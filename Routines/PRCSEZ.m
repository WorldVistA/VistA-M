PRCSEZ ;SF-ISC/LJP/CTB-COMPUTATIONS FOR 2237S ; 03/24/94  10:17 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
TRANK Q:X']""  S Z(X)=-X G A
TRANS Q:X']""  S Z(X)=X
A D EN Q:'$D(Z)!'$D(Z("CPB"))!'$D(Z("TT"))  ;G:$D(PRCHOBL)!(Z("TT")="A") A1 G:Z("TT")=""!(Z("SER")="") EX
A1 I Z("TT")="O" D:$G(Z("SER"))]"" 1 G ST
 I Z("TT")="A" S Z(X)=-Z(X) D 3 D:Z("FT")'=1 4 G ST
 I Z("TT")="CA" D 3,4 G ST
 Q
TRANK1 Q:X']""  S Z(X)=-X G B
TRANS1 Q:X']""  S Z(X)=X
B D EN Q:'$D(Z)!('$D(Z("CPB")))!'$D(Z("TT"))  ;G:$D(PRCHOBL)!(Z("TT")="A") B1 G:Z("TT")=""!(Z("OB")="") EX
B1 I Z("TT")="O" D 2 G ST
 I Z("TT")="A" S Z(X)=-Z(X) D 4 G ST
 I Z("TT")="C" D 3,4 G ST
 Q
EN G:'$D(^PRCS(410,DA,0)) EX1 S Z=^(0) G:$P(Z,U)=$P(Z,U,3) EX1 G:'$D(^(4)) EX1 S Z(4)=^(4),Z("OB")=$P(Z(4),U,5),Z("FIS")=$P(Z(4),U,10) G:'$D(^(7)) EX1 S Z(7)=^(7),Z("SER")=$P(Z(7),U,6),Z("GPF")=$P(Z(7),U,9)
 S Z("ST")=+Z,Z("CP")=+$P(Z,"-",4),Z("FY")=$P(Z,"-",2),Z("QT")=$P(Z,"-",3)
 I $P(Z,U,11) S Z("QT")=$$DATE^PRC0C($P(Z,U,11),"I"),Z("FY")=$E(Z("QT"),3,4),Z("QT")=$P(Z("QT"),U,2)
 S Z("AMT")=X,Z("TT")=$P(Z,U,2),Z("FT")=$P(Z,U,4),Z("SPC")=Z("QT")+1,Z("FPC")=Z("QT")+5
 D ARFY
 QUIT
 ;
 ;add new comm/obl record if not defined
ARFY ;
 ;P182--Commented out following line.  TEMPREQ no longer used as of P140
 ;Q:$D(TEMPREQ)
 S:'$D(^PRC(420,Z("ST"),1,Z("CP"),4,0)) ^(0)="^420.06A^^"
 I '$D(^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),0)) S ^(0)=Z("FY")_"^0^0^0^0^0^0^0^0",$P(^(0),U,3,4)=Z("FY")_U_($P(^PRC(420,Z("ST"),1,Z("CP"),4,0),U,4)+1),^PRC(420,Z("ST"),1,Z("CP"),4,"B",Z("FY"),Z("FY"))=""
 S Z("CPB")=^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),0)
 S:'$D(^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),1)) ^(1)="^0^0^0^0" S Z("SCPB")=^(1)
 I '$D(^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),2)) D
 . S ^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),2)=$$SUBALL
 . QUIT
 QUIT
 ;
SUBALL() ;EV get fms allowance account
 N A,B
  S (A,B)=""
 I $D(^PRC(420,Z("ST"),1,Z("CP"),0)) S $P(A,"^",1)=$P(^(0)," "),$P(A,"^",2)=$P($P(^(0),"^")," ",2,999),$P(A,"^",3)=$P(^(0),"^",2),B=$G(^(5))
 S $P(A,"^",4)=$P(B,"^",5),$P(A,"^",5)=$P(B,"^",2)
 S $P(A,"^",6)=$P(B,"^",3),$P(A,"^",7)=$P(B,"^",4)
 S $P(A,"^",8)=$P(B,"^",6)
 I $P(A,"^",3) S B=^PRCD(420.3,$P(A,"^",3),0),$P(A,"^",9)=$P(B,"^",3),$P(A,"^",10)=$P(B,"^",7)
 QUIT A
 ;
 ;A=station #, B=fiscal year (not bbfy), C=fcp #
ACC(A,B,C) ;EF-retrieve fcp fiscal year fms suballowance data
 N Z
 S Z=$G(^PRC(420,+A,1,+C,4,B,2))
 I Z="" S Z("ST")=+A,Z("FY")=B,Z("CP")=+C,Z=$$SUBALL
 QUIT Z
 ;
1 S $P(Z("CPB"),U,Z("SPC"))=$P(Z("CPB"),U,Z("SPC"))-$J(Z(X),0,2),$P(Z("SCPB"),U,Z("SPC"))=$P(Z("SCPB"),U,Z("SPC"))-$J(Z(X),0,2)
 Q
2 S $P(Z("CPB"),U,Z("FPC"))=$P(Z("CPB"),U,Z("FPC"))-$J(Z(X),0,2) ; Q:Z("FT")'=1  Q:'$D(Z(58))  S $P(Z(58),U,2)=$P(Z(58),U,2)-$J(Z(X),0,2)
 Q
3 G ADD ;I Z("TT")'="A" G ADD
 ;I Z("TT")="A",Z("FT")="" G ADD
 ;I Z("FT")=1,Z("TT")="A",Z("SER")]"" G ADD
 Q
ADD S $P(Z("CPB"),U,Z("SPC"))=$P(Z("CPB"),U,Z("SPC"))+$J(Z(X),0,2),$P(Z("SCPB"),U,Z("SPC"))=$P(Z("SCPB"),U,Z("SPC"))+$J(Z(X),0,2) ; Q:Z("FT")'=1  ; Q:'$D(Z(58))  S $P(Z(58),U,1)=$P(Z(58),U,1)+$J(Z(X),0,2),$P(Z(58),U,3)=$P(Z(58),U,3)+$J(Z(X),0,2)
 Q
4 G ADD1 ;I Z("TT")'="A" G ADD1
 ;I Z("TT")="A",Z("FT")="" G ADD1
 ;I Z("FT")=1,Z("TT")="A" I Z("FIS")]"" G ADD1
 Q
ADD1 S $P(Z("CPB"),U,Z("FPC"))=$P(Z("CPB"),U,Z("FPC"))+$J(Z(X),0,2) ; Q:Z("FT")'=1  Q:'$D(Z(58))  S $P(Z(58),U,2)=$P(Z(58),U,2)+$J(Z(X),0,2)
 Q
ST S ^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),0)=Z("CPB"),^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),1)=Z("SCPB") ; Q:Z("FT")'=1  I $D(Z(58)) S ^PRC(442,Z("PO"),8)=Z(58)
EX ;
EX1 K Z QUIT
 ;
 ;PRCA data ^1=station #, ^2=fcp #, ^3=fy, ^4=QTR #, ^5=$amount (- for credit)
 ;PRCB=O if obligated balance, C if commited (and sub fcp)
EBAL(PRCA,PRCB) ;edit fcp (subfcp) commited/obligated balance without file 410
 N Z,A,B
 S Z("ST")=+PRCA,Z("CP")=+$P(PRCA,"^",2),Z("FY")=$P(PRCA,"^",3)
 S Z("QT")=$P(PRCA,"^",4),Z("AMT")=+$P(PRCA,"^",5),X=Z("AMT"),Z(X)=X
 S Z("SPC")=Z("QT")+1,Z("FPC")=Z("QT")+5
 D ARFY Q:'$D(Z("CPB"))
 D:PRCB="O" 2,ST D:PRCB="C" 1,ST
 QUIT
 ;
