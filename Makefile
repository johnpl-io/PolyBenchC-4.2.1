.PHONY: all
all: bin/floyd-warshall bin/nussinov bin/deriche bin/correlation bin/covariance bin/seidel-2d bin/adi bin/fdtd-2d bin/jacobi-1d bin/heat-3d bin/jacobi-2d bin/syr2k bin/gemver bin/gemm bin/symm bin/trmm bin/syrk bin/gesummv bin/doitgen bin/mvt bin/atax bin/3mm bin/2mm bin/bicg bin/ludcmp bin/cholesky bin/lu bin/trisolv bin/gramschmidt bin/durbin


CC=clang++ -lm -m64 -O3 -I utilities utilities/polybench.c

bin/floyd-warshall: medley/floyd-warshall/floyd-warshall.*
	$(CC) -o bin/floyd-warshall -I medley/floyd-warshall medley/floyd-warshall/floyd-warshall.c

bin/nussinov: medley/nussinov/nussinov.*
	$(CC) -o bin/nussinov -I medley/nussinov medley/nussinov/nussinov.c

bin/deriche: medley/deriche/deriche.*
	$(CC) -o bin/deriche -I medley/deriche medley/deriche/deriche.c

bin/correlation: datamining/correlation/correlation.*
	$(CC) -o bin/correlation -I datamining/correlation datamining/correlation/correlation.c

bin/covariance: datamining/covariance/covariance.*
	$(CC) -o bin/covariance -I datamining/covariance datamining/covariance/covariance.c

bin/seidel-2d: stencils/seidel-2d/seidel-2d.*
	$(CC) -o bin/seidel-2d -I stencils/seidel-2d stencils/seidel-2d/seidel-2d.c

bin/adi: stencils/adi/adi.*
	$(CC) -o bin/adi -I stencils/adi stencils/adi/adi.c

bin/fdtd-2d: stencils/fdtd-2d/fdtd-2d.*
	$(CC) -o bin/fdtd-2d -I stencils/fdtd-2d stencils/fdtd-2d/fdtd-2d.c

bin/jacobi-1d: stencils/jacobi-1d/jacobi-1d.*
	$(CC) -o bin/jacobi-1d -I stencils/jacobi-1d stencils/jacobi-1d/jacobi-1d.c

bin/heat-3d: stencils/heat-3d/heat-3d.*
	$(CC) -o bin/heat-3d -I stencils/heat-3d stencils/heat-3d/heat-3d.c

bin/jacobi-2d: stencils/jacobi-2d/jacobi-2d.*
	$(CC) -o bin/jacobi-2d -I stencils/jacobi-2d stencils/jacobi-2d/jacobi-2d.c

bin/syr2k: linear-algebra/blas/syr2k/*
	$(CC) -o bin/syr2k -I linear-algebra/blas/syr2k/ linear-algebra/blas/syr2k/syr2k.c

bin/gemver: linear-algebra/blas/gemver/*
	$(CC) -o bin/gemver -I linear-algebra/blas/gemver/ linear-algebra/blas/gemver/gemver.c

bin/gemm: linear-algebra/blas/gemm/*
	$(CC) -o bin/gemm -I linear-algebra/blas/gemm/ linear-algebra/blas/gemm/gemm.c

bin/symm: linear-algebra/blas/symm/*
	$(CC) -o bin/symm -I linear-algebra/blas/symm/ linear-algebra/blas/symm/symm.c

bin/trmm: linear-algebra/blas/trmm/*
	$(CC) -o bin/trmm -I linear-algebra/blas/trmm/ linear-algebra/blas/trmm/trmm.c

bin/syrk: linear-algebra/blas/syrk/*
	$(CC) -o bin/syrk -I linear-algebra/blas/syrk/ linear-algebra/blas/syrk/syrk.c

bin/gesummv: linear-algebra/blas/gesummv/*
	$(CC) -o bin/gesummv -I linear-algebra/blas/gesummv/ linear-algebra/blas/gesummv/gesummv.c

bin/doitgen: linear-algebra/kernels/doitgen/*
	$(CC) -o bin/doitgen -I linear-algebra/kernels/doitgen/ linear-algebra/kernels/doitgen/doitgen.c

bin/mvt: linear-algebra/kernels/mvt/*
	$(CC) -o bin/mvt -I linear-algebra/kernels/mvt/ linear-algebra/kernels/mvt/mvt.c

bin/atax: linear-algebra/kernels/atax/*
	$(CC) -o bin/atax -I linear-algebra/kernels/atax/ linear-algebra/kernels/atax/atax.c

bin/3mm: linear-algebra/kernels/3mm/*
	$(CC) -o bin/3mm -I linear-algebra/kernels/3mm/ linear-algebra/kernels/3mm/3mm.c

bin/2mm: linear-algebra/kernels/2mm/*
	$(CC) -o bin/2mm -I linear-algebra/kernels/2mm/ linear-algebra/kernels/2mm/2mm.c

bin/bicg: linear-algebra/kernels/bicg/*
	$(CC) -o bin/bicg -I linear-algebra/kernels/bicg/ linear-algebra/kernels/bicg/bicg.c

bin/ludcmp: linear-algebra/solvers/ludcmp/*
	$(CC) -o bin/ludcmp -I linear-algebra/solvers/ludcmp/ linear-algebra/solvers/ludcmp/ludcmp.c

bin/cholesky: linear-algebra/solvers/cholesky/*
	$(CC) -o bin/cholesky -I linear-algebra/solvers/cholesky/ linear-algebra/solvers/cholesky/cholesky.c

bin/lu: linear-algebra/solvers/lu/*
	$(CC) -o bin/lu -I linear-algebra/solvers/lu/ linear-algebra/solvers/lu/lu.c

bin/trisolv: linear-algebra/solvers/trisolv/*
	$(CC) -o bin/trisolv -I linear-algebra/solvers/trisolv/ linear-algebra/solvers/trisolv/trisolv.c

bin/gramschmidt: linear-algebra/solvers/gramschmidt/*
	$(CC) -o bin/gramschmidt -I linear-algebra/solvers/gramschmidt/ linear-algebra/solvers/gramschmidt/gramschmidt.c

bin/durbin: linear-algebra/solvers/durbin/*
	$(CC) -o bin/durbin -I linear-algebra/solvers/durbin/ linear-algebra/solvers/durbin/durbin.c

clean:
	rm -f bin/*
