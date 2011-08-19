IBCREE ;ALB/ARH - RATES: CM ENTER/EDIT ;16-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,115,223**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EDITRT ; ACTION enter/edit rate types (399.3)
 N DIC,DIE,DA,DR,X,Y,IBRTFN
 W !!,"CAUTION:  This is a standard file with entries released nationally, do not add or"
 W !,"          modify unless necessary.  Changing the Name or AR Category or if it is"
 W !,"          a Third Party rate type will effect processing of claims."
 W !!,"Enter/Edit a Rate Type:"
 ;
 S DIC="^DGCR(399.3,",DIC(0)="AELNQ" D ^DIC K DIC I Y<1 K X,Y Q
 ;
 S IBRTFN=+Y I $D(IBRTFNX) S IBRTFNX=+Y
 ;
 S DIE="^DGCR(399.3,",DA=+IBRTFN,DR=".01;.02;.04;.05;.08;.09;.03;.06" D ^DIE K DIE,DA,DR,X,Y
 Q
 ;
EDITRS ; ACTION enter/edit rate schedules (363)
 N DIC,DIE,DA,DR,X,Y,DINUM,DLAYGO,IBRSFN
 W !!,"The Rate Schedule Adjustment is an M code field, it therefore requires"
 W !,"programmer access to enter or edit (using Charge Master IRM Enter/Edit"
 W !,"[IBCR CHARGE MASTER IRM] option. Contact IRM if this field needs to be modified."
 W !!,"Enter/Edit a Rate Schedule:"
 ;
 S DINUM=$O(^IBE(363,"A"),-1),DINUM=$S(DINUM<1000:1001,1:DINUM+1) I 'DINUM!($D(^IBE(363,DINUM,0))) Q
 S DLAYGO=363,DIC="^IBE(363,",DIC(0)="AELNQ" D ^DIC K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 ;
 S IBRSFN=+Y I $D(IBRSFNX) S IBRSFNX=+Y
 ;
 S DIE("NO^")="BACK"
 S DIDEL=363,DIE="^IBE(363,",DA=+IBRSFN,DR=".01;.02;.03;.04;.05;.06;11" D ^DIE K DIE,DA,DR,X,Y,DIDEL
 Q
 ;
EDITRSA ; OPTION enter/edit Rate Schedule Adjustment field (363,10) if DUZ="@"
 N IBRS10,IBRS10A,DIR,DIC,DIE,DA,DR,X,Y,IBRSFN
 I DUZ(0)'="@" W !,"This option requires programmer access (DUZ(0)=@).",! G ERSA1Q
 ;
 S DIC="^IBE(363,",DIC(0)="AENQ" D ^DIC K DIC S IBRSFN=+Y I Y<1 K X,Y Q
 ;
ERSA1 W !
 S IBRS10=$G(^IBE(363,+IBRSFN,10))
 I IBRS10="" W !,?7,"The base unit charges are not currently Adjusted.",!
 I IBRS10'="" S X=100 X IBRS10 W !,?7,"If the base unit charge is $100,",!,?7,"this Adjustment will result in a charge of: $",$J(X,10,2),!!
 S DIE="^IBE(363,",DA=+IBRSFN,DR="10" D ^DIE K DIE,DA,DR,X,Y
 S IBRS10A=$G(^IBE(363,+IBRSFN,10))
 I IBRS10A=IBRS10 W "  ... no change"
 I IBRS10A="" W !!,?7,"The base unit charges will not be modified."
 S X=100 X IBRS10A W !!,?7,"If the base unit charge is $100,",!,?7,"this Adjustment will result in a charge of: $",$J(X,10,2),!
 S DIR("?")="To Exit the option the correct Adjustment must be entered, i.e. must be able to enter Yes to this question.",DIR("?",1)="Enter either 'Y' or 'N'.",DIR("?",2)=" "
 S DIR("?",3)="The Adjustment has an immediate effect on the charges for this rate."
 S DIR(0)="Y",DIR("A")="Is this correct" D ^DIR K DIR I Y'=1 G ERSA1
 ;
 I $P($G(^DGCR(399.1,+$P(^IBE(363,+IBRSFN,0),"^",4),0)),"^")="PRESCRIPTION",IBRS10A["+" D
 . W !,"The adjustment you entered may have included a dispensing fee or administrative"
 . W !,"fee.  If that is the case, please record the amount of the respective fee(s)"
 . W !,"used in the adjustment calculation above."
 . S DIE="^IBE(363,",DA=+IBRSFN,DR="1.01;1.02" D ^DIE
 ;
ERSA1Q Q
 ;
EDITRG ; enter/edit billing regions (363.31)
 N DIC,DIE,DA,DR,X,Y,DLAYGO,IBRGFN,IBI
 W !!,"Enter/Edit a Rate's Billing Regions:"
 ;
 S DLAYGO=363.31,DIC="^IBE(363.31,",DIC(0)="AELNQ" D ^DIC K DIC,DLAYGO I Y<1 K X,Y Q
 ;
 S IBRGFN=+Y D RESETDV^IBCREE2($P(Y,U,2))
 ;
 ; dr to only allow divisions or institutions not both
 S DIDEL=363.31,DIE="^IBE(363.31,",DA=+IBRGFN,DR=".01;"_$S($O(^IBE(363.31,DA,21,0)):"",1:"11;S:$O(^IBE(363.31,DA,11,0)) Y=0;")_"21" D ^DIE K DIE,DR,X,Y,DIDEL
 ;
 I '$D(DA),+IBRGFN S IBI=0 F  S IBI=$O(^IBE(363.1,IBI)) Q:'IBI  D  ; remove deleted regions from charge sets
 . I +$P($G(^IBE(363.1,IBI,0)),U,7)=+IBRGFN S DIE="^IBE(363.1,",DA=+IBI,DR=".07///@" D ^DIE K DIE,DA,DR,X,Y
 Q
 ;
EDITBR ; enter/edit billing rates (363.3)
 N DIC,DIE,DA,DR,X,Y,DINUM,DLAYGO,IBX,IBBRFN
 W !!,"Enter/Edit a Billing Rate: "
 ;
 S DINUM=$O(^IBE(363.3,"A"),-1),DINUM=$S(DINUM<1000:1001,1:DINUM+1) I 'DINUM!($D(^IBE(363.3,DINUM,0))) Q
 S DLAYGO=363.3,DIC="^IBE(363.3,",DIC(0)="AELNQ" D ^DIC K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 ;
 S IBBRFN=+Y
 ;
 S DIE("NO^")="BACK"
 S DR=".01;.02;.03////2;.05;I X=2 S Y=""@6"";.04;@6" ; VA Cost sets should not have a billable item
 ;
 S IBX=$$CHKBR^IBCREU1(+Y) I +IBX S DR=".02" D  W !!
 . W !!,"Only the Abbreviation may be edited, the Billing Rate Definition can not change:"
 . I +$P(IBX,U,2) W !,"     -  this Billing Rate definition was exported Nationally"
 . I +$P(IBX,U,3) W !,"     -  there are Charge Sets defined for this Billing Rate"
 . I +$P(IBX,U,4) W !,"     -  there are Charge Items defined for a Charge Set with this Billing Rate"
 I '$P(IBX,U,3) W !,"This Billing Rate does not have any Charge Sets assigned.",!
 ;
 S DIDEL=363.3,DIE="^IBE(363.3,",DA=+IBBRFN D ^DIE K DIE,DA,DR,X,Y,DIDEL
 Q
 ;
EDITCS ; enter/edit Charge Sets (363.1)
 N DIC,DIE,DA,DR,X,Y,DINUM,DLAYGO,IBX,IBCSFN
 W !!,"Enter/Edit a Charge Set:"
 ;
 S DINUM=$O(^IBE(363.1,"A"),-1),DINUM=$S(DINUM<1000:1001,1:DINUM+1) I 'DINUM!($D(^IBE(363.1,DINUM,0))) Q
 S DLAYGO=363.1,DIC="^IBE(363.1,",DIC(0)="AELNQ" D ^DIC K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 ;
 S IBCSFN=+Y I $D(IBCSFNX) S IBCSFNX=+Y
 I IBCSFN<1000 D RESETDV^IBCREE2($P(Y,U,2))
 ;
 S DR=".01;.02;.03;.04;.05;.06;.07"
 S IBX=$$CHKCS^IBCREU1(+Y) I +IBX S DR=".04;.05;.06;.07" D  W !!
 . W !!,"Not all elements of this Charge Set may be edited:"
 . I +$P(IBX,U,3) D  Q
 .. W !,"     -  the Set name, Rate, and Billable Event may not be modified since this",!,"        Charge Set definition was exported nationally."
 . I +$P(IBX,U,2) D  S DR=".01;.03;"_DR
 .. W !,"     -  the Billing Rate may not change since the Charge Set has Charge Items."
 ;
 ;
REDTCS S DIDEL=363.1,DIE="^IBE(363.1,",DA=+IBCSFN D ^DIE K DIE,DR,X,DIDEL
 ;
 I $D(DA),$D(Y)=0 S IBX=$$RQCS^IBCREU1(IBCSFN) I +IBX S DR="" W ! D  G REDTCS
 . I $P(IBX,U,2)=1 W !,"The Charge Set requires a Billing Rate.",! S DR=DR_".02;"
 . I $P(IBX,U,3)=1 W !,"The Charge Set requires a Billable Event.",! S DR=DR_".03;"
 . I $P(IBX,U,5) D  S DR=DR_".05;"
 .. W !,"This Charge Set requires a default Revenue Code:"
 .. W !,"     - A VA Cost Charge Set requires a default Rev Code since there are no"
 .. W !,"       Items to assign the rev code to",!
 . I $P(IBX,U,4) D  S DR=DR_".06;"
 .. W !,"This Charge Set requires a default bedsection:"
 .. W !,"     - a bedsection is required before a charge can be added to a bill"
 .. W !,"       therefore a default bedsection is required for every Charge Set whose"
 .. W !,"       charge item is not bedsection",!
 ;
 Q
 ;
EDITBI ; enter/edit billing items - NDC #, MISC (363.21)
 N DIC,DIE,DIR,DA,DR,X,Y,DLAYGO,IBX,IBBIN,IBTYPE
 W !!,"These are items that are billable but not found in other DHCP source files."
 W !,"Items entered that already exist and have no associated charge, can be deleted.",!
 ;
 S DIR(0)="363.21,.02A",DIR("A")="Enter which type of Billable Item? " D ^DIR K DIR I Y<1 Q
 S IBTYPE=+Y_U_Y(0)
 ;
EBI1 W !
 ;
 S DLAYGO=363.21,DIC="^IBA(363.21,",DIC(0)="AELQ",DIC("A")=$P(IBTYPE,U,2)_" Item: ",DIC("DR")=".02////"_+IBTYPE
 S DIC("S")="I $P(^(0),U,2)="_+IBTYPE D ^DIC K DIC,DIE,DA,DR,DLAYGO I Y<1 K X,Y Q
 S IBBIN=Y
 ;
 I +IBTYPE=1,+$P(IBBIN,U,3),$P(IBBIN,U,2)'?1N.N1"-"1N.N1"-"1N.N D  G EBI1
 . I $$DELBI(+IBBIN) W !," ... not added, invalid format (n-n-n)"
 ;
 I +$P(IBBIN,U,3) W " ... added" G EBI1
 ;
 I '$P(IBBIN,U,3) W " ... already exists" D  G EBI1
 . S IBX=+IBBIN_";IBA(363.21," I $O(^IBA(363.2,"B",IBX,0)) W " => can not delete, has Charge Items" Q
 . S DIR(0)="Y",DIR("A")="      DELETE "_$P(IBTYPE,U,2)_" - "_$P(IBBIN,U,2) D ^DIR K DIR I Y'=1 W ?50," ... no change" Q
 . I Y=1 I $$DELBI(+IBBIN) W ?50," ... deleted"
 G EBI1
 Q
DELBI(DA) ;
 N IBX,DIK S IBX=0 I $D(^IBA(363.21,+$G(DA),0)) S DIK="^IBA(363.21," D ^DIK K DA,DIK S IBX=1
 Q IBX
