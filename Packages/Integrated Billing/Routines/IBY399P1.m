IBY399P1 ;ALB/ARH - IB*2*399 POST-INSTALL - RNB UPDATE ; 16-OCT-2008
 ;;2.0;INTEGRATED BILLING;**399**;21-MAR-94;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Update and Add to Reasons Not Billable List (356.8)
 ; This is the post-init routine to update the Reasons Not Billable, it checks that all standard RNBs exist, 
 ; inactivates all non-standard RNBs and some selected standard RNBs, updates some ECME flags,
 ; adds the Code field to existing RNBs and adds many new RNBs with their related Code and ECME flags
 ;
 Q
 ;
RNB ; Update and Add to Reasons Not Billable (356.8)
 ;
 D OLDCHK ; check that all standard RNBs exist (39)
 D NONSTD ; inactivate all existing non-standard RNBs
 ;
 D INAC ; inactivate existing RNBs (5)
 D ECME ; update ECME Paper Flag on existing RNBs (2)
 D CODE ; add Code field data to existing RNBs (33)
 D NEWR ; add new RNBs (51)
 Q
 ;
OLDCHK ; check that standard RNB's exist on the site's system (set INCLUDE to check old and new RNBs)
 N IBI,IBLN,IBNM,IBTOT,IBTNF S (IBTOT,IBTNF)=0
 ;
 D MSG(" "),MSG("Check for the 39 Standard Reasons Not Billable (#356.8)...",1)
 ;
 F IBI=1:1 S IBLN=$P($T(RNB+IBI^IBY399P2),";;",2,999) Q:IBLN=""  I +IBLN D
 . S IBNM=$P(IBLN,U,6) I $P(IBLN,U,2)="NEW",'$G(INCLUDE) Q
 . ;
 . S IBTOT=IBTOT+1 I '$O(^IBE(356.8,"B",IBNM,0)) S IBTNF=IBTNF+1 D MSG(IBNM_" not found")
 ;
 I 'IBTNF D MSG("No Errors: All "_IBTOT_" Standard RNBs Found",2)
 I +IBTNF D MSG("ERRORS Found: "_IBTNF_" of "_IBTOT_" Standard RNBs Not Found",2)
 Q
 ;
NONSTD ; check site for any active Non-Standard RNB's and Inactivate them (356.8, .05)
 N IBI,IBLN,IBNM,RNBS,IBRNB0,IBTOT,IBTCH S (IBTOT,IBTCH)=0
 ;
 D MSG("Inactivate Any Active Non-Standard Reasons Not Billable (#356.8,.05)...",1)
 ;
 ; get list of all standard RNB's
 F IBI=1:1 S IBLN=$P($T(RNB+IBI^IBY399P2),";;",2,999) Q:IBLN=""  S IBNM=$P(IBLN,U,6) I IBNM'="" S RNBS(IBNM)=""
 ;
 ; compare standard RNB's with sites RNB's, inactivate any non-standard
 S IBI=0 F  S IBI=$O(^IBE(356.8,IBI)) Q:'IBI  D
 . S IBRNB0=$G(^IBE(356.8,IBI,0)),IBNM=$P(IBRNB0,U,1) I +$P(IBRNB0,U,5) Q
 . ;
 . S IBTOT=IBTOT+1 I $D(RNBS(IBNM)) Q
 . S IBTCH=IBTCH+1 D MSG(IBNM_" not standard and has been inactivated") D EDIT(IBI,".02////@;.03////@;.05////1")
 ;
 I 'IBTCH D MSG("No Change: No Active Non-Standard RNBs Found",2)
 I +IBTCH D MSG("Updated: "_IBTCH_" of "_IBTOT_" Active Non-Standard RNBs Found and Inactivated",2)
 Q
 ;
INAC ; Inactivate existing standard RNB's (356.8, .05) also remove ECME flags (356.8, .02, .03)
 N IBI,IBLN,IBNM,IBRNB,IBRNB0,IBTOT,IBTNC,IBTNF,IBTCH S (IBTOT,IBTNC,IBTNF,IBTCH)=0
 ;
 D MSG("Inactivate 5 Active Standard Reasons Not Billable (#356.8,.05)...",1)
 ;
 F IBI=1:1 S IBLN=$P($T(INA+IBI^IBY399P2),";;",2,999) Q:'IBLN  I $P(IBLN,U,2)="INA" D
 . S IBNM=$P(IBLN,U,6) S IBRNB=$O(^IBE(356.8,"B",IBNM,0)),IBRNB0=$G(^IBE(356.8,+IBRNB,0))
 . ;
 . S IBTOT=IBTOT+1 I +$P(IBRNB0,U,5) S IBTNC=IBTNC+1 Q
 . I 'IBRNB S IBTNF=IBTNF+1 D MSG(IBNM_" not found") Q
 . S IBTCH=IBTCH+1 D MSG(IBNM_" has been inactivated") D EDIT(IBRNB,".02////@;.03////@;.05////1")
 ;
 I 'IBTCH D MSG("No Change: "_IBTNC_" of "_IBTOT_" RNBs Already Inactive"_$$LN(IBTNF,"Not Found"),2)
 I +IBTCH D MSG("Updated: "_IBTCH_" of "_IBTOT_" RNBs Inactivated"_$$LN(IBTNC,"Already Inactive")_$$LN(IBTNF,"Not Found"),2)
 Q
 ;
ECME ; Reset ECME flags (356.8, .03)
 N IBI,IBLN,IBNM,IBRNB,IBRNB0,IBTOT,IBTNC,IBTNF,IBTCH S (IBTOT,IBTNC,IBTNF,IBTCH)=0
 ;
 D MSG("Reset 2 Reason Not Billable ECME Paper Flags (#356.8,.03)...",1)
 ;
 F IBI=1:1 S IBLN=$P($T(OLD+IBI^IBY399P2),";;",2,999) Q:'IBLN  I $P(IBLN,U,2)="OLD",$P(IBLN,U,5)'="" D
 . S IBNM=$P(IBLN,U,6) S IBRNB=$O(^IBE(356.8,"B",IBNM,0)),IBRNB0=$G(^IBE(356.8,+IBRNB,0))
 . ;
 . S IBTOT=IBTOT+1 I $P(IBRNB0,U,3)=$P(IBLN,U,5) S IBTNC=IBTNC+1 Q
 . I 'IBRNB S IBTNF=IBTNF+1 D MSG(IBNM_" not found") Q
 . S IBTCH=IBTCH+1 D MSG(IBNM_" ECME Paper Flag to "_$$YN($P(IBLN,U,5))) D EDIT(IBRNB,".03////"_+$P(IBLN,U,5))
 ;
 I 'IBTCH D MSG("No Change: "_IBTNC_" of "_IBTOT_" RNB ECME Paper Flags Already Reset"_$$LN(IBTNF,"Not Found"),2)
 I +IBTCH D MSG("Updated: "_IBTCH_" of "_IBTOT_" RNB ECME Paper Flags Reset"_$$LN(IBTNC,"Already Reset")_$$LN(IBTNF,"Not Found"),2)
 Q
 ;
 ;
CODE ; Set Code on Existing RNB's (356.8,.04)
 N IBI,IBLN,IBNM,IBRNB,IBRNB0,IBTOT,IBTNC,IBTNF,IBTCH S (IBTOT,IBTNC,IBTNF,IBTCH)=0
 ;
 D MSG("Add Code to 33 Existing RNBs (#356.8,.04)...",1)
 ;
 F IBI=1:1 S IBLN=$P($T(OLD+IBI^IBY399P2),";;",2,999) Q:'IBLN  I $P(IBLN,U,2)="OLD",$P(IBLN,U,3)'="" D
 . S IBNM=$P(IBLN,U,6) S IBRNB=$O(^IBE(356.8,"B",IBNM,0)),IBRNB0=$G(^IBE(356.8,+IBRNB,0))
 . ;
 . S IBTOT=IBTOT+1 I $P(IBRNB0,U,4)=$P(IBLN,U,3) S IBTNC=IBTNC+1 Q
 . I 'IBRNB S IBTNF=IBTNF+1 D MSG(IBNM_" not found") Q
 . S IBTCH=IBTCH+1 D MSG(IBNM_" code added "_$P(IBLN,U,3)) D EDIT(IBRNB,".04///"_$P(IBLN,U,3))
 ;
 I 'IBTCH D MSG("No Change: "_IBTNC_" of "_IBTOT_" Existing RNB Codes Already Set"_$$LN(IBTNF,"Not Found"),2)
 I +IBTCH D MSG("Updated: "_IBTCH_" of "_IBTOT_" RNBs Code Set"_$$LN(IBTNC,"Codes Already Set")_$$LN(IBTNF,"Not Found"),2)
 Q
 ;
 ;
NEWR ; Add new RNBs (if RNB already exists ensure Code is set)
 N IBI,IBJ,IBLN,IBNM,IBRNB,IBRNB0,IBTOT,IBTNC,IBTCH,DIE,DIC,DR,DA,DD,DO,X,Y,DLAYGO,DINUM
 S (IBTOT,IBTNC,IBTCH)=0 S DLAYGO=356.8
 ;
 D MSG("Add 58 New Reasons Not Billable (#356.8)...",1)
 ;
 F IBI=1:1 S IBLN=$P($T(NEW+IBI^IBY399P2),";;",2,999) Q:'IBLN  I $P(IBLN,U,2)="NEW" D
 . S IBNM=$P(IBLN,U,6) S IBRNB=$O(^IBE(356.8,"B",IBNM,0)),IBRNB0=$G(^IBE(356.8,+IBRNB,0))
 . F IBJ=39:1 I '$D(^IBE(356.8,IBJ,0)),IBJ'=72,IBJ'=90 Q
 . ;
 . S IBTOT=IBTOT+1 I +IBRNB S IBTNC=IBTNC+1 D:$P(IBRNB0,U,4)'=$P(IBLN,U,3) EDIT(IBRNB,".04///"_$P(IBLN,U,3)) Q
 . ;
 . S DIC("DR")=".02////"_$P(IBLN,U,4)_";.03////"_$P(IBLN,U,5)_";.04///"_$P(IBLN,U,3)
 . S DIC="^IBE(356.8,",DIC(0)="L",X=IBNM,DINUM=IBJ D FILE^DICN K DIC I 'Y D MSG(IBNM_" Not Added, ERROR ****") Q
 . S IBTCH=IBTCH+1 D MSG(IBNM_" added")
 ;
 I 'IBTCH D MSG("No Change: "_IBTNC_" of "_IBTOT_" New RNBs Already Exist",2)
 I +IBTCH D MSG("Updated: "_IBTCH_" of "_IBTOT_" New RNBs Added"_$$LN(IBTNC,"Already Exist"),2)
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
YN(X) Q $S(+$G(X):"Yes",1:"No")
 ;
EDIT(DA,DR) ; edit RNB field
 N DIE,DIC,X,Y I +$G(DA),$G(DR)'="" S DIE="^IBE(356.8," D ^DIE K DA,DR
 Q
