DG531076P ;ISP/RFR - PATCH 1076 POST-INIT;May 21, 2018@16:23
 ;;5.3;Registration;**1076**;Aug 13, 1993;Build 4
 ;
POST ; -- post init to build xrefs
 D BMES^XPDUTL("  Creating new-style indexes in the PTF (#45) file...")
 D TOP
 D 601
 D 401
 Q
 ;
TOP ; -- AICP index on 401P node fields
 N DGPTXR,DGPTRES,DGPTOUT,X
 S DGPTXR("FILE")=45
 S DGPTXR("NAME")="AICP"
 S DGPTXR("TYPE")="MU"
 S DGPTXR("USE")="A"
 S DGPTXR("EXECUTION")="R"
 S DGPTXR("SHORT DESCR")="Notify packages of ICD procedure code change."
 S DGPTXR("DESCR",1)="This cross-reference will notify subscribing packages via protocol"
 S DGPTXR("DESCR",2)="DG PTF ICD PROCEDURE NOTIFIER when an ICD procedure code is added,"
 S DGPTXR("DESCR",3)="edited, or removed."
 S DGPTXR("SET")="D NOTIFYP^DGPTDD(.X1,.X2,.DA,45,""DISCHARGE"",""SET"")"
 S DGPTXR("KILL")="D NOTIFYP^DGPTDD(.X1,.X2,.DA,45,""DISCHARGE"",""KILL"")"
 S DGPTXR("WHOLE KILL")="Q"
 S DGPTXR("VAL",1)=.01    ;Patient
 S DGPTXR("VAL",2)=11     ;Type of Record
 S DGPTXR("VAL",3)=45.01  ;Procedure n
 S DGPTXR("VAL",4)=45.02
 S DGPTXR("VAL",5)=45.03
 S DGPTXR("VAL",6)=45.04
 S DGPTXR("VAL",7)=45.05
 D CREIXN^DDMOD(.DGPTXR,"kW",.DGPTRES,"DGPTOUT")
 S X="    AICP: "_$S(+$G(DGPTRES):"DONE",1:"FAILED")
 D MES^XPDUTL(X)
 Q
 ;
601 ; -- AICPP index on 601 multiple
 N DGPTXR,DGPTRES,DGPTOUT,I
 S DGPTXR("FILE")=45.05
 S DGPTXR("NAME")="AICPP"
 S DGPTXR("TYPE")="MU"
 S DGPTXR("USE")="A"
 S DGPTXR("EXECUTION")="R",DGPTXR("ACTIVITY")=""
 S DGPTXR("SHORT DESCR")="Notify packages of ICD procedure code change."
 S DGPTXR("DESCR",1)="This cross-reference will notify subscribing packages via protocol"
 S DGPTXR("DESCR",2)="DG PTF ICD PROCEDURE NOTIFIER when an ICD procedure code is added,"
 S DGPTXR("DESCR",3)="edited, or removed."
 S DGPTXR("SET")="D NOTIFYP^DGPTDD(.X1,.X2,.DA,45,""PROCEDURE"",""SET"")"
 S DGPTXR("KILL")="D NOTIFYP^DGPTDD(.X1,.X2,.DA,45,""PROCEDURE"",""KILL"")"
 S DGPTXR("WHOLE KILL")="Q"
 S DGPTXR("VAL",1)=.01
 ; Procedure Codes 1-25
 F I=2:1:26 S DGPTXR("VAL",I)=I+2
 D CREIXN^DDMOD(.DGPTXR,"kW",.DGPTRES,"DGPTOUT")
 S X="    AICPP: "_$S(+$G(DGPTRES):"DONE",1:"FAILED")
 D MES^XPDUTL(X)
 Q
 ;
401 ; -- AICPS index on 401 multiple
 N DGPTXR,DGPTRES,DGPTOUT,I
 S DGPTXR("FILE")=45.01
 S DGPTXR("NAME")="AICPS"
 S DGPTXR("TYPE")="MU"
 S DGPTXR("USE")="A"
 S DGPTXR("EXECUTION")="R",DGPTXR("ACTIVITY")=""
 S DGPTXR("SHORT DESCR")="Notify packages of ICD diagnosis code change."
 S DGPTXR("DESCR",1)="This cross-reference will notify subscribing packages via protocol"
 S DGPTXR("DESCR",2)="DG PTF ICD PROCEDURE NOTIFIER when an ICD procedure code is added,"
 S DGPTXR("DESCR",3)="edited, or removed."
 S DGPTXR("SET")="D NOTIFYP^DGPTDD(.X1,.X2,.DA,45,""SURGERY"",""SET"")"
 S DGPTXR("KILL")="D NOTIFYP^DGPTDD(.X1,.X2,.DA,45,""SURGERY"",""KILL"")"
 S DGPTXR("WHOLE KILL")="Q"
 S DGPTXR("VAL",1)=.01
 ; Operation Codes 1-25
 F I=2:1:26 S DGPTXR("VAL",I)=I+6
 D CREIXN^DDMOD(.DGPTXR,"kW",.DGPTRES,"DGPTOUT")
 S X="    AICPS: "_$S(+$G(DGPTRES):"DONE",1:"FAILED")
 D MES^XPDUTL(X)
 Q
