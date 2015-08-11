IBDEI203 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQ(358.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(358.6,.01,1,2,2)
 ;;=K ^IBE(358.6,"E",$E(X,$F(X," "),40),DA)
 ;;^DD(358.6,.01,1,2,"%D",0)
 ;;=^^4^4^2940224^
 ;;^DD(358.6,.01,1,2,"%D",1,0)
 ;;= 
 ;;^DD(358.6,.01,1,2,"%D",2,0)
 ;;=For package interfaces that are output routines the name has the custodial
 ;;^DD(358.6,.01,1,2,"%D",3,0)
 ;;=package's name space as a prefix. This cross-reference removes that
 ;;^DD(358.6,.01,1,2,"%D",4,0)
 ;;=prefix. It is used to improve the display of output routines for the user.
 ;;^DD(358.6,.01,1,2,"DT")
 ;;=2930409
 ;;^DD(358.6,.01,3)
 ;;=Answer must be 3-40 characters in length. All entries with Action Type other than PRINT REPORT must be be prefixed with the namespace of the package that is responsible for the data.
 ;;^DD(358.6,.01,21,0)
 ;;=^^3^3^2950412^^^^
 ;;^DD(358.6,.01,21,1,0)
 ;;= 
 ;;^DD(358.6,.01,21,2,0)
 ;;=The name of the Package Interface. For interfaces returning data the name
 ;;^DD(358.6,.01,21,3,0)
 ;;=should be preceded with the namespace of the package.
 ;;^DD(358.6,.01,23,0)
 ;;=^^1^1^2950412^
 ;;^DD(358.6,.01,23,1,0)
 ;;= 
 ;;^DD(358.6,.01,"DT")
 ;;=2930409
