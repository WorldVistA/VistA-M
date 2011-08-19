BPSECA8 ;BHAM ISC/FCS/DRS/VA/DLF - construct a claim reversal ;05/17/04
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; REVERSE - The way we build the claim reversal is to take the
 ; source data from the original claim (CLAIMIEN) and position therein (POS).
 ;
 ; Remember, you have two 401 fields - one in header, one in prescription.
 ;
 ; 5.1 Updates
 ; There are new fields to consider in the 5.1 reversal process, in
 ; addition to a new value for the transaction code (B2)
 ;
 ; Input
 ;   IEN59  - Transaction number
 ; Returns REVIEN of the reversal claim created
 ;
REVERSE(IEN59) ;EP - from BPSOSRB
 ;
 ; Variable initialization
 N CLAIM,RXMULT,BPSFORM,BPS,I,TMP
 N DIC,DR,DIQ,DIE,DA,X,DLAYGO,REVIEN,Y,UERETVAL
 S CLAIM=9002313.02,RXMULT=9002313.0201
 ;
 ; Check IEN59
 I $G(IEN59)="" Q 0
 ;
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG^BPSOSL(IEN59,$T(+0)_"-Gathering claim information")
 ;
 ; Get Claim and multiple POS
 N CLAIMIEN,POS
 S CLAIMIEN=$P(^BPST(IEN59,0),U,4)
 I CLAIMIEN="" Q 0
 S POS=$O(^BPSC(CLAIMIEN,400,0))
 I POS="" Q 0
 ;
 ; Get reversal payer sheet.  If missing, quit
 S BPSFORM=$$GET1^DIQ(9002313.59902,"1,"_IEN59_",","902.19","I")
 I BPSFORM="" Q 0
 ;
 ; Get data from original claim request
 S DR="**",DIQ="TMP",DIQ(0)="I"
 D GETS^DIQ(CLAIM,CLAIMIEN,DR,DIQ(0),DIQ)
 ;
 ; Update CLAIMIEN to match CLAIMIEN format in TMP
 S CLAIMIEN=CLAIMIEN_","
 ;
 ; Execute special code in reversal payer sheets
 D REFORM^BPSOSHR(BPSFORM,CLAIMIEN,POS)
 ;
 ; Create a new claim record and use function to get the Claim ID
R2 S DIC=CLAIM,DIC(0)="LX",DLAYGO=CLAIM
 S X=$$CLAIMID^BPSECX1(IEN59)
 I X="" Q 0
 D ^DIC
 S REVIEN=+Y
 I REVIEN<1 Q 0
 ;
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG^BPSOSL(IEN59,$T(+0)_"-Created claim ID "_X_" ("_REVIEN_")")
 ;
 ; Create a new prescription multiple for the claim
R4 S DIC="^BPSC("_REVIEN_",400,",DIC(0)="LX"
 S DIC("P")=$P(^DD(CLAIM,400,0),U,2)
 S DA(1)=REVIEN,DLAYGO=RXMULT,X=1
 D ^DIC
 I +Y'=1 D  G:UERETVAL R4
 . S UERETVAL=$$IMPOSS^BPSOSUE("FM,P",,"call to ^DIC","for multiple",,$T(+0))
 ;
 ; Update claim with new values
 S DIE=CLAIM,DA=REVIEN,DR=""
 F I=.03,.04,1.01,1.04,101,102,104,110,201,202,302,304,305,310,311,331,332,401 D
 . S DR=DR_I_"////"_$G(TMP(CLAIM,CLAIMIEN,I,"I"))_";"
 ; Add fields that do not come from the claim
 ;   Payer sheet is the reversal sheet, Created On is current date/time
 ;   Transaction Code is B2 and Transaction Count is 1
 S DR=DR_".02////"_BPSFORM_";.06////"_$$NOWFM^BPSOSU1()
 S DR=DR_";103////B2;109////1"
 D ^DIE
 ;
 ; Update multiple with new values
 S DIE="^BPSC("_REVIEN_",400,"
 S DA(1)=REVIEN,DA=1,DR=""
 F I=.03,.04,.05,308,401,402,403,407,418,420,436,438,455 D
 . S DR=DR_I_"////"_$G(TMP(RXMULT,POS_","_CLAIMIEN,I,"I"))_";"
 S DR=$E(DR,1,$L(DR)-1) ; get rid of extra trailing ";"
 D ^DIE
 ;
 Q REVIEN
