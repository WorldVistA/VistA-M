SPNJRPOP ;BP/JAS - Returns list of ICNs for Outpatients ;JUL 01, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DIC(40.7 supported by IA #557
 ; Reference to API VISIT^PXRHS01 supported by IA #1238
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Param values:
 ;     RETURN is the list of ICNs who meet criteria
 ;     ICNLST  is the list of patient ICNs to process
 ;     FDATE is the start date for period
 ;     TDATE is the end date for period
 ;     CLINLST is the Clinic Stops for Outpatients
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST,FDATE,TDATE,CLINLST) ;
 ;
 K ^TMP($J),CLLIST
 S RETURN=$NA(^TMP($J)),RETCNT=1
 D CLLOAD
 S X=FDATE S %DT="T" D ^%DT S FDATE=Y
 I FDATE=-1 S FDATE=1000101
 S X=TDATE S %DT="T" D ^%DT S TDATE=Y
 I TDATE=-1 S TDATE=DT
 ;JAS 02/05/08 - DEFECT 801 (NEXT LINE)
 S TDATE=TDATE_".999999"
 S ICNNM=""
 F  S ICNNM=$O(ICNLST(ICNNM)) Q:ICNNM=""  D
 . S ICN=ICNLST(ICNNM) D IN
 D ZAP
 Q
IN ;
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 K ^TMP("PXHSV",$J)
 D VISIT^PXRHS01(DFN,TDATE,FDATE,"","AHICTNSOERDX")
 ;JAS - 05/15/08 - DEFECT 1090 (MULTIPLE EDITS BELOW)
 ;S REVDT="",FND=0
 S REVDT=0,FND=0
 F  S REVDT=$O(^TMP("PXHSV",$J,REVDT)) Q:REVDT=""!(FND)  D
 . ;S VCNT=""
 . S VCNT=0
 . F  S VCNT=$O(^TMP("PXHSV",$J,REVDT,VCNT)) Q:VCNT=""!(FND)  D
 . . S CLINICNA=$P(^TMP("PXHSV",$J,REVDT,VCNT,0),"^",9)
 . . Q:CLINICNA=""
 . . I $D(CLLIST("ALL")) S ^TMP($J,RETCNT)=ICN_U_"EOL999",RETCNT=RETCNT+1,FND=1 Q
 . . I $G(CLLIST(CLINICNA)) S ^TMP($J,RETCNT)=ICN_U_"EOL999",RETCNT=RETCNT+1,FND=1 Q
 . . Q
 . Q
 Q
ZAP      ;
 K %DT,X,Y,CLINICNA,^TMP("PXHSV",$J)
 K CL,CLIEN,CLINICS,CLLIST
 K DFN,FDATE,ICN,I,FND
 K CLA,CLIDX,CLNM,CLNAM
 K CLINNM,ICNNM,RETCNT,REVDT,VCNT
 Q
CLLOAD   ;CREATE CLINIC LIST FROM USER'S STRING INPUT
 I $G(CLINLST(1))="" S CLLIST("ALL")="" Q
 S CLINNM=""
 F  S CLINNM=$O(CLINLST(CLINNM)) Q:CLINNM=""  D
 . S CL=CLINLST(CLINNM)
 . I $D(^DIC(40.7,"C",CL)) D
 . . S CLNM=CL,CLIDX=$O(^DIC(40.7,"C",CL,""))
 . . I CLIDX="" S CLLIST(CLNM)=CLNM Q
 . . S CLNAM=$P($G(^DIC(40.7,CLIDX,0)),"^",1)
 . . S CLLIST(CLNAM)=CLNM_";"_CLNAM
 . . Q
 . Q
 Q
