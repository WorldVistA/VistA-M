RCMSDD1 ;WASH-ISC@ALTOONA,PA/RGY-Process DD site fields ;5/17/94  1:56 PM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
GRPTYP ;Input transform for AR GROUP TYPE (342.1,.02)
 I '$P($G(^RC(342.2,X,0)),"^",2)&$O(^RC(342.1,"AC",X,0)) K X W !,"*** You already have this type of group defined ***",!
 Q
IRSL ;Input transform for IRS OFFSET letters
 S Y=X X ^DD("DD") W "   (",$P(Y,","),")"
 I $E(X,4,7)>1007!($E(X,4,7)<901) K X W !!,"*** Recommended date must be between 9/1 and 9/20! ***",! Q
 I $E(X,4,7)>920 W *7,!!,"WARNING: You have selected a date outside the recommended",!,"date range of 9/1 and 9/20!",!
 Q
IRSM ;Input transform for IRS MASTER codesheets
 S Y=X X ^DD("DD") W "   (",$P(Y,","),")"
 I $E(X,4,7)>1205!($E(X,4,7)<1122) K X W !!,"*** IRS Master update must be generated",!,"between NOV 22 and DEC 05!",! K X
 Q
