PXRMSINQ ;SLC/PKR - Reminder simple inquiry routines ;03/14/2013
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;===================================
BROWSE(FILENUM,FLDLIST,IEN) ;Display the details of an entry using the
 ;FileMan Browser.
 I '$$FIND1^DIC(FILENUM,"","AQU",IEN) Q
 N BOP,NL,OUTPUT,TITLE,X
 D GETTEXT(FILENUM,FLDLIST,IEN,.NL,.OUTPUT)
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="B" D
 . S X="IORESET"
 . D ENDR^%ZISS
 . S TITLE=$$GET1^DID(FILENUM,"","","NAME")_" INQUIRY for IEN="_IEN
 . D BROWSE^DDBR("OUTPUT","NR",TITLE)
 . W IORESET
 . D KILL^%ZISS
 I BOP="P" D GPRINT^PXRMUTIL("OUTPUT")
 Q
 ;
 ;===================================
CLBROWSE(FILENUM,FLDLIST,IEN) ;Display the details of an entry's Change
 ;Log using the FileMan Browser.
 I '$$FIND1^DIC(FILENUM,"","AQU",IEN) Q
 N BOP,NL,OUTPUT,TITLE,X
 D GETEH(FILENUM,FLDLIST,IEN,.NL,.OUTPUT)
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="B" D
 . S X="IORESET"
 . D ENDR^%ZISS
 . S TITLE=$$GET1^DID(FILENUM,"","","NAME")_" Change Log for IEN="_IEN
 . D BROWSE^DDBR("OUTPUT","NR",TITLE)
 . W IORESET
 . D KILL^%ZISS
 I BOP="P" D GPRINT^PXRMUTIL("OUTPUT")
 Q
 ;
 ;===================================
GETEH(FILENUM,FLDLST,IEN,NL,OUTPUT) ;Get the edit history.
 N IND,NLINES,TEXT
 D GETTEXT(FILENUM,FLDLST,IEN,.NLINES,.TEXT)
 I '$D(TEXT) S OUTPUT(1)="No edits have been made." Q
 S NL=0
 F IND=2:1:NLINES  D
 . I TEXT(IND)["Edit Date:" D  Q
 .. I NL>0 S NL=NL+1,OUTPUT(NL)=" "
 .. S NL=NL+1,OUTPUT(NL)=TEXT(IND+1)_" on"_$P(TEXT(IND),"Edit Date:",2)
 .. S IND=IND+1
 . I TEXT(IND)["Edit Comments" Q
 . S NL=NL+1,OUTPUT(NL)=TEXT(IND)
 Q
 ;
 ;===================================
GETTEXT(FILENUM,FLDLIST,IEN,NL,OUTPUT) ;Get the requested contents of an entry.
 ;FILENUM - file number
 ;IEN - internal entry number
 ;OUTPUT - array where text is returned.
 ;FLDLIST - a semicolon separated list of fields to include in the
 ;output. A piece can be a single field number, a range of fields
 ;in the form FM:FN, or a multiple in the form FN*. Each piece will
 ;be preceeded by a blank line. Example: ".01;10;15*;100:102"
 ;This will get the .01, a blank line and field 10, a blank line
 ;followed by the contents of multiple 15, a blank line followed by
 ;the contents of fields 100 through 102. 
 ;text in OUTPUT.
 N DIQOUT,IENS,IND,INDENT,FIELD,FLABEL,FLDIND,FLDNUM,FNUM,JND
 N MSG,MULT,NIN,NOUT,TEMP,TEXTIN,TEXTOUT,TITLE,WPF
 S NL=0
 F FLDIND=1:1:$L(FLDLIST,";") D
 . S FLDNUM=$P(FLDLIST,";",FLDIND)
 . K DIQOUT
 . D GETS^DIQ(FILENUM,IEN,FLDNUM,"N","DIQOUT","MSG")
 . I $D(DIQOUT)=0 Q
 .;Preceed each group of fields with a blank line.
 . I NL>0 S NL=NL+1,OUTPUT(NL)=" "
 . S FNUM="",MULT=0
 . F  S FNUM=$O(DIQOUT(FNUM)) Q:FNUM=""  D
 .. I FNUM'=FILENUM D
 ... S MULT=1
 ...;DBIA #4768
 ... S TEXTIN=$$TITLE^XLFSTR($O(^DD(FNUM,0,"NM","")))
 ... D FORMATS^PXRMTEXT(1,80,TEXTIN,.NOUT,.TEXTOUT)
 ... F IND=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(IND)
 .. S IENS=""
 .. F  S IENS=$O(DIQOUT(FNUM,IENS)) Q:IENS=""  D
 ... S FIELD=""
 ... F  S FIELD=$O(DIQOUT(FNUM,IENS,FIELD)) Q:FIELD=""  D
 .... S FLABEL=$$GET1^DID(FNUM,FIELD,"","LABEL")
 .... S FLABEL=$$TITLE^XLFSTR(FLABEL)
 ....;Check for a word-processing field.
 .... S TEMP=DIQOUT(FNUM,IENS,FIELD)
 .... S WPF=$S(TEMP["DIQOUT":1,1:0)
 .... I WPF D  Q
 ..... S NL=NL+1,OUTPUT(NL)=FLABEL_":"
 ..... S JND=0
 .....;Do not format word-processing fields so the original is displayed.
 ..... F  S JND=$O(DIQOUT(FNUM,IENS,FIELD,JND)) Q:JND=""  S NL=NL+1,OUTPUT(NL)=DIQOUT(FNUM,IENS,FIELD,JND)
 .... S TEXTIN=$$TITLE^XLFSTR(FLABEL)_": "_DIQOUT(FNUM,IENS,FIELD)
 .... S INDENT=$S(MULT:2,1:1)
 .... D FORMATS^PXRMTEXT(INDENT,80,TEXTIN,.NOUT,.TEXTOUT)
 .... F IND=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(IND)
 Q
 ;
 ;===================================
LMBROWSE(FILENUM,FLDLIST,IEN) ;Display the details of an entry using the
 ;FileMan Browser. For use by a ListManager application.
 I '$$FIND1^DIC(FILENUM,"","AQU",IEN) Q
 N BOP,NL,OUTPUT,TITLE
 D GETTEXT(FILENUM,FLDLIST,IEN,.NL,.OUTPUT)
 D FULL^VALM1
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="B" D
 . S TITLE=$$GET1^DID(FILENUM,"","","NAME")_" INQUIRY for IEN="_IEN
 . D BROWSE^DDBR("OUTPUT","NR",TITLE)
 I BOP="P" D
 . D GPRINT^PXRMUTIL("OUTPUT")
 . S VALMBCK="R"
 Q
 ;
 ;===================================
LMCLBROW(FILENUM,FLDLIST,IEN) ;Display the details of an entry's edit history
 ;using the FileMan Browser. For use by a ListManager application.
 I '$$FIND1^DIC(FILENUM,"","AQU",IEN) Q
 N BOP,NL,OUTPUT,TITLE
 D GETEH(FILENUM,FLDLIST,IEN,.NL,.OUTPUT)
 D FULL^VALM1
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="B" D
 . S TITLE=$$GET1^DID(FILENUM,"","","NAME")_" Change Log for IEN="_IEN
 . D BROWSE^DDBR("OUTPUT","NR",TITLE)
 I BOP="P" D
 . D GPRINT^PXRMUTIL("OUTPUT")
 . S VALMBCK="R"
 Q
 ;
 ;===================================
TEST(FILENUM,IEN) ;Test driver.
 N FLDLIST
 I FILENUM=801 S FLDLIST=".01;10;15*;20*;30*;100:102"
 I FILENUM=803 S FLDLIST=".01:15;30*;40*;45*;50*;100:102"
 I FILENUM=803.2 S FLDLIST=".01:5;20:24;100:102"
 I FILENUM=810.9 S FLDLIST=".01;1;40.7*;44*;100:102"
 D BROWSE(FILENUM,FLDLIST,IEN)
 Q
 ;
