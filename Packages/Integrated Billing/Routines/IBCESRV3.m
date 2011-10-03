IBCESRV3 ;ALB/TMP - Server based Auto-update utilities - IB EDI ;03/05/96
 ;;2.0;INTEGRATED BILLING;**137,155,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; IA 4129 for call to DUZ^XUP
 Q
 ;
EOB835 ; Explanation of Benefits - auto update
 ; Input expected: IBTDA = the ien of the message entry in file 364.2
 ;
 ; This is the background task that is queued to run by TaskManager.
 ; This procedure is called via indirection in TRTN^IBCESRV1 which is
 ; called by ADD^IBCESRV.
 ;
 N IB0,IBBDA,IBBILL,IBMSG,IBFLAG,IBTYP,IBBST,DR,DA,DIE,Z,MRAUSER
 ;
 Q:'$G(IBTDA)
 S IB0=$G(^IBA(364.2,IBTDA,0)),IBBDA=+$P(IB0,U,4)  ; Batch ien
 S IBTYP=$P($G(^IBE(364.3,+$P(IB0,U,2),0)),U)      ; IB message type
 Q:IBTYP'="835EOB"
 ;
 ; The MRA Project is using a specific non-human user for all
 ; 835 EOB/MRA filing processes.  Change the DUZ to be this user.
 ; *** VA SACC approved this exemption 5-June-2003 ***
 ; *** Integration Agreement 4129 - Activated on 30-June-2003 ***
 ;
 S MRAUSER=$$MRAUSR^IBCEMU1()
 I MRAUSER>0,$$ISITMRA(IBTDA) NEW DUZ D DUZ^XUP(MRAUSER)
 ;
 D UPDEOB(IBTDA)
 ;
 Q
 ;
UPDEOB(IBTDA) ; Explanation of Benefits or MRA
 ;   Update data base from msg (store EOB in file 361.1)
 ; IBTDA = ien of message in file 364.2
 ;
 N IBBILL,PRCASV,DA,DIE,DR,DA,X,Y,IBFLAG,IB0,IBS
 N IBEOB,IBAUTO,IBIFN,IBERRMSG
 ;
 D UPDMSG^IBCESRV2(IBTDA,"U",0)    ; updating data in 364.2
 S IB0=$G(^IBA(364.2,IBTDA,0))
 ;
 I '$P(IB0,U,5) G UPDEOBX          ; no transmit bill# in file 364
 S IBEOB=$$UPDEOB^IBCEOB(IBTDA)    ; new entry in file 361.1
 I 'IBEOB G UPDEOBX                ;   exit if some failure
 ;
 ; update transmission status of transmission Bill# in file 364
 ;   status is closed (code "Z")
 D BILLSTAC^IBCESRV2($P(IB0,U,5),"Z") ;Upd indiv transmitted bill
 ;
 ; Delete the entry from file 364.2
 D DELMSG^IBCESRV2(IBTDA)
 ;
 ; If the EOB is not a Medicare MRA, then we can stop here
 I $P($G(^IBM(361.1,IBEOB,0)),U,4)'=1 G UPDEOBX
 ; 
 ; *** Medicare MRA processing ***
 ;
 ; update the claim MRA status of the file 399 bill
 ; to be "C" - Valid MRA received
 D MRASTAT(IBEOB,"C")
 ;
 ; Invoke the EOB criteria check and attempt to create and authorize
 ; the secondary bill
 S IBAUTO=$$CRIT^IBCEMQC(IBEOB)
 I 'IBAUTO D AUTOMSG(IBEOB,$P(IBAUTO,U,2)) G UPDEOBX
 S IBIFN=$P($G(^IBA(364,+$P(IB0,U,5),0)),U,1)   ; bill# from file 364
 ;
 ; Process COB, create secondary bill
 S IBERRMSG=""
 D AUTOCOB^IBCEMQA(IBIFN,IBEOB,.IBERRMSG)
 I IBERRMSG'="" D AUTOMSG(IBEOB,IBERRMSG) G UPDEOBX
 ;
 ; Authorize the secondary bill
 D AUTH^IBCEMQA(IBIFN,.IBERRMSG)
 I IBERRMSG'="" D AUTOMSG(IBEOB,IBERRMSG) G UPDEOBX
 ;
UPDEOBX ;
 S ZTREQ="@"
 Q
 ;
AUTOMSG(IBEOB,MSG) ; File the automatic bill generation failure message
 NEW DIE,DA,DR,D,D0,DI,DIC,DQ,X,Y
 S IBEOB=+$G(IBEOB),MSG=$G(MSG)
 I '$D(^IBM(361.1,IBEOB)) G AUMSGX
 I MSG="" G AUMSGX
 S DIE=361.1,DA=IBEOB,DR="30.01////"_MSG_";30.02////"_$$NOW^XLFDT
 D ^DIE
AUMSGX ;
 Q
 ;
MRASTAT(IBEOB,STAT) ; Update the claim MRA status field on the bill
 ; File 399, Field 24 - CLAIM MRA STATUS
 NEW DIE,DA,DR,D,D0,DI,DIC,DIG,DIH,DIU,DIV,DQ,X,Y,IBIFN
 S IBEOB=+$G(IBEOB),STAT=$G(STAT)
 I '$D(^IBM(361.1,IBEOB)) G MRASTX
 I STAT="" G MRASTX
 S IBIFN=+$P($G(^IBM(361.1,IBEOB,0)),U,1)
 I '$D(^DGCR(399,IBIFN,"TX")) G MRASTX
 ;
 S DIE=399,DA=IBIFN,DR="24////"_STAT
 D ^DIE
MRASTX ;
 Q
 ;
ISITMRA(IBTDA) ; Function to return whether or not this transmission
 ; is a Medicare MRA or a normal EOB
 NEW IEN,MRA,STOP,DATA
 S (IEN,MRA,STOP)=0
 F  S IEN=$O(^IBA(364.2,IBTDA,2,IEN)) Q:'IEN  D  Q:STOP
 . S DATA=$$EXT^IBCEMU1($G(^IBA(364.2,IBTDA,2,IEN,0))) Q:DATA=""
 . I $P(DATA,U,1)'="835EOB" Q
 . I $P(DATA,U,5)="Y" S MRA=1
 . S STOP=1
 . Q
ISMRAX ;
 Q MRA
 ;
