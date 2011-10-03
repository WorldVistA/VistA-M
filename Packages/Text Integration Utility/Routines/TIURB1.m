TIURB1 ; SLC/JER - TIURB-associated subroutines ;9/12/00  11:52
 ;;1.0;TEXT INTEGRATION UTILITIES;**78**;Jun 20, 1997
DELPROB(TIUDA) ; Delete linked problems
 N DA,DIK S DIK="^TIU(8925.9,",DA=0
 F  S DA=$O(^TIU(8925.9,"B",TIUDA,DA)) Q:+DA'>0  D ^DIK
 Q
DELSGNR(TIUDA) ; Delete associated additional signers
 N DA,DIK S DIK="^TIU(8925.7,",DA=0
 F  S DA=$O(^TIU(8925.7,"B",TIUDA,DA)) Q:+DA'>0  D ^DIK
 Q
AUDEL(TIUDA,TIURSN) ; Audit deletions
 N DIC,DIE,DA,DR,X,Y
 S X=""""_"`"_TIUDA_"""",(DIC,DLAYGO)=8925.5,DIC(0)="FLX" D ^DIC Q:+Y'>0
 S DA=+Y
 S DIE=DIC,DR="2.01////"_$$NOW^TIULC_";2.02////"_DUZ_";2.03////"_TIURSN
 D ^DIE
 Q
AUDREASS(TIUDA,TIUD0,TIUD12) ; Audit reassignments
 N DIC,DIE,DA,DR,X,Y
 S X=""""_"`"_TIUDA_"""",(DIC,DLAYGO)=8925.5,DIC(0)="FLX" D ^DIC Q:+Y'>0
 S DA=+Y,DIE=DIC
 S DR="1.01////"_$$NOW^TIULC_";1.02////"_DUZ
 S DR=DR_";1.03////"_$P(TIUD0(0),U,2)_";1.05////"_$P(TIUD0(0),U,7)
 S DR=DR_";1.07////"_$S(+$P(TIUD12(0),U,11):$P(TIUD12(0),U,11),1:$P(TIUD12(0),U,5))
 S DR=DR_";1.09////"_$P(TIUD0(0),U,13)_";1.11////"_$P(TIUD0(0),U,3)
 D ^DIE
 S DR="1.04////"_$P(TIUD0(1),U,2)_";1.06////"_$P(TIUD0(1),U,7)
 S DR=DR_";1.08////"_$S(+$P(TIUD12(1),U,11):$P(TIUD12(1),U,11),1:$P(TIUD12(1),U,5))
 S DR=DR_";1.1////"_$P(TIUD0(1),U,13)_";1.12////"_$P(TIUD0(1),U,3)
 D ^DIE
 Q
LINK1 ; Link a single document to Problem(s)
 N DFN,GMPLUSER,GMPDFN,VADM,VA,VALMY
 S GMPLUSER=1
 S DFN=+$P($G(^TIU(8925,+TIUDA,0)),U,2)
 I +DFN D DEM^VADPT S GMPDFN=DFN_U_VADM(1)_U_$E(VADM(1))_VA("BID")
 D EN^VALM("TIU LINK TO PROBLEM")
 Q
PROBLEM ; Link selected document to problems
 N TIUI
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D
 . N DA,DIC,DIE,DLAYGO,DR,X,Y,TIUTYP,TIUPRBLM,TIUPROB,TIUPOV,TIUEXPR
 . N TIUPNARR,TIUDX
 . S TIUTYP=$P($G(^TIU(8925.1,+$G(^TIU(8925,+TIUDA,0)),0)),U)
 . S TIUPRBLM=$G(^TMP("TIURPIDX",$J,+TIUI)),TIUPROB=+$P(TIUPRBLM,U,2)
 . I +$$DUPROB(TIUDA,TIUPROB) D  Q
 . . W $C(7)
 . . W !!,$P(TIUPRBLM,U,5)," is already associated with this document.",!
 . . I $$READ^TIUU("EA","Press RETURN to continue...") W ""
 . S TIUPOV=$P(TIUPRBLM,U,3),TIUEXPR=+$P(TIUPRBLM,U,4)
 . S TIUPNARR=$P(TIUPRBLM,U,5),TIUDX=+$P(TIUPRBLM,U,6)
 . S X=""""_"`"_TIUDA_"""",(DIC,DLAYGO)=8925.9,DIC(0)="LX" D ^DIC Q:+Y'>0
 . S DIE=DIC,DR=".02////"_$G(TIUPROB)_";.03////"_$G(TIUPOV)_";.04////"_$G(TIUEXPR)_";.05////"_$G(TIUPNARR)_";.06////"_$G(TIUDX)
 . D ^DIE W !,TIUTYP," linked to ",TIUPNARR,"." H 2
 . S TIUCHNG=1 K VALMY(TIUI)
 Q
DUPROB(TIUDA,TIUPROB) ; Check whether document is already linked to problem
 N TIUI,TIUY S (TIUI,TIUY)=0
 F  S TIUI=$O(^TIU(8925.9,"B",TIUDA,TIUI)) Q:+TIUI'>0!+TIUY  D
 . I +$P($G(^TIU(8925.9,TIUI,0)),U,2)=+TIUPROB S TIUY=1
 Q +$G(TIUY)
