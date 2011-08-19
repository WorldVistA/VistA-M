XTRGRPE ;SF/RWF - Routine group edit ; 12/21/88  14:49 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
A W !!,"Routine Group Edit",! X ^%ZOSF("RSEL") Q:$O(^UTILITY($J,0))']""
 S RN=""
 X "F II=0:0 S RN=$O(^UTILITY($J,RN)) Q:RN']""""  W !! ZL @RN X ^%Z"
 W !!,"DONE" K RN,II,^UTILITY($J) Q
