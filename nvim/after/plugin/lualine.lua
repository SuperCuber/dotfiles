vim.opt.showmode = false

local mode_map = {
  ["NORMAL"  ]  = "N",
  ["INSERT"  ]  = "I",
  ["TERMINAL"]  = "T",
  ["REPLACE" ]  = "R",
  ["VISUAL"  ]  = "V",
  ["V-LINE"  ]  = "VL",
  ["V-BLOCK" ]  = "VB",
}

local function modified()
  if vim.bo.modified then
    return '+'
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return '-'
  else
    return ''
  end
end

local pretty_filename = require('lualine.component'):extend()
local utils = require("lualine_require").require("lualine.utils.utils")
local highlight = require("lualine_require").require("lualine.highlight")

function pretty_filename:init(options)
  pretty_filename.super.init(self, options)
  local stem = utils.extract_color_from_hllist(
    'fg',
    { 'Bold' },
    '#ffffff'
  )
  local rest = utils.extract_color_from_hllist(
    'fg',
    { 'Comment' },
    '#273faf'
  )

  self.highlight_groups = {
    stem = highlight.create_component_highlight_group(
      { fg = stem },
      'pretty_filename_stem',
      self.options
    ),
    rest = highlight.create_component_highlight_group(
      { fg = rest },
      'pretty_filename_rest',
      self.options
    ),
  }
end

function pretty_filename:draw(_)
  local bold = highlight.component_format_highlight(self.highlight_groups.stem)
  local normal = highlight.component_format_highlight(self.highlight_groups.rest)

  local dir = vim.fn.expand("%:p:~:.:h")
  local stem = vim.fn.expand("%:t:r")
  local extension = vim.fn.expand("%:e")
  local path_separator = package.config:sub(1,1)

  local filename
  if extension == "" then
    filename = bold .. stem
  else
    filename = bold .. stem .. normal .. "." .. extension
  end

  if dir == "" then
    self.status = bold .. "[No Name]"
  elseif dir == "." then
    self.status = filename
  elseif string.sub(dir, 1, 7) == "term://" then
      local path = string.sub(vim.fn.expand("%:p:~:."), 8)
      local separator_idx = string.find(path, ':')
      local part1 = string.sub(path, 1, separator_idx - 1)
      local part2 = string.sub(path, separator_idx + 1)
      self.status = bold .. "term" .. normal .. "://" .. part1 .. ":" .. bold .. part2
  else
    self.status = normal .. dir .. path_separator .. filename
  end

  self.status = " " .. self.status .. " "

  return self.status
end


require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      { 'mode', fmt = function(str) return mode_map[str] end },
    },
    lualine_b = {},
    lualine_c = {
      { pretty_filename },
      { modified,
        padding = { left = 0, right = 1 },
      },
    },
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {'filename', path = 1}
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {},
}
