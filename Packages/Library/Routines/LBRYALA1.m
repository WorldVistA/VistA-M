LBRYALA1 ;SSI/ALA-Edit Files ;[ 05/16/94  5:46 PM ]
 ;;2.5;Library;;Mar 11, 1996
 S U="^"
BEG R !,"Enter File: ",AFIL:DTIME Q:AFIL=""
 I AFIL<680!(AFIL>689.99) G BEG
 I '$D(^DIC(AFIL)) W !,"No such file - try again" G BEG
FD R !,"Use a (T)emplate or (S)elect Fields: ",ANS:DTIME G BEG:ANS=""
 I $F("Tt",ANS) D TM
 I $F("Ss",ANS) D SL
 G FD
TM S CT=0,FI="F"_AFIL,DIC=^DIC(AFIL,0,"GL")
 S TPN="" D TP
 I CT=0 W !,"No input templates found" G TM
TE R !,"Select One: ",TNM:DTIME Q:TNM=""
 I TNM'?.N G TE
 I TNM>CT W !,"Not valid" G TE
 S TPN=$P($G(TEM(TNM)),U) I TPN="" W !,"Not found" G TM
 S DIE=DIC,DIC(0)="AEMZ" D ^DIC Q:Y<0  S DA=+Y
 S DR="["_TPN_"]" D ^DIE
 Q
TP S TPN=$O(^DIE(FI,TPN)) Q:TPN=""
 S CT=CT+1,TEM(CT)=TPN_U_$O(^DIE(FI,TPN,""))
 W !,CT,"  ",TPN
 G TP
SL S CT=0,FL=0,DIC=^DIC(AFIL,0,"GL")
 D SP
SE R !,"Select Fields: ",SNM:DTIME Q:SNM=""
SE1 S DIE=DIC,DIC(0)="AEMZ" D ^DIC Q:Y<0  S DA=+Y
 S DR=SNM D ^DIE
 G SE1
SP S FL=$O(^DD(AFIL,FL)) Q:FL'>0
 W !,FL,"  ",$P(^DD(AFIL,FL,0),U)
 G SP
