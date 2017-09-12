FBXIP24 ;WOIFO/SAB-PATCH INSTALL ROUTINE ;12/12/2000
 ;;3.5;FEE BASIS;**24**;JAN 30, 1995
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="UPDPOV","VENDOR" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP24")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
UPDPOV ; Update Selected Purpose of Visits (POV)
 N FBCODE,FBDA,FBFDA,FBI,FBNAME,FBPROG,FBX,X,Y
 D BMES^XPDUTL("  Updating selected POVs in the FEE BASIS PURPOSE OF VISIT (161.82) file...")
 ;
 ; verify IEN of OUTPATIENT program in FEE BASIS PROGRAM file
 I $P($G(^FBAA(161.8,2,0)),U)'="OUTPATIENT" D  Q
 . D MES^XPDUTL("    ERROR: Fee Program with IEN 2 is not OUTPATIENT.")
 . D MES^XPDUTL("    Purpose of Visits could not be updated.")
 ;
 ; update POVs
 K FBFDA
 ; loop thru POVs
 F FBI=1:1 S FBX=$P($T(POV+FBI),";;",2) Q:FBX="END"  D
 . S FBCODE=$P(FBX,U)
 . S FBNAME=$P(FBX,U,2)
 . S FBPROG=$P(FBX,U,3)
 . ;
 . ; locate POV in file
 . S FBDA=$$FIND1^DIC(161.82,"","X",FBCODE,"AC")
 . ;
 . ; if POV found then check and if necessary add to update array
 . I FBDA D
 . . I $$GET1^DIQ(161.82,FBDA_",",.01)'=FBNAME S FBFDA(161.82,FBDA_",",.01)=FBNAME
 . . I $$GET1^DIQ(161.82,FBDA_",",2,"I")'=FBPROG S FBFDA(161.82,FBDA_",",2)=FBPROG
 . ;
 . ; if POV not found then add it
 . I 'FBDA D
 . . N DA,DD,DIC,DINUM,DLAYGO,DO,X
 . . S DIC="^FBAA(161.82,",DIC(0)="L",DLAYGO=161.82
 . . S X=FBNAME Q:X=""
 . . S DIC("DR")="2////^S X=FBPROG;3////^S X=FBCODE"
 . . I +FBCODE,'$D(^FBAA(161.82,+FBCODE,0)) S DINUM=+FBCODE
 . . D FILE^DICN
 . . I Y<0 D MES^XPDUTL("ERROR ADDING POV WITH CODE "_FBCODE)
 ;
 ; actually update the found POVs
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 D MES^XPDUTL("    Done.")
 Q
 ;
POV ;austin code^name^fee program for Purpose of Visit (POV) code(s)
 ;;75^CHIROPRACTIC CARE^2
 ;;END
 ;
VENDOR ;Update Vendor Codes
 N FBDT,FBNOW
 S FBDT="3010103.22" ; effective date/time for PART and SPEC updates
 S FBNOW=$$NOW^XLFDT() ; current date/time
 ;
 I FBDT>FBNOW D 
 . ; Queue task for FBDT since effective date/time is future
 . N ZTSK
 . S ZTRTN="ENQ^FBAAUVC"
 . S ZTDESC="FEE BASIS UPDATE OF PART. AND SPEC. VENDOR CODES"
 . S ZTDTH=FBDT
 . S ZTIO=""
 . D ^%ZTLOAD
 . ;
 . I '$G(ZTSK) D
 . . D BMES^XPDUTL("ERROR. The task was not successfully queued.")
 . . D MES^XPDUTL("Please contact National VISTA Support for assistance.")
 . ;
 . I $G(ZTSK) D
 . . D BMES^XPDUTL("  The task to update the PARTICIPATION CODE and the")
 . . D MES^XPDUTL("  SPECIALTY CODE was successfully queued.")
 . . D MES^XPDUTL("  The task number is "_ZTSK)
 . . D MES^XPDUTL("  It will start on "_$$HTE^XLFDT(ZTSK("D")))
 ;
 I FBDT'>FBNOW D
 . ; perform update now since effective date has already past
 . N FBERR
 . ;
 . D BMES^XPDUTL("  Updating selected codes in the FEE BASIS PARTICIPATION CODE (161.81) file...")
 . D UPDPART^FBAAUVC
 . I $D(FBERR) D
 . . N FBCODE
 . . S FBCODE="" F  S FBCODE=$O(FBERR(FBCODE)) Q:FBCODE=""  D
 . . . D MES^XPDUTL("ERROR ADDING PART CODE "_FBCODE)
 . D MES^XPDUTL("    Done.")
 . ;
 . D BMES^XPDUTL("  Updating selected Codes in the FEE BASIS SPECIALTY CODE (161.6) file...")
 . D UPDSPEC^FBAAUVC
 . I $D(FBERR) D
 . . N FBCODE
 . . S FBCODE="" F  S FBCODE=$O(FBERR(FBCODE)) Q:FBCODE=""  D
 . . . D MES^XPDUTL("ERROR ADDING SPECIALTY CODE "_FBCODE)
 . D MES^XPDUTL("    Done.")
 ;
 ;FBXIP24
