ORY306 ;ISL/TC,JER - Pre- and Post-install for patch OR*3*306 ;02/15/13  09:34
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**306**;Dec 17, 1997;Build 43
 ;
PRE ; Initiate pre-init processes
 D UPDTRPT
 S DIK="^DD(101.52,",DA(1)=101.52,DA=23
 D ^DIK
 Q
 ;
POST ; Initiate post-init processes
 D SETMGS
 D REGRPCS
 ; *** NOTE: Remove DEA Subroutine and Call prior to deployment of I1 ***
 D DEA
 D DLGBULL
 D CONSQO
 D SENDMAIL
 D DELPARAM
 D DELRPC
 D PARAM
 D NOTPARAM
 D QPR^ORY306PR
 D ^ORY306ES
 Q
 ;
UPDTRPT ; Modify PL Clinical Reports in OE/RR REPORTS file (101.24) to support PL Data Standardization
 N I
 F I=1:1:4  D
 .N DIC,DA,X,J,ORIFN
 .S DIC="^ORD(101.24,",DIC(0)="BIXZ"
 .S X=$S(I=1:"ORRPW PROBLEM ACTIVE",I=2:"ORRPW PROBLEM ALL",I=3:"ORRPW DOD PROBLEM LIST ALL",1:"ORRPW PROBLEM INACTIVE")
 .D ^DIC I Y=-1 K DIC Q  ; perform top file level search for record X, if unsuccessful quit
 .S DA(1)=+Y,DIC=DIC_DA(1)_",3,",DIC(0)="LIXZ",ORIFN=DA(1)
 .I ORIFN>1000 D  ; if report is a national standard, then proceed to modify the below X fields in the subfile #101.243
 ..F J=1:1:9  D
 ...N X
 ...S X=$S(J=1:"Date of Onset",J=2:"Date Modified",J=3:"Provider Name    ",J=4:"Note Narrative",J=5:"[+]",J=6:"Exposures",J=7:"SNOMED CT Description",J=8:"Primary ICD-9-CM Code & Description",J=9:"Secondary ICD-9-CM Code & Description")
 ...I J>6 S DIC("DR")=".02///;.03///;.05///;.06///;.07///;.09///"
 ...D ^DIC I Y=-1 K DIC Q  ;perform subfile entry level search for record X, if unsuccessful quit
 ...N DIE,DA,DR,DR1 S DIE=DIC S DA=+Y,DA(1)=ORIFN
 ...I J>6 S DR1=";.02///NO;.05///YES;.06///"_$S(J=7:"18",J=8:"10",J=9:"20")_";.07///NO;.09///FREE TEXT"_$S(J=9:";.04///WORD PROCESSING",1:"")
 ...S DR=".03///"_$S(J=1:"8",J=2:"9",J=3:"10",J=4:"11",J=5:"13",J=6:"12",J=7:"5",J=8:"6",J=9:"7")_$S(J>6:DR1,1:"")
 ...D ^DIE K DIE,DR,DA,Y Q  ;edit the SEQUENCE and above DR1 fields of the X COLUMN HEADER multiple accordingly
 ..K DIC Q
 .Q
 Q
 ;
UNDO ;
 N I
 F I=1:1:3  D
 . N DIC,DA,X,J,ORIFN
 . S DIC="^ORD(101.24,",DIC(0)="BIXZ"
 . S X=$S(I=1:"ORRPW PROBLEM ACTIVE",I=2:"ORRPW PROBLEM ALL",1:"ORRPW PROBLEM INACTIVE")
 . D ^DIC I Y=-1 K DIC Q  ; perform top file level search for record X, if unsuccessful quit
 . S DA(1)=+Y,DIC=DIC_DA(1)_",3,",DIC(0)="IXZ",ORIFN=DA(1)
 . I ORIFN>1000 D  ; if report is a national standard, then proceed to modify the below X fields in the subfile #101.243
 . . F J=1:1:9  D
 . . . N X S X=$S(J=1:"Date of Onset",J=2:"Date Modified",J=3:"Provider Name    ",J=4:"Note Narrative",J=5:"[+]",J=6:"Exposures")
 . . . ;I J>6 S DIC("DR")=".02///;.03///;.05///;.06///;.07///;.09///"
 . . . D ^DIC I Y=-1 K DIC Q  ;perform subfile entry level search for record X, if unsuccessful quit
 . . . N DIE,DA,DR,DR1 S DIE=DIC S DA=+Y,DA(1)=ORIFN
 . . . ;I J>6 S DR1=".01///@;.02///@;.05///@;.06///@;.07///@;.09///@"_$S(J=9:";.04///@",1:"")
 . . . S DR=".03///"_$S(J=1:"5",J=2:"6",J=3:"7",J=4:"8",J=5:"10",J=6:"9")
 . . . D ^DIE K DIE,DR,DA,Y Q  ;edit the SEQUENCE and above DR1 fields of the X COLUMN HEADER multiple accordingly
 . . K DIC Q
 . Q
 Q
 ;
SETMGS ; set mail group for OR PROBLEM NTRT BULLETIN
 N ORBIEN,ORBNM,ORERRF,ORFDA,ORGIEN,ORGNM,ORLNE
 N ORMSG,ORTXT
 K ORMSG
 D BMES^XPDUTL("Attaching Mail Groups to OR PROBLEM NTRT BULLETIN")
 S ORBNM="OR PROBLEM NTRT BULLETIN"
 S ORBIEN=$$FIND1^DIC(3.6,"","X",ORBNM,"","","")
 ;If Bulletin not found, error
 I ORBIEN'>0 D  I 1
 . S ORMSG(1)="**"
 . S ORMSG(2)="** Bulletin "_ORBNM_" not found"
 . D MES^XPDUTL(.ORMSG) K ORMSG
 . S ORERRF=1
 ELSE  D
 . S ORGNM="OR CACS"
 . S ORGIEN=$$FIND1^DIC(3.8,"","X",ORGNM,"","","")
 . ;If Mail Group not found, error
 . I ORGIEN'>0 D  Q
 . . S ORMSG(1)="**"
 . . S ORMSG(2)="** Mail Group "_ORGNM_" not found"
 . . D MES^XPDUTL(.ORMSG) K ORMSG
 . . S ORERRF=1
 . ;Attach Mail Group to Bulletin
 . N ORFDA,ORIEN,ORMSG
 . S ORFDA(3.62,"?+2,"_ORBIEN_",",.01)=ORGIEN
 . D UPDATE^DIE("","ORFDA","ORIEN","ORMSG")
 . ;Check for error
 . I $D(ORMSG("DIERR")) D  Q
 . . S ORMSG(1)="**"
 . . S ORMSG(2)="** Unable to attach "_ORGNM_" to "_ORBNM
 . . D MES^XPDUTL(.ORMSG) K ORMSG
 . . S ORERRF=1
 . S ORMSG(1)=" "
 . S ORMSG(2)="... G."_ORGNM_$S($G(ORIEN(2,0))="?":" already",1:"")_" attached to "_ORBNM_" Bulletin"
 . D MES^XPDUTL(.ORMSG) K ORMSG
 ;Check for error
 I $G(ORERRF) D
 . S ORMSG(1)="** Post-installation interrupted"
 . S ORMSG(2)="** Please contact Enterprise VistA Support"
 . D MES^XPDUTL(.ORMSG) K ORMSG
 Q
 ;
INSERT(OPTION,RPC) ; Call FM Updater with each RPC
 ; Input  -- OPTION   Option file (#19) Name field (#.01)
 ;           RPC      RPC sub-file (#19.05) RPC field (#.01)
 ; Output -- None
 N FDA,FDAIEN,ERR,DIERR
 S FDA(19,"?1,",.01)=OPTION
 S FDA(19.05,"?+2,?1,",.01)=RPC
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q
 ;
REGRPCS ; Register new RPCs
 D INSERT("OR CPRS GUI CHART","ORQQPL PROBLEM NTRT BULLETIN")
 D INSERT("OR CPRS GUI CHART","ORWPCE GET DX TEXT")
 Q
 ;
SENDDLG(ANAME) ; Return true if the current order dialog should be sent
 I ANAME="GMRCOR CONSULT" Q 1
 I ANAME="GMRCOR REQUEST" Q 1
 Q 0
 ;
DLGBULL ; send bulletin about modified dialogs <on first install>
 N I,ORD
 F I="GMRCOR CONSULT","GMRCOR REQUEST" S ORD(I)=""
 D EN^ORYDLG(306,.ORD)
 Q
PARAM ;set param value/WAT
 N ORERR
 D BMES^XPDUTL("Setting paramteter ORCDGMRC EARLIEST DATE DEFAULT to TODAY")
 D EN^XPAR("PKG","ORCDGMRC EARLIEST DATE DEFAULT",1,"TODAY",.ORERR)
 I $D(ORERR) D BMES^XPDUTL("Error setting parameter: "_$P(ORERR,"^",2))
 Q
 ;
CONSQO ;get GMRC QOs with date default/WAT
 D BMES^XPDUTL("Finding all consult/procedure quick orders with a default value in the EARLIEST")
 D MES^XPDUTL("APPROPRIATE DATE field")
 D BMES^XPDUTL("A MailMan containing the list of quick orders will be sent to the installer")
 D WAIT^DICD
 D GMRCQO
 Q
GMRCQO ;find GMRC QO's to show the EAD default value/WAT
 K ^TMP("OREAD",$J)
 N GMRCPKG,DA,DA1,QONAME,RESPONSE,OREAD,COUNT
 S GMRCPKG=$O(^DIC(9.4,"B","CONSULT/REQUEST TRACKING",""))
 I +$G(GMRCPKG)'>0 D MES^XPDUTL(" CONSULT/REQUEST TRACKING NOT FOUND IN PACKAGE FILE  ") Q
 S OREAD=$O(^ORD(101.41,"B","OR GTX EARLIEST DATE",""))
 I +$G(OREAD)'>0 D MES^XPDUTL(" OR GTX EARLIEST DATE NOT FOUND IN ORDERABLE ITEMS FILE  ") Q
 S (QONAME,DA,DA1)="",COUNT=1
 S ^TMP("OREAD",$J,COUNT)="Contains Consult and Procedure quick orders with a default value stored",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="in the Earliest Appropriate Date field.",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="These quick orders should be reviewed in light of the new parameter",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="released in OR*3*306, ORCDGMRC EARLIEST DATE DEFAULT.",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="This parameter sets the default value for the Earliest Appropriate Date.",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="Data format of the entries in this message are as follows:",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="IEN from file 101.41^Quick Order Name^Earliest Appropriate Date value",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="",COUNT=COUNT+1
 F  S QONAME=$O(^ORD(101.41,"B",QONAME)) Q:QONAME=""  D
 .F  S DA=$O(^ORD(101.41,"B",QONAME,DA)) Q:DA=""  D
 ..Q:$P(^ORD(101.41,DA,0),U,4)'="Q"
 ..Q:$P(^ORD(101.41,DA,0),U,7)'=+GMRCPKG
 ..;now find the EAD in the items for this QO and show that value
 ..F  S DA1=$O(^ORD(101.41,DA,6,DA1)) Q:DA1=""  D
 ...Q:DA1<1
 ...S RESPONSE=$P(^ORD(101.41,DA,6,DA1,0),U,2)
 ...Q:RESPONSE'=+OREAD
 ...S ^TMP("OREAD",$J,COUNT)=DA_"^"_QONAME_"^"_^ORD(101.41,DA,6,DA1,1),COUNT=COUNT+1
 I COUNT'>9 S ^TMP("OREAD",$J,COUNT)="No Consult or Procedure quick orders found with a default value stored."
 Q
 ;
SENDMAIL ;SEND MESSAGE W/QOs AND DEFAULT VALUES/WAT
 N XMSUB,XMTEXT,XMY,XMZ,XMDUZ,XMMG,DIFROM
 S XMSUB="CONSULT/PROCEDURE QOs EARLIEST APPROPRIATE DATE DEFAULT VALUE"
 S:$G(DUZ) XMY(DUZ)=""
 S XMDUZ="OR*3.0*306 POST INSTALL"
 S XMTEXT="^TMP(""OREAD"",$J,"
 D ^XMD
 D BMES^XPDUTL("Message #"_$G(XMZ)_" has been sent")
 K ^TMP("OREAD",$J)
 Q
 ;
DELPARAM ;remove parameter values, then parameter/WAT
 ;;icr 2263 ^XPAR, 10141 XPDUTL
 N ORLIST,ENT,PAR,OERR
 ;get instances of parameter
 S ENT="",PAR="OR USE MH DLL"
 D ENVAL^XPAR(.ORLIST,PAR,1,.OERR)
 ;delete instances
 D BMES^XPDUTL("Attempting to remove values for parameter OR USE MH DLL...")
 F  S ENT=$O(ORLIST(ENT)) Q:ENT=""  D DEL^XPAR(ENT,PAR,1,.OERR) I $G(OERR)>0 W !,OERR
 D:+$G(OERR)=0 MES^XPDUTL("Delete successful")
 ;delete parameter
 N DA,DIK
 S DIK="^XTV(8989.51,"
 S DA=$O(^XTV(8989.51,"B",PAR,"")) Q:+$G(DA)'>0  D BMES^XPDUTL("Attempting to remove parameter OR USE MH DLL from PARAMETER DEFINITION file")
 D ^DIK D:+$G(DA)>0 MES^XPDUTL("Delete successful")
 Q
 ;
DELRPC ;remove ORQQPXRM MHDLLDMS/WAT
 ;;icr 10013 ^DIK, 10141 xpdutl
 N DIK,DA
 S DIK="^XWB(8994,"
 S DA=$O(^XWB(8994,"B","ORQQPXRM MHDLLDMS","")) I +$G(DA)'>0 D BMES^XPDUTL("RPC OQQPXRM MHDLLDMS not found.  Nothing deleted.") Q
 D BMES^XPDUTL("Attempting to remove ORQQPXRM MHDLLDMS from REMOTE PROCEDURE file")
 D ^DIK
 D:+$G(DA)>0 MES^XPDUTL("Delete successful")
 Q
 ;
 ; *** NOTE: Remove DEA Subroutine and Call prior to deployment of I1 ***
 ;
DEA ;
 N ORMSG,ORERR
 S ORMSG(1)="By completing the two-factor authentication protocol at this time, you are legally signing the prescription(s) and authorizing the transmission of the above information to the pharmacy for dispersing.  "
 S ORMSG(2)="The two-factor authentication protocol may only be completed by the practitioner whose name and DEA registration number appear above."
 D EN^XPAR("SYS","OR DEA TEXT",,.ORMSG,.ORERR)
 Q
NOTPARAM ; parameter transport routine
 K ^TMP($J,"XPARRSTR")
 N ENT,IDX,ROOT,REF,VAL,I
 S ROOT=$NAME(^TMP($J,"XPARRSTR")),ROOT=$E(ROOT,1,$L(ROOT)-1)_","  ;ICR #2336
 D LOAD
XX2 S IDX=0,ENT="PKG."_"ORDER ENTRY/RESULTS REPORTING"
 F  S IDX=$O(^TMP($J,"XPARRSTR",IDX)) Q:'IDX  D
 . N PAR,INST,ORVAL,ORERR K ORVAL
 . S PAR=$P(^TMP($J,"XPARRSTR",IDX,"KEY"),U),INST=$P(^("KEY"),U,2)
 . M ORVAL=^TMP($J,"XPARRSTR",IDX,"VAL")
 . D EN^XPAR(ENT,PAR,INST,.ORVAL,.ORERR)  ;ICR #2336
 K ^TMP($J,"XPARRSTR")
 Q
LOAD ; load data into ^TMP (expects ROOT to be defined)
 S I=1 F  S REF=$T(DATA+I) Q:REF=""  S VAL=$T(DATA+I+1) D
 . S I=I+2,REF=$P(REF,";",3,999),VAL=$P(VAL,";",3,999)
 . S @(ROOT_REF)=VAL
 Q
DATA ; parameter data
 ;;7000,"KEY")
 ;;ORB ARCHIVE PERIOD^DEA AUTO DC CS MED ORDER
 ;;7000,"VAL")
 ;;30
 ;;7001,"KEY")
 ;;ORB DELETE MECHANISM^DEA AUTO DC CS MED ORDER
 ;;7001,"VAL")
 ;;Individual Recipient
 ;;7002,"KEY")
 ;;ORB FORWARD BACKUP REVIEWER^DEA AUTO DC CS MED ORDER
 ;;7002,"VAL")
 ;;0
 ;;7003,"KEY")
 ;;ORB FORWARD SUPERVISOR^DEA AUTO DC CS MED ORDER
 ;;7003,"VAL")
 ;;0
 ;;7004,"KEY")
 ;;ORB FORWARD SURROGATES^DEA AUTO DC CS MED ORDER
 ;;7004,"VAL")
 ;;0
 ;;7005,"KEY")
 ;;ORB PROCESSING FLAG^DEA AUTO DC CS MED ORDER
 ;;7005,"VAL")
 ;;Disabled
 ;;7006,"KEY")
 ;;ORB PROVIDER RECIPIENTS^DEA AUTO DC CS MED ORDER
 ;;7006,"VAL")
 ;;OT
 ;;7007,"KEY")
 ;;ORB URGENCY^DEA AUTO DC CS MED ORDER
 ;;7007,"VAL")
 ;;High
 ;;7008,"KEY")
 ;;ORB ARCHIVE PERIOD^DEA CERTIFICATE REVOKED
 ;;7008,"VAL")
 ;;30
 ;;7009,"KEY")
 ;;ORB DELETE MECHANISM^DEA CERTIFICATE REVOKED
 ;;7009,"VAL")
 ;;Individual Recipient
 ;;7010,"KEY")
 ;;ORB FORWARD BACKUP REVIEWER^DEA CERTIFICATE REVOKED
 ;;7010,"VAL")
 ;;0
 ;;7011,"KEY")
 ;;ORB FORWARD SUPERVISOR^DEA CERTIFICATE REVOKED
 ;;7011,"VAL")
 ;;0
 ;;7012,"KEY")
 ;;ORB FORWARD SURROGATES^DEA CERTIFICATE REVOKED
 ;;7012,"VAL")
 ;;0
 ;;7013,"KEY")
 ;;ORB PROCESSING FLAG^DEA CERTIFICATE REVOKED
 ;;7013,"VAL")
 ;;Disabled
 ;;7014,"KEY")
 ;;ORB PROVIDER RECIPIENTS^DEA CERTIFICATE REVOKED
 ;;7014,"VAL")
 ;;OT
 ;;7015,"KEY")
 ;;ORB URGENCY^DEA CERTIFICATE REVOKED
 ;;7015,"VAL")
 ;;High
 ;;7016,"KEY")
 ;;ORB ARCHIVE PERIOD^DEA CERTIFICATE EXPIRED
 ;;7016,"VAL")
 ;;30
 ;;7017,"KEY")
 ;;ORB DELETE MECHANISM^DEA CERTIFICATE EXPIRED
 ;;7017,"VAL")
 ;;Individual Recipient
 ;;7018,"KEY")
 ;;ORB FORWARD BACKUP REVIEWER^DEA CERTIFICATE EXPIRED
 ;;7018,"VAL")
 ;;0
 ;;7019,"KEY")
 ;;ORB FORWARD SUPERVISOR^DEA CERTIFICATE EXPIRED
 ;;7019,"VAL")
 ;;0
 ;;7020,"KEY")
 ;;ORB FORWARD SURROGATES^DEA CERTIFICATE EXPIRED
 ;;7020,"VAL")
 ;;0
 ;;7021,"KEY")
 ;;ORB PROCESSING FLAG^DEA CERTIFICATE EXPIRED
 ;;7021,"VAL")
 ;;Disabled
 ;;7022,"KEY")
 ;;ORB PROVIDER RECIPIENTS^DEA CERTIFICATE EXPIRED
 ;;7022,"VAL")
 ;;O
 ;;7023,"KEY")
 ;;ORB URGENCY^DEA CERTIFICATE EXPIRED
 ;;7023,"VAL")
 ;;High
