GMRAPEM0 ;HIRMFO/WAA,FT-ALLERGY/ADVERSE REACTION PATIENT EDIT DRIVER ;9/22/06  09:35
 ;;4.0;Adverse Reaction Tracking;**2,5,17,21,36**;Mar 29, 1996;Build 9
EN11 ; Entry point for GMRA USER E/E PAT REC DATA option
 ; GMRAUSER is a flag that indicates that this is a User
 ; If user has Verifier Key then user will act normal
 I '$D(^XUSEC("GMRA-ALLERGY VERIFY",DUZ)) S GMRAUSER=1
EN1 ; Entry for ENTER/EDIT PATIENT REACTION DATA option
 ; EDIT PATIENT A/AR (DFN UNK.)
 S GMRAOUT=0
 W @IOF D PAT^GMRAPAT ; Select A Patient
 D:'GMRAOUT EN21 G:'GMRAOUT EN1
 K DFN,DIC,GMRAOUT,GMRARET,GMA,GMRAUSER
 D EXIT,EN1^GMRAKILL
 Q
EN21 ; Process patient data and determine if patient is NKA
 S GMRAOUT=$G(GMRAOUT,0)
 ; check patient assessment before enter/edit reaction
 I $$NKA^GMRANKA(DFN),$$NKASCR^GMRANKA(DFN) D  ;delete 120.86 entry if assessment=yes, but no active reactions in 120.8
 .N DA,DIK
 .S DIK="^GMR(120.86,",DA=DFN D ^DIK
 .Q
 I '$$NKA^GMRANKA(DFN) D NKAASK^GMRANKA(DFN,.GMRAOUT) Q:GMRAOUT  I '$$NKA^GMRANKA(DFN) Q
 L +^XTMP("GMRAED",DFN):1 I '$T D MESS^GMRAGUI1 Q  ;21
 S GMRAOUT=0
 D:'GMRAOUT SELECT
 I $G(GMRAPA)'>0 S GMRAOUT=0
 S GMRARP=1 I 'GMRAOUT D
 .D ASK^GMRAUTL("Enter another Causative Agent? ",.GMRAOUT,.GMRARP)
 .I 'GMRARP S GMRACNT=$O(^TMP($J,"GMRASF","B"),-1) D
 ..I GMRACNT D SIGNOFF^GMRASIGN
 ..I 'GMRAOUT D IDBAND^GMRASIGN
 ..I GMRAOUT S GMRAOUT=2-GMRAOUT D:GMRAOUT&($D(^TMP($J,"GMRASF"))) ALERT^GMRASIGN K ^TMP($J,"GMRASF"),GMRACNT
 ..Q
 .Q
 I GMRARP,'GMRAOUT K GMRARP L -^XTMP("GMRAED",DFN) G EN21 ;21
 K GMRARP
 ; check patient assessment when exiting enter/edit reaction
 I $$NKA^GMRANKA(DFN),$$NKASCR^GMRANKA(DFN) D  ;delete 120.86 entry if assessment=yes, but no active reactions in 120.8
 .N DA,DIK
 .S DIK="^GMR(120.86,",DA=DFN D ^DIK
 .Q
 L -^XTMP("GMRAED",DFN) ;21
 Q
EN2 ; EDIT PATIENT A/AR (DFN KNOWN)
 ; Called from the GMRAOR ALLERGY ENTER/EDIT protocol
 I '$D(^XUSEC("GMRA-ALLERGY VERIFY",DUZ)) S GMRAUSER=1
 N GMRAOUT
 D EN21 D
 .;N GMRAOUT
 .D EXIT,EN1^GMRAKILL
 .Q
 K GMA,GMRARET,GMRAUSER
 Q
ALERT ; PROCESS ALERTS FOR ART
 N DFN,GMRAPA,GMRACNT,GMRAOUT,GMRANEW,GMRAUSER
 S (GMRACNT,GMRAOUT,GMRANEW)=0 D
 .  I $G(XQADATA)="" S XQAKILL=0 Q
 .  S DFN=$P(XQADATA,U),GMRAPA=$P(XQADATA,U,2),GMRAUSER=$P(XQADATA,U,3) Q:'DFN!'GMRAPA
 .  I $D(^XUSEC("GMRA-ALLERGY VERIFY",DUZ)) K GMRAUSER
 .  S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 .  I $P(GMRAPA(0),U,12) D  Q
 .  .  W !,"This reaction has been signed off.",$C(7)
 .  .  D HANGT^GMRAPEH0
 .  .  S XQAKILL=0
 .  .  Q
 .  D EDIT^GMRAPEM4
 .  D UPDATE^GMRAPEM3
 .  I '$P(GMRAPA(0),U,12) D SIGNOFF^GMRASIGN
 .  I GMRAOUT S GMRAOUT=2-GMRAOUT K XQAKILL
 .  E  D
 .  .I $P(GMRAPA(0),U,12) S XQAKILL=0
 .  .I '$P(GMRAPA(0),U,12) K XQAKILL
 .  D EXIT,EN1^GMRAKILL
 .  Q
 Q
SELECT ;Select a patient reaction
 S GMRACNT=0 D 1^VADPT
 S GMRALOC=$P(VAIN(4),U,2),GMRANAM=VADM(1),GMRASEX=VADM(5),GMRAOUT=0,GMRAOTH=$O(^GMRD(120.83,"B","OTHER REACTION",0)) D KVAR^VADPT K VA,VAROOT
 K GMRADUP S GMRALAGO=1
 D REACT^GMRAPAT(DFN) ; Load all reaction for this patient.
 D EN1^GMRAPES0
 I GMRAPA>0 D TYPE D
 .I GMRAOUT D:$G(GMRANEW) DELETE S:'$$MISSREQ&('$P($G(GMRAPA(0)),U,12)) GMRAOUT=0,^TMP($J,"GMRASF","B",GMRAPA,GMRACNT)="",^TMP($J,"GMRASF",GMRACNT,GMRAPA)="" D:GMRAOUT UPOUT^GMRAPEM3 Q  ; 21,36
 .I GMRAERR D ERR^GMRAPEM3 Q  ;The reaction was entered in error
 .I $P(GMRAPA(0),U,12) D SIGNED^GMRAPEM3 Q  ;The reaction has been signed
 .; Reaction is a new reaction or Update data
 .D UPDATE^GMRAPEM3
 .Q
 Q
TYPE ; Select the type of the process to use this reaction
 S GMRAERR=0
 ; If reaction is not new check to see if user want to enter in error
 I 'GMRANEW W @IOF N GMRADFN D EN1^GMRAPEE0 I GMRAERR!GMRAOUT Q
 ;If reaction is observed and signed off
 I $P(GMRAPA(0),U,6)="o",$P(GMRAPA(0),U,12) D  Q:GMRAOUT
 .Q:$G(GMRAUSER,0)
 .N GMRARP
 .S GMRARP=0 D ASK^GMRAUTL("DO YOU WISH TO EDIT OBSERVED DATA? ",.GMRAOUT,.GMRARP) Q:GMRAOUT
 .Q:'GMRARP  ;Observed data
 .N GMRAOD S GMRAOD=$D(^GMR(120.85,"C",GMRAPA)) ;Existing observation data?
OBSDATE .;
 .S GMRALAGO=1 F  D EN2^GMRAU85 Q:GMRAPA1>0  Q:GMRAOUT  W !,"You must enter a valid date or an Up-arrow to exit",!,$C(7)
 .I 'GMRAOUT,GMRAPA1>0  D EN2^GMRAROBS
 .I '$D(^GMR(120.85,"C",GMRAPA)),$G(GMRANEW)!('$G(GMRANEW)&($G(GMRAOD))) D OBSPROB S GMRAOUT=0 G OBSDATE
 .Q
 ;Verify data
 I 'GMRAERR,$P($G(^GMR(120.8,GMRAPA,0)),U,16)=0,$P(GMRAPA(0),U,12)=1,$D(^XUSEC("GMRA-ALLERGY VERIFY",DUZ)) D  Q:GMRAOUT
 .K GMRAVER S GMRAVER=0
 .N GMRAPRNT D EN1^GMRAVFY K GMRALLER,GMRAMEC,GMRAY
 .I $P($G(^GMR(120.8,GMRAPA,0)),U,16)=1 S GMRASLL(GMRAPA)=1
 .Q
 ;EDIT Verified data
 I 'GMRAERR,$P($G(^GMR(120.8,GMRAPA,0)),U,16)=1,$D(^XUSEC("GMRA-ALLERGY VERIFY",DUZ)) D  Q:GMRAOUT
 .Q:$G(GMRAVER)=1
 .N GMRARP
 .S GMRARP=0
 .D ASK^GMRAUTL("DO YOU WISH TO EDIT VERIFIED DATA? ",.GMRAOUT,.GMRARP) Q:GMRAOUT
 .D:GMRARP SITE^GMRAUTL,EN1^GMRAPED0
 .Q
 ;if the reaction is new or not signed off
 I '$P(GMRAPA(0),U,12) D
 .D EDIT^GMRAPEM4
 .I $P($G(^GMR(120.8,GMRAPA,0)),U,16) S GMRASLL(GMRAPA)=1
 .Q
 Q
EXIT S GMRAPA=0 F  S GMRAPA=$O(^TMP($J,"GMRASF","B",GMRAPA)) Q:GMRAPA<1  D UNLOCK^GMRAUTL(120.8,GMRAPA)
 K ^TMP($J,"GMRASF")
 K ^TMP($J,"GMRALST")
 Q
 ;
DELETE ;Delete entry if required information is not entered - section added in 17
 N DA,DIK,GMRAPA1
 W !!,"Entry process not completed, deleting entry...",!
 S GMRAPA1=$O(^GMR(120.85,"C",GMRAPA,0))
 I GMRAPA1,$G(^GMR(120.85,GMRAPA1,0))="" K ^GMR(120.85,"C",GMRAPA,GMRAPA1)
 I GMRAPA1 S DIK="^GMR(120.85,",DA=GMRAPA1 D ^DIK D UNLOCK^GMRAUTL(120.85,GMRAPA1)
 I GMRAPA S DIK="^GMR(120.8,",DA=GMRAPA D ^DIK D UNLOCK^GMRAUTL(120.8,GMRAPA)
 Q
 ;
OBSPROB ;Display help information for missing observed date/time entry
 W !!,"Observed reactions must have at least one observation entry.",!,"If this reaction is incorrect then enter a date and then proceed",!,"to mark it as entered in error.",!
 Q
 ;
MISSREQ() ;Function determines if required data is missing
 N GMRA0,TYPE
 S GMRA0=$G(^GMR(120.8,+$G(GMRAPA),0)) I GMRA0="" Q 1  ;Entry not found
 S TYPE=$P(GMRA0,U,6) ;Get observed/historical
 I TYPE="" Q 1  ;Type not entered
 I TYPE="h" Q 0  ;Historical has no requirements
 I TYPE="o" I '$D(^GMR(120.85,"C",GMRAPA))!('$O(^GMR(120.85,+$O(^GMR(120.85,"C",GMRAPA,0)),2,0)))!('$$REQCOM) Q 1  ;Missing obs date/time or sign/symptom or required comment
 Q 0
 ;
REQCOM() ;Function determines if comments required
 I '$D(GMRASITE) D SITE^GMRAUTL
 I +$P(^GMRD(120.84,+GMRASITE,0),U,4)=0 Q 1  ;Comments required?
 I $O(^GMR(120.8,GMRAPA,26,0)) Q 1
 Q 0
