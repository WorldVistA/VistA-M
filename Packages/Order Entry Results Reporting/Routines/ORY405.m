ORY405 ;SLC/JLC - ENVIRONMENTAL CHECK ROUTINE ;May 5, 2022@16:30:00
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**405**;Dec 17, 1997;Build 211
 ;
PRE ;Preinstall routine for V32
 D INDPR^ORY405NV  ;IND
 D REMOPT
 Q
 ;
POST ;Post install routine for V32
 D RPSO,QQOPU
 D ORDRSN,OVRDRSN
 D MES^XPDUTL("")
 D EN^ORY405NV
 D INDPT^ORY405NV  ;IND
 D CLINMED^ORY405NV  ; Remove the Route and Days supply prompts from PSJ OR CLINIC OE
 D ADDMENU
 D PARS
 D RI10097
 Q
 ;
QQOPU ;
 N ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTIO,TEXT,ZTSK
 S ZTDESC="Update to Outpatient Meds Quick Orders"
 S TEXT=ZTDESC_" has been queued, task number "
 S ZTRTN="QOPICKUP^ORY405"
 S ZTIO=""
 S ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 I $D(ZTSK) S TEXT=TEXT_ZTSK D MES^XPDUTL(.TEXT)
 Q
 ;
QOPICKUP ;Clean up any PICKUP entries in Quick Orders that are set to "C" for Clinic Pickup
 N ARRAY,DIALOG,INPUT,PROMPT,SUB
 K ^XTMP("OR PU QO LIST")
 S ^XTMP("OR PU QO LIST",0)=$$FMADD^XLFDT($$NOW^XLFDT,30)_U_$$NOW^XLFDT
 S PROMPT=$O(^ORD(101.41,"B","OR GTX ROUTING",""))
 S SUB="OR PU QO"
 K ^TMP($J,SUB)
 S INPUT("PSO OERR")=""
 D FINDQO^ORQOUTL(.ARRAY,.INPUT,SUB,0,1,0,0)
 S DIALOG="" F  S DIALOG=$O(^TMP($J,SUB,DIALOG)) Q:'DIALOG  D
 .I $D(^TMP($J,SUB,DIALOG,"ORDIALOG",PROMPT)) D
 ..I $G(^TMP($J,SUB,DIALOG,"ORDIALOG",PROMPT,1))'="C" Q
 ..D QOEMPTY(DIALOG,PROMPT)
 ..S ^XTMP("OR PU QO LIST","LIST",DIALOG)=""
 D QOREPORT
 Q
 ;
QOEMPTY(ORQO,ORPROMPT) ;Empty the prompt for this qo
 N ORSUB S ORSUB=$O(^ORD(101.41,ORQO,6,"D",ORPROMPT,""))
 S ^ORD(101.41,ORQO,6,ORSUB,1)=""
 Q
 ;
QOREPORT ;Send a mailman message of updated QOs
 K ^TMP("OR MSG",$J),XMY
 N CNT,XMDUZ,XMSUB,XMTEXT,XMY,XMMG
 S CNT=0,XMDUZ="CPRS, SEARCH",XMSUB="CLINIC PICKUP QUICK ORDER CONVERSION",XMTEXT="^TMP(""OR MSG"",$J,",XMY(DUZ)="",XMY("G.OR CACS")=""
 S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="The following report lists Outpatient Medication Quick Orders where the "
 S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="pickup was set to CLINIC.  These Quick Orders have had the pickup prompt "
 S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="cleared of this value."
 S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=""
 I $D(^XTMP("OR PU QO LIST")) D
 .N ORFLAG S ORFLAG=0
 .N ORI S ORI=0 F  S ORI=$O(^XTMP("OR PU QO LIST","LIST",ORI)) Q:'ORI  D
 ..I ORFLAG=0 D
 ...S ORFLAG=1
 ...S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="QO NAME                       QO DISPLAY TEXT"
 ...S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="==============================================================================="
 ..S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=$$PAD^ORCHTAB($P(^ORD(101.41,ORI,0),U,1),30)_$P(^ORD(101.41,ORI,0),U,2)
 I CNT=4 S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="None Found"
 D ^XMD
 Q
 ;
REMOPT ;
 D BMES^XPDUTL("Removing the following options from menu ORCM MGMT")
 I $$DELETE^XPDMENU("ORCM MGMT","OR SUPPLY UTIL MENU") D BMES^XPDUTL("  OR SUPPLY UTIL MENU")
 I $$DELETE^XPDMENU("ORCM MGMT","OR IV ADD FREQ UTILITY") D BMES^XPDUTL("  OR IV ADD FREQ UTILITY")
 I $$DELETE^XPDMENU("ORCM MGMT","OR QO FREETEXT REPORT") D BMES^XPDUTL("  OR QO FREETEXT REPORT")
 I $$DELETE^XPDMENU("ORCM MGMT","OR CONVERT INP TO IV") D BMES^XPDUTL("  OR CONVERT INP TO IV")
 I $$DELETE^XPDMENU("ORCM MGMT","OR CONV INPT QO TO CLIN ORD QO") D BMES^XPDUTL("  OR CONV INPT QO TO CLIN ORD QO")
 I $$DELETE^XPDMENU("ORCM MGMT","OR QO CASE REPORT") D BMES^XPDUTL("  OR QO CASE REPORT")
 I $$DELETE^XPDMENU("ORCM MGMT","OR MEDICATION QO CHECKER") D BMES^XPDUTL("  OR MEDICATION QO CHECKER")
 I $$DELETE^XPDMENU("ORCM MGMT","ORCM GMRC CSV CHECK") D BMES^XPDUTL("  ORCM GMRC CSV CHECK")
 I $$DELETE^XPDMENU("ORCM MGMT","ORCM UPD INDICATION QO") D BMES^XPDUTL("  ORCM UPD INDICATION QO")
 I $$DELETE^XPDMENU("ORCM MGMT","ORCM UPDATE TITRATION QO") D BMES^XPDUTL("  ORCM UPDATE TITRATION QO")
 Q
 ;
SENDDLG(ANAME) ; Return true if the current order dialog should be sent
 I ANAME="PSH OERR" Q 1
 I ANAME="PSO OERR" Q 1
 I ANAME="OR GTX ROUTING" Q 1
 I ANAME="OR GTX TITRATION" Q 1
 Q 0
 ;
ORDRSN ;Add a new Order Reason of Allergy/Adverse Drug Reaction
 N DA,FDAMSG,FILE,ORERR,ORDRSN,ORFDA,ORSYN,ORACT,ORERR,ORPKG,ORNAT,ORIEN
 S ORIEN=""
 S FDAMSG=""
 S ORDRSN="Allergy/Adverse Drug Reaction"
 S ORSYN="ADR"
 S ORACT="ACTIVE"
 S ORPKG="ORDER ENTRY/RESULTS REPORTING"
 S ORNAT="REJECTED"
 S FILE=100.03
 D BMES^XPDUTL("Adding "_ORDRSN_" to ORDER REASON (#100.03) file.")
 S DA=$$FIND1^DIC(FILE,"","X",ORDRSN)
 I DA>0 D  ;Update existing entry
 . S ORFDA(100.03,DA_",",.01)=ORDRSN
 . S ORFDA(100.03,DA_",",.03)=ORSYN
 . S ORFDA(100.03,DA_",",.04)=ORACT
 . S ORFDA(100.03,DA_",",.05)=ORPKG
 . S ORFDA(100.03,DA_",",.07)=ORNAT
 . L +^ORD(100.03,DA):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 . D FILE^DIE("E","ORFDA","FDAMSG")
 . L -^ORD(100.03,DA)
 . I $D(FDAMSG("DIERR")) D  Q
 .. N ERR,TEXT,SWTCH
 .. D BMES^XPDUTL("Failed to update entry "_ORDRSN_" (#"_DA_")!!")
 .. D MES^XPDUTL("     Please contact support!")
 .. S (ERR,SWTCH)=0 F  S ERR=$O(FDAMSG("DIERR",ERR)) Q:+ERR=0  D
 ... S TEXT=$G(FDAMSG("DIERR",ERR,"TEXT",1))
 ... I TEXT'="" D
 .... I SWTCH=0 S SWTCH=1 D MES^XPDUTL("Following error(s) were received:")
 .... D MES^XPDUTL("     "_TEXT)
 . D BMES^XPDUTL("Successfully updated "_ORDRSN_" (#"_DA_")!")
 . K FDAMSG
 I DA=0 D  ;Add new entry
 . N ERR,SWTCH
 . K FDAMSG
 . S FDAMSG=""
 . S ORFDA(100.03,"+1,",.01)=ORDRSN
 . S ORFDA(100.03,"+1,",.03)=ORSYN
 . S ORFDA(100.03,"+1,",.04)=ORACT
 . S ORFDA(100.03,"+1,",.05)=ORPKG
 . S ORFDA(100.03,"+1,",.07)=ORNAT
 . D UPDATE^DIE("E","ORFDA","ORIEN","FDAMSG")
 . I +ORIEN(1)>0 D
 .. D BMES^XPDUTL(ORDRSN_" has been successfully added to the")
 .. D MES^XPDUTL("     ORDER REASON (#100.03) file!")
 .. I $D(FDAMSG("DIERR")) D
 ... S (ERR,SWTCH)=0 F  S ERR=$O(FDAMSG("DIERR",ERR)) Q:+ERR=0  D
 .... S TEXT=$G(FDAMSG("DIERR",ERR,"TEXT",1))
 .... I TEXT'="" D
 ..... I SWTCH=0 S SWTCH=1 D MES^XPDUTL("     The Following error(s) were recorded, please contact support:")
 ..... D MES^XPDUTL("        "_TEXT)
 . I +ORIEN(1)<1 D
 .. D BMES^XPDUTL("Failed to add "_ORDRSN_"!!")
 .. D MES^XPDUTL("     Please contact support!")
 .. S (ERR,SWTCH)=0 F  S ERR=$O(FDAMSG("DIERR",ERR)) Q:+ERR=0  D
 ... S TEXT=$G(FDAMSG("DIERR",ERR,"TEXT",1))
 ... I TEXT'="" D
 .... I SWTCH=0 S SWTCH=1 D MES^XPDUTL("Following error(s) were received:")
 .... D MES^XPDUTL("     "_TEXT)
 . K FDAMSG
 I DA="" D  ;Failure
 . D BMES^XPDUTL("Failed to add "_ORDRSN_"!!")
 . D MES^XPDUTL("     Please contact support!")
 D BMES^XPDUTL("")
 Q
 ;
OVRDRSN ;Add the Order Check Override Reasons (#100.04) file entries
 N ACTIVE,DA,FAILURE,FDA,FDAIEN,FDAMSG,FILE,LINE,MSG,NAME,ORERR,SUCCESS
 N SYNONYM,TEXT,TYPE
 S FAILURE="     Failed to add the following entry, please contact support:"
 S SUCCESS="     SUCCESSFULLY ADDED: "
 D BMES^XPDUTL("Starting add/update of the ORDER CHECK OVERRIDE REASON (#100.04) file.")
 D MES^XPDUTL("")
 S FILE=100.04
 F LINE=1:1 Q:$L($T(ORDRCHK+LINE))<3  D
 . K FDA,FDAIEN,FDAMSG,MSG,ORERR
 . S FDAIEN(1)=LINE
 . S FDAMSG=""
 . S TEXT=$P($T(ORDRCHK+LINE),";;",2)
 . S NAME=$P(TEXT,U,1)
 . S SYNONYM=$P(TEXT,U,2)
 . S TYPE=$P(TEXT,U,3)
 . S ACTIVE=$P(TEXT,U,4)
 . S DA=$$FIND1^DIC(FILE,,"X",NAME)
 . S MSG(2)="          "_$S($L(NAME," ")>8:$P(NAME," ",1,8),1:NAME)
 . I $L(NAME," ")>8 S MSG(3)="          "_$P(NAME," ",9,9999)
 . I DA>0 D  Q  ;Update existing entry
 .. S FDA(100.04,DA_",",.01)=NAME
 .. S FDA(100.04,DA_",",.02)=SYNONYM
 .. S FDA(100.04,DA_",",.03)=TYPE
 .. S FDA(100.04,DA_",",.04)=ACTIVE
 .. L +^ORD(100.04,DA):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 .. D FILE^DIE("E","FDA","FDAMSG")
 .. L -^ORD(100.04,DA)
 .. I $D(FDAMSG("DIERR")) D  Q
 ... N ERR,MSGCNT,SWTCH
 ... S MSG(1)="     Failed to update entry #"_DA_":"
 ... S (ERR,SWTCH)=0 F  S ERR=$O(FDAMSG("DIERR",ERR)) Q:+ERR=0  D
 .... S TEXT=$G(FDAMSG("DIERR",ERR,"TEXT",1))
 .... I TEXT'="" D
 ..... I SWTCH=0 D
 ...... S SWTCH=1,MSGCNT=3
 ...... I $D(MSG(3)) S MSGCNT=4
 ...... S MSG(MSGCNT)="        Following errors were received:"
 ...... S MSGCNT=MSGCNT+1
 ..... S MSG(MSGCNT)="           "_TEXT
 ... D BMES^XPDUTL(.MSG)
 .. S MSG(1)="     Successfully updated entry #"_DA_":"
 .. D BMES^XPDUTL(.MSG)
 . I DA=0 D  Q  ;Add new entry
 .. S FDA(100.04,"+1,",.01)=NAME
 .. S FDA(100.04,"+1,",.02)=SYNONYM
 .. S FDA(100.04,"+1,",.03)=TYPE
 .. S FDA(100.04,"+1,",.04)=ACTIVE
 .. D UPDATE^DIE("","FDA","FDAIEN","FDAMSG")
 .. I +FDAIEN(1)>0 D
 ... S MSG(1)=SUCCESS
 .. I +FDAIEN(1)<1 D
 ... N ERR,MSGCNT,SWTCH
 ... S MSG(1)=FAILURE
 ... S (ERR,SWTCH)=0 F  S ERR=$O(FDAMSG("DIERR",ERR)) Q:+ERR=0  D
 .... S TEXT=$G(FDAMSG("DIERR",ERR,"TEXT",1))
 .... I TEXT'="" D
 ..... I SWTCH=0 D
 ...... S SWTCH=1,MSGCNT=3
 ...... I $D(MSG(3)) S MSGCNT=4
 ...... S MSG(MSGCNT)="        Following errors were received:"
 ...... S MSGCNT=MSGCNT+1
 ..... S MSG(MSGCNT)="           "_TEXT
 .. D BMES^XPDUTL(.MSG)
 . I DA="" D  ;Failure
 .. S MSG(1)=FAILURE
 .. D BMES^XPDUTL(.MSG)
 D BMES^XPDUTL("COMPLETED add/update of the ORDER CHECK OVERRIDE REASON (#100.04) file.")
 Q
 ;
ORDRCHK ;Order Check Override Reasons
 ;;Benefit of Therapy Outweighs Risk^BEN^B^1
 ;;Patient tolerating current therapy with this medication^PAT^B^1
 ;;Previous Adverse Reaction signs/symptoms managed by patient^PRE^B^1
 ;;Renewal of Current Therapy^REN^B^1
 ;;Will Monitor Closely for Adverse Effects^WILL^B^1
 ;;Documentation of Allergy/Adverse Reaction is in Error^DOCAA^B^1
 ;;Documentation of Allergy/Adverse Reaction is to different agent in same drug class^DOAD^B^1
 ;;Patient report per interview is inconsistent with remote allergy data.^REM^B^1
 Q
 ;
RPSO ;remove package PSO from the DONE entry in file #101.42
 D BMES^XPDUTL("Removing PSO from the entry DONE of the ORDER URGENCY (#101.42) file.")
 N IEN,DA,DIK
 S IEN=$O(^ORD(101.42,"S.PSO","DONE",""))
 Q:'IEN
 S DA=0 F  S DA=$O(^ORD(101.42,IEN,1,DA)) Q:'DA  I ^(DA,0)="PSO" D  Q
 .S DA(1)=IEN,DIK="^ORD(101.42,"_DA(1)_",1," D ^DIK Q
 Q
 ;
ADDMENU ;
 N ORSUCC,OROPT
 ;
 D BMES^XPDUTL("Adding the following options to menu OR VIMM MENU")
 F OROPT="PXV EDIT SEQUENCE^SEQ^20","PXV EDIT DEFAULT RESPONSES^DEF^22","PXV SKIN TEST READING CPT^SKC^40" D
 . S ORSUCC=$$ADD^XPDMENU("OR VIMM MENU",$P(OROPT,U,1),$P(OROPT,U,2),$P(OROPT,U,3))
 . I ORSUCC D BMES^XPDUTL("  "_$P(OROPT,U,1))
 . I 'ORSUCC D BMES^XPDUTL("  Error adding "_$P(OROPT,U,1)_" to OR VIMM MENU.")
 ;
 D BMES^XPDUTL("Adding the following options to menu ORCM REPORT/CONV UTILITIES")
 I $$ADD^XPDMENU("ORCM REPORT/CONV UTILITIES","ORCM GMRC CSV CHECK","CS",5) D BMES^XPDUTL("  ORCM GMRC CSV CHECK")
 I $$ADD^XPDMENU("ORCM REPORT/CONV UTILITIES","OR MEDICATION QO CHECKER","MR",10) D BMES^XPDUTL("  OR MEDICATION QO CHECKER")
 I $$ADD^XPDMENU("ORCM REPORT/CONV UTILITIES","OR QO CASE REPORT","CA",25) D BMES^XPDUTL("  OR QO CASE REPORT")
 I $$ADD^XPDMENU("ORCM REPORT/CONV UTILITIES","OR CONV INPT QO TO CLIN ORD QO","CO",30) D BMES^XPDUTL("  OR CONV INPT QO TO CLIN ORD QO")
 I $$ADD^XPDMENU("ORCM REPORT/CONV UTILITIES","OR CONVERT INP TO IV","CV",35) D BMES^XPDUTL("  OR CONVERT INP TO IV")
 I $$ADD^XPDMENU("ORCM REPORT/CONV UTILITIES","OR QO FREETEXT REPORT","DF",40) D BMES^XPDUTL("  OR QO FREETEXT REPORT")
 I $$ADD^XPDMENU("ORCM REPORT/CONV UTILITIES","OR IV ADD FREQ UTILITY","FR",45) D BMES^XPDUTL("  OR IV ADD FREQ UTILITY")
 I $$ADD^XPDMENU("ORCM REPORT/CONV UTILITIES","OR SUPPLY UTIL MENU","SP",50) D BMES^XPDUTL("  OR SUPPLY UTIL MENU")
 Q
 ;
PARS ; set Parameter values
 ;
 N ORINST,ORLIST,ORI,ORX,ORIMM,ORIMMS,ORERR
 ;
 D BMES^XPDUTL("Setting OR IMM REMINDER DIALOG values.")
 S ORINST=0  ;largest instance
 D GETLST^XPAR(.ORLIST,"SYS","OR IMM REMINDER DIALOG")
 S ORI=0
 F  S ORI=$O(ORLIST(ORI)) Q:'ORI  D
 . S ORX=$G(ORLIST(ORI))
 . I $P(ORX,U,2)="" Q
 . S ORIMMS($P(ORX,U,2))=""  ; list of immunizations already defined
 . I $P(ORX,U,1)>ORINST S ORINST=$P(ORX,U,1)
 ;
 ; See if other COVID-19 Imms need to be added
 S ORIMM=0
 F  S ORIMM=$O(^AUTTIMM(ORIMM)) Q:'ORIMM  D   ;ICR  1990
 . S ORX=$G(^AUTTIMM(ORIMM,0))
 . I $P(ORX,U,1)'["COVID-19" Q
 . I $P(ORX,U,3)'=211,$P(ORX,U,7) Q  ;exclude inactive (except Novavax)
 . I $D(ORIMMS(ORIMM)) Q  ;already defined
 . S ORINST=ORINST+1
 . K ORERR
 . D EN^XPAR("SYS","OR IMM REMINDER DIALOG",ORINST,"`"_ORIMM,.ORERR)
 . I +$G(ORERR)>0 D MES^XPDUTL("  ERROR #"_$P(ORERR,U)_": "_$P(ORERR,U,2))
 D MES^XPDUTL("  DONE")
 D BMES^XPDUTL("Setting OR RTN PROCESSED ALERTS value.")
 I $$GET^XPAR("SYS","OR RTN PROCESSED ALERTS")]"" D BMES^XPDUTL("OR RTN PROCESSED ALERTS value is already set") Q
 K ORERR
 D EN^XPAR("SYS","OR RTN PROCESSED ALERTS",1,"YES",.ORERR)
 I +$G(ORERR)>0 D MES^XPDUTL("  ERROR #"_$P(ORERR,U)_": "_$P(ORERR,U,2))
 D MES^XPDUTL("  DONE")
 ;
 Q
RI10097 ;;re-index 100.97
 N DIK
 D BMES^XPDUTL("Re-indexing 100.97, 'E' cross-reference...")
 K ^OR(100.97,"E")
 S DIK="^OR(100.97,",DIK(1)="8^E" D ENALL^DIK
 D BMES^XPDUTL("Completed re-indexing of 100.97")
 Q
