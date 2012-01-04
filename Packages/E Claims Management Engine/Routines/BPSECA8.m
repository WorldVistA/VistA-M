BPSECA8 ;BHAM ISC/FCS/DRS/VA/DLF - construct a claim reversal ;05/17/04
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,10**;JUN 2004;Build 27
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
REVERSE(IEN59) ; function, return reversal IEN or zero on failure, from BPSOSRB
 Q:$G(IEN59)="" 0  ; required
 ;
 N BPS,BPSFORM,C,CLAIM,CLAIMIEN,DA,DIC,DIE,DIQ,DLAYGO,DR,I,L,POS,REVIEN,RXMULT,TMP,UERETVAL
 N VERSION,FLD402,X,Y,COB,REC,FN,FDA,MSG,IENS
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
 ; Get reversal payer sheet.  If missing, quit
 S BPSFORM=$$GET1^DIQ(9002313.59902,"1,"_IEN59_",","902.19","I")
 I BPSFORM="" Q 0
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
 ; Add fields that do not come from the claim
 ;   Payer sheet is the reversal sheet, Created On is current date/time
 ;   Transaction Code is B2 and Transaction Count is 1
 S DR=DR_";.02////"_BPSFORM_";.06////"_$$NOWFM^BPSOSU1_";102////"_VERSION_";103////B2;109////1"
 D ^DIE
 ;
 ; Convert the 402-D2 (Prescription/Service Ref Number) to the proper length based on the NCPDP version
 S FLD402=$G(TMP(RXMULT,POS_","_CLAIMIEN,402,"I")),L=$S(VERSION=51:6,1:11)
 S TMP(RXMULT,POS_","_CLAIMIEN,402,"I")=$E(FLD402,1,2)_$E($E(FLD402,3,99)+1000000000000,13-L,13)
 ;
 ; Update transaction multiple with values
 S DIE="^BPSC("_REVIEN_",400,",DA(1)=REVIEN,DA=1,DR="",C=0
 F I=.03,.04,.05,147,308,337,401,402,403,407,418,430,436,438,455 D
 .S C=C+1,$P(DR,";",C)=I_"////"_$G(TMP(RXMULT,POS_","_CLAIMIEN,I,"I"))
 D ^DIE
 ;
 ; Add Submission Clarification Code to the reversal record
 ; Note that this is only valid for version 5.1 and 5.1 is a single-value
 ;   field, so we only need the first occurrence
 I VERSION=51,$G(^BPSC(+CLAIMIEN,400,POS,354.01,1,1))]"" D
 . K FDA,MSG,IENS
 . S FN=9002313.02354,IENS="+1,"_POS_","_REVIEN_",",IENS(1)=1
 . S FDA(FN,IENS,.01)=1
 . S FDA(FN,IENS,420)=^BPSC(+CLAIMIEN,400,POS,354.01,1,1)
 . D UPDATE^DIE("","FDA","IENS","MSG")
 . I '$D(MSG) S $P(^BPSC(REVIEN,400,POS,350),U,4)="NX"_$$NFF^BPSECFM(1,1)
 . I $D(MSG) D
 .. D LOG^BPSOSL(IEN59,$T(+0)_"-Clarification fields did not file")
 .. D LOG^BPSOSL(IEN59,"REC="_REC)
 .. D LOG^BPSOSL(IEN59,"MSG Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"MSG")
 .. D LOG^BPSOSL(IEN59,"IENS Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"IENS")
 .. D LOG^BPSOSL(IEN59,"FDA Array:")
 .. D LOGARRAY^BPSOSL(IEN59,"FDA")
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
