local ls = require 'luasnip'

local WEIGHTS = {
  [10] = { { 2, 4, 10, 3, 5, 9, 4, 6, 8 } },
  [12] = {
    { 7, 2, 4, 10, 3, 5, 9, 4, 6, 8 },
    { 3, 7, 2, 4, 10, 3, 5, 9, 4, 6, 8 },
  },
}

local function calc_digit(digits, coefficients)
  local sum = 0
  for i = 1, #coefficients do
    sum = sum + digits[i] * coefficients[i]
  end
  return (sum % 11) % 10
end

local function generate_inn(_, _, length)
  local digits = {}
  local base_length = length == 10 and 9 or 10
  for i = 1, base_length do
    digits[i] = math.random(0, 9)
  end

  for _, coeff_set in ipairs(WEIGHTS[length]) do
    table.insert(digits, calc_digit(digits, coeff_set))
  end

  return table.concat(digits)
end

local function generate_kpp()
  local part1 = string.format('%04d', math.random(1, 9999))
  local part2 = string.format('%02d', math.random(1, 99))
  local part3 = string.format('%03d', math.random(1, 999))

  return part1 .. part2 .. part3
end

return {
  ls.s('inn_ul', ls.f(generate_inn, nil, { user_args = { 10 } })),
  ls.s('inn_fl', ls.f(generate_inn, nil, { user_args = { 12 } })),
  ls.s('kpp', ls.f(generate_kpp)),
}
