addVectors:
	nvcc src/addVectors.cu -o bin/addVectors

addThrustVectors:
	nvcc src/addThrustVectors.cu -o bin/addThrustVectors

sumThrustVector:
	nvcc src/sumThrustVector.cu -o bin/sumThrustVector

sumThrustVector2:
	nvcc src/sumThrustVector2.cu -o bin/sumThrustVector2 -rdc=true -g