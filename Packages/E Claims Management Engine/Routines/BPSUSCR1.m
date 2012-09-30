BPSUSCR1 ;BHAM ISC/FLS - STRANDED SUBMISSIONS SCREEN (cont) ;10-MAR-2005
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,10,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Fileman read of New Person file (VA(200)) supported by IA10060
 ; Call to MSGSTAT^HLUTIL supported by IA3098
 ; Call to MSGACT^HLUTIL supported by IA3098
 ; Call to TRIM^XLFSTR supported by IA10104
 ;
 Q
 ;
 ; Warning message for 'Transmitting' submissions
MESSAGE() ;
 W !!!,"Please be aware that if there are submissions appearing on the ECME User Screen"
 W !,"with a status of 'In progress - Transmitting', then there may be a problem"
 W !,"with HL7 or with system connectivity with the Austin Automation Center (AAC)."
 W !,"Please contact your IRM to verify that connectivity to the AAC is working"
 W !,"and the HL7 link BPS NCPDP is processing messages before using this option"
 W !,"to unstrand submissions with a status of 'In progress - Transmitting'.",!
 N DIR,X,Y,BPQ
 S BPQ=0
 S DIR(0)="YA",DIR("A")="Do you want to continue? "
 S DIR("B")="NO"
 D ^DIR
 I Y'=1 S BPQ=1
 W !!
 Q BPQ
 ;
GETDTS(BPARR) ; Transaction dates to view.
 N DIR
 K DIRUT,DIROUT,DUOUT,DTOUT,Y
 S DIR(0)="DA^:DT:EX",DIR("A")="FIRST TRANSACTION DATE: "
 S DIR("B")="T-1"
 D ^DIR
 Q:$D(DUOUT)!($D(DTOUT))
 S BPARR("BDT")=Y_".000001"
ENDDT ;
 K DIRUT,DIROUT,DUOUT,DTOUT,Y
 S DIR(0)="DA^"_$P(BPARR("BDT"),".",1)_":DT:EX",DIR("A")="LAST TRANSACTION DATE: "
 S DIR("B")="T"
 D ^DIR
 Q:$D(DUOUT)!($D(DTOUT))
 S BPARR("EDT")=$$EDATE(Y)
 Q
 ;
EDATE(DATE) ;
 N RTN,%,%H
 S RTN=DATE_".235959"
 D NOW^%DTC
 I $P(%,".")=DATE S $P(%H,",",2)=$P(%H,",",2)-1800 D YX^%DTC S RTN=DATE_%
 Q RTN
 ;
ALL ; Unstrand all submissions currently selected.
 D FULL^VALM1
 N D0,SEQ,LAST,TMP,TMP2,RET
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S LAST=+$O(^TMP("BPSUSCR-2",$J,""),-1)
 I LAST=0 D  Q
 . W !,"There are no stranded submissions in this date range to unstrand"
 . K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR
 ; Display message if there are multiple types on the queue
 S TMP=$O(^TMP("BPSUSCR-1",$J,""))
 I TMP S TMP2=$O(^TMP("BPSUSCR-1",$J,TMP))
 I TMP2 D
 . W !,"Please be aware there are multiple types of requests currently stranded."
 . W !,"Are you sure you want to unstrand ALL submissions?  If not, exit this"
 . W !,"action and select which submissions you want to unstrand."
 . W !!,"Answer NO to following prompt if you wish to SELECT the submissions to unstrand.",!
 S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="NO" D ^DIR Q:'Y
 W !,"Please wait..."
 S SEQ=0,RET=0
 F  S SEQ=$O(^TMP("BPSUSCR-2",$J,SEQ)) Q:'SEQ  D
 .  S D0=""
 .  F  S D0=$O(^TMP("BPSUSCR-2",$J,SEQ,D0)) Q:'D0  D
 .  .  S X=$$UNSTRAND(D0,$G(^TMP("BPSUSCR-2",$J,SEQ,D0)))
 .  .  I 'X S RET=1
 .  .  Q
 .  Q
 I 'RET W !,"Done"
 E  K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR
 D CLEAN^VALM10
 D COLLECT^BPSUSCR4(.BPARR)
 Q
 ;
SELECT ; Select entries from the list and run each through the unstrand function
 D FULL^VALM1
 N D0,I,J,VAR,BPTMPGL,PT,POP,LAST,RET
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S LAST=+$O(^TMP("BPSUSCR-2",$J,""),-1)
 I LAST=0 D  Q
 . W !,"There are no stranded submissions to select"
 . K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR
 K DTOUT,DUOUT
 S BPTMPGL="^TMP(""BPSUSCR"",$J)"
 S VAR=""
 K DIR
 S DIR(0)="LO^1:"_LAST
 S DIR("A")="Enter a Selection of Stranded Submissions",DIR("B")=""
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q
 S VAR=Y,RET=0
 F I=1:1:$L(VAR,",") S PT=$P(VAR,",",I) D
 .  Q:PT=""
 .  I PT'["-" S D0=$O(^TMP("BPSUSCR-2",$J,PT,"")) S X=$$UNSTRAND(D0,$G(^TMP("BPSUSCR-2",$J,PT,+D0))) I 'X S RET=1 Q
 .  F J=$P(PT,"-"):1:$P(PT,"-",2) S D0=$O(^TMP("BPSUSCR-2",$J,J,"")) S X=$$UNSTRAND(D0,$G(^TMP("BPSUSCR-2",$J,J,+D0))) I 'X S RET=1
 .  Q
 I RET K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR
 D CLEAN^VALM10
 D COLLECT^BPSUSCR4(.BPARR)
 Q
 ;
PRINT ;
 ; Full Screen Mode
 D FULL^VALM1
 ; Prompt for pinter
 N %ZIS,POP
 S %ZIS="M",%ZIS("A")="Select Printer: ",%ZIS("B")="" D ^%ZIS
 I POP Q
 ; Use device
 U IO
 ; Create Report
 D REPORT
 Q
 ;
REPORT ;
 N SEQ,LINE,BPQ,LCNT,DATA,BPSCR
 ;
 ; Set flag for interactive device
 S BPSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 ; Print first header
 D HDR
 ;
 ; Loop through data and display
 S SEQ=0,BPQ=0,DATA=0
 F  S SEQ=$O(^TMP("BPSUSCR",$J,SEQ)) Q:'SEQ  D  I BPQ Q
 . S LINE=$G(^TMP("BPSUSCR",$J,SEQ,0))
 . ; Check if we filled a page
 . S BPQ=$$CHKP(BPSCR) I BPQ Q
 . W !,$E(LINE,1,79)
 . S LCNT=LCNT+1
 . S DATA=1
 ;
 ; If no data, display message
 I DATA=0 W !?4,"No data to display"
 ;
 ; Write FF for print devices
 ; Else final Press Return...
 I 'BPSCR W !,@IOF
 E  I 'BPQ D PAUSE2
 ;
 ; Close the device and quit
 D ^%ZISC
 Q
 ;
HDR ;
 ; Display Header.
 ; LCNT is returned
 N HDR,TAB
 S HDR="Submissions Stranded from "_BPBDT_" through "_BPEDT
 S TAB=80-$L(HDR)\2
 W !!,?TAB,HDR
 W !!?4,"TRANS DT",?15,"PATIENT NAME",?36,"ID",?41,"RX/FILL",?57,"DOS",?68,"INS CO"
 W !,?4,"--------",?15,"------------",?36,"--",?41,"-------",?57,"---",?68,"------"
 S LCNT=5
 Q
 ;
CHKP(BPSCR) ;
 ; Check for End of Page
 ; LCNT is returned
 N BPLINES
 I $G(BPSCR) S BPLINES=3
 E  S BPLINES=1
 I '$G(IOSL) Q 0
 I IOSL'<(LCNT+BPLINES) Q 0
 I $G(BPSCR) S BPQ=$$PAUSE I BPQ Q 1
 D HDR
 Q 0
 ;
PAUSE() ;
 N X
 U IO(0)
 R !!,"Press RETURN to continue, '^' to exit: ",X:DTIME
 I '$T!(X="^") Q 1
 U IO
 Q 0
 ;
PAUSE2 ;
 N X
 U IO(0)
 R !,"Press RETURN to continue: ",X:DTIME
 U IO
 Q
 ;
UNSTRAND(IEN59,DATA) ;
 ; Unstrand a specific submission
 ;
 ; Input variables
 ;   IEN59 - IEN of BPS TRANSACTION
 ;   DATA - String of data delimited with caret ('^')
 ;     Piece 1 - IEN of BPS REQUEST - If this is defined, it means that there
 ;       was only a request record but no BPS TRANSACTION record
 ;     Piece 2 - Patient Name
 ;     Piece 3 - Date of Service
 ; Returns
 ;   1: Successful, 0:Unsucessful
 ;
 N MES,BPTYPE,HL7,MES,X
 ; If the IEN of BPS Request file is passed in, that means that there was no transaction
 ;  data (no 0 node) so we need to just remove the request.  This will be done by UNQUEUE.
 I +$G(DATA)>0 D UNQUEUE(IEN59,+DATA) Q 1
 ;
 ; Cancel the outgoing HL7 message.  If it has a status of 1 (waiting in queue), cancel
 ;   it.  If the cancel fails, do not unstrand and display a message
 ; If it has a status of 1.5 (opening connection), do not unstrand and display a message
 ; Calls to HLUTIL supported by IA3098
 S HL7=$P($G(^BPST(IEN59,0)),U,3),MES=""
 I HL7 D  I MES]"" D LOG^BPSOSL(IEN59,$T(+0)_"-"_MES) W !!,MES,!,"The transaction(s) should process normally/no further action required" Q 0
 . N STAT,RESLT,NAME,DATE
 . S STAT=+$$MSGSTAT^HLUTIL(HL7)
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Checking on whether to remove the HL7 message "_HL7_" from the HL7 queue.  Status is "_STAT)
 . S NAME=$$TRIM^XLFSTR($E($P(DATA,U,2),1,21)),DATE=$$DATTIM^BPSRPT1($P(DATA,U,3))
 . ; If status is 1 (Waiting in Queue), cancel the queue entry
 . I STAT=1 D  Q
 .. S RESLT=$$MSGACT^HLUTIL(HL7,1)
 .. D LOG^BPSOSL(IEN59,$T(+0)_"-HL7 message cancelled - Result is "_RESLT)
 .. ; If the cancel failed, set the message variable and do not unstrand
 .. I RESLT=0 S MES="The HL7 message for "_NAME_" on "_DATE_" could not be cancelled"
 . ; If status is 1.5 (Opening Connection), set the message variable but do not try to unstrand
 . I STAT=1.5 S MES="The HL7 message for "_NAME_" on "_DATE_" is open on the HL7 queue"
 ;
 ; Set the result (error 99) and message
 S BPTYPE=$P($G(^BPST(IEN59,0)),U,15)
 S MES="E UNSTRANDED"
 I BPTYPE="U" S MES="E REVERSAL UNSTRANDED"
 I BPTYPE="E" S MES="E ELIGIBILITY UNSTRANDED"
 D SETRESU^BPSOSU(IEN59,99,MES)
 ;
 ; Setting the status to 99% will call REQST99^BPSOSRX5, which will delete
 ;   the current request and subsequent requests
 D SETSTAT^BPSOSU(IEN59,99)
 ; 
 ; Update the log
 S MES=$T(+0)_"-Unstranded"
 I $G(DUZ) S MES=MES_" by "_$$GET1^DIQ(200,DUZ,.01,"E") ; IA# 10060
 D LOG^BPSOSL(IEN59,MES)
 Q 1
 ;
 ;Remove all requests for this set of keys
UNQUEUE(IEN59,IEN77) ;
 N MES,KEY1,KEY2,BPTYPE,BPRETV
 I 'IEN77 Q
 S KEY1=$$GET1^DIQ(9002313.77,IEN77,.01,"I")
 S KEY2=$$GET1^DIQ(9002313.77,IEN77,.02,"I")
 S BPTYPE=$$GET1^DIQ(9002313.77,IEN77,1.04,"I")
 I BPTYPE'="E" D
 . W !,"Warning! The stranded request for the prescription #"_$$GET1^DIQ(9002313.77,IEN77,1.13,"E")_" and fill "_$$GET1^DIQ(9002313.77,IEN77,1.14,"E")
 . W !,"is being deleted. It might need to be submitted manually in the IB Claims"
 . W !,"Tracking Edit option."
 . D PRESSANY^BPSOSU5()
 ;
 ; Lock the request
 D LOG^BPSOSL(IEN59,$T(+0)_"-Attempting to lock request with keys "_KEY1_", "_KEY2)
 S BPRETV=$$LOCKRF^BPSOSRX(KEY1,KEY2,10,IEN59,$T(+0))
 I 'BPRETV D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot lock keys") Q
 ;
 ; Set request to completed and delete any other subsequent or active requests
 ; Then unlock the record
 D COMPLETD^BPSOSRX4(IEN77),DELALLRQ^BPSOSRX7(IEN77,IEN59),DELACTRQ^BPSOSRX6(KEY1,KEY2,IEN59)
 D UNLCKRF^BPSOSRX(KEY1,KEY2,IEN59,$T(+0))
 ;
 ; Put message in log indicating that we have unstranded the request
 S MES=$T(+0)_"-Unqueued (unstranded)"
 I $G(DUZ) S MES=MES_" by "_$$GET1^DIQ(200,DUZ,.01,"E") ; IA# 10060
 D LOG^BPSOSL(IEN59,MES)
 Q
