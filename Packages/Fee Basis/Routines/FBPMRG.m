FBPMRG ;WCIOFO/SAB-FEE BASIS PATIENT MERGE ROUTINE ;12/15/2001
 ;;3.5;FEE BASIS;**19,41,59**;JAN 30, 1995
EN(ARRAY) ; Entry point
 ; Called during patient (file #2) merge due to AFFECTS RECORD MERGE
 ;   in PACKAGE (#9.4) file.
 ; Input
 ;   ARRAY - name of array with the PATIENT (#2) From IENs and To IENs
 ;           format: name(ien_from,ien_to,"ien_from;DPT(","ien_to;DPT(")
 ;           example: TEST(1000,500,"1000;DPT(","500;DPT(")=""
 ;
 N FBFR,FBTO
 ; loop thru from ien of patients (file #2) being merged
 S FBFR=0 F  S FBFR=$O(@ARRAY@(FBFR)) Q:FBFR'>0  D
 . S FBTO=$O(@ARRAY@(FBFR,0)) ; to ien
 . ; check/update some Fee Basis files that normal merge can't handle
 . D F161
 . D F162^FBPMRG1
 Q
 ;
F161 ; File 161 FEE BASIS PATIENT - The .01 field points to and is
 ; dinumed with the PATIENT (#2) file
 ; input
 ;   FBFR - ien of patient (files #2,161) being merged from
 ;   FBTO - ien of patient (files #2,161) being merged to
 N FBFR1,FBTO1
 N DA,DD,DIC,DIK,DINUM,DLAYGO,DO,X,Y
 ;
 Q:'$D(^FBAAA(FBFR))  ; nothing to merge from
 ;
 ;
IDCARD ; if both records have id card numbers the pairs are removed from merge.
 ; all other cases will be handled by merge.
 ;
 I $P($G(^FBAAA(FBFR,4)),U) D
 .I $P($G(^FBAAA(FBTO,4)),U) D
 ..; remove pair from merge when there is a id number in the from and to
 ..S IENFRM=$O(@ARRAY@(FBFR,FBTO,""))
 ..S IENTO=$O(@ARRAY@(FBFR,FBTO,IENFRM,""))
 ..S IEN=""
 ..S IEN=+$G(@ARRAY@(FBFR,FBTO,IENFRM,IENTO))
 ..D RMOVPAIR^XDRDVAL1(FBFR,FBTO,IEN,ARRAY)
 ..N XMSUB,XMTEXT
 ..S XMSUB="MERGE PAIRS EXCLUDED DUE TO BOTH HAVE FEE BASIS ID CARDS"
 ..S ^TMP("DDB",$J,1)="  MERGE PAIR Patient records "_FBFR_" AND "_FBTO_" both have FB ID card numbers.   Please cancel one of the IDs and resubmit the Merge Pair"
 ..S XMTEXT="^TMP(""DDB"",$J,"
 ..D SENDMESG^XDRDVAL1(XMSUB,XMTEXT)
 ..K IEN,IENTO,IENFRM
 ;
 ;
 Q:'$D(^FBAAA(FBTO))  ; if only from ien exists then standard process OK
 ;
 ; both from ien and to ien are in the FEE BASIS PATIENT file.
 ; The AUTHORIZATION multiple and REPORT OF CONTACT multiple can have
 ; duplicate .01 values so they need to be handled here since the
 ; standard merge would inappropriately combine subfile entries whose
 ; .01 values match. Additionally, if the ien of an AUTHORIZATION must
 ; be changed when moved from the 'from ien' to the 'to ien', then
 ; the free-text pointers that reference that AUTHORIZATION will need
 ; to be updated.
 ;
 ; loop thru authorization multiple in 'from ien'
 S FBFR1=0 F  S FBFR1=$O(^FBAAA(FBFR,1,FBFR1)) Q:'FBFR1  D
 . ;
 . ; create new entry in authorization multiple of 'to ien'
 . K DD,DO,DA
 . S DIC="^FBAAA("_FBTO_",1,",DIC(0)="L"
 . S DA(1)=FBTO
 . S X=$P($G(^FBAAA(FBFR,1,FBFR1,0)),U)
 . Q:X=""  ; can't add without a from date
 . I $D(@(DIC_FBFR1_")"))=0 S DINUM=FBFR1 ; use same ien if available
 . S DLAYGO=161.01
 . D FILE^DICN K DIC,DINUM,DLAYGO
 . Q:$P(Y,U,3)'=1  ; couldn't add new authorization
 . S FBTO1=+Y
 . ;
 . ; move data
 . M ^FBAAA(FBTO,1,FBTO1)=^FBAAA(FBFR,1,FBFR1)
 . ;
 . ; delete 'from authorization'
 . S DIK="^FBAAA("_FBFR_",1,"
 . S DA(1)=FBFR,DA=FBFR1
 . D ^DIK K DA,DIK
 . ;
 . ; index 'to authorization'
 . S DIK="^FBAAA("_FBTO_",1,"
 . S DA(1)=FBTO,DA=FBTO1
 . D IX1^DIK K DA,DIK
 . ;
 . ; if authorization ien was changed then update any pointers to it
 . I FBFR1'=FBTO1 D UAUTHP
 ;
 ; loop thru report of contact multiple in 'from ien'
 S FBFR1=0 F  S FBFR1=$O(^FBAAA(FBFR,2,FBFR1)) Q:'FBFR1  D
 . ;
 . ; create new entry in report of contact multiple of 'to ien'
 . K DD,DO,DA
 . S DIC="^FBAAA("_FBTO_",2,",DIC(0)="L"
 . S DA(1)=FBTO
 . S X=$P($G(^FBAAA(FBFR,1,FBFR1,0)),U)
 . Q:X=""  ; can't add without a date of contact
 . I $D(@(DIC_FBFR1_")"))=0 S DINUM=FBFR1 ; use same ien if available
 . S DLAYGO=161.02
 . D FILE^DICN K DIC,DINUM,DLAYGO
 . Q:$P(Y,U,3)'=1  ; couldn't add new report of contact
 . S FBTO1=+Y
 . ;
 . ; move data
 . M ^FBAAA(FBTO,2,FBTO1)=^FBAAA(FBFR,2,FBFR1)
 . ;
 . ; delete 'from report of contact'
 . S DIK="^FBAAA("_FBFR_",2,"
 . S DA(1)=FBFR,DA=FBFR1
 . D ^DIK K DA,DIK
 . ;
 . ; index 'to report of contact'
 . S DIK="^FBAAA("_FBTO_",2,"
 . S DA(1)=FBTO,DA=FBTO1
 . D IX1^DIK
 ;
 Q
 ;
UAUTHP ; Update 'free-text' pointers to authorization
 ; input
 ;   FBFR  - ien of patient (files #2,161) being merged from
 ;   FBFR1 - ien of authorization in FBFR
 ;   FBTO  - ien of patient (files #2,161) being merged to
 ;   FBTO1 - ien of authorization in FBTO
 N AUTHP,DA,DIE,DR,X,X1,Y
 ;
 Q:FBFR1=FBTO1  ; same value so nothing to update
 ;
 ; update file 161.26 FEE BASIS PATIENT MRA
 ; use "B" x-ref to find patient
 K DA S DA=0 F  S DA=$O(^FBAA(161.26,"B",FBFR,DA)) Q:'DA  D
 . ; if existing authorization pointer refers to the authorization
 . ; that was changed then update it
 . S AUTHP=$P($G(^FBAA(161.26,DA,0)),U,3)
 . I AUTHP=FBFR1 D
 . . S DIE="^FBAA(161.26,"
 . . S DR="2////^S X=FBTO1"
 . . D ^DIE
 ;
 ; update file 162 FEE BASIS PAYMENT
 ; use dinum relationship to find patient
 K DA S DA(2)=FBFR
 ; loop thru vendor multiple
 S DA(1)=0 F  S DA(1)=$O(^FBAAC(DA(2),1,DA(1))) Q:'DA(1)  D
 . ; loop thru initial treatment date multiple
 . S DA=0 F  S DA=$O(^FBAAC(DA(2),1,DA(1),1,DA)) Q:'DA  D
 . . ; if existing authorization pointer refers to the authorization
 . . ; that was changed then update it
 . . S AUTHP=$P($G(^FBAAC(DA(2),1,DA(1),1,DA,0)),U,4)
 . . I AUTHP=FBFR1 D
 . . . S DIE="^FBAAC("_DA(2)_",1,"_DA(1)_",1,"
 . . . S DR="3////^S X=FBTO1"
 . . . D ^DIE
 ;
 ; update file 162.1 FEE BASIS PHARMACY INVOICE
 ; use "AD" x-ref to find patient
 ; loop thru inverse dates for 'from patient'
 K DA S X1="" F  S X1=$O(^FBAA(162.1,"AD",FBFR,X1)) Q:X1=""  D
 . ; loop thru invoices
 . S DA(1)=0 F  S DA(1)=$O(^FBAA(162.1,"AD",FBFR,X1,DA(1))) Q:'DA(1)  D
 . . ; loop thru prescriptions
 . . S DA=0 F  S DA=$O(^FBAA(162.1,"AD",FBFR,X1,DA(1),DA)) Q:'DA  D
 . . . ; if existing authorization pointer refers to the authorization
 . . . ; that was changed then update it
 . . . S AUTHP=$P($G(^FBAA(162.1,DA(1),"RX",DA,2)),U,7)
 . . . I AUTHP=FBFR1 D
 . . . . S DIE="^FBAA(162.1,"_DA(1)_",""RX"","
 . . . . S DR="27////^S X=FBTO1"
 . . . . D ^DIE
 ;
 ; update file 162.3 FEE CNH ACTIVITY
 ; use "AE" x-ref to find patient
 K DA S DA="" F  S DA=$O(^FBAACNH("AE",FBFR,DA)) Q:'DA  D
 . ; if existing authorization pointer refers to the authorization
 . ; that was changed then update it
 . S AUTHP=$P($G(^FBAACNH(DA,0)),U,10)
 . I AUTHP=FBFR1 D
 . . S DIE="^FBAACNH("
 . . S DR="9////^S X=FBTO1"
 . . D ^DIE
 ;
 ; update file 162.7 FEE BASIS UNAUTHORIZED CLAIM
 ; using "D" x-ref to find patient
 ; loop thru claims for patient
 K DA S DA=0 F  S DA=$O(^FB583("D",FBFR,DA)) Q:'DA  D
 . ; if existing authorization pointer refers to the authorization
 . ; that was changed then update it
 . S AUTHP=$P($G(^FB583(DA,0)),U,27)
 . I AUTHP=FBFR1 D
 . . S DIE="^FB583("
 . . S DR="30////^S X=FBTO1"
 . . D ^DIE
 Q
 ;
 ;FBPMRG
