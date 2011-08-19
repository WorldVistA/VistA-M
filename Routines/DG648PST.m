DG648PST ;BIR/CMC-PATCH DG*5.3*648 POST INSTALLATION ROUTINE ;2/11/05
 ;;5.3;Registration;**648**;Aug 13, 1993
 ;
POST ;Post init
 N DGFLD,DGMFLD,DGOUT,DGFILE
 ;File cross references
 D XR(2,.525) ;POW STATUS INDICATED?
 ;;D XR(2.0361,.01) ;PATIENT ELIGIBILITIES MULTIPLE ELIGIBILITY FIELD -- MOVED TO DG*5.3*691
 D TEMPL
 ;fix missing leading zeros for ICN Checksums DD issue was corrected in MPIF*1.0*9
 D MES^XPDUTL("  >>> Checking ICN Checksums for missing leading zeros. Job being tasked off.")
 S ZTRTN="CHKSUM^DG648PST",ZTDESC="Correct missing leading zeros in ICN Checksum - DG*5.3*648"
 S ZTIO="",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,1,0)
 I $D(DUZ) S ZTSAVE("DUZ")=DUZ
 D ^%ZTLOAD
 K ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK,%
 Q
 ;
CHKSUM ;fix missing leading zeros for ICN Checksums
 K ^XTMP("DG648","MISSING CHECKSUM"),^XTMP("DG648","CHECKSUM UPDATE"),^XTMP("DG648","CHECKSUM UPDATE FAIL")
 N DFN,ICN,CHECK,DIE,DA,DR,X,Y,CNT,CNT2,CNT3,LEN
 S (CNT2,CNT3,CNT,ICN)=0
 F  S ICN=$O(^DPT("AICN",ICN)) Q:ICN=""  D
 .Q:$E(ICN,1,3)=$P($$SITE^VASITE,"^",3)
 .S DFN=$O(^DPT("AICN",ICN,""))
 .I ICN'=$P($G(^DPT(DFN,"MPI")),"^") Q
 .; ^ ONLY UPDATING PRIMARY ICN
 .S CHECK=$P($G(^DPT(DFN,"MPI")),"^",2)
 .I CHECK="" S CNT2=CNT2+1,^XTMP("DG648","MISSING CHECKSUM",CNT2)="DFN= "_DFN_"^"_"ICN= "_ICN Q
 .S LEN=$L(CHECK)
 .Q:LEN=6
 .I LEN<6 S CHECK=$E(1000000+CHECK,2,7) ;adding missing leading zeros
 .K X,Y,DIE,DA,DR
 .S DA=DFN
 .D LOCK(DA) ;LOCK DPT NODE "MPI"
 .S DIE="^DPT(",DR="991.02///^S X=CHECK" D ^DIE
 .L -^DPT(DA,"MPI")
 .I +$G(Y)=-1 S CNT3=CNT3+1,^XTMP("DG648","CHECKSUM UPDATE FAIL",CNT3)="DFN= "_DFN_"^ICN= "_ICN_"^CHECKSUM= "_CHECK Q
 .S CNT=CNT+1,^XTMP("DG648","CHECKSUM UPDATE",CNT)="DFN= "_DFN_"^ICN= "_ICN_"^CHECKSUM= "_CHECK
 S ^XTMP("DG648","CHECKSUM UPDATE",CNT+2)="TOTAL: "_CNT,^XTMP("DG648","MISSING CHECKSUM",CNT2+2)="TOTAL: "_CNT2
 S ^XTMP("DG648","CHECKSUM UPDATE FILE",CNT3+2)="TOTAL: "_CNT3
 I CNT>0 D
 .N DIFROM,XMSUB,XMTEXT,XMY
 .S XMSUB="Updated Checksums post-init DG648 from "_$P($$SITE^VASITE,"^",3),XMY(DUZ)=""
 .S XMTEXT="^XTMP(""DG648"",""CHECKSUM UPDATE"",",XMY("CHESNEY.CHRISTINE_M@FORUM.VA.GOV")=""
 .D ^XMD
 I CNT2>0 D
 .N DIFROM,XMSUB,XMTEXT,XMY
 .S XMSUB="Missing Checksums post-init DG648 from "_$P($$SITE^VASITE,"^",3),XMY(DUZ)=""
 .S XMTEXT="^XTMP(""DG648"",""MISSING CHECKSUM"",",XMY("CHESNEY.CHRISTINE_M@FORUM.VA.GOV")=""
 .D ^XMD
 I CNT3>0 D
 .N DIFROM,XMSUB,XMTEXT,XMY
 .S XMSUB="Checksum updates failed in post-init DG648 from "_$P($$SITE^VASITE,"^",3),XMY(DUZ)=""
 .S XMTEXT="^XTMP(""DG648"",""CHECKSUM UPDATE FAIL"",",XMY("CHESNEY.CHRISTINE_M@FORUM.VA.GOV")=""
 .D ^XMD
 I CNT=0,CNT2=0,CNT3=0 D
 .N DIFROM,XMSUB,XMTEXT,XMY,ARR
 .S ARR(1)="No issues with Checksums at this site"
 .S XMSUB="Checksum updates failed in post-init DG648 from "_$P($$SITE^VASITE,"^",3),XMY(DUZ)=""
 .S XMTEXT="ARR(",XMY("CHESNEY.CHRISTINE_M@FORUM.VA.GOV")=""
 .D ^XMD
 K ^XTMP("DG648","MISSING CHECKSUM"),^XTMP("DG648","CHECKSUM UPDATE"),^XTMP("DG648","CHECKSUM UPDATE FAIL")
 Q
 ;
LOCK(IEN) ;
 F  L +^DPT(IEN,"MPI"):10 Q:$T
 Q
XR(DGFILE,DGFLD) ;File index type cross references
 ;
 N DGFDA,DGIEN,DGWP,DGERR,DGXR,DGVAL,DGOUT,DIERR
 ;Set up x-refs. Any value that has a ".", will have the period
 ;replaved with a "D" to prevent x-ref's such as .11 and 11 having
 ;identical xref names
 ;I DGFILE=2.0361 S DGXR="AVAFC20361" ;ELIGIBILITY -- MOVED TO DG*5.3*691
 I '$D(DGXR) S DGXR=$S(DGFLD[".":"AVAFC"_$P(DGFLD,".",2),1:"AVAFC"_DGFLD)
 ;Check for existing x-ref
 S DGVAL(1)=DGFILE,DGVAL(2)=DGXR
 D FIND^DIC(.11,"","@;IXIE","KP",.DGVAL,"","","","","DGOUT")
 I $D(DGOUT("DILIST",1)) D  Q
 .D MES^XPDUTL("     >>> Cross reference "_DGXR_" already exists, nothing filed.")
 .Q
 ;Create filer array
 S DGFDA(.11,"+1,",.01)=DGFILE                      ;FILE
 S DGFDA(.11,"+1,",.02)=DGXR                        ;NAME
 S DGFDA(.11,"+1,",.11)="This x-ref calls the DG FIELD MONITOR event point."     ;SHORT DESCRIPTION
 S DGFDA(.11,"+1,",.2)="MU"                         ;TYPE
 S DGFDA(.11,"+1,",.4)="F"                          ;EXECUTION
 S DGFDA(.11,"+1,",.41)="I"                         ;ACTIVITY
 S DGFDA(.11,"+1,",.5)="I"                          ;ROOT TYPE
 S DGFDA(.11,"+1,",.51)=DGFILE                      ;ROOT FILE
 S DGFDA(.11,"+1,",.42)="A"                         ;USE
 S DGFDA(.11,"+1,",1.1)="D FC^DGFCPROT(.DA,"_DGFILE_","_DGFLD_",""SET"",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q"     ;SET LOGIC
 S DGFDA(.11,"+1,",2.1)="D FC^DGFCPROT(.DA,"_DGFILE_","_DGFLD_",""KILL"",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q"     ;KILL LOGIC
 ;CROSS REFERENCE VALUES
 S DGFDA(.114,"+2,+1,",.01)=1                       ;ORDER NUMBER
 S DGFDA(.114,"+2,+1,",1)="F"                       ;TYPE OF VALUE
 S DGFDA(.114,"+2,+1,",2)=DGFILE                    ;FILE NUMBER
 S DGFDA(.114,"+2,+1,",3)=DGFLD                     ;FIELD NUMBER
 S DGFDA(.114,"+2,+1,",7)="F"                       ;COLLATION
 ;DESCRIPTION
 S DGWP(1)="This cross reference activates the DG FIELD MONITOR event point."
 S DGWP(2)="Applications that wish to monitor edit activity related to this field may"
 S DGWP(3)="subscribe to that event point and take action as indicated by the changes"
 S DGWP(4)="that occur.  Refer to the DG FIELD MONITOR protocol for a description of"
 S DGWP(5)="the information available at the time of the event."
 ;File INDEX record
 D UPDATE^DIE("","DGFDA","DGIEN","DGERR")
 I $D(DIERR) D  Q
 .N DGI S DGI=""
 .D MES^XPDUTL("     >>> A problem has occurred during the filing of x-ref. "_DGXR_"!")
 .D MES^XPDUTL("         Please contact Customer Support.")
 .F  S DGI=$O(DGERR("DIERR",1,"TEXT",DGI)) Q:DGI=""  D
 ..D MES^XPDUTL(DGERR("DIERR",1,"TEXT",DGI))
 ..Q
 .Q
 S DGFLD(DGFILE,DGFLD)=""  ;Create list to recompile templates
 D MES^XPDUTL("     >>> "_DGXR_" cross reference filed.")
 ;File DESCRIPTION field
 D WP^DIE(.11,DGIEN(1)_",",.1,"","DGWP")
 Q
TEMPL N GLOBAL,FIELD,NFIELD,FILE,CNT
 D BMES^XPDUTL("Beginning to compile templates on the PATIENT (#2) file.")
 ;
 S NFIELD=".525",FILE=2,FIELD="",CNT=1
 F  S FIELD=$P(NFIELD,",",CNT) Q:FIELD=""  D LOOP(FIELD,FILE) S CNT=CNT+1
 ;S NFIELD=.01,FILE=2.0361 D LOOP(NFIELD,FILE) -- MOVED TO DG*5.3*691
 W !!
 S (X,Y)=""
 D BMES^XPDUTL("The following routine namespace was compiled:")
 F  S X=$O(CFIELD(X)) Q:X=""  S Y=$G(Y)+1 S PRINT(Y)=" "_X_"*"
 ;
 D MES^XPDUTL(.PRINT)
 K X,Y,PRINT,CFIELD
 Q
 ;
LOOP(FIELD,FILE) ;
 N GLOBAL,TEMPLATP,TEMPLATN,X,Y,DMAX
 F GLOBAL="^DIE","^DIPT" DO
 .I $D(@GLOBAL@("AF",FILE,FIELD)) D
 ..S TEMPLATP=0
 ..F  S TEMPLATP=$O(@GLOBAL@("AF",FILE,FIELD,TEMPLATP)) Q:'TEMPLATP  DO
 ...S TEMPLATN=$P($G(@GLOBAL@(TEMPLATP,0)),"^",1)
 ...I TEMPLATN="" D BMES^XPDUTL("Could not compile template "_TEMPLATN_$C(13,10)_"Please review!") Q
 ...S X=$P($G(@GLOBAL@(TEMPLATP,"ROUOLD")),"^")
 ...I X=""&($D(@GLOBAL@(TEMPLATP,"ROU"))'=0) D BMES^XPDUTL("Could not find routine for template "_TEMPLATN_$C(13,10)_"Please review!") Q
 ...I X=""&($D(@GLOBAL@(TEMPLATP,"ROU"))=0) Q
 ...I $D(CFIELD(X)) Q  ;already compiled
 ...S CFIELD(X)="" ;                remember the template was compiled
 ...S Y=TEMPLATP ;                 set up the call for fman
 ...S DMAX=$$ROUSIZE^DILF
 ...I GLOBAL="^DIE" D BMES^XPDUTL(" "),BMES^XPDUTL("   Compiling Input Templates") D EN^DIEZ Q
 ...I GLOBAL="^DIPT" D BMES^XPDUTL(" "),BMES^XPDUTL("   Compiling Print Templates") D EN^DIPZ Q
 Q
