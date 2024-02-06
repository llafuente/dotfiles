
1 bit: 0, 1
1 byte: 0-256 <-- char / i8 / u8

0 - 00000000
1 - 00000001
2 - 00000010
3 - 00000011
4 - 00000100
5 - 00000101
6 - 00000110
7 - 00000111
8 - 00001000
9 - 00001001

1 -   00000001
2 -   00000010
4 -   00000100
8 -   00001000
16 -  00010000
32 -  00100000
64 -  01000000
128 - 10000000


2 byte: 0-32000 <-- i16 / u16
4 byte: 0-16m <-- i32 / u32
8 byte: 0-64m <-- i64 / u64










x::Int = 10
y::Int = 10

function add(x, y)
   return x + y
end


mutable struct Player
   name::String
end

struct Point{T}
   x::T
   y::T
end


fieldnames(Player)

p = Player("Luis")

typeof(p)
