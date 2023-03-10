BPSPHAR ;BHAM ISC/BEE - ECME MGR PHAR OPTION ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,2,5,22,33**;JUN 2004;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is called by the BPS SETUP PHARMACY menu option. It updates
 ; several fields in the BPS PHARMACIES file.
 ;
 Q
 ;
EN ; Main Entry Point
 N BPS56,BPS5601,BPS561,BPSCNT,BPSCS,BPSCSAR,BPSFN,BPSCSID,BPSCSNM,BPSREC
 N D0,DA,DI,DIC,DIR,DLAYGO,DIE,DIRUT,DQ,DR,DTOUT,DUOUT,X,Y
 ;
 ; First select the pharmacy or enter a new one
 W !! S DIC(0)="QEALM",(DLAYGO,DIC)=9002313.56,DIC("A")="Select BPS PHARMACIES NAME: "
 D ^DIC
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(Y)=-1) Q
 ;
 ;Pull internal entry
 S DA=$P($G(Y),U) Q:'$G(Y)
 ;
 ; If new BPS Pharmacy, default the CMOP Switch and Auto-Reversal Parameter
 I $P(Y,U,3)=1 D
 . N DIE,DR,DTOUT
 . S DIE=9002313.56,DR="1////0;.09////5"
 . D ^DIE
 ;
 ; Display the BPS Pharmacy name, NCPDP #, and NPI
 W !!,"NAME: ",$P($G(^BPS(9002313.56,DA,0)),U,1)
 W !,"STATUS: ",$$GET1^DIQ(9002313.56,DA,.1,"E")
 W !,"NCPDP #: ",$P($G(^BPS(9002313.56,DA,0)),U,2)
 W !,"NPI: ",$P($G(^BPS(9002313.56,DA,"NPI")),U,1)
 ;
 ; Now edit OUTPATIENT SITE, CMOP SWITCH, AUTO-REVERSE PARAMETER, 
 ;   and the DEFAULT DEA #
 S DIE=9002313.56
 S DR="13800;1;.09;.03"
 S DR(2,9002313.5601)=".01"
 D ^DIE
 I $D(Y) Q
 ;
 ; If the current BPS Pharmacy being edited is not Active, do
 ; not display the prompt for BPS Pharmacy for Controlled Substances.
 I $$GET1^DIQ(9002313.56,DA,.1,"I")'=1 Q
 ;
 K BPSCSAR
 S BPS56=0
 S BPSCNT=0
 F  S BPS56=$O(^BPS(9002313.56,BPS56)) Q:'BPS56  D
 . I BPS56=DA Q
 . ; Exclude from list if not active
 . S BPS561=$$GET1^DIQ(9002313.56,BPS56,.1,"I")
 . I BPS561'=1 Q
 . ; Exclude from list if pointing to another pharmacy
 . I $$GET1^DIQ(9002313.56,BPS56,2)'="" Q
 . S BPS5601=$$GET1^DIQ(9002313.56,BPS56,.01)
 . S BPSCNT=BPSCNT+1
 . S BPSCSAR(BPSCNT)=BPS56_"^"_BPS5601
 ;
 I '$D(BPSCSAR) Q
 S BPSCSNM=""
 S BPSCSID=$$GET1^DIQ(9002313.56,DA,2,"I")
 I BPSCSID'="" S BPSCSNM=$$GET1^DIQ(9002313.56,BPSCSID,.01)
 ;
 W !!,"*** BPS Pharmacy for CS is an optional field."
 W !,"This field should only be used when a dispensing pharmacy does not"
 W !,"have a valid DEA Controlled Substance Registration Certificate"
 W !,"and therefore those products are dispensed by a different pharmacy."
 W !,"Press Enter to bypass the prompt. ***"
 ;
 K DIR
 S DIR(0)="SO^"
 S BPSCNT=""
 F  S BPSCNT=$O(BPSCSAR(BPSCNT)) Q:'BPSCNT  D
 . S DIR(0)=DIR(0)_BPSCNT_":"_$P(BPSCSAR(BPSCNT),"^",2)_";"
 S DIR(0)=$E(DIR(0),1,$L(DIR(0))-1)
 S DIR("A")="Select BPS Pharmacy for CS or Enter to bypass"
 S DIR("B")=BPSCSNM
 S DIR("?",1)="*** BPS Pharmacy for CS is an optional field."
 S DIR("?",2)="This field should only be used when a dispensing pharmacy does not"
 S DIR("?",3)="have a valid DEA Controlled Substance Registration Certificate"
 S DIR("?",4)="and therefore those products are dispensed by a different pharmacy."
 S DIR("?")="Press Enter to bypass the prompt. ***"
 D ^DIR
 ;
 I '$G(Y),$G(X)'="@" Q
 ;
 S BPS56=""
 I Y S BPS56=$P(BPSCSAR(Y),"^")
 ;
 S BPSFN=9002313.56
 S BPSREC=DA_","
 S BPSCS(BPSFN,BPSREC,2)=BPS56
 D FILE^DIE("","BPSCS","")
 ;
 I BPS56="" Q
 W !!?5,"NCPDP #: "_$$GET1^DIQ(9002313.56,BPS56,.02)
 W !?5,"NPI: "_$$GET1^DIQ(9002313.56,BPS56,41.01),!
 ;
 N DIR
 S DIR(0)="E"
 S DIR("A")="Press enter to continue"
 D ^DIR
 ;
 Q
