setwd('/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong')
library(data.table)
haploid <- read.csv("/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/haploid.csv", header=TRUE)


haploid$P1 <- as.factor(haploid$P1)
haploid$P2 <- as.factor(haploid$P2)
haploid$env <- as.factor(haploid$env)

haploid$hap_PH <- as.numeric(as.character((haploid$hap_PH)))
haploid$AES <- as.numeric(as.character((haploid$AES)))
haploid$hap_DTS <- as.numeric(as.character((haploid$hap_DTS)))
haploid$hap_EH <- as.numeric(as.character((haploid$hap_EH)))
haploid$hap_KRN <- as.numeric(as.character((haploid$hap_KRN)))
haploid$hap_KN <- as.numeric(as.character((haploid$hap_KN)))

A_hap <- matrix(0,nrow = nrow(haploid),ncol = nrow(haploid))


A_hap<- fread("/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/A_hap.csv", header = FALSE, data.table=FALSE)
A_hap <- as.matrix(A_hap)

X_hap <- matrix(0,nrow = nrow(haploid), ncol = length(unique(haploid$env)))
for (i in 1:nrow(haploid)){
  if (haploid$env[i] == unique(haploid$env)[1] ){
    X_hap[i,1]=1
  }else if(haploid$env[i] == unique(haploid$env)[2]){
    X_hap[i,2]=1
  }
}


library(rrBLUP)

###PLANT HEIGHT

ans <- mixed.solve(y=haploid$hap_PH, K=A_hap, X=X_hap)

print("hap_PH")
str(ans)
#List of 5
#$ Vu  : num 488
#$ Ve  : num 1134
#$ beta: num [1:2(1d)] 102 116
#$ u   : num [1:5144(1d)] 42.1 32.4 41.9 35.6 36.8 ...
#$ LL  : num -24593

fwrite(as.data.frame(ans$u), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/ans_u.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

env <- c(rep(ans$beta[1],2232), rep(ans$beta[2], 2912))
b_hap <- as.vector(ans$u) + env
fwrite(as.data.frame(b_hap), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/b_hap.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

#Heritablity: 488/1628.944 (var(haploid$hap_PH, na.rm = TRUE))  = 0.2995806


###AES
ans_aes <- mixed.solve(y=haploid$AES, K=A_hap, X=X_hap)

fwrite(as.data.frame(ans_aes$u), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/ans_aes_u.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

str(ans_aes)

#List of 5
#$ Vu  : num 0.329
#$ Ve  : num 1.57
#$ beta: num [1:2(1d)] 0.891 0.69
#$ u   : num [1:5144(1d)] 0.0339 -0.0607 -0.0607 -0.1553 -0.1553 ...
#$ LL  : num -8687


env_aes <- c(rep(ans_aes$beta[1], 2232),rep(ans_aes$beta[2],2912))

b_hap_aes <- as.vector(ans_aes$u) + env_aes
fwrite(as.data.frame(b_hap_aes), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/b_hap_aes.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

#Heritablity: 0.329/2.401718  = 0.1369853


###hap_DTS
ans_dts <- mixed.solve(y=haploid$hap_DTS, K=A_hap, X=X_hap)

fwrite(as.data.frame(ans_dts$u), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/ans_dts_u.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

print("hap_DTS")

str(ans_dts)

#List of 5
#$ Vu  : num 18.3
#$ Ve  : num 277
#$ beta: num [1:2(1d)] 51.9 63.8
#$ u   : num [1:5144(1d)] 4.08 4.3 4.21 3.95 4.11 ...
#$ LL  : num -21762


env_dts <- c(rep(ans_dts$beta[1], 2232),rep(ans_dts$beta[2],2912))

b_hap_dts <- as.vector(ans_dts$u) + env_dts
fwrite(as.data.frame(b_hap_dts), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/b_hap_dts.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

#Heritablity: 18.3/330.2163  = 0.05541822


###hap_EH
ans_eh <- mixed.solve(y=haploid$hap_EH, K=A_hap, X=X_hap)

fwrite(as.data.frame(ans_eh$u), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/ans_eh_u.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

print("hap_EH")

str(ans_eh)

#List of 5
#$ Vu  : num 83.8
#$ Ve  : num 125
#$ beta: num [1:2(1d)] 28.9 36.2
#$ u   : num [1:5144(1d)] 18.4 18.9 18.7 18.4 20.9 ...
#$ LL  : num -18998



env_eh <- c(rep(ans_eh$beta[1], 2232),rep(ans_eh$beta[2],2912))

b_hap_eh <- as.vector(ans_eh$u) + env_eh
fwrite(as.data.frame(b_hap_eh), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/b_hap_eh.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

#Heritablity: 83.8/220.5628  = 0.3799371


###hap_KRN
ans_krn <- mixed.solve(y=haploid$hap_KRN, K=A_hap, X=X_hap)

fwrite(as.data.frame(ans_krn$u), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/ans_krn_u.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

print("hap_KRN")

str(ans_krn)

#List of 5
#$ Vu  : num 1.48
#$ Ve  : num 22.4
#$ beta: num [1:2(1d)] 10.8 9.82
#$ u   : num [1:5144(1d)] 0.704 0.511 0.576 0.64 0.64 ...
#$ LL  : num -14140


env_krn <- c(rep(ans_krn$beta[1], 2232),rep(ans_krn$beta[2],2912))

b_hap_krn <- as.vector(ans_krn$u) + env_krn
fwrite(as.data.frame(b_hap_krn), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/b_hap_krn.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

#Heritablity: 1.48/23.99279  = 0.0616852



###hap_KN
ans_kn <- mixed.solve(y=haploid$hap_KN, K=A_hap, X=X_hap)

fwrite(as.data.frame(ans_kn$u), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/ans_kn_u.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

print("hap_KN")

str(ans_kn)

#List of 5
#$ Vu  : num 14.7
#$ Ve  : num 43
#$ beta: num [1:2(1d)] 23.3 23.8
#$ u   : num [1:5144(1d)] 6.89 6.89 5.29 6.46 4.71 ...
#$ LL  : num -13706


env_kn <- c(rep(ans_kn$beta[1], 2232),rep(ans_kn$beta[2],2912))

b_hap_kn <- as.vector(ans_kn$u) + env_kn
fwrite(as.data.frame(b_hap_kn), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/b_hap_kn.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

#Heritablity: 18.3/56.22997  = 0.3254492

