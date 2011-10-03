PRCB1E ;WISC/PLT-QUARTERLY CARRY FORWARD ; 03/01/96  1:27 PM
V ;;5.1;IFCAP;**64,72**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN ;quarterly carry forward
 N PRCA,PRCB,PRCQCD,PRCOPT,PRCRI,PRCDI,PRCDUZ,PRC,PRCDES
 N A,B,C
 S PRCQCD=1 ;over lapping days
Q1 ;station
 S PRCF("X")="AS" D ^PRCFSITE G:'% EXIT
 S PRCRI(420)=+PRC("SITE")
Q2 S B="O^1:Carry forward Outstanding Requests;2:Carry forward balances for all control points;3:Carry forward balances for a single control point"
 K X,Y S Y(1)="^W ""Enter an option number 1 to 3."""
 D SC^PRC0A(.X,.Y,"Select Number",B,"")
 S A=Y K X,Y
 G EXIT:A=""!(A["^")
 S PRCOPT=+A
 I PRCOPT=1 G Q4
 I "12"[PRCOPT G Q4
Q3 ;select control point
 S PRCDI="420;^PRC(420,;"_PRC("SITE")
 S $P(PRCDI,"~",2)="420.01;"_$P($P(PRCDI,"~"),";",2)_PRCRI(420)_",1,;"
 S X("S")="I ^(0)-9999"
 D LOOKUP^PRC0B(.X,.Y,PRCDI,"AEOQS","Select Fund Control Point: ")
 I Y<0!(X="") S PRCQT="^" G Q2
 K X S PRCRI(420.01)=+Y,PRC("CP")=$P($P(Y,"^")," ")
Q4 ;fiscal year - quarter
 S A=$P($G(^PRC(420,PRC("SITE"),0)),"^",9),A=$$DATE^PRC0C(A,"I")
 S PRCA=$P(A,"^")_"-"_$P(A,"^",2)_"^"_$P(A,"^",7)_"^"_$P(A,"^",8)
 S A=$$DATE^PRC0C($P(PRCA,"^",3)+100,"H"),A=$$QTRDATE^PRC0D(+A,$P(A,"^",2))
 S B="" F C=$P(A,"^",8):1 S:C-3#7'=6&(C-3#7) B=B+1 Q:B=PRCQCD
 S $P(PRCA,"^",4,5)=$P($$DATE^PRC0C(C-1,"H"),"^",7,8)
 D EN^DDIOL(" "),EN^DDIOL("The oldest OPEN quarter in file is "_$P(PRCA,"^",1)_".")
 S E="O^4:6^K:X'?2N.1""-"".1N&(X'?4N.1""-"".1N)!($P(X,""-"",2)<1)!($P(X,""-"",2)>4) X",Y(1)="Enter a 2 or 4 digit year followed by a '-' and quarter #, like 88-3 or 1988-3"
 D FT^PRC0A(.X,.Y,"For Budget Fiscal Year - Quarter (YY-Q)",E,"")
 G:X["^"!(X="")!(Y'?2.4N.1"-".1N) Q2
 S $P(Y,"-")=+$$YEAR^PRC0C($P(Y,"-"))
 I "1"[PRCOPT,Y]$P(PRCA,"^")!(Y=$P(PRCA,"^")&($H-1<$P(PRCA,"^",5))) S A="You must close quarter "_$P(PRCA,"^")_" first after "_$E($P(PRCA,"^",4),4,5)_"/"_$E($P(PRCA,"^",4),6,7)_"/"_$E($P(PRCA,"^",4),2,3) D EN^DDIOL(A) G Q4
 I "23"[PRCOPT,Y]$P(PRCA,"^")!(Y=$P(PRCA,"^")) D EN^DDIOL("You may only rerun closed quarters. That is any quarter before "_$P(PRCA,"^")) G Q4
 I "1996-1"]Y D EN^DDIOL("Carry forward can not be run for any quarters before '96-1'.") G Q4
 S $P(PRCOPT,"^",2)=Y,$P(PRCOPT,"^",3)=PRCRI(420),$P(PRCOPT,"^",4)=$G(PRCRI(420.01))
 I $P(PRCOPT,"^",2)["-4",$P(^PRC(411,PRC("SITE"),0),"^",25)'="Y" D EN^DDIOL("The outstanding requests are not carried forward to the new fiscal year.")
Q5 D YN^PRC0A(.X,.Y,"Ready to Run","O","NO")
 I X["^"!(X="")!'Y S PRCOPT=$P(PRCOPT,"^") G Q4
 D CF
EXIT QUIT
 ;
 ;
CF ;start carry forward
 N PRCDUZ
 S PRCDUZ=DUZ
 I +PRCOPT=1 S ZTDESC="IFCAP Carry Forward Outstanding Requests from Qtr "_$E($P(PRCOPT,"^",2),3,999)
 I +PRCOPT=2 S ZTDESC="IFCAP Carry Forward Balances for All CP'S from Qtr "_$E($P(PRCOPT,"^",2),3,999)
 I +PRCOPT=3 S ZTDESC="IFCAP Carry Forward Balances for a Single CP from Qtr "_$E($P(PRCOPT,"^",2),3,999)
 S PRCDES=ZTDESC
 S ZTRTN="TMEN^PRCB1E1" F A="PRCOPT","PRCDUZ","PRCDES","DUZ*" S ZTSAVE(A)=""
 D ^PRCFQ
 QUIT
