RCY208PO ;ALB/TMK - PRCA*4.5*208 POST-INSTALL ;08-JAN-2004
 ;;4.5;Accounts Receivable;**208**;Mar 20, 1995
 ;
POST ;Set up check points for post-init
 N %
 S %=$$NEWCP^XPDUTL("REV","REVIEW^RCY208PO")
 S %=$$NEWCP^XPDUTL("INDX","INDEX^RCY208PO")
 S %=$$NEWCP^XPDUTL("CLEAN","CLEANUP^RCY208PO")
 S %=$$NEWCP^XPDUTL("END","END^RCY208PO") ; Leave as last update
 Q
 ;
REVIEW N %,RCB,RCZ,RCZ0,RCY,RC,RCWP,DD,DO,DA,X,Y,DLAYGO,DIC,DIK,DIU
 D BMES^XPDUTL("Moving review comments into new fields")
 S RCZ=+$$PARCP^XPDUTL("REV") ; Get the last entry processed on a previous install of this patch
 D BMES^XPDUTL("Starting at entry # "_(RCZ+1))
 F  S RCZ=$O(^RCY(344.49,RCZ)) Q:'RCZ  S RCZ0=0 F  S RCZ0=$O(^RCY(344.49,RCZ,1,RCZ0)) Q:'RCZ0  I $D(^RCY(344.49,RCZ,1,RCZ0,3,0)) D
 . I $O(^RCY(344.49,RCZ,1,RCZ0,3,0)) D  ; If any review data, create new entry for review
 .. S DA(2)=RCZ,DA(1)=RCZ0,DIC(0)="L",DLAYGO=344.4914,DIC="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",4,",X=$$NOW^XLFDT(),DIC("DR")=".02////.5" K DO,DD D FILE^DICN K DO,DD,DLAYGO,DIC ; Add the multiple
 .. S RCY=+Y
 .. ;Add comment line to indicate post-install moved text and then move the rest of the existing text after it.
 .. K RCWP
 .. S RCWP(1)="REVIEW COPIED HERE BY POST-INSTALL FOR e-PAYMENTS ENHANCEMENTS PATCH"
 .. S RC=1,RCB=0 F  S RCB=$O(^RCY(344.49,RCZ,1,RCZ0,3,RCB)) Q:'RCB  S RC=RC+1,RCWP(RC)=$G(^(RCB,0))
 .. D WP^DIE(344.4914,RCY_","_RCZ0_","_RCZ_",",.03,"","RCWP")
 . I $D(^RCY(344.49,RCZ,1,RCZ0,3)) D WP^DIE(344.491,RCZ0_","_RCZ_",",3,"","@")
 . S %=$$UPCP^XPDUTL("REV",RCZ) ; Store the last record processed in the file
 ; Now delete the DD entry completely from the system
 D BMES^XPDUTL("Deleting the old REVIEW NOTES field definition")
 S DIU(0)="S",DIU=344.4913 D EN^DIU2
 D COMPLETE
 Q
 ;
INDEX ; Re-index the FILE DATE/TIME field (.07) in file 344.4
 D BMES^XPDUTL("Creating new 'AFD' cross ref for field FILE DATE/TIME (#.07) in the ELECTRONIC REMITTANCE ADVICE file (#344.4)")
 I '$D(^RCY(344.4,"AFD")) S DIK="^RCY(344.4,",DIK(1)=.07 D ENALL^DIK
 D COMPLETE
 Q
CLEANUP ; Cleans up the EFTs matched to paper EOBs being unmatched
 N Z,Z0,Z1,Z2,DIE,DA,DR,RCCT
 D BMES^XPDUTL("Cleaning up EFTs matched to paper EOBs")
 S Z=0 F  S Z=$O(^RCY(344.31,Z)) Q:'Z  S Z0=$G(^(Z,0)) D
 . S Z1=$O(^RCY(344,"AEFT",Z,0))
 . Q:'Z1  ; No receipt exists for the EFT detail
 . I '$P(Z0,U,8) D  Q  ; Marked as not matched for EFT detail
 .. S Z2=$G(^RCY(344,Z1,0)),DIE="^RCY(344,",DA=Z,DR=".08////"_$S($P(Z2,U,18):1,1:2) D ^DIE ; Update the match status of EFT detail
 . I $P(Z0,U,8)["1",$P(Z0,U,10) D  ; EFT is matched with an ERA
 .. S Z2=$G(^RCY(344.4,+$P(Z0,U,10),0))
 .. I $P(Z2,U,8)'=Z1 D  ; EFT detail receipt is not the ERA's receipt
 ... S DA=Z,DR=".1///@;.08////2",DIE="^RCY(344.31," D ^DIE
 .. ; Now if no receipt on ERA, change it to matched to paper EOB
 .. I '$P(Z2,U,8) S DA=+$P(Z0,U,10),DIE="^RCY(344.4,",DR=".09////4;.14////3;20.03////1" D ^DIE
 D COMPLETE
 D BMES^XPDUTL("Cleaning up 0-payment ERAs matched to paper check")
 S RCCT="NO"
 S Z=0 F  S Z=$O(^RCY(344.4,Z)) Q:'Z  S Z0=$G(^(Z,0)) I $P(Z0,U,15)="CHK",'$P(Z0,U,5),$P(Z0,U,9)=2 S DIE="^RCY(344.4,",DR=".09////3;.14////3",DA=Z D ^DIE S RCCT=RCCT+1
 D BMES^XPDUTL(RCCT_" ERAs marked as 'MATCH - 0 PAYMENT'")
 D COMPLETE
 Q
 ;
COMPLETE ;
 D BMES^XPDUTL("Step complete.")
 Q
 ;
END ;
 D BMES^XPDUTL("Post install complete.")
 Q
 ;
