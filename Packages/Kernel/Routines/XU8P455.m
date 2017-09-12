XU8P455 ;ISF/RWF - Patch XU*8*455 Post-Init ;9/6/07  13:41
 ;;8.0;KERNEL;;Jul 10, 1995;Build 6
 Q
 ;
POST ;Do Post-init
 X ^%ZOSF("EON")
 D RELOAD^ZTMGRSET
 X ^%ZOSF("EOFF")
 Q
