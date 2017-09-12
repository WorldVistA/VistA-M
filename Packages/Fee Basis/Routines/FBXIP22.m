FBXIP22 ;WCIOFO/SAB-PATCH INSTALL ROUTINE ;8/17/2000
 ;;3.5;FEE BASIS;**22**;JAN 30, 1995
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="UPDPOV" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP22")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
UPDPOV ; Update Selected Purpose of Visits (POV)
 N FBC,FBCODE,FBDA,FBFDA,FBI,FBNAME,FBPROG,FBX
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
 . ; if POV not found then add it
 . I 'FBDA D
 . . N DA,DD,DIC,DINUM,DLAYGO,DO,X
 . . S DIC="^FBAA(161.82,",DIC(0)="L",DLAYGO=161.82
 . . S X=FBNAME Q:X=""
 . . S DIC("DR")="2////^S X=FBPROG;3////^S X=FBCODE"
 . . I +FBCODE,'$D(^FBAA(161.82,+FBCODE,0)) S DINUM=+FBCODE
 . . D FILE^DICN
 . . I Y<0 D MES^XPDUTL("ERROR ADDING POV WITH CODE "_FBCODE)
 . ;
 . ; if POV found then add to update list
 . I FBDA D
 . . I $$GET1^DIQ(161.82,FBDA_",",2,"I")=FBPROG Q
 . . S FBFDA(161.82,FBDA_",",2)=FBPROG
 ;
 ; actually update the found POVs
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 D MES^XPDUTL("  Done.")
 Q
 ;
POV ;austin code^name^fee program
 ;;15^CLASS I DENTAL TREATMENT^2
 ;;16^CLASS II DENTAL TREATMENT^2
 ;;17^CLASS IIa DENTAL TREATMENT^2
 ;;18^CLASS IIb DENTAL TREATMENT^2
 ;;19^CLASS IIc DENTAL TREATMENT^2
 ;;20^CLASS IIr DENTAL TREATMENT^2
 ;;21^CLASS III DENTAL TREATMENT^2
 ;;22^CLASS IV DENTAL TREATMENT^2
 ;;23^CLASS V DENTAL TREATMENT^2
 ;;24^CLASS VI DENTAL TREATMENT^2
 ;;END
 ;
 ;FBXIP22
