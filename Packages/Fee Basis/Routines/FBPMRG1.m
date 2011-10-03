FBPMRG1 ;WCIOFO/SAB-FEE BASIS PATIENT MERGE ROUTINE (cont) ;12/15/2001
 ;;3.5;FEE BASIS;**19,41**;JAN 30, 1995
 Q
F162 ; File 162 FEE BASIS PAYMENT - The .01 field points to and is
 ; dinumed with the PATIENT (#2) file
 ; input
 ;   FBFR - ien of patient (files #2,162) being merged from
 ;   FBTO - ien of patient (files #2,162) being merged to
 N FBAUTHP,FBFR1,FBFR2,FBFR3,FBFRIENS,FBTO1,FBTO2,FBTO3,FBTOIENS
 N DA,DD,DO,DIC,DIK,DINUM,DLAYGO,X,Y
 ;
 Q:'$D(^FBAAC(FBFR))  ; nothing to merge from
 ;
 ; since a 'from ien' exists, we'll need to keep track of the old
 ; and new 'iens' of payments that may have been reported to the
 ; Austin Automation Center (AAC). The AAC returns data concerning the
 ; payments and the 'iens' are used to locate the appropriate entry to
 ; update.
 ;
 ; Additionally, if both the from ien and to ien are in the FEE BASIS
 ; PAYMENT file then the SERVICE PROVIDED multiple and the TRAVEL
 ; PAYMENT DATE multiple will need to be handled here since they
 ; are allowed to have duplicate .01 values and a standard merge could
 ; inappropriately combine subfile entries whose .01 values match.
 ;
 ; medical payments
 ; loop thru vendor multiple
 S FBFR1=0 F  S FBFR1=$O(^FBAAC(FBFR,1,FBFR1)) Q:'FBFR1  D
 . ; loop thru initial treatment date multiple
 . S FBFR2=0 F  S FBFR2=$O(^FBAAC(FBFR,1,FBFR1,1,FBFR2)) Q:'FBFR2  D
 . . S FBAUTHP=$P($G(^FBAAC(FBFR,1,FBFR1,1,FBFR2,0)),U,4) ; auth pointer
 . . ; loop thru service provided multiple
 . . S FBFR3=0
 . . F  S FBFR3=$O(^FBAAC(FBFR,1,FBFR1,1,FBFR2,1,FBFR3)) Q:'FBFR3  D
 . . . S FBFRIENS=FBFR3_","_FBFR2_","_FBFR1_","_FBFR_","
 . . . ; If the 'to ien' does not exist then only the patient ien will be
 . . . ; different on payments sent to the AAC. We just need to save
 . . . ; the iens and the normal merge will take care of moving the data.
 . . . I '$D(^FBAAC(FBTO)) S FBTOIENS=FBFR3_","_FBFR2_","_FBFR1_","_FBTO_","
 . . . E  D
 . . . . ; both from ien and to ien are in the FEE BASIS PAYMENT file
 . . . . S (FBTO1,FBTO2,FBTO3,FBTOIENS)="" ; initialize new iens
 . . . . ;
 . . . . ; create new service provided entry in 'to ien'
 . . . . ; find or create vendor subentry in 'to ien'
 . . . . I $D(^FBAAC(FBTO,1,FBFR1)) S FBTO1=FBFR1
 . . . . E  D
 . . . . . ; need to add vendor subentry
 . . . . . K DA,DD,DO
 . . . . . S DA(1)=FBTO
 . . . . . S DIC="^FBAAC("_DA(1)_",1,"
 . . . . . S DIC(0)="L"
 . . . . . S X=$P($G(^FBAAC(FBFR,1,FBFR1,0)),U)
 . . . . . Q:X=""
 . . . . . S DINUM=X,DLAYGO=162.01
 . . . . . D FILE^DICN K DIC,DINUM,DLAYGO
 . . . . . Q:$P(Y,U,3)'=1  ; couldn't add vendor subentry
 . . . . . S FBTO1=+Y
 . . . . Q:'$G(FBTO1)  ; couldn't find or add the vendor in FBTO
 . . . . ;
 . . . . ; find or create initial treatment date subentry in 'to ien'
 . . . . ;
 . . . . S X=$P($G(^FBAAC(FBFR,1,FBFR1,1,FBFR2,0)),U) ; init treat date
 . . . . Q:X=""
 . . . . S FBTO2=$O(^FBAAC(FBTO,FBTO1,"AD",(9999999.9999-X),0))
 . . . . I 'FBTO2 D
 . . . . . ; need to add initial treatment date subentry
 . . . . . K DA,DD,DO
 . . . . . S DA(2)=FBTO
 . . . . . S DA(1)=FBTO1
 . . . . . S DIC="^FBAAC("_DA(2)_",1,"_DA(1)_",1,"
 . . . . . S DIC(0)="L"
 . . . . . S:FBAUTHP DIC("DR")="3////^S X=FBAUTHP" ;authorization pointer
 . . . . . I $D(@(DIC_FBFR2_")"))=0 S DINUM=FBFR2 ; use same ien if avail
 . . . . . S DLAYGO=162.02
 . . . . . D FILE^DICN K DIC,DINUM,DLAYGO
 . . . . . Q:$P(Y,U,3)'=1  ; couldn't add init treat date subentry
 . . . . . S FBTO2=+Y
 . . . . Q:'$G(FBTO2)  ; couldn't find or add the init treat date in FBTO
 . . . . ;
 . . . . ; create new entry in service provided multiple of 'to ien'
 . . . . K DA,DD,DO
 . . . . S DA(3)=FBTO,DA(2)=FBTO1,DA(1)=FBTO2
 . . . . S DIC="^FBAAC("_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,"
 . . . . S DIC(0)="L"
 . . . . S X=$P($G(^FBAAC(FBFR,1,FBFR1,1,FBFR2,1,FBFR3,0)),U)
 . . . . Q:X=""  ; can't add without a service provided
 . . . . I $D(@(DIC_FBFR3_")"))=0 S DINUM=FBFR3 ; use same ien if avail.
 . . . . S DLAYGO=162.03
 . . . . D FILE^DICN K DIC,DINUM,DLAYGO
 . . . . Q:$P(Y,U,3)'=1  ; couldn't add new subentry
 . . . . S FBTO3=+Y
 . . . . S FBTOIENS=FBTO3_","_FBTO2_","_FBTO1_","_FBTO_","
 . . . . ;
 . . . . ; move service provided data
 . . . . M ^FBAAC(FBTO,1,FBTO1,1,FBTO2,1,FBTO3)=^FBAAC(FBFR,1,FBFR1,1,FBFR2,1,FBFR3)
 . . . . ;
 . . . . ; delete 'from' service provided
 . . . . K DA S DA(3)=FBFR,DA(2)=FBFR1,DA(1)=FBFR2,DA=FBFR3
 . . . . S DIK="^FBAAC("_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,"
 . . . . D ^DIK K DA,DIK
 . . . . ;
 . . . . ; index 'to' service provided
 . . . . K DA S DA(3)=FBTO,DA(2)=FBTO1,DA(1)=FBTO2,DA=FBTO3
 . . . . S DIK="^FBAAC("_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,"
 . . . . D IX1^DIK K DA,DIK
 . . . . ;
 . . . Q:$G(FBTOIENS)=""  ; unable to move service provided to FBTO
 . . . ; save iens (FBFRIENS and FBTOIENS) to file
 . . . D SAVIENS(162.03,FBFRIENS,FBTOIENS)
 . . ; if all service provided entries moved then delete the treat. date
 . . I $P($G(^FBAAC(FBFR,1,FBFR1,1,FBFR2,1,0)),U,4)=0 D
 . . . K DA S DA(2)=FBFR,DA(1)=FBFR1,DA=FBFR2
 . . . S DIK="^FBAAC("_DA(2)_",1,"_DA(1)_",1,"
 . . . D ^DIK K DA,DIK
 . ; if all initial treatment dates moved then delete the vendor
 . I $P($G(^FBAAC(FBFR,1,FBFR1,1,0)),U,4)=0 D
 . . K DA S DA(1)=FBFR,DA=FBFR1
 . . S DIK="^FBAAC("_DA(1)_",1,"
 . . D ^DIK K DA,DIK
 ;
 ; travel payments
 ; loop thru travel payment date multiple
 S FBFR1=0 F  S FBFR1=$O(^FBAAC(FBFR,3,FBFR1)) Q:'FBFR1  D
 . S FBFRIENS=FBFR1_","_FBFR_","
 . ; If the 'to ien' does not exist then only the patient ien will be
 . ; different on payments sent to the AAC. We just need to save
 . ; the iens and the normal merge will take care of moving the data.
 . I '$D(^FBAAC(FBTO)) S FBTOIENS=FBFR1_","_FBTO_","
 . E  D
 . . ; both from ien and to ien are in the FEE BASIS PAYMENT file
 . . ; create travel payment date subentry in to ien
 . . S (FBTO1,FBTOIENS)="" ; initialize new iens
 . . K DA,DD,DO
 . . S DA(1)=FBTO
 . . S DIC="^FBAAC("_DA(1)_",3,"
 . . S DIC(0)="L"
 . . S X=$P($G(^FBAAC(FBFR,3,FBFR1,0)),U)
 . . Q:X=""  ; can't add without a travel payment date
 . . I $D(@(DIC_FBFR1_")"))=0 S DINUM=FBFR1 ; use same ien if avail.
 . . S DLAYGO=162.04
 . . D FILE^DICN K DIC,DINUM,DLAYGO
 . . Q:$P(Y,U,3)'=1  ; couldn't add new subentry
 . . S FBTO1=+Y
 . . S FBTOIENS=FBTO1_","_FBTO_","
 . . ;
 . . ; move data
 . . M ^FBAAC(FBTO,3,FBTO1)=^FBAAC(FBFR,3,FBFR1)
 . . ;
 . . ; delete from ien
 . . K DA S DA(1)=FBFR,DA=FBFR1
 . . S DIK="^FBAAC("_DA(1)_",3,"
 . . D ^DIK K DA,DIK
 . . ;
 . . ; index to ien
 . . K DA S DA(1)=FBTO,DA=FBTO1
 . . S DIK="^FBAAC("_DA(1)_",3,"
 . . D IX1^DIK K DA,DIK
 . ;
 . Q:$G(FBTOIENS)=""  ; unable to move travel payment date to FBTO
 . ; save iens (FBFRIENS and FBTOIENS) to file
 . D SAVIENS(162.04,FBFRIENS,FBTOIENS)
 ;
 Q
 ;
SAVIENS(FBFILE,FBOLDIEN,FBNEWIEN) ; save old & new iens in file 161.45
 N DA,DD,DIC,DLAYGO,DO,X,Y
 S DIC="^FBAA(161.45,",DIC(0)="L"
 S X=FBFILE
 Q:X=""  ; can't add without a from date
 S DIC("DR")="1////^S X=FBOLDIEN;2////^S X=FBNEWIEN"
 S DLAYGO=161.45
 D FILE^DICN K DIC,DLAYGO
 Q
 ;
 ;FBPMRG1
