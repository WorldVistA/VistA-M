IBYOPOS1 ;ALB/TMP - IB*2*51 POST-INSTALL ;22-JAN-96
 ;;2.0;INTEGRATED BILLING;**51**;21-MAR-94
 ;
ADDFORMS ; Add the local forms for HCFA 1500 and UB92 if they don't 
 ;  already exist
 ; Sets up local forms as defaults for form prints
 ; HCFA 1500 and UB-92
 D MES^XPDUTL("Setting up local form defaults for bill forms.")
 N IB2,IBFORM,IBFORMNM,IBLOC,IBLOCN,IBTEXT,DO,DD,DIC,DIE,DINUM,DR,X,Y,Z,Z0,Z1
 ;
 F IBFORM=2,3 S Z=$P($G(^IBE(353,IBFORM,2)),U,8) D
 . K IBTEXT
 . I 'Z D
 .. S IBFORMNM=$S(IBFORM=2:"HCFA 1500",1:"UB-92")
 .. S IBLOCN="LOCAL "_IBFORMNM_" (AUTO-ADDED)"
 .. S IB2=$G(^IBE(353,IBFORM,2))
 .. S IBLOC=+$O(^IBE(353,"B",IBLOCN,0))
 .. I IBLOC D MES^XPDUTL("Form "_IBLOCN_" already exists - not added again")
 .. I 'IBLOC D
 ... F Z0=1:1:5 L +^IBE(353,0):1 Q:$T
 ... I '$T S IBTEXT(1)=" Problem adding local print form for "_IBFORMNM,IBTEXT(2)=" Please add this form manually" D ERRMSG^IBYOPOST(.IBTEXT) Q
 ... D MES^XPDUTL("Adding form '"_IBLOCN_"' to form file.")
 ... S Z1=$O(^IBE(353,"A"),-1) I Z1<10000 S Z1=9999
 ... S Z1=Z1+1,DINUM=Z1,DLAYGO=353,DIC="^IBE(353,",DIC(0)="L",X=IBLOCN
 ... S DIC("DR")="2.01////399;2.02////P;2.03////"_$P(IB2,U,3)_";2.04////0;2.05////"_IBFORM_";2.06////"_IBLOCN
 ... D FILE^DICN K DO,DD,DIC,DLAYGO,DINUM
 ... L -^IBE(353,0)
 ... I Y<0 S IBTEXT(1)=" Problem adding local print form for "_IBFORMNM,IBTEXT(2)=" Please add the form manually using the output formatter" D ERRMSG^IBYOPOST(.IBTEXT) Q
 ... S IBLOC=+Y
 .. ;
 .. D MES^XPDUTL("Updating "_IBFORMNM_"'s PRINT FORM field with "_IBLOCN_".")
 .. S DIE="^IBE(353,",DA=IBFORM,DR="2.08////"_IBLOC D ^DIE
 .. I '$P($G(^IBE(353,IBFORM,2)),U,8) S IBTEXT(1)=" Problem updating "_IBFORMNM_"'s PRINT FORM data",IBTEXT(2)=" Please update this form definition manually so your bills print correctly" D ERRMSG^IBYOPOST(.IBTEXT) Q
 ;
 S Z=8 F  S Z=$O(^IBE(Z)) Q:'Z  I $P($G(^IBE(353,Z,2)),U,2)="S" D
 . S DR="2.05////"_Z,DIE="^IBE(353,",DA=Z D ^DIE
 D COMPLETE^IBYOPOST
 ;
 D BMES^XPDUTL("Post install complete.")
 Q
 ;
