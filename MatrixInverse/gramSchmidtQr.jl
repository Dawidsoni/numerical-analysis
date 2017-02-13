#Maks Brandt & Dawid Wegner - zadanie P3.20
#Moduł udostępnia funkcję obliczającą rozkład QR macierzy za pomocą ortogonalizacji Grama-Schmidta

function gramProj(pVec, qVec)
  fac = sum(pVec .* qVec)
  fac /= sum(qVec .* qVec)
  return fac * qVec
end

function gramMethod(base)
  baseSize = length(base)
  result = []
  for i in 1:baseSize
    vec = copy(base[i])
    for j in range(1, i - 1)
        proj = gramProj(base[i], result[j])
        vec -= proj
    end
    vec *= (1 / norm(vec))
    push!(result, vec)
  end
  return result
end

function mtxAsBase(mtx)
  base = []
  for i in 1:size(mtx, 1)
    push!(base, mtx[:, i])
  end
  return base
end

function gramQrDcmp(inMtx)
  base = mtxAsBase(inMtx)
  ortBase = gramMethod(base)
  qMtx = zeros(size(inMtx))
  rMtx = zeros(size(inMtx))
  for i in 1:size(inMtx, 1)
    for j in 1:size(inMtx, 1)
      qMtx[i, j] = ortBase[j][i]
      rMtx[i, j] = sum(ortBase[i] .* base[j])
    end
  end
  return (qMtx, rMtx)
end
