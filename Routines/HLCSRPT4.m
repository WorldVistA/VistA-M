HLCSRPT4 ;OIFO-O/LJA - Error Listing code ;3/18/02 10:19
 ;;1.6;HEALTH LEVEL SEVEN;**85**;Oct 13, 1995
 ;
 ; Patch HL*1.6*85 created a significant amount of code; enough
 ; that this routine had to be created to hold it. 
 ;
LOADERR ; Find latest NUMERR statuses in ERRDTB->ERRDTE date range. ;HL*1.6*85
 ;ERRDTB,ERRDTE,HLCSER,HLCSTER1,NUMERR -- req
 ;
 N CT,ERR,ERR4,IEN,TIME
 ;
 KILL ^TMP("HLERR",$J),^TMP("ERRLST",$J)
 ;
 S HLERR=3.9,CT=0
 F  S HLERR=$O(^HLMA("AG",HLERR)) QUIT:HLERR'>0!(HLERR>7)  D
 .  S IEN773=0
 .  F  S IEN773=$O(^HLMA("AG",HLERR,IEN773)) Q:IEN773'>0  D
 .  .  S ERR4=$P($G(^HLMA(+IEN773,"P")),U,4) QUIT:ERR4'>0  ;->
 .  .  D CHKERR(ERR4,IEN773,ERRDTB,ERRDTE)
 .  .  S CT=CT+1 W:'(CT#1000) "."
 ;
 S ERR=0
 F  S ERR=$O(^TMP("HLERR",$J,ERR)) Q:ERR'>0  D
 .  S TIME=0
 .  F  S TIME=$O(^TMP("HLERR",$J,ERR,TIME)) Q:TIME'>0  D
 .  .  S IEN=0
 .  .  F  S IEN=$O(^TMP("HLERR",$J,ERR,TIME,IEN)) Q:IEN'>0  D
 .  .  .  S ^TMP("ERRLST",$J,+ERR,+IEN)=""
 ;
 KILL ^TMP("HLERR",$J)
 ;
 QUIT
 ;
CHKERR(ERR4,IEN773,DTB,DTE) ; Should this entry be included? ;HL*1.6*85
 ;NUMERR -- req
 ;
 N ERRNO,OLD773,OLDPDT,PROCDT
 ;
 ; Processing date/time check...
 S PROCDT=$$PROCDT(IEN773) QUIT:PROCDT'>0  ;->
 I PROCDT<DTB!(PROCDT>DTE) QUIT  ;->
 ; OK.  Date check passes.  But, is it among NUMERR latest?
 ;
 ; How many errors recorded for error status?
 S ERRNO=$G(^TMP("HLERR",$J,ERR4))
 ;
 ; Number of errors recorded less than # maximum per status...
 I ERRNO<NUMERR D RECERR(ERR4,IEN773) QUIT  ;->
 ;
 ; Find oldest entry's process date/time & last 773 IEN...
 S OLDPDT=$O(^TMP("HLERR",$J,ERR4,0)) QUIT:OLDPDT'>0  ;->
 S OLD773=$O(^TMP("HLERR",$J,ERR4,+OLDPDT,0)) QUIT:OLD773'>0  ;->
 ;
 ; Now see if "this" error is newer...
 QUIT:PROCDT<OLDPDT  ;->
 I PROCDT=OLDPDT,IEN773<OLD773 QUIT  ;->
 ;
 ; Max number errors reached, but this error is newer than newest...
 ;
 ; Zilch oldest entry, then record "this" error...
 D KILLERR(ERR4,OLDPDT,OLD773)
 D RECERR(ERR4,IEN773)
 ;
 QUIT
 ;
KILLERR(ERR4,OLDPDT,OLD773) ; Remove entry and adjust counts... ;HL*1.6*85
 N NUM
 ;
 KILL ^TMP("HLERR",$J,ERR4,OLDPDT,OLD773)
 ;
 I $O(^TMP("HLERR",$J,ERR4,OLDPDT,0))'>0 D
 .  KILL ^TMP("HLERR",$J,ERR4,OLDPDT)
 I $O(^TMP("HLERR",$J,ERR4,OLDPDT,0))>0 D
 .  S NUM=$G(^TMP("HLERR",$J,ERR4,OLDPDT))-1,NUM=$S(NUM'<0:+NUM,1:0)
 .  S ^TMP("HLERR",$J,ERR4,OLDPDT)=NUM
 ;
 I $O(^TMP("HLERR",$J,ERR4,0))'>0 D
 .  KILL ^TMP("HLERR",$J,ERR4)
 I $O(^TMP("HLERR",$J,ERR4,0))>0 D
 .  S NUM=$G(^TMP("HLERR",$J,ERR4))-1,NUM=$S(NUM'<0:+NUM,1:0)
 .  S ^TMP("HLERR",$J,ERR4)=NUM
 ;
 I $O(^TMP("HLERR",$J,0))'>0 D
 .  KILL ^TMP("HLERR",$J)
 I $O(^TMP("HLERR",$J,0))>0 D
 .  S NUM=$G(^TMP("HLERR",$J))-1,NUM=$S(NUM'<0:+NUM,1:0)
 .  S ^TMP("HLERR",$J)=NUM
 ;
 QUIT
 ;
RECERR(ERR4,IEN773) ; Store error in ^TMP("HLERR",$J,STATUS,IEN773) ;HL*1.6*85
 S ^TMP("HLERR",$J,ERR4)=$G(^TMP("HLERR",$J,ERR4))+1
 S ^TMP("HLERR",$J,ERR4,PROCDT)=$G(^TMP("HLERR",$J,ERR4,PROCDT))+1
 S ^TMP("HLERR",$J,ERR4,PROCDT,IEN773)=""
 QUIT
 ;
SETUP() ; Setup "limit" variables... ;HL*1.6*85
 S TYPEINFO=$$TYPEINFO QUIT:TYPEINFO']"" "" ;->
 ;
 S (ERRDTB,ERRDTE,NUMERR)=""
 W !!,"   If you answer NO below, you will be allowed to specify the number of"
 W !,"   errors to be included in the report."
 W !
 S NUMERR=$$YN("Print all errors","No") QUIT:NUMERR']"" "" ;->
 S NUMERR=$S(NUMERR=1:9999999,1:$$NUMERR) QUIT:NUMERR'>0 "" ;->
 I NUMERR=9999999 D
 .  W !!,"   All errors in the date range you specify next will be included"
 .  W !,"   in the report."
 I NUMERR'=9999999 D
 .  W !!,"   The newest ",NUMERR," errors, for every error status, in the date range you"
 .  W !,"   specify next will be included in the report."
 W !!,"The first entry at your site is from ",$$FMTE^XLFDT($O(^HL(772,"B",2840000))),"."
 W !
S1 S ERRDTB=$$DATE("Enter START DATE/TIME",,$$FMADD^XLFDT($$DT^XLFDT,-90)) QUIT:ERRDTB'>0 "" ;->
 W !
 S ERRDTE=$$DATE("Enter END DATE/TIME",ERRDTB,"NOW") QUIT:ERRDTE'>0 "" ;->
 I ERRDTB=ERRDTE D  G S1 ;->
 .  W !!,"You cannot enter the same values for the beginning and ending times!"
 .  W !
 QUIT 1
 ;
NUMERR() ; How many errors, maximum, does user want to see ;HL*1.6*85
 ; HLCSER -- req
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !!,"Enter the maximum number errors to report for every error status."
 W !
 S DIR(0)="N",DIR("A")="Enter maximum number errors/status"
 S DIR("B")=999
 S DIR("?",1)="If you enter '1000' for the maximum number errors/status..."
 S DIR("?",2)=""
 I HLCSER="ALL" D
 .  S DIR("?",3)="... The most recent 1000 errors for every error type will be included in the"
 .  S DIR("?",4)="... report. If two different error types exist, and each error type has"
 .  S DIR("?",5)="... more than 1000 entries, then 2000 errors will be reported."
 .  S DIR("?")="... (I.e., 1000 errors per error type.)"
 I HLCSER'="ALL" D
 .  S DIR("?",3)="... The most recent 1000 errors for the error type you just selected"
 .  S DIR("?")="... will be included in the report."
 D ^DIR
 QUIT $S(Y>0:+Y,1:"")
 ;
DATE(PMT,BDT,PDT) ; Entry of date for looping ;HL*1.6*85
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S BDT=$S($G(BDT)?7N.E:BDT,1:"")
 S DIR(0)="DA^"_$G(BDT)_"::ET"
 I $G(BDT)>0 D
 .  N TXT
 .  S TXT="Enter a date/time after "_$$FMTE^XLFDT(BDT)_"..."
 .  S DIR("?")=TXT
 S DIR("A")=PMT_": "
 I $G(PDT)?7N.E S DIR("B")=$P($$FMTE^XLFDT(PDT),":",1,2)
 I $G(PDT)="NOW" S DIR("B")="NOW"
 D ^DIR
 I Y?7N.E,$G(PMT)="NOW",$G(PDT)="NOW" QUIT 9999999.24 ;->
 QUIT $S(Y>0:+Y,1:"")
 ;
YN(PMT,DEF,FF) ; Generic YES/NO DIR call... ;HL*1.6*85
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 F X=1:1:$G(FF) W !
 S DIR(0)="Y",DIR("A")=PMT
 S:$G(DEF)]"" DIR("B")=DEF
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) "" ;->
 QUIT $S(Y=1:1,1:0)
 ;
TMPLOG ; Reset ^TMP("TMPLOG") data created in ERRRPT to ^TMP("TLOG") format
 ; expected by the browser.  (See DISPLAY^HLCSRPT)
 ; [This subroutine created by HL*1.6*85.]
 N HLCSLN,PROCDT,IEN773
 S HLCSLN=0,PROCDT="zzzzz"
 F  S PROCDT=$O(^TMP("TMPLOG",$J,PROCDT),-1) Q:PROCDT']""  D
 .  S IEN773=":"
 .  F  S IEN773=$O(^TMP("TMPLOG",$J,PROCDT,IEN773),-1) Q:IEN773'>0  D
 .  .  S HLCSLN=HLCSLN+1
 .  .  S ^TMP("TLOG",$J,+HLCSLN)=$G(^TMP("TMPLOG",$J,PROCDT,IEN773))
 KILL ^TMP("TMPLOG",$J)
 QUIT
 ;
OKDATE(IEN773,DTBEG,DTEND) ; Does 773 processing time fall in date range?  ;HL*1.6*85
 N PROCDT
 ;
 ; Check what's passed in...
 QUIT:'$D(^HLMA(+IEN773,0)) "" ;->
 QUIT:$G(DTBEG)'?7N.E "" ;->
 QUIT:$G(DTEND)'?7N.E "" ;->
 ;
 ; Get processing date/time...
 S PROCDT=$$PROCDT(IEN773) QUIT:PROCDT'?7N.E "" ;->
 ;
 ; Compare dates...
 I PROCDT=DTBEG!(PROCDT=DTEND) QUIT 1 ;->
 QUIT:PROCDT<DTBEG "" ;->
 QUIT:PROCDT>DTEND "" ;->
 ;
 QUIT 1
 ;
PROCDT(IEN773) ; Return 773'S processing date (1st), or if not available
 ; return the 772 creation date/time. ;HL*1.6*85
 N PROCDT
 S PROCDT=$P($G(^HLMA(+IEN773,"S")),U) QUIT:PROCDT?7N.E PROCDT ;->
 QUIT $P($G(^HL(772,+$G(^HLMA(+IEN773,0)),0)),U)
 ;
DTORTM(DTB,DTE,PDT) ; Show date or time?
 QUIT $S($E(DTB,1,7)=$E(DTE,1,7):$$TM(PDT),1:$$DT(PDT))
 ;
TM(PDT) ; Show the 5 character hh:mm time
 QUIT $E($P($$FMTE^XLFDT(+PDT),"@",2),1,5)
 ;
DT(PDT) ; Show the 8 character mm/dd/yy date
 QUIT $E(PDT,4,5)_"/"_$E(PDT,6,7)_"/"_$E(PDT,2,3)
 ;
TYPEINFO() ; Display error type or application information?
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !!,"Select the report view now.  There are two report views.  Both list the "
 W !,"internal entry number from the HL7 Message Administration file (#773) entry,"
 W !,"message ID, processing date or time, and logical link.  The two report views"
 W !,"differ in the remainder of the information displayed on the report.  "
 S DIR(0)="S^1:Display message, event, & application data;2:Display error type"
 S DIR("A")="Select data to display",DIR("B")=1
 S DIR("?",1)="Select the data to be displayed in the last few columns of the report after"
 S DIR("?")="the IEN, message ID, processing date or time, and logical link."
 D ^DIR
 QUIT $S(Y>0:+Y,1:"")
 ;
EOR ;HLCSRPT4 - Error Listing code ;3/18/02 10:19
