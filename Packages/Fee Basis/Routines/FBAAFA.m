FBAAFA ;WOIFO/SAB-FILE ADJUSTMENTS FOR MEDICAL/ANC PAYMENT ;9/9/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 Q
FILEADJ(FBIENS,FBADJ) ; File Adjustments
 ;
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.03
 ;             in standard format as specified for FileMan DBS calls
 ;   FBADJ   - required, array passed by reference
 ;             array of adjustments to file
 ;             array does not have to contain any data or be defined
 ;             format
 ;               FBADJ(#)=FBADJR^FBADJG^FBADJA
 ;             where
 ;               # = sequentially assigned number starting with 1
 ;               FBADJR = adjustment reason (internal value file 162.91)
 ;               FBADJG = adjustment group (internal value file 162.92)
 ;               FBADJA = adjustment amount (dollar value)
 ; Output
 ;   Data in File 162.03 will be modified
 ;
 N FB,FBFDA,FBHIGH,FBI,FBMSR,FBSC,FBSIENS,FBTAS
 ;
 ; delete adjustment reasons currently on file
 D GETS^DIQ(162.03,FBIENS,"52*","","FB")
 K FBFDA
 S FBSIENS="" F  S FBSIENS=$O(FB(162.07,FBSIENS)) Q:FBSIENS=""  D
 . S FBFDA(162.07,FBSIENS,.01)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 ; delete suspend data currently on file
 K FBFDA
 S FBFDA(162.03,FBIENS,3)="@"
 S FBFDA(162.03,FBIENS,3.5)="@"
 S FBFDA(162.03,FBIENS,4)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 ; delete description of suspension currently on file
 D WP^DIE(162.03,FBIENS,22,,"@")
 ;
 ; compute total amount suspended and determine most significant reason
 ; loop thru reasons
 S (FBTAS,FBI,FBHIGH)=0,FBMSR=""
 F  S FBI=$O(FBADJ(FBI)) Q:'FBI  D
 . N FBADJA
 . ; get adjustment amount for reason
 . S FBADJA=$P(FBADJ(FBI),U,3)
 . ; add amount to total
 . S FBTAS=FBTAS+FBADJA
 . ; check if reason has largest absolute $ impact
 . I $FN(FBADJA,"-")>$G(FBHIGH) S FBMSR=FBI,FBHIGH=$FN(FBADJA,"-")
 ;
 I +FBTAS=0 Q  ; quit since total amount suspended is 0
 ;
 ; file adjustments from input array
 K FBFDA
 S FBI=0 F  S FBI=$O(FBADJ(FBI)) Q:'FBI  D
 . S FBFDA(162.07,"+"_FBI_","_FBIENS,.01)=$P(FBADJ(FBI),U)
 . S FBFDA(162.07,"+"_FBI_","_FBIENS,1)=$P(FBADJ(FBI),U,2)
 . S FBFDA(162.07,"+"_FBI_","_FBIENS,2)=+$P(FBADJ(FBI),U,3)
 I $D(FBFDA) D UPDATE^DIE("","FBFDA")
 ;
 ; file derived suspend data
 K FBFDA
 S FBFDA(162.03,FBIENS,3)=FBTAS
 S FBFDA(162.03,FBIENS,3.5)=DT
 I FBMSR,$P(FBADJ(FBMSR),U) S FBSC=$$GET1^DIQ(161.91,$P(FBADJ(FBMSR),U),3)
 I '$G(FBSC) S FBSC=4
 S FBFDA(162.03,FBIENS,4)=FBSC
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 ; if suspend code = 4 (other) then file description of suspension
 I FBSC=4,FBMSR,$P(FBADJ(FBMSR),U) D WP^DIE(162.03,FBIENS,22,,"^FB(161.91,"_$P(FBADJ(FBMSR),U)_",4)")
 D MSG^DIALOG()
 ;
 Q
 ;
LOADADJ(FBIENS,FBADJ) ; Load Adjustments
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.03
 ;             in standard format as specified for FileMan DBS calls
 ;   FBADJ   - required, array passed by reference
 ;             array to load adjustments into
 ; Output
 ;   FBADJ   - the FBADJ input array passed by reference will be modified
 ;             format
 ;               FBADJ(#)=FBADJR^FBADJG^FBADJA
 ;             where
 ;               # = sequentially assigned number starting with 1
 ;               FBADJR = adjustment reason (internal value file 162.91)
 ;               FBADJG = adjustment group (internal value file 162.92)
 ;               FBADJA = adjustment amount (dollar value)
 ;             if no adjustments are on file then the array will be
 ;               undefined
 N FB,FBC,FBI,FBSIENS
 ;
 K FBADJ
 ;
 S FBC=0
 D GETS^DIQ(162.03,FBIENS,"52*","I","FB")
 D MSG^DIALOG()
 S FBSIENS="" F  S FBSIENS=$O(FB(162.07,FBSIENS)) Q:FBSIENS=""  D
 . S FBC=FBC+1
 . S FBADJ(FBC)=FB(162.07,FBSIENS,.01,"I")
 . S FBADJ(FBC)=FBADJ(FBC)_U_FB(162.07,FBSIENS,1,"I")
 . S FBADJ(FBC)=FBADJ(FBC)_U_FB(162.07,FBSIENS,2,"I")
 ;
 Q
 ;
ADJLRA(FBIENS) ; Adjustment Reason^Amount List Extrinsic Function
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.03
 ;             in standard format as specified for FileMan DBS calls
 ; Result
 ;   string containing sorted list (by external code) of reason^amounts
 ;   format
 ;      FBADJE 1, FBADJE 2^FBADJA 1,FBADJA2
 ;   where
 ;      FBADJE = adjustment reason code (external value)
 ;      FBADJA = adjustment amount
 N FBRET,FBADJ,FBADJL,FBADJLA,FBADJLR
 D LOADADJ^FBAAFA(FBIENS,.FBADJ)
 S FBADJL=$$ADJL^FBUTL2(.FBADJ)
 S FBADJLR=$$ADJLR^FBUTL2(FBADJL)
 S FBADJLA=$$ADJLA^FBUTL2(FBADJL)
 S FBRET=FBADJLR_U_FBADJLA
 Q FBRET
 ;
 ;FBAAFA
