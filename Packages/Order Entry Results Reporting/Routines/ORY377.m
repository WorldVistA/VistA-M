ORY377 ;ISP/RFR - INSTALLATION ACTIONS FOR CPRS VERSION 31.B;Dec 20, 2019@15:10
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**377**;Dec 17, 1997;Build 582
 Q
PRE ;PRE-INSTALL ACTIONS
 N ORI,DIK,DA
 F ORI=79,84:1:87,90 D
 .I $D(^ORD(100.9,ORI,0)) D
 ..N ORMSG
 ..S ORMSG(1)="  WARNING:",ORMSG(2)="  A notification already exists in entry number "_ORI_" and will be overwritten."
 ..D BMES^XPDUTL(.ORMSG)
 ..S DIK="^ORD(100.9,",DA=ORI
 ..D ^DIK
 S DIK="^ORD(101.24,",DA=1605
 I $D(@(DIK_DA_",0)")) D
 .D BMES^XPDUTL("  Deleting report "_$P($G(@(DIK_DA_",0)")),U)_"...")
 .D ^DIK
 .D MES^XPDUTL("    DONE")
 Q
POST ;POST-INSTALL ACTIONS
 D EN^ORY377O,AUTODC^ORY377O
 D DLGBULL,NEWNOT,TOOLMENU
 D SETPARAM,ADDPAR
 Q
 ;
SETPARAM ;
 D BMES^XPDUTL("  Setting value for parameter OR RELEASE FORM TEXT...")
 N ORVAL,ORERR
 S ORVAL="default"
 S ORVAL(1)="Use Admit if the patient is newly admitted to the hospital or nursing"
 S ORVAL(2)="home. Use Transfer if inpatient will move from one ward or treating team"
 S ORVAL(3)="to another."
 D EN^XPAR("PKG","OR RELEASE FORM TEXT","1",.ORVAL,.ORERR)
 I +$G(ORERR)>0 D MES^XPDUTL("  ERROR #"_$P(ORERR,U)_": "_$P(ORERR,U,2)) Q
 D MES^XPDUTL("  DONE")
 D BMES^XPDUTL("  Setting value for parameter OR CPRS HELP DESK TEXT...")
 N ORVAL,ORERR
 S ORVAL="default"
 S ORVAL(1)="your local CPRS help desk"
 D EN^XPAR("PKG","OR CPRS HELP DESK TEXT","1",.ORVAL,.ORERR)
 I +$G(ORERR)>0 D MES^XPDUTL("  ERROR #"_$P(ORERR,U)_": "_$P(ORERR,U,2)) Q
 D MES^XPDUTL("  DONE")
 D BMES^XPDUTL("  Setting value for parameter OR EXCLUDE FROM MIXCASE...")
 N OREXMIX
 S OREXMIX(1)="1^II"
 S OREXMIX(2)="2^III"
 S OREXMIX(3)="3^IV"
 S OREXMIX(4)="4^VI"
 S OREXMIX(5)="5^VII"
 S OREXMIX(6)="6^VIII"
 S OREXMIX(7)="7^IX"
 S OREXMIX(8)="8^-VA"
 S OREXMIX(9)="9^HCS"
 S OREXMIX(10)="10^VAMC"
 S OREXMIX(11)="11^VAMCROC"
 D EN^XPAR("SYS","OR EXCLUDE FROM MIXCASE",.OREXMIX,.ORERR)
 I +$G(ORERR)>0 D MES^XPDUTL("  ERROR #"_$P(ORERR,U)_": "_$P(ORERR,U,2)) Q
 D MES^XPDUTL("  DONE")
 Q
SENDDLG(ANAME) ;Return true if the current order dialog should be sent
 I ANAME="FHW1" Q 1
 I ANAME="FHW OP MEAL" Q 1
 I ANAME="FHW8" Q 1
 I ANAME="OR GTX DAYS SUPPLY" Q 1
 I ANAME="RA OERR EXAM" Q 1
 I ANAME="SD RTC" Q 1
 Q 0
 ;
DLGBULL ;Send bulletin about modified dialogs (on first install)
 N I,ORD
 F I="FHW1","FHW OP MEAL","FHW8","GMRCOR CONSULT","GMRCOR REQUEST","SD RTC" S ORD(I)=""
 D EN^ORYDLG(377,.ORD)
 Q
TOOLMENU ;Remove all PKG lvl tools menu parameters and add new VHL item
 N ORERR
 D NDEL^XPAR("PKG","ORWT TOOLS MENU",.ORERR)
 I ORERR D BMES^XPDUTL("  Error deleting existing PKG level tools menu items")
 I 'ORERR D BMES^XPDUTL("  Deleted existing PKG level tools menu items.")
 S ORERR=0
 D ADD^XPAR("PKG","ORWT TOOLS MENU","1","Veteran Health Library=https://www.veteranshealthlibrary.domain",.ORERR)
 I ORERR D BMES^XPDUTL("  Error adding new PKG level tools menu item.")
 I 'ORERR D BMES^XPDUTL("  Added new PKG level tools menu item.")
 Q
NEWNOT ;Configure new notifications
 N ENT,EXIT,INST,ORMSG,LINE,ORI,CONFIG
 D BMES^XPDUTL("  Loading parameter values for new notifications...")
 S ENT="PKG.ORDER ENTRY/RESULTS REPORTING"
 D PRECIP(.CONFIG)
 F ORI=79,84:1:87,90 D  S EXIT=0
 .F LINE=1:1 Q:$G(EXIT)  D
 ..N TEXT,ORERROR
 ..S TEXT=$P($T(PARAM+LINE),";;",2)
 ..S INST=$P($G(^ORD(100.9,ORI,0)),U,1)
 ..I $P(TEXT," ")="ORB" D  Q
 ...I $P(TEXT,U)["PROCESSING FLAG","^79^86^87^"[(U_ORI_U) S $P(TEXT,U,2)="Enabled"
 ...I $P(TEXT,U)["ORB PROVIDER RECIPIENTS",$D(CONFIG(INST))=1 S $P(TEXT,U,2)=CONFIG(INST)
 ...D EN^XPAR(ENT,$P(TEXT,U),INST,$P(TEXT,U,2),.ORERROR)  ;ICR #2336
 ...I +ORERROR D
 ....S ORMSG(1)=" ",EXIT=2
 ....S ORMSG(2)="ERROR: Unable to configure the new "_INST_" notification"
 ....S ORMSG(3)="Kernel Parameter Tools Error #"_+ORERROR_": "_$P(ORERROR,U,2)
 ....D BMES^XPDUTL(.ORMSG)
 ..I TEXT="" S EXIT=1
 D:$G(EXIT)<2 MES^XPDUTL("  Finished loading new notification values")
 Q
SENDNOT(ANAME) ;Return true if the current notification should be sent
 I ANAME="SMART ABNORMAL IMAGING RESULTS" Q 1
 I ANAME="SMART NON-CRITICAL IMAGING RES" Q 1
 I ANAME="PREG/LACT UNSAFE ORDERS" Q 1
 I ANAME="PREGNANCY STATUS REVIEW" Q 1
 I ANAME="LACTATION STATUS REVIEW" Q 1
 I ANAME="SCHEDULED ALERT" Q 1
 Q 0
ADDPAR ;Add ORQQTIU COPY/PASTE EXCLUDE APP parameter entry
 N ERR,FLG,RSLT,X
 D BMES^XPDUTL("Adding ""natspeak.exe"" to the ORQQTIU COPY/PASTE EXCLUDE APP parameter.")
 K RSLT D GETLST^XPAR(.RSLT,"PKG.ORDER ENTRY/RESULTS REPORTING","ORQQTIU COPY/PASTE EXCLUDE APP","E")
 S FLG=0
 S X="" F  S X=$O(RSLT(X)) Q:X=""  I $P($G(RSLT(X)),U,1)="natspeak.exe" S FLG=1 Q
 I FLG=1 D
 . D BMES^XPDUTL("""natspeak.exe"" already exists in the ORQQTIU COPY/PASTE EXCLUDE APP parameter!")
 . D MES^XPDUTL("   Aborting add process!")
 I FLG=0 D
 . K ERR
 . S ERR=""
 . D ADD^XPAR("PKG.ORDER ENTRY/RESULTS REPORTING","ORQQTIU COPY/PASTE EXCLUDE APP","natspeak.exe",,.ERR)
 . I +ERR>0 D
 .. D BMES^XPDUTL("Unable to add ""natspeak.exe"" to ORQQTIU COPY/PASTE EXCLUDE APP parameter")
 .. D MES^XPDUTL("at Package level!")
 .. D MES^XPDUTL("   ERROR:  "_$P($G(ERR),U,2))
 . I +ERR=0 D
 .. D BMES^XPDUTL("""natspeak.exe"" successfully added to the ORQQTIU COPY/PASTE EXCLUDE APP")
 .. D MES^XPDUTL("   parameter!")
 Q
PARAM ;Default notification parameter values to load
 ;;ORB ARCHIVE PERIOD^30
 ;;ORB DELETE MECHANISM^All Recipients
 ;;ORB FORWARD BACKUP REVIEWER^0
 ;;ORB FORWARD SUPERVISOR^0
 ;;ORB FORWARD SURROGATES^0
 ;;ORB PROCESSING FLAG^Disabled
 ;;ORB PROVIDER RECIPIENTS^OP
 ;;ORB URGENCY^High
 Q
PRECIP(CONFIG) ;Override default ORB PROVIDER RECIPIENTS parameter value in
 ;line tag PARAM
 ;CONFIG(NOTIFICATION_NAME)=PARAMETER_VALUE
 K CONFIG
 S CONFIG("PREG/LACT UNSAFE ORDERS")="OPR"
 S CONFIG("PREGNANCY STATUS REVIEW")=""
 S CONFIG("LACTATION STATUS REVIEW")=""
 S CONFIG("SCHEDULED ALERT")=""
 Q
SENDRPT(ORNAME) ;Return true if the current report should be sent
 I ORNAME="ORRPW PHARMACY" Q 1
 I ORNAME="ORRPW POTENTIALLY UNSAFE MEDS" Q 1
 I ORNAME="ORCV WOMEN'S HEALTH" Q 1
 I ORNAME="ORCV WOMEN'S HEALTH DETAILS" Q 1
 I ORNAME="ORCV ALLERGIES" Q 1
 I ORNAME="ORRP AP ALL" Q 1
 I ORNAME="ORRPW LAB CY" Q 1
 I ORNAME="ORRPW LAB EM" Q 1
 I ORNAME="ORRPW LAB SP" Q 1
 I ORNAME="ORL ANATOMIC PATHOLOGY" Q 1
 I ORNAME="ORRPL LAB CY" Q 1
 I ORNAME="ORRPL LAB EM" Q 1
 I ORNAME="ORRPL LAB SP" Q 1
 Q 0
