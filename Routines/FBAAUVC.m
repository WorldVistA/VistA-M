FBAAUVC ;WOIFO/SAB-UPDATE VENDOR CODES ;11/27/2000
 ;;3.5;FEE BASIS;**24**;JAN 30, 1995
 ;This routine may be tasked (or directly called) from the patch
 ;FB*3.5*24 post install routine.
 Q
 ;
ENQ ; Tasked Entry Point
 N FBERR
 D UPDPART
 D UPDSPEC
 Q
 ;
UPDPART ;Update Selected Participation Code(s)
 ;May also be directly called from FBXIP24
 N FBCODE,FBDA,FBFDA,FBI,FBNAME,FBX,X,Y
 K FBERR
 ;
 ; update Part Codes
 K FBFDA
 ; loop thru Part Codes
 F FBI=1:1 S FBX=$P($T(PART+FBI),";;",2) Q:FBX="END"  D
 . S FBCODE=$P(FBX,U)
 . S FBNAME=$P(FBX,U,2)
 . Q:FBCODE=""
 . ;
 . ; locate Part Code in file
 . S FBDA=$$FIND1^DIC(161.81,"","X",FBCODE,"C")
 . ;
 . ; if PART CODE found then check and if necessary add to update array
 . I FBDA D
 . . I $$GET1^DIQ(161.81,FBDA_",",.01)=FBNAME Q
 . . S FBFDA(161.81,FBDA_",",.01)=FBNAME
 . ;
 . ; if Part Code not found then add it
 . I 'FBDA D
 . . N DA,DD,DIC,DINUM,DLAYGO,DO,X
 . . S DIC="^FBAA(161.81,",DIC(0)="L",DLAYGO=161.81
 . . S X=FBNAME Q:X=""
 . . S DIC("DR")="1////^S X=FBCODE"
 . . I +FBCODE,'$D(^FBAA(161.81,+FBCODE,0)) S DINUM=+FBCODE
 . . D FILE^DICN
 . . I Y<0 S FBERR(FBCODE)=""
 ;
 ; actually update the found Part Codes
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 Q
 ;
PART ;austin code^name for Participation Code(s)
 ;;15^DOCTOR OF CHIROPRACTIC
 ;;END
 ;
UPDSPEC ;Update Selected Specialty Code(s)
 ;May also be directly called from FBXIP24
 N FBCODE,FBDA,FBFDA,FBI,FBNAME,FBX,X,Y
 K FBERR
 ;
 ; update Specialty Code(s)
 K FBFDA
 ; loop thru Specialties
 F FBI=1:1 S FBX=$P($T(SPEC+FBI),";;",2) Q:FBX="END"  D
 . S FBCODE=$P(FBX,U)
 . S FBNAME=$P(FBX,U,2)
 . Q:FBCODE=""
 . ;
 . ; locate Specialty Code in file
 . S FBDA=$$FIND1^DIC(161.6,"","X",FBCODE,"C")
 . ;
 . ; if Spec Code found then check and if necessary add to update array
 . I FBDA D
 . . I $$GET1^DIQ(161.6,FBDA_",",.01)=FBNAME Q
 . . S FBFDA(161.6,FBDA_",",.01)=FBNAME
 . ;
 . ; if Specialty Code not found then add it
 . I 'FBDA D
 . . N DA,DD,DIC,DINUM,DLAYGO,DO,X
 . . S DIC="^FBAA(161.6,",DIC(0)="L",DLAYGO=161.6
 . . S X=FBNAME Q:X=""
 . . S DIC("DR")="1////^S X=FBCODE"
 . . D FILE^DICN
 . . I Y<0 S FBERR(FBCODE)=""
 ;
 ; actually update the found Specialty Codes
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 Q
 ;
SPEC ;;austin code^name for Specialty Code(s)
 ;;53^CHIROPRACTIC
 ;;END
 ;
 ;FBAAUVC
