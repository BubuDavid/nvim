vim.api.nvim_create_user_command("Test", function(opts)
  if opts.fargs[1] == "python" or opts.fargs[1] == "py" then
    vim.cmd "!source ~/tests/venv/bin/activate"
    vim.cmd("e " .. "~/tests/test.py")
  else
    print("Type file not supported: ", opts.fargs[1])
  end
end, { nargs = 1 })

vim.api.nvim_create_user_command("Python", function()
  local file_name = vim.api.nvim_buf_get_name(0)
  vim.cmd("!source ~/tests/venv/bin/activate && python3 " .. file_name)
end, {})
