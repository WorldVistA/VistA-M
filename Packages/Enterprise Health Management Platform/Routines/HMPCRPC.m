HMPCRPC ;SLC/AGP,ASMR/RRB - Generic RPC controller for HMP;11/7/12 5:42pm
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CHAINRPC(HMPRES,PARAMS) ; Chain multiple rpcs into one call
 N CITER,RSP,PID
 S CITER="" F  S CITER=$O(PARAMS("commandList",CITER)) Q:CITER=""  D
 . N SUBCMD,SUBRSP,X
 . S X=""
 . F  S X=$O(PARAMS("commandList",CITER,X)) Q:X=""  M SUBCMD(X)=PARAMS("commandList",CITER,X)
 . D CHAINCMD(.SUBCMD,.SUBRSP)
 . I $D(SUBRSP) D DECODE^HMPJSON("SUBRSP","RSP(SUBCMD(""command""))","^JMCERR") I 1
 . I '$TEST S RSP(SUBCMD("command"))=""
 D ENCODE^HMPJSON("RSP","HMPRES","^JMCERR")
 Q
RPC(HMPRES,PARAMS) ; Process request via RPC instead of CSP
 N X,REQ,HMPVAL,HMPCNT,HMPSITE,HMPUSER,HMPDBUG,HMPSTA
 ;S HMPXML=$NA(^TMP($J,"HMP RESULTS")) K @HMPXML
 S HMPCNT=0
 ;S HMPUSER=DUZ,HMPSITE=DUZ(2),HMPSTA=$$STA^XUAF4(DUZ(2))
 S X="" F  S X=$O(PARAMS(X)) Q:X=""  I X'="value" S REQ(X,1)=PARAMS(X)
 I $D(PARAMS("value")) M HMPVAL=PARAMS("value")
 ;
COMMON ; Come here for both CSP and RPC Mode
 ; 
 N CMD
 S CMD=$G(REQ("command",1))
 ;
 I CMD="saveParam" D  G OUT
 . D PUTPARAM^HMPPARAM(.HMPRES,.HMPVAL,"")
 ;
 I CMD="saveParamByUid" D  G OUT
 . D PUTBYUID^HMPPARAM(.HMPRES,$$VAL("uid"),.HMPVAL)
 ;
 I CMD="getParam" D  G OUT
 . D GETBYUID^HMPPARAM(.HMPRES,$$VAL("uid"))
 ;
 I CMD="clearParam" D  G OUT
 . D DELPARAM^HMPPARAM(.HMPRES,$$VAL("uid"))
 ;
 I CMD="getAllParam" D  G OUT
 .D GETALPAR^HMPPARAM(.HMPRES,$$VAL("entity"),$$VAL("entityId"),$$VAL("getValues"))
 ;
 I CMD="getUserInfo" D  G OUT
 .D GETUSERI^HMPCRPC1(.HMPRES,$$VAL("userId"))
 ;
 I CMD="getPatientInfo" D  G OUT
 .D GETPATI^HMPCRPC1(.HMPRES,$$VAL("patientId"))
 ;
 I CMD="getPatientChecks" D  G OUT
 .D CHKS^HMPFPTC(.HMPRES,$$VAL("patientId"))
 ;
 I CMD="logPatientAccess" D  G OUT
 .D LOG^HMPFPTC(.HMPRES,$$VAL("patientId"))
 ;
 I CMD="addTask" D  G OUT
 .D PUT^HMPDJ1(.HMPRES,$$VAL("patientId"),$$VAL("type"),.HMPVAL)
 ;
 I CMD="getReminderList" D  G OUT
 .D REMLIST^HMPPXRM(.HMPRES,$$VAL("user"),$$VAL("location"))
 ;
 I CMD="evaluateReminder" D  G OUT
 .D EVALREM^HMPPXRM(.HMPRES,$$VAL("patientId"),$$VAL("uid"))
 ;
 I CMD="getDefaultPatientList" D  G OUT
 .D GETDLIST^HMPROS8(.HMPRES,$$VAL("server"))
 ;
 I CMD="getWardList" D  G OUT
 .D GETWLIST^HMPROS8(.HMPRES,$$VAL("server"),$$VAL("id"))
 ;
 I CMD="getClinicList" D  G OUT
 .D GETCLIST^HMPROS8(.HMPRES,$$VAL("server"),$$VAL("id"),$$VAL("start"),$$VAL("end"))
 ;
OUT ; output the XML
 ;S HMPRES=$G(RESULT)
 I '$D(HMPRES) S HMPRES="{}"
END Q
 ;
VAL(X) ; return value from request
 Q $G(REQ(X,1))
 ;
CHAINCMD(HMPCMD,HMPRSP) ; Do one command in chain
 ; 
 N CMD
 S CMD=$G(HMPCMD("command"))
 I CMD="getParam" D GETBYUID^HMPPARAM(.HMPRSP,$G(HMPCMD("uid")))
 I CMD="getPatientInfo" D GETPATI^HMPCRPC1(.HMPRSP,$G(HMPCMD("patientId")))
 I CMD="getPatientChecks" D CHKS^HMPFPTC(.HMPRSP,$G(HMPCMD("patientId")))
 I CMD="saveParam" D PUTPARAM^HMPPARAM(.HMPRSP,$G(HMPCMD("value")),"")
 I CMD="saveParamByUid" D PUTBYUID^HMPPARAM(.HMPRSP,$G(HMPCMD("uid")),$G(HMPCMD("value")))
 Q
