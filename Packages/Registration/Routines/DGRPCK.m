DGRPCK ;ALB/MRL - CONSISTENCY PURGE ; 11 FEB 1987
 ;;5.3;Registration;;Aug 13, 1993
 S U="^" D DT^DICRW F I=1:1 S J=$P($T(T+I),";;",2) Q:J']""  W !,J
 D ^DGRPCS G Q:DGCONRUN S Y=$S($D(^DG(43,1,"CON")):$P(^("CON"),"^",2),1:"") I +Y X ^DD("DD") W !!,"LAST RUN COMPLETED:  ",Y
OK W !!,"Do You Really want to purge data from this file" S %=2 D YN^DICN G Q:%=2!(%=-1) I '% W !!?4,"Y - If you want to purge data.",!?4,"N - If you don't wish to purge data." G OK
D W !! S %DT="EA",%DT(0)=-DT,%DT("A")="Purge patients not seen since:  " D ^%DT G Q:Y'>0 S DGPURG=Y,X1=DT,X2=DGPURG D ^%DTC S DGDAY=+X
 I DGPURG=DT W !!?4,"SELECT A DATE IN THE PAST PLEASE!!",*7 G D
OK1 K %DT W !!,"I'm going to purge all patients from the INCONSISTENT DATA file who haven't been",!,"admitted or registered since " S Y=DGPURG X ^DD("DD") W Y," [",DGDAY," DAY",$S(DGDAY>1:"S",1:"")," AGO]."
 W !!,"Is this correct" S %=2 D YN^DICN G Q:%=2!(%=-1) I '% W !!?4,"Y - To start the purge process.",!?4,"N - To QUIT." G OK1
 S DGPURG=DGPURG-.0000001,ION="",DGPGM="S^DGRPCK",DGVAR="DUZ^DGPURG" D QUE^DGUTQ
Q K %,%DT,DFN,DGCONRUN,DGDAY,DGEDCN,DGKILL,DGTIME,DGPGM,DGPURG,DGVAR,DIK,I,J,X,X1,X2,Y D CLOSE^DGUTQ Q
S D H^DGUTL S $P(^DG(43,1,"CON"),"^",1)=DGTIME
 F DFN=0:0 S DFN=$O(^DGIN(38.5,DFN)) Q:'DFN  D C I DGKILL S DGEDCN=0 D ^DGRPCF1
 D H^DGUTL S $P(^DG(43,1,"CON"),"^",2)=DGTIME G Q
 ;
C S DGKILL=1 I $O(^DGPM("APTT1",DFN,DGPURG)) S DGKILL=0 Q
 S X=$O(^DPT(DFN,"DIS",0)) I 'X Q  ;if no dispositions, purge
 S X=9999999-X I X>DGPURG S DGKILL=0
 Q
T ;
 ;;This routine is used to purge entries from the INCONSISTENT DATA file.  I will
 ;;ask you to enter a date and will check all patients in the INCONSISTENT DATA
 ;;file to see if they have an admission or registration date on file after that
 ;;date.  If not, I will delete that entry from the INCONSISTENT DATA file.
