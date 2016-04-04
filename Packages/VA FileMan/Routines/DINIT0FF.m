DINIT0FF ;SFISC/MKO-DATA FOR FORM AND BLOCK FILES ;12DEC2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8,62,82**
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT0FG S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.404,.402011,40,11,21,0)
 ;;=^^5^5^3010402
 ;;^DIST(.404,.402011,40,11,21,1,0)
 ;;=Enter a valid MUMPS routine name of from 3 to 8 characters.  This must
 ;;^DIST(.404,.402011,40,11,21,2,0)
 ;;=be entered without a leading up-arrow, and cannot begin with "DI".
 ;;^DIST(.404,.402011,40,11,21,3,0)
 ;;=It must name a routine currently on the system.
 ;;^DIST(.404,.402011,40,11,21,4,0)
 ;;=This special lookup routine will be executed instead of the standard
 ;;^DIST(.404,.402011,40,11,21,5,0)
 ;;=FileMan lookup logic, whenever a call is made to ^DIC.
 ;;^DIST(.404,.402011,40,12,0)
 ;;=12^CROSS-REFERENCE ROUTINE^2^^CROSS-REFERENCE ROUTINE
 ;;^DIST(.404,.402011,40,12,2)
 ;;=17,26^6^17,1
 ;;^DIST(.404,.402011,40,12,3)
 ;;=!M
 ;;^DIST(.404,.402011,40,12,3.1)
 ;;=S Y=$G(^DD(DA,0,"DIK"))
 ;;^DIST(.404,.402011,40,12,14)
 ;;=I X?1"DI".E!(X'?3U.3NU),X]"" S DDSERROR=1
 ;;^DIST(.404,.402011,40,12,20)
 ;;=F
 ;;^DIST(.404,.402011,40,12,21,0)
 ;;=^^11^11^2981029
 ;;^DIST(.404,.402011,40,12,21,1,0)
 ;;=
 ;;^DIST(.404,.402011,40,12,21,2,0)
 ;;=Enter a valid MUMPS routine name of from 3 to 6 characters.  This must
 ;;^DIST(.404,.402011,40,12,21,3,0)
 ;;=be entered without a leading up-arrow, and cannot begin with "DI".
 ;;^DIST(.404,.402011,40,12,21,4,0)
 ;;=
 ;;^DIST(.404,.402011,40,12,21,5,0)
 ;;=This will become the namespace of the compiled routine(s).
 ;;^DIST(.404,.402011,40,12,21,6,0)
 ;;=
 ;;^DIST(.404,.402011,40,12,21,7,0)
 ;;=If a NEW routine name is entered, but the cross-references are not
 ;;^DIST(.404,.402011,40,12,21,8,0)
 ;;=compiled at this time, the routine name will be automatically deleted.
 ;;^DIST(.404,.402011,40,12,21,9,0)
 ;;=
 ;;^DIST(.404,.402011,40,12,21,10,0)
 ;;=If the routine name is deleted, the cross-references are considered
 ;;^DIST(.404,.402011,40,12,21,11,0)
 ;;=un-compiled, and FileMan will not use the routine for re-indexing.
 ;;^DIST(.404,.402011,40,13,0)
 ;;=1.8^DEVELOPER^3
 ;;^DIST(.404,.402011,40,13,1)
 ;;=20
 ;;^DIST(.404,.402011,40,13,2)
 ;;=5,36^35^5,25
 ;;^DIST(.404,.402011,40,15,0)
 ;;=1.2^Select APPLICATION GROUP^3
 ;;^DIST(.404,.402011,40,15,1)
 ;;=10
 ;;^DIST(.404,.402011,40,15,2)
 ;;=4,36^5^4,10
 ;;^DIST(.404,.402011,40,16,0)
 ;;=.1^^4^^NUMBER
 ;;^DIST(.404,.402011,40,16,2)
 ;;=3,49^18
 ;;^DIST(.404,.402011,40,16,30)
 ;;=S Y="(File # "_DA_")"
 ;;^DIST(.404,.402011,40,17,0)
 ;;=.2^FILE NAME^2^^NAME
 ;;^DIST(.404,.402011,40,17,2)
 ;;=2,12^45^2,1
 ;;^DIST(.404,.402011,40,17,3)
 ;;=!M
 ;;^DIST(.404,.402011,40,17,3.1)
 ;;=S Y=$P($G(^DIC(DA,0)),U)
 ;;^DIST(.404,.402011,40,17,13)
 ;;=I X="" S DDACT="EX"
 ;;^DIST(.404,.402011,40,17,20)
 ;;=F^^3:45
 ;;^DIST(.404,.402011,40,18,0)
 ;;=13^^4^^FORMERLY COMPILED AS
 ;;^DIST(.404,.402011,40,18,2)
 ;;=17,37^31
 ;;^DIST(.404,.402011,40,18,30)
 ;;=S Y="" I '$D(^DD(DA,0,"DIK")) S Y=$G(^("DIKOLD")) S:Y]"" Y="(formerly compiled as '"_Y_"')"
 ;;^DIST(.404,.403011,0)
 ;;=DDGF BLOCK EDIT 1^.4032
 ;;^DIST(.404,.403011,11)
 ;;=I $$GET^DDSVAL(DIE,.DA,3)="d" D UNED^DDSUTL("DISABLE NAVIGATION","DDGF BLOCK EDIT 2","",1)
 ;;^DIST(.404,.403011,40,0)
 ;;=^.4044I^10^8
 ;;^DIST(.404,.403011,40,1,0)
 ;;=1^ Block Properties Stored in FORM File ^1
 ;;^DIST(.404,.403011,40,1,2)
 ;;=^^1,20^1
 ;;^DIST(.404,.403011,40,2,0)
 ;;=3^BLOCK ORDER^3
 ;;^DIST(.404,.403011,40,2,1)
 ;;=1
 ;;^DIST(.404,.403011,40,2,2)
 ;;=3,69^4^3,56
 ;;^DIST(.404,.403011,40,2,4)
 ;;=1
 ;;^DIST(.404,.403011,40,3,0)
 ;;=4^TYPE OF BLOCK^3
 ;;^DIST(.404,.403011,40,3,1)
 ;;=3
 ;;^DIST(.404,.403011,40,3,2)
 ;;=4,18^7^4,3
 ;;^DIST(.404,.403011,40,3,4)
 ;;=1
 ;;^DIST(.404,.403011,40,3,13)
 ;;=D:X="d" PUT^DDSVAL(.404,$$GET^DDSVAL(DIE,.DA,.01),2,"") D UNED^DDSUTL("DISABLE NAVIGATION","DDGF BLOCK EDIT 2","",$E(1,X="d"))
 ;;^DIST(.404,.403011,40,5,0)
 ;;=6^POINTER LINK^3
 ;;^DIST(.404,.403011,40,5,1)
 ;;=4
 ;;^DIST(.404,.403011,40,5,2)
 ;;=6,18^57^6,4
 ;;^DIST(.404,.403011,40,6,0)
 ;;=2^BLOCK NAME^3
 ;;^DIST(.404,.403011,40,6,1)
 ;;=.01
 ;;^DIST(.404,.403011,40,6,2)
 ;;=3,18^30^3,6
 ;;^DIST(.404,.403011,40,8,0)
 ;;=7^PRE ACTION^3
 ;;^DIST(.404,.403011,40,8,1)
 ;;=11
 ;;^DIST(.404,.403011,40,8,2)
 ;;=7,18^57^7,6
 ;;^DIST(.404,.403011,40,9,0)
 ;;=9^POST ACTION^3
 ;;^DIST(.404,.403011,40,9,1)
 ;;=12
 ;;^DIST(.404,.403011,40,9,2)
 ;;=8,18^57^8,5
 ;;^DIST(.404,.403011,40,10,0)
 ;;=5^OTHER PARAMETERS...^2
 ;;^DIST(.404,.403011,40,10,2)
 ;;=4,69^1^4,49^1
 ;;^DIST(.404,.403011,40,10,7)
 ;;=^11
 ;;^DIST(.404,.403011,40,10,20)
 ;;=F^^0:0
 ;;^DIST(.404,.403011,40,10,21,0)
 ;;=^^1^1^2940928
 ;;^DIST(.404,.403011,40,10,21,1,0)
 ;;=Press <RET> to edit additional properties of the block
 ;;^DIST(.404,.403012,0)
 ;;=DDGF BLOCK EDIT 2^.404
 ;;^DIST(.404,.403012,40,0)
 ;;=^.4044I^7^7
 ;;^DIST(.404,.403012,40,1,0)
 ;;=1^----------------- Block Properties Stored in BLOCK File ------------------^1
 ;;^DIST(.404,.403012,40,1,2)
 ;;=^^1,2^1
 ;;^DIST(.404,.403012,40,2,0)
 ;;=2^NAME^2
 ;;^DIST(.404,.403012,40,2,2)
 ;;=3,16^30^3,10
 ;;^DIST(.404,.403012,40,2,3)
 ;;=!M
 ;;^DIST(.404,.403012,40,2,3.1)
 ;;=S Y=DDGFBKNO
 ;;^DIST(.404,.403012,40,2,20)
 ;;=DD^^.404,.01
 ;;^DIST(.404,.403012,40,2,23)
 ;;=S DDGFBKNN=X
 ;;^DIST(.404,.403012,40,3,0)
 ;;=3^DESCRIPTION (WP)^3
 ;;^DIST(.404,.403012,40,3,1)
 ;;=15
 ;;^DIST(.404,.403012,40,3,2)
 ;;=3,69^1^3,51
 ;;^DIST(.404,.403012,40,4,0)
 ;;=4^DD NUMBER^3
 ;;^DIST(.404,.403012,40,4,1)
 ;;=1
 ;;^DIST(.404,.403012,40,4,2)
 ;;=4,16^16^4,5
 ;;^DIST(.404,.403012,40,5,0)
 ;;=5^DISABLE NAVIGATION^3
 ;;^DIST(.404,.403012,40,5,1)
 ;;=2
 ;;^DIST(.404,.403012,40,5,2)
 ;;=4,69^5^4,49
 ;;^DIST(.404,.403012,40,6,0)
 ;;=6^PRE ACTION^3
 ;;^DIST(.404,.403012,40,6,1)
 ;;=11
 ;;^DIST(.404,.403012,40,6,2)
 ;;=6,16^59^6,4
 ;;^DIST(.404,.403012,40,7,0)
 ;;=7^POST ACTION^3
 ;;^DIST(.404,.403012,40,7,1)
 ;;=12
 ;;^DIST(.404,.403012,40,7,2)
 ;;=7,16^59^7,3
 ;;^DIST(.404,.403013,0)
 ;;=DDGF BLOCK EDIT OTHER^.4032
 ;;^DIST(.404,.403013,11)
 ;;=I $$GET^DDSVAL(DIE,.DA,"REPLICATION")<2 N DDGFZ F DDGFZ="INDEX","INITIAL POSITION","DISALLOW LAYGO","FIELD FOR SELECTION","ASK 'OK'","COMPUTED MULTIPLE","COMPUTED MUL PTR" D UNED^DDSUTL(DDGFZ,"","",1)
 ;;^DIST(.404,.403013,40,0)
 ;;=^.4044I^9^9
 ;;^DIST(.404,.403013,40,1,0)
 ;;=1^ Other Block Parameters ^1
 ;;^DIST(.404,.403013,40,1,2)
 ;;=^^1,16
 ;;^DIST(.404,.403013,40,2,0)
 ;;=2^BLOCK COORDINATE^2
 ;;^DIST(.404,.403013,40,2,2)
 ;;=3,24^7^3,6
 ;;^DIST(.404,.403013,40,2,3)
 ;;=!M
 ;;^DIST(.404,.403013,40,2,3.1)
 ;;=S Y=DDGFBKCO
 ;;^DIST(.404,.403013,40,2,4)
 ;;=1
 ;;^DIST(.404,.403013,40,2,20)
 ;;=DD^^.4032,2
 ;;^DIST(.404,.403013,40,2,23)
 ;;=S DDGFBKCN=X
