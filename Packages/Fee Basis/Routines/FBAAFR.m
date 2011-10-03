FBAAFR ;WOIFO/SAB-FILE REMITTANCE REMARKS FOR MEDICAL/ANC PAYMENT ;7/16/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
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
LOADRR(FBIENS,FBRRMK) ; Load Remittance Remarks
 ; Input
 ;   FBIENS -  required, internal entry numbers for subfile 162.03
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
 N FB,FBC,FBI,FBSIENS
 ;
 K FBRRMK
 ;
 S FBC=0
 D GETS^DIQ(162.03,FBIENS,"53*","I","FB")
 S FBSIENS="" F  S FBSIENS=$O(FB(162.08,FBSIENS)) Q:FBSIENS=""  D
 . S FBC=FBC+1
 . S FBRRMK(FBC)=FB(162.08,FBSIENS,.01,"I")
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
 ;FBAAFR
