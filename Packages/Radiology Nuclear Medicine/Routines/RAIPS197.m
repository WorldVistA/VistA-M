RAIPS197 ;HISC/GJC - PostInit RA5P197 ; Dec 15, 2022@09:15:05
 ;;5.0;Radiology/Nuclear Medicine;**197**;Mar 16, 1998;Build 2
 ;
 ; File               IA          Type
 ; -------------------------------------
 ; FILE^DIE          2053         (S)
 ; $$FIND1^DIC       2051         (S)
 ; BMES^XPDUTL      10141         (S)
 ; NEWCP^XPDUTL     10141         (S)
 ;
 ; INC 24962082
 ; ------------
 ; This post-install routine will update a single CPT code
 ; record CODE (#.01)in the RADIOLOGY CPT BY PROCEDURE TYPE
 ; (#73.2). The field updated is: WAIT TIMES PROCEDURE TYPE (#2).
 ;
 ; From: CODE = 77067; WAIT TIMES PROCEDURE TYPE = OTHER
 ;   To: CODE = 77067; WAIT TIMES PROCEDURE TYPE = MAMMOGRAPHY
 ;
 ;
EN ;entry point for P197 checkpoints
 N RACHX1,RACHX2
 S RACHX1=$$NEWCP^XPDUTL("POST1","EN1^RAIPS197")
 S RACHX2=$$NEWCP^XPDUTL("POST2","EN2^RAIPS197")
 Q
 ;
EN1 ;find CODE '77067' free text (FT)
 N RACODE,RAFDA,RAIEN,RAIENS
 S RACODE=77067 ;CODE
 ;---
 S RAIEN=+$O(^RA(73.2,"B",RACODE,0))
 I RAIEN=0 D  QUIT
 .N RATXT S RATXT="CODE '"_RACODE_"' not found; no action taken."
 .D BMES^XPDUTL(RATXT)
 .Q
 ;---
 L +^RA(73.2,RAIEN):5 I '$T D  QUIT
 .N RATXT S RATXT(1)="CODE '"_RACODE_"' record could not be locked for editing."
 .S RATXT(2)="WAIT TIMES PROCEDURE TYPE failed update to: 'MAMMOGRAPHY'."
 .D BMES^XPDUTL(.RATXT)
 .Q
 ;---
 N RATXT K RAERR S RAIENS=RAIEN_"," ;string
 S RAFDA(73.2,RAIENS,2)="MAMMOGRAPHY"
 D FILE^DIE("E","RAFDA","RAERR")
 ;---
 I $D(RAERR) D
 .S RATXT(1)="The WAIT TIMES PROCEDURE TYPE value for CODE '"_RACODE_"' has failed to be updated"
 .S RATXT(2)="to 'MAMMOGRAPHY'."
 .Q
 E  D
 .S RATXT(1)="The WAIT TIMES PROCEDURE TYPE value for CODE '"_RACODE_"' has successfully been"
 .S RATXT(2)="updated to 'MAMMOGRAPHY'."
 .Q
 D BMES^XPDUTL(.RATXT)
 K RAERR
 ;---
 L -^RA(73.2,RAIEN) ;unconditionally
 Q
 ;
EN2 ;inactivate existing COVID reasons.
 K RACOREA,RAERR,RAFDA,RAI,RAIEN,RATXT,RAX
 F RAI=1:1 S RAX=$T(COVID+RAI) Q:RAX=""  D
 .S RACOREA=$P(RAX,";",3),RAIEN=$$FIND1^DIC(75.2,"","X",RACOREA)
 .I RAIEN=0 D  Q
 ..N RATXT S RATXT="Could not find reason '"_RACOREA_"' to inactivate."
 ..D BMES^XPDUTL(RATXT)
 ..Q
 .; ---
 .; ^DD(75.2,2,0)="TYPE OF REASON^S^1:CANCEL REQUEST;3:HOLD REQUEST;9:GENERAL REQUEST;^0;2^Q" 
 .; Delete ToR (1 or 3 or 9) for each COVID reason. This will inactivate the COVID reason from
 .; selection by a user.
 .; ---
 .K RAFDA,RATXT S RAFDA(75.2,RAIEN_",",2)="@"
 .D FILE^DIE("","RAFDA","RAERR")
 .I $D(RAERR("DIERR"))#2 D
 ..S RATXT="An error occurred inactivating reason '"_RACOREA_"'. Contact your Radiology ADPAC."
 ..Q
 .E  S RATXT="Reason '"_RACOREA_"' was successfully inactivated."
 .D BMES^XPDUTL(RATXT)  K RAERR,RATXT
 .Q
 K RACOREA,RAERR,RAFDA,RAI,RAIEN,RATXT,RAX
 Q
 ;
COVID ;COVID reasons (cancel/hold) to be inactivated
 ;;COVID-19 CONCERNS
 ;;COVID-19  CONCERNS
 ;;COVID-19 CLINICAL REVIEW
 ;;COVID-19 CLINICAL REVIEW COMPLETE TO SCHEDULE
