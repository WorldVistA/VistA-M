IBDEI002 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQ(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(358,.01,1,6,0)
 ;;=358^AB^MUMPS
 ;;^DD(358,.01,1,6,1)
 ;;=Q
 ;;^DD(358,.01,1,6,2)
 ;;=Q
 ;;^DD(358,.01,1,6,"%D",0)
 ;;=^^4^4^2940606^^
 ;;^DD(358,.01,1,6,"%D",1,0)
 ;;=This cross-reference will be used to store the boxes needed for the compiled
 ;;^DD(358,.01,1,6,"%D",2,0)
 ;;=forms. The format will be ..."AB",form ien,row #,column #, Block ien)=
 ;;^DD(358,.01,1,6,"%D",3,0)
 ;;=box width^box height. The index will be created by the 'compile'
 ;;^DD(358,.01,1,6,"%D",4,0)
 ;;=action of the encounter form utilities.
 ;;^DD(358,.01,1,6,"DT")
 ;;=2940606
 ;;^DD(358,.01,3)
 ;;=The form name must be 3-30 uppercase characters in length.
 ;;^DD(358,.01,21,0)
 ;;=^^2^2^2931110^^
 ;;^DD(358,.01,21,1,0)
 ;;= 
 ;;^DD(358,.01,21,2,0)
 ;;=The name of the encounter form.
 ;;^DD(358,.01,"DEL",1,0)
 ;;=I 1 W "...Encounter Forms can only be deleted through the",!," DELETE UNUSED FORM action in the Encounter Form Utilities!"
 ;;^DD(358,.01,"DT")
 ;;=2940606
