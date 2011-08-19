IBECUSM ;DVAMC/RLM - TRICARE PHARMACY BILLING OPTIONS; 20-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,162,240,347**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
REV ; Reverse a claim already submitted to the Fiscal Intermediary.
 I '$P($G(^IBE(350.9,1,9)),"^",4) W !!,"Please note that your TRICARE Pharmacy billing interface is not running!",!
REVA N X K DIC S DIC=52,DIC("A")="Enter the RX# you wish to reverse: ",DIC(0)="AEQMN"
 W ! D DIC^PSODI(52,.DIC) S IBRX=+Y K DIC
 I Y<1!($D(DUOUT))!($D(DIRUT)) G REVQ
 W !!,"Prescription: ",$P(Y,"^",2),!,"     Patient: ",$$FILE^IBRXUTL(+Y,2,"E")
 ;
 ; - has this prescription been billed?
 K IBARR,IBCAN S (IBKEY,IBKEYS)=IBRX_";"
 F  S IBKEY=$O(^IBA(351.5,"B",IBKEY)) Q:$E(IBKEY,1,$L(IBKEYS))'=IBKEYS  S IBARR(IBKEY)=+$O(^(IBKEY,0))
 I '$D(IBARR) W !!,"This prescription has not yet been billed." G REVA
 ;
 ; - find all potential transactions
 D FINDC^IBECUSMU(.IBARR,1,.IBCAN)
 S IBKEY=$O(IBCAN("")) I IBKEY="" G REVA
 ;
 ; - there's just one
 I $O(IBCAN(IBKEY))="" S IBCHTRN=IBCAN(IBKEY) W !!,$S($P(IBKEY,";",2):"Refill #"_$P(IBKEY,";",2),1:"The original fill")," for this prescription can be cancelled." G OKAYC
 ;
 ; - more than 1; must select from the list
 W !!,"More than one fill for rx# ",$$FILE^IBRXUTL(IBRX,.01)," may be cancelled."
 S IBREF=$$SEL^IBECUSMU(.IBCAN)
 I IBREF<0 G REVQ
 ;
 S IBKEY=IBRX_";"_IBREF,IBCHTRN=IBCAN(IBKEY)
 ;
OKAYC ; - okay to cancel?
 S DIR("A")="Is it okay to cancel this prescription"
 S DIR(0)="Y" D ^DIR K DIR
 I 'Y!($D(DUOUT))!($D(DIRUT)) W !,"The claim reversal was NOT submitted." G REVQ
 ;
 ; - queue cancellation for submittal
 S ^IBA(351.5,"APOST",IBKEY)="REVERSE^^"_DUZ_"^"_IBCHTRN
 W !,"The claim reversal has been submitted."
REVQ K DIROUT,DIRUT,DTOUR,DUOUT,IBRX,IBARR,IBCAN,IBKEY,IBKEYS,IBCHTRN,IBREF
 Q
 ;
 ;
 ;
RESUB ; Resubmit a claim to the Fiscal Intermediary.
 I '$P($G(^IBE(350.9,1,9)),"^",4) W !!,"Please note that your TRICARE Pharmacy billing interface is not running!",!
RESUBA N X K DIC S DIC=52 S DIC(0)="AEQMN",DIC("A")="Enter the RX# you wish to resubmit: "
 W ! D DIC^PSODI(52,.DIC) S IBRX=+Y K DIC
 I Y<1!($D(DUOUT))!($D(DIRUT)) G RESUBQ
 S DFN=$$FILE^IBRXUTL(+Y,2)
 W !!,"Prescription: ",$$FILE^IBRXUTL(IBRX,.01),!,"     Patient: ",$P($G(^DPT(DFN,0)),"^")
 ;
 ; - find all potential transactions
 K IBBIL D FINDB^IBECUSMU(IBRX,1,.IBBIL)
 S IBKEY=$O(IBBIL("")) I IBKEY="" G RESUBA
 ;
 ; - there's just one
 I $O(IBBIL(IBKEY))="" W !!,$S($P(IBKEY,";",2):"Refill #"_$P(IBKEY,";",2),1:"The original fill")," for this prescription can be billed." G IBPSR
 ;
 ; - more than 1; must select from the list
 W !!,"More than one fill for rx# ",$$FILE^IBRXUTL(IBRX,.01)," may be billed."
 S IBREF=$$SEL^IBECUSMU(.IBBIL)
 I IBREF<0 G RESUBQ
 ;
 S IBKEY=IBRX_";"_IBREF
 ;
IBPSR ;Ask for the Product Selection Reason
 N DIR,DIE,DR,X,Y,DA
 S DIR("B")=$S($P($G(^IBA(351.5,+IBBIL(IBKEY),0)),"^",10):$P(^IBA(351.53,$P(^(0),"^",10),0),"^"),1:0)
 S DIR(0)="PO^351.53" D ^DIR I Y=-1 W !,"The prescription was NOT submitted for billing." G RESUBQ
 S DA=+$G(IBBIL(IBKEY)),DIE="^IBA(351.5,",DR=".10////"_(+Y) D ^DIE
 K DIR
OKAYB ; - okay to bill?
 S DIR("A")="Is it okay to bill this prescription"
 S DIR(0)="Y" D ^DIR
 I 'Y!($D(DUOUT))!($D(DIRUT)) W !,"The prescription was NOT submitted for billing." G RESUBQ
 ;
 D:'$D(PSOPAR) ^PSOLSET
 I '$D(PSOLAP) W !!,*7,"The label printer is not defined!",!,"The prescription has NOT been submitted for billing." G RESUBQ
 S ^IBA(351.5,"APOST",IBKEY)=PSOLAP_"^"_PSOSITE_"^"_DUZ_"^^"_$P($G(^IBA(351.5,+IBBIL(IBKEY),0)),"^",10)
 W !,"The prescription has been submitted for billing."
 ;
RESUBQ K DIROUT,DIRUT,DTOUR,DUOUT,IBRX,DFN,IBBIL,IBKEY,IBREF
 K PSOBAR0,PSOBAR1,PSOBARS,PSOCLC,PSOCNT,PSODIV,PSODTCUT
 K PSOLAP,PSOPAR,PSOPAR7,PSOPRPAS,PSOSITE
 Q
 ;
 ;
 ;
DREJ ; Delete an entry from the Reject (#351.52) file.
 I '$P($G(^IBE(350.9,1,9)),"^",4) W !!,"Please note that your TRICARE Pharmacy billing interface is not running!",!
DREJA N X K DIC S DIC=52 S DIC(0)="AEQMN",DIC("A")="Enter the RX# of the rejected transmission: "
 W ! D DIC^PSODI(52,.DIC) S IBRX=+Y K DIC
 I Y<1!($D(DUOUT))!($D(DIRUT)) G DREJQ
 W !!,"Prescription: ",$P(Y,"^",2),!,"     Patient: ",$$FILE^IBRXUTL(+Y,2,"E")
 ;
 ; - is there a reject entry for this prescription?
 K IBARR S (IBKEY,IBKEYS)=IBRX_";"
 F  S IBKEY=$O(^IBA(351.52,"B",IBKEY)) Q:$E(IBKEY,1,$L(IBKEYS))'=IBKEYS  S IBARR(IBKEY)=+$O(^(IBKEY,0))
 I '$D(IBARR) W !!,"There is no reject entry for this prescription." G DREJA
 ;
 ; - select the reject entry to delete
 S IBKEY=$O(IBARR("")) I IBKEY="" G DREJA
 I $O(IBARR(IBKEY))="" S IBCHREF=+IBARR(IBKEY) W !!,$S($P(IBKEY,";",2):"Refill #"_$P(IBKEY,";",2),1:"The original fill")," for this prescription has been rejected." G OKAYD
 ;
 ; - more than 1; must select from the list
 W !!,"More than one fill for rx# ",$$FILE^IBRXUTL(IBRX,.01)," has a reject entry."
 S IBREF=$$SEL^IBECUSMU(.IBARR)
 I IBREF<0 G DREJQ
 ;
 S IBKEY=IBRX_";"_IBREF,IBCHREF=+$G(IBARR(IBKEY))
 ;
OKAYD ; - okay to delete the reject?
 I '$D(^IBA(351.52,IBCHREF,0)) K ^IBA(351.52,"B",IBKEY) W !!,"Sorry, can't find a reject for this prescription!" G DREJQ
 S DIR("A")="Is it okay to delete this reject entry"
 S DIR(0)="Y" D ^DIR K DIR
 I 'Y!($D(DUOUT))!($D(DIRUT)) W !,"The reject entry was NOT deleted." G DREJQ
 ;
 ; - delete the entry
 S DA=IBCHREF,DIK="^IBA(351.52," D ^DIK K DA,DIK
 W !,"The reject entry has been deleted."
DREJQ K DIROUT,DIRUT,DTOUR,DUOUT,IBRX,IBARR,IBKEY,IBKEYS,IBCHREF,IBREF
 Q
