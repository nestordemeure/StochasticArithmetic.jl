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
  pseudoRandomNumber = hash((DSAseed, args...)) # hash used as a random number
  return isodd(pseudoRandomNumber) # turn hash into a bool
end

end # module 

# NOTES:
# diffusion is an important property in cryptographic cyphers (see paper "random as easy as 1, 2, 3" for concept and fast PRNG that have this property)
# means that a change of 1 bit in the input guarantees that all bits in the output have a 50% proba of changing
# splittable RNG paper (hash functions used as RNG): http://www.thesalmons.org/john/random123/papers/random123sc11.pdf