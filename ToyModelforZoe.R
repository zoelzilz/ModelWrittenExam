r <- 0.1
a <- 0.01
b <- 0.1
h <- 0.005
m <- 0.1

tset <- seq(from = 0, to = 5000, by = 0.005)
Nset <- NaN*tset; Nset[1] <- m/(b*a-m*a*h) *.95
Pset <- Nset; Pset[1] <- r*Nset[1]/a/Nset[1]*(1+a*h*Nset[1])


for(i in 2:length(tset)){
	dt <- tset[i]-tset[i-1]
	N <- Nset[i-1]
	P <- Pset[i-1]
	
	dN <- dt *( r*N - a*N/(1+a*h*N)*P )
	dP <- dt *( b*a*N/(1+a*h*N)*P - m*P )
	
	Nset[i] <- N + dN
	Pset[i] <- P + dP
	
}

plot(tset,Nset,type='l',ylim=c(0,1.1*max(Nset[1],Pset[1])))
lines(tset,Pset,col='red')