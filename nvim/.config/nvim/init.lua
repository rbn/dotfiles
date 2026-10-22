vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.test_from_init = "loaded"

-- =========================================================
-- Shared configuration
-- Used by both native Neovim and VS Code Neovim
-- =========================================================

local function project_root()
  local path = vim.api.nvim_buf_get_name(0)

  if vim.bo.buftype ~= "" or path == "" then
    path = vim.fn.getcwd()
  end

  return vim.fs.root(path, { ".git", "package.json", "tsconfig.json" })
    or vim.fn.getcwd()
end

-- -------------------------
-- Basic editing settings
-- -------------------------

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.ignorecase = true
vim.opt.smartcase = false

-- Two-space indentation for TypeScript/React and web development.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Preserve and infer indentation as new lines are created.
vim.opt.autoindent = true
vim.opt.smartindent = true

-- vim.opt.guicursor =
--   "n-v-c-i-ci-ve-r-cr:ver25-blinkwait300-blinkon500-blinkoff500"
vim.opt.guicursor = {
    "n-v-c:block",
    "i-ci:ver25-blinkwait050-blinkon050-blinkoff050",
    "r-cr:hor20-blinkwait050-blinkon050-blinkoff050",
}
-- -------------------------
-- Shared key mappings
-- -------------------------

-- Keep cursor centered while scrolling half-pages.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Quickly add a blank line above without staying in Insert mode.
vim.keymap.set("n", "<leader>o", "O<Esc>", {
  desc = "Insert blank line above",
})

-- Clear search highlighting.
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>")

-- Paste from system clipboard.
vim.keymap.set("n", "<C-q>", '"+p', {
  desc = "Paste from system clipboard",
})

-- Yank to system clipboard while preserving normal Vim register behavior.
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', {
  desc = "Yank to system clipboard",
})

-- Edit Neovim config.
vim.keymap.set("n", "<leader>ev", ":e $MYVIMRC<CR>", {
  desc = "Edit Neovim config",
})

vim.keymap.set("n", "<leader>sc", "<cmd>source ~/.config/nvim/init.lua<CR>", {
  desc = "Source Neovim config",
})

-- Dev helper: resize after running scripts/start-dev.sh.
vim.keymap.set("n", "<leader>r", function()
  vim.fn.system(vim.fn.expand("~/scripts/resize-dev.sh"))
end, {
  desc = "Resize dev workspace",
})

-- =========================================================
-- VS Code Neovim
-- =========================================================

if vim.g.vscode then
  -- VS Code supplies:
  -- file explorer
  -- IntelliSense / LSP
  -- debugging
  -- tabs
  -- terminal
  -- search UI
  --
  -- Native Neovim UI plugins are intentionally not loaded here.

  return
end

-- =========================================================
-- Native Neovim only
-- =========================================================

-- -------------------------
-- Native UI settings
-- -------------------------

vim.opt.mouse = "a"
vim.opt.splitright = true
vim.opt.splitbelow = true

-- -------------------------
-- Plugins
-- -------------------------

vim.pack.add({
  "https://github.com/folke/which-key.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/tpope/vim-commentary",

  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },

  "https://github.com/neovim/nvim-lspconfig",

  {
    src = "https://github.com/saghen/blink.cmp",
    version = "v1.10.2",
  },

  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/navarasu/onedark.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-tree/nvim-web-devicons",

  -- Telescope
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",

  -- Harpoon 2
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "harpoon2",
  },

  -- GitHub Copilot
  "https://github.com/github/copilot.vim",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/lukas-reineke/virt-column.nvim",
  "https://github.com/tpope/vim-sensible",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  -- maarkdown editor
  "https://github.com/iamcco/markdown-preview.nvim",
  "https://github.com/HakonHarnes/img-clip.nvim",
})

-- -------------------------
-- Completion / TypeScript
-- -------------------------

require("nvim-surround").setup();

require("virt-column").setup({
  char = "│",
  virtcolumn = "101",
})

-- Super Tab gives Tab IDE-style completion behavior.
require("blink.cmp").setup({
  keymap = {
    preset = "super-tab",
  },

  completion = {
    documentation = {
      auto_show = true,
    },
  },

  signature = {
    enabled = true,
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  fuzzy = {
    implementation = "lua",
  },
})

vim.lsp.config("ts_ls", {
  cmd = {
    vim.fn.expand(
      "~/.local/share/nvim/typescript-tools/node_modules/.bin/typescript-language-server"
    ),
    "--stdio",
  },

  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.enable("ts_ls")

-- -------------------------
-- Tool paths
-- -------------------------

-- Include user-installed tools such as ripgrep for Telescope.
vim.env.PATH = vim.fn.expand("~/.local/bin") .. ":" .. vim.env.PATH

-- Parser build tools are local to Neovim.
local parser_tools = vim.fn.stdpath("data") .. "/parser-tools"

vim.env.PATH = parser_tools .. ":" .. vim.env.PATH
vim.env.CC = parser_tools .. "/cc"

-- -------------------------
-- Which-key
-- -------------------------

require("which-key").setup({
  delay = 300,
})

require("which-key").add({
  { "<leader>f", group = "Find" },
  { "<leader>c", group = "Code" },
  { "<leader>g", group = "Git" },
  { "<leader>x", group = "Diagnostics" },

  { "<leader>o", desc = "Insert blank line above" },
  { "<leader>y", desc = "Yank to system clipboard" },
  { "<leader>ev", desc = "Edit Neovim config" },
  { "<leader>r", desc = "Resize dev workspace" },
  { "<leader>b", desc = "Edit Bash config" },
  { "<leader>e", desc = "Toggle project file tree" },

  { "<leader>ff", desc = "Find project files" },
  { "<leader>fg", desc = "Search project text" },

  { "<leader>a", desc = "Bookmark current file" },
  { "<leader>h", desc = "Show Harpoon bookmarks" },
  { "<leader>1", desc = "Harpoon file 1" },
  { "<leader>2", desc = "Harpoon file 2" },
  { "<leader>3", desc = "Harpoon file 3" },
  { "<leader>4", desc = "Harpoon file 4" },
})

-- -------------------------
-- Formatting / Prettier
-- -------------------------

require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
  },

  formatters = {
    prettier = {
      -- Prefer the project's node_modules/.bin/prettier.
      command = require("conform.util").from_node_modules("prettier"),
    },
  },

  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    return {
      timeout_ms = 3000,
      lsp_format = "never",
    }
  end,
})

-- Fallback tool installation when a project does not provide Prettier.
vim.env.PATH =
  vim.fn.stdpath("data")
  .. "/typescript-tools/node_modules/.bin:"
  .. vim.env.PATH

-- Manually format the current buffer/selection.
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({
    async = true,
    lsp_format = "never",
  })
end, {
  desc = "Format code",
})

-- Toggle automatic formatting on save.
vim.keymap.set("n", "<leader>ct", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat

  vim.notify(
    "Format on save: "
      .. (vim.g.disable_autoformat and "off" or "on")
  )
end, {
  desc = "Toggle format on save",
})

-- -------------------------
-- ESLint / LSP
-- -------------------------

vim.lsp.config("eslint", {
  cmd = {
    vim.fn.stdpath("data")
      .. "/typescript-tools/node_modules/.bin/vscode-eslint-language-server",
    "--stdio",
  },

  settings = {
    format = false,
  },
})

vim.lsp.enable("eslint")

vim.diagnostic.config({
  severity_sort = true,

  virtual_text = {
    spacing = 2,
  },

  float = {
    border = "rounded",
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("IdeLspKeys", {
    clear = true,
  }),

  callback = function(event)
    local function map(key, action, description)
      vim.keymap.set("n", key, action, {
        buffer = event.buf,
        desc = description,
      })
    end

    map("gd", vim.lsp.buf.definition, "Go to definition")

    map(
      "gr",
      require("telescope.builtin").lsp_references,
      "Find references"
    )

    map("K", vim.lsp.buf.hover, "Show documentation")

    map(
      "<leader>cr",
      vim.lsp.buf.rename,
      "Rename symbol"
    )

    map(
      "<leader>ca",
      vim.lsp.buf.code_action,
      "Code actions / quick fixes"
    )

    map(
      "<leader>cs",
      require("telescope.builtin").lsp_document_symbols,
      "Find symbols in file"
    )
  end,
})

vim.keymap.set(
  "n",
  "<leader>ce",
  "<cmd>LspEslintFixAll<CR>",
  {
    desc = "Apply ESLint fixes",
  }
)

vim.keymap.set(
  "n",
  "<leader>xd",
  vim.diagnostic.open_float,
  {
    desc = "Explain diagnostic",
  }
)

-- -------------------------
-- Git
-- -------------------------

require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")

    local function map(key, action, desc)
      vim.keymap.set("n", key, action, {
        buffer = bufnr,
        desc = desc,
      })
    end

    map(
      "<leader>gp",
      gs.preview_hunk,
      "Preview Git change"
    )

    map(
      "<leader>gs",
      gs.stage_hunk,
      "Stage Git change"
    )

    map(
      "<leader>gb",
      gs.blame_line,
      "Show line author"
    )

    map("]h", function()
      gs.nav_hunk("next")
    end, "Next Git change")

    map("[h", function()
      gs.nav_hunk("prev")
    end, "Previous Git change")
  end,
})

-- -------------------------
-- Diagnostics / Trouble
-- -------------------------

vim.opt.signcolumn = "yes"

require("trouble").setup({})

vim.keymap.set(
  "n",
  "<leader>xx",
  "<cmd>Trouble diagnostics toggle<CR>",
  {
    desc = "Toggle Problems panel",
  }
)

-- -------------------------
-- Tree-sitter / TSX
-- -------------------------

require("nvim-treesitter").setup({})

vim.treesitter.language.register("json", "jsonc")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("IdeTreesitter", {
    clear = true,
  }),

  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "css",
    "html",
    "json",
    "jsonc",
    "lua",
    "markdown",
  },

  callback = function(event)
    pcall(vim.treesitter.start, event.buf)
  end,
})

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
  },
})

-- Automatically close matching HTML/JSX/TSX tags.
require("nvim-ts-autotag").setup({})

-- Automatically close brackets, parentheses, and quotes.
require("nvim-autopairs").setup({})

-- -------------------------
-- Theme
-- -------------------------

-- vim.cmd.colorscheme("tokyonight-night")
require("kanagawa").setup({
  transparent = true,
})
vim.cmd.colorscheme("kanagawa")

-- -------------------------
-- Telescope
-- -------------------------

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-b>"] = actions.preview_scrolling_up,
      },
    },
  },
})

-- Wrap long lines in Telescope preview windows.
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",

  callback = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
  end,
})

-- -------------------------
-- Nvim Tree
-- -------------------------

require("nvim-tree").setup({
  view = {
    side = "right",
    width = 35,
  },

  update_focused_file = {
    enable = true,
    update_root = false,
  },

  sync_root_with_cwd = false,
  respect_buf_cwd = false,
})

-- -------------------------
-- Bufferline
-- -------------------------

require("bufferline").setup()

-- -------------------------
-- Lualine
-- -------------------------

require("lualine").setup({
  sections = {
    lualine_c = {
      {
        "filename",
        path = 1,
      },
    },

    lualine_x = {
      function()
        return os.date("%I:%M %p")
      end,

      "encoding",
      "fileformat",
      "filetype",
    },
  },
})

-- -------------------------
-- Harpoon
-- -------------------------

local harpoon = require("harpoon")

harpoon:setup({
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
  },
})

-- -------------------------
-- Native Neovim mappings
-- -------------------------

-- Esc leaves terminal mode.
vim.keymap.set(
  "t",
  "<Esc>",
  [[<C-\><C-n>]]
)

-- Edit Bash config.
vim.keymap.set(
  "n",
  "<leader>b",
  ":e ~/.bashrc<CR>",
  {
    desc = "Edit Bash config",
  }
)

-- Ctrl-V is occupied in your workflow, so provide an explicit
-- Visual Block mapping.
vim.keymap.set(
  "n",
  "<leader>v",
  "<C-v>",
  {
    desc = "Visual block mode",
  }
)

-- Nvim Tree in the current project.
vim.keymap.set("n", "<leader>e", function()
  local api = require("nvim-tree.api")

  if api.tree.is_visible() then
    api.tree.close()
    return
  end

  api.tree.open({
    path = project_root(),
  })
end, {
  desc = "Toggle project file tree",
})

-- Telescope file search in the current project.
vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({
    cwd = project_root(),
  })
end, {
  desc = "Find project files",
})

-- Telescope text search in the current project.
vim.keymap.set("n", "<leader>fg", function()
  builtin.live_grep({
    cwd = project_root(),
  })
end, {
  desc = "Search project text",
})

-- Harpoon: add current file.
vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end, {
  desc = "Bookmark current file",
})

-- Harpoon: menu.
vim.keymap.set("n", "<leader>h", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, {
  desc = "Show Harpoon bookmarks",
})

-- Harpoon: jump to slots 1-4.
vim.keymap.set("n", "<leader>1", function()
  harpoon:list():select(1)
end, {
  desc = "Harpoon file 1",
})

vim.keymap.set("n", "<leader>2", function()
  harpoon:list():select(2)
end, {
  desc = "Harpoon file 2",
})

vim.keymap.set("n", "<leader>3", function()
  harpoon:list():select(3)
end, {
  desc = "Harpoon file 3",
})

vim.keymap.set("n", "<leader>4", function()
  harpoon:list():select(4)
end, {
  desc = "Harpoon file 4",
})

-- colorscheme for virtcolumn

vim.api.nvim_set_hl(0, "VirtColumn", {
  fg = "#5fd7d7",
})


-- format text files for readability
vim.api.nvim_create_autocmd("FileType", {
  pattern = "text",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append("t")

    vim.keymap.set("n", "<leader>tf", "gggqG", {
      buffer = true,
      desc = "Format entire text file",
    })
  end,
})

-- show linting errors better
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)


-- yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300, visual = true })
  end,
})

-- cursor line


-- Disable automatic comment continuation on new lines
vim.api.nvim_create_autocmd("FileType", {
  desc = "Disable auto-commenting on new lines",
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

------ -- show cursorline only in active window enable
------ vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
------ 	group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
------ 	callback = function()
------ 		vim.opt_local.cursorline = true
------ 	end,
------ })


-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
	desc = "Highlight references under cursor",
	callback = function()
		-- Only run if the cursor is not in insert mode
		if vim.fn.mode() ~= "i" then
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local supports_highlight = false
			for _, client in ipairs(clients) do
				if client.server_capabilities.documentHighlightProvider then
					supports_highlight = true
					break -- Found a supporting client, no need to check others
				end
			end

			-- 3. Proceed only if an LSP is active AND supports the feature
			if supports_highlight then
				vim.lsp.buf.clear_references()
				vim.lsp.buf.document_highlight()
			end
		end
	end,
})

-- go to insert mode in terminal right away
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
    pattern = "*",
    callback = function()
        if vim.opt.buftype:get() == "terminal" then
            vim.cmd("startinsert")
        end
    end
})

-- toggle vim background (-> to hide win term bg img)
local opaque = false

vim.keymap.set("n", "<leader>bg", function()
  opaque = not opaque

  if opaque then
    vim.cmd("highlight Normal guibg=#111111")
  else
    vim.cmd("highlight Normal guibg=NONE")
  end
end, { desc = "Toggle Neovim background opacity" })


-- C development - compile/debug
local function compile_c(flags)
    local file = vim.fn.expand("%:p")
    local name = vim.fn.expand("%:t:r")
    flags = flags or {}

    if file == "" then
        vim.notify("Save the file first", vim.log.levels.ERROR)
        return nil
    end

    vim.cmd("write")

    local build_dir = vim.fn.getcwd() .. "/" --/build"
    vim.fn.mkdir(build_dir, "p")

    local output = build_dir .. "/" .. name
    local cmd = {
        "gcc", "-g", "-O0", "-Wall", "-Wextra",
        file, "-o", output
    }

    vim.list_extend(cmd, flags)
    vim.fn.system(cmd)
    if vim.v.shell_error == 0 then
        return output
    end

    vim.notify("Compilation failed", vim.log.levels.ERROR)
    return nil
end
vim.keymap.set("n", "<leader>r", function()
    local flags = {}

    if vim.v.count == 1 then
        flags = { "-lm" }
    end

    local output = compile_c(flags)
    if output then
        vim.cmd("!" .. vim.fn.shellescape(output))
    end
end, { desc = "Compile and run C" })

vim.keymap.set("n", "<leader>d", function()
    local output = compile_c()
    if output then
        vim.cmd("terminal gdb " .. vim.fn.shellescape(output))
    end
end, { desc = "Compile and debug C" })

vim.lsp.enable("clangd")

-- markdown editor
vim.fn["mkdp#util#install"]()

-- Image pasting for Markdown
require("img-clip").setup({
    default = {
        dir_path = "images",
        relative_to_current_file = true,
        file_name="%Y-%m-%d-%H-%M-%S",
        prompt_for_file_name = false,
    },
    filetypes = {
        markdown = {
            template = "![$FILE_NAME]($FILE_PATH)",
        },
    },
})

vim.keymap.set("n", "<leader>pi", "<cmd>PasteImage<CR>",
    { desc = "Paste clipboard image" })

vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>",
    { desc = "Toggle Markdown Preview" })
vim.g.mkdp_auto_close = 0

-- Terminal colors for GDB
vim.g.terminal_color_2 = "#98c379"   -- Green
vim.g.terminal_color_10 = "#39FF14"  -- Bright green
vim.g.terminal_color_6 = "#56b6c2"   -- Cyan
vim.g.terminal_color_14 = "#56b6c2"  -- Bright cyan

-- Buffervim.keymap.set("n", "<PageUp>", "<cmd>BufferLineCyclePrev<CR>")
-- cycle buffers
-- vim.keymap.set("n", "<leader>[", "<cmd>bprevious<CR>")
-- vim.keymap.set("n", "<leader>]", "<cmd>bnext<CR>")
vim.keymap.set("n", "<PageDown>", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<PageUp>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-PageDown>", "<cmd>BufferLineMovePrev<CR>")
vim.keymap.set("n", "<S-PageUp>", "<cmd>BufferLineMoveNext<CR>")


-- close buffer
vim.keymap.set("n", "<leader>z", "<cmd>bd<CR>", {
    desc = "Close current buffer"
})

-- clang formatter
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.c", "*.h" },
    callback = function(args)
        local file = vim.api.nvim_buf_get_name(args.buf)
        local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
        local input = table.concat(lines, "\n") .. "\n"

        local result = vim.fn.system(
            { "clang-format", "--assume-filename=" .. file },
            input
        )

        if vim.v.shell_error ~= 0 then
            vim.notify("clang-format failed: " .. result, vim.log.levels.ERROR)
            return
        end

        local formatted = vim.split(result:gsub("\n$", ""), "\n")
        vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, formatted)
    end,
})

-- visual select color
vim.api.nvim_set_hl(0, "Visual", {
    bg = "#00E1F0",
    fg = "#ffffff",
})
