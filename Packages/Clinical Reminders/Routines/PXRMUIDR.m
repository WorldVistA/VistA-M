PXRMUIDR ;SLC/PKR - Taxonomy Use In Dialog report routines. ;03/01/2013
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;==========================================
REPD ;Inactive UID report driver.
 N DIR0,NLINES,OUTPUT,TITLE
 D REPTEXT(.NLINES,.OUTPUT)
 S TITLE="Inactive UID Report as of "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 D BROWSE^DDBR("OUTPUT","NR",TITLE)
 I $D(VALMDDF) S VALMBCK="R"
 Q
 ;
 ;==========================================
REPTEXT(NLINES,OUTPUT) ;Create inactive UID report text.
 N ACTDT,BDESC,CODE,CODESYS,CODESYSN,FMTSTR,IEN,INACTDT,IND,LC
 N NAME,NCS,NOUT,TEXT,TEXTOUT
 K ^TMP("PXRMUIDR",$J)
 S FMTSTR="10L1^10C4^45L"
 S IEN=0
 F  S IEN=+$O(^PXD(811.2,IEN)) Q:IEN=0  D
 . S NAME=$P(^PXD(811.2,IEN,0),U,1)
 . S CODESYS=""
 . F  S CODESYS=$O(^PXD(811.2,IEN,20,"AUID",CODESYS)) Q:CODESYS=""  D
 .. S CODE=""
 .. F  S CODE=$O(^PXD(811.2,IEN,20,"AUID",CODESYS,CODE)) Q:CODE=""  D
 ... S ACTDT=$O(^PXD(811.2,IEN,20,"AUID",CODESYS,CODE,""),-1)
 ... S INACTDT=$O(^PXD(811.2,IEN,20,"AUID",CODESYS,CODE,ACTDT,""),-1)
 ... I (INACTDT>DT)!(INACTDT="DT") Q
 ... S ^TMP("PXRMUIDR",$J,NAME,CODESYS,CODE,INACTDT)=$P(^PXD(811.2,IEN,20,"AUID",CODESYS,CODE,ACTDT,INACTDT),U,2)
 . I $D(^TMP("PXRMUIDR",$J,NAME)) S ^TMP("PXRMUIDR",$J,NAME)=IEN
 ;Create the text.
 S OUTPUT(1)="The following taxonomies contain the listed inactive codes which are marked as"
 S OUTPUT(2)="Use in Dialog:"
 S OUTPUT(3)=""
 S LC=3,NAME=""
 F  S NAME=$O(^TMP("PXRMUIDR",$J,NAME)) Q:NAME=""  D
 . S IEN=^TMP("PXRMUIDR",$J,NAME)
 . I LC>3 S LC=LC+1,OUTPUT(LC)=""
 . S LC=LC+1,OUTPUT(LC)="Taxonomy: "_NAME_" (IEN="_IEN_")"
 . S CODESYS="",NCS=0
 . F  S CODESYS=$O(^TMP("PXRMUIDR",$J,NAME,CODESYS)) Q:CODESYS=""  D
 .. S NCS=NCS+1
 ..;DBIA #5679
 .. I '$D(CODESYSN(CODESYS)) S CODESYSN(CODESYS)=$P($$CSYS^LEXU(CODESYS),U,4)
 .. I NCS>1 S LC=LC+1,OUTPUT(LC)=""
 .. S LC=LC+1,OUTPUT(LC)=" Coding system: "_CODESYSN(CODESYS)
 .. S LC=LC+1,OUTPUT(LC)="Code       Inactivation  Brief Description"
 .. S LC=LC+1,OUTPUT(LC)="---------  ------------  -----------------"
 .. S CODE=""
 .. F  S CODE=$O(^TMP("PXRMUIDR",$J,NAME,CODESYS,CODE)) Q:CODE=""  D
 ... S INACTDT=$O(^TMP("PXRMUIDR",$J,NAME,CODESYS,CODE,""))
 ... S BDESC=^TMP("PXRMUIDR",$J,NAME,CODESYS,CODE,INACTDT)
 ... S TEXT=CODE_U_$$FMTE^XLFDT(INACTDT,"5Z")_U_BDESC
 ... D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NOUT,.TEXTOUT)
 ... F IND=1:1:NOUT S LC=LC+1,OUTPUT(LC)=TEXTOUT(IND)
 ;If no text in addition to the header was created change the header.
 I LC=3 D
 . S OUTPUT(1)="No taxonomies containing inactive codes which are marked as Use in Dialog"
 . S OUTPUT(2)="were found."
 . S OUTPUT(3)=""
 S NLINES=LC
 K ^TMP("PXRMUIDR",$J)
 Q
 ;
