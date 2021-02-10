module Determinism
export randBool, resetSeed

using Random

"""
seed used for the deterministic stochastic arithmetic
should be changed from one sample to another
"""
DSAseed = rand(Int64)

"""
changes the seed in order to run the computation and get a new result
"""
function resetSeed()
  global DSAseed = rand(Int64)
end

"""
Function that returns a boolean pseudo-randomly
garantees *determinism*: the same inputs will always produce the same output
and *diffusion*: all bits in the output have a 50% probability of being flipped if any bit of an input change
"""
function randBool(args...)
  global DSAseed # put global variable in scope
  argsInt = map(x -> reinterpret(Int64,x), args) # converts inputs to Int64
  seed = xor(DSAseed, argsInt...) # fuses inputs and seed
  randomBool = isodd(hash(seed)) # very simple random number generator
  return randomBool
end

end # module 

# diffusion is an important property in cryptographic cyphers (see paper "random as easy as 1, 2, 3" for concept and fast PRNG that have this property)
#  means that a change of 1 bit in the input guarantees that all bits in the output have a 50% proba of changing
#
# meaning that if we use such a cypher on top of our XOR mix, we have the guarantee that the output can be used without fear of bias.
#
# splittable RNG: http://www.thesalmons.org/john/random123/papers/random123sc11.pdf