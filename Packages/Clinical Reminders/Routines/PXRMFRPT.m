PXRMFRPT ;SLC/PKR - Finding usage report. ;10/7/2014
 ;;2.0;CLINICAL REMINDERS;**12,17,16,18,22,26,53**;Feb 04, 2005;Build 225
 ;==============================
BLDLIST(FILENUM,GBL,FIEN,SUB) ;
 I FILENUM'=811.9 D DEFLIST(FILENUM,GBL,FIEN,SUB)
 I FILENUM'=811.5 D TERMLIST(FILENUM,GBL,FIEN,SUB)
 D DIALOG(FILENUM,GBL,FIEN,SUB)
 D OIGLIST(FILENUM,GBL,FIEN,SUB)
 I (FILENUM=811.5)!(FILENUM=811.9) D
 . D OCRLIST(FILENUM,GBL,FIEN,SUB)
 . D RSETLIST(FILENUM,GBL,FIEN,SUB)
 Q
 ;
 ;==============================
DEFLIST(FILENUM,GBL,FIEN,SUB) ;Search reminder definitions for any that are
 ;using GBL as a finding. If FIEN is not null then search for only
 ;those findings.
 N FI,FNDIEN,IEN
 S IEN=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . I '$D(^PXD(811.9,IEN,20,"E",GBL)) Q
 . I +FIEN>0 D
 .. S FI=""
 .. F  S FI=$O(^PXD(811.9,IEN,20,"E",GBL,FIEN,FI)) Q:FI=""  D
 ... S ^TMP($J,SUB,FILENUM,FIEN,"DEF",IEN,FI)=""
 . I +FIEN=0 D
 ..;No finding specified, find all of them.
 .. S FNDIEN=""
 .. F  S FNDIEN=$O(^PXD(811.9,IEN,20,"E",GBL,FNDIEN)) Q:FNDIEN=""  D
 ... S FI=""
 ... F  S FI=$O(^PXD(811.9,IEN,20,"E",GBL,FNDIEN,FI)) Q:FI=""  D
 .... S ^TMP($J,SUB,FILENUM,FNDIEN,"DEF",IEN,FI)=""
 Q
 ;
DFIND(TLIST) ;
 S IND=0
 F  S IND=+$O(^DD(801.41,15,"V",IND)) Q:IND=0  D
 . S TEMP=^DD(801.41,15,"V",IND,0)
 . S TLIST($P(TEMP,U,2))=$P(TEMP,U,1)
 Q
 ;==============================
DIALDSAR(OUTPUT) ;
 ;This is used for individual dialog element checks, may be better in a
 ;different routine
 N FILENUM,IND,STATUS,TEMP
 S IND=0 F  S IND=+$O(^DD(801.41,15,"V",IND)) Q:IND=0  D
 . S TEMP=^DD(801.41,15,"V",IND,0)
 . S FILENUM=$P(TEMP,U)
 .;DBIA #4640
 . S STATUS=+$$GETSTAT^HDISVF01(FILENUM)
 . I STATUS'=6,STATUS'=7 Q
 . S OUTPUT($$ROOT^DILFD(FILENUM))=FILENUM_U_STATUS
 ;DBIA #4640
 S STATUS=+$$GETSTAT^HDISVF01(101.43) I STATUS'=6,STATUS'=7 Q
 S OUTPUT($$ROOT^DILFD("^101.43,"))=101.43_U_STATUS
 Q
 ;
 ;==============================
DIALOG(FILENUM,GBL,FIEN,SUB) ;
 N DIEN,FIELD,FIND
 I '$D(^TMP($J,"DLG FIND")) D BLDDLGTM^PXRMSTS("DLG FIND")
 I +FIEN>0 D  Q
 .I '$D(^TMP($J,"DLG FIND",GBL,FIEN)) Q
 .S DIEN=0
 .F  S DIEN=$O(^TMP($J,"DLG FIND",GBL,FIEN,DIEN)) Q:DIEN'>0  D
 ..S FIELD=""
 ..F  S FIELD=$O(^TMP($J,"DLG FIND",GBL,FIEN,DIEN,FIELD)) Q:FIELD=""  D
 ...S ^TMP($J,SUB,FILENUM,FIEN,"DIALOG",DIEN,FIELD)=""
 ;
 S FIND="" F  S FIND=$O(^TMP($J,"DLG FIND",GBL,FIND)) Q:FIND=""  D
 .S DIEN=0
 .F  S DIEN=$O(^TMP($J,"DLG FIND",GBL,FIND,DIEN)) Q:DIEN'>0  D
 ..S FIELD=""
 ..F  S FIELD=$O(^TMP($J,"DLG FIND",GBL,FIND,DIEN,FIELD)) Q:FIELD=""  D
 ...S ^TMP($J,SUB,FILENUM,FIND,"DIALOG",DIEN,FIELD)=""
 Q
 ;
 ;==============================
FINDDIAL(RESULT,GBL,FIEN) ;
 ;This api is used to return a list of dialogs that contains a specific
 ;finding
 K ^TMP($J,"DLG FIND")
 D BLDDLGTM^PXRMSTS("DLG FIND")
 N DIEN,FIELD,FIND,NAME
 I +FIEN'>0 Q
 I '$D(^TMP($J,"DLG FIND",GBL,FIEN)) Q
 S DIEN=0
 F  S DIEN=$O(^TMP($J,"DLG FIND",GBL,FIEN,DIEN)) Q:DIEN'>0  D
 .S NAME=$P($G(^PXRMD(801.41,DIEN,0)),U) Q:NAME=""
 .S RESULT(NAME)=DIEN
 Q
 ;
 ;==============================
FSEL(FNUM,GBL,GNAME,SOURCE,LIST) ;Build a list of reminder findings and let the user
 ;select from the list.
 N ALIST,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILENUM,FLIST,IND,INUM
 N STAR,TEMP,TLIST,X,Y
 S (IND,INUM)=0
 I $D(SOURCE("DEFINITION")) D RFIND(.TLIST)
 I $D(SOURCE("DIALOG")) D DFIND(.TLIST)
 S IND="",INUM=0
 F  S IND=$O(TLIST(IND)) Q:IND=""  D
 . S INUM=INUM+1
 . S FILENUM=TLIST(IND)
 .;DBIA #4640
 . S STAR=$S($$SCREEN^HDISVF01(FILENUM):" *",1:"")
 . S FLIST(FILENUM)=INUM
 . S GNAME(INUM)=IND
 . S ALIST(INUM)=" "_$J(INUM,4)_" - "_GNAME(INUM)_STAR
 . S FNUM(INUM)=FILENUM
 . S GBL(INUM)=$P($$GET1^DID(FILENUM,"","","GLOBAL NAME"),"^",2)
 M DIR("A")=ALIST
 S DIR("A")="Enter your list for the report"
 S DIR(0)="LO^1:"_INUM
 W !!,"Select from the following reminder findings (* signifies standardized):"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S LIST="" Q
 I $D(DUOUT)!$D(DTOUT) S LIST="" Q
 S LIST=Y
 Q
 ;
 ;==============================
ISEL(FNUM,GBL,GNAME,LIST,ITEMLIST) ;See if the user wants selected items or
 ;all from the selected finding types.
 N DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IND,LI,NUM,SEL,TEXT,Y
 S DIC(0)="AEMQ"
 S DIR(0)="S^1:ALL;2:SELECTED"
 S DIR("B")="SELECTED"
 S NUM=$L(LIST,",")-1
 F IND=1:1:NUM D
 . S LI=$P(LIST,",",IND)
 . S TEXT="Search for all or selected "_GNAME(LI)
 . S TEXT=TEXT_$S($E(TEXT,$L(TEXT))="S":"?",1:"S?")
 . W !,TEXT
 . D ^DIR
 . I $D(DIROUT)!$D(DIRUT) Q
 . I $D(DUOUT)!$D(DTOUT) Q
 . I Y=1 S ITEMLIST="ALL" Q
 . S DIC=FNUM(LI)
 . S DIC("A")="Select "_GNAME(LI)_": "
 . S SEL=1
 . F  Q:'SEL  D
 .. D ^DIC
 .. I ($D(DTOUT))!($D(DUOUT)) S SEL=0 Q
 .. I Y=-1 S SEL=0 Q
 .. S ITEMLIST(FNUM(LI),$P(Y,U,1))=""
 Q
 ;
 ;==============================
OCRLIST(FILENUM,GBL,FIEN,SUB) ;Search Reminder Order Check rules for
 ;any that are using GBL as a finding. If FIEN is not null then search
 ;for only those findings.
 I FILENUM=811.5,'$D(^PXD(801.1,"T")) Q
 I FILENUM=811.9,'$D(^PXD(801.1,"R")) Q
 N IEN
 I FILENUM=811.5 D
 . I +FIEN>0 D
 .. S IEN=0
 .. F  S IEN=$O(^PXD(801.1,"T",FIEN,IEN)) Q:IEN'>0  S ^TMP($J,SUB,FILENUM,FIEN,"OCRULE",IEN)=""
 . I +FIEN=0 D
 .. S FIEN=""
 .. F  S FIEN=$O(^PXD(801.1,"T",FIEN)) Q:FIEN=""  D
 ... S IEN=0
 ... F  S IEN=$O(^PXD(801.1,"T",FIEN,IEN)) Q:IEN'>0  S ^TMP($J,SUB,FILENUM,FIEN,"OCRULE",IEN)=""
 I FILENUM=811.9 D
 . I +FIEN>0 D
 .. S IEN=0
 .. F  S IEN=$O(^PXD(801.1,"R",FIEN,IEN)) Q:IEN'>0  S ^TMP($J,SUB,FILENUM,FIEN,"OCRULE",IEN)=""
 . I +FIEN=0 D
 .. S FIEN=""
 .. F  S FIEN=$O(^PXD(801.1,"R",FIEN)) Q:FIEN=""  D
 ... S IEN=0
 ... F  S IEN=$O(^PXD(801.1,"R",FIEN,IEN)) Q:IEN'>0  S ^TMP($J,SUB,FILENUM,FIEN,"OCRULE",IEN)=""
 Q
 ;
 ;==============================
OIGLIST(FNUM,GBL,FIEN,SUB) ;Search reminder orderable item groups for
 ;any that are using GBL as a finding. If FIEN is not null then search
 ;for only those findings.
 N IEN,ITEM,NODE,RIEN,RNAME
 S NODE=$S(FNUM=101.43:"O",FNUM=50.605:"P",FNUM=50:"P",FNUM=50.6:"P",1:"")
 I NODE="" Q
 S ITEM=$S(NODE="P":FIEN_";"_GBL,1:FIEN)
 I +FIEN>0 D  Q
 . I '$D(^PXD(801,NODE,ITEM)) Q
 . S IEN=0 F  S IEN=$O(^PXD(801,NODE,ITEM,IEN)) Q:IEN'>0  D
 .. S ^TMP($J,SUB,FNUM,FIEN,"ROC",IEN)="" Q
 I '$D(^PXD(801,NODE)) Q
 S ITEM="" F  S ITEM=$O(^PXD(801,NODE,ITEM)) Q:ITEM=""  D
 . S FIEN=$S(NODE="P":$P(ITEM,";"),1:ITEM)
 . S IEN=0 F  S IEN=$O(^PXD(801,NODE,ITEM,IEN)) Q:IEN'>0  D
 .. S ^TMP($J,SUB,FNUM,FIEN,"ROC",IEN)=""
 Q
 ;
 ;==============================
REPD ;Main report driver.
 N DONE,FI,FIEN,FIENS,FILES,FILENUM,FNUM,GBL,GNAME,IEN,IND,ITEMLIST
 N LI,LIST,NL,NUM,REP,SOURCE,STATUS,TYPE
 S DONE=0
 S SOURCE("DEFINITION")="",SOURCE("DIALOG")=""
 W !,"Clinical Reminders Usage Report"
 F  Q:DONE  D
 . K ^TMP($J,"DIALOG MESSAGE"),^TMP($J,"DLG FIND")
 . K ^TMP($J,"FDATA"),^TMP("PXRMXMZ",$J)
 . K FNUM,GBL,GNAME,ITEMLIST,LIST
 .;Get a list of findings for the report.
 . D FSEL(.FNUM,.GBL,.GNAME,.SOURCE,.LIST)
 . S NUM=$L(LIST,",")-1
 . I NUM=0 S DONE=1 Q
 . D ISEL(.FNUM,.GBL,.GNAME,.LIST,.ITEMLIST)
 . I '$D(ITEMLIST) Q
 . D BLDDLGTM^PXRMSTS("DLG FIND")
 . F IND=1:1:NUM D
 .. S LI=$P(LIST,",",IND)
 .. I '$D(ITEMLIST(FNUM(LI))) D BLDLIST(FNUM(LI),GBL(LI),"","FDATA") Q
 .. I $D(ITEMLIST(FNUM(LI))) D
 ... S FIEN=""
 ... F  S FIEN=$O(ITEMLIST(FNUM(LI),FIEN)) Q:FIEN=""  D BLDLIST(FNUM(LI),GBL(LI),FIEN,"FDATA")
 .;Process the finding list and generate the MailMan message.
 . D REPORT
 . K ^TMP($J,"FDATA"),^TMP($J,"SDATA"),^TMP("PXRMXMZ",$J),^TMP($J,"DLG FIND")
 Q
 ;
 ;==============================
REPORT ;Generate the report.
 N DTYP,FILENUM,FNAME,FNUMLIST,GNAME,IND,NAME,NL,NOUT,NTYPE
 N REPFNAME,REPGNAME,RNUM,STANDARD,STATUS
 N TEXT,TEXTOUT,TO,TYPELIST
 D SORT
 S FNUMLIST("DEF")=811.9,TYPELIST("DEF")="Reminder Definition"
 S FNUMLIST("DIALOG")=801.41,TYPELIST("DIALOG")="Reminder Dialog"
 S FNUMLIST("LRULE")=810.4,TYPELIST("LRULE")="Reminder List Rule"
 S FNUMLIST("OCRULE")=801.1,TYPELIST("OCRULE")="Reminder Order Check Rules"
 S FNUMLIST("ROC")=801,TYPELIST("ROC")="Reminder Order Check Items Group"
 S FNUMLIST("TERM")=811.5,TYPELIST("TERM")="Reminder Term"
 K ^TMP("PXRMXMZ",$J)
 S NL=1,^TMP("PXRMXMZ",$J,NL,0)="Clinical Reminders finding usage report."
 S GNAME=""
 F  S GNAME=$O(^TMP($J,"SDATA",GNAME)) Q:GNAME=""  D
 . S FILENUM=$P(^TMP($J,"SDATA",GNAME),U,1)
 . S STANDARD=$P(^TMP($J,"SDATA",GNAME),U,2)
 . S NTYPE=0
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="The following "_GNAME_"(s) are used as follows:"
 . I STANDARD S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="(This file has been standardized.)"
 . S FNAME=""
 . F  S FNAME=$O(^TMP($J,"SDATA",GNAME,FNAME)) Q:FNAME=""  D
 .. S FIEN=^TMP($J,"SDATA",GNAME,FNAME)
 .. S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 .. S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="======================================================="
 .. S TEXT=GNAME_" - "_FNAME_" (IEN="_FIEN_")"
 .. D FORMATS^PXRMTEXT(1,72,TEXT,.NOUT,.TEXTOUT)
 .. F IND=1:1:NOUT S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXTOUT(IND)
 .. I STANDARD D
 ... S STATUS=^TMP($J,"SDATA",GNAME,FNAME,"STD")
 ... S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  status is: "_STATUS
 ... I $D(^TMP($J,"SDATA",GNAME,FNAME,"STD","REP")) D
 .... S REPGNAME=$P(^TMP($J,"SDATA",GNAME,FNAME,"STD","REP"),U,1)
 .... S REPFNAME=$P(^TMP($J,"SDATA",GNAME,FNAME,"STD","REP"),U,2)
 .... S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  its replacement is "_REPGNAME_"; "_REPFNAME
 .. S TYPE=""
 .. F  S TYPE=$O(TYPELIST(TYPE)) Q:TYPE=""  D
 ... I '$D(^TMP($J,"FDATA",FILENUM,FIEN,TYPE)) Q
 ... S NTYPE=NTYPE+1
 ... S RNUM=FNUMLIST(TYPE)
 ... S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 ... I NTYPE>1 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="---------------------------------"
 ... S TEXT=" Is used in the following "_TYPELIST(TYPE)_"(s):"
 ... D FORMATS^PXRMTEXT(4,72,TEXT,.NOUT,.TEXTOUT)
 ... F IND=1:1:NOUT S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXTOUT(IND)
 ... S IEN=0
 ... F  S IEN=$O(^TMP($J,"FDATA",FILENUM,FIEN,TYPE,IEN)) Q:IEN=""  D
 .... S NAME=$$GET1^DIQ(RNUM,IEN,.01)
 .... I NAME="" S NAME="Undefined"
 .... S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 ....;
 .... I TYPE="DIALOG" D 
 ..... S DTYP=$P(^PXRMD(801.41,IEN,0),U,4)
 ..... S TEXT="Dialog "_$S(DTYP="E":"element",DTYP="G":"group",DTYP="S":"result group",1:"item")
 ..... S TEXT=TEXT_" "_NAME_$S($P(^PXRMD(801.41,IEN,0),U,3)=1:" (Disable)",1:"")_" (IEN="_IEN_")"
 ..... S TEXT=TEXT_", used in the"
 ..... D FORMATS^PXRMTEXT(6,72,TEXT,.NOUT,.TEXTOUT)
 ..... F IND=1:1:NOUT S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXTOUT(IND)
 ..... S FI=0
 ..... F  S FI=$O(^TMP($J,"FDATA",FILENUM,FIEN,TYPE,IEN,FI)) Q:FI=""  D
 ...... S TEXT=$S(FI=15:"Finding Item field",FI=17:"Orderable Item field",FI=18:"Additional Finding field",FI=119:"MH Test field",1:"")
 ...... D FORMATS^PXRMTEXT(8,72,TEXT,.NOUT,.TEXTOUT)
 ...... F IND=1:1:NOUT S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXTOUT(IND)
 ....;
 .... I TYPE'="DIALOG" D
 ..... S TEXT=NAME_" (IEN="_IEN_")"
 ..... D FORMATS^PXRMTEXT(6,72,TEXT,.NOUT,.TEXTOUT)
 ..... F IND=1:1:NOUT S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXTOUT(IND)
 ..... S FI=0
 ..... F  S FI=$O(^TMP($J,"FDATA",FILENUM,FIEN,TYPE,IEN,FI)) Q:FI=""  D
 ...... S TEXT="Finding number "_FI
 ...... D FORMATS^PXRMTEXT(8,72,TEXT,.NOUT,.TEXTOUT)
 ...... F IND=1:1:NOUT S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXTOUT(IND)
 .....;
 ;Deliver the report.
 I NL=1 D  Q
 . W !,"None of the selected findings are used."
 . K ^TMP("PXRMXMZ",$J)
 N ANS,BOP,X
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="B" D
 . S X="IORESET"
 . D ENDR^%ZISS
 . D BROWSE^DDBR("^TMP(""PXRMXMZ"",$J)","NR","Reminder Usage Report")
 . W IORESET
 . D KILL^%ZISS
 I BOP="P" D GPRINT^PXRMUTIL("^TMP(""PXRMXMZ"",$J)")
 ;Ask the user if they want the report delivered through MailMan.
 S ANS=$$ASKYN^PXRMEUT("N","Deliver the report as a MailMan message")
 I ANS="1" D
 . S TO(DUZ)=""
 . D SEND^PXRMMSG("PXRMXMZ","Clinical Reminders Finding Usage Report",.TO,DUZ)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
RFIND(TLIST) ;
 N IND
 S IND=0
 ;Create a temporary list ordered by file name.
 S TLIST("REMINDER DEFINITION")=811.9
 ;DBIA #2991, #5149 for access to ^DD.
 F  S IND=+$O(^DD(811.902,.01,"V",IND)) Q:IND=0  D
 . S TEMP=^DD(811.902,.01,"V",IND,0)
 . S TLIST($P(TEMP,U,2))=$P(TEMP,U,1)
 Q
 ;==============================
RSETLIST(FILENUM,GBL,FIEN,SUB) ;Search list rules for any that are using
 ;GBL as a finding. If FIEN is not null then search for only those
 ;findings.
 N FNDIEN,IEN,TEMP,TYPE
 S IEN=0
 F  S IEN=+$O(^PXRM(810.4,IEN)) Q:IEN=0  D
 . S TEMP=^PXRM(810.4,IEN,0)
 . S TYPE=$P(TEMP,U,3)
 .;If it is not a finding rule or reminder rule skip it.
 . I (TYPE=3)!(TYPE=5) Q
 . S FNDIEN=+$S(FILENUM=811.5:$P(TEMP,U,7),FILENUM=811.9:$P(TEMP,U,10),1:0)
 . I FNDIEN=0 Q
 .;If no finding specified find, all of them.
 . I (FIEN=FNDIEN)!(FIEN="") S ^TMP($J,SUB,FILENUM,FNDIEN,"LRULE",IEN)=""
 Q
 ;
 ;==============================
SORT ;Sort by global name and finding name.
 N FIEN,FILENUM,FNAME,GNAME,STANDARD
 K ^TMP($J,"SDATA")
 S FILENUM=0
 F  S FILENUM=$O(^TMP($J,"FDATA",FILENUM)) Q:FILENUM=""  D
 . S GNAME=$$GET1^DID(FILENUM,"","","NAME")
 .;DBIA #4640
 . S STANDARD=$$SCREEN^HDISVF01(FILENUM)
 . S ^TMP($J,"SDATA",GNAME)=FILENUM_U_STANDARD
 . S FIEN=0
 . F  S FIEN=$O(^TMP($J,"FDATA",FILENUM,FIEN)) Q:FIEN=""  D
 .. S FNAME=$$GET1^DIQ(FILENUM,FIEN,.01)
 .. I FNAME="" S FNAME="Undefined"
 .. S ^TMP($J,"SDATA",GNAME,FNAME)=FIEN
 .. I STANDARD D
 ... N REPFNAME,REPFNUM,REPGNAME,REPIEN,STATUS
 ...;DBIA #4631
 ... S STATUS=$P($$GETSTAT^XTID(FILENUM,.01,FIEN_","),U,3)
 ... I STATUS="" S STATUS="undefined"
 ... S ^TMP($J,"SDATA",GNAME,FNAME,"STD")=STATUS
 ... S REP=$$RPLCMNT^XTIDTRM(FILENUM,FIEN)
 ... I REP=(FIEN_";"_FILENUM) S REP=""
 ... I REP'="" D
 .... S REPIEN=$P(REP,";",1)
 .... S REPFNUM=$P(REP,";",2)
 .... S REPGNAME=$$GET1^DID(REPFNUM,"","","NAME")
 .... S REPFNAME=$$GET1^DIQ(REPFNUM,REPIEN,.01)
 .... S ^TMP($J,"SDATA",GNAME,FNAME,"STD","REP")=REPGNAME_U_REPFNAME
 Q
 ;
 ;==============================
TERMLIST(FILENUM,GBL,FIEN,SUB) ;Search reminder terms for any that are using
 ;GBL as a finding. If FIEN is not null then search for only those
 ;findings.
 N FI,FNDIEN,IEN
 S IEN=0
 F  S IEN=+$O(^PXRMD(811.5,IEN)) Q:IEN=0  D
 . I '$D(^PXRMD(811.5,IEN,20,"E",GBL)) Q
 . I +FIEN>0 D
 .. S FI=""
 .. F  S FI=$O(^PXRMD(811.5,IEN,20,"E",GBL,FIEN,FI)) Q:FI=""  D
 ... S ^TMP($J,SUB,FILENUM,FIEN,"TERM",IEN,FI)=""
 . I +FIEN=0 D
 ..;No finding specified find, all of them.
 .. S FNDIEN=""
 .. F  S FNDIEN=$O(^PXRMD(811.5,IEN,20,"E",GBL,FNDIEN)) Q:FNDIEN=""  D
 ... S FI=""
 ... F  S FI=$O(^PXRMD(811.5,IEN,20,"E",GBL,FNDIEN,FI)) Q:FI=""  D
 .... S ^TMP($J,SUB,FILENUM,FNDIEN,"TERM",IEN,FI)=""
 Q
 ;
