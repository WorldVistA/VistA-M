RCEVDD1 ;WASH-ISC@ALTOONA,PA/RGY-Process event driver DD fields ;6/17/93  1:01 PM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EVNNUM ;Input transform for EVENT NUMBER (341.1,.02)
 I $O(^RC(341.1,"AC",X,0)),$O(^(0))'=DA W !,"*** Already being used for '",$P($G(^RC(341.1,$O(^(0)),0)),"^"),"' ***",! K X
 Q
