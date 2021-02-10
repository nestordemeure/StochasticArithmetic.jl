module Determinism
export randBool, resetSeed

"""
seed used for the deterministic stochastic arithmetic
should be changed from one sample to another
"""
DSAseed = rand(UInt64)

"""
changes the seed in order to run the computation and get a new result
"""
function resetSeed()
    global DSAseed = rand(UInt64)
end

"""
Function that returns a boolean pseudo-randomly
garantees *determinism*: the same inputs will always produce the same output
and *diffusion*: all bits in the output have a 50% probability of being flipped if any bit of an input change
"""
function randBool(args...)
  global DSAseed # put global variable in scope
  argsUInt = map(x -> reinterpret(UInt64,x), args) # converts inputs to UInt64
  seed = xor(DSAseed, argsUInt...) # fuses inputs and seed
  randomBool = isodd(count_ones(seed)) # very simple random number generator
  return randomBool
end

end # module 

# diffusion is an important property in cryptographic cyphers (see paper "random as easy as 1, 2, 3" for concept and fast PRNG that have this property)
#  means that a change of 1 bit in the input guarantees that all bits in the output have a 50% proba of changing
#
# meaning that if we use such a cypher on top of our XOR mix, we have the guarantee that the output can be used without fear of bias.