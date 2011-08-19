PSNUPN ;BIR/WRT-Allows user to lookup one or more entries from NDC/UPN file ; 11/06/98 9:12
 ;;4.0; NATIONAL DRUG FILE;**2,5**; 30 Oct 98
 ; K ^TMP($J,"PSNUPN")
 S PSNFL=0 D EXPLN,DISC F PSNMM=1:1 D START S:'$D(PSNFL) PSNFL=0 Q:PSNFL  Q:$D(DIRUT)
DONE K PSNMM,PSNFL,X,Y,ENT,MNP,MN,NDC1,UPN1,TRAD,INDTE,PSP,PTP,PT,PS,OTRX,ZZ,QQ,XX,GOT,IND,PSNINQ,RT,RTP,VAP,VAPN Q
EXPLN W !!,"This option allows you to pick an NDC or UPN and the corresponding",!,"information from NDC/UPN file will be displayed to the screen. ",! Q
START W !,"Do you want to Inquire on an NDC or UPN:" S DIR(0)="S^N:NDC;U:UPN;",DIR("B")="NDC" D ^DIR Q:$D(DIRUT)  Q:$D(DUOUT)  S PSNINQ=Y(0) D:PSNINQ="NDC" NCODE D:PSNINQ="UPN" UCODE
 Q
NCODE W !!,?5,"When selecting by NDC, use a 12 character format for",!,?5,"the NDC. (i.e., 510000033058)",!! S DIC="^PSNDF(50.67,",DIC(0)="QEA",D="NDC" D IX^DIC K DIC I Y<0 S PSNFL=1 Q
 S ENT=+Y D INFO
 Q
INFO S GOT=^PSNDF(50.67,ENT,0),NDC1=$P(GOT,"^",2),UPN1=$P(GOT,"^",3),MNP=$P(GOT,"^",4),MN=$P(^PS(55.95,MNP,0),"^"),TRAD=$P(GOT,"^",5),INDTE=$P(GOT,"^",7),PSP=$P(GOT,"^",8),PTP=$P(GOT,"^",9),VAP=$P(GOT,"^",6),VAPN=$P(^PSNDF(50.68,VAP,0),"^")
 S OTRX=$P(GOT,"^",10),PS=$P(^PS(50.609,PSP,0),"^"),PT=$P(^PS(50.608,PTP,0),"^"),IND=$S(OTRX="O":"OTC",OTRX="R":"RX",1:"  ") D DSPLY,DSPRT,DSPREV,DSPREV1 W !!
 Q
DSPLY W @IOF W ! I NDC1]"" W "NDC: ",NDC1 W ?45,"OTX/RX Indicator: ",IND
 I UPN1]"" W "UPN: ",UPN1 W ?45,"OTX/RX Indicator: ",IND
 W !,"Manufacturer: ",MN
 I INDTE]"" W ?45,"Inactivation Date: " S Y=INDTE D DD^%DT W Y
 W !,"Trade Name: ",TRAD
 W !,"VA Product Name: ",VAPN
 W !,"Package Size: ",PS,?45,"Package Type: ",PT
 Q
DSPRT I $D(^PSNDF(50.67,ENT,1,0)) W !,"Route of Administration: " F ZZ=0:0 S ZZ=$O(^PSNDF(50.67,ENT,1,ZZ)) Q:'ZZ  S RT=$P(^PSNDF(50.67,ENT,1,ZZ,0),"^") W !,?27,RT
 Q
DSPREV I $D(^PSNDF(50.67,ENT,2,0)) W !,"Previous NDC: " F XX=0:0 S XX=$O(^PSNDF(50.67,ENT,2,XX)) Q:'XX  W !?5,$P(^PSNDF(50.67,ENT,2,XX,0),"^")
 Q
DSPREV1 I $D(^PSNDF(50.67,ENT,3,0)) W !,"Previous UPN: " F QQ=0:0 S QQ=$O(^PSNDF(50.67,ENT,3,QQ)) Q:'QQ  W !?5,$P(^PSNDF(50.67,ENT,3,QQ,0),"^")
 Q
UCODE S DIC="^PSNDF(50.67,",DIC(0)="QEA",D="UPN" D IX^DIC K DIC I Y<0 S PSNFL=1 Q
 S ENT=+Y D INFO
 Q
DISC W !,"***DISCLAIMER: This option is designed to give the user information on a NDC",!,"or UPN entry. Unfortunately, at this time, the UPN field has not been populated"
 W !,"with data. This disclaimer will be removed once the data is entered for this",!,"field.",!! Q
