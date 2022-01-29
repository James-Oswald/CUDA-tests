addVectors:
	nvcc src/addVectors.cu -o bin/addVectors

addThrustVectors:
	nvcc src/addThrustVectors.cu -o bin/addThrustVectors

sumThrustVectors:
	nvcc src/sumThrustVectors.cu -o bin/sumThrustVectors