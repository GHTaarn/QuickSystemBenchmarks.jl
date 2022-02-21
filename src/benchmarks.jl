using LinearAlgebra

function benchmark1()
	n=30
	eigen(reshape(collect(1.0:n^2), n, n))
	return nothing
end

function benchmark2()
	s = collect(1.0:1e4)
	sort(s .* (-1).^s)
	return nothing
end

function runbenchmarks()
	for benchmark in [benchmark1, benchmark2]
		# Warm up run
		benchmark()

		# Report the runtime
		@time benchmark()
	end
end

