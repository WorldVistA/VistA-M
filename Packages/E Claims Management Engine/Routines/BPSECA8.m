BPSECA8 ;BHAM ISC/FCS/DRS/VA/DLF - construct a claim reversal ;05/17/04
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,10,12,11,15,20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;External reference to $$PLANEPS^IBNCPDPU supported by IA 5572
 ;
 Q
 ;
REVERSE(IEN59) ;
 ; Function to build a Reversal claim by copying selected data from the Billing
 ;   Request into the new Reversal Claim record
 ;
 ; Input Parameter
 ;   IEN59 - Transaction number
 ; Returns
 ;   REVIEN (0 if unsuccessful or IEN of the Reversal Claim)
 ;
 Q:$G(IEN59)="" 0  ; required
 ;
 N BPS,BPSFORM,C,CLAIM,CLAIMIEN,DA,DIC,DIE,DIQ,DLAYGO,DR,I,L,POS,REVIEN,RXMULT,TMP,UERETVAL
 N VERSION,FLD402,X,Y,COB,REC,FN,FDA,MSG,IENS,PLAN,PLANSHT,TRANSHT,SHEETSRC,IEN5902
 ;
 S CLAIM=9002313.02,RXMULT=9002313.0201
 ;
 ; Needed for Turn-Around Stats - Do NOT delete/alter!!
 D LOG^BPSOSL(IEN59,$T(+0)_"-Gathering claim information")
 ;
 ; Get Claim and multiple POS
 S CLAIMIEN=$P(^BPST(IEN59,0),U,4)
 I CLAIMIEN="" Q 0
 S POS=$O(^BPSC(CLAIMIEN,400,0))
 I POS="" Q 0
 ;
 ; Get the reversal payer sheets from the Pharmacy Plan and the BPS Transaction
 S (BPSFORM,PLANSHT,SHEETSRC)=""
 S IEN5902=$$GET1^DIQ(9002313.59,IEN59,901,"I")
 I 'IEN5902 S IEN5902=1
 S PLAN=$$GET1^DIQ(9002313.59902,IEN5902_","_IEN59_",",".01","I")
 I PLAN S PLANSHT=$P($P($$PLANEPS^IBNCPDPU(PLAN),U,2),",",2),BPSFORM=PLANSHT,SHEETSRC="plan" ; IA5572
 S TRANSHT=$$GET1^DIQ(9002313.59902,IEN5902_","_IEN59_",","902.19","I")
 ;
 ; If the reversal payer sheet is missing from the pharmacy plan or is disabled, use the
 ;   reversal payer sheet from the transaction record
 I 'PLANSHT!($$GET1^DIQ(9002313.92,+PLANSHT_",",1.06,"I")=0) S BPSFORM=TRANSHT,SHEETSRC="transaction"
 ;
 ; If still no reversal payer sheet, log an error and quit.
 I 'BPSFORM D LOG^BPSOSL(IEN59,$T(+0)_"-No Reversal Payer Sheet found") Q 0
 ;
 ; Log the payer sheet and the source
 D LOG^BPSOSL(IEN59,$T(+0)_"-Reversal payer sheet "_$$GET1^DIQ(9002313.92,BPSFORM_",",.01,"E")_" ("_BPSFORM_") came from the "_SHEETSRC)
 ;
 ; If the payer sheet is different than what is currently stored in the BPS Transaction, update the BPS Transaction
 I BPSFORM'=TRANSHT D
 . N DIE,DA,DR,DTOUT
 . S DIE="^BPST("_IEN59_",10,",DA(1)=IEN59,DA=IEN5902,DR="902.19////^S X=BPSFORM"
 . D ^DIE
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Transaction updated with reversal payer sheet "_BPSFORM)
 ;
 ; Get payer sheet version
 S VERSION=$P(^BPSF(9002313.92,BPSFORM,1),"^",2)
 I VERSION="" S VERSION="D0"
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
 ; Create a new transaction multiple for the claim
R4 S DIC="^BPSC("_REVIEN_",400,",DIC(0)="LX"
 S DIC("P")=$P(^DD(CLAIM,400,0),U,2)
 S DA(1)=REVIEN,DLAYGO=RXMULT,X=1
 D ^DIC
 I +Y'=1 D  G:UERETVAL R4
 . S UERETVAL=$$IMPOSS^BPSOSUE("FM,P",,"call to ^DIC","for multiple",,$T(+0))
 ;
 ; Update claim with new values
 S DIE=CLAIM,DA=REVIEN,DR="",C=0
 F I=.03,.04,1.01,1.04,101,104,110,201,202,301,302,304,305,310,311,331,332,359,401 D
 .S C=C+1,$P(DR,";",C)=I_"////"_$G(TMP(CLAIM,CLAIMIEN,I,"I"))
 ;
 ; Update claim with new A22, A43 and A45 values but only if these fields were on original B1 Payer Sheet- BPS*1*15
 F I=1022,1043,1045 D
 .I $G(TMP(CLAIM,CLAIMIEN,I,"I"))]"" S C=C+1,$P(DR,";",C)=I_"////"_TMP(CLAIM,CLAIMIEN,I,"I")
 ;
 ; Add fields that do not come from the claim
 ;   Payer sheet is the reversal sheet, Created On is current date/time
 ;   Transaction Code is B2 and Transaction Count is 1
 S DR=DR_";.02////"_BPSFORM_";.06////"_$$NOWFM^BPSOSU1_";102////"_VERSION_";103////B2;109////1"
 D ^DIE
 ;
 ; Convert the 402-D2 (Prescription/Service Ref Number) to the proper length
 S FLD402=$G(TMP(RXMULT,POS_","_CLAIMIEN,402,"I")),L=11
 S TMP(RXMULT,POS_","_CLAIMIEN,402,"I")=$E(FLD402,1,2)_$E($E(FLD402,3,99)+1000000000000,13-L,13)
 ;
 ; Update transaction multiple with values
 S DIE="^BPSC("_REVIEN_",400,",DA(1)=REVIEN,DA=1,DR="",C=0
 F I=.04,.05,147,308,337,402,403,407,418,430,436,438,455 D
 .S C=C+1,$P(DR,";",C)=I_"////"_$G(TMP(RXMULT,POS_","_CLAIMIEN,I,"I"))
 D ^DIE
 ;
 ; Update transaction multiple with new D.1 through D.9 values but only if these fields were on the original B1 Payer Sheet- BPS*1*15
 S DIE="^BPSC("_REVIEN_",400,",DA(1)=REVIEN,DA=1,DR="",C=0
 F I=579:1:681,1023:1:1027,1029:1:1032 D
 .I $G(TMP(RXMULT,POS_","_CLAIMIEN,I,"I"))]"" S C=C+1,$P(DR,";",C)=I_"////"_TMP(RXMULT,POS_","_CLAIMIEN,I,"I")
 D ^DIE
 ;
 ; Create COB multiple if it exists in the claim record
 S COB=0
 F  S COB=$O(^BPSC(+CLAIMIEN,400,POS,337,COB)) Q:'COB  D
 . S REC=$G(^BPSC(+CLAIMIEN,400,POS,337,COB,0))
 . I $P(REC,U,1)=""!($P(REC,U,2)="") Q
 . K FDA,MSG,IENS
 . S FN=9002313.0401,IENS="+1,"_POS_","_REVIEN_",",IENS(1)=COB
 . S FDA(FN,IENS,.01)=$P(REC,U,1)
 . S FDA(FN,IENS,338)=$P(REC,U,2)
 . D UPDATE^DIE("","FDA","IENS","MSG")
 . I $D(MSG) D
 .. D LOG^BPSOSL(IEN59,$T(+0)_"-COB fields did not file, COB="_COB)
 .. D LOG^BPSOSL(IEN59,"REC="_REC)
 .. D LOG^BPSOSL(IEN59,"MSG Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"MSG")
 .. D LOG^BPSOSL(IEN59,"IENS Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"IENS")
 .. D LOG^BPSOSL(IEN59,"FDA Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"FDA")
 ;
 Q REVIEN
 ;
