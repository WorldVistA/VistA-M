RORP029 ;ALB/TK - CCR PRE/POST-INSTALL PATCH 29 ;29 Jul 2014  4:02 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**29**;Feb 17, 2006;Build 18
 ;
 ; This routine uses the following IAs:
 ; #3277         OWNSKEY^XUSRB (supported)
 ; #10141        BMES^XPDUTL
 ;               MES^XPDUTL
 ; #2056         GET1^DIQ (supported)
 ; #2053         UPDATE^DIE (supported)
 ; #2054         CLEAN^DILF (supported)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*29   APR  2016   T KOPP       Patch 29 pre and post install
 ;******************************************************************************
 ;******************************************************************************
 ;
 Q
 ;Pre-Install routine for Patch 29
PRE ;
 ; CHECK FOR ROR VA IRM KEY, ABORT IF USER DOES NOT POSSESS
 N RORKEYOK
 D BMES^XPDUTL("Verifying installing user has the ROR VA IRM security key")
 D OWNSKEY^XUSRB(.RORKEYOK,"ROR VA IRM",DUZ)
 I '$G(RORKEYOK(0)) D  Q
 . S XPDABORT=1
 . D BMES^XPDUTL("****** INSTALL ABORTED!!! ******")
 . D BMES^XPDUTL("This patch can only be installed by a user who is assigned the ROR VA IRM key")
 . D BMES^XPDUTL("Restart the installation again once the appropriate key has been assigned")
 D BMES^XPDUTL("  User has the ROR VA IRM key - OK to install")
 Q
 ;
 ;Post-Install routine for Patch 29
POST ;
 D BMES^XPDUTL("Post install started")
 D BMES^XPDUTL("Adding new reports to all registries")
 D UPDREG
 ;
 D BMES^XPDUTL("Adding new selection panel to reports")
 D UPDPAN
 ;
 D CLEAN^DILF
 D BMES^XPDUTL("Post install completed")
 Q
 ;
UPDREG ;  Add new reports to all registries
 N CT,DIERR,RORDATA,REGNAME,REGIEN,RORERR,RORFDA,RORMSG,X,Y,Z
 S REGIEN=0 F  S REGIEN=$O(^ROR(798.1,REGIEN)) Q:'REGIEN  D
 . ; Extract field #27 AVAILABLE REPORTS - Quit if "24,25" already exists in the record .  Add ,24,25 to report list
 . ; VA HEPB registry does not have report 25
 . S RORDATA=$$GET1^DIQ(798.1,REGIEN_",",27,"I")
 . S REGNAME=$P($$REGNAME^RORUTL01(REGIEN),U)
 . I RORDATA[$S(REGNAME'="VA HEPB":"24,25",1:",24") D  Q
 .. D BMES^XPDUTL("   o New reports already exist for registry #"_REGIEN)
 . K RORFDA,RORMSG
 . S RORFDA(798.1,REGIEN_",",27)=RORDATA_",24"_$S(REGNAME'="VA HEPB":",25",1:"")
 . D UPDATE^DIE("","RORFDA",,"RORMSG")
 . I $D(DIERR) D  Q
 .. K RORERR
 .. D DBS^RORERR("RORMSG",-112,,,798.1,REGIEN)
 .. M RORMSG=RORERR
 .. K RORERR
 .. S RORERR(1)="     Update of registry "_$P($G(^ROR(798.1,REGIEN,0)),U)_" with new reports"
 .. S RORERR(2)="      encountered the following error.  Please report this error to your CCR contact:"
 .. S RORERR(3)=""
 .. S Z=0,CT=3 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",10)_$G(RORMSG("DIERR",1,"TEXT",Z))
 .. S CT=CT+1,RORERR(CT)=" "
 .. D MES^XPDUTL(.RORERR)
 D COMPL
 Q
 ;
UPDPAN ;  Add new panel to all reports with OTHER DIAGNOSIS panel
 N CT,DIERR,P1,P2,RORDATA,RORRPT,RORERR,RORFDA,RORMSG,X,Y,Z
 S RORRPT=0 F  S RORRPT=$O(^ROR(799.34,RORRPT)) Q:'RORRPT  D
 . ; Extract field #1 PARAMETER PANELS - Quit if ",190," already exists in the record .  Add ,190 after ,180
 . S RORDATA=$$GET1^DIQ(799.34,RORRPT_",",1,"I")
 . Q:RORDATA'["180"
 . I RORDATA[",180,190" D  Q
 .. D BMES^XPDUTL("   o New selection panel 190 already exists for report #"_RORRPT)
 . K RORFDA,RORMSG
 . S P1=$P(RORDATA,",180"),P2=$P(RORDATA,",180",2)
 . S RORFDA(799.34,RORRPT_",",1)=P1_",180,190"_P2
 . D UPDATE^DIE("","RORFDA",,"RORMSG")
 . I $D(DIERR) D  Q
 .. K RORERR
 .. D DBS^RORERR("RORMSG",-112,,,799.34,RORRPT)
 .. M RORMSG=RORERR
 .. K RORERR
 .. S RORERR(1)="     Update of report "_$P($G(^ROR(799.34,RORRPT,0)),U)_" with new panel"
 .. S RORERR(2)="      encountered the following error.  Please report this error to your CCR contact:"
 .. S RORERR(3)=""
 .. S Z=0,CT=3 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",10)_$G(RORMSG("DIERR",1,"TEXT",Z))
 .. S CT=CT+1,RORERR(CT)=" "
 .. D MES^XPDUTL(.RORERR)
 D COMPL
 Q
 ;
COMPL ;
 D BMES^XPDUTL("   >> Step complete")
 Q
 ;
