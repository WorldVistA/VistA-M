HDI1000B ;BPFO/JRP - HDI v1.0 POST-INSTALL ROUTINE (CONT);2/23/2005
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
SERVERS() ;Fix server options (they need resource devices)
 ; Input: None
 ;Output: 0 = Stop post-install (error)
 ;        1 = Continue with post-install
 N SRVR,RSRC,HDIMSG
 ;Fix VUID Server option
 S SRVR="HDIS-FACILITY-DATA-SERVER"
 S RSRC="HDIS VUID RESOURCE DEVICE"
 S HDIMSG(1)=" "
 S HDIMSG(2)="Making "_RSRC_" the resource device"
 S HDIMSG(3)="for "_SRVR
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$FIXSRVR(SRVR,RSRC) Q 0
 ;Fix Status Server option
 S SRVR="HDIS-STATUS-UPDATE-SERVER"
 S RSRC="HDIS STATUS RESOURCE DEVICE"
 S HDIMSG(1)=" "
 S HDIMSG(2)="Making "_RSRC_" the resource device"
 S HDIMSG(3)="for "_SRVR
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$FIXSRVR(SRVR,RSRC) Q 0
 ;Done
 Q 1
 ;
FIXSRVR(SRVR,RSRC) ;Fix server option
 ; Input: SRVR - Name of server option
 ;        RSRC - Name of resource device
 ;Output: 1 = Success     0 = Error/bad input
 ; Notes: Call assumes that all input have values
 N HDIMSG,PTRSRVR,PTRRSRC
 S SRVR=$G(SRVR)
 S RSRC=$G(RSRC)
 ;Find option
 S PTRSRVR=$$PTROPT(SRVR)
 I 'PTRSRVR D  Q 0
 .I SRVR="" S SRVR="<null>"
 .S HDIMSG(1)="**"
 .S HDIMSG(2)="** Unable to find "_SRVR_" in the OPTION file (#19)"
 .S HDIMSG(3)="** Post-installation will be halted"
 .S HDIMSG(4)="**"
 .D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Create/find resource device
 S PTRRSRC=$$CR8RD(RSRC,1)
 I 'PTRRSRC D  Q 0
 .I RSRC="" S RSRC="<null>"
 .S HDIMSG(1)="**"
 .S HDIMSG(2)="** Unable to find/create "_RSRC_" in the DEVICE file (#3.5)"
 .S HDIMSG(3)="** Post-installation will be halted"
 .S HDIMSG(4)="**"
 .D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Attach resource device to server
 I '$$RD4OPT(PTRRSRC,PTRSRVR) D  Q 0
 .S HDIMSG(1)="**"
 .S HDIMSG(2)="** Unable to add "_RSRC_" as the resource"
 .S HDIMSG(3)="** device for server option "_SRVR
 .S HDIMSG(4)="** Post-installation will be halted"
 .S HDIMSG(5)="**"
 .D MES^XPDUTL(.HDIMSG) K HDIMSG
 Q 1
 ;
CR8RD(NAME,SLOTS) ;Create resource device
 ; Input: NAME - Name of resource device to create
 ;        SLOTS - Number of resource slots (defaults to 1)
 ;Output: Pointer to resource device (DEVICE file)
 ;        0 will be returned on error/bad input
 ; Notes: If the device NAME already exists, the pointer to that device
 ;        will be returned.  The definition of the device will not be
 ;        checked and/or modified.
 S NAME=$G(NAME)
 I NAME="" Q 0
 S SLOTS=+$G(SLOTS)
 I SLOTS<1 S SLOTS=1
 N PTRDVC,HDIMSG
 ;Device alread exist - return pointer to it
 S PTRDVC=$$FIND1^DIC(3.5,"","X",NAME,"B","","HDIMSG")
 I PTRDVC Q PTRDVC
 ;Create resource device
 S PTRDVC=+$$RES^XUDHSET(NAME,NAME,SLOTS)
 I PTRDVC<1 S PTRDVC=0
 Q PTRDVC
 ;
PTROPT(NAME) ;Get pointer to option
 ; Input: NAME - Option name
 ;Output: Pointer to OPTION file (#19)
 ; Notes: 0 returned when option not found
 N PTROPT,HDIMSG
 S PTROPT=$$FIND1^DIC(19,"","X",$G(NAME),"B","","HDIMSG")
 I $D(HDIMSG) Q 0
 Q PTROPT
 ;
RD4OPT(PTRDVC,PTROPT) ;Attach resource device to option
 ; Input: PTRDVC - Pointer to DEVICE file (#3.5)
 ;        PTROPT - Pointer to OPTION file (#19)
 ;Output: 1 = Success     0 = Error/Bad input
 ; Notes: Call assumes all input exists and is valid
 N HDIFDA,HDIMSG
 S PTRDVC=+$G(PTRDVC)
 I 'PTRDVC Q 0
 S PTROPT=+$G(PTROPT)
 I 'PTROPT Q 0
 S HDIFDA(19,PTROPT_",",227)=PTRDVC
 D FILE^DIE("","HDIFDA","HDIMSG")
 I $D(HDIMSG) Q 0
 Q 1
 ;
ATTBUL() ;Attach HDIS Mail Groups to HDIS Bulletins
 N HDISBIEN,HDISBNM,HDISERRF,HDISFDA,HDISGIEN,HDISGNM,HDISLNE,HDISMSG,HDISTXT
 K HDIMSG
 D BMES^XPDUTL("Attaching HDIS Mail Groups to HDIS Bulletins")
 F HDISLNE=1:1 S HDISTXT=$P($T(BULGRP+HDISLNE),";;",2) Q:HDISTXT="END"!($G(HDISERRF))  D
 . S HDISBNM=$P(HDISTXT,"^",1)
 . S HDISBIEN=$$FIND1^DIC(3.6,"","X",HDISBNM,"","","")
 . S HDISGNM=$P(HDISTXT,"^",2)
 . S HDISGIEN=$$FIND1^DIC(3.8,"","X",HDISGNM,"","","")
 . ;If Bulletin or Mail Group not found, error
 . I HDISBIEN'>0!(HDISGIEN'>0) D
 . . S HDIMSG(1)="**"
 . . S HDIMSG(2)="** Bulletin "_HDISBNM_" or Mail Group "_HDISGNM_" not found"
 . . D MES^XPDUTL(.HDIMSG) K HDIMSG
 . . S HDISERRF=1
 . ELSE  D
 . . ;Attach Mail Group to Bulletin
 . . N HDISFDA,HDISIEN,HDISMSG
 . . S HDISFDA(3.62,"?+2,"_HDISBIEN_",",.01)=HDISGIEN
 . . D UPDATE^DIE("","HDISFDA","HDISIEN","HDISMSG")
 . . ;Check for error
 . . I $D(HDISMSG("DIERR")) D
 . . . S HDIMSG(1)="**"
 . . . S HDIMSG(2)="** Unable to attach "_HDISGNM_" to "_HDISBNM
 . . . D MES^XPDUTL(.HDIMSG) K HDIMSG
 . . . S HDISERRF=1
 . . ELSE  D
 . . . S HDIMSG(1)=" "
 . . . S HDIMSG(2)=".."_HDISGNM_" Mail Group"_$S($G(HDISIEN(2,0))="?":" already",1:"")_" attached to "_HDISBNM_" Bulletin"
 . . . D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Check for error
 I $G(HDISERRF) D
 . S HDIMSG(1)="** Post-installation will be halted"
 . S HDIMSG(2)="**"
 . D MES^XPDUTL(.HDIMSG) K HDIMSG
 Q +$S($G(HDISERRF):0,1:1)
 ;
BULGRP ;Bulletin Name^Mail Group Name
 ;;HDIS ERRORS^HDIS ERRORS
 ;;HDIS NOTIFY ERT^HDIS ERT NOTIFICATION
 ;;HDIS NOTIFY HDR^HDIS HDR NOTIFICATION
 ;;HDIS XML MSG PROCESS ERROR^HDIS ERRORS
 ;;END
 ;
ATTREM() ;Attach HDIS Remote Members to HDIS Mail Groups
 N HDISERRF,HDISFDA,HDISGIEN,HDISGNM,HDISLNE,HDISMSG,HDISRNM,HDISTXT
 K HDIMSG
 D BMES^XPDUTL("Attaching HDIS Remote Members to HDIS Mail Groups")
 F HDISLNE=1:1 S HDISTXT=$P($T(REMMEM+HDISLNE),";;",2) Q:HDISTXT="END"!($G(HDISERRF))  D
 . S HDISGNM=$P(HDISTXT,"^",1)
 . S HDISGIEN=$$FIND1^DIC(3.8,"","X",HDISGNM,"","","")
 . S HDISRNM=$P(HDISTXT,"^",2)
 . ;If Mail Group not found, error
 . I HDISGIEN'>0 D
 . . S HDIMSG(1)="**"
 . . S HDIMSG(2)="** Mail Group "_HDISGNM_" not found"
 . . D MES^XPDUTL(.HDIMSG) K HDIMSG
 . . S HDISERRF=1
 . ELSE  D
 . . ;Attach Remote Member to Mail Group
 . . N HDISFDA,HDISIEN,HDISMSG
 . . S HDISFDA(3.812,"?+2,"_HDISGIEN_",",.01)=HDISRNM
 . . D UPDATE^DIE("","HDISFDA","HDISIEN","HDISMSG")
 . . ;Check for error
 . . I $D(HDISMSG("DIERR")) D
 . . . S HDIMSG(1)="**"
 . . . S HDIMSG(2)="** Unable to attach "_HDISRNM_" to "_HDISGNM
 . . . D MES^XPDUTL(.HDIMSG) K HDIMSG
 . . . S HDISERRF=1
 . . ELSE  D
 . . . S HDIMSG(1)=" "
 . . . S HDIMSG(2)=".."_HDISRNM_$S($G(HDISIEN(2,0))="?":" already",1:"")_" attached to "_HDISGNM
 . . . D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Check for error
 I $G(HDISERRF) D
 . S HDIMSG(1)="** Post-installation will be halted"
 . S HDIMSG(2)="**"
 . D MES^XPDUTL(.HDIMSG) K HDIMSG
 Q +$S($G(HDISERRF):0,1:1)
 ;
REMMEM ;Mail Group Name^Remote Member
 ;;HDIS ERRORS^G.HDIS ERRORS@FORUM.VA.GOV
 ;;HDIS ERT NOTIFICATION^G.HDIS ERRORS@FORUM.VA.GOV
 ;;HDIS ERT NOTIFICATION^G.HDIS ERT NOTIFICATION@FORUM.VA.GOV
 ;;HDIS HDR NOTIFICATION^G.HDIS HDR NOTIFICATION@FORUM.VA.GOV
 ;;END
