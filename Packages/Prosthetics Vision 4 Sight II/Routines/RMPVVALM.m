RMPVVALM ; OIT/JDA - SCAMP runtime support; Nov 17, 2024@23:35:37
 ;;1.0;PROSTHETICS VISION 4 SIGHT II;**2**;Jan 31, 2025;Build 38
 ;
 ; WARNING - This functionality is largely untested.
 Q
EN(NAME) ; Mimic call to EN^VALM, only make it non-interactive
 D WRITE^RMPVIO("VALM^"_NAME)
 N NAMEIEN S NAMEIEN=$O(^SD(409.61,"B",NAME,""))
 N PROCM S PROCM=$P(^SD(409.61,NAMEIEN,0),"^",10)
 N PROCMIEN S PROCMIEN=$O(^ORD(101,"B",PROCM,""))
 N ITEM,TARGET S ITEM=0
 F  S ITEM=$O(^ORD(101,PROCMIEN,10,ITEM)) Q:'ITEM  D
 .N ITEMIEN S ITEMIEN=$P(^ORD(101,PROCMIEN,10,ITEM,0),"^")
 .N ENTCODE S ENTCODE=$G(^ORD(101,ITEMIEN,20))
 .I $E(ENTCODE,1,2)="D " D  ; TODO - allow DO, not just D
 ..N DOARG S DOARG=$P($E(ENTCODE,3,99),")")
 ..; TODO - validate that it's a simple DO call
 ..N EREF S EREF=$P(DOARG,"(")
 ..N RTN S RTN=$P(EREF,"^",2) Q:RTN=""
 ..S $P(EREF,"^",2)=$$NEWNAME^RMPVRT(RTN)
 ..I $T(@EREF)'="" N SPEC S SPEC(RTN)=$$NEWNAME^RMPVRT(RTN) S ENTCODE=$$REPLACE^XLFSTR(DOARG,.SPEC)
 .N MNEM S MNEM=$P(^ORD(101,PROCMIEN,10,ITEM,0),"^",2)
 .S TARGET(MNEM)=ENTCODE
 N CMD S CMD=""
 ;  input:   NAME := free text name of list template or routine call
 ;          PARMS := parameter list
 I $G(PARMS)["T" K VALMEVL ; kill if 'T'op level
 D INIT^VALM0(.NAME,$G(PARMS)) G ENQ:$D(VALMQUIT)
 ; -- build list of items
 I $G(^TMP("VALM DATA",$J,VALMEVL,"INIT"))]"" X ^("INIT") G ENQ:$D(VALMQUIT)
 ; -- start event loop
 S VALMBCK="R" D ASK
 X:$G(^TMP("VALM DATA",$J,VALMEVL,"FNL"))]"" ^("FNL")
 ;
ENQ D POP^VALM0 ; Exit menu
 Q
ASK ; Ask for user input via RMPVIO instead of a READ command.
 F  D  Q:CMD="QUIT"
 .D READ^RMPVIO(.CMD)
 .Q:CMD="QUIT"
 .;D LOG^RMPVTEST("VALM command '"_CMD_"' would invoke '"_$G(TARGET(CMD))_"'")
 Q
