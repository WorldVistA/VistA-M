IBYP458 ;ALB/ARH - IB*2.0*458 POST INIT: RCBE III UPDATE ; 16-OCT-2012
 ;;2.0;INTEGRATED BILLING;**458**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
PRE ; RCBE III (VF #2) PRE-INSTALL
 ; clean up, delete APRE1 xref (#1) on Insurance Review Authorization Number field (#356.2,.28)
 ;
 N IBA S IBA(2)="     IB*2*458 Pre-Install .....",IBA(1)=" " D MES^XPDUTL(.IBA) K IBA
 ;
 D DELIX^DDMOD(356.2,.28,1)
 S IBA(2)="     >> ^DD(356.2,.28) cross-reference #1 deleted",IBA(1)=" "
 S IBA(3)="        Insurance Review (#356.2) Authorization Number (.28) xref APRE1" D MES^XPDUTL(.IBA) K IBA
 ;
 S IBA(2)="     IB*2*458 Pre-Install Complete",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
POST ; RCBE III (VF #2) POST-INSTALL
 ;
 N IBA S IBA(2)="     IB*2*458 Post-Install .....",IBA(1)=" " D MES^XPDUTL(.IBA) K IBA
 ;
 D CTRT ; Add 3 Claims Tracking Review Types, New (#356.11)
 D CTDR ; Add 3 Claims Tracking Denial Reasons, New (#356.21)
 ;
 D RNBN ; Add 14 RNBs, new (#356.8)
 D RNBE ; Edit 1 RNB, change name (#356.8)
 ;
 D MOVE ; Copy Insurance Review (#356.2) Authorization and Call Reference Number Data
 ;
 S IBA(2)="     IB*2*458 Post-Install Complete",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
CTRT ; Add New Claims Tracking Review Types (#356.11)
 N IBI,IBRIEN,IBLN,IBNM,IBCTRT,IBTOT,IBTNC,IBTCH,DIE,DIC,DR,DA,DD,DO,X,Y,DLAYGO,DINUM
 S (IBTOT,IBTNC,IBTCH)=0 S DLAYGO=356.11
 ;
 D MSG("Add 3 Claims Tracking Review Types, New (#356.11) ...",1)
 ;
 F IBI=1:1 S IBLN=$P($T(NRT11+IBI),";;",2,999) Q:'IBLN  D
 . ;
 . S IBNM=$P(IBLN,U,4) S IBCTRT=$O(^IBE(356.11,"B",IBNM,0))
 . F IBRIEN=11:1 I '$D(^IBE(356.11,IBRIEN,0)) Q
 . ;
 . S IBTOT=IBTOT+1 I +IBCTRT S IBTNC=IBTNC+1 Q
 . ;
 . S DIC="^IBE(356.11," S DIC("DR")=".02////"_$P(IBLN,U,2)_";.03////"_$P(IBLN,U,3)
 . S DIC(0)="L",X=IBNM,DINUM=IBRIEN D FILE^DICN K DIC I 'Y D MSG(IBNM_" Not Added, ERROR ****") Q
 . S IBTCH=IBTCH+1 D MSG(IBNM_" added")
 ;
 I 'IBTCH D MSG("No Change: "_IBTNC_" of "_IBTOT_" New Review Types Already Exist")
 I +IBTCH D MSG("Updated: "_IBTCH_" of "_IBTOT_" New Review Types Added"_$$LN(IBTNC,"Already Exist"),2)
 Q
 ;
 ;
CTDR ; Add New Claims Tracking Denial Reasons (#356.21)
 N IBI,IBRIEN,IBLN,IBNM,IBCTDR,IBTOT,IBTNC,IBTCH,DIE,DIC,DR,DA,DD,DO,X,Y,DLAYGO,DINUM
 S (IBTOT,IBTNC,IBTCH)=0 S DLAYGO=356.21
 ;
 D MSG("Add 3 Claims Tracking Denial Reasons, New (#356.21) ...",1)
 ;
 F IBI=1:1 S IBLN=$P($T(NDR21+IBI),";;",2,999) Q:'IBLN  D
 . ;
 . S IBNM=$P(IBLN,U,3) S IBCTDR=$O(^IBE(356.21,"B",$E(IBNM,1,30),0))
 . F IBRIEN=8:1 I '$D(^IBE(356.21,IBRIEN,0)) Q
 . ;
 . S IBTOT=IBTOT+1 I +IBCTDR S IBTNC=IBTNC+1 Q
 . ;
 . S DIC="^IBE(356.21," S DIC("DR")=".02////"_$P(IBLN,U,2)
 . S DIC(0)="L",X=IBNM,DINUM=IBRIEN D FILE^DICN K DIC I 'Y D MSG(IBNM_" Not Added, ERROR ****") Q
 . S IBTCH=IBTCH+1 D MSG(IBNM_" added")
 ;
 I 'IBTCH D MSG("No Change: "_IBTNC_" of "_IBTOT_" New Denial Reasons Already Exist")
 I +IBTCH D MSG("Updated: "_IBTCH_" of "_IBTOT_" New Denial Reasons Added"_$$LN(IBTNC,"Already Exist"),2)
 Q
 ;
 ;
RNBE ; Edit Reasons Not Billable:  Rename one existing RNB (356.8,.01)
 N DIE,DIC,DA,DR,X,Y,IBI,IBLN,IBOLD,IBNEW,IBRNB,IBTOT,IBTNC,IBTNF,IBTCH S (IBTOT,IBTNC,IBTNF,IBTCH)=0
 ;
 D MSG("Change 1 Reasons Not Billable (RNB), Name (#356.8, .01) ...",1)
 ;
 F IBI=1:1 S IBLN=$P($T(ERNB8+IBI),";;",2,999) Q:'IBLN  D
 . S IBOLD=$P(IBLN,U,2),IBNEW=$P(IBLN,U,3) S IBRNB=$O(^IBE(356.8,"B",IBOLD,0))
 . ;
 . S IBTOT=IBTOT+1
 . I $O(^IBE(356.8,"B",IBNEW,0)) S IBTNC=IBTNC+1 Q
 . I 'IBRNB S IBTNF=IBTNF+1 D MSG(IBOLD_" not found, Error") Q
 . ;
 . N DIE,DIC,X,Y S DA=+IBRNB,DR=".01///"_IBNEW S DIE="^IBE(356.8," D ^DIE K DA,DR
 . S IBTCH=IBTCH+1 D MSG(IBOLD_" changed to "_IBNEW)
 ;
 I 'IBTCH D MSG("No Change: "_IBTNC_" of "_IBTOT_" RNB Names Already Changed"_$$LN(IBTNF,"Not Found"))
 I +IBTCH D MSG("Updated: "_IBTCH_" of "_IBTOT_" RNB Names Updated"_$$LN(IBTNC,"Already Changed")_$$LN(IBTNF,"Not Found"),2)
 Q
 ;
 ;
RNBN ; Add New Reasons Not Billable (#356.8)
 N IBI,IBRIEN,IBLN,IBNM,IBRNB,IBTOT,IBTNC,IBTCH,DIE,DIC,DR,DA,DD,DO,X,Y,DLAYGO,DINUM
 S (IBTOT,IBTNC,IBTCH)=0 S DLAYGO=356.8
 ;
 D MSG("Add 14 Reasons Not Billable (RNB), New (#356.8) ...",1)
 ;
 F IBI=1:1 S IBLN=$P($T(NRNB8+IBI),";;",2,999) Q:'IBLN  D
 . ;
 . S IBNM=$P(IBLN,U,5) S IBRNB=$O(^IBE(356.8,"B",IBNM,0))
 . F IBRIEN=100:1 I '$D(^IBE(356.8,IBRIEN,0)) Q
 . ;
 . S IBTOT=IBTOT+1 I +IBRNB S IBTNC=IBTNC+1 Q
 . ;
 . S DIC="^IBE(356.8," S DIC("DR")=".02////"_$P(IBLN,U,2)_";.03////"_$P(IBLN,U,3)_";.04///"_$P(IBLN,U,4)
 . S DIC(0)="L",X=IBNM,DINUM=IBRIEN D FILE^DICN K DIC I 'Y D MSG(IBNM_" Not Added, ERROR ****") Q
 . S IBTCH=IBTCH+1 D MSG(IBNM_" added")
 ;
 I 'IBTCH D MSG("No Change: "_IBTNC_" of "_IBTOT_" New RNBs Already Exist")
 I +IBTCH D MSG("Updated: "_IBTCH_" of "_IBTOT_" New RNBs Added"_$$LN(IBTNC,"Already Exist"),2)
 Q
 ;
 ;
MOVE ; Move Insurance Review (#356.2) Call Reference and Authorization Number Data 
 ; from old fields/location (.09, .28) to new fields/location (2.01, 2.02)
 N IBTRC,IBTRC0,IBTRC2,IBCOLD,IBAOLD,IBCC1,IBCC2,IBAC1,IBAC2,DIE,DIC,DA,DR,X,Y
 S (IBCC1,IBCC2,IBAC1,IBAC2)=0
 ; 
 D MSG("Copy Insurance Review (#356.2) Data to New Field Locations ...",1)
 D MSG("Searching file for data to copy, "_+$P($G(^IBT(356.2,0)),U,4)_" entries, please wait ...")
 ;
 S IBTRC=0 F  S IBTRC=$O(^IBT(356.2,IBTRC)) Q:'IBTRC  D
 . S IBTRC0=$G(^IBT(356.2,IBTRC,0)),IBCOLD=$P(IBTRC0,U,9),IBAOLD=$P(IBTRC0,U,28)
 . S IBTRC2=$G(^IBT(356.2,IBTRC,2)),DR=""
 . ;
 . I IBCOLD'="" S IBCC1=IBCC1+1 I $P(IBTRC2,U,1)="" S DR=DR_"2.01////^S X=IBCOLD;" S IBCC2=IBCC2+1
 . I IBAOLD'="" S IBAC1=IBAC1+1 I $P(IBTRC2,U,2)="" S DR=DR_"2.02////^S X=IBAOLD" S IBAC2=IBAC2+1
 . ;
 . I DR'="" S DIE="^IBT(356.2,",DA=IBTRC D ^DIE K DIE,DIC,DA,DR
 ;
 D MSG(IBCC1_" Call Reference Numbers found (.09), "_IBCC2_" copied (2.01)",2)
 D MSG(IBAC1_" Authorization Numbers found (.28), "_IBAC2_" copied (2.02)")
 Q
 ;
 ;
 ;
MSG(X,Y) ; set lines into patch install message, X is message, Y is line type (1-header, 2-result line)
 N CNT,IBA S CNT=1,IBA(1)="        " I +$G(Y) S CNT=2,IBA(2)=IBA(1) I +$G(Y)=1 S IBA(2)="     >> "
 S IBA(CNT)=IBA(CNT)_$G(X) D MES^XPDUTL(.IBA) K IBA
 Q
 ;
LN(NUM,TXT) Q $S('$G(NUM):"",1:", "_$G(NUM)_" "_$G(TXT))
 ;
 ;
 ;
NRT11 ; Add New Review Types (#356.11):  number ^ CODE (.02) ^ ABBREVIATION (.03) ^ NAME (.01)
 ;;1^25^SNF/NHCU^SNF/NHCU REVIEW
 ;;2^35^RETRO INPT^INPT RETROSPECTIVE REVIEW
 ;;3^55^RETRO OPT^OPT RETROSPECTIVE REVIEW
 ;;
 ;
NDR21 ; Add New Denial Reasons (#356.21):  number ^ ABBREVIATION (.02) ^ NAME (.01)
 ;;1^DELAY TX^DELAY IN TREATMENT/SERVICE
 ;;2^OBS^OBSERVATION IS MORE APPROPRIATE
 ;;3^ALT LOC^ALTERNATE LEVEL OF CARE IS MORE APPROPRIATE
 ;;
 ;
ERNB8 ; Edit RNB name (#356.8):  number ^ OLD NAME (.01) ^ NEW NAME (.01)
 ;;1^NPI/TAXONOMY ISSUES^NPI/TAXONOMY/PPN ISSUES
 ;;
 ;
NRNB8 ; Add New RNBs (#356.8):   number ^ ECME FLAG (0/1) (.02) ^ ECME PAPER FLAG (0/1) (.03) ^ CODE (.04) ^ NAME (.01)
 ;;1^^^MC20^APPT CANCELLED/PT NOT SEEN
 ;;2^^^MC21^SEEN BY PROVIDER ON SAME DAY
 ;;3^^^MC22^NON-BILLABLE DME/PROSTHETIC
 ;;4^^^MC23^NON-BILLABLE PROCEDURE
 ;;5^1^0^MC24^EMPLOYEE HEALTH
 ;;6^^^MC25^ENCOUNTER DURING INPT STAY
 ;;7^^^CV22^NO PROSTHETIC COVERAGE
 ;;8^^^CV23^NON-COVERED DIAGNOSIS
 ;;9^^^CV24^NON-COVERED ROUTINE CARE
 ;;10^1^0^CV25^HDHP PLAN NOT BILLED
 ;;11^^^CV26^NOT RELATED TO WC/TORT/NF
 ;;12^1^0^CV27^TRICARE PT SEEN AS VETERAN
 ;;13^^^BL08^COMBINED CHARGES
 ;;14^^^BL09^UNBUNDLED SERVICE
 ;;
