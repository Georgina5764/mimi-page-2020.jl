using Mimi
using Base.Test

include("../src/utils/load_parameters.jl")
include("../src/components/Population.jl")

m = Model()
set_dimension!(m, :time, convert(Vector{Float64}, [2009, 2010, 2020, 2030, 2040, 2050, 2075, 2100, 2150, 2200]))
set_dimension!(m, :region, ["EU", "USA", "OECD","USSR","China","SEAsia","Africa","LatAmerica"])

population = addcomponent(m, Population)
population[:y_year_0] = 2008.
population[:y_year] = Mimi.dim_keys(m.md, :time)

p = load_parameters(m)

set_leftover_params!(m, p)

run(m)

# Generated data
pop = m[:Population, :pop_population]

# Recorded data
pop_compare = readpagedata(m, "test/validationdata/pop_population.csv")

@test pop ≈ pop_compare rtol=1e-3
