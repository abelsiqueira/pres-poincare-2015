using Winston

function createplotfile(p, file)
  savefig(p, file, "width", 640, "height", 480)
  run(`mogrify -fuzz 10% -transparent white $file`)
end
