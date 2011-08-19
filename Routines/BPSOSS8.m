BPSOSS8 ;BHAM ISC/FCS/DRS/FLS - Edit Basic ECME Parameters ;03/07/08  14:09
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;EP - Option BPS SETUP BASIC PARAMS
 N DIE,DA,DR,DTOUT
 W !!,"Edit Pharmacy ECME configuration",!
 ;
 ; If the BPS Setup record is not created, create it.
 ; Quit if there is an error.
 D VERSION^BPSJINIT
 ;
 ; Check for errors
 I '$D(^BPS(9002313.99,1,0)) D  Q
 . W !!,"BPS Setup not defined and can not be created.  Quitting."
 ;
 ; Prompts and input
 S DA=1
 S DIE=9002313.99
 S DR="3.01ECME timeout? (0 to 30 seconds)//10;.05Insurer Asleep Interval (0 to 29 minutes): //20;.06Insurer Asleep Retries (0 to 99): //10"
 D ^DIE
 Q
 ;
