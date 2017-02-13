#Maks Brandt & Dawid Wegner - zadanie P2.20
#Moduł służący do aproksymowania dowolnej funkcji przy użyciu dyskretnego iloczynu skalarnego

function getApproxPol(base, dualBase, approxFunc, pointSet)
  scalarFunc = discScalarFunc(pointSet, false)
  baseSize = length(base)
  result = [0.0]
  for i in range(1, baseSize)
    elemFunc = (x) -> getPolVal(dualBase[i], x)
    scalarProd = scalarFunc(approxFunc, elemFunc)
    elem = mulVec(scalarProd, base[i])
    result = addVec(result, elem)
  end
  return result
end

function getApproxFunc(base, approxMethod, approxFunc, pointSet)
  scalarFunc = discScalarFunc(pointSet, true)
  dualBase = approxMethod(base, scalarFunc)
  result = getApproxPol(base, dualBase, approxFunc, pointSet)
  return (x) -> getPolVal(result, x)
end
