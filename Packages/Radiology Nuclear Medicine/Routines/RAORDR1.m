RAORDR1 ;ABV/SCR/MKN - Refer Pending/Hold Requests continued ; Nov 09, 2022@06:30:52
 ;;5.0;Radiology/Nuclear Medicine;**148,161,170,190,196**;Mar 16, 1998;Build 1
 ;
 ; p196/KLM - Does the following:
 ;          - Update rad order HOLD code - don't write to OR global, instead
 ;          - use our RA EVSEND OR to update special comment in RAO7CH. 
 ;          - Also, RAORDU is updated to set the 'ORDER REFERRED..' field.
 ;
 ;
 ; Routine/File        IA           Type
 ; -------------------------------------
 ; DEM^VADPT           10061        (S)
 ; GETDLG^ORCD         5493         (C)
 ; SAVE^ORWDX          NONE
 ; SEND^ORWDX          5656         (C)
 ; VALID^ORWDXA        NONE
 ; ^OR(100             5771,6475    (C)
 ; 101.41              NONE
 ; 101.42              2698         (C)
 ; 101.43              2843         (C)
 ; 100.98              3004         (C)
 ;
 Q
 ;
MAKECONS(RAOIFN) ;Create Consult using Order Dialog GMRCOR CONSULT
 ;RAOIFN is the IEN in file #75.1
 ;
 N DA,DFN,DIC,DIE,DR,ORDIALOG,RADFN,RADLG,RADTDES,RAFIELDS,RAFILE,RAIENS,RAMAP,RAN,RAN1,RANEWORD,RAO,RAOIEN,RAORDG
 N RAORDIEN,RAORDITM,RAORDLOC,RAORDS,RAORDTXT,RAOREA,RAORGTX,RAORNP,RAORIT,RAORL,RAORNP,RAORPRE,RAORPREG,RAORTYP
 N RAORVP,RAORWANT,RAQUIT,RAORD,RARET,RARTRN,RAUCID,RAURG,RAWPN,RAX,RAY,RAOILOC,VADM,X,Y,RAITYP,RAOREA,RAORC
 S RADLG="GMRCOR CONSULT"
 K DIC S DIC=101.41,X=RADLG D ^DIC I Y=-1 D ERROR("Quick Order ""GMRCOR CONSULT"" not found in ORDER DIALOG file") Q 0
 S RAORIT=+Y
 D GETDLG^ORCD(RAORIT)
 I $$CHECKDLG=1 D ERROR("Order dialog missing essential items") Q 0
 ;Now set up the input parameters for ORWDX SAVE 
 S RAFILE=75.1  ;RAD\NUC MED ORDER
 S RAIENS=RAOIFN_","
 S RAFIELDS=".01;2;3;7;12;13;14;20;21;22;"  ; ALL FIELDS
 D GETS^DIQ(RAFILE,RAIENS,RAFIELDS,"IE","RARTRN","RAERR")
 S (RADFN,DFN,RAORVP)=$G(RARTRN(75.1,RAIENS,.01,"I")) ;Patient DFN P2
 S (RAORDIEN,RAORD)=$G(RARTRN(75.1,RAIENS,7,"I")) ;RAD Order IEN P100
 S RAORTYP=$G(RARTRN(75.1,RAIENS,3,"E"))  ;Type of imaging P79.2
 S RAITYP=$G(RARTRN(75.1,RAIENS,3,"I")) ;Type of imaging p79.2 (internal)
 S RAOILOC=$G(RARTRN(75.1,RAIENS,20,"I")) ;p161 - Imaging Location p79.1
 S RAORPRE=$G(RARTRN(75.1,RAIENS,12,"E")) ;PRE-OP DATE/TIME
 S RAORPREG=$G(RARTRN(75.1,RAIENS,13,"E")) ;PREGNANT - set of codes Y,N,U
 S RAORNP=$G(RARTRN(75.1,RAIENS,14,"I"))  ;Ordering Provider P200
 S (RADTDES,RAORWANT)=$G(RARTRN(75.1,RAIENS,21,"E")) ;Date Desired for consult
 S RAORL=$G(RARTRN(75.1,RAIENS,22,"I"))
 S RAORDLOC=$G(RARTRN(75.1,RAIENS,22,"E"))   ;Ordering Location P44
 K DIC S DIC=100.98,X="CONSULTS" D ^DIC I Y=-1 D ERROR("Quick Order ""CONSULTS"" display group not found") Q 0
 S RAORDG=+Y
 ;Now add the responses to the dialog
 ;p161 start 
 ;Use I-LOC from order to lookup CCC in 79.1
 ;P170 - It's possible for the order to not have a 'submit to' location, in which case we'll try to
 ;determine a location based on imaging type and user's division.
 I $G(RAOILOC)="" S RAOILOC=$$GETILOC^RAORDR2(RAITYP)
 I $G(RAOILOC)=0 D ERROR("No Imaging location found/selected") Q 0
 ;if the I-LOC doesn't have a CCC
 I '$O(^RA(79.1,RAOILOC,"CON",0)) S RAOILOC=$$GETILOC^RAORDR2(RAITYP) ;no CCC on order location
 I $G(RAOILOC)=0 D ERROR("No Consult title associated with I-LOC") Q 0
 ;p170 end
 ;
 I $D(^RA(79.1,RAOILOC,"CON")) D
 .I RAORTYP["MAMMOGRAPHY" S RAMAP=$$MAMMO() Q
 .S RAI=$O(^RA(79.1,RAOILOC,"CON",0)) S RAMAP=$$GET1^DIQ(79.11,RAI_","_RAOILOC_",",.01)
 .Q
 I $G(RAMAP)=0 Q 0
 I $G(RAMAP)="" D ERROR("No Consult title associated with I-LOC") Q 0
 ;p170 - change next line to FIND^DIC to allow for partial matches
 ;S RAORDITM=$$FIND1^DIC(101.43,,,RAMAP) I RAORDITM=0 D ERROR("Orderable Item "_RAMAP_" not found in Orderable item file") Q 0
 D FIND^DIC(101.43,,"@;.01","P",RAMAP,,,,,"RAOI",) I $D(RAOI)=10 D
 .N RAJ S RAJ=0 F  S RAJ=$O(RAOI("DILIST",RAJ)) Q:RAJ=""  D
 ..I $P($G(RAOI("DILIST",RAJ,0)),U,2)=RAMAP S RAORDITM=+$G(RAOI("DILIST",RAJ,0))
 ..Q
 .Q
 I $G(RAORDITM)'>0 D ERROR("Orderable Item "_RAMAP_" not found in Orderable item file") Q 0
 ;p161 end
 D UPORDLG("OR GTX ORDERABLE ITEM",RAORDITM)
 K DIC S DIC=101.42,X="ROUTINE" D ^DIC I Y=-1 D ERROR("Urgency ""ROUTINE"" not found in ORDER URGENCY file") Q 0
 S RAURG=+Y
 D UPORDLG("OR GTX URGENCY",RAURG)
 D UPORDLG("OR GTX CATEGORY","O") ;Outpatient
 D UPORDLG("OR GTX PLACE OF CONSULTATION","C") ;"Consultant's Choice"
 D UPORDLG("OR GTX PROVIDER","") ;Attention field not known
 ;
 D GETS^DIQ(100,RAORDIEN_",",".8*","IE","RAO")
 S RAORDTXT=$G(RAO(100.008,"1,"_RAORDIEN_",",.1,1))
 I RAORDTXT="" D ERROR("Order Text not found in ORDER file at IEN "_RAORDIEN) Q 0
 D UPORDLG("OR GTX FREE TEXT","Encounter for other specified special examinations")
 D UPORDLG("OR GTX CODE","Z01.89") ;p161 - Add Provisional DX Code
 D UPORDLG("OR GTX CLINICALLY INDICATED DATE",RADTDES)
 S ORDIALOG("ORCHECK")=0 ;No Order Checks
 S ORDIALOG("ORTS")=0
 ;Set up Reason For Study in ORDIALOG
 S RAWPN=RAORGTX("OR GTX WORD PROCESSING 1")
 S ORDIALOG(RAWPN_",1")="ORDIALOG(""WP"",15,1)"
 D GETREAS^RAORDR2 Q:RAQUIT 0
 ;Clean up ORDIALOG to leave only answers
 S RAN="" F  S RAN=$O(ORDIALOG(RAN)) Q:RAN=""  D
 .M:RAN="WP" RANEWORD(RAN)=ORDIALOG(RAN) I RAN'="WP",RAN'="ORCHECK",RAN'="ORTS" S RAN1="" D
 ..F  S RAN1=$O(ORDIALOG(RAN,RAN1)) Q:RAN1=""  S:RAN1=1 RANEWORD(RAN,RAN1)=ORDIALOG(RAN,RAN1)
 S RAX=$O(ORDIALOG("WP","")) I RAX]"" S RANEWORD(RAX,1)="ORDIALOG(""WP"","_RAX_",1)"
 K ORDIALOG M ORDIALOG=RANEWORD
 ;Create Consult Order
 L +^XTMP("ORPTLK-"_RADFN):5 I '$T D ERROR("Another person is editing orders for this patient.") Q 0 ;p161 -Lock Patient (CPRS)
 D SAVE^ORWDX(.RARET,RAORVP,RAORNP,RAORL,RADLG,RAORDG,RAORIT,"",.ORDIALOG,"","","",0)
 L -^XTMP("ORPTLK-"_RADFN) ;Unlock patient
 S RAORDIEN=0,RAX=$G(RARET(1)) I RAX]"" S RAORDIEN=$P($P($P(RAX,U),"~",2),";")
 I 'RAORDIEN Q 0
 L +^OR(100,+RAORDIEN):5 I '$T D ERROR("Another person is working on this order.") Q 0 ;p161 -Lock order (CPRS)
 D VALID^ORWDXA(.RAO,RAORDIEN,"OC",DUZ) ;Signature on chart
 K RAORDS S RAORDS(1)=RAORDIEN_";1^0^1^W"
 D SEND^ORWDX(.RAO,RAORVP,RAORNP,RAORL," ",.RAORDS)
 ;Set Signature Status to "Electronic" and Reason to ADMINISTRATIVELY RELEASED BY POLICY
 S DA(1)=RAORDIEN,DA=1,DIE="^OR(100,"_RAORDIEN_",8,"
 S DR="4///1;1///ADMINISTRATIVELY RELEASED BY POLICY;7///@"
 D ^DIE
 L -^OR(100,+RAORDIEN) ;unlock order
 ;
 ;Put Radiology order on hold
 S RAOREA=$O(^RA(75.2,"B","COMMUNITY CARE APPT","")) D HOLD(RAOIFN,RAORDIEN,RAOREA)
 ;
 Q RAORDIEN
 ;
HOLD(RAOIFN,RAORIEN,RAOREA) ;p196 - put radiology order on hold set special comment.
 N RAOSTS,RAFDA,IENS
 S RAORC=$G(^OR(100,RAORDIEN,4)) I $P(RAORC,";",2)="GMRC" D
 .S RAORC=+RAORC,RAUCID=$$GET1^DIQ(123,RAORC,80)
 .I RAUCID]"" S RAORC="Placed on hold due to transfer to Community Care with UCID "_RAUCID
 S RAOSTS=3 D ^RAORDU
 Q
 ;
USRPRMT() ;Prompt for consult/request service -p161  REMOVE!
 N DIR,Y,DIRUT S DIR(0)="P^RA(79.1,RAOILOC,""CON"",:QEZ" D ^DIR I $D(DIRUT) Q ""
 S RAMAP=$G(Y(0,0))
 Q RAMAP
 ; 
CHECKDLG() ;
 N RAI,RARES,RAX,RAY,X,Y
 S RARES=0 F RAI=1:1 S RAX=$P($T(DLGLST+RAI),";",2) Q:RAX="//"  D
 .K DIC S DIC=101.41,X=RAX D ^DIC I Y=-1 D ERROR("Order Dialog "_RAX_" not found") S RARES=1
 .S RAY=+Y
 .I '$D(ORDIALOG(RAY)) D ERROR("Order Dialog "_RAX_" not found") S RARES=1
 .S RAORGTX(RAX)=RAY
 Q RARES
 ;
UPORDLG(RADLGNA,RADATA) ;Stuff answer into Order Dialog array ORDIALOG
 N RAX
 S RAX=$G(RAORGTX(RADLGNA)),ORDIALOG(RAX,1)=RADATA
 Q
 ;
DLGLST ;
 ;OR GTX ORDERABLE ITEM
 ;OR GTX URGENCY
 ;OR GTX CATEGORY
 ;OR GTX WORD PROCESSING 1
 ;OR GTX PROVIDER
 ;OR GTX FREE TEXT
 ;OR GTX PLACE OF CONSULTATION
 ;OR GTX CODE
 ;OR GTX FREE TEXT OI
 ;OR GTX CLINICALLY INDICATED DATE
 ;//
ERROR(RAERR) ;
 W !!,RAERR
 Q
 ;
GETDIAG(RAORDIEN) ;RETURN POINTER TO #80 FROM ORDER ENTRY
 ;
 N RADIAG,RAFILE,RAFLD,RAERR,RAIENS
 S RAFILE=100.051 ;DIAGNOSIS SUB-FILE
 S RAIENS=1_","_RAORDIEN_","
 S RAFLD=.01
 S RADIAG=$$GET1^DIQ(RAFILE,RAIENS,RAFLD,"I",,"RAERR")  ;If there is no entry for DX in 5.1, -1 returns in piece 1
 I $D(RAERR) S RADIAG="-1^"_RAERR("DIERR",1,"TEXT",1)
 Q RADIAG
 ;
MAMMO() ;
 N RARES,DIR,DIRUT,RAI,RATOM,RAMAM,Y
 W !!,"Please select the type of Mammography order from the following options:"
 S DIR(0)="S^1:Diagnostic Mammography;2:Screen Mammography"
 D ^DIR
 I $D(DIRUT) S RARES=0 Q 0
 S RAARAY("TYPEOFSERVICE")=$S(Y=1:"4^Diagnostic",1:"4^Screen")
 S RATOM=$S(+Y=2:"SCREEN",1:"DIAGNOSTIC"),RAMAP=""
 S RAI=0 F  S RAI=$O(^RA(79.1,RAOILOC,"CON",RAI)) Q:RAI=""  D
 .S RAMAM=$$GET1^DIQ(79.11,RAI_","_RAOILOC_",",.01) I RAMAM[RATOM S RAMAP=RAMAM
 .Q
 Q $G(RAMAP)
 ;
MAP(RAIN) ;
 N RAI,RARES,RAX
 S RARES=""
 F RAI=1:1 S RAX=$T(ORDITEMS+RAI) Q:RAX=" ;//"  I $P(RAX,";",2)=RAIN S RARES=$P(RAX,";",3) Q
 Q RARES
 ;
