FBAACP1 ;AISC/CMR-C&P PAYMENT DRIVER ;7/17/2003
 ;;3.5;FEE BASIS;**4,61,116,108**;JAN 30, 1995;Build 115
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
FILE ;files sp multiple entry
 S DIE="^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,",DA(3)=DFN,DA(2)=FBV,DA(1)=FBSDI,DA=FBAACPI
 S TP="",DR="1///^S X=FBAAAMT;Q;2///^S X="_$S($G(FBDEN):0,1:FBAAAMT)_";I '$G(FBDEN) S Y=6;3//^S X=FBAAAMT;3.5///^S X=DT;@4;4;I X']"""" D SC^FBAACO3;S:X'=4 Y=6;22;6////^S X=DUZ;7////^S X=FBAABE"
 S DR=DR_";8////^S X=BO;13///^S X=FBAAID;14///^S X=FBAAIN;15///^S X=FBPT;23////^S X=2;33///^S X=FBAAVID;16////^S X=FBPOV;17///^S X=FBTT;18///^S X=FBAAPTC;26////^S X=FBPSA"
 S DR(1,162.03,1)="34///^S X=$G(FBAAMM1);28////^S X=FBHCFA(28);30///^S X=FBHCFA(30);31////^S X=FBHCFA(31);44///^S X=FBFSAMT;45////^S X=FBFSUSD;48///^S X=FBAARC;47///^S X=FBUNITS;54////^S X=FBCNTRP;S FBTST=1"
 D LOCK^FBUCUTL("^FBAAC(",DFN,1)
 D ^DIE
 I $G(FBTST) D
 . D FILERR^FBAAFR(FBAACPI_","_FBSDI_","_FBV_","_DFN_",",.FBRRMK)
 L -^FBAAC(DFN)
 I '$G(FBTST),$G(DA) S DIR(0)="YA",DIR("A")="Entering an '^' will delete "_$S($G(FBDEN):"denial",1:"payment")_".  Are you sure you want to delete? ",DIR("B")="No" D ^DIR K DIR G FILE:'$D(DIRUT)&('Y) D KILL^FBAACO2 Q
 S FBINTOT=FBINTOT+FBAAAMT
 ; HIPAA 5010 - count line items that have 0.00 amount paid
 ;I FBAAAMT>0 S Z1=$P(^FBAA(161.7,FBAABE,0),"^",11)+1,$P(^(0),"^",11)=Z1
 S Z1=$P(^FBAA(161.7,FBAABE,0),"^",11)+1,$P(^(0),"^",11)=Z1
 W !,$S($G(FBDEN):"Denial",1:"Payment")," Data Entered for Patient"
 K FBDEN,FBAAMM1,FBTST,DIE,DR,DA
 Q
 ;
PAID ;called from fbaacp to reset fee schedule if user opts to edit
 ;a service.  If fee schedule of new cpt_modifier=0 tell user
 ;not allowed in this option and refer to edit payment option.
 ;
