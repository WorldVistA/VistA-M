DIPKI003 ;VEN/TOAD-PACKAGE FILE INIT ; 04-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.402,0,"DT")
 ;;=2900906
 ;;^DD(9.402,0,"IX","B",9.402,.01)
 ;;=
 ;;^DD(9.402,0,"NM","AFFECTS RECORD MERGE")
 ;;=
 ;;^DD(9.402,0,"UP")
 ;;=9.4
 ;;^DD(9.402,.01,0)
 ;;=FILE AFFECTED^*P1'X^DIC(^0;1^S DIC("S")="I $D(^DD(15,.01,""V"",""B"",Y))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X S:$D(X) DINUM=X
 ;;^DD(9.402,.01,1,0)
 ;;=^.1
 ;;^DD(9.402,.01,1,1,0)
 ;;=9.402^B
 ;;^DD(9.402,.01,1,1,1)
 ;;=S ^DIC(9.4,DA(1),20,"B",$E(X,1,30),DA)=""
 ;;^DD(9.402,.01,1,1,2)
 ;;=K ^DIC(9.4,DA(1),20,"B",$E(X,1,30),DA)
 ;;^DD(9.402,.01,1,2,0)
 ;;=9.4^AMRG
 ;;^DD(9.402,.01,1,2,1)
 ;;=S ^DIC(9.4,"AMRG",$E(X,1,30),DA(1),DA)=""
 ;;^DD(9.402,.01,1,2,2)
 ;;=K ^DIC(9.4,"AMRG",$E(X,1,30),DA(1),DA)
 ;;^DD(9.402,.01,1,2,"%D",0)
 ;;=^^2^2^2900906^
 ;;^DD(9.402,.01,1,2,"%D",1,0)
 ;;=This xref is used by the merge process to determine if any package
 ;;^DD(9.402,.01,1,2,"%D",2,0)
 ;;=file entry affects the file being merged.
 ;;^DD(9.402,.01,1,2,"DT")
 ;;=2900906
 ;;^DD(9.402,.01,3)
 ;;=Pointer to a file that has been added to FILE 15's variable pointer.
 ;;^DD(9.402,.01,12)
 ;;=MUST BE VARIABLE POINTER FILE IN FIELD .01 OF FILE 15
 ;;^DD(9.402,.01,12.1)
 ;;=S DIC("S")="I $D(^DD(15,.01,""V"",""B"",Y))"
 ;;^DD(9.402,.01,21,0)
 ;;=^^1^1^2970307^^^^
 ;;^DD(9.402,.01,21,1,0)
 ;;=A file that if merged will affect this package.
 ;;^DD(9.402,.01,"DT")
 ;;=2900910
 ;;^DD(9.402,3,0)
 ;;=NAME OF MERGE ROUTINE^F^^0;3^K:$L(X)>8!($L(X)<2)!'(X?1U1.7UN) X
 ;;^DD(9.402,3,3)
 ;;=Answer with a routine name (1U.1.7UN).
 ;;^DD(9.402,3,21,0)
 ;;=^^4^4^2930330^
 ;;^DD(9.402,3,21,1,0)
 ;;=This field holds the routine name to call when two records in
 ;;^DD(9.402,3,21,2,0)
 ;;=an affected file are to be merged. This allows the package to
 ;;^DD(9.402,3,21,3,0)
 ;;=do any repointing or other clean-up needed before the records
 ;;^DD(9.402,3,21,4,0)
 ;;=are merged.
 ;;^DD(9.402,3,"DT")
 ;;=2900816
 ;;^DD(9.402,4,0)
 ;;=RECORD HAS PACKAGE DATA^K^^1;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(9.402,4,3)
 ;;=This is Standard MUMPS code. To tell if this record has data in this package.
 ;;^DD(9.402,4,9)
 ;;=@
 ;;^DD(9.402,4,"DT")
 ;;=2900816
 ;;^DD(9.41,0)
 ;;=DESCRIPTION SUB-FIELD^NL^.01^1
 ;;^DD(9.41,0,"DT")
 ;;=3130331
 ;;^DD(9.41,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(9.41,0,"UP")
 ;;=9.4
 ;;^DD(9.41,.01,0)
 ;;=DESCRIPTION^Wa^^0;1^Q
 ;;^DD(9.41,.01,3)
 ;;=Please enter a complete and detailed description of the Package.
 ;;^DD(9.41,.01,21,0)
 ;;=^^2^2^2920513^^^^
 ;;^DD(9.41,.01,21,1,0)
 ;;=This is a complete and detailed description of the Package's functions
 ;;^DD(9.41,.01,21,2,0)
 ;;=and capabilities.
 ;;^DD(9.41,.01,"AUDIT")
 ;;=y
 ;;^DD(9.41,.01,"DT")
 ;;=3130331
 ;;^DD(9.415007,0)
 ;;=SYNONYM SUB-FIELD^^.01^1
 ;;^DD(9.415007,0,"DT")
 ;;=2941020
 ;;^DD(9.415007,0,"IX","B",9.415007,.01)
 ;;=
 ;;^DD(9.415007,0,"NM","SYNONYM")
 ;;=
 ;;^DD(9.415007,0,"UP")
 ;;=9.4
 ;;^DD(9.415007,.01,0)
 ;;=SYNONYM^F^^0;1^K:$L(X)>30!($L(X)<2) X
 ;;^DD(9.415007,.01,1,0)
 ;;=^.1
 ;;^DD(9.415007,.01,1,1,0)
 ;;=9.415007^B
 ;;^DD(9.415007,.01,1,1,1)
 ;;=S ^DIC(9.4,DA(1),15007,"B",$E(X,1,30),DA)=""
 ;;^DD(9.415007,.01,1,1,2)
 ;;=K ^DIC(9.4,DA(1),15007,"B",$E(X,1,30),DA)
 ;;^DD(9.415007,.01,1,2,0)
 ;;=9.4^E
 ;;^DD(9.415007,.01,1,2,1)
 ;;=S ^DIC(9.4,"E",$E(X,1,30),DA(1),DA)=""
 ;;^DD(9.415007,.01,1,2,2)
 ;;=K ^DIC(9.4,"E",$E(X,1,30),DA(1),DA)
 ;;^DD(9.415007,.01,1,2,"%D",0)
 ;;=^^2^2^2941020^
 ;;^DD(9.415007,.01,1,2,"%D",1,0)
 ;;=This allow the lookup of a package other than it's official name.
 ;;^DD(9.415007,.01,1,2,"%D",2,0)
 ;;=It is'nt used by the Kernel VERSION function.
 ;;^DD(9.415007,.01,1,2,"DT")
 ;;=2941020
 ;;^DD(9.415007,.01,3)
 ;;=Answer must be 2-30 characters in length.
 ;;^DD(9.415007,.01,"DT")
 ;;=2941020
 ;;^DD(9.432,0)
 ;;=EXCLUDED NAME SPACE SUB-FIELD^NL^.01^1
 ;;^DD(9.432,0,"NM","EXCLUDED NAME SPACE")
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
 ;;=FILE SUB-FIELD^NL^223^9
 ;;^DD(9.44,0,"DT")
 ;;=2890928
 ;;^DD(9.44,0,"IX","B",9.44,.01)
 ;;=
 ;;^DD(9.44,0,"NM","FILE")
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
 ;;^DD(9.44,222.8,3)
 ;;=
 ;;^DD(9.44,222.8,21,0)
 ;;=^^7^7^2920513^^^^
 ;;^DD(9.44,222.8,21,1,0)
 ;;= 
 ;;^DD(9.44,222.8,21,2,0)
 ;;=If the data being sent is to be MERGED, then only data which is not
 ;;^DD(9.44,222.8,21,3,0)
 ;;=already on file at the recipient site will be put in place.
 ;;^DD(9.44,222.8,21,4,0)
 ;;= 
 ;;^DD(9.44,222.8,21,5,0)
 ;;=If the data being sent is to OVERWRITE, then the data included in
 ;;^DD(9.44,222.8,21,6,0)
 ;;=the initialization routines will be put in place regardless of what
 ;;^DD(9.44,222.8,21,7,0)
 ;;=is on file at the recipient site.
 ;;^DD(9.44,222.8,"DT")
 ;;=2890627
 ;;^DD(9.44,222.9,0)
 ;;=MAY USER OVERRIDE DATA UPDATE^S^y:YES;n:NO;^222;9^Q
 ;;^DD(9.44,222.9,2)
 ;;=MAY USER OVERRIDE DATA UPDATE
 ;;^DD(9.44,222.9,3)
 ;;=
 ;;^DD(9.44,222.9,21,0)
 ;;=^^7^7^2920513^^^^
 ;;^DD(9.44,222.9,21,1,0)
 ;;=YES means that the user has the option to determine whether or not
 ;;^DD(9.44,222.9,21,2,0)
 ;;=to bring in the data that has been sent with the package.  However,
