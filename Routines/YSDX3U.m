YSDX3U ;SLC/DJP/LJA-Utilities for Diagnoses Entered in the MH Medical Record ;12/17/93 14:52
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;D RECORD^YSDX0001("^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 ;
END D END^YSDX3U00 ;->
 QUIT
 ;
LIST ; Called by routines YSDX3, YSDX3A, YSDX3U
 ; List diagnoses on file for a specific patient
 ;D RECORD^YSDX0001("LIST^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 K YSDXN,YSDXNN,YSDXST,YSMOD,YSDXDT,YSNO S N1=0
 I '$O(^YSD(627.8,"AC",YSDFN,0)) D  QUIT  ;->
 .  W !?10,"No diagnoses on file for ",YSNM S YSNO=1
 ;
AXIS1 ;  DSM display
 ;D RECORD^YSDX0001("AXIS1^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 I YSAX=1 D
 .  S L2=0
 .  F  S L2=$O(^YSD(627.8,"AC",YSDFN,L2)) Q:'L2  D
 .  .  S L3=""
 .  .  F  S L3=$O(^YSD(627.8,"AC",YSDFN,L2,L3)) Q:L3=""  I $P(L3,";",2)["YSD"  D SELECTL
AXIS3 ;  ICD9 Display
 ;D RECORD^YSDX0001("AXIS3^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 I YSAX=3 D
 .  S L2=0
 .  F  S L2=$O(^YSD(627.8,"AC",YSDFN,L2)) Q:'L2  D
 .  .  S L3=""
 .  .  F  S L3=$O(^YSD(627.8,"AC",YSDFN,L2,L3)) Q:L3=""  I $P(L3,";",2)["ICD"  D SELECTL
 QUIT
 ;
SELECTL ;
 ;D RECORD^YSDX0001("SELECTL^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 S L4=""
 F  S L4=$O(^YSD(627.8,"AC",YSDFN,L2,L3,L4)) Q:L4=""  D
 .  S L5=0
 .  F  S L5=$O(^YSD(627.8,"AC",YSDFN,L2,L3,L4,L5)) Q:'L5  D STATUS,ALST:YSDTY="A",ILST:YSDTY="I",IRNLST:YSDTY="IRN"
 QUIT
STATUS ;
 ;D RECORD^YSDX0001("STATUS^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 S L9=$P(^YSD(627.8,L5,1),U,2)
 S:L9="i" F1=1
 S:"rn"[L9!($P(^YSD(627.8,L5,1),U,4)="I") F2=1
 QUIT
 ;
ALST ;
 ;D RECORD^YSDX0001("ALST^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 D:L4="A" PLIST
 QUIT
 ;
ILST ;
 ;D RECORD^YSDX0001("ILST^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 D:L9="i" PLIST
 QUIT
 ;
IRNLST ;
 ;D RECORD^YSDX0001("IRNLST^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 D:L4="I" PLIST
 QUIT
 ;
PLIST ;Sets variables for print of list line
 ;
 ;  Axis 1
 ;D RECORD^YSDX0001("PLIST^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 I YSAX=1 D
 .  S P3=$P(L3,";",2)
 .  S P4=$P(L3,";")
 .  S P5="^"_P3_P4_","_0_")"
 .  S P50=@P5
 .  S YSDXN=^YSD(627.7,+P4,"D") ;  Diagnosis name
 .  S YSDXNN=$P(P50,U) ;           ICD#
 ;
 ;  Axis 3
 I YSAX=3 D
 .  S P3=$P(L3,";",2)
 .  S P4=$P(L3,";")
 .  S P5="^"_P3_P4_","_0_")"
 .  S P50=@P5
 .  S YSDXNN=$P(P50,U) ;           Diagnosis name
 .  S YSDXN=$P(P50,U,3) ;          ICD#
 ;
 S YSDXST=$S(L9="v":"VERIFIED",L9="p":"PROVISIONAL",L9="i":"INACTIVE",L9="r":"REFORMULATED",L9="n":"NOT FOUND",L9="ru":"RULE OUT",1:"")
 S Y=$P(^YSD(627.8,L5,0),U,3) D DD^%DT S YSDXDT=Y
 ;
 ;  Modifiers?
 I $D(^YSD(627.8,L5,5)) D
 .  S L7=$P(^YSD(627.8,L5,5,0),U,3)
 .  F I=1:1:L7 S YSMOD(I)=$P(^YSD(627.8,L5,5,I,0),U,3)
 ;
 ;  DXLS?
 S L10=$P($G(^YSD(627.8,L5,1)),U,6) I L10]"" D
 .  S YSDXSTAT="INACTIVATED",Y=$P(^YSD(627.8,L5,1),U,5) D DD^%DT S YSTATDT=Y
 ;
 S N1=N1+1,N2(N1)=$P(L3,";"),N4=0 K YSSTOP
 F N3=1:1 S:P4=N2(N3) N4=N4+1 S:N4>1 YSSTOP=1 Q:N3=N1
 QUIT:$D(YSSTOP)  ;->
 S P1=P1+1 S P2(P1)=L5
PRINT ;
 ;D RECORD^YSDX0001("PRINT^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 Q:YSDTY="IRN"&(L9="i")  ;->
 W !,P1,?3,YSDXNN,!?3,$E(YSDXN,1,75)
 I $D(YSMOD) F I=1:1:L7 I $D(YSMOD(I)) W:$TR(YSMOD(I)," ","")]"" !?8," --- "_YSMOD(I)
 W !?8," --- "_YSDXST,?35,YSDXDT I $D(YSDXSTAT) W !?8," --- "_YSDXSTAT,?35,YSTATDT
 QUIT
 ;
INQ ; Called by routines YSDX3, YSDX3A
 ;D RECORD^YSDX0001("INQ^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 Q:$D(YSNO)  ;->
 K %
 S F3=$S(YSAX=1:" Axes 1 & 2 ",YSAX=3:" Axis 3 ",1:"")
 I $D(F1) W !!,"List INACTIVE diagnoses" S %=2 D YN^DICN K:%=2 F1 S:%=1 YSDTY="I" I %=0 W !!,"YES will list all INACTIVE,",F3,"diagnoses for ",$E(YSNM,1,20),".",! G INQ
 S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) Q:YSTOUT!YSUOUT
 I $D(%) I %=-1 Q
 I $D(F2) D RNQ I YSTOUT!YSUOUT Q
 I $D(F1)!$D(F2) D LIST^YSDX3U I '$D(YSDXN) W !,"No additional",F3,"dx found."
 QUIT
 ;
RNQ ;
 ;D RECORD^YSDX0001("RNQ^YSDX3U") ;Used for testing.  Inactivated in YSDX0001...
 S %=0
 F  Q:$G(%)  W !!,"List REFORMULATED/NOT FOUND diagnoses" S %=2 D
 .  D YN^DICN S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) W !
 .  I '% D
 .  .  W !!,"YES will list, in addition to all INACTIVE"
 .  .  W F3,"diagnoses,",!?3," all REFORMULATED/NOT FOUND"
 .  .  W F3,"diagnoses on file",!?3,"for ",$E(YSNM,1,20),".",!
 I %=2 K F2 QUIT  ;->
 S:%=1 YSDTY="IRN"
 I %=-1 S YSQT=1
 QUIT
 ;
EOR ;YSDX3U - Utilities for Diagnoses in MH Med Record ;6/30/89 09:49
