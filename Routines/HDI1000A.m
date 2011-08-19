HDI1000A ;BPFO/JRP - HDI v1.0 POST-INSTALL ROUTINE;2/17/2005
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
 ;
POST ;Main entry point for post-install routine
 ; Input: None
 ;        All variables set by Kernel for KIDS post-installs
 ;Output: None
 N HDIMSG
 S HDIMSG(1)=" "
 S HDIMSG(2)="~~~~~~~~~~~~~~~~~~~~"
 S HDIMSG(3)="Post-Installation (POST^HDI1000A) will now be run"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$SERVERS^HDI1000B() D PSTHALT Q
 I '$$ATTBUL^HDI1000B() D PSTHALT Q
 I '$$ATTREM^HDI1000B() D PSTHALT Q
 I '$$SYSPAR() D PSTHALT Q
 I '$$VUID() D PSTHALT Q
 S HDIMSG(1)=" "
 S HDIMSG(2)="Post-Installation ran to completion"
 S HDIMSG(3)="~~~~~~~~~~~~~~~~~~~~"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 Q
 ;
PSTHALT ;Print post-install halted text
 N HDIMSG
 S HDIMSG(1)=" "
 S HDIMSG(2)="*****"
 S HDIMSG(3)="***** Post-installation has been halted"
 S HDIMSG(4)="***** Please contact Enterprise VistA Support"
 S HDIMSG(5)="*****"
 S HDIMSG(6)=" "
 D MES^XPDUTL(.HDIMSG)
 Q
 ;
SYSPAR() ;Initialize HDIS System and HDIS Parameter files
 ; Input: None
 ;Output: 0 = Stop post-install (error)
 ;        1 = Continue with post-install
 N FACNUM,DOMAIN,SYSTYPE,X,SYSPTR,HDIMSG,PRAMPTR
 ;Determine system information
 S FACNUM=$$FACNUM^HDISVF01()
 S DOMAIN=$G(^XMB("NETNAME"))
 S SYSTYPE=$$PROD^XUPROD()
 S HDIMSG(1)=" "
 S HDIMSG(2)="The following information concerning this system has been"
 S HDIMSG(3)="determined and will be used to initialize the HDIS SYSTEM"
 S HDIMSG(4)="(#7118.21) and HDIS PARAMETER (#7118.29) files"
 S HDIMSG(5)=" "
 S HDIMSG(6)="  Facility Number: "_FACNUM
 S HDIMSG(7)="   MailMan Domain: "_DOMAIN
 S HDIMSG(8)="      System Type: "_$S(SYSTYPE:"Production",1:"Test")
 S HDIMSG(9)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Create entry in HDIS System file
 D BMES^XPDUTL("Creating entry in HDIS SYSTEM file")
 I '$$FINDSYS^HDISVF07(DOMAIN,FACNUM,SYSTYPE,1,.SYSPTR) D  Q 0
 .S HDIMSG(1)="**"
 .S HDIMSG(2)="** Unable to create entry"
 .S HDIMSG(3)="** Post-installation will be halted"
 .S HDIMSG(4)="**"
 .D MES^XPDUTL(.HDIMSG) K HDIMSG
 D MES^XPDUTL("Entry number "_SYSPTR_" created")
 ;Create entry in HDIS Parameter file
 D BMES^XPDUTL("Creating entry in HDIS PARAMETER file")
 S PRAMPTR=$$PARAMINI^HDISVF10(SYSPTR)
 I 'PRAMPTR D  Q 0
 .S HDIMSG(1)="**"
 .S HDIMSG(2)="** Unable to create entry"
 .S HDIMSG(3)="** Post-installation will be halted"
 .S HDIMSG(4)="**"
 .D MES^XPDUTL(.HDIMSG) K HDIMSG
 D MES^XPDUTL("Entry number "_PRAMPTR_" created")
 ;Done if this is not FORUM
 I DOMAIN'="FORUM.VA.GOV" Q 1
 ;This is FORUM - make it a server
 D BMES^XPDUTL("Making FORUM a server")
 D SETTYPE^HDISVF02(2,SYSPTR)
 I (+$$GETTYPE^HDISVF02(SYSPTR))'=2 D
 .S HDIMSG(1)="**"
 .S HDIMSG(2)="** Unable to change system type to SERVER"
 .S HDIMSG(3)="**"
 .D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Set Last Non-Standard VUID field
 I '$$GETNSVL^HDISVF03(SYSPTR) S X=$$SET^HDISVF02(7118.29,51,PRAMPTR_",",4536403,1)
 I '$$GETNSVL^HDISVF03(SYSPTR) D
 .S HDIMSG(1)="**"
 .S HDIMSG(2)="** Unable to set LAST NON-STANDARD VUID field to 4536403"
 .S HDIMSG(3)="**"
 .D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Set Ending Non-Standard VUID field
 I '$$GETNSVE^HDISVF03(SYSPTR) S X=$$SET^HDISVF02(7118.29,52,PRAMPTR_",",4636403,1)
 I '$$GETNSVE^HDISVF03(SYSPTR) D
 .S HDIMSG(1)="**"
 .S HDIMSG(2)="** Unable to set ENDING NON-STANDARD VUID field to 4636403"
 .S HDIMSG(3)="**"
 .D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Done
 Q 1
 ;
VUID() ;Instantiate VUIDs for set of code fields in Vitals domain
 ; Input: None
 ;Output: 0 = Stop post-install (error)
 ;        1 = Continue with post-install
 N HDIMSG
 S HDIMSG(1)=" "
 S HDIMSG(2)="Seeding XTID VUID FOR SET OF CODES file (#8985.1) with Vitals data"
 S HDIMSG(3)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$VUIDL("VITALS","HDI1000C") Q 0
 S HDIMSG(1)=" "
 S HDIMSG(2)="Seeding XTID VUID FOR SET OF CODES file (8985.1) with Allergy data"
 S HDIMSG(3)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$VUIDL("ALLERGY","HDI1000C") Q 0
 S HDIMSG(1)=" "
 S HDIMSG(2)="Seeding XTID VUID FOR SET OF CODES file (8985.1) with Lab & Pharmacy data"
 S HDIMSG(3)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$VUIDL("LABPHAR","HDI1000D") Q 0
 I '$$VUIDL("LABPHAR","HDI1000E") Q 0
 I '$$VUIDL("LABPHAR","HDI1000F") Q 0
 I '$$VUIDL("LABPHAR","HDI1000G") Q 0
 Q 1
 ;
VUIDL(TAG,ROUTINE) ;Instantiate VUIDs for set of code fields
 ; Input: TAG - Line tag under which VUID data has been placed
 ;        ROUTINE - Routine line tag is in
 ;                  Leave blank if in this routine
 ;Output: 0 = Stop post-install (error)
 ;        1 = Continue with post-install
 ; Notes: Data lines must be in the format
 ;          File~Field~Code~VUID~Status~EffectiveDateTime
 ;          (Status and EffectiveDateTime must be in internal format)
 ;          (Default value for Status is 0 - Inactive)
 ;          (Default value for EffectiveDateTime is NOW)
 ;      : Call assumes that all input (TAG & ROUTINE) is valid
 ;      : Call assumes that data lines are valid
 ;        (i.e. no missing/bad data)
 N OFFSET,DATA,FILE,FIELD,IREF,VUID,STAT,STDT,DONE,RESULT,HDIMSG
 S ROUTINE=$G(ROUTINE)
 S RESULT=1
 S DONE=0
 F OFFSET=1:1 D  Q:DONE
 .S DATA=$S(ROUTINE="":$T(@TAG+OFFSET),1:$T(@TAG+OFFSET^@ROUTINE))
 .S DATA=$P(DATA,";;",2)
 .I DATA="" S DONE=1 Q
 .S FILE=$P(DATA,"~",1)
 .S FIELD=$P(DATA,"~",2)
 .S IREF=$P(DATA,"~",3)
 .S VUID=$P(DATA,"~",4)
 .S STAT=$P(DATA,"~",5)
 .I STAT="" S STAT=0
 .S STDT=$P(DATA,"~",6)
 .I STDT="" S STDT=$$NOW^XLFDT()
 .I '$$STOREIT(FILE,FIELD,IREF,VUID,STAT,STDT) D
 ..S HDIMSG(1)="**"
 ..S HDIMSG(2)="** Unable to store VUID and/or status information for file"
 ..S HDIMSG(3)="** "_FILE_", field "_FIELD_", and internal value "_IREF
 ..S HDIMSG(4)="**"
 ..D MES^XPDUTL(.HDIMSG) K HDIMSG
 ..S RESULT=0
 Q RESULT
 ;
STOREIT(FILE,FIELD,IREF,VUID,STAT,STDT) ;Store VUID info
 ; Input : FILE - File number
 ;         FIELD - Field number
 ;         IREF - Internal reference
 ;         VUID - VUID
 ;         STAT - Status
 ;                0 = Inacive (default)     1 = Active
 ;         STDT - Status Date/Time (FileMan)
 ;                (Defaults to NOW)
 ;Output : 1 = Success
 ;         0 = Failure
 ; Notes : Existance/validity of input assumed (internal call)
 ;       : Call will automatically inactivate terms when appropriate
 ;
 N TMP,MASTER
 S STAT=+$G(STAT)
 S STDT=+$G(STDT)
 I 'STDT S STDT=$$NOW^XLFDT()
 ;Store VUID (also sets master entry flag, if appropriate)
 I '$$SETVUID^XTID(FILE,FIELD,IREF,VUID) Q 0
 ;Inactivate non-master entries
 I '$$GETMASTR^XTID(FILE,FIELD,IREF) D
 .S STAT=0
 .S STDT=$$NOW^XLFDT()
 ;Store status
 Q $$SETSTAT^XTID(FILE,FIELD,IREF,STAT,STDT)
