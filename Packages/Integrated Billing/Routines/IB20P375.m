IB20P375 ;ALB/CXW - IB*2.0*375 POST INIT ;14-MAY-07
 ;;2.0;INTEGRATED BILLING;**375**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; 
 ;1) Update the transmission status with "X" for MRA 2nd bills in 
 ;   field/file (.03/364) based on these criteria:
 ;          bill authorized but not transmitted in field/file (.13/399)
 ;          bill has at least one Medicare MRA in field/file (.04/361.1)
 ;          bill has been passed to AR & generated in file (430)
 ;          bill's status is active in field/file (8/430)
 ;          bill has no total amount collected in field/file (15/433)
 ;          bill exists in file (364) for EDI transmission
 ;          bill has no batch # associated in field/file (.02/364)
 ;          bill is not ready for extract in field/file (.03/364)
 ;          bill's COB Sequence is Secondary in field/file (.08/364)
 ;
 ;2) Update the CLAM MRA STATUS with VALID MRA RECEIVED in field/file
 ;   (24/399) if bill has at least one Medicare MRA, otherwise store
 ;   NO MRA NEEDED status.
 ;
 ;3) List of all claims excludes ACTIVE AR status with 0 total amount
 ;   collected.
 ;
 ;Output-XTMP("IB20P375",0)=purge date_U_today_U_patch # 
 ;                       1,0)=update transmit status_U_total bills
 ;                       IEN)=IBIFN_U_Bill #_U_statement covers from dt  
 ;                       2,0)=list of claims_U_total bills
 ;                     IBIFN)=IBIFN_U_Bill #_U_IEN AR status_U_AR total
 ;                            amount collected
 ;                      
 ;                      
 ;          
 ;Not delete XTMP file until 30 days from now 
 Q
POST ;
START D MES^XPDUTL("** ALL RECORDS ARE IN ^XTMP(""IB20P375"") WHEN THE PROCESS HAS BEEN COMPLETED **")
 D MES^XPDUTL(" >>  Starting the Post init routine ...")
 ;
 N ARACT,ARAMT,IB375,IBIFN,IBMRA,IBILL,IBAR,IBCDT,IBDA,IBST,IBEDI,IBCT1,IBCT2,U,X,X1,X2,DA,DIE,DR
 S U="^",IB375="IB20P375",(IBCT1,IBCT2)=0
 K ^XTMP(IB375)
 S DT=$$DT^XLFDT,X1=DT,X2=30 D C^%DTC
 S ^XTMP(IB375,0)=X_U_DT_U_"IB*2.0*375 POST-INIT"
 S ^XTMP(IB375,1,0)="Updating the transmit status in file 364 for MRA secondary claim"
 S ^XTMP(IB375,2,0)="List of all claims excludes ACTIVE AR Status with 0 Total Amount Collected"
 ;
 S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"AST",3,IBIFN)) Q:'IBIFN  D
 . S IBMRA=$$MRACNT^IBCEMU1(IBIFN),IBILL=$P($G(^DGCR(399,IBIFN,0)),U),IBAR=$$BILL^RCJIBFN2(IBIFN),IBCDT=$P($G(^DGCR(399,IBIFN,"U")),U,1),ARACT=$P(IBAR,U,2),ARAMT=$P(IBAR,U,4)
 . ;update CLAIM MRA STATUS 
 . I +$P($G(^DGCR(399,IBIFN,"TX")),U,5) D
 .. N IBMST,DIE,DA,DR S IBMST=0  ; assume no MRA needed
 .. S:IBMRA IBMST="C"  ;Medicare MRA on file
 .. S DIE=399,DA=IBIFN,DR="24///"_IBMST
 .. D ^DIE
 . ;quit if bill no Medicare MRA 
 . Q:'IBMRA
 . I ARACT'=16!ARAMT D  ;no active status or total amt collected do list
 .. S ^XTMP(IB375,2,IBIFN)=IBIFN_U_IBILL_U_ARACT_U_ARAMT
 .. S IBCT2=IBCT2+1
 .. ; 
 . I ARACT=16,'ARAMT D  ;active status & no total amt collected
 .. S IBDA=0 F  S IBDA=$O(^IBA(364,"B",IBIFN,IBDA)) Q:'IBDA  D
 ... S IBEDI=$G(^IBA(364,IBDA,0)),IBST=$P(IBEDI,U,3)
 ... ;
 ... ;quit if batch # exists or ready for extract status or primary sequence
 ... I $P(IBEDI,U,2)!(IBST="X")!($P(IBEDI,U,8)'="S") Q
 ... N DA,DIE,DR
 ... S DIE=364,DA=IBDA,DR=".03////X;.04///NOW" D ^DIE
 ... S ^XTMP(IB375,1,IBDA)=IBIFN_U_IBILL_U_IBCDT,IBCT1=IBCT1+1
 S $P(^XTMP(IB375,1,0),U,2)=IBCT1,$P(^XTMP(IB375,2,0),U,2)=IBCT2
NOPRINT ;
 I 'IBCT1,'IBCT2 D  G END
 . D BMES^XPDUTL(" No claims met criteria, no transmit status update, no list of claims")
PRINT1 ;
 D BMES^XPDUTL($P(^XTMP(IB375,1,0),U))
 S IBDA=0
 F  S IBDA=$O(^XTMP(IB375,1,IBDA)) Q:'IBDA  S IBEDI=$G(^(IBDA)) D
 . D MES^XPDUTL(" Bill #: "_$P(IBEDI,U,2)_"  Statement Covers From Date: "_$$FMTE^XLFDT($P(IBEDI,U,3))_"  Transmit Status: X")
 D MES^XPDUTL("Total "_$S(IBCT1=1:IBCT1_" bill has",1:IBCT1_" bills have")_" been updated.")
PRINT2 ;
 D BMES^XPDUTL($P(^XTMP(IB375,2,0),U))
 S IBDA=0
 F  S IBDA=$O(^XTMP(IB375,2,IBDA)) Q:'IBDA  S IBEDI=$G(^(IBDA)) D
 . D MES^XPDUTL(" Bill #: "_$P(IBEDI,U,2)_"  AR Status: "_$P($G(^PRCA(430.3,+$P(IBEDI,U,3),0)),U)_"  Total Amount Collected: $"_$J($P(IBEDI,U,4),0,2))
 D MES^XPDUTL("Total "_$S(IBCT2=1:IBCT2_" bill has",1:IBCT2_" bills have")_" been listed.")
 ;
END D BMES^XPDUTL(" >>  End of the Post init routine ...")
 Q
 ;
