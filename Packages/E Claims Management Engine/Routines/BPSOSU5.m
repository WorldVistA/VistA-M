BPSOSU5 ;BHAM ISC/FCS/DRS/FLS - utilities ;03/07/08  10:39
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;----------------------------------------------------------------------
TOSCREEN()         ;EP; True or False, is output to screen?
 I $E(IOST)'="C" Q 0
 I $D(ZTQUEUED) Q 0
 I IOT'="TRM",IOT'="VTRM" Q 0
 I $D(IO("S")) Q 0
 Q 1
PRESSANY(NLF,TIMEOUT) ;EP
 I '$$TOSCREEN Q
 N X,I
 S NLF=+$G(NLF)
 S:+$G(TIMEOUT)=0 TIMEOUT=30
 F I=1:1:NLF W !
 I $$FREETEXT^BPSOSU2("Press ENTER to continue: ",,1,1,1,300)
 Q
 ;----------------------------------------------------------------------
 ;'Press the return key to continue of ^ to exit:' PROMPT
 ; See also $$EOPQ^BPSOSU8
ENDPAGE(NLF,TIMEOUT) ;EP
 I '$$TOSCREEN Q 1
 N X,Y,I,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S NLF=+$G(NLF)
 F I=1:1:NLF W !
 S:+$G(TIMEOUT)>0 DIR("T")=TIMEOUT
 S DIR(0)="E"
 D ^DIR
 Q $S(Y="":-1,Y=0:"^",1:Y)
 ;----------------------------------------------------------------------
ENDRPT() ; EP
 N RETVAL
 S RETVAL=$$ENDRPT^BPSOSU8() Q
 ;=====================================================================
BYE ; EP
 ; Most routines should come here when they exit.
 ; Example: GOTO BYE^BPSOSU3
 ; IN: FLGSTOP   1=user wanted out
 ;
 I $G(FLGSTOP) W "  < exit >" HANG 1
 D ^%ZISC
 Q
 ;=====================================================================
BOTTOM(LINES) ;07/26/96
 ;  IN:  lines (optional) = lines from the bottom  (default=1)
 ;       This line-feeds down to the bottom of the screen
 ;
 Q:'$G(IOSL)
 N X1,X2,J S LINES=$S($D(LINES):LINES,1:1)
 S X1=($Y+2)
 I X1>(IOSL-LINES) DO
 . S X1=($Y+2)
 S X2=(IOSL-X1) F J=1:1:X2 W !
 Q
 ;=================================================================
