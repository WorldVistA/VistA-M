PXRMDTAX ; SLC/AGP - Reminder Dialog Taxonomy Field editor/List Manager ;03/14/2014
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;
 ;ADDTAXF1(FIELD,CODE,ARRAY) ;
ADDTAXF1(CODE,ARRAY) ;
 N CURVALUE,PROMPT,RESULT,SARRAY,TEMP,TYPE,X,Y
 S CURVALUE=$$GETTEXT^PXRMDTAX(.ARRAY,CODE)
 ;I CURVALUE="" S CURVALUE="Selectable "_$S(FIELD=2:"current ",FIELD=3:"historical ",1:"")_$S($E(TEMP)="d":TEMP_"es",1:TEMP_"s")_" codes"
 Q CURVALUE
 ;
 ;central location for building array of codes when determine what codes go with an
 ;encounter type
BLDCODE(TYPE,CODESYS) ;
 I TYPE="ALL" S (CODESYS("ICD"),CODESYS("10D"),CODESYS("CPT"),CODESYS("CPC"))="" Q
 I TYPE="POV" S (CODESYS("ICD"),CODESYS("10D"))="" Q
 I TYPE="CPT" S (CODESYS("CPT"),CODESYS("CPC"))="" Q
 Q
 ;
 ;build FDA array for Taxonomy Fields multiple
BLDFDA(CODE,IEN,FDA,DEFAULT) ;
 N DA,ENCTYPE,FIELD,IENS,NODEIEN,RESULT,TEMP,VALUE,X
 S X=$S(CODE="POV":141,1:142)
 S VALUE=$$TAXDIR(X,CODE,IEN,.DEFAULT) I VALUE[U Q VALUE
 S FDA(801.41,IEN_",",X)=VALUE
 Q VALUE
 ;
CHECKER(DIEN,TIEN,FIELD,OUTPUT) ;
 N CNT,FAIL,NAME,NODE,RESULT,TAXSEL,TDX,TDXNODE,TNAME,TPR,TPRNODE,TYPE
 S FAIL=""
 S NODE=$G(^PXRMD(801.41,DIEN,0)),NAME=$P(NODE,U),TYPE=$S($P(NODE,U,4)="G":"Group",1:"Element")
 S TNAME=$P($G(^PXD(811.2,TIEN,0)),U)
 I $P($G(^PXD(811.2,TIEN,0)),U,6)=1 S OUTPUT(1)="Dialog "_TYPE_" "_NAME_" contains an inactive taxonomy "_TNAME_".",FAIL="W" Q FAIL
 I '$D(^PXD(811.2,TIEN,20,"AUID")) S OUTPUT(1)="Dialog "_TYPE_" "_NAME_" contains a taxonomy "_TNAME_" that does not have codes marked to be used in a dialog.",FAIL=$S(FIELD="F":"F",1:"W") I FIELD'="" Q FAIL
 ;
 S TAXSEL=$P($G(^PXRMD(801.41,DIEN,"TAX")),U)
 S TDX=$$TOK(TIEN,"POV"),TPR=$$TOK(TIEN,"CPT")
 ;I TYPE="Group",TDX,TPR,TAXSEL'["N" S OUTPUT(1)="Dialog "_TYPE_" "_NAME_" cannot have a taxonomy selection field value other than 'No Pick List'.",FAIL="F" Q FAIL
 ;.I TAXSEL'["N" S OUTPUT(1)="Dialog "_TYPE_" "_NAME_" cannot have a taxonomy selection field value other than 'No Pick List'.",FAIL="F"
 I TAXSEL="N" Q FAIL
 S TDXNODE=$S($P($G(^PXRMD(801.41,DIEN,"POV")),U)'="":1,1:0),TPRNODE=$S($P($G(^PXRMD(801.41,DIEN,"CPT")),U)'="":1,1:0)
 S CNT=0
 I TAXSEL="A",TDX,TPR D  Q FAIL
 .S RESULT=$$CHCKCOMP(TDXNODE,TDX,"POV",NAME) I RESULT'="" S FAIL="W",CNT=CNT+1,OUTPUT(CNT)=RESULT
 .S RESULT=$$CHCKCOMP(TPRNODE,TPR,"CPT",NAME) I RESULT'="" S FAIL="W",CNT=CNT+1,OUTPUT(CNT)=RESULT
 I TAXSEL="D" S RESULT=$$CHCKCOMP(TDXNODE,TDX,"POV",NAME) I RESULT'="" S FAIL="W",CNT=CNT+1,OUTPUT(CNT)=RESULT
 I TAXSEL="P" S RESULT=$$CHCKCOMP(TPRNODE,TPR,"CPT",NAME) I RESULT'="" S FAIL="W",CNT=CNT+1,OUTPUT(CNT)=RESULT
 I $$HASACT(TIEN)=0 S FAIL="W",CNT=CNT+1,OUTPUT(CNT)="Taxonomy "_TNAME_" does not contain active codes for "_$$FMTE^XLFDT(DT)
 Q FAIL
 ;
CHCKCOMP(DNODE,TNODE,TYPE,NAME) ;
 N NODE S NODE=$S(TYPE="POV":"diagnosis",1:"procedure")
 I DNODE=1,TNODE=0 Q "Dialog element "_NAME_" "_NODE_" Header Text is defined, but the taxonomy does not have "_NODE_" codes marked to be used in a dialog."
 I DNODE=0,TNODE=1 Q "Dialog element "_NAME_" "_NODE_" Header Text is not defined, but the taxonomy does have "_NODE_" codes marked to be used in a dialog."
 Q ""
 ;
 ;write out code display used by List Manager
CODES(TIEN,CODES,NLINE,HIST,ISMAIL) ;
 N BDATE,CODE,DATE,DATES,DESC,DTEXT,EDATE,NLINES,STR,SUB
 N TAB,TEXT,TEXTIN,TEXTOUT,X
 ;
 S SUB=""
 F  S SUB=$O(CODES(SUB)) Q:SUB=""  D
 .S CODE=$P(CODES(SUB),U,2),DESC=$P(CODES(SUB),U,3)
 .S BDATE=$$FMTE^XLFDT($P($G(CODE),":",2))
 .S EDATE=$S($P($G(CODE),":",3)'="":$$FMTE^XLFDT($P($G(CODE),":",3)),1:"")
 .S DATE=BDATE_"-"_EDATE
 .S STR=$$LJ^XLFSTR($P($G(CODE),":"),8)
 .S STR=STR_DESC
 .S TEXTIN(1)=STR
 .D FORMAT^PXRMTEXT(1,$S(ISMAIL:35,1:44),1,.TEXTIN,.NLINES,.TEXTOUT)
 .F X=1:1:NLINES D
 ..S DTEXT=$S(X=1:$$LJ^XLFSTR(TEXTOUT(X),$S(ISMAIL=1:38,1:45))_DATE,1:TEXTOUT(X))
 ..S NLINE=NLINE+1
 ..S ^TMP(NODE,$J,NLINE,0)=$J("",15)_DTEXT
 Q
 ;
 ;general field delete sub-routine
DELFIELD(IENS,SUB,FIELD) ;Delete a field.
 N FDA,MSG
 S FDA(SUB,IENS,FIELD)="@"
 D FILE^DIE("","FDA","MSG")
 I $D(MSG) W !,"Error in delete",! D AWRITE^PXRMUTIL("MSG")
 Q
 ;
 ;Cross-reference delete when deleting Taxonomy fields in a dialog
DELLOG(DA,FIELD,OLD,NEW) ;
 I OLD="" Q
 N IENS,POVIEN,PROCIEN
 I FIELD=123 D  Q
 .I NEW=""!(NEW="N") D  Q
 ..S IENS=DA_"," D DELFIELD(IENS,801.41,141)
 ..S IENS=DA_"," D DELFIELD(IENS,801.41,142)
 .I NEW="D" S IENS=DA_"," D DELFIELD(IENS,801.41,142) Q
 .I NEW="P" S IENS=DA_"," D DELFIELD(IENS,801.41,141)
 Q
 ;
GETSTAT(TYPE) ;
 N HIST,RESULT,STATUS
 S RESULT=0
 S IEN=$O(^PXRMD(801.45,"B",TYPE,"")) I IEN'>0 Q RESULT
 I '$D(^PXRMD(801.45,IEN,1,"B",2)) S RESULT=1 Q RESULT
 S HIST=$O(^PXRMD(801.45,IEN,1,"B",2,"")) I HIST'>0 S RESULT=1 Q RESULT
 I $P($G(^PXRMD(801.45,IEN,1,HIST,0)),U,2)=1 S RESULT=1 Q RESULT
 S RESULT=2
 S STATUS=0 F  S STATUS=$O(^PXRMD(801.45,IEN,1,"B",STATUS)) Q:STATUS'>0!(RESULT<2)  I STATUS'=2 S RESULT=0
 Q RESULT
 ;
 ;this returns the default values from file 801.45 for POV or Procedure
 ;codes.
 ;DEFAULT(TYPE,pointer to file 801.9)=default
 ;DEFAULT(TYPE,pointer to file 801.9,ADDFIND,n)=additional finding node
GETTAXDF(DEFAULT,TYPE,ISHIST) ;
 N CNT,IEN,FIND,STATUS
 S IEN=$O(^PXRMD(801.45,"B",TYPE,"")) I IEN'>0 Q
 ;get resolution status
 S CNT=0 F  S CNT=$O(^PXRMD(801.45,IEN,1,CNT)) Q:CNT'>0  D
 .S STATUS=$P($G(^PXRMD(801.45,IEN,1,CNT,0)),U)
 .I ISHIST=1,STATUS'=2 Q
 .I ISHIST=0,STATUS=2 Q
 .;get prefix and suffix text
 .S DEFAULT(TYPE,"PREFIX")=$G(^PXRMD(801.45,IEN,1,CNT,3))
 .S DEFAULT(TYPE,"SUFFIX")=$G(^PXRMD(801.45,IEN,1,CNT,4))
 .;get additional findings
 .S FIND=0 F  S FIND=$O(^PXRMD(801.45,IEN,1,CNT,5,FIND)) Q:FIND'>0  D
 ..S DEFAULT(TYPE,"ADDFIND",FIND)=$G(^PXRMD(801.45,IEN,1,CNT,5,FIND,0))
 Q
 ;
 ;Returns the default taxonomy checkbox header for the Encounter Type
GETTEXT(VALUES,TYPE) ;
 ;GETTEXT(VALUES,TYPE,CURR) ;
 N ENCTYPE,IEN,TEXT
 S TEXT=""
 S TEXT=$G(VALUES(TYPE,"PREFIX"))_$G(VALUES(TYPE,"SUFFIX"))
 Q TEXT
 ;
HASACT(TIEN) ;
 N SYS,CODE,SDATE,EDATE,START,TODAY,FOUND,END
 S TODAY=DT+1,FOUND=0
 S SYS="" F  S SYS=$O(^PXD(811.2,TIEN,20,"AUID",SYS)) Q:SYS=""!(FOUND=1)  D
 .S CODE="" F  S CODE=$O(^PXD(811.2,TIEN,20,"AUID",SYS,CODE)) Q:CODE=""!(FOUND=1)  D
 ..S SDATE=""
 ..F  S SDATE=$O(^PXD(811.2,TIEN,20,"AUID",SYS,CODE,SDATE)) Q:SDATE=""!(FOUND=1)  D
 ...S START=SDATE-1,EDATE=""
 ...F  S EDATE=$O(^PXD(811.2,TIEN,20,"AUID",SYS,CODE,SDATE,EDATE)) Q:EDATE=""!(FOUND=1)  D
 ....S END=$S(EDATE="DT":DT+1,1:EDATE+1) I DT>START,DT<END S FOUND=1 Q
 Q FOUND
 ;
PRINT(TEXTIN,NIN) ;
 N LINE,NOUT,TEXTOUT
 D FORMAT^PXRMTEXT(1,75,NIN,.TEXTIN,.NOUT,.TEXTOUT)
 D MES^XPDUTL(.TEXTOUT)
 Q
 ;
 ;Builds a list of prompts associated with the taxonomy finding types
 ;Prompts the user to add the prompts to the dialog editor. Does not prompt if prompts
 ;are already defined to the element.
PROMPTS(DA,SEL,DEFAULT,FDA,IENCNT) ;
 N CNT,CODE,DIR,DNUM,ENC,EXTVAL,FIELD,IEN,IENS,NAME,NODE,NUM,PROMPT,PROMPTS,START,VALUE,X,Y
 I $D(^PXRMD(801.41,DA,10)) Q 0
 S CODE="" F  S CODE=$O(DEFAULT(CODE)) Q:CODE=""  D
 .I SEL="P",CODE="POV" Q
 .I SEL="D",CODE="CPT" Q
 .S CNT=0 F  S CNT=$O(DEFAULT(CODE,"ADDFIND",CNT)) Q:CNT'>0  D
 ..S NODE=DEFAULT(CODE,"ADDFIND",CNT)
 ..S IEN=$P(NODE,U)
 ..I $D(^PXRMD(801.41,DA,10,"D",IEN))>0 Q
 ..I $D(PROMPTS(IEN))>0 I $L(PROMPTS(IEN),U)<$L(NODE,U) S PROMPTS(IEN)=NODE
 ..S PROMPTS(IEN)=NODE
 ;
 I '$D(PROMPTS) Q 0
 S START=+$O(^PXRMD(801.41,DA,10,""),-1)
 S DNUM=0
 W !,"Default prompts for the taxonomy:"
 S IEN=0,CNT=0 F  S IEN=$O(PROMPTS(IEN)) Q:IEN'>0  D
 .S CNT=CNT+1,START=START+1,DNUM=DNUM+1
 .S IENCNT=IENCNT+1,IENS="+"_IENCNT_","_DA_","
 .S NAME=$P($G(^PXRMD(801.41,IEN,0)),U)
 .S NODE=PROMPTS(IEN),CNT=$L(NODE,U)
 .I $P(NODE,U,3)>0 Q
 .S FDA(801.412,IENS,.01)=START
 .S FDA(801.412,IENS,2)=IEN
 .W !,"Prompt: "_NAME
 .I CNT=1 Q
 .F NUM=2:1:CNT D
 ..I NUM=3 Q
 ..I NUM=4 Q
 ..S VALUE=$P(NODE,U,NUM) I $G(VALUE)="" Q
 ..S FIELD=$S(NUM=2:9,NUM=4:.01,NUM=5:6,NUM=6:7,NUM=7:8,1:"") I $G(FIELD)="" Q
 ..S FDA(801.412,IENS,FIELD)=VALUE
 ..S PROMPT=$S(FIELD=.01:"Sequence",FIELD=6:"Override Prompt Caption",FIELD=7:"Start New Line",FIELD=8:"Exclude From PN Text",FIELD=9:"Required")
 ..I $G(PROMPT)="" Q
 ..I FIELD=6 S EXTVAL=VALUE
 ..I FIELD>6 S EXTVAL=$S(VALUE=1:"Yes",1:"No")
 ..W !,"   "_PROMPT_": "_EXTVAL
 ;
 I CNT=0 W !,"None" Q 0
 S DIR(0)="S^Y:Yes;N:No"
 S DIR("A")="Add Prompts to the dialog"
 S DIR("B")="Yes"
 D ^DIR
 I Y[U K FDA(801.412) Q 0
 I Y="N" K FDA(801.412)
 Q 1
 ;
 ;Prompts the user for values for the fields in the Taxonomy Fields multiple.
 ;Builds default values from existing values or from file 801.45
TAXDIR(FIELD,CODE,DA,ARRAY) ;
 N DIR,CURVALUE,PROMPT,RESULT,SARRAY,TEMP,TYPE,X,Y
 S CURVALUE=""
 S DIR("A")=$S(CODE="POV":"Diagnosis Header",1:"Procedure Header")
 S DIR(0)="F^1:80"
 S TEMP=$S(CODE="POV":"diagnosis",1:"Procedure")
 I +DA>0 S CURVALUE=$$GET1^DIQ(801.41,DA_",",FIELD)
 I CURVALUE="" D
 .S CURVALUE=$$GETTEXT(.ARRAY,CODE)
 .I CURVALUE="" S CURVALUE="Selectable "_$S($E(TEMP)="d":TEMP_"es",1:TEMP_"s")_" codes"
 S DIR("B")=CURVALUE
 D ^DIR
 Q Y
 ;
 ;main taxonomy fields editor entry point. Returns ^ or ^^ or 1 is fields are answer.
TAXDIAL(IEN,FIND) ;
  ;Protect FileMan variables
 N D,D0,DA,DC,DDES,DE,DG,DH,DI,DIC,DIDEL,DIE,DIEDA,DIEL,DIEN,DIR,DIETMP
 N DIEXREF,DIFLD,DIEIENS,DINUSE,DIP,DISYS,DK,DL,DM,DP,DQ,DR,DU
 ;
 N DEF,DEFAULT,DXTYPE,FDA,FDAIEN,HTEXT,IENCNT,IENS,ISHIST,MSG,NODEIEN,NAME,NONE,PRTYPE,RESULT,STR,TAXIEN,TAXSEL,TDX,TPR,VALUE,X,Y
 ;
ENTAXDL ;
 ;
 S RESULT=1
 I FIND'["PXD(811.2" Q 0
 S DA=IEN,TAXIEN=+FIND I TAXIEN'>0 Q 0
 S ISHIST=$S($P($G(^PXRMD(801.41,IEN,1)),U,3)=2:1,1:0)
 S TDX=$$TOK(TAXIEN,"POV")
 S TPR=$$TOK(TAXIEN,"CPT")
 S DEF=$P($G(^PXRMD(801.41,DA,"TAX")),U)
 S DIR(0)="S^A:All;N:No Pick List" D HELP(.HTEXT,"")
 I TDX=1,TPR=1 S DIR(0)="S^A:All;D:ICD Diagnoses Only;P:CPT Procedures Only;N:No Pick List" D HELP(.HTEXT,"PD")
 I $P($G(^PXRMD(801.41,IEN,0)),U,4)="G" D
 .I $G(DEF)="" S DEF="N"
 .I TDX=1,TPR=1 S DIR(0)="S^D:ICD Diagnoses Only;P:CPT Procedures Only;N:No Pick List" D HELP(.HTEXT,"GPD") Q
 .I TPR=1 S DIR(0)="S^P:CPT Procedures Only;N:No Pick List" D HELP(.HTEXT,"GP") Q
 .S DIR(0)="S^D:ICD Diagnoses Only;N:No Pick List" D HELP(.HTEXT,"GD")
 I DIR(0)'[DEF S DEF=""
 S DIR("A")="Taxonomy Pick List"
 S DIR("B")=$S(DEF]"":DEF,1:"A")
 S DIR("?")="Select the pick list display value or '^' to quit. Enter ?? for detail help."
 S DIR("??")=U_"D HELP^PXRMEUT(.HTEXT)"
 D ^DIR
 I Y[U Q Y
 S VALUE=Y
 S FDA(801.41,DA_",",123)=VALUE
 I VALUE="N" G TAXUPD
 I TDX=1 D GETTAXDF(.DEFAULT,"POV",ISHIST)
 I TPR=1 D GETTAXDF(.DEFAULT,"CPT",ISHIST)
 S IENCNT=0
 I TDX=1,TPR=1,VALUE="A" D  G TAXDIALX:RESULT="^^" G ENTAXDL:RESULT=U
 .S RESULT=$$BLDFDA("POV",IEN,.FDA,.DEFAULT) I RESULT[U Q
 .S RESULT=$$BLDFDA("CPT",IEN,.FDA,.DEFAULT)
 ;I TPR=1,VALUE="A" S RESULT=$$BLDFDA("CPT",IEN,.FDA,.DEFAULT) G TAXDIALX:RESULT="^^" G ENTAXDL:RESULT=U
 ;
 S RESULT=$$PROMPTS(IEN,VALUE,.DEFAULT,.FDA,.IENCNT) I RESULT[U G TAXDIALX:RESULT="^^" G ENTAXDL:RESULT=U
 K MSG
TAXUPD ;
 D UPDATE^DIE("","FDA","","MSG")
 I $D(MSG) W !,"Error in update",! D AWRITE^PXRMUTIL("MSG")
 ;
TAXDIALX ; 
 Q RESULT
 ;
 ;This routine is used to display Taxonomy codes in the List Manager view for Dialog Text.
 ;TODO should we display any codes in Dialog Text view for Additional Findings or Taxonomy Pick List of N, D, P?
TAXDISP(FIEN,SEQ,DIEN,NLINE,NODE,ADDFIND,ISMAIL) ;
 N ARRAY,CNT,CODESYS,FILE,HIST,TIEN,TSEQ
 N CNT,DTXT,FNODE,RSUB,TDX,TNAME,TPAR,TPR,TYP
 N TCUR,TDTXT,TDHTXT,THIS,TPTXT,TPHTXT
 S TIEN=$P(FIEN,";") Q:TIEN=""
 S HIST=0,FILE=""
 ;Get associated codes
 ;
 ;Get taxonomy name
 S TNAME=$P($G(^PXD(811.2,TIEN,0)),U,1)
 ;
 ;Check what type of taxonomy codes exist
 S TDX=$$TOK(TIEN,"POV")
 S TPR=$$TOK(TIEN,"CPT")
 ;
 S TAXSEL=$P($G(^PXRMD(801.41,DIEN,"TAX")),U)
 I ADDFIND=1 S TAXSEL="N"
 ;
 I TDX D
 .D BLDCODE("POV",.CODESYS)
 .D CODES^PXRMDLLB(TIEN,.CODESYS,.CODES)
 .I '$D(CODES) Q
 .S TEXT=$J("",15)_$S(TAXSEL="N":"Diagnoses Codes:",TAXSEL="P":"Procedures Codes:",1:"Selectable Diagnoses Codes:"),TAB=18
 .S STR=$$LJ^XLFSTR($G(TEXT),$S(ISMAIL=1:51,1:60))
 .S STR=STR_"Activation Periods"
 .S NLINE=NLINE+1
 .S ^TMP(NODE,$J,NLINE,0)=STR
 .D CODES(TIEN,.CODES,.NLINE,HIST,ISMAIL)
 .S NLINE=NLINE+1
 .S ^TMP(NODE,$J,NLINE,0)=$J("",79)
 ;
 I TPR D
 .K CODESYS,CODES
 .D BLDCODE("CPT",.CODESYS)
 .D CODES^PXRMDLLB(TIEN,.CODESYS,.CODES)
 .I '$D(CODES) Q
 .S TEXT=$J("",15)_$S(TAXSEL="N":"Procedures Codes:",TAXSEL="D":"Procedures Codes:",1:"Selectable Procedures codes:"),TAB=18
 .S STR=$$LJ^XLFSTR($G(TEXT),$S(ISMAIL=1:51,1:60))
 .S STR=STR_"Activation Periods"
 .S NLINE=NLINE+1
 .S ^TMP(NODE,$J,NLINE,0)=STR
 .D CODES(TIEN,.CODES,.NLINE,HIST,ISMAIL)
 .S NLINE=NLINE+1
 .S ^TMP(NODE,$J,NLINE,0)=$J("",79)
 Q
 ;
TAXEDITC(TIEN,TEXT) ;
 N DARRAY,DIEN,HEADER,NAME,OCNT,OUTPUT,RARRAY,RESULT,TDX,TPR,TAXNODE
 N TAXSEL
 D FINDDIAL^PXRMFRPT(.DARRAY,"PXD(811.2,",TIEN)
 S TEXT(1)="Taxonomy and/or the following dialog(s) have problems."
 S TEXT(2)="Correct either the taxonomy or the following dialog(s):"
 S CNT=2
 I '$D(DARRAY) G TXEDITCX
 I '$D(^PXD(811.2,TIEN,20,"AUID")) S TEXT(1)="Taxonomy does not contain codes marked to be used in a dialog. It is assigned to the following dialog(s)." D  Q
 .S CNT=1,NAME="" F  S NAME=$O(DARRAY(NAME)) Q:NAME=""  S CNT=CNT+1,TEXT(CNT)="   "_NAME
 S TDX=$$TOK(TIEN,"POV"),TPR=$$TOK(TIEN,"CPT")
 S NAME="" F  S NAME=$O(DARRAY(NAME)) Q:NAME=""  D
 .S IEN=DARRAY(NAME) S RESULT=$$CHECKER(IEN,TIEN,"",.OUTPUT) I RESULT="" Q
 .S TEXT(2)="See below for descriptions of the problem(s):"
 .N LINE,NIN,NOUT,TEMP
 .S NIN=$O(OUTPUT(""),-1)
 .D FORMAT^PXRMTEXT(1,75,NIN,.OUTPUT,.NOUT,.TEMP)
 .F LINE=1:1:NOUT S CNT=CNT+1,TEXT(CNT)=TEMP(LINE)
TXEDITCX ;
 I CNT=2 K TEXT
 K ^TMP($J,"DLG FIND")
 Q
 ;
 ;change to use AUID cross-referenc instead of the selectable node, central location for checking what codes to use
 ;in a dialog for encounter type.
TOK(TIEN,TYPE) ;Check if selectable codes exist
 I TYPE="POV" I $D(^PXD(811.2,TIEN,20,"AUID","ICD"))>0!($D(^PXD(811.2,TIEN,20,"AUID","10D"))>0) Q 1
 I TYPE="CPT" I $D(^PXD(811.2,TIEN,20,"AUID","CPT"))>0!($D(^PXD(811.2,TIEN,20,"AUID","CPC"))>0) Q 1
 Q 0
 ;
HELP(HTEXT,TYPE) ;
 N CNT S CNT=1
 S HTEXT(CNT)="Set the taxonomy pick list display for the codes marked to be used in a dialog."
 I TYPE'["G" S CNT=CNT+1,HTEXT(CNT)="\\\\   A: To display a pick list for all codes "
 I TYPE["G" D  Q
 .I "PD" D  Q
 ..S CNT=CNT+1,HTEXT(CNT)="\\\\   D: To display a pick list for the diagnosis codes."
 ..S CNT=CNT+1,HTEXT(CNT)="\\\\      The procedure codes will automatically be filed to the encounter."
 ..S CNT=CNT+1,HTEXT(CNT)="\\\\   P: To display a pick list for the procedure codes."
 ..S CNT=CNT+1,HTEXT(CNT)="\\\\      The diagnosis codes will automatically be filed to the encounter."
 ..S CNT=CNT+1,HTEXT(CNT)="\\\\   N: To not display a pick list all codes will automatically be filed to the encounter."
 I TYPE["D" D
 .S CNT=CNT+1,HTEXT(CNT)="\\\\   D: To display a pick list for the diagnosis codes."
 .S CNT=CNT+1,HTEXT(CNT)="\\\\      The procedure codes will automatically be filed to the encounter."
 I TYPE["P" D
 .S CNT=CNT+1,HTEXT(CNT)="\\\\   P: To display a pick list for the procedure codes."
 .S CNT=CNT+1,HTEXT(CNT)="\\\\      The diagnosis codes will  automatically be filed to the encounter."
 S CNT=CNT+1,HTEXT(CNT)="\\\\   N: To not display a pick list, all codes will automatically be filed "
 S CNT=CNT+1,HTEXT(CNT)="\\\\      to the encounter."
 Q
 ;
