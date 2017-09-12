XU8P365 ;;BP-OAK/BDT -  CLEAN INVALID "D" X-REF IN FILE 19.1; 9/12/07
 ;;8.0;KERNEL;**365**;JUL 10, 1995;Build 5
 Q
POST ; do post-init
 D KGL,COM,REL
 Q
 ;
KGL ;
 I $D(^DIC(19.1,"D")) K ^DIC(19.1,"D")
 Q
 ;
REL ; reload
 X ^%ZOSF("EON")
 D RELOAD^ZTMGRSET
 X ^%ZOSF("EOFF")
 Q
 ;
COM ; Compile template routine
 N X,Y,DMAX
 S X="XUFILE0"
 S Y=$$FIND1^DIC(.4,"","MX","XUFILEINQ","","","ERR")
 S DMAX=$$ROUSIZE^DILF
 I +Y>0 D EN^DIPZ
 Q
