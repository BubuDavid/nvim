return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              diagnosticMode = "workspace",
            },
          },
        },
        handlers = {
          ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
            local filtered_diagnostics = {}

            for _, diagnostic in ipairs(result.diagnostics) do
              local keep = true

              if diagnostic.tags and diagnostic.tags[1] == 1 and diagnostic.message:match("is not accessed") then
                local var_name = diagnostic.message:match('"([^"]+)" is not accessed')

                if var_name and var_name:match("^_") then
                  keep = false
                end
              end

              if keep then
                table.insert(filtered_diagnostics, diagnostic)
              end
            end

            result.diagnostics = filtered_diagnostics
            vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
          end,
          ["$/progress"] = function() end,
        },
      },
    },
  },
}
