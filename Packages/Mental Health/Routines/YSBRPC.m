YSBRPC ;SLC/DJE - MHA DASHBOARD ; Apr 01, 2021@16:33
 ;;5.01;MENTAL HEALTH;**202**;Dec 30, 1994;Build 47
 ;
 ; Routine retrieves Settings, Views, Widgets and User information
 Q
RESTFUL(OUT,IN) ;main RPC that interprets RESTful calls
 I $G(IN(1))="" D LOADDB(.OUT) Q
 ;Connector
 I $E(IN(1),1,27)="GET /api/dashboard/getconn/" D GETCONN^YSBRPC(.OUT)
 ;HR
 I $E(IN(1),1,34)="GET /api/dashboard/highrisk/cssrs/" D GETRPRT^YSBDD1(.OUT,+$P(IN(1),"GET /api/dashboard/highrisk/cssrs/",2))
 I $E(IN(1),1,33)="GET /api/dashboard/highrisk/hrpp/" D HRPTPROF^YSBDD1(.OUT,+$P(IN(1),"GET /api/dashboard/highrisk/hrpp/",2))
 I $E(IN(1),1,33)="GET /api/dashboard/highrisk/note/" D GETNOTE^YSBDD1(.OUT,+$P(IN(1),"GET /api/dashboard/highrisk/note/",2))
 ;
 I $E(IN(1),1,28)="GET /api/dashboard/userpref/" D GETUSRP^YSBPREFS(.OUT)
 I $E(IN(1),1,29)="POST /api/dashboard/userpref/" D USRP^YSBPREFS(.OUT,.IN)
 ;
 Q
 ;I $E(IN(1),1,40)="GET /api/dashboard/highrisk/selcriteria/" D GETHRSEL^YSBDD1(.OUT,+$P(IN(1),"GET /api/dashboard/highrisk/selcriteria/",2))
 ;I $E(IN(1),1,41)="POST /api/dashboard/highrisk/selcriteria/" D HRWSEL^YSBDD2(.OUT,.IN)
 ;;MBC
 ;I $E(IN(1),1,28)="GET /api/dashboard/mbc/data/" D MBC0^YSBWMBC(.OUT)
 ;I $E(IN(1),1,27)="GET /api/dashboard/mbc/prf/" D PRF^YSBDD2(.OUT,+$P(IN(1),"GET /api/dashboard/mbc/prf/",2))
 ;I $E(IN(1),1,30)="GET /api/dashboard/mbc/visits/" D VST^YSBDD2(.OUT,+$P(IN(1),"GET /api/dashboard/mbc/visits/",2))
 ;I $E(IN(1),1,35)="GET /api/dashboard/mbc/selcriteria/" D GETMBSEL^YSBPREFS(.OUT)
 ;I $E(IN(1),1,36)="POST /api/dashboard/mbc/selcriteria/" D MBCWSEL^YSBPREFS(.OUT,.IN)
 ;I $E(IN(1),1,29)="GET /api/dashboard/mbc/ilist/" D GETILST^YSBPREFS(.OUT)
 ;I $E(IN(1),1,30)="POST /api/dashboard/mbc/ilist/" D ILST^YSBPREFS(.OUT,.IN)
 ;
LOADDB(JSONOUT) ;Load dashboard data. Currently close to everything is loaded. User data, widget and widget data.
 N DATAOUT,DATAIN,ERRARY,I
 D GETUSER(.DATAOUT) ;get the user data 
 D GETWDGT(.DATAOUT) ;process if call from dashboard 
 D SELPATS(.DATAOUT) ;get the patients
 I '$D(DATAOUT("data",1,"patient_name")) D
 . S DATAOUT("data",1)=""
 D ENCODE^YSBJSON("DATAOUT","JSONOUT","ERRARY")
 ;I '$D(DATAOUT("data",1,"patient_name")) D NOPAT
 Q
WEBWIDG(ARGS,RESULTS) ;Load dashboard data for a widget embedded in MHA Web
 N WNAME,DATAOUT,ERRARY
 S WNAME=$G(ARGS("widgetName"))
 D GETUSER(.DATAOUT) ;get the user data 
 D GETWDGT(.DATAOUT,WNAME) ;process if call from dashboard 
 D SELPATS(.DATAOUT) ;get the patients
 D ENCODE^YSBJSON("DATAOUT","JSONOUT","ERRARY")
 D TOTMP(.JSONOUT)
 S RESULTS=$NA(^TMP("YTQ-JSON",$J))
 Q
TOTMP(JSONOUT) ; move JSONOUT array to ^TMP("YTQ-JSON)
 N II,JJ
 S JJ=$O(^TMP("YTQ-JSON",$J,"A"),-1)
 S II=0 F  S II=$O(JSONOUT(II)) Q:II=""  D
 . S JJ=JJ+1,^TMP("YTQ-JSON",$J,JJ,0)=JSONOUT(II)
 Q
NOPAT ; no patients but JSON utility sets up "data":[""]. Needs to be "data":[]
 Q
 N II,BEF,AFT,PSTR,XSTR,DUN
 S PSTR="""data"":[""""]",DUN=0
 S II="" F  S II=$O(JSONOUT(II)) Q:II=""!(DUN)  D
 . Q:JSONOUT(II)'[PSTR
 . S BEF=$P(JSONOUT(II),PSTR),AFT=$P(JSONOUT(II),PSTR,2)
 . S JSONOUT(II)=BEF_"""data"":[]"_AFT,DUN=1
 Q
 ;
GETUSER(DATAOUT) ;user info
 ;Entry point for YSB GET USER RPC
 ;input DUZ as internal ien file 200 for user to check [optional default is current user]
 ;      KEY as name of security key to check 
 N TODAY,HASSITE,SITE,I,Y,X
 S X="TODAY" D ^%DT S TODAY=Y
 S HASSITE=$$DIV4^XUSER(.SITE,DUZ)
 I 'HASSITE I $G(DUZ(2))]"" S SITE(DUZ(2))=""  ;Use Default site if not explicitly defined.
 Q:'$D(SITE)
 S DATAOUT("user","id")=DUZ
 ;S DATAOUT("user","name")=$P($G(^VA(200,DUZ,0)),U,1)
 S I=0 F  S I=$O(SITE(I)) Q:'I  D
 .S DATAOUT("user","site",I,"id")=$P(SITE(I),U)
 S DATAOUT("user","time")=TODAY
 Q
 ;
CHKCLIN(WIEN,ERR)  ; Check if clinic is mental health used in get user and mh next appt and mh last appt
 N CLINIC,N0,TOPCD,TOPNO
 S (CLINIC,TOPCD,TOPNO)=""
 I 'WIEN S ERR="NO IEN" Q 0
 S N0=$G(^SC(WIEN,0))
 S TOPCD=$P(N0,U,7)
 I TOPCD S TOPNO=$$GET1^DIQ(40.7,TOPCD,1) ;get stop code number to check for mental health 
 I (TOPNO>=500),(TOPNO<600) Q 1
 ;credit stop code could be mental health, not sure if I should only do this for main stop code=telephone
 S TOPCD=$P(N0,U,18)
 I TOPCD S TOPNO=$$GET1^DIQ(40.7,TOPCD,1) ;get stop code number to check for mental health 
 I (TOPNO>=500),(TOPNO<600) Q 1
 S ERR="NOT MENTAL HEALTH"
 Q 0
 ;
GETWDGT(DATAOUT,WNAME)  
 N ID,COLSEQ,LOCATION,WIDGETN0,FIELDN0,COLUMN,SHOW,LOCID,SUBCOL,SUBCOLSEQ,SUBFIELDN0
 N INSTID,INSTSEQ,MNGRP,MNSCL,SUB
 N INSTS,ISTR,IIEN,ILAB,ILAB2,WIN1,COLCNT,IN0,YSDT,NOW
 S NOW=$$NOW^XLFDT()
 S WNAME=$G(WNAME)
 S YSDT=$P(NOW,".",1)
 S ID=0 F  S ID=$O(^YSD(605.1,ID)) Q:'ID  D  ;starting point for load of all widgets
 .S WIDGETN0=^YSD(605.1,ID,0)
 .Q:$P(WIDGETN0,U)="MBC"
 .I WNAME]"",($P(WIDGETN0,U)'=WNAME) Q  ;If widget name passed in, only return Widget definition for that Widget
 .S DATAOUT("widgets",ID,"id")=ID
 .S DATAOUT("widgets",ID,"name")=$P(WIDGETN0,U)
 .S COLSEQ=0 F  S COLSEQ=$O(^YSD(605.1,ID,1,"AC",COLSEQ)) Q:'COLSEQ  D
 ..S COLUMN=$O(^YSD(605.1,ID,1,"AC",COLSEQ,""))
 ..S FIELDN0=$G(^YSD(605.1,ID,1,COLUMN,0))
 ..S DATAOUT("widgets",ID,"columns",COLSEQ,"id")=COLUMN
 ..S DATAOUT("widgets",ID,"columns",COLSEQ,"name")=$P(FIELDN0,U)
 ..S DATAOUT("widgets",ID,"columns",COLSEQ,"label")=$P(FIELDN0,U,2)
 ..S SHOW="true"
 ..I $P(FIELDN0,U,4)=1 S SHOW="false" ;if hide by default then don't show
 ..S DATAOUT("widgets",ID,"columns",COLSEQ,"options","display")=SHOW
 ..S SUBCOLSEQ=0 F  S SUBCOLSEQ=$O(^YSD(605.1,ID,1,COLUMN,1,"AC",SUBCOLSEQ)) Q:'SUBCOLSEQ  D
 ...S SUBCOL=$O(^YSD(605.1,ID,1,COLUMN,1,"AC",SUBCOLSEQ,""))
 ...S SUBFIELDN0=$G(^YSD(605.1,ID,1,COLUMN,1,SUBCOLSEQ,0))
 ...S DATAOUT("widgets",ID,"columns",COLSEQ,"subcol",SUBCOLSEQ,"options","display")="true"  ;Set up default def in 605.1?
 ...S DATAOUT("widgets",ID,"columns",COLSEQ,"subcol",SUBCOLSEQ,"id")=SUBCOL
 ...S DATAOUT("widgets",ID,"columns",COLSEQ,"subcol",SUBCOLSEQ,"name")=$P(SUBFIELDN0,U)
 ...S DATAOUT("widgets",ID,"columns",COLSEQ,"subcol",SUBCOLSEQ,"label")=$P(SUBFIELDN0,U,2)
 .;Leave in sub-column process for potential High Risk use
 .I ID=4 D  ;Add on the Instrument Column/Sub-Columns for the MBC Widget
 ..S COLCNT=$O(DATAOUT("widgets",ID,"columns","A"),-1)
 ..K INSTS
 ..D IDFLT^YSBWHIG2(.INSTS)  ;Don't show all instruments
 ..S INSTSEQ="" F  S INSTSEQ=$O(INSTS(INSTSEQ)) Q:'INSTSEQ  D
 ...S ISTR=INSTS(INSTSEQ),IIEN=$P(ISTR,U),ILAB=$P(ISTR,U,2)
 ...S MNGRP=$G(INSTS(INSTSEQ,"MNGRP")),MNSCL=$G(INSTS(INSTSEQ,"MNSCL"))
 ...S ILAB2=ILAB_$S(MNSCL]"":" / ",1:"")_MNSCL  ;Add on display scale.
 ...S COLCNT=COLCNT+1
 ...S DATAOUT("widgets",ID,"columns",COLCNT,"id")=COLCNT
 ...S DATAOUT("widgets",ID,"columns",COLCNT,"name")=ILAB
 ...S DATAOUT("widgets",ID,"columns",COLCNT,"label")=ILAB  ;ILAB2
 ...S DATAOUT("widgets",ID,"columns",COLCNT,"insttype")=INSTS(INSTSEQ,"TYPE")
 ...S DATAOUT("widgets",ID,"columns",COLCNT,"options","display")=$G(INSTS(INSTSEQ,"DISPLAY"))
 ...F SUB="1^score^Score","2^date^Date","3^trend^Trend" D
 ....S DATAOUT("widgets",ID,"columns",COLCNT,"subcol",$P(SUB,U),"options","display")=$G(INSTS(INSTSEQ,"DISPLAY"))
 ....S DATAOUT("widgets",ID,"columns",COLCNT,"subcol",$P(SUB,U),"id")=$P(SUB,U)
 ....S DATAOUT("widgets",ID,"columns",COLCNT,"subcol",$P(SUB,U),"name")=$P(SUB,U,2)
 ....S DATAOUT("widgets",ID,"columns",COLCNT,"subcol",$P(SUB,U),"label")=$P(SUB,U,3)
 .S INSTSEQ=0 F  S INSTSEQ=$O(^YSD(605.1,ID,3,INSTSEQ)) Q:'INSTSEQ  D
 ..S INSTID=^YSD(605.1,ID,3,INSTSEQ,0)
 ..Q:INSTID=""  ;Should not occur
 ..Q:'$D(^YTT(601.71,INSTID))  ;Instrument not installed in this environment
 ..S DATAOUT("widgets",ID,"instrumentList",INSTSEQ,"id")=INSTID
 ..S DATAOUT("widgets",ID,"instrumentList",INSTSEQ,"name")=$P(^YTT(601.71,INSTID,0),U)
 .I ID=4 D  ;if widget is MBC
 ..D GETLOCS^YSBWHIG2(.DATAOUT,ID)
 Q
 ;
SELPATS(DATAOUT) ;
 N WIDGETNUM
 S WIDGETNUM=0 F  S WIDGETNUM=$O(DATAOUT("widgets",WIDGETNUM)) Q:'WIDGETNUM  D
 .N WIDGETNAME
 .S WIDGETNAME=DATAOUT("widgets",WIDGETNUM,"name")
 .I WIDGETNAME="HIGH RISK" D HIGHRISK^YSBWHIGH(.DATAOUT)
 .;I WIDGETNAME="MBC" D MBC^YSBWMBC(.DATAOUT)
 Q
HRINIT(SAFHEAD,SAFDCL,SAFREV,SAFSCNO,SAFSCYES,CSREHEAD,CSRENEW,CSREUPD,SITES) ;
 D GETLST^XPAR(.SAFHEAD,"ALL","YSB SAFETY PLAN HEADER TEXT")
 D GETLST^XPAR(.SAFDCL,"ALL","YSB SAFETY PLAN DECLINE")
 D GETLST^XPAR(.SAFREV,"ALL","YSB SAFETY PLAN REVIEWED")
 D GETLST^XPAR(.SAFSCNO,"ALL","YSB SAFETY PLAN SOC CONT NO")
 D GETLST^XPAR(.SAFSCYES,"ALL","YSB SAFETY PLAN SOC CONT YES")
 D GETLST^XPAR(.CSREHEAD,"ALL","YSB CSRE HEADER TEXT")
 D GETLST^XPAR(.CSRENEW,"ALL","YSB CSRE NEW EVALUATION")
 D GETLST^XPAR(.CSREUPD,"ALL","YSB CSRE UPDATE EVALUATION")
 D DIV4^XUSER(.SITES,DUZ)
 Q
 ;D GETLST^XPAR(.SAFHFC,"SYS","YSB SAFETY PLAN HF CATEGORY")
 ;D GETLST^XPAR(.CSREHFC,"SYS","YSB CSRE HF CATEGORY")
 ;D GETLST^XPAR(.CSRETITL,"SYS","YSB CSRE DOCUMENT TITLE")
 ;
GETCONN(JSONOUT) ;Respond to the connection check
 N DATAOUT,ERRARY
 S DATAOUT("connection","status")="OK"
 S DATAOUT("connection","datetime")=$$HTE^XLFDT($H,2)
 D ENCODE^YSBJSON("DATAOUT","JSONOUT","ERRARY")
 Q
