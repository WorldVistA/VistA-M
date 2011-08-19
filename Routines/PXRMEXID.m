PXRMEXID ;SLC/PJH - Reminder Dialog Exchange Install Routine.;04/28/2009
 ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
 ;
 ;==================================================
 ;Install all dialog components in an exchange file entry
 ;------------------------------------------------
INSALL N ALL,DIROUT,DIRUT,DTOUT,DUOUT,IND,PXRMDONE
 ;
 ;Set the install date and time.
 S IND="",PXRMDONE=0
 ;
 ;Go to full screen mode.
 D FULL^VALM1
 ;
 ;Check if all or none exists - option to install all unchanged
 N DNAME
 S DNAME=$G(^TMP("PXRMEXTMP",$J,"PXRMDNAME"))
 D EXIST^PXRMEXIX(.ALL,DNAME,"reminder dialog","")
 I ALL=0 D DISP^PXRMEXLD(PXRMMODE) Q
 ;
 ;Lock the entire file
 Q:'$$LOCK
 F  S IND=$O(^TMP("PXRMEXLD",$J,"SEL",IND),-1) Q:(IND="")!(PXRMDONE)  D
 .D INSCOM(DNAME,IND,1)
 ;
 ;Clear lock
 D UNLOCK
 ;
 ;Rebuild display workfile
 D DISP^PXRMEXLD(PXRMMODE)
 ;
 K PXRMNMCH
 Q
 ;
 ;Build list of descendents names
 ;-------------------------------
INSBLD(DIALNAM,NAME,INAME) ;
 N DNAME,IDATA,ISEQ
 S ISEQ=0
 F  S ISEQ=$O(^TMP("PXRMEXTMP",$J,"DMAP",NAME,ISEQ)) Q:'ISEQ  D
 .S IDATA=$G(^TMP("PXRMEXTMP",$J,"DMAP",NAME,ISEQ)) Q:IDATA=""
 .S DNAME=$P(IDATA,U) Q:DNAME=""
 .;
 .I $D(^TMP("PXRMEXTMP",$J,"DREPL"))>0 D
 ..S REPL=$$CHKREPL^PXRMEXDB(NAME) I REPL>0 D INSREPL(DIALNAM,NAME,REPL,.INAME)
 .S INAME(DNAME)=""
 .;Check for descendants
 .I $D(^TMP("PXRMEXTMP",$J,"DMAP",DNAME)) D INSBLD(DIALNAM,DNAME,.INAME)
 Q
 ;
 ;Build list of replacement names
 ;-------------------------------
INSREPL(DIALNAME,NAME,REPL,INAME) ;
 N DNAME,IDATA,ISEQ
 S ISEQ=0
 S IDATA=$G(^TMP("PXRMEXTMP",$J,"DREPL",DIALNAM,REPL,NAME)) Q:IDATA=""
 S DNAME=$P(IDATA,U) Q:DNAME=""  S INAME(DNAME)=""
 ;Check for descendants
 I $D(^TMP("PXRMEXTMP",$J,"DMAP",DNAME)) D INSBLD(DIALNAM,DNAME,.INAME)
 Q
 ;
 ;Install component IND
 ;---------------------
INSCOM(DIALNAM,IND,SILENT) ;
 N ACTION,ATTR,CSUM,DTYP,EXIEN,END,EXISTS,FILENUM,IND120,JND120
 N NEWPT01,PT01,START,REPL,SAME,TEMP
 S TEMP=^TMP("PXRMEXLD",$J,"SEL",IND),FILENUM=$P(TEMP,U,1)
 S START=$P(TEMP,U,2),END=$P(TEMP,U,3) Q:START=""
 S IND120=$P(TEMP,U,4) Q:'IND120
 S JND120=$P(TEMP,U,5) Q:'JND120
 S EXISTS=$P(TEMP,U,6)
 S TEMP=^PXD(811.8,PXRMRIEN,100,START,0),PT01=$P(TEMP,"~",2) Q:PT01=""
 S DTYP=$G(^TMP("PXRMEXTMP",$J,"DTYP",PT01))
 I DTYP="dialog" S DTYP="reminder dialog"
 ;
 ;Go to full screen mode.
 D FULL^VALM1
 ;
 ;Check for descendents
 S REPL=$$CHKREPL^PXRMEXDB(DIALNAM,PT01)
 I 'SILENT&($$INSDSC(PT01)!(REPL>0)) D  Q:PXRMDONE
 .N ANS,INDS,TEXT
 .S TEXT(1)=PT01_" ("_DTYP_") contains sub-components."
 .S TEXT="Install all sub-components with the "_DTYP_": "
 .;Give option to install all descendents
 .D ASK^PXRMEXIX(.ANS,.TEXT,1) Q:PXRMDONE
 .I $G(ANS)="N" S PXRMDONE=1 Q
 .I $G(ANS)="Y" D
 ..S INDS=IND
 ..N IDATA,INAME,IND
 ..I REPL>0 D INSREPL(DIALNAM,PT01,REPL,.INAME)
 ..;Build list of decendents to install
 ..D INSBLD(DIALNAM,PT01,.INAME)
 ..;Check if all or none exists - option to install all unchanged
 ..D EXIST^PXRMEXIX(.ALL,PT01,DTYP,.INAME) Q:PXRMDONE
 ..;Start at the end of the list
 ..S IND=""
 ..F  S IND=$O(^TMP("PXRMEXLD",$J,"SEL",IND),-1) Q:PXRMDONE!(IND=INDS)  D
 ...N PT01,START,TEMP
 ...S TEMP=^TMP("PXRMEXLD",$J,"SEL",IND),START=$P(TEMP,U,2) Q:START=""
 ...S PT01=$P(^PXD(811.8,PXRMRIEN,100,START,0),"~",2) Q:PT01=""
 ...;Ignore namechanges
 ...I $D(PXRMNMCH(801.41,PT01)) Q
 ...;Only install descendents
 ...I $D(INAME(PT01)) D INSCOM(DIALNAM,IND,1)
 ;
SETENTRY ;
 D SETATTR^PXRMEXFI(.ATTR,FILENUM,PT01)
 S ACTION=""
 ;Double check that it hasn't been installed
 S EXIEN=$$EXISTS^PXRMEXIU(801.41,PT01)
 I EXIEN,'EXISTS S EXISTS=1
 I EXISTS D
 . D CHECKSUM^PXRMEXCS(.ATTR,START,END)
 . S CSUM=$$FILE^PXRMEXCS(ATTR("FILE NUMBER"),EXIEN)
 . S SAME=$S(ATTR("CHECKSUM")=CSUM:1,1:0)
 . I SAME D FEIMSG^PXRMEXFI(SAME,.ATTR) S ACTION="S",(PXRMNMCH,NEWPT01)=""
 I ACTION="" D
 .;If all components installed the default is 'Install or Overwrite'
 . S:ALL ACTION=$S(EXISTS:"O",1:"I"),(PXRMNMCH,NEWPT01)=""
 . S:'ALL ACTION=$$GETFACT^PXRMEXFI(PT01,.ATTR,.NEWPT01,.PXRMNMCH,EXIEN)
 ;Save what was done for the installation summary.
 S ^TMP("PXRMEXIAD",$J,IND,ATTR("FILE NAME"),ATTR("PT01"),ACTION)=NEWPT01
 ;Clear heading
 S VALMHDR(2)=""
 ;If the ACTION is Quit then quit the entire install.
 I ACTION="Q" S PXRMDONE=1 S VALMHDR(2)="Install not completed" Q
 ;If the ACTION is Skip then skip this component.
 I ACTION="S" S VALMBCK="R" Q
 ;If the ACTION is Replace then skip this component.
 I ACTION="P" S VALMBCK="R",VALMHDR(2)=PT01_" replaced with "_NEWPT01 Q
 ;Install this component.
 D FILE^PXRMEXIC(PXRMRIEN,EXIEN,IND120,JND120,ACTION,.ATTR,.PXRMNMCH)
 S VALMBCK="R"
 I PXRMDONE S VALMHDR(2)="Install aborted" Q
 I NEWPT01="" S VALMHDR(2)=PT01_" ("_DTYP_") installed from exchange file."
 I NEWPT01'="" S VALMHDR(2)=PT01_" installed as "_NEWPT01_"."
 ;If reminder dialog - disable and give option to link
 I DTYP="reminder dialog" D
 .N DNAME
 .S DNAME=PT01
 .I NEWPT01'="" S DNAME=NEWPT01
 .D INSLNK(DNAME)
 Q
 ;
 ;Check for descendents (either elements or prompts)
 ;--------------------------------------------------
INSDSC(NAME) ;
 N DATA,DFOUND,SUB
 S DFOUND=0,SUB=0
 F  S SUB=$O(^TMP("PXRMEXTMP",$J,"DMAP",NAME,SUB)) Q:'SUB  D  Q:DFOUND
 .S DATA=$G(^TMP("PXRMEXTMP",$J,"DMAP",NAME,SUB)) Q:DATA=""
 .S DFOUND=1
 Q DFOUND
 ;
INSREPL1(NAME) ;
 N DATA,DFOUND,SUB
 S DFOUND=0,SUB=0
 F  S SUB=$O(^TMP("PXRMEXTMP",$J,"DREPL",NAME,SUB)) Q:'SUB  D  Q:DFOUND
 .S DATA=$G(^TMP("PXRMEXTMP",$J,"DREPL",NAME,SUB)) Q:DATA=""
 .S DFOUND=1
 Q DFOUND
 ;Option to link dialog to a reminder
 ;-----------------------------------
INSLNK(DNAME) ;
 N DIEN,DISABLE,DSRC,RNAME
 N DA,DIE,DR
 ;Disable
 S DIEN=$O(^PXRMD(801.41,"B",DNAME,"")) Q:'DIEN
 ;Set dialog as disabled
 S DISABLE=1
 ;Except for National dialogs
 I $P(^PXRMD(801.41,DIEN,100),U)="N" S DISABLE=0
 ;
 S DR="3///^S X=DISABLE",DIE="^PXRMD(801.41,",DA=$P(DIEN,U)
 D ^DIE
 ;
 ;Quit if already linked
 I $D(^PXD(811.9,"AG",DIEN)) Q
 ;
 S RNAME=""
 ;If reminder was renamed use as default
 I $D(PXRMNMCH(811.9)) D
 .S RNAME=$O(PXRMNMCH(811.9,"")) Q:RNAME=""
 .S RNAME=$G(PXRMNMCH(811.9,RNAME))
 ;Otherwise use original reminder name as default
 I RNAME="" D
 .N DATA,FOUND,RIEN,SUB
 .;Rebuild ^TMP("PXRMEXLC",$J
 .D CDISP^PXRMEXLC(PXRMRIEN)
 .;
 .S SUB="",FOUND=0
 .F  S SUB=$O(^TMP("PXRMEXLC",$J,"SEL",SUB),-1) Q:'SUB  Q:FOUND  D
 ..S DATA=$G(^TMP("PXRMEXLC",$J,"SEL",SUB)) Q:$P(DATA,U)'=811.9
 ..S RIEN=$P(DATA,U,4),FOUND=1 Q:'RIEN
 ..S RNAME=$P($G(^PXD(811.9,RIEN,0)),U)
 ;
TAG W !!,"Reminder Dialog "_DNAME_" is not linked to a reminder.",!
 ;Select reminder to link
 S IEN=$$SELECT^PXRMINQ("^PXD(811.9,","Select Reminder to Link: ",RNAME)
 ;Update reminder link in #811.9
 I $P(IEN,U)'=-1 D
 .N DA,DIE,DIK,DR
 .;Set reminder to dialog pointer
 .S DR="51///^S X=DNAME",DIE="^PXD(811.9,",DA=$P(IEN,U)
 .D ^DIE
 .;If source reminder is null replace with linked reminder
 .S DSRC=$P($G(^PXRMD(801.41,DIEN,0)),U,2) Q:DSRC
 .S DSRC=$P(IEN,U)
 .S DR="2///^S X=DSRC",DIE="^PXRMD(801.41,",DA=$P(DIEN,U)
 .D ^DIE
 Q
 ;
 ;Install Selected Components
 ;---------------------------
INSSEL N ALL,IND,PXRMDONE,VALMY
 N DIROUT,DIRUT,DNAME,DTOUT,DUOUT
 N VALMBG,VALMLST
 S VALMBG=1,VALMLST=+$O(^TMP("PXRMEXLD",$J,"IDX",""),-1)
 ;Get the list to install.
 D EN^VALM2(XQORNOD(0))
 ;
 ;Set the install date and time.
 S ALL="",PXRMDONE=0
 ;
 ;Lock the entire file
 Q:'$$LOCK
 ;
 S DNAME=$G(^TMP("PXRMEXTMP",$J,"PXRMDNAME"))
 S IND=0
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D INSCOM(DNAME,IND,0)
 ;
 ;Clear locks
 D UNLOCK
 ;
 ;Rebuild workfile
 D DISP^PXRMEXLD(PXRMMODE)
 Q
 ;
 ;Install the exchange entry PXRMRIEN
 ;-----------------------------------
INSTALL N CLOK,IEN,IND,VALMY
 ;Make sure the component list exists for this entry. PXRMRIEN is
 ;set in INSTALL^PXRMEXLR.
 S CLOK=1
 I '$D(^PXD(811.8,PXRMRIEN,120)) D CLIST^PXRMEXCO(PXRMRIEN,.CLOK)
 I 'CLOK Q
 D CDISP^PXRMEXLC(PXRMRIEN)
 S VALMBCK="R",VALMCNT=$O(^TMP("PXRMEXLD",$J,"IDX"),-1)
 Q
 ;
PXRM(NAME) ;Validate prompts
 ;Ignore non-PXRM
 I $E(NAME,1,4)'="PXRM" Q 0
 N DIEN,RESULT
 I $G(PXRMINST)=1 D  Q RESULT
 .S RESULT=0
 .S DIEN=$O(^PXRMD(801.41,"B",NAME,"")) I 'DIEN Q
 .I $P($G(^PXRMD(801.41,DIEN,100)),U)'="N" Q
 .I ($P($G(^PXRMD(801.41,DIEN,0)),U,4)="P")!($P($G(^PXRMD(801.41,DIEN,0)),U,4)="F") S RESULT=1
 ;
 ;Check if this is a national code
 S DIEN=$O(^PXRMD(801.41,"B",NAME,""))
 ;If not found abort
 I 'DIEN Q 0
 ;if result group/element quit
 I $P($G(^PXRMD(801.41,DIEN,0)),U,4)="S"!($P($G(^PXRMD(801.41,DIEN,0)),U,4)="T") Q 0
 ;Check class
 I $P($G(^PXRMD(801.41,DIEN,100)),U)="N" Q 1
 ;Otherwise local
 Q 0
 ;
 ;Lock the dialog file
LOCK() ;
 L +^PXRMD(801.41):0 I  Q 1
 E  W !,"Another user is editing this file, try later" H 2
 Q 0
 ;
 ;Clear lock
UNLOCK L -^PXRMD(801.41)
 Q
