RORP027 ;ALB/TK - CCR PRE/POST-INSTALL PATCH 27 ;29 Jul 2014  4:02 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**27**;Feb 17, 2006;Build 58
 ;
 ; This routine uses the following IAs:
 ; #3277         OWNSKEY^XUSRB (supported)
 ; #10141        BMES^XPDUTL
 ;               MES^XPDUTL
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*27   FEB  2015   T KOPP       Patch 27 pre and post install
 ;******************************************************************************
 ;******************************************************************************
 ;
 Q
 ;Pre-Install routine for Patch 27
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
 ;Post-Install routine for Patch 27
POST ;
 N CT,ROR,RORERR,REGNAME,REGIEN,RORBUF,RORFDA,RORMSG,RORMSGX
 D BMES^XPDUTL("Post install started")
 ; Check if any registries from patch 24 have been inactivated
 S ROR(1)="VA ALS",ROR(2)="VA OSTEOPOROSIS",ROR(3)="VA HCC",ROR(4)="VA LUNG CANCER"
 S ROR(5)="VA MELANOMA",ROR(6)="VA COLORECTAL CANCER",ROR(7)="VA PANCREATIC CANCER",ROR(8)="VA PROSTATE CANCER"
 D BMES^XPDUTL("Checking for inactive registries")
 S CT=1,RORERR=0
 F ROR=1:1:8 D
 . K RORBUF,RORMSGX,RORFDA
 . S REGIEN=$$REGIEN^RORUTL02(ROR(ROR),"11I",.RORBUF)
 . I $G(RORBUF("DILIST","ID",1,11)) D
 .. S RORFDA(798.1,REGIEN_",",11)=0
 .. D FILE^DIE(,"RORFDA","RORMSGX")
 .. S CT=CT+1,RORMSG(CT)=$J("",10)_ROR(ROR)
 .. I '$G(RORMSGX) D
 ... S RORMSG(CT)=RORMSG(CT)_" was reactivated"
 .. E  D
 ... S RORMSG(CT)=RORMSG(CT)_" must be manually reactivated",RORERR=1
 I CT=1 K RORMSG D BMES^XPDUTL("No inactive registries found")
 I CT>1 D
 . S RORMSG(1)="REGISTRY UPDATE STATUS:" D MES^XPDUTL(.RORMSG)
 . I RORERR D BMES^XPDUTL("***** AT LEAST ONE REGISTRY MUST BE MANUALLY REACTIVATED *****")
 D BMES^XPDUTL("    Step Complete")
 ;
 D BMES^XPDUTL("Updating List Items")
 D UPDLIST
 D BMES^XPDUTL("    Step Complete")
 ;
 D BMES^XPDUTL("Post install completed")
 Q
 ;
UPDLIST ;
 N RORI,RORI1,RORREG,RORDATA,REGIEN,Z,CT
 F RORI=1:1 S RORREG=$P($P($T(@("REGS+"_RORI_"^RORP027")),";;",2),U) Q:RORREG=""  D
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . I REGIEN>0 D
 .. F RORI1=1:1 S RORDATA=$P($T(@("LISTITEM+"_RORI1_"^RORP027")),";;",2) Q:RORDATA=""  D
 ... Q:$D(^ROR(799.1,"KEY",+$P(RORDATA,U,2),REGIEN,+$P(RORDATA,U,3)))  ; Entry already exists
 ... K RORFDA,RORMSG,RORERR,DIERR
 ... S RORFDA(799.1,"?+1,",.01)=$P(RORDATA,U)
 ... S RORFDA(799.1,"?+1,",.02)=$P(RORDATA,U,2)
 ... S RORFDA(799.1,"?+1,",.03)=REGIEN
 ... S RORFDA(799.1,"?+1,",.04)=$P(RORDATA,U,3)
 ... D UPDATE^DIE(,"RORFDA",,"RORMSG")
 ... I $G(DIERR) D
 .... K RORERR
 .... S RORERR(1)="     New entry for "_RORREG_"(ien #"_REGIEN_") encountered the following error"
 .... S RORERR(2)="     and was not added to the ROR LIST ITEM file."
 .... S RORERR(3)="     (Data = "_RORDATA_")"
 .... S RORERR(4)="     Please report this error to your CCR contact:"
 .... S RORERR(5)=""
 .... S Z=0,CT=5 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",6)_$G(RORMSG("DIERR",1,"TEXT",Z))
 .... D MES^XPDUTL(.RORERR)
 Q
 ;
REGS ; List of registries whose LIST ITEM entries should be added to file 799.1
 ;;VA ALS
 ;;VA APNEA
 ;;VA COLORECTAL CANCER
 ;;VA HCC
 ;;VA LUNG CANCER
 ;;VA MELANOMA
 ;;VA OSTEOPOROSIS
 ;;VA PANCREATIC CANCER
 ;;VA PROSTATE CANCER
 ;;
 ;
LISTITEM ;  Entries to add to file 799.1  text^group^code
 ;;eGFR by CKD-EPI^7^3
 ;;eGFR by MDRD^7^2
 ;;Creatinine clearance by Cockcroft-Gault^7^1
 ;;FIB-4^6^4
 ;;APRI^6^3
 ;;MELD-Na^6^2
 ;;MELD^6^1
 ;;BMI^5^1
 ;;Registry Lab^3^1
 ;;
