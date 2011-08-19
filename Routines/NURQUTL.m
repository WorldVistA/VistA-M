NURQUTL ;HIRMFO/RM-QI SUMMARY UTILITIES ;4/24/96
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
PERFORM(NURQSURV,NURQLOC) ; This function will do a lookup on the
 ; Performance measure multiple and return a valid entry, or -1.
 ;    Input variables:  NURQSURV=IEN in file 217
 ;                       NURQLOC=IEN in 217.04 sub-file (Location)
 ;    Return Value:  IEN in 217.43 sub-file, or -1 if none selected.
 ;                   NURQOUT=1 if user abnormally terminated selection.
 ;
 N NURQFXN S NURQFXN=-1
 K ^TMP($J,"NURQPMS"),^TMP($J,"NURQPMA")
 D GETPM(","_NURQLOC_","_NURQSURV_",")
 S %=$P($G(^SC(+$P($G(^NURQ(217,NURQSURV,2,NURQLOC,0)),"^"),0)),"^"),NURQPLOC=$S(%?1"NUR ".E:$P(%,"NUR ",2),1:%)
REPM ; Label is here so can jump back to reask Performance Measures.
 W !!!,"The following performance measures have been selected for "_NURQPLOC_":"
 D LISTQUES("^TMP($J,""NURQPMS"",") G QPM:NURQOUT
 S Y=$O(^TMP($J,"NURQPMS",9999999),-1) S:$G(NURQDA)>0 Y=""
 W !,"Select PERFORMANCE MEASURE: "_$S(Y]"":Y_"// ",1:"") R X:DTIME
 S:'$T X="^^" S:X=""&$L(Y) X=Y I X="^"!(X="^^") S NURQOUT=1
 I "^^"'[X D  G QPM:NURQOUT,REPM:NURQFXN<0
 .  S NURQX=X,NURQY=Y
 .  S NURQFXN=$P($G(^TMP($J,"NURQPMS",NURQX)),"^",2) Q:NURQFXN>0
 .  S NURQFXN=-1 D:'$D(^TMP($J,"NURQPMA")) GETQUES(","_NURQSURV_",")
 .  S NURQFXN=$P($G(^TMP($J,"NURQPMA",NURQX)),"^",2) Q:NURQFXN>0
 .  S NURQFXN=-1 I NURQX'?1"?".E W !,$C(7),"INVALID ENTRY"
 .  W !,"  Choose from: "
 .  D LISTQUES("^TMP($J,""NURQPMA"",")
 .  Q
QPM ; Quit and exit PERFORM procedure
 K NURQPLOC,NURQX,NURQY,^TMP($J,"NURQPMA"),^TMP($J,"NURQPMS")
 Q NURQFXN
LISTQUES(ARRAY) ; This procedure will list perfmance measures selected so far,
 ; or questions that can be selected.  ARRAY will be set to the list
 ; of performance measures to print.
 N NURQQNO,NURQQUES,NURQTXT,NURQX
 W # S NURQQNO=0 F  S NURQQNO=$O(@(ARRAY_NURQQNO_")")) Q:NURQQNO'>0  D
 .  S NURQSEQ=+$G(@(ARRAY_NURQQNO_")")) Q:NURQSEQ=""
 .  S NURQX=0 F  S NURQX=$O(@(ARRAY_"""WRITE"","_NURQSEQ_","_NURQX_")")) Q:NURQX'>0  D
 .  .  S NURQTXT=$G(@(ARRAY_"""WRITE"","_NURQSEQ_","_NURQX_")"))
 .  .  W !,NURQTXT
 .  .  I $Y>(IOSL-3) S DIR(0)="E" D ^DIR S:Y NURQOUT=1
 .  .  Q
 .  Q
 Q
GETQUES(NURQIENS) ; This procedure will get the Questions from 748.26
 ; sub-file for the entry defined by NURQIENS (FM DB IENS format).
 ; Data will be returned in the ^TMP($J,"NURQPMA", array.
 K ^TMP("DILIST",$J),^TMP($J,"NURQSEQ")
 D LIST^DIC(748.26,NURQIENS,"","","","","","","","D QUESID^NURQUTL(Y1)")
 K ^TMP($J,"NURQPMA") M ^TMP($J,"NURQPMA")=^TMP($J,"NURQSEQ")
 M ^TMP($J,"NURQPMA","WRITE")=^TMP("DILIST",$J,"ID","WRITE")
 M ^TMP($J,"NURQPMA","DA")=^TMP($J,"DILIST",$J,2)
 K ^TMP("DILIST",$J),^TMP($J,"NURQSEQ")
 Q
GETPM(NURQIENS) ; This procedure will get the Performance Measures from 217.43
 ; sub-file for the entry defined by NURQIENS (FM DB IENS format).
 ; Data will be returned in the ^TMP($J,"NURQPMS", array.
 ;
 K ^TMP("DILIST",$J),^TMP($J,"NURQSEQ")
 D LIST^DIC(217.43,","_NURQLOC_","_NURQSURV_",","","","","","","","","D PMID^NURQUTL")
 K ^TMP($J,"NURQPMS") M ^TMP($J,"NURQPMS")=^TMP($J,"NURQSEQ")
 M ^TMP($J,"NURQPMS","WRITE")=^TMP("DILIST",$J,"ID","WRITE")
 M ^TMP($J,"NURQPMS","DA")=^TMP("DILIST",$J,2)
 K ^TMP("DILIST",$J),^TMP($J,"NURQSEQ")
 Q
PMID ; This procedure is called by Identifier code in LIST^DIC call which
 ; is returning the printable text for the question to be listed for
 ; a particular entry in the Performance Measure (217.43) sub-file.
 ;
 N NURQIENS,NURQREF
 S NURQREF=$P(^(0),"^")
 S NURQIENS=$P(NURQREF,",",4)_","_$P(NURQREF,",",2)_","
 D QUESID(NURQIENS)
 Q
QUESID(NURQIENS) ; This procedure is given the entry in the Question
 ; (748.26) sub-file defined by NURQIENS (in DBS IENS format), will
 ; set the printable text of that question for a LIST^DIC call.
 ;
 N NURQSURV,NURQQUES,NURQDAT,NURQQNO,NURQSEQ,NURQX,NURQY
 D GETS^DIQ(748.26,NURQIENS,".015;.05","","NURQDAT")
 S NURQQNO=$G(NURQDAT(748.26,NURQIENS,.015)) Q:NURQQNO=""
 S NURQSEQ=$O(^TMP("DILIST",$J,1,""),-1) Q:NURQSEQ=""
 S ^TMP($J,"NURQSEQ",NURQQNO)=NURQSEQ_"^"_$P(NURQIENS,",")
 S NURQ1ST=1 K ^UTILITY($J,"W")
 I $O(NURQDAT(748.26,NURQIENS,.05,0)) D
 .  S NURQX=0 F  S NURQX=$O(NURQDAT(748.26,NURQIENS,.05,NURQX)) Q:NURQX'>0  S X=$G(NURQDAT(748.26,NURQIENS,.05,NURQX)) I $G(X)]"" D
 .  .  I NURQ1ST S X=$J(NURQQNO,3)_"    "_X
 .  .  E  S %=$G(^UTILITY($J,"W",8)),X=$G(^UTILITY($J,"W",8,%,0))_X K ^UTILITY($J,"W",8,%,0) S ^UTILITY($J,"W",8)=%-1
 .  .  S DIWL=8,DIWR=IOM-2,DIWF="" D ^DIWP K DIWL,DIWR,DIWF S NURQ1ST=0
 .  .  Q
 .  Q
 E  D
 .  S X=NURQQNO
 .  S DIWL=8,DIWR=IOM-2,DIWF="" D ^DIWP K DIWL,DIWR,DIWF
 .  Q
 S NURQX=0 F  S NURQX=$O(^UTILITY($J,"W",8,NURQX)) Q:NURQX'>0  D
 .  S NURQY=$G(^UTILITY($J,"W",8,NURQX,0))
 .  I NURQY]"" D EN^DDIOL(NURQY,"",$S(NURQX=1:"!?0",1:"!?7"))
 .  Q
 K ^UTILITY($J,"W")
 Q
