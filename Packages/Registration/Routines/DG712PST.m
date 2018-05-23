DG712PST ;BIR/CMC/TKW,PTD-PATCH DG*5.3*712 POST INSTALLATION ROUTINE ;1/29/09  17:41
 ;;5.3;Registration;**712**;Aug 13, 1993;Build 7
 ;
 ; IA #2796 for use of calls to RGHLLOG in UPDBAI
POST ;Post init
 N DGFLD,DGMFLD,DGOUT,DGFILE
 ;File cross references
 D XR(2,.121) ; BAD ADDRESS INDICATOR (#.121)
 D XR(2,.133) ; EMAIL ADDRESS (#.133)
 D XR(2,.134) ; PHONE NUMBER [CELLULAR] (#.134)
 D TEMPL
 ;TURNING ON AUDITING FOR ALIAS FIELD(S)
 D ALIAS
 ; Queue job to send A31 for patients with BAD ADDRESS INDICATOR
 D UPDBAI
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
 S DGFLD(DGFILE,DGFLD)=""  ;Create list to recompile templates
 D MES^XPDUTL("   >> "_DGXR_" cross-reference filed.")
 ;File DESCRIPTION field
 D WP^DIE(.11,DGIEN(1)_",",.1,"","DGWP")
 Q
 ;
TEMPL ;Determine templates on the PATIENT (#2) file to be compiled.
 N GLOBAL,FIELD,NFIELD,FILE,CNT
 D BMES^XPDUTL("Beginning to compile templates on the PATIENT (#2) file.")
 ;
 S NFIELD=".121,.133,.134",FILE=2,FIELD="",CNT=1
 F  S FIELD=$P(NFIELD,",",CNT) Q:FIELD=""  D LOOP(FIELD,FILE) S CNT=CNT+1
 W !!
 S (X,Y)=""
 D BMES^XPDUTL("The following routine namespace was compiled:")
 F  S X=$O(CFIELD(X)) Q:X=""  S Y=$G(Y)+1 S PRINT(Y)=" "_X_"*"
 ;
 D MES^XPDUTL(.PRINT)
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
ALIAS ;TURNING ON ALIAS AUDITING
 N FLDNUM
 S FLDNUM=.01 D TURNON^DIAUTL(2.01,FLDNUM) W !,"Adding AUDIT to sub-file 2.01 Alias, field #",FLDNUM
 S FLDNUM=1 D TURNON^DIAUTL(2.01,FLDNUM) W !,"Adding AUDIT to sub-file 2.01 Alias, field #",FLDNUM
 Q
 ;
UPDBAI ; Send A31 to update the BAD ADDRESS INDICATOR for all patients
 D BMES^XPDUTL(" "),BMES^XPDUTL("   Queuing job to update MPI for Patients with BAD ADDRESS INDICATOR.")
 N ZTIO,ZTSK,ZTRTN,ZTDESC,ZTSAVE,ZTDTH,Y
 S ZTIO="",ZTRTN="DQUPDBAI^DG712PST",ZTDTH=$H
 S ZTDESC="Send A31 update for patients with BAD ADDRESS INDICATOR-post init for DG*5.3*712."
 D ^%ZTLOAD
 I '$G(ZTSK) D MES^XPDUTL("   **** Queuing job failed!!!") Q
 D MES^XPDUTL("   Job number "_ZTSK_" was queued.")
 Q
DQUPDBAI ; Entry point to queue job to update BAD ADDRESS INDICATOR for all patients
 N DGSITE,DGSNAME,DGDFN,DGBAI,DGICN,DGCNT,DGECNT,DGERR,R,X
 ; Get current station number and name
 S X=$$SITE^VASITE()
 S DGSNAME=$P(X,"^",2),DGSITE=$P(X,"^",3)
 S (DGCNT,DGECNT)=0
 ; Loop through patient file, if patient has a BAD ADDRESS INDICATOR, send A31
 F DGDFN=0:0 S DGDFN=$O(^DPT(DGDFN)) Q:'DGDFN  D
 . ; Check for PATIENT having BAD ADDRESS INDICATOR
 . S DGBAI=$P($G(^DPT(DGDFN,.11)),U,16)
 . Q:'DGBAI
 . S DGICN=+$$GETICN^MPIF001(DGDFN)
 . ; Only update if station has a valid national ICN
 . Q:DGICN=-1
 . Q:$E(DGICN,1,($L(DGSITE)))=DGSITE
 . ; Send A31
 . S DGERR=$$A31^MPIFA31B(DGDFN)
 . I +DGERR<0 D  Q
 .. D START^RGHLLOG()
 .. D EXC^RGHLLOG(208,"Error building A31 for BAD ADDRESS INDICATOR during post-init of DG*5.3*712, (DFN="_DGDFN_"), ERROR="_$P(DGERR,"^",2),DGDFN)
 .. D STOP^RGHLLOG()
 .. S DGECNT=DGECNT+1 Q
 . S DGCNT=DGCNT+1
 . Q
 ; Send email to person who ran the INIT, letting them know results
 N XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,X,R
 S R(1)="A31 messages to update the BAD ADDRESS INDICATOR for "_DGCNT_" Patients were sent."
 I DGECNT'>0 S R(2)=" ",R(3)="You can now delete the post-init routine ^DG712PST."
 I DGECNT>0 D
 . S R(2)=" "
 . S R(3)="*** Note: "_DGECNT_" errors occurred trying to update the BAD ADDRESS INDICATOR."
 . S R(4)="*** IMDQ can check the EXCEPTIONS LOG to see details for these errors."
 . S R(5)="*** See further instructions in the patch description for DG*5.3*712."
 . Q
 S XMTEXT="R(",XMSUB="Results from running patch DG*5.3*712"
 S XMDUZ=.5
 S XMY(DUZ)=""
 D ^XMD
 ; Send message to MPI developers on Outlook
 K XMDUZ,XMTEXT,XMSUB,XMY,XMZ,XMDUN,R
 S R(1)="Post-Init routine UPDBAI^DG712PST run at station: "_DGSITE_" - "_DGSNAME
 S R(2)=" "
 S R(3)="A31 messages to update the BAD ADDRESS INDICATOR for "_DGCNT_" Patients were sent."
 I DGECNT>0 D
 . S R(4)=" "
 . S R(5)="*** Note: "_DGECNT_" errors occurred trying to update the BAD ADDRESS INDICATOR."
 . S R(6)="*** IMDQ can check the EXCEPTIONS LOG to see details for these errors."
 . S R(7)="*** See further instructions in the patch description for DG*5.3*712."
 . Q
 S XMTEXT="R(",XMSUB="Results from running patch DG*5.3*712 at station: "_DGSITE
 S XMDUZ=DUZ
 S XMY("TAMI.WINN@DOMAIN.EXT")=""
 S XMY("CHRISTINE.LINK@DOMAIN.EXT")=""
 D ^XMD
 Q
 ;
 ;
