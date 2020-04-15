setwd('/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong')
library(data.table)
haploid <- read.csv("/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/haploid.csv", header=TRUE)


haploid$P1 <- as.factor(haploid$P1)
haploid$P2 <- as.factor(haploid$P2)
haploid$env <- as.factor(haploid$env)

haploid$hap_PH <- as.numeric(as.character((haploid$hap_PH)))

A_hap <- matrix(0,nrow = nrow(haploid),ncol = nrow(haploid))

ncom = 0


for(i in 1:nrow(haploid)){
  
  for (j in 1:nrow(haploid)) {
    
    if(i==j){
      A_hap[i,j] <-1
    }else{
      
      ncom = (haploid[i,1]==haploid[j,1])+(haploid[i,1]==haploid[j,2])+(haploid[i,2]==haploid[j,1])+(haploid[i,2]==haploid[j,2])
      if(ncom == 1){
        A_hap[i,j]=0.25
        
      }else if(ncom==2){
        
        A_hap[i,j]=0.5
        
      }else if(ncom==0){
        
        A_hap[i,j]=0.0
        
      }
      
    }
    
    
  }
  
  
  
  
  #idxnsnps_i <- (e2m.sig[[i]]$coef != 0)
  #snpsnames_i <- Znames[idxnsnps_i]
  #med_snps <- data.frame(medi=rep(mednames[i], length(snpsnames_i)), snps_for_medi=snpsnames_i)
  #output <- rbind(output, med_snps)
}
#
fwrite(as.data.frame(A_hap), "/common/jyanglab/zhikaiyang/projects/agro932_hm1/largedata/jinlong/A_hap.csv", sep=",", row.names=FALSE, col.names = FALSE, quote=FALSE)

