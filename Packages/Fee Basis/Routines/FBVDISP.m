FBVDISP ;AISC/CMR-VENDOR DISPLAY IDENTIFIERS - APR 9, 1993
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 N FBT,FBVC,FBZ S FBT(0)=$G(^FBAAV(Y,0)) Q:FBT(0)']""  F FBT=2,3,4,5,6,9,10,14 S FBT(FBT)=$P(FBT(0),U,FBT)
 S FBT(99)=$P($G(^FBAAV(Y,1)),U),FBT(98)=$P($G(^FBAAV(Y,"ADEL")),U)
 W:FBT(2)]"" ?40,FBT(2)
 W:FBT(10) "  CHAIN #: ",FBT(10)
 W:FBT(9)]"" "  ",$E($P($G(^FBAA(161.81,+FBT(9),0)),U),1,15)
 W:FBT(3)]"" !?10,FBT(3) D
 .S FBZ=$$CKVEN^FBAADV(+Y) I FBZ W:FBT(3)']"" ! W ?40,"(Awaiting Austin Approval)"
 .I FBT(98)="Y" W:FBT(3)']""!(FBZ) ! W ?40,"(Vendor in Delete Status)"
 W:FBT(14)]"" !?10,FBT(14)
 W:FBT(4)]"" !?10,FBT(4)
 W:FBT(5)]"" ", ",$P($G(^DIC(5,+FBT(5),0)),U,2)
 W:FBT(6)]"" "  ",FBT(6)
 W:FBT(99)]"" "    TEL. #:  ",FBT(99)
 W !?1
