PSNPPIO ;BIR/JLC - return PMI in TMP ; 21 Apr 2004  9:32 AM
 ;;4.0; NATIONAL DRUG FILE;**68,84**; 30 Oct 98
 ;
 ; Reference to ^PS(59.7 supported by IA #2613
 ; Reference to ^PSDRUG supported by IA #221
 ; Reference to ^PS(55 supported by IA #2191
 ;
EN(PSNDRUG,PSNMSG) ;
 ;
 ; entry point from Outpatient Pharmacy Labels
 ; Calling method: S PSNFLAG=$$EN^PSNPPIO(PSNDRUG)
 ;
 ; Input: PSNDRUG = IFN from the DRUG file (50)  ** REQUIRED **
 ;
 ; Output: PSNFLAG = 0 if no PMI returned
 ;                   1 if PMI returned in ^TMP($J,"PSNPMI"
 ;         MSG = message text for no PMI information
 ;
 N PSNFLAG,PSNPN,PSNGCN,A1,A2,PSNFILE1,PSNFILE2,PSNEMAP,PMID,PSNPL,I
 K ^TMP($J,"PSNPMI")
 S PSNFLAG=1,PSNPN=$P($G(^PSDRUG(PSNDRUG,"ND")),"^",3)
 I 'PSNPN S PSNMSG="This drug is not matched to the National Drug File; therefore, a Medication Information Sheet cannot be printed." Q 0
 S PSNGCN=$P($G(^PSNDF(50.68,PSNPN,1)),"^",5)
 I 'PSNGCN S PSNMSG="This drug is not linked to a Medication Information Sheet." Q 0
 S A1=$G(^PS(59.7,1,10)),A2=$$GET1^DIQ(55,$G(DFN)_",",106.1,"I"),PSNPL=$P(A1,"^",7),PSNFILE1=$S(A2=2:50.624,PSNPL=2:50.624,1:50.623),PSNFILE2=PSNFILE1-.002
 S PSNEMAP=$O(^PS(PSNFILE1,"B",PSNGCN,0)) I 'PSNEMAP S PSNMSG="This drug is not linked to a Medication Information Sheet." Q 0
 S PSNGCN=+$P($G(^PS(PSNFILE1,PSNEMAP,0)),"^",2) I '$D(^PS(PSNFILE2,PSNGCN)) S PSNMSG="This drug is not linked to a Medication Information Sheet." Q 0
 M ^TMP($J,"PSNPMI")=^PS(PSNFILE2,PSNGCN)
 S PMID=$P(A1,"^",8) F I=1:1:$L(PMID,",") K ^TMP($J,"PSNPMI",$P(PMID,",",I))
 Q 1
