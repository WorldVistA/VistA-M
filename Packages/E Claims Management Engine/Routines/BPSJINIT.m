BPSJINIT ;BHAM ISC/LJF - HL7 Application Registration ;03/07/08  14:09
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,2,5,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 N DA,DIC,DIE,DINUM,DIR,DIRUT,DIROUT,DLAYGO,DR,DTOUT,DUOUT,X,Y
 N BPSJAPPR,BPSJVALR,PHIX,BPSOUT
 ;
 ;  This program will allow user to enter site data.
 ;
 ; Programmer Note: D BPSJVAL^BPSJAREG(X) will validate with following.
 ;   where X is: 0 = HL7 trigger, no validation display
 ;               1 = HL7 trigger, display validation
 ;               2 = no HL7 trigger, display validation
 ;               3 = no validation display, no HL7 trigger
 ;
 W !!,?IOM/2-14,"** ECME Site Registration **"
 ;
 ; Create/update BPS Setup record
 D VERSION
 ;
 S BPSOUT=0
 S DIE="^BPS(9002313.99,",DA=1
 S DR="[BPSJ SITE SETUP]" D ^DIE
 I BPSOUT!($D(Y)) Q
 ;
 W !!!,"-- Application Registration Validation Results:"
 S BPSJVALR=-1
 D BPSJVAL^BPSJAREG(2)
 S BPSJAPPR=BPSJVALR
 ;
 I 'BPSJAPPR W !!,?IOM/2-21,"** Application Registration Data VALID **",!
 E  D
 . W !!,"** Application Registration Data INVALID!!!  **"
 . W !,"**  Application Registration and Pharmacy    **"
 . W !,"**    Registrations will NOT be sent!        **",!
 ;
 S DIR(0)="EO" D ^DIR I X=U Q
 ;
 D PHARM(.BPSOUT)
 I BPSOUT Q
 I BPSJAPPR D  Q
 . W !!,"Registration ABORTED due to invalid site registration data",!!
 ;
 W !!!,"Application Registration Data is VALID"
 W !!,"Pharmacy Registration Data is:"
 S PHIX=$O(^BPS(9002313.56,0))
 F  Q:'PHIX  D  S PHIX=$O(^BPS(9002313.56,PHIX))
 . S BPSJVALR=-1 D REG^BPSJPREG(PHIX,3)
 . I BPSJVALR>0 S DIR=" *INVALID",DIE=" and will NOT be transmitted."
 . E  S DIR="    VALID",DIE=" and will be transmitted."
 . W !,DIR_" for "_$P($G(^BPS(9002313.56,PHIX,0)),U)_DIE
 W !
 K DA,DIC,DIE,DINUM,DIR,DIRUT,DIROUT,DLAYGO,DR,DTOUT,DUOUT,X,Y
 S DIR(0)="YEO",DIR("A")="Send Application Registration: Y/N " D ^DIR
 I $TR($E(X),"y","Y")'="Y" Q
 ;
 K DA,DIC,DIE,DINUM,DIR,DIRUT,DIROUT,DLAYGO,DR,DTOUT,DUOUT,X,Y
 D BPSJVAL^BPSJAREG(0)
 W !!,"Application Registration SUBMITTED..."
 Q
 ;
PHARM(BPSOUT) ;CYCLE THROUGH PHARMACIES
 ;
 N DA,DIC,DIE,DINUM,DIR,DIRUT,DIROUT,DLAYGO,DR,DTOUT,DUOUT,X,Y
 N BPSJVALR,BPSJPHPR,BPSPHARM
 ;
 S BPSPHARM=0 F  D  Q:BPSPHARM=""!(BPSOUT)
 . W !!!,"Enter/verify Pharmacy Registration Data"
 . ;
 . ;check for drop dead date
 . S DIC(0)="QAELM"
 . S DIC="^BPS(9002313.56,",DLAYGO=DIC D ^DIC
 . ;
 . I X'=U,0<+Y S BPSPHARM=+Y
 . E  S BPSPHARM="" Q
 . D MOD(BPSPHARM,.BPSOUT) I 'BPSPHARM!(BPSOUT) Q
 . W !!!,"-- Pharmacy Registration Validation Results --",!
 . ;
 . S BPSJVALR=-1
 . D REG^BPSJPREG(BPSPHARM,2)
 . S BPSJPHPR=BPSJVALR
 . ;
 . I 'BPSJPHPR W !!,"-- Pharmacy Registration Data VALID. --",!
 . E  D
 .. W !!,"**     Pharmacy Registration Data INVALID!!!      **"
 .. W !,"** This pharmacy's registration will NOT be sent! **",!
 ;
 Q
 ;
MOD(DA,BPSOUT) ;
 N DIE,DR,DTOUT,X,Y
 ;
 ; Set STATUS default to ACTIVE if not set
 I $P($G(^BPS(9002313.56,DA,0)),"^",10)="" D
 . S DR=".1///ACTIVE",DIE="^BPS(9002313.56,"
 . D ^DIE
 ;
 S DIE="^BPS(9002313.56,"
 S DR="[BPSJ PHARMACY ENTER/EDIT]" D ^DIE
 I $D(Y) S BPSOUT=1
 ;
 Q
 ;
VERSION ;
 ; Create entry if missing
 ; Sets in defaults:
 ;    ECME TIMEOUT: 10
 ;    SITE TYPE: VA
 ;    WINNOW TESTING FLAG: NO
 ;    VA LAST SEQUENCE: = $P($P($G(^BPSC(+$P(^BPSC(0),U,3),0)),U),?=?,4)
 ;    WINNOW BPS LOG: 36
 ;    VITRIA INTERFACE VERSION: 3
 ;
 N BPSDA,DIC,DLAYGO,X,Y,DTOUT,DUOUT,DINUM
 S BPSDA=$O(^BPS(9002313.99,0))
 I BPSDA'=1 D
 . S (DIC,DLAYGO)=9002313.99,DIC(0)="L",X="MAIN SETUP ENTRY",DINUM=1
 . S DIC("DR")="3.01///10;1000///^S X=$P($P($G(^BPSC(+$P(^BPSC(0),U,3),0)),U),"=",4);9999///VA;6003///3;2341.01///NO;2341.03///36"
 . D ^DIC
 ;
 Q
 ;
