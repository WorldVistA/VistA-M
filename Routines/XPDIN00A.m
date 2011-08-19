XPDIN00A ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.7)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(9.7,0,"GL")
 ;;=^XPD(9.7,
 ;;^DIC("B","INSTALL",9.7)
 ;;=
 ;;^DIC(9.7,"%D",0)
 ;;=^^3^3^2940705^^^
 ;;^DIC(9.7,"%D",1,0)
 ;;=This file contains the installation information for a site from the Kernel
 ;;^DIC(9.7,"%D",2,0)
 ;;=Installation & Distribution System.  This file should not be edited.
 ;;^DIC(9.7,"%D",3,0)
 ;;=All information is updated when a new package is installed at a site.
 ;;^DD(9.7,0)
 ;;=FIELD^^50^23
 ;;^DD(9.7,0,"DDA")
 ;;=N
 ;;^DD(9.7,0,"DT")
 ;;=2950410
 ;;^DD(9.7,0,"ID",.02)
 ;;=W "   ",@("$P($P($C(59)_$S($D(^DD(9.7,.02,0)):$P(^(0),U,3),1:0)_$E("_DIC_"Y,0),0),$C(59)_$P(^(0),U,9)_"":"",2),$C(59),1)")
 ;;^DD(9.7,0,"IX","AS",9.7,4)
 ;;=
 ;;^DD(9.7,0,"IX","ASP",9.7,3)
 ;;=
 ;;^DD(9.7,0,"IX","B",9.7,.01)
 ;;=
 ;;^DD(9.7,0,"NM","INSTALL")
 ;;=
 ;;^DD(9.7,0,"PT",9.7,3)
 ;;=
 ;;^DD(9.7,0,"VRPK")
 ;;=KERNEL
 ;;^DD(9.7,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>50!($L(X)<3) X
 ;;^DD(9.7,.01,1,0)
 ;;=^.1^^-1
 ;;^DD(9.7,.01,1,1,0)
 ;;=9.7^B
 ;;^DD(9.7,.01,1,1,1)
 ;;=S ^XPD(9.7,"B",X,DA)=""
 ;;^DD(9.7,.01,1,1,2)
 ;;=K ^XPD(9.7,"B",X,DA)
 ;;^DD(9.7,.01,3)
 ;;=Answer must be 3-50 characters in length.
 ;;^DD(9.7,.01,21,0)
 ;;=^^1^1^2950109^^
 ;;^DD(9.7,.01,21,1,0)
 ;;=The name and version number of this Package (i.e. Kernel 8.0T1)
 ;;^DD(9.7,.01,"DEL",1,0)
 ;;=I $P(^XPD(9.7,DA,0),U,9)<3 D EN^DDIOL($C(7)_$S($P(^(0),U,9)=2:"Cannot delete if Install has started.",1:"You must use the Unload a Distribution option."))
 ;;^DD(9.7,.01,"DT")
 ;;=2941013
 ;;^DD(9.7,.02,0)
 ;;=STATUS^RS^0:Loaded from Distribution;1:Queued for Install;2:Start of Install;3:Install Completed;4:De-Installed;^0;9^Q
 ;;^DD(9.7,.02,21,0)
 ;;=^^1^1^2940620^
 ;;^DD(9.7,.02,21,1,0)
 ;;=This is the status of this package at this site.
 ;;^DD(9.7,.02,"DT")
 ;;=2950410
 ;;^DD(9.7,1,0)
 ;;=PACKAGE FILE LINK^P9.4'^DIC(9.4,^0;2^Q
 ;;^DD(9.7,1,21,0)
 ;;=^^1^1^2940502^^
 ;;^DD(9.7,1,21,1,0)
 ;;=This field contains the link to the Package File.
 ;;^DD(9.7,1,"DT")
 ;;=2940524
 ;;^DD(9.7,2,0)
 ;;=DATE LOADED^DI^^0;3^S %DT="ESTXR" D ^%DT S X=Y K:Y<1 X
 ;;^DD(9.7,2,21,0)
 ;;=^^1^1^2950321^^
 ;;^DD(9.7,2,21,1,0)
 ;;=This is the time the Transport Global was loaded at the site.
 ;;^DD(9.7,2,"DT")
 ;;=2950321
 ;;^DD(9.7,3,0)
 ;;=STARTING PACKAGE^P9.7'I^XPD(9.7,^0;4^Q
 ;;^DD(9.7,3,1,0)
 ;;=^.1
 ;;^DD(9.7,3,1,1,0)
 ;;=9.7^ASP^MUMPS
 ;;^DD(9.7,3,1,1,1)
 ;;=S %=$P(^XPD(9.7,DA,0),U,5) S:% ^XPD(9.7,"ASP",X,%,DA)=""
 ;;^DD(9.7,3,1,1,2)
 ;;=S %=$P(^XPD(9.7,DA,0),U,5) K:% ^XPD(9.7,"ASP",X,%,DA)
 ;;^DD(9.7,3,1,1,"%D",0)
 ;;=^^3^3^2940114^^
 ;;^DD(9.7,3,1,1,"%D",1,0)
 ;;=This cross-reference uses the INSTALL ORDER field as the 4th subscript.
 ;;^DD(9.7,3,1,1,"%D",2,0)
 ;;=It is used to find the first package in a linked package and the order to
 ;;^DD(9.7,3,1,1,"%D",3,0)
 ;;=install this package.
 ;;^DD(9.7,3,1,1,"DT")
 ;;=2940113
 ;;^DD(9.7,3,3)
 ;;=
 ;;^DD(9.7,3,21,0)
 ;;=^^1^1^2940415^
 ;;^DD(9.7,3,21,1,0)
 ;;=This is the first package in a multi-package install.
 ;;^DD(9.7,3,"DT")
 ;;=2940113
 ;;^DD(9.7,4,0)
 ;;=INSTALL ORDER^NJ2,0I^^0;5^K:+X'=X!(X>99)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(9.7,4,1,0)
 ;;=^.1
 ;;^DD(9.7,4,1,1,0)
 ;;=9.7^AS^MUMPS
 ;;^DD(9.7,4,1,1,1)
 ;;=S %=$P(^XPD(9.7,DA,0),U,4) S:% ^XPD(9.7,"ASP",%,X,DA)=""
 ;;^DD(9.7,4,1,1,2)
 ;;=S %=$P(^XPD(9.7,DA,0),U,4) K:% ^XPD(9.7,"ASP",%,X,DA)
 ;;^DD(9.7,4,1,1,"%D",0)
 ;;=^^3^3^2940114^
 ;;^DD(9.7,4,1,1,"%D",1,0)
 ;;=This cross-reference uses the STARTING PACKAGE field as the 3rd subscript.
 ;;^DD(9.7,4,1,1,"%D",2,0)
 ;;=It is used to find the first package in a linked package and the order
 ;;^DD(9.7,4,1,1,"%D",3,0)
 ;;=to install this package.
 ;;^DD(9.7,4,1,1,"DT")
 ;;=2940114
 ;;^DD(9.7,4,3)
 ;;=Type a Number between 1 and 99, 0 Decimal Digits
 ;;^DD(9.7,4,21,0)
 ;;=^^1^1^2940415^
 ;;^DD(9.7,4,21,1,0)
 ;;=This is the order to install this package in a multi-package install.
 ;;^DD(9.7,4,"DT")
 ;;=2940114
 ;;^DD(9.7,5,0)
 ;;=QUEUED TASK NUMBER^NJ8,0I^^0;6^K:+X'=X!(X>99999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(9.7,5,3)
 ;;=Type a Number between 1 and 99999999, 0 Decimal Digits
 ;;^DD(9.7,5,21,0)
 ;;=^^2^2^2940415^
 ;;^DD(9.7,5,21,1,0)
 ;;=This is the Task number for this package if this package was queued to
 ;;^DD(9.7,5,21,2,0)
 ;;=be installed at a later time.
 ;;^DD(9.7,5,"DT")
 ;;=2940113
 ;;^DD(9.7,6,0)
 ;;=FILE COMMENT^F^^2;E1,240^K:$L(X)>240!($L(X)<3) X
 ;;^DD(9.7,6,3)
 ;;=Answer must be 3-240 characters in length.
 ;;^DD(9.7,6,21,0)
 ;;=^^1^1^2950321^
 ;;^DD(9.7,6,21,1,0)
 ;;=This is the comment from the HFS file that contained this package.
 ;;^DD(9.7,6,"DT")
 ;;=2950321
 ;;^DD(9.7,7,0)
 ;;=SETNAME^F^^0;8^K:$L(X)>30!($L(X)<3) X
