include("scalar_products.jl")
include("gram_method.jl")
include("matrix_method.jl")
include("opt_method.jl")
include("bases.jl")
include("approx_func.jl")

#Maks Brandt & Dawid Wegner - zadanie P2.20
#Główna część programu zawierająca funkcje służące do testowania

function getKroneckerDelta(base, dualBase, scalarFunc)
  baseSize = length(base)
  result = zeros(baseSize, baseSize)
  for i in range(1, baseSize)
    for j in range(1, baseSize)
      index = baseSize * (i - 1) + j
      result[index] = scalarFunc(base[i], dualBase[j])
    end
  end
  return result
end

function getKroneckerError(delta)
  result = BigFloat(0.0)
  deltaSize = size(delta)[1]
  for i in range(1, deltaSize)
    for j in range(1, deltaSize)
      elem = BigFloat(delta[deltaSize * (i - 1) + j])
      if i == j
        result += (1.0 - elem) ^ 2
      else
        result += (0.0 - elem) ^ 2
      end
    end
  end
  return sqrt(result)
end

function testTime(testMethod)
  scalarFunc = discScalarFunc(range(1, 10), true)
  for i in range(200, 10, 6)
    base = getStandardBase(i)
    startTime = now()
    testMethod(base, scalarFunc)
    totalTime = Int(now() - startTime)
    println("Base size = ", i, ", time: ", totalTime)
  end
end

function testTime()
  println("Gram method time test:")
  testTime(gramMethod)
  println()
  println("Matrix method time test:")
  testTime(matrixMethod)
  println()
  println("Opt method time test:")
  testTime(optMethod)
end

function testScalar(baseMethod, methodFunc, scalarFunc)
  for i in range(1, 20)
    base = baseMethod(i)
    dualBase = methodFunc(base, scalarFunc)
    delta = getKroneckerDelta(base, dualBase, scalarFunc)
    error = getKroneckerError(delta)
    println("Base size = ", i, ", error: ", error)
  end
  println()
end

function testIntScalar(baseFunc)
  scalarFunc = intScalarFunc(-1.0, 1.0)
  println("Gram method approximation test (integral scalar product):")
  testScalar(baseFunc, gramMethod, scalarFunc)
  println("Matrix method approximation test (integral scalar product):")
  testScalar(baseFunc, matrixMethod, scalarFunc)
  println("Opt method approximation test (integral scalar product):")
  testScalar(baseFunc, optMethod, scalarFunc)
end

function testDiscScalar(baseFunc)
  scalarFunc = discScalarFunc([1, 2, 3], true)
  println("Gram method approximation test (discrete scalar product):")
  testScalar(baseFunc, gramMethod, scalarFunc)
  println("Matrix method approximation test (discrete scalar product):")
  testScalar(baseFunc, matrixMethod, scalarFunc)
  println("Opt method approximation test (discrete scalar product):")
  testScalar(baseFunc, optMethod, scalarFunc)
end

function testApprox(base, approxMethod, approxFunc, pointSet)
  result = getApproxFunc(base, approxMethod, approxFunc, pointSet)
  index = 0
  for it in pointSet
    index += 1
    if index % 20 == 0
      print("Func(", round(it, 2), "): ", approxFunc(it))
      println(", approx(", round(it, 2), "): ", result(it))
    end
  end
end

function testCosApprox(baseFunc)
  base = baseFunc(7)
  pointSet = range(0, 0.01, ceil(Int, 2 * pi / 0.01))
  testApprox(base, optMethod, cos, pointSet)
end

function testGaussianApprox(baseFunc)
  base = baseFunc(7)
  approxFunc = (x) -> e ^ (-(x - 1) ^ 2 / 18) / (sqrt(2 * pi) * 3)
  pointSet = range(-10, 0.02, 1001)
  testApprox(base, optMethod, approxFunc, pointSet)
end

function testComplexSinApprox(baseFunc)
  base = baseFunc(7)
  approxFunc = (x) -> sin(x) / x
  pointSet = range(0.01, 0.01, ceil(Int, 2 * pi / 0.01))
  testApprox(base, optMethod, approxFunc, pointSet)
end

function testApprox(baseFunc)
  println("Test cos approx:")
  testCosApprox(baseFunc)
  println()
  println("Test gaussian approx:")
  testGaussianApprox(baseFunc)
  println()
  println("Test complex sinus approx:")
  testComplexSinApprox(baseFunc)
end
