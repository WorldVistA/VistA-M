ENTIUTL1 ;WOIFO/SAB - Engineering Utilities ;2/4/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 ; this routine contains APIs that create or modify IT assignment data
 ;
ASGN(ENDA,EN200) ; Assign Equipment Responsibility
 ; input
 ;   ENDA = equipment ien (file 6914)
 ;   EN200 = owner ien (file 200)
 ; returns value =
 ;    0 (already exists) or
 ;    E (error) or
 ;    internal entry number of the created record (positive integer)
 N ENERR,ENFDA,ENIEN,ENRET
 S ENRET=0
 ; only create if owner does not have an active assignment for the item
 I '$D(^ENG(6916.3,"AOA",EN200,ENDA)) D
 . S ENFDA(6916.3,"+1,",.01)=ENDA
 . S ENFDA(6916.3,"+1,",1)=EN200
 . S ENFDA(6916.3,"+1,",2)=$$NOW^XLFDT()
 . S ENFDA(6916.3,"+1,",3)=DUZ
 . D UPDATE^DIE("","ENFDA","ENIEN","ENERR")
 . S ENRET=$S($D(ENERR):"E",1:ENIEN(1))
 ;
 Q ENRET
 ;
SIGN(ENDA) ; Sign Equipment Responsibility
 ; input
 ;   ENDA = assignment ien (file 6916.3)
 ; returns value = 1 (signed) or 0 (not active) or E (error)
 N ENERR,ENFDA,ENHRT,ENRET,ENSTR,ENSTRH,ENY,X,X1,X2
 S ENRET=0
 ; only sign if assignment is active
 I $P($G(^ENG(6916.3,ENDA,0)),U,8)="" D
 . S ENHRT=$O(^ENG(6916.2," "),-1) ; current hand receipt text ien
 . I 'ENHRT S ENRET="E" Q  ; required
 . ;
 . ; if already signed or certified then retain that data in history
 . D SAVSIG
 . I $D(ENERR) S ENRET="E" Q  ; error during DBS call
 . ;
 . ; build signature block string
 . S ENY=$G(^ENG(6916.3,ENDA,0))
 . S ENSTR=$$ESBLOCK^XUSESIG1()
 . S ENSTR=ENSTR_U_$P(ENY,U) ; equipment ien
 . S ENSTR=ENSTR_U_$P(ENY,U,2) ; owner ien
 . S ENSTR=ENSTR_U_ENHRT ; hand receipt text ien
 . S ENSTR=ENSTR_U_$$GET1^DIQ(6916.2,ENHRT,3) ; hand receipt checksum
 . S X=ENSTR,X1=ENDA,X2=1 D EN^XUSHSHP S ENSTRH=X ; hashed string
 . ;
 . ; set up FDA array for DBS call
 . S ENFDA(6916.3,ENDA_",",4)=$P(ENSTR,U,4) ; signed date/time
 . S ENFDA(6916.3,ENDA_",",5)=ENHRT ; hand receipt text
 . S ENFDA(6916.3,ENDA_",",5.9)="@" ; may be leftover from prior cert
 . S ENFDA(6916.3,ENDA_",",6)="@" ; may be leftover from prior cert
 . S ENFDA(6916.3,ENDA_",",9)=ENSTRH ; encrypted string
 . ;
 . D FILE^DIE("","ENFDA","ENERR")
 . S ENRET=$S($D(ENERR):"E",1:1)
 ;
 Q ENRET
 ;
CERT(ENDA,ENDT) ; Certify Signature for Equipment Responsibility
 ; input
 ;   ENDA = assignment ien (file 6916.3)
 ;   ENDT = date of signature (FileMan internal date)
 ; returns value = 1 (created) or 0 (not active) or E (error)
 N ENERR,ENFDA,ENHRT,ENRET
 S ENRET=0
 ; only certify if assignment is active
 I $P($G(^ENG(6916.3,ENDA,0)),U,8)="" D
 . I $G(ENDT)'?7N S ENRET="E" Q  ; required
 . ;
 . S ENHRT=$O(^ENG(6916.2," "),-1) ; current hand receipt text ien
 . I 'ENHRT S ENRET="E" Q  ; required
 . ;
 . ; if already signed or certified then retain that data in history
 . D SAVSIG
 . I $D(ENERR) S ENRET="E" Q  ; error during DBS call
 . ;
 . ; set data for a certification
 . S ENFDA(6916.3,ENDA_",",4)=ENDT
 . S ENFDA(6916.3,ENDA_",",5)=ENHRT
 . S ENFDA(6916.3,ENDA_",",5.9)=$$NOW^XLFDT()
 . S ENFDA(6916.3,ENDA_",",6)=DUZ
 . S ENFDA(6916.3,ENDA_",",9)="@" ; may be leftover from prior e-sig
 . ;
 . D FILE^DIE("","ENFDA","ENERR")
 . S ENRET=$S($D(ENERR):"E",1:1)
 ;
 Q ENRET
 ;
TERM(ENDA) ; Terminate Equipment Responsibility Assignment
 ; input
 ;   ENDA = assignment ien (file 6916.3)
 ; returns value = 1 (created) or 0 (not active) or E (error)
 N ENERR,ENFDA,ENRET
 S ENRET=0
 ; only terminate if assignment is active
 I $P($G(^ENG(6916.3,ENDA,0)),U,8)="" D
 . S ENFDA(6916.3,ENDA_",",7)=$$NOW^XLFDT()
 . S ENFDA(6916.3,ENDA_",",8)=DUZ
 . D FILE^DIE("","ENFDA","ENERR")
 . S ENRET=$S($D(ENERR):"E",1:1)
 ;
 Q ENRET
 ;
SAVSIG ; Save current signature data (if any) to previous signature multiple
 ; input ENDA = ien of assignment (file 6916.3)
 ; result = may create entry in subfile 6916.31
 ; output ENERR - only defined if there was an error during DBS call
 N ENFDA,ENY,ENY1
 ; if already signed or certified then retain that data in history
 S ENY=$G(^ENG(6916.3,ENDA,0))
 Q:'$P(ENY,U,5)  ; not signed or certified
 S ENY1=$G(^ENG(6916.3,ENDA,1))
 ;
 S ENFDA(6916.31,"+1,"_ENDA_",",.01)=$P(ENY,U,5)
 I $P(ENY,U,6) S ENFDA(6916.31,"+1,"_ENDA_",",1)=$P(ENY,U,6)
 I $P(ENY,U,10) S ENFDA(6916.31,"+1,"_ENDA_",",2)=$P(ENY,U,10)
 I $P(ENY,U,7) S ENFDA(6916.31,"+1,"_ENDA_",",3)=$P(ENY,U,7)
 I $P(ENY1,U)]"" S ENFDA(6916.31,"+1,"_ENDA_",",4)=$P(ENY1,U)
 ;
 D UPDATE^DIE("","ENFDA","","ENERR")
 ;
 Q
 ;
 ;ENTIUTL1
