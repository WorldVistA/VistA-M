SPNJRPIL ;BP/JAS - Returns ICNs for list of DFNs ;JAN 18, 2006
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to ^DPT supported by IA# 4938
 ;
 ; Parm values:
 ;     RETURN  is the returned ICN value to go with the patient's DFN
 ;     DFNLST  is DFN of the patient to process
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,DFNLST) ;
 ;
 ;***************************
 K ^TMP($J),^TMP("SPN",$J)
 S RETURN=$NA(^TMP($J)),RETCNT=1
 ;***************************
 F DFNNM=1:1:$L(DFNLST,"^") S DFN=$P(DFNLST,"^",DFNNM) D GET
 K DFN,DFNNM,ICN,RETCNT
 Q
GET ;
 I '$D(^DPT(DFN)) D  Q
 . S ^TMP($J,RETCNT)="DFN NOT FOUND^"_DFN_"^EOL999"
 . S RETCNT=RETCNT+1
 I '$D(^DPT(DFN,"MPI")) D  Q
 . S ^TMP($J,RETCNT)="NO LOCAL ICN FOUND^"_DFN_"^EOL999"
 . S RETCNT=RETCNT+1
 S ICN=$P(^DPT(DFN,"MPI"),"^",1)
 S ^TMP($J,RETCNT)=ICN_"^"_DFN_"^EOL999"
 S RETCNT=RETCNT+1
 Q
