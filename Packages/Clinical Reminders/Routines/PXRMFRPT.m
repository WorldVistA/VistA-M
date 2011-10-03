PXRMFRPT ; SLC/PKR - Finding usage report. ;11/02/2009
 ;;2.0;CLINICAL REMINDERS;**12,17,16**;Feb 04, 2005;Build 119
 ;==============================
BLDLIST(FILENUM,GBL,FIEN,SUB) ;
 D DEFLIST(FILENUM,GBL,FIEN,SUB)
 D TERMLIST(FILENUM,GBL,FIEN,SUB)
 D DIALOG(FILENUM,GBL,FIEN,SUB)
 D BROC(FILENUM,GBL,FIEN,SUB)
 Q
 ;
BROC(FNUM,GBL,FIEN,SUB) ;
 N IEN,NODE,RIEN,RNAME
 S NODE=$S(FNUM=811.9:"R",FNUM=811.5:"T",FNUM=101.43:"O",FNUM=50.605:"D",1:"")
 I NODE="" Q
 I +FIEN>0 D  Q
 .I '$D(^PXD(801,NODE,FIEN)) Q
 .S IEN=0 F  S IEN=$O(^PXD(801,NODE,FIEN,IEN)) Q:IEN'>0  D
 ..I NODE="O"!(NODE="D") S ^TMP($J,SUB,FNUM,FIEN,"ROC",IEN,NODE)="" Q
 ..S RIEN="" F  S RIEN=$O(^PXD(801,NODE,FIEN,IEN,RIEN)) Q:RIEN=""  D
 ...S RNAME=$P($G(^PXD(801,IEN,3,RIEN,0)),U)
 ...S ^TMP($J,SUB,FNUM,FIEN,"ROC",IEN,RNAME)="" Q
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
 ;HANDLE NONE
 N DIEN,FIELD,FIND
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
FSEL(FNUM,GBL,GNAME,LIST) ;Build a list of reminder findings and let the user
 ;select from the list.
 N ALIST,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILENUM,FLIST,IND,INUM
 N STAR,TEMP,TLIST,X,Y
 S (IND,INUM)=0
 ;DBIA #2991, #5149 for access to ^DD.
 F  S IND=+$O(^DD(811.902,.01,"V",IND)) Q:IND=0  D
 . S TEMP=^DD(811.902,.01,"V",IND,0)
 .;Create a temporary list ordered by file name.
 . S TLIST($P(TEMP,U,2))=$P(TEMP,U,1)
 ;Scan dialogs for additional findings.
 S IND=0
 F  S IND=+$O(^DD(801.41,15,"V",IND)) Q:IND=0  D
 . S TEMP=^DD(801.41,15,"V",IND,0)
 . S TLIST($P(TEMP,U,2))=$P(TEMP,U,1)
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
MSG ;Generate the MailMan message that reports the results.
 N ANS,DTYP,FILENUM,FNAME,GNAME,IND,NAME,NL,NOUT,REPIEN,REPFNUM,REPGNAME
 N REPFNAME,RNUM,STANDARD,STATUS,TEXT,TEXTOUT,TO
 K ^TMP("PXRMXMZ",$J)
 S NL=1,^TMP("PXRMXMZ",$J,NL,0)="Clinical Reminder finding usage report."
 S FILENUM=0
 F  S FILENUM=$O(^TMP($J,"FDATA",FILENUM)) Q:FILENUM=""  D
 .;DBIA #4640
 . S STANDARD=$$SCREEN^HDISVF01(FILENUM)
 . S GNAME=$$GET1^DID(FILENUM,"","","NAME")
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="The following "_GNAME_"s are used as Clinical Reminder findings:"
 . I STANDARD S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="(This file has been standardized.)"
 . S FIEN=0
 . F  S FIEN=$O(^TMP($J,"FDATA",FILENUM,FIEN)) Q:FIEN=""  D
 .. S FNAME=$$GET1^DIQ(FILENUM,FIEN,.01)
 .. S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 .. S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="======================================================="
 .. S TEXT=GNAME_" - "_FNAME_" (IEN="_FIEN_")"
 .. D FORMATS^PXRMTEXT(1,72,TEXT,.NOUT,.TEXTOUT)
 .. F IND=1:1:NOUT S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXTOUT(IND)
 .. I STANDARD D
 ...;DBIA #4631
 ... S STATUS=$P($$GETSTAT^XTID(FILENUM,.01,FIEN_","),U,3)
 ... I STATUS="" S STATUS="undefined"
 ... S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  status is: "_STATUS
 ...;DBIA #5078
 ... S REP=$$RPLCMNT^XTIDTRM(FILENUM,FIEN)
 ... I REP=(FIEN_";"_FILENUM) S REP=""
 ... I REP'="" D
 .... S REPIEN=$P(REP,";",1)
 .... S REPFNUM=$P(REP,";",2)
 .... S REPGNAME=$$GET1^DID(REPFNUM,"","","NAME")
 .... S REPFNAME=$$GET1^DIQ(REPFNUM,REPIEN,.01)
 .... S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  its replacement is "_REPGNAME_"; "_REPFNAME
 .. F TYPE="DEF","TERM","DIALOG" D
 ... I '$D(^TMP($J,"FDATA",FILENUM,FIEN,TYPE)) Q
 ... S RNUM=$S(TYPE="DEF":811.9,TYPE="TERM":811.5,TYPE="DIALOG":801.41)
 ... S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 ... S TEXT=FNAME_" is used in the following "_$S(TYPE="DEF":"Definitions:",TYPE="TERM":"Terms:",TYPE="DIALOG":"Dialogs:",1:"")
 ... D FORMATS^PXRMTEXT(4,72,TEXT,.NOUT,.TEXTOUT)
 ... F IND=1:1:NOUT S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXTOUT(IND)
 ... S IEN=0
 ... F  S IEN=$O(^TMP($J,"FDATA",FILENUM,FIEN,TYPE,IEN)) Q:IEN=""  D
 .... S NAME=$$GET1^DIQ(RNUM,IEN,.01)
 .... S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="----------------------------"
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
 ;Deliver the message.
 I NL=1 W !,"None of the selected findings are used in definitions, terms, or dialogs."
 I NL>1 D
 .;Ask the user if they want the report delivered through MailMan.
 . S ANS=$$ASKYN^PXRMEUT("Y","Deliver the report as a MailMan message")
 . I ANS="1" D
 .. S TO(DUZ)=""
 .. D SEND^PXRMMSG("PXRMXMZ","Clinical Reminders Finding Usage Report",.TO)
 . I ANS="0" F IND=1:1:NL W !,^TMP("PXRMXMZ",$J,IND,0)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
 ;==============================
REPD ;Main report driver.
 N DONE,FI,FIEN,FIENS,FILES,FILENUM,FNUM,GBL,GNAME,IEN,IND,ITEMLIST
 N LI,LIST,NL,NUM,REP,STATUS,TYPE
 S DONE=0
 W !,"Clinical Reminders Finding Usage Report"
 F  Q:DONE  D
 . K ^TMP($J,"DIALOG MESSAGE"),^TMP($J,"DLG FIND")
 . K ^TMP($J,"FDATA"),^TMP("PXRMXMZ",$J)
 . K FNUM,GBL,GNAME,ITEMLIST,LIST
 .;Get a list of findings for the report.
 . D FSEL(.FNUM,.GBL,.GNAME,.LIST)
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
 . D MSG
 . K ^TMP($J,"FDATA"),^TMP("PXRMXMZ",$J),^TMP($J,"DLG FIND")
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
 ..;No finding specified find all of them.
 .. S FNDIEN=""
 .. F  S FNDIEN=$O(^PXRMD(811.5,IEN,20,"E",GBL,FNDIEN)) Q:FNDIEN=""  D
 ... S FI=""
 ... F  S FI=$O(^PXRMD(811.5,IEN,20,"E",GBL,FNDIEN,FI)) Q:FI=""  D
 .... S ^TMP($J,SUB,FILENUM,FNDIEN,"TERM",IEN,FI)=""
 Q
 ;
