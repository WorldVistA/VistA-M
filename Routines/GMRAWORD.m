GMRAWORD ;HIRMFO/YMP,RM,WAA- WORD DATA TO HISTORICAL STORAGE ;12/1/95  13:45
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
WORD(GMRAPA,COMM,WID) ; PASS THE DATA TO AN ARRAY
 ; Input variables:
 ;     GMRAPA = Reaction IEN in 120.8
 ;       COMM = Kind of comment to display
 ;              O is Originator
 ;              V is Verifier
 ;              E is Entered in Error
 ;      ARRAY = Merge arrat for the text
 ;        WID = Width of the array
 N GMRAYY,GMRACNT,Y,DIWL
 S GMRACNT=1
 F GMRAYY=1:1:$L(COMM) K ^UTILITY($J,"W") D
 .D DISP1(GMRAPA,$E(COMM,GMRAYY),WID) Q:'$D(DIWL)
 .I $D(^UTILITY($J,"W",DIWL)) S ^TMP($J,"GMRAWORD",GMRACNT)=$S($E(COMM,GMRAYY)="E":"ENTERED IN ERROR",$E(COMM,GMRAYY)="V":"VERIFIER",$E(COMM,GMRAYY)="O":"OBSERVER",1:"")_" COMMENTS: ",GMRACNT=GMRACNT+1
 .S Y=0 F  S Y=$O(^UTILITY($J,"W",DIWL,Y)) Q:Y<1  S ^TMP($J,"GMRAWORD",GMRACNT)=$G(^UTILITY($J,"W",DIWL,Y,0)),GMRACNT=GMRACNT+1
 .Q
 Q
DISP1(GMRAPA,GMRAKIND,WID) ;Display comments and reaction for a reaction
 ; Input variables:
 ;     GMRAPA = Reaction IEN in 120.8
 ;   GMRAKIND = Kind of comment to display
 ;              O is Originator
 ;              V is Verifier
 ;              E is Entered in Error
 ;        WID = Width of the array
 I '$D(^GMR(120.8,GMRAPA,26,"AVER",GMRAKIND)) Q
 S GMRAX=0 F  S GMRAX=$O(^GMR(120.8,GMRAPA,26,"AVER",GMRAKIND,GMRAX)) Q:GMRAX<1  D  Q:GMRAOUT
 .S GMRAY=$P(^GMR(120.8,GMRAPA,26,GMRAX,0),U),GMRAZ=$P(^(0),U,2)
 .D BLD
 .Q
 Q
BLD ; BUILD THE DATA
 N GMRAT,GMRAZN S (GMRAZN,GMRAT)=""
 I '$D(^GMR(120.8,GMRAPA,26,GMRAX,2,0)) Q
 S DIWL=0,DIWR=WID,DIWF=""
 K ^UTILITY($J,"W",DIWL)
 S GMRAXX=0 F  S GMRAXX=$O(^GMR(120.8,GMRAPA,26,GMRAX,2,GMRAXX)) Q:GMRAXX<1  S X=^(GMRAXX,0) D ^DIWP
 Q
