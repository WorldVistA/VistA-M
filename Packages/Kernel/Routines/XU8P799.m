XU8P799 ;BIR/JFW - XU*8.0*799 Post-Init ;04-Mar-2025 4:47 PM
 ;;8.0;KERNEL;**799**;Jul 10, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;**663 STORY 1203246 (jfw) - Create 'AVIAM' New Style X-REF in NEW PERSON (#200) file
 ;      STORY 1204295 (jfw) - Enable Auditing on NEW PERSON (#200) fields
 ;      STORY 1203257 (jfw) - Initialize # of Purge Days for File 8933.1 in File 8989.3 (Field #875)
 ;**799 STORY VAMPI-22625 (jfw) - Copied XU8P663 and adding new Cleanup processes
 ;
POST ;
 D BMES^XPDUTL("Post-Install: Starting")
 D XR  ;Create 'AVIAM' New Style X-REF in the NEW PERSON File (#200)
 D ENAUDIT  ;Enable auditing on fields in the NEW PERSON File (#200)
 D INITPRG  ;Initialize new field #875 in KERNEL SYSTEM PARAMETERS File (#8989.3)
 D MNTRFCU  ;**799 Story VAMPI-22625 (jfw) - NEW PERSON FIELD MONITOR (#8933.1) File Wipe (XU*8.0*663 CleanUp)
 D DELHMP  ;**799 Story VAMPI-22625 (mko) - Remove HMP XU EVENTS menu item from Kernel Options
 D QUECU  ;**799 Story VAMPI-22625 (jfw) - Name Components Clean Up Task
 D BMES^XPDUTL("Post-Install: Finished")
 Q
 ;
ENAUDIT ;Enable auditing on NEW PERSON (#200) fields)
 N XUI,XUENTRY
 D BMES^XPDUTL("   >> Enable AUDIT(ing) on the following NEW PERSON (#200) fields:")
 F XUI=2:1 S XUENTRY=$P($T(@"AUDITON"+XUI),";;",2) Q:(XUENTRY="")  D
 .D AUDIT($P(XUENTRY,"^",2),$P(XUENTRY,"^",3))
 Q
 ;
INITPRG ;Initialize # of days to keep records in File #8933.1 before Purging
 N XUDA,XUFDA,XUERR,XUMSG
 S XUDA=1  ;DD only supports having 1 record with ID of 1 in the file
 S XUFDA(8989.3,XUDA_",",875)=365  ;Default Purge (#875) of 8933.1 to 365 Days
 D FILE^DIE("K","XUFDA","XUERR")
 D:('$D(XUERR("DIERR")))
 .D BMES^XPDUTL("   >> NEW PERSON FIELD MONITOR PURGE initialized to 365 days in File #8989.3")
 D:($D(XUERR("DIERR")))
 .S XUMSG(1)=""
 .S XUMSG(2)="   >> The following error occurred updating Field #875 in file #8989.3"
 .S XUMSG(3)="        Error Code: "_$G(XUERR("DIERR",1))
 .S XUMSG(4)="              Text: "_$G(XUERR("DIERR",1,"TEXT",1))
 .S XUMSG(5)=""
 .S XUMSG(6)="      Re-execute Purge initialization D INITPRG^XU8P663 after resolving error(s)"
 .D BMES^XPDUTL(.XUMSG)
 Q
 ;
 ;Input:
 ;  XUFLD    - Field # to turn auditing for
 ;  XUFLDNME - Name of the Field
AUDIT(XUFLD,XUFLDNM) ;Turn on Auditing for Fields in NEW PERSON (#200) file
 D TURNON^DIAUTL(200,XUFLD)  ;DBIA #4397 Supported
 D MES^XPDUTL("        Field (#"_XUFLD_"): "_XUFLDNM)
 Q
 ;
XR ;Create 'AVIAM' New Style index type cross reference
 N DIERR,DIHELP,DIMSG,XUI,XUERR,XUFDA,XURES,XUOUT,XUXR
 S XUXR("FILE")=200
 S XUXR("NAME")="AVIAM"
 S XUXR("TYPE")="MU"
 S XUXR("USE")="A"
 S XUXR("EXECUTION")="R"
 S XUXR("ACTIVITY")="I"
 S XUXR("SHORT DESCR")="IAM User Provisioning Monitor for NEW PERSON (#200) fields."
 S XUXR("DESCR",1)="The AVIAM cross-reference (X-REF) is used to remember that"
 S XUXR("DESCR",2)="changes to the following fields were made to the NEW PERSON (#200) file:"
 S XUXR("DESCR",3)=" "
 S XUXR("DESCR",4)="      (.01)   NAME"
 S XUXR("DESCR",5)="      (.151)  EMAIL ADDRESS"
 S XUXR("DESCR",6)="      (4)     SEX"
 S XUXR("DESCR",7)="      (5)     DOB"
 S XUXR("DESCR",8)="      (7)     DISUSER"
 S XUXR("DESCR",9)="      (9)     SSN"
 S XUXR("DESCR",10)="      (9.2)   TERMINATION DATE"
 S XUXR("DESCR",11)="      (41.99) NPI"
 S XUXR("DESCR",12)="      (202)   LAST SIGN-ON DATE/TIME"
 S XUXR("DESCR",13)="      (205.1) SECID"
 S XUXR("DESCR",14)="      (205.2) SUBJECT ORGANIZATION"
 S XUXR("DESCR",15)="      (205.3) SUBJECT ORGANIZATION ID"
 S XUXR("DESCR",16)="      (205.4) UNIQUE USER ID"
 S XUXR("DESCR",17)="      (205.5) ADUPN"
 S XUXR("DESCR",18)="      (501.1) NETWORK USERNAME"
 S XUXR("DESCR",19)="      (201)   PRIMARY MENU OPTION"
 S XUXR("DESCR",20)=" "
 S XUXR("DESCR",21)="Execution of this X-REF will create (assuming an entry doesn't exist) or"
 S XUXR("DESCR",22)="update (entry exists) an entry in the NEW PERSON FIELD MONITOR (#8933.1) file"
 S XUXR("DESCR",23)="and mark it as requiring transmission/broadcast out."
 S XUXR("DESCR",24)=" "
 S XUXR("DESCR",25)="NOTE: The local variable 'XUIAMNPF' should be initialized to 1 if the 'AVIAM'"
 S XUXR("DESCR",26)="X-REF is NOT to be executed, because the entry is being initially 'ADD'ed to"
 S XUXR("DESCR",27)="the system."
 S XUXR("SET")="I ($T(AVIAM^XUIAMDD1)'="""") D AVIAM^XUIAMDD1(DUZ,DA,.X1,.X2)"
 S XUXR("KILL")="Q"
 S XUXR("WHOLE KILL")="Q"
 S XUXR("VAL",1)=.01
 S XUXR("VAL",1,"COLLATION")="F"
 S XUXR("VAL",2)=.151
 S XUXR("VAL",2,"COLLATION")="F"
 S XUXR("VAL",3)=4
 S XUXR("VAL",3,"COLLATION")="F"
 S XUXR("VAL",4)=5
 S XUXR("VAL",4,"COLLATION")="F"
 S XUXR("VAL",5)=7
 S XUXR("VAL",5,"COLLATION")="F"
 S XUXR("VAL",6)=9
 S XUXR("VAL",6,"COLLATION")="F"
 S XUXR("VAL",7)=9.2
 S XUXR("VAL",7,"COLLATION")="F"
 S XUXR("VAL",8)=41.99
 S XUXR("VAL",8,"COLLATION")="F"
 S XUXR("VAL",9)=202
 S XUXR("VAL",9,"COLLATION")="F"
 S XUXR("VAL",10)=205.1
 S XUXR("VAL",10,"COLLATION")="F"
 S XUXR("VAL",11)=205.2
 S XUXR("VAL",11,"COLLATION")="F"
 S XUXR("VAL",12)=205.3
 S XUXR("VAL",12,"COLLATION")="F"
 S XUXR("VAL",13)=205.4
 S XUXR("VAL",13,"COLLATION")="F"
 S XUXR("VAL",14)=205.5
 S XUXR("VAL",14,"COLLATION")="F"
 S XUXR("VAL",15)=501.1
 S XUXR("VAL",15,"COLLATION")="F"
 S XUXR("VAL",16)=201
 S XUXR("VAL",16,"COLLATION")="F"
 D CREIXN^DDMOD(.XUXR,"K",.XURES,"XUOUT","XUERR")
 ;
 I $D(DIERR) D  Q
 .D BMES^XPDUTL("   >> A problem has occurred during the creation of x-ref ""AVIAM""!")
 .D MES^XPDUTL("      Please contact Customer Support.")
 .S XUI="" F  S XUI=$O(XUERR("DIERR",1,"TEXT",XUI)) Q:XUI=""  D MES^XPDUTL(XUERR("DIERR",1,"TEXT",XUI))
 ;
 ;CREIXN^DDMOD wasn't updated to include the RE-INDEXING field (#666) of the INDEX file (#.11)
 S XUFDA(.11,+XURES_",",666)=1
 D FILE^DIE("","XUFDA","XUERR")
 ;
 D MES^XPDUTL("   >> ""AVIAM"" cross-reference index created...")
 Q
 ;
MNTRFCU ;**799 Story VAMPI-22625 (jfw) - NEW PERSON FIELD MONITOR File #8933.1 Clean-Up
 ;Don't reset 8933.1 after patch has been installed!
 Q:($$PATCH^XPDUTL("XU*8.0*799"))  ;Supported DBIA #10141
 L +^XTV(8933.1):30
 K ^XTV(8933.1)  ;Remove all data from file
 S:('$D(^XTV(8933.1,0))) ^XTV(8933.1,0)="NEW PERSON FIELD MONITOR^8933.1D^0^0"
 L -^XTV(8933.1)
 D BMES^XPDUTL("   >> NEW PERSON FIELD MONITOR (#8933.1) File has been reset!")
 Q
 ;
DELHMP ;**799 Story VAMPI-22625 (mko) - Remove HMP XU EVENTS menu item from Kernel Options
 N DA,DIK,XUHMP,XUHMPIEN,XUITEMIEN,XUOPTIEN,XUOPTNM
 ;Build XUHMP(ien)="", where ien=ien of HMP XU EVENTS option (there should be only one)
 S XUHMPIEN="" F  S XUHMPIEN=$O(^DIC(19,"B","HMP XU EVENTS",XUHMPIEN)) Q:XUHMPIEN'>0  S XUHMP(XUHMPIEN)=""
 ;For each of the three Kernel options, find the HMP XU EVENTS menu item and delete it.
 F XUOPTNM="XU USER ADD","XU USER CHANGE","XU USER TERMINATE" D
 .S XUOPTIEN="" F  S XUOPTIEN=$O(^DIC(19,"B",XUOPTNM,XUOPTIEN)) Q:XUOPTIEN'>0  D
 ..S XUHMPIEN="" F  S XUHMPIEN=$O(XUHMP(XUHMPIEN)) Q:XUHMPIEN'>0  D
 ...S XUITEMIEN="" F  S XUITEMIEN=$O(^DIC(19,XUOPTIEN,10,"B",XUHMPIEN,XUITEMIEN)) Q:XUITEMIEN'>0  D
 ....S DIK="^DIC(19,"_XUOPTIEN_",10,",DA(1)=XUOPTIEN,DA=XUITEMIEN
 ....D ^DIK
 D BMES^XPDUTL("   >> Obsolete HMP XU EVENTS menu item removed from Kernel options!")
 Q
 ;
QUECU ;**799 Story VAMPI-22625 (jfw) - Name Component Clean Up Task
 N ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTREQ,ZTSK,ZTDTH
 S ZTRTN="EN663CU^XU8P799",ZTDESC="XU*8.0*779 Post-Init Name Component Clean Up Task"
 S ZTIO="",ZTDTH=$H
 I $D(DUZ) S ZTSAVE("DUZ")=DUZ
 D ^%ZTLOAD
 D BMES^XPDUTL("   >> Name Component Clean-Up Task #"_ZTSK_" has been queued!")
 Q
 ;
EN663CU ;**799 Story VAMPI-22625 (jfw) - Name Component Clean Up Task Entry Point
 N XUCNT,XUSTRT,XUEND
 S XUSTRT=$$NOW^XLFDT
 D NCOMPCU(.XUCNT)  ;Missing or Dangling Ptrs to NAME COMPONENTS (#20) File Clean-Up
 S XUEND=$$NOW^XLFDT
 D EMAIL(.XUCNT,XUSTRT,XUEND)
 Q
 ;
NCOMPCU(XUCNT) ;**799 Story VAMPI-22625 (jfw) - File #20 Clean-up
 N XURECS,XUPRECS,DA,XUNCPTR
 S XURECS=0,XUPRECS=0,DA=0
 F  S DA=$O(^VA(200,DA)) Q:'+DA  D
 .S XURECS=XURECS+1,XUNCPTR=+$G(^VA(200,DA,3.1))
 .I $S('XUNCPTR:1,'$D(^VA(20,XUNCPTR)):1,1:0),($P($G(^VA(200,DA,0)),"^",1)'="") D
 ..D CHKPTR^XLFNAME2  ;Update Name Components File (#20) if invalid/missing
 ..S XUPRECS=XUPRECS+1
 S XUCNT("NPRECS")=XURECS,XUCNT("NPRECSUP")=XUPRECS
 Q
 ;
EMAIL(XUCNT,XUSTRT,XUEND) ;*799 Story VAMPI-22625 (jfw) - Clean-Up Results Email
 N XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,XUMSG,XUSTN
 S XUSTN=$$SITE^VASITE(),XUSTN=$P(XUSTN,"^",3)_" ("_$P(XUSTN,"^",2)_")"
 S XUMSG(1)="Post-Init routine XU8P799 has completed performing the"
 S XUMSG(2)="required Name Component Clean-Up."
 S XUMSG(3)=" "
 S XUMSG(4)="Process Started: "_$$FMTE^XLFDT(XUSTRT)_" / Completed: "_$$FMTE^XLFDT(XUEND)_" / "
 S XUMSG(5)="Processing Time [DD HH:MM:SS]: "_$$FMDIFF^XLFDT(XUEND,XUSTRT,3)
 S XUMSG(6)=" "
 S XUMSG(7)="Number of NEW PERSON Records: "_$FN(XUCNT("NPRECS"),",")
 S XUMSG(8)="    >> with NAME COMPONENTS issues: "_$FN(XUCNT("NPRECSUP"),",")
 S XMSUB="Name Component Clean-Up : XU*8.0*799 - "_XUSTN
 S XMTEXT="XUMSG(",XMDUZ=.5,XMY(DUZ)=""
 S XMY("VAIDSMPIDEVELOPERS@DOMAIN.EXT")=""
 D ^XMD
 Q
 ;
AUDITON ;List of NEW PERSON (#200) fields to audit
 ;;FILE^FIELD #^FIELD NAME
 ;;200^.151^EMAIL ADDRESS
 ;;200^41.98^NPI ENTRY STATUS
 ;;200^41.99^NPI
 ;;200^205.1^SECID
 ;;200^205.2^SUBJECT ORGANIZATION
 ;;200^205.3^SUBJECT ORGANIZATION ID
 ;;200^205.4^UNIQUE USER ID
 ;;200^205.5^ADUPN
 ;;200^501.1^NETWORK USERNAME
 ;;
