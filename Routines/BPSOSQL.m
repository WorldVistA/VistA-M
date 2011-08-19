BPSOSQL ;BHAM ISC/FCS/DRS/FLS - Process responses ;12/7/07  15:28
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7**;JUN 2004;Build 46
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
 ;     Branch from RESP1 if there is no response value in the
 ;     prescription
 ;
 ; ONE - Both the claim and response record are correct and complete
 ;   Now update all of the prescription records affected by them.
ONE(CLAIMIEN,RESPIEN) ;
 N ISREVERS,INDEX,IEN59
 S ISREVERS=$$ISREVERS^BPSOSU(CLAIMIEN)
 S INDEX=$S(ISREVERS:"AER",1:"AE")
 S IEN59=0
 F  S IEN59=$O(^BPST(INDEX,CLAIMIEN,IEN59)) Q:IEN59=""  D
 . D RESP1(IEN59,ISREVERS,CLAIMIEN,RESPIEN)
 Q
 ;
 ; RESP1 - Process each transaction associated with the claim
RESP1(IEN59,REVERSAL,CLAIMIEN,RESPIEN) ; called from ONE
 N ERROR,ERRTXT,X,MSG
 ;
 ; Store pointer to response
 N DIE,DA,DR
 S DIE=9002313.59,DA=IEN59
 S DR=$S(REVERSAL:402,1:4)_"////"_RESPIEN
 D ^DIE
 ;
 ; Update the status
 D SETSTAT^BPSOSU(IEN59,90) ; "Processing response"
 ;
 ; Get Position and log it
 N POSITION S POSITION=$P(^BPST(IEN59,0),U,9)
 I REVERSAL S POSITION=1 ; but reversals have only 1 transaction
 ;
 ;
 S MSG=$T(+0)_"-Processing "
 I REVERSAL S MSG=MSG_"Reversal "
 S MSG=MSG_"Response #"_RESPIEN_" for Claim #"_CLAIMIEN_" and position "_POSITION
 D LOG^BPSOSL(IEN59,MSG)
 ;
 ; If the Response Status is missing for the prescription, quit with error
 I '$D(^BPSR(RESPIEN,1000,POSITION,500)) D  G RESPBAD
 . S ERROR=901,ERRTXT="Corrupted response `"_RESPIEN
 ;
 ; Get the Respose Status for the prescription and update the statistics
 N RESP S RESP=$P(^BPSR(RESPIEN,1000,POSITION,500),U)
 D INCSTAT^BPSOSUD("R",$S(RESP="R"&REVERSAL:7,RESP="R":2,RESP="P":3,RESP="D":4,RESP="C":5,RESP="A":6,1:19))
 ;
 ; Log Response and if Payable, Amount Paid
 S MSG=$T(+0)_"-Response = "_RESP
 I RESP="P" S MSG=MSG_"-$"_$$INSPAID1^BPSOS03(RESPIEN,POSITION)
 D LOG^BPSOSL(IEN59,MSG)
 ;
 ; If the claims was rejected, log the reject reason
 I RESP="R" D  ; rejected, give rejection reasons
 . N J S J=0 F  S J=$O(^BPSR(RESPIEN,1000,POSITION,511,J)) Q:'J  D
 .. N R S R=$P($G(^BPSR(RESPIEN,1000,POSITION,511,J,0)),U)
 .. ;check if reject lists for non-covered drug needs to be updated IA# 5185
 .. ;I 'REVERSAL D UPDLST^IBNCDNC(+($G(IEN59)\1),$P($G(^BPST(+$G(IEN59),1)),U,2),$P($G(^BPSC(+$G(CLAIMIEN),1)),U,4),R)
 .. N X
 .. I R]"" D
 ... S X=$O(^BPSF(9002313.93,"B",R,0))
 ... ;check if reject lists for non-covered drug needs to be updated IA# 5185
 ... I 'REVERSAL D UPDLST^IBNCDNC(+($G(IEN59)\1),$P($G(^BPST(+$G(IEN59),1)),U,2),$P($G(^BPSC(+$G(CLAIMIEN),1)),U,4),X)
 ... I X]"" S X=$P($G(^BPSF(9002313.93,X,0)),U,2)
 .. E  S X=""
 .. D LOG^BPSOSL(IEN59,"Reject Code: "_R_" - "_X)
 . ;
 . ; If there are reject codes and the claim is not a reversal, synch reject codes
 . ;   with Outpatient Pharmacy
 . I 'REVERSAL D DURSYNC^BPSECMP2(IEN59)
 ;
 ; Get response messages and log them.
 S X=$G(^BPSR(RESPIEN,504))
 I X]"" D LOG^BPSOSL(IEN59,"Response Message: "_X)
 S X=$G(^BPSR(RESPIEN,1000,POSITION,504))
 I X]"" D LOG^BPSOSL(IEN59,"Response Message: "_X)
 S X=$G(^BPSR(RESPIEN,1000,POSITION,526))
 I X]"" D LOG^BPSOSL(IEN59,"Response Message: "_X)
 ;
 ; Get the GROUP INSURANCE PLAN
 N GRPLAN
 S GRPLAN=$$GETPLN77^BPSUTIL2(+$P($G(^BPST(IEN59,0)),U,12))
 ;
 ; Check if the payer should go to sleep based on the reject codes
 I $$REJSLEEP^BPSOSQ4(RESPIEN,POSITION,IEN59) D  ; ins. asleep: want to retry
 . N BPSRETRY
 . D SETSTAT^BPSOSU(IEN59,31)
 . S BPSRETRY=$$INCSLEEP^BPSOSQ4(IEN59) I 'BPSRETRY Q
 . ; Convert to External date/time for logging
 . S BPSRETRY=$$FMTE^XLFDT(BPSRETRY)
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Insurer asleep; retry scheduled for "_BPSRETRY_" for "_$P(GRPLAN,U,2))
 E  D  ; else: a normal kind of response, so we are done
 . N RESULT
 . D CLRSLEEP^BPSOSQ4(+GRPLAN)
 . I REVERSAL S RESULT="Reversal "
 . S RESULT=$G(RESULT)_$S(RESP="R":"Rejected",RESP="P":"Payable",RESP="D":"Duplicate",RESP="C":"Captured",RESP="A":"Accepted",1:"Completed")
 . D SETRESU^BPSOSU(IEN59,0,RESULT)
 . D SETSTAT^BPSOSU(IEN59,99) ; "Done"
 Q
 ;
RESPBAD ; corrupted response escape from RESP1 - reached by a GOTO from RESP
 ; Log the error
 D ERROR^BPSOSU($T(+0),IEN59,$G(ERROR),$G(ERRTXT))
 Q
