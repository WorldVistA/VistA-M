FBXIP38 ;WOIFO/SAB-PATCH INSTALL ROUTINE ;11/26/2001
 ;;3.5;FEE BASIS;**38**;JAN 30, 1995
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="SUSCOD","STATEXP","EXPDT" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP38")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
SUSCOD ; Add new Suspend Code to the FEE BASIS SUSPENSION (#161.27) file.
 D BMES^XPDUTL("  Adding new suspend code to file #161.27...")
 N FBDA
 ; check for J suspension code
 S FBDA=$$FIND1^DIC(161.27,"","X","J","B")
 ; if not found then add it
 I 'FBDA D
 . N DA,DD,DIC,DINUM,DLAYGO,DO,X,Y
 . S DIC="^FBAA(161.27,",DIC(0)="L",DLAYGO=161.27
 . S X="J"
 . S DIC("DR")="2///^S X=""Mill Bill Authority, 38 U.S.C. 1725"""
 . D FILE^DICN
 . I Y<0 D MES^XPDUTL("ERROR ADDING J SUSPEND CODE") Q
 . ; update Description wp field of entry (replaces current text)
 . K ^TMP($J,"FB1")
 . S ^TMP($J,"FB1",1,0)="Payment in Accordance with pricing for claims approved under 38 USC 1725"
 . S ^TMP($J,"FB1",2,0)="payer of last resort."
 . ;   replace existing text with content of array
 . D WP^DIE(161.27,+Y_",",1,"","^TMP($J,""FB1"")") D MSG^DIALOG()
 . K ^TMP($J,"FB1")
 Q
 ;
STATEXP ; Populate field .07 in file 162.92 for appropriate status
 D BMES^XPDUTL("  Populating new field in file #162.92...")
 N FBDA,FBFDA,FBORDER
 ; loop thru status orders that need to be populated
 F FBORDER=10,40,55,70 D
 . S FBDA=$$STATUS^FBUCUTL(FBORDER) ; get ien
 . Q:'FBDA
 . Q:$P($G(^FB(162.92,FBDA,0)),U,7)]""  ; field already populated
 . I FBORDER=10 S FBFDA(162.92,FBDA_",",.07)="31"
 . I FBORDER=40 S FBFDA(162.92,FBDA_",",.07)="366"
 . I FBORDER=55 S FBFDA(162.92,FBDA_",",.07)="366"
 . I FBORDER=70 S FBFDA(162.92,FBDA_",",.07)="121"
 ; update entries
 I $D(FBFDA) D FILE^DIE("E","FBFDA") D MSG^DIALOG()
 Q
 ;
EXPDT ; Recompute expiration dates of incomplete Mill Bill claims
 D BMES^XPDUTL("  Recalculating expiration date of incomplete claims...")
 N FBDA,FBEXP,FBEXPN,FBLETDT,FBORDER,FBSTATUS,FBUCA
 ;
 ; get ien for status 'incomplete unauthorized claim' 
 S FBORDER=10
 S FBSTATUS=$$STATUS^FBUCUTL(FBORDER)
 ;
 ; loop thru incomplete claims
 S FBDA=0 F  S FBDA=$O(^FB583("AS",FBSTATUS,FBDA)) Q:'FBDA  D
 . S FBUCA=$G(^FB583(FBDA,0))
 . S FBEXP=$P(FBUCA,U,26) ; expiration date
 . S FBLETDT=$P(FBUCA,U,19) ; date letter sent
 . Q:$P(FBUCA,U,28)'=1  ; skip if not mill bill claim
 . Q:FBEXP'>0  ; skip if no expiration date on file
 . Q:FBLETDT'>0  ; skip if letter date is not on file
 . ;
 . ; calculate new expiration date and update claim
 . S FBEXPN=$$EXPIRE^FBUCUTL8(FBDA,FBLETDT,FBUCA,FBORDER)
 . ;W !,FBDA,?10,FBLETDT,?20,FBEXP,?30,FBEXPN
 . D EDITL^FBUCED(FBDA,FBEXPN,0)
 Q
 ;FBXIP38
