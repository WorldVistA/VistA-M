SPNJRPRE ;BP/JAS - RPC READMISSIONS REPORT BY DATE RANGE ;FEB 05, 2007
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to file #4 supported by IA# 10090
 ; Reference to ^DGPM("APRD" supported by IA# 4942
 ; Reference to API $$KSP^XUPARAM supported by IA# 2541
 ; Reference to API DEM^VADPT supported by IA# 10061
 ; Reference to API IN5^VADPT supported by IA# 10061
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     RETURN  is the sorted data from the earliest date of listing
 ;     ICNLST  is the list of patient ICNs to process
 ;     FDATE   is the delivery starting date
 ;     TDATE   is the delivery ending date
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST,FDATE,TDATE) ;
 ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 S X=FDATE S %DT="T" D ^%DT S SPNDATE=Y
 S X=TDATE S %DT="T" D ^%DT S SPNEDAT=Y_.2359
 ;***************************
 K ^TMP($J),^TMP("SPN",$J)
 S LOCDA=$$KSP^XUPARAM("INST")
 S LOC=$$GET1^DIQ(4,LOCDA_",",.01)
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D OUT,CLNUP
 Q
IN Q:$G(ICN)=""
 S SPNDFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 S SPNQDAT=SPNDATE-.000001
 S SDA=SPNDFN
 Q:'$D(^DGPM("APRD",SDA))
 F  S SPNQDAT=$O(^DGPM("APRD",SDA,SPNQDAT)) Q:(SPNQDAT<1)  Q:(SPNQDAT>(SPNEDAT+30))  D
 . S SPNIEN=0 F  S SPNIEN=$O(^DGPM("APRD",SDA,SPNQDAT,SPNIEN)) Q:SPNIEN<1  D
 . . N DFN,SPNLINE,SPNLOS
 . . S DFN=SPNDFN,VAIP("E")=SPNIEN D IN5^VADPT
 . . Q:VAIP(2)'["ADMISSION"&(VAIP(2)'["DISCHARGE")
 . . S TRANS=$P(VAIP(2),"^",2),WARD=$P(VAIP(5),"^",2)
 . . S MDAT=$P(VAIP(3),"^",1),TDAT=$P(VAIP(3),"^",2)
 . . I TRANS="DISCHARGE",SPNQDAT>SPNEDAT Q
 . . S SPNLINE=ICN_U_TRANS_U_LOC_U_LOCDA_U_WARD_U_TDAT
 . . S ^TMP("SPN",$J,ICN,MDAT,SPNIEN)=SPNLINE
 . . D KVAR^VADPT
 Q
OUT ;
 S ICN=""
 F  S ICN=$O(^TMP("SPN",$J,ICN)) Q:ICN=""  D
 . S MDAT=""
 . F  S MDAT=$O(^TMP("SPN",$J,ICN,MDAT)) Q:MDAT=""  D
 . . S SPNIEN=""
 . . F  S SPNIEN=$O(^TMP("SPN",$J,ICN,MDAT,SPNIEN)) Q:SPNIEN=""  D
 . . . S ^TMP($J,RETCNT)=^TMP("SPN",$J,ICN,MDAT,SPNIEN)_U_"EOL999"
 . . . S RETCNT=RETCNT+1
 Q
CLNUP ;
 K %DT,ICN,ICNNM,LOC,LOCDA,MDAT,RETCNT,SDA,SPNDATE,SPNDFN
 K SPNEDAT,SPNIEN,SPNQDAT,TDAT,TRANS,VAIP,WARD,X,Y
 Q
