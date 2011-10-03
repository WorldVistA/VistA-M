SPNJRPIP ;BP/JAS - Returns list of ICNs for Inpatients ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DGPT("B" & file 45 supported by IA# 92
 ; Reference to ^DGPT(D0,0 supported by IA# 4945
 ; Reference to ^DPT(D0,"MPI" supported by IA# 4938
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     RETURN is the list of ICNs who meet criteria
 ;     FDATE is the start date for period
 ;     TDATE is the end date for period
 ;     ICNLST is the group of ICNs to search from
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,FDATE,TDATE,ICNLST) ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 S X=FDATE S %DT="T" D ^%DT S FDATE=Y
 S X=TDATE S %DT="T" D ^%DT S TDATE=Y
 ;***************************
 K ^TMP($J),^TMP("SPN",$J)
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D REC
 D OUT
 K %DT,DFN,ICN,RETCNT,Y,ICNNM
 Q
REC ;
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 N RECNR,NODE0,NODE70,ZDD,ZAD,BS,ADMDAYS,NUMADMS,BSNR,X,X1,X2
 I '$D(TDATE) S TDATE=DT
 ; We will take all admissions which overlap the desired range, and adjust
 ; the admit and/or discharge dates to conform with the desired range.
 S (ADMDAYS,NUMADMS,RECNR)=0 ; for each inpatient record
 F  S RECNR=$O(^DGPT("B",DFN,RECNR)) Q:NUMADMS!(RECNR="")  D
 . Q:$$GET1^DIQ(45,RECNR_",",11,"I")'=1  ; 1=PTF record, 2=census record
 . ;wde/line added below to block fee basis records in the count 2/18/99
 . I $$GET1^DIQ(45,RECNR_",",4,"I")=1 Q
 . ;S NODE70=$G(^DGPT(RECNR,70))
 . S ZDD=$$GET1^DIQ(45,RECNR_",",70,"I")\1 ; Discharge date
 . Q:ZDD'=0&(ZDD<FDATE)
 . S ZAD=$$GET1^DIQ(45,RECNR_",",2,"I")\1 Q:ZAD>TDATE  ; Admit date
 . S NUMADMS=1
 Q:NUMADMS=0
 S ICN=$P($G(^DPT(DFN,"MPI")),"^",1)
 Q:ICN=""
 S ^TMP("SPN",$J,ICN)=""
 Q
OUT ;
 S ICN=""
 F  S ICN=$O(^TMP("SPN",$J,ICN)) Q:ICN=""  D
 . S ^TMP($J,RETCNT)=ICN_"^EOL999"
 . S RETCNT=RETCNT+1
 Q
