YSDX0001 ;DALISC/LJA - Diagnosis Miscellaneous Code ;12/17/93 11:03
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
 ;  Various non-YSDX*-namespaced routines contained code directly
 ;  accessing ^MR or ^YSD(627.8 DSM data.  As much as possible,
 ;  direct access of DSM data should be done in YSDX*-namespaced
 ;  routine.  So, in these instances, code was lifted from
 ;  the non-YSDX* routine locations, moved here, and called from their
 ;  original locations...
 ;
DX1 ;  Called by DX1^YSPROB5 (Profile of Patient, #10 - Short Problem List)
 ;D RECORD^YSDX0001("DX1^YSDX0001") ;Used for testing.  Inactivated in YSDX0001...
 D:$Y+YSSL+1>IOSL CK
 G:YSLFT FIN ;->
 I '$D(^YSD(627.8,"AE","D",YSDFN)) W !!,"NO DSM DIAGNOSES ON FILE" G PHDX
 W !!,"DSM DIAGNOSES:" S L="D",L2="",L1=0
 F  S L1=$O(^YSD(627.8,"AE",L,YSDFN,L1)) Q:'L1  D
 .  F  S L2=$O(^YSD(627.8,"AE",L,YSDFN,L1,L2)) Q:L2=""  D
 .  .  S L3=0
 .  .  F  S L3=$O(^YSD(627.8,"AE",L,YSDFN,L1,L2,L3)) Q:'L3  D VAR
PHDX ;
 ;D RECORD^YSDX0001("PHDX^YSDX0001") ;Used for testing.  Inactivated in YSDX0001...
 D:$Y+YSSL+1>IOSL CK
 G:YSLFT FIN ;->
 I '$D(^YSD(627.8,"AE","I",YSDFN)) W !!,"NO ICD9 DIAGNOSES ON FILE" G FIN
 W !!,"ICD9 DIAGNOSES:" S L="I",L2="",L1=0
 F  S L1=$O(^YSD(627.8,"AE",L,YSDFN,L1)) Q:'L1  D
 .  F  S L2=$O(^YSD(627.8,"AE",L,YSDFN,L1,L2)) Q:L2=""  D
 .  .  S L3=0
 .  .  F  S L3=$O(^YSD(627.8,"AE",L,YSDFN,L1,L2,L3)) Q:'L3  D VAR
 QUIT
 ;
VAR ;
 ;  DSM Diagnosis
 ;D RECORD^YSDX0001("VAR^YSDX0001") ;Used for testing.  Inactivated in YSDX0001...
 ;
 S DX=$P(L2,";",2),DX1=$P(L2,";"),DX2="^"_DX_DX1_","_0_")"
 ;
 I DX["YSD" D
 .  S YSDXN=^YSD(627.7,+DX1,"D")
 ;
 ;
 ;  ICD Diagnosis
 I DX["ICD" D
 .  S YSDXN=$P(@DX2,U,3),YSDXNN=$P(@DX2,U)
 ;
 S Z=$P(^YSD(627.8,L3,0),U,3)
 D DC
 S RDT=Z,ST=$P(^YSD(627.8,L3,1),U,4)
 S ST1=$S(ST="A":"ACTIVE",ST="I":"INACTIVE",1:"UNKNOWN")
 S Z=$P(^YSD(627.8,L3,1),U,5)
 D DC
 S STDT=Z
PLINE ;
 ;D RECORD^YSDX0001("PLINE^YSDX0001") ;Used for testing.  Inactivated in YSDX0001...
 D:$Y+YSSL>IOSL CK
 G:YSLFT FIN ;->
 ;W !,$E(YSDXN,1,55),?63,$J(ST1,8),?72,STDT
 W !,$E(YSDXN,1,52),?55,$J(ST1,12),?69,STDT
 QUIT
 ;
DC ;
 ;D RECORD^YSDX0001("DC^YSDX0001") ;Used for testing.  Inactivated in YSDX0001...
 S Z=$E(Z,1,7) S:Z]"" Z=$$FMTE^XLFDT(Z,"5ZD")
 QUIT
 ;
CK ;
 ;D RECORD^YSDX0001("CK^YSDX0001") ;Used for testing.  Inactivated in YSDX0001...
 I $D(YSNOFORM) D:'YST WAIT QUIT:YSLFT  W:YST @IOF QUIT  ;->
 S:YST&(YSLFT=0) YSCON=1
 D ENFT^YSFORM:YST,WAIT:'YST
 QUIT:YSLFT  ;->
 D:YST ENHD^YSFORM
 X:'YST YSFHDR(1)
 QUIT
WAIT ;
 ;D RECORD^YSDX0001("WAIT^YSDX0001") ;Used for testing.  Inactivated in YSDX0001...
 N DIR,DIRUT,DTOUT,DUOUT
 F I0=1:1:(IOSL-$Y-2) W !
 W:($Y+1)<IOSL !
 S DIR(0)="E"
 D ^DIR K DIR
 S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT),YSLFT=$D(DIRUT)
 W @IOF
 QUIT
 ;
FIN ;
 ;D RECORD^YSDX0001("FIN^YSDX0001") ;Used for testing.  Inactivated in YSDX0001...
 S:YST YSLFT=1
 D:'$D(PROFILE) CK
 QUIT
 ;---------------------------------------------------------------------
RECORD(TXT) ;
 N YSUCT,YSUOPT
 QUIT:$G(TXT)']""  ;->
 S YSUOPT=$S($G(XQY0)']"":"Unknown",1:$P(XQY0,U,1,2))
 I YSUOPT'="Unknown" S YSUOPT=$P(YSUOPT,U,2)_" ["_$P(YSUOPT,U)_"]"
 S YSUCT=$G(^TMP("YSDX","COUNT",+DUZ))+1,^TMP("YSDX","COUNT",+DUZ)=YSUCT
 S ^TMP("YSDX",+$G(DUZ),YSUCT)=$H_U_YSUOPT_"~"_TXT
 QUIT
 ;
EOR ;YSDX0001 - Diagnosis Miscellaneous Code ;11/17/93 14:01
