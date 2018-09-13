TIUP246 ; SLC/JER - Installer Routine for TIU*1*246 ;02/03/09  10:15
 ;;1.0;TEXT INTEGRATION UTILITIES;**246**;Jun 20, 1997;Build 22
 Q
 ;
 ;=======================================================
PRE ; Pre-install - If the Exchange File entry already exists delete it.
 N LVL
 F LVL="DC","T" D
 . N ARRAY,LUVALUE,LIST,NUM
 . D EXARRAY(.ARRAY,LVL)
 . S LUVALUE(1)=ARRAY(1),LUVALUE(2)=ARRAY(2)
 . D FIND^DIC(811.8,"","","U",.LUVALUE,"","","","","LIST")
 . I '$D(LIST) Q
 . S NUM=$P(LIST("DILIST",0),U,1)
 . I NUM'=0 D
 .. N IND
 .. F IND=1:1:NUM D
 ... N DA,DIK
 ... S DIK="^PXD(811.8,"
 ... S DA=LIST("DILIST",2,IND)
 ... D ^DIK
 Q
 ;
 ;=======================================================
EXARRAY(ARRAY,LVL) ; List of exchange entries used by delete and install
 S ARRAY(1)=$S(LVL="T":"TIU*1*246 20090128 TL",1:"TIU*1*246 20090128 DC/TL")
 S ARRAY(2)=$S(LVL="T":"01/28/2009@17:09:58",1:"01/28/2009@17:05:57")
 S ARRAY(3)="O"
 Q
 ;
 ;=======================================================
POST ; Post-install.
 N ACTION,EXARRAY,IEN,LUVALUE,PXRMINST,TEXT,TIUDC,TIUFPRIV,TIUFWHO
 N TIUDCDA,TIUDCNM,TIUTDA,TIUETNM,TIUEDCNM,TIULVL
 S TIUEDCNM="TBI/POLYTRAUMA DOCUMENTS"
 S TIUETNM="TBI/POLYTRAUMA REHABILITATION/REINTEGRATION PLAN OF CARE"
 S TIUDCDA=$G(XPDQUES("POS001")),TIUDCNM=$G(XPDQUES("POS001","B"))
 I TIUDCNM="" S TIUDCNM=TIUEDCNM
 S (PXRMINST,TIUFPRIV)=1,TIUFWHO="N"
 S TIULVL=$S(TIUDCNM'=TIUEDCNM:"T",1:"DC")
 D EXARRAY(.EXARRAY,TIULVL)
 S LUVALUE(1)=EXARRAY(1),LUVALUE(2)=EXARRAY(2)
 S IEN=+$$FIND1^DIC(811.8,"","KU",.LUVALUE)
 I IEN=0 D BMES^XPDUTL("Reminder Exchange entry "_LUVALUE(1)_" not properly installed.") Q
 S TEXT="Installing Reminder Exchange entry "_LUVALUE(1)
 D BMES^XPDUTL(TEXT)
 S ACTION=EXARRAY(3)
 D INSTALL^PXRMEXSI(IEN,ACTION,1)
 S TIUTDA=$$FIND(TIUETNM,"DOC")
 I +TIUTDA'>0 D  Q
 . D BMES^XPDUTL("Title """_TIUETNM_"""")
 . D MES^XPDUTL("  NOT PROPERLY INSTALLED.")
 ; If user specified TBI/POLYTRAUMA DOCUMENTS as preferred Document Class,
 ; attach new TBI/POLYTRAUMA DOCUMENTS Document Class to Class PROGRESS NOTES
 I TIUDCNM=TIUEDCNM D  I 1
 . N TIUEDCDA S TIUEDCDA=$$FIND(TIUEDCNM,"DC")
 . I +TIUEDCDA'>0 D BMES^XPDUTL("Document Class """_TIUEDCNM_""" NOT PROPERLY INSTALLED.") Q
 . D ATTACH(TIUEDCDA,3)
 ; Otherwise, attach TIU/POLYTRAUMA Title to preferred Document Class
 E  D ATTACH(TIUTDA,TIUDCDA)
 ;Map new TBI/POLYTRAUMA CARE PLAN Title to Enterprise Standard Title TBI/POLYTRAUMA CARE PLAN NOTE
 D MAP(TIUTDA)
 Q
 ;
 ;=======================================================
FIND(TIUNM,TYPE) ; Find IEN of TBI/POLYTRAUMA Document Definition
 N TIUY,POP S (POP,TIUY)=0
 F  S TIUY=$O(^TIU(8925.1,"B",TIUNM,TIUY)) Q:+TIUY'>0  D  Q:POP
 . I $P($G(^TIU(8925.1,+TIUY,0)),U,4)=TYPE S POP=1
 Q TIUY
 ;
 ;=======================================================
ATTACH(TIUDA,TIUPDA) ; Attach Entry (TIUDA) to desired Parent (TIUPDA)
 N ERR,IENS,FLAGS,FDA,TIUFPRIV,TIUFWHO,XQORM
 S TIUFPRIV=1,TIUFWHO="N",IENS=TIUDA_","
 S FLAGS="K"
 S IENS="?+1,"_TIUPDA_","
 S FDA(8925.14,IENS,".01")=TIUDA
 D UPDATE^DIE(FLAGS,"FDA","","ERR")
 ; if filing error occurs, write message to install log
 I $D(ERR) D  Q
 . D BMES^XPDUTL("Unable to Attach "_$P($G(^TIU(8925.1,TIUDA,0)),U)_" to "_$P($G(^TIU(8925.1,TIUPDA,0)),U))
 . D MES^XPDUTL($G(ERR("DIERR",1,"TEXT",1)))
 ; Re-compile menu
 K ^XUTL("XQORM",TIUPDA_";TIU(8925.1,")
 S XQORM=TIUPDA_";TIU(8925.1,",XQORM(0)="" D ^XQORM
 Q
 ;
 ;=======================================================
MAP(TIUDA) ; Map new TBI/POLYTRAUMA Title to Enterprise Standard Title TBI TREATMENT PLAN NOTE
 N ERR,IENS,FLAGS,FDA,TIUFPRIV,TIUFWHO,TIUPROD S TIUPROD=$$PROD^XUPROD(1)
 I +TIUDA'>0 D BMES^XPDUTL("TBI/POLYTRAUMA REHABILITATION/REINTEGRATION PLAN OF CARE title not installed.") Q
 S TIUFPRIV=1,TIUFWHO="N",IENS=TIUDA_","
 S FDA(8925.1,IENS,1501)="TBI TREATMENT PLAN NOTE"
 S FDA(8925.1,IENS,1502)=$$FMTE^XLFDT($$NOW^XLFDT)
 S FDA(8925.1,IENS,1503)="`"_DUZ
 S FLAGS="ET"
 D FILE^DIE(FLAGS,"FDA","ERR")
 ; if filing error occurs, write message to install log & quit
 I $D(ERR) D  Q
 . D:TIUPROD BMES^XPDUTL("Unable to map TBI/POLYTRAUMA REHABILITATION/REINTEGRATION PLAN OF CARE title") I 1
 . D:TIUPROD MES^XPDUTL("  to TBI TREATMENT PLAN NOTE. You'll have to manually map the title.")
 . D:TIUPROD MES^XPDUTL("  "_$G(ERR("DIERR",1,"TEXT",1)))
 ; otherwise activate title
 K FDA
 S FDA(8925.1,IENS,".07")="ACTIVE"
 S FDA(8925.1,IENS,".13")="YES"
 D FILE^DIE(FLAGS,"FDA","ERR")
 ; if filing error occurs, write message to install log
 I $D(ERR) D  Q
 . D:TIUPROD BMES^XPDUTL("Unable to Activate TBI/POLYTRAUMA TITLE.")
 . D MES^XPDUTL($G(ERR("DIERR",1,"TEXT",1)))
 ; finally, check for entry in "ACL" cross-reference and if missing, call EN^DIK
 I +$O(^TIU(8925.1,"ACL",3,"TBI/POLYTRAUMA REHABILITATION/REINTEGRATION PLAN OF CARE",0))'>0 D
 . N DIK,DA S DIK="^TIU(8925.1,",DIK(1)=".07^ACL07",DA=TIUDA D EN^DIK
 Q
