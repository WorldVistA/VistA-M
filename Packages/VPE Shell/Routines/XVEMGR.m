XVEMGR ;DJB/VGL**Process a Range of nodes [02/03/95];2017-08-15  12:46 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
RANGE ;User asked for a range with ":" or ",,"
 ;Set up GLOBAL,START(),END()
 I ZGL'?.E1"(".E D TOP^XVEMGI(ZGL) D  Q
 . Q:XVVT("STATUS")["START"  Q:XVVT("STATUS")["PROT"
 . W !!?1,"No data" D VRR
 NEW END,HOLD,I1,II,GLOBAL,LIMIT,START
 S GLOBAL=$P(ZGL,"(")
 ;Replace variables with their values.
 D VARIABLE^XVEMGR1 I FLAGQ D VRR Q
 ;Process a range with "spaces".
 I NEWSUB[ZDELIM1 D SPACES^XVEMGR1 D:FLAGQ VRR Q
 ;Process a range entered with ":" or ",,".
 D SETPARAM I FLAGQ W !!?1,"Invalid quote marks" D VRR Q
 D START I XVVT("STATUS")'["START",XVVT("STATUS")'["PROT" D  Q
 . W !!?1,"No data" D VRR
 Q
VRR ;Pause screen if VGL was called from VRR.
 I $G(FLAGVPE)["VRR" D PAUSE^XVEMKU(2)
 Q
SETPARAM ;Set starting and ending parameters
 S LIMIT=$L(NEWSUB,ZDELIM) F I=1:1:LIMIT D  Q:FLAGQ  I START(I)'=END(I) S HOLD(I)=START(I)
 . S (START(I),END(I))=$P(NEWSUB,ZDELIM,I)
 . I START(I)[ZDELIM2 D  ;handle ":" range using ZDELIM2
 . . S END(I)=$P(START(I),ZDELIM2,2),START(I)=$P(START(I),ZDELIM2)
 . S:START(I)="" START(I)=0 S:END(I)="" END(I)="zzzzz"
 . S $P(NEWSUB,ZDELIM,I)=START(I)
 . ;Next check validity of any quote marks.
 . I START(I)?1""""1.E1"""" D  Q:FLAGQ
 . . F II=2:1:($L(START(I))-1) Q:$E(START(I),II)'=""""&FLAGQ  I $E(START(I),II)="""" S FLAGQ=FLAGQ=0
 . I END(I)?1""""1.E1"""" D
 . . F II=2:1:($L(END(I))-1) Q:$E(END(I),II)'=""""&FLAGQ  I $E(END(I),II)="""" S FLAGQ=FLAGQ=0
 Q
START ;Move up and down the subscript
 NEW ACTLEV,HLDGLX,HLDEND,LOWLEV,RUNSUB,TEMPSUB,UPLEV
 S FLAGQ=0,(ACTLEV,UPLEV)=LIMIT,LOWLEV=1
 F I=1:1:UPLEV S GLX(I)=START(I)
START1 ;Set each part of subscript to correct value during looping.
 S RUNSUB="" F I=1:1:UPLEV S RUNSUB=RUNSUB_$S($G(HOLD(I))]"":HOLD(I),I=ACTLEV:GLX(I),1:START(I))_$S(I=UPLEV:"",1:ZDELIM)
 ;W !,$$TRAN^XVEMGU(GLOBAL_"("_RUNSUB_")") R XXX ;Used for tracking the subscript when a range was specified.
 D TOP^XVEMGI($$TRAN^XVEMGU(GLOBAL_"("_RUNSUB_")")) Q:FLAGQ!FLAGE
START2 ;Now get new values for RUNSUB
 Q:ACTLEV<LOWLEV
 S TEMPSUB="" F I=1:1:ACTLEV S TEMPSUB=TEMPSUB_$S($G(HOLD(I))]"":HOLD(I),I=ACTLEV:GLX(I),1:START(I))_$S(I=ACTLEV:"",1:ZDELIM)
 S GLX(ACTLEV)=$O(@$$TRAN^XVEMGU(GLOBAL_"("_TEMPSUB_")"))
 I GLX(ACTLEV)="" D RESET G START2
 S HLDGLX=$S(GLX(ACTLEV)["E"!(GLX(ACTLEV)["e"):"ALPH",+GLX(ACTLEV)'=GLX(ACTLEV):"ALPH",1:"NUM")
 S HLDEND=$S(END(ACTLEV)["E"!(END(ACTLEV)["e"):"ALPH",+END(ACTLEV)'=END(ACTLEV):"ALPH",1:"NUM")
 ;Next line converts any single quotes to double quotes
 I HLDGLX="ALPH" S GLX(ACTLEV)=$$QUOTES2^XVEMKU(GLX(ACTLEV)),GLX(ACTLEV)=""""_GLX(ACTLEV)_""""
 I HLDGLX="NUM",HLDEND="NUM",GLX(ACTLEV)>END(ACTLEV) D RESET G START2
 I HLDGLX="ALPH",HLDEND="ALPH",GLX(ACTLEV)]END(ACTLEV) D RESET G START2
 I HLDGLX="ALPH",HLDEND="NUM" D RESET G START2
 I $G(HOLD(ACTLEV))]"" S HOLD(ACTLEV)=GLX(ACTLEV),ACTLEV=UPLEV ;HOLD(ACTLEV) handles ranges like ^DIC(3,,1:200
 G START1
 ;
RESET ;Set HOLD to current value and go back up to UPLEV
 S:$G(HOLD(ACTLEV))]"" HOLD(ACTLEV)=START(ACTLEV)
 S GLX(ACTLEV)=START(ACTLEV),ACTLEV=ACTLEV-1
 Q
