

--- Trim the given string from whitespaces (use n position)
--- http://lua-users.org/lists/lua-l/2009-12/msg00904.html
-- @param str The string to trim
-- @return string
function string.trim(str)
 local n = str:find("%S");
 return n and str:match(".*%S", n) or "";
end


--- Left trim the given string from whitespaces (use n position)
--- http://lua-users.org/lists/lua-l/2009-12/msg00904.html
-- @param str The string to trim left
-- @return string
function string.ltrim(str)
  local n = str:find("%S");
  return n and string.sub(str, n) or "";
end


--- Right trim the given string from whitespaces (use n position)
--- http://lua-users.org/lists/lua-l/2009-12/msg00904.html
-- @param str The string to trim left
-- @return string
function string.rtrim(str)
  local n = str:find("%S%s*$");
  return n and string.sub(str, 1, n) or "";
end


--- Wrap the given string at about limit characters long per lines. Optionally,
--- an indentation of indent spaces can be given for subsequent lines.
-- @param str The string to wrap
-- @param limit The limit in characters per line
-- @param indent (optinal) The space indentation for subsequent lines
-- @return The lines
function string.wrap(str, limit, indent)
  local lines = {};
  local offset = string.find(str, "%S");  -- skip white space at beginning of string
  local pos;

  limit = math.max(limit, 1);

  while str and offset and offset <= #str do
    if offset + limit < #str then
      pos = string.find(string.sub(str, 1, offset + limit + 1), "%s+%S+$", offset) or
            string.find(str, "%s%S", math.max(offset + limit - 1, 1));
    else
      pos = nil;
    end

    --print("POS=".. (pos or "nil") ..", offset=".. offset ..", limit=".. limit .." == ".. string.sub(str, offset));

    if pos then
      local subStr = string.trim(string.sub(str, offset, pos - 1));
      local nextOffset = string.find(str, "%S", pos);

      if subStr and #subStr > 0 then
        if indent and indent > 0 then
          if #lines == 0 then
            limit = math.max(limit - indent, 1);
          else
            subStr = string.rep(" ", indent) .. subStr;
          end
        end

        --print(#lines .." = ".. subStr .."(".. #subStr ..")");
        table.insert(lines, subStr);
      end

      if nextOffset then
        offset = nextOffset;
      else
        offset = nil;
      end

    else
      local subStr = string.trim(string.sub(str, offset));

      if #lines > 0 and indent and indent > 0 then
        subStr = string.rep(" ", indent) .. subStr;
      end

      --print(#lines .." = ".. subStr .."(".. #subStr ..")");
      table.insert(lines, subStr);
      offset = nil;
    end
  end

  return lines;
end
