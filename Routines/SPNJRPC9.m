SPNJRPC9 ;BP/JAS - Returns ICD9 Codes based on search criteria ;JUN 16, 2009
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; NO LONGER USED - ACCESS TO FILE NOT NEEDED: [References to ^ICD9 supported by IA #10082]
 ; References to ^DPT(D0,0 supported by IA #998 and #10035
 ; Reference to ^DPT(D0,"MPI" supported by IA #4938
 ; References to ^DGPT supported by IA #4945
 ; References to file #45 supported by IA #92
 ; Reference to API DEM^VADPT supported by IA #10061
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     RETURN is the sorted data from the earliest date of listing
 ;     ICNLST is the list of patient ICNs to process
 ;     FDATE  is the Admission starting date
 ;     TDATE  is the Admission ending date
 ;     PATTYP is (0) Pats in Reg only (1) All Pats
 ;     SPNANS is (0) Range of Codes (1) Individual codes
 ;     CODES  is the list or range of codes
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST,FDATE,TDATE,PATTYP,SPNANS,CODES) ;
 ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 S X=FDATE S %DT="T" D ^%DT S SPNSTRT=Y
 S X=TDATE S %DT="T" D ^%DT S SPNEND=Y_.2359
 ;***************************
 K ^TMP($J),^TMP("SPN",$J),SPNARY
 S SPNIN=$S(PATTYP=0:"JUST",1:"ALL")
 Q:SPNANS'=1
 S IDA="" F  S IDA=$O(CODES(IDA)) Q:IDA=""  D
 . S ICD=CODES(IDA)
 . I ICD?1E.E1" " S ICD=$E(ICD,1,($L(ICD)-1))
 . ;JAS 6/16/09 - DEFECT 1137 - Removed direct reads of CPT/ICD files - Not needed
 . ;S ICDA=$O(^ICD9("AB",ICD,0))
 . ;S SPNARY(ICD)=ICDA_"^"_ICD
 . S SPNARY(ICD)=""
 . Q
 ;JAS 05/01/08 DEFECT 1015 - REWROTE FOLLOWING SECTIONS & ELIMINATED 
 ;                         UNNECESSARY CODE TO CORRECT FOR ALL PATS
 D GATHER,EN
 D CLNUP
 Q
GATHER ;Start looping through the af xfr of the PTF file
 K ^TMP("SPN",$J)
 S SPNADDT=SPNSTRT
 F  S SPNADDT=$O(^DGPT("AF",SPNADDT)) Q:(SPNADDT="")!('+SPNADDT)  Q:SPNADDT>SPNEND  D
 . S SPNPTF="",SPNPTF=$O(^DGPT("AF",SPNADDT,SPNPTF)) Q:SPNPTF=""
 . D TESTPT
 . Q
 Q
TESTPT ;test pt in 154 then icds
 S SPNDFN=$P($G(^DGPT(SPNPTF,0)),U,1)
 S SPNICD=$P($G(^DPT(SPNDFN,"MPI")),U,1)
 I SPNIN="JUST" S FND=0 D
 . S ICNT="" F  S ICNT=$O(ICNLST(ICNT)) Q:ICNT=""  D  Q:FND
 . . I ICNLST(ICNT)=SPNICD S FND=1 Q
 . Q
 I SPNIN="JUST",'FND Q
 ;spnans=1 range spnasn=2 just the ones entered
 S SPNY=0 F A=79,79.16,79.17,79.18,79.19,79.201,79.21,79.22,79.23,79.24 S SPNY=$$GET1^DIQ(45,SPNPTF_",",A) I +SPNY D
 . I SPNANS=0 I (SPNY]SPNRAN1) I (SPNY']SPNRAN2) S ^TMP("SPN",$J,SPNDFN,SPNPTF)=""
 . I SPNANS=1 I $D(SPNARY(SPNY)) S ^TMP("SPN",$J,SPNDFN,SPNPTF)=""
 . Q
 Q
EN ;
 S Y=SPNSTRT X ^DD("DD") S SPNSTRT=Y,Y=SPNEND X ^DD("DD") S SPNEND=Y K Y
 I $D(^TMP("SPN",$J))=0 Q
 S ^TMP($J,RETCNT)="HDR999^Patient^SSN^Registration Status^Admission Date^EOL999"
 S RETCNT=RETCNT+1
 S SPNDFN=0 F  S SPNDFN=$O(^TMP("SPN",$J,SPNDFN)) Q:(SPNDFN=0)!('+SPNDFN)  D EN2
 Q
EN2 S SPNREG=""
 S SPNICD=$P($G(^DPT(SPNDFN,"MPI")),U,1)
 I SPNICD="" S SPNREG="**NOT IN SCIDO**"
 I SPNICD'="",'$D(ICNLST(SPNICD)) S SPNREG="**NOT IN SCIDO**"
 S SPNAM=$P(^DPT(SPNDFN,0),U,1),SPNSSN=$P(^DPT(SPNDFN,0),U,9)
 S SPNPTF=0 F  S SPNPTF=$O(^TMP("SPN",$J,SPNDFN,SPNPTF)) Q:(SPNPTF=0)!('+SPNPTF)  D EN3
 Q
EN3 ;
 S SPNADDT=$$GET1^DIQ(45,SPNPTF_",",2)
 S ^TMP($J,RETCNT)="PAT1^"_SPNAM_"^"_SPNSSN_"^"_SPNREG_"^"_SPNADDT_"^EOL999"
 S RETCNT=RETCNT+1
 S DXLS=$$GET1^DIQ(45,SPNPTF_",",79)
 S ICD2=$$GET1^DIQ(45,SPNPTF_",",79.16)
 S ICD3=$$GET1^DIQ(45,SPNPTF_",",79.17)
 S ICD4=$$GET1^DIQ(45,SPNPTF_",",79.18)
 S ICD5=$$GET1^DIQ(45,SPNPTF_",",79.19)
 S ^TMP($J,RETCNT)="ICD1^"_DXLS_"^"_ICD2_"^"_ICD3_"^"_ICD4_"^"_ICD5_"^EOL999"
 S RETCNT=RETCNT+1
 S ICD6=$$GET1^DIQ(45,SPNPTF_",",79.201)
 S ICD7=$$GET1^DIQ(45,SPNPTF_",",79.21)
 S ICD8=$$GET1^DIQ(45,SPNPTF_",",79.22)
 S ICD9=$$GET1^DIQ(45,SPNPTF_",",79.23)
 S ICD10=$$GET1^DIQ(45,SPNPTF_",",79.24)
 S ^TMP($J,RETCNT)="ICD2^"_ICD6_"^"_ICD7_"^"_ICD8_"^"_ICD9_"^"_ICD10_"^EOL999"
 S RETCNT=RETCNT+1
 Q
CLNUP ;
 K %DT,A,AICN,DFN,DXLS,I,ICD,ICD10,ICD2,ICD3,ICD4,ICD5,ICD6,ICD7
 K ICD8,ICD9,ICDA,ICN,ICNNM,IDA,PATARY,PATLIST,RETCNT,SPN,SPNADDT
 K SPNAM,SPNDFN,SPNEND,SPNICD,SPNIN,SPNPTF,SPNRAN1,SPNRAN2
 K SPNREG,SPNSSN,SPNSTRT,SPNY,X,ICNT,FND
 Q
