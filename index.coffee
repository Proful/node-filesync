fs = require('fs')
walk = require('./walk').walk
path = require('path')
util = require('util')
exec = require('child_process').exec

# constant initialization
target = {}
targetDir = './test/target'
sourceDir = './test/source'


# check directory present or not
# if directory not created create it.
createDirTree = (fileName) ->
  fsplit = fileName.split '/'

  prevF = ''
  i = 0
  while i < fsplit.length - 1
    prevF = prevF + "/" + fsplit[i++]  # i should be incremented here..
    if path.existsSync targetDir + "/" + prevF
      console.log "Dir #{prevF} exist"
    else
      fs.mkdirSync "#{targetDir}#{prevF}",0777
      console.log "Directory #{targetDir}#{prevF} created successfully."

walk targetDir, (results)->
  for r in results
    r = r.substr(targetDir.length + 1)
    target[r] = true
  console.log target
  walk sourceDir, (srcResults) ->
    for s in srcResults
      s = s.substr(targetDir.length + 1)
      console.log s
      if target[s] == true
        console.log "file exist"
      else
        createDirTree s
        console.log "file does not exist"
        child = exec "cp #{sourceDir}/#{s} #{targetDir}/#{s}",(error,stdout,stderr) ->
          console.log error if error is not null
          console.log "Copy successful."
