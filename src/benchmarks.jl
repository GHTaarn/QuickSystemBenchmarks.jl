using LinearAlgebra

function benchmark1()
	n=30
	eigen(reshape(collect(1.0:n^2), n, n))
	return nothing
end

function runbenchmarks()
	# Warm up runs
	benchmark1()

	# Report the runtimes
	@time benchmark1()
end

