DGRPCR ;ALB/MRL,BAJ - CONSISTENCY FLAGGER, REBUILD FILE ; NOV 16, 2005
 ;;5.3;Registration;**653**;Aug 13, 1993;Build 2
 S U="^" D DT^DICRW F I=1:1 S J=$P($T(T+I),";;",2) Q:J']""  W !,J
 D ^DGRPCS G Q:DGCONRUN S Y=$S($D(^DG(43,1,"CON")):$P(^("CON"),"^",4),1:"") I +Y X ^DD("DD") W !!,"LAST RUN COMPLETED:  ",Y
K W !!,"Do you want to delete the existing entries and rebuild the file" S %=2 D YN^DICN G Q:%=-1 I % S DGKILL=$S(%=1:1,1:0)
 I '% W !!?4,"Y - If you want to remove all existing entries from the INCONSISTENT DATA",!?9,"file and rebuild from scratch.",!?5,"N - If you just want to add newly identified inconsistencies to the",!?9,"existing file." G K
D W !! S %DT="EA",%DT(0)=-DT,%DT("A")="Rebuild for patients seen since what date:  " D ^%DT G Q:Y'>0 S DGDAT=Y,X1=DT,X2=DGDAT D ^%DTC S DGDAY=+X
 I DGDAT=DT W !!?4,"SELECT A DATE IN THE PAST PLEASE!!",*7 G D
OK K %DT W !!,"I'm going to check all patients who were admitted or registered on or after " S Y=DGDAT X ^DD("DD") W !,Y," [Within the Past ",+DGDAY," day",$S(+DGDAY>1:"s",1:""),"]."
 W !,"I will ",$S(DGKILL:"DELETE all existing entries prior to rebuilding",1:"add any new inconsistent data elements to the existing file"),"."
 W !!,"Is this correct" S %=2 D YN^DICN G Q:%=2!(%=-1) I '% W !!?4,"Y - If this is what you want to do.",!?4,"N - If you wish to STOP processing and reconsider this action." G OK
 S ION="",DGPGM="S^DGRPCR",DGVAR="DUZ^DGDAT^DGKILL" D QUE^DGUTQ
Q K %,%DT,DFN,DGCONRUN,DGDAT,DGDAY,DGDD,DGDD1,DGEDCN,DGTIME,DGKILL,DGPGM,DGVAR,I,J,X,X1,X2,Y,^UTILITY($J,"DGINCP"),PASS D CLOSE^DGUTQ Q
S D H^DGUTL S $P(^DG(43,1,"CON"),"^",3)=DGTIME K ^UTILITY($J,"DGINCP")
 I DGKILL K ^DGIN(38.5) S ^DGIN(38.5,0)="INCONSISTENT DATA^38.5P^^0"
 ; DG*5.3*653 BAJ Added call to Z07 Consistency Checks
 F DGDD=DGDAT:0 S DGDD=$O(^DPT("ADIS",DGDD)) Q:'DGDD  F DFN=0:0 S DFN=$O(^DPT("ADIS",DGDD,DFN)) Q:'DFN  D
 . I '$D(^UTILITY($J,"DGINCP",DFN)) S ^UTILITY($J,"DGINCP",DFN)="" D EN^DGRPC S PASS=$$EN^IVMZ07C(DFN)
 F DGDD=DGDAT:0 S DGDD=$O(^DGPM("ATT1",DGDD)) Q:'DGDD  F DGDD1=0:0 S DGDD1=$O(^DGPM("ATT1",DGDD,DGDD1)) Q:'DGDD1  D
 . I $D(^DGPM(+DGDD1,0)) S DFN=$P(^(0),"^",3) I '$D(^UTILITY($J,"DGINCP",DFN)) S ^UTILITY($J,"DGINCP",DFN)="" D EN^DGRPC S PASS=$$EN^IVMZ07C(DFN)
 D H^DGUTL S $P(^DG(43,1,"CON"),"^",4)=DGTIME G Q
T ;
 ;;This routine is used to build the INCONSISTENT DATA file.  I will ask you to
 ;;enter a date and will check all patients who were admitted or were registered
 ;;on or after that date for inconsistencies.  If any exist I will add
 ;;those patients to the INCONSISTENT DATA file for further editing of those
 ;;inconsistencies.  You will also be asked if you wish to delete all the existing
 ;;entries and rebuild the file.  If you answer YES I will kill off all entries
 ;;which are currently in the file and then rebuild based on the date you entered.
 ;;If you answer NO I will simply add the new entries I find to the existing file.
