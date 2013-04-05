IBDEI001 ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQ(358)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358,0,"GL")
 ;;=^IBE(358,
 ;;^DIC("B","IMP/EXP ENCOUNTER FORM",358)
 ;;=
 ;;^DIC(358,"%D",0)
 ;;=^^1^1^2940829^^^^
 ;;^DIC(358,"%D",1,0)
 ;;=Used by the import/export utility as a workspace.
 ;;^DIC(358,"%D",2,0)
 ;;=This file is nearly identical to file #357. It is used by the Import/Export
 ;;^DIC(358,"%D",3,0)
 ;;=Utility as a temporary staging area for data from that file that is being
 ;;^DIC(358,"%D",4,0)
 ;;=imported or exported.
 ;;^DD(358,0)
 ;;=FIELD^^2^18
 ;;^DD(358,0,"DDA")
 ;;=N
 ;;^DD(358,0,"DT")
 ;;=2951024
 ;;^DD(358,0,"ID",.03)
 ;;=W "   ",$P(^(0),U,3)
 ;;^DD(358,0,"IX","AB",358,.01)
 ;;=
 ;;^DD(358,0,"IX","AC",358,.01)
 ;;=
 ;;^DD(358,0,"IX","AG",358,.01)
 ;;=
 ;;^DD(358,0,"IX","AT",358,.01)
 ;;=
 ;;^DD(358,0,"IX","AU",358,.01)
 ;;=
 ;;^DD(358,0,"IX","B",358,.01)
 ;;=
 ;;^DD(358,0,"IX","C",358,.07)
 ;;=
 ;;^DD(358,0,"IX","D",358,.04)
 ;;=
 ;;^DD(358,0,"NM","IMP/EXP ENCOUNTER FORM")
 ;;=
 ;;^DD(358,0,"PT",358.1,.02)
 ;;=
 ;;^DD(358,0,"VRPK")
 ;;=IBD
 ;;^DD(358,.01,0)
 ;;=NAME^RFX^^0;1^K:X[""""!($A(X)=45) X I $D(X) S X=$$UP^XLFSTR(X) K:$L(X)>30!($L(X)<3) X
 ;;^DD(358,.01,1,0)
 ;;=^.1
 ;;^DD(358,.01,1,1,0)
 ;;=358^B
 ;;^DD(358,.01,1,1,1)
 ;;=S ^IBE(358,"B",$E(X,1,30),DA)=""
 ;;^DD(358,.01,1,1,2)
 ;;=K ^IBE(358,"B",$E(X,1,30),DA)
 ;;^DD(358,.01,1,2,0)
 ;;=358^AT^MUMPS
 ;;^DD(358,.01,1,2,1)
 ;;=Q
 ;;^DD(358,.01,1,2,2)
 ;;=Q
 ;;^DD(358,.01,1,2,"%D",0)
 ;;=^^4^4^2931124^
 ;;^DD(358,.01,1,2,"%D",1,0)
 ;;=This cross-reference will be used to store the text of the compiled form.
 ;;^DD(358,.01,1,2,"%D",2,0)
 ;;=The format will be ..."AT",form ien,row #)=text line. The index will be
 ;;^DD(358,.01,1,2,"%D",3,0)
 ;;=created by the 'compile' action of the encounter form utilities - it is
 ;;^DD(358,.01,1,2,"%D",4,0)
 ;;=optional.
 ;;^DD(358,.01,1,2,"DT")
 ;;=2931124
 ;;^DD(358,.01,1,3,0)
 ;;=358^AC^MUMPS
 ;;^DD(358,.01,1,3,1)
 ;;=Q
 ;;^DD(358,.01,1,3,2)
 ;;=Q
 ;;^DD(358,.01,1,3,"%D",0)
 ;;=^^4^4^2940216^
 ;;^DD(358,.01,1,3,"%D",1,0)
 ;;=This cross-reference will be used to store the special controls needed
 ;;^DD(358,.01,1,3,"%D",2,0)
 ;;=(bold on, bold off, etc.) to print the compiled form. The format will be
 ;;^DD(358,.01,1,3,"%D",3,0)
 ;;=..."AC",form ien,row #,column # )=controls. The index will be created by
 ;;^DD(358,.01,1,3,"%D",4,0)
 ;;=the 'compile' action of the encounter form utilities - it is optional.
 ;;^DD(358,.01,1,3,"DT")
 ;;=2931124
 ;;^DD(358,.01,1,4,0)
 ;;=358^AU^MUMPS
 ;;^DD(358,.01,1,4,1)
 ;;=Q
 ;;^DD(358,.01,1,4,2)
 ;;=Q
 ;;^DD(358,.01,1,4,"%D",0)
 ;;=^^4^4^2931124^
 ;;^DD(358,.01,1,4,"%D",1,0)
 ;;=This cross-reference will be used to store the underlining of the compiled
 ;;^DD(358,.01,1,4,"%D",2,0)
 ;;=form. The format will be ...,"AU",form ien,row #)=underlining . The index
 ;;^DD(358,.01,1,4,"%D",3,0)
 ;;=will be created by the 'compile' action of the encounter form utilities -
 ;;^DD(358,.01,1,4,"%D",4,0)
 ;;=it is optional.
 ;;^DD(358,.01,1,4,"DT")
 ;;=2931124
 ;;^DD(358,.01,1,5,0)
 ;;=358^AG^MUMPS
 ;;^DD(358,.01,1,5,1)
 ;;=Q
 ;;^DD(358,.01,1,5,2)
 ;;=Q
 ;;^DD(358,.01,1,5,"%D",0)
 ;;=^^5^5^2931124^
 ;;^DD(358,.01,1,5,"%D",1,0)
 ;;=This cross-reference will be used to store strings of graphics characters
 ;;^DD(358,.01,1,5,"%D",2,0)
 ;;=(TLC,TRC, etc.) needed for the compiled form. The format will be
 ;;^DD(358,.01,1,5,"%D",3,0)
 ;;=..."AG",form ien,row #,column # )=graphics string . The index will be
 ;;^DD(358,.01,1,5,"%D",4,0)
 ;;=created by the 'compile' action of the encounter form utilities - it is
 ;;^DD(358,.01,1,5,"%D",5,0)
 ;;=optional.
 ;;^DD(358,.01,1,5,"DT")
 ;;=2931124
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
