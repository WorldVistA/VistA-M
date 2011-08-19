PRS8MSC0 ;HISC/DAD,WCIOFO/JAH,SAB - MISC TIME CARD ADJUST(contd) ;4/04/2007
 ;;4.0;PAID;**22,35,40,56,111,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; for employee on daily tour check if no duty performed during week
 I TYP["D" D NODUTY^PRS8MSC1
 ;
 S B="",Z0="" S $P(B,"B",97)="",$P(Z0,"0",97)="",FLAG=0
 F X=1:1:PEROWK S Y=$P(PEROWK(X),"^",4),DAT=$P(PEROWK(X),"^",1,3),DY=$P(DAT,"^",1),BEG=$P(DAT,"^",2),END=$P(DAT,"^",3) D
 .I $L(Y)'<96,TYP'["Ff",$E(ENT,27) D  ; slp for 24hr cvg
 ..S SLMAX=32,(SLW,SLY,SLST,SLSTR,SLST1,SLY1,SL1,SL2,SL3)=""
 ..I END=96 D
 ...S SLST=$P($G(PEROWK(X)),"^",4),SL2=$E(SLST,SST,$L(SLST)),SL1=$E(SLST,1,SLMAX-$L(SL2)),SL3=$L(SL2)
 ...S SLSTR=SL1_SL2
 ...I DOUB S SLSTR=$TR(SLSTR,"Cct","Bbb") ; if PPC = W then OC = SB
 ...S SLSTR=$TR(SLSTR,$TR(SLSTR,"Bb"),Z0)
 ...S SLY=$L($TR(SLSTR,"b0")),SLW=$L($TR(SLSTR,"B0"))
 ...I SLW>12 Q
 ...I DY=0 S FLAG=SL3
 ...S Y=$L(SLSTR)-SLW
 ...I FLAG>0&(DY=1) S Y=Y-FLAG,FLAG=0
 ...S D=DY,P=25 D SET Q
 ..E  D
 ...S SLST=$G(^TMP($J,"PRS8",DY,"W"))_$G(^TMP($J,"PRS8",DY+1,"W"))
 ...S SLSTR=$E(SLST,1,SST+(SLMAX-1))
 ...I DOUB S SLSTR=$TR(SLSTR,"Cct","Bbb") ; if PPC = W then OC = SB
 ...S SLSTR=$TR(SLSTR,$TR(SLSTR,"Bb"),Z0)
 ...S SLY=$E(SLSTR,SST,96),SLY1=$E(SLSTR,97,$L(SLSTR))
 ...S SLSTR=SLY_SLY1,SLW=$L($TR(SLSTR,"B0"))
 ...I SLW>12 Q
 ...S D=DY,Y=$L($TR(SLY,"b0")),P=25 D SET
 ...Q:DY=0  S D=DY+1,Y=$L($TR(SLY1,"b0")) D SET
 ...Q
 ..K BEG,DAT,END,NL,SLW,SLY,SLST,SLSTR,SLST1,SLY1,SL1,SL2,SL3 Q
 .Q
 S D="",(H,ROSS)=1 K OT,UN,DA,CT
 F H=H:ROSS:PEROT D  ; calculate CB OT and FF OT/sleep time
 .S Y=PEROT(H),Z=$P(Y,"^",3)
 .I "Ff"[TYP D  ;K OT,UN,DA D  ; FF sleep time
 ..F M=1:1:$L(Z) D  ; following FF OT per Mary Baker 4/1/93
 ...I D'=+Y+(($P(Y,"^",2)+M-2)\96) D
 ....S D=+Y+(($P(Y,"^",2)+M-2)\96),HT=0
 ....Q
 ...S HT=HT+1
 ...I $E(Z,H)="E" S CT(D)=$G(CT(D))+1 Q
 ...I M'>32 S:HT'>32 OT(D)=$G(OT(D))+1 S:HT>32 DA(D)=$G(DA(D))+1 ; FF OT
 ...I M>32,$L(Z)'<96&(M'>64)!($L(Z)<96) S DA(D)=$G(DA(D))+1 ; FF hrs>8
 ...I $L(Z)'<96,M>64 D  ; FF 2/3 rule
 ....I M'>96 S UN(D)=$G(UN(D))+1 ; first 8 sleep time
 ....E  S DA(D)=$G(DA(D))+1 ; rest hrs >8 
 ....Q
 ...Q
 ..Q
 .I $L(Z)<8 D  ; call back OT at least 2 hrs
 ..S YY=Y,ZZ=Z N X,Y,START,STOP,T,TT,Z,DD,TL S Y=YY,Z=ZZ
 ..S CB=$G(^TMP($J,"PRS8",+Y,"CB"))
 ..;no call back OT today or send bulletin
 ..Q:(CB="")!($$OTNXTPP(+Y,CB,$P(C0,"^",1),PY,$P(C0,"^",8)))
 ..S Q=0 F ZZ=1:2 Q:'$P(CB,"^",ZZ)  I $P(Y,"^",2)=$P(CB,"^",ZZ) S Q=1
 ..Q:'Q  ; this OT episode not call back
 ..S OT=Y,START=$P(OT,"^",2),STOP=$P(OT,"^",2)+$L(Z)-1,T=START,TT=$S(T>96:T-96,1:T)
 ..S W=$G(^TMP($J,"PRS8",+OT,"W")),WEEK=$S(+OT>7:2,1:1)
 ..S W1=$G(^TMP($J,"PRS8",OT-1,"W"))
 ..S W2=$G(^TMP($J,"PRS8",OT+1,"W"))
 ..S (Z,X)=0 F Z=1:1:8-(STOP-START+1) D  Q:X=0
 ...S DD=Z
 ...I TT-DD>0 S X=$E(W,TT-DD)
 ...E  S X=$E(W1,96+T-DD)
 ...I "123m"[X,$E($G(^TMP($J,"PRS8",$S(TT-DD>0:+OT,1:OT-1),"HOL")),$S(TT-DD>0:TT-DD,1:96+T-DD))=1 S X=0 ; HX becomes time off
 ...Q
 ..S ZZ=Z S:X=0&Z ZZ=ZZ-1 S X=0,T=STOP,TT=$S(T>96:T-96,1:T)
 ..F Z=1:1:8-(STOP-START+1+ZZ) D  Q:X=0
 ...S DD=STOP-START+1+ZZ+Z
 ...I T+Z'>96 S X=$E(W,T+Z)
 ...E  S X=$E(W2,T-96+Z)
 ...I "123m"[X,$E($G(^TMP($J,"PRS8",$S(T+Z'>96:+OT,1:OT+1),"HOL")),$S(T+Z'>96:T+Z,1:T-96+Z))=1 S X=0 ; HX becomes time off
 ...Q
 ..S Z=ZZ+Z-(X=0&Z)
 ..I STOP-START+1+Z<8 D
 ...I TYP["W",$E($P(PEROT(H),"^",3))'="E"&($G(^TMP($J,"PRS8",$P(PEROT(H),"^",1),"OFF"))=0) S TOUR=$G(^TMP($J,"PRS8",$P(PEROT(H),"^",1),"TOUR"))
 ...S D=+OT,P=$S($E($P(PEROT(H),"^",3))'="E":TOUR+19,1:7),Y=8-(STOP-START+1+Z)
 ...;
 ...I TYP["P",TYP'["B",P'=7,'+NAWS D
 ....I $P($G(^TMP($J,"PRS8",$P(PEROT(H),"^",1),"OFF")),"^",1)=1&(TH(WEEK)'>160) S Y=0 Q
 ....I $P(C0,"^",12)="E" S P=$S($L($TR(W,"0O"))>31&(TH(WEEK)'>160):TOUR+25,1:P) D:Y SET S Y=$S(TH(WEEK)'>160:Y,1:0) S P=9 D:Y SET S Y=0
 ...I $P(C0,"^",12)="N",P'=7 S P=$S($L($TR(W,"0O"))>31:TOUR+15,1:P) D:Y SET S Y=0
 ...D:Y&('+NAWS) SET
 ...;
 ...I +NAWS D  Q  ; Checks for just the AWS nurses
 ....N CNT,HT,I
 ....S CNT=Y,Y=1,HT=$G(^TMP($J,"PRS8",D,"HT"))
 ....F I=1:1:CNT D
 .....I HT'<32 S P=$S(P'=7:TOUR+15,1:P) D SET1 Q  ; DA/DE or CE/CT
 .....I TH($S(+OT>7:2,1:1))'<160 S P=$S(P'=7:TOUR+19,1:P) D SET1 Q  ; OA/OE or CE/CT
 .....I HT<32,TH($S(+OT>7:2,1:1))<160 S P=9 D SET1 Q  ; UN/US
 ..Q
 .Q
 F X="OT","DA","UN","CT" D  ; store FF OT into WK array
 .N Y S P=$S(X="OT":TOUR+19,X="DA"&$E(ENT,TOUR+18):TOUR+15,X="DA":TOUR+19,X="CT":TOUR+6,1:9)
 .F D=0:0 S D=$O(@(X_"("_D_")")) Q:D'>0  S Y=@(X_"("_D_")") D SET
 .Q
 ;
 ; check/adjust night differential granted for leave
 D LVND
 Q
SET ; Set sleep time into WK array
 Q:D<1!(D>14)
 S WEEK=$S(D>7:2,1:1)
 S $P(WK(WEEK),"^",P)=$P(WK(WEEK),"^",P)+Y
 Q
 ;
SET1     ; Set sleep time into WK array
 Q:D<1!(D>14)
 S WEEK=$S(D>7:2,1:1)
 S $P(WK(WEEK),"^",P)=$P(WK(WEEK),"^",P)+Y
 Q:(HT>32)&(TH(WEEK)<160)&(NH<320)&($E(ENT,19)=1)
 Q:(HT>32)&(TH(WEEK)<160)&(NH=320)&($E(ENT,19)=1)&($E(AC,2)=2)  ; 9month AWS
 S HT=HT+1,TH(WEEK)=TH(WEEK)+1
 S ^TMP($J,"PRS8",D,"HT")=^TMP($J,"PRS8",D,"HT")+1
 Q
 ;
OTNXTPP(DAY,CALLBK,EMPNM,PPIEN,TLU) ;
 ;OT or CT connects to a tour of duty in the next pay period.
 ;JAH-patch PRS*4*22
 ;If OT or CT are worked in last 2 hours of pay period & 1st day 
 ;of next pay period is missing a tour beginning at midnight, send
 ;a bulletin warning that call back will be paid unless corrective
 ;action is taken.
 ;(i.e a nurse comes in before midnight on last saturday of 
 ;pay period & works for a period less than 2 hrs. before her tour
 ;that begins at midnight on Sunday, first day of the next pp)
 ;
 ; CALLBK  =   start and stop position in 96 char BCD string.
 ; RECORD  =   pointer from employee's tour info to a record 
 ;             in tour of duty file.
 ; DAY  =      day of the pay period 
 ; D1NXTPP  =  BOOLEAN; set to true if tour on day 1 of next pay period 
 ;                      begins at midnight, otherwise false
 ; NEXTP    =  next pay period in 97-05 format.
 ; CURP     =  current pay period in 99-02 format.
 ; TLU      = 3 digit time & leave unit of employee.
 N D1NXTPP,RECORD,CURP,NEXTP,XMDUZ,XMB,XMY,XMDUZ
 S (RTN,D1NXTPP)=0
 S RECORD=$P($G(^TMP($J,"PRS8",15,0)),"^",2)
 I RECORD'="" S D1NXTPP=($P($G(^PRST(457.1,RECORD,1)),"^")="MID")
 I (DAY=14)&($P(CALLBK,"^",2)=96) D
 . I (D1NXTPP) S RTN=1
 . E  D
 ..   S CURP=$P($G(^PRST(458,PPIEN,0)),"^",1)
 ..   S NXTP=$E($$NXTPP^PRSAPPU(CURP),3,7)
 ..;  Send bulletin to G.PAD
 ..   S XMY("G.PAD@"_^XMB("NETNAME"))=""
 ..   S XMDUZ="DHCP PAID package"
 ..   S XMB="PRS LAST SAT OT/CT"
 ..;
 ..;  employee name, pay period number, next pay period
 ..   S XMB(1)=EMPNM,XMB(2)=CURP,XMB(3)=NXTP,XMB(4)=TLU
 ..   D ^XMB
 Q RTN
 ;
LVND ; Leave Night Differential
 ; back out ND granted for leave if employee took 8 or more hrs of leave
 ;   a non-wage grade employee can receive night differential when
 ;   on leave as long as the employee has taken less than 8 hours of
 ;   leave during the pay period.
 ; input (note: units are count of 15min time segments):
 ;   LU     - leave taken during pay period (set in PRS8AC, PRS8MT)
 ;   WK(#)  - piece 10 contains total shift-2 ND for week #
 ;   WKL(#) - ND granted for leave during week # (set in PRS8PP)
 ; output:
 ;   WK(#)  - piece 10 may be modified
 ;   WKL(#) - may be modified
 N W
 Q:TYP["W"  ;              Doesn't apply to Wage Grade
 Q:LU'>31  ;               Didn't take 8hrs of leave
 F W=1,2 D  ;              For each week subtract leave ND from total ND
 . Q:'WKL(W)  ;                                 No leave ND to subtract
 . I +NAWS'=36 S $P(WK(W),"^",10)=$P(WK(W),"^",10)-WKL(W) ; Subtract
 . ; For 36/40 AWS subtract time from Night Differential-AWS (piece 51)
 . I +NAWS=36 S $P(WK(W),"^",51)=$P(WK(W),"^",51)-WKL(W)
 . S WKL(W)=0 ;                                 Reset leave ND amount
 Q
