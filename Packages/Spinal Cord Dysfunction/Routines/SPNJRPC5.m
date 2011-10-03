SPNJRPC5 ;BP/JAS - Returns Breakdown of Patients data ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to API DEM^VADPT supported by IA# 10061
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ; API GATHER^SPNLGRPS is part of Spinal Cord version 2.0
 ;
 ; Parm values:
 ;     RETURN is the sorted data from the earliest date of listing
 ;     ICNLST is the list of patient ICNs to process
 ;     FDATE is the start date for period
 ;     TDATE is the end date for period
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST,FDATE,TDATE) ;
 ;***************************
 S QLIST("WINDOW")=0
 S QLIST("INCLUDE DEAD")=1
 S RETURN=$NA(^TMP($J)),RETCNT=1
 S X=FDATE S %DT="T" D ^%DT S FDATE=Y
 S X=TDATE S %DT="T" D ^%DT S TDATE=Y
 I FDATE'=-1,TDATE'=-1 S QLIST("WINDOW")=1
 ;***************************
 K ^TMP($J),^TMP("SPN",$J)
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D FMTRET
 D CLNUP
 Q
IN Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 D DEM^VADPT
 D GATHER^SPNLGRPS(DFN,FDATE,TDATE,.QLIST)
 Q
FMTRET ;
 F SEX="F","M","U" S SEXLIST(SEX)=""
 S ^TMP($J,RETCNT)="HDR999^CATEGORY^FEMALE^MALE^UNKNOWN^TOTAL^EOL999"
 S RETCNT=RETCNT+1
 S ^TMP($J,RETCNT)="BOS999^TOTALS^EOL999"
 S RETCNT=RETCNT+1
 I QLIST("INCLUDE DEAD") D
 . S ^TMP($J,RETCNT)="Living (or Unknown)" D LISTEM("STAT","LIVE")
 . S ^TMP($J,RETCNT)="Deceased (Date of Death in Patient file)" D LISTEM("STAT","DEAD")
 E  S ^TMP($J,RETCNT)="Total" D LISTEM("STAT","LIVE")
 ;
 S ^TMP($J,RETCNT)="BOS999^AGE^EOL999"
 S RETCNT=RETCNT+1
 N AGE S AGE=""
 F  S AGE=$O(^TMP("SPN",$J,"PS","AGE",AGE)) Q:AGE=""  D
 . S ^TMP($J,RETCNT)=(AGE)_"-"_(AGE+4)_" years" D LISTEM("AGE",AGE)
 ;
 S ^TMP($J,RETCNT)="BOS999^RACE^EOL999"
 S RETCNT=RETCNT+1
 N RACE S RACE=""
 F  S RACE=$O(^TMP("SPN",$J,"PS","RACE",RACE)) Q:RACE=""  D
 . S ^TMP($J,RETCNT)=RACE D LISTEM("RACE",RACE)
 ;
 S ^TMP($J,RETCNT)="BOS999^MEANS TEST^EOL999"
 S RETCNT=RETCNT+1
 N MEANS S MEANS=""
 F  S MEANS=$O(^TMP("SPN",$J,"PS","MEANS",MEANS)) Q:MEANS=""  D
 . S ^TMP($J,RETCNT)="Means Test "_MEANS D LISTEM("MEANS",MEANS)
 ;
 S ^TMP($J,RETCNT)="BOS999^ELIGIBILITY^EOL999"
 S RETCNT=RETCNT+1
 N ELIG S ELIG=""
 F  S ELIG=$O(^TMP("SPN",$J,"PS","ELIG",ELIG)) Q:ELIG=""  D
 . S ^TMP($J,RETCNT)=ELIG D LISTEM("ELIG",ELIG)
 ;
 S ^TMP($J,RETCNT)="BOS999^PLACE OF SERVICE^EOL999"
 S RETCNT=RETCNT+1
 N POS S POS=""
 F  S POS=$O(^TMP("SPN",$J,"PS","POS",POS)) Q:POS=""  D
 . S ^TMP($J,RETCNT)=POS D LISTEM("POS",POS)
 ;
 S ^TMP($J,RETCNT)="BOS999^SEEN^EOL999"
 S RETCNT=RETCNT+1
 N SEEN S SEEN=""
 F  S SEEN=$O(^TMP("SPN",$J,"PS","SEEN",SEEN)) Q:SEEN=""  D
 . S ^TMP($J,RETCNT)="Seen "_$S(SEEN="IP":"as Inpatient",SEEN="OP":"as Outpatient",SEEN="CH":"in Laboratory",SEEN="RX":"in Pharmacy",SEEN="RA":"in Radiology",1:"Somewhere")
 . D LISTEM("SEEN",SEEN)
 Q
LISTEM(TYPE,SUB)        ;
 N SEX,TOTLSEX,I,NUM
 S SEX="",TOTLSEX=0
 F I=0:1 S SEX=$O(SEXLIST(SEX)) Q:SEX=""  D
 . S NUM=+$G(^TMP("SPN",$J,"PS",TYPE,SUB,SEX))
 . Q:NUM=0
 . S TOTLSEX=TOTLSEX+NUM
 . S $P(^TMP($J,RETCNT),"^",I+2)=NUM
 I I>1 S $P(^TMP($J,RETCNT),"^",5)=TOTLSEX
 S $P(^TMP($J,RETCNT),"^",6)="EOL999"
 S RETCNT=RETCNT+1
 Q
CLNUP ;
 K %DT,AICN,DFN,ICN,ICNNM,NUMSEX,PATLIST,QLIST,RETCNT
 K SEXLIST,SPN,X,Y
 Q
