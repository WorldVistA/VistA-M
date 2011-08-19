DIPKI002 ; ; 30-MAR-1999
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.4,9.1,"DT")
 ;;=2940603
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
 ;;^DD(9.4,11.1,0)
 ;;=*MAINTENANCE ISC^F^^7;1^K:$L(X)>20!($L(X)<3) X
 ;;^DD(9.4,11.1,3)
 ;;=Please enter the name of the ISC (3-20 characters).
 ;;^DD(9.4,11.1,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(9.4,11.1,21,1,0)
 ;;=The ISC responsible for the support and maintenance of this Package.
 ;;^DD(9.4,11.1,"DT")
 ;;=2940603
 ;;^DD(9.4,11.3,0)
 ;;=CLASS^S^I:National;II:Inactive;III:Local;^7;3^Q
 ;;^DD(9.4,11.3,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.4,11.3,21,1,0)
 ;;=The ranking Class of this software Package.
 ;;^DD(9.4,11.3,"DT")
 ;;=2940325
 ;;^DD(9.4,11.4,0)
 ;;=*VERIFICATION^9.404ID^^8;0
 ;;^DD(9.4,11.4,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(9.4,11.4,21,1,0)
 ;;=Information about the verification(s) of this Package.
 ;;^DD(9.4,11.4,"DT")
 ;;=2940603
 ;;^DD(9.4,11.5,0)
 ;;=*ALPHA^P4'^DIC(4,^9;1^Q
 ;;^DD(9.4,11.5,3)
 ;;=Please enter the name of the Alpha Test site.
 ;;^DD(9.4,11.5,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(9.4,11.5,21,1,0)
 ;;=The name of this Package's Alpha Test site.
 ;;^DD(9.4,11.5,"DT")
 ;;=2940603
 ;;^DD(9.4,11.6,0)
 ;;=*BETA^P4'^DIC(4,^9;2^Q
 ;;^DD(9.4,11.6,3)
 ;;=Please enter the name of the Beta Test site.
 ;;^DD(9.4,11.6,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(9.4,11.6,21,1,0)
 ;;=The name of this Package's Beta Test site.
 ;;^DD(9.4,11.6,"DT")
 ;;=2940603
 ;;^DD(9.4,11.7,0)
 ;;=*DELTA^9.409P^^10;0
 ;;^DD(9.4,11.7,21,0)
 ;;=^^1^1^2920706^^
 ;;^DD(9.4,11.7,21,1,0)
 ;;=The names of the Delta Test sites for this Package.
 ;;^DD(9.4,11.7,"DT")
 ;;=2940603
 ;;^DD(9.4,12,0)
 ;;=*PRIMARY HELP FRAME^P9.2'^DIC(9.2,^0;4^Q
 ;;^DD(9.4,12,3)
 ;;=
 ;;^DD(9.4,12,21,0)
 ;;=^^1^1^2920416^^^
 ;;^DD(9.4,12,21,1,0)
 ;;=This is the primary Help Frame for this Package.
 ;;^DD(9.4,12,"DT")
 ;;=2940603
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
 ;;^DD(9.4,13,21,4,0)
 ;;=This can be either using the old format (1.0, 16.04, etc.) or the new
 ;;^DD(9.4,13,21,5,0)
 ;;=format (18.0T4, 19.1V2, etc.)
 ;;^DD(9.4,13,"DT")
 ;;=2860221
 ;;^DD(9.4,20,0)
 ;;=AFFECTS RECORD MERGE^9.402P^^20;0
 ;;^DD(9.4,20,21,0)
 ;;=^^2^2^2940627^
 ;;^DD(9.4,20,21,1,0)
 ;;=This Multipule lists the files that will impact this package if a Record
 ;;^DD(9.4,20,21,2,0)
 ;;=Merge is done on any of the files in the list.
 ;;^DD(9.4,22,0)
 ;;=VERSION^9.49I^^22;0
 ;;^DD(9.4,22,21,0)
 ;;=^^1^1^2930415^^^^
 ;;^DD(9.4,22,21,1,0)
 ;;=The version numbers of this Package.
 ;;^DD(9.4,200.1,0)
 ;;=*USER TERMINATE TAG^F^^200;1^K:$L(X)>8!($L(X)<1)!'((X?1U.UN)!(X?1N.N)) X
 ;;^DD(9.4,200.1,3)
 ;;=Enter the entry TAG for the routine in field 200.2
 ;;^DD(9.4,200.1,21,0)
 ;;=^^3^3^2920306^^^
 ;;^DD(9.4,200.1,21,1,0)
 ;;=This field holds the entry point into the routine that will be called at
 ;;^DD(9.4,200.1,21,2,0)
 ;;=the time that a USER (File 200 entry with access/verify codes) is
 ;;^DD(9.4,200.1,21,3,0)
 ;;=terminated. See field 200.2
 ;;^DD(9.4,200.1,"DT")
 ;;=2940603
 ;;^DD(9.4,200.2,0)
 ;;=*USER TERMINATE ROUTINE^F^^200;2^K:$L(X)>8!($L(X)<2)!'(X?2U.UN) X
 ;;^DD(9.4,200.2,3)
 ;;=Enter a 2-8 character routine name.
 ;;^DD(9.4,200.2,21,0)
 ;;=^^7^7^2920306^^^
 ;;^DD(9.4,200.2,21,1,0)
 ;;=This field holds the name of a routine that will be called at the time
 ;;^DD(9.4,200.2,21,2,0)
 ;;=that a USER (File 200 entry with access/verify codes) is terminated.
 ;;^DD(9.4,200.2,21,3,0)
 ;;=ie. has their access/verify codes removed.
 ;;^DD(9.4,200.2,21,4,0)
 ;;=This is to allow each package to do their own clean-up.
 ;;^DD(9.4,200.2,21,5,0)
 ;;= 
 ;;^DD(9.4,200.2,21,6,0)
 ;;=At the time the call is made DA will hold the IFN of the user being
 ;;^DD(9.4,200.2,21,7,0)
 ;;=terminated. This normally runs in the background without an IO device.
 ;;^DD(9.4,200.2,"DT")
 ;;=2940603
 ;;^DD(9.4,913,0)
 ;;=*ENVIRONMENT CHECK ROUTINE^F^^PRE;1^K:$L(X)>8!($L(X)<3) X
 ;;^DD(9.4,913,.1)
 ;;=DEVELOPERS ROUTINE RUN BEFORE 'INIT' QUESTIONS ASKED
 ;;^DD(9.4,913,3)
 ;;=Enter name of developer's environment check routine (3-8 characters) that runs before any user questions are asked.  This routine should be used for environment check only and should not alter data.
 ;;^DD(9.4,913,21,0)
 ;;=^^4^4^2921202^
 ;;^DD(9.4,913,21,1,0)
 ;;=The name of the developer's routine which is run at the beginning of
 ;;^DD(9.4,913,21,2,0)
 ;;=the NAMESPACE_INIT routine.  This should just check the environment
 ;;^DD(9.4,913,21,3,0)
 ;;=and should not alter any data, since the user has no way to exit out of
 ;;^DD(9.4,913,21,4,0)
 ;;=the INIT process until this program runs to completion.
