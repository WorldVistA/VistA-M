IBCNEUT2 ;DAOU/DAC - eIV MISC. UTILITIES ;06-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Can't be called from the top
 Q
 ;
SAVETQ(IEN,TDT) ;  Update service date in TQ record
 ;
 N DIE,DA,DR,D,D0,DI,DIC,DQ,X
 S DIE="^IBCN(365.1,",DA=IEN,DR=".12////"_TDT
 D ^DIE
 Q
 ;
 ;
SST(IEN,STAT) ;  Set the Transmission Queue Status
 ;  Input parameters
 ;    IEN = Internal entry number for the record
 ;    STAT= Status IEN
 ;
 NEW DIE,DA,DR,D,D0,DI,DIC,DQ,X
 ;
 I IEN="" Q
 ;
 S DIE="^IBCN(365.1,",DA=IEN,DR=".04////^S X=STAT;.15////^S X=$$NOW^XLFDT()"
 D ^DIE
 Q
 ;
RSP(IEN,STAT) ;  Set the Response File Status
 ;  Input parameters
 ;    IEN = Internal entry number for the record
 ;    STAT= Status IEN
 ;
 NEW DIE,DA,DR,D,D0,DI,DIC,DQ,X
 S DIE="^IBCN(365,",DA=IEN,DR=".06////^S X=STAT"
 D ^DIE
 Q
 ;
BUFF(BUFF,BNG) ;  Set error symbol into Buffer File
 ;  Input Parameter
 ;    BUFF = Buffer internal entry number
 ;    BNG = Buffer Symbol IEN
 I 'BUFF!'BNG Q
 NEW DIE,DA,DR,D,D0,DI,DIC,DQ,X,DISYS
 S DIE="^IBA(355.33,",DA=BUFF,DR=".12////^S X=BNG"
 D ^DIE
 Q
 ;
PAYR ;  Set up the '~NO PAYER' payer.  This procedure is called by both
 ;  the post-install routine and by the nightly batch extract routine.
 S DLAYGO=365.12,DIC(0)="L",DIC("P")=DLAYGO,DIC="^IBE(365.12,"
 S X="~NO PAYER" D ^DIC
 S DA=+Y
 S DR=".02////^S X=""00000""",DIE=DIC D ^DIE
 ;
 K DA,DIC,DLAYGO,X,Y,D1,DILN,DISYS,IDUZ,DIE,DR,D0,D,DI,DIERR,DQ
 Q
 ;
