PXRMPTDF ; SLC/PKR/PJH - Reminder Inquiry print template routines. ;03/16/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ;
 ;================================================
PFIND ;Print the reminder definition finding multiple.
 N DIWF,FIELD,FILENUM,FINDING,FIND0,FIND3,FINDNAM,FL,HFCAT,HFIEN
 N IEN1,IND,INT,LEN,NL,OUTPUT,PAD,PADS,PARRAY
 N RJC,RFIND,RTERM,SCNT,SIEN,STAT0,TEMP,X
 ;If called by a FileMan print build the variable pointer list.
 I '$D(PXRMFVPL) N PXRMFVPL D BLDRLIST^PXRMVPTR(811.902,.01,.PXRMFVPL)
 ;No printing is done by PFIND it accumulates all output using ^DIWP.
 ;The print template outputs the text with ^DIWW.
 ;Because of the way DIWP works we need to format all the found and
 ;not found text first and store it in ^TMP.
 K ^TMP($J,"W")
 S FILENUM="811.902"
 S RJC=30,PAD=" ",PADS=""
 F IND=1:1:(RJC+2) S PADS=PADS_PAD
 S FINDING=0
 F  S FINDING=$O(^PXD(811.9,D0,20,FINDING)) Q:+FINDING=0  D
 .D WPFORMAT(FINDING,20,RJC,1)
 .D WPFORMAT(FINDING,20,RJC,2)
 K ^UTILITY($J,"W")
 S FINDING=0
 F  S FINDING=$O(^PXD(811.9,D0,25,FINDING)) Q:+FINDING=0  D
 . D WPFORMAT(FINDING,25,RJC,1)
 . D WPFORMAT(FINDING,25,RJC,2)
 S DIWF="C80",DIWL=2
 K ^UTILITY($J,"W")
 S FINDING=0
 F  S FINDING=$O(^PXD(811.9,D0,20,FINDING)) Q:+FINDING=0  D
 . S FIND0=^PXD(811.9,D0,20,FINDING,0)
 . S FIELD=$P(FIND0,U,1)
 . S RTERM=FIELD
 . S X=" "
 . D ^DIWP
 . S FINDNAM=$$ENTRYNAM^PXRMPTD2(FIELD)
 . I FINDNAM="" S FINDNAM="?"
 . S RFIND=$$GENIEN^PXRMPTD2(FINDING)
 . S X="---- Begin: "_FINDNAM_RFIND
 . D FORMATS^PXRMTEXT(2,75,X,.NL,.OUTPUT)
 . F IND=1:1:NL D
 .. S X=OUTPUT(IND)
 .. I IND=NL S X=X_" ",LEN=75-$L(X) F INT=1:1:LEN S X=X_"-"
 .. D ^DIWP
 .;
 . S X=$$RJ^XLFSTR("Finding Type:",RJC,PAD)
 . S X=X_" "_$$FTYPE^PXRMPTD2(FIELD,0)
 . D ^DIWP
 . I RFIND["HF" D
 .. S HFIEN=$P($P($P(RFIND,"HF",2),"(",2),")")
 .. S HFCAT=$P($G(^AUTTHF(HFIEN,0)),U,3)
 .. S HFCAT=$S(HFCAT="":"UNDEFINED",1:$P($G(^AUTTHF(HFCAT,0)),U,1))
 .. S X=$$RJ^XLFSTR("Health Factor Category:",RJC,PAD)
 .. S X=X_" "_HFCAT
 .. D ^DIWP
 .;
 . S FIELD=$P(FIND0,U,4)
 . I $L(FIELD)>0 D
 .. S X=$$RJ^XLFSTR("Match Frequency/Age:",RJC,PAD)
 .. S X=X_" "_$$GENFREQ^PXRMPTD2(FIND0)
 .. D ^DIWP
 .;
 . D SFDISP(FIND0,5,6,"Rank Frequency:",RJC,PAD,FILENUM)
 . D SFDISP(FIND0,6,7,"Use in Resolution Logic:",RJC,PAD,FILENUM)
 . D SFDISP(FIND0,7,8,"Use in Patient Cohort Logic:",RJC,PAD,FILENUM)
 . D DATE^PXRMPTD2(FIND0,8,9,"Beginning Date/Time:",RJC,PAD,FILENUM)
 . D DATE^PXRMPTD2(FIND0,11,12,"Ending Date/Time:",RJC,PAD,FILENUM)
 . D SFDISP(FIND0,14,17,"Occurrence Count:",RJC,PAD,FILENUM)
 . D SFDISP(FIND0,9,10,"Use Inactive Problems:",RJC,PAD,FILENUM)
 . D SFDISP(FIND0,10,11,"Within Category Rank:",RJC,PAD,FILENUM)
 . D SFDISP(FIND0,16,28,"Include Visit Data:",RJC,PAD,FILENUM)
 . D SFDISP(FIND0,12,13,"MH Scale:",RJC,PAD,FILENUM)
 . D SFDISP(FIND0,13,16,"Rx Type:",RJC,PAD,FILENUM)
 . D SFDISP(FIND0,15,27,"Use Start Date:",RJC,PAD,FILENUM)
 . I $D(^PXD(811.9,D0,20,FINDING,5,0))=1 D
 .. S (SCNT,SIEN)=0
 .. F  S SIEN=$O(^PXD(811.9,D0,20,FINDING,5,SIEN)) Q:SIEN=""  D
 ... S STAT0=$G(^PXD(811.9,D0,20,FINDING,5,SIEN,0))
 ... D STATUS(STAT0,"Status List:",RJC) S SCNT=SCNT+1
 . S FIND0=$G(^PXD(811.9,D0,20,FINDING,3))
 . D SFDISP(FIND0,1,14,"Condition:",RJC,PAD,FILENUM)
 . D SFDISP(FIND0,2,15,"Condition Case Sensitive:",RJC,PAD,FILENUM)
 . D SFDISP(FIND0,3,18,"Use Status/Cond in Search:",RJC,PAD,FILENUM)
 . I $G(^PXD(811.9,D0,20,FINDING,15))'="" D 
 .. S X=$$RJ^XLFSTR("Computed Finding Parameter:",RJC,PAD)
 .. S X=X_" "_$G(^PXD(811.9,D0,20,FINDING,15))
 .. D ^DIWP
 . D WPOUT(FINDING,20,"Found Text:",RJC,PAD,PADS,1)
 . D WPOUT(FINDING,20,"Not Found Text:",RJC,PAD,PADS,2)
 . I RTERM["PXRMD(811.5" S IEN1=$P(RTERM,";") D RTERM
 . S X="---- End: "_FINDNAM
 . D FORMATS^PXRMTEXT(2,75,X,.NL,.OUTPUT)
 . F IND=1:1:NL D
 .. S X=OUTPUT(IND)
 .. I IND=NL S X=X_" ",LEN=75-$L(X) F INT=1:1:LEN S X=X_"-"
 .. D ^DIWP
 ;
 ;Function Findings
 I +$P($G(^PXD(811.9,D0,25,0)),U,4)>0 D
 . S X=" "
 . D ^DIWP
 . S X="Function Findings:"
 . D ^DIWP
 .;Build the list of findings for this reminder.
 . D BLDFLST^PXRMPTL(D0,.FL)
 . S FILENUM="811.925",FINDING=0
 . F  S FINDING=$O(^PXD(811.9,D0,25,FINDING)) Q:+FINDING=0  D
 .. S FIND0=$G(^PXD(811.9,D0,25,FINDING,0))
 .. S FIND3=$G(^PXD(811.9,D0,25,FINDING,3))
 .. I FIND3="" Q
 .. S FIELD=$P(FIND0,U,1)
 .. S FINDNAM="FF("_FIELD_")"
 .. S X=" "
 .. D ^DIWP
 .. S X=$$RJ^XLFSTR("---- Begin:",12,PAD)
 .. S X=X_" "_FINDNAM
 .. S LEN=(75-$L(X))
 .. F INT=1:1:LEN S X=X_"-"
 .. D ^DIWP
 ..;
 .. D SFDISP(FIND3,1,3,"Function String:",RJC,PAD,FILENUM)
 .. S X="     Expanded Function String:" D ^DIWP
 .. D DISLOGF^PXRMPTL(D0,FINDING,.FL,.PARRAY)
 .. S INT=0
 .. F  S INT=$O(PARRAY(INT)) Q:'INT  D
 ... S X=$J("",6)_PARRAY(INT) D ^DIWP
 ..;
 .. S FIELD=$P(FIND0,U,4)
 .. I $L(FIELD)>0 D
 ... S X=$$RJ^XLFSTR("Match Frequency/Age:",RJC,PAD)
 ... S X=X_" "_$$GENFREQ^PXRMPTD2(FIND0)
 ... D ^DIWP
 ..;
 .. D SFDISP(FIND0,5,10,"Rank Frequency:",RJC,PAD,FILENUM)
 .. D SFDISP(FIND0,6,11,"Use in Resolution Logic:",RJC,PAD,FILENUM)
 .. D SFDISP(FIND0,7,12,"Use in Patient Cohort Logic:",RJC,PAD,FILENUM)
 ..;
 .. D WPOUT(FINDING,25,"Found Text:",RJC,PAD,PADS,1)
 .. D WPOUT(FINDING,25,"Not Found Text:",RJC,PAD,PADS,2)
 .. S X=$$RJ^XLFSTR("---- End:",10,PADS)
 .. S X=X_" "_FINDNAM_" "
 .. S LEN=(75-$L(X))
 .. F INT=1:1:(LEN) S X=X_"-"
 .. D ^DIWP
 .. S X=" "
 .. D ^DIWP
 ;
 K ^TMP($J,"W")
 ;^UTILITY($J,"W") will be killed by ^DIWW in the print template.
 Q
 ;
 ;================================================
RTERM ;Reminder Term
 N CNT,RJT,SCNT,SIEN,STAT0,TERM,TERM3,TERMNUM,TERMS
 S CNT=0,RJT=RJC+5,TERMNUM="811.52",TERMS=0
  F  S TERMS=$O(^PXRMD(811.5,IEN1,20,TERMS)) Q:+TERMS=0  D
 .S TERM=$G(^PXRMD(811.5,IEN1,20,TERMS,0))
 .S TERM3=$G(^PXRMD(811.5,IEN1,20,TERMS,3))
 .D SFDISP(TERM,1,.01,"Mapped Finding Item:",RJT,PAD,TERMNUM,CNT)
 .D SFDISP(TERM,8,9,"Beginning Date/Time:",RJT,PAD,TERMNUM)
 .D SFDISP(TERM,9,10,"Use Inactive Problems:",RJT,PAD,TERMNUM)
 .D SFDISP(TERM,11,12,"Ending Date/Time:",RJT,PAD,TERMNUM)
 .D SFDISP(TERM,10,11,"Within Category Rank:",RJT,PAD,TERMNUM)
 .D SFDISP(TERM,12,13,"MH Scale:",RJT,PAD,TERMNUM)
 .D SFDISP(TERM,13,16,"RX Type:",RJT,PAD,TERMNUM)
 .D SFDISP(TERM,14,17,"Occurrence Count:",RJT,PAD,TERMNUM)
 .I $D(^PXRMD(811.5,IEN1,20,TERMS,5,0))=1 D
 ..S (SCNT,SIEN)=0
 ..F  S SIEN=$O(^PXRMD(811.5,IEN1,20,TERMS,5,SIEN)) Q:SIEN=""  D
 ...S STAT0=$G(^PXRMD(811.5,IEN1,20,TERMS,5,SIEN,0))
 ...D STATUS(STAT0,"Status List:",RJT) S SCNT=SCNT+1
 .D SFDISP(TERM3,1,14,"Condition:",RJT,PAD,TERMNUM,1)
 .D SFDISP(TERM3,2,15,"Condition Case Sensitive:",RJT,PAD,TERMNUM)
 .D SFDISP(TERM3,3,18,"Use Status/Cond in Search:",RJT,PAD,TERMNUM)
 .I $G(^PXRMD(811.5,IEN1,20,TERMS,15))'="" D 
 ..S X=$$RJ^XLFSTR("Computed Finding Parameter:",RJT,PAD)
 ..S X=X_" "_$G(^PXRMD(811.5,IEN1,20,TERMS,15))
 ..D ^DIWP
 .S X=""
 .D ^DIWP
 .S CNT=CNT+1
 I CNT=0 D  Q
 .S X=$$RJ^XLFSTR("RT Mapped Finding:",RJC,PAD)
 .S X=X_" No Reminder Finding Found"
 .D ^DIWP
 Q
 ;
 ;================================================
SFDISP(FIND0,PIECE,FLDNUM,TITLE,RJC,PAD,FILENUM,FLG) ;Standard finding
 ;multiple field display.
 N FIELD,FMTSTR,HFCAT,HFIEN,IND,OUTPUT,NAME,NL,TYPE,X
 S FMTSTR=RJC_"R1^35L"
 S NAME=""
 S FIELD=$P(FIND0,U,PIECE)
 I (FILENUM="811.52"),(FLDNUM=".01"),(PIECE=1) D
 .I FLG=0 D
 ..S X="" D ^DIWP
 ..S RTERM=$P($P(RFIND,"=",2),")")_")"
 .S TYPE=$$FTYPE^PXRMPTD2(FIELD,1),NAME=$$ENTRYNAM^PXRMPTD2(FIELD)
 .S X="Mapped Findings:^"_TYPE_"."_NAME
 .D COLFMT^PXRMTEXT(FMTSTR,X,PAD,.NL,.OUTPUT)
 .F IND=1:1:NL S X=OUTPUT(IND) D ^DIWP
 .I TYPE="HF" D
 ..S HFIEN=$P(TERM,";")
 ..S HFCAT=$P($G(^AUTTHF(HFIEN,0)),U,3)
 ..S HFCAT=$P($G(^AUTTHF(HFCAT,0)),U)
 ..S X=$$RJ^XLFSTR("Health Factor Category:",RJC,PAD)
 ..S X=X_" "_HFCAT
 ..D ^DIWP
 I NAME'="" Q
 I $L(FIELD)>0 D
 .S X=$$RJ^XLFSTR(TITLE,RJC,PAD)
 .S X=X_" "_$$EXTERNAL^DILFD(FILENUM,FLDNUM,"",FIELD,"")
 .I FLDNUM=13 S X=X_" - "_$$SPECIAL(FIND0,FIELD)
 .D ^DIWP
 Q
 ;
 ;================================================
SPECIAL(FIND0,FIELD) ;Special output for certain fields.
 N FINDING,GLOBAL,IEN
 S FINDING=$P(FIND0,U,1)
 S IEN=$P(FINDING,";",1)
 S GLOBAL=$P(FINDING,";",2)
 I GLOBAL="YTT(601.71," Q $$SCNAME^PXRMMH(IEN,FIELD)
 Q ""
 ;
 ;================================================
STATUS(STAT0,TITLE,SPACE) ;
 I $L(STAT0)>0 D
 .I SCNT=0 S X=$$RJ^XLFSTR(TITLE,SPACE,PAD)
 .I SCNT>0 S X=$$RJ^XLFSTR("",SPACE,PAD)
 .S X=X_" "_STAT0
 .D ^DIWP
 Q
 ;
 ;================================================
WPFORMAT(FINDING,NODE,RJC,INDEX) ;Format found/not found word processing text.
 I '$D(^PXD(811.9,D0,NODE,FINDING,INDEX,1,0)) Q
 ;Save the title using the current format for DIWP.
 N DIWF,DIWL,DIWR,IND,NLINES,SC,X
 K ^UTILITY($J,"W")
 S DIWF="|",DIWL=RJC+2,DIWR=78
 S IND=0
 F  S IND=$O(^PXD(811.9,D0,NODE,FINDING,INDEX,IND)) Q:+IND=0  D
 .S X=$G(^PXD(811.9,D0,NODE,FINDING,INDEX,IND,0))
 .D ^DIWP
 ;Find where this stuff went.
 S SC=$O(^UTILITY($J,"W",""))
 ;Save into ^TMP.
 S NLINES=^UTILITY($J,"W",SC)
 S ^TMP($J,"W",FINDING,NODE,INDEX)=NLINES
 F IND=1:1:NLINES D
 .S ^TMP($J,"W",FINDING,NODE,INDEX,IND)=^UTILITY($J,"W",SC,IND,0)
 K ^UTILITY($J,"W")
 Q
 ;
 ;================================================
WPOUT(FINDING,NODE,TITLE,RJC,PAD,PADS,INDEX) ;Output found/not found word processing
 ;text.
 I $D(^TMP($J,"W",FINDING,NODE,INDEX)) D
 .N IND,X
 .S X=$$RJ^XLFSTR(TITLE,RJC,PAD)_" "_^TMP($J,"W",FINDING,NODE,INDEX,1)
 .D ^DIWP
 .F IND=2:1:^TMP($J,"W",FINDING,NODE,INDEX) D
 ..S X=PADS_^TMP($J,"W",FINDING,NODE,INDEX,IND)
 ..D ^DIWP
 Q
 ;
