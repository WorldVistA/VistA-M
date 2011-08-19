PXRMEXIH ; SLC/PKR - Routines for installation history. ;06/08/2009
 ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
 ;======================================================
BLDLIST ;Build a list of install histories in ^TMP("PXRMEXIH",$J).
 N DATE,FMTSTR,IHIEN,IND,INDONE,JND,NAME,NL,NLINE,NSEL,OUTPUT
 N SOURCE,TDATE,TEMP,TEXT,TYPE
 K ^TMP("PXRMEXIH",$J)
 S FMTSTR=$$LMFMTSTR^PXRMTEXT(.VALMDDF,"LLL")
 S (NLINE,NSEL,VALMCNT)=0
 S INDONE=+$P($G(^PXD(811.8,PXRMRIEN,130,0)),U,4)
 S TEMP=^PXD(811.8,PXRMRIEN,0)
 S NAME=" "_$P(TEMP,U,1)
 S SOURCE=$P(TEMP,U,2)
 S DATE=$P(TEMP,U,3)
 D FMT(NAME,SOURCE,DATE,FMTSTR,.NL,.OUTPUT)
 F JND=1:1:NL S NLINE=NLINE+1,^TMP("PXRMEXIH",$J,NLINE,0)=OUTPUT(JND)
 S FMTSTR="4R1^20L2^15L2^35L"
 S TEXT=" ^Installation Date^Type^Installed By"
 D COLFMT^PXRMTEXT(FMTSTR,TEXT,"  ",.NL,.OUTPUT)
 F JND=1:1:NL S NLINE=NLINE+1,^TMP("PXRMEXIH",$J,NLINE,0)=OUTPUT(JND)
 S TEXT=" ^-------------------^----^------------"
 D COLFMT^PXRMTEXT(FMTSTR,TEXT,"  ",.NL,.OUTPUT)
 F JND=1:1:NL S NLINE=NLINE+1,^TMP("PXRMEXIH",$J,NLINE,0)=OUTPUT(JND)
 I 'INDONE D  Q
 . S NLINE=NLINE+1
 . S ^TMP("PXRMEXIH",$J,NLINE,0)="      none"
 . S NLINE=NLINE+1
 . S ^TMP("PXRMEXIH",$J,NLINE,0)=" "
 . S VALMCNT=1
 ;Build the "dummy" lines so EN^VALM2 will work.
 F IND=1:1:NLINE S ^TMP("PXRMEXIH",$J,"IDX",IND,1)=""
 S DATE=""
 F  S DATE=$O(^PXD(811.8,PXRMRIEN,130,"B",DATE)) Q:DATE=""  D
 . S NSEL=NSEL+1
 . S IHIEN=$O(^PXD(811.8,PXRMRIEN,130,"B",DATE,""))
 . S TEMP=^PXD(811.8,PXRMRIEN,130,IHIEN,0)
 . S TDATE=$$FMTE^XLFDT($P(TEMP,U,1),"5Z")
 . S SOURCE=$P(TEMP,U,2)
 . S TYPE=$P(TEMP,U,3)
 . S TEXT=NSEL_U_TDATE_U_TYPE_U_SOURCE
 . D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NL,.OUTPUT)
 . F JND=1:1:NL D
 .. S NLINE=NLINE+1,^TMP("PXRMEXIH",$J,NLINE,0)=OUTPUT(JND)
 .. S ^TMP("PXRMEXIH",$J,"IDX",NLINE,NSEL)=""
 .. S ^TMP("PXRMEXIH",$J,"SEL",NSEL)=PXRMRIEN_U_IHIEN
 S NLINE=NLINE+1,^TMP("PXRMEXIH",$J,NLINE,0)=" "
 S VALMCNT=NLINE
 S ^TMP("PXRMEXIH",$J,"VALMCNT")=NLINE
 S ^TMP("PXRMEXIH",$J,"IDX",NLINE,NSEL)=""
 Q
 ;
 ;======================================================
DELETE(LIST) ;Delete the install histories on the list.
 N IHIEN,IND,RIEN,TEMP
 S IND=""
 F  S IND=$O(LIST(IND)) Q:IND=""  D
 . S TEMP=^TMP("PXRMEXIH",$J,"SEL",IND)
 . S RIEN=$P(TEMP,U,1)
 . S IHIEN=$P(TEMP,U,2)
 . D DELHIST^PXRMEXU1(RIEN,IHIEN)
 ;Rebuild the history list display.
 D BLDLIST
 S VALMBCK="R"
 Q
 ; 
 ;======================================================
DELHIST ;Get a list of repository installation entries and delete them.
 ;Save the original list, it contains the selected repository entries.
 N VALMBG,VALMLST,VALMY
 S VALMBG=1,VALMLST=+$O(^TMP("PXRMEXIH",$J,"IDX",""),-1)
 ;Get the list to delete.
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 D DELETE(.VALMY)
 Q
 ;
 ;======================================================
DETAILS ;Output the details of an installation.
 N VALMBG,VALMCNT,VALMLST,VALMY
 S VALMBG=1,VALMLST=+$O(^TMP("PXRMEXIH",$J,"IDX",""),-1)
 S VALMCNT=+$G(^TMP("PXRMEXIH",$J,"VALMCNT"))
 ;Get the list to display.
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 D DDISP(.VALMY)
 Q
 ;
 ;==================================================
DDISP(ARRAY) ;Display details list
 N ACTION,CAPTION,CMPNT,DI,DP,ENTRY,FMTSTR,IHIEN,IND,JND,KND
 N NL,NLINE,OUTPUT,RIEN,TEMP,TEXT,VALMCNT,VALMHDR
 K ^TMP("PXRMEXID",$J)
 ;If there are no items then quit.
 I '$D(ARRAY) Q
 S FMTSTR="4R1^34L2^6C2^34L"
 S VALMCNT=0
 S TEMP=^PXD(811.8,PXRMRIEN,0)
 S ENTRY=$E($P(TEMP,U,1),1,38)
 S DP=$$FMTE^XLFDT($P(TEMP,U,3),"5Z")
 ;CAPTION is used in ENTRY action of LM template
 S CAPTION="Entry: "_ENTRY_"  Date Packed: "_DP
 S (IND,NLINE)=0
 F  S IND=$O(ARRAY(IND)) Q:IND=""  D
 . S TEMP=^TMP("PXRMEXIH",$J,"SEL",IND)
 . S RIEN=$P(TEMP,U,1)
 . S IHIEN=$P(TEMP,U,2)
 . S DI=$$FMTE^XLFDT(^PXD(811.8,RIEN,130,IHIEN,0),"5Z")
 . I NLINE>1 D
 .. S NLINE=NLINE+1
 .. S ^TMP("PXRMEXID",$J,NLINE,0)="------------------------------------------------------------------------------"
 . S NLINE=NLINE+1
 . S ^TMP("PXRMEXID",$J,NLINE,0)="Installation date: "_DI
 .;Write the header line here.
 . S NLINE=NLINE+1
 . S ^TMP("PXRMEXID",$J,NLINE,0)="     Component                          Action  New Name"
 . S CMPNT=""
 . S JND=0
 . F  S JND=$O(^PXD(811.8,RIEN,130,IHIEN,1,JND)) Q:JND=""  D
 .. S TEMP=^PXD(811.8,RIEN,130,IHIEN,1,JND,0)
 .. I $P(TEMP,U,2)'=CMPNT D
 ... S NLINE=NLINE+1
 ... S ^TMP("PXRMEXID",$J,NLINE,0)=" "
 ... S CMPNT=$P(TEMP,U,2)
 ... S NLINE=NLINE+1
 ... S ^TMP("PXRMEXID",$J,NLINE,0)=CMPNT
 ..;The first piece is the component number in the packed reminder.
 .. S TEXT=$P(TEMP,U,1)_U_$P(TEMP,U,3,5)
 .. D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NL,.OUTPUT)
 .. F KND=1:1:NL S NLINE=NLINE+1,^TMP("PXRMEXID",$J,NLINE,0)=OUTPUT(KND)
 ..;If there are Additional Details add them to the display.
 .. S KND=0
 .. F  S KND=$O(^PXD(811.8,RIEN,130,IHIEN,1,JND,1,KND)) Q:KND=""  D
 ... S NLINE=NLINE+1
 ... S ^TMP("PXRMEXID",$J,NLINE,0)=^PXD(811.8,RIEN,130,IHIEN,1,JND,1,KND,0)
 . S NLINE=NLINE+1
 . S ^TMP("PXRMEXID",$J,NLINE,0)=" "
 S VALMHDR(1)=^PXD(811.8,RIEN,0)_"  "_^TMP("PXRMEXID",$J,1,0)
 S VALMCNT=NLINE
 D EN^VALM("PXRM EX INSTALLATION DETAIL")
 K ^TMP("PXRMEXID",$J)
 Q
 ;
 ;======================================================
ENTRY ;List Manager ENTRY entry point.
 D BLDLIST,XQORM
 Q
 ;
 ;======================================================
EXIT ;List Manager EXIT entry point.
 K ^TMP("PXRMEXIH",$J)
 Q
 ;
 ;======================================================
FMT(ENTRY,SOURCE,DATE,FMTSTR,NL,OUTPUT) ;
 N TEMP
 S TEMP=NAME_U_SOURCE
 S DATE=$$FMTE^XLFDT(DATE,"5Z")
 S TEMP=TEMP_U_DATE
 D COLFMT^PXRMTEXT(FMTSTR,TEMP," ",.NL,.OUTPUT)
 Q
 ;
 ;======================================================
HDR ;List Manager HEADER entry point.
 S VALMHDR(1)="Exchange File Entry History."
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;======================================================
HELP ;Help code
 W !,"Select DH to delete install histories."
 W !,"Select ID to see the details of an install."
 D PAUSE^VALM1
 Q
 ;
 ;======================================================
IHIST ;Get a list of repository entries and show their installation history.
 N PXRMRIEN,VALMCNT,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:IND=""  D
 . S PXRMRIEN=^TMP("PXRMEXLR",$J,"SEL",IND)
 . D EN^VALM("PXRM EX INSTALLATION HISTORY")
 S VALMBCK="R"
 Q
 ;
 ;=====================================================
PEXIT ;PXRM EXCH SELECT HISTORY protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
 ;======================================================
START ;Main entry point for installation history. The Exchange File IEN is
 ;PXRMRIEN.
 N VALMBCK,VALMCNT,VALMSG,X,XMZ,XQORM,XQORNOD
 S X="IORESET"
 D ENDR^%ZISS
 S VALMCNT=0
 D EN^VALM("PXRM EX INSTALLATION HISTORY")
 Q
 ;
 ;======================================================
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM EXCH SELECT HISTORY",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Action: "
 Q
 ;
 ;======================================================
XSEL ;PXRM EXCH SELECT HISTORY validation
 N ARRAY,CNT,SEL,SELECT
 S SELECT=$P(XQORNOD(0),"=",2)
 I '$$VALID^PXRMEXLD(SELECT) S VALMBCK="R" Q
 ;Build array of selected items
 F CNT=1:1 S SEL=$P(SELECT,",",CNT) Q:'SEL  S ARRAY(SEL)=""
 ;
 D FULL^VALM1
 ;
 ;Option to display installation details or delete install history.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,OPTION,X,Y
 S DIR(0)="SBM"_U_"DH:Delete Install History;"
 S DIR(0)=DIR(0)_"ID:Installation Details;"
 S DIR("A")="Select Action: "
 S DIR("B")="ID"
 S DIR("?")="Select from the codes displayed."
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S VALMBCK="R" Q
 I $D(DTOUT)!$D(DUOUT) S VALMBCK="R" Q
 S OPTION=Y
 ;
 ;Display installation details.
 I OPTION="ID" D DDISP(.ARRAY)
 ;
 ;Delete installation history.
 I OPTION="DH" D DELETE(.ARRAY)
 S VALMBCK="R"
 Q
 ;
