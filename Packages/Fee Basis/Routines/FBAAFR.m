FBAAFR ;WOIFO/SAB-FILE REMITTANCE REMARKS FOR MEDICAL/ANC PAYMENT ;7/16/2003
 ;;3.5;FEE BASIS;**61,158**;JAN 30, 1995;Build 94
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
FILERR(FBIENS,FBRRMK) ; File Remittance Remakrs
 ;
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.03
 ;             in standard format as specified for FileMan DBS calls
 ;   FBRRMK -  required, array passed by reference
 ;             array of remittance remarks to file
 ;             array does not have to contain any data or be defined
 ;             format
 ;               FBRRMK(FBADJ,#)=FBRRMKC
 ;             where
 ;               FBADJ = Adjustment Reason Code IEN
 ;               # = sequentially assigned number starting with 1
 ;               FBRRMKC = remittance remark (internal value file 162.93)
 ; Output
 ;   Data in File 162.03 will be modified
 ;
 N FB,FBFDA,FBI,FBSIENS,FBADJ,CNTR,ADJDA
 ;
 ; delete remitance remarks currently on file
 D GETS^DIQ(162.03,FBIENS,"53*","","FB")
 K FBFDA
 S FBSIENS="" F  S FBSIENS=$O(FB(162.08,FBSIENS)) Q:FBSIENS=""  D
 . S FBFDA(162.08,FBSIENS,.01)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 ; file remarks from input array
 K FBFDA
 ;FB*3.5*158
 S (FBADJ,CNTR)=0
 D DA^DILF(FBIENS,.FBDA)
 F  S FBADJ=$O(FBRRMK(FBADJ)) Q:'FBADJ  D
 . ;S ADJDA=$$GETADJI(FBADJ,.FBDA)
 . S ADJDA=$S(FBADJ'=999:$$GETADJI(FBADJ,.FBDA),1:FBADJ) ;999 indicates a CARCless RARC
 . S FBI=0
 . F  S FBI=$O(FBRRMK(FBADJ,FBI)) Q:'FBI  D
 . . S CNTR=CNTR+1
 . . S FBFDA(162.08,"+"_CNTR_","_FBIENS,.01)=$P(FBRRMK(FBADJ,FBI),U)
 . . S FBFDA(162.08,"+"_CNTR_","_FBIENS,1)=ADJDA
 I $D(FBFDA) D UPDATE^DIE("","FBFDA")
 Q
 ;
GETADJI(ADJI,FBDA) ; get correct DA from ADJUSTMENT multiple
 ;
 N DA
 I $D(FBDA)'=11 Q ""
 S DA=""
 I $G(FBDA),$G(FBDA(1)),$G(FBDA(2)),$G(FBDA(3)),$G(ADJI) D
 . I $D(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,7,"B",ADJI)) D
 . . S DA=$O(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,7,"B",ADJI,DA))
 Q DA
 ;
LOADRR(FBIENS,FBRRMK) ; Load Remittance Remarks
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.03
 ;             in standard format as specified for FileMan DBS calls
 ;   FBRRMK - required, array passed by reference
 ;             array to load adjustments into
 ; Output
 ;   FBRRMK - the FBRRMK input array passed by reference will be modified
 ;             format
 ;               FBRRMK(ADJI,#)=FBRRMKC
 ;             where
 ;               ADJI = ADJUSTMENT REASON IEN
 ;               # = sequentially assigned number starting with 1
 ;               FBRRMKC = remittance remark (internal value file 162.93)
 ;             if no remarks are on file then the array will be undefined
 N FB,FBC,FBI,FBSIENS,FBDA,RRI,ADJMI,ADJI
 ;
 K FBRRMK
 ;
 S FBC=0,ADJMI=""
 D DA^DILF(FBIENS,.FBDA)
 I $D(FBDA)'=11 Q
 D GETS^DIQ(162.03,FBIENS,"53*","I","FB")
 S FBSIENS=""
 F  S FBSIENS=$O(FB(162.08,FBSIENS)) Q:FBSIENS=""  D
 . S RRI=FB(162.08,FBSIENS,.01,"I")
 . S ADJMI=FB(162.08,FBSIENS,1,"I")
 . I ADJMI,$D(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,7,ADJMI,0)) D
 . . S ADJI=$P(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,7,ADJMI,0),U)
 . E  S ADJI=999
 . S FBC=$S($D(FBRRMK(ADJI)):$O(FBRRMK(ADJI,FBC)),1:0)
 . S FBRRMK(ADJI,FBC+1)=RRI
 ;
 Q
 ;
RRL(FBIENS) ; Remittance Remarks List Extrinsic Function
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.03
 ;             in standard format as specified for FileMan DBS calls
 ; Result
 ;   string containing sorted list (by external code) of remarks
 ;   format
 ;      FBRRMKCE 1, FBRRMKCE 2
 ;   where
 ;      FBRRMKCE = remittance remark code (external value)
 N FBRET,FBRRMK
 D LOADRR^FBAAFR(FBIENS,.FBRRMK)
 S FBRET=$$RRL^FBUTL4(.FBRRMK)
 Q FBRET
 ;
KILLRR(X,DA) ; Called from FEE BASIS PAYMENT (#162), 
 ;             ADJUSTMENT (#162.03,52), ADJUSTMENT REASON (162.07, .01)
 ;             to delete remittance remarks associated with adjustment
 ;             reasons being deleted.
 ;
 N FBIENS,FB,FBFDA,FBSIENS
 ;
 S FBIENS=$G(DA(1))_","_$G(DA(2))_","_$G(DA(3))_","_$G(DA(4))_","
 D GETS^DIQ(162.03,FBIENS,"53*","","FB")
 ;
 S FBSIENS="" F  S FBSIENS=$O(FB(162.08,FBSIENS)) Q:FBSIENS=""  D
 . I FB(162.08,FBSIENS,1)=$G(DA) S FBFDA(162.08,FBSIENS,.01)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 Q
 ;
FILERRCP(FBIENS,FBRRMK) ; File Remittance Remakrs
 ;
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.03
 ;             in standard format as specified for FileMan DBS calls
 ;   FBRRMK -  required, array passed by reference
 ;             array of remittance remarks to file
 ;             array does not have to contain any data or be defined
 ;             format
 ;               FBRRMK(#)=FBRRMKC
 ;             where
 ;               # = sequentially assigned number starting with 1
 ;               FBRRMKC = remittance remark (internal value file 162.93)
 ; Output
 ;   Data in File 162.03 will be modified
 ;
 N FB,FBFDA,FBI,FBSIENS
 ;
 ; delete remitance remarks currently on file
 D GETS^DIQ(162.03,FBIENS,"53*","","FB")
 K FBFDA
 S FBSIENS="" F  S FBSIENS=$O(FB(162.08,FBSIENS)) Q:FBSIENS=""  D
 . S FBFDA(162.08,FBSIENS,.01)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 ; file remarks from input array
 K FBFDA
 S FBI=0 F  S FBI=$O(FBRRMK(FBI)) Q:'FBI  D
 . S FBFDA(162.08,"+"_FBI_","_FBIENS,.01)=$P(FBRRMK(FBI),U)
 I $D(FBFDA) D UPDATE^DIE("","FBFDA")
 ;
 Q
 ;
 ;FBAAFR
