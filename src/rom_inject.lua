#!/usr/bin/env lua5.3

if #arg ~= 1 then
   io.stderr:write("Usage: rom_inject.lua new_rom.rom < friedup.bin > friedup_new_rom.bin\n")
   os.exit(1)
end

local f = assert(io.open(arg[1], "rb"))
local rom = f:read("*a")
assert(#rom <= 8192, "ROM is too large")
if #rom < 8192 then rom = rom .. ("\0"):rep(8192 - #rom) end
f:close()

local INIT_STRINGS = {
   [0]="fa0f",
   "fa1e",
   "fa2d",
   "fa3c",
   "fa4b",
   "fa5a",
   "fa69",
   "fa78",
   "fa87",
   "fa96",
   "faa5",
   "fab4",
   "fac3",
   "fad2",
   "fae1",
   "faf0",
}

local segments = {}
for i,v in pairs(INIT_STRINGS) do
   segments[v:rep(16)] = i
end

repeat
   local l = io.read("*l")
   if not l then break end
   print(l)
   if l:sub(1,10) == ".ram_data " then
      l = io.read("*l")
      if segments[l] then
         local discriminant = l
         local i = segments[discriminant]
         segments[discriminant] = nil
         for row=0,15 do
            if row ~= 0 then assert(io.read("*l") == discriminant) end
            local t = {}
            for col=15,0,-1 do
               local base = ((i&14)<<8)+(row<<5)+(col<<2)+((i&1)<<1)
               t[#t+1] = ("%02x%02x"):format(rom:byte(base+2), rom:byte(base+1))
            end
            print(table.concat(t))
         end
      else
         print(l)
      end
   end
until false

if next(segments) ~= nil then
   io.stderr:write("Not all ROM segments were injected!\n")
   local t = {}
   for _,seg in pairs(segments) do t[#t+1] = ("%X"):format(seg) end
   table.sort(t)
   io.stderr:write("Missing: ", table.concat(t, ", "), "\n")
   os.exit(1)
end
