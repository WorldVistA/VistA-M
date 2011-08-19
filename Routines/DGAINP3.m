DGAINP3 ;ALB/RMO - Set-up Utility and Print Inpatient AMIS's 334-341 ; 27 DEC 89 1:37 pm
 ;;5.3;Registration;;Aug 13, 1993
 ;==============================================================
 ;Set-up Utility Global to print inpatient AMIS segments for
 ;a selected Month/Year.
 ;
 ;Input:
 ; DGMYR   -(Optional) Month/Year being printed in internal date format
 ;==============================================================
EN ;Entry point for IMS and MAS Inpatient AMIS 334-341 Print
 I '$D(DGMYR) S DIC("A")="Select AMIS 334-341 MONTH/YEAR: ",DIC="^DGAM(334,",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q:Y<0 S DGMYR=+Y
 S DGPGM="START^DGAINP3",DGVAR="DGMYR" D ZIS^DGUTQ G Q:POP
 ;
START U IO K ^UTILITY($J,"DGAINP") F DGSEG=0:0 S DGSEG=$O(^DGAM(334,DGMYR,"SE",DGSEG)) Q:'DGSEG  D DIV
 D ^DGAINP4
 ;
Q K ^UTILITY($J,"DGAINP"),%,DGAM,DGAM0,DGDIV,DGEND,DGMYR,DGPGM,DGSEG,DGVAR,I,POP W ! D CLOSE^DGUTQ
 Q
 ;
DIV ;Loop through AMIS Segments by Division to set the Utility Global
 S DGEND=$S(DGSEG=334!(DGSEG=336):15,1:14)
 F DGDIV=0:0 S DGDIV=$O(^DGAM(334,DGMYR,"SE",DGSEG,"D",DGDIV)) Q:'DGDIV  I $D(^(DGDIV,0)) S DGAM0=^(0) D SET
 Q
 ;
SET ;Set Utility Global by Month/Year, Segment and Division
 S DGAM="" F I=1:1:DGEND S $P(DGAM,"^",I)=0
 I DGSEG=334 F I=1:1:DGEND S $P(DGAM,"^",I)=$S(I=12:+$P(DGAM0,"^",24),I=13:+$P(DGAM0,"^",I),I>13:+$P(DGAM0,"^",I+4),1:+$P(DGAM0,"^",I+1))
 I DGSEG>334,DGSEG<342 F I=1:1:DGEND S $P(DGAM,"^",I)=$S(I<13:+$P(DGAM0,"^",I+1),I=15:0,1:+$P(DGAM0,"^",I+5))
 S ^UTILITY($J,"DGAINP",DGMYR,DGSEG,DGDIV)=DGAM
 Q
