SPNJRPDC ;BP/JAS - Returns list of ICNs who match VA Drug Class criteria ;JUN 25, 2007
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DPT(D0,"MPI" supported by IA# 4938
 ; Reference to ^PS(55,D0,"P","A" supported by IA# 552
 ; Reference to API RX^PSO52API supported by IA# 4820
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     ICNLST  is the list of patient ICNs to process
 ;     FDATE is the start date for period
 ;     TDATE is the end date for period
 ;     VADC is the VA Drug Class to search for
 ;     ^TMP($J) is the return value with list of ICNs
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST,FDATE,TDATE,VADC) ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 K ^TMP($J),^TMP("SPN",$J),VALIST
 S X=FDATE S %DT="T" D ^%DT S FDATE=Y
 S X=TDATE S %DT="T" D ^%DT S TDATE=Y
 D VALOAD
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D OUT,CLNUP
 Q
IN ;
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 Q:'$D(^PS(55,DFN,"P","A"))
 N EXPDATE,RECNR,ZEROREC,TWOREC,ZDRUGNR,UNITVAL,PNAME,PSSN
 N FILLDATE,SUBRECNR
 I '$D(TDATE) S TDATE=DT
 ; We are interested in any drug whose prescription 'expiration' or
 ; 'cancel' date falls on or after the 'from' date.
 ; We are going to take only the fills or refills which occurred
 ; during the 'from'-'thru' date range.
 S FND=0
 S EXPDATE=FDATE-.000001 ; for each expiration date
 F  S EXPDATE=$O(^PS(55,DFN,"P","A",EXPDATE)) Q:EXPDATE'>0!(FND)  D
 . S RECNR=0 ; for each prescription on that date
 . F  S RECNR=$O(^PS(55,DFN,"P","A",EXPDATE,RECNR)) Q:RECNR'>0!(FND)  D
 . . K ^TMP($J,"PSARRAY")
 . . D RX^PSO52API(DFN,"PSARRAY",RECNR)
 . . S FILLDATE=$P(^TMP($J,"PSARRAY",DFN,RECNR,22),"^",1)
 . . Q:FILLDATE>TDATE
 . . S ZDRUGNR=$P(^TMP($J,"PSARRAY",DFN,RECNR,6),"^",1)
 . . S PSDESC=$P(^TMP($J,"PSARRAY",DFN,RECNR,6),"^",2)
 . . I FILLDATE'<FDATE,FILLDATE'>TDATE D CHK Q:FND
 . . S SUBRECNR=0 ; for each refill of the drug
 . . F  S SUBRECNR=$O(^TMP($J,"PSARRAY",DFN,RECNR,"RF",SUBRECNR)) Q:SUBRECNR=""  D
 . . . S FILLDATE=$P(^TMP($J,"PSARRAY",DFN,RECNR,"RF",SUBRECNR,.01),"^",1)
 . . . Q:FILLDATE<FDATE!(FILLDATE>TDATE)
 . . . D CHK Q:FND
 . . K ^TMP($J,"PSARRAY")
 Q
CHK ;
 Q:'$D(VALIST(PSDESC))
 S ICN=$P($G(^DPT(DFN,"MPI")),"^",1)
 Q:ICN=""
 S ^TMP("SPN",$J,ICN,PSDESC)=""
 S FND=1
 Q
OUT ;
 S ICN=""
 F  S ICN=$O(^TMP("SPN",$J,ICN)) Q:ICN=""  D
 . S ^TMP($J,RETCNT)=ICN_"^EOL999"
 . S RETCNT=RETCNT+1
 Q
VALOAD ;
 S MDA="" F  S MDA=$O(VADC(MDA)) Q:MDA=""  D
 . S VAX=VADC(MDA)
 . S VALIST(VAX)=""
 Q
CLNUP ;
 K %DT,CNT,DFN,DNBR,FND,ICN,ICNNM,MDA,PATLST,PSDESC
 K RETCNT,VAX,X,Y,VADC,VALIST,^TMP($J,"PSARRAY")
 Q
