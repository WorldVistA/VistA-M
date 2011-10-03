PRS8EX ;HISC/MRL,WCIOFO/SAB-DECOMPOSITION, EXCEPTIONS ;6/11/2008
 ;;4.0;PAID;**2,40,56,69,111,112,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is used to process most exceptions to the normal
 ;tod.  It is used, for example, to determine whether or not the
 ;employee is entitled to such exceptions as Leave, OT, etc.,
 ;and then calls ^PRS8AC to process them.
 ;
 ;Called by Routines:  PRS8ST
 ;
 S TT=$P(V,"^",3) ;type of time
 I TT="OT",+$P(V,"^",4)=8,$E(ENT,18) S TT="TT" ;ot in travel status
 I TT="CT",$P(V,"^",4)=16 S TT="CQ" ;credit hours earned
 I TT="CU",$P(V,"^",4)=16 S TT="CS" ;credit hours used
 I TT="HW",$E(ENT,1,2)="0D" S TT="RG"
 I TT="OT",TYP["P",TYP'["B" S TT="RG" ;To convert Pt ot to RG
 I TT="HW",TYP'["D",+V,+$P(V,"^",2) D
 .I $P(V,"^",2)-V-1<8 D  ; <2 hrs HW
 ..S ^TMP($J,"PRS8",DY,"HW")=$G(^TMP($J,"PRS8",DY,"HW"))_$P(V,U,1,2)_U
 ..Q
 .I TYP["P",$P(V,"^",2)>96 S LEN=$P(V,"^",2)-96 D  ;two day tour of HW for part timers
 ..S ^TMP($J,"PRS8",DY+1,"HWK")=$G(^TMP($J,"PRS8",DY+1,"HWK"))_1_U_LEN_U
 ..K LEN
 ..Q
 .I TYP["P",TYP["N"!(TYP["H"),'$E(DAY(DY,"W"),+V) D  ; part time nurses, uscheduled HW.
 ..S ^TMP($J,"PRS8",DY,"HWK")=$G(^TMP($J,"PRS8",DY,"HWK"))_$P(V,U,1,2)_U
 ..Q
 .Q
 S X="^AL^SL^WP^NP^AA^RL^CU^CT^CP^HX^ML^TR^TV^OT^RG^TT^SB^ON^NL^HW^CB^AD^DL^RS^CH^CQ^CS" ;code
 S X=($F(X,"^"_TT)\3)+4,(X,TT(1))=$P($T(ACT+X),";;",2) ;parameters
 S GO=0 I '+X!($E(ENT,+X)) S GO=1 ;entitlement exists-continue
 I TT="RG",$E(ENT,2)'=0 S GO=1 ;intermittent
 I TT="RG"!(TT="CP"),$E(ENT,2)="D" S DAY(DY,"DWK")=1 ;intrmtnt-count days worked (for RG or CP)
 I TT="OT",'GO,$E(ENT,13)!$E(ENT,14) S GO=1 ;entitled to ot
 I TT="UN" S GO=1,VAR="-" ;unavailable
 I TYP["W",TT="RG",$P(V,"^",4)=7 D
 .;wage grade employee working regular unscheduled hours for
 .;shift coverage (7) can get shift differential based on the higher
 .;of the unscheduled tour's shift or their normal shift.
 .;The unscheduled tour and corresponding differential will be saved
 .;in the "SD" node and used by PRS8PP when differentials are
 .;computed.
 .N ST,EN,SD,MID
 .S ST=$P(V,"^"),EN=$P(V,"^",2) Q:'ST!'EN
 .S MID=ST+EN/2
 .; check for 2day tour and if found use combined tour (recompute MID)
 .; to determine appropriate shift differential.
 .; if start is 1 (midnight) then check previous day for a similar tour
 .; that ended at 96 (midnight).
 . I ST=1 D
 .. N PRSI,PRSX
 .. S PRSX=$G(^TMP($J,"PRS8",DY-1,2))
 .. F PRSI=1:1:7 Q:$P(PRSX,U,(PRSI-1)*4+1)=""  D
 ... I $P(PRSX,U,(PRSI-1)*4+2)=96,$P(PRSX,U,(PRSI-1)*4+3)="RG",$P(PRSX,U,(PRSI-1)*4+4)=7 S MID=($P(PRSX,U,(PRSI-1)*4+1)+EN+96)/2
 .; if end is 96 (midnight) then check next day for a similar tour that
 .; starts at 1 (midnight).
 . I EN=96 D
 .. N PRSI,PRSX
 .. S PRSX=$G(^TMP($J,"PRS8",DY+1,2))
 .. F PRSI=1:1:7 Q:$P(PRSX,U,(PRSI-1)*4+1)=""  D
 ... I $P(PRSX,U,(PRSI-1)*4+1)=1,$P(PRSX,U,(PRSI-1)*4+3)="RG",$P(PRSX,U,(PRSI-1)*4+4)=7 S MID=(ST+$P(PRSX,U,(PRSI-1)*4+2)+96)/2
 .; determine shift differential (if any) based on unscheduled tour hours
 .S SD=0
 .I MID<32.5 S SD=3 ; majority of tour before 8a
 .I MID>60.5,MID'>94.5 S SD=2 ; majority of tour after 3p, upto 11:30p
 .I MID>94.5,MID<128.5 S SD=3 ; majority of tour after 11:30p, before 8a
 .; use employee's normal shift if higher than shift based on hours
 .I TOUR>1,TOUR>SD S SD=TOUR
 .S:SD ^TMP($J,"PRS8",DY,"SD")=$G(^TMP($J,"PRS8",DY,"SD"))_ST_U_EN_U_SD_U
 .Q
 I (TT="OT"!(TT="RG")!(TT="CT")),"^13^14^"[("^"_$P(V,"^",4)_"^")!($P(V,"^",4)=12&(TYP["N"!(TYP["H"))) D
 .S ^TMP($J,"PRS8",DY,"CB")=$G(^TMP($J,"PRS8",DY,"CB"))_$P(V,"^",1,2)_"^"
 .Q
 I TYP'["D",TT="HX"!(TT="HW") S GO=1 ;process holiday excused/worked
 G END:'GO ;nothing to process
 I TT'="UN" S VAR=$P(X,"^",3) ;increment time code
 I '$S(VAR'="W":1,'CYA:1,DY<CYA:1,1:0) D
 .S WPCY=1 ;flag to save WOP in hours from 1/1 for calendar year adjustment
 I TYP'["D" D  G END ;process hourly people and quit
 .; The following 2 lines commented out because for Employees that are
 .; non-daily tour (TYP'["D"), policy is has been described that all
 .; ML/COP has to be posted by time-keeper.
 .; If this changes, then uncomment these lines, remove the line adding
 .; military leave and COP that follows, and refer to routine PRS8UP.
 .; I VAR="M" S ^TMP($J,"PRS8",DY,"ML")=1,MILV=1 ;military leave taken
 .; I VAR="V" S ^TMP($J,"PRS8",DY,"CP")=1,WCMP=1 ;cont of pay indicator
 .I DY>0,DY<15 D
 ..; Post ML for employees who are charged in days.
 ..I VAR="M",$$MLINHRS^PRSAENT(DFN)=0 D
 ...S X=$P(TT(1),"^",4) D SET ; military leave & auth. absence
 ..I VAR="V",'$G(^TMP($J,"PRS8",DY,"CP")) S X="M",^TMP($J,"PRS8",DY,"CP")=1 D SET ; COP
 ..Q
 .D ^PRS8AC ;update activity string
 .Q
 ; Employees with daily tours (TYP["D")
 I DY>0,DY<15,VAR="M" S X=$P(TT(1),"^",4) D SET S X=5 D SET G END ;military leave & auth. absence
 I DY>0,DY<15,$$HOLIDAY^PRS8UT(PY,DFN,DY) D  G END ;holiday-no charge
 .I TT="RG" S DAY(DY,"W")=VAR,X=$S('$E(ENT,TOUR+21):9,1:TOUR+28) D SET ; If worked on holiday count it.
 .Q
 S D=DY
 I TT="NP"!($P(DAY(D,0),"^",2)'=1) S DAY(D,"W")=VAR,X=$P(TT(1),"^",4) I X'="",DY>0,DY<15 D SET I VAR="V" S X="M" D SET I VAR="V",TYP["DI",$E(ENT,2)="D" S X=9 D SET ; IF INT RESDNT PAID IN DAYS HAS COP POSTED PAY UN/US ALSO
 D ENCAP^PRS8EX0
 ;
END ; --- all done here     
 K A,D,DD,GO,TT,X,Z
 Q
 ;
SET ; --- enter here to set without VAL defined
 ; Quit if this day has already been counted through the encapsulation
 ; check that is performed in ENCAP^PRS8EX0.
 Q:$D(^TMP($J,"PRS8",DY,2,0))
 ;
 Q:X="K"&($P(V,"^",1)>96)!((X="K")&($D(^TMP($J,"PRS8",DY,"ML"))))  S ^TMP($J,"PRS8",DY,"ML")=1 ;stop counting ML twice for two day tours & split tours, but allow PC
 I +X S $P(WK(WK),"^",+X)=$P(WK(WK),"^",+X)+1
 E  S X=$A(X)-64,$P(WK(3),"^",+X)=$P(WK(3),"^",+X)+1
 Q
 ;
ACT ; --- define variable X for action
 ;     - piece 1 = entitlement (ENT) string $Extract to check
 ;     -       2 = Literal name of exception
 ;     -       3 = Time String code (DAY(X,"W"))
 ;;
 ;;30^Annual Leave^L^1
 ;;31^Sick Leave^S^2
 ;;33^Without Pay^W^3
 ;;36^Non-Pay Status^n^4
 ;;35^Authorized Absence^A^5
 ;;30^Restored Leave^R^6
 ;;28^Comp Used^U^8
 ;;28^Comp Earned^E^7
 ;;37^Continuation of Pay^V^33
 ;;38^Holiday Excused^H
 ;;34^Military Leave^M^K
 ;;0^Training^X^43
 ;;0^Travel^Y^42
 ;;12^Overtime^O
 ;;2^Unscheduled^4^9
 ;;18^OT in Travel Status^T
 ;;29^Standby^B
 ;;26^On-Call^C
 ;;36^Nonpay A/L^N^A
 ;;38^Holiday Worked^h
 ;;31^Care and Bereavement^F^44
 ;;31^Adoption^G^45
 ;;35^Donor Leave^D^46
 ;;5^Recess^r^48
 ;;4^Comp Time for Travel Used^Z^53
 ;;28^Credit Hours Earned^Q^54
 ;;28^Credit Hours Used^q^55
