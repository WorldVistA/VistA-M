FBRXFR ;WOIFO/SAB-FILE REMITTANCE REMARKS FOR PHARMACY PAYMENT ;7/17/2003
 ;;3.5;FEE BASIS;**61,158**;JAN 30, 1995;Build 94
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
FILERR(FBIENS,FBRRMK) ; File Remittance Remakrs
 ;
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.11
 ;             in standard format as specified for FileMan DBS calls
 ;   FBRRMK -  required, array passed by reference
 ;             array of remittance remarks to file
 ;             array does not have to contain any data or be defined
 ;             format
 ;               FBRRMK(FBADJ,#)=FBRRMKC
 ;             where
 ;               FBADJ = Adjustment Reason IEN (internal value from file 161.91)
 ;               # = sequentially assigned number starting with 1
 ;               FBRRMKC = remittance remark (internal value file 162.93)
 ; Output
 ;   Data in File 162.11 will be modified
 ;
 N FB,FBFDA,FBI,FBSIENS,FBADJ,FBDA,CNTR,ADJDA
 ;
 ; delete remitance remarks currently on file
 D GETS^DIQ(162.11,FBIENS,"38*","IE","FB")
 K FBFDA
 S FBSIENS="" F  S FBSIENS=$O(FB(162.15,FBSIENS)) Q:FBSIENS=""  D
 . S FBFDA(162.15,FBSIENS,.01)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 ; file remarks from input array
 K FBFDA
 S (FBADJ,CNTR)=0
 D DA^DILF(FBIENS,.FBDA)
 F  S FBADJ=$O(FBRRMK(FBADJ)) Q:'FBADJ  D
 . ;S ADJDA=$$GETADJI(FBADJ,.FBDA)
 . S ADJDA=$S(FBADJ'=999:$$GETADJI(FBADJ,.FBDA),1:FBADJ) ;999 indicates a CARCless RARC
 . S FBI=0
 . F  S FBI=$O(FBRRMK(FBADJ,FBI)) Q:'FBI  D
 . . S CNTR=CNTR+1
 . . S FBFDA(162.15,"+"_CNTR_","_FBIENS,.01)=$P(FBRRMK(FBADJ,FBI),U)
 . . S FBFDA(162.15,"+"_CNTR_","_FBIENS,1)=ADJDA
 I $D(FBFDA) D UPDATE^DIE("","FBFDA")
 ;
 Q
 ;
GETADJI(ADJI,FBDA) ; get correct DA from ADJUSTMENT multiple
 ;
 N DA
 I $D(FBDA)'=11 Q ""
 S DA=""
 I $G(ADJI),$D(^FBAA(162.1,FBDA(1),"RX",FBDA,4,"B",ADJI)) D
 . S DA=$O(^FBAA(162.1,FBDA(1),"RX",FBDA,4,"B",ADJI,DA))
 Q DA
 ;
LOADRR(FBIENS,FBRRMK) ; Load Remittance Remarks
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.11
 ;             in standard format as specified for FileMan DBS calls
 ;   FBRRMK - required, array passed by reference
 ;             array to load adjustments into
 ; Output
 ;   FBRRMK - the FBRRMK input array passed by reference will be modified
 ;             format
 ;               FBRRMK(#)=FBRRMKC
 ;             where
 ;               # = sequentially assigned number starting with 1
 ;               FBRRMKC = remittance remark (internal value file 162.93)
 ;             if no remarks are on file then the array will be undefined
 N FB,FBC,FBI,FBSIENS,ADJMI,FBDA,RRI,ADJI
 ;
 K FBRRMK
 ;
 S FBC=0,ADJMI=""
 D DA^DILF(FBIENS,.FBDA)
 D GETS^DIQ(162.11,FBIENS,"38*","I","FB")
 S FBSIENS=""
 F  S FBSIENS=$O(FB(162.15,FBSIENS)) Q:FBSIENS=""  D
 . S RRI=FB(162.15,FBSIENS,.01,"I")
 . S ADJMI=FB(162.15,FBSIENS,1,"I")
 . I ADJMI,$D(^FBAA(162.1,FBDA(1),"RX",FBDA,4,ADJMI,0)) D
 . . S ADJI=$P(^FBAA(162.1,FBDA(1),"RX",FBDA,4,ADJMI,0),U)
 . E  S ADJI=999
 . S FBC=$S($D(FBRRMK(ADJI)):$O(FBRRMK(ADJI,FBC)),1:0)
 . S FBRRMK(ADJI,FBC+1)=RRI
 ;
 Q
 ;
RRL(FBIENS) ; Remittance Remarks List Extrinsic Function
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.11
 ;             in standard format as specified for FileMan DBS calls
 ; Result
 ;   string containing sorted list (by external code) of remarks
 ;   format
 ;      FBRRMKCE 1, FBRRMKCE 2
 ;   where
 ;      FBRRMKCE = remittance remark code (external value)
 N FBRET,FBRRMK
 D LOADRR^FBRXFR(FBIENS,.FBRRMK)
 S FBRET=$$RRL^FBUTL4(.FBRRMK)
 Q FBRET
 ;
KILLRR(X,DA) ; Called from FEE BASIS PHARMACY INVOICE (#162.1), 
 ;             ADJUSTMENT (#162.11,37), ADJUSTMENT REASON (162.14, .01)
 ;             to delete REMITTANCE REMARK (#162.11,38) entries associated
 ;             with adjustment reasons being deleted.
 ;
 N FBIENS,FB,FBFDA,FBSIENS
 ;
 S FBIENS=$G(DA(1))_","_$G(DA(2))_","
 D GETS^DIQ(162.11,FBIENS,"38*","","FB")
 ;
 S FBSIENS="" F  S FBSIENS=$O(FB(162.15,FBSIENS)) Q:FBSIENS=""  D
 . I FB(162.15,FBSIENS,1)=$G(DA) S FBFDA(162.15,FBSIENS,.01)="@"
 I $D(FBFDA) D FILE^DIE("","FBFDA")
 ;
 Q
 ;FBRXFR
