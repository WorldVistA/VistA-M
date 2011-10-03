PXRMHF ; SLC/PKR - Handle Health Factor findings. ;11/02/2009
 ;;2.0;CLINICAL REMINDERS;**6,17**;Feb 04, 2005;Build 102
 ;
 ;=====================================================
CATSORT(FIEVAL,FIND0,FARR) ;Sort all the true health factor findings
 ;according to the category criteria. FIND0 will be defined only
 ;for terms.
 N CAT,CATLIST,DATE,IND,FI,HFIEN,LDATE,NTRUE,WCR
 S HFIEN=""
 F  S HFIEN=$O(FARR("E","AUTTHF(",HFIEN)) Q:HFIEN=""  D
 . S FI=0
 . F  S FI=$O(FARR("E","AUTTHF(",HFIEN,FI)) Q:FI=""  D
 .. I 'FIEVAL(FI) Q
 ..;Get the Within Category Rank
 .. S WCR=$P(FARR(20,FI,0),U,10)
 .. I WCR="" S WCR=$P(FIND0,U,10)
 .. I WCR="" S WCR=9999
 ..;If Within Category Rank is 0 ignore the category and treat it like
 ..;regular finding (exclude it from the list).
 .. I WCR>0 D
 ... S CAT=$P(^AUTTHF(HFIEN,0),U,3)
 ...;If the category is null then send a warning.
 ... I CAT="" D WARN(^AUTTHF(HFIEN,0))  Q
 ... S CATLIST(CAT,FIEVAL(FI,"DATE"),WCR,FI)=""
 ... I $G(PXRMDEBG) S FIEVAL(FI,"CAT^WCR")=CAT_U_WCR
 ;No health factors to categorize then quit.
 I '$D(CATLIST) Q
 ;Only the most recent HF in a category can be true.
 S CAT=""
 F  S CAT=$O(CATLIST(CAT)) Q:CAT=""  D
 . S LDATE=$O(CATLIST(CAT,""),-1)
 .;For each category set all but the most recent HF false.
 . S DATE=""
 . F  S DATE=$O(CATLIST(CAT,DATE)) Q:DATE=LDATE  D
 .. S WCR=""
 .. F  S WCR=$O(CATLIST(CAT,DATE,WCR)) Q:WCR=""  D
 ... S FI=""
 ... F  S FI=$O(CATLIST(CAT,DATE,WCR,FI)) Q:FI=""  D
 .... S FIEVAL(FI)=0
 ....;If there are multiple occurrences set them all false.
 .... S IND=0
 .... F  S IND=+$O(FIEVAL(FI,IND)) Q:IND=0  S FIEVAL(FI,IND)=0
 .;
 .;If there is more than on HF on the most recent date then only the
 .;one with the highest WCR can be true. The highest possible WCR is 1.
 .;Set all with lower WCRs false.
 .;If the most recent health factor has multiple occurrences only
 .;the first occurrence can be true.
 . S (NTRUE,WCR)=0
 . F  S WCR=$O(CATLIST(CAT,LDATE,WCR)) Q:WCR=""  D
 .. S FI=""
 .. F  S FI=$O(CATLIST(CAT,LDATE,WCR,FI)) Q:FI=""  D
 ... I NTRUE=0 D  Q
 ....;If there are multiple sub-occurrences set them all false.
 .... S (IND,NTRUE)=1
 .... F  S IND=+$O(FIEVAL(FI,IND)) Q:IND=0  S FIEVAL(FI,IND)=0
 ... S FIEVAL(FI)=0
 ...;If there are multiple sub-occurrences set them all false.
 ... S IND=0
 ... F  S IND=+$O(FIEVAL(FI,IND)) Q:IND=0  S FIEVAL(FI,IND)=0
 Q
 ;
 ;=====================================================
EVALFI(DFN,DEFARR,ENODE,FIEVAL) ;Evaluate health factor findings.
 N FIEVT,FILENUM,FINDPA,FINDING,HFIEN,NOINDEX
 S FILENUM=$$GETFNUM^PXRMDATA(ENODE)
 I $G(^PXRMINDX(FILENUM,"DATE BUILT"))="" D
 . D NOINDEX^PXRMERRH("D",PXRMITEM,FILENUM)
 . S NOINDEX=1
 E  S NOINDEX=0
 S HFIEN=""
 F  S HFIEN=$O(DEFARR("E",ENODE,HFIEN)) Q:+HFIEN=0  D
 . S FINDING=""
 . F  S FINDING=$O(DEFARR("E",ENODE,HFIEN,FINDING)) Q:+FINDING=0  D
 .. I NOINDEX S FIEVAL(FINDING)=0 Q
 .. K FINDPA
 .. M FINDPA=DEFARR(20,FINDING)
 .. K FIEVT
 .. D FIEVAL^PXRMINDX(FILENUM,"PI",DFN,HFIEN,.FINDPA,.FIEVT)
 .. M FIEVAL(FINDING)=FIEVT
 .. S FIEVAL(FINDING,"FINDING")=$P(FINDPA(0),U,1)
 ;Sort all the true true findings by category.
 D CATSORT(.FIEVAL,"",.DEFARR)
 Q
 ;
 ;=====================================================
EVALPL(FINDPA,ENODE,TERMARR,PLIST) ;Evaluate health factor term findings
 ;for patient lists.
 D EVALPL^PXRMINDL(.FINDPA,ENODE,.TERMARR,PLIST)
 Q
 ;
 ;=====================================================
EVALTERM(DFN,FINDPA,ENODE,TERMARR,TFIEVAL) ;Evaluate health factor terms.
 N BDT,EDT,FIEVT,HFIEN,NOINDEX,PFINDPA
 N TFINDPA,TFINDING
 I $G(^PXRMINDX(9000010.23,"DATE BUILT"))="" D
 . D NOINDEX^PXRMERRH("TR",TERMARR("IEN"),9000010.23)
 . S NOINDEX=1
 E  S NOINDEX=0
 S HFIEN=""
 F  S HFIEN=$O(TERMARR("E",ENODE,HFIEN)) Q:+HFIEN=0  D
 . S TFINDING=""
 . F  S TFINDING=$O(TERMARR("E",ENODE,HFIEN,TFINDING)) Q:+TFINDING=0  D
 .. I NOINDEX S TFIEVAL(TFINDING)=0 Q
 .. K FIEVT,PFINDPA,TFINDPA
 .. M TFINDPA=TERMARR(20,TFINDING)
 ..;Set the finding parameters.
 .. D SPFINDPA^PXRMTERM(.FINDPA,.TFINDPA,.PFINDPA)
 .. D FIEVAL^PXRMINDX(9000010.23,"PI",DFN,HFIEN,.PFINDPA,.FIEVT)
 .. M TFIEVAL(TFINDING)=FIEVT
 .. S TFIEVAL(TFINDING,"FINDING")=$P(TFINDPA(0),U,1)
 ;Sort all the true true findings by category.
 D CATSORT(.TFIEVAL,FINDPA(0),.TERMARR)
 Q
 ;
 ;=====================================================
GETDATA(DAS,FIEVT) ;Return data for a specified V Health Factor entry.
 ;DBIA #4250
 D VHF^PXPXRM(DAS,.FIEVT)
 Q
 ;
 ;=====================================================
MHVOUT(INDENT,IFIEVAL,NLINES,TEXT) ;Produce the MHV output.
 N EM,FIEN,IND,JND,LVL,NAME,NOUT,PNAME,TEMP,TEXTOUT,VDATE
 S FIEN=$P(IFIEVAL("FINDING"),";",1)
 S PNAME=$P(^AUTTHF(FIEN,0),U,1)
 S NAME="Health Factor: "_PNAME_" = "
 S IND=0
 F  S IND=+$O(IFIEVAL(IND)) Q:IND=0  D
 . S LVL=$G(IFIEVAL(IND,"VALUE"))
 . I LVL'="" S LVL=$$EXTERNAL^DILFD(9000010.23,.04,"",LVL,.EM)
 . S VDATE=IFIEVAL(IND,"DATE")
 . S TEMP=NAME_LVL_" ("_$$EDATE^PXRMDATE(VDATE)_")"
 . D FORMATS^PXRMTEXT(INDENT+2,PXRMRM,TEMP,.NOUT,.TEXTOUT)
 . F JND=1:1:NOUT S NLINES=NLINES+1,TEXT(NLINES)=TEXTOUT(JND)
 S NLINES=NLINES+1,TEXT(NLINES)=""
 Q
 ;
 ;=====================================================
OUTPUT(INDENT,IFIEVAL,NLINES,TEXT) ;Produce the clinical
 ;maintenance output.
 N EM,FIEN,IND,JND,LVL,NOUT,PNAME,TEMP,TEXTOUT,VDATE
 S FIEN=$P(IFIEVAL("FINDING"),";",1)
 ;DBIA #3083
 S PNAME=$P(^AUTTHF(FIEN,0),U,1)
 S NLINES=NLINES+1
 S TEXT(NLINES)=$$INSCHR^PXRMEXLC(INDENT," ")_"Health Factor: "_PNAME
 S IND=0
 F  S IND=+$O(IFIEVAL(IND)) Q:IND=0  D
 . S VDATE=IFIEVAL(IND,"DATE")
 . S TEMP=$$EDATE^PXRMDATE(VDATE)
 . S LVL=$G(IFIEVAL(IND,"VALUE"))
 . I LVL'="" D
 .. S TEMP=TEMP_" level/severity - "
 .. S TEMP=TEMP_$$EXTERNAL^DILFD(9000010.23,.04,"",LVL,.EM)
 . D FORMATS^PXRMTEXT(INDENT+2,PXRMRM,TEMP,.NOUT,.TEXTOUT)
 . F JND=1:1:NOUT S NLINES=NLINES+1,TEXT(NLINES)=TEXTOUT(JND)
 . I IFIEVAL(IND,"COMMENTS")'="" D
 .. S TEMP="Comments: "_IFIEVAL(IND,"COMMENTS")
 .. D FORMATS^PXRMTEXT(INDENT+3,PXRMRM,TEMP,.NOUT,.TEXTOUT)
 .. F JND=1:1:NOUT S NLINES=NLINES+1,TEXT(NLINES)=TEXTOUT(JND)
 S NLINES=NLINES+1,TEXT(NLINES)=""
 Q
 ;
 ;=====================================================
WARN(HF0) ;Issue a warning if a health factor is missing its category.
 N XMSUB
 K ^TMP("PXRMXMZ",$J)
 S XMSUB="CLINICAL REMINDER DATA PROBLEM, HEALTH FACTOR"
 S ^TMP("PXRMXMZ",$J,1,0)="Health Factor "_$P(HF0,U,1)
 S ^TMP("PXRMXMZ",$J,2,0)="does not have a category, this is a required field."
 S ^TMP("PXRMXMZ",$J,3,0)="This health factor will be ignored for all patients until the problem is fixed."
 D SEND^PXRMMSG("PXRMXMZ",XMSUB)
 Q
 ;
