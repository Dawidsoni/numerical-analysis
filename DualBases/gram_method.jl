#Maks Brandt & Dawid Wegner - zadanie P2.20
#Moduł udostępnia funkcję obliczjącą bazę dualną metodą ortogonalizacji Grama - Schmidta

function gramProj(pVec, qVec, scalarFunc)
  fac = scalarFunc(pVec, qVec)
  fac /= scalarFunc(qVec, qVec)
  return mulVec(fac, qVec)
end

function gramMethod(base, scalarFunc)
  baseSize = length(base)
  result = []
  for i in range(1, baseSize)
    vec = getVecCopy(base[i])
    for j in range(1, i - 1)
        proj = gramProj(base[i], result[j], scalarFunc)
        vec = subVec(vec, proj)
    end
    norm = getNormQuad(vec, scalarFunc)
    vec = mulVec(1 / norm, vec)
    push!(result, vec)
  end
  return result
end

function gramMethodTest()
  base = [[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
  scalarFunc = intScalarFunc(-1, 1)
  result = gramMethod(base, scalarFunc)
  println(result)
  for i in range(1, 3)
    for j in range(1, 3)
      println(scalarFunc(base[i], result[j]))
    end
  end
end
