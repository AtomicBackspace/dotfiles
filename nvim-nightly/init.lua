vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes:2"
vim.o.wrap = false
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.completeopt = "menu,menuone,noselect" -- setup for autocompletion with omnifunc
vim.o.mouse = ""

-- Navigation
vim.keymap.set("n", "<Tab>", ":bn<CR>")
vim.keymap.set("n", "<S-Tab>", ":bp<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<C-c>', '"+y<CR>')

-- Fix swedish letters
vim.keymap.set('i', ';a', 'ä', { noremap = true })
vim.keymap.set('i', ';w', 'å', { noremap = true })
vim.keymap.set('i', ';o', 'ö', { noremap = true })

vim.keymap.set('i', ';A', 'Ä', { noremap = true })
vim.keymap.set('i', ';W', 'Å', { noremap = true })
vim.keymap.set('i', ';O', 'Ö', { noremap = true })

-- Plugins
vim.pack.add({
  { src = "https://github.com/rose-pine/neovim" },             -- theme
  { src = "https://github.com/echasnovski/mini.pick" },        -- telescope-light
  { src = "https://github.com/stevearc/oil.nvim" },            -- file browser
  { src = "https://github.com/neovim/nvim-lspconfig" },        -- LSP configurations
  { src = "https://github.com/Tadaa/vimade" },                 -- dimming windows
  { src = "https://github.com/iamcco/markdown-preview.nvim" }, -- markdown preview
})

require "mini.pick".setup({
  window = {
    config = function()
      local width = math.floor(vim.o.columns * 0.4)
      return { width = width }
    end,
  }
})
require "oil".setup({ view_options = { show_hidden = true } })
require "vimade".setup({ ncmode = "windows", fadelevel = 0.65 })

vim.keymap.set('n', '<C-f>', ":Pick files<CR>")
vim.keymap.set('n', '<C-g>', ":Pick grep_live<CR>")
vim.keymap.set('n', '<C-e>', ":Oil<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float)
vim.api.nvim_create_user_command("E", function()
  require("oil").open()
end, {})

vim.g.mkdp_preview_options = {
  markdown_it_plugins = {
    "markdown-it-plantuml"
  },
  uml = {
    server = "http://127.0.0.1:8889"
  }
}

-- LSP Features
-- For key bindings, look at `lsp-defaults` in help

local on_attach = function(client, bufnr)
  -- organize imports
  if client.id == "gopls" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        local params = vim.lsp.util.make_range_params(bufnr, vim.lsp._get_offset_encoding())
        params["context"] = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 3000)
        for cid, res in pairs(result or {}) do
          for _, r in pairs(res.result or {}) do
            if r.edit then
              local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
              vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
          end
        end
      end
    })
  end

  -- automatic formatting
  if not client:supports_method('textDocument/willSaveWaitUntil')
      and client:supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
      end,
    })
  end

  -- highlight references
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- document color
  if client:supports_method('textDocument/documentColor') then
    vim.lsp.document_color.enable(true, bufnr)
  end

  -- autocompletions
  if client:supports_method('textDocument/completion') then
    -- Setup autocomplete on every keystroke
    local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
    client.server_capabilities.completionProvider.triggerCharacters = chars

    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = true,
      convert = function(item)
        return { abbr = item.label:gsub('%b()', '') }
      end,
    })
  end

  -- semantic tokens
  if client.server_capabilities.semanticTokensProvider then
    vim.lsp.semantic_tokens.enable(true, { client.id, bufnr })
  end
end

vim.lsp.config("gopls", {
  name = "gopls",
  cmd = { "gopls" },
  on_attach = on_attach,
  root_dir = vim.fs.dirname(vim.fs.find({ "go.mod", ".git" }, { upward = true })[1]),
  settings = {
    gopls = {
      gofumpt = true,
      symbolScope = "workspace",
      semanticTokens = true,
      staticcheck = true,
      vulncheck = "Imports",
      usePlaceholders = true,
      completeUnimported = true,
      diagnosticsDelay = "500ms",
      hoverKind = "FullDocumentation",
      analyses = {
        unusedparams = true,
        shadow = true,
        nilness = true,
        unusedwrite = true,
        useany = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*.go",
  callback = function()
    vim.lsp.start(vim.lsp.configs["gopls"])
  end,
})

vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*.gohtml",
  callback = function()
    vim.lsp.start(vim.lsp.configs["tailwindcss"])
  end,
})

vim.lsp.config("tailwindcss", {
  on_attach = on_attach,
})

vim.lsp.config("denols", {
  on_attach = on_attach,
})

vim.lsp.enable({
  "gopls",
  "lua_ls",
  "pylsp",
  "tailwindcss",
  "denols",
})

-- formatting
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 0
    vim.opt_local.formatoptions = vim.opt_local.formatoptions - { "t", "c", "r", "o" }
    vim.opt_local.colorcolumn = "80"
  end,
})

---- Prettier
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.md", "*.js", "*.yaml", "*.yml" },
  callback = function()
    if vim.fn.executable('prettier') == 1 then
      local filename = vim.fn.expand("%:p")
      vim.fn.jobstart({ "prettier", "-w", filename }, {
        on_exit = function()
          vim.cmd("edit!")
        end,
      })
    end
  end,
})

---- Python
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.py" },
  callback = function()
    if vim.fn.executable('black') == 1 then
      local filename = vim.fn.expand("%:p")
      vim.fn.jobstart({ "black", filename }, {
        on_exit = function()
          vim.cmd("edit!")
        end,
      })
    end
  end,
})

---- Terraform
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    if vim.fn.executable('terraform') == 1 then
      local filename = vim.fn.expand("%:p")
      vim.fn.jobstart({ "terraform", "fmt", filename }, {
        on_exit = function()
          vim.cmd("edit!")
        end,
      })
    end
  end,
})

-- Colorschema
vim.cmd("colorscheme rose-pine-main")
