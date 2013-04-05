DGYNPRE ;ALB/ABR - pre-init for DG*5.3*36;10-04-94
 ;;5.3;Registration;**36**;Aug 13, 1993
 ;
 ; delete field TSR ORDER to remove NO-DELETION message prior to init.
EN ;entry point for pre-init
 S DIK="^DD(40.806,",DA(1)=40.806,DA=.04
 D ^DIK
 Q
