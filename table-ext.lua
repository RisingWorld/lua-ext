

--- Slice part of a table and return a new copy
---
--- Note : This methods does not check if tbl is a table, it does not check
---        if first and last are valid... it is the responsibility of the caller
---        to make sure all args are valid.
---
-- @param tbl the table to slice
-- @param first (optional) the starting index (default 1)
-- @param last (optional) the last index (default #tbl)
-- @param step (optinal) skip elements between first...last (default 1)
-- @return The table slice
function table.slice(tbl, first, last, step)
  local sliced = {}

  for i = first or 1, last or #tbl, step or 1 do
    sliced[#sliced+1] = tbl[i]
  end

  return sliced
end


--- Return all the keys in the given table. The table is assume not to be
--- an array.
-- @param tbl the table
-- @return Table an array of all the keys in the given table
function table.keys(tbl)
  local keys = {};

  for k,v in pairs(tbl) do
    table.insert(keys, k);
  end

  return keys;
end


--- Used to find out if the provided table contains the specified value.
-- @param tbl The table
-- @param value The value you're looking for
-- @return True if the value exists in the table, false if not
function table.contains(tbl, value)
  local found = false;

  for k,v in pairs(tbl) do
    if v == value then
      found = true;
      break;
    end
  end

  return found;
end


--- Used to insert all elements into the provided table. This function is like
--- table.insert(tbl, index, value) except that values is expected to be an array.
--- However, values may not need to be an array and the function will act just like
--- table.insert.
-- @param tbl The table
-- @param index The index from which insertion will start
-- @param values The value or values to insert.
function table.insertAll(tbl, index, values)
  if type(index) == "table" or values == nil then
    values = index;
    index = #tbl + 1;
  elseif type(index) ~= "number" then
    index = nil;
  end

  index = math.max(index, 1);

  if type(values) ~= "table" then
    if index then
      table.insert(tbl, index, values);
    else
      table.insert(tbl, values);
    end
  else
    for i = 1, #values do;
      table.insert(tbl, index + i - 1, values[i]);
    end;
  end

  return tbl;
end


--- Used to remove all elements from the provided table matching a given value.
-- @param tbl The table
-- @param value The value you want to remove
-- @return The number of times value was removed from the array
function table.removeAll(tbl, value)
  local n = #tbl;
  local j = 0;
  local removed = 0;

  -- 1. Remove all values from array and/or table
  for k,v in pairs(tbl) do
    if v == value then
      tbl[k] = nil;
      removed = removed + 1;
    end
  end

  -- 2. shifting elements
  for i = 1, n do
    if tbl[i] ~= nil then
      j = j + 1;
      tbl[j] = tbl[i];
    end
  end

  -- 3. Compacting
  for i = j + 1, n do
    tbl[i] = nil;
  end

  return removed;
end


--- Pluck a value from each table elements and return them as an array.
--- If an element is not a table, or does not possess the specified key,
--- then it will be skipped. Otherwise, default will be used.
-- @param tbl The table
-- @param key The key's value to pluck from each element
-- @param default (optional) If plucked value is nil, or missing, the value to be used instead
-- @return The resulting table
function table.pluck(tbl, key, default)
  local res = {};

  for k,v in pairs(tbl) do
    if type(v) == "table" and v[key] then
      table.insert(res, v[key]);
    elseif default ~= nil then
      table.insert(res, default);
    end
  end

  return res;
end