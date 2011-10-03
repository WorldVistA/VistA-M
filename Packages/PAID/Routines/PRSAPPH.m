PRSAPPH ; WOIFO/JAH - Holiday Utilities ;12/17/08
 ;;4.0;PAID;**33,66,113,112,116,123**;Sep 21, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 K HOL S PDT=$G(^PRST(458,PPI,1)) Q:PDT=""  S X1=$P(PDT,"^",1),X2=-6 D C^%DTC
 S PRS8D=X D EN^PRS8HD
 S PDH=PRS8D F DAY=1:1:25 S X1=PRS8D,X2=DAY D C^%DTC S PDH=PDH_"^"_X
 F DAY=1:1:26 S Z=$P(PDH,"^",DAY) I $D(HD(Z)) S HOL(Z)=$S(DAY<7:-DAY,1:DAY-6) I $G(HD(Z))["Inauguration" S HOL(Z,"SC")="W"
 K HO,HD,PRS8D,PDH Q
E ; Set Holidays for Employees
 S FLX=$P($G(^PRST(458,PPI,"E",DFN,0)),"^",6),DB=$P($G(^PRSPC(DFN,0)),"^",10)
 S NH=$P($G(^PRSPC(DFN,0)),"^",16) Q:NH>80
 F LLL=0:0 S LLL=$O(HOL(LLL)) Q:LLL<1  S DAY=HOL(LLL) D E0
 Q
E0 ; Find Benefit Day
 Q:DAY=15  I DAY>0,DAY<15 G P0
 Q:$D(HOL(LLL,"SC"))
 Q:DB'=1  Q:NH=48!(NH=72)  G P1:DAY<0,P3:DAY>14
P0 S TC=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",2) Q:'TC
 I (TC=3)!(TC=4) G U1
 I DB=1,NH=48 G U1
 S C=0
 I TC=2!$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",8)!$P($G(^(0)),"^",14),'$P($G(^(0)),"^",12) G S0
 Q:$P($G(^(0)),"^",12)=LLL&(TT="HX") 
 G U1:DB=2!(NH=72)
 I $G(HOL(LLL,"SC"))="W" G U1
 ; From this point on the code is trying to find an In Lieu of Day
 I FLX'="C" G EF:(DAY#7=1),EB:(DAY#7=0)
 S C=0 F X1=$S(DAY<8:1,1:8):1:DAY I '$P($G(^PRST(458,PPI,"E",DFN,"D",X1,0)),"^",8),'$P($G(^(0)),"^",14) S C=C+1
 I FLX'="C" G EF:C<2,EB
 I C'=2 G EF:C<3,EB
 I DAY#7 F X1=DAY+1:1:$S(DAY<8:7,1:14) I '$P($G(^PRST(458,PPI,"E",DFN,"D",X1,0)),"^",8),'$P($G(^(0)),"^",14) S C=C+1
 G EB:C=2,EF
 ;
 ;if looking forward, don't set off for another holiday
 ;
EF F DAY=DAY+1:1:14 S TC=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",2) Q:TC=""  I TC=2!$P($G(^(0)),"^",8)!$P($G(^(0)),"^",14),'$$FUTRHOL(),$$PREVSET() G S0
 Q
 ;
FUTRHOL() ;Check to see if day is another future holiday.
 Q $G(HOL($P($G(^PRST(458,PPI,1)),"^",DAY)))>0
PREVSET() ; Day NOT Already Set as holiday
 Q ('($P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",12)>0)!($P($G(^(0)),"^",12)=LLL))
 ;
 ;back up to find an available day to set the Holiday.
EB F DAY=DAY-1:-1:1 S TC=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",2) Q:TC=""  I $$PREVSET(),TC=2!$P($G(^(0)),"^",8)!$P($G(^(0)),"^",14) G S0
 Q
 ;
P1 I FLX'="C" Q:DAY'=-5  S C=13 D PF Q:'Z  S DAY=0 G EF
 S C=8-DAY D PF Q:'Z
 S DAY=8-DAY,C=0 F X1=8:1:DAY I '$P($G(^PRST(458,PPI-1,"E",DFN,"D",X1,0)),"^",8),'$P($G(^(0)),"^",14) S C=C+1
 Q:C>2  I C<2 S DAY=0 G EF
 I DAY<14 F X1=DAY+1:1:14 I '$P($G(^PRST(458,PPI-1,"E",DFN,"D",X1,0)),"^",8),'$P($G(^(0)),"^",14) S C=C+1
 Q:C=2  S DAY=0 G EF
P3 I FLX'="C" Q:DAY'=16  S C=2 D PN Q:'Z  S DAY=15 G EB
 Q:DAY=15  S C=DAY-14 D PN Q:'Z  I DAY>16 S DAY=15 G EB
 S C=2 F L1=3:1:7 D
 .S X1=$G(^PRST(458,PPI+1,"E",DFN,"D",L1,0)) I X1'="" S:$P(X1,"^",8)+$P(X1,"^",14)=0 C=C+1 Q
 .S X1=$P($G(^PRST(458,PPI,"E",DFN,"D",L1,0)),"^",2,4) I $P(X1,"^",3),$P(X1,"^",4) S X1=$P(X1,"^",4)
 .S:'$P($G(^PRST(457.1,+X1,0)),"^",6) C=C+1 Q
 Q:C>2  S DAY=15 G EB
PN ; Determine TC for next Pay Period; if Z=1 then all TC=1 for days 1 to C
 S Z=1 F C=C:-1:1 D  Q:'Z
 .S X1=$P($G(^PRST(458,PPI+1,"E",DFN,"D",C,0)),"^",2) I X1=2 S Z=0 Q
 .I X1'="" S X1=$P($G(^PRST(458,PPI+1,"E",DFN,"D",C,0)),"^",8)+$P($G(^(0)),"^",14) S:X1 Z=0 Q
 .S X1=$P($G(^PRST(458,PPI,"E",DFN,"D",C,0)),"^",2,4) I $P(X1,"^",2),$P(X1,"^",3) S X1=$P(X1,"^",3)
 .S X1=+X1 I X1=0!(X1=2) S Z=0 Q
 .S:$P($G(^PRST(457.1,X1,0)),"^",6) Z=0 Q
 Q
PF ; Determine TC for prior PP
 S Z=1 F C=C:1:14 D  Q:'Z
 .S X1=$P($G(^PRST(458,PPI-1,"E",DFN,"D",C,0)),"^",2) I X1=""!(X1=2) S Z=0 Q
 .S X1=$P($G(^PRST(458,PPI-1,"E",DFN,"D",C,0)),"^",8)+$P($G(^(0)),"^",14) S:X1 Z=0 Q
 Q
S0 ; Set Holiday (Excused or Worked)
 I TT="HX",$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",12)=LLL Q
 S Z=$G(^PRST(458,PPI,"E",DFN,"D",DAY,1)) I Z="" S $P(^(2),"^",3)=TT Q:TT="HW"  G UPD
 S ZS=$G(^PRST(458,PPI,"E",DFN,"D",DAY,4)) I ZS'="" D FND
 S ZS="",L1=1 F K=1:3:19 Q:$P(Z,"^",K)=""  D
 .I $P(Z,"^",K+2),"RG"'[$P($G(^PRST(457.2,+$P(Z,"^",K+2),0)),"^",2) Q
 .S $P(ZS,"^",L1)=$P(Z,"^",K),$P(ZS,"^",L1+1)=$P(Z,"^",K+1)
 .S $P(ZS,"^",L1+2)=TT S L1=L1+4 Q
 S:ZS'="" ^PRST(458,PPI,"E",DFN,"D",DAY,2)=ZS Q:TT="HW"  G:'DUP UPD
 ; Remove holiday on another day
 S K=PPI F L1=$S(DAY-8>0:DAY-8,1:1):1:$S(DAY+8<15:DAY+8,1:14) I $P($G(^PRST(458,K,"E",DFN,"D",L1,0)),"^",12)=LLL D REM
 I DAY<9 S K=PPI-1 F L1=(DAY+6):1:14 I $P($G(^PRST(458,K,"E",DFN,"D",L1,0)),"^",12)=LLL D REM
 I DAY>6 S K=PPI+1 F L1=1:1:(DAY-6) I $P($G(^PRST(458,K,"E",DFN,"D",L1,0)),"^",12)=LLL D REM
UPD ; Update status
 S $P(^PRST(458,PPI,"E",DFN,"D",DAY,10),"^",1,4)="T^"_DUZ_"^"_NOW_"^2"
U1 ; Mark as Holiday
 S $P(^PRST(458,PPI,"E",DFN,"D",DAY,0),"^",12)=LLL Q
REM ; Remove posting for moved holiday
 I $P($G(^PRST(458,K,"E",DFN,0)),"^",2)'="T" Q
 S $P(^PRST(458,K,"E",DFN,"D",L1,0),"^",12)=""
 S ZS=$G(^PRST(458,K,"E",DFN,"D",L1,2)) Q:ZS=""
 I ZS["HX"!(ZS["HW") K ^PRST(458,K,"E",DFN,"D",L1,2),^(3),^(10)
 Q
FND ; Determine which tour is first
 N X,Y S X=$P(Z,"^",1),Y=0 D MIL^PRSATIM S K=Y
 S X=$P(ZS,"^",1),Y=0 D MIL^PRSATIM S:Y<K Z=ZS Q
 Q
