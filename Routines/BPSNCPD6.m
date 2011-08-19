BPSNCPD6 ;ALB/SS - Pharmacy API part 6 ;10-JAN-08
 ;;1.0;E CLAIMS MGMT ENGINE;**7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;Moved portions of the BPSNCPDP code because of routine size issues
 ;== New Claim 
NEWCLAIM ;
 S BPRETV=$$NEWCLM^BPSNCPD5(.BP77NEW,BRXIEN,BFILL,BFILLDAT,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPCOBIND,BPJOBFLG,IEN59,BPACTTYP,DFN,.BPSTART,$G(BPREQIEN),.BPSELIG,$G(BPSRTYPE),$G(BPSPLAN),.BPSPRDAT)
 S RESPONSE=+BPRETV
 ;to make LOG backward compatible
 D LOG(IEN59,$T(+0)_"-After Submit of Claim.  Return Value: "_$S(RESPONSE=0:1,1:0))
 S CLMSTAT=$P(BPRETV,U,2)
 D DISPL^BPSNCPD4(WFLG,BPRETV,$G(BPSELIG))
 I RESPONSE=0 Q
 D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;
 ;== Reversals for Payable claims
 ;(Note: BPSCLOSE parameter of EN^BPSNCPDP can be used in this case)
RVPAID ;
 ;If Last Action was REVERSAL type Then we should expect Rejected and Stranded/Other reversal responses
 ;(because the claim is still Payable)
 ;And if so then DO NOT REVERSE it again 
 ;Exceptions (from pre-existing logic): 
 ; EREV - can be re-reversed if the previous submission is Payable or Rejected Reversal
 ; DE,RS - pre-existing logic
 I OLDRESP["REVERSAL",BWHERE'="EREV",BWHERE'="DE",BWHERE'="RS" D  Q
 . S RESPONSE=1
 . S CLMSTAT="Claim has status "_OLDRESP_".  Not reversed."
 . D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 . D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 ; do all the rest - E PAYABLE, etc
 S BPRETV=$$REVERSAL^BPSNCPD5(.BP77NEW,BRXIEN,BFILL,OLDRESP,BFILLDAT,BWHERE,$G(BILLNDC),REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,IEN59,BPCOBIND,BPJOBFLG,BPACTTYP,.BPSTART,$G(BPREQIEN),.BPSCLOSE,$G(BPSRTYPE),.BPSPRDAT)
 S RESPONSE=+BPRETV
 ;to make LOG backward compatible
 D LOG(IEN59,$T(+0)_"-After Submit of Reversal. Return Value: "_$S(RESPONSE=0:1,1:0))
 S CLMSTAT=$P(BPRETV,U,2)
 I BWHERE'="EREV" D DISPL^BPSNCPD4(WFLG,BPRETV,$G(BPSELIG))
 I RESPONSE=0 Q
 D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;
 ;== Reversals+Resubmits for Payable claims
RVRSPAID ;
 ;Last Action was REVERSAL type? 
 ;we should expect rejected and stranded reversal but not accepted one since the claim is Payable
 ;exception for Tricare - "reversal rejected" and "reversal unstranded" can be resubmitted, others - not
 I OLDRESP["REVERSAL" I ($P($G(^BPST(IEN59,9)),U,4)'="T")!($P($G(^BPST(IEN59,9)),U,4)="T"&(OLDRESP'["E REVERSAL REJECTED")&(OLDRESP'["E REVERSAL UNSTRANDED")) D  Q
 . S RESPONSE=1
 . S CLMSTAT="Can not resubmit a rejected or stranded reversal"
 . D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 . D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 ; do all the rest - E PAYABLE, etc
 S BPRETV=$$REVRESUB^BPSNCPD4(.BP77NEW,BRXIEN,BFILL,BFILLDAT,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPCOBIND,BPJOBFLG,IEN59,DFN,.BPSTART,$G(BPREQIEN),OLDRESP,.BPSELIG,$G(BPSRTYPE),$G(BPSPLAN),.BPSPRDAT)
 S RESPONSE=+BPRETV
 ;if "Reversal only not resubmit" - display a message for the user
 I RESPONSE=10 D DISPL^BPSNCPD4(WFLG,"10^Claim Will Be Reversed But Will Not Be Resubmitted^D^2",$G(BPSELIG))
 ;to make LOG backward compatible
 D LOG(IEN59,$T(+0)_"-After Submit of Reversal. Return Value: "_$S(RESPONSE=0:1,1:0))
 D DISPL^BPSNCPD4(WFLG,BPRETV,$G(BPSELIG))
 I RESPONSE=10 S CLMSTAT=$P(BPRETV,U,5) Q
 S CLMSTAT=$P(BPRETV,U,2)
 I RESPONSE=0 Q
 D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;
 ;== Resubmits for Payable claims - DO NOT resubmit
RSPAID ;
 S RESPONSE=1
 ;Last Action was REVERSAL type? 
 ;(we should expect rejected and stranded reversal but not accepted one since the claim is Payable)
 I OLDRESP["REVERSAL" D  Q
 . S CLMSTAT="Can not resubmit a rejected or stranded reversal"
 . D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 . D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 ; do all the rest - E PAYABLE, etc
 S CLMSTAT="Previously billed through ECME: "_OLDRESP
 D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;== Reversals for Non-Payable claims - DO NOT reverse
RVNPAID ;
 ;if this is return to stock OR delete - close the claim
 I ",RS,DE,"[(","_BWHERE_",") D  Q
 . D CLOSE2^BPSBUTL(BRXIEN,BFILL,BWHERE)
 . S RESPONSE=3
 . S CLMSTAT="Claim was not payable so it has been closed.  No ECME claim created."
 . D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 . D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 S RESPONSE=1
 S CLMSTAT="Claim has status "_OLDRESP_".  Not reversed."
 D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;== Resubmits AND Reversals+Resubmits for Non-Payable claims
RVRSNPD ;
 ; if this is a single resubmit action ("C")
 ; and the claim is NON-PAYABLE because of some reason other than 
 ;   successful reversal 
 ;   or
 ;   claim rejected by the payer
 ; then do not submit a claim
 I BPACTTYP="C",OLDRESP'="E REVERSAL ACCEPTED",OLDRESP'="E REJECTED" D  Q
 . S RESPONSE=1
 . S CLMSTAT="Previously billed through ECME: "_OLDRESP
 . D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 . D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 ; resubmit a claim
 S BPRETV=$$REVRESNP^BPSNCPD5(.BP77NEW,BRXIEN,BFILL,BFILLDAT,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPCOBIND,BPJOBFLG,IEN59,BPACTTYP,DFN,.BPSTART,$G(BPREQIEN),OLDRESP,.BPSELIG,$G(BPSRTYPE),$G(BPSPLAN),.BPSPRDAT)
 S RESPONSE=+BPRETV
 ;to make LOG backward compatible
 D LOG(IEN59,$T(+0)_"-After Submit of Reversal. Return Value: "_$S(RESPONSE=0:1,1:0))
 S CLMSTAT=$P(BPRETV,U,2)
 D DISPL^BPSNCPD4(WFLG,BPRETV,$G(BPSELIG))
 I RESPONSE=0 Q
 D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;
 ; if Back Billing
BB ;
 S RESPONSE=1
 S CLMSTAT="Previously billed through ECME: "_OLDRESP
 D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;
 ; if we do not have a status for pre-existing claim AND this is a reversal request - DO NOT reverse
RVNEW ;
 S RESPONSE=1
 S CLMSTAT="Prescription not previously billed through ECME.  Cannot Reverse claim."
 D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 D LOG(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
LOG(IEN59,MSG,BPDTFLG) ;
 D LOG^BPSOSL(IEN59,MSG,$G(BPDTFLG))
 Q
 ;
 ;use in BPSSCR04 to collect requests for the User Screen that don't have BPS TRANSACTION records 
 ; D LOOK77^BPSNCPD6(BPBDT,BPEDT,BPTMP1)
LOOK77(BPBEGDT,BPENDDT,BPTMP) ;
 N BPLDT77,BP77,BP59,BPRXRF
 S BPLDT77=BPBEGDT-0.00001
 F  S BPLDT77=+$O(^BPS(9002313.77,"E",BPLDT77)) Q:BPLDT77=0!(BPLDT77>BPENDDT)  D
 . S BP77=0 F  S BP77=$O(^BPS(9002313.77,"E",BPLDT77,BP77)) Q:+BP77=0  D
 . . S BPRXRF=$P($G(^BPS(9002313.77,BP77,0)),U,1,2)
 . . S BP59=$$IEN59^BPSOSRX(+BPRXRF,$P(BPRXRF,U,2)) ;calculate BPS TRANSACTION ien (even if it doesn't exist yet)
 . . I $D(@BPTMP@(BP59)) Q  ;don't create an entry if the claim is already there
 . . S @BPTMP@(BP59)=(BPLDT77\1)_"^77-"
 Q
 ;
