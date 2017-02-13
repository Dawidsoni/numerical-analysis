#Maks Brandt & Dawid Wegner - zadanie P2.20
#Moduł udostepnia funkcje umożliwiające podstawowe operacje na wektorach

function printVec(vec)
  for i in range(1, length(vec))
    print(vec[i], "(", i - 1, ")")
    if i != length(vec)
      print(", ")
    end
  end
  println()
end

function addVec(pVec, qVec)
  vecSize = max(length(pVec), length(qVec))
  result = zeros(vecSize)
  for i in range(1, vecSize)
    if i <= length(pVec)
      result[i] += pVec[i]
    end
    if i <= length(qVec)
      result[i] += qVec[i]
    end
  end
  return result
end

function subVec(pVec, qVec)
  vecSize = max(length(pVec), length(qVec))
  result = zeros(vecSize)
  for i in range(1, vecSize)
    if i <= length(pVec)
      result[i] = pVec[i]
    end
    if i <= length(qVec)
      result[i] -= qVec[i]
    end
  end
  return result
end

function mulVec(fac, vec)
  result = zeros(length(vec))
  for i in range(1, length(vec))
    result[i] = fac * vec[i]
  end
  return result
end

function getVecCopy(vec)
  return mulVec(1, vec)
end

function vectorsTest()
  printVec(getVecCopy([1, 2]))
  printVec(addVec([1, 2], [2, 3, 4]))
  printVec(subVec([1, 2], [2, 3, 4]))
  printVec(mulVec(2, [1, 2, 3]))
end
