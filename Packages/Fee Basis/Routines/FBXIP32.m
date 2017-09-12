FBXIP32 ;WOIFO/SAB-PATCH INSTALL ROUTINE ;7/19/2001
 ;;3.5;FEE BASIS;**32**;JAN 30, 1995
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="UPDPOV","STATLTR","REQINFO" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP32")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
UPDPOV ; Update Selected Purpose of Visits (POV)
 N FBCODE,FBDA,FBFDA,FBI,FBNAME,FBPROG,FBX,X,Y
 D BMES^XPDUTL("  Updating selected POVs in the FEE BASIS PURPOSE OF VISIT (161.82) file...")
 ;
 ; verify IEN of OUTPATIENT program in FEE BASIS PROGRAM file
 ;I $P($G(^FBAA(161.8,2,0)),U)'="OUTPATIENT" D  Q
 ;. D MES^XPDUTL("    ERROR: Fee Program with IEN 2 is not OUTPATIENT.")
 ;. D MES^XPDUTL("    Purpose of Visits could not be updated.")
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
 . . I $$GET1^DIQ(161.82,FBDA_",",2,"I")'=FBPROG D
 . . . I FBPROG]"" S FBFDA(161.82,FBDA_",",2)=FBPROG
 . . . I FBPROG="" S FBFDA(161.82,FBDA_",",2)="@"
 . ;
 . ; if POV not found then add it
 . I 'FBDA D
 . . N DA,DD,DIC,DINUM,DLAYGO,DO,X
 . . S DIC="^FBAA(161.82,",DIC(0)="L",DLAYGO=161.82
 . . S X=FBNAME Q:X=""
 . . S DIC("DR")="3////^S X=FBCODE"
 . . I FBPROG]"" S DIC("DR")=DIC("DR")_";2////^S X=FBPROG"
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
 ;;52^OUTPATIENT 38 U.S.C. 1725^
 ;;39^INPATIENT 38 U.S.C. 1725^6
 ;;END
 ;
STATLTR ; Populate field .06 in file 162.92 for appropriate status
 N FBDA,FBFDA,FBORDER
 ; loop thru status orders that need to be populated
 F FBORDER=10,40,70,90 D
 . S FBDA=$$STATUS^FBUCUTL(FBORDER) ; get ien
 . Q:'FBDA
 . Q:$P($G(^FB(162.92,FBDA,0)),U,6)]""  ; field already populated
 . I FBORDER=10 S FBFDA(162.92,FBDA_",",.06)="1725 REQUEST INFO"
 . I FBORDER>10 S FBFDA(162.92,FBDA_",",.06)="1725 DISPOSITION"
 ; update entries
 I $D(FBFDA) D FILE^DIE("E","FBFDA") D MSG^DIALOG()
 Q
 ;
REQINFO ; Add/Update data in file 162.93
 D SSFC^FBXIP32A ; signed statement from claimant
 Q
 ;FBXIP32
