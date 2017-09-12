ORY116 ;SLC/MKB -- postinit rtn for OR*3*116 ;9/27/01  16:39 [11/27/01 1:28pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**116**;Dec 17, 1997
 ;
PRE ; -- preinit
 Q
 ;
POST ; -- postinit
 N NAME,DLG,VER
 S VER=$P($T(VERSION^ORY116),";",3)
 F NAME="PSJ OR PAT OE","PSO OERR","PSO SUPPLY","PS MEDS" S DLG=+$O(^ORD(101.41,"AB",NAME,0)) S:DLG ^ORD(101.41,DLG,7)="D SC^ORCDPS3" ;Set VALIDATION field for medication dialogs
 D DLGS
 D SURGRPT
 D MAIL
 Q
 ;
DLGS ; -- Look for local dialogs that will need to be updated
 N PSJ,PSO,PSS,ORPKG,ORDLG,OR0,ORZ,CNT
 S PSJ=+$O(^DIC(9.4,"C","PSJ",0)),PSO=+$O(^DIC(9.4,"C","PSO",0))
 S PSS=+$O(^DIC(9.4,"C","PSS",0))
 S ORZ(1)="The VALIDATION field has been populated for the medication dialogs"
 S ORZ(2)="PSJ OR PAT OE, PSO OERR, PSO SUPPLY, and PS MEDS with this patch;"
 S ORZ(3)="please review the following local copies of these dialogs:"
 S CNT=3 F ORPKG=PSJ,PSO,PSS S ORDLG=0 D
 . F  S ORDLG=+$O(^ORD(101.41,"APKG",ORPKG,ORDLG)) Q:ORDLG'>0  D
 .. S OR0=$G(^ORD(101.41,ORDLG,0)) Q:$P(OR0,U,4)'="D"  ;ck dialogs only
 .. I ORPKG=PSJ Q:$P(OR0,U)="PSJ OR PAT OE"
 .. I ORPKG=PSO Q:$P(OR0,U)="PSO OERR"  Q:$P(OR0,U)="PSO SUPPLY"
 .. I ORPKG=PSS Q:$P(OR0,U)="PS MEDS"
 .. S CNT=CNT+1,ORZ(CNT)=$J(ORDLG,7)_"  "_$P(OR0,U)
DLG1 I $O(ORZ(3)) D  ;send bulletin
 . N XMDUZ,XMY,I,XMSUB,XMTEXT,DIFROM
 . S XMDUZ="PATCH OR*3*116 INSTALLATION",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 . ;I '$G(DUZ) S I=$G(^XTMP("OR94","DUZ")) S:I XMY(I)=""
 . S XMSUB="PATCH OR*3*116 INSTALLATION COMPLETED"
 . S XMTEXT="ORZ(" D ^XMD
 . D BMES^XPDUTL("The order dialogs for medications have been modified in this patch;")
 . D MES^XPDUTL("a bulletin has been sent to the installer listing local copies that")
 . D MES^XPDUTL("may need to be reviewed and updated.")
 Q
 ;
DLGSEND(NAME)  ; -- Return true if the order dialog should be sent
 I NAME="PS MEDS" Q 1
 I NAME="PSJ OR PAT OE" Q 1
 I NAME="PSO OERR" Q 1
 I NAME="PSO SUPPLY" Q 1
 Q 0
SURGRPT ;  Should surgery report be available?  (RV)
 N ORP,ORT,ORS,ORLST,ORERR
 S ORP="ORWRP REPORT LIST",ORT=$O(^ORD(101.24,"B","ORRP SURGERIES",0))
 I $$PATCH^XPDUTL("SR*3.0*100"),(+ORT) D
 . D GETLST^XPAR(.ORLST,"PKG","ORWRP REPORT LIST","Q",.ORERR)
 . S ORS=+ORLST(ORLST)+5
 . D PUT^XPAR("PKG",ORP,ORS,ORT)
 Q
 ;
MAIL ; send bulletin of installation time
 N COUNT,DIFROM,I,START,TEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S COUNT=0
 S XMSUB="Version "_$P($T(VERSION),";;",2)_" Installed"
 S XMDUZ="CPRS PACKAGE"
 F I="G.CPRS GUI INSTALL@ISC-SLC.DOMAIN.EXT",DUZ S XMY(I)=""
 S XMTEXT="TEXT("
 ;
 S X=$P($T(VERSION),";;",2)
 D LINE("Version "_X_" has been installed.")
 D LINE(" ")
 D LINE("Install complete:  "_$$FMTE^XLFDT($$NOW^XLFDT()))
 ;
 D ^XMD
 Q
 ;
LINE(DATA)      ; set text into array
 S COUNT=COUNT+1
 S TEXT(COUNT)=DATA
 Q
 ;
VERSION ;;17.7
