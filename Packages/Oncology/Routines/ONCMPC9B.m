ONCMPC9B ;HINES CIOFO/GWB - 1999 Melanoma Study - print ;6/1/98
 ;;2.11;ONCOLOGY;**22**;Mar 07, 1995
I W !,"    IMMUNOTHERAPY THERAPY"
 W !,"    ---------------------"
 W !,"72. DATE IMMUNOTHERAPY STARTED......: ",ONC(165.5,IE,55) D P Q:EX=U
 W !,"73. IMMUNOTHERAPY...................: ",ONC(165.5,IE,55.2) D P Q:EX=U
 W ! D P Q:EX=U
 W !,"74. IMMUNOTHERAPEUTIC AGENTS ADMINISTERED:" D P Q:EX=U
 W !,"     VACCINE THERAPY................: ",ONC(165.5,IE,884) D P Q:EX=U
 W !,"     GENE THERAPY...................: ",ONC(165.5,IE,1131) D P Q:EX=U
 W !,"     INTERLEUKIN 2..................: ",ONC(165.5,IE,385) D P Q:EX=U
 W !,"     INTERFERON.....................: ",ONC(165.5,IE,384) D P Q:EX=U
 W !,"     LEVAMISOLE.....................: ",ONC(165.5,IE,791) D P Q:EX=U
 W !,"     COLONY STIMULATING FACTORS.....: ",ONC(165.5,IE,559) D P Q:EX=U
 W !,"     OTHER GIVEN, TYPE UNKNOWN......: ",ONC(165.5,IE,386)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCMPC0 W !?4,TABLE_" (continued)",!?4,LINE G OT
 W ! D P Q:EX=U
OT W !,"    OTHER THERAPY"
 W !,"    -------------"
 W !,"75. DATE OTHER TREATMENT STARTED....: ",ONC(165.5,IE,57) D P Q:EX=U
 W !,"76. OTHER TREATMENT.................: ",ONC(165.5,IE,57.2) D P Q:EX=U
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR Q:'Y  D HEAD^ONCMPC0 G V
 W ! D P Q:EX=U
V S TABLE="TABLE V - FIRST RECURRENCE"
 I IOST'?1"C".E W !
 W !?4,TABLE,!?4,"--------------------------" D P Q:EX=U
 W !,"77. DATE OF FIRST RECURRENCE........: ",ONC(165.5,IE,70) D P Q:EX=U
 W !,"78. TYPE OF FIRST RECURRENCE........: ",ONC(165.5,IE,71) D P Q:EX=U
 W !,"79. OTHER TYPE OF FIRST RECURRENCE..: ",ONC(165.5,IE,71.4) D P Q:EX=U
VI S TABLE="TABLE VI - STATUS AT LAST CONTACT"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HEAD^ONCMPC0
 W !!?4,TABLE,!?4,"---------------------------------" D P Q:EX=U
 S DLC="" I $D(^ONCO(160,ONCOPA,"F","B")) S DLC=$O(^ONCO(160,ONCOPA,"F","B",""),-1)
 I DLC'="" S Y=DLC D DATEOT^ONCOPCE S DLC=Y
 W !,"80. DATE OF LAST CONTACT OR DEATH...: ",DLC
 W !,"81. VITAL STATUS....................: ",ONC(160,ONCOPA,15) D P Q:EX=U
 S CS="" I $D(^ONCO(165.5,IE,"TS","AA")) D
 .S CSDAT=$O(^ONCO(165.5,IE,"TS","AA",""))
 .S CSI=$O(^ONCO(165.5,IE,"TS","AA",CSDAT,""))
 .S CSPNT=$P(^ONCO(165.5,IE,"TS",CSI,0),U,2)
 .S:CSPNT'="" CS=$P(^ONCO(164.42,CSPNT,0),U,1)
 W !,"82. CANCER STATUS...................: ",CS
VII S TABLE="TABLE VII - OTHER INFORMATION"
 I IOST'?1"C".E W ! I ($Y'<(LIN-4)) D HEAD^ONCMPC0
 W !!?4,TABLE,!?4,"-----------------------------" D P Q:EX=U
 W !,"83. COMPLETED BY....................: ",ONC(165.5,IE,81) D P Q:EX=U
 W !,"84. REVIEWED BY CANCER COMMITTEE....: ",ONC(165.5,IE,82)
 I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR
KILL ;Kill Variables and Exit
 K %,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILN,ONCOBL,EX,TXT,X,Y,SCTI
 Q
P ;Display Data
 I ($Y'<(LIN-1)) D  Q:EX=U  W !?4,TABLE_" (continued)",!?4,LINE
 .I IOST?1"C".E W ! K DIR S DIR(0)="E" D ^DIR I 'Y S EX=U Q
 .D HEAD^ONCMPC0 Q
 Q
