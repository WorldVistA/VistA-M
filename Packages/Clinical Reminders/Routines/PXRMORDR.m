PXRMORDR ; SLC/PKR - Handle orderable item findings. ;07/14/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;=========================================================
EVALFI(DFN,DEFARR,ENODE,FIEVAL) ;Evaluate orderable item findings.
 D EVALFI^PXRMINDX(DFN,.DEFARR,ENODE,.FIEVAL)
 Q
 ;
 ;=========================================================
EVALPL(FINDPA,ENODE,TERMARR,PLIST) ;Evaluate orderable item term findings
 ;for patient lists.
 D EVALPL^PXRMINDL(.FINDPA,ENODE,.TERMARR,PLIST)
 Q
 ;
 ;=========================================================
EVALTERM(DFN,FINDPA,ENODE,TERMARR,TFIEVAL) ;Evaluate orderable item terms.
 D EVALTERM^PXRMINDX(DFN,.FINDPA,ENODE,.TERMARR,.TFIEVAL)
 Q
 ;
 ;=========================================================
GETDATA(DAS,FIEVT) ;Return data, for a specified order file entry.
 N DA,DATA
 S DA=$P(DAS,";",1)
 ;DBIA #4498
 D GETDATA^ORPXRM(DA,.DATA)
 S (FIEVT("STATUS"),FIEVT("VALUE"))=$P(DATA("ORSTS"),U,2)
 S FIEVT("ORDER")=DATA("ORORDER")
 S FIEVT("RELEASE DATE")=DATA("ORREL")
 S FIEVT("START DATE")=DATA("ORSTRT")
 S FIEVT("STOP DATE")=DATA("ORSTOP")
 S FIEVT("DURATION")=$$DURATION^PXRMDATE(FIEVT("START DATE"),FIEVT("STOP DATE"))
 Q
 ;
 ;=========================================================
MHVOUT(INDENT,IFIEVAL,NLINES,TEXT) ;Produce the MHV output.
 N DATE,IND,JND,NAME,NOUT,PNAME,TEMP,TEXTOUT
 S PNAME=$P(IFIEVAL("ORDER"),U,2)
 S NAME="Orderable Item: "_PNAME_" = "
 S IND=0
 F  S IND=+$O(IFIEVAL(IND)) Q:IND=0  D
 . S TEMP=NAME_$$LOW^XLFSTR(IFIEVAL(IND,"STATUS"))
 . S DATE=$G(IFIEVAL(IND,"START DATE"))
 . S TEMP=TEMP_" ("_$$EDATE^PXRMDATE(DATE)
 . S DATE=$G(IFIEVAL(IND,"STOP DATE"))
 . I DATE'="" S TEMP=TEMP_" - "_$$EDATE^PXRMDATE(DATE)
 . S TEMP=TEMP_")"
 . D FORMATS^PXRMTEXT(INDENT+2,PXRMRM,TEMP,.NOUT,.TEXTOUT)
 . F JND=1:1:NOUT S NLINES=NLINES+1,TEXT(NLINES)=TEXTOUT(JND)
 S NLINES=NLINES+1,TEXT(NLINES)=""
 Q
 ;
 ;=========================================================
OUTPUT(INDENT,IFIEVAL,NLINES,TEXT) ;Produce the clinical
 ;maintenance output.
 N DATE,IND,JND,NOUT,PNAME,TEMP,TEXTOUT
 S PNAME=$P(IFIEVAL("ORDER"),U,2)
 S NLINES=NLINES+1
 S TEXT(NLINES)=$$INSCHR^PXRMEXLC(INDENT," ")_"Orderable Item: "_PNAME
 S IND=0
 F  S IND=+$O(IFIEVAL(IND)) Q:IND=0  D
 . S DATE=IFIEVAL(IND,"DATE")
 . S TEMP=$$EDATE^PXRMDATE(DATE)
 . S TEMP=TEMP_" Status: "_$$LOW^XLFSTR(IFIEVAL(IND,"STATUS"))
 . S DATE=$G(IFIEVAL(IND,"START DATE"))
 . I DATE="" S DATE="missing"
 . S TEMP=TEMP_", Start date: "_$$EDATE^PXRMDATE(DATE)
 . S DATE=$G(IFIEVAL(IND,"STOP DATE"))
 . I DATE="" S DATE="missing"
 . S TEMP=TEMP_", Stop date: "_$$EDATE^PXRMDATE(DATE)
 . I $D(IFIEVAL(IND,"DURATION")) S TEMP=TEMP_"  Duration: "_IFIEVAL(IND,"DURATION")_" D"
 . D FORMATS^PXRMTEXT(INDENT+2,PXRMRM,TEMP,.NOUT,.TEXTOUT)
 . F JND=1:1:NOUT S NLINES=NLINES+1,TEXT(NLINES)=TEXTOUT(JND)
 S NLINES=NLINES+1,TEXT(NLINES)=""
 Q
 ;
