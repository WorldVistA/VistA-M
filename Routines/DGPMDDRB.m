DGPMDDRB ;ALB/RMO - ROOM-BED FILE 405.4 DD CALLS; 7 JAN 90
 ;;5.3;Registration;;Aug 13, 1993
CK ;Check that no other Room-bed with this name is associated with
 ;this Ward. If one is found to exist do not allow this Ward to be added.
 S DGX=$S($D(^DG(405.4,DA(1),0)):$P(^(0),"^"),1:"") I DGX]"" F DGI=0:0 S DGI=$O(^DG(405.4,"B",DGX,DGI)) Q:'DGI  I $D(^DG(405.4,DGI,"W","B",X,X)) W !,"Ward is already associated with a Room-bed with this name!" K X Q
 K DGI,DGX Q
 ;
ID ;Write first five Wards Associated with Room-bed
 W !?10,"WARD(S): " S DGCNT=0 F DGI=0:0 S DGI=$O(^DG(405.4,+Y,"W",DGI)) Q:'DGI!(DGCNT=5)  I $D(^(DGI,0)),$D(^DIC(42,+^(0),0)) W:DGCNT ! W ?23,$P(^(0),"^") S DGCNT=DGCNT+1
 W:'DGCNT ?23,"NONE ASSIGNED"
 K DGCNT,DGI Q
