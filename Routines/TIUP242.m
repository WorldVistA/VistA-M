TIUP242 ; SLC/JER - Installer Routine for TIU*1*242 ;08/14/2008
 ;;1.0;TEXT INTEGRATION UTILITIES;**242**;Jun 20, 1997;Build 7
 Q
 ;=======================================================
PRE ;Pre-install - If the Exchange File entry already exists delete it.
 N ARRAY,IC,IND,LIST,LUVALUE,NUM
 D EXARRAY(.ARRAY)
 S IC=0
 F  S IC=$O(ARRAY(IC)) Q:'IC  D
 . S LUVALUE(1)=ARRAY(IC,1)
 . D FIND^DIC(811.8,"","","U",.LUVALUE,"","","","","LIST")
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
 ;====================================================
EXARRAY(ARRAY) ;List of exchange entries used by delete and install
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="TIU*1*242 20080814"
 S ARRAY(LN,2)="08/14/2008@08:20:45"
 S ARRAY(LN,3)="O"
 ;
 Q
 ;
 ;==========================================
POST ;Post-install.
 N ACTION,EXARRAY,IC,IEN,LUVALUE,PXRMINST,TEXT,TIUDC,TIUFPRIV
 S (PXRMINST,TIUFPRIV)=1
 D EXARRAY(.EXARRAY)
 S IC=0
 F  S IC=$O(EXARRAY(IC)) Q:'IC  D
 . S LUVALUE(1)=EXARRAY(IC,1),LUVALUE(2)=EXARRAY(IC,2)
 . S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 . I IEN=0 D BMES^XPDUTL("Reminder Exchange entry "_LUVALUE(1)_" not properly installed.") Q
 . S TEXT="Installing Reminder Exchange entry "_LUVALUE(1)
 . D BMES^XPDUTL(TEXT)
 . S ACTION=EXARRAY(IC,3)
 . D INSTALL^PXRMEXSI(IEN,ACTION,1)
 ;Map new SECURE MESSAGING Title to Enterprise Standard Title MHV DIALOG NOTE
 D MAP($$DT("DOC"))
 ;Attach new SECURE MESSAGING Document Class to Class PROGRESS NOTES
 D ATTACH($$DT("DC"))
 Q
 ;
 ;==========================================
DT(TYPE) ; Find IEN of SECURE MESSAGING Document Class
 N TIUY,POP,TIUNM S (POP,TIUY)=0,TIUNM=$S(TYPE="DOC":"SECURE MESSAGING",1:"SECURE MESSAGING DOCUMENTS")
 F  S TIUY=$O(^TIU(8925.1,"B",TIUNM,TIUY)) Q:+TIUY'>0  D  Q:POP
 . I $P($G(^TIU(8925.1,+TIUY,0)),U,4)=TYPE S POP=1
 Q TIUY
 ;
 ;==========================================
MAP(TIUDA) ; Map new SECURE MESSAGING Title to Enterprise Standard Title MHV DIALOG NOTE
 N ERR,IENS,FLAGS,FDA,TIUFPRIV
 I +TIUDA'>0 D BMES^XPDUTL("SECURE MESSAGING TITLE NOT PROPERLY INSTALLED.") Q
 S TIUFPRIV=1,IENS=TIUDA_","
 S FDA(8925.1,IENS,1501)="MHV DIALOG NOTE"
 S FDA(8925.1,IENS,1502)=$$FMTE^XLFDT($$NOW^XLFDT)
 S FDA(8925.1,IENS,1503)="`"_DUZ
 S FLAGS="ET"
 D FILE^DIE(FLAGS,"FDA","ERR")
 ; if filing error occurs, write message to install log & quit
 I $D(ERR) D  Q
 . D BMES^XPDUTL("Unable to map SECURE MESSAGING TITLE to MHV DIALOG NOTE - Please notify CAC.")
 ; otherwise activate title
 K FDA
 S FDA(8925.1,IENS,".07")="ACTIVE"
 D FILE^DIE(FLAGS,"FDA","ERR")
 ; if filing error occurs, write message to install log
 I $D(ERR) D
 . D BMES^XPDUTL("Unable to activate SECURE MESSAGING TITLE - Please notify CAC.")
 Q
 ;
 ;==========================================
ATTACH(TIUDA) ; Attach new SECURE MESSAGING Document Class to Class PROGRESS NOTES
 N D,D0,DI,DIY,DQ,DA,DIC,DLAYGO,DIE,DR,I,TIUI,TIUFPRIV,X,Y,XQORM
 I +TIUDA'>0 D BMES^XPDUTL("SECURE MESSAGING DOCUMENT CLASS NOT PROPERLY INSTALLED.") Q
 S TIUFPRIV=1
 S DIC="^TIU(8925.1,3,10,",DLAYGO=8925.14,DIC(0)="LNX"
 S X="`"_TIUDA,DA(1)=3
 D ^DIC Q:+Y'>0
 S TIUI=$P(^TIU(8925.1,3,10,0),U,4)
 S DA(1)=3,DA=+Y,DIE=DIC
 S DR="4////Secure Messaging"
 D ^DIE
 ; Serialize menu items
 S (DA,TIUI)=0
 F  S DA=$O(^TIU(8925.1,3,10,DA)) Q:+DA'>0  D
 . S TIUI=TIUI+1,DR="2////^S X=TIUI;3////^S X=TIUI" D ^DIE
 ; Re-compile menu
 K ^XUTL("XQORM","3;TIU(8925.1,")
 S XQORM="3;TIU(8925.1,",XQORM(0)="" D ^XQORM
 Q
