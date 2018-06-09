PXKWSRCH ;SLC/PKR - Keyword search routines. ;02/24/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;=====================================
CASESEN() ;Ask the user if the search is case sensitive.
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YA"
 S DIR("A")="Should the search be case-sensitive? "
 S DIR("B")="N"
 D ^DIR
 I $D(DIRUT) S Y="^"
 Q Y
 ;
 ;=====================================
DISPLAY(CASESEN,NKW,KEYWORD) ;Display the search results.
 N ENAME,FIELD,FILENUM,FLABEL,FNUM,GNAME,GNAMELST,IEN,IENS,IND
 N LABEL,LN,NIEN,NL,NM,TEMP,TEXT
 S NL=0
 S NL=NL+1,TEXT(NL)="The search was for the following keywords:"
 F IND=1:1:NKW S NL=NL+1,TEXT(NL)=" "_KEYWORD(IND)
 S FILENUM=""
 F  S FILENUM=$O(^TMP($J,"KWS",FILENUM)) Q:FILENUM=""  D
 . S GNAME=$$GET1^DID(FILENUM,"","","NAME")
 . S GNAMELST(GNAME,FILENUM)=""
 S GNAME=""
 F  S GNAME=$O(GNAMELST(GNAME)) Q:GNAME=""  D
 . I NL>1 S NL=NL+1,TEXT(NL)=""
 . S NL=NL+1,TEXT(NL)="File: "_GNAME
 . S FILENUM=$O(GNAMELST(GNAME,FILENUM))
 . S IEN="",NIEN=0
 . F  S IEN=$O(^TMP($J,"KWS",FILENUM,IEN)) Q:IEN=""  D
 .. S ENAME=$$GET1^DIQ(FILENUM,IEN,.01)
 .. S NIEN=NIEN+1
 .. I NIEN>1 S NL=NL+1,TEXT(NL)=""
 .. S NM=^TMP($J,"KWS",FILENUM,IEN)
 .. S NL=NL+1,TEXT(NL)=" Entry "_ENAME_" (IEN="_IEN_") contains "_NM_" match"_$S(NM>1:"es.",1:".")
 .. S FNUM=""
 .. F  S FNUM=$O(^TMP($J,"KWSIEN",FILENUM,IEN,FNUM)) Q:FNUM=""  D
 ... S IENS=""
 ... F  S IENS=$O(^TMP($J,"KWSIEN",FILENUM,IEN,FNUM,IENS)) Q:IENS=""  D
 .... S FIELD=""
 .... F  S FIELD=$O(^TMP($J,"KWSIEN",FILENUM,IEN,FNUM,IENS,FIELD)) Q:FIELD=""  D
 ..... I '$D(FLABEL(FNUM,FIELD)) S FLABEL(FNUM,FIELD)=$$FLABEL(FNUM,FIELD)
 ..... S NL=NL+1,TEXT(NL)="  Found in field "_FLABEL(FNUM,FIELD)_" the text is:"
 ..... S TEMP=$G(^TMP($J,"KWSIEN",FILENUM,IEN,FNUM,IENS,FIELD))
 ..... I TEMP'="" S NL=NL+1,TEXT(NL)="   "_$$HLITE(TEMP,CASESEN)
 ..... S LN=0
 ..... F  S LN=$O(^TMP($J,"KWSIEN",FILENUM,IEN,FNUM,IENS,FIELD,LN)) Q:LN=""  D
 ...... S TEMP=$G(^TMP($J,"KWSIEN",FILENUM,IEN,FNUM,IENS,FIELD,LN))
 ...... I TEMP'="" S NL=NL+1,TEXT(NL)="   "_$$HLITE(TEMP,CASESEN)
 I NL=(NKW+1) S NL=NL+1,TEXT(NL)="No matches were found."
 D BROWSE^DDBR("TEXT","ANR","Text/Keyword Search")
 K ^TMP($J,"KWS"),^TMP($J,"KWSIEN")
 Q
 ;
 ;=====================================
FLABEL(FNUM,FIELD) ;Return the label for a field.
 N DATA
 D FIELD^DID(FNUM,FIELD,"N","LABEL","DATA")
 Q DATA("LABEL")
 ;
 ;=====================================
GETFLIST(NSFILE,SFILE) ;Get the list of files to search.
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,FLIST,IND,LNUM,NFILES,X,Y
 S FLIST(1)="1. ^Education Topics^9999999.09^AUTTEDT"
 S FLIST(2)="2. ^Exam^9999999.15^AUTTEXAM"
 S FLIST(3)="3. ^Health Factors^9999999.64^AUTTHF"
 S FLIST(4)="4. ^Immunizations^9999999.14^AUTTIMM"
 S FLIST(5)="5. ^Skin Test^9999999.28^AUTTSK"
 S DIR(0)="LA^1:5"
 S DIR("A")="Select the files to search: "
 F IND=1:1:5 S DIR("A",IND)=$P(FLIST(IND),U,1)_$P(FLIST(IND),U,2)
 D EN^DDIOL("Select from the following list of files:")
 D ^DIR
 I Y["^"!$G(DIROUT) S NSFILE=0 Q
 S NSFILE=$L(Y,",")-1
 F IND=1:1:NSFILE D
 . S LNUM=$P(Y,",",IND)
 . S SFILE(IND)=$P(FLIST(LNUM),U,2,4)
 Q
 ;
 ;=====================================
GETKWS(CASESEN,NKW,KEYWORD) ;Have the user input the key words.
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S NKW=0
 D EN^DDIOL("Input the keywords, one per line. Enter NULL or '^' to exit.")
 S DIR(0)="FAOU^2:45"
 S DIR("A")="Input a keyword: "
 S DONE=0
 F  Q:DONE  D
 . D ^DIR
 . I (Y="^")!(Y="")!$G(DIROUT) S DONE=1 Q
 . S NKW=NKW+1
 . S KEYWORD(NKW)=$S(CASESEN:Y,1:$$UP^XLFSTR(Y))
 Q
 ;
 ;=====================================
GSEARCH ;Entry point for general selection of global to search.
 N CASESEN,DIC,FILENUM,FNAME,GBL,IEN,KEYWORD,NKW,X,Y
 ;Prompt the user for the file that want to search.
 S DIC=1,DIC(0)="AEMNV"
 S DIC("A")="Select a file to search: "
 D ^DIC
 I Y=-1 Q
 S FILENUM=$P(Y,U,1)
 S FNAME=$P(Y,U,2)
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 S GBL=$$CREF^DILF(GBL)
 ;Prompt for case-sensitive.
 S CASESEN=$$CASESEN
 I CASESEN["^" Q
 ;Get the list of keywords.
 D GETKWS(CASESEN,.NKW,.KEYWORD)
 I NKW=0 Q
 K ^TMP($J,"KWS"),^TMP($J,"KWSIEN")
 D EN^DDIOL("Searching "_FNAME_" ...")
 S IEN=0
 F  S IEN=+$O(@GBL@(IEN)) Q:IEN=0  D SRCHTEXT(FILENUM,IEN,CASESEN,NKW,.KEYWORD)
 D DISPLAY(CASESEN,NKW,.KEYWORD)
 Q
 ;
 ;=====================================
HLITE(TEXT,CASESEN) ;Mark the keyword so it will be highlighted in the Browser.
 N FIND,KEYWORD,HTEXT,LKW,MKEY,MTEXT,START,STOP,TAG,TAGBEG,TAGEND,TTEXT
 S TTEXT=$P(TEXT,U,1)
 S MTEXT=$S(CASESEN:TTEXT,1:$$UP^XLFSTR(TTEXT))
 S KEYWORD=$P(TEXT,U,2)
 S MKEY=$S(CASESEN:KEYWORD,1:$$UP^XLFSTR(KEYWORD))
 S LKW=$L(KEYWORD)
 S FIND=1,HTEXT="",START=1
 F  Q:FIND=0  D
 . S FIND=$F(MTEXT,MKEY,FIND)
 . I FIND=0 Q
 . S TAGBEG=FIND-LKW
 . S TAGEND=FIND-1
 . S STOP=TAGEND-LKW
 . S TAG="$.%^"_$E(TTEXT,TAGBEG,TAGEND)_"$.%"
 . S HTEXT=HTEXT_$E(TTEXT,START,STOP)_TAG
 . S START=FIND
 S HTEXT=HTEXT_$E(TTEXT,START,$L(TTEXT))
 Q HTEXT
 ;
 ;=====================================
SEARCH ;Perform the keyword search.
 N CASESEN,FILENUM,FNAME,IEN,IND,KEYWORD,NKW,NSFILE,SFILE
 D EN^DDIOL("Search PCE files for keywords.")
 ;Get the list of files to search.
 D GETFLIST(.NSFILE,.SFILE)
 I NSFILE=0 Q
 ;Prompt for case-sensitive.
 S CASESEN=$$CASESEN
 I CASESEN["^" Q
 ;Get the list of keywords.
 D GETKWS(CASESEN,.NKW,.KEYWORD)
 I NKW=0 Q
 K ^TMP($J,"KWS"),^TMP($J,"KWSIEN")
 F IND=1:1:NSFILE D
 . S FNAME=$P(SFILE(IND),U,1)
 . S FILENUM=$P(SFILE(IND),U,2)
 . S GBL="^"_$P(SFILE(IND),U,3)
 . D EN^DDIOL("Searching "_FNAME_" ...")
 . S IEN=0
 . F  S IEN=+$O(@GBL@(IEN)) Q:IEN=0  D SRCHTEXT(FILENUM,IEN,CASESEN,NKW,.KEYWORD)
 D DISPLAY(CASESEN,NKW,.KEYWORD)
 Q
 ;
 ;=====================================
SRCHTEXT(FILENUM,IEN,CASESEN,NKW,KEYWORD) ;Search the text of an entry.
 N DIQOUT,IENS,IND,FIELD,FNUM,LABEL,LN,MSG,MTEMP,NM,TEMP
 D GETS^DIQ(FILENUM,IEN,"**","N","DIQOUT","MSG")
 S FNUM="",NM=0
 F  S FNUM=$O(DIQOUT(FNUM)) Q:FNUM=""  D
 . S IENS=""
 . F  S IENS=$O(DIQOUT(FNUM,IENS)) Q:IENS=""  D
 .. S FIELD=""
 .. F  S FIELD=$O(DIQOUT(FNUM,IENS,FIELD)) Q:FIELD=""  D
 ... S TEMP=DIQOUT(FNUM,IENS,FIELD)
 ... S MTEMP=$S(CASESEN:TEMP,1:$$UP^XLFSTR(TEMP))
 ... F IND=1:1:NKW I MTEMP[KEYWORD(IND) D
 .... S ^TMP($J,"KWSIEN",FILENUM,IEN,FNUM,IENS,FIELD)=TEMP_U_KEYWORD(IND)
 .... S NM=NM+1
 ... S LN=""
 ... F  S LN=$O(DIQOUT(FNUM,IENS,FIELD,LN)) Q:LN=""  D
 .... ;S TEMP=DIQOUT(FNUM,IENS,FIELD)
 .... S TEMP=DIQOUT(FNUM,IENS,FIELD,LN)
 .... S MTEMP=$S(CASESEN:TEMP,1:$$UP^XLFSTR(TEMP))
 .... F IND=1:1:NKW I MTEMP[KEYWORD(IND) D
 ..... S ^TMP($J,"KWSIEN",FILENUM,IEN,FNUM,IENS,FIELD,LN)=TEMP_U_KEYWORD(IND)
 ..... S NM=NM+1
 I NM>0 S ^TMP($J,"KWS",FILENUM,IEN)=NM
 Q
 ;
