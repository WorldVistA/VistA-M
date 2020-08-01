PXRMDLR2 ;SLC/AGP - Dialog reporting routine to find active CPRS dialogs ;09/14/2017
 ;;2.0;CLINICAL REMINDERS;**53,45**;Feb 04, 2005;Build 566
 Q
 ;
ASK(YESNO,PROMPT,NUM)      ;
 N X,Y,TEXT
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")=PROMPT
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMDLRH("_NUM_")"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
FINDDIAL ;
 N DIROUT,DIRUT,DTOUT,DUOUT
 N ANS,CPRSONLY,DARRAY,DLIST,NAME,NEWP,PARAMS,FINAL,SHOWREAS,TEMPDIAL,TLIST,USER
 K ^TMP("PXRM DIALOG LISTS",$J),^TMP("PXRMXMZ",$J)
 S CPRSONLY=1,SHOWREAS=0
 D ASK(.ANS,"Search for coding system? ",6) I $D(DTOUT)!($D(DUOUT)) G ENX
 I ANS="Y" D CODES Q:$D(DTOUT)&($D(DUOUT))  G:$D(DUOUT) FINDDIAL
ENF ;
 K ANS D ASK(.ANS,"Search for Finding Item(s) used in dialog component(s)? ",8) G:$D(DTOUT)&($D(DUOUT)) ENX  G:$D(DUOUT) FINDDIAL
 I ANS="Y" D FINDING Q:$D(DTOUT)&($D(DUOUT))  G:$D(DUOUT) FINDDIAL
END ;
 K ANS D ASK(.ANS,"Search for specific Reminder Dialog component(s)? ",9) G:$D(DTOUT)&($D(DUOUT)) ENX  G:$D(DUOUT) ENF
 I ANS="Y" D DIALOG  Q:$D(DTOUT)&($D(DUOUT))  G:$D(DUOUT) ENF
ENC ;
 D NEWCVOK^PXRMCVRL(.NEWP,DUZ) I 'NEWP S CPRSONLY=0 W !!,"Cannot search by CPRS Paramater(s), Reminder New Parameter not set to Yes" G ENR
 K ANS D ASK(.ANS,"Search for Reminder Dialog by CPRS parameter(s)? ",10) G:$D(DTOUT)&($D(DUOUT)) ENX  G:$D(DUOUT) ENF
 I ANS="N" S CPRSONLY=0 G ENR
ENU ;
 D CPRSLIST G:$D(DTOUT)&($D(DUOUT)) ENX G:$D(DUOUT)&(NEWP) ENC G:$D(DUOUT)&('NEWP) END
 ;
ENR ;
 K ANS D ASK(.ANS,"Display match criteria on the report? ",13) G:$D(DTOUT)&($D(DUOUT)) ENX   G:$D(DUOUT)&(NEWP) ENC G:$D(DUOUT)&('NEWP) END
 I ANS="Y" S SHOWREAS=1
 ;
PROCESS ;
 ;build list of dialogs that contains the items that were selected
 D BLDLIST
 I '$D(^TMP("PXRM DIALOG LISTS",$J,"DIALOG")) W !,"No parent dialogs found." K ^TMP("PXRM DIALOG LISTS",$J) Q
 ;if searching all dialogs moved results to final array for the user.
 I CPRSONLY=0 K ^TMP("PXRM DIALOG LISTS",$J,"COVER") D MERGE(.FINAL) G OUTPUT
 ;
 ;if searching for CPRS dialogs get dialogs for each users. get all templates for now.
 D GETTDLST^PXRMCVRL(.TLIST)
 D GETCPRSC(.FINAL)
 D CPRSTDLG(.TEMPDIAL,.TLIST)
 ;
OUTPUT ;
 I '$D(FINAL),'$D(TEMPDIAL) W !,"No Dialog Found" G ENX
 D REPORT^PXRMDLR3(.FINAL,.TEMPDIAL,CPRSONLY,SHOWREAS)
 D PRINT
ENX ;
 ;K ^TMP("PXRM DIALOG LISTS",$J)
 Q
 ;
 ;
ADDDREAS(TYPE,IEN,REASON) ;add reason the dialog/dialog items in on the list
 N CNT
 I $D(^TMP("PXRM DIALOG LISTS",$J,TYPE,IEN,"SAVE REASON",REASON)) Q
 S CNT=$O(^TMP("PXRM DIALOG LISTS",$J,TYPE,IEN,"REASON",""),-1)
 S CNT=CNT+1,^TMP("PXRM DIALOG LISTS",$J,TYPE,IEN,"REASON",CNT)=REASON
 S ^TMP("PXRM DIALOG LISTS",$J,TYPE,IEN,"SAVE REASON",REASON)=""
 Q
 ;
ADDFREAS(TYPE,GBL,FIND,REASON) ;add the reason a finding item is on the list. For now only Taxonomies
 N CNT
 I $D(^TMP("PXRM DIALOG LISTS",$J,TYPE,GBL,FIND,"SAVE REASON",REASON)) Q
 S CNT=$O(^TMP("PXRM DIALOG LISTS",$J,TYPE,GBL,FIND,"REASON",""),-1)
 S CNT=CNT+1,^TMP("PXRM DIALOG LISTS",$J,TYPE,GBL,FIND,"REASON",CNT)=REASON
 S ^TMP("PXRM DIALOG LISTS",$J,TYPE,GBL,FIND,"SAVE REASON",REASON)=""
 Q
 ;
BLDLIST ;build list of dialogs that contains the selected search items
 N CODE,FIND,FIEN,GBL,IEN,ITEM,PATH,REASON,SHOWPATH
 S SHOWPATH=$S($G(^TMP("PXRM DIALOG LISTS",$J,"PATH"))="Y":1,1:0)
 ;find taxonomies for codes marked to be used in a dialog. Add taxonomies to the FINDING subscript
 I $D(^TMP("PXRM DIALOG LISTS",$J,"CODES"))>0 S CODE="" F  S CODE=$O(^TMP("PXRM DIALOG LISTS",$J,"CODES",CODE)) Q:CODE=""  D
 .S IEN=0 F  S IEN=$O(^PXD(811.2,IEN)) Q:IEN'>0  I $D(^PXD(811.2,IEN,20,"AUID",CODE))>0 D
 ..S ^TMP("PXRM DIALOG LISTS",$J,"FINDING","PXD(811.2,",IEN)=""
 ..D ADDFREAS("FINDING","PXD(811.2,",IEN,"Coding System: "_CODE)
 ;
 ;search for finding items and add dialog IEN to ITEM subscript
 I $D(^TMP("PXRM DIALOG LISTS",$J,"FINDING"))>0 D GETITEMS
 ;
 ;search for dialog that contain the items.
 I $D(^TMP("PXRM DIALOG LISTS",$J,"ITEM"))>0 D
 .S IEN=0 F  S IEN=$O(^TMP("PXRM DIALOG LISTS",$J,"ITEM",IEN)) Q:IEN'>0  D
 ..S NODE=^TMP("PXRM DIALOG LISTS",$J,"ITEM",IEN)
 ..S REASON="Dialog "_$$RETTYPE($P(NODE,U,4))_": "_$P(NODE,U)_U_IEN D GETDIAL(IEN,REASON)
 ;
 Q
 ;
BLDREAS(DARRAY,GBL,IEN) ;get finding item type and name
 N RESULT,NAME
 S RESULT=$G(DARRAY(GBL))_"."
 S NAME=$P($G(@(U_GBL_IEN_",0)")),U) Q:NAME="" RESULT
 Q RESULT_NAME
 ;
 ;find matching dialogs from a CPRS CoverSheet Parameter
CPRSCOM(FINAL,DLIST,NAME) ;
 N DIEN,NODE
 S FINAL(NAME,"CPRS Cover Sheet Reminder")=""
 S DIEN=0 F  S DIEN=$O(^TMP("PXRM DIALOG LISTS",$J,"DIALOG",DIEN)) Q:DIEN'>0  D
 .S NODE=$G(^TMP("PXRM DIALOG LISTS",$J,"DIALOG",DIEN)) I $P(NODE,U)="" Q
 .I $D(DLIST("REMINDER",DIEN)) S FINAL(NAME,"CPRS Cover Sheet Reminder",$P(NODE,U))=DIEN_U_$P(NODE,U,1,4)
 Q
 ;
 ;find matching dialogs from CPRS Template List
CPRSTDLG(TEMPDIAL,TLIST) ;
 N DIEN,NODE
 S DIEN=0 F  S DIEN=$O(^TMP("PXRM DIALOG LISTS",$J,"DIALOG",DIEN)) Q:DIEN'>0  D
 .S NODE=$G(^TMP("PXRM DIALOG LISTS",$J,"DIALOG",DIEN)) I $P(NODE,U)="" Q
 .I $D(TLIST("TEMPLATE",DIEN)) S TEMPDIAL($P(NODE,U))=DIEN_U_$P(NODE,U,1,4)
 Q
 ;
CODES ;
 N ALIST,CODESYS,CODE,DIR,DIROUT,DIRUT,INUM,LI,NUM,Y
 D BLDCODE^PXRMDTAX("ALL",.CODESYS)
 S CODE="",INUM=0 F  S CODE=$O(CODESYS(CODE)) Q:CODE=""  S INUM=INUM+1,ALIST(INUM)=INUM_" "_CODE
 M DIR("A")=ALIST
 S DIR("A")="Enter your list for search criteria"
 S DIR(0)="LO^1:"_INUM
 S DIR("??")=U_"D HELP^PXRMDLRH(7)"
 W !!,"Select from the following coding systems:"
 D ^DIR
 I $D(DIROUT),$D(DIRUT) S DTOUT=1
 I $D(DUOUT)!$D(DTOUT) Q
 S NUM=$L(Y,",")-1
 F IND=1:1:NUM D
 . S LI=$P(Y,",",IND)
 .I '$D(ALIST(LI)) Q
 .S ^TMP("PXRM DIALOG LISTS",$J,"CODES",$P(ALIST(LI)," ",2))=""
 Q
 ;
 ;build possible parameter values for CPRS CoverSheet pick lists
CPRSLIST ;
 N ALIST,DIR,LIST,NUM,TYPE,X
 K ^TMP("PXRM DIALOG LISTS",$J,"COVER")
 S NUM=0
 S NUM=NUM+1,ALIST(NUM)=" "_$J(NUM,4)_" - Division",LIST(NUM)="DIV"
 S NUM=NUM+1,ALIST(NUM)=" "_$J(NUM,4)_" - Location",LIST(NUM)="LOC"
 S NUM=NUM+1,ALIST(NUM)=" "_$J(NUM,4)_" - Service",LIST(NUM)="SRV"
 S NUM=NUM+1,ALIST(NUM)=" "_$J(NUM,4)_" - System",LIST(NUM)="SYS"
 S NUM=NUM+1,ALIST(NUM)=" "_$J(NUM,4)_" - User",LIST(NUM)="USR"
 S NUM=NUM+1,ALIST(NUM)=" "_$J(NUM,4)_" - User Class",LIST(NUM)="CLASS"
 M DIR("A")=ALIST
 S DIR("A")="Enter your list for the report"
 S DIR(0)="LO^1:"_NUM
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 F X=1:1:$L(Y,",")-1  D  I $D(DTOUT)!($D(DUOUT)) Q
 .I $D(DTOUT)!($D(DUOUT)) Q
 .S NUM=$P(Y,",",X) I NUM'>0 Q
 .S TYPE=$G(LIST(NUM)) I TYPE="" Q
 .I TYPE="SYS" S ^TMP("PXRM DIALOG LISTS",$J,"COVER","System",0)=TYPE Q
 .I TYPE="LOC" D GETVALS("^SC(","Location",TYPE) Q
 .I TYPE="USR" D GETVALS("^VA(200,","User",TYPE) Q
 .I TYPE="SRV" D GETVALS("^DIC(49,","Service",TYPE) Q
 .I TYPE="CLASS" D GETVALS("^USR(8930,","User Class",TYPE) Q
 .I TYPE="DIV" D GETVALS("^AUTTLOC(","Division",TYPE) Q
 Q
 ;
DIALOG ;
 N ANS,DIC
 S DIC="^PXRMD(801.41,"
 S DIC(0)="AEMQ"
 S DIC("A")="Select Dialog Definition: "
 D SELECT("ITEM",.DIC)
 Q
 ;
FINDING ;
 N FNUM,GBL,GNAME,IND,ITEMLIST,LI,LIST,NODE,NUM,PXRMCNT,SOURCE
 S SOURCE("DIALOG")=""
 ;called to determine what finding types to search for
 D FSEL^PXRMFRPT(.FNUM,.GBL,.GNAME,.SOURCE,.LIST)
 S NUM=$L(LIST,",")-1
 I NUM=0 Q
 ;called to determine individual finding items or all finding items for a type to search for.
 D ISEL^PXRMFRPT(.FNUM,.GBL,.GNAME,.LIST,.ITEMLIST)
 I '$D(ITEMLIST) Q
 F IND=1:1:NUM D
 . S LI=$P(LIST,",",IND)
 . I '$D(ITEMLIST(FNUM(LI))) S ^TMP("PXRM DIALOG LISTS",$J,"FINDING",GBL(LI),"ALL")="" Q
 . I $D(ITEMLIST(FNUM(LI))) D
 .. S FIEN=""
 .. F  S FIEN=$O(ITEMLIST(FNUM(LI),FIEN)) Q:FIEN=""  D
 ...S ^TMP("PXRM DIALOG LISTS",$J,"FINDING",GBL(LI),FIEN)=""
 ...I GBL(LI)'["ORD(101.41" Q
 ...;D FINDORD(GBL(LI),FIEN)
 Q
 ;
FINDORD(GBL,FIEN) ;
 N CNT,CNT1,DARRAY,IEN,LCNT,LIEN,NODE,PXRMORD
 D FINDOPAR^ORQOUTL(.PXRMORD,FIEN) I '$D(PXRMORD) Q
 S DARRAY("ORD(101.41,")="Q"
 S REASON=$$BLDREAS(.DARRAY,GBL,FIEN)
 S IEN=0 F  S IEN=$O(PXRMORD(IEN)) Q:IEN'>0  D
 .S NODE=$G(PXRMORD(IEN))
 .S ^TMP("PXRM DIALOG LISTS",$J,"FINDING","ORD(101.41,",IEN)=""
 .;D ADDFREAS("FINDING","ORD(101.41,",IEN,REASON)
 .S ^TMP("PXRM DIALOG LISTS",$J,"FINDING","ORD(101.41,",IEN,"FIEN",FIEN)=NODE
 Q
 ;
 S CNT=0,LCNT=0 F  S CNT=$O(PXRMORD(CNT)) Q:CNT'>0  D
 .;I LCNT=0 S LCNT=CNT
 .;I LCNT'=CNT D ADDFREAS("FINDING","ORD(101.41,",LIEN,REASON) S LCNT=CNT
 .S CNT1=0,LIEN=0 F  S CNT1=$O(PXRMORD(CNT,CNT1)) Q:CNT1'>0  D
 ..S NODE=$G(PXRMORD(CNT,CNT1)) Q:$P(NODE,U)'>0
 ..;I LIEN=0 S LIEN=$P(NODE,U)
 ..S ^TMP("PXRM DIALOG LISTS",$J,"FINDING","ORD(101.41,",$P(NODE,U))=""
 ..D ADDFREAS("FINDING","ORD(101.41,",$P(NODE,U),REASON)
 ..S ^TMP("PXRM DIALOG LISTS",$J,"FINDING","ORD(101.41,",$P(NODE,U),"SEQ")=CNT_U_CNT1
 ..;I LIEN'=$P(NODE,U) D ADDFREAS("FINDING","ORD(101.41,",LIEN,$P(NODE,U,5)_": "_$P(NODE,U,2)_U_$P(NODE,U)) S LIEN=$P(NODE,U)
 M ^TMP("PXRM DIALOG LISTS",$J,"ORDER STRUCTURE")=PXRMORD
 Q
 ;
GETCPRSL(DLIST,USER,LOC) ;
 N CNT
 D GETDLIST^PXRMCVRL(.DLIST,USER,$G(LOC))
 Q
 ;
 ;loop through CPRS coversheet parameter to find CPRS dialogs.
GETCPRSC(FINAL) ;
 N CLASS,DIALOGS,LVL,NAME,TEMP,TYPE
 S TYPE="" F  S TYPE=$O(^TMP("PXRM DIALOG LISTS",$J,"COVER",TYPE)) Q:TYPE=""  D
 .S NAME="" F  S NAME=$O(^TMP("PXRM DIALOG LISTS",$J,"COVER",TYPE,NAME)) Q:NAME=""  D
 ..S LVL=$G(^TMP("PXRM DIALOG LISTS",$J,"COVER",TYPE,NAME)) Q:LVL=""
 ..K DIALOGS
 ..I TYPE'="User Class" D GETLVRD^PXRMCVRL(.DIALOGS,LVL,"")
 ..I TYPE="User Class" D GETLVRD^PXRMCVRL(.DIALOGS,"CLASS",LVL)
 ..I TYPE="Package"!(TYPE="System") S TEMP=TYPE
 ..E  S TEMP=TYPE_" ("_NAME_")"
 ..D CPRSCOM(.FINAL,.DIALOGS,TEMP)
 Q
 ;
GETDIAL(IEN,REASON) ; recurrsive function that follows up the AD cross-references 
 ;until either the item is not used or a dialog is reached
 N CNT,NAME,NODE,DIEN,OIEN
 S NODE=$G(^PXRMD(801.41,IEN,0))
 S NAME=$P(NODE,U)
 ;S CNT=$O(PATH(""),-1) S CNT=CNT+1,PATH(CNT)=NODE
 I $P($G(NODE),U,4)="R" S ^TMP("PXRM DIALOG LISTS",$J,"DIALOG",IEN)=NODE D ADDDREAS("DIALOG",IEN,REASON) Q
 I $P($G(NODE),U,4)="S" D  Q
 .S DIEN=0 F  S DIEN=$O(^PXRMD(801.41,"RG",IEN,DIEN)) Q:DIEN'>0  D
 ..;checked for result group attached to a dialog. This should not happened. Just a safety check
 ..S NODE=$G(^PXRMD(801.41,DIEN,0))
 ..I $P($G(NODE),U,4)="R" S ^TMP("PXRM DIALOG LISTS",$J,"DIALOG",DIEN)=NODE D ADDDREAS("DIALOG",DIEN,REASON) Q
 ..D GETDIAL(DIEN,REASON)
 ;search normal dialog structure
 S DIEN=0,OIEN=0 F  S DIEN=$O(^PXRMD(801.41,"AD",IEN,DIEN)) Q:DIEN'>0  D
 .S NODE=$G(^PXRMD(801.41,DIEN,0))
 .I $P($G(NODE),U,4)="R" S ^TMP("PXRM DIALOG LISTS",$J,"DIALOG",DIEN)=NODE D ADDDREAS("DIALOG",DIEN,REASON) Q
 .D GETDIAL(DIEN,REASON)
 ;search replacement item structure
 S DIEN=0 F  S DIEN=$O(^PXRMD(801.41,"BLR",IEN,DIEN)) Q:DIEN'>0  D
 .S NODE=$G(^PXRMD(801.41,DIEN,0))
 .I $P($G(NODE),U,4)="R" S ^TMP("PXRM DIALOG LISTS",$J,"DIALOG",DIEN)=NODE D ADDDREAS("DIALOG",DIEN,REASON) Q
 .;S:REASON'["item" REASON=$P(REASON,":")_" replacement item: "_$P(REASON,":",2)
 .S:REASON'["item" REASON=$P(REASON,":")_" replacement item: "_NAME_U_$P(REASON,U,2)
 .D GETDIAL(DIEN,REASON)
 Q
GETITEMS ;
 N DARRAY,FIND,FIEN,GBL,IEN,LOC,NODE,REASON,SUB,TYPE
 ;
 S DARRAY("AUTTEDT(")="ED"
 S DARRAY("AUTTEXAM(")="EX"
 S DARRAY("AUTTHF(")="HF"
 S DARRAY("AUTTIMM(")="IM"
 S DARRAY("AUTTSK(")="ST"
 S DARRAY("GMRD(120.51,")="VM"
 S DARRAY("ORD(101.41,")="Q"
 S DARRAY("YTT(601.71,")="MH"
 S DARRAY("WV(790.404,")="WH"
 S DARRAY("WV(790.1,")="WHR"
 S DARRAY("PXD(811.2,")="TX"
 S DARRAY("PXD(811.9,")="RD"
 S DARRAY("PXRMD(811.5,")="TM"
 ;
 S SUB="PXRM DIALOG FINDINGS LIST"
 K ^TMP($J,SUB)
 I $G(PXRMDMUL)=0!('$D(^TMP($J,SUB))) D
 .D FARRAY^PXRMDUTL(SUB,"EGS") I '$D(^TMP($J,SUB)) D
 ..I $G(PXRMDAPI)=1 S PXRMFAIL=1 K ^TMP($J,SUB) Q
 ..W !,"Problem building finding list" K ^TMP($J,SUB) Q
 S GBL="" F  S GBL=$O(^TMP("PXRM DIALOG LISTS",$J,"FINDING",GBL)) Q:GBL=""  D
 .S FIND="" F  S FIND=$O(^TMP("PXRM DIALOG LISTS",$J,"FINDING",GBL,FIND)) Q:FIND=""  D
 ..;find dialog items for individaul findings for a gobal
 ..I +FIND>0 D  Q
 ...S IEN=0 F  S IEN=$O(^TMP($J,SUB,GBL,FIND,IEN)) Q:IEN'>0  D
 ....S NODE=$G(^PXRMD(801.41,IEN,0)),^TMP("PXRM DIALOG LISTS",$J,"ITEM",IEN)=NODE D
 .....S REASON=$$BLDREAS(.DARRAY,GBL,FIND)
 .....S LOC="" F  S LOC=$O(^TMP($J,SUB,GBL,FIND,IEN,LOC)) Q:LOC=""  D
 ......S TYPE=$S(LOC="A":"Additional Finding: ",LOC="B":"Branching Logic: ",LOC="O":"Orderable Item: ",LOC="RG":"Result Group: ",1:"Finding: ")
 ......D ADDDREAS("ITEM",IEN,TYPE_REASON_U_FIND_";"_GBL)
 ..;find dialog items for all finding for a gobal
 ..I FIND="ALL" D  Q
 ...S FIEN=0 F  S FIEN=$O(^TMP($J,SUB,GBL,FIEN)) Q:FIEN'>0  D
 ....S IEN=0 F  S IEN=$O(^TMP($J,SUB,GBL,FIEN,IEN)) Q:IEN'>0  D
 .....S NODE=$G(^PXRMD(801.41,IEN,0)),^TMP("PXRM DIALOG LISTS",$J,"ITEM",IEN)=NODE D
 ......S REASON=$$BLDREAS(.DARRAY,GBL,FIEN)
 ......S LOC="" F  S LOC=$O(^TMP($J,SUB,GBL,FIEN,IEN,LOC)) Q:LOC=""  D
 .......S TYPE=$S(LOC="A":"Additional Finding: ",LOC="B":"Branching Logic: ",LOC="O":"Orderable Item: ",LOC="RG":"Result Group: ",1:"Finding: ")
 .......D ADDDREAS("ITEM",IEN,TYPE_REASON_U_FIEN_";"_GBL)
 I $G(PXRMDMUL)=0 K ^TMP($J,SUB)
 Q
 ;
GETVALS(GBL,TYPE,INST) ;
 N DIC,NUM,X
 S DIC=GBL
 S DIC(0)="AEMQ"
 S DIC("A")="Select "_TYPE_": "
 D SELECT(TYPE,.DIC,INST)
 Q
 ;
MERGE(FINAL) ;
 N DIEN,NAME,NODE
 S NAME=$$GET1^DIQ(200,DUZ,.01)
 S DIEN=0 F  S DIEN=$O(^TMP("PXRM DIALOG LISTS",$J,"DIALOG",DIEN)) Q:DIEN'>0  D
 .S NODE=^TMP("PXRM DIALOG LISTS",$J,"DIALOG",DIEN)
 .S FINAL(NAME,"Reminder Dialog",$P(NODE,U))=DIEN_U_$P(NODE,U,1,4)
 Q
 ;
PRINT ;
 N ANS,BOP,TO,X
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="B" D
 . S X="IORESET"
 . D ENDR^%ZISS
 . D BROWSE^DDBR("^TMP(""PXRMXMZ"",$J)","NR","Reminder Dialog Search Report")
 . W IORESET
 . D KILL^%ZISS
 I BOP="P" D GPRINT^PXRMUTIL("^TMP(""PXRMXMZ"",$J)")
 ;Ask the user if they want the report delivered through MailMan.
 S ANS=$$ASKYN^PXRMEUT("N","Deliver the report as a MailMan message")
 I ANS="1" D
 . S TO(DUZ)=""
 . D SEND^PXRMMSG("PXRMXMZ","Clinical Reminders Dialog Search Report",.TO,DUZ)
 Q
 ;
PROMPTS(ITEM) ;
 N ANS,EXT,GUIID,IEN,NUM,NAME,TYPE
 S IEN=+Y,NAME=$P(ITEM,U,2),TYPE=$P($G(^PXRMD(801.41,IEN,0)),U,4)
 I "PF"'[TYPE Q
 S EXT=$S(TYPE="P":"Prompt",TYPE="F":"Forced Value",1:"") I EXT="" Q
 D ASK(.ANS,NAME_" is a "_EXT_" search for all "_EXT_" of the same type? ",14) I $D(DTOUT)!($D(DUOUT)) Q
 I ANS'="Y" Q
 S GUIID=+$G(^PXRMD(801.41,IEN,46)) I GUIID'>0 Q
 S NUM=0 F  S NUM=$O(^PXRMD(801.41,NUM)) Q:NUM'>0  D
 .I +$G(^PXRMD(801.41,NUM,46))'=GUIID Q
 .S ^TMP("PXRM DIALOG LISTS",$J,"ITEM",NUM)=$P($G(^PXRMD(801.41,NUM,0)),U)
 .W !,$P($G(^PXRMD(801.41,NUM,0)),U)_" added as search criteria."
 Q
 ;
RETTYPE(T) ;
 N RESULT
 S RESULT=$S(T="E":"Element",T="G":"Group",T="P":"Prompt",T="F":"Forced Value",T="S":"Result Group",T="T":"Result Element","R":"Dialog",1:"")
 Q RESULT
 ;
SELECT(TYPE,DIC,INST) ;
 N CNT,NAME,SEL,Y
 S SEL=1
 W !
 F  Q:'SEL  D
 . D ^DIC
 . I ($D(DTOUT))!($D(DUOUT)) S SEL=0 Q
 . I Y=-1 S SEL=0 Q
 . I TYPE="User" S ^TMP("PXRM DIALOG LISTS",$J,"COVER",TYPE,$P(Y,U,2))=INST_".`"_+Y Q
 . I TYPE="Location" S ^TMP("PXRM DIALOG LISTS",$J,"COVER",TYPE,$P(Y,U,2))=INST_".`"_+Y Q
 . I TYPE="Service" S ^TMP("PXRM DIALOG LISTS",$J,"COVER",TYPE,$P(Y,U,2))=INST_".`"_+Y Q
 . I TYPE="User Class" S ^TMP("PXRM DIALOG LISTS",$J,"COVER",TYPE,$P(Y,U,2))=Y Q
 . I TYPE="Division" D
 ..S NAME=$$GET1^DIQ(4,+Y,.01,"I"),^TMP("PXRM DIALOG LISTS",$J,"COVER",TYPE,NAME)=INST_".`"_+Y Q
 . ;I TYPE'="USER" S ^TMP("PXRM DIALOG LISTS",$J,TYPE,+Y)=$P(Y,U,2)
 . ;I TYPE="LOCATION" S SEL=0 Q
 . S ^TMP("PXRM DIALOG LISTS",$J,TYPE,+Y)=$P(Y,U,2)
 . I TYPE="ITEM" D PROMPTS(Y)
 . I TYPE="USER" S ^TMP("PXRM DIALOG LISTS",$J,TYPE,$P(Y,U,2))=Y
 Q
 ;
