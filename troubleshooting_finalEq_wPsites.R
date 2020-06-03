################################################################################################################################################ troubleshooting model with kevins edits ##################################################################################################################################################
# trying to get it to work without parasites in the system first
# currently either the DH predator crashes or the 2IH prey crashes, depending on parameters
# SHOULD see predator limiting prey pop nicely with type II functional response (no cycles)


# do i need to incorporate the full handling time in denomenator with populations of all prey items (in denom) for the consumption part of the prey equation, while only having the prey population in the numerator???
### OH MY GOD I THINK I FIXED IT
#### nope just kidding, preds still shoot to infinity
# FINALLY GOT IT TO WORK, had to get rid of carrying capacity for 2IH fish, but add a mortality rate for them, and reparameterize alt prey (v) for DHs

source("WORKING_paramvals.R") # continually edited as chunks of the model are added


source("build_statevars0.R")

tset <- seq(from=0, to=1000, length.out = 5000) # definitely going to have to tweak time scale later

# color for algae
Acol <- "green"
# color for 1IH snails
Fcol <- "orange"
# color for 2IH fish
Scol <- "purple"
# color for DH birbs
Dcol <- "blue"
# color for parasite eggs
Pcol <- "red"


# set up empty vectors and initial values
A.simu <- NaN*tset; A.simu[1] <- 1
FI.simu <- NaN*tset; FI.simu[1] <- 0 # parasites off
FU.simu <- NaN*tset; FU.simu[1] <- 1
C.simu <- NaN*tset; C.simu[1] <- 0
SI.simu <- NaN*tset; SI.simu[1] <- 0 # parasites off
SU.simu <- NaN*tset; SU.simu[1] <- 1
DI.simu <- NaN*tset; DI.simu[1] <- 0 # parasites off
DU.simu <- NaN*tset; DU.simu[1] <- 1
P.simu <- NaN*tset; P.simu[1] <- 1 # toggle on and off to see system without parasites

# for loop
for(i in 2:length(tset)){
  dt <- tset[i]-tset[i-1]
  A <- A.simu[i-1]    # maybe subsume later
  F_U <- FU.simu[i-1]
  F_I <- FI.simu[i-1]
  C <- C.simu[i-1]    # maybe subsume later
  S_U <- SU.simu[i-1]
  S_I <- SI.simu[i-1]
  D_U <- DU.simu[i-1]
  D_I <- DI.simu[i-1]
  P <- P.simu[i-1]
  
  # algae
  dA <- (inp - A*d_A                    # input - death
         - gamma_I*F_I*(A/(h_F +A))     # - grazing rate x handling time infected
         - gamma_U*F_U*(A/(h_F +A)))*dt # - grazing rate x handling time uninfected
  # uninfected 1IH
  dF_U <- (F_U*(gamma_U*e_FU*(A/(h_F +A)))  # grazing * conversion efficiency * algae pop/handling time (decreases with prey density) - REMOVED: death (-d_FU)
           - (P*beta_I*F_U)                   # parasites * infection * uninfected pop
           + F_I*(gamma_I*e_FI*(A/(h_F + A))) # births from infecteds
           - (m_FU * F_U)^2)*dt               # density dependent mortality
  
  # infected 1IH
  dF_I <- ((P*beta_I*F_U) 
           #- (d_FI*F_I)                      # REMOVED BACKGROUND MORTALITY, too much death
           - (m_FI * F_I)^2)*dt               # density dependent mortality
  # cercariae
  # dC/dt = Fi g e A/(h+A) - m C - C (Si + Su)c
  dC <- (F_I * gamma_I * e_C * (A/(h_F + A))                         # new cercariae made of algae via snails
         - (d_C * C)                                                 # death of cercariae                       
         - C* (S_I + S_U)*c)*dt                                      # uptake of cercariae into 2IH at a rate c
  
  
  # uninfected 2IH
  dS_U <- (
    (r_SU*S_U)                              
    -((D_U) * (gamma_D * ((S_U)/(h_D + (v + S_U + alpha* S_I)))))       # added in all prey items to denom
    -(D_I * gamma_D * ((S_U)/(h_D + (v + S_U + alpha* S_I))))            # un-simplified equation, multiplied it out
    + (r_SI * S_I)                   # births from infecteds, off right now
    - (F_I * S_U * c)                # loss due to movement to infected class, also off right now
    - S_U * m_S
  )* dt                              
  
  
  
  # infected 2IH ## should be zero right now
  dS_I <- ((C * S_U * c)                                                               # infection
           - ((D_U + D_I) * (gamma_D * ((alpha* S_I)/(h_D + (v + S_U + alpha* S_I))))) # type II consumption by uninfected+infected predators 
           - S_I * m_S
           )*dt  
  
  
  
  
  # uninfected DH
  dD_U <- ((D_U + D_I) * (gamma_D * e_DU * ((v + S_U + alpha* S_I)/(h_D + (v + S_U + alpha * S_I)))) # births due to consumption of infected and uninfected prey, type II functional response
           - (D_U * d_DU)                                                                 # minus deaths
           - D_U*((gamma_D*alpha*S_I)/(h_D + (v+S_U + alpha * S_I))) # minus movement to infected class
  )*dt                               
  
  
  
  # infected DH ## should be zero right now
  dD_I <- ((D_U *((gamma_D * alpha * S_I)/(h_D + (v + S_U + alpha * S_I)))) # new infections from eating infected 2IH
           - (D_I*d_DI)                                                     # minus death
  )* dt                                         
  
  # parasite eggs
  dP <- ((r_P * D_I) - P * (d_P + beta_I * F_I + beta_U * F_U)) * dt
  
  A.simu[i] <- A + dA
  FU.simu[i] <- F_U + dF_U
  FI.simu[i] <- F_I + dF_I
  C.simu[i] <- C + dC
  SU.simu[i] <- S_U + dS_U
  SI.simu[i] <- S_I + dS_I
  DU.simu[i] <- D_U + dD_U
  DI.simu[i] <- D_I + dD_I
  P.simu[i] <- P + dP
  
}

# plot
# parasites are off so parasite/infected time series are commented out
# legend gets in the way so its commented out

#png("withparasites.png")
plot(tset, A.simu,type='l',las=1,lwd=2,ylab='Population Size',xlab='Time', col=Acol,ylim=c(0,100), xlim = c(0, 1000))
lines(tset, FU.simu, type = 'l', las = 1, lwd = 2, col = Fcol)
lines(tset, FI.simu, type = 'l', las = 1, lty = 3, col = Fcol)
lines(tset, SU.simu, type = 'l', las = 1, lwd = 2, col = Scol)
lines(tset, SI.simu, type = 'l', las = 1, lty = 3, col = Scol)
lines(tset, DU.simu, type = 'l', las = 1, lwd = 2, col = Dcol)
abline(h = 0)
lines(tset, DI.simu, type = 'l', las = 1, lty = 3, col = Dcol)
lines(tset, P.simu, type = 'l', las = 1, lwd = 2, col = Pcol)
lines(tset, C.simu, type = 'l', las = 1, lty = 2, col = "black")
#legend("topright",legend=c('Algae', '1st Intermediate Host','2nd Intermediate Host','Definitive Host', 'Parasite Eggs', 'Cercariae'),lwd=2,col=c(Acol, Fcol,Scol,Dcol,Pcol,"black"))
#dev.off()

