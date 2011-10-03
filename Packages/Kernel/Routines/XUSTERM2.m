XUSTERM2 ;SFISC/RWF - USER TERMINATE, PACKAGE FILE RUN ;9/7/94  16:23
 ;;8.0;KERNEL;;Jul 10, 1995
 ;;.1;;
 D B,A
 Q
A ;FOR v8 only, loop thru package file and do clean-up routines.
 N XUI,XUJ,XUGRP
 F XU1=0:0 S XU1=$O(^DIC(9.4,XU1)) Q:XU1'>0  S XU2=$P($G(^DIC(9.4,XU1,200)),"^",1,2) D:$L($P(XU2,"^",2)) T2(XU2,XUDA)
 K XU1,XU2 Q
T2(XU1,DA) ;Set trap and call one with DA=IFN of user.
 ;Protect what we need to return.
 N XUDA
 S X="TX^XUSTERM2",@^%ZOSF("TRAP"),X=$P(XU1,"^",2) X ^%ZOSF("TEST") Q:'$T
 D @XU1
 Q
TX D @^%ZOSF("ERRTN") Q
 ;
B ;Call XQOR to handle protocall.
 N XUI,XUJ,XUGRP S XUIFN=XUDA N XUDA ;Protect ourself.
 S X="TX^XUSTERM2",@^%ZOSF("TRAP"),DIC="^DIC(19,",X="XU USER TERMINATE"
 D EN^XQOR
 K X,DIC Q
