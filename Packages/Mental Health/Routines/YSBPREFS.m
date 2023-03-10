YSBPREFS ;BAL/KTL - MHA DASHBOARD USER PREFERENCES ; Apr 01, 2021@16:33
 ;;5.01;MENTAL HEALTH;**202**;Dec 30, 1994;Build 47
 ;
 ; Routine saves Settings, gets settings for User Preferences
 ; in JSON format.
 ;
 ; Reference to XPAR in ICR #2263
 Q
 ;==============================
 ; Get User Preferences
 ;
GETHRSEL(JSONOUT,PARMS) ;
 ; Given user DUZ and Widget, get the High Risk Patient Selection Criteria
 N DATAOUT,WPARR,DUZPAR,WDGT,YDUZ,II
 K JSONOUT
 S WDGT=1
 S YDUZ=$G(DUZ)
 S:WDGT="" WDGT=1  ;For first instance of this parameter. Most likely always 1
 S DUZPAR=YDUZ_";VA(200,"
 D GETWP^XPAR(.WPARR,DUZPAR,"YSB HR SELECTION CRITERIA",WDGT)
 I '$D(WPARR) D  Q
 . S JSONOUT(1)="{}"
 I $D(WPARR)=1,(WPARR="") D  Q
 . S JSONOUT(1)="{}"
 S II="" F  S II=$O(WPARR(II)) Q:II=""  D
 . S JSONOUT(II)=WPARR(II,0)
 Q
GETMBSEL(JSONOUT) ;
 ; Given user DUZ and Widget, get the Measurement Based Care (MBC) Patient Selection Criteria
 N DATAOUT,WPARR,DUZPAR,WDGT,YDUZ
 K JSONOUT
 S WDGT=1
 S YDUZ=$G(DUZ)
 S:WDGT="" WDGT=1  ;For first instance of this parameter. Most likely always 1
 S DUZPAR=YDUZ_";VA(200,"
 D GETWP^XPAR(.WPARR,DUZPAR,"YSB MBC SELECTION CRITERIA",WDGT)
 I '$D(WPARR) D  Q
 . ;S JSONOUT(1)="{}"  ;Need to define Default
 . D MBSDFLT(.JSONOUT)
 I $D(WPARR)=1,(WPARR="") D  Q
 . D MBSDFLT(.JSONOUT)
 S II="" F  S II=$O(WPARR(II)) Q:II=""  D
 . S JSONOUT(II)=WPARR(II,0)
 Q
MBSDFLT(JSONOUT) ;Generate default Selection JSON
 N LARR,ERRARR,CNT,XCNT
 ; Remove default list of all locations in UI, too cumbersome.
 ;N DUMDAT
 ;S CNT=0
 ;D GETLOCS^YSBWHIG2(.DUMDAT,1)  ;Call to get standardized MH Locs list
 ;S XCNT=0 F  S XCNT=$O(DUMDAT("widgets",1,"locationList",XCNT)) Q:XCNT=""  D
 ;. S CNT=CNT+1
 ;. S LARR("data","clinics",CNT,"label")=DUMDAT("widgets",1,"locationList",XCNT,"name")
 ;. S LARR("data","clinics",CNT,"value")=DUMDAT("widgets",1,"locationList",XCNT,"id")
 S LARR("data","date","label")="past year"
 S LARR("data","date","value")="-365"
 S LARR("data","sessionId")=""
 D ENCODE^YSBJSON("LARR","JSONOUT","ERRARR")
 Q
GETILST(JSONOUT,PARMS) ;
 ; Given user DUZ and Widget, get the Measurement Based Care (MBC) Patient Selection Criteria
 N DATAOUT,WPARR,DUZPAR,WDGT,YDUZ
 K JSONOUT
 S WDGT=""
 S YDUZ=$G(DUZ)
 S:WDGT="" WDGT=1  ;For first instance of this parameter. Most likely always 1
 S DUZPAR=YDUZ_";VA(200,"
 D GETWP^XPAR(.WPARR,DUZPAR,"YSB MBC INSTRUMENT SELECTION",WDGT)
 I '$D(WPARR) D  Q
 . S JSONOUT(1)="{}"  ;Need to define Default
 . ;D MBCIDFLT(.JSONOUT)
 I ($D(WPARR)=1),(WPARR="") D  Q
 . S JSONOUT(1)="{}"  ;Need to define Default
 . ;D MBCIDFLT(.JSONOUT)
 S II="" F  S II=$O(WPARR(II)) Q:II=""  D
 . S JSONOUT(II)=WPARR(II,0)
 Q
MBCIDFLT(JSONOUT) ;Generate Default MBC Instrument List
 Q
GETUSRP(JSONOUT) ;
 ; Given user DUZ and Widget, get the Patient Selection Criteria
 N DATAOUT,WPARR,DUZPAR,WDGT,YDUZ
 ;S YDUZ=$P(PARMS,"/"),WDGT=$P(PARMS,"/",2)
 K JSONOUT
 S WDGT=""
 S YDUZ=$G(DUZ)
 S:WDGT="" WDGT=1  ;For first instance of this parameter. Most likely always 1
 S DUZPAR=YDUZ_";VA(200,"
 D GETWP^XPAR(.WPARR,DUZPAR,"YSB USER COLUMN PREFERENCE",WDGT)
 I '$D(WPARR) D  Q
 . D DFLTUP(.JSONOUT)
 I ($D(WPARR)=1),(WPARR="") D  Q
 . D DFLTUP(.JSONOUT)
 S II="" F  S II=$O(WPARR(II)) Q:II=""  D
 . S JSONOUT(II)=WPARR(II,0)
 Q
WEBGUSRP(ARGS,RESULTS)  ;MHA Web call to get User Preferences
 N JSONOUT
 D GETUSRP(.JSONOUT)
 D TOTMP^YSBRPC(.JSONOUT)
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
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
 ;=============================================
 ;Set User Preferences
 ;
HRWSEL(JSONOUT,IN) ;
 ; Save PATIENT SELECTION CRITERIA
 ; High Risk Widget
 Q  ;Not used yet
 N WPARR,II,YDUZ,JSON,CNT,JSFLG,PDEF
 N DATAOUT
 N FDA,IENS,FDAIEN,MSG
 N INSTANCE
 S CNT=0,YDUZ=""
 ;In the IN array the body starts at line 4
 S II=3 F  S II=$O(IN(II)) Q:II=""  D
 . S CNT=CNT+1,JSON(CNT)=IN(II)
 . ;I IN(II)["userId" S YDUZ=$$EXTPROP(STR,"""userId"":")
 S YDUZ=$G(DUZ)
 S PDEF=$O(^XTV(8989.51,"B","YSB HR SELECTION CRITERIA",""))
 I PDEF="" D ERRHND("high_risk_selection","Parameter not defined") Q
 S INSTANCE=1
 S YDUZ=YDUZ_";VA(200,"
 D EN^XPAR(YDUZ,PDEF,INSTANCE,.JSON,.MSG)
 S DATAOUT("high_risk_selection",1,"status")="OK"
 D ENCODE^YSBJSON("DATAOUT","JSONOUT","ERRARY")
 Q
MBCWSEL(JSONOUT,IN) ;
 ; Save PATIENT SELECTION CRITERIA
 ; Measurement Based Care (MBC) widget
 N WPARR,II,YDUZ,JSON,CNT,JSFLG,PDEF
 N DATAOUT
 N FDA,IENS,FDAIEN,MSG
 N INSTANCE,STRT,DONE
 S STRT="",DONE=""
 S II=0 F  S II=$O(IN(II)) Q:II=""!DONE  D
 . I IN(II)="" S STRT=II,DONE=1
 I STRT="" D ERRHND("mbc_selection","Data not found") Q
 S CNT=0,YDUZ=""
 ;In the IN array the body starts at line 4
 S II=STRT F  S II=$O(IN(II)) Q:II=""  D
 . S CNT=CNT+1,JSON(CNT)=IN(II)
 S YDUZ=$G(DUZ)
 S PDEF=$O(^XTV(8989.51,"B","YSB MBC SELECTION CRITERIA",""))
 I PDEF="" D ERRHND("mbc_selection","Parameter not defined") Q
 S INSTANCE=1
 S YDUZ=YDUZ_";VA(200,"
 D EN^XPAR(YDUZ,PDEF,INSTANCE,.JSON,.MSG)
 S DATAOUT("mbc_selection",1,"status")="OK"
 D ENCODE^YSBJSON("DATAOUT","JSONOUT","ERRARY")
 Q
ILST(JSONOUT,IN) ;
 ; Save the MBC INSTRUMENT SELECTION LIST
 ; Measurement Based Care (MBC) widget
 N WPARR,II,YDUZ,JSON,CNT,JSFLG,PDEF
 N DATAOUT
 N FDA,IENS,FDAIEN,MSG
 N INSTANCE,STRT,DONE
 S CNT=0,YDUZ="",STRT="",DONE=""
 S II=0 F  S II=$O(IN(II)) Q:II=""!DONE  D
 . I IN(II)="" S STRT=II,DONE=1
 I STRT="" D ERRHND("mbc_instrument_selection","Data not found") Q
 ;In the IN array the body starts at line 4
 S II=3 F  S II=$O(IN(II)) Q:II=""  D
 . S CNT=CNT+1,JSON(CNT)=IN(II)
 S YDUZ=$G(DUZ)
 S PDEF=$O(^XTV(8989.51,"B","YSB MBC INSTRUMENT SELECTION",""))
 I PDEF="" D ERRHND("mbc_instrument_selection","Parameter not defined") Q
 S INSTANCE=1
 S YDUZ=YDUZ_";VA(200,"
 D EN^XPAR(YDUZ,PDEF,INSTANCE,.JSON,.MSG)
 S DATAOUT("mbc_instrument_selection",1,"status")="OK"
 D ENCODE^YSBJSON("DATAOUT","JSONOUT","ERRARY")
 Q
USRP(JSONOUT,IN) ;
 ; Save PATIENT Column preference
 ; Column preference settings
 N WPARR,II,YDUZ,JSON,CNT,JSFLG,PDEF
 N DATAOUT
 N FDA,IENS,FDAIEN,MSG
 N INSTANCE
 S CNT=0,YDUZ=""
 ;In the IN array the body starts at line 4
 S II=2 F  S II=$O(IN(II)) Q:II=""  D
 . S CNT=CNT+1,JSON(CNT)=IN(II)
 S JSON="DASH COL PREF"
 S YDUZ=$G(DUZ)
 S PDEF=$O(^XTV(8989.51,"B","YSB USER COLUMN PREFERENCE",""))
 I PDEF="" D ERRHND("user_preference","Parameter not defined") Q
 S INSTANCE=1
 S YDUZ=YDUZ_";VA(200,"
 D EN^XPAR(YDUZ,PDEF,INSTANCE,.JSON,.MSG)
 S DATAOUT("user_preference",1,"status")="OK"
 D ENCODE^YSBJSON("DATAOUT","JSONOUT","ERRARY")
 Q
EXTPROP(STR,PROP) ;
 ; Extract the VALUE from the string based on the PROPerty
 N VAL
 S VAL=$P(STR,PROP,2)
 I $E(VAL)="""" S VAL=$E(VAL,2,$L(VAL))
 I $E(VAL,$L(VAL))="""" S VAL=$E(VAL,1,$L(VAL)-1)
 Q VAL
ERRHND(TYP,MSG) ;
 K DATAOUT
 S DATAOUT(TYP,1,"line")=MSG
 D ENCODE^YSBJSON("DATAOUT","JSONOUT","ERRARY")
 Q
