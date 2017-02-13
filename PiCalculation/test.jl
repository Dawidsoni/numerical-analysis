include("program.jl")

methodList = []
push!(methodList, leibniz)
push!(methodList, newtonEuler)
push!(methodList, monteCarlo)
push!(methodList, nilakantha)
push!(methodList, leibnizTrans)
push!(methodList, newtonTrans)
push!(methodList, ramanujan)
push!(methodList, chudnovsky)

setprecision(200000)

for method in methodList
  estPi = computeIterPi(method, 1000)
  printMeasurements(estPi, ITER_LIMIT, 1000)
  computeIterPi(method, 2000, 500)
  estPi = computeTimePi(method, 2000)
  printMeasurements(estPi, TIME_LIMIT, 2000)
  computeTimePi(method, 2000, 500)
  println()
end
