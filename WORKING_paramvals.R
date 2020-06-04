####### BUILDING THE MODEL OUT ONE PIECE AT A TIME ########

# input of algae
inp <- 10  #5 #or 10 # or 15

# death rates d
d_A <- 0.1     # death of algae
d_P <- 0.1     # death of parasites
d_C <- 0.1     # death of cercariae
#d_FU <- 0.05   # death of uninfected first int hosts
#d_FI <- 0.05   # death of infected first int hosts
d_DU <- 0.1   # death of uninfected definitive hosts 0.3 is APPARENTLY WAY TOO HIGH, and 0.1 too low??! 0.22 works nicely
################## THIS IS THE ONLY VALUE I CAN KEEP DEATH RATE AT WHERE PRED/PREY POPS REACH EQULIBRIUM
d_DI <- 0.1   # death of infected definitive hosts
m_FU <- 0.1   # density dependent mortality of uninfected first int hosts
m_FI <- 0.1   # density dependent mortality of infected first int hosts
m_SU <- 0.05  # background mortality rate of uninfected fish second int hosts
m_SI <- 0.05  # background mortality rate of infected fish second int hosts

# grazing rate 
### later I will change them so that infected snails graze at a higher rate
### PRE HANDLING TIME: anything higher than 0.5 tanks the algae pop, but allows for growth of the snails
### WITH HANDLING: 2 seems like the limit
gamma_I <- 0.5  # grazing rate of infected first int hosts, 
gamma_U <- 0.5  # grazing rate of uninfected first int hosts
# general attack rate
## these will need to vary later but for now they are all equal (system with no behavioral manipulation)
gamma_D <- 0.5


# handling time
### for saturation rates for preds and grazers
### in denominator so larger means slower?
h_F <- 2  # handling time for first int hosts (grazing time for snails... good around 2 with a gamma of 0.5 and conversion rate of 0.5, algal input of 10)
h_D <- 2 # if zero, whole model crashes/explodes/breaks???

# carrying capacity for fish second int hosts (shot in the dark)
k <- 10

# multiplier for infected prey consumption rate
alpha <- 1

# alternate prey abundance 
#v <- 0
v <- 0.1

# infection rate
## equates to c_HIP and c_HUP (consumption of parasite propagules) in long et al and is held equal
beta_U <- 0.1   # infection rate of uninfected first int hosts
beta_I <- 0.1   # infection rate of already infected first int hosts (dead end) 

# contact rate
## I made this up so I'm going to have to figure it out
## actually it's technically the R0 I think?! Just for a different species of host.. but does it matter
c <- 0.5    # we'll just set it really high for now

# conversion rate
# preds have higher i guess 
# i'm not sure if this is how conversion rates work, I might need to tweak these
e_FU <- 0.5   # conversion of algae by uninfecteds into uninfected first int host tissue
e_FI <- 0.5  # conversion of algae by infecteds into uninfected first int host tissue (should be zero or close to it)
e_DU <- 0.5   # conversion of 2I hosts by uninfecteds into determinate host tissue
e_DI <- 0.5   # conversion of 2I hosts by infecteds into determinate host tissue
e_C <- 0.5    # conversion of infected 1I hosts to cercariae (it's very high)

# reproduction rate
## I guess we will make these equal for now?
r_P <- 0.5 # reproduction of parasites (note: if we want to include pathogenicity other than death, could we subtract r from the IDH pop equation?)
r_SU <- 0.5 # reproduction of new uninfected second intermediate hosts
r_SI <- 0.5 # reproduction of new uninfecteds by INFECTED second intermediate hosts

# goals: three levels of kelp input crossed with three levels of 2IH susceptibility to predation