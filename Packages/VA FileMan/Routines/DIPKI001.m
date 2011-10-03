DIPKI001 ; ; 30-MAR-1999
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
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
 ;;=FIELD^NL^15007^41
 ;;^DD(9.4,0,"DDA")
 ;;=N
 ;;^DD(9.4,0,"DT")
 ;;=2941020
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
 ;;^DD(9.4,0,"IX","D",9.42,.01)
 ;;=
 ;;^DD(9.4,0,"IX","E",9.415007,.01)
 ;;=
 ;;^DD(9.4,0,"NM","PACKAGE")
 ;;=
 ;;^DD(9.4,0,"PT",.84,1.2)
 ;;=
 ;;^DD(9.4,0,"PT",4.01,.01)
 ;;=
 ;;^DD(9.4,0,"PT",4.332,.01)
 ;;=
 ;;^DD(9.4,0,"PT",9.6,1)
 ;;=
 ;;^DD(9.4,0,"PT",9.7,1)
 ;;=
 ;;^DD(9.4,0,"PT",19,12)
 ;;=
 ;;^DD(9.4,0,"PT",101,12)
 ;;=
 ;;^DD(9.4,0,"PT",8989.332,.01)
 ;;=
 ;;^DD(9.4,0,"VRPK")
 ;;=KERNEL
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
 ;;^DD(9.4,1,0)
 ;;=PREFIX^RFX^^0;2^K:$L(X)>4!(X'?1U1.3NU) X I $D(X) S %=$O(^DIC(9.4,"C",X,0)) K:(%>0)&(%-DA) X
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
 ;;=SHORT DESCRIPTION^RF^^0;3^K:$L(X)>60!($L(X)<2) X
 ;;^DD(9.4,2,3)
 ;;=Answer must be 2-60 characters in length.
 ;;^DD(9.4,2,21,0)
 ;;=1
 ;;^DD(9.4,2,21,1,0)
 ;;=This is a brief description of this Package's functions.
 ;;^DD(9.4,2,"DT")
 ;;=2890627
 ;;^DD(9.4,3,0)
 ;;=DESCRIPTION^9.41A^^1;0
 ;;^DD(9.4,3,21,0)
 ;;=^^2^2^2920513^^^
 ;;^DD(9.4,3,21,1,0)
 ;;=This is a complete and detailed description of the Package's functions
 ;;^DD(9.4,3,21,2,0)
 ;;=and capabilities.
 ;;^DD(9.4,4,0)
 ;;=*ROUTINE^9.42A^^2;0
 ;;^DD(9.4,4,21,0)
 ;;=^^3^3^2920513^^^^
 ;;^DD(9.4,4,21,1,0)
 ;;=These are the routines which make up this Package.  This multiple
 ;;^DD(9.4,4,21,2,0)
 ;;=is used for documentation only, and is not used during the INIT
 ;;^DD(9.4,4,21,3,0)
 ;;=process.
 ;;^DD(9.4,4,"DT")
 ;;=2940603
 ;;^DD(9.4,5,0)
 ;;=*GLOBAL^9.43^^3;0
 ;;^DD(9.4,5,21,0)
 ;;=^^2^2^2920513^^^^
 ;;^DD(9.4,5,21,1,0)
 ;;=These are the globals which make up this Package.  This multiple is used
 ;;^DD(9.4,5,21,2,0)
 ;;=for documentation purposes only.
 ;;^DD(9.4,5,"DT")
 ;;=2940603
 ;;^DD(9.4,6,0)
 ;;=*FILE^9.44PA^^4;0
 ;;^DD(9.4,6,21,0)
 ;;=^^3^3^2920513^^^^
 ;;^DD(9.4,6,21,1,0)
 ;;=Any FileMan files which are part of this Package are documented
 ;;^DD(9.4,6,21,2,0)
 ;;=here.  This multiple controls what files (Data Dictionaries and
 ;;^DD(9.4,6,21,3,0)
 ;;=Data) are sent in an INIT built from this Package entry.
 ;;^DD(9.4,6,"DT")
 ;;=2940603
 ;;^DD(9.4,7,0)
 ;;=*PRINT TEMPLATE^9.46^^DIPT;0
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
 ;;=2940603
 ;;^DD(9.4,8,0)
 ;;=*INPUT TEMPLATE^9.47^^DIE;0
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
 ;;=2940603
 ;;^DD(9.4,9,0)
 ;;=*SORT TEMPLATE^9.48^^DIBT;0
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
 ;;=2940603
 ;;^DD(9.4,9.1,0)
 ;;=*SCREEN TEMPLATE (FORM)^9.485^^DIST;0
 ;;^DD(9.4,9.1,21,0)
 ;;=^^2^2^2920513^^^
 ;;^DD(9.4,9.1,21,1,0)
 ;;=The names of Screen Templates (from the FORM file) associated with
 ;;^DD(9.4,9.1,21,2,0)
 ;;=this package.
