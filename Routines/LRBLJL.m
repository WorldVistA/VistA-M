LRBLJL ;AVAMC/REG/CYM - UNIT RELOCATION ;7/7/97  08:32 ;
 ;;5.2;LAB SERVICE;**16,72,79,90,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END,S^LRBLW,CK^LRBLPUS G:Y=-1 END D A^LRBLJL1 G:Y=-1 END S LRB=$O(^LAB(61.3,"C",50710,0)) I 'LRB D EN1^LRBLU
 W !!?30,"Relocation of units",!!?30,LRAA(4) I LRCAPA S X="UNIT RELOCATION" D X^LRUWK G:'$D(X) END
P W ! K LRG,DIC,DIE,DR,DA,C,LRW,V,R,LRV,^TMP($J) D ^LRDPA G:LRDFN=-1 END S LRBL=$S(LRPFN=2:DFN,1:"") D R G P
R D EN^LRBLPUS F X=1:1:4 S LRW(X)=""
 D ^LRBLJL1 I F=0 W $C(7),!!,"No units available for release",!,"Use appropriate options to assign or modify" Q
 I $D(LRG(1)) W $C(7),!!?3,"( # unsatisfactory unit)" K LRG(1)
 I $D(V) W $C(7),!!?3,"( *Expired unit )" K V
 I F=1 S LRV=1 D DIE Q
M W !,"Select (1-",F,"): " R X:DTIME Q:X=""!(X[U)  I X["?" W !,"Enter number(s) from 1 to ",F,!,"For 2 or more selections separate each with a ',' (ex. 1,3,4)",!,"Enter 'ALL' for all units" G M
 I X="ALL" S LR("ALL")=1 D ALL Q
 I X?.E1CA.E!($L(X)>200) W $C(7),!,"No CONTROL CHARACTERS, LETTERS or more than 200 characters allowed" G M
 I '+X W $C(7),!,"START with a NUMBER !!",! G M
 S LRQ=X F LRA=0:0 S LRZ=0,LRV=+LRQ,LRQ=$E(LRQ,$L(LRV)+2,$L(LRQ)) D:LRV A Q:'$L(LRQ)
 Q
A Q:'$D(^TMP($J,LRV))  S A=LRV,LRX=^(A) W !,A,")" D W^LRBLJL1,DIE
 Q
F S DA=9999999-LRW(1) S:'$D(^LRD(65,LRX,3,0)) ^(0)="^65.03DA^^" I '$D(^(DA,0)) S ^LRD(65,LRX,3,DA,0)=LRW(1),X=^LRD(65,LRX,3,0),^(0)="^65.03DA^"_DA_"^"_($P(X,"^",4)+1)
 Q
ALL ; This subroutine detects if a previous Inspection was
 ; Unsatisfactory, then calls up another subroutine to give
 ; a warning message.  It also evaluates each individual unit
 ; within a group selected to be sure that all required testing
 ; is complete and compatible with the patient.
 S (LRZ,LR("STOP"))=0
 F LRC=0:0 S LRC=$O(^TMP($J,LRC)) Q:LRC'>0  Q:LR("STOP")=2  D
 . S LRE=^TMP($J,LRC),LRX=+LRE,(LRZ(LRX),LRR(LRX))=0,L=$P(LRE,U,14) D:"Blood BankBLOOD BANK"[L C
 . I $P(LRE,U,11)="U" W $C(7),!,"Unit unsatisfactory, cannot release." S LRZ(LRX)=1 Q
 . Q:LRZ(LRX)
 . I 'LR("STOP") D T Q
 . I LR("STOP") D
 .. I $D(LRG(LRX)) D PRE Q
 .. S LRK=LRW(1) D F,G S ^LRD(65,LRX,3,DA,0)=LRW(1)_"^"_LRW(2)_"^"_DUZ_"^"_LRW(3)_"^"_LRW(4)_"^"_LRP_"^"_LRBL,^LRD(65,"AL",LRW(1),LRX)=""
 Q
DIE S LRE=^TMP($J,LRV),LRX=+LRE,(LRZ(LRX),LRR(LRX))=0 K ^TMP($J,LRV),Y,LR("CK") I "Blood BankBLOOD BANK"[L D C Q:LRZ(LRX)
 I $P(LRE,"^",11)="U" W $C(7),!,"Unit unsatisfactory, cannot release." S LRR(LRX)=1 Q
T R !!,"DATE/TIME UNIT RELOCATION: NOW//",X:DTIME I '$T!(X[U) S LRR(LRX)=1 Q
 S:X="" X="N" S %DT="ETX",%DT(0)="-N" D ^%DT K %DT S LRW(1)=Y I Y<1!(Y'[".") W $C(7),!?5,"TIME and DATE must be entered, future time not allowed." G T
 I Y<$P(LRE,U,12) W $C(7),!!,"Relocation time must be after DATE/TIME unit assigned " S Y=$P(LRE,U,12) D DT^LRU W "(",Y,")" S LRR(LRX)=1 Q
 D F S DIE="^LRD(65,LRX,3," D CK^LRU Q:$D(LR("CK"))  S DA(1)=LRX,X=$P(LRE,"^",6),LRW(5)=$S("Blood BankBLOOD BANK"[X:1,1:0) S:'LRW(5) LRW(3)=LR(44)
 S DR=".03////^S X=DUZ;.02;S LRW(2)=X;D:X=""U"" I^LRBLJL;S:LRW(2)=""U""&(LRW(5)) Y=0;I 'LRW(5)&(LRW(2)=""U"") D S^LRBLJL;.04;S LRW(3)=X;.05;S LRW(4)=X;.06///^S X=LRP;.07////^S X=LRBL" D ^DIE D FRE^LRU
 I $D(LR("ALL")) S LR("STOP")=1 ; Only enter relocation data once if "ALL"
 I $D(Y)!(LRW(2)="U"&(LRW(5))) D W,CLNP K Y S LR("STOP")=2 Q  ; If incomplete answers given during relocation, gives warning message and deletes current relocation.
 I $D(LRG(LRX)) D PRE,CLNP Q  ; If a previous Unsatisfactory Inspection, gives warning message and deletes current relocation.
 S ^LRD(65,"AL",LRW(1),LRX)="",LRK=LRW(1) D G
 Q
PRE ; Warning message if a unit has had a previous Unsatisfactory Inspection
 N UNIT S UNIT=$P(^LRD(65,LRX,0),U)
 W $C(7),!!,UNIT," has had a previous Unsatisfactory inspection and cannot be relocated.",!!,"Relocation entry <DELETED>",! Q
CLNP ; When indicated, current relocation episode is deleted.
 S DA(1)=LRX,DIK="^LRD(65,"_DA(1)_",3," D ^DIK S LRZ(LRX)=1 Q
C I $D(R),$P(LRE,"^",8)=1,$P(LRE,"^",10)'=1 W ! F Z=0:0 S Z=$O(R(Z)) Q:'Z  I Z'=LRB,'$D(^LRD(65,LRX,70,Z,0)) W !,$P(^LAB(61.3,Z,0),"^"),$E("..............",$X,14),?15,"RBC ANTIGEN" S LRZ(LRX)=1
 I LRZ(LRX) W $C(7),!,"Above antigen(s) not entered in RBC ANTIGEN ABSENT field"
 D:$P(LRE,"^",9)=1 D W:LRZ(LRX) !?3,"for ",$P(LRE,"^",2),?28,"*** UNIT NOT RELOCATED ***",! Q
D S X=$S($D(^LRD(65,+LRE,10)):$P(^(10),"^"),1:"") S:X="ND" X="" I X="" S LRZ(LRX)=1 W $C(7),!,"ABO not rechecked"
 I X]"",X'=$P($P(LRE,"^",4)," ") S LRZ(LRX)=1 W $C(7),!,"ABO recheck different from ABO GROUP"
 S X=$S($D(^LRD(65,+LRE,11)):$P(^(11),"^"),1:"") S:X="ND" X="" I $P($P(LRE,U,4)," ",2)="NEG",X="" S LRZ(LRX)=1 W $C(7),!,"Rh NEG unit not rechecked"
 I X]"",X'=$P($P(LRE,U,4)," ",2) W $C(7),!!?6,"Rh recheck (",X,") different from Rh TYPE (",$P($P(LRE,U,4)," ",2),")" W !?6,"Are you sure you want to relocate unit " S %=2 D YN^LRU S:%'=1 LRZ(LRX)=1
 Q
G W !,$P(LRE,"^",2)," relocated" D:LRCAPA ^LRBLW K Y Q
I W $C(7),"      Are you sure " S %=2 D YN^LRU S:%'=1 Y=.02 Q
S W !?15,$C(7),"***Unsatisfactory unit(s) returned to BLOOD BANK***",! S $P(^LRD(65,LRX,3,DA,0),"^",4)="BLOOD BANK",Y=.05 Q
W W $C(7),!!,"No units with incomplete answers or units to be sent from the blood bank",!,"with unsatisfactory inspections can be relocated. Relocation entry <DELETED>",! Q
END D V^LRU Q
