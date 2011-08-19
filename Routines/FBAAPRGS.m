FBAAPRGS ;AISC/DMK-STATUS OF PURGE ;15JUL92
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$D(^XUTL("FBAAPURGE")) W !?5,"Fee Purge is not running!",! Q
 ;
 W !?5,"Total Payment Line Items to be Purged:  ",$FN($P(^XUTL("FBAAPURGE"),"^"),",")
 W !!?5,"Number of Line Items Purged as of now:  ",$FN($P(^XUTL("FBAAPURGE"),"^",2),",")
 Q
