PXRMEXLI ; SLC/PKR - List Manager routines for repository entry install. ;03/30/2009
 ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
 ;
 ;================================================
EXIT ;Cleanup ^TMP arrays.
 K ^TMP("PXRMEXLC",$J),^TMP("PXRMEXTMP",$J),^TMP("PXRMEXFND",$J)
 Q
 ;
 ;================================================
INSALL ;Install all components in a repository entry.
 N IND,INSTALL
 ;Initialize the name change storage.
 K PXRMNMCH
 S (IND,INSTALL,PXRMDONE)=0
 F  S IND=$O(^TMP("PXRMEXLC",$J,"SEL",IND)) Q:(+IND=0)!(PXRMDONE)  D
 . D INSCOM(IND,.INSTALL)
 ;
 ;If anything was installed rebuild the display.
 I INSTALL D CDISP^PXRMEXLC(PXRMRIEN)
 ;
 ;Save the install history in the repository.
 D SAVHIST^PXRMEXU1
 Q
 ;
 ;================================================
INSCOM(IND,INSTALL) ;Install component IND.
 ;PXRMRIEN is not passed because this is invoked by the ListManger
 ;action to install a repository entry.
 N ACTION,ATTR,END,EXISTS,FIELDNUM,FILENUM,IND120,JND120
 N NEWNAME,NEWPT01,PT01,RTN,START,TEMP,TEMP0
 S TEMP=^TMP("PXRMEXLC",$J,"SEL",IND)
 S FILENUM=$P(TEMP,U,1)
 S IND120=$P(TEMP,U,2)
 S JND120=$P(TEMP,U,3)
 S EXISTS=$P(TEMP,U,4)
 ;Dialogs use their own installation screen.
 I FILENUM=801.41 D  Q
 . D DBUILD^PXRMEXLB(PXRMRIEN,IND120,JND120)
 . D START^PXRMEXLD
 . S VALMBCK="R"
 S TEMP=^PXD(811.8,PXRMRIEN,120,IND120,1,JND120,0)
 S START=$P(TEMP,U,2)
 S END=$P(TEMP,U,3)
 S TEMP=^PXD(811.8,PXRMRIEN,100,START,0)
 ;Go to full screen mode.
 D FULL^VALM1
 I ((FILENUM=0)!(FILENUM=811.4)),DUZ(0)'="@" D  Q
 . I FILENUM=0 W !,"Only programmers can install routines."
 . I FILENUM=811.4 W !,"Only programmers can install Reminder Computed Findings."
 . H 2
 . S VALMBCK="R"
 I FILENUM=0 D
 . D RTNLD^PXRMEXIC(PXRMRIEN,START,END,.ATTR,.RTN)
 . D CHECKSUM^PXRMEXCS(.ATTR,START,END)
 . S ACTION=$$GETRACT^PXRMEXCF(.ATTR,.NEWNAME,.PXRMNMCH,.RTN,EXISTS)
 .;Save what was done for the installation summary.
 . S ^TMP("PXRMEXIA",$J,IND,"ROUTINE",ATTR("NAME"),ACTION)=NEWNAME
 E  D
 .;Make sure we have the .01, some files have .001.
 . S TEMP0=$P(TEMP,";",3)
 . S FIELDNUM=$P(TEMP0,"~",1)
 . I FIELDNUM=.001 S TEMP=^PXD(811.8,PXRMRIEN,100,(START+1),0)
 . S PT01=$P(TEMP,"~",2)
 . D SETATTR^PXRMEXFI(.ATTR,FILENUM,PT01)
 . D CHECKSUM^PXRMEXCS(.ATTR,START,END)
 . S ACTION=$$GETFACT^PXRMEXFI(PT01,.ATTR,.NEWPT01,.PXRMNMCH,EXISTS)
 .;Save what was done for the installation summary.
 . S ^TMP("PXRMEXIA",$J,IND,ATTR("FILE NAME"),ATTR("PT01"),ACTION)=NEWPT01
 ;If the ACTION is Quit then quit the entire install.
 I ACTION="Q" S PXRMDONE=1 Q
 ;If the ACTION is Skip then skip this component.
 I ACTION="S" S VALMBCK="R" Q
 ;If the ACTION is rePlace then skip this component.
 I ACTION="P" S VALMBCK="R" Q
 ;Install this component.
 I FILENUM=0 D
 . S NEWPT01=$G(PXRMNMCH(ATTR("FILE NUMBER"),ATTR("NAME")))
 . I NEWPT01="" S NEWPT01=ATTR("NAME")
 . D RTNSAVE^PXRMEXIC(.RTN,NEWPT01)
 . S INSTALL=1
 E  D
 . D FILE^PXRMEXIC(PXRMRIEN,EXISTS,IND120,JND120,ACTION,.ATTR,.PXRMNMCH)
 . S INSTALL=1
 S VALMBCK="R"
 Q
 ;
 ;================================================
INSSEL ;Get a list of components to install.
 N IND,INSTALL,VALMBG,VALMLST,VALMY
 ;
 S VALMBG=1,VALMLST=+$O(^TMP("PXRMEXLC",$J,"IDX",""),-1)
 ;
 ;Get the list to install.
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 ;
 K ^TMP("PXRMEXIA",$J),^TMP("PXRMEXIAD",$J)
 ;
 ;Initialize the name change storage.
 K PXRMNMCH
 S (IND,INSTALL)=0
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D INSCOM(IND,.INSTALL)
 ;
 ;If anything was installed rebuild the display.
 I INSTALL D CDISP^PXRMEXLC(PXRMRIEN)
 ;
 ;Save the install history in the repository.
 D SAVHIST^PXRMEXU1
 Q
 ;
 ;================================================
INSTALL ;Install the repository entry PXRMRIEN.
 N CLOK,IEN,IND,VALMY
 ;Make sure the component list exists for this entry. PXRMRIEN is
 ;set in INSTALL^PXRMEXLR.
 S CLOK=1
 I '$D(^PXD(811.8,PXRMRIEN,120)) D CLIST^PXRMEXCO(PXRMRIEN,.CLOK)
 I 'CLOK Q
 ;Format the component list for display.
 D CDISP^PXRMEXLC(PXRMRIEN)
 S VALMCNT=$O(^TMP("PXRMEXLC",$J,"IDX"),-1)
 S VALMBCK="R"
 D XQORM
 Q
 ;
 ;================================================
 ;Exit action added to PXRM EXCH INSTALL MENU
PEXIT ;PXRM EXCH INSTALL MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
 ;================================================
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM EXCH SELECT COMPONENT",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Action: "
 Q
 ;
 ;================================================
XSEL ;PXRM EXCH SELECT COMPONENT validation
 N CNT,SELECT,SEL,PXRMDONE
 S SELECT=$P(XQORNOD(0),"=",2)
 I '$$VALID^PXRMEXLD(SELECT) S VALMBCK="R" Q
 ;
 ;Sort selections into ascending sequence order
 D ORDER^PXRMEXLC(.SELECT,1)
 ;
 K ^TMP("PXRMEXIA",$J),^TMP("PXRMEXIAD",$J)
 ;
 ;Install selected component
 N INSTALL
 S INSTALL=0,CNT=0,PXRMDONE=0
 F CNT=1:1 S SEL=$P(SELECT,",",CNT) Q:'SEL  D  Q:PXRMDONE
 . D INSCOM(SEL,.INSTALL)
 ;
 ;If anything was installed rebuild the display.
 I INSTALL D CDISP^PXRMEXLC(PXRMRIEN)
 ;
 ;Save the install history in the repository.
 D SAVHIST^PXRMEXU1
 ;
 ;Clear any renames made in the last session
 K PXRMNMCH
 Q
 ;
