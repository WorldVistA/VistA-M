DIPKI001 ;VEN/TOAD-PACKAGE FILE INIT ; 04-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(9.4,0,"GL")
 ;;=^DIC(9.4,
 ;;^DIC("B","PACKAGE",9.4)
 ;;=
 ;;^DIC(9.4,"%",0)
 ;;=^1.005^1^1
 ;;^DIC(9.4,"%",1,0)
 ;;=XU
 ;;^DIC(9.4,"%","B","XU",1)
 ;;=
 ;;^DIC(9.4,"%D",0)
 ;;=^^15^15^2940705^^^^
 ;;^DIC(9.4,"%D",1,0)
 ;;=This file identifies the elements of a package that will be transported
 ;;^DIC(9.4,"%D",2,0)
 ;;=by the initialization routines created by DIFROM.  The prefix determines
 ;;^DIC(9.4,"%D",3,0)
 ;;=which namespaced entries will be retrieved from the Option, Bulletin,
 ;;^DIC(9.4,"%D",4,0)
 ;;=Help Frame, Function, and Security Key Files as well as the namespace
 ;;^DIC(9.4,"%D",5,0)
 ;;=that will be used to name the INIT routines built by running DIFROM.
 ;;^DIC(9.4,"%D",6,0)
 ;;=The Excluded Namespace field may be used to leave out some of these items.
 ;;^DIC(9.4,"%D",7,0)
 ;;=The File Multiple determines which files are sent with the package and
 ;;^DIC(9.4,"%D",8,0)
 ;;=whether data is included.  Print, Input, Sort and Screen (FORM)
 ;;^DIC(9.4,"%D",9,0)
 ;;=templates are brought in by namespace, for the files listed in the File
 ;;^DIC(9.4,"%D",10,0)
 ;;=multiple.  In addition, there are multiples for each type of template,
 ;;^DIC(9.4,"%D",11,0)
 ;;=that allow the user to specify individual templates outside the
 ;;^DIC(9.4,"%D",12,0)
 ;;=namespace to retrieve.  Routines to be run before and after the
 ;;^DIC(9.4,"%D",13,0)
 ;;=INIT are specified in the Environment Check Routine, Pre-init after
 ;;^DIC(9.4,"%D",14,0)
 ;;=User Commit, and Post-Initialization Routine fields. The remaining
 ;;^DIC(9.4,"%D",15,0)
 ;;=fields are simply for documentation.
 ;;^DD(9.4,0)
 ;;=FIELD^NL^15007^31
 ;;^DD(9.4,0,"DDA")
 ;;=N
 ;;^DD(9.4,0,"DT")
 ;;=3130331
 ;;^DD(9.4,0,"ID",1)
 ;;=W:$D(^("0")) "   ",$P(^("0"),U,2)
 ;;^DD(9.4,0,"IX","AMRG",9.402,.01)
 ;;=
 ;;^DD(9.4,0,"IX","AR",9.44,.01)
 ;;=
 ;;^DD(9.4,0,"IX","B",9.4,.01)
 ;;=
 ;;^DD(9.4,0,"IX","C",9.4,1)
 ;;=
 ;;^DD(9.4,0,"IX","C2",9.4014,.01)
 ;;=
 ;;^DD(9.4,0,"IX","E",9.415007,.01)
 ;;=
 ;;^DD(9.4,0,"NM","PACKAGE")
 ;;=
 ;;^DD(9.4,0,"PT",.84,1.2)
 ;;=
 ;;^DD(9.4,0,"PT",3.077,3.1)
 ;;=
 ;;^DD(9.4,0,"PT",9.6,1)
 ;;=
 ;;^DD(9.4,0,"PT",9.7,1)
 ;;=
 ;;^DD(9.4,0,"PT",15.01101,.01)
 ;;=
 ;;^DD(9.4,0,"PT",19,12)
 ;;=
 ;;^DD(9.4,0,"PT",44,50.02)
 ;;=
 ;;^DD(9.4,0,"PT",100,12)
 ;;=
 ;;^DD(9.4,0,"PT",100.03,.05)
 ;;=
 ;;^DD(9.4,0,"PT",100.1,2)
 ;;=
 ;;^DD(9.4,0,"PT",100.22,.07)
 ;;=
 ;;^DD(9.4,0,"PT",100.67,.01)
 ;;=
 ;;^DD(9.4,0,"PT",100.9901,.01)
 ;;=
 ;;^DD(9.4,0,"PT",100.995,.01)
 ;;=
 ;;^DD(9.4,0,"PT",101,12)
 ;;=
 ;;^DD(9.4,0,"PT",101.41,7)
 ;;=
 ;;^DD(9.4,0,"PT",150.93,.01)
 ;;=
 ;;^DD(9.4,0,"PT",579.6,.01)
 ;;=
 ;;^DD(9.4,0,"PT",776.3,.02)
 ;;=
 ;;^DD(9.4,0,"PT",779.2,2)
 ;;=
 ;;^DD(9.4,0,"PT",7105.5,3)
 ;;=
 ;;^DD(9.4,0,"PT",8989.332,.01)
 ;;=
 ;;^DD(9.4,0,"PT",8989.5,.01)
 ;;=
 ;;^DD(9.4,0,"PT",8992.3,.03)
 ;;=
 ;;^DD(9.4,0,"PT",9000010,81202)
 ;;=
 ;;^DD(9.4,0,"PT",9000010.06,81202)
 ;;=
 ;;^DD(9.4,0,"PT",9000010.07,81202)
 ;;=
 ;;^DD(9.4,0,"PT",9000010.11,81202)
 ;;=
 ;;^DD(9.4,0,"PT",9000010.12,81202)
 ;;=
 ;;^DD(9.4,0,"PT",9000010.13,81202)
 ;;=
 ;;^DD(9.4,0,"PT",9000010.15,81202)
 ;;=
 ;;^DD(9.4,0,"PT",9000010.16,81202)
 ;;=
 ;;^DD(9.4,0,"PT",9000010.18,81202)
 ;;=
 ;;^DD(9.4,0,"PT",9000010.23,81202)
 ;;=
 ;;^DD(9.4,0,"VRPK")
 ;;=KERNEL PUBLIC DOMAIN
 ;;^DD(9.4,.01,0)
 ;;=NAME^RF^^0;1^K:$L(X)>30!($L(X)<4)!'(X'?1P.E) X
 ;;^DD(9.4,.01,1,0)
 ;;=^.1
 ;;^DD(9.4,.01,1,1,0)
 ;;=9.4^B
 ;;^DD(9.4,.01,1,1,1)
 ;;=S ^DIC(9.4,"B",X,DA)=""
 ;;^DD(9.4,.01,1,1,2)
 ;;=K ^DIC(9.4,"B",X,DA)
 ;;^DD(9.4,.01,3)
 ;;=Please enter the name of this PACKAGE (4-30 characters).
 ;;^DD(9.4,.01,21,0)
 ;;=^^1^1^2940627^^^^
 ;;^DD(9.4,.01,21,1,0)
 ;;=The name of this Package.
 ;;^DD(9.4,.01,"DT")
 ;;=3121204
 ;;^DD(9.4,1,0)
 ;;=PREFIX^RFX^^0;2^K:$L(X)>4!(X'?1U1.3NU) X I $D(X) N %,%1,%2 S %="^DIC(9.4)" F %1="C","C2" S %2=$O(@%@(%1,X,0)) I %2>0,%2-DA K X Q
 ;;^DD(9.4,1,.1)
 ;;=NAMESPACE
 ;;^DD(9.4,1,1,0)
 ;;=^.1
 ;;^DD(9.4,1,1,1,0)
 ;;=9.4^C
 ;;^DD(9.4,1,1,1,1)
 ;;=S ^DIC(9.4,"C",X,DA)=""
 ;;^DD(9.4,1,1,1,2)
 ;;=K ^DIC(9.4,"C",X,DA)
 ;;^DD(9.4,1,3)
 ;;=Please enter the unique namespace prefix (2-4 characters, starting with an alpha).
 ;;^DD(9.4,1,21,0)
 ;;=^^4^4^2940627^^^^
 ;;^DD(9.4,1,21,1,0)
 ;;=This is the unique namespace prefix assigned to the Package, e.g. XM for
 ;;^DD(9.4,1,21,2,0)
 ;;=the MailMan routines and globals, DI for the FileMan routines, etc.
 ;;^DD(9.4,1,21,3,0)
 ;;=This field is appended to letters (like "INIT") to be used as the
 ;;^DD(9.4,1,21,4,0)
 ;;=names of INIT routines.
 ;;^DD(9.4,1,"DT")
 ;;=2890223
 ;;^DD(9.4,2,0)
 ;;=SHORT DESCRIPTION^RFI^^0;3^K:$L(X)>60!($L(X)<2) X
 ;;^DD(9.4,2,3)
 ;;=Answer must be 2-60 characters in length.
 ;;^DD(9.4,2,21,0)
 ;;=1
 ;;^DD(9.4,2,21,1,0)
 ;;=This is a brief description of this Package's functions.
 ;;^DD(9.4,2,"DT")
 ;;=3130123
 ;;^DD(9.4,3,0)
 ;;=DESCRIPTION^9.41A^^1;0
 ;;^DD(9.4,3,21,0)
 ;;=^^2^2^2920513^^^
 ;;^DD(9.4,3,21,1,0)
 ;;=This is a complete and detailed description of the Package's functions
 ;;^DD(9.4,3,21,2,0)
 ;;=and capabilities.
 ;;^DD(9.4,6,0)
 ;;=FILE^9.44PA^^4;0
 ;;^DD(9.4,6,21,0)
 ;;=^^3^3^2920513^^^^
 ;;^DD(9.4,6,21,1,0)
 ;;=Any FileMan files which are part of this Package are documented
 ;;^DD(9.4,6,21,2,0)
 ;;=here.  This multiple controls what files (Data Dictionaries and
 ;;^DD(9.4,6,21,3,0)
 ;;=Data) are sent in an INIT built from this Package entry.
 ;;^DD(9.4,6,"DT")
 ;;=2990407
 ;;^DD(9.4,7,0)
 ;;=PRINT TEMPLATE^9.46^^DIPT;0
 ;;^DD(9.4,7,21,0)
 ;;=^^4^4^2921202^^^^
 ;;^DD(9.4,7,21,1,0)
 ;;=The names of Print Templates being sent with this Package.
 ;;^DD(9.4,7,21,2,0)
 ;;=This multiple is used to send non-namespaced templates in an INIT.
 ;;^DD(9.4,7,21,3,0)
 ;;=Namespaced templates are sent automatically and need not be listed
 ;;^DD(9.4,7,21,4,0)
 ;;=separately.
 ;;^DD(9.4,7,"DT")
 ;;=2990407
 ;;^DD(9.4,8,0)
 ;;=INPUT TEMPLATE^9.47^^DIE;0
 ;;^DD(9.4,8,21,0)
 ;;=^^4^4^2920513^^^
 ;;^DD(9.4,8,21,1,0)
 ;;=The names of the Input Templates being sent with this Package
 ;;^DD(9.4,8,21,2,0)
 ;;=This multiple is used to send non-namespaced templates in an INIT.
 ;;^DD(9.4,8,21,3,0)
 ;;=Namespaced templates are sent automatically and need not be listed
 ;;^DD(9.4,8,21,4,0)
 ;;=separately.
 ;;^DD(9.4,8,"DT")
 ;;=2990407
 ;;^DD(9.4,9,0)
 ;;=SORT TEMPLATE^9.48^^DIBT;0
 ;;^DD(9.4,9,21,0)
 ;;=^^4^4^2920513^^^
 ;;^DD(9.4,9,21,1,0)
 ;;=The names of the Sort Templates being sent with this Package.
 ;;^DD(9.4,9,21,2,0)
 ;;=This multiple is used to send non-namespaced templates in an INIT.
 ;;^DD(9.4,9,21,3,0)
 ;;=Namespaced templates are sent automatically and need not be listed
 ;;^DD(9.4,9,21,4,0)
 ;;=separately.
 ;;^DD(9.4,9,"DT")
 ;;=2990407
 ;;^DD(9.4,9.1,0)
 ;;=SCREEN TEMPLATE (FORM)^9.485^^DIST;0
 ;;^DD(9.4,9.1,21,0)
 ;;=^^2^2^2920513^^^
 ;;^DD(9.4,9.1,21,1,0)
 ;;=The names of Screen Templates (from the FORM file) associated with
 ;;^DD(9.4,9.1,21,2,0)
 ;;=this package.
 ;;^DD(9.4,9.1,"DT")
 ;;=2990407
 ;;^DD(9.4,9.5,0)
 ;;=*MENU^9.495^^M;0
 ;;^DD(9.4,9.5,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(9.4,9.5,21,1,0)
 ;;=This is the name of a menu-type option in another namespace.
 ;;^DD(9.4,9.5,"DT")
 ;;=2940603
 ;;^DD(9.4,10,0)
 ;;=DEVELOPER (PERSON/SITE)^F^^DEV;1^K:$L(X)>50!($L(X)<2) X
 ;;^DD(9.4,10,3)
 ;;=Please enter the name of the principal Developer and Site (2-50 characters).
 ;;^DD(9.4,10,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.4,10,21,1,0)
 ;;=The name of the principal Developer and Site for this Package.
 ;;^DD(9.4,10.6,0)
 ;;=*LOWEST FILE NUMBER^NJ12,2^^11;1^K:+X'=X!(X>999999999)!(X<0)!(X?.E1"."3N.N) X
 ;;^DD(9.4,10.6,3)
 ;;=Type a Number between 0 and 999999999, 2 Decimal Digits
 ;;^DD(9.4,10.6,21,0)
 ;;=^^1^1^2920513^^^^
 ;;^DD(9.4,10.6,21,1,0)
 ;;=Inclusive lower bound of the range of file numbers allocated to this package.
 ;;^DD(9.4,10.6,"DT")
 ;;=2940603
 ;;^DD(9.4,11,0)
 ;;=*HIGHEST FILE NUMBER^NJ12,2^^11;2^K:+X'=X!(X>999999999)!(X<0)!(X?.E1"."3N.N) X
 ;;^DD(9.4,11,3)
 ;;=Type a Number between 0 and 999999999, 2 Decimal Digits
 ;;^DD(9.4,11,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(9.4,11,21,1,0)
 ;;=Inclusive upper bound of the range of file numbers assigned to this package.
 ;;^DD(9.4,11,"DT")
 ;;=2940603
 ;;^DD(9.4,11.01,0)
 ;;=DEVELOPMENT ISC^F^^5;1^K:$L(X)>20!($L(X)<3) X
 ;;^DD(9.4,11.01,3)
 ;;=Please enter the name of the ISC (3-20 characters).
 ;;^DD(9.4,11.01,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(9.4,11.01,21,1,0)
 ;;=The ISC responsible for the development and management of this Package.
 ;;^DD(9.4,11.01,"DT")
 ;;=2840815
 ;;^DD(9.4,11.3,0)
 ;;=CLASS^S^I:National;II:Inactive;III:Local;^7;3^Q
 ;;^DD(9.4,11.3,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.4,11.3,21,1,0)
 ;;=The ranking Class of this software Package.
 ;;^DD(9.4,11.3,"DT")
 ;;=2940325
 ;;^DD(9.4,13,0)
 ;;=CURRENT VERSION^F^^VERSION;1^K:$L(X)>8!($L(X)<1)!'(X?1N.ANP) X
 ;;^DD(9.4,13,3)
 ;;=Enter the version of this package currently running, (1-8 characters).
 ;;^DD(9.4,13,21,0)
 ;;=^^5^5^2920702^
 ;;^DD(9.4,13,21,1,0)
 ;;=This field holds the version number of the package currently running
 ;;^DD(9.4,13,21,2,0)
 ;;=at this site.  When a package initialization has been run, this field
 ;;^DD(9.4,13,21,3,0)
 ;;=will be updated with the version number most recently installed.
