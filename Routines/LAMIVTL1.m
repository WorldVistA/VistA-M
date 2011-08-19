LAMIVTL1 ;DAL/HOAK 2nd Vitek literal verify rtn
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**12,29**;Sep 27,1994
INIT ;
 S OK=1
 S LREND=0
 D CONTROL
 Q
CONTROL ;
 W @IOF
 D SETUP Q:'OK
 D EXP Q:'OK
 D ^LAMIVTL2
 Q
SETUP ;
 ; Set up variables for PROCESSING
 S LRAN=LRANX
 ;I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN)) S OK=0 QUIT  ;-----Back to Control
 S LRNODE=^LRO(68,LRAA,1,LRAD,1,LRAN,0) S LRACCN=^(.2)
 S LRDFN=+LRNODE
 S LRDPF=$P(LRNODE,U,2)
 S LRLLOC=$P(LRNODE,U,7)
 S LRPHY=$P(LRNODE,U,8)
 S LRODT=$P(LRNODE,U,4)
 S LRSN=$P(LRNODE,U,5)
 ;---------------------------------------------------------------------
 ; Reset LRNODE----------------------------------------------\/
 S LRIDT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,5) S LRNODE=^(3)
 S LRCDT=$P(LRNODE,U)
 S LRDTR=$P(LRNODE,U,3)
 S LREAL=$P(LRNODE,U,2)
 S LRSUB=$P(^LRO(68,LRAA,0),U,2)
 ;----------------------------------------------------------------------
EN ; From LAMIAUT0 BY FHS
 S LRI=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,5,0)) I $D(^(LRI,0)) D
 .  S LRSPEC=+^LRO(68,LRAA,1,LRAD,1,LRAN,5,LRI,0),LRSAMP=+$P(^(0),U,2)
 S DFN=$P(^LR(LRDFN,0),U,3)
 S LRPHYN=$S($D(^VA(200,+LRPHY,0)):$P(^(0),U),1:"Unknown")
 ;----------------------------------------------------------------------
PAT ;
 D PT^LRX
 W !,"ACC # (",LRAN,")    "
 W $$DTF^LRAFUNC1(LRCDT),!!?10,PNM,"   SSN: ",SSN,"   LOC: ",LRLLOC
 W !?5,"Specimen: "
 W $S($D(^LAB(61,+LRSPEC,0)):$P(^(0),U),1:"Unknown")
 W "    Sample: ",$S($D(^LAB(62,+LRSAMP,0)):$P(^(0),U),1:"Unknown"),!
 I $D(^LRO(69,LRODT,1,LRSN,6,+$O(^LRO(69,LRODT,1,LRSN,6,0)),0)) D
 .  W !," Comment on Specimem    "
 S I=0
 F A=0:0 S I=$O(^LRO(69,LRODT,1,LRSN,6,I)) Q:I=""  W ?30,^(I,0),!
 I $D(^LR(LRDFN,"MI",LRIDT,2,+$O(^LR(LRDFN,"MI",LRIDT,2,0)),0)) D
 .  W !,"GRAM STAIN "
 .  S I=0
 .  F A=0:0 S I=$O(^LR(LRDFN,"MI",LRIDT,2,I)) Q:I=""  W ?15,^(I,0),!
 I $D(^LR(LRDFN,"MI",LRIDT,99)) W !,"Comment on Specimen : ",^(99)
 S %=1
 W !!?10,"Is this the correct patient/specimen? "
 D YN^DICN
 I %'=1 S OK=0 QUIT
 QUIT
EXP ; From LAMIAUT4 BY FHS
 ;---------------------------------------------------------------------
 ;Get the list of tests for this ACC.
 W !!,PNM,"   ",SSN,!,LRACCN
 D INF^LRX
 W !!?5,$P(^LAB(61,LRSPEC,0),U),"  ",$P(^LAB(62,LRSAMP,0),U),!
 K ^TMP("LR",$J),LRTEST,LRNAME,LRTS
 S N=0
 F I=0:0 S I=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,I)) Q:I<1  D
 .  S N=N+1,LRTEST(N)=+^(I,0)
 S LRNTN=N
 F I=1:1:N D
 .  S:$D(^LAB(60,+LRTEST(I),0)) LRTEST(I)=LRTEST(I)_U_^(0) D
 ..  S LRNAME(I)=$P(LRTEST(I),U,2)
 ..  S LRNAME(I,+LRTEST(I))=""
 ..  S LRTS(I)=LRNAME(I)
 ..  S LRTS(I,+LRTEST(I))=""
 S LRALL=""
 F I=1:1:LRNTN I $D(LRNAME(I)) D
 .  S LRTS=+$O(LRNAME(I,0))
 .  S LRALL=LRALL_","_I
 .  W !,I,"  ",LRNAME(I) D
 ..  I $D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,+$O(LRNAME(I,0)),0)),$P(^(0),U,5) W ?25," verified" S LRNOTO=1
 ;-----------------------------------------------------------------------
V9 ;
 W !
 S LRALL=$P(LRALL,",",2,99)
 S DIR(0)="F"
 S DIR("A")="Please enter the test number(s) or "
 S DIR("B")="ALL"
 S DIR("?")="Enter ALL, a number, or a range separated by `,' ie 1,2,3."
 D ^DIR
 S:$D(DUOUT)!($D(DTOUT)) OK=0 I 'OK S LREND=1
 S:Y="ALL" Y=LRALL S:Y["A" Y=LRALL
 D RANGE^LRWU2 Q:X9=""  X (X9_"S:'$D(LRNAME(T1)) X=0") I X=0 W !!?7,"Incorrect test number ",$C(7) G EXP
 Q
