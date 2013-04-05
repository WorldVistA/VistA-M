RGHLPOST ;CAIRO/DKM-CIRN Messaging Build Postinit ;19-Dec-97
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;;30 Apr 99
 ;=================================================================
 ;cairo's stuff
 W !!
 X ^%ZOSF("EON"),^%ZOSF("TRMOFF")
 I $P($G(^RGSITE("COR",1,"TZ")),U)="",$$^RGMSCDIC(990.8,"1|<;10;11")
 Q
 ;
