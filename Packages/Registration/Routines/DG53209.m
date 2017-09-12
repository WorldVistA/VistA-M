DG53209 ;BP-CIOFO/JRP - KIDS INSTALL ROUTINE FOR DG*5.3*209;8/25/98
 ;;5.3;Registration;**209**;Aug 13, 1993
 ;
ENV ;Environment check
 N DG53209
 ;Check for existance of required domain
 Q:$$FIND1^DIC(4.2,,"QX","Q-NPP.DOMAIN.EXT","B",,"DG53209")
 ;Required domain not found
 W !
 W !,"***"
 W !,"***  Installation of this patch requires that the domain"
 W !,"***  Q-NPP.DOMAIN.EXT be defined.  Installation aborted."
 W !,"***"
 W !
 S XPDQUIT=1
 Q
 ;
PRE ;Pre-init
 ;Turn off ADT/R HL7 messaging
 D BMES^XPDUTL("Disabling PIMS v2.3 messages")
 D STOP23^VAFHPOST
 Q
 ;
POST ;Post-init
 N PROT,PROTFIX,DG53209,OFFSET,CLIENT,SERVER
POST1 ;Make sure required ADT-Axx protocols are enabled
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Ensuring that required HL7 protocols are enabled")
 F OFFSET=1:1 S PROT=$P($T(DATA1+OFFSET),";;",2) Q:(PROT="")  D
 .S PROTFIX=$$PROTON(PROT)
 .S DG53209=PROT_$S(('PROTFIX):" could not be ",1:" ")_"enabled"
 .S DG53209="  "_$S(('PROTFIX):"** ",1:"")_DG53209
 .D MES^XPDUTL(DG53209)
POST2 ;Remove subscription of VAFC ADT-xxx CLIENT to VAFC ADT-xxx SERVER
 I ('$G(XPDQUES("POS-REMOVE-SUBSCRIPTION"),1)) G POST3
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Removing subscription of VAFC ADT-xxx CLIENT to VAFC ADT-xxx SERVER")
 F OFFSET=1:1 S PROT=$P($T(DATA2+OFFSET),";;",2) Q:(PROT="")  D
 .S CLIENT=$P(PROT,"^",1)
 .S SERVER=$P(PROT,"^",2)
 .S PROTFIX=$$UNSUB(CLIENT,SERVER)
 .S DG53209=CLIENT_$S(('PROTFIX):" could not be ",1:" ")_"removed from "
 .S DG53209="  "_$S(('PROTFIX):"*** ",1:"")_DG53209_SERVER
 .D MES^XPDUTL(DG53209)
POST3 ;Turn on ADT/R HL7 messaging
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Enabling PIMS v2.3 messages")
 D SEND23^VAFHPOST
 Q
 ;
PROTON(NAME) ;Enable protocol
 ;Input  : NAME - Name of protocol
 ;Output : 1 - Protocol enabled
 ;         0 - Protocol couldn't be enabled
 ;
 Q:($G(NAME)="") 0
 N PTR101,FDAROOT,MSGROOT,IENS
 S FDAROOT=$NA(^TMP("FDAROOT",$J))
 S MSGROOT=$NA(^TMP("DIERR",$J))
 K @FDAROOT,@MSGROOT
 ;Find entry in PROTOCOL file (#101)
 S PTR101=$$FIND1^DIC(101,,"X",NAME,"B",,MSGROOT)
 ;Not found
 I ('PTR101) K @FDAROOT,@MSGROOT Q 0
 ;Enable protocol - delete text from DISABLE field (#2)
 K @FDAROOT,@MSGROOT
 S IENS=PTR101_","
 S @FDAROOT@(101,IENS,2)="@"
 D FILE^DIE("S",FDAROOT,MSGROOT)
 ;Error
 I ($D(@MSGROOT)) K @FDAROOT,@MSGROOT Q 0
 K @FDAROOT,@MSGROOT
 Q 1
 ;
UNSUB(CLIENT,SERVER) ;Remove subscription of client from server
 ;Input  : CLIENT - Name of HL7 client protocol
 ;         SERVER - Name of HL7 server protocol
 ;Output : 1 - Success (subscription removed)
 ;         0 - Failure (subscription not removed)
 ;
 ;Bad input
 Q:(($G(CLIENT)="")!($G(SERVER)="")) 0
 ;Declare variables
 N PTR101,FDAROOT,MSGROOT,IENS
 S FDAROOT=$NA(^TMP("FDAROOT",$J))
 S MSGROOT=$NA(^TMP("DIERR",$J))
 K @FDAROOT,@MSGROOT
 ;Find server in PROTOCOL file (#101)
 S PTR101=$$FIND1^DIC(101,,"X",SERVER,"B",,MSGROOT)
 ;Not found (return failure)
 I ('PTR101) K @FDAROOT,@MSGROOT Q 0
 ;Find client in ITEM multiple (#10) of server protocol
 S IENS=","_PTR101_","
 S PTR101M=$$FIND1^DIC(101.01,IENS,"X",CLIENT,"B",,MSGROOT)
 ;Not found (return success)
 I ('PTR101M) K @FDAROOT,@MSGROOT Q 1
 ;Remove client from ITEM multiple
 S IENS=PTR101M_","_PTR101_","
 S @FDAROOT@(101.01,IENS,.01)="@"
 K @MSGROOT
 D FILE^DIE("",FDAROOT,MSGROOT)
 ;Failure
 I ($D(@MSGROOT)) K @FDAROOT,@MSGROOT Q 0
 ;Success
 K @FDAROOT,@MSGROOT
 Q 1
 ;
 ;
DATA1 ;
 ;;VAFC ADT-A01 SERVER
 ;;VAFC ADT-A02 SERVER
 ;;VAFC ADT-A03 SERVER
 ;;VAFC ADT-A04 SERVER
 ;;VAFC ADT-A08 SERVER
 ;;VAFC ADT-A08-TSP SERVER
 ;;VAFC ADT-A11 SERVER
 ;;VAFC ADT-A12 SERVER
 ;;VAFC ADT-A13 SERVER
 ;;DG PTF ADT-A01 CLIENT
 ;;DG PTF ADT-A02 CLIENT
 ;;DG PTF ADT-A03 CLIENT
 ;;DG PTF ADT-A04 CLIENT
 ;;DG PTF ADT-A08 CLIENT
 ;;DG PTF ADT-A08-TSP CLIENT
 ;;DG PTF ADT-A11 CLIENT
 ;;DG PTF ADT-A12 CLIENT
 ;;DG PTF ADT-A13 CLIENT
 ;;
 ;
 ;
DATA2 ;;Client Protocol^Server Protocol
 ;;VAFC ADT-A01 CLIENT^VAFC ADT-A01 SERVER
 ;;VAFC ADT-A02 CLIENT^VAFC ADT-A02 SERVER
 ;;VAFC ADT-A03 CLIENT^VAFC ADT-A03 SERVER
 ;;VAFC ADT-A04 CLIENT^VAFC ADT-A04 SERVER
 ;;VAFC ADT-A08 CLIENT^VAFC ADT-A08 SERVER
 ;;VAFC ADT-A08-SCHED CLIENT^VAFC ADT-A08-SCHED SERVER
 ;;VAFC ADT-A08-SDAM CLIENT^VAFC ADT-A08-SDAM SERVER
 ;;VAFC ADT-A08-TSP CLIENT^VAFC ADT-A08-TSP SERVER
 ;;VAFC ADT-A11 CLIENT^VAFC ADT-A11 SERVER
 ;;VAFC ADT-A12 CLIENT^VAFC ADT-A12 SERVER
 ;;VAFC ADT-A13 CLIENT^VAFC ADT-A13 SERVER
 ;;VAFC ADT-A19 CLIENT^VAFC ADT-A19 SERVER
 ;;
