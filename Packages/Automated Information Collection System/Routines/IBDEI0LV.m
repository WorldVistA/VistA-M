IBDEI0LV ; ; 19-NOV-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQ(358.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(358.6,0,"GL")
 ;;=^IBE(358.6,
 ;;^DIC("B","IMP/EXP PACKAGE INTERFACE",358.6)
 ;;=
 ;;^DIC(358.6,"%D",0)
 ;;=^^1^1^2950927^^^^
 ;;^DIC(358.6,"%D",1,0)
 ;;=This file is used as a workspace by the import/export utility.
 ;;^DIC(358.6,"%D",2,0)
 ;;=Import/Export Utility as a temporary staging area for data from that file
 ;;^DIC(358.6,"%D",3,0)
 ;;=that is being imported or exported.
 ;;^DIC(358.6,"%D",4,0)
 ;;= 
 ;;^DIC(358.6,"%D",5,0)
 ;;=This file contains a description of all of the interfaces with other packages.
 ;;^DIC(358.6,"%D",6,0)
 ;;=The form will invoke the proper interface routines by doing a lookup on
 ;;^DIC(358.6,"%D",7,0)
 ;;=this file and then invoking the routine by indirection. The INPUT VARIABLE
 ;;^DIC(358.6,"%D",8,0)
 ;;=fields are for documentation purposes and to verify that the proper
 ;;^DIC(358.6,"%D",9,0)
 ;;=variables are defined. Data will be exchanged between the encounter form
 ;;^DIC(358.6,"%D",10,0)
 ;;=utilities and other packages by putting the data in a predefined location.
 ;;^DIC(358.6,"%D",11,0)
 ;;=The first part of the subscript is always be ^TMP("IB",$J,"INTERFACES".
 ;;^DIC(358.6,"%D",12,0)
 ;;=For output routines, but not selection routines, the fourth subscript is
 ;;^DIC(358.6,"%D",13,0)
 ;;=be the patient DFN. The next subscript is the name of the Package
 ;;^DIC(358.6,"%D",14,0)
 ;;=Interface. For single valued data and record valued data there is no
 ;;^DIC(358.6,"%D",15,0)
 ;;=additional subscript. For interfaces returning a list there is one
 ;;^DIC(358.6,"%D",16,0)
 ;;=additional subscript level, the number of the item on the list. For
 ;;^DIC(358.6,"%D",17,0)
 ;;=word processing type data the data will be in FM word-processing format,
 ;;^DIC(358.6,"%D",18,0)
 ;;=i.e., the final subscripts will be ...1,0),...2,0),...3,0), etc.
 ;;^DIC(358.6,"%D",19,0)
 ;;=these items of data can have its own entry in the Package Interface file,
 ;;^DIC(358.6,"%D",20,0)
 ;;=but by using the same entry point there is a savings because all of the
 ;;^DIC(358.6,"%D",21,0)
 ;;=data on that node can be obtained at once. The routines that invoke the
 ;;^DIC(358.6,"%D",22,0)
 ;;=entry point keep track of the entry points already invoked so they are
 ;;^DIC(358.6,"%D",23,0)
 ;;=not repeated.
 ;;^DD(358.6,0)
 ;;=FIELD^^21^76
 ;;^DD(358.6,0,"DDA")
 ;;=N
 ;;^DD(358.6,0,"DT")
 ;;=3000124
 ;;^DD(358.6,0,"ID",.06)
 ;;=W ""
 ;;^DD(358.6,0,"ID","WRITE")
 ;;=N IBDWNAM S IBDWNAM=$E($P(^(0),U),1,40) D EN^DDIOL(IBDWNAM,"","!?0")
 ;;^DD(358.6,0,"ID","WRITE1")
 ;;=N IBDWTYPE S IBDWTYPE=$S($P(^(0),"^",6)=1:"INPUT",$P(^(0),"^",6)=2:"OUTPUT",$P(^(0),"^",6)=3:"SELECTION",1:"REPORT")_$S($P(^(0),U,6)=3&'$P(^(0),"^",13):"  ** NOT SCANNABLE **",1:"") D EN^DDIOL("TYPE="_IBDWTYPE,"","?45")
 ;;^DD(358.6,0,"IX","B",358.6,.01)
 ;;=
 ;;^DD(358.6,0,"IX","C",358.6,.04)
 ;;=
 ;;^DD(358.6,0,"IX","D",358.6,3)
 ;;=
 ;;^DD(358.6,0,"IX","E",358.6,.01)
 ;;=
 ;;^DD(358.6,0,"NM","IMP/EXP PACKAGE INTERFACE")
 ;;=
 ;;^DD(358.6,0,"PT",358.2,.11)
 ;;=
 ;;^DD(358.6,0,"PT",358.5,.03)
 ;;=
 ;;^DD(358.6,0,"PT",358.6,.13)
 ;;=
 ;;^DD(358.6,0,"PT",358.93,.06)
 ;;=
 ;;^DD(358.6,0,"VRPK")
 ;;=IBD
 ;;^DD(358.6,.01,0)
 ;;=NAME^RF^^0;1^K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>40!($L(X)<3)!'(X'?1P.E) X
 ;;^DD(358.6,.01,1,0)
 ;;=^.1
 ;;^DD(358.6,.01,1,1,0)
 ;;=358.6^B
 ;;^DD(358.6,.01,1,1,1)
 ;;=S ^IBE(358.6,"B",$E(X,1,30),DA)=""
 ;;^DD(358.6,.01,1,1,2)
 ;;=K ^IBE(358.6,"B",$E(X,1,30),DA)
 ;;^DD(358.6,.01,1,2,0)
 ;;=358.6^E^MUMPS
 ;;^DD(358.6,.01,1,2,1)
 ;;=S ^IBE(358.6,"E",$E(X,$F(X," "),40),DA)=""
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
