-- Bootstrap Lazy.nvim ---------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins --------------------------------------------------------------------
require("lazy").setup({
  -- Theme
  require("plug_config.theme"),

  -- Icons
  require("plug_config.devicons"),

  -- Completion
  require("plug_config.blink"),

  -- Mason + LSP (modern API)
  require("plug_config.mason"),

  -- Telescope
  require("plug_config.telescope"),

  -- Treesitter
  require("plug_config.treesitter"),

  -- Lualine
  require("plug_config.lualine"),

  -- Dashboard
  require("plug_config.alpha"),
})

