GMRARAD0 ;HIRMFO/RM-Radiology\ART Interface Routine (cont.);12/30/93
 ;;4.0;Adverse Reaction Tracking;**41**;Mar 29, 1996;Build 8
NKADD ; This entry point will add the NKA entry in file 120.8 if needed.
 N GMRATMP,GMRAPA,GMRA,GMRAY,GMRAX,DA,DFN,DIK
 S GMRA(0)=GMRAL
 Q:$P($G(^GMR(120.86,+GMRA(0),0)),U,2)=1
 I '$D(^GMR(120.86,+GMRA(0),0)) D
 .N GMRACNT,GMRADFN,GMRAX
 .S GMRADFN=+GMRA(0),GMRAX=$G(^GMR(120.86,0))
 .S:GMRAX="" GMRAX="ADVERSE REACTION ASSESSMENT^120.86P^^"
 .S GMRACNT=($P(GMRAX,U,4)+1),^GMR(120.86,GMRADFN,0)=GMRADFN_U_"1"
 .S ^GMR(120.86,"B",GMRADFN,GMRADFN)=""
 .S $P(GMRAX,U,3,4)=GMRADFN_U_GMRACNT S ^GMR(120.86,0)=GMRAX
 .Q
 I $P($G(^GMR(120.86,+GMRA(0),0)),U,2)'=1 S $P(^(0),U,2)="1"
 Q
CHKEXAL ; This entry point will check the database for existing Rad. Allergies,
 ; and ask user if they should be entered in error.
 S GMRADA=0 F  S GMRADA=$O(^GMR(120.8,"B",DFN,GMRADA)) Q:GMRADA'>0  I $$RALLG^GMRARAD(GMRADA) Q
 Q:GMRADA'>0  W $C(7),!!!,$C(7)
 S DIR("A",1)="*** WARNING *** WARNING *** WARNING ***",DIR("A",2)="Contrast media allergies have already been documented for this patient.",DIR("A",3)="By answering this question NO, you will be deleting this data."
 S DIR("A")="ARE YOU SURE THIS IS WHAT YOU WANT TO DO? ",DIR("?")="Answer Yes if you want to delete existing data, else answer No.",DIR(0)="YA" D ^DIR
 I Y'=1 S FXN=1 Q
 S GMRADA=0 F  S GMRADA=$O(^GMR(120.8,"B",DFN,GMRADA)) Q:GMRADA'>0  I $$RALLG^GMRARAD(GMRADA) D
 .   S GMRAER=$G(^GMR(120.8,GMRADA,"ER")),DA=GMRADA
 .   F GMRAX=22,23,24 S X=$S(GMRAX=22:$P(GMRAER,U),GMRAX=23:$P(GMRAER,U,2),1:$P(GMRAER,U,3)),GMRAY=0 F  S GMRAY=$O(^DD(120.8,GMRAX,1,GMRAY)) Q:GMRAY'>0  X:$D(^DD(120.8,GMRAX,1,GMRAY,2)) ^(2)
 .   S GMRAER="1^"_$$HTFM^XLFDT($H)_"^"_DUZ,^GMR(120.8,GMRADA,"ER")=GMRAER
 .   F GMRAX=22,23,24 S X=$S(GMRAX=22:$P(GMRAER,U),GMRAX=23:$P(GMRAER,U,2),1:$P(GMRAER,U,3)),GMRAY=0 F  S GMRAY=$O(^DD(120.8,GMRAX,1,GMRAY)) Q:GMRAY'>0  X:$D(^DD(120.8,GMRAX,1,GMRAY,1)) ^(1)
 Q
QBULL ; THIS ENTRY POINT WILL ALLOW BE CALLED AS A TASKED JOB TO SEND
 ; BULLETINS FOR A RAD ALLERGY IF NECESSARY.
 ;  INPUT VARIABLE: GMRAPA = IEN 120.8 ENTRY
 Q:GMRAPA'>0
 S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:$P(GMRAPA(0),U,2)=""
 S DFN=+GMRAPA(0) Q:DFN'>0
 D 1^VADPT S GMRANAM=VADM(1),GMRALOC=$P(VAIN(4),U,2),GMRAVIP=VA("PID") D KVAR^VADPT K VA
 D SITE^GMRAUTL S GMRASITE(0)=$G(^GMRD(120.84,+GMRASITE,0))
 I '$P(GMRAPA(0),U,16) D EN1^GMRAVAB ; Send Verify bull. if not ver.
 I '$O(^GMR(120.8,GMRAPA,13,0))!'($P(GMRASITE(0),U,5)=0!(GMRALOC="")!$O(^GMR(120.8,GMRAPA,14,0))) D BULLT^GMRASEND ; Send Mark Chart/ID Band bull. if necessary.
 I $P(GMRAPA(0),U,6)="o",$P(GMRAPA(0),U,20)["D" D PTBUL^GMRAROBS ; Send P&T bull. if observed drug rxn.
 K %,DFN,GMRAHLOC,GMRALOC,GMRANAM,GMRAOUT,GMRAPA,GMRASITE,GMRATYPE,GMRAVIP,XMB,XMY,XQA,XQAMSG S ZTREQ="@"
 Q
DRCLRACK(DA) ; This function will determine if entry DA in 120.8 represents
 ; a contrast media allergy that is not entered in error if the Drug
 ; Class DX100 is deleted.
 ;    Input variable: DA=entry in file 120.8
 ;    Return value: 1 if entry is contrast media allergy, 0 if not
 ;
 N FXN,ZERO,DRCL,DRCL1,DRCL2
 S FXN=0,ZERO=$G(^GMR(120.8,DA(1),0))
 I '+$G(^GMR(120.8,DA(1),"ER")) D
 .   F DRCL="DX100","DX101","DX102" D  Q:FXN
 .   .   ;41-VS
 .   .   D IEN^PSN50P65("",DRCL,"ENCAP")
 .   .   S DRCL1=$O(^TMP($J,"ENCAP","B",DRCL,0))_";PS(50.605,"
 .   .   K ^TMP($J,"ENCAP")
 .   .   ;41-VS
 .   .   I $P(ZERO,U,3)=DRCL1 S FXN=1 Q
 .   .   S DRCL2=0 F  S DRCL2=$O(^GMR(120.8,DA(1),3,DRCL2)) Q:DRCL2<1  I DRCL2'=DA,+$G(^GMR(120.8,DA(1),3,DRCL2,0))=+DRCL1 S FXN=1 Q
 .   .   Q
 .   I 'FXN,$P(ZERO,U,3)["GMRD(120.82"&$D(^GMRD(120.82,"D","RADIOLOGICAL/CONTRAST MEDIA",+$P(ZERO,U,3))) S FXN=1
 .   Q
 Q FXN
