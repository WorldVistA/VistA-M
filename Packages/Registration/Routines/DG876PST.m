DG876PST ;BIR/JFW - PATCH DG*5.3*876 POST INSTALLATION ROUTINE ; 12/23/13 4:31pm
 ;;5.3;Registration;**876**;Aug 13, 1993;Build 6
 ;
 ; IA #4397 (Supported) for call to TURNON^DIAUTL
POST ;Post init
 N DGI,DGFLDS
 ;  Modifying the following field(s) in the PATIENT File #2:
 ;     - .024 SELF IDENTIFIED GENDER
 S DGFLDS=".024"
 ;File cross references for the field(s) (TRIGGERS)
 F DGI=1:1:$L(DGFLDS,",")  D XR(2,$P(DGFLDS,",",DGI))
 ;Re-Compile Templates for field(s) (if applicable)
 D TEMPL(2,DGFLDS,"PATIENT")
 ;Turning on AUDITING for field(s)
 F DGI=1:1:$L(DGFLDS,",")  D AUDIT(2,$P(DGFLDS,",",DGI),"Patient")
 ;
 D EMPA31
 ;
 Q
 ;
XR(DGFILE,DGFLD) ;File index type cross references
 ;
 N DGFDA,DGIEN,DGWP,DGERR,DGXR,DGVAL,DGOUT,DIERR
 ;Set up the cross-reference
 I '$D(DGXR) S DGXR=$S(DGFLD[".":"AVAFC"_$P(DGFLD,".",2),1:"AVAFC"_DGFLD)
 ;Check for existing cross-reference
 S DGVAL(1)=DGFILE,DGVAL(2)=DGXR
 D FIND^DIC(.11,"","@;IXIE","KP",.DGVAL,"","","","","DGOUT")
 I $D(DGOUT("DILIST",1)) D  Q
 .D MES^XPDUTL("   >> Cross reference "_DGXR_" already exists, nothing filed.")
 .Q
 ;Create filer array
 S DGFDA(.11,"+1,",.01)=DGFILE                      ;FILE
 S DGFDA(.11,"+1,",.02)=DGXR                        ;NAME
 S DGFDA(.11,"+1,",.11)="This x-ref calls the DG FIELD MONITOR event point."  ;SHORT DESCRIPTION
 S DGFDA(.11,"+1,",.2)="MU"                         ;TYPE
 S DGFDA(.11,"+1,",.4)="F"                          ;EXECUTION
 S DGFDA(.11,"+1,",.41)="I"                         ;ACTIVITY
 S DGFDA(.11,"+1,",.5)="I"                          ;ROOT TYPE
 S DGFDA(.11,"+1,",.51)=DGFILE                      ;ROOT FILE
 S DGFDA(.11,"+1,",.42)="A"                         ;USE
 S DGFDA(.11,"+1,",1.1)="D FC^DGFCPROT(.DA,"_DGFILE_","_DGFLD_",""SET"",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q"  ;SET LOGIC
 S DGFDA(.11,"+1,",2.1)="D FC^DGFCPROT(.DA,"_DGFILE_","_DGFLD_",""KILL"",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q"  ;KILL LOGIC
 ;CROSS REFERENCE VALUES
 S DGFDA(.114,"+2,+1,",.01)=1                       ;ORDER NUMBER
 S DGFDA(.114,"+2,+1,",1)="F"                       ;TYPE OF VALUE
 S DGFDA(.114,"+2,+1,",2)=DGFILE                    ;FILE NUMBER
 S DGFDA(.114,"+2,+1,",3)=DGFLD                     ;FIELD NUMBER
 S DGFDA(.114,"+2,+1,",7)="F"                       ;COLLATION
 ;DESCRIPTION
 S DGWP(1)="This cross-reference activates the DG FIELD MONITOR event point."
 S DGWP(2)="Applications that wish to monitor edit activity related to this field may"
 S DGWP(3)="subscribe to that event point and take action as indicated by the changes"
 S DGWP(4)="that occur.  Refer to the DG FIELD MONITOR protocol for a description of"
 S DGWP(5)="the information available at the time of the event."
 ;File INDEX record
 D UPDATE^DIE("","DGFDA","DGIEN","DGERR")
 I $D(DIERR) D  Q
 .N DGI S DGI=""
 .D BMES^XPDUTL("   >> A problem has occurred during the filing of x-ref "_DGXR_"!")
 .D MES^XPDUTL("      Please contact Customer Support.")
 .F  S DGI=$O(DGERR("DIERR",1,"TEXT",DGI)) Q:DGI=""  D
 ..D MES^XPDUTL(DGERR("DIERR",1,"TEXT",DGI))
 ..Q
 .Q
 D MES^XPDUTL("   >> "_DGXR_" cross-reference filed.")
 ;File DESCRIPTION field
 D WP^DIE(.11,DGIEN(1)_",",.1,"","DGWP")
 Q
 ;
TEMPL(DGFILE,DGFLDS,DGFNAME) ;Determine templates on the file to be compiled.
 N DGI
 D BMES^XPDUTL("Beginning to compile templates on the "_DGFNAME_" (#"_DGFILE_") file.")
 ;
 F DGI=1:1:$L(DGFLDS,",")  D LOOP($P(DGFLDS,",",DGI),DGFILE)
 W !!
 S (X,Y)=""
 D:$D(CFIELD)
 .D BMES^XPDUTL("The following routine namespace was compiled:")
 .F  S X=$O(CFIELD(X)) Q:X=""  S Y=$G(Y)+1 S PRINT(Y)=" "_X_"*"
 .D MES^XPDUTL(.PRINT)
 D:'$D(CFIELD)
 .D BMES^XPDUTL("No routine namespaces were needed to be compiled.")
 K X,Y,PRINT,CFIELD
 Q
LOOP(FIELD,FILE) ;Compile templates.
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
 ...S CFIELD(X)="" ;  remember the template was compiled
 ...S Y=TEMPLATP ;  set up the call for FileMan
 ...S DMAX=$$ROUSIZE^DILF
 ...I GLOBAL="^DIE" D BMES^XPDUTL(" "),BMES^XPDUTL("   Compiling Input Templates") D EN^DIEZ Q
 ...I GLOBAL="^DIPT" D BMES^XPDUTL(" "),BMES^XPDUTL("   Compiling Print Templates") D EN^DIPZ Q
 Q
 ;
AUDIT(DGFILE,DGFLD,DGFNAME) ;Turn on Auditing for Field in File
 D TURNON^DIAUTL(DGFILE,DGFLD) W !,"Adding AUDIT to file "_DGFILE_" "_DGFNAME_", field #"_DGFLD
 Q
 ;
EMPA31 ; queue off A31 messages on employees
 ;
 D BMES^XPDUTL(" "),BMES^XPDUTL("   Queuing job to update MPI for Employee Patients.")
 I '$O(^DG(391,"B","EMPLOYEE",0)) D BMES^XPDUTL(" "),BMES^XPDUTL(" *** ERROR: EMPLOYEE entry not found in file 391 ***"),BMES^XPDUTL("*** Log a REMEDY ticket ***") Q
 N ZTIO,ZTSK,ZTRTN,ZTDESC,ZTSAVE,ZTDTH,Y
 S ZTIO="",ZTRTN="DQEMPA31^DG876PST",ZTDTH=$H
 S ZTDESC="Send A31 update for Employee Patients-post init for DG*5.3*876"
 D ^%ZTLOAD
 I '$G(ZTSK) D MES^XPDUTL("   **** Queuing job failed!!!") Q
 D MES^XPDUTL("   Job number "_ZTSK_" was queued.")
 Q
DQEMPA31 ; Entry point to queue job to update Employee Patients
 N DGSITE,DGSNAME,DGDFN,DGICN,DGCNT,DGECNT,DGERR,R,X,DGEMP
 ; Get EMPLOYEE entry
 S DGEMP=$O(^DG(391,"B","EMPLOYEE",0))
 ; Get current station number and name
 S X=$$SITE^VASITE()
 S DGSNAME=$P(X,"^",2),DGSITE=$P(X,"^",3)
 S (DGCNT,DGECNT)=0
 ; Loop through patient file to find EMPLOYEE entries
 S DGDFN=0 F  S DGDFN=$O(^DPT("APTYPE",DGEMP,DGDFN)) Q:'DGDFN  D
 . ; Only update if station has a valid national ICN
 . S DGICN=+$$GETICN^MPIF001(DGDFN)
 . Q:DGICN=-1
 . Q:$E(DGICN,1,($L(DGSITE)))=DGSITE
 . ; Send A31
 . S DGERR=$$A31^MPIFA31B(DGDFN)
 . I +DGERR<0 D  Q
 .. D START^RGHLLOG()
 .. D EXC^RGHLLOG(208,"Error building A31 for EMPLOYEE PATIENT during post-init of DG*5.3*876, (DFN="_DGDFN_"), ERROR="_$P(DGERR,"^",2),DGDFN)
 .. D STOP^RGHLLOG()
 .. S DGECNT=DGECNT+1 Q
 . S DGCNT=DGCNT+1
 ; Send email to person who ran the INIT, letting them know results
 N XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,X,R
 S R(1)="A31 messages to update the EMPLOYEE PATIENTS for "_DGCNT_" were sent."
 I DGECNT'>0 S R(2)=" ",R(3)="You can now delete the post-init routine ^DG876PST."
 I DGECNT>0 D
 . S R(2)=" "
 . S R(3)="*** Note: "_DGECNT_" errors occurred trying to update the EMPLOYEE PATIENT."
 . S R(4)="*** IMDQ can check the EXCEPTIONS LOG to see details for these errors."
 . S R(5)="*** See further instructions in the patch description for DG*5.3*876."
 S XMTEXT="R(",XMSUB="Results from running patch DG*5.3*876"
 S XMDUZ=.5
 S XMY(DUZ)=""
 D ^XMD
 ; Send message to MPI developers on Outlook
 K XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,R
 S R(1)="Post-Init routine ^DG876PST run at station: "_DGSITE_" - "_DGSNAME
 S R(2)=" "
 S R(3)="A31 messages to update the EMPLOYEE PATIENTs for "_DGCNT_" records were sent."
 I DGECNT>0 D
 . S R(4)=" "
 . S R(5)="*** Note: "_DGECNT_" errors occurred trying to update the EMPLOYEE PATIENTS."
 . S R(6)="*** IMDQ can check the EXCEPTIONS LOG to see details for these errors."
 . S R(7)="*** See further instructions in the patch description for DG*5.3*876."
 S XMTEXT="R(",XMSUB="Results from running patch DG*5.3*876 at station: "_DGSITE
 S XMDUZ=DUZ
 S XMY("Christine.Chesney@domain.ext")=""
 S XMY("John.Williams30ec0c@domain.ext")=""
 S XMY("Ed.Zeigler@domain.ext")=""
 D ^XMD
 Q
 ;
