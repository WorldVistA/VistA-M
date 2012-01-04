BPSOSQL ;BHAM ISC/FCS/DRS/FLS - Process responses ;12/7/07  15:28
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;  ONE(CLAIMIEN,RESPIEN)
 ;     Process the Response for the claim.  Loop through the
 ;     transaction associated with the claim and call RESP1
 ;  RESP1
 ;     The real work of response handling for one IEN59 is in here
 ;  RESPBAD
 ;     Branch from RESP1 if there is no response value in the transaction
 ;
 ; ONE - Both the claim and response record are correct and complete
 ;   Now update all of the transaction records affected by them.
ONE(CLAIMIEN,RESPIEN) ;
 N TRANTYPE,INDEX,IEN59
 S TRANTYPE=$P($G(^BPSC(CLAIMIEN,100)),"^",3)
 S INDEX=$S(TRANTYPE="B2":"AER",1:"AE")
 S IEN59=0
 F  S IEN59=$O(^BPST(INDEX,CLAIMIEN,IEN59)) Q:IEN59=""  D
 . D RESP1(IEN59,TRANTYPE,CLAIMIEN,RESPIEN)
 Q
 ;
 ; RESP1 - Process each transaction associated with the transmission
RESP1(IEN59,TRANTYPE,CLAIMIEN,RESPIEN) ; called from ONE
 N ERROR,ERRTXT,X,MSG
 ;
 ; Store pointer to response
 N DIE,DA,DR
 S DIE=9002313.59,DA=IEN59
 S DR=$S(TRANTYPE="B2":402,1:4)_"////"_RESPIEN
 D ^DIE
 ;
 ; Update the status
 D SETSTAT^BPSOSU(IEN59,90) ; "Processing response"
 ;
 ; Get Position and log it
 N POSITION S POSITION=$P(^BPST(IEN59,0),U,9)
 I TRANTYPE'="B1" S POSITION=1 ; Reversals and eligibility have only 1 transaction
 ;
 ;
 S MSG=$T(+0)_"-Processing "_$S(TRANTYPE="B2":"Reversal ",TRANTYPE="E1":"Eligibility ",1:"")
 S MSG=MSG_"Response #"_RESPIEN_" for Claim #"_CLAIMIEN_" and position "_POSITION
 D LOG^BPSOSL(IEN59,MSG)
 ;
 ; If the Response Status is missing for the transaction, quit with error
 I '$D(^BPSR(RESPIEN,1000,POSITION,500)) D  G RESPBAD
 . S ERROR=901,ERRTXT="Corrupted response `"_RESPIEN
 ;
 ; Get the Respose Status for the transaction and update the statistics
 N RESP,PIECE S RESP=$P(^BPSR(RESPIEN,1000,POSITION,500),U)
 S PIECE=$S(RESP="R"&TRANTYPE="B2":7,RESP="R"&(TRANTYPE="E1"):10,RESP="R":2,RESP="P":3,RESP="D":4,RESP="C":5,RESP="A"&(TRANTYPE="B2"):6,RESP="A":9,1:19)
 D INCSTAT^BPSOSUD("R",PIECE)
 ;
 ; Log Response and if Payable, Amount Paid
 S MSG=$T(+0)_"-Response = "_RESP
 I RESP="P" S MSG=MSG_"-$"_$$INSPAID1^BPSOS03(RESPIEN,POSITION)
 D LOG^BPSOSL(IEN59,MSG)
 ;
 ; If the claims was rejected, log the reject reason
 I RESP="R" D  ; rejected, give rejection reasons
 . N J S J=0 F  S J=$O(^BPSR(RESPIEN,1000,POSITION,511,J)) Q:'J  D
 .. N R,X S R=$P($G(^BPSR(RESPIEN,1000,POSITION,511,J,0)),U)
 .. I R]"" D
 ... S X=$O(^BPSF(9002313.93,"B",R,0))
 ... ; Check if reject lists for non-covered drug needs to be updated IA# 5185
 ... I TRANTYPE="B1" D UPDLST^IBNCDNC(+($G(IEN59)\1),$P($G(^BPST(+$G(IEN59),1)),U,2),$P($G(^BPSC(+$G(CLAIMIEN),1)),U,4),X)
 ... I X]"" S X=$P($G(^BPSF(9002313.93,X,0)),U,2)
 .. E  S X=""
 .. D LOG^BPSOSL(IEN59,"Reject Code: "_R_" - "_X)
 . ;
 . ; If there are reject codes and the claim is a billing request, synch reject codes
 . ;   with Outpatient Pharmacy
 . I TRANTYPE="B1" D DURSYNC^BPSECMP2(IEN59)
 ;
 ; Get response messages and log them.
 S X=$G(^BPSR(RESPIEN,504))
 I X]"" D LOG^BPSOSL(IEN59,"Response Message: "_X)
 N ADDMESS
 D ADDMESS^BPSSCRLG(RESPIEN,POSITION,.ADDMESS)
 I $D(ADDMESS) D LOG^BPSOSL(IEN59,"Additional Text Message (array):"),LOGARRAY^BPSOSL(IEN59,"ADDMESS")
 ;
 ; Check if the payer should go to sleep based on the reject codes
 I $$REJSLEEP^BPSOSQ4(RESPIEN,POSITION,IEN59),$$INCSLEEP^BPSOSQ4(IEN59) Q
 ;
 ; If we are here, we are not asleep so we need to clear sleep and log completion
 ; Get the GROUP INSURANCE PLAN
 N GRPLAN
 S GRPLAN=$$GETPLN59^BPSUTIL2(IEN59)
 ;
 ; Clear any insurer asleep flags
 D CLRSLEEP^BPSOSQ4(GRPLAN,IEN59)
 ;
 ; Set Result and final status (99%-Done)
 N RESULT
 S RESULT=$S(TRANTYPE="B2":"Reversal ",TRANTYPE="E1":"Eligibility ",1:"")
 S RESULT=RESULT_$S(RESP="R":"Rejected",RESP="P":"Payable",RESP="D"!(RESP="S"):"Duplicate",RESP="C":"Captured",RESP="A":"Accepted",1:"Completed")
 D SETRESU^BPSOSU(IEN59,0,RESULT)
 D SETSTAT^BPSOSU(IEN59,99)
 Q
 ;
RESPBAD ; corrupted response escape from RESP1 - reached by a GOTO from RESP1
 ; Log the error
 D ERROR^BPSOSU($T(+0),IEN59,$G(ERROR),$G(ERRTXT))
 Q
