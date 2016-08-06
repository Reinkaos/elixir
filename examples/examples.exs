def flares # some function

def no_eva(flares) do
  Enum.filter flares, fn (flare) ->
    power(flare) > 1000
  end
end

# you can do the above function like this
# & means function and &1 is the first param of the function

def no_eva(flares), do: Enum.filter flares, &(power(&1) > 1000)

# Getting the max flar
def deadliest(flares) do
  Enum.map(flares, &(power(&1)))
    |> Enum.max
end

# List
planets = [
  :mercury,
  :venus,
  :earth,
  :mars,
  :jupiter,
  :saturn,
  :uranus,
  :neptune
]

# Access Values

p = Enum.at(planets, 3) # Mars
p = Enum.find(planets, &(&1 == :mars)) # Mars
p = Enum.filter(planets, &(&1 == :mars)) #[Mars]

# Keyword Lists

planets = [
  [name: :mercury, type: :rocky, ev: 4.3],
  [name: :venus, type: :rocky, ev: 10.4],
  [name: :earth, type: :rocky, ev: 11.2],
  [name: :mars, type: :rocky, ev: 5.0],
  [name: :jupiter, type: :gaseous, ev: 59.5],
  [name: :saturn, type: :gaseous, ev: 35.5],
  [name: :uranus, type: :gaseous, ev: 21.3],
  [name: :neptune, type: :gaseous, ev: 23.5],
]

# Gives back mars
# It matches on the element sin the list
p = Enum.find(planets, fn([name: name, type: type, ev: ev]) ->
  name == :mars
end)

# List of maps

planets = [
  %{name: "mercury", type: :rocky, ev: 4.3},
  %{name: "venus", type: :rocky, ev: 10.4},
  %{name: "earth", type: :rocky, ev: 11.2},
  %{name: "mars", type: :rocky, ev: 5.0},
  %{name: "jupiter", type: :gaseous, ev: 59.5},
  %{name: "saturn", type: :gaseous, ev: 35.5},
  %{name: "uranus", type: :gaseous, ev: 21.3},
  %{name: "neptune", type: :gaseous, ev: 23.5},
]

#Mars
p = Enum.find(planets, fn(map) ->
  map.name == "mars"
end)

# Insert into a list of maps
fixed = List.insert_at(planets, -1, %{name: "pluto", type: :rocky, ev: 1.1})
# -1 puts it at the end, 0 puts it at the front

fixed = [
  %{name: "mercury", type: :rocky, ev: 4.3},
  %{name: "venus", type: :rocky, ev: 10.4},
  %{name: "earth", type: :rocky, ev: 11.2},
  %{name: "mars", type: :rocky, ev: 5.0},
  %{name: "jupiter", type: :gaseous, ev: 59.5},
  %{name: "saturn", type: :gaseous, ev: 35.5},
  %{name: "uranus", type: :gaseous, ev: 21.3},
  %{name: "neptune", type: :gaseous, ev: 23.5},
  %{name: "pluto", type: :rocky, ev: 1.1}
]

# You can also do to append

fixed = planets ++ %{name: "pluto", type: :rocky, ev: 1.1}

# If you want to prepend do

fixed = [%{name: "pluto", type: :rocky, ev: 1.1}] ++ planets

## Counting recursively

# count_planets will be called with a collection
# it will call the second count planets, passing in the collection and the count
# it will increment it by one and remove the head until the collection is empty
# the last function will then be called and return the count

def count_planets(planets), do: count_planets(planets, 0)
def count_planets([head | tail], count), do: count_planets(tail, count + 1)
def count_planets([], count), do: count
