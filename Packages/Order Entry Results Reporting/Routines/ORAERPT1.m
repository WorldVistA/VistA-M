ORAERPT1 ; SPFO/AJB - Alert Enhancements Reports ;Feb 21, 2020@13:04:05
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**518**;Dec 17, 1997;Build 11
 Q  ;
FILTERED ;
 N DIV,LOC,NTF,SAVE,SRV,TTL,TXT,TYP,USR
 ;S TIME("Start","F")=$$NOW^XLFDT
 I '+$G(SETUP) D SETUP^ORAERPT ; create dynamic filter criteria in the protocol file
 ;S TIME("Stop","F")=$$NOW^XLFDT,TIME("Total","F")=$FN($$FMDIFF^XLFDT(TIME("Start","F"),TIME("Stop","F"),2)/60,"-") ; timing information
 ;W !!,TIME("Total","F")
 W !!,"Enter the criteria for filtering.  Enter '?' for more information."
 S FLTR=$$ASK^ORAERPT(.FLTR,"A","RECIPIENT","ORAE MENU FILTER "_$J,"Filter by:  ") I FLTR'>0 Q
 S Y=FLTR F X=1:1:Y S:X=1 FLTR=$P(FLTR(X),U,3) S:X>1 $P(FLTR,U,X)=$P(FLTR(X),U,3) K FLTR(X)
 S X("NOTIFICATION")="NTF",X("DIVISION")="DIV",X("RECIPIENT")="USR",X("LOCATION")="LOC",X("SERVICE")="SRV",X("TITLE")="TTL"
 S FLTR=$$REPLACE^XLFSTR(FLTR,.X) D
 . ; remove duplicate filter entries
 . N CNT,TMP S CNT=0,TMP=FLTR K FLTR S FLTR=""
 . F X=1:1:$L(TMP,U) I FLTR'[$P(TMP,U,X) S CNT=CNT+1,$P(FLTR,U,CNT)=$P(TMP,U,X)
 F X=1:1:$L(FLTR,U) D  Q:@TYP'>0
 . S TYP=$P(FLTR,U,X)
 . N DEFAULT S DEFAULT=$P(TOP10(TYP,1),U)
 . S DEFAULT=$S(TYP="USR":$TR(DEFAULT,","," "),DEFAULT["z<":$E(DEFAULT,2,$L(DEFAULT)),DEFAULT["-":$TR(DEFAULT,"-"," "),1:DEFAULT)
 . S @TYP=$$ASK^ORAERPT(.@TYP,"A",DEFAULT,"ORAE MENU "_TYP_" "_$J,$S(TYP="DIV":"DIVISION",TYP="LOC":"LOCATION",TYP="NTF":"NOTIFICATION",TYP="SRV":"SERVICE",TYP="TTL":"TITLE",TYP="USR":"RECIPIENT")_": ","D HELP1^ORAEHLP")
 Q:@TYP'>0
 ;
 F X=1:1:$L(FLTR,U) S TYP=$P(FLTR,U,X),FLTR(X)=TYP ; get types to filter in order of entry
 S X=0 F  S X=$O(FLTR(X)) Q:'+X  D
 . S TYP=FLTR(X) I $P(@TYP@(1),U,4)="ALL" K @TYP Q  ; remove filter for ALL entries by a type
 . N CNT S (CNT,Y)=0 F  S Y=$O(@TYP@(Y)) Q:'+Y  S @TYP@(Y)=$P(^ORD(101,$P(@TYP@(Y),U,2),0),U,2) ; set to data from File #101
 ;
 ; evaluate filter to ensure either USER or NOTIFICATION centric display
 I FLTR'["USR",FLTR'["NTF" S FLTR(1)="USR" ; neither, user centric
 I FLTR'["USR",FLTR["NTF" S FLTR(1)="NTF" ; ntf centric
 I FLTR["USR",FLTR'["NTF" S FLTR(1)="USR" ; usr centric
 I FLTR["USR",FLTR["NTF" D  ; if both...
 . I $L(FLTR,U)=6 S FLTR(1)="USR" Q  ; if ALL, set user centric display
 . F X=1:1:$L(FLTR,U) I $P(FLTR,U,X)="NTF"!($P(FLTR,U,X)="USR") S FLTR(1)=$P(FLTR,U,X) Q  ; set in order of entry
 ;
 ; filter entries to display
 N CNT,CONT S CONT=0 S USR="" F  S USR=$O(@TMP@("ALL",USR)) Q:USR=""  D
 . I +$D(USR(1)) D  Q:'+CONT
 . . S (CNT,CONT)=0 F  S CNT=$O(USR(CNT)) Q:'+CNT  I $TR(USR,"z<","<")=USR(CNT) S CONT=1
 . S TTL="" F  S TTL=$O(@TMP@("ALL",USR,TTL)) Q:TTL=""  D
 . . I +$D(TTL(1)) D  Q:'+CONT
 . . . S (CNT,CONT)=0 F  S CNT=$O(TTL(CNT)) Q:'+CNT  I $TR(TTL,"z<","<")=TTL(CNT) S CONT=1
 . . S SRV="" F  S SRV=$O(@TMP@("ALL",USR,TTL,SRV)) Q:SRV=""  D
 . . . I +$D(SRV(1)) D  Q:'+CONT
 . . . . S (CNT,CONT)=0 F  S CNT=$O(SRV(CNT)) Q:'+CNT  I $TR(SRV,"z<","<")=SRV(CNT) S CONT=1
 . . . S NTF="" F  S NTF=$O(@TMP@("ALL",USR,TTL,SRV,NTF)) Q:NTF=""  D
 . . . . I +$D(NTF(1)) D  Q:'+CONT
 . . . . . S (CNT,CONT)=0 F  S CNT=$O(NTF(CNT)) Q:'+CNT  I $TR(NTF,"z<","<")=NTF(CNT) S CONT=1
 . . . . S DIV="" F  S DIV=$O(@TMP@("ALL",USR,TTL,SRV,NTF,DIV)) Q:DIV=""  D
 . . . . . I +$D(DIV(1)) D  Q:'+CONT
 . . . . . . S (CNT,CONT)=0 F  S CNT=$O(DIV(CNT)) Q:'+CNT  I $TR(DIV,"z<","<")=DIV(CNT) S CONT=1
 . . . . . S LOC="" F  S LOC=$O(@TMP@("ALL",USR,TTL,SRV,NTF,DIV,LOC)) Q:LOC=""  D
 . . . . . . I +$D(LOC(1)) D  Q:'+CONT
 . . . . . . . S (CNT,CONT)=0 F  S CNT=$O(LOC(CNT)) Q:'+CNT  I $TR(LOC,"z<","<")=LOC(CNT) S CONT=1
 . . . . . . S @TMP@("FILTER",FLTR(1),$S(FLTR(1)="NTF":NTF,1:USR),$S(FLTR(1)="NTF":USR,1:NTF),TTL,SRV,DIV,LOC)=@TMP@("ALL",USR,TTL,SRV,NTF,DIV,LOC)
 ;
 N HDR S CNT=0,TYP="",TYP=$O(@TMP@("FILTER",TYP)) Q:TYP=""
 D  ; set up the data header information
 . S HDR(1)=$S(TYP="NTF":"NOTIFICATION",1:"RECIPIENT")
 . S HDR(2)=$S(TYP="NTF":"  RECIPIENT",1:"  NOTIFICATION")
 . S:FLTR["TTL" HDR($S(TYP="USR":1,1:2))=HDR($S(TYP="USR":1,1:2))_" [TITLE"_$S(FLTR["SRV":"",1:"]")
 . S:FLTR["SRV" HDR($S(TYP="USR":1,1:2))=HDR($S(TYP="USR":1,1:2))_$S(FLTR["TTL":"/SERVICE]",1:" [SERVICE]")
 . I FLTR'["DIV",FLTR["LOC" D  Q
 . . I FLTR["SRV"!(FLTR["TTL") S HDR($S(TYP="USR":2,1:3))=$$SETSTR^VALM1("LOCATION",$G(HDR($S(TYP="USR":2,1:3))),40,8),HDR($S(TYP="USR":2,1:3))=$$SETSTR^VALM1("TOTAL",HDR($S(TYP="USR":2,1:3)),76,5)
 . . I FLTR'["SRV",FLTR'["TTL" S HDR(2)=$$SETSTR^VALM1("LOCATION",HDR(2),40,8),HDR(2)=$$SETSTR^VALM1("TOTAL",HDR(2),76,5)
 . . S $P(HDR(3),"=",80)="="
 . I FLTR["DIV" S HDR(3)="    DIVISION" S:FLTR["LOC" HDR(3)=$$SETSTR^VALM1("LOCATION",$S(FLTR["DIV":HDR(3),1:""),40,8)
 . I FLTR["DIV" S HDR(3)=$$SETSTR^VALM1("TOTAL",$G(HDR(3)),76,5),$P(HDR(4),"=",80)="=" Q
 . S HDR(2)=$$SETSTR^VALM1("TOTAL",HDR(2),76,5),$P(HDR(3),"=",80)="="
 ;
 S NTF="" F  S NTF=$O(@TMP@("FILTER",TYP,NTF)) Q:NTF=""  D
 . N ENT,SUM,VAL S SUM=0
 . S CNT=CNT+1,TXT(CNT)=NTF,ENT=CNT ; Notification or User, keep track on initial ENTRY line CNT
 . S USR="" F  S USR=$O(@TMP@("FILTER",TYP,NTF,USR)) Q:USR=""  D
 . . S CNT=CNT+1,TXT(CNT)=$$SETSTR^VALM1(USR,"",3,$L(USR)) ; Notification or User
 . . S TTL="" F  S TTL=$O(@TMP@("FILTER",TYP,NTF,USR,TTL)) Q:TTL=""  D
 . . . S SRV="" F  S SRV=$O(@TMP@("FILTER",TYP,NTF,USR,TTL,SRV)) Q:SRV=""  D
 . . . . I TYP="USR" D  ; add TITLE/SERVICE to main entry (USER) using ENT
 . . . . . N TMP S TMP=" ["_$TR(TTL,"z<","<")_$S(FLTR["SRV":"",1:"]")
 . . . . . I TXT(ENT)'[$TR(TTL,"z<","<") S:FLTR["TTL" TXT(ENT)=$$SETSTR^VALM1(TMP,TXT(ENT),($L(TXT(ENT))+1),$L(TMP))
 . . . . . S TMP=$S(FLTR["TTL":"/",1:" [")_$TR(SRV,"z<","<")_"]"
 . . . . . I TXT(ENT)'[$TR(SRV,"z<","<") S:FLTR["SRV" TXT(ENT)=$$SETSTR^VALM1(TMP,TXT(ENT),($L(TXT(ENT))+1),$L(TMP))
 . . . . I TYP="NTF" D  ; add TITLE/SERVICE to main entry (NTF)
 . . . . . N TMP S TMP=" ["_$TR(TTL,"z<","<")_$S(FLTR["SRV":"",1:"]")
 . . . . . I TXT(CNT)'[$TR(TTL,"z<","<") S:FLTR["TTL" TXT(CNT)=$$SETSTR^VALM1(TMP,TXT(CNT),($L(TXT(CNT))+1),$L(TMP))
 . . . . . S TMP=$S(FLTR["TTL":"/",1:" [")_$TR(SRV,"z<","<")_"]"
 . . . . . I TXT(CNT)'[$TR(SRV,"z<","<") S:FLTR["SRV" TXT(CNT)=$$SETSTR^VALM1(TMP,TXT(CNT),($L(TXT(CNT))+1),$L(TMP))
 . . . . S DIV("TOTAL")=0,DIV="" F  S DIV=$O(@TMP@("FILTER",TYP,NTF,USR,TTL,SRV,DIV)) Q:DIV=""  D
 . . . . . I FLTR["DIV" S CNT=CNT+1,TXT(CNT)=$$SETSTR^VALM1($TR(DIV,"z<","<"),"",5,$L($TR(DIV,"z<","<")))
 . . . . . S LOC="",VAL=0 F  S LOC=$O(@TMP@("FILTER",TYP,NTF,USR,TTL,SRV,DIV,LOC)) Q:LOC=""  D
 . . . . . . I FLTR["LOC" D  ; display location
 . . . . . . . I FLTR'["DIV",TYP="NTF" I FLTR["SRV"!(FLTR["TTL") S VAL=1
 . . . . . . . S:VAL>0 CNT=CNT+1 S TXT(CNT)=$$SETSTR^VALM1($TR(LOC,"z<","<"),$S(VAL>0:"",1:TXT(CNT)),40,$L($TR(LOC,"z<","<")))
 . . . . . . . S TXT(CNT)=$$SETSTR^VALM1(@TMP@("FILTER",TYP,NTF,USR,TTL,SRV,DIV,LOC),TXT(CNT),(IOM-$L(@TMP@("FILTER",TYP,NTF,USR,TTL,SRV,DIV,LOC))+1),$L(@TMP@("FILTER",TYP,NTF,USR,TTL,SRV,DIV,LOC)))
 . . . . . . S VAL=VAL+@TMP@("FILTER",TYP,NTF,USR,TTL,SRV,DIV,LOC) ; total sum by LOC
 . . . . . . S SUM=SUM+@TMP@("FILTER",TYP,NTF,USR,TTL,SRV,DIV,LOC) ; total sum by NTF (Recipient or Notification)
 . . . . . S DIV("TOTAL")=DIV("TOTAL")+VAL ; add location sum to DIV
 . . . . . I FLTR["DIV",FLTR'["LOC" S TXT(CNT)=$$SETSTR^VALM1(VAL,TXT(CNT),(IOM-$L(VAL)+1),$L(VAL))
 . . I FLTR'["DIV",FLTR'["LOC" S TXT(CNT)=$$SETSTR^VALM1(DIV("TOTAL"),TXT(CNT),(IOM-$L(DIV("TOTAL"))+1),$L(DIV("TOTAL"))) ; display sum by DIVISION
 . ;S CNT=CNT+1,TXT(CNT)=$$SETSTR^VALM1(SUM,"",(IOM-$L(SUM)+1),$L(SUM)) ; display total
 . I $O(@TMP@("FILTER",TYP,NTF))'="" S CNT=CNT+1,TXT(CNT)="" ; add a blank line between entries
 ;
 S (SAVE("HDR"),SAVE("TXT"))="" W ! D EN^XUTMDEVQ("DISPLAY^ORAERPT(.TXT)","Filter Report",.SAVE)
 K @TMP@("FILTER"),FLTR
 Q
 Q
