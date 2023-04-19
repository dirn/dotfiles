local highlight_colors = {
  "Keyword",
  "Constant",
  "Number",
  "Type",
  "String",
  "Special",
  "Function",
}
local greetings = {
  "Go to bed",
  "Good morning",
  "Good afternoon",
  "Good evening",
  "Good night",
}
local padding = {}
for i = 1, 10, 1 do
  padding[i] = { type = "padding", val = i }
end
local punctuation = { "!!", "!", ".", ".", "." }

local function hello_world(name)
  local hour = os.date("*t").hour
  local index = 5
  if hour < 7 then
    index = 1
  elseif hour < 12 then
    index = 2
  elseif hour < 18 then
    index = 3
  elseif hour < 21 then
    index = 4
  end

  return greetings[index] .. ", " .. name .. punctuation[index]
end

local function highlight_color_of_the_day()
  local day_of_the_week = os.date("*t").wday
  return highlight_colors[day_of_the_week]
end

local function footer()
  local version = vim.version()
  return {
    {
      type = "text",
      val = "Neovim v"
        .. version.major
        .. "."
        .. version.minor
        .. "."
        .. version.patch,
      opts = { position = "center", hl = "Comment" },
    },
  }
end

local function greeting()
  return {
    {
      type = "text",
      val = hello_world("dirn"),
      opts = { position = "center", hl = highlight_color_of_the_day() },
    },
  }
end

local function header()
  return {
    {
      type = "text",
      -- Generated using
      -- https://textkool.com/en/ascii-art-generator?hl=default&vl=default&font=DOS%20Rebel&text=Neovim.
      val = {
        [[                                                                     ]],
        [[  ██████   █████                                ███                  ]],
        [[ ░░██████ ░░███                                ░░░                   ]],
        [[  ░███░███ ░███   ██████   ██████  █████ █████ ████  █████████████   ]],
        [[  ░███░░███░███  ███░░███ ███░░███░░███ ░░███ ░░███ ░░███░░███░░███  ]],
        [[  ░███ ░░██████ ░███████ ░███ ░███ ░███  ░███  ░███  ░███ ░███ ░███  ]],
        [[  ░███  ░░█████ ░███░░░  ░███ ░███ ░░███ ███   ░███  ░███ ░███ ░███  ]],
        [[  █████  ░░█████░░██████ ░░██████   ░░█████    █████ █████░███ █████ ]],
        [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
      },
      opts = {
        position = "center",
        hl = highlight_color_of_the_day(),
      },
    },
  }
end

local function plugins()
  local opts = {
    type = "text",
    val = "You don't appear to be using any plugins.",
    opts = { position = "center", hl = "Comment" },
  }

  local ok, lazy = pcall(require, "lazy")
  if not ok then
    return { opts }
  end

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
      vim.keymap.set("n", "L", function()
        vim.cmd.Lazy()
      end, { silent = true, noremap = true, buffer = true })
    end,
  })

  local stats = lazy.stats()
  local loaded = tostring(stats.loaded)
  if stats.loaded == stats.count then
    loaded = "All"
  end

  opts.val = "You are using "
    .. stats.count
    .. " plugins, "
    .. loaded
    .. " of them are loaded. Open [L]azy to see more."

  return { opts }
end

local function recents()
  function recent(filename, label, shortcut)
    local action = "<cmd>e " .. filename .. "<cr>"
    local opts = {
      keymap = {
        "n",
        shortcut,
        action,
        { silent = true, noremap = true },
      },
      position = "center",
      shortcut = "[" .. shortcut .. "] ",
      cursor = 1,
      align_shortcut = "left",
      hl_shortcut = {
        { "Operator", 0, 1 },
        { "Number", 1, #shortcut + 1 },
        { "Operator", #shortcut + 1, #shortcut + 2 },
      },
      shrink_margin = false,
    }

    local function on_press()
      local key =
        vim.api.nvim_replace_termcodes(action .. "<ignore>", true, false, true)
      vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
      type = "button",
      val = label,
      on_press = on_press,
      opts = opts,
    }
  end

  local cwd = vim.fn.getcwd()
  local is_home = vim.fn.fnamemodify(cwd, ":~") == "~"

  local function include_recent(recent)
    if not vim.startswith(recent, cwd) then
      return false
    end
    if string.find(recent, "COMMIT_EDITMSG") then
      return false
    end
    -- My code lives inside src. If my current working directory is ~, I don't
    -- want things in src to take up the whole recents less.
    if
      is_home and vim.startswith(vim.fn.fnamemodify(recent, ":~"), "~/src")
    then
      return false
    end
    if vim.fn.filereadable(recent) ~= 1 then
      return false
    end

    return true
  end

  local oldfiles = {}
  local recents_limit = 10
  for _, v in pairs(vim.v.oldfiles) do
    if include_recent(v) then
      table.insert(oldfiles, v)
      if #oldfiles == recents_limit then
        break
      end
    end
  end

  local recents = {}
  for i, filename in ipairs(oldfiles) do
    -- 2 characters are needed to account for 1-indexing and the / separating
    -- the current working directory and the rest of the path.
    local short_filename = string.sub(filename, #cwd + 2, -1)
    table.insert(recents, recent(filename, short_filename, tostring(i - 1)))
  end

  if #recents == 0 then
    return {
      {
        type = "text",
        val = "You haven't opened any files in this directory.",
        opts = {
          position = "center",
          hl = "Constant",
        },
      },
      padding[1],
      padding[10],
    }
  else
    -- Figure out the width needed to fit all of the recents and use that for all
    -- of them so that they properly align without being too far left.
    local max_width = 0
    for _, recent in ipairs(recents) do
      max_width = math.max(max_width, #recent.val + #recent.opts.shortcut)
    end
    for _, recent in ipairs(recents) do
      recent.opts.width = max_width
    end
  end

  return {
    {
      type = "text",
      val = "Recently Viewed Files",
      opts = {
        position = "center",
        hl = "Constant",
      },
    },
    padding[1],
    { type = "group", val = recents, opts = { position = "center" } },
  }
end

local function shortcuts()
  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
      vim.keymap.set("n", "B", function()
        require("telescope.builtin").current_buffer_fuzzy_find()
      end, { silent = true, noremap = true, buffer = true })
      vim.keymap.set("n", "F", function()
        vim.cmd.GitFiles()
      end, { silent = true, noremap = true, buffer = true })
      vim.keymap.set("n", "S", function()
        vim.cmd.Rg()
      end, { silent = true, noremap = true, buffer = true })
      vim.keymap.set("n", "R", function()
        require("persistence").load()
      end, { silent = true, noremap = true, buffer = true })
      vim.keymap.set(
        "n",
        "Q",
        "<cmd>qa<cr>",
        { silent = true, noremap = true, buffer = true }
      )
    end,
  })
  return {
    {
      type = "text",
      val = "[B]uffers     [F]iles     [S]earch     [R]estore     [Q]uit",
      opts = {
        position = "center",
        hl = {
          { "Number", 0, 11 },
          { "Operator", 14, 21 },
          { "Special", 26, 34 },
          { "Keyword", 39, 48 },
          { "Error", 53, 59 },
        },
      },
    },
  }
end

local sections = {
  footer = { type = "group", val = footer },
  greeting = { type = "group", val = greeting },
  header = { type = "group", val = header },
  plugins = { type = "group", val = plugins },
  recents = { type = "group", val = recents },
  shortcuts = { type = "group", val = shortcuts },
}

local config = {
  layout = {
    padding[3],
    sections.header,
    padding[1],
    sections.greeting,
    padding[1],
    sections.shortcuts,
    padding[1],
    sections.recents,
    padding[4],
    sections.plugins,
    padding[1],
    sections.footer,
  },
  opts = { margin = 3, redraw_on_resize = false },
}

return {
  section = sections,
  config = config,
}
