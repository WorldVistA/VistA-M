PSOHELP1 ;BIR/SAB-OUTPATIENT HELP TEXT/UTILITY ROUTINE 2 ;11/09/92
 ;;7.0;OUTPATIENT PHARMACY;**23,36,88,146,227,222**;DEC 1997;Build 12
 ;External reference ^DIC(19.2 supported by DBIA 1472
 ;External reference ^PSDRUG( supported by DBIA 221
 ;External reference ^PS(55 supported by DBIA 2228
2001 N PSOHLP S PSOHLP(1,"F")="!!"
 S PSOHLP(1)="Enter the lowest prescription number for this site."
 S PSOHLP(2,"F")="!"
 S PSOHLP(2)="If this is the first time you are entering this field,"
 S PSOHLP(3,"F")="!"
 S PSOHLP(3)="you should pick a number LARGER than the last prescription number used."
 S PSOHLP(4,"F")="!!"
 D WRITE
 Q
 ;
2002 N PSOHLP S PSOHLP(1,"F")="!!"
 S PSOHLP(1)="Enter the largest acceptable prescription number for this site."
 S PSOHLP(2,"F")="!"
 S PSOHLP(2)="The difference between this number and the lowest prescription"
 S PSOHLP(3,"F")="!"
 S PSOHLP(3)="number should be substantial. The system will not allow numbers"
 S PSOHLP(4,"F")="!"
 S PSOHLP(4)="larger than the one you choose. It will give a warning message"
 S PSOHLP(5,"F")="!"
 S PSOHLP(5)="and not allow entry of any more prescriptions."
 S PSOHLP(6,"F")="!!"
 D WRITE
 Q
 ;
2003 N PSOHLP S PSOHLP(1,"F")="!!"
 S PSOHLP(1)="Enter the last prescription number used."
 S PSOHLP(2,"F")="!"
 S PSOHLP(2)="If you are entering this for the first time, this number"
 S PSOHLP(3,"F")="!"
 S PSOHLP(3)="should be the same as the number you entered for LOW RX#."
 S PSOHLP(4,"F")="!"
 S PSOHLP(4)="The system will take this number, increment it by one"
 S PSOHLP(5,"F")="!"
 S PSOHLP(5)="until it finds a number that has not been used, and then"
 S PSOHLP(6,"F")="!"
 S PSOHLP(6)="use that number for the next prescription."
 S PSOHLP(7,"F")="!!"
 D WRITE
 Q
WRITE ;EN^DDIOL call
 D EN^DDIOL(.PSOHLP) K PSOHLP
 Q
AUTOQ ;entry point to queue all background jobs
 D:0 RESET1^PSOTPHL1  ;placed out of order by PSO*7*227
 D AUTO^PSOAUTOC ;ques auto cancel job
 D SETUP^PSOAUTOC ;ques nightly cost compile
 D SETUP1^PSOAUTOC ;ques nightly mgmt compile
 D QUP,CLO ;ques amis compile
 D SETUP^PSOHLEXP ;ques exipration status update
 D AUTO^PSOSUDEL ;ques job to deleted rxs printed from 52.5
CLO K Y,C,D,D0,DI,DQ,DA,DIE,DR,DIC,Y,X,PSOTM,PSOOPTN,%DT,PSOPTN
 Q
QUP K %DT,DIC,DTOUT S DIC(0)="XZM",DIC="^DIC(19.2,",X="PSO AMIS COMPILE" D ^DIC
 I +Y>0 D EDIT^XUTMOPT("PSO AMIS COMPILE") G CLO
 D RESCH^XUTMOPT("PSO AMIS COMPILE","","","24H","L"),EDIT^XUTMOPT("PSO AMIS COMPILE")
 Q
EXP ;reset "P","A" xref in 55 from cancel option
 Q:$G(REA)="C"
 S PCD=+$P($G(^PSRX(DA,3)),"^",5) I 'PCD D  K EXP,PCD,IFN Q
 .S (IFN,EXP)=0
 .F  S EXP=$O(^PS(55,PSODFN,"P","A",EXP)) Q:'EXP  F  S IFN=$O(^PS(55,PSODFN,"P","A",EXP,IFN)) Q:'IFN  I IFN=DA K ^PS(55,PSODFN,"P","A",EXP,DA) S ^PS(55,PSODFN,"P","A",$P(^PSRX(DA,2),"^",6),DA)=""
 K ^PS(55,PSODFN,"P","A",PCD,DA) S ^PS(55,PSODFN,"P","A",$P(^PSRX(DA,2),"^",6),DA)="",$P(^PSRX(DA,3),"^",5)=""
 K PCD Q
SREF ;set "P","A" xref in 55 from fileman
 I $P($G(^PSRX(X,"STA")),"^")=12,'$P($G(^PSRX(X,3)),"^",5) D  Q
 .F PX=0:0 S PA=$O(^PSRX(X,"A",PX)) Q:'PX  S:$P(^PSRX(X,"A",PX,0),"^",2)="C" PCD=$P($P(^PSRX(X,"A",PX,0),"^"),".")
 .I $G(PCD) S ^PS(55,DA(1),"P","A",PCD,X)="",$P(^PSRX(X,3),"^",5)=PCD
 .E  S:$P($G(^PSRX(X,2)),"^",6) ^PS(55,DA(1),"P","A",$P(^PSRX(X,2),"^",6),X)=""
 .K PCD,PX
 I $P($G(^PSRX(X,"STA")),"^")=12,$P($G(^PSRX(X,3)),"^",5) S ^PS(55,DA(1),"P","A",$P(^PSRX(X,3),"^",5),X)="" Q
 S:$P($G(^PSRX(X,2)),"^",6) ^PS(55,DA(1),"P","A",$P(^PSRX(X,2),"^",6),X)=""
 Q
KREF ;kill "P","A" xref in 55 from fileman
 K:+$P($G(^PSRX(X,2)),"^",6) ^PS(55,DA(1),"P","A",+$P(^PSRX(X,2),"^",6),X)
 I $P($G(^PSRX(X,"STA")),"^")=12,'$P($G(^PSRX(X,3)),"^",5) D  K PCD,PX Q
 .F PX=0:0 S A=$O(^PSRX(X,"A",PX)) Q:'PX  S:$P(^PSRX(X,"A",PX,0),"^",2)="C" PCD=$P($P(^PSRX(X,"A",PX,0),"^"),".")
 .I $G(PCD) K ^PS(55,DA(1),"P","A",PCD,X)
 I $P($G(^PSRX(X,"STA")),"^")=12,$P($G(^PSRX(X,3)),"^",5) K ^PS(55,DA(1),"P","A",$P(^PSRX(X,3),"^",5),X)
 Q
DAYS K PSMAX I $P($G(^PSDRUG(+$P(^PSRX(DA,0),"^",6),0)),"^",4),$P(^PSRX(DA,0),"^",7)/X>$P($G(^PSDRUG(+$P(^PSRX(DA,0),"^",6),0)),"^",4) D EN^DDIOL("Max Daily Dose of "_$P($G(^(0)),"^",4)_" Exceeded","","$C(7),!?5") D EN^DDIOL(" ","","!")
 S PSDAYS=$P(^PSRX(DA,0),"^",8),PSRF=+$P(^(0),"^",9),PTST=$G(^PS(53,$P(^(0),"^",3),0)),PTDY=$P(PTST,"^",3),PTRF=$P(PTST,"^",4),PSODEA=$P(^PSDRUG($P(^PSRX(DA,0),"^",6),0),"^",3),CS=0
 D NARC I $G(CLOZPAT)=1,'PSRF,X>14 K X D EN^DDIOL("     14 Day Supply Max for Clozapine Prescriptions.","","$C(7),!!") Q
 I $G(CLOZPAT)=0,'PSRF,X>7 K X D EN^DDIOL("     7 Day Supply Max for Clozapine Prescriptions.","","$C(7),!!") Q
 I $G(CLOZPAT)=1,X'=7,PSRF K X D EN^DDIOL("     Day Supply Must Equal 7 with 1 refill for Clozapine Prescriptions.","","$C(7),!!") Q
 I $G(CLOZPAT)=1,'PSRF,X>14 K X D EN^DDIOL("     14 Day Supply Max for Clozapine Prescriptions.","","$C(7),!!") Q
 I $G(CLOZPAT)=2,'PSRF,X>28 K X D EN^DDIOL("     28 Day Supply Max for Clozapine Prescriptions.","","$C(7),!!") Q
 I $G(CLOZPAT)=2,PSRF=1,X>14 K X D EN^DDIOL("     Day Supply Must Equal 14 with 1 refill for Clozapine Prescriptions.","","$C(7),!!") Q
 I $G(CLOZPAT)=2,PSRF=3,X>7 K X D EN^DDIOL("     Day Supply Must Equal 7 with 3 refill for Clozapine Prescriptions.","","$C(7),!!") Q
 I PSRF>MAX S DS=X D
 .D FULL^VALM1,EN^DDIOL(PSRF_" refills are not correct for a "_DS_" day supply.","","$C(7),!!") D EN^DDIOL("Please enter correct # of refills for a "_DS_" day supply. Max refills allowed is "_MAX_".","","!") D EN^DDIOL(" ","","!")
 .K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,X,Y,DIRUT S VALMBCK="R"
 K PSTMAX,DS D EDSTAT^PSOUTLA
 K MAX,DAYS,PSDAYS,PSODEA,PSOX,PSOX1,PSDY,PSDY1,DEA,CS,PTST,PSRF,PTRF,PTDY
 Q
DAYS1 K PSRMAX S PSRF=$P(^PSRX(DA(1),0),"^",9),PTST=$G(^PS(53,$P(^(0),"^",3),0)),PTDY=$P(PTST,"^",3),PTRF=$P(PTST,"^",4)
 S PSDAYS=$P(^PSRX(DA(1),1,DA,0),"^",10),PSODEA=$P(^PSDRUG($P(^PSRX(DA(1),0),"^",6),0),"^",3),CS=0
 D NARC I PSRF>MAX S DS=X D
 .D EN^DDIOL(PSRF_" refills are not correct for a "_DS_" day supply.","","$C(7),!!") D EN^DDIOL("Please enter correct # of refills for a "_DS_" day supply. Max refills allowed is "_MAX_".","","!") D EN^DDIOL(" ","","!")
 .K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR,X,Y,DIRUT S VALMBCK="R"
 K PSTMAX,DS ;D EDSTAT^PSOUTLA
 K MAX,DAYS,PSDAYS,PSODEA,PSOX,PSOX1,PSDY,PSDY1,DEA,CS,PTST,PSRF,PTDY,PTRF
 Q
NARC F DEA=1:1 Q:$E(PSODEA,DEA)=""  I $E(+PSODEA,DEA)>1,$E(+PSODEA,DEA)<6 S CS=1
 I $D(CLOZPAT) S MAX=$S(CLOZPAT=2&($P(^PSRX(DA,0),"^",8)=14):1,CLOZPAT=2&($P(^PSRX(DA,0),"^",8)=7):3,CLOZPAT=1&($P(^PSRX(DA,0),"^",8)=7):1,1:0),MIN=0 Q
 I CS D
 .S PSOX1=$S(PTRF>5:5,1:PTRF),PSOX=$S(PSOX1=5:5,1:PSOX1)
 .S PSOX=$S('PSOX:0,X=90:1,1:PSOX),PSDY1=$S(X<60:5,X'<60&(X'>89):2,X=90:1,1:0) S MAX=$S(PSOX'>PSDY1:PSOX,1:PSDY1)
 E  D
 .S PSOX1=PTRF,PSOX=$S(PSOX1=11:11,1:PSOX1),PSOX=$S('PSOX:0,X=90:3,1:PSOX)
 .S PSDY1=$S(X<60:11,X'<60&(X'>89):5,X=90:3,1:0) S MAX=$S(PSOX'>PSDY1:PSOX,1:PSDY1)
 Q
