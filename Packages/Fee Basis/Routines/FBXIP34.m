FBXIP34 ;WOIFO/MJE-PATCH INSTALL ROUTINE ;6/7/01
 ;;3.5;FEE BASIS;**34**;JAN 30, 1995
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="UPDPOV" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP34")
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
 ; verify IEN of CONTRACT NURSING HOME in FEE BASIS PROGRAM file
 I $P($G(^FBAA(161.8,7,0)),U)'="CONTRACT NURSING HOME" D  Q
 . D MES^XPDUTL("    ERROR: Fee Program with IEN 7 is not CONTRACT NURSING HOME.")
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
 ;;43^CNH HOSPICE & PALLIATIVE CARE^7
 ;;44^CNH RESPITE CARE^7
 ;;71^HOMEMAKER/HOME HEALTH AID SERVICES^2
 ;;74^HOME HEALTH SERVICES (NON-NURSING PROFESSIONAL)^2
 ;;76^ADHC^2
 ;;77^HOSPICE & PALLIATIVE CARE (OPT) - CONTRACT/SHARING AGREEMENT^2
 ;;78^HOSPICE & PALLIATIVE CARE (OPT) - FEE BASIS AUTHORITY (CFR 17.50b)^2
 ;;END
 ;
 ;FBXIP34
