DGPMRBA ;ALB/MIR - ROOM-BED AVAILABILITY; 9 JAN 89 ; 10/21/03 8:50am
 ;;5.3;Registration;**544**;Aug 13, 1993
OPT ;called from BED AVAILABILITY OPTION
 ;
 W !!,"(A)bbreviated or (E)xpanded Bed Availability Listing?  A//" R X:DTIME G:'$T!(X["^") Q I X="" S X="A" W X
 S Z="^ABBREVIATED^EXPANDED" D IN^DGHELP I %<0 W !!,"ENTER:",!?5,"'A' to see bed availability for a single ward, or",!?5,"'E' for bed availability for multiple wards, by service or",!?9,"a list of all available beds" G OPT
 I X="A" S DGOPT=X D ABB,Q Q
 D ASK2^SDDIV G Q:Y<0 ;get OMA division(s)
WS W !,"Sort by (W)ARD, (S)ERVICE, or (B)EDS:  W//" R X:DTIME G Q:'$T!(X["^") I X="" S X="W" W X
 S Z="^WARD^SERVICE^BEDS" D IN^DGHELP I %<0 D   G WS
 .W !,"ENTER:",!?5,"'W' to see available beds for one, many, or all wards, or",!?5,"'S' to see available beds for one, many, or all services, or",!?5,"'B' to see all available beds and wards which can assign them."
 S DGOPT=X
 I DGOPT="W"!(DGOPT="B") S VAUTNI=1 D WARD^VAUTOMA G Q:Y<0
 G:DGOPT="W" SAD G:DGOPT="B" LDG
 S DIR("A")="Select SERVICE: ",(DIR(0),DGSTR)="SA^A:ALL;M:MEDICINE;S:SURGERY;P:PSYCHIATRY;NH:NHCU;NE:NEUROLOGY;I:INTERMEDIATE MED;R:REHAB MEDICINE;SCI:SPINAL CORD INJURY;D:DOMICILLARY;B:BLIND REHAB;NC:NON-COUNT",DIR("B")="ALL"
 S DIR("?")="Enter desired service for which you would like to see bed availability."
 S DIR("?",1)="CHOOSE FROM:"
 S DIR("?",2)="   A FOR ALL",DIR("?",3)="   M FOR MEDICINE",DIR("?",4)="   S FOR SURGERY",DIR("?",5)="   P FOR PSYCHIATRY",DIR("?",6)="   NH FOR NHCU",DIR("?",7)="   NE FOR NEUROLOGY"
 S DIR("?",8)="   I FOR INTERMEDIATE MED",DIR("?",9)="   R FOR REHAB MEDICINE",DIR("?",10)="   SCI FOR SPINAL CORD INJURY",DIR("?",11)="   D FOR DOMICILLARY",DIR("?",12)="   B FOR BLIND REHAB",DIR("?",13)="   NC FOR NON-COUNT" D ^DIR
 I $D(DTOUT)!$D(DUOUT) K DTOUT,DUOUT G Q
 I Y="A" S DGSV=1 G SAD
 S DGSV=0,DGSV(Y)="",$P(DIR(0),"^",1)=$P(DIR(0),"^",1)_"O",$P(DIR(0),"^",2)=$E($P(DIR(0),"^",2),7,999) K DIR("B")
 F I=2:1:12 S DIR("?",I)=DIR("?",I+1)
 K DIR("?",13) S DIR("A")="Select another SERVICE: "
ASK D ^DIR I $D(DUOUT)!$D(DTOUT) K DUOUT,DTOUT G Q
 I X]"" S DGSV(Y)="" G ASK
SAD W !,"Do you want to display scheduled admissions" S %=1 D YN^DICN G Q:%<0 I '% W !?5,"Respond 'Y'es to display scheduled admissions to the ward.",!?8,"Otherwise, respond 'N'o." G SAD
 S DGSA='(%-1)
LDG W !,"Do you want to display lodgers" S %=1 D YN^DICN G Q:%<0 I '% W !?5,"Respond 'Y'es to display lodgers to the ward.",!?8,"Otherwise, respond 'N'o." G LDG
 S DGLD='(%-1)
 D DESC I %<0 G Q
CONT S DGVARS="DGOPT^VAUTD#^VAUTW#^DGDESC^DGLD^DGSV#^DGSTR",DGPGM="PR^DGPMRBA1" D ZIS^DGUTQ I 'POP D PR^DGPMRBA1
Q K ^UTILITY("DGPMLD",$J),^TMP("DGPMBD",$J),%,DFN,DGA,DGDESC,DGDT,DGFL,DGHOW,DGI,DGJ,DGL,DGLD,DGND,DGNM,DGNOW,DGONE,DGPG,DGPGM,DGOPT,DGR,DGSA,DGSTR,DGSV,DGU,DGVARS,DIC,DIR,I,I1,J,J1,M,POP,W,X,Y,VA,VAUTD,VAUTW,Y,Z W ! D CLOSE^DGUTQ Q
 ;
 ;
ABB ;abbreviated bed availability (single ward only)
 W ! S DIC="^DIC(42,",DIC(0)="AEQMZ" D ^DIC I Y'>0 Q
 D DESC I %<0 G Q
 D NOW^%DTC S DGDT=%
 S W=+Y,(DGA,DGFL,DGL,DGLD)=0,DGSA=1,DGNM=$P(Y(0),"^",1) D ABB^DGPMRBA1
 G ABB
 ;
DESC ;ask to show room-bed descriptions
 W !,"Do you want to display room-bed descriptions" S %=2 D YN^DICN I %<0 Q
 I '% W !?5,"Enter 'Yes' to display the description for vacant beds, otherwise 'No'" G DESC
 S DGDESC=%#2
 Q
