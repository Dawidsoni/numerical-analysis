#Maks Brandt & Dawid Wegner - zadanie P3.20
#Moduł testowy, który służył do przetestowania poprawności zaimplementowanych metod

function householderQrDcmpTest()
  mtx = [1.0 1.0 0.0; 1.0 0.0 1.0; 0.0 1.0 1.0]
  (qMtx, rMtx) = householderQrDcmp(mtx)
  println(mtx)
  println(qMtx * rMtx)
end

function givensQrDcmpTest()
  mtx = [1.0 1.0 0.0; 1.0 0.0 1.0; 0.0 1.0 1.0]
  (qMtx, rMtx) = givensQrDcmp(mtx)
  println(mtx)
  println(qMtx * rMtx)
end

function gramQrDcmpTest()
  mtx = [1.0 1.0 0.0; 1.0 0.0 1.0; 0.0 1.0 1.0]
  (qMtx, rMtx) = gramQrDcmp(mtx)
  println(mtx)
  println(qMtx * rMtx)
end

function qrMtxInverseTest(qrMethod)
  mtx = [1.0 2.0 3.0; 0.0 1.0 4.0; 5.0 6.0 0.0]
  inv = qrMtxInverse(mtx, qrMethod)
  println(mtx * inv)
end

function lupMtxInverseTest()
  mtx = [0.0 1.0 1.0; 0.0 0.0 1.0; 1.0 1.0 1.0]
  inv = lupMtxInverse(mtx)
  println(mtx * inv)
end

function dcmpMethodTest()
  givensQrDcmpTest()
  householderQrDcmpTest()
  gramQrDcmpTest()
  lupMtxInverseTest()
  qrMtxInverseTest(givensQrDcmp)
  qrMtxInverseTest(householderQrDcmp)
  qrMtxInverseTest(gramQrDcmp)
end
