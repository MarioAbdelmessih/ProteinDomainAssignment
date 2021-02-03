

library("PTXQC")

DomainDB=read.csv("PDBfam.txt",header=T,sep="\t")

TargetFile="InputData.csv"
QuerySeq=read.csv(TargetFile,sep=",",header=T)

cutoff=0.7
myDB=as.character(DomainDB$SeqAlignment)

Results=matrix("NA",length(QuerySeq$Sequence),9)
colnames(Results)=c("Sequence","MaxSimilarity","Pfam_Acc","Pfam_ID","Description","Clan_Acc","Clan_ID","UniprotCode","UniprotID")

for(i in 1:length(QuerySeq$Sequence)){
  Query=as.character(QuerySeq$Sequence[i])
  ProteinInd=grep(unlist(strsplit(as.character(QuerySeq$Master.Protein.Accessions[i]),"-"))[1],DomainDB$UniprotCode)
  if(length(ProteinInd)==0){next}
  ProteinMatchedSeq=myDB[ProteinInd]
  MatchedPercent=sapply(ProteinMatchedSeq,function(x) nchar(LCS(Query,x))/nchar(Query))
  BestMatchInd=ProteinInd[as.numeric(which.max(MatchedPercent))]
  Results[i,]=c(Query,as.character(max(MatchedPercent)),as.character(DomainDB$Pfam_Acc[BestMatchInd]),as.character(DomainDB$Pfam_ID[BestMatchInd]),as.character(DomainDB$Description[BestMatchInd]),
  as.character(DomainDB$Clan_Acc[BestMatchInd]),as.character(DomainDB$Clan_ID[BestMatchInd]),
  as.character(DomainDB$UniprotCode[BestMatchInd]),as.character(DomainDB$UniprotID[BestMatchInd]))

  gc()
  print(i)
}

AllData=cbind(QuerySeq,Results)
write.csv(AllData,file="Results_Annotated.csv",row.names=F,quote=F)
