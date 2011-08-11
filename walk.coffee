fs = require 'fs'
path = require 'path'

# return the list of files inside the folder
# done is the callback method as it seems
walk = (dir, done) ->
  results = []
  i = 0

  # return the file name is not directory
  ###
  unless fs.statSync(dir).isDirectory()
    console.log "------> 4. done.."
    done(results)
  ###
  # Returns array of file name excluding . and ..
  list = fs.readdirSync dir

  # if not list means directory is empty
  # Important... if you pass a empty folder here.. 
  # it should return there itself
  if list.length == 0
    done(results)

  # console.log "list length: " + list.length
  list.forEach (f) ->
    # verifying each file whether directory or not
    if fs.statSync("#{dir}/#{f}").isDirectory()
      # console.log "dir:" + f

      # if the file is directory then agan recurssively call the walk
      walk "#{dir}/#{f}", (r) ->
        # concat the result of walk into the results variable
        results = results.concat(r)

        # console.log "2. #{i} ==> #{list.length}"

        # Confuse...
        if ++i is list.length
          # console.log "------> 2. done.."
          done results
    else
      # console.log "file:" + f

      # if file then push into results
      results.push "#{dir}/#{f}"

      # console.log "1. #{i} ==> #{list.length}"
      # if all file iteration complete return the result
      if ++i is list.length
        # console.log "------> 1. done.."
        done results

exports.walk = walk
