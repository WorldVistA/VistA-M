HDISVF10 ;BPFO/JRP -  FILE UTILITIES/API;2/3/2005
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
 ;---------- Begin HDIS PARAMETER file (#7118.29) APIs ----------
 ;
PARAMINI(SYSPTR,FACNUM,DOMAIN,SYSTYPE,USESYS) ;Initialize parameters for system
 ; Input : SYSPTR - Pointer to HDIS System file (optional)
 ;         FACNUM - Facility number (defaults to local number)
 ;         DOMAIN - Domain/IP address (defaults to local system)
 ;         SYSTYPE - Flag indicating type of system
 ;                   1 = Production    0 = Test
 ;                   Defaults to current system type
 ;         USESYS - Flag indicating if information from HDIS System
 ;                  file should be used instead of default values
 ;                  0 = No (default)     1 = Yes
 ;Output : Pointer to HDIS Parameter file
 ; Notes : 0 is returned if an entry can not be initialized
 N FAC,HDISFDA,HDISMSG,IENS,PRMDOM,OK
 S SYSPTR=$G(SYSPTR)
 S FAC=$$GETPTR(.SYSPTR,$G(FACNUM),$G(DOMAIN),$G(SYSTYPE),1)
 I 'FAC Q 0
 S PRMDOM="FORUM.VA.GOV"
 ;Get info from system
 S OK=1
 I $G(USESYS) D
 .K PRMDOM
 .S OK=$$GETDIP^HDISVF07(SYSPTR,.PRMDOM)
 ;Problem pulling from system
 I 'OK Q 0
 S IENS=FAC_","
 K HDISFDA,HDISMSG
 S HDISFDA(7118.29,IENS,.02)="CLIENT"
 S HDISFDA(7118.29,IENS,11)="NO"
 S HDISFDA(7118.29,IENS,12)=PRMDOM
 S HDISFDA(7118.29,IENS,13)="MAILMAN"
 S HDISFDA(7118.29,IENS,21)="HDIS-FACILITY-DATA-SERVER"
 S HDISFDA(7118.29,IENS,31)="NO"
 S HDISFDA(7118.29,IENS,32)=PRMDOM
 S HDISFDA(7118.29,IENS,33)="MAILMAN"
 S HDISFDA(7118.29,IENS,41)="HDIS-STATUS-UPDATE-SERVER"
 D FILE^DIE("E","HDISFDA","HDISMSG")
 Q FAC
 ;
GETPTR(SYSPTR,FACNUM,DOMAIN,SYSTYPE,LAYGO) ;Get pointer to HDIS Parameter file
 ; Input : SYSPTR - Pointer to HDIS System file (optional)
 ;         FACNUM - Facility number (defaults to local number)
 ;         DOMAIN - Domain/IP address (defaults to local system)
 ;         SYSTYPE - Flag indicating type of system
 ;                   1 = Production    0 = Test
 ;                   Defaults to current system type
 ;         LAYGO - Flag indicating if an entry for the system should
 ;                 be created if one is not found
 ;                 0 = No (don't create) (default)     1 = Yes
 ;Output : Pointer to HDIS PARAMETER file
 ; Notes : 0 is returned if an entry is not found
 ;       : If SYSPTR is not passed, then FACNUM, DOMAIN, and TESTSYS
 ;         will be used to find the HDIS System file entry
 N X,PTR,HDISMSG,HDISIEN,HDISFDA
 S SYSPTR=+$G(SYSPTR)
 S LAYGO=+$G(LAYGO)
 ;Find entry in HDIS System file
 I 'SYSPTR D
 .K SYSPTR
 .S FACNUM=$G(FACNUM)
 .I 'FACNUM S FACNUM=$$FACNUM^HDISVF01()
 .S DOMAIN=$G(DOMAIN)
 .I DOMAIN="" S DOMAIN=$G(^XMB("NETNAME"))
 .S SYSTYPE=$G(SYSTYPE)
 .I SYSTYPE="" S SYSTYPE=$$PROD^XUPROD()
 .S X=$$FINDSYS^HDISVF07(DOMAIN,FACNUM,SYSTYPE,LAYGO,.SYSPTR)
 I '$G(SYSPTR) Q 0
 ;Find entry in HDIS Parameter file
 S PTR=$$FIND1^DIC(7118.29,,"QX",SYSPTR,"B",,"HDISMSG")
 I PTR Q PTR
 I 'LAYGO Q 0
 ;Create entry
 S HDISFDA(7118.29,"+1,",.01)=SYSPTR
 S HDISIEN(1)=SYSPTR
 D UPDATE^DIE("","HDISFDA","HDISIEN","HDISMSG")
 I $D(HDISMSG) Q 0
 S PTR=HDISIEN(1)
 Q PTR
 ;
 ;---------- End HDIS PARAMETER file APIs ----------
