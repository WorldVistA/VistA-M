RGP43PST ;BIR/PTD-POST-INIT TO RETIRE EXCEPTIONS #209, 213, 214, 218 ;10/05/05
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**43**;30 Apr 99
 ;
 ;Loop through the CIRN HL7 EXCEPTION LOG (#991.1) file.
 ;Find exceptions with EXCEPTION STATUS of NOT PROCESSED ("0").
 ;Get the TYPE which is a pointer to the CIRN HL7 EXCEPTION
 ;TYPE (#991.11) file.  If the TYPE is 209, 213, 214, or 218,
 ;mark the EXCEPTION STATUS to  PROCESSED ("1").  These exception
 ;types will not be generated in the future.
 ;
EXLOG ;
 ;If patch RG*1.0*43 has previously been installed, quit post-init.
 I $$PATCH^XPDUTL("RG*1.0*43") D BMES^XPDUTL(" Post-install previously ran; no need to reprocess file 991.1.") Q
 ;Else continue with post-init.
 ;
 D BMES^XPDUTL(" The post-init routine will retire selected exceptions in")
 D MES^XPDUTL(" the CIRN HL7 EXCEPTION LOG (#991.1) file.")
 ;
 N COUNT,DA,DIC,DIE,DR,EXNUM,EXCTYP,LOGIEN,X,Y,ZNODE
 S (LOGIEN,COUNT)=0
 F  S LOGIEN=$O(^RGHL7(991.1,LOGIEN)) Q:'LOGIEN  D
 .S EXNUM=0
 .F  S EXNUM=$O(^RGHL7(991.1,LOGIEN,1,EXNUM)) Q:'EXNUM  S ZNODE=$G(^(EXNUM,0)) I $P(ZNODE,"^",5)'=1 D  ;Quit if EXCEPTION STATUS (#6) equals 1 for PROCESSED
 ..S EXCTYP=$P(ZNODE,"^",3) ;Quit if TYPE is NOT one of these 4:
 ..;209 - Required field(s) missing for patient sent to MPI
 ..;213 - SSN Match Failed
 ..;214 - Name Doesn't Match
 ..;218 - Potential Matches Returned
 ..I $S(EXCTYP=209:0,EXCTYP=213:0,EXCTYP=214:0,EXCTYP=218:0,1:1) Q  ;TYPE is one of the four we want to mark as PROCESSED
 ..;
DIE ..;Update the EXCEPTION STATUS (#6) field to '1'.
 ..S DA(1)=LOGIEN,DA=EXNUM,DR="6///"_1
 ..S DIE="^RGHL7(991.1,"_DA(1)_",1,"
 ..L +^RGHL7(991.1,LOGIEN):10
 ..D ^DIE K DA,DIE,DR
 ..L -^RGHL7(991.1,LOGIEN)
 ..S COUNT=COUNT+1
 ;
 D BMES^XPDUTL(" A total of "_COUNT_" exceptions were retired.")
 D MES^XPDUTL(" Post-install routine completed successfully.")
 Q
