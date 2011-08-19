ORLP ; SLC/CLA - Manager for Team List options ; 5/30/08 6:28am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**47,90,98,243**;Dec 17, 1997;Build 242
 ;
CLEAR ; From TM, MERG^ORLP1, END^ORLP0.
 K ^XUTL("OR",$J,"ORLP"),^("ORV"),^("ORU"),^("ORW") S ORCNT=0
 Q
 ;
TM ; From option ORLP TEAM ADD - create/add a team list.
 N ORLTYP
 D CLEAR
 W @IOF,!,"A team list is a list containing patients related to several providers.",!,"These providers are the list's users.  You may now create a new team list"
 W !,"or add autolinks, users and/or patients to an existing team list.  Autolinks",!,"automatically add or remove patients with ADT movements.  Users on the list"
 W !,"may receive notifications regarding patients on the same list.  Please prefix",!,"your list name with 'TEAM' or 'SERVICE' (e.g. TEAM7B, SERVICECARDIOLOGY.)",!
 D ASKLIST,END
 Q
 ;
ASKLIST ; Ask for team list.
 ; NOTE: For new entries, TYPE field is required and trigger
 ;       stuffs CREATOR field with DUZ of current user.
 ;
AL N DLAYGO,DIC,DIE,DIK,DR,ORFLAG,ORLTNAM,OROWNER,ORROOT,ORDA,ORYY
 N DIR S DIR(0)="FAO^3:30",DIR("A")="Enter team list name: "
 D ^DIR
 I '$D(X)!$D(DIRUT) K DIR,DIRUT Q
 S ORLTNAM=$$CHKNAM(Y)                 ; Check for duplication.
 K DIR
 N DIC S X=$G(X),(ORROOT,DIC)="^OR(100.21,",DLAYGO=100.21,DIC(0)="LEFQZ" D ^DIC
 I '$D(X)!(+Y<0)!$D(DIRUT) K DIRUT Q   ; User aborted or problem.
 I +Y,'+$G(^OR(100.21,+Y,11)) S ^OR(100.21,+Y,11)="0^"
 ; Check for "Personal" lists (and not a new entry):
 I ORLTNAM>0,(+Y>0),$P($G(^OR(100.21,+Y,0)),U,2)="P" W !!,"     Personal lists cannot be edited here.",! G AL
 S (ORYY,TEAM)=Y,ORDA=+Y,TEAM(0)=Y(0),^TMP("ORLP",$J,"TLIST")=+Y K DIC
 ; Check for entry of team type (new team entry):
 I $P(TEAM,U,3) D  Q
 .I $P(TEAM(0),U,2)="" D
 ..SET Y=TEAM,Y(0)=TEAM(0) ; Reassign in case DIE previously called.
 ..N DIE S DIE=ORROOT,DA=+Y,DR="1  Enter type:  ~R" D ^DIE I $O(Y(0)) S DIK=DIE D ^DIK Q
 .S (ORLTYP,OROWNER)=""
 .S ORLTYP=$P(^OR(100.21,+TEAM,0),U,2) Q:'$L(ORLTYP)
 .; Check for "P" type, ask for user/owner input:
 .I ORLTYP="P" D OWNER^ORLP1 ; Sets OROWNER variable.
 .I (ORLTYP="P")&(OROWNER="") S DIK=ORROOT,DA=ORDA D ^DIK Q
 .;
 .; Allow further editing of autolink type teams:
 .I ORLTYP["A" S:'$D(^OR(100.21,+TEAM,2,0)) ^(0)="^100.213AVI^^" D  Q
 .. D ASKLINK,ASKUSER,ASKDEV,ASKSUB
 .;
 .; Proceed with editing for "TM" type teams:
 .D ASKPT^ORLP00(+TEAM),ASKUSER,ASKDEV
 ;
 ; For existing teams, display team type:
 W !,"  Type: "_$S($P(Y(0),U,2)="TM":"Manual Team List",$P(Y(0),U,2)="TA":"Autolinked Team List",$P(Y(0),U,2)="MRAL":"Manual Removal Autolinked Team List",1:"(Unknown)")
 ;
 ; Lock before allowing editing:
 I $O(^OR(100.21,+TEAM,10,0)) L +^OR(100.21,+TEAM):3 I '$T W !?5,"  Another user is editing this entry." Q
 ;
 ; Allow applicable editing for all types but "TM" teams:
 I $P(TEAM(0),U,2)'="TM" D
 . D ASKLINK,ASKUSER,ASKDEV
 . ;
 . ; Editing of "subscription" attribute for "TA" and "MRAL" teams:
 . I $P(TEAM(0),U,2)["A" D
 . . D ASKSUB
 ;
 ; Proceed with editing for "TM" type teams:
 I $P(TEAM(0),U,2)="TM" D ASKPT^ORLP00(+TEAM),ASKUSER,ASKDEV
 Q
 ;
ASKLINK ; Ask for autolinks.
 N DIC,DA,DLAYGO,Y,DUOUT,LVP,LVPT,LNAME
 W !
 F  K DIC,DA,DUOUT D  I LVP<1 Q
 .S DLAYGO=100.21,DA(1)=+TEAM,DIC="^OR(100.21,"_DA(1)_",2,",DIC(0)="AELMQZ",DIC("A")="  Enter team autolink: "
 .D ^DIC S LVP=Y I Y<1 Q
 .I $P($G(Y),U,3)=1 D
 ..S LNAME=Y(0,0)
 ..I LVP["VA(200" F  D  Q:'$D(Y)
 ...S DA(1)=+TEAM,DIE="^OR(100.21,"_DA(1)_",2,",DA(1)=+TEAM,DA=+LVP,DR="1R" D ^DIE I $D(Y) W !,"  This field is required in order for Provider autolinks to work correctly.",!,"  Please answer the question."
 ..S LVPT=$P($G(^OR(100.21,+TEAM,2,+LVP,0)),U,2)
 ..; For clinics, take a fork in the road:
 ..I $P($P(LVP,U,2),";",2)="SC(" D BYCL(LVP) Q
 ..; For autolinks besides clinics, truck on:
 ..D ADDLPTS
 Q
 ;
ADDLPTS ; Add patients linked to autolink.
 W !
 W !,"       [ADT movements linked to "
 W !,"          ",LNAME
 W !,"        will now automatically add patients to this list.]"
 S LINK=$P(LVP,U,2),FILE="^"_$P(LINK,";",2),X="",CNT=0
 W !!,"       Adding patients linked to ",LNAME,"..."
 W !
 I FILE="^DIC(42," D LOOPTS("CN",LNAME) Q
 I FILE="^DG(405.4," D LOOPTS("RM",LNAME) Q
 I FILE="^VA(200," D  Q
 . ; Variable LVPT determines if provider pointer is for:
 . ;    B - Both Primary and Attending
 . ;    A - Attending
 . ;    P - Primary
 . I LVPT["B" D LOOPTS("APR",+LINK) N CNTAPR S CNTAPR=CNT,CNT=0 D LOOPTS("AAP",+LINK) Q
 . I LVPT["P" D LOOPTS("APR",+LINK) Q
 . I LVPT["A" D LOOPTS("AAP",+LINK)
 I FILE="^DIC(45.7," D LOOPTS("ATR",+LINK) Q
 Q
 ;
BYCL(CLINIC) ; SLC/PKS - 6/99 - Return list of clinic patients by enrollment.
 ;
 ; Called by ASKLINK.
 ;
 ; Variables used:
 ;
 ;    CLINIC  = Clinic to search.
 ;    ORLIST  = Array, returned by call to PTCL^SCAPMC.
 ;    ORERR   = Array for errors, returned by call to PTCL^SCAPMC.
 ;    ORRET  = Flag for problem with PTCL^SCAPMC call.
 ;    RESULT  = Holds result of PTCL^SCAPMC call (1=OK, 0=error).
 ;    RCD     = Holder for each record in ^TMP of PTCL^SCAPMC.
 ;    DFN     = Patient IEN.
 ;    ALCNT   = Count of autolink patients added.
 ;    DUPCNT  = Count of duplicate patients already on list.
 ;    X       = Temp value holder variable.
 ;
 N DIC,DA,DO,DD,ORLIST,ORERR,RESULT,RCD,DFN,ALCNT,DUPCNT,X,ORRET
 ;
 ; Assign clinic variable:
 S CLINIC=$P(CLINIC,"^",2)
 S CLINIC=$P(CLINIC,";")
 ;
 ; Keep user informed:
 W !
 W !,"       [Patient enrollments linked to "
 W !,"          ",LNAME
 W !,"        will now automatically add patients to this list.]"
 W !
 W !,"       Adding patients enrolled in ",LNAME,"..."
 W !
 ;
 ; Process the Autolink entries:
 K ^TMP("SC TMP LIST") ; Clean up potential leftover data.
 S ORRET=1
 S RESULT=$$PTCL^SCAPMC(CLINIC,,.ORLIST,.ORERR)
 I $L($G(RESULT)) D   ; Make sure something was returned.
 .I RESULT>0 S ORRET=0 ; Was return value 1 or more?
 I ORRET W !,"  Error in processing - patients will not be added." Q  ; Abort if there's a problem.
 ; Clinic patients should now be in ^TMP("SC TMP LIST",$J file.
 ;
 ; Write the patients to the OE/RR LIST file:
 S ALCNT=0  ; Initialize autolink counter.
 S DUPCNT=0 ; Initialize duplicate counter.
 S RCD=0    ; Initialize to start with first data record.
 F  S RCD=$O(^TMP("SC TMP LIST",$J,RCD)) Q:'RCD  D  ; Each record.
 .S DFN=$P(^TMP("SC TMP LIST",$J,RCD),"^")          ; Patient IEN.
 .S X=DFN_";DPT(" ; Add ";DPT(" to patient string.
 .I $D(^OR(100.21,+TEAM,10,"B",X)) S DUPCNT=DUPCNT+1 Q  ; This patient already on list - increment dupe counter.
 .S:'$D(^OR(100.21,+TEAM,10,0)) ^(0)="^100.2101AV^^"
 .K DIC,DA,DO,DD
 .S DA(1)=+TEAM,DIC="^OR(100.21,"_DA(1)_",10,",DIC(0)="L"
 .D FILE^DICN
 .I +X S ALCNT=ALCNT+1 ; Increment counter.
 .Q  ; Loop for each record in ^TMP file.
 ;
 ; Give user the results:
 I ALCNT>0 W !,"       "_ALCNT_" patient(s) added to list."
 I ALCNT=0 W !,"       No linked patients found."
 I DUPCNT>0 W !,"       "_DUPCNT_" patient(s) already on list."
 W !
 K ^TMP("SC TMP LIST",$J) ; Clean up ^TMP file entries.
 ;
 Q
 ;
LOOPTS(REF,DEX) ;
 S ORLPT=0 F  S ORLPT=$O(^DPT(REF,DEX,ORLPT)) Q:ORLPT'>0  S X=ORLPT_";DPT(" D ADDLOOP
 I $D(LVPT),LVPT["B"!(LVPT']"") Q:REF="APR"
 I +X W !,$S(+CNT:"       "_(+$G(CNTAPR)+(+CNT))_" patient(s) added.",1:"       Linked patients already on list.")
 E  W "       No linked patients found."
 W !
 K DEX,FILE,MSG,REF,X,Y
 Q
 ;
ASKUSER ; From ASKLIST - ask for providers/users.
 Q:$D(DTOUT)!($D(DUOUT))
 W !
 S:'$D(^OR(100.21,+TEAM,1,0)) ^(0)="^100.212PA^^"
 K DIC,DA
 S DLAYGO=100.212,DA(1)=+TEAM
 S DIC("P")="100.212PA",DIC="^OR(100.21,"_DA(1)_",1,",DIC(0)="AELMQ"
 S DIC("A")="  Enter team provider/user: "
 ; SLC/PKS - Next line added on 4/11/2000:
 S DIC("S")="I $D(X),$D(^VA(200,""AK.PROVIDER"",$P(^(0),U))),$$ACTIVE^XUSER(+Y)"
 F  D  Q:Y<1
 .D ^DIC
 .I '(Y<1) W !
 K DIC,DA,DLAYGO
 Q
 ;
ASKDEV ; From ASKLIST - ask for device.
 ;
 ; New, by PKS - 7/29/99:
 Q:$D(DTOUT)!($D(DUOUT))  ; Previous interaction fail?
 W !
 N DIE,DR
 S DIE="^OR(100.21,"
 S DA=+TEAM
 S DR="1.5  Enter device: "
 D ^DIE ; Writes to DEVICE field.
 K DIE
 Q
 ;
ASKSUB ; From ASKLIST - Ask re: subscription status.
 ; (PKS - 8/1999)
 ;
 Q:$D(DTOUT)!($D(DUOUT))  ; Previous interaction fail?
 W !
 N DIE,DR
 S DIE="^OR(100.21,"
 S DA=+TEAM
 S DR="1.7  Enter subscription status: "
 D ^DIE ; Writes to SUBSCRIBE field.
 K DIE
 ;
 Q
 ;
STOR ; From SEQ^ORLP0 - store list in 100.21.
 Q:'$D(DUZ)!('ORCNT)
 I '$D(TEAM),($D(Y)#2) S TEAM=Y
 S DLAYGO=100.21
 L +^OR(100.21,+TEAM)
 S (CNT,ORLI)=0 F ORLJ=1:1 S ORLI=$O(^XUTL("OR",$J,"ORLP",ORLI)) Q:ORLI<1  I $D(^(ORLI,0)) S X=^(0),X=$P(X,U,3) D ADDLOOP
 I $G(X)>0 S MSG=$S(CNT=0:"       Patient(s) already on list.",1:"       "_CNT_" patient(s) added.") W !?5,MSG
 E  W !?5,"       No patients found."
 I CNT>0 W !?5,"  Storing list " W:$D(TEAM) $P(TEAM,U,2)," " W "for future reference..."
 L -^OR(100.12,+TEAM)
 Q
 ;
ADDLOOP ; From STOR, LOOPTS - add patients.
 Q:$D(^OR(100.21,+TEAM,10,"B",X))  ; Quit if on list.
 S:'$D(^OR(100.21,+TEAM,10,0)) ^(0)="^100.2101AV^^"
 K DIC,DA,DO,DD
 S DA(1)=+TEAM,DIC="^OR(100.21,"_DA(1)_",10,",DIC(0)="L"
 D FILE^DICN I Y>0 S:$D(CNT) CNT=CNT+1
 Q
 ;
CHKNAM(X) ; Check for duplicate entry.
 N DIC
 S X=$G(X)
 S DIC="^OR(100.21,"
 D ^DIC
 S X=+Y
 Q X
 ;
END ;
 I $G(TEAM) L -^OR(100.21,+TEAM)
 ;
END1 K %,CNT,DA,DD,DIC,DO,DIE,DIK,DIR,DR,LINK,ORCNT,ORLI,ORLJ,ORLPT,SEL,TEAM,X,Y,ORBSTG,ORBROOT,DTOUT
 Q
 ;
