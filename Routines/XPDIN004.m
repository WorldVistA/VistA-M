XPDIN004 ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.62,10,21,0)
 ;;=^^6^6^2940110^^
 ;;^DD(9.62,10,21,1,0)
 ;;=This field contains standard M code which will be executed after the DIR
 ;;^DD(9.62,10,21,2,0)
 ;;=array has been set from the previous fields, but before the call to the DIR
 ;;^DD(9.62,10,21,3,0)
 ;;=routine. If the developer doesn't want to ask a question, kill the DIR
 ;;^DD(9.62,10,21,4,0)
 ;;=array.  The array XPDQUES(SUBSCRIPT)=internal answer will be defined for all
 ;;^DD(9.62,10,21,5,0)
 ;;=questions asked.  This code can only make references to the ENVIORMENT CHECK
 ;;^DD(9.62,10,21,6,0)
 ;;=ROUTINE, since it will be the only routine loaded at this time.
 ;;^DD(9.62,10,"DT")
 ;;=2931129
 ;;^DD(9.623,0)
 ;;=DIR(A,#) SUB-FIELD^^.01^1
 ;;^DD(9.623,0,"DT")
 ;;=2931122
 ;;^DD(9.623,0,"NM","DIR(A,#)")
 ;;=
 ;;^DD(9.623,0,"UP")
 ;;=9.62
 ;;^DD(9.623,.01,0)
 ;;=DIR(A,#)^WL^^0;1^Q
 ;;^DD(9.623,.01,"DT")
 ;;=2931122
 ;;^DD(9.626,0)
 ;;=DIR(?,#) SUB-FIELD^^.01^1
 ;;^DD(9.626,0,"DT")
 ;;=2931122
 ;;^DD(9.626,0,"NM","DIR(?,#)")
 ;;=
 ;;^DD(9.626,0,"UP")
 ;;=9.62
 ;;^DD(9.626,.01,0)
 ;;=DIR(?,#)^WL^^0;1^Q
 ;;^DD(9.626,.01,"DT")
 ;;=2931122
 ;;^DD(9.63,0)
 ;;=MULTI-PACKAGE SUB-FIELD^^.01^2
 ;;^DD(9.63,0,"DT")
 ;;=2940503
 ;;^DD(9.63,0,"IX","B",9.63,.01)
 ;;=
 ;;^DD(9.63,0,"NM","MULTI-PACKAGE")
 ;;=
 ;;^DD(9.63,0,"UP")
 ;;=9.6
 ;;^DD(9.63,.001,0)
 ;;=INSTALL ORDER^NJ2,0^^ ^K:+X'=X!(X>99)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(9.63,.001,3)
 ;;=Type a Number between 1 and 99, 0 Decimal Digits
 ;;^DD(9.63,.001,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.63,.001,21,1,0)
 ;;=This is the order in which this package will be installed.
 ;;^DD(9.63,.001,"DT")
 ;;=2940503
 ;;^DD(9.63,.01,0)
 ;;=MULTI-PACKAGE^MP9.6'^XPD(9.6,^0;1^Q
 ;;^DD(9.63,.01,1,0)
 ;;=^.1
 ;;^DD(9.63,.01,1,1,0)
 ;;=9.63^B
 ;;^DD(9.63,.01,1,1,1)
 ;;=S ^XPD(9.6,DA(1),10,"B",$E(X,1,30),DA)=""
 ;;^DD(9.63,.01,1,1,2)
 ;;=K ^XPD(9.6,DA(1),10,"B",$E(X,1,30),DA)
 ;;^DD(9.63,.01,21,0)
 ;;=^^1^1^2940503^
 ;;^DD(9.63,.01,21,1,0)
 ;;=Name of package that will be part of this multi-package distribution.
 ;;^DD(9.63,.01,"DT")
 ;;=2940502
 ;;^DD(9.64,0)
 ;;=FILE SUB-FIELD^NL^224^13
 ;;^DD(9.64,0,"DT")
 ;;=2950330
 ;;^DD(9.64,0,"IX","AC",9.64,222.3)
 ;;=
 ;;^DD(9.64,0,"IX","APDD",9.6411,.01)
 ;;=
 ;;^DD(9.64,0,"IX","B",9.64,.01)
 ;;=
 ;;^DD(9.64,0,"NM","FILE")
 ;;=
 ;;^DD(9.64,0,"UP")
 ;;=9.6
 ;;^DD(9.64,.01,0)
 ;;=FILE^M*P1'X^DIC(^0;1^S DIC("S")="I Y>1.9999" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X I $D(X) S DINUM=X
 ;;^DD(9.64,.01,.1)
 ;;=REQUIRED FILES FOR THIS PACKAGE
 ;;^DD(9.64,.01,1,0)
 ;;=^.1^^-1
 ;;^DD(9.64,.01,1,1,0)
 ;;=9.64^B
 ;;^DD(9.64,.01,1,1,1)
 ;;=S ^XPD(9.6,DA(1),4,"B",X,DA)=""
 ;;^DD(9.64,.01,1,1,2)
 ;;=K ^XPD(9.6,DA(1),4,"B",X,DA)
 ;;^DD(9.64,.01,3)
 ;;=Please enter the name of a FILE that is known to VA FileMan.
 ;;^DD(9.64,.01,12)
 ;;=Select a file which is used by this package.
 ;;^DD(9.64,.01,12.1)
 ;;=S DIC("S")="I Y>1.9999"
 ;;^DD(9.64,.01,21,0)
 ;;=^^2^2^2920513^^^^
 ;;^DD(9.64,.01,21,1,0)
 ;;=The name of a VA FileMan file which you wish to transport with
 ;;^DD(9.64,.01,21,2,0)
 ;;=this package.  This may be any file whose number is 2 or greater.
 ;;^DD(9.64,.01,"DT")
 ;;=2931104
 ;;^DD(9.64,.02,0)
 ;;=CHECKSUM^F^^0;2^K:$L(X)>30!($L(X)<3) X
 ;;^DD(9.64,.02,3)
 ;;=Answer must be 3-30 characters in length.
 ;;^DD(9.64,.02,21,0)
 ;;=^^1^1^2950330^
 ;;^DD(9.64,.02,21,1,0)
 ;;=This field contains the checksum for this Data Dictionary
 ;;^DD(9.64,.02,"DT")
 ;;=2950330
 ;;^DD(9.64,1,0)
 ;;=DD NUMBER^9.641^^2;0
 ;;^DD(9.64,1,21,0)
 ;;=^^2^2^2940903^
 ;;^DD(9.64,1,21,1,0)
 ;;=DD NUMBER pertains to the top level of the file, file number, or a
 ;;^DD(9.64,1,21,2,0)
 ;;=sub-file such as a multiple field.
 ;;^DD(9.64,222.1,0)
 ;;=UPDATE THE DATA DICTIONARY^S^y:YES;n:NO;^222;1^Q
 ;;^DD(9.64,222.1,21,0)
 ;;=8^^7^7^2940503^
 ;;^DD(9.64,222.1,21,1,0)
 ;;=YES means that the Data Dictionary for this file should be updated when
 ;;^DD(9.64,222.1,21,2,0)
 ;;=this version of the package is installed.
 ;;^DD(9.64,222.1,21,3,0)
 ;;= 
 ;;^DD(9.64,222.1,21,4,0)
 ;;=NO means that this Data Dictionary has not changed since the last version,
 ;;^DD(9.64,222.1,21,5,0)
 ;;= 
 ;;^DD(9.64,222.1,21,6,0)
 ;;=If the Data Dictionary does not exist at the installing site, then this
 ;;^DD(9.64,222.1,21,7,0)
 ;;=field does not apply.  The DD will be put in place.
 ;;^DD(9.64,222.1,"DT")
 ;;=2890627
 ;;^DD(9.64,222.2,0)
 ;;=SEND SECURITY CODE^S^y:YES;n:NO;^222;2^Q
 ;;^DD(9.64,222.2,21,0)
 ;;=^^5^5^2940503^^^
 ;;^DD(9.64,222.2,21,1,0)
 ;;=YES means you want to include the security protection currently
 ;;^DD(9.64,222.2,21,2,0)
 ;;=on this file when it is distributed. The security protection will
