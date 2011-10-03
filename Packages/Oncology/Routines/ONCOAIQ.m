ONCOAIQ ;WASH ISC/SRR,MLH-CHECK REQUIRED FIELDS & EDIT ;7/20/93  10:26
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;
CK ;Check data
Q ;Q  ;QUIT UNTIL PATCHED
 K DR S P=1,ER=0 F I=0:1:3 S X(I)=$G(^ONCO(165.5,D0,I))
 ;node 0
 S X0=X(0),XD0=$P(X0,U,2),DR=""
X0 F J=3:1:7 I $P(X0,U,J)="" S DR=DR_".0"_J_";",ER=ER+1
 I $P(X0,U,11)="" S DR=DR_2_";",ER=ER+1
 F J=12:1:15 I $P(X0,U,J)="" S DR=DR_"2."_(J-11)_";",ER=ER+1
 F J=16:1:19 I $P(X0,U,J)="" S DR=DR_$S(J=16:3,1:J-12)_";",ER=ER+1
X1 S X1=X(1) F J=1:1:5 I $P(X1,U,J)="" S ER=ER+1 S:J<4 DR=DR_(J+7)_";" I J>3 S DR=DR_$S(J=4:16,1:11)_";"
X2 S X2=X(2),X=18 F J=1,3,5,6,8 S X=X+2 I $P(X2,U,J)="" S DR=DR_X_";",ER=ER+1
 F J=9:1:14 I $P(X2,U,J)="" S DR=DR_(J+20)_";",ER=ER+1
 F J=15,16 I $P(X2,U,J)="" S DR=DR_$S(J=15:34.1,1:34.2)_";",ER=ER+1
 F J=17,18,20 I $P(X2,U,J)="" S DR=DR_(J+18)_";",ER=ER+1
 S X=37 F J=25:1:27 S X=X+.1 I $P(X2,U,J)="" S DR=DR_X_";",ER=ER+1
X3 S X3=X(3) F J=27,28,26 I $P(X3,U,J)="" S DR=DR_$S(J=27:58.1,J=28:59,1:58)_";",ER=ER+1
 S X=50.2 F J=6,7,10,13,16,19,25 S X=X+1 I $P(X3,U,J)="" S DR=DR_$S(J'=7:X,1:51.3)_";",ER=ER+1
 I 'ER R !?30,"Data OK=",Z:3 G EX
 W !?25,"Empty PRIMARY fields = ",ER,!!
 IF P D  G EX:$D(Y),X0
 .  N X S DIE="^ONCO(165.5,",DA=D0,ONCOL=0
 .  L +^ONCO(165.5,DA):0 I $T D ^DIE L -^ONCO(165.5,DA) S P=0,ER=0,DR="",ONCOL=1
 .  I 'ONCOL W !,"This primary is being edited by another user."
 .  K ONCOL
 .  Q
 ;END IF
 ;
CK1 ;Check Patient data
 S ER=0,P=1 F I=0,1 S X(I)=$G(^ONCO(160,XD0,I))
 S X0=X(0),X1=X(1)
XP0 F J=5:1:8 I $P(X0,U,J)="" S DR=DR_(J+2)_";",ER=ER+1
 I $P(X1,U)=0 F J=3:1:5 I $P(X1,U,J)="" S DR=DR_(J+16)_";",ER=ER+1
 I ER,P D
 .W !?25,"Patient file Errors: = ",ER
 .S DIE="^ONCO(160,",DA=XD0,ONCOL=0
 .L +^ONCO(160,DA):0 I $T D ^DIE L -^ONCO(160,DA) S ONCOL=1
 .I 'ONCOL W !,"This primary being edited by another user."
 .K ONCOL
 .G EX:$D(Y)=0 S ER=0,P=0 G XP0
 S ER=0,FU=$P($G(^ONCO(160,XD0,"F",0)),U,3) I FU="" S ER=1 W !?15,"You must register at least ONE Last Contact/Followup",! G EX
 S XX=$O(^ONCO(160,XD0,"F","AA",0)) I XX'="" S XD1=$O(^(XX,0)),LC=^ONCO(160,XD0,"F",XD1,0) F J=1:1:6 I $P(LC,U,J)="" S ER=ER+1
 I ER W !,?10,"Errors in Oncology Patient/Follow-up: ",ER
EX ;EXIT
 I ER S $P(^ONCO(165.5,D0,7),U,2)=0 W !?20,"ABSTRACT Status RESET to Incomplete ",!!
 K DR,DIE,J,C,DA,ER,P,ONCOD
 Q
