PRSACED3 ;HISC/MGD-T&A Edits ;02/03/06
 ;;4.0;PAID;**35,45,75,92,96,102**;Sep 21, 1995
 S E(1)=0
 F K=24,25,33,43:1:45 S X=$P(C0,"^",K) I X'="" S LAB=$P(T0," ",K-12) D @LAB
 F K=6,7,15,25:1:27,42,45,47:1:57 S X=$P(C1,"^",K) I X'="" S LAB=$P(T1," ",K) D @LAB
 I E(1)>$S(NOR>1:NOR*10,1:140),DUT=1 S ERR=69 D ERR^PRSACED
 G ^PRSACED4
PA ;
PB S E(1)=E(1)+X
 I DUT=2,LAB="PA",X>$P(C0,"^",42) S ERR=70 D ERR^PRSACED
 I DUT=2,LAB="PB",X>$P(C1,"^",24) S ERR=70 D ERR^PRSACED
 I DUT=3,X>400 S ERR=71 D ERR^PRSACED
 I '$P(C1,"^",41) S ERR=72 D ERR^PRSACED
 Q
ON ;
CL I PAY'="A"!("^U^V^W^Y^"'[(U_PMP_U)) S ERR=73 D ERR^PRSACED
 I X>1280 S ERR=74 D ERR^PRSACED
 Q
VC I $P(C1,"^",27)="" S ERR=75 D ERR^PRSACED
VS I LAB="VS",$P(C0,"^",45)="" S ERR=75 D ERR^PRSACED
 I PAY'="U" S ERR=77 D ERR^PRSACED
 Q
YA Q
YD Q
YE Q
DT ;Validate lump sum expiration date and report format errors.
 ; REQUIRED VARIABLES:  X = date to be checked, format mmddyy.
 ;                      PPI = current pay period IEN.
 ;
 ;1. Check month.  2. Check days aren't > than corresponding month.
 ;3. To check that year is in range: current year to next year:
 ;     Get 1st day of pp for date being checked.
 ;     Get 4 digit year from PP^PRSAPPU.
 ;     Add 1 to the 4 digit year and check year range.
 ;
 ;  Month
 I $E(X,1,2)<1!($E(X,1,2)>12) D
 .  S ERR=138 D ERR^PRSACED
 ;
 ;  Days
 S X1=+$E(X,3,4)
 I X1<1!(X1>$P("31 29 31 30 31 30 31 31 30 31 30 31"," ",+$E(X,1,2))) D
 .  S ERR=138 D ERR^PRSACED
 ;
 ;  Year
 N PPE,PP4Y,D1,NXTYR,DAY
 S D1=$P($G(^PRST(458,PPI,1)),"^")
 D PP^PRSAPPU
 S YEAR=$E(+PP4Y,3,4),NXTYR=$E(+PP4Y+1,3,4),X1=$E(X,5,6)
 I '((X1=YEAR)!(X1=NXTYR)) D
 .  S ERR=138 D ERR^PRSACED
 ;
 ; Firefighters can't use lump sum date
 I NOR>80 S ERR=173 D ERR^PRSACED
 Q
YH Q
SP ; saturday premium pay
SQ N HYBRID
 S HYBRID=$S(+$G(DFN)'="":$$HYBRID^PRSAENT1(DFN),1:0)
 S MX=$S("ABCKMN"[PAY:400,HYBRID:400,1:320) I X>MX S ERR=140 D ERR^PRSACED
 I "ABCKMN"'[PAY S ERR=141 D ERR^PRSACED
 I "ABCN"[PAY,PMP="",'HYBRID S ERR=149 D ERR^PRSACED
 Q
TF ; travel ot flsa
TG I FLSA'="N" S ERR=142 D ERR^PRSACED
 Q
DA ; hrs excess 8 (day)
DE I "0123456789AGKMNU"'[PAY S ERR=143 D ERR^PRSACED
 Q
DB ; hrs excess 8 (two)
DF I "0123456789BGU"'[PAY S ERR=145 D ERR^PRSACED
 Q
DC ; hrs excess 8 (three)
DG I "0123456789GU"'[PAY S ERR=147 D ERR^PRSACED
 Q
TA ; travel
 I NOR>0,DUT=1,(X+($P(C1,"^",54)))>(NOR*10) S ERR=95 D ERR^PRSACED
 I "23"[DUT,X>($P(C0,"^",42)+($P(C0,"^",21))) S ERR=94 D ERR^PRSACED
 I DUT=1,"45"[LVG,+X>70 S ERR=91 D ERR^PRSACED
 I NOR>80,$P(C0,"^",42),X>$P(C0,"^",42) S ERR=92 D ERR^PRSACED
 Q
TB ;
 I NOR>0,DUT=1,($P(C1,"^",15)+X)>(NOR*10) S ERR=95 D ERR^PRSACED
 I "23"[DUT,X>($P(C1,"^",24)+($P(C1,"^",3))) S ERR=94 D ERR^PRSACED
 I DUT=1,"45"[LVG,+X>70 S ERR=91 D ERR^PRSACED
 I NOR>80,$P(C1,"^",24),X>$P(C1,"^",24) S ERR=92 D ERR^PRSACED
 Q
TC ; training
 I NOR>0,DUT=1,(X+($P(C1,"^",57)))>(NOR*10) S ERR=98 D ERR^PRSACED
 I "23"[DUT,X>($P(C0,"^",42)+($P(C0,"^",21))) S ERR=97 D ERR^PRSACED
 I DUT=1,"45"[LVG,+X>70 S ERR=91 D ERR^PRSACED
 I NOR>80,$P(C0,"^",42),X>$P(C0,"^",42) S ERR=92 D ERR^PRSACED
 Q
TD ;
 I NOR>0,DUT=1,($P(C1,"^",42)+X)>(NOR*10) S ERR=98 D ERR^PRSACED
 I "23"[DUT,X>($P(C1,"^",24)+($P(C1,"^",3))) S ERR=97 D ERR^PRSACED
 I DUT=1,"45"[LVG,+X>70 S ERR=91 D ERR^PRSACED
 I NOR>80,$P(C1,"^",24),X>$P(C1,"^",24) S ERR=92 D ERR^PRSACED
 Q
