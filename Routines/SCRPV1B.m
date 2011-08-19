SCRPV1B ; bp/djb - PCMM Inconsistency Rpt - Print ; 9/13/99 3:23pm
 ;;5.3;Scheduling;**177,231**;AUG 13, 1993
 ;
EN ;
 NEW PAGE,QUIT
 S QUIT=0
 D HD
 D POSITION Q:QUIT
 D PATIENT
 Q
 ;
POSITION ;Print position inconsistencies.
 NEW NUM,POS,TM,TXT
 ;
 W !!,"POSITION INCONSISTENCIES"
 W !,"------------------------",!
 I '$D(^TMP("PCMM POSITION",$J)) W !?3,"No inconsistencies found." Q
 I SCMODE="B" D BRIEFPOS^SCRPV1B1 Q  ;Report type = Brief
 W !?3,"INCONSISTENCY"
 W !?6,"TEAM",?38,"POSITION",!
 ;
 ;Process the POSITION array
 S NUM=0
 F  S NUM=$O(^TMP("PCMM POSITION",$J,NUM)) Q:'NUM!QUIT  D  ;
 . S TXT=$T(TXT+NUM)
 . S TXT=$P(TXT,";",4)
 . I $Y>(IOSL-6) D PAUSE Q:QUIT
 . W !?3,TXT
 . S TM=""
 . F  S TM=$O(^TMP("PCMM POSITION",$J,NUM,TM)) Q:TM=""!QUIT  D
 .. S POS=""
 .. F  S POS=$O(^TMP("PCMM POSITION",$J,NUM,TM,POS)) Q:POS=""!QUIT  D
 ... I $Y>(IOSL-6) D PAUSE Q:QUIT
 ... W !,?6,TM,?38,POS
 Q
 ;
PATIENT ;Print patient inconsistencies
 ;
 I $Y>(IOSL-7) D PAUSE Q:QUIT
 W !!,"PATIENT INCONSISTENCIES"
 W !,"-----------------------",!
 I '$D(^TMP("PCMM PATIENT",$J)) D  Q
 . W !?3,"No inconsistencies found.",!
 I $Y>(IOSL-6) D PAUSE Q:QUIT
 I SCMODE="B" D BRIEFPT^SCRPV1B1 Q  ;Report type = Brief
 I SCMODE="DP" D PATIENT1 Q
 I SCMODE="DT" D PATIENT2 Q
 Q
 ;
PATIENT1 ;Patient printout sorted by patient name.
 NEW DFN,DFNNAM,NUM,POS,SSN,TM,TXT,VAR
 ;
 W !?3,"PATIENT",?41,"SSN"
 W !?6,"INCONSISTENCY"
 W !?9,"TEAM",?41,"POSITION",!
 ;
 ;Process the PATIENT array
 S DFNNAM=""
 F  S DFNNAM=$O(^TMP("PCMM PATIENT",$J,DFNNAM)) Q:DFNNAM=""!QUIT  D  ;
 . S DFN=0
 . F  S DFN=$O(^TMP("PCMM PATIENT",$J,DFNNAM,DFN)) Q:'DFN!QUIT  D  ;
 .. I $Y>(IOSL-6) D PAUSE Q:QUIT
 .. S SSN=$P($G(^DPT(DFN,0)),U,9)
 .. W !?3,DFNNAM,?41,SSN
 .. S NUM=0
 .. F  S NUM=$O(^TMP("PCMM PATIENT",$J,DFNNAM,DFN,NUM)) Q:'NUM!QUIT  D
 ... S VAR=0
 ... ;If number is 8.1, 8.2 or 8.3, substitute in 3 choices below.
 ... I NUM?1"8.".E S VAR=$P(NUM,".",2)
 ... S TXT=$T(TXT+(NUM\1))
 ... S TXT=$P(TXT,";",4)
 ... I VAR D  ;
 .... S VAR=$S(VAR=1:"Team Assignment",VAR=2:"Team",1:"Position")
 .... S TXT=$P(TXT,"[]",1)_VAR_$P(TXT,"[]",2)
 ... I $Y>(IOSL-6) D PAUSE Q:QUIT
 ... ;W !?6,(NUM\1),". ",TXT
 ... W !?6,TXT
 ... S TM=""
 ... F  S TM=$O(^TMP("PCMM PATIENT",$J,DFNNAM,DFN,NUM,TM)) Q:TM=""!QUIT  D
 .... S POS=""
 .... F  S POS=$O(^TMP("PCMM PATIENT",$J,DFNNAM,DFN,NUM,TM,POS)) Q:POS=""!QUIT  D
 ..... I $Y>(IOSL-6) D PAUSE Q:QUIT
 ..... W !?9,TM,?41,POS
 ..... ;
 ..... ;Print 404.43 IEN if SCIEN is set to 1 before calling ^SCRPV1.
 ..... I $G(SCIEN) D  ;
 ...... I $G(^TMP("PCMM PATIENT",$J,DFNNAM,DFN,NUM,TM,POS)) W ?72,^(POS)
 Q
 ;
PATIENT2 ;Patient printout sorted by inconsistency number and then team name.
 NEW DFN,DFNNAM,NUM,POS,SSN,TM,TXT,VAR
 ;
 W !,"INCONSISTENCY"
 W !?3,"TEAM"
 W !?6,"PATIENT",?38,"SSN",?50,"POSITION",!
 ;
 KILL ^TMP("PCMM PATIENT1",$J)
 ;
 ;Reorder PATIENT array
 S DFNNAM=""
 F  S DFNNAM=$O(^TMP("PCMM PATIENT",$J,DFNNAM)) Q:DFNNAM=""  D  ;
 . S DFN=0
 . F  S DFN=$O(^TMP("PCMM PATIENT",$J,DFNNAM,DFN)) Q:'DFN  D  ;
 .. S NUM=0
 .. F  S NUM=$O(^TMP("PCMM PATIENT",$J,DFNNAM,DFN,NUM)) Q:'NUM  D  ;
 ... S TM=""
 ... F  S TM=$O(^TMP("PCMM PATIENT",$J,DFNNAM,DFN,NUM,TM)) Q:TM=""  D
 .... S POS=""
 .... F  S POS=$O(^TMP("PCMM PATIENT",$J,DFNNAM,DFN,NUM,TM,POS)) Q:POS=""  D
 ..... S ^TMP("PCMM PATIENT1",$J,NUM,TM,DFNNAM,DFN,POS)=""
 ;
 ;Process new array
 S NUM=0
 F  S NUM=$O(^TMP("PCMM PATIENT1",$J,NUM)) Q:'NUM!QUIT  D  ;
 . S VAR=0
 . ;If number is 8.1, 8.2 or 8.3, substitute in 3 choices below.
 . I NUM?1"8.".E S VAR=$P(NUM,".",2)
 . S TXT=$T(TXT+(NUM\1))
 . S TXT=$P(TXT,";",4)
 . I VAR D  ;
 .. S VAR=$S(VAR=1:"Team Assignment",VAR=2:"Team",1:"Position")
 .. S TXT=$P(TXT,"[]",1)_VAR_$P(TXT,"[]",2)
 . ;
 . I $Y>(IOSL-6) D PAUSE Q:QUIT
 . W !,TXT
 . ;
 . S TM=""
 . F  S TM=$O(^TMP("PCMM PATIENT1",$J,NUM,TM)) Q:TM=""!QUIT  D  ;
 .. I $Y>(IOSL-6) D PAUSE Q:QUIT
 .. W !?3,TM
 .. S DFNNAM=""
 .. F  S DFNNAM=$O(^TMP("PCMM PATIENT1",$J,NUM,TM,DFNNAM)) Q:DFNNAM=""!QUIT  D  ;
 ... S DFN=0
 ... F  S DFN=$O(^TMP("PCMM PATIENT1",$J,NUM,TM,DFNNAM,DFN)) Q:'DFN!QUIT  D
 .... S POS=0
 .... F  S POS=$O(^TMP("PCMM PATIENT1",$J,NUM,TM,DFNNAM,DFN,POS)) Q:'POS!QUIT  D  ;
 ..... S SSN=$P($G(^DPT(DFN,0)),U,9)
 ..... I $Y>(IOSL-6) D PAUSE Q:QUIT
 ..... W !?6,DFNNAM,?38,SSN,?50,POS
 ;
 KILL ^TMP("PCMM PATIENT1",$J)
 Q
 ;
PAUSE ;Pause the display
 NEW ANS,COL,PGTXT
 S PAGE=PAGE+1
 I $G(ION)="HFS" Q
 S PGTXT="Page: "_PAGE
 S COL=(IOM-$L(PGTXT)-2)
 I $E(IOST,1,2)="P-" W @IOF,!?COL,PGTXT Q
 W !,"<RET> to continue, ^ to quit: "
 R ANS:DTIME S:'$T ANS="^" I ANS["^" S QUIT=1 Q
 W @IOF,!?COL,PGTXT
 Q
 ;
HD ;Heading
 NEW HD,LINE,NOW,TM,TMN
 ;
 S PAGE=1
 S HD="PCMM INCONSISTENCY REPORT"
 ;Adjust heading if going to the P-MESSAGE device
 I IOST["P-",IOST["MESSAGE" D  Q
 . W !?(78-$L(HD)\2),HD
 ;
 I $E(IOST,1,2)="P-" W !!
 E  W @IOF
 S $P(LINE,"=",IOM)=""
 W !?(IOM-$L(HD)\2),HD
 S NOW=$$NOW^XLFDT()
 I $P(NOW,".",2) S NOW=$P(NOW,".",1)_"."_$E($P(NOW,".",2),1,4)
 S HD=$$FMTE^XLFDT(NOW)
 W !?(IOM-$L(HD)\2),HD
 W !,LINE
 I SCTYPE("TM")="I" D  ;
 . W !,"See PCMM User Guide for detailed instructions."
 E  D  ;
 . W !,"Teams: "
 . I SCTYPE("TM")="A" W "All teams"
 . E  D  ;
 .. S TM=0
 .. F  S TM=$O(SCTM(TM)) Q:'TM  D  ;
 ... S TMN=$P($G(^SCTM(404.51,TM,0)),U,1)
 ... S:TMN']"" TMN="UNKNOWN"
 ... I ($L(TMN)+$X+2)>IOM W !?7
 ... W TMN
 ... I $O(SCTM(TM)) W ", "
 W !,LINE
 Q
 ;
TXT ;Inconsistencies
 ;;1;Position has no staff assigned
 ;;2;Patient has no PCP assigned
 ;;3;Patient has multiple PCPs assigned
 ;;4;AP & PCP are the same provider
 ;;5;AP is without a Preceptor
 ;;6;AP position is not designated for PC
 ;;7;PCP position is not designated for PC
 ;;8;Position assignment with inactive []
 Q
