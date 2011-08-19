DGANHD3 ;ALB/RMO - Set-up Utility and Print NHCU and DOM AMIS's 345-346 ; 01 SEP 90 9:20 am
 ;;5.3;Registration;;Aug 13, 1993
 ;==============================================================
 ;Set-up Utility Global to print NHCU and DOM AMIS segments for
 ;a selected Month/Year.
 ;
 ;Input:
 ; DGMYR   -(Optional) Month/Year being printed in internal date format
 ;==============================================================
EN ;Entry point for IMS and MAS Inpatient AMIS 345-346 Print
 I '$D(DGMYR) S DIC("A")="Select AMIS 345-346 MONTH/YEAR: ",DIC="^DGAM(345,",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q:Y<0 S DGMYR=+Y
 S DGPGM="START^DGANHD3",DGVAR="DGMYR" D ZIS^DGUTQ G Q:POP
 ;
START U IO K ^UTILITY($J,"DGANHD") F DGSEG=0:0 S DGSEG=$O(^DGAM(345,DGMYR,"SE",DGSEG)) Q:'DGSEG  D DIV
 D ^DGANHD4
 ;
Q K ^UTILITY($J,"DGANHD"),%,DGAM,DGAM0,DGDIV,DGEND,DGMYR,DGPGM,DGSEG,DGVAR,I,POP W ! D CLOSE^DGUTQ
 Q
 ;
DIV ;Loop through AMIS Segments by Division to set the Utility Global
 S DGEND=17
 F DGDIV=0:0 S DGDIV=$O(^DGAM(345,DGMYR,"SE",DGSEG,"D",DGDIV)) Q:'DGDIV  I $D(^(DGDIV,0)) S DGAM0=^(0) D SET
 Q
 ;
SET ;Set Utility Global by Month/Year, Segment and Division
 S DGAM="" F I=1:1:DGEND S $P(DGAM,"^",I)=0
 F I=1:1:DGEND S $P(DGAM,"^",I)=+$P(DGAM0,"^",I+1)
 S ^UTILITY($J,"DGANHD",DGMYR,DGSEG,DGDIV)=DGAM
 Q
