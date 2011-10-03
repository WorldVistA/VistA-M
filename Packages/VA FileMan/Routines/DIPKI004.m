DIPKI004 ; ; 30-MAR-1999
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q:'DIFQ(9.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.4,1946,21,2,0)
 ;;=along with the Package.
 ;;^DD(9.4,1946,"DT")
 ;;=2940606
 ;;^DD(9.4,15007,0)
 ;;=SYNONYM^9.415007^^15007;0
 ;;^DD(9.402,0)
 ;;=AFFECTS RECORD MERGE SUB-FIELD^^4^3
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
 ;;=^^1^1^2940627^^
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
 ;;^DD(9.404,0)
 ;;=*VERIFICATION SUB-FIELD^NL^3^4
 ;;^DD(9.404,0,"ID",1)
 ;;=W:$D(^(0)) "   ",$P(^(0),U,2)
 ;;^DD(9.404,0,"NM","*VERIFICATION")
 ;;=
 ;;^DD(9.404,0,"UP")
 ;;=9.4
 ;;^DD(9.404,.01,0)
 ;;=VERIFICATION^DX^^0;1^S %DT="E" D ^%DT S (DINUM,X)=Y K:Y<1 DINUM,X
 ;;^DD(9.404,.01,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(9.404,.01,21,1,0)
 ;;=Date of notification that this software has been verified.
 ;;^DD(9.404,.01,"DT")
 ;;=2840815
 ;;^DD(9.404,1,0)
 ;;=ISC^F^^0;2^K:$L(X)>20!($L(X)<2) X
 ;;^DD(9.404,1,3)
 ;;=The name of the ISC responsible for verification (3-20 characters).
 ;;^DD(9.404,1,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.404,1,21,1,0)
 ;;=The name of the ISC where this verification was done.
 ;;^DD(9.404,1,"DT")
 ;;=2840815
 ;;^DD(9.404,2,0)
 ;;=VERSION^NJ6,2^^0;3^K:+X'=X!(X>999)!(X<0)!(X?.E1"."3N.N) X
 ;;^DD(9.404,2,3)
 ;;=Please enter the version number of this verified Package (0.00-999.99).
 ;;^DD(9.404,2,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.404,2,21,1,0)
 ;;=The version number of this verified Package.
 ;;^DD(9.404,2,"DT")
 ;;=2840815
 ;;^DD(9.404,3,0)
 ;;=COMMENTS^9.414^^1;0
 ;;^DD(9.404,3,21,0)
 ;;=^^1^1^2920513^^
 ;;^DD(9.404,3,21,1,0)
 ;;=Comments regarding this verified version of the Package.
 ;;^DD(9.409,0)
 ;;=*DELTA SUB-FIELD^NL^.01^1
 ;;^DD(9.409,0,"NM","*DELTA")
 ;;=
 ;;^DD(9.409,0,"UP")
 ;;=9.4
 ;;^DD(9.409,.01,0)
 ;;=DELTA^MP4'X^DIC(4,^0;1^S:$D(X) DINUM=X
 ;;^DD(9.409,.01,3)
 ;;=Please enter the name of the Delta Test site.
 ;;^DD(9.409,.01,21,0)
 ;;=^^1^1^2851007^
 ;;^DD(9.409,.01,21,1,0)
 ;;=The name of a Delta Test site for this Package.
 ;;^DD(9.409,.01,"DT")
 ;;=2840815
 ;;^DD(9.41,0)
 ;;=DESCRIPTION SUB-FIELD^NL^.01^1
 ;;^DD(9.41,0,"NM","DESCRIPTION")
 ;;=
 ;;^DD(9.41,0,"UP")
 ;;=9.4
 ;;^DD(9.41,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(9.41,.01,3)
 ;;=Please enter a complete and detailed description of the Package.
 ;;^DD(9.41,.01,21,0)
 ;;=^^2^2^2920513^^^^
 ;;^DD(9.41,.01,21,1,0)
 ;;=This is a complete and detailed description of the Package's functions
 ;;^DD(9.41,.01,21,2,0)
 ;;=and capabilities.
 ;;^DD(9.41,.01,"DT")
 ;;=2851007
 ;;^DD(9.414,0)
 ;;=COMMENTS SUB-FIELD^NL^.01^1
 ;;^DD(9.414,0,"NM","COMMENTS")
 ;;=
 ;;^DD(9.414,0,"UP")
 ;;=9.404
 ;;^DD(9.414,.01,0)
 ;;=COMMENTS^W^^0;1^Q
 ;;^DD(9.414,.01,3)
 ;;=Comments relating to verification
 ;;^DD(9.414,.01,21,0)
 ;;=^^1^1^2920513^^^
 ;;^DD(9.414,.01,21,1,0)
 ;;=Comments regarding this verified version of the Package.
 ;;^DD(9.414,.01,"DT")
 ;;=2840815
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
 ;;^DD(9.42,0)
 ;;=*ROUTINE SUB-FIELD^NL^.01^1
 ;;^DD(9.42,0,"IX","B",9.42,.01)
 ;;=
 ;;^DD(9.42,0,"NM","*ROUTINE")
 ;;=
 ;;^DD(9.42,0,"UP")
 ;;=9.4
 ;;^DD(9.42,.01,0)
 ;;=ROUTINE^MFX^^0;1^K:$L(X)>8!($L(X)<1)!'(X?.UN!(X?1"%".UN)) X
 ;;^DD(9.42,.01,1,0)
 ;;=^.1^^-1
 ;;^DD(9.42,.01,1,1,0)
 ;;=9.4^D
 ;;^DD(9.42,.01,1,1,1)
 ;;=S ^DIC(9.4,"D",X,DA(1))=""
 ;;^DD(9.42,.01,1,1,2)
 ;;=K ^DIC(9.4,"D",X,DA(1))
 ;;^DD(9.42,.01,1,2,0)
 ;;=9.42^B
 ;;^DD(9.42,.01,1,2,1)
 ;;=S ^DIC(9.4,DA(1),2,"B",X,DA)=""
 ;;^DD(9.42,.01,1,2,2)
 ;;=K ^DIC(9.4,DA(1),2,"B",X,DA)
 ;;^DD(9.42,.01,3)
 ;;=Please enter a routine name (1-8 characters).
 ;;^DD(9.42,.01,21,0)
 ;;=^^3^3^2920513^^^^
