# ProteinDomainAssignment

Method </br>
The objective of the fragment annotation script is to use protein domain databases such as Pfam to annotate query fragment and use sequence similarity as a way to reflect the confidence in such annotation prediction as follows: First, Pfam database [1 and 2] is used to identify protein domains in the protein of interest that contains the query fragment to be annotated. Next, the Longest Common Substring (LCS) between the query fragment and protein domains is identified using dynamic programming methods (R package PTXQC) [3]. Following this, protein domain with maximum percentage of similarity (ratio between length of LCS to length of query fragment) is identified. Finally, after identifying protein domain with maximum sequence similarity to query fragment, the annotation associated with the matching domain is extracted from Pfam, Clan, Uniprot, respectively. In addition, the domain Evalue is extracted from Pfam as well as fragment enrichment significance score is computed as ratio of number of domains that containing LCS to the total number of domains in the database.</br>


For script execution follow the following steps:</br>
Step1: </br>
Download the protein domain annotation data (PDPfam.txt) using (http://dunbrack2.fccc.edu/ProtCiD/PDBfam/Download.aspx).</br>

Step2:</br> 
Open R terminal and install the following pre-request R packages:</br>
       library("PTXQC")</br>
       library("parallel")</br>
       
Step3: </br>
      For serial execution of the script use AnnotDemo_Serial.R </br>
      For parallel execution use AnnotDemo_Parallel.R </br>
      
Step4:</br>
creat a file named "InputData.csv" which contains the protein fragment data that need to be annotated, following the format of the attached "InputData.csv" example file</br>

Step5: </br>
As a result of successful script execution, you should find a new .csv file with the name "Results_Annotated.csv" which will contain extra columns for the domain annotation as well as maximum similairty percentile which can indicate the confidnence in the predicted domain annotation.</br>

    
For any technical questions, please email: mario.abdelmessih-at-pfizer.com </br>


References: </br>
1-	http://pfam.xfam.org</br>
2-	Q. Xu and R. Dunbrack, “Assignment of protein sequences to existing domain and family classification systems: Pfam and the PDB.” Bioinformatics Vol. 28 no. 21, pages 2763–2772 (2012).</br>
3-	https://cran.rstudio.com/web/packages/PTXQC/index.html </br>

