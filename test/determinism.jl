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

# instrumented (thus likely different from Float64 runs) but we always get the same result as we are using the same seed
println("result Sfloat: ", rumpTest(SFloat64).value)
println("result Sfloat: ", rumpTest(SFloat64).value)
println("result Sfloat: ", rumpTest(SFloat64).value)
println("result Sfloat: ", rumpTest(SFloat64).value)
println("result Sfloat: ", rumpTest(SFloat64).value)

# now varying the seed between runs (getting the usual behaviour of stochastic arithmetic)
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

# this function is exact despite having imprecise components
# it is wrongly labeled by traditional stochastic arithmetic 
function detTest(T)
    x = rumpTest(T) # numerical noise
    y = rumpTest(T) # identical numerical noise 
    zero = x - y # exact zero
    return 1. + zero # exact one
end

# this should have an infinity of digits
println( @reliable_digits detTest(SFloat64) )
