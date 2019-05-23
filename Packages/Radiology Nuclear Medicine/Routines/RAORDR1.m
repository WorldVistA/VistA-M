RAORDR1 ;ABV/SCR/MKN - Refer Pending/Hold Requests continued ;4/2/2018  3:30 PM
 ;;5.0;Radiology/Nuclear Medicine;**148**;Mar 16, 1998;Build 59
 ;
 ;ICR   Supports
 ;10061 DEM^VADPT
 ;
 Q
 ;
MAKECONS(RAOIFN) ;Create Consult using Order Dialog GMRCOR CONSULT
 ;RAOIFN is the IEN in file #75.1
 ;
 N DA,DFN,DIC,DIE,DR,ORDIALOG,RADFN,RADLG,RADTDES,RAFIELDS,RAFILE,RAIENS,RAMAP,RAN,RAN1,RANEWORD,RAO,RAOIEN,RAORDG
 N RAORDIEN,RAORDITM,RAORDLOC,RAORDS,RAORDTXT,RAOREA,RAORGTX,RAORNP,RAORIT,RAORL,RAORNP,RAORPRE,RAORPREG,RAORTYP
 N RAORVP,RAORWANT,RAQUIT,RAORD,RARET,RARTRN,RAUCID,RAURG,RAWPN,RAX,RAY,VADM,X,Y
 S RADLG="GMRCOR CONSULT"
 K DIC S DIC=101.41,X=RADLG D ^DIC I Y=-1 D ERROR("Quick Order ""GMRCOR CONSULT"" not found in ORDER DIALOG file") Q 0
 S RAORIT=+Y
 D GETDLG^ORCD(RAORIT)
 I $$CHECKDLG=1 D ERROR("Order dialog missing essential items") Q 0
 ;Now set up the input parameters for ORWDX SAVE 
 S RAFILE=75.1  ;RAD\nUC MED ORDER
 S RAIENS=RAOIFN_","
 S RAFIELDS=".01;2;3;7;12;13;14;21;22;"  ; ALL FIELDS
 D GETS^DIQ(RAFILE,RAIENS,RAFIELDS,"IE","RARTRN","RAERR")
 S (DFN,RAORVP)=$G(RARTRN(75.1,RAIENS,.01,"I")) ;Patient DFN P2
 S (RAORDIEN,RAORD)=$G(RARTRN(75.1,RAIENS,7,"I")) ;RAD Order IEN P100
 S RAORTYP=$G(RARTRN(75.1,RAIENS,3,"E"))  ;Type of imaging P79.2
 S RAORPRE=$G(RARTRN(75.1,RAIENS,12,"E")) ;PRE-OP DATE/TIME
 S RAORPREG=$G(RARTRN(75.1,RAIENS,13,"E")) ;PREGNANT - set of codes Y,N,U
 S RAORNP=$G(RARTRN(75.1,RAIENS,14,"I"))  ;Ordering Provider P200
 S (RADTDES,RAORWANT)=$G(RARTRN(75.1,RAIENS,21,"E")) ;Date Desired for consult
 S RAORL=$G(RARTRN(75.1,RAIENS,22,"I"))
 S RAORDLOC=$G(RARTRN(75.1,RAIENS,22,"E"))   ;Ordering Location P44
 K DIC S DIC=100.98,X="CONSULTS" D ^DIC I Y=-1 D ERROR("Quick Order ""CONSULTS"" display group not found") Q 0
 S RAORDG=+Y
 ;Now add the responses to the dialog
 S RAQUIT=0,RAMAP=$$MAP(RAORTYP) I RAMAP="" D  Q 0
 .S RAX="Radiology Orders may only be forwarded from national IMAGING TYPEs."_$C(13,10)
 .S RAX=RAX_"The Imaging Type:  "_RAORTYP_" is not a recognized"_$C(13,10)
 .S RAX=RAX_"national IMAGING TYPE. Please contact your Imaging Supervisor"_$C(13,10)
 .S RAX=RAX_"for assistance to correct this issue."
 .D ERROR(RAX) S RAQUIT=1
 Q:RAQUIT 0
 I RAMAP["MAMMOGRAPHY" D
 .D DEM^VADPT S RAX=$P($G(VADM(5)),U)
 .I RAX="M" S RAMAP="COMMUNITY CARE-IMAGING MAMMOGRAPHY DIAGNOSTIC-AUTO" S:RAX="" RAQUIT=1 Q
 .S RAX=$$MAMMO() I RAX=0 S RAQUIT=1
 .S RAMAP=$S(RAX=1:"COMMUNITY CARE-IMAGING MAMMOGRAPHY DIAGNOSTIC-AUTO",RAX=2:"COMMUNITY CARE-IMAGING MAMMOGRAPHY SCREEN-AUTO",1:"") S:RAMAP="" RAQUIT=1
 Q:RAQUIT 0
 K DIC S DIC=101.43,X=RAMAP D ^DIC I Y=-1 D ERROR("Orderable Item "_RAMAP_" not found in Orderable item file") Q 0
 S RAORDITM=+Y
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
 D UPORDLG("OR GTX FREE TEXT","Encounter for other specified special examinations (ICD-10-CM Z01.89)")
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
 D SAVE^ORWDX(.RARET,RAORVP,RAORNP,RAORL,RADLG,RAORDG,RAORIT,"",.ORDIALOG,"","","",0)
 S RAORDIEN=0,RAX=$G(RARET(1)) I RAX]"" S RAORDIEN=$P($P($P(RAX,U),"~",2),";")
 I 'RAORDIEN Q 0
 D VALID^ORWDXA(.RAO,RAORDIEN,"OC",DUZ) ;Signature on chart
 K RAORDS S RAORDS(1)=RAORDIEN_";1^0^1^W"
 D SEND^ORWDX(.RAO,RAORVP,RAORNP,RAORL," ",.RAORDS)
 ;Set Signature Status to "Electronic" and Reason to ADMINISTRATIVELY RELEASED BY POLICY
 S DA(1)=RAORDIEN,DA=1,DIE="^OR(100,"_RAORDIEN_",8,"
 S DR="4///1;1///ADMINISTRATIVELY RELEASED BY POLICY;7///@"
 D ^DIE
 ;
 ;Put Radiology order on hold
 S RAX=$O(^RA(75.2,"B","COMMUNITY CARE APPT","")) D HOLD(RAOIFN,.RAX)
 ;Now add comment to show UCID if it exists
 S RAX=$G(^OR(100,RAORDIEN,4)) I $P(RAX,";",2)="GMRC" D
 .S RAX=+RAX,RAUCID=$$GET1^DIQ(123,RAX,80)
 .I RAUCID]"" S RAX="Placed on hold due to transfer to Community Care with UCID "_RAUCID D
 ..;RADORD is IEN of original radiology order in file #100
 ..S DA(1)=RAORD,DIE="^OR(100,"_RAORD_",8,",DA=$O(^OR(100,RAORD,8,"A"),-1) I DA S DR="1///"_RAX D ^DIE
 ;
 Q RAORDIEN
 ;
HOLD(RAOIFN,RAOREA) ;Put the original radiology order on hold
 N RAOSTS
 S RAOSTS=3 D ^RAORDU
 Q
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
 N RARES,DIR,DIRUT
 W !!,"Please select the type of Mammography order from the following options:"
 S DIR(0)="S^1:Diagnostic Mammography;2:Screen Mammography"
 D ^DIR
 I $D(DIRUT) S RARES=0
 S RAARAY("TYPEOFSERVICE")=$S(Y=1:"4^Diagnostic",1:"4^Screen")
 Q +Y
 ;
MAP(RAIN) ;
 N RAI,RARES,RAX
 S RARES=""
 F RAI=1:1 S RAX=$T(ORDITEMS+RAI) Q:RAX=" ;//"  I $P(RAX,";",2)=RAIN S RARES=$P(RAX,";",3) Q
 Q RARES
 ;
ORDITEMS ;
 ;CT SCAN;COMMUNITY CARE-IMAGING CT-AUTO
 ;MAMMOGRAPHY;COMMUNITY CARE-IMAGING MAMMOGRAPHY DIAGNOSTIC-AUTO
 ;MAMMOGRAPHY;COMMUNITY CARE-IMAGING MAMMOGRAPHY SCREEN-AUTO
 ;MAGNETIC RESONANCE IMAGING;COMMUNITY CARE-IMAGING MAGNETIC RESONANCE IMAGING-AUTO
 ;NUCLEAR MEDICINE;COMMUNITY CARE-IMAGING NUCLEAR MEDICINE-AUTO
 ;GENERAL RADIOLOGY;COMMUNITY CARE-IMAGING GENERAL RADIOLOGY-AUTO
 ;ULTRASOUND;COMMUNITY CARE-IMAGING ULTRASOUND-AUTO
 ;//
