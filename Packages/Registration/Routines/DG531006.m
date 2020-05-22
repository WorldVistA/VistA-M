DG531006 ;WILM/BDB - DG*5.3*1006 PRE INSTALL TO UPDATE HBP NAMES;10/28/19 9:18pm
 ;;5.3;Registration;**1006**;Aug 13, 1993;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;        10104 : UP^XLFSTR
 ;
 Q
 ; This pre-install routine will be used to perform the following task:
 ; Update the NAME (#.01) field of the HEALTH BENEFIT PLAN (#25.11) file.
 ;
PRE ; Entry point for pre-install
 ;
 L +^DGHBP(25.11,0):10 I '$T D BMES^XPDUTL("Health Benefit Plan (#25.11) File is locked by another user.  Please log YOUR IT Services ticket.") Q
 ;
 ; Update NAME (#.01) field of the HEALTH BENEFIT PLAN (#25.11) file.
 D BMES^XPDUTL("Updating the NAME (#.01) field of the Health Benefit Plan (#25.11) File ")
 D UPDATE
 D BMES^XPDUTL("Update of the NAME field of the Health Benefit Plans has completed. ")
 ;
 L -^DGHBP(25.11,0)
 Q
 ;
UPDATE ;Change Name field of certain Health Benefit Plans
 ;
 N DGN,DGTEXT,DGOLD,DGNEW,DGIEN,DGFND,DGHBPN
 F DGN=1:1 S DGTEXT=$P($T(NAMES+DGN),";;",2) Q:DGTEXT=""  D
 .S DGOLD=$P(DGTEXT,";",1),DGNEW=$P(DGTEXT,";",2)
 .S DGOLD=$$UP^XLFSTR(DGOLD),DGNEW=$$UP^XLFSTR(DGNEW)
 .S DGIEN=0,DGFND=0 F  S DGIEN=$O(^DGHBP(25.11,DGIEN)) Q:+DGIEN=0  D  Q:DGFND=1
 ..S DGHBPN=$P(^DGHBP(25.11,DGIEN,0),U,1) Q:DGHBPN'=DGOLD
 ..S DGFND=1
 ..S DR=".01///"_DGNEW,DIE="^DGHBP(25.11,",DA=DGIEN D ^DIE K DIE,DR,DA
 ..D BMES^XPDUTL("PLAN NAME:")
 ..D MES^XPDUTL(DGOLD)
 ..D MES^XPDUTL("RENAMED TO:")
 ..D MES^XPDUTL(DGNEW)
 Q
DGERR ;
 D BMES^XPDUTL("    *** An Error occurred during the updating of ")
 D MES^XPDUTL("    the NAME field for the Health Benefit Plans for this Plan:")
 D MES^XPDUTL("    "_DGOLD)
 D MES^XPDUTL("    The Plan was not located on file.")
 D MES^XPDUTL("    Please log YOUR IT Services ticket. ***")
 Q
NAMES ;format:  ;;oldname;newname
 ;;Veteran - Full Medical Benefits Treatment & Rx Copay Exempt;Veteran Full Med Benefits Tx and Rx Copay Exmt
 ;;Veteran - Full Medical Benefits Treatment & Rx Copay Exempt (X);Veteran Full Med Benefits Tx and Rx Copay Exmt 6
 ;;Veteran - Full Medical Benefits Treatment Copay Exempt & Rx Copay Required;Veteran Full Med Benefits Tx Copay Exmt and Rx Copay Req
 ;;Veteran - Full Medical Benefits Treatment Copay Exempt & Rx Copay Required (Y);Veteran Full Med Benefits Tx Copay Exmt and Rx Copay Req 6
 ;;Veteran - Full Medical Benefits Treatment Copay Required & Rx Copay Exempt (A);Veteran Full Med Benefits Tx Copay Req and Rx Copay Exmt 6
 ;;Veteran - Full Medical Benefits Treatment Copay Required & Rx Copay Exempt (B);Veteran Full Med Benefits Tx Copay Req and Rx Copay Exmt 7
 ;;Veteran - Full Medical Benefits Treatment Copay Required & Rx Copay Exempt (C);Veteran Full Med Benefits Tx Copay Req and Rx Copay Exmt 8
 ;;Veteran - Full Medical Benefits Treatment & Rx Copay Required (A);Veteran Full Med Benefits Tx and Rx Copay Req 6
 ;;Veteran - Full Medical Benefits Treatment & Rx Copay Required (B);Veteran Full Med Benefits Tx and Rx Copay Req 8
 ;;Veteran - Full Medical Benefits Treatment GMT Copay Required & Rx Copay Exempt;Veteran Full Med Benefits Tx GMT Copay Req and Rx Copay Exmt
 ;;Veteran - Full Medical Benefits Treatment GMT Copay Required & Rx Copay Exempt (A);Veteran Full Med Benefits Tx GMT Copay Req and Copay Exmt 6
 ;;Veteran - Full Medical Benefits Treatment GMT Copay Required & Rx Copay Required;Veteran Full Med Benefits Tx GMT Copay Req and Rx Copay Req
 ;;Veteran - Full Medical Benefits Treatment GMT Copay Required & Rx Copay Required (A);Veteran Full Med Benefits Tx GMT and Rx Copay Req 6
 ;;Veteran - Restricted Medical Benefits;Veteran Restricted Med Benefits
 ;;Non-Veteran - Other Restricted Medical Benefits;Non Veteran Other Restricted Med Benefits
 ;;Active Duty & Sharing Agreements;Active Duty and Sharing Agreements
 ;;VETERAN BENEFICIARY PLAN - NEWBORN;BENEFICIARY NEWBORN
 ;;VETERAN BENEFICIARY PLAN - SPINA BIFIDA (SB);BENEFICIARY SPINA BIFIDA
 ;;VETERAN BENEFICIARY PLAN - CHILDREN OF WOMEN VIETNAM VETERANS (CWVV);BENEFICIARY CHILDREN OF WOMEN OF VIETNAM VETERANS
 ;;VETERAN PLAN - FOREIGN MEDICAL PROGRAM;VETERAN FOREIGN MEDICAL PROGRAM
 ;;VETERAN PLAN FOREIGN MEDICAL CARE;VETERAN FOREIGN MEDICAL PROGRAM
 ;;VETERAN BENEFICIARY PLAN - CAREGIVER (PRIMARY FAMILY CAREGIVER);CAREGIVER PRIMARY FAMILY
 ;;VETERAN BENEFICIARY PLAN - CAREGIVER (SECONDARY FAMILY CAREGIVER);CAREGIVER SECONDARY FAMILY
 ;;VETERAN BENEFICIARY PLAN - CAREGIVERS (GENERAL CAREGIVER);CAREGIVER GENERAL
 ;;VETERAN BENEFICIARY PLAN - CHAMPVA;BENEFICIARY CHAMPVA
 ;;
