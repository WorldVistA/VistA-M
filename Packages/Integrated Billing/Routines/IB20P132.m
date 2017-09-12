IB20P132 ;ALB/BGA - IB V2.0 POST INIT, RESOLVE POINTERS ; 08-15-2000
 ;;2.0;INTEGRATED BILLING;**132**; 21-MAR-94
 ;
 ; Post Init Description: This init will resolve the pointer issues
 ;  for the new entries required in 350.2 and the update need in
 ;  file 399.1. This post init is associated with path *132*.
 ;
 ; Resolve Pointer-- Control Logic
 D NEWAT   ; Added new entries to 350.1
 D ATSE    ; Resolve ptrs to #49 from #350.1
 D ATAT    ; Resolve ptrs to #350.1 from #350.1
 D ATUT    ; Resolve ptrs to #350.1 from #399.1
 D ARNB    ; Added new MST entry to #356.8 
 D LAST    ; End task
 Q
 ;
 ;
NEWAT ; Add new IB Action Types into file #350.1
 D BMES^XPDUTL(">>> Adding new IB Action Types into file #350.1")
 F IBI=1:1 S IBCR=$P($T(NAT+IBI),";;",2) Q:IBCR="QUIT"  D
 .S X=$P(IBCR,"^")
 .I $O(^IBE(350.1,"B",X,0)) D BMES^XPDUTL(" >> '"_X_"' is already on file.") Q 
 .K DD,DO S DIC="^IBE(350.1,",DIC(0)="" D FILE^DICN Q:Y<0
 .S ^(0)=^IBE(350.1,+Y,0)_"^"_$P(IBCR,"^",2,11) S DIK=DIC,DA=+Y D IX1^DIK
 .D BMES^XPDUTL(" >> '"_$P(IBCR,"^")_"' has been filed.")
 .I $P(IBCR,"^",12)'="" S ^IBE(350.1,+DA,20)=$P(IBCR,"^",12)
 ; set the description for FEE OUTPATIENT node 20
 I $O(^IBE(350.1,"B","DG FEE SERVICE (OPT) NEW",0)) S Z=$O(^(0)) D
 . S ^IBE(350.1,+Z,20)="S IBDESC=""FEE OPT COPAYMENT"""
 K DA,DIC,DIE,DIK,DR,IBI,IBCR,X,Y,Z
 Q
 ;
 ;
NAT ; Action Types to add into file #350.1          
 ;;DG OBSERVATION COPAY NEW^OBS CO^^^1^^^OBSERVATION CARE COPAY^^1^4^S IBDESC="OBS DISCHARGE COPAY"
 ;;DG OBSERVATION COPAY CANCEL^CAN OBS^^^2
 ;;DG OBSERVATION COPAY UPDATE^UPD OBS^^^3^^^^^1^4
 ;;QUIT
 ;
 ;
ATSE ; Resolve pointers to file #49 from file #350.1
 D BMES^XPDUTL(">>> Updating pointers to file #49 from file #350.1.")
 S IBSERV=$P($G(^IBE(350.9,1,1)),"^",14)
 I 'IBSERV D  G ATSEQ
 .D BMES^XPDUTL("You must define MAS as a service in your IB Site Parameter file before you")
 .D BMES^XPDUTL("can update the IB Action Type file!  Please perform this action after")
 .D BMES^XPDUTL("installing this software.")
 ;
 ; - update both service and AR category
 F IBI=1:1 S IBX=$P($T(DATA+IBI),";;",2,99) Q:IBX=""  D
 .S IBATYP=$O(^IBE(350.1,"B",$P(IBX,"^"),0)) Q:'IBATYP
 .S IBARTYP=$O(^PRCA(430.2,"B",$P(IBX,"^",3),0)) Q:'IBARTYP
 .S $P(^IBE(350.1,IBATYP,0),"^",3)=IBARTYP
 .S DIE="^IBE(350.1,",DA=IBATYP,DR=".04////"_IBSERV
 .D ^DIE K DIC,DIE,DA,DR
 ;
 ;
ATSEQ K IBI,IBX,IBATYP,IBARTYP,IBSERV
 Q
 ;
 ;
DATA ;Action Type (#350.1)^  <null>   ^AR Category (#430.2)
 ;;DG OBSERVATION COPAY NEW^     ^OUTPATIENT CARE(NSC)
 ;;DG OBSERVATION COPAY CANCEL^  ^OUTPATIENT CARE(NSC)
 ;;DG OBSERVATION COPAY UPDATE^  ^OUTPATIENT CARE(NSC)
 ;
ATAT ; Resolve pointers to file #350.1 from file #350.1
 D BMES^XPDUTL(">>> Updating pointers to file #350.1 from file #350.1.")
 F IBI=1:1 S IBX=$P($T(ACT+IBI),";;",2,99) Q:IBX=""  D
 .S IBNEW=$O(^IBE(350.1,"B",$P(IBX,"^"),0))
 .S IBCAN=$O(^IBE(350.1,"B",$P(IBX,"^",2),0))
 .S IBUPD=$O(^IBE(350.1,"B",$P(IBX,"^",3),0))
 .F IBJ=IBNEW,IBCAN,IBUPD D
 ..S DIE="^IBE(350.1,",DA=IBJ
 ..S DR=".06////"_IBCAN_";.07////"_IBUPD_";.09////"_IBNEW
 ..D ^DIE K DA,DR,DIE
 ;
 K IBI,IBX,IBNEW,IBCAN,IBUPD,IBJ
 Q
 ;
 ;
ACT ;New Action (#350.1)^Cancel Action (#350.1)^Update Action (#350.1)
 ;;DG OBSERVATION COPAY NEW^DG OBSERVATION COPAY CANCEL^DG OBSERVATION COPAY UPDATE
 ;
 ;
ATUT ; Resolve pointers to #350.1 from #399.1
 D BMES^XPDUTL(">>> Updating pointers to file #350.1 from file #399.1.")
 F IBI=1:1 S IBX=$P($T(UTL+IBI),";;",2,99) Q:IBX=""  D
 .S IBUTL=$O(^DGCR(399.1,"B",$P(IBX,"^"),0))
 .S IBCP=$O(^IBE(350.1,"B",$P(IBX,"^",2),0))
 .S DIE="^DGCR(399.1,",DA=IBUTL,DR=".14////"_IBCP
 .D ^DIE K DA,DR,DIE
 ;
 K DA,DR,DIE,IBI,IBX,IBUTL,IBCP
 Q
 ;
 ;
UTL ;Utility (#399.1)^Copay Action (#350.1)^Per Diem Action (#350.1)
 ;;OBSERVATION CARE^DG OBSERVATION COPAY NEW
 ;
ARNB ;
 ; Adds an entry to file 356.8 for MST if no entry found. 
 N IBNEXT,IBNAME,DO,DIC,DD,IBNEXT,IB0,Y,DINUM,DLAYGO,X
 S IBNAME="MILITARY SEXUAL TRAUMA"
 I $D(^IBE(356.8,"B",IBNAME)) D BMES^XPDUTL("***> Entry IN FILE #356.8 for "_IBNAME_" already EXISTS") Q
 I '$D(^IBE(356.8,0)) D BMES^XPDUTL("***> Could not find ^IBE(356.8,0 Please contact your IRM ... MST Entry not ADDED") Q
 L +^IBE(356.8,0):10 I '$T D BMES^XPDUTL("***> Could not Lock file #356.8 NODE 0 NO MST entry ADDED") Q
 S IB0=$G(^IBE(356.8,0))
 ;
 ; In the case where we have a file containing a gap in the order of the iens
 ;  ie ^IBE(356.8,0)="CLAIMS TRK NBR^356.8^999^29
 ;  We will loop the file to find the next available Sequential IEN
 ;  The sites reserve IEN's above 999 for custom use.
 ;
 D IBNEXT
 I IBNEXT<1 D BMES^XPDUTL("***>Could not find the NEXT available IEN ...NO MST entry added.") Q
 L -^IBE(356.8,0)
 I $D(^IBE(356.8,IBNEXT,0)) D  Q
 . D BMES^XPDUTL("***> The SELECTED NEW IEN "_IBNEXT_" already exists.  File #356.8 is out of SEQUENTIAL order Please contact your IRM.")
 . D BMES^XPDUTL("***> No MST entry ADDED to File #356.8.")
 L +^IBE(356.8,IBNEXT):5 I '$T D BMES^XPDUTL("***> Could not Lock file #356.8 NODE "_IBNEXT_" NO MST entry ADDED") Q
 S DIC="^IBE(356.8,",DIC(0)="L",DLAYGO=356.8,DINUM=IBNEXT,X=IBNAME
 D FILE^DICN L -^IBE(356.8,IBNEXT)
 I +Y<1 D BMES^XPDUTL("***> Could not ADD entry "_IBNEXT_" to FILE #356.8 FILE^DICN FAILED.") Q
 D BMES^XPDUTL("***> MST Entry ADDED to file #356.8 at IEN "_IBNEXT_".")
 Q
 ;
IBNEXT ;
 ; Find the next IEN in sequential order in file 356.8
 N IBCNT,IBSTOP,IBI,IBJ
 S (IBCNT,IBI)=0
 F IBJ=1:1 S IBI=$O(^IBE(356.8,IBI)) Q:'IBI!($D(IBNEXT))  D
 . S IBCNT=IBCNT+1
 . I IBCNT<IBI S IBNEXT=IBCNT ; case entries out of sequence
 I '$D(IBNEXT) S IBNEXT=$P(IB0,U,3)+1 ; entries in sequence
 Q
 ;
LAST ;
 D BMES^XPDUTL(">>> All POST-INIT Activities have been completed. <<<")
 Q
