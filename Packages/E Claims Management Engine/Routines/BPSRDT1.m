BPSRDT1 ;BHAM ISC/FCS/DRS/FLS/DLF - Turn Around Time Statistics Report ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 N TRANDT,FR,TO,BPSSIZ,BPSTTAT,IEN57,IEN59,IEN,UPDT,SEQ,ENDLOOP,BPSTATIM
 N BPSBGN,BPSBTIM,BPSCTIM,BPSEND,BPSETIM,BPSGTIM,BPSRTIM,BPSSTIM
 N BPSBDT,BPSCNT,X,Y,BPSQUIT,MES,TYPE,DATA
 K ^TMP("BPSRDT1",$J)
 ;
 ; Get start/end dates.  Quit if no dates entered
 D DATE I Y<0 K DTOUT Q
 ;
 ; Initialize variables
 S TRANDT=FR,BPSSIZ=0,BPSTTAT=0,BPSCNT=0
 ;
 ; Quit if no dates in X-ref that match
 I '$O(^BPSTL("AH",TRANDT)) G QUIT
 ;
 ; Loop through the dates and build temporary list
 F  S TRANDT=$O(^BPSTL("AH",TRANDT)) Q:TRANDT=""!($P(TRANDT,".")>TO)  D
 . S IEN57=""
 . F  S IEN57=$O(^BPSTL("AH",TRANDT,IEN57)) Q:IEN57=""  D
 .. S IEN59=$P($G(^BPSTL(IEN57,0)),U,1)
 .. I 'IEN59 Q
 .. S IEN=$$EXISTS^BPSOSL1(IEN59)
 .. I IEN S ^TMP("BPSRDT1",$J,1,IEN59)=IEN
 ;
 ; Loop through the temporary list and build second list with turn-around stats
 S IEN59=""
 F  S IEN59=$O(^TMP("BPSRDT1",$J,1,IEN59)) Q:IEN59=""  D
 . S IEN=$G(^TMP("BPSRDT1",$J,1,IEN59))
 . S ENDLOOP=0
 . S (BPSBDT,BPSBGN,BPSEND,BPSBTIM,BPSGTIM,BPSCTIM,BPSSTIM,BPSRTIM,BPSETIM,TYPE)=""
 . S UPDT=FR F  S UPDT=$O(^BPS(9002313.12,IEN,10,"B",UPDT)) Q:UPDT=""  D  Q:ENDLOOP
 .. S SEQ="" F  S SEQ=$O(^BPS(9002313.12,IEN,10,"B",UPDT,SEQ)) Q:SEQ=""  D  Q:ENDLOOP
 ... S MES=$$UP($P($G(^BPS(9002313.12,IEN,10,SEQ,1)),U,1))
 ... I MES="" Q
 ... I MES["BEFORE SUBMIT OF " D
 .... S TYPE=$P(MES,"BEFORE SUBMIT OF ",2)
 .... S BPSBDT=$P(UPDT,".",1)
 .... I BPSBDT>TO S BPSBDT="",ENDLOOP=1 Q
 .... S BPSBGN=$$TIME2(UPDT),BPSBTIM=$$TIME(UPDT)
 .... S (BPSEND,BPSGTIM,BPSCTIM,BPSSTIM,BPSRTIM,BPSETIM)=""
 ... I ENDLOOP=1 Q
 ... I BPSBDT,MES["BPSOSU NOW RESUBMIT"!(MES["BPSOSU-NOW RESUBMIT") D
 .... S TYPE="Request portion of a Reversal/Resubmit"
 .... S BPSBGN=$$TIME2(UPDT),BPSBTIM=$$TIME(UPDT)
 .... S (BPSEND,BPSGTIM,BPSCTIM,BPSSTIM,BPSRTIM,BPSETIM)=""
 ... I BPSBGN="" Q
 ... I MES["INITIATING REVERSAL AND AFTER THAT, CLAIM WILL BE RESUBMITTED" S TYPE="Reversal portion of a Reversal/Resubmit"
 ... I MES["GATHERING"!(MES["VALIDATING THE BPS TRANSACTION") S BPSGTIM=$$TIME(UPDT)
 ... I MES["CREATED CLAIM ID" S BPSCTIM=$$TIME(UPDT)
 ... I MES["BPSECMC2 - CLAIM - SENT"!(MES["BPSECMC2-CLAIM SENT") S BPSSTIM=$$TIME(UPDT)
 ... I MES["BPSECMC2 - CLAIM - RESPONSE STORED"!(MES["BPSECMC2-RESPONSE STORED") S BPSRTIM=$$TIME(UPDT)
 ... I MES["CLAIM - END"!(MES["BPSOSU-CLAIM COMPLETE") I BPSBGN D
 .... S BPSEND=$$TIME2(UPDT),BPSETIM=$$TIME(UPDT)
 .... D LOG
 ;
 ; If no data to report, quit
 I 'BPSTTAT G QUIT
 ;
 ; Loop through list of stats and output
 S BPSCNT="",BPSQUIT=0
 F  S BPSCNT=$O(^TMP("BPSRDT1",$J,2,BPSCNT)) Q:BPSCNT=""  D  I BPSQUIT=1 Q
 . S DATA=$G(^TMP("BPSRDT1",$J,2,BPSCNT)),IEN59=$P(DATA,U,1),TYPE=$P(DATA,U,2)
 . S TYPE=$S(TYPE="CLAIM":"Request",TYPE="REVERSAL":"Reversal",1:TYPE)
 . W !,"For Prescription",?25,IEN59_"  (Rx# "_$$RXAPI1^BPSUTIL1($P(IEN59,"."),.01,"I")_")"
 . W !,"Type",?25,TYPE
 . W !,"Date",?25,$$FMTE^XLFDT($P(DATA,U,3),"5Z")
 . W !,"Begin ",?25,$P(DATA,U,4)
 . W !,"Gathering information",?25,$P(DATA,U,5)
 . W !,"Claim ID created",?25,$P(DATA,U,6)
 . W !,"Claim Sent",?25,$P(DATA,U,7)
 . W !,"Response stored ",?25,$P(DATA,U,8)
 . W !,"Completed at",?25,$P(DATA,U,9)
 . W !,"Turn-around time",?25,$P(DATA,U,10),!
 . I BPSCNT#2=0 D
 .. R !!,"Press RETURN to continue, '^' to exit: ",X:DTIME
 .. I '$T!(X["^") S BPSQUIT=1
 ;
 ; Write Totals
 W !!!,"Total number of claims",?25,BPSSIZ
 W !,"Average Turn-around time",?25,BPSTTAT\BPSSIZ,!!
 D PRESSANY^BPSOSU5()
 ;
 ; Kill scratch global
 K ^TMP("BPSRDT1",$J)
 Q
 ;
 ;
TIME(%) ;
 S %=$E($P(%,".",2)_"000000",1,6)
 Q $E(%,1,2)_":"_$E(%,3,4)_":"_$E(%,5,6)
 ;
TIME2(%) ;
 Q $P($$FMTH^XLFDT(%),",",2)
 ;
 ;
LOG ;
 I BPSBGN="" Q
 I BPSEND="" Q
 S BPSTATIM=$G(BPSEND)-$G(BPSBGN)
 ;
 ; Remove negative times (span midnight) and claims more than 20 minutes as anomolies
 I BPSTATIM'>0 Q
 ;I BPSTATIM>1200 Q
 S BPSCNT=BPSCNT+1
 S ^TMP("BPSRDT1",$J,2,BPSCNT)=IEN59_U_TYPE_U_BPSBDT_U_BPSBTIM_U_BPSGTIM_U_BPSCTIM_U_BPSSTIM_U_BPSRTIM_U_BPSETIM_U_BPSTATIM
 S BPSTTAT=BPSTTAT+BPSTATIM
 S BPSSIZ=BPSSIZ+1
 I TYPE="Reversal/Resubmit" S BPSSIZ=BPSSIZ+1
 S (BPSBGN,TYPE)=""
 Q
 ;
DATE ; Ask user the date range
 N %DT,VAL,TYPEVAL,X
 S %DT="AEP",%DT(0)=-DT,%DT("A")="START WITH DATE: "
 S %DT("B")="T-1"
 D ^%DT Q:Y<0!($D(DTOUT))
 S (%DT(0),FR)=Y
 S %DT("A")="GO TO DATE: "
 S %DT("B")="T"
 D ^%DT Q:Y<0!($D(DTOUT))
 S TO=Y
 Q
 ;
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
QUIT ;
 W !!,"*** No valid data found ***",!!
 D PRESSANY^BPSOSU5()
 Q
