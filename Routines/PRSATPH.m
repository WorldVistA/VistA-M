PRSATPH ; HISC/REL-Exception Utilities ;12/9/93  09:53
 ;;4.0;PAID;;Sep 21, 1995
NX ; Determine first start time of next day
 I DAY<14 S TC1=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY+1,0)),"^",2),TC2=$P($G(^(0)),"^",13) G N1
 I $D(^PRST(458,PPI+1,"E",DFN,"D",1,0)) S TC1=$P(^(0),"^",2),TC2=$P($G(^(0)),"^",13) G N1
 S ZPX=$G(^PRST(458,PPI,"E",DFN,"D",1,0)),TC1=$P(ZPX,"^",2),TC2=""
 S:$P(ZPX,"^",3) TC1=$P(ZPX,"^",4)
N1 S TC1=$G(^PRST(457.1,+TC1,1)),Z9=""
 F KK=1:3 Q:$P(TC1,"^",KK)=""  S Z=$P(TC1,"^",KK+2) I $S('Z:1,1:$P($G(^PRST(457.2,Z,0)),"^",2)="RG") S Z9=$P(TC1,"^",KK) Q
 S TC1=Z9 G:'TC2 N2
 S TC2=$G(^PRST(457.1,TC2,1)),Z9=""
 F KK=1:3 Q:$P(TC2,"^",KK)=""  S Z=$P(TC2,"^",KK+2) I $S('Z:1,1:$P($G(^PRST(457.2,Z,0)),"^",2)="RG") S Z9=$P(TC2,"^",KK) Q
 S TC2=Z9
N2 N X,Y S X=TC1,Y=0 D MIL^PRSATIM S TC1=Y
 I TC2'="" S X=TC2,Y=0 D MIL^PRSATIM S:Y<TC1 TC1=Y
 S TC1=TC1\100*60+(TC1#100) I $P(Y0,"^",2)>TC1 S ERR=10 D ERR^PRSATPE
 Q
PR ; Determine last end time of previous day
 I DAY>1 S TC1=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY-1,0)),"^",2),TC2=$P($G(^(0)),"^",13)
 E  Q:'$D(^PRST(458,PPI-1,"E",DFN,"D",14,0))  S TC1=$P(^(0),"^",2),TC2=$P($G(^(0)),"^",13)
 I $P($G(^PRST(457.1,+TC1,0)),"^",5)="Y" S ZPX=$G(^(1))
 E  Q:$P($G(^PRST(457.1,+TC2,0)),"^",5)'="Y"  S ZPX=$G(^(1))
 N X,Y S Z="",DY2=1 F KK=1:3:19 S X=$P(ZPX,"^",KK,KK+1) Q:"^"[X  D CNV^PRSATIM S:$P(Y,"^",2)'>$P(Y,"^",1) DY2=2 I DY2=2 S Z9=$P(ZPX,"^",KK+2) I $S('Z9:1,1:$P($G(^PRST(457.2,Z9,0)),"^",2)="RG") S Z=$P(Y,"^",2)
 Q:Z=""  I Z>$P(Y0,"^",1) S ERR=11 D ERR^PRSATPE
 Q
UN ; Check UN against OT CT ON SB in tour
 K TUN F KK=1:3 Q:$P(X1,"^",KK)=""  S Z=$P(X1,"^",KK+2) I $S('Z:0,1:$P($G(^PRST(457.2,Z,0)),"^",2)'="RG") D
 .S X=$P(X1,"^",KK,KK+1) D CNV^PRSATIM S Z1=$P(Y,"^",1),Z2=$P(Y,"^",2) D V0
 .I Z1'="",$G(TUN(Z1))="*" K TUN(Z1) S TUN(Z2)="*" Q
 .S TUN(Z1)="",TUN(Z2)="*" Q
 I X4'="" F KK=1:3 Q:$P(X4,"^",KK)=""  S Z=$P(X4,"^",KK+2) I $S('Z:0,1:$P($G(^PRST(457.2,Z,0)),"^",2)'="RG") D
 .S X=$P(X4,"^",KK,KK+1) D CNV^PRSATIM S Z1=$P(Y,"^",1),Z2=$P(Y,"^",2) D V0
 .I Z1'="",$G(TUN(Z1))="*" K TUN(Z1) S TUN(Z2)="*" Q
 .S TUN(Z1)="",TUN(Z2)="*" Q
 S Z1=$P(Y0,"^",1),Z2=$P(Y0,"^",2) D V0
 S Z1=$O(TUN(Z1)) S:Z1'="" Z1=TUN(Z1)
 S Z2=$O(TUN(Z2-1)) S:Z2'="" Z2=TUN(Z2)
 I Z1'="*"!(Z2'="*") S ERR=12 D ERR^PRSATPE
 Q
V0 I Z2>Z1 S:$O(TUN(""))'<Z2 Z1=Z1+1440,Z2=Z2+1440 Q
 S Z2=Z2+1440 Q
