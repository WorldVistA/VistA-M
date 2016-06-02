HMPCPRS ;SLC/AGP,ASMR/RRB - CPRS RPC for;9/21/12 5:57pm
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
RPC(HMPOUT,PARAMS) ; Process request via RPC instead of CSP
 N X,REQ,HMPCNT,HMPSITE,HMPUSER,HMPDBUG,HMPSTA
 S HMPCNT=0
 S HMPUSER=DUZ,HMPSITE=DUZ(2),HMPSTA=$$STA^XUAF4(DUZ(2))
 S X="" F  S X=$O(PARAMS(X)) Q:X=""  S REQ(X,1)=PARAMS(X)
 ;
COMMON ; Come here for both CSP and RPC Mode
 ;
 N CMD
 S CMD=$G(REQ("command",1))
 ;
 ; returns an order structure for change orders
 ; or places an order if auto-accept QO
 I CMD="alerts" D  G OUT
 . D ALERTS(.HMPOUT)
 ;
 I CMD="reminders" D  G OUT
 .D EVALLIST^HMPPXRM(.HMPOUT,$$VAL("patientId"),$$VAL("userId"),$$VAL("location"))
 ;
OUT ;
END ;
 ;
BLDINFO(INFO) ;
 N X
 S X="" F  S X=$O(REQ(X)) Q:X=""  D
 .S INFO(X)=REQ(X,1)
 Q
 ;
VAL(X) ; return value from request
 Q $G(REQ(X,1))
 ;
ALERTS(HMPOUT) ;
 N ALERT,CNT,ERROR,NODE,NUM,RESULT,HMPORY
 K ^TMP("HMPALERTS",$J),^TMP("HMPOUT",$J)
 ;S HMPOUT=$NA(^TMP("HMPOUT",$J))
 D FASTUSER^ORWORB(.HMPORY)
 ;ZW HMPORY
 S CNT=0,NUM=1 F  S CNT=$O(@HMPORY@(CNT)) Q:CNT'>0  D
 .S NODE=$G(@HMPORY@(CNT))
 .K ALERT
 .I $P(NODE,U)="I" S ALERT("infoOnly")="I"
 .S ALERT("patient")=$P(NODE,U,2),ALERT("urgency")=$P(NODE,U,4),ALERT("dateTime")=$P(NODE,U,5)
 .I $P(NODE,U,3)'="" S ALERT("location")=$P(NODE,U,3)
 .S ALERT("message")=$P(NODE,U,6)
 .I $P(NODE,U,8)'="" S ALERT("action")=$P(NODE,U,8)
 .S ALERT("mustBeProcess")=$S($P(NODE,U,9)="yes":"false",1:"true")
 .I $P(NODE,U,10)'="" S ALERT("forwardBy")="true"
 .M ^TMP("HMPALERTS",$J,"data","alerts",NUM,"alert")=ALERT S NUM=NUM+1
 D ENCODE^HMPJSON($NA(^TMP("HMPALERTS",$J)),"HMPOUT","ERROR")
 Q
 ;
