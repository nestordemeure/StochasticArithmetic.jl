using StochasticArithmetic

# proposed by Siegfried Rump (rump's royal pain)
# http://www.davidhbailey.com/dhbtalks/dhb-num-repro.pdf
#
# true result: -0.82739605994682136814116
# the result is astronomicaly wrong !
# but consistant across precisions
function rumpTest(T)
    x::T = 77617.0
    y::T = 33096.0
    x2 = x*x
    y2 = y*y
    y4 = y2*y2
    y6 = y4*y2
    y8 = y4*y4
    return 333.75*y6 + x2*(11.0*x2*y2 - y6 - 121.0*y4 - 2.0) + 5.5*y8 + x/(2.0*y)
end

# non-instrumented run
println("result float: ", rumpTest(Float64))

# instrumented but we always get the same result as we are using the same seed
println("result Sfloat: ", rumpTest(SFloat64).value)
println("result Sfloat: ", rumpTest(SFloat64).value)
println("result Sfloat: ", rumpTest(SFloat64).value)
println("result Sfloat: ", rumpTest(SFloat64).value)
println("result Sfloat: ", rumpTest(SFloat64).value)

# now varying the seed between runs
StochasticArithmetic.Determinism.resetSeed()
println("result Sfloat (reset): ", rumpTest(SFloat64).value)
StochasticArithmetic.Determinism.resetSeed()
println("result Sfloat (reset): ", rumpTest(SFloat64).value)
StochasticArithmetic.Determinism.resetSeed()
println("result Sfloat (reset): ", rumpTest(SFloat64).value)
StochasticArithmetic.Determinism.resetSeed()
println("result Sfloat (reset): ", rumpTest(SFloat64).value)
StochasticArithmetic.Determinism.resetSeed()
println("result Sfloat (reset): ", rumpTest(SFloat64).value)

# digits computed over 10 runs
println( @reliable_digits rumpTest(SFloat64) )
