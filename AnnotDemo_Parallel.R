

library("PTXQC")
library("parallel")

DomainDB=read.csv("PDBfam.txt",header=T,sep="\t",stringsAsFactors=F)


TargetFile="InputData.csv"
QuerySeq=read.csv(TargetFile,sep=",",header=T,stringsAsFactors=F)

myDB=DomainDB$SeqAlignment

Results=matrix("NA",length(QuerySeq$Sequence),11)
colnames(Results)=c("Sequence","MaxSimilarity","Pfam_Acc","Pfam_ID","Description","Clan_Acc","Clan_ID","UniprotCode","UniprotID","Domain Evalue","Fragment Enrichment Significance")

for(i in 1:length(QuerySeq$Sequence)){
  Query=QuerySeq$Sequence[i]
  no_cores <- 4
  cl <- makeCluster(no_cores,type="FORK")
  ProteinInd=grep(unlist(strsplit(QuerySeq$Master.Protein.Accessions[i],"-"))[1],DomainDB$UniprotCode)
  if(length(ProteinInd)==0){next}
  ProteinMatchedSeq=gsub("-","",myDB[ProteinInd])
  MatchedPercent=parSapply(cl,ProteinMatchedSeq,function(x) nchar(LCS(Query,x))/nchar(Query))
  stopCluster(cl)
  BestMatchInd=ProteinInd[as.numeric(which.max(MatchedPercent))]
  MatchedFrag=LCS(Query,gsub("-","",DomainDB$SeqAlignment[BestMatchInd]))
  EnrichScore=length(grep(MatchedFrag,gsub("-","",DomainDB$SeqAlignment)))/length(DomainDB$SeqAlignment)
  Results[i,]=c(Query,max(MatchedPercent),DomainDB$Pfam_Acc[BestMatchInd],
                DomainDB$Pfam_ID[BestMatchInd],DomainDB$Description[BestMatchInd],
                DomainDB$Clan_Acc[BestMatchInd],DomainDB$Clan_ID[BestMatchInd],
                DomainDB$UniprotCode[BestMatchInd],DomainDB$UniprotID[BestMatchInd],
                DomainDB$Evalue[BestMatchInd],EnrichScore)
  print(i)
}
AllData=cbind(QuerySeq,Results)
write.csv(AllData,file="Results_Annotated.csv",row.names=F,quote=F)
