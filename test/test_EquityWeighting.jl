using Mimi

include("../src/EquityWeighting.jl")

m = Model()
setindex(m, :time, [2009, 2010, 2020, 2030, 2040, 2050, 2075, 2100, 2150, 2200])
setindex(m, :region, ["EU", "USA", "OECD","USSR","China","SEAsia","Africa","LatAmerica"])

equityweighting = addequityweighting(m)

equityweighting[:tc_totalcosts_co2] = zeros(10, 8)
equityweighting[:tc_totalcosts_ch4] = zeros(10, 8)
equityweighting[:tc_totalcosts_n2o] = zeros(10, 8)
equityweighting[:tc_totalcosts_linear] = zeros(10, 8)

equityweighting[:ac_adaptationcosts_economic] = zeros(10, 8)
equityweighting[:ac_adaptationcosts_noneconomic] = zeros(10, 8)
equityweighting[:ac_adaptationcosts_sealevelrise] = zeros(10, 8)

p = load_parameters(m)
p["y_year_0"] = 2008.
p["y_year"] = m.indices_values[:time]

p["pop_ulation"] = repeat(p["population"]', outer=[10, 1]) # should be computed by a Population component, using pop_grw

setleftoverparameters(m, p)

run(m)
