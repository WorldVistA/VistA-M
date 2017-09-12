DG53134P ;ALB/CAW - Add Integration Name if needed
 ;;5.3;Registration;**134**;Aug 13, 1993
 ;
POST N DG
 S DG=$G(XPDQUES("POS01")) I $L(DG)>3 D
 .S DG1=$O(^VA(389.9,"AIVDT1",1,-DT)),DA=$O(^VA(389.9,"AIVDT1",1,DG1,0))
 .S DIE="^VA(389.9,",DR=17000_"///"_DG D ^DIE
 K DA,DIE,DR,DG,DG1 Q
