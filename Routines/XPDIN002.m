XPDIN002 ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.6,7,"DT")
 ;;=2940519
 ;;^DD(9.6,10,0)
 ;;=MULTI-PACKAGE^9.63P^^10;0
 ;;^DD(9.6,10,21,0)
 ;;=^^2^2^2940503^
 ;;^DD(9.6,10,21,1,0)
 ;;=This multiple contains other packages that will be sent with this package
 ;;^DD(9.6,10,21,2,0)
 ;;=for a multi-package distribution.
 ;;^DD(9.6,20,0)
 ;;=ALPHA/BETA TESTING^S^y:YES;n:NO;^ABPKG;1^Q
 ;;^DD(9.6,20,21,0)
 ;;=^^5^5^2940502^^^^
 ;;^DD(9.6,20,21,1,0)
 ;;=YES means this package is currently in alpha or beta test and that you want
 ;;^DD(9.6,20,21,2,0)
 ;;=to track option usage and errors relating to this package at the sites.
 ;;^DD(9.6,20,21,3,0)
 ;;= 
 ;;^DD(9.6,20,21,4,0)
 ;;=NO means that you want to discontinue tracking of alpha or beta testing
 ;;^DD(9.6,20,21,5,0)
 ;;=at sites.
 ;;^DD(9.6,20,"DT")
 ;;=2940307
 ;;^DD(9.6,21,0)
 ;;=INSTALLATION MESSAGE^S^y:YES;n:NO;^ABPKG;2^Q
 ;;^DD(9.6,21,21,0)
 ;;=^^3^3^2940307^^
 ;;^DD(9.6,21,21,1,0)
 ;;=YES means you want a Installation Message sent when this package is
 ;;^DD(9.6,21,21,2,0)
 ;;=installed at a site.  The message will be sent to the mailgroup in the 
 ;;^DD(9.6,21,21,3,0)
 ;;='ADDRESS FOR USAGE REPORTING' field.
 ;;^DD(9.6,21,"DT")
 ;;=2940307
 ;;^DD(9.6,22,0)
 ;;=ADDRESS FOR USAGE REPORTING^FX^^ABPKG;3^K:$L(X)>60!($L(X)<5)!(X'?1"G."1U.E1"@"1U.E) X I $D(X) N DIC,XPD S DIC=4.2,DIC(0)="QEM",XPD=X,X=$P(X,"@",2) D ^DIC S:Y>0 X=$P(XPD,"@")_"@"_$P(Y,U,2) K:Y<0 X
 ;;^DD(9.6,22,3)
 ;;=Answer should be a group addressee network mail format (e.g., G.PKG-TEST@ISC-ANYWHERE)
 ;;^DD(9.6,22,21,0)
 ;;=^^4^4^2940307^
 ;;^DD(9.6,22,21,1,0)
 ;;=This field contains a mail group at a domain to which
 ;;^DD(9.6,22,21,2,0)
 ;;=installation, option usage, and error messages are sent.
 ;;^DD(9.6,22,21,3,0)
 ;;=This is usually a mail group containing one or more of
 ;;^DD(9.6,22,21,4,0)
 ;;=the developers of the package at the developing ISC.
 ;;^DD(9.6,22,"DT")
 ;;=2940308
 ;;^DD(9.6,23,0)
 ;;=PACKAGE NAMESPACE OR PREFIX^9.66A^^ABNS;0
 ;;^DD(9.6,23,21,0)
 ;;=^^3^3^2940307^
 ;;^DD(9.6,23,21,1,0)
 ;;=This multiple field is used to identify the namespace or
 ;;^DD(9.6,23,21,2,0)
 ;;=prefixes used to identify the options and routines
 ;;^DD(9.6,23,21,3,0)
 ;;=associated with the alpha or beta test package.
 ;;^DD(9.6,30,0)
 ;;=GLOBAL^9.65^^GLO;0
 ;;^DD(9.6,30,21,0)
 ;;=^^1^1^2950105^^
 ;;^DD(9.6,30,21,1,0)
 ;;=This multiple contains the globals to transport with KIDS.
 ;;^DD(9.6,50,0)
 ;;=INSTALL QUESTIONS^9.62^^QUES;0
 ;;^DD(9.6,50,21,0)
 ;;=^^4^4^2940502^^^
 ;;^DD(9.6,50,21,1,0)
 ;;=These are the Install questions that will be asked at the installing site.
 ;;^DD(9.6,50,21,2,0)
 ;;=All questions will use the VA Fileman Reader (DIR) and all variables need
 ;;^DD(9.6,50,21,3,0)
 ;;=to be defined in this multiple. Only the ENVIROMENT CHECK ROUTINE will be
 ;;^DD(9.6,50,21,4,0)
 ;;=loaded at the installing site when these questions are asked.
 ;;^DD(9.6,913,0)
 ;;=ENVIRONMENT CHECK ROUTINE^FX^^PRE;1^K:$L(X)<3!(X'?1U.7UN) X
 ;;^DD(9.6,913,.1)
 ;;=DEVELOPERS ROUTINE RUN BEFORE 'INIT' QUESTIONS ASKED
 ;;^DD(9.6,913,3)
 ;;=Enter name of developer's environment check routine (3-8 characters) that runs before any user questions are asked.  This routine should be used for environment check only and should not alter data.
 ;;^DD(9.6,913,21,0)
 ;;=^^8^8^2931118^^^
 ;;^DD(9.6,913,21,1,0)
 ;;=The name of the developer's routine which is run at the beginning of
 ;;^DD(9.6,913,21,2,0)
 ;;=the install process.  This should just check the environment
 ;;^DD(9.6,913,21,3,0)
 ;;=and should not alter any data, since the user has no way to exit out of
 ;;^DD(9.6,913,21,4,0)
 ;;=the install process until this program runs to completion.
 ;;^DD(9.6,913,21,5,0)
 ;;=This routine can interact with the user. If the variable XPDQUIT is set,
 ;;^DD(9.6,913,21,6,0)
 ;;=the install process will terminate.
 ;;^DD(9.6,913,21,7,0)
 ;;= Note: This routine must be self-contained, since it will be the only
 ;;^DD(9.6,913,21,8,0)
 ;;=routine installed from this package at this time.
 ;;^DD(9.6,913,"DT")
 ;;=2940119
 ;;^DD(9.6,914,0)
 ;;=POST-INSTALL ROUTINE^FX^^INIT;E1,240^K:$L(X)>17!(X'?.1UP.7UN.1"^"1UP.7UN) X
 ;;^DD(9.6,914,.1)
 ;;=
 ;;^DD(9.6,914,3)
 ;;=Enter the name of the developer's post-initialization [TAG^]ROUTINE. 
 ;;^DD(9.6,914,21,0)
 ;;=^^3^3^2940518^^^^
 ;;^DD(9.6,914,21,1,0)
 ;;=The name of the developer's routine which is run immediately after the
 ;;^DD(9.6,914,21,2,0)
 ;;=installation of the package.  This routine cannot be interactive with
 ;;^DD(9.6,914,21,3,0)
 ;;=the user, it might be queued to run at a later time.
