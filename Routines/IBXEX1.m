IBXEX1 ; ;10/25/02
 S X=DG(DQ),DIC=DIE
 S ^IBA(354.1,"AA",$E(X,1,30),DA)=""
 S X=DG(DQ),DIC=DIE
 N IBX S IBX=^IBA(354.1,DA,0) I +X,$P(IBX,U,2),$P(IBX,U,3),$P(IBX,U,4)'="" S ^IBA(354.1,"AIVDT",+$P(IBX,U,3),+$P(IBX,U,2),-($P(IBX,U)),DA)=""
 S X=DG(DQ),DIC=DIE
 I X,+$P(^IBA(354.1,DA,0),U,2),+$P(^(0),U,3),+^(0) S ^IBA(354.1,"ACY",+$P(^(0),U,3),+$P(^(0),U,2),+$E($P(^(0),U),1,3),DA)=""
