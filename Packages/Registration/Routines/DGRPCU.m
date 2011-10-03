DGRPCU ;ALB/MRL,BAJ - CONSISTENCY FLAGGER, CHECK EXISTING ; NOV 18, 2005
 ;;5.3;Registration;**653**;Aug 13, 1993;Build 2
 S U="^" D DT^DICRW F I=1:1 S J=$P($T(T+I),";;",2) Q:J']""  W !,J
 D ^DGRPCS G Q:DGCONRUN S Y=$S($D(^DG(43,1,"CON")):$P(^("CON"),"^",6),1:"") I +Y X ^DD("DD") W !!,"LAST RUN COMPLETED:  ",Y
OK W !!,"Do you really want to update existing inconsistent entries" S %=2 D YN^DICN G Q:%=2!(%=-1)
 I '% W !!?4,"Y - If you want me to run through all the entries currently filed in",!?9,"the INCONSISTENT DATA file and verify they're still inconsistent.",!?4,"N - If you wish to QUIT and rethink this action." G OK
 S ION="",DGPGM="ST^DGRPCU",DGVAR="DUZ" D QUE^DGUTQ S IOP="HOME" D ^%ZIS K IOP
Q K DFN,DGCONRUN,DGPGM,DGTIME,DGVAR,I,J,Y,%,%Y,PASS D CLOSE^DGUTQ Q
 ; DG*5.3*653 BAJ Added call to Z07 Consistency checker
ST D H^DGUTL S $P(^DG(43,1,"CON"),"^",5)=DGTIME F DFN=0:0 S DFN=$O(^DGIN(38.5,DFN)) Q:'DFN  D EN^DGRPC S PASS=$$EN^IVMZ07C(DFN)
 D H^DGUTL S $P(^DG(43,1,"CON"),"^",6)=DGTIME G Q
T ;
 ;;This option is designed to loop through the existing entries in the INCONSISTENT
 ;;DATA file and verify that all elements are still inconsistent.  This function
 ;;is necessary because some data may get updated by means where the consistency
 ;;checker isn't automatically run, i.e., VA FileMan.  If you wish to in fact run
 ;;this option simply respond YES when asked and enter the DATE/TIME you wish the
 ;;option to commence running.
 ;
 ;
UPD ;update file 38.5 - called from DG CONSISTENCY CHECK option
 D ON^DGRPC G KVAR^DGRPCE:DGER W !! S DGEDIT=1,DIC="^DGIN(38.6,",DIC(0)="AEQMZ",DIC("S")="I Y'=21" D ^DIC G KVAR^DGRPCE:Y'>0 S DGD=+Y
 S DGL="",$P(DGL,"=",80)="" W !,DGL F I=0:0 S I=$O(^DGIN(38.6,+DGD,"D",I)) Q:'I  W !,^(I,0)
 I "^2^9^10^13^14^22^51^52^53^"[("^"_DGD_"^") W !!,*7,"This check can not be edited.  It is automatically turned ",$S(DGD=2:"OFF",DGD=51:"OFF",1:"ON"),"!",!,DGL G UPDQ
 W !,DGL S (DA,Y)=DGD,DIE=DIC,DR="5;" K DG,DQ D ^DIE
UPDQ K DA,DGD,DGEDIT,DGER,DGL,DR,DIC,DIE,I,X,Y
 G UPD
