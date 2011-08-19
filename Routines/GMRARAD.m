GMRARAD ;HIRMFO/RM-Radiology\ART Interface Routine ;12/8/04  08:03
 ;;4.0;Adverse Reaction Tracking;**21,27,41**;Mar 29, 1996;Build 8
 ;
RADD(DFN,OH,YN,VER) ; THIS EXTRINSIC FUNCTION WILL ADD A CONTRAST MEDIA
 ; ALLERGY TO FILE 120.8 FOR PATIENT WITH IEN DFN.  INPUT VARIABLES:
 ;    DFN = IEN IN FILE 2 OF PATIENT
 ;    OH = 'o' FOR OBSERVED, 'h' FOR HISTORICAL, OR
 ;         'p' IF THE UTILITY SHOULD PROMPT FOR OBSERVED/HISTORICAL.
 ;    YN = 'Y' MEANS CONTRAST RXN, 'N' MEANS NO CONTRAST RXN,
 ;         'U' MEANS UNKNOWN CONTRAST RXN, "" MEANS CONTRAST RXN DELETED
 ;    VER (optional) = '1' MEANS DATA WILL BE AUTOVERIFIED,
 ;                     '0' MEANS DATA WILL NOT BE VERIFIED,
 ;                     '$D MEANS USE ART AUTOVERIFICATION CHECKS.
 ; FUNCTION RETURNS THE IEN OF NEW 120.8 ENTRY, OR -1 IF NOT ADDED.
 N DA,DIK,GMRA,GMRACAUS,GMRADRCL,GMRAL,GMRACLS,GMRANEW,GMRANOW,GMRAX,GMRAY,GMRAER,X,Y
 I YN'="YES",YN'="Y" S DA=-1 G RETRA ; if no rxn, then no need to add
 I DFN'>0 S DA=-1 G RETRA ; if bad DFN, then quit
 ;--41-VS
 D IEN^PSN50P65("","DX100","ENCAP")
 S GMRACAUS="RADIOLOGICAL/CONTRAST MEDIA"
 S GMRADRCL=$O(^TMP($J,"ENCAP","B","DX100",0))_";PS(50.605," I +GMRADRCL'>0 S DA=-1 G RETRA ; is DX100 in file 50.605
 K ^TMP($J,"ENCAP")
 ;--41-VS
 S DA=0 F  S DA=$O(^GMR(120.8,"B",DFN,DA)) Q:DA'>0  I $$RALLG(DA) Q  ; check to see if RAD allergy present
 I DA>0 G RETRA ; if RAD allergy present, then quit
 I OH="p" D  ; read for OH if desired
 .   K DIR S DIR("A")="(O)bserved or (H)istorical reaction? ",DIR(0)="SAO^O:Observed;H:Historical",DIR("?",1)="   IF THIS REACTION HAS BEEN OBSERVED, PLEASE ENTER AN O,",DIR("?")="   IF THIS REACTION IS HISTORICAL, ENTER AN H." D ^DIR
 .   K DIR I Y="O"!(Y="H") S OH=$$LOW^XLFSTR(Y)
 .   Q
 I OH'="o",OH'="h" S DA=-1 G RETRA ; is OH set up right
 S GMRANOW=$$HTFM^XLFDT($H),GMRAL=DFN_"^"_GMRACAUS_"^"_GMRADRCL_"^"_GMRANOW_"^"_$S('$G(RAAF18):DUZ,1:"")_"^"_OH_"^^^^^^1^^U^^^^^^D",GMRACLS=+GMRADRCL ; 120.8 record 0th node
 I '$D(VER) D  ; need to check site's autoverify parameters
 .   S GMRAY="",GMRAY(0)=GMRAL,VER=$$VFY^GMRASIGN(.GMRAY)
 .   K GMRASITE,GMRATYPE,GMRAY
 .   Q
 I VER'=0,VER'=1 S DA=-1 G RETRA ; is VER set up correctly
 S $P(GMRAL,U,16)=VER I VER S $P(GMRAL,U,17)=GMRANOW ; set up verify data in 0th node
 S GMRANEW=$P($G(^GMR(120.8,0)),"^",3,4) ; get 120.8 0th node
 F DA=1+GMRANEW:1 L +^GMR(120.8,DA,0):0 Q:$T&'$D(^GMR(120.8,DA,0))  L:$T&$D(^GMR(120.8,DA,0)) -^GMR(120.8,DA,0) ; find IEN for new record
 S ^GMR(120.8,DA,0)=GMRAL ; set 0th node for new record
 S ^GMR(120.8,DA,3,0)="^120.803PA^1^1",^GMR(120.8,DA,3,1,0)=GMRACLS ; set drug class multiple for new record
 S ^GMR(120.8,DA,13,0)="^120.813DA^1^1",^GMR(120.8,DA,13,1,0)=$$DT^XLFDT_"^"_$G(DUZ,"") ;21 Add marked on chart when entered
 S DIK="^GMR(120.8," D IX1^DIK L -^GMR(120.8,DA,0) ; xref new record
 S $P(^GMR(120.8,0),"^",3,4)=DA_"^"_($P(GMRANEW,"^",2)+1) ; update 120.8 0th node
 I '$G(RAAF18) S GMRAPA=DA,ZTSAVE("GMRAPA")="",ZTDESC="Send GMRA Bulletins For Radiology Allergy",ZTIO="",ZTRTN="QBULL^GMRARAD0",ZTDTH=$H D ^%ZTLOAD K ZTSK,GMRAPA ; send ART bulletins
 D NKADD^GMRARAD0 ; add NKA entry if necessary
RETRA Q DA ; exit returning entry number of new record
 ;
RACHK(DFN,YN) ; This function will be called from input transform on the
 ; .05 field of file 70.  If the patient (DFN) has allergies in ART
 ; to contrast media, and the user is changing the .05 field to
 ; indicate NO contrast media allergy (YN), this function will prompt
 ; the user if this change is correct.
 ;    Input variables:  DFN=Patient IEN in file 2.
 ;                      YN=new value of the .05 field.
 ;    Return value:  1 if X should be killed, 0 if not
 ;
 N DA,DIK,DIR,FXN,GMRADA,GMRAER,GMRAX,GMRAY,X,Y
 S FXN=0
 I YN="N" D CHKEXAL^GMRARAD0
 Q FXN
RALLG(DA,ERR) ; This function will determine if entry DA in 120.8 represents
 ; a contrast media allergy that is not entered in error.
 ;    Input variable: DA=entry in file 120.8
 ;                    ERR(optional)=if set to 0 do not check for E/E
 ;    Return value: 1 if entry is contrast media allergy, 0 if not
 ;
 N FXN,ZERO,DRCL,DRCL1
 S FXN=0,ZERO=$G(^GMR(120.8,DA,0)) I '$D(ERR) S ERR=1
 I 'ERR!(ERR&'+$G(^GMR(120.8,DA,"ER"))) D
 .;--41-VS
 .F DRCL="DX100","DX101","DX102","DX103","DX104","DX105","DX106","DX107","DX108","DX109" D IEN^PSN50P65("",DRCL,"ENCAP") S DRCL1=$O(^TMP($J,"ENCAP","B",DRCL,0))_";PS(50.605," I $P(ZERO,U,3)=DRCL1!$D(^GMR(120.8,DA,3,"B",+DRCL1)) S FXN=1 Q
 .I 'FXN,$P(ZERO,U,3)["GMRD(120.82"&$D(^GMRD(120.82,"D","RADIOLOGICAL/CONTRAST MEDIA",+$P(ZERO,U,3))) S FXN=1
 .I 'FXN,$$PSCHK^GMRARAD1($P(ZERO,U,3)) S FXN=1
 .Q
 Q FXN
OTHRAD(DFN,DA) ; This function will determine if another entry for patient
 ; (DFN) exists other than entry DA that is also a Radiological
 ; allergy.
 ;    Input Variables:  DFN=IEN of patient,   DA=entry in 120.8
 ;    Function Returns:  1 if another entry exists, else returns 0
 ;
 N FXN,GMRADA
 S (GMRADA,FXN)=0 F  S GMRADA=$O(^GMR(120.8,"B",DFN,GMRADA)) Q:GMRADA'>0  I $$RALLG(GMRADA),GMRADA'=DA S FXN=1 Q
 Q FXN
