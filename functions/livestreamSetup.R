### note that this function won't work in an untitled R script ### livecode throws an error in this case

livestreamSetup = function(password = 'vulcans',user = 'rdavis',port = 4040){
  packs = c('rstudioapi','remotes')
  for(i in packs){if(!require(i,character.only = T)){install.packages(i);require(i,character.only = T)}}
  if(!require('livecode')){remotes::install_github('rundel/livecode');require(livecode)}
  
  #https://bitsandbricks.github.io/post/code-live-from-rstudio-and-share-it-with-the-world-in-real-time/
  #troubleshooting install: https://stackoverflow.com/questions/65251887/clang-7-error-linker-command-failed-with-exit-code-1-for-macos-big-sur/65334247#65334247
  #start livecode local server (available only on LAN)
  s <- livecode::serve_file(port = port,open_browser = F)
  url = s$url
  #adding -bind-tls=true makes https, but for some reason people just then get a blank white screen
  command = paste0("ngrok http -hostname=www.rdaviscode.com -auth='",user,"':'",password,"' ",url)
  terminal_id = rstudioapi::terminalExecute(command)
  id = rstudioapi::terminalExecute('R --version',show = F)
  return(id)
}

livestreamStop = function(id = NULL){
  terminalKill(id = id)
  livecode::stop_all()
}


