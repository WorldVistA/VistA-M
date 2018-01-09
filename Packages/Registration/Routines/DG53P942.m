DG53P942 ;ALB/LLS-Update DNS DOMAIN for HL Logical Link ;7/26/17 08:20
 ;;5.3;Registration;**942**;Aug 13, 1993;Build 11
 ; Uses ICRs:
 ; #4440 KERNEL Supported DBIA4440
 Q
EN ;Post install entry point
 D CHG
 Q
 ;
CHG ;Change DNS DOMAIN field of the HL LOGICAL LINK file (#870) for entry DG HT CC
 N DIC,DR,DA,DGIEN,DIE
 I '$$PROD^XUPROD(1) D BMES^XPDUTL("Install was done in a non-production environment."),BMES^XPDUTL("DNS DOMAIN, TCP/IP ADDRESS, and MAILMAN DOMAIN fields not updated.") Q
 S DGIEN=$O(^HLCS(870,"B","DG HT CC",""))
 I DGIEN']"" D BMES^XPDUTL("'DG HT CC' record not found in HL LOGICAL LINK file (#870). DNS DOMAIN not updated.") Q  ; DG HT CC entry not found in file 870
 K ^UTILITY("DIQ1",$J)
 S DIC=870,DR=".08",DA=DGIEN D EN^DIQ1 ; populate ^UTILITY("DIQ1",$J,870,DGIEN,.08)
 S DIE="^HLCS(870,",DA=DGIEN,DR=".08///VAWW.HL7.200T7.CC.DOMAIN.EXT" D ^DIE
 D BMES^XPDUTL("DNS DOMAIN changed from '"_^UTILITY("DIQ1",$J,870,DGIEN,.08)_"' to 'VAWW.HL7.200T7.CC.DOMAIN.EXT' for entry 'DG HT CC' of the HL LOGICAL LINK file (#870).")
 K ^UTILITY("DIQ1",$J)
 Q 
