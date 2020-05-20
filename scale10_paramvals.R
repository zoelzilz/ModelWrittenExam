####### BUILDING THE MODEL OUT ONE PIECE AT A TIME ########

# input of algae
inp <-20  #5 #or 10 # or 15

# death rates d
d_A <- 1     # death of algae
d_P <- 1     # death of parasites
d_C <- 1     # death of cercariae
#d_FU <- 0.05   # death of uninfected first int hosts
#d_FI <- 0.05   # death of infected first int hosts
d_DU <- 1   # death of uninfected definitive hosts
d_DI <- 1   # death of infected definitive hosts
m_FU <- 1   # density dependent mortality of uninfected first int hosts
m_FI <- 1   # density dependent mortality of infected first int hosts

# grazing rate 
### later I will change them so that infected snails graze at a higher rate
### PRE HANDLING TIME: anything higher than 0.5 tanks the algae pop, but allows for growth of the snails
### WITH HANDLING: 2 seems like the limit
gamma_I <- 20  # grazing rate of infected first int hosts, 
gamma_U <- 20  # grazing rate of uninfected first int hosts

# handling time
### for saturation rates for preds and grazers
### in denominator so larger means slower?
h_F <- 5
h_D <- 5

# attack rate
## these will need to vary later but for now they are all equal (system with no behavioral manipulation)
alpha_DUSU <- 3   # predation of uninfected definitive hosts on uninfected second int hosts
alpha_DUSI <- 8   # predation of uninfected definitive hosts on infected second int hosts
alpha_DISU <- 3   # predation of infected definitive hosts on uninfected second int hosts
alpha_DISI <- 8   # predation of infected definitive hosts on infected second int hosts

# infection rate
## equates to c_HIP and c_HUP (consumption of parasite propagules) in long et al and is held equal
beta_U <- 1   # infection rate of uninfected first int hosts
beta_I <- 1   # infection rate of already infected first int hosts (dead end) 

# contact rate
## I made this up so I'm going to have to figure it out
## actually it's technically the R0 I think?! Just for a different species of host.. but does it matter
c <- 20    # we'll just set it really high for now

# conversion rate
# preds have higher i guess 
# i'm not sure if this is how conversion rates work, I might need to tweak these
e_FU <- 1   # conversion of algae by uninfecteds into uninfected first int host tissue
e_FI <- 0.1  # conversion of algae by infecteds into uninfected first int host tissue (should be zero or close to it)
e_DU <- 3   # conversion of 2I hosts by uninfecteds into determinate host tissue
e_DI <- 3   # conversion of 2I hosts by infecteds into determinate host tissue
e_C <- 9    # conversion of infected 1I hosts to cercariae (it's very high)

# reproduction rate
## I guess we will make these equal for now?
r_P <- 5 # reproduction of parasites (note: if we want to include pathogenicity other than death, could we subtract r from the IDH pop equation?)
r_SU <- 10 # reproduction of new uninfected second intermediate hosts
r_SI <- 10 # reproduction of new uninfecteds by INFECTED second intermediate hosts

# goals: three levels of kelp input crossed with three levels of 2IH susceptibility to predation