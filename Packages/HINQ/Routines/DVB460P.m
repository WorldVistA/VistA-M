DVB460P ;ALB/TCK POST-INSTALL FOR PATCH DVB*4*60 ; 2/21/2008
 ;;4.0;HINQ;**60**;03/25/92;Build 6
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX
 F FBX="ICD" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^DVB460P")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
ICD ;
 ; Map the ICD diagnosis code, 295.90 to disability condition 9204
 D BMES^XPDUTL("  Mapping diagnosis code 295.90 to Disability condition, 9204.")
 ;Locate the IEN of file (#80) that contains the 295.90 diagnosis code
 N PTR,ICD,RD
 S PTR="",ICD=295.90,RD=9204
 I '$D(^ICD9("BA")) D  Q
 .D BMES^XPDUTL("Error mapping diagnosis code "_ICD_" to rated disability "_RD_".  Cross reference is missing.")
 S PTR=$O(^ICD9("BA",ICD,PTR))
 I PTR'>0 D  Q
 .D BMES^XPDUTL("Error. Diagnosis code "_ICD_" is missing from ICD Diagnosis file, #80.  Mapping was not successful.")
 D MAP(PTR,RD,ICD)
 Q
 ;
MAP(PTR,RD,ICD) ;
 N RDARY,RPTR,DD,DO,DA,DIE,DR,X,Y
 S (RDARY,RPTR)=""
 I '$D(^DIC(31,"C")) D  Q
 .D BMES^XPDUTL("Error mapping diagnosis code "_ICD_" to rated disability "_RD_".  Cross reference is missing.")
 F  S RPTR=$O(^DIC(31,"C",RD,RPTR)) Q:RPTR=""  D
 .Q:RPTR'>0
 .S RDARY(RD,RPTR)=""
 I '$D(RDARY) D  Q
 .D BMES^XPDUTL(" Error. Rated Disability "_RD_" is missing from Disability Condition file, #31.")
 F  S RPTR=$O(RDARY(RD,RPTR)) Q:RPTR=""  D
 .Q:RPTR=""
 .I $D(^DIC(31,RPTR,"ICD","B",PTR)) D  Q
 ..D BMES^XPDUTL(" Diagnosis code "_ICD_" is already mapped to Rated disability "_RD_".")
 .S DA(1)=RPTR
 .S DA=$O(^DIC(31,DA(1),"ICD","B",PTR,0))
 .I DA'>0 D  Q:DA'>0
 ..S DIC="^DIC(31,"_DA(1)_",""ICD"",",DIC(0)="L",DIC("P")="31.01PA",DLAYGO=31.01
 ..S X=PTR
 ..K DD,DO D FILE^DICN
 ..K DIC,DLAYGO
 ..S DA=+Y
 .;
 .S DIE="^DIC(31,"_DA(1)_",""ICD"","
 .S DR=".02///0"
 .D ^DIE
 Q
 ;
 ;DVB460P
