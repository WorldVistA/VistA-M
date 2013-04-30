PSJADM ;BIR/WRT/ALG- SHELL ROUTINE THAT CONTAINS HOOKS FOR AUTOMATED DISPENSING MACHINES ; 8/12/10 5:59pm
 ;;5.0;INPATIENT MEDICATIONS;**268**;16 DEC 97;Build 9
 ;
EDIT ; This is where you hook the Vendors 1-x to routine PSGOEE
 Q
NEWG ; This is where you hook the Vendors 1-x to routine PSGOETO
 Q
NEWJ ; This is where you hook the Vendors 1-x to routine PSJOEA2,PSJHLV,PSGOEV
 Q
RENEW ; This is where you hook the Vendors 1-x to routines PSJCOMR
 Q
