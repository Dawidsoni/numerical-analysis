include("calc_state.jl")

#metody obliczenia liczby pi
#jeśli iterRange jest pustym przedziałem, to zwracamy wartość końcową przybliżenia
#w przeciwnym wypadku rozwijamy wynik o iteracje z przedziału iterRange

function leibniz(calcPi, iterRange)
	if length(iterRange) == 0
		return calcPi * 4
	end
	if calcPi == Void
		calcPi = BigFloat(0)
	end
	result = BigFloat(0)
	for i in iterRange
		if i % 2 == 0
			result += BigFloat(1) / (2i + 1)
		else
			result -= BigFloat(1) / (2i + 1)
		end
	end
	return calcPi + result
end

function newtonEuler(calcPi, iterRange)
	if length(iterRange) == 0
		return  2 * sqrt(BigFloat(2)) * calcPi
	end
	if calcPi == Void
		calcPi = BigFloat(0)
	end
	result = BigFloat(0)
	for i in iterRange
		if i * (i - 1) / 2 % 2 == 0
			result += BigFloat(1) / (2i + 1)
		else
			result -= BigFloat(1) / (2i + 1)
		end
	end
	return calcPi + result
end

function monteCarloCoord()
	minRand = typemin(Int128) + 1
	maxRand = typemax(Int128)
	return BigInt(rand(minRand:maxRand))
end

function monteCarlo(calcState, iterRange)
	if length(iterRange) == 0
		return (calcState[1] / calcState[2]) * 4
	end
	if calcState == Void
		calcState = (BigInt(0), BigInt(0))
	end
	result = BigInt(0)
	radius = BigInt(typemax(Int128))
	for i in iterRange
		xC, yC = monteCarloCoord(), monteCarloCoord()
		if xC * xC + yC * yC <= radius * radius
			result += 1
		end
	end
	return (calcState[1] + result, last(iterRange) + 1)
end

function nilakantha(calcPi, iterRange)
	if length(iterRange) == 0
		return 3 + 4 * calcPi
	end
	if calcPi == Void
		calcPi = BigFloat(0)
	end
	result = BigFloat(0)
	for i in iterRange
		k = 2i
		if i % 2 == 0
			result += BigFloat(1) / ((k + 2) * (k + 3) * (k + 4))
		else
			result -= BigFloat(1) / ((k + 2) * (k + 3) * (k + 4))
		end
	end
	return calcPi + result
end

function leibnizTrans(calcState, iterRange)
	if length(iterRange) == 0
		return calcState[1]
	end
	if calcState == Void
		calcState = (BigFloat(3), BigFloat(3))
	end
	calcComp = calcState[2]
	result = BigFloat(0)
	for i in iterRange
		k = i + 1
		calcComp *= (5k + 3) * k * (2k - 1) * 2k
		calcComp /= (5 * (k - 1) + 3) * 2 * 3k * (3k + 1) * (3k + 2)
		result += calcComp
	end
	return (calcState[1] + result, calcComp)
end

function newtonTrans(calcState, iterRange)
	if length(iterRange) == 0
		return calcState[1] * sqrt(BigFloat(2)) / 9
	end
	if calcState == Void
		initVal = 19 + BigFloat(2) / BigFloat(10)
		calcState = (initVal, initVal)
	end
	calcComp = calcState[2]
	result = BigFloat(0)
	for i in iterRange
		k = i + 1
		calcComp *= 12k * (2k - 1) * (120k + 96)
		calcComp /= 9 * (6k + 1) * (6k + 5) * (120k - 24)
		result += calcComp
	end
	return (calcState[1] + result, calcComp)
end

function ramanujanStep(val, i)
	result = (4i - 3) * (4i - 2) * (4i - 1)
	result *= (1 + BigFloat(26390) / (26390 * (i - 1) + 1103))
	result /= ((i ^ 3) * 6147814464)
	return val * result
end

function ramanujan(calcState, iterRange)
	if length(iterRange) == 0
		return 9801 / (sqrt(BigFloat(8)) * calcState[1])
	end
	if calcState == Void
		initPi = BigFloat(1103)
		calcState = (initPi, initPi)
	end
	calcComp = calcState[2]
	result = BigFloat(0)
	for i in iterRange
		k = i + 1
		calcComp = ramanujanStep(calcComp, k)
		result += calcComp
	end
	return (calcState[1] + result, calcComp)
end

function chudnovskyStep(val, i)
	tf = BigFloat(3) / 4
	prod = 13591409 + 545140134 * (i - 1)
	result = 512 * (tf - BigFloat(5) / (8i))
	result *= (tf - BigFloat(3) / (8i))
	result *= (tf - BigFloat(1) / (8i))
	result *= (1 + BigFloat(545140134) / prod)
	result /= 32817176580096000
	return val * result
end

function chudnovsky(calcState, iterRange)
	if length(iterRange) == 0
		return 	(53360 * sqrt(BigFloat(640320))) / calcState[1]
	end
	if calcState == Void
		initPi = BigFloat(13591409)
		calcState = (initPi, initPi)
	end
	calcComp = calcState[2]
	result = BigFloat(0)
	for i in iterRange
		k = i + 1
		calcComp = chudnovskyStep(calcComp, k)
		if k % 2 == 0
			result += calcComp
		else
			result -= calcComp
		end
	end
	return (calcState[1] + result, calcComp)
end
