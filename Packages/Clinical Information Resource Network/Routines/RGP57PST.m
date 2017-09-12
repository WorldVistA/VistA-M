RGP57PST ;BIR/PTD-POST-INIT TO RETIRE #218 EXCEPTIONS ;3/9/10
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**57**;30 Apr 99;Build 2
 ;
 ;Loop through the CIRN HL7 EXCEPTION LOG (#991.1) file.
 ;Find exceptions with EXCEPTION STATUS of NOT PROCESSED ("0").
 ;Get the TYPE which is a pointer to the CIRN HL7 EXCEPTION
 ;TYPE (#991.11) file.  If the TYPE is 218 (Potential Matches
 ;Returned),mark the EXCEPTION STATUS to PROCESSED ("1").
 ;Exception type 218 is obsolete.
 ;
EXLOG ;
 ;If patch RG*1.0*57 has previously been installed, quit post-init.
 I $$PATCH^XPDUTL("RG*1.0*57") D BMES^XPDUTL(" Post-install previously ran; no need to reprocess file 991.1 again.") Q
 ;Else continue with post-init.
 ;
 D BMES^XPDUTL(" The post-init routine will retire Potential Matches Returned (218)")
 D MES^XPDUTL(" exceptions in the CIRN HL7 EXCEPTION LOG (#991.1) file.")
 ;
 N COUNT,DA,DIC,DIE,DR,EXNUM,EXCTYP,LOGIEN,X,Y,ZNODE
 S (LOGIEN,COUNT)=0
 F  S LOGIEN=$O(^RGHL7(991.1,LOGIEN)) Q:'LOGIEN  D
 .S EXNUM=0
 .F  S EXNUM=$O(^RGHL7(991.1,LOGIEN,1,EXNUM)) Q:'EXNUM  S ZNODE=$G(^(EXNUM,0)) I $P(ZNODE,"^",5)'=1 D  ;Quit if EXCEPTION STATUS (#6) equals 1 for PROCESSED
 ..S EXCTYP=$P(ZNODE,"^",3) ;Get exception TYPE
 ..I EXCTYP=218 D  ;If TYPE is 218 - Potential Matches Returned DO
 ...; 
DIE ...;Update the EXCEPTION STATUS (#6) field to '1' - PROCESSED.
 ...S DA(1)=LOGIEN,DA=EXNUM,DR="6///"_1
 ...S DIE="^RGHL7(991.1,"_DA(1)_",1,"
 ...L +^RGHL7(991.1,LOGIEN):10
 ...D ^DIE K DA,DIE,DR
 ...L -^RGHL7(991.1,LOGIEN)
 ...S COUNT=COUNT+1
 ;
 D BMES^XPDUTL(" A total of "_COUNT_" Potential Matches Returned exceptions were retired.")
 D MES^XPDUTL(" Post-install routine completed successfully.")
 Q
