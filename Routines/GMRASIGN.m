GMRASIGN ;HIRMFO/WAA-ALLERGY/ADVERSE REACTION PATIENT SIGN OFF ;9/22/06  11:01
 ;;4.0;Adverse Reaction Tracking;**17,19,36**;Mar 29, 1996;Build 9
SIGNOFF ; The signoff code
 N GMRAOUT,GMRACNTT S GMRAOUT=0 ;19
 S GMRASIGN=0
 D ENCNT^GMRASIG1 ; Count entries
 D SOQ ; Display entries and ask if user wants all the entries signed.
 I 'Y D  ; User said no the sign off question
 .I GMRACNTT>1 S GMRASIGN=1 D YNSO^GMRASIG1 I Y'=0 D RANGE(Y) ; User had more than one entry
 .D ALERT ; Ask Delete and trigger alerts for those non delete entries 
 .Q
 K GMRASITE ; force the update of the site parameters
 D PNOTE^GMRASIG1 ; File progress note
 K ^TMP($J,"GMRASF") ; clean up the temp globals
 Q
SOQ ;Sign off on all allergies for a patient
 W @IOF,!,"Causative Agent Data edited this Session:"
 K X D PRINT^GMRASIG1 ; Display entries edit this session
 N DIR
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("?")="PLEASE ENTER 'Y' IF THE DATA IS CORRECT OR 'N' IF IT IS NOT CORRECT"
 S DIR("??")="^D PRINT^GMRASIG1"
 S DIR("A")=$S(GMRACNTT>1:"Are ALL these",1:"Is this")_" correct? "
 D ^DIR
 I $D(DIRUT) S Y=0,GMRAOUT=1 ; user ^ or timed out
 I Y=0 Q  ; user answered no the sign off
 D ALLSNG,RANGE(Y) ; sign all the entries
 S Y=1
 Q
ALLSNG ;Sign off on all
 N X
 S Y="",X=0
 F  S X=$O(^TMP($J,"GMRASF",X)) Q:X<1  S Y=Y_X_","
 Q
RANGE(GMRARNG) ;Sign off select allergies
 ;Input:
 ;   GMRARNG = The entries that need to be signed
 ;
 N GMRATYPE ;19
 F I=1:1 S GMRACNT=$P(GMRARNG,",",I) Q:GMRACNT<1  S GMRAPA=$O(^TMP($J,"GMRASF",GMRACNT,0)) Q:GMRAPA'>0  D
 .N I,GMRARNG
 .S DA=GMRAPA,DIE="^GMR(120.8,",DR="15////1" D ^DIE
 .S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0))
 .S GMRATYPE=$P(GMRAPA(0),U,20)
 .S GMRASLL(GMRAPA)=0
 .I '$P(GMRAPA(0),U,16) D
 ..N GMRACNT K DR S DA=GMRAPA,DIE="^GMR(120.8,"
 ..I $$VFY(.GMRAPA) D
 ...S DR="19////1;20///N" D ^DIE
 ...Q
 ..E  S DR="19////0" D ^DIE,EN1^GMRAVAB
 ..S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0))
 .I $P(GMRAPA(0),U,6)="o",GMRATYPE["D" D PTBUL^GMRAROBS
 .D  ; Execute the event point for this reaction
 ..Q:'$D(GMRAPA)  S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 ..N OROLD,DFN,GMRACNT S DFN=$P(GMRAPA(0),U)
 ..D INP^VADPT S X=$$FIND1^DIC(101,,"BX","GMRA SIGN-OFF ON DATA")_";ORD(101," D EN^XQOR:X K VAIN,X ;19
 ..Q
 .K ^TMP($J,"GMRASF",GMRACNT,GMRAPA),^TMP($J,"GMRASF","B",GMRAPA,GMRACNT)
 .Q
 Q
ALERT ; SENDS ALERT FOR ALL DATA THAT IS UNSIGNED
 I '$O(^TMP($J,"GMRASF",0)) Q
 D REMAIN ;D DEL^GMRADEL ; Ask user if they want to delete given entries
 Q:$D(XQADATA)  ; user is processing alert
 S (GMRACNT,GMRACNTF)=0 F  S GMRACNT=$O(^TMP($J,"GMRASF",GMRACNT)) Q:GMRACNT<1  S GMRAPA=$O(^TMP($J,"GMRASF",GMRACNT,0)) Q:GMRAPA<1  D
 .S GMRAPA(0)=(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 .S XQA(DUZ)=""
 .S XQAMSG=GMRANAM_" with reaction of "_$P(GMRAPA(0),U,2)_" has not been Signed off."
 .S XQAID="GMASignoff Alert"
 .S XQADATA=DFN_U_GMRAPA_U_$G(GMRAUSER,0)
 .S XQAROU="ALERT^GMRAPEM0"
 .D SETUP^XQALERT
 .D UNLOCK^GMRAUTL(120.8,GMRAPA)
 .I 'GMRACNTF W !,?5,"Please Note that these UNSIGNED Causative Agents ",!,?5,"will not show in the patient's records.",$C(7) D HANGT^GMRAPEH0 S GMRACNTF=1
 .S X=$O(^TMP($J,"GMRASF","B",GMRAPA,0))
 .K ^TMP($J,"GMRASF",X,GMRAPA),^TMP($J,"GMRASF","B",GMRAPA,X)
 .Q
 K XQA,XQAMSG,GMRACNTF
 Q
IDBAND ; Mark ID Bands and Charts for a given patient
 I $D(GMRASLL) D
 .D EN4^GMRAMCB(.GMRASLL,DFN) S GMRAPA=0 F  S GMRAPA=$O(GMRASLL(GMRAPA)) Q:GMRAPA<1  D UNLOCK^GMRAUTL(120.8,GMRAPA)
 .K GMRASLL
 .Q
 Q
VFY(Y) ;THIS FUNCTION WILL RETURN TRUE IF THIS ALLERGY IS AUTO VERIFIED
 N GMRAPASS,X
 S GMRAPASS=0
 I '$D(GMRASITE) D SITE^GMRAUTL
 S X=$G(^GMRD(120.84,+GMRASITE,0))
 S GMRATYPE=$P(Y(0),U,20)
 I @(($P(Y(0),U,6)="o"&($P(X,U,3)\2)!($P(Y(0),U,6)="h"&($P(X,U,3)#2)))_$S($P(X,U,6)="&":"&",1:"!")_(GMRATYPE["F"&($P(X,U,2)\2#2)!(GMRATYPE["D"&($P(X,U,2)#2))!(GMRATYPE["O"&($P(X,U,2)\4)))) S GMRAPASS=1
 Q GMRAPASS
 Q
 ;
REMAIN ;Review remaining entries that were not signed off.  Entire section added with patch 17
 N GMRAPA,LCVJ,Y,DIR,DIRUT,DUOUT,SIGNED,GMRAOUT,GMRANEW,DIC,DONE
 S SIGNED=""
 S LCVJ=0 F  S LCVJ=$O(^TMP($J,"GMRASF",LCVJ)) Q:'+LCVJ  D
 .S GMRAPA=$O(^TMP($J,"GMRASF",LCVJ,0)) Q:'+GMRAPA  S GMRAPA(0)=^GMR(120.8,GMRAPA,0)
 .S DIR(0)="SB^Edit:Edit;Delete:Delete",DIR("B")="Edit" ;36
 .S DIR("?")="Select edit or delete" ;36
 .S DIR("?",1)="You must complete entry of this record.  Select edit to change" ;36
 .S DIR("?",2)="the record or delete to remove the record.  Previously existing" ;36
 .S DIR("?",3)="records will be marked as entered in error while records added" ;36
 .S DIR("?",4)="during this session will be deleted." ;36
 .S DIR("A")="For reactant "_$P(GMRAPA(0),U,2) D ^DIR K DIR S:$G(DIRUT) Y="E" ;36
 .I $E(Y)="D" Q  ;Do nothing if allergy is to be deleted
 .S GMRANEW=0
 .F  D  Q:DONE
 ..S DONE=0,GMRAOUT=0
 ..D EDIT^GMRAPEM4 W !
 ..I $P(^GMR(120.8,GMRAPA,0),U,6)="o" I '$D(^GMR(120.85,"C",GMRAPA))!('$O(^GMR(120.85,+$O(^GMR(120.85,"C",GMRAPA,0)),2,0)))!('$$REQCOM^GMRAPEM0) D  Q
 ...W !,"Observed reactions require the date of the reaction and",!,"sign/symptoms",$S('$$REQCOM^GMRAPEM0:" and comments.",1:"."),!
 ...S DIR(0)="SA^R:Re-edit;D:Delete",DIR("A")="Do you want to (R)e-edit or (D)elete this entry? ",DIR("B")="R" D ^DIR S:Y'="R" DONE=1 Q
 ..I $P(^GMR(120.8,GMRAPA,0),U,6)="h",$D(^GMR(120.85,"C",GMRAPA)) D DELOBS ;Delete observed data if changing to historical
 ..S DIR(0)="Y",DIR("A")="Is this entry now correct",DIR("B")="Y",DIR("?")="Answer yes to accept the allergy.  Enter NO to re-edit.  Enter ^ to delete this entry." D ^DIR
 ..I Y=0 Q
 ..I $G(DIRUT) S DONE=1 Q
 ..S SIGNED=SIGNED_LCVJ_",",DONE=1
 I $L(SIGNED)>1 D RANGE(SIGNED) ;Sign off on accepted allergies
 I $O(^TMP($J,"GMRASF",0)) D DELETE^GMRADEL ;Delete unaccepted entries
 Q
 ;
DELOBS ;Delete observed data from 120.85
 N OIEN,DIK,DA
 S OIEN=0 F  S OIEN=$O(^GMR(120.85,"C",GMRAPA,OIEN)) Q:'+OIEN  S DIK="^GMR(120.85,",DA=OIEN D ^DIK
 Q
