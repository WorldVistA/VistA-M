PXRMEXLI ; SLC/PKR - List Manager routines for repository entry install. ;04/05/2018
 ;;2.0;CLINICAL REMINDERS;**6,12,42**;Feb 04, 2005;Build 80
 ;
 ;====================
EXIT ;Finish the install.
 D HFCAT
 ;Clean-up ^TMP.
 K ^TMP($J,"HFCAT"),^TMP("PXRMEXLC",$J),^TMP("PXRMEXTMP",$J),^TMP("PXRMEXFND",$J)
 Q
 ;
 ;====================
HFCAT ;Check for category health factors that need to be renamed or repointed.
 ;Category names must end with "[C]".
 N CEXISTS,CNAME,EXISTS,HFNAME,L3C,LEN,PXNAT,TEXT
 S PXNAT=$S($G(PXRMNAT)=1:1,1:0)
 S HFNAME=""
 F  S HFNAME=$O(^TMP($J,"HFCAT",HFNAME)) Q:HFNAME=""  D
 . S LEN=$L(NAME),L3C=$E(NAME,(LEN-2),LEN)
 . I L3C="[C]" Q
 . S CNAME=HFNAME_" [C]"
 . S CEXISTS=+$$EXISTS^PXRMEXIU(9999999.64,CNAME)
 . I CEXISTS D  Q
 .. D HFCLASS(CEXISTS,PXRMNAT)
 .. K TEXT
 .. S TEXT(1)=""
 .. S TEXT(2)="Changing pointers to category health factor "_HFNAME
 .. S TEXT(3)="to point to "_CNAME
 .. S TEXT(4)="and deleting "_HFNAME
 .. D MSG(.TEXT)
 .. D HFCRPT(HFNAME,CNAME)
 . K TEXT
 . S TEXT(1)=""
 . S TEXT(2)="Renaming category health factor "_HFNAME
 . S TEXT(3)="to "_CNAME
 . D MSG(.TEXT)
 . D RENAME^PXRMUTIL(9999999.64,HFNAME,CNAME)
 Q
 ;
 ;====================
HFCLASS(CIEN,PXRMNAT) ;Check the class of the category health factor and
 ;if PXNAT=1 make sure it is national.
 N CLASS
 S CLASS=$P(^AUTTHF(CIEN,100),U,1)
 I (PXRMNAT=1)&(CLASS="N") Q
 I PXRMNAT=1 S $P(^AUTTHF(CIEN,100),U,1)="N"
 Q
 ;
 ;====================
HFCRPT(HFNAME,CNAME) ;Repoint a category health factor.
 ;All health factors in a category.
 N FDA,HFIEN,IEN,IENS,MSG,TEXT
 S HFIEN=+$$EXISTS^PXRMEXIU(9999999.64,HFNAME)
 I HFIEN=0 Q
 S IEN=""
 F  S IEN=+$O(^AUTTHF("AC",HFIEN,IEN)) Q:IEN=0  D
 . K TEXT
 . S TEXT(1)=""
 . S TEXT(2)="Changing the category of health factor "_$P(^AUTTHF(IEN,0),U,1)
 . S TEXT(3)=" from "_HFNAME
 . S TEXT(4)=" to "_CNAME
 . D MSG(.TEXT)
 . S FDA(9999999.64,IEN_",",.03)=CNAME
 . D FILE^DIE("ET","FDA","MSG")
 . I $D(MSG) D
 .. K TEXT
 .. S TEXT(1)=""
 .. S TEXT(2)="There was an error changing the category"
 .. S TEXT(3)="the FileMan error message is:"
 .. D EN^DDIOL(.TEXT)
 .. D AWRITE^PXRMUTIL("MSG") H 3
 ;
 ;Health Summaries using the component PCE Health Factors Selected.
 D HSHFCAT(HFIEN,CNAME)
 ;
 ;Delete the original health factor.
 S FDA(9999999.64,HFIEN_",",.01)="@"
 D FILE^DIE("ET","FDA","MSG")
 I $D(MSG) D
 . K TEXT
 . S TEXT(1)=""
 . S TEXT(2)="There was an error deleting the category health factor:"
 . S TEXT(3)=HFNAME
 . S TEXT(4)="the FileMan error message is:"
 . D EN^DDIOL(.TEXT)
 . D AWRITE^PXRMUTIL("MSG") H 3
 Q
 ;
 ;====================
HSHFCAT(HFIEN,CNAME) ;Search the Health Summary Type file for Selection Items
 ;that match HFIEN and replace it with CNAME.
 ;are health factor categories.
 N D0,D1,D2,FDA,IENS,MSG,SELITEM,TEXT,VP
 S VP=HFIEN_";AUTTHF("
 S D0=0
 F  S D0=+$O(^GMT(142,D0)) Q:D0=0  D
 . S D1=0
 . F  S D1=+$O(^GMT(142,D0,1,D1)) Q:D1=0  D
 .. S D2=0
 .. F  S D2=+$O(^GMT(142,D0,1,D1,1,D2)) Q:D2=0  D
 ... I $P(^GMT(142,D0,1,D1,1,D2,0),U,1)'=VP Q
 ... S TEXT(1)=""
 ... S TEXT(2)="Changing Health Summary Type "_$P(^GMT(142,D0,0),U,1)_" Selection Item"
 ... S TEXT(3)=" from "_$P(^AUTTHF(HFIEN,0),U,1)
 ... S TEXT(4)=" to "_CNAME
 ... D MSG(.TEXT)
 ... ;S IENS=D0_","_D1_","_D2_","
 ... S IENS=D2_","_D1_","_D0_","
 ... S FDA(142.14,IENS,.01)=CNAME
 ... D FILE^DIE("ET","FDA","MSG")
 ... I '$D(MSG) Q
 ... K TEXT
 ... S TEXT(1)=""
 ... S TEXT(2)="There was an error changing the Selection Item"
 ... S TEXT(3)="the FileMan error message is:"
 ... D EN^DDIOL(.TEXT)
 ... D AWRITE^PXRMUTIL("MSG") H 3
 Q
 ;
 ;====================
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
 ;====================
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
 ;====================
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
 ;====================
INSTALL ;Install the repository entry PXRMRIEN.
 N CLOK,IEN,IND,VALMY
 ;Make sure the component list exists for this entry. PXRMRIEN is
 ;set in INSTALL^PXRMEXLR.
 S CLOK=1
 I '$D(^PXD(811.8,PXRMRIEN,120)) D CLIST^PXRMEXCO(PXRMRIEN,.CLOK)
 I 'CLOK Q
 ;Look for packing attributes and build the list if it does not exist.
 I '$D(^PXD(811.8,PXRMRIEN,140)) D PATTR^PXRMEXU1(PXRMRIEN)
 K ^TMP($J,"HFCAT")
 ;Format the component list for display.
 D CDISP^PXRMEXLC(PXRMRIEN)
 S VALMCNT=$O(^TMP("PXRMEXLC",$J,"IDX"),-1)
 S VALMBCK="R"
 D XQORM
 Q
 ;
 ;====================
MSG(TEXT) ;Display messages.
 D FULL^VALM1
 D EN^DDIOL(.TEXT)
 H 3
 S VALMBCK="R"
 Q
 ;
 ;====================
 ;Exit action added to PXRM EXCH INSTALL MENU
PEXIT ;PXRM EXCH INSTALL MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
 ;====================
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM EXCH SELECT COMPONENT",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Action: "
 Q
 ;
 ;====================
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
