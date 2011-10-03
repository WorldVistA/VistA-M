GMRAFX2 ;SLC/DAN - Select reactant for update ;1/7/08  09:36
 ;;4.0;Adverse Reaction Tracking;**17,19,21,23,41**;Mar 29, 1996;Build 8
 ;DBIA SECTION
 ;10026 - DIR
 ;4631  - XTID
 ;4829  - PSN5067
 ;10104 - XLFSTR
 ;10103 - XLFDT
 ;10006 - DIC
 ;4554  - PSNDI
 ;2574  - $$TGTOG^PSNAPIS
 ;
EN1 ; Select new reactant
 N DIR,Y,DIRUT,X,DTOUT,DUOUT,DIC,GMRALAR,D,ENTRY,OK,CNT,LST,ROOT,NAM,DIROUT
 S DIR(0)="FO^3:30",DIR("A")="Enter Causative Agent",DIR("?")="^D HELP^GMRAFX2" D ^DIR S:$D(DIROUT) STOP=1 Q:$D(DIRUT)  S GMRALAR=$$UP^XLFSTR(Y)
NPA S DIC("S")="I $P(^(0),U)'=""OTHER ALLERGY/ADVERSE REACTION""&($S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(120.82,.01,Y_"",""),1:1))" ;21,23
 W !!,"Checking GMR ALLERGIES (#120.82) file for matches...",! K Y,DTOUT,DUOUT,ENTRY S X=GMRALAR,DIC="^GMRD(120.82,",DIC(0)="EZM",DIC("W")="" D ^DIC K DIC S:+Y>0 ENTRY=X D DIC ;21
 I +Y>0&($G(OK)) S GMRAAR=+Y_";GMRD(120.82,",GMRAAR(0)=$P(Y,"^",2),GMRAAR("O")=$P(Y(0),"^",2) Q
NDF ;find partial matches and select from NDF
 K Y,DTOUT,DUOUT,ENTRY
 W !!,"Now checking the National Drug File - Generic Names (#50.6)",!
 S DIC=50.6,X=GMRALAR,DIC(0)="EZM",DIC("S")="I $S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(50.6,.01,Y_"",""),1:1)" D DIC^PSNDI(50.6,"GMRA",.DIC,.X,,$$DT^XLFDT) K DIC S:+Y>0 ENTRY=X D DIC ;23,41
 I +Y>0&($G(OK)) S GMRAAR=+Y_";PSNDF(50.6,",GMRAAR(0)=$P(Y,U,2),GMRAAR("O")="D" Q
 W !!,"Now checking the National Drug File - Trade Names (#50.67)",!
 K DUOUT,DTOUT,Y,ENTRY
 S ROOT="^TMP($J,""GMRASEL"",""B"")",CNT=0,X=GMRALAR ;41
 D ALL^PSN5067(,X,$$DT^XLFDT,"GMRASEL") ;41
 I $D(@ROOT@(X)),$S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(50.6,.01,$$TGTOG^PSNAPIS(X)_","),1:1) S CNT=CNT+1,LST(CNT)=$$TGTOG^PSNAPIS(X)_U_X ;23 Exact match stores IEN in 50.6 along with trade name
 S NAM=X F  S NAM=$O(@ROOT@(NAM)) Q:NAM=""!($E(NAM,1,$L(X))'=X)  D
 .Q:$S($L($T(SCREEN^XTID)):$$SCREEN^XTID(50.6,.01,$$TGTOG^PSNAPIS(NAM)_","),1:0)  ;23
 .S CNT=CNT+1,LST(CNT)=$$TGTOG^PSNAPIS(NAM)_U_NAM
 I 'CNT S Y=-1 ;No matches found
 I CNT=1 S Y(0)=LST(1),ENTRY=$P(Y(0),U,2),Y=+LST(1) ;Only one choice
 I CNT>1 D
 .D MATCHES
 .S DIR(0)="NAO^1:"_CNT,DIR("A")="Select 1-"_CNT_": "
 .S DIR("?")="Select the number of desired causative agent"
 .D ^DIR S Y=$S(+Y:+Y,1:-1) S:Y>0 Y(0)=LST(Y),(ENTRY,X)=$P(Y(0),U,2)
 D DIC
 I +Y>0&($G(OK)) S GMRAAR=+Y(0)_";PSNDF(50.6,",GMRAAR(0)=$P(Y(0),U,2),GMRAAR("O")="D" Q
 ;Selection from file 50 removed in patch 23 and code actually removed in 41
 ;19 - Moved ING and CLASS code here from above
ING W !!,"Now checking INGREDIENT (#50.416) file for matches...",! ;23
 K Y,DTOUT,DUOUT,ENTRY S D="P",DIC="^PS(50.416,",DIC(0)="SEMZ",DIC("S")="I $S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(50.416,.01,Y_"",""),1:1)",X=GMRALAR D IX^PSNDI(50.416,"GMRA",.DIC,D,.X,,$$DT^XLFDT) K DIC S:+Y>0 ENTRY=X D DIC ;23,41
 I +Y>0&($G(OK)) S GMRAAR=+Y_";PS(50.416,",GMRAAR(0)=$S(X?1A.E:X,1:$P(Y,"^",2)),GMRAAR("O")="D" Q
CLASS W !!,"Now checking VA DRUG CLASS (#50.605) file for matches...",! ;23
 K Y,DTOUT,DUOUT,ENTRY S X=GMRALAR,DIC="^PS(50.605,",DIC(0)="SEZ",DIC("S")="I $S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(50.605,.01,Y_"",""),1:1)",D="C" D IX^PSNDI(50.605,"GMRA",.DIC,D,.X,,$$DT^XLFDT) K DIC S:+Y>0 ENTRY=X D DIC ;23,41
 I +Y>0&($G(OK)) S GMRAAR=+Y_";PS(50.605,",GMRAAR(0)=$S(X?1A.E:X,1:$P(Y,"^",2)),GMRAAR("O")="D" Q
YNOTH W !!,"Could not find ",GMRALAR," in any files.",!,"Please try again (check spelling, etc).",!,"If you need to add a new reactant, use the AE option." G EN1
 Q
DIC ; VALIDATE LOOKUP FOR A/AR
 N DIR,X,Y
 Q:'$D(ENTRY)
 K OK
 W !!,"You selected ",ENTRY
 S DIR(0)="Y",DIR("B")="Y",DIR("A")="Is this correct",DIR("?")="Answer yes if this is the correct reactant" D ^DIR S:Y=1 OK=1
 Q
MATCHES ; -- List matches for NDF
 N I,J,QUIT
 W !!,"Choose from the following "_+$G(CNT)_" matches:"
 S (I,J,QUIT)=0 F  S I=$O(LST(I)) Q:I'>0  D  Q:QUIT
 . S J=J+1 I '(J#(IOSL-5)) S:'$$MORE QUIT=1 Q:QUIT
 . W !,J,"  ",$P(LST(I),"^",2)
 Q
        ;
MORE()  ; -- show more matches
 N DIR,DTOUT,DUOUT,X,Y
 S DIR(0)="EA",DIR("A")="Press <return> to see more, or ^ to stop ..."
 D ^DIR
 Q +Y
 ;
HELP ;Display help for selection of causative agent
 W !,"Enter new causative agent to be assigned to the selected entries."
 W !,"Enter between 3 and 30 characters.  The entered text will then be"
 W !,"searched for in a number of different files.  Select the appropriate"
 W !,"entry from the appropriate file to update the selected patient."
 W !!,"Enter ^ to skip the current patient or ^^ to exit the entire process."
 Q
