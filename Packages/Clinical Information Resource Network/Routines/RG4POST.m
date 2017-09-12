RG4POST ;HIRMFO/GJC-POST-INIT DRIVER ;11/10/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**4**;30 Apr 99
 ;
 N RGCHK
 S RGCHK=$$NEWCP^XPDUTL("POST1","EN1^RG4POST")
 ;         Add RG ADT ENCOUNTER DRIVER (extended action protocol)
 ;         as an Item under DGPM MOVEMENT EVENTS & SDAM APPOINTMENT
 ;         EVENTS.
 ;
 S RGCHK=$$NEWCP^XPDUTL("POST2","EN2^RG4POST")
 ;         Task off the process (RGADT2) that seeds (adds data to
 ;         a null field) the DATE LAST TREATED (#.03) field and the
 ;         ADT/HL7 EVENT REASON (#.07) field in the TREATING FACILITY
 ;         LIST (#391.91) file.  Broadcasts MFU HL7 messages with the
 ;         data mentioned above (VAFCTFMF).
 ;
 S RGCHK=$$NEWCP^XPDUTL("POST4","EN4^RG4POST")
 ;         Add RG CIRN ADT to the HL7 APPLICATION PARAMETER (#.02)
 ;         field for all the entries in the ADT/HL7 EVENT REASON
 ;         (#391.72) file.
 ;
 QUIT
 ;
EN1 ; Add RG ADT ENCOUNTER DRIVER (extended action protocol) as
 ; an Item under DGPM MOVEMENT EVENTS & SDAM APPOINTMENT EVENTS
 K RGFDA,RGMSG N X0,X1,X2,Y0,Y1,Y2
 ; CIRN stuff
 S Y0="RG ADT ENCOUNTER DRIVER",X0=+$$FIND1^DIC(101,"","QX",Y0)
 I X0=0 D ERRMSG(Y0) Q
 ; PIMS stuff: SDAM APPOINTMENT EVENTS
 S Y1="SDAM APPOINTMENT EVENTS",X1=+$$FIND1^DIC(101,"","QX",Y1)
 I X1=0 D ERRMSG(Y1) Q
 ; DGPM MOVEMENT EVENTS
 S Y2="DGPM MOVEMENT EVENTS",X2=+$$FIND1^DIC(101,"","QX",Y2)
 I X2=0 D ERRMSG(Y2) Q
 ;
 ; add RG ADT ENCOUNTER DRIVER as an item under SDAM APPOINTMENT EVENTS
 S RGFDA(101.01,"+1,"_X1_",",.01)=Y0
 D:'$D(^ORD(101,X1,10,"B",X0)) UPDATE^DIE("E","RGFDA")
 I '$D(^ORD(101,X1,10,"B",X0)) D  ; issue error message
 . K RGMSG S RGMSG(1)=" ",RGMSG(2)="Error adding "_Y0_" as an"
 . S RGMSG(3)="item under "_Y1 D MES^XPDUTL(.RGMSG)
 . Q
 ; add RG ADT ENCOUNTER DRIVER as an item under DGPM MOVEMENT EVENTS
 S RGFDA(101.01,"+1,"_X2_",",.01)=Y0
 D:'$D(^ORD(101,X2,10,"B",X0)) UPDATE^DIE("E","RGFDA")
 I '$D(^ORD(101,X2,10,"B",X0)) D  ; issue error message
 . K RGMSG S RGMSG(1)=" ",RGMSG(2)="Error adding "_Y0_" as an"
 . S RGMSG(3)="item under "_Y2 D MES^XPDUTL(.RGMSG)
 . Q
 K RGFDA,RGMSG
 QUIT
 ;
EN2 ; Task off the process (RGADT2) that seeds (adds data to a null
 ; field) the DATE LAST TREATED (#.03) field in the TREATING FACILITY
 ; LIST (#391.91) file.  Admission and discharge dates are checked on
 ; the registration side (IN5^VADPT), and a status of 'check out' is
 ; what our software is looking for in the OUTPATIENT ENCOUNTER
 ; (#409.68) file.
 ;
 Q:'$D(^DPT("AICN"))  ; if MPI has not been loaded, quit
 Q:$P($G(^RGSITE(991.8,1,1)),"^",2)  ; seeding process ran in the past
 K RGMSG N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTIO="",ZTRTN="EN^RGADT2",ZTDESC="CIRN-CPRS: seed DATE LAST TREATED field (TREATING FACILITY LIST #391.91)"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT(),0,0,1,0) ; in future, one minute
 S:$D(XPDNM) ZTSAVE("XPD*")=""
 S:$D(RGDUZ) ZTSAVE("RGDUZ")=""
 D ^%ZTLOAD
 S RGMSG(1)=" ",RGMSG(2)="CIRN-CPRS: DATE LAST TREATED field seeding for the TREATING FACILITY"
 S RGMSG(3)="LIST (#391.91) file is running in background."
 S:$G(ZTSK)>0 RGMSG(4)="Task: "_ZTSK_"." D MES^XPDUTL(.RGMSG)
 K RGMSG,RGDUZ
 QUIT
 ;
EN4 ; Add RG CIRN ADT to the HL7 APPLICATION PARAMETER (#.02)
 ; field for all the entries in the ADT/HL7 EVENT REASON
 ; (#391.72) file.
 N RG771 S RG771=+$$FIND1^DIC(771,"","X","RG CIRN ADT")
 Q:'RG771  N DA,RGFDA ; quit if RG CIRN ADT cannot be found
 S DA=0 F  S DA=$O(^VAT(391.72,DA)) Q:'DA  D
 .S RGFDA(391.72,DA_",",.02)=RG771
 .D FILE^DIE("K","RGFDA") K RGFDA
 Q
 ;
ERRMSG(X) ; display an error message about missing protocols
 ; input: the name of the protocol missing
 K RGMSG S RGMSG(1)=" ",RGMSG(2)=X_" protocol is missing"
 S RGMSG(3)="from the host system.  Contact your "_$S($E(X,1,2)="RG":"CIRN",1:"PIMS")_" ADPAC."
 D MES^XPDUTL(.RGMSG)
 Q
