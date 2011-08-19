IVMRNQ1 ;ALB/CPM - IVM CASE INQUIRY (CON'T) ; 16-JUN-94
 ;;2.0;INCOME VERIFICATION MATCH ;**13,17**; 21-OCT-94
 ;
HDR ; Display inquiry header.
 N IVMS
 I $E(IOST,1,2)="C-"!(IVMPAG) W @IOF,*13
 S IVMPAG=IVMPAG+1
 W "IVM Case Inquiry",?28,IVMDAT,?70,"Page: ",IVMPAG,!,$TR($J("",79)," ","-")
 W !?5,"Name: ",$P(IVMNAM,"^"),?47,"Awaiting Trans: ",$S('$P(IVM0,"^",3):"YES",1:"NO")
 W !?6,"SSN: ",$P(IVMNAM,"^",2),?50,"Case Status: ",$S($P(IVM0,"^",4):"CLOSED",1:"OPEN")
 ;"5D" will return only the date with a 4 digit year. 
 W !?1,"Inc Year: ",1700+$E(IVMYR,1,3),?39,"Full Transmission Sent: ",$S($P(IVM0,"^",5):$TR($$FMTE^XLFDT($P(IVM0,"^",5),"5DF")," ","0"),1:"**Not Sent**")
 W !?2,"MT/CT Date: ",$TR($$FMTE^XLFDT($P(IVMMT,"^",2),"5DF")," ","0"),"  (",$P(IVMMT,"^",3),")",!!,$TR($J("",80)," ","=")
 ;
 ; - display sub-header if case is closed
 I IVMPAG=1,$P(IVM0,"^",4) D
 .W !?4,"---  T H I S  C A S E  R E C O R D  H A S  B E E N  C L O S E D  ---",!
 .W !?2,"Closure Reason: " S IVMS=$$EXPAND^IVMUFNC(301.5,1.01,+IVM1) W $S($L(IVMS)>3:IVMS,1:"<UNKNOWN>")
 .W !?2,"Closure Source: " S IVMS=$$EXPAND^IVMUFNC(301.5,1.02,+$P(IVM1,"^",2)) W $S($L(IVMS)>3:IVMS,1:"<UNKNOWN>")
 .W !?4,"Closure Date: " S IVMS=$$FMTE^XLFDT($P(IVM1,"^",3)) W $S($L(IVMS)>3:IVMS,1:"<UNKNOWN>")
 .W !,$TR($J("",80)," ","=")
 Q
 ;
THDR ; Display transmission history header.
 W !!,"Means/Copay Test Transmission History:",!?56,"Transmitted As"
 W !?2,"Trans Date/Time",?25,"Status",?53,"MT/CT Cat",?67,"Had Ins?",!?2,$TR($J("",77)," ","-")
 Q
 ;
BHDR ; Display billing transmission history header.
 W !!,"Billing Transmission History:",!?37,"Amt",?46,"Amt"
 W !?2,"Bill Type",?14,"Bill From",?25,"Bill To",?36,"Billed",?46,"Coll",?54,"Canc?",?61,"Closed?",?69,"Last Trans"
 W !?2,$TR($J("",77)," ","-")
 Q
 ;
INS(X) ; Has any insurance been acted upon?
 ;  Input:   X  --  Pointer to the case record in file #301.5
 ; Output:   Zeroth node of multiple in #301.5 with ins. upload data
 N Y,Z S Z=""
 S Y=0 F  S Y=$O(^IVM(301.5,+$G(X),"IN",Y)) Q:'Y  S Z=$G(^(Y,0)) I $P(Z,"^",4)]"" Q
 Q Z
 ;
CKUPL ; Any upload information to display?
 N IVMS,IVMS1
 K IVMTXT
 S IVMS=0 F  S IVMS=$O(^IVM(301.5,"B",DFN,IVMS)) Q:'IVMS  D
 .I $O(^IVM(301.5,"ASEG","PID",IVMS,0)) S IVMTXT(1)=""
 .I $O(^IVM(301.5,"ASEG","ZIV",IVMS,0)) S IVMTXT(2)=""
 .I $O(^IVM(301.5,"ASEG","IN1",IVMS,0)) S IVMTXT(3)=""
 .S IVMS1=$$INS(IVMS) I IVMS1]"" S IVMTXT(4,IVMS)=IVMS1
 Q
 ;
UPTXT ; Upload Text to display.
 ;;This patient has demographics which need to be uploaded.
 ;;This patient has SSNs which need to be uploaded.
 ;;This patient has insurance which needs to be uploaded.
