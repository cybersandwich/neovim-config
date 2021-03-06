local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.pyright.setup{
    capabilities = capabilities,
    on_attach = function() 
    vim.keymap.set("n","K", vim.lsp.buf.hover,{buffer=0})
    vim.keymap.set("n","gd", vim.lsp.buf.definition,{buffer=0})
    vim.keymap.set("n","gt", vim.lsp.buf.type_definition,{buffer=0})
    vim.keymap.set("n"," dj", vim.diagnostic.goto_next,{buffer=0})
 --   vim.keymap.set("n","1", "<cmd>Telescope diagnostics<cr>",{buffer=0})
  --  vim.keymap.set("n","ca", vim.lsp.buf.code_actions,{buffer=0})
    end,
}

vim.opt.completeopt={"menu","menuone","noselect"}
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
         require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

