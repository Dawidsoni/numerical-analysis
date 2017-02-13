@enum LimitType TIME_LIMIT = 1 ITER_LIMIT = 2 #typy sprawdzania stanu obliczeń
const ITER_COUNT = 1 #liczba iteracji po których sprawdzamy stan obliczeń
const MAX_EST_PI = 1000000 #maksymalne estymowane pi

#wyszukiwanie binarne liczby cyfr dokładnych

function getExactDigits(estPi)
	diff = 2 * abs(estPi - pi)
	result = fromInd = 0
	toInd = MAX_EST_PI
	while fromInd != toInd
		middle = floor(Int, (fromInd + toInd) / 2)
		if diff * (BigInt(10) ^ middle) <= 1
			result = middle
			fromInd = middle + 1
		else
			toInd = middle
		end
	end
	return result
end

#wypisanie wyników pomiarów

function printMeasurements(estPi, limitType, limitCount)
	if limitType == TIME_LIMIT
		print("Po ", limitCount, " milisekundach: ")
	elseif limitType == ITER_LIMIT
		iterCount = BigInt(limitCount) * ITER_COUNT
		print("Po ", iterCount, " iteracjach: ")
	else
		throw("Illegal argument")
	end
	println(getExactDigits(estPi))
end

#metody sprawdzania stanu obliczeń (czasem i iteracjami)
#metody tic, toc służące do obliczania czasu nie działają w środowisku Jupyter
#użyto zastępczo metody now()

function computeTimePi(func, limitCount)
	calcState = Void
	fstIter = BigInt(0)
	totalTime = Int(0)
	while totalTime < limitCount
		endIter = fstIter + ITER_COUNT - 1
		startTime = now()
		calcState = func(calcState, fstIter:endIter)
		totalTime += Int(now() - startTime)
		fstIter = endIter + 1
	end
	return func(calcState, [])
end

function computeTimePi(func, limitCount, printInterval)
	calcState = Void
	fstIter = BigInt(0)
	totalTime = Int(0)
	printTime = Int(0)
	while totalTime < limitCount
		endIter = fstIter + ITER_COUNT - 1
		startTime = now()
		calcState = func(calcState, fstIter:endIter)
		itTime = Int(now() - startTime)
		printTime += itTime
		fstIter = endIter + 1
		while printTime > printInterval && totalTime < limitCount
			totalTime += printInterval
			printTime -= printInterval
			printMeasurements(func(calcState, []), TIME_LIMIT, totalTime)
		end
	end
	return func(calcState, [])
end

function computeIterPi(func, limitCount)
	calcState = Void
	fstIter = BigInt(0)
	for i in 1:limitCount
		endIter = fstIter + ITER_COUNT - 1
		calcState = func(calcState, fstIter:endIter)
		fstIter = endIter + 1
	end
	return func(calcState, [])
end

function computeIterPi(func, limitCount, printInterval)
	calcState = Void
	fstIter = BigInt(0)
	for i in 1:limitCount
		endIter = fstIter + ITER_COUNT - 1
		tic()
		calcState = func(calcState, fstIter:endIter)
		fstIter = endIter + 1
		if i % printInterval == 0
			printMeasurements(func(calcState, []), ITER_LIMIT, i)
		end
	end
	return func(calcState, [])
end
