vim.api.nvim_create_user_command("Test", function(opts)
  if opts.fargs[1] == "python" or opts.fargs[1] == "py" then
    local file = io.open("~/tests/test.py", "w")
    vim.cmd("e " .. "~/tests/test.py")
    if file then
      print "Python file created"
      file:close()
    else
      print "A problem with Python file"
    end
    file = nil
  else
    print("Type file not supported: ", opts.fargs[1])
  end
end, { nargs = 1 })
