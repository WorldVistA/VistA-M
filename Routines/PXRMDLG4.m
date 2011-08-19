PXRMDLG4 ; SLC/PJH - Reminder Dialog Edit/Inquiry ;01/18/2010
 ;;2.0;CLINICAL REMINDERS;**4,6,12,16**;Feb 04, 2005;Build 119
 ;
WP(SUB,SUB1,WIDTH,SEQ,VALMCNT) ;Format WP text
 N DIWF,DIWL,DIWR,IC,TEXT,X,TXTCNT,DTXT,CNT,SUB2
 S (CNT,SUB2,TXTCNT)=0
 F  S SUB2=$O(^PXRMD(801.41,SUB,SUB1,SUB2)) Q:'SUB2  D
 .S TXTCNT=TXTCNT+1,DTXT(TXTCNT)=$G(^PXRMD(801.41,SUB,SUB1,SUB2,0))
 .S DTXT(TXTCNT)=$$STRREP^PXRMUTIL($G(DTXT(TXTCNT)),"<br>","\\")
 I TXTCNT>0 D
 .N OUTPUT,NLINES
 .S NLINES=0 D FORMAT^PXRMTEXT(1,WIDTH,TXTCNT,.DTXT,.NLINES,.OUTPUT)
 .I NLINES>0 K DTXT M DTXT=OUTPUT
 S CNT=0
 F  S CNT=$O(DTXT(CNT)) Q:CNT=""  D
 .S TEXT=$G(DTXT(CNT)),VALMCNT=VALMCNT+1
 .S ^TMP(NODE,$J,VALMCNT,0)=SEQ_TEXT,SEQ=$J("",$L(SEQ))
 Q
 ;
ADD ;PXRM DIALOG ADD ELEMENT validation
 N ANS,DTOUT,DUOUT,LIT,LOCK,Y,PIEN,ERR,IEN,NATIONAL,SEQ
 W IORESET
 S VALMBCK="R",NATIONAL=0
 I $P($G(^PXRMD(801.41,PXRMDIEN,100)),U)="N" S NATIONAL=1
 S LOCK=$P($G(^PXRMD(801.41,PXRMDIEN,100)),U,4)
 I NATIONAL,'($G(PXRMINST)=1)&(DUZ(0)="@"),$G(LOCK)'=1 D  Q
 .W !,"Elements may not be added to national reminder dialogs" H 2
 ;
 F  D SEQ(.SEQ,.PIEN) Q:$D(DUOUT)!$D(DTOUT)  Q:SEQ
 Q:$D(DUOUT)!$D(DTOUT)
 ;
 ;Check if sequence number is OK
 I $G(PIEN)="" Q
 S ANS="N" D ASK^PXRMDLG5(.ANS,PIEN) Q:$D(DUOUT)!$D(DTOUT)!($G(ANS)="N")
 ;
 ;Select a dialog element to add to parent dialog (PIEN)
 ;PIEN may be dialog or a group within the dialog
 D ESEL^PXRMDEDT(PIEN,SEQ)
 ;Rebuild workfile
 D BUILD^PXRMDLG(PXRMMODE)
 Q
 ;
FADD(DIEN,FTAB) ;Additional Findings
 N FIND,FSUB,FTYP,FNAME,FNUM
 S FSUB=0
 F  S FSUB=$O(^PXRMD(801.41,DIEN,3,FSUB)) Q:'FSUB  D
 .S FIND=$P($G(^PXRMD(801.41,DIEN,3,FSUB,0)),U) Q:FIND=""
 .S FNAME="" D FDESC(FIND) Q:FNAME=""
 .;Save additional finding name
 .S FOUND=1 D FSAVE(2,FNAME,FTYP,FTAB,FIND)
 Q
 ;
DETAIL(DIEN,LEV,VIEW,NODE) ;;Build listman global for all components
 N DDATA,DDLG,DEND,DCIEN,DNAM,DSEQ,DSTRT,IND,JND,DSUB
 S DSEQ=0
 ;
 ;Get each sequence number
 F  S DSEQ=$O(^PXRMD(801.41,DIEN,10,"B",DSEQ)) Q:'DSEQ  D
 .;Determine subscript
 .S DSUB=$O(^PXRMD(801.41,DIEN,10,"B",DSEQ,"")) Q:'DSUB
 .;Get ien of prompt/component
 .S DCIEN=$P($G(^PXRMD(801.41,DIEN,10,DSUB,0)),U,2) Q:'DCIEN
 .I "PF"[$P($G(^PXRMD(801.41,DCIEN,0)),U,4) D  Q
 ..S ^TMP("PXRMDLG4",$J,"IEN",NSEL)=DIEN_U_DSEQ
 ..S ^TMP("PXRMDLG4",$J,"SEQ",LEV_DSEQ)=DCIEN
 .;Save line in workfile
 .D DLINE(DCIEN,LEV,DSEQ,NODE)
 .;Build pointers back to parent
 .I VIEW'=4 D
 ..S ^TMP("PXRMDLG4",$J,"IEN",NSEL)=DIEN_U_DSEQ
 ..S ^TMP("PXRMDLG4",$J,"SEQ",LEV_DSEQ)=DCIEN
 .;Process any sub-components
 .I VIEW<5 D DETAIL(DCIEN,LEV_DSEQ_".",VIEW,NODE)
 Q
 ;
DLINE(DIEN,LEV,DSEQ,NODE) ;Save individual component details
 N CNT,DBOX,DCAP,DDIS,DMULT,DSUPP,DSHOW,DTYP,DTXT
 N IC,RESNM,RESULT,RIEN,RNAME,RCNT
 ;Dialog name
 S DDATA=$G(^PXRMD(801.41,DIEN,0)),DNAM=$P(DDATA,U) Q:DNAM=""
 ;Check if standard PXRM prompt
 I $$PXRM^PXRMEXID(DNAM) Q
 ;Dialog Type and Disabled
 S DDIS=$P(DDATA,U,3),DTYP=$P(DDATA,U,4)
 S DTYP=$S(DTYP="G":"Group",1:"Element"),DNAM=DTYP_": "_DNAM
 I VIEW=5 S DNAM=DNAM
 ;Resolution type and name
 S RNAME="",RIEN=$P($G(^PXRMD(801.41,DIEN,1)),U,3)
 I RIEN S RNAME=$P($G(^PXRMD(801.9,RIEN,0)),U)
 ;
 ;Group fields
 I DTYP="Group" D
 .S DGRP=1,DTXT=$P(DDATA,U,5),DCAP=" [group caption]"
 .I DTXT="" S DCAP=""
 .I DTXT]"" S DCAP=DTXT_" "_DCAP
 .S DBOX=$S($P(DDATA,U,6)="Y":"BOX",1:"NO BOX")
 .S DSUPP=$S($P(DDATA,U,11):"SUPPRESS",1:"NO SUPPRESS")
 .S DSHOW=$S($P(DDATA,U,10):"HIDE",1:"SHOW")
 .S DMULT=$P(DDATA,U,9)
 .S DMULT=$S(DMULT=1:"ONE ONLY",DMULT=2:"ONE OR MORE",DMULT=3:"NONE OR ONE",DMULT=4:"ALL REQUIRED",1:"NO SELECTION")
 ;
 N DPTX,DTXT,EXIST,ITEM,TEMP,SEP,SEQ,TAB,ALTLEN
 S NSEL=NSEL+1,NLINE=NLINE+1,ITEM=NSEL,SEP=$E(LEV,$L(LEV)),SEQ=LEV_DSEQ
 ;Suppress Item numbers for INQ options
 I VIEW=4 S ITEM=""
 ;Otherwise display Item, Sequence and Dialog Name
 S TEMP=$J(ITEM,4)_$J("",3)_SEQ,TAB=$L(TEMP)+2
 S CNT=0 F IC=1:1 Q:'$P(SEQ,".",IC)  S:$P(SEQ,".",IC)<10 CNT=CNT+1
 S TAB=TAB+CNT
 ;
 S ALTLEN=$L(TEMP)
 ;Display dialog name
 S TEMP=TEMP_$J("",2+CNT)_DNAM
 ;Add disabled if present
 I +DDIS>0 S TEMP=TEMP_" (Disabled)"
 ;
 S ^TMP(NODE,$J,NLINE,0)=TEMP
 ;check for alternate dialog element/group
 I VIEW<2!(VIEW>4) D
 .I $D(^PXRMD(801.41,DIEN,49))>0 D ALT^PXRMDLG5(DIEN,LEV,DSEQ,NODE,VIEW,.NLINE,CNT,ALTLEN)
 ;
 ;Dialog Text or P/N Text
 I (VIEW=2)!(VIEW=3)!(VIEW=4) D
 .N DGBEG,DGSUB,TSUB
 .S DGSUB=0,TSUB=$$TSUB^PXRMDLG1(DIEN,VIEW)
 .I VIEW=4 S DGBEG=$J("",TAB)_"Text: "
 .I VIEW'=4 S DGBEG=$J("",5+$L(SEQ)+CNT+$L(DTYP))_"Text: "
 .D WP(DIEN,TSUB,65,.DGBEG,.NLINE)
 .I DTYP="Group" D
 ..S TEMP=DGBEG_"["_DBOX_", "_DSUPP_", "_DSHOW_", "_DMULT_"]"
 ..S NLINE=NLINE+1,^TMP(NODE,$J,NLINE,0)=TEMP
 ;
 ;Set up selection index
 S ^TMP(NODE,$J,"IDX",NSEL,DIEN)=""
 ;Insert finding items
 I (VIEW=1)!(VIEW=4),("Element;Group"[DTYP) D
 .N DSUB,FDATA,FILENUM,FLIT,FLONG,FNAME,FOUND,FREP,FTYP,TEMP
 .;Findings
 .S FNAME="",FOUND=0
 .D FDESC($P($G(^PXRMD(801.41,DIEN,1)),U,5))
 .I FNAME'="" S FOUND=1 D FSAVE(1,FNAME,FTYP,TAB)
 .;Resolution
 .I RNAME]"" D
 ..S TEMP=$J("",TAB)_"Resolution: "_RNAME
 ..S NLINE=NLINE+1,^TMP(NODE,$J,NLINE,0)=TEMP
 .;Result Group
 .I VIEW=4 D
 ..S RCNT=0 F  S RCNT=$O(^PXRMD(801.41,DIEN,51,RCNT)) Q:RCNT'>0  D
 ...S RESULT=$P($G(^PXRMD(801.41,DIEN,51,RCNT,0)),U)
 ...S RESNM=$P($G(^PXRMD(801.41,RESULT,0)),U) Q:RESNM=""
 ...S TEMP=$J("",TAB)_"Result Group: "_RESNM
 ...S NLINE=NLINE+1,^TMP(NODE,$J,NLINE,0)=TEMP
 .;Additional findings
 .D FADD(DIEN,TAB)
 ;Get additional prompts
 I VIEW=2 D
 .S FIEN=$P($G(^PXRMD(801.41,DIEN,1)),U,5)
 .I $G(FIEN)["PXD(811.2," D TAX^PXRMDLG1(FIEN,DSEQ,DIEN,.NLINE,NODE)
 .I $G(FIEN)["ICPT"!($G(FIEN)["ICD9") D FIND^PXRMDLG1(FIEN,DSEQ,DIEN,.NLINE,NODE)
 .D FADD(DIEN,TAB)
 I VIEW,VIEW<5,"Element;Group"[DTYP D PROMPT(DIEN,TAB,"Prompts: ",VIEW)
 ;
 I VIEW=4,$D(^PXRMD(801.41,DIEN,49))>0 D ALT^PXRMDLG5(DIEN,LEV,DSEQ,NODE,VIEW,.NLINE,CNT,ALTLEN)
 S NLINE=NLINE+1
 S ^TMP(NODE,$J,NLINE,0)=$J("",79)
 Q
 ;
FDESC(FIEN) ;Finding description
 N FGLOB,FITEM,FNUM
 S FGLOB=$P(FIEN,";",2) Q:FGLOB=""
 S FITEM=$P(FIEN,";") Q:FITEM=""
 S FNUM=" ["_FITEM_"]"
 I FGLOB["ICD9" D  Q
 .S FTYP="DIAGNOSIS",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,3)_FNUM
 I FGLOB["WV" D  Q
 .S FTYP="WH NOTIFICATION PURPOSE",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U)_FNUM
 I FGLOB["ICPT" D  Q
 .S FTYP="PROCEDURE",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,2)_FNUM
 I FGLOB["ORD(101.41" D  Q
 .S FTYP="QUICK ORDER",FGLOB=U_FGLOB_FITEM_",0)"
 .S FNAME=$P($G(@FGLOB),U,2)_FNUM
 ;Short name for finding type
 S FTYP=$G(DEF1(FGLOB)) Q:FTYP=""
 ;Long name
 S FTYP=$G(DEF2(FTYP))
 S FGLOB=U_FGLOB_FITEM_",0)"
 S FNAME=$P($G(@FGLOB),U,1)_FNUM
 I FNAME="" S FNAME=$P($G(@FGLOB),U)_FNUM
 I FNAME="" S FNAME=FITEM
 Q
 ;
FSAVE(DSUB,FNAME,FTYP,FTAB,FIEN) ;Save finding details
 N IND,FMTSTR,NL,OUTPUT,TEMP,TEXT
 I DSUB>1 D
 . S FMTSTR=FTAB_"R^13L1^"_(65-FTAB)_"L"
 . S TEXT=U_"Add. Finding:"
 I DSUB=1 D
 . S FMTSTR=FTAB_"R^8L1^"_(70-FTAB)_"L"
 . S TEXT=U_"Finding:"
 S TEXT=TEXT_U_FNAME_" ("_FTYP_")"
 D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NL,.OUTPUT)
 F IND=1:1:NL D
 . S NLINE=NLINE+1
 . S ^TMP(NODE,$J,NLINE,0)=OUTPUT(IND)
 I VIEW=2,($G(FIEN)["ICPT"!($G(FIEN)["ICD9")) D FIND^PXRMDLG1(FIEN,DSEQ,DIEN,.NLINE,NODE)
 Q
 ;
PROMPT(IEN,TAB,TEXT,VIEW) ;additional prompts in the dialog file
 N DATA,DDIS,DGSEQ,DSUB,DTITLE,DTXT,DTYP,SEQ,SUB
 S SEQ=0
 F  S SEQ=$O(^PXRMD(801.41,IEN,10,"B",SEQ)) Q:'SEQ  D
 .S SUB=$O(^PXRMD(801.41,IEN,10,"B",SEQ,"")) Q:'SUB
 .S DSUB=$P($G(^PXRMD(801.41,IEN,10,SUB,0)),U,2) Q:'DSUB 
 .S DATA=$G(^PXRMD(801.41,DSUB,0)) Q:DATA=""
 .S DNAME=$P(DATA,U),DDIS=$P(DATA,U,3),DTYP=$P(DATA,U,4)
 .I "PF"'[DTYP Q
 .I DTYP="F" S DNAME=DNAME_" (forced value)"
 .I DTYP="P",(VIEW=2)!(VIEW=3) D
 ..;Override prompt caption
 ..S DTITLE=$P($G(^PXRMD(801.41,IEN,10,SUB,0)),U,6)
 ..I DTITLE="" S DTITLE=$P($G(^PXRMD(801.41,DSUB,2)),U,4)
 ..S DNAME=DTITLE
 .S DNAME=$J("",TAB)_TEXT_DNAME
 .S:+DDIS>0 DNAME=DNAME_" (Disabled)"
 .S NLINE=NLINE+1
 .S ^TMP(NODE,$J,NLINE,0)=DNAME
 .S TEXT=$J("",$L(TEXT))
 Q
 ;
SEQ(SEQ,PIEN) ;Select sequence number to add
 N X,Y,TEXT,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S SEQ=0
 S DIR(0)="FA0;1;30"
 S DIR("A")="Enter a new SEQUENCE NUMBER: "
 S DIR("?")="Enter new sequence number. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMDLG4(1)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 ;
 ;Check that sequence number is new 
 I $D(^TMP("PXRMDLG4",$J,"SEQ",X)) D  Q
 .W !,"Sequence number "_X_" already in use."
 ;
 ;Then check that the parent is a group or reminder dialog
 I X["." D  Q:X=""
 .N CLASS,SUB
 .;Sequence number of parent
 .S SUB=$P(X,".",1,$L(X,".")-1)
 .I $G(SUB)=""!($G(SUB)=0) W !,"Invalid sequence number. A sequence number cannot be less then 1" H 2 Q
 .;Get IEN of parent dialog or group
 .S PIEN=$G(^TMP("PXRMDLG4",$J,"SEQ",SUB))
 .;Validate sequence number
 .I 'PIEN W !,"Sequence number is not part of an existing group." S X="" Q
 .;Validate that the parent is a group or reminder dialog
 .I "RG"'[$P($G(^PXRMD(801.41,PIEN,0)),U,4) D  S X="" Q
 ..W !,"New sequences can only be added to groups or reminder dialogs"
 .;Disallow adding elements to national dialogs or groups
 .I $P($G(^PXMRD(801.41,PIEN,100)),U)="N" D  Q:X=""
 ..Q:(DUZ(0)="@")&($G(PXRMINST)=1)
 ..W !,"Elements cannot be added to a national group" S X=""
 ;
 ;If adding to top level parent ien is reminder dialog
 I X?.N S PIEN=PXRMDIEN
 ;
 S SEQ=$P(X,".",$L(X,"."))
 Q
 ;
 ;
HELP(CALL) ;General help text routine.
 N HTEXT
 N DIWF,DIWL,DIWR,IC
 S DIWF="C75",DIWL=0,DIWR=75
 ;
 I CALL=1 D
 .S HTEXT(1)="Sequence numbers can be added at any level. Specify the full"
 .S HTEXT(2)="number for the level required (e.g. 15.10.20)."
 ;
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
