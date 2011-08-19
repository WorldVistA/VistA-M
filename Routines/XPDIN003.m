XPDIN003 ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 Q:'DIFQ(9.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(9.6,914,"DT")
 ;;=2940518
 ;;^DD(9.6,916,0)
 ;;=PRE-INSTALL ROUTINE^FX^^INI;E1,240^K:$L(X)>17!(X'?.1UP.7UN.1"^".1UP.7UN) X
 ;;^DD(9.6,916,.1)
 ;;=
 ;;^DD(9.6,916,3)
 ;;=Enter name of developer's pre-init [TAG^]ROUTINE.
 ;;^DD(9.6,916,21,0)
 ;;=^^6^6^2940518^^^^
 ;;^DD(9.6,916,21,1,0)
 ;;=Name of the developer's routine that runs after the user has answered all
 ;;^DD(9.6,916,21,2,0)
 ;;=of the questions, but before any data or DD has been installed. All of
 ;;^DD(9.6,916,21,3,0)
 ;;=the routines for this package will already be installed. Used for data
 ;;^DD(9.6,916,21,4,0)
 ;;=conversions, etc. that the developer needs to do before bringing in new
 ;;^DD(9.6,916,21,5,0)
 ;;=data.  This routine cannot be interactive with the user, it might
 ;;^DD(9.6,916,21,6,0)
 ;;=be queued to run at a later time.
 ;;^DD(9.6,916,"DT")
 ;;=2940518
 ;;^DD(9.61,0)
 ;;=DESCRIPTION OF ENHANCEMENTS SUB-FIELD^NL^.01^1
 ;;^DD(9.61,0,"NM","DESCRIPTION OF ENHANCEMENTS")
 ;;=
 ;;^DD(9.61,0,"UP")
 ;;=9.6
 ;;^DD(9.61,.01,0)
 ;;=DESCRIPTION^W^^0;1^Q
 ;;^DD(9.61,.01,3)
 ;;=Please enter a complete and detailed description of the Package.
 ;;^DD(9.61,.01,21,0)
 ;;=^^2^2^2920513^^^^
 ;;^DD(9.61,.01,21,1,0)
 ;;=This is a complete and detailed description of the Package's functions
 ;;^DD(9.61,.01,21,2,0)
 ;;=and capabilities.
 ;;^DD(9.61,.01,"DT")
 ;;=2851007
 ;;^DD(9.62,0)
 ;;=INSTALL QUESTIONS SUB-FIELD^^10^9
 ;;^DD(9.62,0,"DT")
 ;;=2931129
 ;;^DD(9.62,0,"IX","B",9.62,.01)
 ;;=
 ;;^DD(9.62,0,"NM","INSTALL QUESTIONS")
 ;;=
 ;;^DD(9.62,0,"UP")
 ;;=9.6
 ;;^DD(9.62,.01,0)
 ;;=SUBSCRIPT^MFX^^0;1^K:$L(X)>30!'(X?1"PRE".E!(X?1"POS".E)) X
 ;;^DD(9.62,.01,1,0)
 ;;=^.1
 ;;^DD(9.62,.01,1,1,0)
 ;;=9.62^B
 ;;^DD(9.62,.01,1,1,1)
 ;;=S ^XPD(9.6,DA(1),"QUES","B",$E(X,1,30),DA)=""
 ;;^DD(9.62,.01,1,1,2)
 ;;=K ^XPD(9.6,DA(1),"QUES","B",$E(X,1,30),DA)
 ;;^DD(9.62,.01,3)
 ;;=Answer must begin with "PRE" or "POS" and can be up to 30 characters in length.
 ;;^DD(9.62,.01,21,0)
 ;;=^^8^8^2940607^^^^
 ;;^DD(9.62,.01,21,1,0)
 ;;=This field will be used as the subscript of the users answer to the
 ;;^DD(9.62,.01,21,2,0)
 ;;=Install Questions.  The first 3 character should be either "PRE" or "POS"
 ;;^DD(9.62,.01,21,3,0)
 ;;=to indicate whether the question should be asked during the pre-init or
 ;;^DD(9.62,.01,21,4,0)
 ;;=during the post-init.   The answers will be in the XPDQUES array, example:
 ;;^DD(9.62,.01,21,5,0)
 ;;= If this field was set to 'PRE1 QUESTION' then
 ;;^DD(9.62,.01,21,6,0)
 ;;= XPDQUES("PRE1 QUESTION") = user response.
 ;;^DD(9.62,.01,21,7,0)
 ;;= 
 ;;^DD(9.62,.01,21,8,0)
 ;;=This field is also used to determine the order of the questions.
 ;;^DD(9.62,.01,"DT")
 ;;=2931129
 ;;^DD(9.62,1,0)
 ;;=DIR(0)^RF^^1;E1,245^K:$L(X)>240!($L(X)<1) X
 ;;^DD(9.62,1,3)
 ;;=Answer must be 1-240 characters in length.
 ;;^DD(9.62,1,21,0)
 ;;=^^1^1^2940414^
 ;;^DD(9.62,1,21,1,0)
 ;;=This is the DIR(0) variable for the VA Fileman DIR routine.
 ;;^DD(9.62,1,"DT")
 ;;=2931123
 ;;^DD(9.62,2,0)
 ;;=DIR(A)^F^^A;E1,245^K:$L(X)>240!($L(X)<1) X
 ;;^DD(9.62,2,3)
 ;;=Answer must be 1-240 characters in length.
 ;;^DD(9.62,2,21,0)
 ;;=^^1^1^2940414^^
 ;;^DD(9.62,2,21,1,0)
 ;;=This is the DIR("A") variable for the VA Fileman DIR routine.
 ;;^DD(9.62,2,"DT")
 ;;=2931122
 ;;^DD(9.62,3,0)
 ;;=DIR(A,#)^9.623^^A1;0
 ;;^DD(9.62,3,21,0)
 ;;=^^1^1^2940414^^
 ;;^DD(9.62,3,21,1,0)
 ;;=This is the DIR("A",#) array for the VA Fileman DIR routine.
 ;;^DD(9.62,4,0)
 ;;=DIR(B)^F^^B;1^K:$L(X)>79!($L(X)<1) X
 ;;^DD(9.62,4,3)
 ;;=Answer must be 1-79 characters in length.
 ;;^DD(9.62,4,21,0)
 ;;=^^1^1^2940414^^
 ;;^DD(9.62,4,21,1,0)
 ;;=This is the DIR("B") variable for the VA Fileman DIR routine.
 ;;^DD(9.62,4,"DT")
 ;;=2931122
 ;;^DD(9.62,5,0)
 ;;=DIR(?)^F^^Q;E1,245^K:$L(X)>240!($L(X)<1) X
 ;;^DD(9.62,5,3)
 ;;=Answer must be 1-240 characters in length.
 ;;^DD(9.62,5,21,0)
 ;;=^^1^1^2940414^^
 ;;^DD(9.62,5,21,1,0)
 ;;=This is the DIR("?") variable for the VA Fileman DIR routine.
 ;;^DD(9.62,5,"DT")
 ;;=2931122
 ;;^DD(9.62,6,0)
 ;;=DIR(?,#)^9.626^^Q1;0
 ;;^DD(9.62,6,21,0)
 ;;=^^1^1^2940414^^
 ;;^DD(9.62,6,21,1,0)
 ;;=This is the DIR("?",#) array for the VA Fileman DIR routine.
 ;;^DD(9.62,7,0)
 ;;=DIR(??)^F^^QQ;E1,245^K:$L(X)>240!($L(X)<3) X
 ;;^DD(9.62,7,3)
 ;;=Answer must be 3-240 characters in length.
 ;;^DD(9.62,7,21,0)
 ;;=^^1^1^2940414^^
 ;;^DD(9.62,7,21,1,0)
 ;;=This is the DIR("??") variable for the VA Fileman DIR routine.
 ;;^DD(9.62,7,"DT")
 ;;=2931122
 ;;^DD(9.62,10,0)
 ;;=M CODE^K^^M;E1,245^K:$L(X)>245 X D:$D(X) ^DIM
 ;;^DD(9.62,10,3)
 ;;=This is Standard MUMPS code.
 ;;^DD(9.62,10,9)
 ;;=@
