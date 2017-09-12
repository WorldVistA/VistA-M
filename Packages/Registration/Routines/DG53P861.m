DG53P861 ;ALB/LG - PRE-INSTALL ROUTINE FOR DG*5.3*861;NOV 2012 ; 3/14/13 1:57pm
 ;;5.3;Registration;**861**;Aug 13, 1993;Build 29
 ; This routine will be used to default the ID FORMAT
 ; Field (#9) of the  ELIGIBILITY CODE FILE (#8) in cases where
 ; the field is set to null.  This file update will coincide
 ; with a modification to make the ID FORMAT Field (#9) of the 
 ; ELIGIBILITY CODE FILE (#8) a required field. 
 Q
EN N DA,DIE,DR,DGELGSTT,DGELDAT,DGVAS
 S DA=0,DGVAS=$O(^DIC(8.2,"B","VA STANDARD","")) ;Check for site specific VA STANDARD assignment 
 F  S DA=$O(^DIC(8,DA)) Q:'DA  D
 .S DGELDAT=$G(^DIC(8,DA,0)),DGELGSTT=$P(DGELDAT,"^",10)
 .I DGELGSTT Q  ;Field already has ID Format Field (#9) defined and should not be updated
 .S DIE=8,DR="9////"_DGVAS ;Update using site specific VA standard assignment
 .D ^DIE
 D BMES^XPDUTL("Pre-Install Routine: ^DG53P861--Complete")
 Q
