ORY389 ;SP/WAT,RFR - PRE/POST INSTALL FOR OR*3*389 ;01/06/16  05:57
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**389**;Dec 17, 1997;Build 17
 Q
POST ;post
 D BMES^XPDUTL("Configuring order dialogs...")
 D UPDDGMAP
 D DLGBULL
 D PARVAL
 D BMES^XPDUTL("DONE")
 N ORPOST,ORSTNUM,XPDIDTOT
 S ORPOST=1,ORSTNUM=1,XPDIDTOT=4
 D QUEUE("re-index file #100","INDEX^ORY389(""?"")","OE/RR ADD C AND D INDEX TO FILE #100",.ORSTNUM)
 D QUEUE("find consult quick orders","CONSULT^ORY389","OE/RR FIND CONSULT QUICK ORDERS",.ORSTNUM)
 D QUEUE("supply orderable item report","SODLGCON^ORY389","OE/RR SUPPLY ORDERABLE ITEM REPORT",.ORSTNUM)
 D QUEUE("outpatient pharmacy quick order report","EN^ORY389A","OE/RR PSO QO REPORT",.ORSTNUM)
 Q
 ;
RESTART ;index redux
 N DIC,Y,X,DTOUT,DUOUT
 S DIC="^OR(100,",DIC(0)="AEQX",DIC("A")="ENTER THE STARTING ORDER NUMBER FROM THE STATUS EMAIL: "
 D ^DIC
 Q:+Y<1
 W !,"Queueing re-index..."
 D QUEUE("re-index file #100","INDEX^ORY389("_+Y_")","OE/RR ADD C AND D INDEX TO FILE #100")
 Q
 ;
QUEUE(ORMSG,ZTRTN,ZTDESC,ORCURITM) ;CREATE A SPECIFIED TASK
 ;PARAMETERS: ORMSG    => STRING CONTAINING THE TEXT TO OUTPUT TO THE SCREEN
 ;            ZTRTN    => STRING CONTAINING THE ROUTINE TASKMAN SHOULD EXECUTE
 ;            ZTDESC   => STRING CONTAINING THE TASK'S DESCRIPTION
 ;            ORCURITM => REFERENCE TO THE VARIABLE STORING THE NUMBER OF THE CURRENT ITEM
 N ZTDTH,ZTIO,ZTSK
 D BMES^XPDUTL("Queueing "_ORMSG_"...")
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,0,10)
 S ZTIO=""
 D ^%ZTLOAD
 I +$G(ZTSK)=0 D
 .I $G(ORPOST) D BMES^XPDUTL("Unable to queue the "_ORMSG_"; file a Remedy ticket for assistance.")
 .E  W "ERROR",!,"Unable to queue the "_ORMSG_"; file a Remedy ticket for assistance.",!
 E  D
 .I $G(ORPOST) D
 ..D BMES^XPDUTL("DONE - Task #"_ZTSK)
 ..D UPDATE^XPDID(ORCURITM)
 ..S ORCURITM=ORCURITM+1
 .E  W "DONE",!,"Task #"_ZTSK,!
 Q
 ;
INDEX(ORIFN) ;create indices
 ;100,2 DIALOG
 ;100,7 ITEM ORDERED
 N ORNODE,ORDLG,ORITEM,ORREP,ORSTAT,ORRECP
 F  S ORIFN=$O(^OR(100,ORIFN),-1) H:'(ORIFN#10000) 1 D  Q:$G(ORIFN)=""!($G(ZTSTOP)=1)
 .Q:+ORIFN'>0
 .I $D(^OR(100,ORIFN,0))'=0 D
 ..S ORNODE=^OR(100,ORIFN,0)
 ..S ORDLG=$P(ORNODE,U,5)
 ..S:$G(ORDLG)'="" ^OR(100,"C",$E(ORDLG,1,30),ORIFN)=""
 .I $D(^OR(100,ORIFN,3))'=0 D
 ..S ORNODE=^OR(100,ORIFN,3),ORDLG=""
 ..S ORDLG=$P(ORNODE,U,4)
 ..S:$G(ORDLG)'="" ^OR(100,"D",$E(ORDLG,1,30),ORIFN)=""
 .I ORIFN#1000=0,($$S^%ZTLOAD) N X S ZTSTOP=1,X=$$S^%ZTLOAD("Received shutdown request")
 ;SEND STATUS EMAIL
 I +$G(ZTSTOP)=0 D
 .S ORREP(1)="The file #100 re-index process from OR*3.0*389 was successfully completed."
 E  D
 .K ORREP
 .S ORREP(1)="The file #100 re-index process from OR*3.0*389 has unexpectedly stopped."
 .S ORREP(2)="If you or the system manager did not stop the process, please check the"
 .S ORREP(3)="error log and file a Remedy ticket for assistance."
 .S ORREP(4)=""
 .S ORREP(5)="To requeue the cleanup/conversion process, run RESTART^ORY389 from the"
 .S ORREP(6)="programmer prompt and when asked for the starting order number, enter"
 .S ORREP(7)=ORIFN+1
 S ORRECP(DUZ)=""
 S ORSTAT=$$MAIL^ORUTL("ORREP(","PATCH OR*3.0*389 ORDER RE-INDEX STATUS",.ORRECP)
 I +ORSTAT,($G(ZTSTOP)=1) D
 .S ^XTMP("ORY389",0)=$$FMADD^XLFDT($$NOW^XLFDT,7,0,0,0)_U_$$NOW^XLFDT_U_"OR*3*389 POST-INSTALL DATA"
 .S ^XTMP("ORY389","ORDER")=(ORIFN+1)
 S ZTREQ="@"
 Q
 ;
CONSULT ;find GMRC QO's to show the EAD default value/WAT
 K ^TMP("OREAD",$J)
 N ORGMRPKG,DA,DA1,QONAME,RESPONSE,OREAD,COUNT,TOTAL,ORDISABL,ORSTAT,ORLABEL
 S (QONAME,DA,DA1)="",COUNT=1
 S ORGMRPKG=$O(^DIC(9.4,"B","CONSULT/REQUEST TRACKING",""))
 S OREAD=$O(^ORD(101.41,"B","OR GTX EARLIEST DATE","")),ORLABEL="EARLIEST DATE"
 I $G(OREAD)="" S OREAD=$O(^ORD(101.41,"B","OR GTX CLINICALLY INDICATED DATE","")),ORLABEL="CLINICALLY INDICATED DATE"
 I +$G(OREAD)'>0 S ^TMP("OREAD",$J,COUNT)=(" OR GTX "_ORLABEL_" not found in ORDERABLE ITEMS file  ") G XM Q
 S ^TMP("OREAD",$J,COUNT)="Contains Consult and Procedure quick orders with a default value stored",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="in the "_ORLABEL_" field. These quick orders should be",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="reviewed in advance of the installation of CPRS GUI v30.B (OR*3*350)",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="and GMRC*3.0*81.",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="These patches rename the Earliest Date field and introduce a new parameter.",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="The new ORCDGMRC CLIN IND DATE DEFAULT parameter can be set for the",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="DIVISION, SYSTEM, and PACKAGE levels. The PACKAGE setting for the parameter",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="is null, which will force a provider to actively choose a value for",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="the date field.  Local settings may be chosen for the DIVISION and SYSTEM",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="levels. Refer to the parameter definition and the OR*3.0*389/350 patch",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="descriptions for further information.",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="Data format of the entries in this message are as follows:",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="IEN from file 101.41^Quick Order Name^"_ORLABEL_" value",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="If you change the value of the parameter, any quick orders in this list",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="that should reflect the new value, should have the "_ORLABEL,COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="field edited accordingly.",COUNT=COUNT+1
 S ^TMP("OREAD",$J,COUNT)="",COUNT=COUNT+1
 F  S QONAME=$O(^ORD(101.41,"B",QONAME)) Q:QONAME=""  D
 .F  S DA=$O(^ORD(101.41,"B",QONAME,DA)) Q:DA=""  D
 ..Q:$P(^ORD(101.41,DA,0),U,4)'="Q"
 ..Q:$P(^ORD(101.41,DA,0),U,7)'=+$G(ORGMRPKG)
 ..;now find the EAD in the items for this QO and show that value
 ..F  S DA1=$O(^ORD(101.41,DA,6,DA1)) Q:DA1=""  D
 ...Q:DA1<1
 ...S RESPONSE=$P(^ORD(101.41,DA,6,DA1,0),U,2)
 ...Q:RESPONSE'=+OREAD
 ...S ORDISABL=$P(^ORD(101.41,DA,0),U,3)
 ...S ORDISABL=$S($L($G(ORDISABL))>0:"YES",1:"")
 ...S ^TMP("OREAD",$J,COUNT)=DA_"^"_QONAME_"^"_^ORD(101.41,DA,6,DA1,1)_"^"_$G(ORDISABL),COUNT=COUNT+1
 I COUNT'>18 S ^TMP("OREAD",$J,COUNT)="No Consult or Procedure quick orders found with a default value stored."
 S TOTAL=0  S:COUNT>18 TOTAL=COUNT-19 S ^TMP("OREAD",$J,COUNT)="TOTAL NUMBER OF QOs FOUND: "_TOTAL,COUNT=COUNT+1
XM S ORSTAT=$$MAIL^ORUTL("^TMP(""OREAD"",$J,","CONSULT/PROCEDURE QOs EARLIEST APPROPRIATE DATE DEFAULT VALUE",,"ORY389CQORECIPS")
 S ZTREQ="@"
 Q
 ;
SODLGCON ;LOOP THROUGH ALL ORDERABLE ITEMS AND REPORT ON THOSE THAT ARE SUPPLY (TASKED)
 N ORCHK,ORDATE,ORDGIEN,ORDLGIDX,ORDLGIEN,ORDRGIEN,OREXIT,ORFIELDS,ORGROUP,ORIDX,ORTEXT
 N ORITMHDR,ORITMIEN,ORLINE,ORPHOI,ORQIEN,ORQORDER,ORRESULT,ORDDHDR,ORIEN,ORISSUP,ORSTAT
 N ORCHNKBR,ORGO,ORDLG
 I '$D(ZTQUEUED) W "Assembling the supply orderable item report...",!
 S ORGO=1,ORTEXT=$NA(^TMP($J,"ORSODLGCON")) K @ORTEXT
 S ORDLG("ORDERABLE ITEM")=+$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM",0))
 I ORDLG("ORDERABLE ITEM")=0 D
 .S @ORTEXT@(1)="Unable to find the OR GTX ORDERABLE ITEM dialog in the ORDER DIALOG file"
 .S @ORTEXT@(2)="(#101.41). Please log a Remedy ticket for assistance.",@ORTEXT=2
 S ORDLG("ADDITIVE")=+$O(^ORD(101.41,"B","OR GTX ADDITIVE",0))
 I ORDLG("ADDITIVE")=0 D
 .S:+$G(@ORTEXT)>0 @ORTEXT=@ORTEXT+1,@ORTEXT@(@ORTEXT)=""
 .S @ORTEXT=$G(@ORTEXT)+1,@ORTEXT@(@ORTEXT)="Unable to find the OR GTX ADDITIVE dialog in the ORDER DIALOG file (#101.41)."
 .S @ORTEXT=@ORTEXT+1,@ORTEXT@(@ORTEXT)="Please log a Remedy ticket for assistance."
 I ORGO D
 .S @ORTEXT@(1)="The following orderable items resolve to a supply dispense item.",@ORTEXT@(2)=""
 .S @ORTEXT@(3)="ORDERABLE ITEM",@ORTEXT@(4)=$$REPEAT^XLFSTR("-",72),@ORTEXT=4
 .;CREATE ORDERABLE ITEM INDEX OF QUICK ORDERS
 .S ORQORDER=$NA(^TMP($J,"ORQORDER")) K @ORQORDER
 .S ORQIEN=0 F  S ORQIEN=$O(^ORD(101.41,ORQIEN)) Q:'+$G(ORQIEN)  D
 ..Q:$P($G(^ORD(101.41,ORQIEN,0)),U,4)'="Q"
 ..S ORDLGIDX="" F  S ORDLGIDX=$O(ORDLG(ORDLGIDX)) Q:$G(ORDLGIDX)=""  D
 ...S ORDLGIEN=0 F  S ORDLGIEN=$O(^ORD(101.41,ORQIEN,6,"D",ORDLG(ORDLGIDX),ORDLGIEN)) Q:'+ORDLGIEN  D
 ....S ORITMIEN=$G(^ORD(101.41,ORQIEN,6,ORDLGIEN,1))
 ....Q:+ORITMIEN'=ORITMIEN
 ....S @ORQORDER@(ORITMIEN,$P(^ORD(101.41,ORQIEN,0),U,1))=ORQIEN
 .S ORCHNKBR=$$REPEAT^XLFSTR("*",30)
 .S ORIEN=0 F  S ORIEN=$O(^ORD(101.43,ORIEN)) Q:+$G(ORIEN)=0!($G(ZTSTOP))  D
 ..I ORIEN#1000=0 D  Q:$G(ZTSTOP)
 ...I $$S^%ZTLOAD D
 ....N X
 ....S ZTSTOP=1,X=$$S^%ZTLOAD("Received shutdown request")
 ..S ORDATE=$P($G(^ORD(101.43,ORIEN,.1)),U,1),OREXIT=0
 ..I ORDATE'="",(+ORDATE<DT) S OREXIT=1
 ..Q:+$G(OREXIT)=1
 ..S ORPHOI=$P($G(^ORD(101.43,ORIEN,0)),U,2)
 ..Q:$P(ORPHOI,";",2)'="99PSP"
 ..S ORCHK=0
 ..D DRGIEN^PSS50P7(+ORPHOI,,"ORSUPPLY")
 ..Q:+^TMP($J,"ORSUPPLY",0)<1
 ..S (ORITMHDR,ORDDHDR,ORISSUP)=0
 ..S ORDRGIEN=0 F  S ORDRGIEN=$O(^TMP($J,"ORSUPPLY",ORDRGIEN)) Q:'+$G(ORDRGIEN)  D
 ...D ZERO^PSS50(ORDRGIEN,,,,,"ORDRUG")
 ...Q:+^TMP($J,"ORDRUG",0)<1
 ...I $$ISSUPPLY(ORDRGIEN) D
 ....I 'ORITMHDR D WRAP^ORUTL($P(^ORD(101.43,ORIEN,0),U,1),ORTEXT) S ORITMHDR=1
 ....I 'ORDDHDR D WRAP^ORUTL("DISPENSE ITEM(S): "_^TMP($J,"ORDRUG",ORDRGIEN,.01),ORTEXT) I 1 S ORDDHDR=1
 ....E  D WRAP^ORUTL($$REPEAT^XLFSTR(" ",18)_^TMP($J,"ORDRUG",ORDRGIEN,.01),ORTEXT)
 ....S ORISSUP=1
 ..I ORISSUP D
 ...D QUICK(ORIEN,ORTEXT)
 ...D REMIND(ORIEN,ORTEXT,"101.43^ORD(101.43,")
 ...S @ORTEXT=@ORTEXT+1,@ORTEXT@(@ORTEXT)=ORCHNKBR
 .I +$G(ZTSTOP)=0 D
 ..S @ORTEXT=@ORTEXT+1,@ORTEXT@(@ORTEXT)=$$REPEAT^XLFSTR(" ",32)_"[END OF REPORT]"
 .E  D
 ..S @ORTEXT=@ORTEXT+1,@ORTEXT@(@ORTEXT)=""
 ..S @ORTEXT=@ORTEXT+1,@ORTEXT@(@ORTEXT)="The quick order dialog report process has unexpectedly stopped."
 ..S @ORTEXT=@ORTEXT+1,@ORTEXT@(@ORTEXT)="If you or the system manager did not stop the process, please check the"
 ..S @ORTEXT=@ORTEXT+1,@ORTEXT@(@ORTEXT)="error log and file a Remedy ticket for assistance."
 ..S @ORTEXT=@ORTEXT+1,@ORTEXT@(@ORTEXT)=""
 I 'ORGO!($G(ZTSTOP)) D
 .S @ORTEXT=@ORTEXT+1,@ORTEXT@(@ORTEXT)="To rerun the report, execute SODLGCON^ORY389 from the programmer prompt."
 K ^TMP($J,"FDATA"),^TMP($J,"DLG FIND")
 S ORSTAT=$$MAIL^ORUTL($P(ORTEXT,")",1)_",","SUPPLY ORDERABLE ITEM REPORT",,"ORY389SOIRECIPS")
 K @ORTEXT,@ORQORDER
 I $D(ZTQUEUED) S ZTREQ="@"
 E  W !,"Report successfully generated.",!
 Q
ISSUPPLY(ORDRGIEN) ;DETERMINE IF DRUG IS A SUPPLY ITEM
 ;PARAMETERS: ORDRGIEN=>DRUG IEN IN ^TMP($J,"ORDRUG") GLOBAL
 Q:"^XA^XX^"[(U_$E(^TMP($J,"ORDRUG",ORDRGIEN,2),1,2)_U)!(^TMP($J,"ORDRUG",ORDRGIEN,2)="DX900"&($G(^TMP($J,"ORDRUG",ORDRGIEN,3))["S")) 1
 Q 0
QUICK(ORIEN,ORTEXT) ;FIND QUICK ORDERS THAT REFERENCE THE ORDERABLE ITEM
 ;PARAMETERS: ORIEN =>ORDERABLE ITEM IEN
 ;            ORTEXT=>NAME OF ARRAY TO STORE OUTPUT TEXT IN
 N ORQO,ORHEADER
 S ORHEADER=0
 S ORQO="" F  S ORQO=$O(@ORQORDER@(ORIEN,ORQO)) Q:$G(ORQO)=""  D
 .I 'ORHEADER D WRAP^ORUTL("QUICK ORDERS: "_ORQO,ORTEXT) I 1 S ORHEADER=1
 .E  D WRAP^ORUTL($$REPEAT^XLFSTR(" ",14)_ORQO,ORTEXT)
 .D REMIND(@ORQORDER@(ORIEN,ORQO),ORTEXT,"101.41^ORD(101.41,",18)
 .D MENU(@ORQORDER@(ORIEN,ORQO),ORTEXT,18)
 Q
REMIND(ORITMIEN,ORTEXT,ORFILE,ORINDENT) ;FIND CLINICAL REMINDERS THAT REFERENCE THE ORDERABLE ITEM/QUICK ORDER DIALOG
 ;PARAMETERS: ORITMIEN=>ORDERABLE ITEM/QUICK ORDER DIALOG IEN
 ;            ORTEXT  =>NAME OF ARRAY TO STORE OUTPUT TEXT IN
 ;            ORFILE  =>DELIMITED STRING WITH FILE_NUMBER^FILE_GLOBAL_ROOT
 ;            ORINDENT=>NUMBER OF SPACES TO INDENT TEXT; DEFAULT IS 0
 K ^TMP($J,"FDATA")
 D BLDLIST^PXRMFRPT(+ORFILE,$P(ORFILE,U,2),ORITMIEN,"FDATA")
 D MSG(ORTEXT,$G(ORINDENT,0))
 Q
MSG(TEXTOUT,ORINDENT) ;PROCESS DATA FROM BLDLIST^PXRMFRPT
 ;PARAMETERS: TEXTOUT =>TEXT TO OUTPUT TO THE SCREEN
 ;            ORINDENT=>NUMBER OF SPACES TO INDENT TEXT; DEFAULT IS 0
 N DTYP,FILENUM,IND,NAME,NL,NOUT,RNUM,FI,FIEN,IEN,TEXT,TYPE,SUBHEAD
 N OUTPUT
 S ORINDENT=$$REPEAT^XLFSTR(" ",$G(ORINDENT,0))
 S FILENUM=0
 F  S FILENUM=$O(^TMP($J,"FDATA",FILENUM)) Q:FILENUM=""  D
 .S FIEN=0
 .F  S FIEN=$O(^TMP($J,"FDATA",FILENUM,FIEN)) Q:FIEN=""  D
 ..F TYPE="DEF","TERM","DIALOG","ROC" D
 ...I '$D(^TMP($J,"FDATA",FILENUM,FIEN,TYPE)) Q
 ...S RNUM=$S(TYPE="DEF":811.9,TYPE="TERM":811.5,TYPE="DIALOG":801.41,TYPE="ROC":801)
 ...S OUTPUT=ORINDENT_"REMINDER "_$S(TYPE="DEF":"DEFINITIONS:",TYPE="TERM":"TERMS:",TYPE="DIALOG":"DIALOGS:",TYPE="ROC":"ORDER CHECKS:",1:"")
 ...S IEN=0
 ...F  S IEN=$O(^TMP($J,"FDATA",FILENUM,FIEN,TYPE,IEN)) Q:IEN=""  D
 ....S NAME=$$GET1^DIQ(RNUM,IEN,.01)
 ....I TYPE="DIALOG" D
 .....S DTYP=$P(^PXRMD(801.41,IEN,0),U,4)
 .....S OUTPUT=$G(OUTPUT,ORINDENT)_" Dialog "_$S(DTYP="E":"element",DTYP="G":"group",DTYP="S":"result group",1:"item")
 .....S OUTPUT=OUTPUT_" "_NAME_$S($P(^PXRMD(801.41,IEN,0),U,3)=1:" (Disable)",1:"")_" (IEN="_IEN_")"
 .....S OUTPUT=OUTPUT_", used in the "
 .....N ORITMS
 .....S FI=0 F  S FI=$O(^TMP($J,"FDATA",FILENUM,FIEN,TYPE,IEN,FI)) Q:FI=""  S ORITMS=$S($G(ORITMS)'="":ORITMS_", ",1:"")_$S(FI=15:"Finding Item field",FI=17:"Orderable Item field",FI=18:"Additional Finding field",FI=119:"MH Test field",1:"")
 .....D WRAP^ORUTL(OUTPUT_$G(ORITMS),TEXTOUT)
 ....I TYPE'="DIALOG" D
 .....S OUTPUT=$G(OUTPUT,ORINDENT)_" "_NAME_" (IEN="_IEN_", "
 .....S (FI,SUBHEAD)=0
 .....F  S FI=$O(^TMP($J,"FDATA",FILENUM,FIEN,TYPE,IEN,FI)) Q:FI=""  D
 ......I 'SUBHEAD D
 .......S OUTPUT=OUTPUT_$S(TYPE="ROC":"Rule Name ",1:"Finding number ")_FI_", "
 .......S SUBHEAD=1
 ......E  S OUTPUT=OUTPUT_FI_", "
 .....D WRAP^ORUTL($E(OUTPUT,1,*-2)_")",TEXTOUT)
 Q
MENU(ORQIEN,ORTEXT,ORINDENT) ;FIND ORDER MENUS THAT REFERENCE THE ORDERABLE ITEM
 ;PARAMETERS: ORQIEN=>QUICK ORDER DIALOG IEN
 ;            ORTEXT=>NAME OF ARRAY TO STORE OUTPUT TEXT IN
 ;            ORINDENT=>NUMBER OF SPACES TO INDENT TEXT; DEFAULT IS 0
 N ORIDX,HEADER,OUTPUT
 S ORINDENT=$G(ORINDENT,0)
 S (ORIDX,HEADER)=0 F  S ORIDX=$O(^ORD(101.41,"AD",ORQIEN,ORIDX)) Q:+ORIDX=0  D
 .I 'HEADER S OUTPUT=$$REPEAT^XLFSTR(" ",ORINDENT)_"ORDER MENUS: ",HEADER=1
 .E  S OUTPUT=$$REPEAT^XLFSTR(" ",ORINDENT+13)
 .D WRAP^ORUTL($G(OUTPUT)_$P($G(^ORD(101.41,ORIDX,0)),U,1),ORTEXT)
 Q
UPDDGMAP ;Update the Pharmacy Display Group child mappings
 ;find the IENs of the PHARMACY, CLINIC MEDICATIONS and CLINIC INFUSIONS display groups
 N ORPHDG,ORCMDG,ORCIDG,ORZZ,ORFND,ORI,ORCSUP
 S ORPHDG=$O(^ORD(100.98,"B","PHARMACY",0))
 S ORCMDG=$O(^ORD(100.98,"B","CLINIC MEDICATIONS",0))
 S ORCIDG=$O(^ORD(100.98,"B","CLINIC INFUSIONS",0))
 S ORCSUP=$O(^ORD(100.98,"B","SUPPLIES/DEVICES",0))
 S ORFND=0,ORI=0 F  S ORI=$O(^ORD(100.98,2,1,ORI)) Q:'ORI  D
 .I $G(^ORD(100.98,2,1,ORI,0))=ORCMDG S ORFND=1
 I 'ORFND S ORZZ(1,100.981,"+2,"_ORPHDG_",",.01)=ORCMDG
 S ORFND=0,ORI=0 F  S ORI=$O(^ORD(100.98,2,1,ORI)) Q:'ORI  D
 .I $G(^ORD(100.98,2,1,ORI,0))=ORCIDG S ORFND=1
 I 'ORFND S ORZZ(1,100.981,"+3,"_ORPHDG_",",.01)=ORCIDG
 S ORFND=0,ORI=0 F  S ORI=$O(^ORD(100.98,2,1,ORI)) Q:'ORI  D
 .I $G(^ORD(100.98,2,1,ORI,0))=ORCSUP S ORFND=1
 I 'ORFND S ORZZ(1,100.981,"+4,"_ORPHDG_",",.01)=ORCSUP
 D UPDATE^DIE("","ORZZ(1)")
 Q
 ;
SENDDSPG(ANAME) ; Return true if the current display group should be sent
 I ANAME="CLINIC ORDERS" Q 1
 I ANAME="CLINIC INFUSIONS" Q 1
 I ANAME="CLINIC MEDICATIONS" Q 1
 I ANAME="SUPPLIES/DEVICES" Q 1
 Q 0
 ;
SENDDLG(ANAME) ; Return true if the current order dialog should be sent
 I ANAME="PSJ OR CLINIC OE" Q 1
 I ANAME="CLINIC OR PAT FLUID OE" Q 1
 I ANAME="PSO SUPPLY" Q 1
 Q 0
 ;
DLGBULL ; send bulletin about modified dialogs <on first install>
 N I,ORD
 F I="PSJ OR CLINIC OE","CLINIC OR PAT FLUID OE","PSO SUPPLY" S ORD(I)=""
 D EN^ORYDLG(389,.ORD)
 Q
 ;
PARVAL ;add Clin. Inf, Clin Meds display group to SEQUENCE parameter
 N X
 D DEL^XPAR("PKG","ORWOR CATEGORY SEQUENCE",69)
 I $D(^ORD(100.98,"B","CLINIC MEDICATIONS")) D
 . S X=0,X=$O(^ORD(100.98,"B","CLINIC MEDICATIONS",X)) Q:'X  D
 . . D PUT^XPAR("PKG","ORWOR CATEGORY SEQUENCE",69,X)
 D DEL^XPAR("PKG","ORWOR CATEGORY SEQUENCE",59)
 I $D(^ORD(100.98,"B","CLINIC INFUSIONS")) D
 . S X=0,X=$O(^ORD(100.98,"B","CLINIC INFUSIONS",X)) Q:'X  D
 . . D PUT^XPAR("PKG","ORWOR CATEGORY SEQUENCE",59,X)
 D DEL^XPAR("PKG","ORWOR CATEGORY SEQUENCE",130)
 I $D(^ORD(100.98,"B","SUPPLIES/DEVICES")) D
 . S X=0,X=$O(^ORD(100.98,"B","SUPPLIES/DEVICES",X)) Q:'X  D
 . . D PUT^XPAR("PKG","ORWOR CATEGORY SEQUENCE",130,X)
 Q
 ;