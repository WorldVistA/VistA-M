DGANHD2 ;ALB/RMO - Balance and Save NHCU and DOM AMIS's 345-346 ; 31 AUG 90 3:34 pm
 ;;5.3;Registration;;Aug 13, 1993
 ;==============================================================
 ;When balancing NHCU and DOM AMIS segments the division statistics
 ;are combined.
 ;
 ;Input:
 ; DGMYR   -Month/Year being calculated in internal date format
 ; DGPMYR  -Prior Month/Year in internal date format
 ; DGCODFLG-Code Sheet flag if  1 -generate  0-do not generate
 ; ^UTILITY-Contains stats by Month/Year, Segment and Division
 ;==============================================================
 K DGNOB F DGSEG=0:0 S DGSEG=$O(^UTILITY($J,"DGANHD",DGMYR,DGSEG)) Q:'DGSEG  D SET,BAL,SAVE
 I DGCODFLG,'$D(DGNOB) F DGSEG=0:0 S DGSEG=$O(^DGAM(345,DGMYR,"SE",DGSEG)) Q:'DGSEG  D GEN
 ;
Q K DGAM,DGAM0,DGBALFLG,DGDIV,DGEND,DGNOB,DGPAM,I,J,X
 Q
 ;
SET ;Add up Prior and Current Month AMIS(s) for All Divisions
 S DGEND=17 F I=1:1:DGEND S $P(DGPAM,"^",I)=0,$P(DGAM,"^",I)=0
 F J=0:0 S J=$O(^DGAM(345,DGPMYR,"SE",DGSEG,"D",J)) Q:'J  I $D(^(J,0)) S X=^(0) F I=1:1:DGEND S $P(DGPAM,"^",I)=$P(DGPAM,"^",I)+$P(X,"^",I+1)
 F J=0:0 S J=$O(^UTILITY($J,"DGANHD",DGMYR,DGSEG,J)) Q:'J  S X=^(J) F I=1:1:DGEND S $P(DGAM,"^",I)=$P(DGAM,"^",I)+$P(X,"^",I)
 Q
 ;
BAL ;Balance AMIS Segment and Set Balance Flag to 1
 S DGBALFLG=0 I ($P(DGPAM,"^",9)+$P(DGPAM,"^",10)+$P(DGAM,"^",1)+$P(DGAM,"^",2)+$P(DGAM,"^",3)+$P(DGAM,"^",4))-(+$P(DGAM,"^",5)+$P(DGAM,"^",6)+$P(DGAM,"^",7)+$P(DGAM,"^",8))=($P(DGAM,"^",9)+$P(DGAM,"^",10)) S DGBALFLG=1
 S:'DGBALFLG DGNOB(DGSEG)=""
 Q
 ;
SAVE ;Loop through Segments by Division to Save
 F DGDIV=0:0 S DGDIV=$O(^UTILITY($J,"DGANHD",DGMYR,DGSEG,DGDIV)) Q:'DGDIV  S DGAM=^(DGDIV) D FILE
 Q
 ;
FILE ;Save AMIS Segment Statistics in File
 L ^DGAM(345,DGMYR):1 G:'$T FILE S:'$D(^DGAM(345,DGMYR,"SE",0)) ^(0)="^42.701SA^^"
 I '$D(^DGAM(345,DGMYR,"SE",DGSEG,0)) S ^(0)=DGSEG_"^"_DGBALFLG,$P(^(0),"^",3,4)=DGSEG_"^"_($P(^DGAM(345,DGMYR,"SE",0),"^",4)+1)
 S:'$D(^DGAM(345,DGMYR,"SE",DGSEG,"D",0)) ^(0)="^42.702PA^^"
 S DGAM0=DGDIV_"^"_$P(DGAM,"^",1,17)_"^^"_DT_"^"_DUZ_"^^"
 S ^DGAM(345,DGMYR,"SE",DGSEG,"D",DGDIV,0)=DGAM0 S $P(^(0),"^",3,4)=DGDIV_"^"_($P(^DGAM(345,DGMYR,"SE",DGSEG,"D",0),"^",4)+1) L
 Q
 ;
GEN ;Generate AMIS Code Sheets
 S DGDIV=+$O(^DG(40.8,0)) D QUE^DGGECSA
 Q
