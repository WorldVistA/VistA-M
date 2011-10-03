DENTCPM ;ISC2/HCD,JEC-DENTAL CRITICAL PATH APPT. SCHED. AID (CON'T) ; 12/5/88  10:43 AM ;
 ;;VERSION 1.2;;**11**;
ENTER W !!,"Would you like instructions" S %=2 D YN^DICN D:%=0 Q G ENTER:%=0,EXIT:%<0 I %=1 D INST
 S DIC="^DENT(220,",DIC(0)="AELQM",DIC("DR")="" D ^DIC G EXIT:Y<1 S DIE=DIC,DA=+Y,DR="[DENTCPMEDT]" D ^DIE K DIC("DR") G DENTAN:'$D(D1)
 I $D(^DENT(220,DA,9,D1,0)) W:$P(^(0),U,2)="Y" !!!,?5,"***** MAKE SURE PATIENT HAS Rx *****"
DENTAN W !!,"Enter another appointment" S %=1 D YN^DICN D:%=0 Q1 G DENTAN:%=0,ENTER:%=1,EXIT
PRINT S DIC="^DENT(220,",DIC(0)="AEQM" D ^DIC G EXIT:Y<0 S D0=+Y
 I '$D(^DENT(220,D0,9,0)) W !,"Sorry, no appointments have been entered for this patient.",! G DENTPA
 S DIC="^DENT(220,D0,9,",DIC(0)="AEMQ" D ^DIC G DENTPA:Y<0 S D1=+Y
 S %ZIS="MQ" K IO("Q") D ^%ZIS G DENTPA:IO=""
 I $D(IO("Q")) S ZTRTN="QUE^DENTCPM",ZTSAVE("U")="",ZTSAVE("D0")="",ZTSAVE("D1")="" D ^%ZTLOAD K ZTSK,ZTRTN,ZTSAVE G DENTPA
QUE U IO
 W @IOF,!,?26,"DENTAL APPOINTMENT SCHEDULE"
 S DFN=D0 D DEM^VADPT I VAERR=0 S DENTNM=VADM(1),DENTSSN=$P(VADM(2),"^")
 I $D(^DENT(220,D0,9,D1,0)) S L=^(0),Y=$P(L,U,17),DENTRX=$P(L,U,2),L=$P(L,U,3,16)
 F I=1:1:14 S L(I)=$P(L,U,I)
 W !!,"PATIENT: " W:$D(DENTNM) DENTNM W ?39,"SSN: " W:$D(DENTSSN) DENTSSN X ^DD("DD") W ?55,"DATE ENTERED: ",Y,! F I=1:1:80 W "_"
 W !,"APPOINTMENTS",?30,1,?40,1,?50,2,?60,2,?70,3,?76,3
 W !,?11 F I=1:1:33 W ?($X+1),$S(I>9:$E(I,2),1:I)
 W ! F I=1:1:80 W "-"
 W !,"ITEM  PROV",!
 S DENTX="PROPH^^PERIO^^ENDO^^REST^^SURG^^C&B^^PROS"
 F I=5,7,9,1,3,11,13 I L(I) W !,$P(DENTX,U,I) W:L(I+1) ?7,$P(^DENT(220.5,L(I+1),0),U,2) S I1=$S(I=3:12+(2*L(1)),I=11:12+((L(1)+L(3))*2),I=13:12+((L(1)+L(3)+L(11))*2),1:12),DENTL=$S(I=5!(I=7)!(I=9):"+ ",1:"* ") F A=1:1:L(I) W ?I1,DENTL
 S DENTRX=$S(DENTRX="Y":"will",DENTRX="N":"won't",1:"may") W !!!,"The patient "_DENTRX_" be receiving MEDICATION prior to treatment.",! G:$D(ZTSK) EXIT
DENTPA W !!,"Print another Appointment Schedule" S %=2 D YN^DICN D:%=0 Q2 G DENTPA:%=0 I %=1 G PRINT
EXIT X ^%ZIS("C") K %,A,DA,DENTDTE,DENTL,DENTNM,D0,DENTRX,DENTSSN,DENTX,DIC,DIE,DR,G,H,I,I1,L,X,Y,Z K:$D(ZTSK) ^%ZTSK(ZTSK),ZTSK Q
INST W !!!,"This module provides an optimized appointment schedule for individual",!,"patients, based on indicated procedures."
 W !,"General questions such as the patient's name and appointment date are asked",!,"first, then the number of appointments necessary for each procedure and"
 W !,"the provider's ID are asked.  Additional help is available by entering",!,"a question mark during any entry.",! Q
Q W !!,"Enter a 'Y' for 'Yes' if you wish to see additional instructions on how to use",!,"this scheduling aid.  Press return if you do not want additional instructions.",!,"Enter an uparrow (^) to exit this option entirely." Q
Q1 W !!,"Press return if you want to enter another appointment for a patient.",!,"Enter 'N' for 'No' if you do not want to enter another appointment",!,"and wish to exit this option." Q
Q2 W !!,"Enter a 'Y' for 'Yes' if you wish to print an appointment schedule",!,"for another patient or press return to exit this option." Q
