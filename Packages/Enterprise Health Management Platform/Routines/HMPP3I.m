HMPP3I ;SLC/AGP,ASMR/RRB,ASF,SRG - HMP patch 3 post install ; Jan 21, 2015 16:50:00
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Oct 10, 2014;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ^XTV(8989.51 - ICR 2992
 ; ^XTV(8989.5 - ICR 2682
 ;
 Q
 ;
ENV ; -- environment check to prevent production installation
 N XPDABORT  ; DE2818 SQA findings ASMR/RRB
 I $$PROD^XUPROD D
 .W !,"Production account installation is not permitted at this time."
 .W !!,"Please verify the target installation account is a non-production account."
 .W !!,"*** INSTALLATION ABORTED! ***"
 .S XPDABORT=1
 Q
 ;
PRE ; -- clean out HMP SUBSCRIPTION and ^XTMP("HMP") entries for testing
 N HMPDT S HMPDT="HMP-1111111"
 F  S HMPDT=$O(^XTMP(HMPDT)) Q:HMPDT'?1"HMP-"7N  K ^XTMP(HMPDT)
 S HMPDT="HMPEF-1111111"
 F  S HMPDT=$O(^XTMP(HMPDT)) Q:HMPDT'?1"HMPEF-"7N  K ^XTMP(HMPDT)
 K ^XTMP("HMP"),^TMP("HMPX")
 ;I $$VERCMP($$VERSRV(),"0.7-S54")>0 D  ; if current < S54
 ;. K ^HMP(800000)
 ;. S ^HMP(800000,0)="HMP SUBSCRIPTION^800000^^"
 ;D CLEARPAR
 ;D TASKCONV
 D ADDRSRC ; add resource for throttling extract tasks
 S ^XTMP("HMP-LAST-SCHEMA",0)=$$HTFM^XLFDT(+$H+7)_U_$$HTFM^XLFDT(+$H)_U_"JSON schema before install"
 S ^XTMP("HMP-LAST-SCHEMA",1)=+$P($$GET^XPAR("PKG","HMP JSON SCHEMA"),".")
 Q
 ;
CLEARPAR ;
 N ENT,ERROR,INST,LIST,PAR,TYPE,X,UID
 ;S PAR="" F  S PAR=$O(^XTV(8989.51,"B","HMP PARAMETERS","")) I PAR>0 Q
 S PAR=$O(^XTV(8989.51,"B","HMP PARAMETERS","")) Q:PAR'>0
 S X="" F  S X=$O(^XTV(8989.5,"AC",PAR,X)) Q:X=""  D
 .S TYPE=$S(X["VA":"USR",X["DIC":"SYS",1:"") I TYPE="" Q
 .S ENT=TYPE_".`"_+X
 .S UID="" F  S UID=$O(^XTV(8989.5,"AC",PAR,X,UID)) Q:UID=""  D
 ..D DEL^XPAR(ENT,"HMP PARAMETERS",UID,.ERROR)
 Q
 ;
 ; VERSRV and VERCMP are also in HMPUTILS, but not until after the install
 ; of this patch (HMP*2*3), so they are reproduced here.
 ;
VERSRV()   ; Return server version of option name
 N HMPLST,VAL
 D FIND^DIC(19,"",1,"X","HMP UI CONTEXT",1,,,,"HMPLST")
 S VAL=$G(HMPLST("DILIST","ID",1,1))
 Q $$UP^XLFSTR($P(VAL,"version ",2))
 ;
VERCMP(CUR,VAL) ; Returns 1 if CUR<VAL, -1 if CUR>VAL, 0 if equal
 N CURMAJOR,CURMINOR,CURSNAP,VALMAJOR,VALMINOR,VALSNAP
 S CURMAJOR=$P(CUR,"-"),CURMINOR=$P(CUR,"-",2),CURSNAP=$E($P(CUR,"-",3),1,4)="SNAP"
 S VALMAJOR=$P(VAL,"-"),VALMINOR=$P(VAL,"-",2),VALSNAP=$E($P(VAL,"-",3),1,4)="SNAP"
 I $E(VALMINOR)="P" S VALMINOR=$E(VALMINOR,2,99)     ; "P"ilot versions (old)
 I $E(CURMINOR)="P" S CURMINOR=$E(VALMINOR,2,99)
 I $E(VALMINOR)="S" S VALMINOR=$E(VALMINOR,2,99)*10  ; "S"print versions
 I $E(CURMINOR)="S" S CURMINOR=$E(CURMINOR,2,99)*10
 Q:VALMAJOR>CURMAJOR 1   Q:VALMAJOR<CURMAJOR -1  ; compare major versions
 Q:VALMINOR>CURMINOR 1   Q:VALMINOR<CURMINOR -1  ; compare minor versions
 Q:(CURSNAP&'VALSNAP) 1  Q:(VALSNAP&'CURSNAP) -1 ; "SNAPSHOT" < released
 Q 0
 ;
 ;
POST ; -- set up new Tx data
 ;D CREATEUS
 N HMPLVER
 S HMPLVER=$$VERSRV()
 D VERSION
 D EN^HMPIDX
 D OBJCNT
 I $$VERCMP(HMPLVER,"0.7-S58")>0 D PARPID            ; if current < S58
 I $G(^XTMP("HMP-LAST-SCHEMA",1))<2 D CVTPAT,CVTSEL  ; if existing schema < 2.0
 K ^XTMP("HMP-LAST-SCHEMA")
 ;D CREATE^HMPAP1  ;BL;V5-6 Protocols now attached via KIDs build not post routine
 D POST^HMPPRXY2
 D DISABLE^HMPZ0218 ;BL;US5021
 D POST^HMP0311P
 D POST^HMP0311Q ;DE2393 - Subscribe HMP ADT CLIENT P'cols to VAFC ATD SERVERS
 D SETPARMS ;US7724 - set throttling parameter values
 D MENUADD  ;NEED TO ADD HMP XU EVENTS OPTION to menu XU USER ADD
 Q
 ;
VERSION ; -- update V# parameter
 D PUT^XPAR("PKG","HMP VERSION",1,"2.00")
 S HMPSYS=$$GET^XPAR("SYS","HMP SYSTEM NAME") I HMPSYS'=$$SYS^HMPUTILS D PUT^XPAR("SYS","HMP SYSTEM NAME",1,$$SYS^HMPUTILS) ;ASF 12/19/15
 Q
 ;
OBJCNT ; -- create count index for HMP OBJECT file
 Q:$D(^HMP(800000.11,"ACNT"))
 N DIK,DA
 S DIK="^HMP(800000.11,"
 S DIK(1)=".03^ACNT"
 D ENALL^DIK
 Q
CREATEUS ;
 N DIV,FDA,IC,IEN,IENS,NAME,SER,HMPERR
 ;do not create the user if the patch is already installed or if the user is already created
 I $$PATCH^XPDUTL("HMP*1.0*3") Q
 D EN^DDIOL("Creating HMP Sync User")
 ;
 S NAME="HMP,USER SYNC"
 S IEN=$$CREATE^XUSAP(NAME,"","HMP SYNCHRONIZATION CONTEXT")
 I IEN=0 D EN^DDIOL("User already exists") Q
 I IEN<0 D EN^DDIOL("Cannot create user") Q
 S IENS="?"_IEN_","
 S DIV=$$ASK(4) I DIV'>0 D EN^DDIOL("A division needs to be selected.") Q
 S SER=$$ASK(49) I SER'>0 D EN^DDIOL("A service needs to be selected.") Q
 S FDA(200,IENS,.01)=NAME
 S FDA(200,IENS,7.2)=1
 S FDA(200,IENS,29)=$P(SER,U)
 S FDA(200,IENS,200.04)=1
 S FDA(200,IENS,200.1)=99999
 ;S FDA(200.03,"?+2,"_IENS,.01)="HMP SYNCHRONIZATION CONTEXT"
 ;S FDA(200.03,"?+3,"_IENS,.01)="HMP UI CONTEXT"
 S FDA(200.02,"?+4,"_IENS,.01)=$P(DIV,U)
 S FDA(200.02,"?+4,"_IENS,1)=1
 D UPDATE^DIE("","FDA","","HMPERR")
 I $D(HMPERR) D  Q
 .D EN^DDIOL("Update failed, UPDATE^DIE returned the following error message.")
 .S IC="HMPERR"
 .F  S IC=$Q(@IC) Q:IC=""  W !,IC,"=",@IC
 .D EN^DDIOL("Examine the above error message for the reason.")
 .H 2
 D EN^DDIOL("Add ACCESS/VERIFY codes to the "_NAME)
 Q
 ;
ASK(FILENUM) ;
 N DIC,Y
 S DIC=FILENUM,DIC(0)="AEQMZ",DIC("A")="Select "_$S(FILENUM=4:"division: ",1:"service/section: ")
 I FILENUM=4 S DIC("S")="S DINUM=X K:$S($D(^XUSEC(""XUMGR"",DUZ)):0,'$$TF^XUAF4(X):1,1:0) X,DINUM"
 D ^DIC
 Q Y
 ;
TASKCONV ;
 N COLL,I,IEN,NODE,PAT,TEMP,UID,UPDATE,HMPY
 K ^TMP($J,"HMPY"),^TMP($J,"HMPTEMP")
 S HMPY=$NA(^TMP($J,"HMPY")),TEMP=$NA(^TMP($J,"HMPTEMP"))
 S PAT=0 F  S PAT=$O(^HMP(800000.1,"C",PAT)) Q:PAT'>0  D
 .S IEN=0 F  S IEN=$O(^HMP(800000.1,"C",PAT,"task",IEN)) Q:IEN'>0  D
 ..S NODE=$G(^HMP(800000.1,IEN,0))
 ..S UID=$P(NODE,U) I UID="" Q
 ..S UPDATE=0
 ..S I=0 F  S I=$O(^HMP(800000.1,IEN,1,I)) Q:I<1  S X=$G(^(I,0)),HMPY(I)=X
 ..D DECODE^HMPJSON("HMPY","TEMP","ERROR")
 ..I $D(ERROR) D EN^DDIOL("Error in decoding JSON Object") Q
 ..K HMPY,^TMP($J,"HMPY")
 ..I $G(@TEMP@("assignToCode"))'="" S @TEMP@("createdByCode")=@TEMP@("assignToCode"),UPDATE=1 K @TEMP@("assignToCode")
 ..I $G(@TEMP@("assignToName"))'="" S @TEMP@("createdByName")=@TEMP@("assignToName"),UPDATE=1 K @TEMP@("assignToName")
 ..I $G(@TEMP@("ownerName"))'="" S UPDATE=1 K @TEMP@("ownerName")
 ..I $G(@TEMP@("ownerCode"))'="" S UPDATE=1 K @TEMP@("ownerCode")
 ..I UPDATE=0 Q
 ..;
 ..S HMPY=$NA(^TMP($J,"HMPY"))
 ..D ENCODE^HMPJSON("TEMP","HMPY","ERROR")
 ..I $D(ERROR) D EN^DDIOL("Error in encoding JSON Object") Q
 ..D EN^DDIOL("Updating task uid: "_UID)
 ..D PUT^HMPDJ1(.HMP,PAT,"task",.HMPY)
 K ^TMP($J,"HMPY"),^TMP($J,"HMPTEMP")
 Q
ADDRSRC ; Add resource device
 N RNAME,RDESC,RSLOT,RTYPE,RIEN
 S RNAME="HMP EXTRACT RESOURCE"
 S RDESC="Controls the number of HMP extract jobs that run simultaneously."
 S RSLOT=10
 S RTYPE="P-OTHER"
 S RIEN=$$RES^XUDHSET(RNAME,RNAME,RSLOT,RDESC,RTYPE)
 Q
CVTPAT ; resend all the patient objects
 D BMES^XPDUTL("Updating HMP patient objects")
 N HMPIEN,DFN,CNT
 K ^TMP("HMPCVT",$J)
 S CNT=0
 S HMPIEN=0 F  S HMPIEN=$O(^HMP(800000,HMPIEN)) Q:'HMPIEN  D
 . S DFN=0 F  S DFN=$O(^HMP(800000,HMPIEN,1,DFN)) Q:'DFN  D
 . . Q:$D(^TMP("HMPCVT",$J,DFN))
 . . D POST^HMPDJFS(DFN,"patient",DFN,"","")
 . . S ^TMP("HMPCVT",$J,DFN)=""
 . . S CNT=CNT+1 I '(CNT#1000) D MES^XPDUTL("  "_CNT_" patient objects converted")
 K ^TMP("HMPCVT",$J)
 Q
CVTSEL ; resend all patient selection objects
 N HMPIEN
 D BMES^XPDUTL("Updating patient select objects")
 S HMPIEN=0 F  S HMPIEN=$O(^HMP(800000,HMPIEN)) Q:'HMPIEN  D
 . Q:$P(^HMP(800000,HMPIEN,0),U,3)'=2  ; operational sync not completed
 . N HMPSRV,BATCH,DOMAINS,HMPFERR
 . S HMPSRV=$P(^HMP(800000,HMPIEN,0),U)
 . S BATCH="HMPFX~"_HMPSRV_"~OPD"
 . S DOMAINS(1)="pt-select"
 . D QUINIT^HMPDJFSP(BATCH,"OPD",.DOMAINS)
 . I $D(HMPFERR) D MES^XPDUTL("Error tasking pt-select objects for server "_HMPSRV)
 Q
PARPID ; Loop thru HMP PARAMETERS and switch ICN to qualified DFN
 N PAR,ENT,UID,HMPWP,HMPERR,I,HMPSYS
 S HMPSYS=$$GET^XPAR("SYS","HMP SYSTEM NAME")
 S PAR=$O(^XTV(8989.51,"B","HMP PARAMETERS","")) Q:PAR'>0
 S ENT="" F  S ENT=$O(^XTV(8989.5,"AC",PAR,ENT)) Q:ENT=""  D
 . S UID="" F  S UID=$O(^XTV(8989.5,"AC",PAR,ENT,UID)) Q:UID=""  D  ;INST=UID
 . . I $P(UID,":",6,7)'="HMP USER PREF:0" Q
 . . N HMPWP,HMPERR,JSON,OBJ,ERR,DFN,RSLT
 . . D GETWP^XPAR(.HMPWP,ENT,PAR,UID,.HMPERR)
 . . I +HMPERR D WRERR(UID,$P(HMPERR,U,2,99)) Q
 . . I $D(HMPWP)<10 Q                         ; no JSON found
 . . S I=0 F  S I=$O(HMPWP(I)) Q:'I  S JSON(I)=HMPWP(I,0)
 . . D DECODE^HMPJSON("JSON","OBJ","ERR")
 . . I $D(ERR) D WRERR(UID,"Error decoding JSON") Q
 . . I '$L($G(OBJ("cpe.context.patient"))) Q  ; nothing there
 . . I OBJ("cpe.context.patient")[";" Q       ; already DFN
 . . S DFN=$$GETDFN^MPIF001(OBJ("cpe.context.patient"))
 . . I DFN<1 D WRERR(UID,"Error converting ICN: "_$P(DFN,U,2)) Q
 . . S OBJ("cpe.context.patient")=HMPSYS_";"_DFN
 . . K JSON
 . . D ENCODE^HMPJSON("OBJ","JSON","ERR")
 . . I $D(ERR) D WRERR(UID,"Error encoding JSON") Q
 . . D PUTBYUID^HMPPARAM(.RSLT,UID,.JSON)
 Q
WRERR(UID,MSG) ; Write out error (from post-init in KIDS build)
 D MES^XPDUTL("Error: "_MSG_" for UID "_UID)
 Q
 ;
SETPARMS ; -- set various XPAR parameter values      US7724
 ; 
 ; -- add/edit latest domain object average size in bytes
 D BMES^XPDUTL(" Adding domain object average sizes to HMP DOMAIN SIZES parameter...")
 D PTADD
 D ODCADD
 ;
 ; -- set to 100 megabytes if not currently defined
 I $$GET^XPAR("SYS","HMP EXTRACT DISK SIZE LIMIT",1,"Q")="" D
 . D EN^XPAR("SYS","HMP EXTRACT DISK SIZE LIMIT",1,100)
 ;
 ; -- set to 10 seconds if not currently defined
 I $$GET^XPAR("SYS","HMP EXTRACT TASK REQUEUE SECS",1,"Q")="" D
 . D EN^XPAR("SYS","HMP EXTRACT TASK REQUEUE SECS",1,10)
 Q
 ;
PTADD ; -- add patient domain average sizes
 N I,X,DOMAIN,SIZE,ERR
 S I=0 F  S I=I+1,X=$P($T(PTDOM+I),";;",2) Q:X="zzzzz"  D
 . S DOMAIN=$P(X,";",1),SIZE=$P(X,";",2)
 . D PUT^XPAR("PKG","HMP DOMAIN SIZES",DOMAIN,SIZE,.ERR)
 . I $G(ERR) D BMES^XPDUTL("Error: "_ERR)
 D MES^XPDUTL("   o  patient domain sizes added")
 Q
 ;
ODCADD ; -- add OPD domain average sizes
 N I,X,DOMAIN,SIZE,ERR
 S I=0 F  S I=I+1,X=$P($T(ODCDOM+I),";;",2) Q:X="zzzzz"  D
 . S DOMAIN=$P(X,";",1),SIZE=$P(X,";",2)
 . D PUT^XPAR("PKG","HMP DOMAIN SIZES",DOMAIN,SIZE,.ERR)
 . I $G(ERR) D BMES^XPDUTL("Error: "_ERR)
 D MES^XPDUTL("   o  operational domain sizes added")
 Q
 ;
MENUADD  ;BL;Post processor to add option HMP XU EVENTS to Option XU USER ADD
 N XUMENU,HMPMENU,FDA,QFLG,X
 ;Get IEN of XU USER ADD
 S XUMENU="",XUMENU=$O(^DIC(19,"B","XU USER ADD",XUMENU))
 Q:XUMENU=""
 ;Get IEN of HMP XU EVENTS
 S HMPMENU="",HMPMENU=$O(^DIC(19,"B","HMP XU EVENTS",HMPMENU))
 Q:HMPMENU=""
 ;Check if already installed
 S X=0,QFLG=0
 F  S X=$O(^DIC(19,XUMENU,10,X)) Q:X'=+X  D
 . I $P(^DIC(19,XUMENU,10,X,0),"^",1)=HMPMENU S QFLG=1
 Q:QFLG  ;If HMPMENU found silently quit
 ;Now insert new menu item HMPMENU, into 
 ; file 19.01  field .01
 S FDA(1,19.01,"+1,"_XUMENU_",",.01)=HMPMENU
 D UPDATE^DIE("","FDA(1)","","HMPERR")
 I $D(HMPERR) D  Q
 .D EN^DDIOL("XU USER ADD menu not updated, UPDATE^DIE returned the following error message.")
 .S IC="HMPERR"
 .F  S IC=$Q(@IC) Q:IC=""  W !,IC,"=",@IC
 .D EN^DDIOL("Examine the above error message for the reason.") Q
 ;
PTDOM ; patient domains
 ;;allergy;690
 ;;appointment;742
 ;;auxiliary;749
 ;;consult;545
 ;;cpt;487
 ;;diagnosis;331
 ;;document;3993
 ;;education;415
 ;;exam;338
 ;;factor;550
 ;;image;1038
 ;;immunization;550
 ;;lab;1231
 ;;med;5340
 ;;mh;4827
 ;;obs;754
 ;;order;999
 ;;patient;3294
 ;;pov;450
 ;;problem;756
 ;;procedure;278
 ;;ptf;397
 ;;roadtrip;370
 ;;skin;388
 ;;surgery;852
 ;;task;401
 ;;treatment;1071
 ;;visit;911
 ;;vital;462
 ;;zzzzz
 ;
ODCDOM ; operational domains
 ;;asu-class;226
 ;;asu-rule;509
 ;;category;117
 ;;charttab;991
 ;;doc-def;381
 ;;labgroup;737
 ;;labpanel;267
 ;;location;278
 ;;orderable;773
 ;;page;901
 ;;personphoto;15445
 ;;pointofcare;241
 ;;pt-select;419
 ;;qo;97
 ;;roster;3862
 ;;route;157
 ;;schedule;116
 ;;syncerror;18323
 ;;syncstatus;1207
 ;;team;812
 ;;teamposition;533
 ;;user;639
 ;;usertabprefs;3029
 ;;viewdefdef;5742
 ;;viewdefdefcoldefconfigtemplate;440
 ;;HMPupdate;128
 ;;zzzzz
