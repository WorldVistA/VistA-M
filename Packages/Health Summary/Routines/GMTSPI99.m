GMTSPI99 ;SLC/WAT - INSTALL ROUTINES FOR HRMH GMTS COMPONENTS ;12/01/11  11:13
 ;;2.7;Health Summary;**99**;Oct 20, 1995;Build 45
 ;
 ;UPDATE^DIE 2053
 ;^DIK 10013
 ;FIND and $$FIND1^DIC 2051
 ;CLEAN^DILF 2054
 ;B/MES^XPDUTL, $$PATCH^XPDUTL 10141
 ;^PXRMEXSI 4371
 ;5687 - allows GMTS to transport Reminder Exchange files in KIDS build
 ;
 ; check enviro-abort if 99 already installed.  if national IENs are already used or HS component name already exists, abort and advise.
 N GMTSABRT
 I $$PATCH^XPDUTL("GMTS*2.7*99") D BMES^XPDUTL("GMTS*2.7*99 has been previously installed.  Environment check complete.") Q
 D BMES^XPDUTL(" Verifying installation environment...")
 D MES^XPDUTL("Checking Health Summary Component file (#142.1)")
 I +$$LU(142.1,"MAS CONTACTS","X")>0!($O(^GMT(142.1,"B","MAS CONTACTS",""))=253) D
 .D MES^XPDUTL(" Environment Error:  NAME or IEN collision with MAS CONTACTS.") S GMTSABRT=1
 ;
 I +$$LU(142.1,"MAS MH CLINIC VISITS FUTURE","X")>0!($O(^GMT(142.1,"B","MAS MH CLINIC VISITS FUTURE",""))=254) D
 .D MES^XPDUTL(" Environment Error:  NAME or IEN collision with MAS MH CLINIC VISITS FUTURE.") S GMTSABRT=1
 ;
 I +$$LU(142.1,"MH HIGH RISK PRF HX","X")>0!($O(^GMT(142.1,"B","MH HIGH RISK PRF HX",""))=255) D
 .D MES^XPDUTL(" Environment Error:  NAME or IEN collision with MH HIGH RISK PRF HX.") S GMTSABRT=1
 ;
 I +$$LU(142.1,"MH TREATMENT COORDINATOR","X")>0!($O(^GMT(142.1,"B","MH TREATMENT COORDINATOR",""))=256) D
 .D MES^XPDUTL(" Environment Error:  NAME or IEN collision with MH TREATMENT COORDINATOR.") S GMTSABRT=1
 ;
 I +$G(GMTSABRT) D BMES^XPDUTL("  Health Summary Component file IENs 253, 254, 255 and 256 must be empty or non-existent.")
 I +$G(GMTSABRT) D BMES^XPDUTL(" Please re-install GMTS*2.7*99 after the necessary changes have been made.") S XPDABORT=1 Q
 Q
 ;
LU(FILE,NAME,FLAGS,SCREEN,INDEXES) ; call FileMan Finder to look up file entry
 Q $$FIND1^DIC(FILE,"",$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN),"MSGERR")
 ;
PRE ; cleanup previous if exists
 D DELEX
 D DELCOMP
 D DELHSTYP
 D BMES^XPDUTL("Re-index and rebuild after housekeeping")
 D BUILD^GMTSXPD3
 Q
 ;
POST ;create components, stubs, install exchange file
 D INSTUB
 D BMES^XPDUTL("Installing Health Summary items and TIU/HS object.")
 D SMEXINS^PXRMEXSI("EXARRAY","GMTSPI99")
 D BMES^XPDUTL("Re-index and rebuild after install")
 D BUILD^GMTSXPD3 ;rebuild Ad-Hoc
 Q
 ;
DELEX ;remove prior version of exchange entry
 N ARRAY,IC,IND,LIST,GMTSVAL,NUM
 D BMES^XPDUTL("Cleaning up any previous versions of Reminder Exchange file entry")
 D EXARRAY("L",.ARRAY)
 S IC=0
 F  S IC=$O(ARRAY(IC)) Q:'IC  D
 . S GMTSVAL(1)=ARRAY(IC,1)
 . D FIND^DIC(811.8,"","","U",.GMTSVAL,"","","","","LIST")
 . I '$D(LIST) Q
 . S NUM=$P(LIST("DILIST",0),U,1)
 . I NUM'=0 D
 .. F IND=1:1:NUM D
 ... N DA,DIK
 ... S DIK="^PXD(811.8,"
 ... S DA=LIST("DILIST",2,IND)
 ... D ^DIK
 Q
 ;
DELCOMP ;delete HS components
 D BMES^XPDUTL("Cleaning up any previous test versions of Health Summary Components")
 N DA,DIK,X,Y,NAME,COUNT,IDX,I,GMTSVAL
 S DIK="^GMT(142.1,"
 S DA=252
 ;check IEN 252, if NOT Medication Worksheet, then delete.
 I $D(^GMT(142.1,DA)) D
 .D:$P(^GMT(142.1,DA,0),U)='"Medication Worksheet (Tool #2)" ^DIK
 S DA=""
 S NAME="MAS CONTACTS^MAS MH CLINIC VISITS FUTURE^MH HIGH RISK PRF HX^MH TREATMENT COORDINATOR"
 F I=1:1:4 D
 .S GMTSVAL=$P(NAME,U,I)
 .D FIND^DIC(142.1,"","","X",GMTSVAL,"","","","","LIST")
 .I '$D(LIST) Q
 .S COUNT=$P(LIST("DILIST",0),U,1)
 .I COUNT'=0 D
 ..F IDX=1:1:COUNT D
 ...N DA,DIK
 ...S DIK="^GMT(142.1,"
 ...S DA=LIST("DILIST",2,IDX)
 ...D ^DIK
 Q
DELHSTYP ; remove HS Types
 D BMES^XPDUTL("Cleaning up any previous versions of Health Summary Types")
 N DA,DIK,X,Y
 S DIK="^GMT(142,"
 S DA=5000020 D ^DIK
 S DA=$O(^GMT(142,"B","VA-MH HIGH RISK PATIENT","")) D:+$G(DA) ^DIK
 Q
 ;
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="GMTS FOR HRMH"
 I MODE["I" S ARRAY(LN,2)="12/01/2011@11:10:12"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 Q
 ;
INSTUB ;create stubs for 142
 ;UPDATE^DIE(FLAGS,FDA_ROOT,IEN_ROOT,MSG_ROOT)
 D BMES^XPDUTL("Creating stub entries for Health Summary Types.")
 N FDA,MSG,HSIEN,NAME,NUMBER,I
 S NAME="MAS CONTACTS^MAS MH CLINIC VISITS FUTURE^MH HIGH RISK PRF HX^MH TREATMENT COORDINATOR"
 S NUMBER="253^254^255^256"
 F I=1:1:4 D
 .K FDA,HSIEN,MSG
 .S HSIEN(1)=$P(NUMBER,U,I)
 .S FDA(142.1,"+1,",.01)=$P(NAME,U,I)
 .D UPDATE^DIE("","FDA","HSIEN","MSG")
 .I $D(MSG)>0 D AWRITE("MSG")
 ;
 ;
 K FDA,MSG,HSIEN
 S FDA(142,"+1,",.01)="REMOTE MH HIGH RISK PATIENT"
 S HSIEN(1)=5000020
 D UPDATE^DIE("","FDA","HSIEN","MSG")
 I $D(MSG)>0 D AWRITE("MSG")
 D CLEAN^DILF
 Q
 ;
AWRITE(REF) ;Write all the descendants of the array reference.
 ;REF is the starting array reference, for example A or ^TMP("PXRM",$J).
 ;coied from PXRMUTIL
 N DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP,GMTSTEXT
 I REF="" Q
 S LN=0
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S LN=LN+1,GMTSTEXT(LN)=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 D MES^XPDUTL(.GMTSTEXT)
 Q
 ;
