PRS8WE ;WCIOFO/MGD-DECOMPOSITION, WEEKEND PREMIUM ;01/31/08
 ;;4.0;PAID;**42,65,74,75,90,92,96,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is used to determine the payment of Saturday and
 ;Sunday Premium pays to entitled employees.
 ;
 ;Called by Routine PRS8ST
 ;
 N DAY,HYBRID,SAT2DT,SATNOSUN
 S HYBRID=$S(+DFN'="":$$HYBRID^PRSAENT1(DFN),1:0)
 ;
 ; The variable SATNOSUN has been added for employees who are now
 ; eligible to receive Saturday Premium but not Sunday Premium under
 ; Public Law 108-170.
 S SATNOSUN=$S($E(ENT,8,9)="10":1,1:0)
 ;
 ; Compute Sunday Premium Pay.  Check SATNOSUN employees
 I $E(ENT,9)!(TYP["B")!(HYBRID)!(SATNOSUN) F DAY=1,8,15 D WPD
 ;
 ; Compute Saturday Premium Pay
 I $E(ENT,8)!(TYP["B")!(HYBRID) F DAY=7,14 D WPD
 ;
 Q
 ;
WPD ; Weekend Premium for Day
 ; input
 ;   DAY - day in pay period (1,7,8,14, or 15)
 ;   SAT2DT(day) - if defined for day, it equals the time segment (1-96)
 ;                 just before the start of a 2-day tour that begins on
 ;                 a Saturday and has already received Sunday premium.
 ;                 Defined during computation of Sunday premiums and
 ;                 used during computation of Saturday premiums to
 ;                 prevent payment of both premiums for same period.
 ;   TYP, ENT, etc...
 ; output
 ;   WK()
 ;
 N AV,D,END,H,M,P,TP,TV
 ;
 ; determine type of weekend premium.
 S TP=$S("^7^14^"[(U_DAY_U):"SAT","^1^8^15^"[(U_DAY_U):"SUN",1:"")
 Q:TP=""  ; invalid day (must be Sat. or Sun.)
 ;
 ; determine types of time in a 'tour'
 S TV=$$TV
 ;
 ; determine types of time that might be eligible for premium
 S AV=$$AV
 ;
 ; load info for day
 S D(DAY)=$G(^TMP($J,"PRS8",DAY,"W"))
 Q:D(DAY)?1"0"."0"  ; no activity on day
 S P(DAY)=$G(^TMP($J,"PRS8",DAY,"P"))
 S H(DAY)=$G(^TMP($J,"PRS8",DAY,"HOL"))
 ;
 ; loop thru activity string to find start of 'tour'
 S M=1
 S END=$S($G(SAT2DT(DAY))>0:SAT2DT(DAY),1:96)
 F  D  Q:M=END  S M=M+1
 . I TV'[$E(D(DAY),M),$E(H(DAY),M)'=2 Q
 . ; found start of a 'tour'
 . ; loop thru 'tour' activity and count the premium
 . N CNT
 . ;
 . ; if the 'tour' starts at beginning of day then check if it is part
 . ; of a 2-day 'tour' that actually started on the previous day
 . I DAY>1,M=1 D
 . . N CLASS,DYP,Z
 . . S CLASS=$$CTS($E(D(DAY),M),$E(H(DAY),M))
 . . S DYP=DAY-1
 . . S D(DYP)=$G(^TMP($J,"PRS8",DYP,"W"))
 . . S P(DYP)=$G(^TMP($J,"PRS8",DYP,"P"))
 . . S H(DYP)=$G(^TMP($J,"PRS8",DYP,"HOL"))
 . . Q:$$CTS($E(D(DYP),96),$E(H(DYP),96))'=CLASS  ; not same 'tour'
 . . ; Hybrids defined by Public Law P.L. 107-135 only get Saturday
 . . ; or Sunday premium for CT/OT/UN worked on Saturday or Sunday
 . . Q:HYBRID&(TP="SAT")&($$CTS($E(D(DYP),96),$E(H(DYP),96))="X")
 . . I CLASS="R",'$$TDT(DYP) Q  ; can't be same scheduled tour
 . . ; If SATNOSUN and the day is a Sunday quit
 . . Q:SATNOSUN&("^1^8^15^"[(U_DAY_U))
 . . ; loop backward from midnight thru previous day's portion of tour
 . . S Z=96
 . . F  D  Q:Z=1  S Z=Z-1 Q:$$CTS($E(D(DYP),Z),$E(H(DYP),Z))'=CLASS
 . . . I AV[$E(D(DYP),Z)!($E(D(DYP),Z)="O"&($E(H(DYP),Z)=2)) D COUNT^PRS8WE2(DYP,Z)
 . . ; if Sun. premium then save Z to avoid recount of these Sat. hours
 . . ;   when/if Sat. premium is calculated
 . . ;
 . . I TP="SUN" S SAT2DT(DYP)=Z
 . ;
 . ; If SATNOSUN and tour crossed mid onto Sunday set TP=SAT
 . I M=1&("^1^8^"[(U_DAY_U)),SATNOSUN D
 . . I AV[$E($G(^TMP($J,"PRS8",DAY-1,"W")),96) S TP="SAT"
 . ;
 . ; loop forward thru current day's portion of tour
 . I DAY<15 F  D  Q:M=END  S M=M+1 Q:TV'[$E(D(DAY),M)&($E(H(DAY),M)'=2)
 . . I AV[$E(D(DAY),M)!($E(D(DAY),M)="O"&($E(H(DAY),M)=2)) D COUNT^PRS8WE2(DAY,M)
 . . ;
 . . ; If checking for SATNOSUN quit when tour crossing midnight ends
 . . I SATNOSUN&(TP="SAT")&("^1^8^15^"[(U_DAY_U))&(AV'[$E(D(DAY),M+1)) D SAVE^PRS8WE2 S M=END Q
 . ;
 . ; If counting Sat Prem for SATNOSUN and Day is a Sunday there is no
 . ; need to check for the tour crossing midnight onto Monday
 . Q:SATNOSUN&(TP="SAT")&("^1^8^15^"[(U_DAY_U))
 . ;
 . ; If SATNOSUN and DAY=14 and M<96 check remainder of tour for work
 . I SATNOSUN&(DAY=14)&(M<96) D
 . . F M=M:1:96 D
 . . . I AV[$E(D(DAY),M)!($E(D(DAY),M)="O"&($E(H(DAY),M)=2)) D COUNT^PRS8WE2(DAY,M)
 . ;
 . ; If tour lasted until end of day then check if it is part of
 . ; a 2-day tour that extends into next day
 . I DAY<15,M=96,'SATNOSUN,(TV[$E(D(DAY),M))!($E(H(DAY),M)=2) D
 . . N CLASS,DYN,Z
 . . S CLASS=$$CTS($E(D(DAY),96),$E(H(DAY),96))
 . . S DYN=DAY+1
 . . S D(DYN)=$G(^TMP($J,"PRS8",DYN,"W"))
 . . S P(DYN)=$G(^TMP($J,"PRS8",DYN,"P"))
 . . S H(DYN)=$G(^TMP($J,"PRS8",DYN,"HOL"))
 . . Q:$$CTS($E(D(DYN),1),$E(H(DYN),1))'=CLASS  ; not same 'tour'
 . . ; Hybrids defined by Public Law P.L. 107-135 only get Saturday
 . . ; or Sunday premium for CT/OT/UN worked on Saturday or Sunday
 . . Q:HYBRID&(TP="SUN")&($$CTS($E(D(DYN),1),$E(H(DYN),1))="X")
 . . I CLASS="R",'$$TDT(DAY) Q  ; can't be same scheduled tour
 . . ; loop forward from midnight thru next day's portion of tour
 . . S Z=1
 . . F  D  Q:Z=96  S Z=Z+1 Q:$$CTS($E(D(DYN),Z),$E(H(DYN),Z))'=CLASS
 . . . I AV[$E(D(DYN),Z)!($E(D(DYN),Z)="O"&($E(H(DYN),Z)=2)) D COUNT^PRS8WE2(DYN,Z)
 . ;
 . ; post premium time for tour to WK()
 . D SAVE^PRS8WE2
 Q
 ;
TV() ; List types of time in a 'tour'
 N PRSX
 ; for regular time
 S PRSX="LRSFGDUAJMWNnVH1234XYmZq"
 ; for OT/CT
 S PRSX=PRSX_$S(TYP["B":"EeOs",TYP["N"!(TYP["H"):"EetOoscbT",1:"")
 I HYBRID S PRSX=PRSX_"EetOoscbT"
 ; for employees covered by PL 108-170
 I PMP'=""&("^S^T^U^V^"[(U_PMP_U)) D
 . I $E(ENT,28),PRSX'["Eet" S PRSX=PRSX_"Eet"
 . I $E(ENT,12),PRSX'["Oos" S PRSX=PRSX_"Oos"
 . I $E(ENT,17),PRSX'["c" S PRSX=PRSX_"c"
 . I $E(ENT,29),PRSX'["b" S PRSX=PRSX_"b"
 . I $E(ENT,18),PRSX'["T" S PRSX=PRSX_"T"
 Q PRSX
 ;
AV() ; List types of time that might be eligible for premium pay
 N PRSX
 ; for regular time
 S PRSX=$S(TYP["B":"",1:"1234XY")
 ; for OT/CT
 S PRSX=PRSX_$S(TYP["B":"EeOos",TYP["N"!(TYP["H"):"EeOosc",1:"")
 I HYBRID S PRSX=PRSX_"EeOosc"
 ; for employees covered by PL 108-170
 I PMP'=""&("^S^T^U^V^"[(U_PMP_U)) D
 . I $E(ENT,28),PRSX'["Ee" S PRSX=PRSX_"Ee"
 . I $E(ENT,12),PRSX'["Oos" S PRSX=PRSX_"Oos"
 . I $E(ENT,17),PRSX'["c" S PRSX=PRSX_"c"
 Q PRSX
 ;
CTS(XW,XH) ; Return class of a time segment
 ; input XW = type of time in activity ("W") string
 ;       XH = value in holiday ("H")  string
 ; returns class
 ;    "R"  regular scheduled
 ;    "X"  extra (ot/ct) or unscheduled reg.
 ;    "N"  not worked (includes on-call, standby when not called back)
 Q $S(("LRSFGDUAJMWNnVH123XYmZq"[XW)!((XW="O")&(XH=2)):"R",("EetscbT4"[XW)!((XW="O")&(XH'=2)):"X",1:"N")
 ;
TDT(DAYN) ; Two-Day Tour extrinsic variable
 ; input
 ;   DAYN = day # (0-15) being checked for at least one sch. 2-day tour
 ; returns 0 (false) or 1 (true)
 N RET
 S RET=0 ; assume no scheduled 2-day tour of duty
 S X=$G(^TMP($J,"PRS8",DAYN,0))
 F I=2,13 I $P(X,U,I),$P($G(^PRST(457.1,$P(X,U,I),0)),U,5)="Y" S RET=1
 Q RET
 ;
 ;PRS8WE
