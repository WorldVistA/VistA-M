RMPFET2 ;DDC/KAW-FREE TEXT PATIENT ADDRESS; [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 ;;input:  RMPFX,DFN,RMPFTYP
 ;;output:  None
 Q:'$P(RMPFSYS,U,2)  Q:$P(^RMPF(791810.1,RMPFTYP,0),U,10)
AD1 W !!,"View patient address? YES// " D READ G END:$D(RMPFOUT)
AD11 I $D(RMPFQUT) W !!,"Enter <Y> to view or edit the patient address information",!?6,"<N> or <RETURN> to continue." G AD1
 G START:Y="",END:"Nn"[Y
START D DISPLAY
ASK F I=1:1 Q:$Y>21  W !
 W !!,"Do you wish to edit the ROES address for this patient? NO// " D READ
 G END:$D(RMPFOUT)
ASK1 I $D(RMPFQUT) W !!,"Enter <Y> is you wish to edit the address for this patient.",!,"If the new address is complete, it will be transmitted to the",!,"DDC instead of the address in the DHCP patient file." G ASK
 S:Y="" Y="N" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G ASK1
 G END:"Nn"[Y W !!
 S DA=RMPFX,DIE="^RMPF(791810,",DR="1.01;1.02;1.03;1.04;1.05;1.06"
 D ^DIE
TEMP W !!,"Is this a <T>emporary or <P>ermanent Address? P// "
 D READ G END:$D(RMPFOUT)
TEMP1 I $D(RMPFQUT) W !!,"Type <T> if this is a temporary address,",!?5,"<RETURN> or <P> if it a permanent address." G TEMP
 S:Y="" Y="P" S Y=$E(Y,1) I "PpTt"'[Y S RMPFQUT="" G TEMP1
 I "Pp"[Y S DA=RMPFX,DIE=791810,DR="1.07////@;1.08////@" D ^DIE G START
 S DIE=791810,DA=RMPFX,DR="1.07;1.08" D ^DIE
 G START
END K AD,ST,BD,T,Z,X,Y,RMPFQUT,DA,DIE,D0,DR,DI,%,%DT,C,D,DIC,DQ,ED,I
 K RMPFA,S,S1,S2,AA,A1,A2,A3,A4,A5,A6,A7,A8,L1,L2,L3,L4,L5,L6,L7,L8
 K RMPFNAM,RMPFSSN,RMPFDOB,RMPFDOD,DISYS,VAERR,VAPA Q
DISPLAY Q:'$D(DFN)  Q:'$D(RMPFX)  D PAT^RMPFUTL,ADD^VADPT
 D SET,DISP
DEND Q
DISP D HEAD
 W !?38,"|",!,"Addr [1]: ",A1,?38,"|",?41,"Addr [1]: ",L1
 W !,"Addr [2]: ",A2,?38,"|",?41,"Addr [2]: ",L2
 W !,"Addr [3]: ",A3,?38,"|",?41,"Addr [3]: ",L3
 W !?4,"City: ",A4,?38,"|",?45,"City: ",L4
 W !?3,"State: ",A5,?38,"|",?44,"State: ",L5
 W !?5,"Zip: ",A6,?38,"|",?46,"Zip: ",L6
 W ! W:A7'="" ?3,"Begin: ",A7 W ?38,"|" I L7'="" W ?44,"Begin: ",L7
 W ! W:A8'="" ?5,"End: ",A8 W ?38,"|" I L8'="" W ?46,"End: ",L8
 W !?38,"|",!?6,$S(A7="":"*** PERMANENT ADDRESS ***",1:"*** TEMPORARY ADDRESS ***"),?38,"|"
 S MG="*** INCOMPLETE ADDRESS ***" I L4=""!(L5="")!(L6="") G WRIT
 S MG="*** PERMANENT ADDRESS ***"
 I L7'=""!(L8'="") S MG="*** TEMPORARY ADDRESS ***"
WRIT W ?47,MG
DISPE W ! F I=1:1:80 W "-"
 K C,MG,I,J Q
SET F I=1:1:8 S @("A"_I)=""
 F I=1:1:4 S @("A"_I)=VAPA(I)
 S A5=$P(VAPA(5),U,2)
 S A6=VAPA(6),A7=$P(VAPA(9),U,2),A8=$P(VAPA(10),U,2)
SET1 F I=1:1:8 S @("L"_I)=""
 G SETE:'$D(^RMPF(791810,RMPFX,1)) S S1=^(1)
 F I=1:1:4 S @("L"_I)=$P(S1,U,I)
 S X=$P(S1,U,5) I X,$D(^DIC(5,X,0)) S X=$P(^(0),U,1) I X'="" S L5=X
 S L6=$P(S1,U,6),L7=$P(S1,U,7) I L7 S Y=L7 D DD^%DT S L7=Y
 S L8=$P(S1,U,8) I L8 S Y=L8 D DD^%DT S L8=Y
SETE F I="A","L" F J=1:1:6 S @(I_J)=$E(@(I_J),1,28)
 K X,I Q
HEAD W @IOF,!?32,"PATIENT ADDRESS"
 W !,"Station:  ",RMPFSTAP,?68,RMPFDAT
 W !,"Patient:  ",$E(RMPFNAM,1,25),?40,"SSN:  ",RMPFSSN,?62,"DOB:  ",RMPFDOB
 W ! F I=1:1:80 W "-"
 W !?10,"DHCP PATIENT FILE",?38,"|",?51,"ROES PATIENT ADDRESS"
 W !?10,"------------------",?38,"|",?51,"---------------------"
 Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
CONT F I=1:1 Q:$Y>21  W !
 W !,"Enter <RETURN> to continue or <^> to exit: " D READ
 Q
