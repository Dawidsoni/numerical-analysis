include("vectors.jl")

#Maks Brandt & Dawid Wegner - zadanie P2.20
#Moduł udostepnia funkcje liczące iloczyn skalarny:
# a) iloczyn skalarny liczony całką na przedziale dla wielomianów
# b) dyskretny iloczyn skalarny dla dowolnych funkcji

function getPolVal(pol, val)
  polSize = length(pol)
  result = pol[polSize]
  for i in range(polSize - 1, -1, polSize - 1)
    result = pol[i] + val * result
  end
  return result
end

function getPolInt(pol)
  polSize = length(pol)
  result = zeros(polSize + 1)
  for i in range(polSize, -1, polSize)
    result[i + 1] = pol[i] / i
  end
  return result
end

function mulPol(pPol, qPol)
  result = zeros(length(pPol) + length(qPol) - 1)
  for i in range(1, length(pPol))
    for j in range(1, length(qPol))
      result[i + j - 1] += (pPol[i] * qPol[j])
    end
  end
  return result
end

function intScalarProd(pPol, qPol, stRange, endRange)
  integral = getPolInt(mulPol(pPol, qPol))
  return getPolVal(integral, endRange) - getPolVal(integral, stRange)
end

function intScalarFunc(stRange, endRange)
  return (pPol, qPol) -> intScalarProd(pPol, qPol, stRange, endRange)
end

function discScalarProd(pFunc, qFunc, pointSet, isPol)
  result = 0.0
  for it in pointSet
    if isPol
      pVal = getPolVal(pFunc, it)
      qVal = getPolVal(qFunc, it)
      result += (pVal * qVal)
    else
      result += (pFunc(it) * qFunc(it))
    end
  end
  return result
end

function discScalarFunc(pointSet, isPol)
  return (pFunc, qFunc) -> discScalarProd(pFunc, qFunc, pointSet, isPol)
end

function scalarProdArr(elem, arr, scalarFunc)
  result = []
  for i in range(1, length(arr))
    prod = scalarFunc(elem, arr[i])
    push!(result, prod)
  end
  return result
end

function getNormQuad(pol, scalarFunc)
  return scalarFunc(pol, pol)
end

function scalarProductsTest()
  pol = [-2, 0, 3, 1, 4]
  println(getPolVal(pol, 1))
  integral = getPolInt(pol)
  printVec(integral)
  printVec(mulPol([1, 2, 3], [2, 3, 4]))
  println(intScalarProd(pol, pol, -1, 1))
  println(getNormQuad(pol, intScalarFunc(-1, 1)))
  func = (x) -> 2
  println(getNormQuad(func, discScalarFunc([1, 2, 3])))
end
