EDP22PST ;SLC/BWF - Post-init for facility install ;9/3/13 11:08am
 ;;2.0;EMERGENCY DEPARTMENT;**2**;Feb 24, 2012;Build 23
 ;
 D ROLES
 Q
 ;
ROLES ; add Resident and Nurse roles to 'Edit Closed' worksheet
 N WSIEN,NURIEN,RESIEN
 S WSIEN=$O(^EDPB(232.6,"B","Edit Closed",0)) Q:'WSIEN
 S NURIEN=$O(^EDPB(232.5,"C","N",0)) I NURIEN D ADD(WSIEN,NURIEN)
 S RESIEN=$O(^EDPB(232.5,"C","R",0)) I RESIEN D ADD(WSIEN,RESIEN)
 Q
ADD(WSIEN,IEN) ;
 ; do not add this role if it is already here
 Q:$D(^EDPB(232.6,WSIEN,3,"B",IEN))
 S FDA(232.63,"+1,"_WSIEN_",",.01)=IEN
 D UPDATE^DIE(,"FDA") K FDA
 Q
