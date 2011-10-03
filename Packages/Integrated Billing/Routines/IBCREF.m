IBCREF ;ALB/ARH - RATES: CM FILE ENTRIES (CI,BI) ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,138,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
ADDCI(CS,ITEM,EFDT,CHG,RVCD,MOD,INAC,BASE) ; adds new charge item entries, does not check for duplicates or zero charge
 ; Input:  CS, ITEM, EFDT are required, rest will be set if they have values
 ; Output: IFN of new entry
 ;
 N IBCS0,IBCI,IBEFDT,IBBI,IBFILE,DIC,DIE,DA,D0,DLAYGO,DR,X,Y S IBCI=0 I '$G(ITEM) G ADDCIQ
 S IBCS0=$G(^IBE(363.1,+$G(CS),0)) I IBCS0="" G ADDCIQ
 S IBEFDT=$G(EFDT)\1 I IBEFDT'?7N G ADDCIQ
 ;
 S IBBI=$P($$CSBR^IBCRU3(CS),U,4) I 'IBBI G ADDCIQ
 S IBFILE=$P($$BIFILE^IBCRU2(IBBI),U,1) I IBFILE="" G ADDCIQ
 I '$$ITFILE^IBCRU2(IBBI,ITEM,IBEFDT) G ADDCIQ
 ;
 S DIC("DR")=".02////"_CS_";.03////"_IBEFDT
 K DD,DO S DLAYGO=363.2,DIC="^IBA(363.2,",DIC(0)="L",X=+ITEM_IBFILE
 D FILE^DICN K DIC,DLAYGO,X I Y<1 G ADDCIQ
 ;
 S IBCI=+Y D EDITCI(IBCI,$G(CHG),$G(RVCD),$G(MOD),$G(INAC),$G(BASE))
 ;
ADDCIQ Q IBCI
 ;
EDITCI(CI,CHG,RVCD,MOD,INAC,BASE) ; edit certain fields of a charge item
 ;
 N DIC,DIE,DA,D0,DR,X,Y S DR=""
 S:$G(INAC)'="" DR=".04////"_INAC_";" S:$G(CHG)'="" DR=DR_".05////"_+$FN(CHG,"",2)_";" S:$G(BASE)'="" DR=DR_".08////"_+$FN(BASE,"",2)_";"
 S:$G(RVCD)'="" DR=DR_".06////"_RVCD_";" S:$G(MOD)'="" DR=DR_".07////"_MOD
 I DR'="",+$G(CI),$G(^IBA(363.2,+CI,0))'="" S DIE="^IBA(363.2,",DA=+CI D ^DIE
 Q
 ;
ADDBI(TYPE,NAME,DUP) ; add a new Billing Item entry (363.21), check for duplicates optional
 ; Input:  TYPE - data type (363.21,.02), NAME - billing item name, DUP - 1 if add without duplicate check
 ; Output: 0 - not added, BI IFN ^ 0 - already exists, BI IFN ^ 1 - new entry added
 N IBX,IBTYPE,IBBI,DIC,DIE,DA,D0,DLAYGO,DR,X,Y S IBBI=0
 ;
 S IBTYPE=$G(TYPE),IBTYPE=$S(IBTYPE["NDC":1,IBTYPE["MISCELLANEOUS":9,1:IBTYPE) I 'IBTYPE!($G(NAME)="") G ADDBIQ
 I IBTYPE=1,NAME'?1N.N1"-"1N.N1"-"1N.N G ADDBIQ
 I '$G(DUP) S IBX=$$FNDBI^IBCRU2(IBTYPE,NAME) I +IBX S IBBI=+IBX_U_0 G ADDBIQ
 ;
 S DIC("DR")=".02////"_IBTYPE
 K DD,DO S DLAYGO=363.21,DIC="^IBA(363.21,",DIC(0)="L",X=NAME D FILE^DICN K DIC,DLAYGO,X I Y<1 G ADDCIQ
 S IBBI=+Y_U_1
ADDBIQ Q IBBI
