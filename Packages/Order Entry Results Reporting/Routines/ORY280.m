ORY280 ;ISL/TC,JER - Pre- and Post-install for patch OR*3*280 ;09/22/10  07:12
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**280**;Dec 17, 1997;Build 85
 ;
 ;
PRE ; Initiate pre-init processes
 Q
 ;
POST ; Initiate post-init processes
 D DLGBULL
 D UPDNAT
 D OC
 D UPDPAR
 D ^ORY280ES ;expert system changes
 D MAIN^ORY280P ;install parameter values
 K ^DIC(100.05,0,"RD") ; REMOVE @ ACCESS CODE FROM READ OF FILE 100.05
 ;D UPDPAR1
 Q
 ;
SENDDLG(ANAME) ; Return true if the current order dialog should be sent
 I ANAME="OR GTX EARLIEST DATE" Q 1
 I ANAME="GMRCOR CONSULT" Q 1
 I ANAME="GMRCOR REQUEST" Q 1
 I ANAME="OR GTX ADDITIVE FREQUENCY" Q 1
 I ANAME="PSJI OR PAT FLUID OE" Q 1
 I ANAME="PSJ OR PAT OE" Q 1
 I ANAME="PSO OERR" Q 1
 I ANAME="PS MEDS" Q 1
 Q 0
 ;
DLGBULL ; send bulletin about modified dialogs <on first install>
 N I,ORD
 F I="GMRCOR CONSULT","GMRCOR REQUEST","PSJI OR PAT FLUID OE" S ORD(I)=""
 D EN^ORYDLG(280,.ORD)
 Q
 ;
OC ; setup new order checks
 S ^ORD(100.8,34,0)="DRUG DOSAGE"
 S ^ORD(100.8,34,1,0)="^^2^2^3090623^"
 S ^ORD(100.8,34,1,1,0)="This is an order check that Pharmacy performs to check the dosage of a "
 S ^ORD(100.8,34,1,2,0)="drug order for various problems."
 S ^ORD(100.8,35,0)="CLINICAL REMINDER TEST"
 S ^ORD(100.8,35,1,0)="^^4^4^3090706^"
 S ^ORD(100.8,35,1,1,0)="This order check refers to Clinical Reminder Rules that will look at the "
 S ^ORD(100.8,35,1,2,0)="Orderable Item that is getting placed and determin if a Reminder Rule "
 S ^ORD(100.8,35,1,3,0)="should fire.  The CLINICAL REMINDER TEST order check is for testing "
 S ^ORD(100.8,35,1,4,0)="Reminder Order checks before deploying them to production."
 S ^ORD(100.8,36,0)="CLINICAL REMINDER LIVE"
 S ^ORD(100.8,36,1,0)="^^3^3^3090706^"
 S ^ORD(100.8,36,1,1,0)="This order check refers to Clinical Reminder Rules that will look at the "
 S ^ORD(100.8,36,1,2,0)="Orderable Item that is getting placed and determin if a Reminder Rule "
 S ^ORD(100.8,36,1,3,0)="should fire. "
 S ^ORD(100.8,"B","DRUG DOSAGE",34)=""
 S ^ORD(100.8,"B","CLINICAL REMINDER LIVE",36)=""
 S ^ORD(100.8,"B","CLINICAL REMINDER TEST",35)=""
 D EN^XPAR("PKG","ORK PROCESSING FLAG","DRUG DOSAGE","Enabled",.ERR)
 D EN^XPAR("PKG","ORK PROCESSING FLAG","CLINICAL REMINDER TEST","Disabled",.ERR)
 D EN^XPAR("PKG","ORK PROCESSING FLAG","CLINICAL REMINDER LIVE","Enabled",.ERR)
 D EN^XPAR("PKG","ORK CLINICAL DANGER LEVEL","CLINICAL REMINDER LIVE","Moderate",.ERR)
 D EN^XPAR("PKG","ORK CLINICAL DANGER LEVEL","CLINICAL REMINDER TEST","Low",.ERR)
 D EN^XPAR("PKG","ORK CLINICAL DANGER LEVEL","DRUG DOSAGE","High",.ERR)
 Q
 ;
UPDNAT ;
 N DA,DIE,DR,UPDATED,XUMF
 S XUMF=1
 S DIE="^ORD(100.02,"
 S DA=$O(^ORD(100.02,"B","SERVICE REJECT","")) I DA'>0 Q
 ;DBIA 4631
 S UPDATED=$$SETVUID^XTID(100.02,.01,DA_",",4712356)
 I +$P(UPDATED,U)=0 D  Q
 .D EN^DDIOL("Nature of Order file entry 'Service Reject' not updated")
 .D EN^DDIOL($P(UPDATED,U,2))
 S DR=".01///REJECTED BY SERVICE"
 D ^DIE
 D EN^DDIOL("Nature of Order file entry 'Service Reject' renamed to 'Rejected by Service'.")
 Q
 ;
UPDPAR ;
 N ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTIO,TEXT,ZTSK
 S ZTDESC="Session Order Dialog setting update"
 S TEXT=ZTDESC_" has been queued, task number "
 S ZTRTN="UPDPARQ^ORY280"
 S ZTIO=""
 S ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 I $D(ZTSK) S TEXT=TEXT_ZTSK D MES^XPDUTL(.TEXT)
 Q
 ;
UPDPARQ ;
 N ENT,INST,ORERR,ORLIST,PAR,VALUE
 S PAR="ORWCH BOUNDS",INST="frmOCSession",VALUE="0,0,0,0"
 D ENVAL^XPAR(.ORLIST,PAR,INST,.ORERR)
 S ENT=""
 F  S ENT=$O(ORLIST(ENT)) Q:ENT=""  D DEL^XPAR(ENT,PAR,INST,.ORERR)
 ;F  S ENT=$O(ORLIST(ENT)) Q:ENT=""  D CHG^XPAR(ENT,PAR,INST,VALUE,.ORERR)
 Q
 ;
UPDPAR1 ;Update ORWT TOOLS MENU parameter description
 N TMP,DIE,ARRAY,ERR,X
 D BMES^XPDUTL("Starting update of ORWT TOOLS MENU parameter definition description...")
 S TMP("OR*3*280",8989.51,1)="This parameter may be used to identify which items should appear on the"
 S TMP("OR*3*280",8989.51,2)="tools menu which is displayed by the CPRS GUI.  Each item should contain"
 S TMP("OR*3*280",8989.51,3)="a name that should be displayed on the menu, followed by an equal sign,"
 S TMP("OR*3*280",8989.51,4)="followed by the command string used to invoke the executable.  This"
 S TMP("OR*3*280",8989.51,5)="string may also include parameters that are passed to the executable."
 S TMP("OR*3*280",8989.51,6)="Some example entries are:"
 S TMP("OR*3*280",8989.51,7)=" "
 S TMP("OR*3*280",8989.51,8)="     Hospital Policy=C:\WINNT\SYSTEM32\VIEWERS\QUIKVIEW.EXE LOCPLCY.DOC"
 S TMP("OR*3*280",8989.51,9)="     VISTA Terminal=C:\PROGRA~1\KEA\KEAVT.EXE VISTA.KTC"
 S TMP("OR*3*280",8989.51,10)=" "
 S TMP("OR*3*280",8989.51,11)="An ampersand may be used in the name portion to identify a letter that"
 S TMP("OR*3*280",8989.51,12)="should be underlined on the menu for quick keyboard access.  For example,"
 S TMP("OR*3*280",8989.51,13)="to underscore the letter H in Hospital Policy, enter &Hospital Policy as"
 S TMP("OR*3*280",8989.51,14)="the name part."
 S TMP("OR*3*280",8989.51,15)=" "
 S TMP("OR*3*280",8989.51,16)="To use submenus on the tools menu, you must place special text in the"
 S TMP("OR*3*280",8989.51,17)="caption and action values.  Submenus must have action text SUBMENU ID,"
 S TMP("OR*3*280",8989.51,18)="where ID is a unique identifier for the submenu.  Menu items belonging to"
 S TMP("OR*3*280",8989.51,19)="the submenu must specify which submenu they belong to by appending [ID]"
 S TMP("OR*3*280",8989.51,20)="after the caption.  Thus the following entries create a Utilities submenu"
 S TMP("OR*3*280",8989.51,21)="with 2 child items:"
 S TMP("OR*3*280",8989.51,22)=" "
 S TMP("OR*3*280",8989.51,23)="     Utilities=SUBMENU 1"
 S TMP("OR*3*280",8989.51,24)="     Calculator[1]=calc.exe"
 S TMP("OR*3*280",8989.51,25)="     Notepad[1]=notepad.exe"
 S TMP("OR*3*280",8989.51,26)=" "
 S TMP("OR*3*280",8989.51,27)="To create a nested submenu, you create a submenu that belongs to another"
 S TMP("OR*3*280",8989.51,28)="submenu s ID.  For example, to create a nested submenu belonging the"
 S TMP("OR*3*280",8989.51,29)="above Utilities submenu, you would do the following:"
 S TMP("OR*3*280",8989.51,30)=" "
 S TMP("OR*3*280",8989.51,31)="     Utility Web Sites[1]=SUBMENU UtilWeb"
 S TMP("OR*3*280",8989.51,32)="     MicroSoft Tools[UtilWeb]=http:\\www.msdn"
 S TMP("OR*3*280",8989.51,33)=" "
 S TMP("OR*3*280",8989.51,34)="While submenu IDs at the end of a caption are not displayed on the Tools"
 S TMP("OR*3*280",8989.51,35)="menu, this is only true if a corresponding menu ID is found.  If no Menu"
 S TMP("OR*3*280",8989.51,36)="ID is found, the square brackets and included text will appear as part of"
 S TMP("OR*3*280",8989.51,37)="the caption on the Tools menu.  This allows for existing bracketed text"
 S TMP("OR*3*280",8989.51,38)="to remain displayed."
 S TMP("OR*3*280",8989.51,39)=" "
 S TMP("OR*3*280",8989.51,40)="If two submenus share the same menu ID, the second submenu will be"
 S TMP("OR*3*280",8989.51,41)="treated as belonging to the first menu."
 S TMP("OR*3*280",8989.51,42)=" "
 S TMP("OR*3*280",8989.51,43)="One point worth noting.  If you have a caption of a single dash (or a"
 S TMP("OR*3*280",8989.51,44)="single dash followed by a submenu id), it will create a separator line in"
 S TMP("OR*3*280",8989.51,45)="the menu or submenu.  This is not new functionality, but may not have"
 S TMP("OR*3*280",8989.51,46)="been previously documented."
 S TMP("OR*3*280",8989.51,47)=" "
 S TMP("OR*3*280",8989.51,48)="Finally, if more than 30 menu items are assigned to the top level menu"
 S TMP("OR*3*280",8989.51,49)="(i.e. they are not part of a submenu), a ""More..."" submenu will"
 S TMP("OR*3*280",8989.51,50)="automatically be created at the top of the Tools menu, with additional"
 S TMP("OR*3*280",8989.51,51)="menu items spilling into the newly created ""More..."" submenu.  If more"
 S TMP("OR*3*280",8989.51,52)="than 30 menu items spill into the ""More..."" submenu, another ""More..."""
 S TMP("OR*3*280",8989.51,53)="submenu will be created inside the first ""More..."" submenu, with"
 S TMP("OR*3*280",8989.51,54)="additional menu items spilling into it, and so on, as needed.  Note,"
 S TMP("OR*3*280",8989.51,55)="however, that there is a limit of 99 total menu items, since you can only"
 S TMP("OR*3*280",8989.51,56)="enter an integer sequence number from 1-99 when defining the ORWT TOOLS"
 S TMP("OR*3*280",8989.51,57)="MENU parameter."
 S X=$$FIND1^DIC(8989.51,,"BX","ORWT TOOLS MENU",,,)
 S ARRAY=$NA(TMP("OR*3*280",8989.51))
 S ERR=$NA(TMP("OR*3*280","ERR"))
 D WP^DIE(8989.51,X_",",20,"K",ARRAY,ERR)
 I $D(TMP("OR*3*280","ERR")) D  Q
 . N ERRORS,LINES,FILE,IENS,TXT,TEXT,Y
 . S FILE=8989.51
 . S ERRORS=0 F  S ERRORS=$O(TMP("OR*3*280","ERR","DIERR",ERRORS)) Q:+ERRORS=0  D
 .. S IENS=$G(TMP("OR*3*280","ERR","DIERR",ERRORS,"PARAM","IENS"))
 .. S Y=0
 .. F  S Y=$O(TMP("OR*3*280","ERR","DIERR",ERRORS,"TEXT",Y)) Q:+Y=0  D
 ... S TXT(Y)=$G(TMP("OR*3*280","ERR","DIERR",ERRORS,"TEXT",Y))
 . D BMES^XPDUTL("  Error occurred during update of ORWT TOOLS MENU parameter definition.")
 . D MES^XPDUTL("  Entry"_$S($G(IENS)'="":" "_IENS,1:"")_" in file "_FILE_$S($G(IENS)'="":",",1:"")_" failed to update with the following")
 . D MES^XPDUTL("  error message:")
 . D MES^XPDUTL(" ")
 . S Y=0 F  S Y=$O(TXT(Y)) Q:Y=""  D
 .. S TEXT=$G(TXT(Y))
 .. D MES^XPDUTL("    "_TEXT)
 . K TMP
 D BMES^XPDUTL("Update of ORWT TOOLS MENU parameter definition description has")
 D MES^XPDUTL(" successfully completed")
 Q
 ;
