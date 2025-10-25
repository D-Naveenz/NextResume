-- NextResume Lua implementation of TokenGrid
local modulename = "Next TokenGrid"

-- TokenGrid class definition
local TokenGrid = {}
TokenGrid.__index = TokenGrid

-- Constructor for TokenGrid instances
function TokenGrid:new(hideFieldNames, withhyper)
  local instance = {
    fieldDefinitions = {},
    fields = {},
    hideFieldNames = hideFieldNames or false,
    hyperlinkEnabled = withhyper or false
  }
  setmetatable(instance, TokenGrid)
  return instance
end

-- Private function to get LaTeX formatted string for a field
local function get_latex_field_string(self, field_name, text, hyperlink)
  -- Get symbol once and cache it
  local symbol = self:get_symbol(field_name)
  if not symbol or symbol == "" then
    return "" -- Early return if symbol not found
  end

  -- Build symbol/field name part
  local symbol_part
  if self.hideFieldNames then
    symbol_part = string.format(
      "{\\BeginAccSupp{method=escape,ActualText={%s:}}\\normalfont %s\\EndAccSupp{}}",
      field_name, symbol
    )
  else
    symbol_part = string.format(
      "{\\normalfont %s\\hspace{0.3em}%s:}",
      symbol, field_name
    )
  end

  -- Build text part with optional hyperlink
  local text_part
  if hyperlink and hyperlink ~= "" then
    if self.hyperlinkEnabled then
      text_part = string.format([[\href{%s}{\detokenize{%s}}]], hyperlink, text)
    else
      texio.write_nl("Warning: Hyperlinks disabled but hyperlink provided. Use [withhyper] option.")
      text_part = string.format([[\detokenize{%s}]], text)
    end
  else
    text_part = string.format([[\detokenize{%s}]], text)
  end

  -- Combine all parts efficiently
  return string.format(
    [[\begin{tblr}{stretch = 0, colspec = {Q[h,l]l}, colsep=0.4em} %s & %s \end{tblr}]],
    symbol_part, text_part
  )
end

-- Method to get the symbol by field name
function TokenGrid:get_symbol(field_name)
  local def = self.fieldDefinitions[field_name]
  if def and def.symbol then
    return def.symbol
  else
    texio.write_nl("NextResume Error: Unknown symbol '" .. field_name .. "'")
    return ""
  end
end

-- Method to create new info field with different modes
function TokenGrid:create_info_field(field_name, symbol, mode, hyperlink_prefix)
  -- Register the field definition
  self.fieldDefinitions[field_name] = {
    symbol = symbol,
    mode = mode,
    hyperlinkPrefix = hyperlink_prefix or ""
  }

  -- Create the LaTeX command
  local lua_func_name = field_name .. "_handler"

  -- Store the function in the global namespace
  _G[lua_func_name] = function()
    local text = token.scan_string()

    -- Determine hyperlink based on mode
    local hyperlink = ""
    if mode == "prefix" then
      -- Prefix mode: hyperlink_prefix + text
      local prefix = self.fieldDefinitions[field_name].hyperlinkPrefix
      if prefix and prefix ~= "" then
        hyperlink = prefix .. text
      end
    elseif mode == "fullurl" then
      -- Full URL mode: text is the complete URL
      hyperlink = text
    end
    -- For "noprefix" mode, hyperlink remains empty

    -- Add the formatted field to our collection
    table.insert(self.fields, get_latex_field_string(self, field_name, text, hyperlink))
  end

  -- Define the LaTeX command that calls our Lua function
  tex.sprint("\\newcommand{\\" .. field_name .. "}{\\directlua{" .. lua_func_name .. "()}}")
end

-- Method to create a table from fields
function TokenGrid:build_grid(num_columns)
  num_columns = num_columns or 3
  if #self.fields == 0 then
    tex.sprint("") -- Return empty string if no fields
    return
  end

  local result = {}
-- \noindent: Prevents indentation at the start of the table.
-- \begin{tabular*}{\columnwidth}{...}: Creates a table stretched to the full column width.
-- - \columnwidth: Specifies the table width to match the column's width.
-- - @{\extracolsep{\stretch{1}}}: Adds flexible space between columns to evenly distribute content across the full width.
-- - *{7}{r}: Defines 7 right-aligned columns (first for row labels, remaining 6 for data).
-- - @{}: Removes default padding at the table's edges. 
  table.insert(result, [[\noindent\begin{tabular*}{\columnwidth}{@{\extracolsep{\stretch{1}}}*{]] .. num_columns .. [[}{l}@{}} ]])

  for i, field in ipairs(self.fields) do
    table.insert(result, field)

    if i < #self.fields then
      if i % num_columns == 0 then
        table.insert(result, [[ \\ ]])
      else
        table.insert(result, " & ")
      end
    end
  end

  -- Close the last row if needed
  if #self.fields % num_columns ~= 0 then
    table.insert(result, [[ \\ ]])
  end

  table.insert(result, [[\end{tabular*}]])
  tex.sprint(table.concat(result))
end

-- Method to clear all fields (utility function)
function TokenGrid:clear_fields()
  self.fields = {}
end

-- Return the TokenGrid class for module usage
return TokenGrid