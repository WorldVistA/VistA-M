DGPTOPCE ;ALB/DWS - PRINT 801 NOT SENT TO PCE REPORT ;5/24/05 1:04pm
 ;;5.3;Registration;**635**;Aug 13, 1993
 N DIR,DIC,BY,FR,TO,L,DIS,Y,DGST,DGEND
 S DIR(0)="D^:DT",DIR("A")="Select Start Date",DIR("B")="T-30" D ^DIR
 K DIR
 I '$D(DIRUT),Y D
 .S DGST=Y,DIR(0)="D^:DT",DIR("A")="Select End Date",DIR("B")="T"
 .W " (",Y(0),")" D ^DIR K DIR
 .I '$D(DIRUT),Y D
 ..W " (",Y(0),")" S DGEND=Y,DIC="^DGPT(",FLDS="[801notsenttopce]"
 ..S BY="[801FIND]",FR(0,1)=DGST,TO(0,1)=DGEND+1 D NOW^%DTC
 ..S Y=DGST D DD^%DT S DGST=Y,Y=DGEND D DD^%DT S DGEND=Y
 ..S DHD="[801HEADER]"
 ..D EN1^DIP
 Q
