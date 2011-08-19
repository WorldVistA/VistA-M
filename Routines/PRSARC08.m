PRSARC08 ;WOIFO/JAH - Tour hours procedure calls ;12/19/06
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
TRSHFTS(TOURIEN) ; return two piece ^ string with EARLIEST shift special
 ; indicator for a tour 
 ;
 N TOUR,TODSHFT,TOMSHFT,TSEGS,TWODAYTR,I
 N DONE,CROSS,BEG,END,SPIND,BEG24,END24
 Q:$G(TOURIEN)'>0 "^"
 S (TODSHFT,TOMSHFT)="4"
 S TOUR=$G(^PRST(457.1,TOURIEN,0))
 S TSEGS=$G(^PRST(457.1,TOURIEN,1))
 S TWODAYTR=$P(TOUR,U,5)="Y"
 S (DONE,CROSS)=0
 F I=1:3:18 D  Q:DONE
 .  S BEG=$P(TSEGS,U,I)
 .  I BEG="" S DONE=1 Q
 .  S END=$P(TSEGS,U,I+1)
 .  S SPIND=$P(TSEGS,U,I+2) I SPIND="" S SPIND=1
 .  S SPIND=$TR(SPIND,"67","23")
 .  Q:"^1^2^3^"'[("^"_SPIND_"^")
 . ; convert beg and end to twenty four hr to determine if one is
 . ; less than other and hence crosses midnight. You've also
 . ;  crossed midnight if a segment other than first starts at
 . ;  midnight.
 . ; Set CROSS to true so any remaining segments get recorded to
 . ; tomorrow.
 .    S BEG24=$$TWENTY4^PRSPESR2(BEG)
 .    S END24=$$TWENTY4^PRSPESR2(END)
 .    I 'CROSS&((BEG24'<END24)!((I>1)&(BEG24=2400))) D
 ..     S CROSS=1
 ..     I SPIND<TODSHFT S TODSHFT=SPIND
 ..     I SPIND<TOMSHFT S TOMSHFT=SPIND
 .    E  D
 ..     I CROSS D
 ...       I SPIND<TOMSHFT S TOMSHFT=SPIND
 ..     E  D
 ...       I SPIND<TODSHFT S TODSHFT=SPIND
 I TODSHFT=4 S TODSHFT=""
 I TOMSHFT=4 S TOMSHFT=""
 Q TODSHFT_"^"_TOMSHFT
 ;
PLACEML(S1,S2,M) ; Remove meal from hrs on 2 day tour.  Put meal in middle and
 ; remove from today S1 or tomorrow S2.  Function considers only amount
 ; of hrs worked, to indicate in which hr of total hrs meal
 ; would begin.  It doesn't consider where hrs are placed in day.
 ; INPUT:
 ;  S1 = HRS ON DAY 1 (DECIMAL 8.0, 8.5, ETC)
 ;  S2 = HRS ON DAY 2
 ;  M = LENGTH OF MEAL IN DECIMAL FORM .25 HRS, .5 HRS ETC
 ;
 ; ETA deals with quarter hrs so (\.25*.25) will round
 ; down result to quarter hr.
 ;
 I (M>60)!(M<15)!((M#15)'=0) Q S1_"^"_S2
 ; Convert minutes meal to decimal
 N X S X=M D MEALIN^PRSPESR2 S M=.25*X
 N MEALHR,NS1,NS2
 S MEALHR=(S1+S2)/2-(M/2)\.25*.25
 Q:MEALHR'>0 S1_"^"_S2
 ;
 ;  pull meal from S1, S2 or both
 I MEALHR<S1 D
 .  I (MEALHR+M)'>S1 D
 ..   S NS2=S2
 ..   S NS1=S1-M
 .  E  D
 ..   S NS1=S1-(S1-MEALHR)
 ..   S NS2=S2-(M-(S1-MEALHR))
 E  D
 .   S NS1=S1
 .   S NS2=S2-M
 Q NS1_"^"_NS2
 ;
EARLYSH(TH,WAGER) ; LOOP THROUGH ARRAY TO FIND EARLIEST SHIFT
 ;
 N EARLIEST,HRS,SHIFT,TOURDAY
 I WAGER D
 .  S EARLIEST=0
 E  D
 .  S EARLIEST=4
 .  S TOURDAY=0
 .  F  S TOURDAY=$O(TH(TOURDAY)) Q:TOURDAY'>0  D
 ..    S HRS=$P($G(TH(TOURDAY)),U,2)
 ..    Q:HRS'>0
 ..    S SHIFT=$P($G(TH(TOURDAY)),U)
 ..    I SHIFT<EARLIEST S EARLIEST=SHIFT
 I EARLIEST=4 S EARLIEST=""
 Q EARLIEST
 ;
ISWAGE(PRSIEN) ; return true for wage grade 
 I $G(PRSIEN)'>0 Q "0^undefined employee"
 N PAYPLAN,ISWAGE
 S ISWAGE=1
 I '$D(^PRSPC(PRSIEN,0)) Q "0^undefined employee"
 S PAYPLAN=$P($G(^PRSPC(PRSIEN,0)),U,21)
 I "0123456789GU"'[PAYPLAN S ISWAGE=0
 Q ISWAGE
 ;
ISCMPTR(PPI,PRSIEN) ; return true for compressed tours
 ;
 N ISCT S ISCT=0 I $P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,6)="C" S ISCT=1
 Q ISCT
 ;
TOTAL(TH,WKS) ; array loop tallis hrs
 ; INPUT : WKS (optional) 1 for week one total, 2 for week 2 total,
 ;                        otherwise full pay period total.
 N LASTDAY,TOURDAY,TOTAL S TOTAL=0
 S TOURDAY=$S($G(WKS)=2:7,1:0)
 S LASTDAY=$S($G(WKS)=1:7,1:14)
 F  S TOURDAY=$O(TH(TOURDAY)) Q:TOURDAY>LASTDAY!(TOURDAY'>0)  D
 .  S TOTAL=TOTAL+$P($G(TH(TOURDAY)),U,2)
 Q TOTAL
 ;
PARSE(VALMNOD,BEG,END) ; -- Copy from VALM2 split out pre-answers from user
 N Y,J,L,X
 S Y=$TR($P($P(VALMNOD,U,4),"=",2),"/\; .",",,,,,")
 I Y["-" S X=Y,Y="" F I=1:1 S J=$P(X,",",I) Q:J']""  I +J>(BEG-1),+J<(END+1) S:J'["-" Y=Y_J_"," I J["-",+J,+J<+$P(J,"-",2) F L=+J:1:+$P(J,"-",2) I L>(BEG-1),L<(END+1) S Y=Y_L_","
 Q Y
