LRLLS3 ;SLC/RWF - MORE LOAD/WORK LIST CODE ;2/5/91  14:41 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
SHOW D ^LRWU4 Q:LRAN<1
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRACC=^(.2),DFN=$P(^LR(LRDFN,0),U,3),LRDPF=$P(^(0),U,2) D PT^LRX
 W !,LRACC,"  ",PNM,"  ",SSN
 F T=0:0 S T=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,T)) Q:T<1  S X=^(T,0) W !?5,$P(^LAB(60,+X,0),U),?20," "
 G SHOW
SH2 W !?5,$P(^LAB(60,+X,0),U)
 S X=$P(X,U,3) W "  ",$P(^LRO(68.2,+$P(X,";"),0),U)," TRAY:",$P(X,";",2)," CUP:",$P(X,";",3)
 Q
CLEAR ;unload any test that has not been verified, from LRLL3
 F T=0:0 S T=$O(^LRO(68.2,LRINST,1,T)) Q:T<1  D CL1
 S ^LRO(68.2,LRINST,2)="^1^1^^" K T,C,X,Y,Z Q
CL1 F C=0:0 S C=$O(^LRO(68.2,LRINST,1,T,1,C)) Q:C<1  D CL2
 I $O(^LRO(68.2,LRINST,1,T,1,0))="" K ^LRO(68.2,LRINST,1,T)
 Q
CL2 S X=+^LRO(68.2,LRINST,1,T,1,C,0),Y=$P(^(0),U,2),Z=$P(^(0),U,3)
 S I=0 F  S I=$O(^LRO(68.2,LRINST,1,T,1,C,1,I)) Q:I<1  I $D(^LRO(68,X,1,Y,1,Z,4,I,0)),'$P(^(0),U,5) S $P(^LRO(68,X,1,Y,1,Z,4,I,0),U,3)=""
 K ^LRO(68.2,LRINST,1,T,1,C) Q
 Q
EN ;
NWSEQNM ;SET A NEW STARTING SEQUENCE NUMBER
 S DIC=68.2,DIC(0)="AEQ",DIC("S")="I '$P(^(0),U,3)" D ^DIC K DIC G END:Y<1 S LRLL=+Y
NEWNUM W !,"Enter the ""new starting"" sequence number: " R X:DTIME G END:X=""!(X["^") S J=+X
 W !,"Do you really want to wipe out data from ",J," on up" S %=2 D YN^DICN G NEWNUM:%'=1
 L +^LAH(LRLL) F I=J-1:0 S I=$O(^LAH(LRLL,1,I)) Q:I<1  D ZAP^LRVR3
 S ^LAH(LRLL)=J L -^LAH(LRLL)
END K A,DIC,I,J,LRLL,X,Y,Z
 Q
