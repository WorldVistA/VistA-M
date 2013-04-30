IBCNFCON ;WOIFO/PO - Electronic Insurance Identification ;25-MAY-2011
 ;;2.0;INTEGRATED BILLING;**457**;21-MAR-94;Build 30
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 ;
 ; Electronic Insurance Indentification  Configuration
 ;
 Q
 ;
EDIT ; edit eII software parameters
 ; this routine is called from IBCNF EDIT CONFIGURATION ooption.
 ;
 N DA,DR,DIE
 L +^IBE(350.9,1,0):0 I '$T W !,"The configuration file is being edited by another user!" Q
 ;
 S DA=1,DR="[IBCNF EDIT CONFIGURATION]",DIE="^IBE(350.9," D ^DIE
 L -^IBE(350.9,1,0)
 Q
 ;
