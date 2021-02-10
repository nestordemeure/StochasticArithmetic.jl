module StochasticArithmetic

using Statistics

export UP, DWN, RND, resetSeed, SFloat64, SFloat32, value, @reliable_digits

include("EFT.jl")
include("determinism.jl")
include("rounding.jl")
include("sfloat.jl")

end # module
