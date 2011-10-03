SPNJRPIC ;BP/JAS - Returns Applications for Inpatient Care data ;JAN 18, 2006
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DPT(D0,0 supported by IA #998
 ; Reference to API REG^VADPT supported by IA #10061
 ; Reference to API DEM^VADPT supported by IA #10061
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
 D HEAD
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D OUT,CLNUP
 Q
IN Q:$G(ICN)=""
 S SPNDFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(SPNDFN)=""
 ;***************************
 N SPNX,SPNFAC
 S (SPNLPRT,SPNFAC)=0
 Q:'$D(^DPT(SPNDFN))
 D PATIENT(SPNDFN)
 Q
 ;
OUT I $D(^TMP("SPN",$J)) D
 . N SPNSTATE,SPNDFN,SPNNAME
 . S SPNNAME="" F  S SPNNAME=$O(^TMP("SPN",$J,SPNNAME)) Q:SPNNAME=""  D
 . . S SPNDFN="" F  S SPNDFN=$O(^TMP("SPN",$J,SPNNAME,SPNDFN)) Q:SPNDFN=""  D
 . . . S SPNX="" F  S SPNX=$O(^TMP("SPN",$J,SPNNAME,SPNDFN,SPNX)) Q:SPNX=""  D
 . . . . S ^TMP($J,RETCNT)=^TMP("SPN",$J,SPNNAME,SPNDFN,SPNX)
 . . . . S RETCNT=RETCNT+1
 Q
PATIENT(SPNDFN) ; Print Patient data
 N DFN
 S DFN=SPNDFN
 D DEM^VADPT
 S PNAM=$E(VADM(1),1,30)_" ("_$E(VADM(1),1)_VA("BID")_")"
 S SPNNAME=VADM(1)
 D KVAR^VADPT
 K ^UTILITY("VARP",$J)
 S DFN=SPNDFN,VARP("F")=SPNDATE,VARP("T")=SPNEDAT
 D REG^VADPT
 N SPNODE,SPNNODE
 S SPNODE=0
 F  S SPNODE=$O(^UTILITY("VARP",$J,SPNODE)) Q:SPNODE<1  D
 . N SPNX,SPNY
 . S SPNX=$G(^UTILITY("VARP",$J,SPNODE,"I")) Q:SPNX=""
 . S SPNY=$G(^UTILITY("VARP",$J,SPNODE,"E")) Q:SPNY=""
 . S DOD=$$FMTE^XLFDT($P(SPNX,U),"2D"),DISP=$P(SPNY,U,7)
 . S TYBN=$P(SPNY,U,3)
 . S ^TMP("SPN",$J,SPNNAME,SPNDFN,SPNX)=PNAM_"^"_DOD_"^"_DISP_"^"_TYBN_"^EOL999"
 . Q
 D KVAR^VADPT K ^UTILITY("VARP",$J)
 Q
HEAD ; Header Print
 S ^TMP($J,RETCNT)="HDR999^PATIENT^DATE OF DISPOSITION^DISPOSITION^TYPE OF BENEFIT^EOL999"
 S RETCNT=RETCNT+1
 Q
CLNUP ;
 K ^TMP("SPN",$J)
 K %DT,DISP,DOD,ICN,ICNNM,PNAM,RETCNT,SPNDATE,SPNEDAT,SPNLPRT
 K SPNQDAT,SPNRDAT,TYBN,VA,VADM,VARP,X,Y
 Q
