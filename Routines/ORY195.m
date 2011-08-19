ORY195 ;SLCOIFO - Pre and Post-init for patch OR*3*195 [10/4/04 7:21am] ; [1/20/05 9:26am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**195**;Dec 17, 1997
 ;
PRE ; initiate pre-init processes
 ;
 ; Dump previously-installed param templates w/bad "B" x-ref entries:
 ;
 N DA,DIK
 ;
 S DA=$O(^XTV(8989.52,"B","ORQQ SEARCH RANGE (DIVISION)",0))
 I +DA>0 S DIK="^XTV(8989.52," D ^DIK
 ;
 S DA=$O(^XTV(8989.52,"B","ORQQ SEARCH RANGE (SERVICE)",0))
 I +DA>0 S DIK="^XTV(8989.52," D ^DIK
 ;
 S DA=$O(^XTV(8989.52,"B","ORQQ SEARCH RANGE (SYSTEM)",0))
 I +DA>0 S DIK="^XTV(8989.52," D ^DIK
 ;
 S DA=$O(^XTV(8989.52,"B","ORQQ SEARCH RANGE (USER)",0))
 I +DA>0 S DIK="^XTV(8989.52," D ^DIK
 ;
 Q
 ;
POST ; initiate post-init processes
 ;
 I +$$PATCH^XPDUTL("TIU*1.0*112") D SURGREG
 I +$$PATCH^XPDUTL("OR*3.0*222") D GNRPCS
 I +$$PATCH^XPDUTL("MAG*3.0*7") D MAGRPC1
 I +$$PATCH^XPDUTL("MAG*3.0*37") D MAGRPC2
 D SETIMO
 D PARVAL
 D STUFDTRG
 D MAIL
 D Q^ORY195A ;Queue lab order check routine
 Q
 ;
MAIL ; send bulletin of installation time
 N COUNT,DIFROM,I,START,TEXT,XMDUZ,XMSUB,XMTEXT,XMY
 S COUNT=0,XMDUZ="CPRS PACKAGE",XMTEXT="TEXT("
 S XMSUB="Version "_$P($T(VERSION),";;",2)_" Installed"
 F I="G.CPRS GUI INSTALL@ISC-SLC.VA.GOV",DUZ S XMY(I)=""
 ;
 S X=$P($T(VERSION),";;",2)
 D LINE("Version "_X_" has been installed.")
 D LINE(" ")
 D LINE("Install complete:  "_$$FMTE^XLFDT($$NOW^XLFDT()))
 ;
 D ^XMD
 Q
 ;
LINE(DATA) ; set text into array
 S COUNT=COUNT+1
 S TEXT(COUNT)=DATA
 Q
 ;
SURGREG ; Register TIU SURGERY RPCs if TIU*1.0*112 present
 N MENU,RPC
 S MENU="OR CPRS GUI CHART"
 F RPC="TIU IS THIS A SURGERY?","TIU IDENTIFY SURGERY CLASS","TIU LONG LIST SURGERY TITLES","TIU GET DOCUMENTS FOR REQUEST" D INSERT(MENU,RPC)
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
SETIMO ; Create "CLINIC MEDICATIONS" display group
 N NDATA,DLG,IEN,X
 S (NDATA,DLG,IEN,X)=""
 S NDATA="CLINIC MEDICATIONS^Clin. Meds^C RX^"
 N DIC
 S DIC="^ORD(100.98,",DIC(0)="BX",X=$P(NDATA,U)
 D ^DIC
 I Y'=-1 S ^ORD(100.98,+Y,0)=NDATA Q
 I Y=-1 S DIC(0)="L" D ^DIC
 S DIC(0)="BX" D ^DIC
 S IEN=+Y
 I 'IEN Q
 N DIE,DA,DR
 S DIE="^ORD(100.98,",DA=IEN,DR="2///Clin. Meds;3///C RX"
 D ^DIE
 N DLAYGO
 S DA(1)=$O(^ORD(100.98,"B","PHARMACY",0)) Q:'DA(1)
 S:'$D(^ORD(100.98,DA(1),1,0)) ^(0)="^100.981P^^"
 S DIC="^ORD(100.98,"_DA(1)_",1,",DIC(0)="NLX",DLAYGO=100.98
 S X="CLINIC MEDICATIONS" D ^DIC
 K Y
 Q
PARVAL ;add Clin. Meds display group to SEQUENCE parameter
 N X
 Q:'$D(^ORD(100.98,"B","CLINIC MEDICATIONS"))
 S X=0,X=$O(^ORD(100.98,"B","CLINIC MEDICATIONS",X)) Q:'X  D 
 . D PUT^XPAR("PKG","ORWOR CATEGORY SEQUENCE",69,X)
 Q
 ;
SCH ; -- Adjust admin schedule Help Msg for Non-Std Schedules
 N SCH,I,DG,PKG,IPKG,DLG,PRMT,OR0
 S SCH=+$O(^ORD(101.41,"B","OR GTX SCHEDULE",0)) Q:SCH<1
 F I="I","UD","O","C" S X=+$O(^ORD(100.98,"B",I_" RX",0)) S:X DG(X)=""
 F I="RX","SPLY" S X=+$O(^ORD(100.98,"B",I,0)) S:X DG(X)=""
 F PKG="PSJ","PSO","PSS" D
 . S IPKG=+$O(^DIC(9.4,"C",PKG,0))
 . S DLG=0 F  S DLG=+$O(^ORD(101.41,"APKG",IPKG,DLG)) Q:DLG<1  D
 .. S OR0=$G(^ORD(101.41,DLG,0)) Q:$P(OR0,U,4)'="D"  Q:'$D(DG($P(OR0,U,5)))
 .. S PRMT=+$O(^ORD(101.41,DLG,10,"D",SCH,0)) Q:PRMT<1
 .. S ^ORD(101.41,DLG,10,PRMT,1)="Enter a standard administration schedule."
 Q
 ;
STUFDTRG ; Stuff existing date ranges into new parameters for CS and PCE.
 ;
 ; Get existing settings, stuff into new parameters.
 ;
 ; NOTE: ORQQCSDR params will allow "T, T+, T- settings.
 ;       ORQQEAPT params allow single value number entries only.
 ;
 N ORBE,ORBX,ORBZ,ORDUZ,ORERR,ORLST,ORNEG,ORSTART,ORSTOP,ORVAL
 ;
 ; First deal with PKG level settings.
 ;
 ; Clean out any existing settings:
 D NDEL^XPAR("PKG","ORQQEAPT ENC APPT START",.ORERR)
 D NDEL^XPAR("PKG","ORQQEAPT ENC APPT STOP",.ORERR)
 D NDEL^XPAR("PKG","ORQQCSDR CS RANGE START",.ORERR)
 D NDEL^XPAR("PKG","ORQQCSDR CS RANGE STOP",.ORERR)
 ;
 ; Get settings of previously-used high level params:
 S ORSTART=$$GET^XPAR("DIV^SYS^PKG","ORQQVS SEARCH RANGE START",1,"I")
 I '$L(ORSTART) S ORSTART=90
 S ORSTOP=$$GET^XPAR("DIV^SYS^PKG","ORQQAP SEARCH RANGE STOP",1,"I")
 I '$L(ORSTOP) S ORSTOP=90
 ;
 ; Stuff retrieved values into PKG level of first set of new params:
 D EN^XPAR("PKG","ORQQCSDR CS RANGE START",1,ORSTART)
 D EN^XPAR("PKG","ORQQCSDR CS RANGE STOP",1,ORSTOP)
 ;
 ; Treat "start" value and stuff it:
 S ORVAL=ORSTART,ORNEG=0
 I ORVAL["T" S ORVAL=$P(ORVAL,"T",2)
 I ORVAL["t" S ORVAL=$P(ORVAL,"t",2)
 I ORVAL["-" S ORNEG=1,ORVAL=$P(ORVAL,"-",2)
 I ORVAL["+" S ORVAL=$P(ORVAL,"+",2)
 S ORVAL=+ORVAL
 I 'ORNEG S ORVAL=0 ; Can't have later than "Today" for "start."
 D EN^XPAR("PKG","ORQQEAPT ENC APPT START",1,ORVAL)
 ;
 ; Treat "stop" value and stuff it:
 S ORVAL=ORSTOP,ORNEG=0
 I ORVAL["T" S ORVAL=$P(ORVAL,"T",2)
 I ORVAL["t" S ORVAL=$P(ORVAL,"t",2)
 I ORVAL["-" S ORNEG=1,ORVAL=$P(ORVAL,"-",2)
 I ORVAL["+" S ORVAL=$P(ORVAL,"+",2)
 S ORVAL=+ORVAL
 I ORNEG S ORVAL=0 ; Won't allow earlier than "Today" for "stop."
 D EN^XPAR("PKG","ORQQEAPT ENC APPT STOP",1,ORSTOP)
 ;
 ; Deal with User level settings.
 ;
 S (ORBE,ORBX,ORBZ,ORDUZ,ORERR,ORLST,ORNEG,ORVAL)=""
 ;
 ; Begin with the START parameter:
 D ENVAL^XPAR(.ORLST,"ORQQAP SEARCH RANGE START",1,.ORERR)
 I 'ORERR,$G(ORLST)>0 D
 .F ORBX=1:1:ORLST S ORBE=$O(ORLST(ORBE)) D
 ..S ORBZ=$P(ORBE,";",2)
 ..I ORBZ="VA(200," S ORDUZ=$P(ORBE,";") I $L($G(ORDUZ)) D
 ...S ORVAL=ORLST(ORBE,1) ; Current setting.
 ...;
 ...; Eliminate any existing entries:
 ...D NDEL^XPAR("USR.`"_ORDUZ,"ORQQCSDR CS RANGE START",.ORERR)
 ...;
 ...; Stuff value:
 ...D EN^XPAR("USR.`"_ORDUZ,"ORQQCSDR CS RANGE START",1,ORVAL)
 ...;
 ...; Treat value:
 ...S ORNEG=0
 ...I ORVAL["T" S ORVAL=$P(ORVAL,"T",2)
 ...I ORVAL["t" S ORVAL=$P(ORVAL,"t",2)
 ...I ORVAL["-" S ORNEG=1,ORVAL=$P(ORVAL,"-",2)
 ...I ORVAL["+" S ORVAL=$P(ORVAL,"+",2)
 ...S ORVAL=+ORVAL
 ...I 'ORNEG S ORVAL=0 ; Can't have later than "Today" for "start."
 ...;
 ...; Eliminate any existing entries:
 ...D NDEL^XPAR("USR.`"_ORDUZ,"ORQQEAPT ENC APPT START",.ORERR)
 ...;
 ...; Stuff value:
 ...D EN^XPAR("USR.`"_ORDUZ,"ORQQEAPT ENC APPT START",1,ORVAL)
 ;
 ; Now do the STOP parameter:
 S (ORBE,ORBX,ORBZ,ORDUZ,ORERR,ORLST,ORNEG,ORVAL)=""
 ;
 D ENVAL^XPAR(.ORLST,"ORQQVS SEARCH RANGE STOP",1,.ORERR)
 I 'ORERR,$G(ORLST)>0 D
 .F ORBX=1:1:ORLST S ORBE=$O(ORLST(ORBE)) D
 ..S ORBZ=$P(ORBE,";",2)
 ..I ORBZ="VA(200," S ORDUZ=$P(ORBE,";") I $L($G(ORDUZ)) D
 ...S ORVAL=ORLST(ORBE,1) ; Current setting.
 ...;
 ...; Eliminate any existing entries:
 ...D NDEL^XPAR("USR.`"_ORDUZ,"ORQQCSDR CS RANGE STOP",.ORERR)
 ...;
 ...; Stuff value:
 ...D EN^XPAR("USR.`"_ORDUZ,"ORQQCSDR CS RANGE STOP",1,ORVAL)
 ...;
 ...; Treat parameter value:
 ...S ORNEG=0
 ...I ORVAL["T" S ORVAL=$P(ORVAL,"T",2)
 ...I ORVAL["t" S ORVAL=$P(ORVAL,"t",2)
 ...I ORVAL["-" S ORNEG=1,ORVAL=$P(ORVAL,"-",2)
 ...I ORVAL["+" S ORVAL=$P(ORVAL,"+",2)
 ...S ORVAL=+ORVAL
 ...I ORNEG S ORVAL=0 ; Can't have earlier than "Today" for "stop."
 ...;
 ...; Eliminate any existing entries:
 ...D NDEL^XPAR("USR.`"_ORDUZ,"ORQQEAPT ENC APPT STOP",.ORERR)
 ...;
 ...; Stuff value:
 ...D EN^XPAR("USR.`"_ORDUZ,"ORQQEAPT ENC APPT STOP",1,ORVAL)
 ;
 Q
 ;
GNRPCS ;
 N MENU,I
 S MENU="OR CPRS GUI CHART"
 F I="ORWGN GNLOC","ORWGN AUTHUSR" D INSERT(MENU,I)
 Q
 ;
MAGRPC1 ;  Register Imaging RPC if MAG*3.0*7 present (DBIA 4526)
 D INSERT("OR CPRS GUI CHART","MAG4 REMOTE IMPORT")
 Q
 ;
MAGRPC2 ; Register Imaging RPCS if MAG*3.0*37 installed (DBIA 4528/4530)
 D INSERT("OR CPRS GUI CHART","MAG IMPORT CHECK STATUS")
 D INSERT("OR CPRS GUI CHART","MAG IMPORT CLEAR STATUS")
 Q
 ;
VERSION ;;25.28
