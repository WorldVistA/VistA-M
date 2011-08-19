DGSEC2 ;ALB/RMO - Display User Access to Patient Record ; 22 JUN 87 1:00 pm
 ;;5.3;Registration;**391**;Aug 13, 1993
 I '$D(^XUSEC("DG SECURITY OFFICER",DUZ)) W !!?3,*7,"You do not have the appropriate access privileges to display user access." Q
 S DIC("A")="Select PATIENT NAME: ",DIC="^DGSL(38.1,",DIC(0)="AEMQ"
 S DIC("S")="I (+$P(^(0),U,2))!(+$O(^(""D"",0)))",DGSENFLG=""
 W ! D ^DIC K DIC("A"),DIC("S"),DGSENFLG
 G Q:Y<0 S DFN=+Y D DTRNG G Q:DGPOP
ASKUSR K DGUSR W !!,"Do you want to see when a select user accessed this record" S %=2 D YN^DICN G Q:%<0 S:%=2 DGUSR="ALL" I '% W !!,"Enter 'YES' to display a select user, or 'NO' to display all users." G ASKUSR
 I '$D(DGUSR) S DIC="^VA(200,",DIC(0)="AEMQ" W ! D ^DIC G Q:Y<0 S DGUSR=+Y
 S DGPGM="START^DGSEC2",DGVAR="DFN^DGBEGDT^DGENDDT^DGRNG1^DGRNG2^DGUSR" W ! D ZIS^DGUTQ G Q:POP
 ;
START U IO S DGX="",(DGCNT,DGPGE)=0 S:$D(^DPT(DFN,0)) DGNAM=$E($P(^(0),"^",1),1,30),DOB=$P(^(0),"^",3),SSN=$P(^(0),"^",9) D SELUSR:DGUSR,ALLUSR:DGUSR="ALL"
 ;
Q K DFN,DGBEGDT,DGCNT,DGDTE,DGENDDT,DGLNE,DGNAM,DGPGE,DGPOP,DGPGM,DGRNG1,DGRNG2,DGSL0,DGVAR,DGX,POP D CLOSE^DGUTQ
 Q
 ;
SELUSR D CHKDTE I 'DGCNT W @IOF,!!?5,"User ",$S($D(^VA(200,DGUSR,0)):$P(^(0),"^"),1:DGUSR)," did not access the patient record of",!?5,DGNAM,$S(DGRNG1=DGRNG2:" on "_DGRNG1,1:" during "_DGRNG1_" and "_DGRNG2),"."
 Q
 ;
ALLUSR F DGUSR=0:0 S DGUSR=$O(^DGSL(38.1,"AU",DFN,DGUSR)) Q:'DGUSR!(DGX="^")  D CHKDTE
 I 'DGCNT W @IOF,!!?5,"No user access logged for the patient record of ",DGNAM,!?5,$S(DGRNG1=DGRNG2:"on "_DGRNG1,1:"during "_DGRNG1_" and "_DGRNG2),"."
 Q
 ;
CHKDTE F DGDTE=DGENDDT:0 S DGDTE=$O(^DGSL(38.1,"AU",DFN,DGUSR,DGDTE)) Q:'DGDTE!(DGBEGDT<DGDTE)  I $D(^DGSL(38.1,DFN,"D",DGDTE,0)) S DGSL0=^(0),DGCNT=DGCNT+1 D HD:'DGPGE!(($Y+4)>IOSL) Q:DGX="^"  D PRT
 Q
 ;
PRT W !,$S($D(^VA(200,DGUSR,0)):$E($P(^(0),"^"),1,20),1:"Unknown") S Y=$P(DGSL0,"^") W ?23 D DT^DIQ
 W ?46,$S($P(DGSL0,"^",3)]"":$E($P(DGSL0,"^",3),1,20),1:"Unknown"),?70,$P($P(^DD(38.11,4,0),$P(DGSL0,"^",4)_":",2),";",1)
 Q
 ;
HD D CRCHK Q:DGX="^"  W @IOF,!,"Sensitive Patient Access Report for ",DGRNG1," to ",DGRNG2 S DGPGE=DGPGE+1 W ?70,"Page: ",DGPGE
 K DGLNE S $P(DGLNE,"=",80)="" W !,DGLNE,!,"Run Date    : " D H^DGUTL S Y=DGTIME W ?14 D DT^DIQ W ?47,"Social Sec Num: ",$S($D(SSN):SSN,1:"Unknown")
 W !,"Patient Name: ",$S($D(DGNAM):DGNAM,1:"Unknown"),?47,"Date of Birth : " S Y=$S($D(DOB):DOB,1:"Unknown") D DT^DIQ W !,DGLNE
 K DGLNE S $P(DGLNE,"-",80)="" W !!,"USER",?23,"DATE ACCESSED",?46,"OPTION/PROTOCOL USED",?70,"INPATIENT",!,DGLNE
 Q
 ;
CRCHK I DGPGE,$E(IOST,1)="C" W !!,*7,"Press RETURN to continue or '^' to stop " R X:DTIME S DGX=X
 Q
 ;
DTRNG S DGPOP=0 K DGBEGDT,DGENDDT,DGRNG1,DGRNG2 W !!,"**** Date Range Selection ****"
BEGDT W ! S %DT="APEX",%DT("A")="   Beginning DATE : " D ^%DT I Y<0 S DGPOP=1 K %DT Q
 I $D(DGSDFLG),Y>$P(DGSDFLG,"^",2) W *7," ??" G BEGDT
 S %DT(0)=Y,DGBEGDT=9999999.9999-(Y-.0001) X ^DD("DD") S DGRNG1=Y
ENDDT W ! S %DT="APEX",%DT("A")="   Ending    DATE : " D ^%DT I Y<0 S DGPOP=1 K %DT Q
 I $D(DGSDFLG),Y>$P(DGSDFLG,"^",2) W *7," ??" G ENDDT
 S DGENDDT=9999999.9999-(Y+.9999) X ^DD("DD") S DGRNG2=Y W ! K %DT Q
