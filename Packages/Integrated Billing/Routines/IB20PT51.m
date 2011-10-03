IB20PT51 ;ALB/CPM - MORE IB V2.0 POST-INIT ONE-TIME ITEMS ; 28-JAN-94
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ; Perform more one-time post-init items
 D UBFM ;     add UB-92 form type to the Form Type (#353) file
 D RXFT ;     add Addendum form type to the Form Type (#353) file
 D FLAG ;     flag telephone stop codes as non-billable
 D HOLD ;     check all charges 'on hold' in file #350
 Q
 ;
 ;
UBFM ; Add UB-92 form type to the Form Type (#353) file.
 Q:$O(^IBE(353,"B","UB-92",0))
 W !!,">>> Adding UB-92 form type to the Form Type (#353) file."
 S DINUM=0 F Y=3:1:1000 I '$D(^IBE(353,Y,0))!($P($G(^IBE(353,Y,0)),U,1)="UB-92") S DINUM=Y Q
 I 'DINUM W !!,"****  ERROR: Could not add UB-92 claim form to file 353!  ****" G UBFMQ
 S DIC="^IBE(353,",DIC(0)="LX",X="UB-92" D ^DIC
 I '$P(Y,U,3) W !!,"**** ERROR: UB-92 Claim Form already defined!  Check Routine. ****" G UBFMQ
 I +Y>0 S DA=+Y,DIE=DIC,DR="1.01///^S X=""EN^IBCF3""" D ^DIE
UBFMQ K DIC,DIE,DA,Y,X,DR,DINUM
 Q
 ;
RXFT ; Add Addendum form type to the Form Type (#353) file.
 W !!,">>> Adding Addendum form type to the Form Type (#353) file."
 S DINUM=0 F Y=3:1:1000 I '$D(^IBE(353,Y,0))!($P($G(^IBE(353,Y,0)),U,1)="BILL ADDENDUM") S DINUM=Y Q
 I 'DINUM W !!,"****  ERROR: Could not add BILL ADDENDUM claim form to file 353!  ****" G RXFTE
 S DIC="^IBE(353,",DIC(0)="LX",X="BILL ADDENDUM" D ^DIC
 I '$P(Y,U,3) W !!,"**** ERROR: BILL ADDENDUM Claim Form already defined!  Check Routine. ****" G RXFTE
 I +Y>0 S DA=+Y,DIE=DIC,DR="1.01///^S X=""EN^IBCF4""" D ^DIE
RXFTE K DIC,DIE,DA,Y,X,DR,DINUM
 Q
 ;
FLAG ; Flag Telephone Stop Codes as non-billable for Means Test Billing
 W !!,">>> Flagging Telephone stop codes as non-billable for Means Test Billing..."
 F IBI=1:1 S IBS=$P($T(STOPS+IBI),";;",2) Q:IBS="QUIT"  D
 .S X=$O(^DIC(40.7,"B",IBS,0))
 .I 'X W !?4,"Unable to flag the stop code '",IBS,"' (not on file)..." Q
 .K DD,DO S DIC="^IBE(352.3,",DIC(0)="" D FILE^DICN Q:Y<0
 .S DIE=DIC,DA=+Y,DR=".02////2940201;.03////1" D ^DIE
 .W !?4,"Flagged stop code '",IBS,"' as non-billable..."
 K DA,DIC,DIE,DR,IBI,IBS,X,Y
 Q
 ;
STOPS ; Stop codes to flag
 ;;TELEPHONE TRIAGE
 ;;TELEPHONE/MEDICINE
 ;;TELEPHONE/SURGERY
 ;;TELEPHONE/SPECIAL PSYCHIATRY
 ;;TELEPHONE/GENERAL PSYCHIATRY
 ;;TELEPHONE/PTSD
 ;;TELEPHONE/ALCOHOL DEPENDENCE
 ;;TELEPHONE/DRUG DEPENDENCE
 ;;TELEPHONE/SUBSTANCE ABUSE
 ;;TELEPHONE/ANCILLARY
 ;;TELEPHONE/REHAB AND SUPPORT
 ;;TELEPHONE/DIAGNOSTIC
 ;;TELEPHONE/PROSTHETICS/ORTHOTIC
 ;;TELEPHONE/DENTAL
 ;;TELEPHONE/DIALYSIS
 ;;QUIT
 ;
 ;
HOLD ; Check all charges in file #350 that are on hold.
 ;
 W !!,">>> Examining all charges 'on hold' in File #350..."
 ;
 S (IBCNTR,IBCNTU)=0
 ;
 ; - run through all held charges
 S DFN=0 F  S DFN=$O(^IB("AH",DFN)) Q:'DFN  D
 .S IBN=0 F  S IBN=$O(^IB("AH",DFN,IBN)) Q:'IBN  D
 ..;
 ..; - get the action and parent
 ..S IBND=$G(^IB(IBN,0)),IBPAR=+$P(IBND,"^",9)
 ..;
 ..; - if the parent is itself, and there's no entry in
 ..; - ^ib("apdt",ibpar then re-index entry
 ..I IBN=IBPAR,'$D(^IB("APDT",IBN)) S DA=IBN,DIK="^IB(" D IX1^DIK S IBCNTR=IBCNTR+1
 ..;
 ..; - determine the transaction type of the last transaction
 ..S IBL=$$LAST^IBECEAU(IBPAR)
 ..S IBTRTY=$P($G(^IBE(350.1,+$P($G(^IB(IBL,0)),"^",3),0)),"^",5)
 ..;
 ..; - if the transaction was a cancel-type transaction, update
 ..; - the status of the held charge to cancelled.
 ..Q:IBTRTY'=2
 ..S DA=IBN,DIE="^IB(",DR=".05////10" D ^DIE
 ..S IBCNTU=IBCNTU+1
 ..;
 ..; - show signs of life
 ..W:'(IBCNTU#10) "."
 ;
 ;
 W !," >> ",$S(IBCNTU:IBCNTU,1:"No")," held charge",$S(IBCNTU=1:" was",1:"s were")," updated to cancelled."
 W !," >> ",$S(IBCNTR:IBCNTR,1:"No")," held charge",$S(IBCNTR=1:" was",1:"s were")," re-indexed."
 ;
 K DA,DIK,DIE,DR,DFN,IBCNTR,IBCNTU,IBN,IBND,IBPAR,IBL,IBTRTY
 Q
