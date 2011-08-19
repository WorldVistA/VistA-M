ONCP2P8B ;HINES CIOFO/GWB - 1998 Prostate Cancer Study - print ;6/1/98
 ;;2.11;ONCOLOGY;**18,22**;Mar 07, 1995
V S TABLE="TABLE V - FIRST RECURRENCE"
 I IOST'?1"C".E W !
 W !?4,TABLE,!?4,"--------------------------" D P Q:EX=U
 W !,"64. DATE OF FIRST RECURRENCE.........: ",ONC(165.5,IE,70) D P Q:EX=U
 W !,"65. TYPE OF FIRST RECURRENCE.........: ",ONC(165.5,IE,71) D P Q:EX=U
VI S TABLE="TABLE VI - STATUS AT LAST CONTACT"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HEAD^ONCP2P0
 W !!?4,TABLE,!?4,"---------------------------------" D P Q:EX=U
 S DLC="" I $D(^ONCO(160,ONCOPA,"F","B")) S DLC=$O(^ONCO(160,ONCOPA,"F","B",""),-1)
 I DLC'="" S Y=DLC D DATEOT^ONCOPCE S DLC=Y
 W !,"66. DATE OF LAST CONTACT OR DEATH....: ",DLC
 W !,"67. VITAL STATUS.....................: ",ONC(160,ONCOPA,15) D P Q:EX=U
 S CS="" I $D(^ONCO(165.5,IE,"TS","AA")) D
 .S CSDAT=$O(^ONCO(165.5,IE,"TS","AA",""))
 .S CSI=$O(^ONCO(165.5,IE,"TS","AA",CSDAT,""))
 .S CSPNT=$P(^ONCO(165.5,IE,"TS",CSI,0),U,2)
 .S:CSPNT'="" CS=$P(^ONCO(164.42,CSPNT,0),U,1)
 W !,"68. CANCER STATUS....................: ",CS
 W !,"69. COMPLETED BY.....................: ",ONC(165.5,IE,81) D P Q:EX=U
 W !,"70. REVIEWED BY CANCER COMMITTEE.....: ",ONC(165.5,IE,82) D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR
KILL ;Kill Variables and Exit
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILN,ONCOBL,EX,TXT,X,Y,SCTI
 Q
P ;Display Data
 I ($Y'<(LIN-1)) D  Q:EX=U  W !?4,TABLE_" (continued)",!?4,LINE
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HEAD^ONCP2P0 Q
 Q
