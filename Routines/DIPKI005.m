DIPKI005 ; ; 30-MAR-1999
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.42,.01,21,1,0)
 ;;=This multiple is used for documentation purposes only and does
 ;;^DD(9.42,.01,21,2,0)
 ;;=not control anything during the INIT process.  It is used to document
 ;;^DD(9.42,.01,21,3,0)
 ;;=the routines that are included in this Package.
 ;;^DD(9.42,.01,22)
 ;;=
 ;;^DD(9.42,.01,"DT")
 ;;=2850211
 ;;^DD(9.43,0)
 ;;=*GLOBAL SUB-FIELD^NL^5^3
 ;;^DD(9.43,0,"DT")
 ;;=2910827
 ;;^DD(9.43,0,"IX","B",9.43,.01)
 ;;=
 ;;^DD(9.43,0,"NM","*GLOBAL")
 ;;=
 ;;^DD(9.43,0,"UP")
 ;;=9.4
 ;;^DD(9.43,.01,0)
 ;;=GLOBAL^MF^^0;1^K:X[""""!(X'?.ANP)!(X<0) X I $D(X) K:$L(X)>15!($L(X)<1) X
 ;;^DD(9.43,.01,1,0)
 ;;=^.1
 ;;^DD(9.43,.01,1,1,0)
 ;;=9.43^B
 ;;^DD(9.43,.01,1,1,1)
 ;;=S ^DIC(9.4,DA(1),3,"B",X,DA)=""
 ;;^DD(9.43,.01,1,1,2)
 ;;=K ^DIC(9.4,DA(1),3,"B",X,DA)
 ;;^DD(9.43,.01,3)
 ;;=Enter name of global used in this package.  Answer must be 1-15 characters in length.  (Used for documentation only.)
 ;;^DD(9.43,.01,21,0)
 ;;=^^2^2^2920513^^^
 ;;^DD(9.43,.01,21,1,0)
 ;;=The name of a global which is part of this Package.  Used for documentation
 ;;^DD(9.43,.01,21,2,0)
 ;;=only.
 ;;^DD(9.43,.01,"DT")
 ;;=2910827
 ;;^DD(9.43,4,0)
 ;;=DESCRIPTION^9.431^^4;0
 ;;^DD(9.43,4,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.43,4,21,1,0)
 ;;=This is a description of the global and how it is used by the Package.
 ;;^DD(9.43,5,0)
 ;;=JOURNALLING^S^M:mandatory!;O:optional--not required;N:not recommended;^5;1^Q
 ;;^DD(9.43,5,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(9.43,5,21,1,0)
 ;;=Advises whether or not to Journal this global.
 ;;^DD(9.43,5,"DT")
 ;;=2850228
 ;;^DD(9.431,0)
 ;;=DESCRIPTION SUB-FIELD^NL^.01^1
 ;;^DD(9.431,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(9.431,0,"UP")
 ;;=9.43
 ;;^DD(9.431,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(9.431,.01,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(9.431,.01,21,1,0)
 ;;=This is a description of the global and how it is used by the Package.
 ;;^DD(9.431,.01,"DT")
 ;;=2850228
 ;;^DD(9.432,0)
 ;;=*EXCLUDED NAME SPACE SUB-FIELD^NL^.01^1
 ;;^DD(9.432,0,"NM","*EXCLUDED NAME SPACE")
 ;;=
 ;;^DD(9.432,0,"UP")
 ;;=9.4
 ;;^DD(9.432,.01,0)
 ;;=EXCLUDED NAME SPACE^MFX^^0;1^K:$L(X)>7!($L(X)<2)!'(X?1U1UN.UN) X
 ;;^DD(9.432,.01,3)
 ;;=Please enter the prefix of the excluded name space (2-7 characters).
 ;;^DD(9.432,.01,4)
 ;;=W !,?5,"When DIFROM builds '",$P(^DIC(9.4,D0,0),"^",2),"INIT',",!?5,"OPTIONS, FUNCTIONS, SECURITY KEYS, and BULLETINS beginning with",!?5,"these characters WON'T be included.",!
 ;;^DD(9.432,.01,21,0)
 ;;=^^2^2^2851008^
 ;;^DD(9.432,.01,21,1,0)
 ;;=This specifies a sub-set of the Package's namespace which is not to
 ;;^DD(9.432,.01,21,2,0)
 ;;=be exported by the DIFROM routines.
 ;;^DD(9.432,.01,"DT")
 ;;=2841128
 ;;^DD(9.44,0)
 ;;=*FILE SUB-FIELD^NL^223^9
 ;;^DD(9.44,0,"DT")
 ;;=2890928
 ;;^DD(9.44,0,"IX","B",9.44,.01)
 ;;=
 ;;^DD(9.44,0,"NM","*FILE")
 ;;=
 ;;^DD(9.44,0,"UP")
 ;;=9.4
 ;;^DD(9.44,.01,0)
 ;;=FILE^M*P1'^DIC(^0;1^S DIC("S")="I Y>1.9999" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(9.44,.01,.1)
 ;;=REQUIRED FILES FOR THIS PACKAGE
 ;;^DD(9.44,.01,1,0)
 ;;=^.1
 ;;^DD(9.44,.01,1,1,0)
 ;;=9.44^B
 ;;^DD(9.44,.01,1,1,1)
 ;;=S ^DIC(9.4,DA(1),4,"B",X,DA)=""
 ;;^DD(9.44,.01,1,1,2)
 ;;=K ^DIC(9.4,DA(1),4,"B",X,DA)
 ;;^DD(9.44,.01,1,2,0)
 ;;=9.4^AR
 ;;^DD(9.44,.01,1,2,1)
 ;;=S ^DIC(9.4,"AR",$E(X,1,30),DA(1),DA)=""
 ;;^DD(9.44,.01,1,2,2)
 ;;=K ^DIC(9.4,"AR",$E(X,1,30),DA(1),DA)
 ;;^DD(9.44,.01,3)
 ;;=Please enter the name of a FILE that is known to VA FileMan.
 ;;^DD(9.44,.01,12)
 ;;=Select a file which is used by this package.
 ;;^DD(9.44,.01,12.1)
 ;;=S DIC("S")="I Y>1.9999"
 ;;^DD(9.44,.01,21,0)
 ;;=^^2^2^2920513^^^^
 ;;^DD(9.44,.01,21,1,0)
 ;;=The name of a VA FileMan file which you wish to transport with
 ;;^DD(9.44,.01,21,2,0)
 ;;=this package.  This may be any file whose number is 2 or greater.
 ;;^DD(9.44,.01,"DT")
 ;;=2890928
 ;;^DD(9.44,2,0)
 ;;=FIELD^9.45A^^1;0
 ;;^DD(9.44,2,21,0)
 ;;=^^3^3^2920513^^^
 ;;^DD(9.44,2,21,1,0)
 ;;=The names of the FileMan Fields required by this Package.  Enter data
 ;;^DD(9.44,2,21,2,0)
 ;;=here ONLY if you wish to send just selected fields from a Data Dictionary
 ;;^DD(9.44,2,21,3,0)
 ;;=instead of the entire DD (i.e., a partial DD).
 ;;^DD(9.44,222.1,0)
 ;;=UPDATE THE DATA DICTIONARY^S^y:YES;n:NO;^222;1^Q
 ;;^DD(9.44,222.1,21,0)
 ;;=^^8^8^2920513^^^^
 ;;^DD(9.44,222.1,21,1,0)
 ;;=YES means that the Data Dictionary for this file should be updated when
 ;;^DD(9.44,222.1,21,2,0)
 ;;=this version of the package is installed.
 ;;^DD(9.44,222.1,21,3,0)
 ;;= 
 ;;^DD(9.44,222.1,21,4,0)
 ;;=NO means that this Data Dictionary has not changed since the last version,
 ;;^DD(9.44,222.1,21,5,0)
 ;;=and therefore, need not be updated.
 ;;^DD(9.44,222.1,21,6,0)
 ;;= 
 ;;^DD(9.44,222.1,21,7,0)
 ;;=If the Data Dictionary does not exist on the recipient system, then this
 ;;^DD(9.44,222.1,21,8,0)
 ;;=field does not apply.  The DD will be put in place.
 ;;^DD(9.44,222.1,"DT")
 ;;=2890627
 ;;^DD(9.44,222.2,0)
 ;;=ASSIGN A VERSION NUMBER^S^y:YES;n:NO;^222;2^Q
 ;;^DD(9.44,222.2,3)
 ;;=
 ;;^DD(9.44,222.2,21,0)
 ;;=^^5^5^2920513^^^^
 ;;^DD(9.44,222.2,21,1,0)
 ;;=YES means that you want to set ^DD(file#,0,"VR") to the version
 ;;^DD(9.44,222.2,21,2,0)
 ;;=number of this package when the init is finished.
 ;;^DD(9.44,222.2,21,3,0)
 ;;= 
 ;;^DD(9.44,222.2,21,4,0)
 ;;=NO means that you intend for the version number to remain as it is.
 ;;^DD(9.44,222.2,21,5,0)
 ;;=This may mean that this DD has no version number at all.
 ;;^DD(9.44,222.4,0)
 ;;=MAY USER OVERRIDE DD UPDATE^S^y:YES;n:NO;^222;4^Q
 ;;^DD(9.44,222.4,3)
 ;;=
 ;;^DD(9.44,222.4,21,0)
 ;;=^^5^5^2920513^^^^
 ;;^DD(9.44,222.4,21,1,0)
 ;;=YES means that the user may decide at installation time whether or not
 ;;^DD(9.44,222.4,21,2,0)
 ;;=to update the data dictionary for this file.
 ;;^DD(9.44,222.4,21,3,0)
 ;;= 
 ;;^DD(9.44,222.4,21,4,0)
 ;;=NO means that the developer building the INIT is determining if the
 ;;^DD(9.44,222.4,21,5,0)
 ;;=data dictionary is to be updated.
 ;;^DD(9.44,222.7,0)
 ;;=DATA COMES WITH FILE^S^y:YES;n:NO;^222;7^Q
 ;;^DD(9.44,222.7,2)
 ;;=DATA COMES WITH FILE
 ;;^DD(9.44,222.7,21,0)
 ;;=^^4^4^2920513^^^^
 ;;^DD(9.44,222.7,21,1,0)
 ;;=YES means that the data should be included in the initialization
 ;;^DD(9.44,222.7,21,2,0)
 ;;=routines.
 ;;^DD(9.44,222.7,21,3,0)
 ;;= 
 ;;^DD(9.44,222.7,21,4,0)
 ;;=NO means that the data should be left out.
 ;;^DD(9.44,222.7,"DT")
 ;;=2940502
 ;;^DD(9.44,222.8,0)
 ;;=MERGE OR OVERWRITE SITE'S DATA^S^m:MERGE;o:OVERWRITE;^222;8^Q
