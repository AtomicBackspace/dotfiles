vim.api.nvim_set_hl(0, "BadWhitespace", { bg = "red" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "markdown", "yaml" },
  callback = function()
    vim.fn.matchadd("BadWhitespace", [[\s\+$]])
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("PreventDuplicateLSP", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local attached = 0
    for _, c in pairs(vim.lsp.get_clients()) do
      if c.name == client.name then
        attached = attached + 1
      end
    end
    if attached > 1 then
      client:stop()
    end
  end,
})

local function organize_imports_and_format()
  local bufnr = vim.api.nvim_get_current_buf()

  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
  for _, res in pairs(results or {}) do
    for _, action in pairs(res.result or {}) do
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
      else
        vim.lsp.buf.execute_command(action.command)
      end
    end
  end
  vim.lsp.buf.format({ bufnr = bufnr, async = false })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = organize_imports_and_format,
})
