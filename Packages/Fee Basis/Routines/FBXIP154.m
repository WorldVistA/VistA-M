FBXIP154 ;WOIFO/SAB - PATCH INSTALL ROUTINE ;12/2/2014
 ;;3.5;FEE BASIS;**154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ; 
 ; ICRs
 ;  #2050   MSG^DIALOG
 ;  #2052   $$GET1^DID
 ;  #2053   FILE^DIE, UPDATE^DIE
 ;  #2056   $$GET1^DIQ
 ;  #2343   $$ACTIVE^XUSER()
 ;  #10103  $$FMADD^XLFDT
 ;  #10141  BMES^XPDUTL, MES^XPDUTL, $$NEWCP^XPDUTL
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="USRAUD","AUTHP" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP154")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
USRAUD ; populate user audit
 N DA,DIERR,FBC,FBCE,FBDT,FBFILE,FBIENS,FBTXT,FBUSR,FBY
 D BMES^XPDUTL("    Creating User Audit entries. This may take some time.")
 ;
 ; populate user audit in file 162.2
 D MES^XPDUTL("      processing file 162.2...")
 S (FBC,FBCE)=0
 S FBFILE=162.292
 S FBTXT(1)="Added by FB*3.5*154 based on legal determination."
 S FBTXT(2)="Added by FB*3.5*154 based on medical determination."
 S FBTXT(3)="Added by FB*3.5*154 based on user entering & install date."
 ; loop thru file 162.2
 S DA=0 F  S DA=$O(^FBAA(162.2,DA)) Q:'DA  D
 . ; skip if user audit already populated
 . Q:$O(^FBAA(162.2,DA,"LOG1",0))
 . ;
 . S FBIENS=DA_","
 . S FBY=$G(^FBAA(162.2,DA,0))
 . ;
 . S FBDT=$P(FBY,U,10) ; DATE OF LEGAL DETERMINATION
 . S FBUSR=$P(FBY,U,11) ; USER ENTERING LEGAL DETERM.
 . I FBDT,FBUSR D ADDUA(FBFILE,FBIENS,FBDT,FBUSR,FBTXT(1))
 . ;
 . S FBDT=$P(FBY,U,13) ; DATE OF MEDICAL DETERMINATION
 . S FBUSR=$P(FBY,U,14) ; USER ENTERING MEDICAL DETERM.
 . I FBDT,FBUSR D ADDUA(FBFILE,FBIENS,FBDT,FBUSR,FBTXT(2))
 . ;
 . S FBDT=DT ; current (install) date
 . S FBUSR=$P(FBY,U,8) ; USER ENTERING NOTIFICATION
 . I FBDT,FBUSR D ADDUA(FBFILE,FBIENS,FBDT,FBUSR,FBTXT(3))
 D SHOWCNT
 ;
 ; populate user audit in file 162.4
 D MES^XPDUTL("      processing file 162.4...")
 S (FBC,FBCE)=0
 S FBFILE=162.492
 S FBTXT="Added by FB*3.5*154 based on user entering & date of issue."
 ; loop thru file 162.4
 S DA=0 F  S DA=$O(^FB7078(DA)) Q:'DA  D
 . ; skip if user audit already populated
 . Q:$O(^FB7078(DA,"LOG1",0))
 . ;
 . S FBIENS=DA_","
 . S FBY=$G(^FB7078(DA,0))
 . ;
 . S FBDT=$P(FBY,U,10) ; DATE OF ISSUE
 . S FBUSR=$P(FBY,U,8) ; USER ENTERING
 . I FBDT,FBUSR D ADDUA(FBFILE,FBIENS,FBDT,FBUSR,FBTXT)
 D SHOWCNT
 ;
 ; populate user audit in file 162.7
 D MES^XPDUTL("      processing file 162.7...")
 S (FBC,FBCE)=0
 S FBFILE=162.792
 S FBTXT="Added by FB*3.5*154 based on entered/last edited."
 ; loop thru file 162.7
 S DA=0 F  S DA=$O(^FB583(DA)) Q:'DA  D
 . ; skip if user audit already populated
 . Q:$O(^FB583(DA,"LOG1",0))
 . ;
 . S FBIENS=DA_","
 . S FBY=$G(^FB583(DA,0))
 . ;
 . S FBDT=$P(FBY,U,18) ; DATE ENTERED/LAST EDITED
 . S FBUSR=$P(FBY,U,17) ; ENTERED/LAST EDITED BY
 . I FBDT,FBUSR D ADDUA(FBFILE,FBIENS,FBDT,FBUSR,FBTXT)
 D SHOWCNT
 ;
 ; populate user audit in sub-file 161.01
 D MES^XPDUTL("      processing sub-file 161.01...")
 S (FBC,FBCE)=0
 S FBFILE=161.192
 S FBTXT="Added by FB*3.5*154 based on clerk & install date."
 ; loop thru file 161
 S DA(1)=0 F  S DA(1)=$O(^FBAAA(DA(1))) Q:'DA(1)  D
 . ; loop thru sub-file 161.01
 . S DA=0 F  S DA=$O(^FBAAA(DA(1),1,DA)) Q:'DA  D
 . . N FBX
 . . ; skip if user audit already populated
 . . Q:$O(^FBAAA(DA(1),1,DA,"LOG1",0))
 . . ;
 . . S FBIENS=DA_","_DA(1)_","
 . . ;
 . . S FBDT=DT ; current (install) date
 . . S FBUSR=$P($G(^FBAAA(DA(1),1,DA,100)),U) ; CLERK
 . . S FBX=$P($G(^FBAAA(DA(1),1,DA,0)),U,9) ; ASSOCIATED 7078/583
 . . ;
 . . ; skip if 7078 and clerk already in file 162.4 user audit
 . . I FBUSR,FBX[";FB7078(",$O(^FB7078(+FBX,"LOG1","AU",FBUSR,0)) Q
 . . ;
 . . ; skip if U/C and clerk already in file 162.7 user audit
 . . I FBUSR,FBX[";FB583(",$O(^FB583(+FBX,"LOG1","AU",FBUSR,0)) Q
 . . ;
 . . I FBDT,FBUSR D ADDUA(FBFILE,FBIENS,FBDT,FBUSR,FBTXT)
 D SHOWCNT
 ;
 D MES^XPDUTL("    Done creating user audit entries.")
 Q
 ;
ADDUA(FBFILE,FBIENS,FBDT,FBUSR,FBTXT) ; add user audit record
 Q:FBDT'?7N  ; invalid date
 Q:$$ACTIVE^XUSER(FBUSR)=""  ; no user record found
 N FBFDA
 S FBIENS="+1,"_FBIENS
 S FBFDA(FBFILE,FBIENS,.01)=FBDT ; DATE/TIME EDITED
 S FBFDA(FBFILE,FBIENS,1)=FBUSR ; EDITED BY
 S FBFDA(FBFILE,FBIENS,2)=FBTXT ; COMMENTS
 D UPDATE^DIE("","FBFDA")
 I $G(DIERR)="" S FBC=FBC+1
 E  D
 . S FBCE=FBCE+1
 . D MES^XPDUTL("          "_"Error creating record with IENS "_FBIENS)
 Q
 ;
SHOWCNT ; show counts for file
 D MES^XPDUTL("        "_FBC_" user audit entries were created.")
 D:FBCE MES^XPDUTL("        "_FBCE_" user audit entries not created due to error.")
 Q
 ;
AUTHP ; populate authorization pointer data
 N DA,DIERR,FBA,FBAUTHP,FBFE,FBIENS,FBP,FBT,FBX,FBYA,FBYD,FBYP
 D MES^XPDUTL("Populating new AUTHORIZATION POINTER field. This may take some time...")
 ;
 ; init counters
 S FBT("TLN")=0 ; total line items
 S FBT("TLN","SKIP")=0 ; lines skipped because new field was populated
 S FBT("TLN","PROC")=0 ; lines processed
 S FBT("NOP")=0 ; processed lines without old authorization pointer
 S FBT("NOP","7078C")=0 ; populated based on 7078/583 match
 S FBT("NOP","7078U")=0 ; not populated, no 7078/583 match found
 S FBT("NOP","POVC")=0 ; populated based on POV match
 S FBT("NOP","POVU")=0 ; not populated, no POV match found
 S FBT("PTR")=0 ; processed lines with old authorization pointer
 S FBT("PTR","7078M")=0 ; populated with same value based on 7078/583
 S FBT("PTR","7078C")=0 ; populated with diff value based on 7078/583
 S FBT("PTR","7078U")=0 ; populated with same value, no 7078/583 match
 S FBT("PTR","POVM")=0 ; populated with same value based on POV
 S FBT("PTR","POVC")=0 ; populated with diff value based on POV
 S FBT("PTR","POVU")=0 ; populated with same value, no POV match
 ;
 ; set header for XTMP with purge date in 120 days
 S ^XTMP("FB*3.5*154",0)=$$FMADD^XLFDT(DT,120)_"^"_DT_"^From patch FB*3.5*154 post init."
 ;
 ; determine if old field still exists
 S FBFE=$S($$GET1^DID(162.02,3,"","LABEL")="*AUTHORIZATION POINTER":1,1:0)
 ;
 ; loop thru outpatient and ancillary line items in FEE BASIS PAYMENT
 ; loop thru patients
 S DA(3)=0
 F  S DA(3)=$O(^FBAAC(DA(3))) Q:'DA(3)  D
 . ; loop thru vendors
 . S DA(2)=0
 . F  S DA(2)=$O(^FBAAC(DA(3),1,DA(2))) Q:'DA(2)  D
 . . ; loop thru dates of service
 . . S DA(1)=0
 . . F  S DA(1)=$O(^FBAAC(DA(3),1,DA(2),1,DA(1))) Q:'DA(1)  D
 . . . S FBYD=$G(^FBAAC(DA(3),1,DA(2),1,DA(1),0))
 . . . S FBP("DOS")=$P(FBYD,U,1) ; date of service
 . . . S FBP("FTP")=$S(FBFE:$P(FBYD,U,4),1:"") ; old value
 . . . ; don't use old value if authorization does not exist in file 161
 . . . I FBP("FTP"),'$D(^FBAAA(DA(3),1,FBP("FTP"),0)) S FBP("FTP")=""
 . . . S FBYA=$S(FBP("FTP"):$G(^FBAAA(DA(3),1,FBP("FTP"),0)),1:"")
 . . . S FBA("POV")=$P(FBYA,U,7) ; PURPOSE OF VISIT
 . . . S FBA("7078")=$P(FBYA,U,9) ; ASSOCIATED 7078/583
 . . . ; loop thru service provided
 . . . S DA=0
 . . . F  S DA=$O(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA)) Q:'DA  D
 . . . . S FBT("TLN")=FBT("TLN")+1
 . . . . S FBIENS=DA_","_DA(1)_","_DA(2)_","_DA(3)_","
 . . . . ;
 . . . . ; skip if already converted (i.e. new field populated)
 . . . . I $P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,3)),U,9) D  Q
 . . . . . S FBT("TLN","SKIP")=FBT("TLN","SKIP")+1
 . . . . S FBT("TLN","PROC")=FBT("TLN","PROC")+1
 . . . . ;
 . . . . S FBYP=$G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,0))
 . . . . S FBP("7078")=$P(FBYP,U,13) ; ASSOCIATED 7078/583
 . . . . S FBP("POV")=$P(FBYP,U,18) ; PURPOSE OF VISIT
 . . . . ;
 . . . . I 'FBP("FTP") S FBT("NOP")=FBT("NOP")+1 ; no old pointer
 . . . . E  S FBT("PTR")=FBT("PTR")+1 ; old pointer exists
 . . . . ;
 . . . . ; determine correct authorization pointer for line item
 . . . . S FBAUTHP="" ; init new auth pointer value
 . . . . ; if payment associated 7078/583 exists then match with that
 . . . . I FBP("7078")]"" D
 . . . . . ; if pointer exists and 7078/583 matches then copy old value
 . . . . . I FBP("FTP"),FBP("7078")=FBA("7078") D  Q:FBAUTHP
 . . . . . . S FBAUTHP=FBP("FTP")
 . . . . . . S FBT("PTR","7078M")=FBT("PTR","7078M")+1
 . . . . . ; if 7078/583 does not match then look for an better auth.
 . . . . . I FBP("7078")'=FBA("7078") D  Q:FBAUTHP
 . . . . . . S FBX=$$ASSOC(DA(3),FBP("DOS"),FBP("7078"))
 . . . . . . Q:'FBX
 . . . . . . S FBAUTHP=FBX
 . . . . . . I FBP("FTP") S FBT("PTR","7078C")=FBT("PTR","7078C")+1
 . . . . . . I 'FBP("FTP") S FBT("NOP","7078C")=FBT("NOP","7078C")+1
 . . . . . . S ^XTMP("FB*3.5*154","7078C",FBIENS)=FBP("FTP")_"^"_FBAUTHP
 . . . . . I 'FBAUTHP D
 . . . . . . ; if better auth. not found use old value when available
 . . . . . . I FBP("FTP") S FBAUTHP=FBP("FTP")
 . . . . . . I FBP("FTP") S FBT("PTR","7078U")=FBT("PTR","7078U")+1
 . . . . . . I 'FBP("FTP") S FBT("NOP","7078U")=FBT("NOP","7078U")+1
 . . . . . . S ^XTMP("FB*3.5*154","7078U",FBIENS)=FBP("FTP")_"^"_FBAUTHP
 . . . . ;
 . . . . ; if payment associated 7078/583 blank then match with POV
 . . . . I FBP("7078")="" D
 . . . . . ; if pointer exists and POV matches then copy old value
 . . . . . I FBP("FTP"),FBP("POV")=FBA("POV") D  Q:FBAUTHP
 . . . . . . S FBAUTHP=FBP("FTP")
 . . . . . . S FBT("PTR","POVM")=FBT("PTR","POVM")+1
 . . . . . ; if POV does not match then look for an better auth.
 . . . . . I FBP("POV")'=FBA("POV") D  Q:FBAUTHP
 . . . . . . S FBX=$$POV(DA(3),FBP("DOS"),FBP("POV"))
 . . . . . . Q:'FBX
 . . . . . . S FBAUTHP=FBX
 . . . . . . I FBP("FTP") S FBT("PTR","POVC")=FBT("PTR","POVC")+1
 . . . . . . I 'FBP("FTP") S FBT("NOP","POVC")=FBT("NOP","POVC")+1
 . . . . . . S ^XTMP("FB*3.5*154","POVC",FBIENS)=FBP("FTP")_"^"_FBAUTHP
 . . . . . ; if better auth. not found use old value when available
 . . . . . I 'FBAUTHP D
 . . . . . . I FBP("FTP") S FBAUTHP=FBP("FTP")
 . . . . . . I FBP("FTP") S FBT("PTR","POVU")=FBT("PTR","POVU")+1
 . . . . . . I 'FBP("FTP") S FBT("NOP","POVU")=FBT("NOP","POVU")+1
 . . . . . . S ^XTMP("FB*3.5*154","POVU",FBIENS)=FBP("FTP")_"^"_FBAUTHP
 . . . . ;
 . . . . ; save authorization pointer value in new field
 . . . . I FBAUTHP D
 . . . . . N FBFDA
 . . . . . S FBFDA(162.03,FBIENS,15.5)=FBAUTHP
 . . . . . D FILE^DIE("","FBFDA")
 . . . . . I $G(DIERR)'="" D MES^XPDUTL("  Error updating record with IENS "_FBIENS)
 ;
 ; report results
 S FBX=$J($FN(FBT("TLN"),","),10)_" payment line items in FEE BASIS PAYMENT file"
 D MES^XPDUTL(FBX)
 D MES^XPDUTL("----------")
 S FBX=$J($FN(FBT("TLN","SKIP"),","),10)_" lines skipped because new field already populated"
 D MES^XPDUTL(FBX)
 S FBX=$J($FN(FBT("TLN","PROC"),","),10)_" lines processed"
 D MES^XPDUTL(FBX)
 ;
 S FBX=$J($FN(FBT("NOP"),","),10)_" processed lines without an existing authorization pointer value"
 D BMES^XPDUTL(FBX)
 D MES^XPDUTL("----------")
 S FBX=$J($FN(FBT("NOP","7078C"),","),10)_" lines populated based on 7078/583 match"
 D MES^XPDUTL(FBX)
 S FBX=$J($FN(FBT("NOP","7078U"),","),10)_" lines not populated because 7078/583 match not found"
 D MES^XPDUTL(FBX)
 S FBX=$J($FN(FBT("NOP","POVC"),","),10)_" lines populated based on POV match"
 D MES^XPDUTL(FBX)
 S FBX=$J($FN(FBT("NOP","POVU"),","),10)_" lines not populated because POV match not found"
 D MES^XPDUTL(FBX)
 ;
 S FBX=$J($FN(FBT("PTR"),","),10)_" processed lines with an existing authorization pointer value"
 D BMES^XPDUTL(FBX)
 D MES^XPDUTL("----------")
 S FBX=$J($FN(FBT("PTR","7078M"),","),10)_" lines populated with same value based on 7078/583 match"
 D MES^XPDUTL(FBX)
 S FBX=$J($FN(FBT("PTR","7078C"),","),10)_" lines populated with different value based on 7078/583 match"
 D MES^XPDUTL(FBX)
 S FBX=$J($FN(FBT("PTR","7078U"),","),10)_" lines populated with same value since 7078/583 match not found"
 D MES^XPDUTL(FBX)
 S FBX=$J($FN(FBT("PTR","POVM"),","),10)_" lines populated with same value based on POV match"
 D MES^XPDUTL(FBX)
 S FBX=$J($FN(FBT("PTR","POVC"),","),10)_" lines populated with different value based on POV match"
 D MES^XPDUTL(FBX)
 S FBX=$J($FN(FBT("PTR","POVU"),","),10)_" lines populated with same value since POV match not found"
 D MES^XPDUTL(FBX)
 ;
 Q
 ;
ASSOC(FBDFN,FBDOS,FB7078) ; find authorization for ASSOCIATED 7078/583
 ; input
 ;   FBDFN - patient (internal, pointer to file 2 and file 161)
 ;   FBDOS - date of service (internal, FM date)
 ;   FB7078 - associated 7078/583 (internal)
 ; returns null value or authorization IEN in file 161 for patient
 N FBFTP
 S FBFTP=""
 I $G(FB7078)]"",$G(FBDFN)]"",$G(FBDOS)]"" D
 . N FBDA,FBY
 . ; loop thru authorizations for ASSOCIATED 7078/583 and PATIENT
 . S FBDA=0
 . F  S FBDA=$O(^FBAAA("AG",FB7078,FBDFN,FBDA)) Q:'FBDA  D  Q:FBFTP
 . . S FBY=$G(^FBAAA(FBDFN,1,FBDA,0))
 . . Q:$P(FBY,U,1)=""  ; invalid data
 . . Q:$P(FBY,U,1)>FBDOS  ; auth from date is after date of service
 . . Q:$P(FBY,U,2)<FBDOS  ; auth to date is before date of service
 . . ; passed all criterion, found matching authorization
 . . S FBFTP=FBDA
 ;
 Q FBFTP
 ;
POV(FBDFN,FBDOS,FBPOV) ; find authorization for POV
 ; input
 ;   FBDFN - patient (internal, pointer to file 2 and file 161)
 ;   FBDOS - date of service (internal, FM date)
 ;   FBPOV - purpose of visit (internal, pointer to 161.82)
 ; returns null value or authorization IEN in file 161 for patient
 N FBFTP
 S FBFTP=""
 I $G(FBPOV)]"",$G(FBDFN)]"",$G(FBDOS)]"" D
 . N FBDA,FBY
 . ; loop thru authorizations for patient
 . S FBDA=0
 . F  S FBDA=$O(^FBAAA(FBDFN,1,FBDA)) Q:'FBDA  D  Q:FBFTP
 . . S FBY=$G(^FBAAA(FBDFN,1,FBDA,0))
 . . Q:$P(FBY,U,1)=""  ; invalid data
 . . Q:$P(FBY,U,7)'=FBPOV  ; POV does not match input value
 . . Q:$P(FBY,U,1)>FBDOS  ; auth from date is after date of service
 . . Q:$P(FBY,U,2)<FBDOS  ; auth to date is before date of service
 . . ; passed all criterion, found matching authorization
 . . S FBFTP=FBDA
 ;
 Q FBFTP
 ;
 ;
RPT ; report of ^XTMP
 W !,"Report of XTMP(""FB*3.5*154"") data"
 ;
 D LIST("7078C")
 D LIST("7078U")
 D LIST("POVC")
 D LIST("POVU")
 Q
 ;
 ;
LIST(FBSUB) ; list lines in subscript
 N FBIENS,FBFLD,FBFLDN,FBY
 ;
 W:FBSUB["C" !,"Lines with pointer changed based on "
 W:FBSUB["U" !,"Lines with no matching authorization found using "
 W:FBSUB["7078" "associated 7078/583"
 W:FBSUB["POV" "POV"
 I FBSUB["7078" S FBFLD=27,FBFLDN="  7078/583: "
 I FBSUB["POV" S FBFLD=16,FBFLDN="  POV: "
 ;
 S FBIENS=""
 F  S FBIENS=$O(^XTMP("FB*3.5*154",FBSUB,FBIENS)) Q:FBIENS=""  D
 . S FBY=$G(^XTMP("FB*3.5*154",FBSUB,FBIENS))
 . W !,FBIENS,"  From: ",$P(FBY,U,1),"  To: ",$P(FBY,U,2),FBFLDN,$$GET1^DIQ(162.03,FBIENS,FBFLD,"I")
 Q
 ;FBXIP154
