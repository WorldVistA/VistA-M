GMRAPES0 ;HIRMFO/RM-SELECT PATIENT ALLERGY TO EDIT ;11/16/07  10:26
 ;;4.0;Adverse Reaction Tracking;**13,17,19,21,23,20,41**;Mar 29, 1996;Build 8
 ;DBIA Section
 ;PSN5067 - 4829
 ;DIC     - 10006
 ;DICN    - 10009
 ;DIQ     - 2056
 ;DIR     - 10026
 ;DIWE    - 10028
 ;PSNAPIS - 2574
 ;PSNDI   - 4554
 ;XLFDT   - 10103
 ;XLFSTR  - 10104
 ;XMD     - 10070
 ;XTID    - 4631
EN1 ; GIVEN DFN, SELECT PATIENT ALLERGY
 N GMRAGOUT,ROOT,CNT,LST,NAM,DIR,GMRAET
 S GMRARET=0
 S GMRAPA=-1,GMRANEW=0 R !!,"Enter Causative Agent: ",GMRALAR:DTIME S:'$T GMRALAR="^^" S:GMRALAR="" GMRARET=1 I "^^"[GMRALAR S GMRAOUT='$L(GMRALAR)+1 G Q1
 I GMRALAR?1P.E!($L(GMRALAR)<3)!($L(GMRALAR)>30) S GMRAHLP=1 D EN1^GMRAHLP0 G EN1:'GMRAOUT,Q1
 I GMRALAR?.E1L.E S GMRALAR=$$UP^XLFSTR(GMRALAR)
PAL K Y,DTOUT,DUOUT S DGSENFLG="",DIC="^GMR(120.8,",DIC(0)="SEZ",X=GMRANAM,DIC("S")="I '+$G(^(""ER"")),$P(^(0),U,2)?@(""1""""""_GMRALAR_"""""".E""),$D(^GMR(120.8,""B"",DFN,+Y))",DIC("W")="W $P(^(0),U,2)"
 W !!,"Checking existing PATIENT ALLERGIES (#120.8) file for matches...",!
 D ^DIC S X=$P($G(Y(0)),"^",2) K DIC,DGSENFLG,DTOUT,DUOUT D DIC I GMRAOUT S GMRAOUT=GMRAOUT-1 G:GMRAOUT Q1 G EN1
 S:+Y>0 GMRAPA=+Y G Q1:+Y>0!GMRAOUT,PAL:X?1"?".E,EN1:Y=0
 G Q1:'GMRALAGO
NPA W !!,"Now checking GMR ALLERGIES (#120.82) file for matches...",!
 S DIC("S")="I $P(^(0),U)'=""OTHER ALLERGY/ADVERSE REACTION""&($S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(120.82,.01,Y_"",""),1:1))" ;21,23
 K Y,DTOUT,DUOUT S X=GMRALAR,DIC="^GMRD(120.82,",DIC(0)="EZM",DIC("W")="" D ^DIC K DIC S:+Y>0 X=$P(Y,"^",2) D DIC I GMRAOUT S GMRAOUT=GMRAOUT-1 G:GMRAOUT Q1 G EN1
 I +Y>0 S GMRAAR=+Y_";GMRD(120.82,",GMRAAR(0)=$P(Y,"^",2),GMRAAR("O")=$P(Y(0),"^",2) D:'GMRAOUT ADAR^GMRAPES1 G EN1:GMRAPA'>0,Q1
 G Q1:GMRAOUT,NPA:X?1"?".E,EN1:Y=0
NDF ;find partial matches and select from NDF
 K Y,DTOUT,DUOUT
 W !!,"Now checking the National Drug File - Generic Names (#50.6)",!
 S DIC=50.6,X=GMRALAR,DIC(0)="EZM",DIC("S")="I $S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(50.6,.01,Y_"",""),1:1)" D DIC^PSNDI(50.6,"GMRA",.DIC,.X,,$$DT^XLFDT) K DIC D DIC ;23,41
 I +Y>0 S GMRAAR=+Y_";PSNDF(50.6,",GMRAAR(0)=$P(Y,U,2),GMRAAR("O")="D" D:'GMRAOUT ADAR^GMRAPES1 G EN1:GMRAPA'>0,Q1
 W !!,"Now checking the National Drug File - Trade Names (#50.67)",!
 K DUOUT,DTOUT,Y
 S ROOT="^TMP($J,""GMRASEL"",""B"")",CNT=0,X=GMRALAR ;41
 D ALL^PSN5067(,X,$$DT^XLFDT,"GMRASEL") ;41
 I $D(@ROOT@(X)),$S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(50.6,.01,$$TGTOG^PSNAPIS(X)_","),1:1) S CNT=CNT+1,LST(CNT)=$$TGTOG^PSNAPIS(X)_U_X ;23 Exact match stores IEN in 50.6 along with trade name
 S NAM=X F  S NAM=$O(@ROOT@(NAM)) Q:NAM=""!($E(NAM,1,$L(X))'=X)  D
 .Q:$S($L($T(SCREEN^XTID)):$$SCREEN^XTID(50.6,.01,$$TGTOG^PSNAPIS(NAM)_","),1:0)  ;23
 .S CNT=CNT+1,LST(CNT)=$$TGTOG^PSNAPIS(NAM)_U_NAM
 I 'CNT S Y=-1 ;No matches found
 I CNT=1 S Y(0)=LST(1),X=$P(Y(0),U,2),Y=+LST(1) ;Only one choice
 I CNT>1 D
 .D MATCHES
 .S DIR(0)="NAO^1:"_CNT,DIR("A")="Select 1-"_CNT_": "
 .S DIR("?")="Select the number of desired causative agent"
 .D ^DIR S Y=$S(+Y:+Y,1:-1) S:Y>0 Y(0)=LST(Y),X=$P(Y(0),U,2)
 D DIC I GMRAOUT S GMRAOUT=GMRAOUT=1 G:GMRAOUT Q1 G EN1
 I +Y>0 S GMRAAR=+Y(0)_";PSNDF(50.6,",GMRAAR(0)=$P(Y(0),U,2),GMRAAR("O")="D" D:'GMRAOUT ADAR^GMRAPES1 G EN1:GMRAPA'>0,Q1
 ;Selection from file 50 removed in patch 23 and code actually removed in 41
 ;19 - Moved ING and CLASS code here
ING W !!,"Now checking the INGREDIENTS (#50.416) file for matches...",!
 K Y,DTOUT,DUOUT S D="P",DIC="^PS(50.416,",DIC(0)="SEMZ",DIC("S")="I $S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(50.416,.01,Y_"",""),1:1)",X=GMRALAR D IX^PSNDI(50.416,"GMRA",.DIC,D,.X,,$$DT^XLFDT) K DIC D DIC ;41
 I GMRAOUT S GMRAOUT=GMRAOUT-1 G:GMRAOUT Q1 G EN1 ;41
 I +Y>0 S GMRAAR=+Y_";PS(50.416,",GMRAAR(0)=$S(X?1A.E:X,1:$P(Y,"^",2)),GMRAAR("O")="D" D:'GMRAOUT ADAR^GMRAPES1 G EN1:GMRAPA'>0,Q1
 G Q1:GMRAOUT,ING:X?1"?".E,EN1:Y=0
CLASS W !!,"Now checking VA DRUG CLASS (50.605) file for matches...",!
 K Y,DTOUT,DUOUT S X=GMRALAR,DIC="^PS(50.605,",DIC(0)="SEZ",D="C",DIC("S")="I $S($L($T(SCREEN^XTID)):'$$SCREEN^XTID(50.605,.01,Y_"",""),1:1)" D IX^PSNDI(50.605,"GMRA",.DIC,D,.X,,$$DT^XLFDT) K DIC D DIC ;41
 I GMRAOUT S GMRAOUT=GMRAOUT-1 G:GMRAOUT Q1 G EN1 ;41
 I +Y>0 S GMRAAR=+Y_";PS(50.605,",GMRAAR(0)=$S(X?1A.E:X,1:$P(Y,"^",2)),GMRAAR("O")="D" D:'GMRAOUT ADAR^GMRAPES1 G EN1:GMRAPA'>0,Q1
 G Q1:GMRAOUT,CLASS:X?1"?".E,EN1:Y=0
YNOTH W !!,"Could not find ",GMRALAR," in any files."
 W !!,"Before sending an email requesting the addition of a new reactant, please",!,"try entering the first 3 or 4 letters of the reactant to search for",!,"the desired entry.",!
 W !,"Would you like to send an email requesting ",GMRALAR,!,"be added as a causative agent?"
 S DIR("A")="Send email"
 S DIR(0)="Y",DIR("B")="NO",DIR("?")="^D MESS^GMRAPES0"
 D ^DIR
 I Y'=+Y S GMRAOUT=1 G Q1
 I '+Y G EN1
YNDRG ;
 D GETINPUT(.GMRAET)
 S X=$$SENDREQ(DUZ,DFN,GMRALAR,.GMRAET)
 I '+X W !!,"Error - Message not sent - ",$P(X,U,2)
 I +X W !!,"Message sent - NOTE: This reactant was NOT added for this patient."
 W !
Q1 ;
 S:GMRAPA>0 GMRAPA(0)=$S($D(^GMR(120.8,+GMRAPA,0)):^(0),1:"")
 K %,D,DA,DIC,DTOUT,DUOUT,GMRAAR,GMRAHLP,GMRAING,GMRALAGO,GMRALAR,PSNDA,PSODA,X,Y
 Q
DIC ; VALIDATE LOOKUP FOR A/AR
 S:$D(DTOUT) X="^^" I X="^^" S GMRAOUT=1 Q
 S:$D(DUOUT) Y=0 Q:+Y'>0
YNOK W !?3,X,"   OK" S %=1 D YN^DICN S:%=-1 GMRAOUT=1,Y=-1 Q:GMRAOUT  S:%=2 Y=-1 Q:Y=-1  S:$$DUPCHK(X,DFN,Y) Y=-1 Q:GMRAOUT  I % W ! Q  ;19
 W !?5,$C(7),"ANSWER YES IF THIS IS THE CORRECT ALLERGY/ADVERSE REACTION,",!?5,"ELSE ANSWER NO."
 G YNOK
DUPCHK(X,Y,Z) ;CHECK FOR ENTERED IN ERROR
 N GMRAPA,GMRAGOUT,%,%Y S GMRAGOUT=0
 I $P($G(^GMR(120.8,+Z,0)),U,2)=X Q GMRAGOUT
 I $O(^GMR(120.8,"B",Y,0)) S GMRAPA=0 F  S GMRAPA=$O(^GMR(120.8,"B",Y,GMRAPA)) Q:GMRAPA<1  D  Q:GMRAOUT!(GMRAGOUT)
 .I $P(^GMR(120.8,GMRAPA,0),U,2)'=X Q
 .I $D(^GMR(120.8,GMRAPA,"ER")) D
 ..F  S %=2 W !,?5,$C(7),"This Agent has been Entered in Error once before.",!,?5,"Are you sure you want to select this Agent again" D  Q:%
 ...D YN^DICN S:%'=1 %=2,GMRAOUT=1  S:%Y?2"^" GMRAOUT=2
 ...Q:%  W !,?10,"ENTER 'Y' FOR YES OR 'N' FOR NO"
 ...Q
 ..S GMRAGOUT=%
 ..Q
 .Q
 I GMRAGOUT=0 S GMRAGOUT=1
 Q (GMRAGOUT-1)
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
SENDREQ(USER,PAT,TEXT,GMRAET) ;Send email to GMRA REQUEST NEW REACTANT indicating user's request for a new allergy
 ;Returns 0^reason for error
 ;        1 if successful
 N XMDUZ,XMY,XMSUB,GMRATXT,XMTEXT,XMZ,XMMG,GMRAUI,GMRAPI,GMRAUS,GMRAPS,CNT,J
 Q:'$G(USER)!('+$G(DUZ))!('$L(TEXT)) "0^Required information missing"
 S XMDUZ="Allergy Package",XMSUB="Request to add new reactant"
 S XMY("G.GMRA REQUEST NEW REACTANT")=""
 S XMY(DUZ)="" ;Include requestor in message
 D GETS^DIQ(200,USER,".01;.132;.138;8","E","GMRAUI"),GETS^DIQ(2,PAT,".01;.09","IE","GMRAPI") S GMRAUS=USER_",",GMRAPS=PAT_","
 S CNT=1
 S GMRATXT(CNT)="A request to add "_TEXT_" as a new reactant was entered",CNT=CNT+1
 S GMRATXT(CNT)="by "_GMRAUI(200,GMRAUS,.01,"E")_" for patient "_GMRAPI(2,GMRAPS,.01,"E")_" ("_$E(GMRAPI(2,GMRAPS,.09,"I"),6,9)_")",CNT=CNT+1
 S GMRATXT(CNT)="",CNT=CNT+1
 S GMRATXT(CNT)="User's contact information:",CNT=CNT+1
 S GMRATXT(CNT)="Title        : "_GMRAUI(200,GMRAUS,8,"E"),CNT=CNT+1
 S GMRATXT(CNT)="Office Phone : "_GMRAUI(200,GMRAUS,.132,"E"),CNT=CNT+1
 S GMRATXT(CNT)="Digital Pager: "_GMRAUI(200,GMRAUS,.138,"E"),CNT=CNT+1
 S GMRATXT(CNT)="",CNT=CNT+1
 I $D(GMRAET) S GMRATXT(CNT)="The user added the following comment:",CNT=CNT+1,GMRATXT(CNT)="",CNT=CNT+1 F J=1:1:$P(GMRAET(0),U,3) S GMRATXT(CNT)=GMRAET(J,0),CNT=CNT+1 ;20 Added blank line following comment
 I $D(GMRAET) S GMRATXT(CNT)="",CNT=CNT+1
 S GMRATXT(CNT)="Please verify with the user the intended reactant and then take the",CNT=CNT+1
 S GMRATXT(CNT)="appropriate action.  Be sure to try alternate spellings, etc before",CNT=CNT+1
 S GMRATXT(CNT)="requesting new reactants through NTRT (New Term Rapid Turnaround).",CNT=CNT+1 ;23
 S GMRATXT(CNT)="",CNT=CNT+1
 S GMRATXT(CNT)="Please note, an allergy to "_TEXT_" was NOT entered for this patient!",CNT=CNT+1 ;20
 S XMTEXT="GMRATXT("
 D ^XMD
 Q $S($D(XMMG):"0^Mail group GMRA REQUEST NEW REACTANT has no members - contact IRM",1:1)
 ;
MESS ;Provide help for sending email message
 W !,"Enter YES to send an email to the allergy coordinator(s) indicating that",!,"Reactant--> ",GMRALAR,!,"was not found when you were trying to add it for this patient.",!,"Enter NO to try entering the reactant again."
 Q
 ;
GETINPUT(GMRAET) ;Allow user to add comment to message
 N DIC,DWLW,DWPK,DIWEPSE
 S ^TMP($J,"TEXT",0)=""
 S DIC="^TMP($J,""TEXT"","
 S DWLW=70,DWPK=1,DIWEPSE=""
 W !!,"You may now add any comments you may have to the message that",!,"is going to be sent with the request to add this reactant."
 W !,"You may want to add things like sign/symptoms, observed or historical, etc",!,"that may be useful to the reviewer.",!
 D EN^DIWE
 I $O(^TMP($J,"TEXT",0)) M GMRAET=^TMP($J,"TEXT")
 K ^TMP($J,"TEXT")
 Q
