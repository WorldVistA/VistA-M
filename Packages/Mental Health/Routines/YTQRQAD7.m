YTQRQAD7 ;BAL/KTL - RESTful Calls to handle MHA Web RPCs ; 7/19/2021
 ;;5.01;MENTAL HEALTH;**181,187,202**;Dec 30, 1994;Build 47
 ;
 ; Reference to EN^XPAR in ICR #2263
 ; Reference to ORQQCN in ICR #1671
 ; Reference to XLFJSON in ICR #6682
 ;
 ;User Preferences
 ;Instrument Admin COMMENT retrieval
 Q
IACTV(INAM) ; Return 1 if Instrument Active, 0 otherwise
 N IEN,STAT,OP
 S STAT=0
 S IEN=$O(^YTT(601.71,"B",INAM,"")) I +IEN=0 Q STAT
 S OP=$P($G(^YTT(601.71,IEN,2)),U,2) I OP="Y" S STAT=1
 Q STAT
GETASMTP(ARGS,RESULTS) ; Given user DUZ get last Assignment Preferences
 N YSWPARR
 K ^TMP("YTQ-JSON",$J)
 D GETPARAM("YS MHA_WEB LAST ASSIGN SET","{}",.YSWPARR)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SETASMTP(ARGS,DATA) ; Set a User's last Assignment Preferences
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 S YSRET=$$SETPARAM("YS MHA_WEB LAST ASSIGN SET","/api/mha/assignmentparam/pref/",.HTTPREQ,,"LAST ASSIGNMENT")
 Q YSRET
GETIFAV(ARGS,RESULTS) ; Given user DUZ get Instrument Favorites
 N YSWPARR,INSTARR,TMPARR,I,INSTN,CHGF,DFLT
 K ^TMP("YTQ-JSON",$J)
 S DFLT="{""favlist"":[]}"
 D GETPARAM("YS MHA_WEB FAV INST",DFLT,.YSWPARR)
 I $G(YSWPARR(1,0))'["[]" D  ;Was not the default empty list
 . D CHKPRMI(.YSWPARR,DFLT,.CHGF)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 I $G(CHGF)=1 D RSTPARAM("YS MHA_WEB FAV INST","/api/mha/instrument/lists/fav/userfav/",.YSWPARR,,"INST FAVS")
 Q
SETIFAV(ARGS,DATA) ; Set a User's Instrument Favorites
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 N I,YSWPARR,CHGF,CNT,DFLT
 S DFLT="{""favlist"":[]}"
 S CNT=0,I=2 F  S I=$O(HTTPREQ(I)) Q:+I=0  D
 . S CNT=CNT+1,YSWPARR(CNT,0)=HTTPREQ(I)
 D CHKPRMI(.YSWPARR,DFLT,.CHGF)
 I $G(CHGF)=1 D
 . K HTTPREQ
 . S CNT=2,I=0 F  S I=$O(YSWPARR(I)) Q:+I=0  D
 .. S CNT=CNT+1,HTTPREQ(CNT)=YSWPARR(I,0)
 S YSRET=$$SETPARAM("YS MHA_WEB FAV INST","/api/mha/instrument/lists/fav/userfav/",.HTTPREQ,,"INST FAVS")
 Q YSRET
GETGRAPH(ARGS,RESULTS) ; Given user DUZ get Graphing Preferences
 N YSWPARR
 K ^TMP("YTQ-JSON",$J)
 D GETPARAM("YS MHA_WEB GRAPH PREFS","{""graphprefs"":[]}",.YSWPARR)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SETGRAPH(ARGS,DATA) ; Set a User's Graphing Preferences
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 S YSRET=$$SETPARAM("YS MHA_WEB GRAPH PREFS","/api/mha/instrumentgraph/prefs/",.HTTPREQ,,"GRAPH PREF")
 Q YSRET
GETSPCLG(ARGS,RESULTS) ; Given user DUZ get Special Report Graph Report Preferences
 N YSWPARR,INSTARR,TMPARR,I,INSTN,CHGF,DFLT
 K ^TMP("YTQ-JSON",$J)
 S DFLT="{""spclgraphprefs"":[]}"
 D GETPARAM("YS MHA_WEB SPECIAL GRAPH RPT",DFLT,.YSWPARR)
 I $G(YSWPARR(1,0))'["[]" D  ;Was not the default empty list
 . D CHKPRMI(.YSWPARR,DFLT,.CHGF)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 I $G(CHGF)=1 D RSTPARAM("YS MHA_WEB SPECIAL GRAPH RPT","/api/mha/specialgraph/rptpref/",.YSWPARR,,"SPCL RPT")
 Q
SETSPCLG(ARGS,DATA) ; Set a User's Special Report Graph Report Preferences
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 N I,YSWPARR,CHGF,CNT,DFLT
 S DFLT="{""spclgraphprefs"":[]}"
 S CNT=0,I=2 F  S I=$O(HTTPREQ(I)) Q:+I=0  D
 . S CNT=CNT+1,YSWPARR(CNT,0)=HTTPREQ(I)
 D CHKPRMI(.YSWPARR,DFLT,.CHGF)
 I $G(CHGF)=1 D
 . K HTTPREQ
 . S CNT=2,I=0 F  S I=$O(YSWPARR(I)) Q:+I=0  D
 .. S CNT=CNT+1,HTTPREQ(CNT)=YSWPARR(I,0)
 S YSRET=$$SETPARAM("YS MHA_WEB SPECIAL GRAPH RPT","/api/mha/specialgraph/rptpref/",.HTTPREQ,,"SPCL RPT")
 Q YSRET
GETRPT(ARGS,RESULTS) ; Given user DUZ get Report view Preferences
 N YSWPARR
 K ^TMP("YTQ-JSON",$J)
 D GETPARAM("YS MHA_WEB REPORT PREFS","{""reportprefs"":[]}",.YSWPARR)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SETRPT(ARGS,DATA) ; Set a User's Report view Preferences
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 S YSRET=$$SETPARAM("YS MHA_WEB REPORT PREFS","/api/mha/reports/rptpref/",.HTTPREQ,,"RPT PREFS")
 Q YSRET
GETNP(ARGS,RESULTS) ; Given user DUZ get Report Save Progress Note preference
 N YSWPARR
 K ^TMP("YTQ-JSON",$J)
 D GETPARAM("YS MHA_WEB PROG NOTE PREFS","{""noteprefs"":[]}",.YSWPARR)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SETNP(ARGS,DATA) ; Set a User's Save Progress Note preference
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 S YSRET=$$SETPARAM("YS MHA_WEB PROG NOTE PREFS","/api/mha/notes/noteprefs/",.HTTPREQ,,"PROG NOTE PREF")
 Q YSRET
WEBGUSRP(ARGS,RESULTS) ;Get Dashboard User Column Preferences
 N YSWPARR,JSONOUT
 K ^TMP("YTQ-JSON",$J)
 D GETPARAM("YSB USER COLUMN PREFERENCE","",.YSWPARR)
 I $G(YSWPARR(1,0))="" D
 . K YSWPARR D DFLTUP(JSONOUT)
 . D TOTMP^YSBRPC(.JSONOUT)
 I $D(YSWPARR) M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
WEBPUSRP(ARGS,DATA) ; Set a User's Dashboard Column Preferences
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 S YSRET=$$SETPARAM("YSB USER COLUMN PREFERENCE","/api/mha/dashboard/userpref/",.HTTPREQ,,"DASH COLS")
 Q YSRET
DFLTUP(XJSON)  ;
 ; Get the Default columns to display if there are no set User Preferences
 N II,XDATA,XNAM,XJ,SPC,XCNT,XTABC
 S $P(SPC," ",10)=""
 S XCNT=1,XTABC=1,XJSON(XCNT)="{"
 D GETWDGT^YSBRPC(.XDATA)
 S II=0 F  S II=$O(XDATA("widgets",II)) Q:+II=0  D
 . S XNAM=$G(XDATA("widgets",II,"name"))
 . S XNAM=$S(XNAM="HIGH RISK":"highRisk",XNAM="MBC":"measurementBased",1:XNAM)
 . K XDATA("widgets",II,"instrumentList")  ;Don't include instrument list for now
 . K XDATA("widgets",II,"name")
 . M XJ(XNAM)=XDATA("widgets",II)
 . S XJ(XNAM,"display")="true"
 . S XJ(XNAM,"filterList","name")="name"
 . S XJ(XNAM,"filterList","value")=""
 D ENCODE^YSBJSON("XJ","XJSON","ERRARY")
 Q
SETPARAM(YSPNAM,RETURL,HTTPREQ,YSWDGT,YSVAL)  ;Set Parameter
 ; Assignment Parameters=YS MHA_WEB LAST ASSIGN SET
 ; Favorite Instruments=YS MHA_WEB FAV INST
 ; Batteries=YS MHA_WEB BATTERIES
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 ; Return Success or Failure URL string
 N II,CNT,YSDUZ
 N FDA,IENS,FDAIEN,YSMSG,YSJSON
 ;I '$D(HTTPREQ) Q RETURL_"NODATA"
 S CNT=0
 ;In the DATA array the body starts after the first line
 S II=2 F  S II=$O(HTTPREQ(II)) Q:II=""  D
 . Q:$TR(HTTPREQ(II)," ")=""
 . S CNT=CNT+1,YSJSON(CNT)=HTTPREQ(II)
 S YSJSON=$G(YSVAL)
 I '$D(HTTPREQ) S YSJSON="@"
 S:+$G(YSWDGT)=0 YSWDGT=1
 S YSDUZ=DUZ_";VA(200,"
 D EN^XPAR(YSDUZ,YSPNAM,YSWDGT,.YSJSON,.YSMSG)
 I +YSMSG'=0 D SETERROR^YTQRUTL(404,"PARAMETER not found: "_YSPNAM) Q RETURL_"ERROR: "_$P(YSMSG,U,2)
 Q RETURL_"OK"
GETPARAM(YSPNAM,DFLT,YSWPARR,YSWDGT)  ;Get Parameter
 N YSDUZ
 K JSONOUT
 S:$G(YSWDGT)="" YSWDGT=1  ;Parameter instance-default to 1
 S YSDUZ=DUZ_";VA(200,"
 D GETWP^XPAR(.YSWPARR,YSDUZ,YSPNAM,YSWDGT)
 I '$D(YSWPARR) D
 . S YSWPARR(1,0)=DFLT  ;Need to define Default
 I $D(YSWPARR)=1,($G(YSWPARR)="") D  ;Parameter for User exists but it is empty
 . S YSWPARR(1,0)=DFLT  ;Need to define Default
 Q
RSTPARAM(YSPNAM,RETURL,YSWPARR,YSWDGT,YSVAL)  ;Rest Parameter
 ; This is used when during a GET Parameter an instrument is found to be inactive and the JSON
 ; payload is changed to remove the instrument.  The parameter has to be reset with the new instrument list
 ; The JSON Array has to be set up in the format of HTTPREQ and there does not need to be any return value
 N HTTPREQ,I,NORET
 Q:$G(YSPNAM)=""
 Q:'$D(YSWPARR)
 S RETURL=$G(RETURL),YSWDGT=$G(YSWDGT),YSVAL=$G(YSVAL)
 S I=0 F  S I=$O(YSWPARR(I)) Q:+I=0  D
 . S HTTPREQ(I+2)=YSWPARR(I,0)  ;I+2 because the first line is the URL and the second line is blnk in HTTPREQ normally
 S NORET=$$SETPARAM(YSPNAM,RETURL,.HTTPREQ,YSWDGT,YSVAL)  ;Set Parameter
 Q
GETBAT(ARGS,RESULTS) ; Given user DUZ get Instrument Batteries
 N YSWPARR,INSTARR,TMPARR,I,INSTN,CHGF,DFLT
 K ^TMP("YTQ-JSON",$J)
 S DFLT="{""batteries"":[]}"
 D GETPARAM("YS MHA_WEB BATTERIES",DFLT,.YSWPARR)
 I $G(YSWPARR(1,0))'["[]" D  ;Was not the default empty list
 . D CHKPRMI(.YSWPARR,DFLT,.CHGF)
 M ^TMP("YTQ-JSON",$J)=YSWPARR
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 I $G(CHGF)=1 D RSTPARAM("YS MHA_WEB BATTERIES","/api/mha/instrument/lists/batteries/userbat/",.YSWPARR,,"BATTERIES")
 Q
SETBAT(ARGS,DATA) ; Set a User's Instrument Batteries
 ; Requires HTTPREQ to be defined coming from YTQRUTL passed in by VistA RPC handler
 N YSRET
 N I,YSWPARR,CHGF,CNT,DFLT
 S DFLT="{""batteries"":[]}"
 S CNT=0,I=2 F  S I=$O(HTTPREQ(I)) Q:+I=0  D
 . S CNT=CNT+1,YSWPARR(CNT,0)=HTTPREQ(I)
 D CHKPRMI(.YSWPARR,DFLT,.CHGF)
 I $G(CHGF)=1 D
 . K HTTPREQ
 . S CNT=2,I=0 F  S I=$O(YSWPARR(I)) Q:+I=0  D
 .. S CNT=CNT+1,HTTPREQ(CNT)=YSWPARR(I,0)
 S YSRET=$$SETPARAM("YS MHA_WEB BATTERIES","/api/mha/instrument/lists/batteries/userbat/",.HTTPREQ,,"BATTERIES")
 Q YSRET
CHKPRMI(YSWPARR,DFLT,CHGF) ;Check Parameter instrument list for inactive instruments
 ; Currently for "batteries" and "favlist"
 ; Input=array of JSON
 ; Output=array of JSON with inactive instruments removed and CHGF=1 if array has changed
 ; Both input array and CHGF passed by reference
 N INSTARR,TMPARR,I,J,INSTN,ISTAT,ERR
 D J2ARR(.YSWPARR,.TMPARR)
 D DECODE^XLFJSON("TMPARR","INSTARR","ERR")
 S CHGF=0
 I '$D(ERR),(DFLT["batteries") D
 . S J=0 F  S J=$O(INSTARR("batteries",J)) Q:+J=0  D
 .. S I=0 F  S I=$O(INSTARR("batteries",J,"instruments",I)) Q:+I=0  D
 ... S INSTN=INSTARR("batteries",J,"instruments",I)
 ... S ISTAT=$$IACTV(INSTN)
 ... I +ISTAT=0 K INSTARR("batteries",J,"instruments",I) S CHGF=1  ;Instrument no longer active
 ... I '$D(INSTARR("batteries",J,"instruments")) K INSTARR("batteries",J)  ;No instruments in battery
 I '$D(ERR),(DFLT["favlist") D
 . S I=0 F  S I=$O(INSTARR("favlist",I)) Q:+I=0  D
 .. S INSTN=$G(INSTARR("favlist",I,"instrumentName")) Q:INSTN=""
 .. S ISTAT=$$IACTV(INSTN)
 .. I +ISTAT=0 K INSTARR("favlist",I) S CHGF=1  ;Instrument no longer active
 I '$D(ERR),(DFLT["spclgraphprefs") D
 . S I=0 F  S I=$O(INSTARR("selectedInstruments",I)) Q:+I=0  D
 .. S INSTN=INSTARR("selectedInstruments",I) Q:INSTN=""
 .. S ISTAT=$$IACTV(INSTN)
 .. I +ISTAT=0 K INSTARR("selectedInstruments",I) S CHGF=1  ;Instrument no longer active
 K YSWPARR,TMPARR
 I '$D(INSTARR) S YSWPARR(1,0)=DFLT Q  ;No batteries left
 D ENCODE^XLFJSON("INSTARR","TMPARR","ERR")
 I '$D(ERR) D
 . S I=0 F  S I=$O(TMPARR(I)) Q:+I=0  D
 .. S YSWPARR(I,0)=TMPARR(I)
 Q
LOADCOM(ARGS,RESULTS) ;Get Comments for an Instrument Admin and load them for display
 N YSADMIN,YSARR,I,CRLF
 S CRLF=$C(10)
 S YSADMIN=$G(ARGS("adminId"))
 I '$D(^YTT(601.84,YSADMIN,0)) D SETERROR^YTQRUTL(404,"Admin not found: "_YSADMIN) QUIT
 D GETCOM^YTQRQAD3(.YSARR,YSADMIN)
 I '$D(YSARR) S RESULTS("text","\",1)="" Q
 S I="" F  S I=$O(YSARR(I)) Q:I=""  D
 . S RESULTS("text","\",I)=YSARR(I)_CRLF
 Q
AINSTS(SETID,IARR)  ; Assignment Instrument Status check for Deletion
 ; Pre-validated Assignment ID passed in
 ; Return IARR by Assignment Instrument Index (e.g. IARR(instnum)=0)
 ;        0=Complete
 ;        1=Incomplete
 ;        2=Not allowed
 ; Return IARR(instnum,"ADMINID")=MH ADMINISTRATION IEN for reference
 ; Overall Delete SETID status
 ;        IARR("STAT")="OK","NOTOK","NOTALLOWED"
 N ASSGN,INST,ISCMPLT,AOK,MGR,YSADMIN,X0
 S MGR=$$ISMGR^YTQRQAD1()
 S ASSGN="YTQASMT-SET-"_SETID,IARR("STAT")="OK"
 S INST=0 F  S INST=$O(^XTMP(ASSGN,1,"instruments",INST)) Q:+INST=0  D
 . S YSADMIN=$G(^XTMP(ASSGN,1,"instruments",INST,"adminId"))
 . I +YSADMIN=0 S IARR(INST)=1 Q
 . S IARR(INST,"ADMINID")=YSADMIN
 . S X0=$G(^YTT(601.84,YSADMIN,0)) I X0="" S IARR(INST)=1 Q
 . S ISCMPLT=$P(X0,U,9)
 . I ISCMPLT="Y" S IARR(INST)=0,IARR("STAT")="NOTOK" Q
 . I MGR!(DUZ=$P(X0,U,6))!(DUZ=$P(X0,U,7)) S IARR(INST)=1 I 1
 . E  S IARR(INST)=2,IARR("STAT")="NOTALLOWED"
 Q
GETCONS(ARGS,RESULTS)   ; Get list of patient consults
 N TYPE,RV,CONS,DT,STAT,LOC,TYPE,LOCA,YSSTAT,HIT,NOCONS,DFN,IEN
 S YSSTAT="5,6,8,9,15"  ;Pending, Active, Scheduled, Partial Results, Renewed
 K ^TMP("ORQQCN",$J)
 S DFN=+$G(ARGS("dfn")) D LIST^ORQQCN(.RV,DFN,,,,YSSTAT)  ;DBIA 1671 ORQQCN LIST
 K ^TMP("YTQ-JSON",$J) S CNT=0
 D SETRES("{""consults"":[")
 S HIT="",NOCONS=""
 S IEN=0 F  S IEN=$O(^TMP("ORQQCN",$J,"CS",IEN)) Q:'IEN!NOCONS  D
 .S DATA=^TMP("ORQQCN",$J,"CS",IEN,0)
 .I DATA["PATIENT DOES NOT HAVE ANY" S NOCONS=1 Q
 .S HIT=1
 .S CONS=$P(DATA,U,1)
 .S DT=$P(DATA,U,2)
 .S STAT=$P(DATA,U,3)
 .S LOC=$P(DATA,U,4)
 .S TYPE=$P(DATA,U,5)
 .S LOCA=$P(DATA,U,6)
 .S STR="{""Consult"":"""_CONS_""", ""ConsultDate"":"""_$$FMTE^XLFDT($P(DT,"."))_""", ""Status"":"""_STAT_""", ""Clinic"":"""_LOC_""",""Type"":"""_TYPE_"""},"
 .D SETRES(STR)
 I HIT S STR=^TMP("YTQ-JSON",$J,CNT,0),STR=$E(STR,1,$L(STR)-1),^TMP("YTQ-JSON",$J,CNT,0)=STR  ;Remove last trailing ","
 D SETRES("]}")
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
ASMTSTAF(ARGS,RESULTS) ; get assignment identified by assignmentId
 N ASMT,INTE,ORBY,LOCA,INTV,ORDBY,LOC,CON,DAT,CONTX,CONA,ADMINDT,IEN,DFN
 N YSARR,II,DATA
 S ASMT="YTQASMT-SET-"_$G(ARGS("assignmentId"))
 I '$D(^XTMP(ASMT)) D SETERROR^YTQRUTL(404,"Not Found: "_ARGS("assignmentId")) QUIT
 M DATA=^XTMP("YTQASMT-SET-"_$G(ARGS("assignmentId")))
 S INTE=$G(DATA(1,"interview"))
 S ORBY=$G(DATA(1,"orderedBy"))
 S LOCA=$G(DATA(1,"location"))
 S CONA=$G(DATA(1,"consult"))
 S DFN=$G(DATA(1,"patient","dfn"))
 ;Now XLAT pointers to JSON data var_"Name"
 S INTV=$P($G(^VA(200,INTE,0)),U,1)
 S ORDBY=$P($G(^VA(200,ORBY,0)),U,1)
 S LOC=$P($G(^SC(LOCA,0)),U,1)
 S ADMINDT=$G(DATA(1,"adminDate"))
 S RESULTS("interviewName")=INTV
 S RESULTS("orderedbyName")=ORDBY
 S RESULTS("locationName")=LOC
 S RESULTS("adminDate")=ADMINDT
 S RESULTS("consultName")=""  ;initialize consultName
 D LIST^ORQQCN(.RV,DFN)
 S IEN="" F  S IEN=$O(^TMP("ORQQCN",$J,"CS",IEN)) Q:'IEN  D
 .S DAT=^TMP("ORQQCN",$J,"CS",IEN,0)
 .S CON=$P(DAT,U,1) Q:CON'=CONA  D  I CON=CONA S CONTX=$P(DAT,U,7)
 .S RESULTS("consultName")=CONTX
 M RESULTS=^XTMP(ASMT,1)
 K ^TMP("YTQ-JSON",$J)
 D ENCODE^XLFJSON("RESULTS","YSARR")
 S II=0 F  S II=$O(YSARR(II)) Q:II=""  D
 . S ^TMP("YTQ-JSON",$J,II,0)=YSARR(II)
 K RESULTS
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
 ;
SETRES(STR) ;
 S CNT=CNT+1,^TMP("YTQ-JSON",$J,CNT,0)=STR
 Q
 ;
GLIST(YSPAR,YSENT,YSLIST) ;Get the number of values for a particular parameter
 D GETLST^XPAR(.YSLIST,YSENT,YSPAR)
 Q
SRLST(SRARR) ;Special Reports Parameters List
 ; Find all instances of Special Reports and decode from JSON into array
 N YSLIST,YSDUZ,YSPAR,I,JARR,ERR,TMPAR,II
 S YSPAR="YS MHA_WEB SPECIAL GRAPH RPT"
 S YSDUZ=DUZ_";VA(200,"
 D GETLST^XPAR(.YSLIST,YSDUZ,YSPAR)
 Q:+$G(YSLIST)=0
 F I=1:1:YSLIST D
 . D GETPARAM("YS MHA_WEB SPECIAL GRAPH RPT","{""spclgraphprefs"":[]}",.YSWPARR,I)
 . K JARR,TMPAR
 . S II=0 F  S II=$O(YSWPARR(II)) Q:II=""  D
 .. S TMPAR(II)=YSWPARR(II,0)
 . D DECODE^XLFJSON("TMPAR","JARR","ERR")
 . I '$D(ERR) M SRARR(I)=JARR
 Q
GETSRLST(ARGS,RESULTS) ;Get Special Reports Parameter(s)
 N II,SRARR,YSARR,CNT,TMPAR
 D SRLST(.SRARR)
 S CNT=0
 S II=0 F  S II=$O(SRARR(II)) Q:II=""  D
 . S CNT=CNT+1
 . M TMPAR("specialReports",CNT)=SRARR(II,"specialReports",1)
 K ^TMP("YTQ-JSON",$J)
 D ENCODE^XLFJSON("TMPAR","YSARR")
 S II=0 F  S II=$O(YSARR(II)) Q:II=""  D
 . S ^TMP("YTQ-JSON",$J,II,0)=YSARR(II)
 K RESULTS
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
SAVSRLST(ARGS,RESULTS) ;Save Special Reports Parameter
 N HTTPOBJ,II,CNT,YSJSON,JARR,ERR,INNAM,SRARR,MATCH,SRNAM
 S CNT=0
 S II=2 F  S II=$O(HTTPREQ(II)) Q:II=""  D
 . Q:$TR(HTTPREQ(II)," ")=""
 . S CNT=CNT+1,HTTPOBJ(CNT)=HTTPREQ(II)
 D DECODE^XLFJSON("HTTPOBJ","JARR","ERR")
 S INNAM=$G(JARR("specialReports",1,"name"))
 I INNAM="" D SETERROR^YTQRUTL(404,"Special Report Name not sent") Q "/api/mha/specialgraph/rptpref/ERROR: Name not sent"
 D SRLST(.SRARR)
 S MATCH=""
 S II=0 F  S II=$O(SRARR(II)) Q:II=""  D
 . S SRNAM=$G(SRARR(II,"specialReports",1,"name"))
 . I SRNAM=INNAM S MATCH=II
 I MATCH="" S MATCH=$O(SRARR(""),-1)+1  ;No match, so new parameter. Find last instance and add one.
 S YSRET=$$SETPARAM("YS MHA_WEB SPECIAL GRAPH RPT","/api/mha/specialgraph/rptpref/",.HTTPREQ,MATCH,"SPCL RPT")
 Q YSRET
J2ARR(JARR,OUTARR) ;Move XLFJSON array contents to OUTARR
 N I
 S I=0 F  S I=$O(JARR(I)) Q:+I=0  D
 . S OUTARR(I)=JARR(I,0)
 Q
