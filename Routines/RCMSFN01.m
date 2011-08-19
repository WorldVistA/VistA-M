RCMSFN01 ;WASH-ISC@ALTOONA,PA/RGY-Miscellaneous Site Functions ;7/3/96  11:16 AM
V ;;4.5;Accounts Receivable;**47**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
INT(Y) ;Input: Date
 ;Return: Effective Interest Rate^Effective date
 NEW X
 S X=+$O(^RC(342,1,4,"AC",9999999-$S($G(Y):Y,1:DT)))
 Q +$P($G(^RC(342,1,4,+$O(^RC(342,1,4,"AC",X,0)),0)),"^",2)_"^"_$S(X:9999999-X,1:"")
ADM(Y) ;Input: Date
 ;Return: Effective Admin. charge^Effective date
 NEW X
 S X=+$O(^RC(342,1,4,"AC",9999999-$S($G(Y):Y,1:DT)))
 Q +$P($G(^RC(342,1,4,+$O(^RC(342,1,4,"AC",X,0)),0)),"^",3)_"^"_$S(X:9999999-X,1:"")
PEN(Y) ;Input: Date
 ;Return: Effective Penalty Rate^Effect date
 NEW X
 S X=+$O(^RC(342,1,4,"AC",9999999-$S($G(Y):Y,1:DT)))
 Q +$P($G(^RC(342,1,4,+$O(^RC(342,1,4,"AC",X,0)),0)),"^",4)_"^"_$S(X:9999999-X,1:"")
LIT(Y) ;Input: Date
 ;Return: Effective Penalty^Effective Date
 NEW X
 S X=+$O(^RC(342,1,4,"AC",9999999-$S($G(Y):Y,1:DT)))
 Q +$P($G(^RC(342,1,4,+$O(^RC(342,1,4,"AC",X,0)),0)),"^",5)_"^"_$S(X:9999999-X,1:"")
