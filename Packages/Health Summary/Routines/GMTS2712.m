GMTS2712 ; SLC/JER - Environment check for GMTS*2.7*12
 ;;2.7;Health Summary;**12**;Feb 28, 1996
EN ; main
 W !,"** CHECKING DHCP ENVIRONMENT **",!
 I +$$VERSION^XPDUTL("TIU")'>0 D  Q
 . W !,"You MUST install TIU v1.0 first...Aborting Installation.",!
 . S XPDQUIT=1
 I +$O(^GMR(121,0)),(+$P($G(^TIU(8925.97,1,0)),U,2)'>0),(+$O(^TIU(8925,0))'>0) D  Q
 . W !,"You MUST Convert Progress Notes to TIU first...Aborting Installation.",!
 . S XPDQUIT=1
 W !,"Everything looks fine!",!
 Q
