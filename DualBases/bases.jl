#Maks Brandt & Dawid Wegner - zadanie P2.20
#Moduł udostepnia funkcje tworzące bazy przestrzeni wektorowych

function getStandardBase(size)
  result = []
  for i in range(1, size)
    vec = fill(0.0, size)
    vec[i] = 1.0
    push!(result, vec)
  end
  return result
end

function getChebyshevBase(size)
  if size == 1
    return [1.0]
  end
  tp1 = fill(0.0, size)
  tp1[1] = 1.0
  tp2 = fill(0.0, size)
  tp2[2] = 1.0
  result = [tp1, tp2]
  for i in range(1, size - 2)
    vec = zeros(size)
    tp1 = result[i + 1][1:(length(vec) - 1)]
    tp2 = result[i][1:(length(vec) - 2)]
    vec[2:length(vec)] += (2 * tp1)
    vec[1:(length(vec) - 2)] -= tp2
    push!(result, vec)
  end
  return result
end
