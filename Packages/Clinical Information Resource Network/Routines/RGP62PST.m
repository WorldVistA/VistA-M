RGP62PST ;OAK/ELZ-POST-INIT TO RETIRE #234 EXCEPTIONS ;9/29/2014
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**62**;30 Apr 99;Build 3
 ;
 ; Loop through the CIRN HL7 EXCEPTION LOG (#991.1) file "AC"
 ; cross reference for the 234 (Primary View Reject) exceptions.
 ; See if they are EXCEPTION STATUS of NOT PROCESSED ("0").
 ; Mark the EXCEPTION STATUS to PROCESSED ("1").
 ; Exception type 234 is obsolete.
 ;
EXLOG ;
 ;If patch RG*1.0*62 has previously been installed, quit post-init.
 I $$PATCH^XPDUTL("RG*1.0*62") D BMES^XPDUTL(" Post-install previously ran; no need to reprocess file 991.1 again.") Q
 ;
 D BMES^XPDUTL(" The post-init routine will retire Primary View Reject (234)")
 D MES^XPDUTL(" exceptions in the CIRN HL7 EXCEPTION LOG (#991.1) file.")
 ;
 N RGCOUNT,DA,DIE,DR,RGEXIEN,RGIEN,X,Y
 ;
 S (RGCOUNT,RGIEN)=0
 F  S RGIEN=$O(^RGHL7(991.1,"AC",234,RGIEN)) Q:'RGIEN  S RGEXIEN=0 F  S RGEXIEN=$O(^RGHL7(991.1,RGIEN,1,RGEXIEN)) Q:'RGEXIEN  D
 . ;
 . ; quit if processed
 . I $P(^RGHL7(991.1,RGIEN,1,RGEXIEN,0),"^",5)=1 Q
 . ;I RGCOUNT=3 W "." Q
 . ;
 . ;Update the EXCEPTION STATUS (#6) field to '1' - PROCESSED.
 . S DA(1)=RGIEN,DA=RGEXIEN,DR="6///1"
 . S DIE="^RGHL7(991.1,"_DA(1)_",1,"
 . L +^RGHL7(991.1,RGIEN):10
 . D ^DIE
 . L -^RGHL7(991.1,RGIEN)
 . S RGCOUNT=RGCOUNT+1
 ;
 D BMES^XPDUTL(" A total of "_RGCOUNT_" Primary View Reject exceptions were retired.")
 D MES^XPDUTL(" Post-install routine completed successfully.")
 Q
