# Lua-Ext SubModule

This module adds some utility functions to the Lua language.


## Installation

This script is not standalone and must be used with your own script, as it doesn't have a `definition.xml` file.


### Direct installation (not recommended)

You only need to copy the necessary Lua scripts to your Rising World script's directory. Whenever the file needs updating, this manual step must be done. This is a non-desirable method as, if commited, it will create duplicate versions of this file across different repositories.


### Using as a Git Sub-Module (recommended)

At the script base folder, execute the two commands

```
$ git submodule add https://github.com/RisingWorld/lua-ext
$ git commit -am 'Added lua-ext sub-module'
```

This will create a directory called `lua-ext`, and clone this repository in it. However, the content of the directory will not be commited with the rest of your project, only the directory entry and a file called `.gitmodules` 

Whenever the project needs updating, perform this command, also at the script's base folder :

```
$ git submodule update --remote lua-ext
```

Refer to the [official Git documentation](http://www.git-scm.com/book/en/v2/Git-Tools-Submodules) for more information.


## Usage

Just include the necessary script (ex: `lua-ext/string-ext.lua`).


## API Reference

### String

* `string.trim(str)`
  Trim the given string from spaces.

* `string.ltrim(str)`
  Left trim the given string from spaces.

* `string.rtrim(str)`
  Right trim the given string from spaces.

* `string.wrap(str, limit[, indent])`  
  Wrap the given `str` at about `limit` characters per line with an optional `indent`ation of spaces in front of each subsequent lines. The returned value is an array of lines (with no trailing spaces).

  ```
  str = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur non urna lectus. Nunc ornare pharetra egestas. In gravida neque mi.";
  string.wrap(str, 50);   
  --> {
        "Lorem ipsum dolor sit amet, consectetur adipiscing",
        "elit. Curabitur non urna lectus. Nunc ornare",
        "pharetra egestas. In gravida neque mi."
      }
  ```


### Table

* `table.slice(tbl, first, last, step)`  
  Return a copy of the given `tbl` with all the elements from `first` to `last` (inclusively), with an optional stepping gap, will be removed. For example  

  ```
  tbl = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
  table.slice(tbl);         --> {}
  table.slice(tbl, 4);      --> { 1, 2, 3 }
  table.slice(tbl, 4, 8);    --> { 1, 2, 3, 9, 10 }
  table.slice(tbl, 4, 8, 2); --> { 1, 2, 3, 5, 7, 9, 10 }
  ```
  
* `table.keys(tbl)`  
  Return all the keys in the given `tbl`. For example  
  
  ```
  tblArr = { 2, 3, 5, 7, 11, 13, 17, 19 };  
  tblObj = { foo = "Hello", bar = "World" };  
  table.keys(tblArr);    --> { 1, 2, 3, 4, 5, 6, 7, 8 }  
  table.keys(tblObj);    --> { "foo", "bar" }  
  ```
  
* `table.contains(tbl, value)`
  Returns `true` if the specified table `tbl` has an element equal to `value`, `false` otherwise.
* `table.removeAll(tbl, value)`
  Removes *all* elements equal to `value` in the specified table `tbl`, then returns the number of time `value` was found and removed.
* `table.pluck(tbl, key[, default])`
  Returns an array containing all values plucked out of the given table matching the corresponding `key`.
  
  ```
  tbl = {
    { foo = "Hello", bar = "World" },
    { foo = "Lorem" },
    { bar = "whatever" },
    { foo = "Ipsum"}
  };
  table.pluck(tbl, "foo");        --> { "HellO", "Lorem", "Ipsum" }  
  table.pluck(tbl, "foo", false); --> { "HellO", "Lorem", false, "Ipsum" }  
  ```

* `table.insertAll(tbl, [index, ] values)`
  Exactly like `table.insert`, but `values` may be a table. Note that this function only works for numeric keys (i.e. arrays) and will not insert values associated with any other keys (i.e. objects)


## License

Copyright (c) 2015 Yanick Rochon

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
