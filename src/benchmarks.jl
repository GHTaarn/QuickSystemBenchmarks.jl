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

function benchmark3()
	nthreads = 4
	arraysize = 1e6
	a = Vector{Vector{Float64}}(UndefInitializer(), nthreads)
	thread = Vector{Task}(UndefInitializer(), nthreads)

	s = collect(1.0:arraysize)
	a[1] = s .* (-1).^s
	for i=2:nthreads a[i]=deepcopy(a[1]) end

	for i = 1 : nthreads
		thread[i] = @async sort!(a[i])
	end
	for i = 1 : nthreads
		wait(thread[i])
	end

	return nothing
end

function runbenchmarks()
	for benchmark in [benchmark1, benchmark2, benchmark3]
		# Warm up run
		benchmark()

		# Report the runtime
		@time benchmark()
	end
end

