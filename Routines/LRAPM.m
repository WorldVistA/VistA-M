LRAPM ;AVAMC/REG/WTY - ANATOMIC PATH MODIFY MICRO/DX ;10/23/04  22:55
 ;;5.2;LAB SERVICE;**72,91,130,231,248,295**;Sep 27, 1994
 ;
 ;Reference to ^%DT supported by IA #10003
 ;Reference to %XY^%RCR supported by IA #10022
 ;Reference to ^DIE supported by IA #10018
 ;Reference to EN^DDIOL supported by IA #10142
 ;
 D A^LRAPD Q:'$D(Y)
 I LRCAPA D @(LRSS_"^LRAPSWK")
 D @LRSS
 S LRB(1)="GROSS DESCRIPTION",LRB(2)="MICROSCOPIC DESCRIPTION"
 S LRB(3)="DIAGNOSIS",LRB(4)="FROZEN SECTION"
 S:'$D(^LRO(69.2,LRAA,2,0)) ^(0)="^69.23A^^"
AK W !!,"Modify data for ",LRH(0)," "
 S %=1 D YN^LRU G:%<1 END
 I %=2 S %DT="AE",%DT(0)="-N",%DT("A")="Enter YEAR: " D ^%DT K %DT G:Y<1 END S LRAD=$E(Y,1,3)_"0000",LRH(0)=$E(Y,1,3)+1700
 I '$D(^LRO(68,LRAA,1,LRAD,0)) W $C(7),!!,"NO ",LRAA(1)," ACCESSIONS IN FILE FOR ",LRH(0),!! G END
W K X,Y R !!,"Select Accession Number/Pt name: ",LRAN:DTIME
 G:LRAN=""!(LRAN[U) END
 I LRAN'?1N.N D PNAME^LRAPDA G:LRAN<1 W D DIE G W
 D REST G W
REST W "  for ",LRH(0) I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W $C(7),!!,"Accession # ",LRAN," for ",LRH(0)," not in ACCESSION file",!! Q
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRLLOC=$P(X,"^",7),LRDFN=+X
 Q:'$D(^LR(LRDFN,0))  S X=^(0) D ^LRUP
 W !,LRP,"  ID: ",SSN
 S LRI=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),"^",5)
 W:$O(^LR(LRDFN,LRSS,LRI,.1,0)) !,"Specimen(s):" F X=0:0 S X=$O(^LR(LRDFN,LRSS,LRI,.1,X)) Q:'X  W !,$P($G(^(X,0)),U)
DIE S X=^LR(LRDFN,LRSS,LRI,0)
 I '$P(X,"^",11),'$P(X,"^",15) W $C(7),!!,"Report not verified.  Do not need to use this option !" Q
ASK D:LRCAPA C^LRAPSWK
 W !?14,"1. MODIFY GROSS DESCRIPTION",!?14,"2. MODIFY MICROSCOPIC DESCRIPTION",!?14,"3. MODIFY DIAGNOSIS" S LRB=3 I LRSS="SP" W !?14,"4. MODIFY FROZEN SECTION" S LRB=4
 W !,"CHOOSE (1-",LRB,"): " R X:DTIME Q:X[U!(X="")
 I X'=+X!(X<1)!(X>LRB) W $C(7),!,"Choose from 1 to ",LRB G ASK
 S LRB=X,LRF=$S(X=1:"1^7",X=2:"1.1^4",X=3:"1.4^5",1:"1.3^6"),LRE=$P(LRF,U,2),LRF=$P(LRF,U)
 I '$D(^LR(LRDFN,LRSS,LRI,LRF)) W $C(7),!!,"There is no ",LRB(LRB)," text to modify !",!,"The report was released before entering text.",!,"Do you still want to continue " S %=2 D YN^LRU Q:%'=1  G A
 W !!,"Are you sure you want to modify ",LRB(LRB)," text " S %=2 D YN^LRU Q:%'=1
A S:'$D(^LR(LRDFN,LRSS,LRI,LRE,0)) ^(0)=LRQ(LRB) S LRT(1)=^(0),(B,C)=0
 F A=0:1 S B=$O(^LR(LRDFN,LRSS,LRI,LRE,B)) Q:'B  S C=B
 S C=C+1
 S ^LR(LRDFN,LRSS,LRI,LRE,0)=$P(LRT(1),"^",1,2)_"^"_C_"^"_($P(LRT(1),"^",4)+1),LRDTMOD=C
 S X="N",%DT="T" D ^%DT
 S ^LR(LRDFN,LRSS,LRI,LRE,LRDTMOD,0)=Y_"^"_DUZ
 S %X="^LR(LRDFN,LRSS,LRI,LRF,",%Y="^LR(LRDFN,LRSS,LRI,LRE,LRDTMOD,1,"
 D %XY^%RCR
 W ! S DR=LRF,DIE="^LR(LRDFN,LRSS,",DA=LRI,DA(1)=LRDFN
 I LRF=1 D
 .S DR=".012;1"
 .S:LRSS="SP" DR(2,63.812)=".01"
 .S:LRSS="CY" DR(2,63.902)=".01;.02"
 .S:LRSS="EM" DR(2,63.202)=".01"
 L +^LR(LRDFN,LRSS,DA):5 I '$T D  Q
 .S MSG="This record is locked by another user.  "
 .S MSG=MSG_"Please try again later."
 .D EN^DDIOL(MSG,"","!!") K MSG
 D ^DIE S X=^LR(LRDFN,LRSS,LRI,0),LRRC=$P(X,"^",10) K X
 L -^LR(LRDFN,LRSS,DA)
 D:LRCAPA C1^LRAPSWK
 S LRC=1 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,LRF,A)) Q:'A  S X=^(A,0) S:'$D(^LR(LRDFN,LRSS,LRI,LRE,LRDTMOD,1,A,0)) LRC=0 Q:'LRC  I X'=^(0) S LRC=0 Q
 I LRC F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,LRE,LRDTMOD,1,A)) Q:'A  S X=^(A,0) I '$D(^LR(LRDFN,LRSS,LRI,LRF,A,0)) S LRC=0 Q
 I LRC D  Q
 . W $C(7),!!,"No changes were made to ",LRB(LRB)
 . K ^LR(LRDFN,LRSS,LRI,LRE,LRDTMOD)
 . S X=^LR(LRDFN,LRSS,LRI,LRE,0),A=$P(X,"^",4),Y=$O(^(0))
 . S ^LR(LRDFN,LRSS,LRI,LRE,0)=$P(X,"^",1,2)_"^"_Y_"^"_$S(A:A-1,1:0)
 S X=^LR(LRDFN,LRSS,LRI,0),Y=$P(X,"^",15),$P(^(0),"^",11)="" S:'Y $P(^(0),"^",15)=$P(X,"^",11)
 I $G(SEX)["F","SPCY"[LRSS D DEL^LRWOMEN ;This sends notificatin to WHP
 ;that a previously verified report has been modified. ;cym 2/20/1999
 D UPDATE^LRPXRM(LRDFN,LRSS,LRI)
 I '$D(^LRO(69.2,LRAA,2,LRAN,0)) D
 .L +^LRO(69.2,LRAA,2):5 I '$T D  Q
 ..S MSG(1)="The final reports queue is in use by another person.  "
 ..S MSG(1,"F")="!!"
 ..S MSG(2)="You will need to add this accession to the queue later."
 ..D EN^DDIOL(.MSG) K MSG
 .S ^LRO(69.2,LRAA,2,LRAN,0)=LRDFN_"^"_LRI_"^"_LRH(0)
 .S X=^LRO(69.2,LRAA,2,0),^(0)=$P(X,"^",1,2)_"^"_LRAN_"^"_($P(X,"^",4)+1)
 .L -^LRO(69.2,LRAA,2)
 Q
SP S LRQ(1)="^63.087DA^^",LRQ(2)="^63.84DA^^",LRQ(3)="^63.085DA^^",LRQ(4)="^63.086DA^^" Q
CY S LRQ(1)="^63.097D^^",LRQ(2)="^63.94DA^^",LRQ(3)="^63.095DA^^" Q
EM S LRQ(1)="^63.0272DA^^",LRQ(2)="^63.242DA^^",LRQ(3)="^63.025DA^^" Q
 ;
END D V^LRU K LRDTMOD Q
