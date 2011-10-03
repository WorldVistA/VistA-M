VALMPT ;MJK;05:33 PM  15 Dec 1992;
 ;;1;List Manager;;Aug 13, 1993
 ;
POST ; -- post init
 ;
 ; -- bring VALM protocols
 D ^VALMONIT
 ;
 ; -- add list tempaltes
 W !!,">>> List Template installation..."
 D ^VALML
 ;
 ; -- load XQOR routines if necessary
 D XQOR^VALMPT1
 ;
 ; -- send message(s) to developers
 S X="VALMINIY" X ^%ZOSF("TEST") I $T D ^VALMINIY
 Q
 ;
