PRCAFN1 ;WASH-ISC@ALTOONA,PA/LDB-Functions to return AR data ;8/12/93  10:36 AM
V ;;4.5;Accounts Receivable;**48**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;;
EN(TRAN) ;Input is transaction number
 ;Variable returned = internal number of debtor^internal bill number
 N X,Y
 S Y=$P($G(^PRCA(433,+TRAN,0)),"^",2) G NULL:'Y
 S X=$P($G(^PRCA(430,+Y,0)),"^",9) G NULL:'X
 S $P(X,"^",2)=Y
 Q X
 ;
NULL ;Either no bill or debtor
 S X=""
 Q X
 ;
 ;
CAT(Y) ;Input: Internal Bill #
 ;Return: Category #^Category name^Category Type or -1
 ;
 I Y>0 S Y=$S('$D(Y)#2:-1,Y="":-1,1:$G(^PRCA(430.2,+$P($G(^PRCA(430,Y,0)),"^",2),0))) S:Y="" Y=-1 S:Y'=-1 Y=$P(Y,"^",7)_"^"_$P(Y,"^")_"^"_$P(Y,"^",6)
 Q Y
 ;
PAID(Y) ;Input: Internal Bill #
 ;Return: Amount of payments on receivable
 N AMT,X
 S AMT=0
 I 'Y!(Y<0)!('$D(^PRCA(430,Y,0))) S Y="ERROR" G PAIDQ
 S X="" F  S X=$O(^PRCA(433,"C",+Y,X)) Q:'X  D
 .S X(1)=$G(^PRCA(433,+X,1))
 .S X(2)=$P(X(1),"^",2)
 .I "^2^34^"[("^"_X(2)_"^") S AMT=AMT+$P(X(1),"^",5)
 S Y=AMT
PAIDQ Q Y
