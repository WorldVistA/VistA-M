ONCCPC9B ;HIRMFO/GWB - PCE Study of Colorectal Cancer - Print (continued);4/1/97
 ;;2.11;ONCOLOGY;**11**;Mar 07, 1995
V S TABLE="TABLE V - QUALITY OF LIFE"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HDR^ONCCPC9
 W !?4,TABLE,!?4,"-------------------------" D P Q:EX=U
 W !,"69. WERE OTHER REFERRALS MADE:"
 W !,"      NUTRITIONAL CONSULTATION.......: ",ONC(165.5,IE,796) D P Q:EX=U
 W !,"      OCCUPATIONAL THERAPY...........: ",ONC(165.5,IE,797) D P Q:EX=U
 W !,"      PHYSICAL THERAPY...............: ",ONC(165.5,IE,563) D P Q:EX=U
 W !,"      OSTOMY CONSULTATION............: ",ONC(165.5,IE,798) D P Q:EX=U
 W !,"      PSYCHOSOCIAL...................: ",ONC(165.5,IE,799) D P Q:EX=U
VI S TABLE="TABLE VI - FIRST RECURRENCE"
 W !!?4,TABLE,!?4,"---------------------------" D P Q:EX=U
 W !,"70. DATE OF FIRST RECURRENCE..........: ",ONC(165.5,IE,70) D P Q:EX=U
 W !,"71. TYPE OF FIRST RECURRENCE..........: ",ONC(165.5,IE,71) D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HDR^ONCCPC9 G VII
 D P Q:EX=U
VII S TABLE="TABLE VII - STATUS AT LAST CONTACT"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HDR^ONCCPC9
 W !?4,TABLE,!?4,"----------------------------------" D P Q:EX=U
 S DLC="" I $D(^ONCO(160,ONCOPA,"F","B")) S DLC=$O(^ONCO(160,ONCOPA,"F","B",""),-1)
 I DLC'="" S Y=DLC D DATEOT^ONCOPCE S DLC=Y
 W !,"72. DATE OF LAST CONTACT OR DEATH....: ",DLC
 W !,"73. VITAL STATUS.....................: ",ONC(160,ONCOPA,15) D P Q:EX=U
 S CS="" I $D(^ONCO(165.5,IE,"TS","AA")) D
 .S CSDAT=$O(^ONCO(165.5,IE,"TS","AA",""))
 .S CSI=$O(^ONCO(165.5,IE,"TS","AA",CSDAT,""))
 .S CSPNT=$P(^ONCO(165.5,IE,"TS",CSI,0),U,2)
 .S CS=$P(^ONCO(164.42,CSPNT,0),U,1)
 W !,"74. CANCER STATUS....................: ",CS
 W !,"75. COMPLETED BY.....................: ",ONC(165.5,IE,81) D P Q:EX=U
 W !,"76. REVIEWED BY CANCER COMMITTEE.....: ",ONC(165.5,IE,82) D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR
KILL ;Kill Variables and Exit
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILN,ONCOBL,EX,TXT,X,Y,SCTI
 Q
P ;Display Data
 I ($Y'<(LIN-1)) D  Q:EX=U  W !?4,TABLE_" (continued)",!?4,LINE
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HDR^ONCCPC9 Q
 Q
