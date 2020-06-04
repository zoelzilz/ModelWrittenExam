####### REORGANIZED SO PARAMETER VALUES ARE ORGANIZED BY EQUATION ########

##################  ALGAE ################## 
inp <- 10  #5  #10  #15                     # input of algae
d_A <- 0.1                                  # death of algae
#####################################################################################################################################


##################  FIRST INTERMEDIATE HOSTS ################## 
## UNINFECTED
m_FU <- 0.1                                 # density dependent mortality of uninfected first int hosts
#d_FU <- 0.05                               # death of uninfected first int hosts
gamma_U <- 0.5                              # grazing rate of uninfected first int hosts
h_F <- 2                                    # handling time for first int hosts (grazing time for snails... good around 2 with a gamma of 0.5 and conversion rate of 0.5, algal input of 10)
beta_U <- 0.1                               # infection rate of uninfected first int hosts
e_FU <- 0.7                                 # conversion of algae by uninfecteds into uninfected first int host tissue

## INFECTED
m_FI <- 0.1                                 # density dependent mortality of infected first int hosts
#d_FI <- 0.05                               # death of infected first int hosts
gamma_I <- 0.5                              # grazing rate of infected first int hosts
beta_I <- 0.1                               # infection rate of already infected first int hosts (dead end) 
e_FI <- 0.7                                 # conversion of algae by infecteds into uninfected first int host tissue (should be zero or close to it)
#####################################################################################################################################  

##################  CERCARIAE ################## 
d_C <- 0.1                                  # death of cercariae
e_C <- 0.9                                  # conversion of infected 1I hosts to cercariae (it's very high)
#####################################################################################################################################  

################## SECOND INTERMEDIATE HOSTS ################## 
c <- 0.9  #0.5                             # contact rate, we'll just set it really high for now
## UNINFECTED
m_SU <- 0.05                                # background mortality rate of uninfected fish second int hosts
r_SU <- 0.7 #0.5                            # reproduction of new uninfected second intermediate hosts # 1 is too high

## INFECTED
m_SI <- 0.05                                # background mortality rate of infected fish second int hosts
alpha <- 1                                  # multiplier for infected prey consumption rate
r_SI <- 0.5                                 # reproduction of new uninfecteds by INFECTED second intermediate hosts
#####################################################################################################################################  

################## DEFINITIVE HOSTS ################## 
h_D <- 2                                    # handling time
gamma_D <- 0.5                              # general attack rate
v <- 0                                      # alternate prey abundance #v <- 0

## UNINFECTED
d_DU <- 0.2                                 # death of uninfected definitive hosts 
e_DU <- 0.7                                 # conversion of 2I hosts by uninfecteds into determinate host tissue

## INFECTED
d_DI <- 0.1                                 # death of infected definitive hosts
e_DI <- 0.7                                 # conversion of 2I hosts by infecteds into determinate host tissue
#####################################################################################################################################  

##################  PARASITE EGGS ################## 
d_P <- 0.1                                  # death of parasites
r_P <- 1                                    # reproduction of parasites 
##################################################################################################################################### 

# NOTES #
# goals: three levels of kelp input crossed with three levels of 2IH susceptibility to predation