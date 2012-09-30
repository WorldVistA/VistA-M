BPSNCPD6 ;ALB/SS - Pharmacy API part 6 ;10-JAN-08
 ;;1.0;E CLAIMS MGMT ENGINE;**7,8,10,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;All of the entry points in this routine except LOOK77 were 
 ; created from code that was copied from BPSNCPDP because BPSNCPDP 
 ; was too big.  The variables are newed in BPSNCPDP and returned back
 ; to BPSNCPDP
 ;== New Claim 
NEWCLAIM ;
 S BPRETV=$$NEWCLM^BPSNCPD5(.BP77NEW,BRXIEN,BFILL,DOS,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPSDELAY,BPCOBIND,BPJOBFLG,IEN59,BPACTTYP,DFN,.BPSTART,$G(BPREQIEN),.BPSELIG,$G(BPSRTYPE),$G(BPSPLAN),.BPSPRDAT)
 S RESPONSE=+BPRETV
 ;to make LOG backward compatible
 D LOG^BPSOSL(IEN59,$T(+0)_"-After Submit of Claim.  Return Value: "_$S(RESPONSE=0:1,1:0))
 S CLMSTAT=$P(BPRETV,U,2)
 D DISPL^BPSNCPD4(WFLG,BPRETV,$G(BPSELIG))
 I RESPONSE=0 Q
 D LOG^BPSOSL(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;
 ;== Reversals for Payable claims
 ;(Note: BPSCLOSE parameter of EN^BPSNCPDP can be used in this case)
RVPAID ;
 S BPRETV=$$REVERSAL^BPSNCPD5(.BP77NEW,BRXIEN,BFILL,OLDRESP,DOS,BWHERE,$G(BILLNDC),REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPSDELAY,IEN59,BPCOBIND,BPJOBFLG,BPACTTYP,.BPSTART,$G(BPREQIEN),.BPSCLOSE,$G(BPSRTYPE),.BPSPRDAT)
 S RESPONSE=+BPRETV
 ;to make LOG backward compatible
 D LOG^BPSOSL(IEN59,$T(+0)_"-After Submit of Reversal. Return Value: "_$S(RESPONSE=0:1,1:0))
 S CLMSTAT=$P(BPRETV,U,2)
 I BWHERE'="EREV" D DISPL^BPSNCPD4(WFLG,BPRETV,$G(BPSELIG))
 I RESPONSE=0 Q
 D LOG^BPSOSL(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;
 ;== Reversals+Resubmits for Payable claims
RVRSPAID ;
 S BPRETV=$$REVRESUB^BPSNCPD4(.BP77NEW,BRXIEN,BFILL,DOS,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPSDELAY,BPCOBIND,BPJOBFLG,IEN59,DFN,.BPSTART,$G(BPREQIEN),OLDRESP,.BPSELIG,$G(BPSRTYPE),$G(BPSPLAN),.BPSPRDAT)
 S RESPONSE=+BPRETV
 ;if "Reversal only not resubmit" - display a message for the user
 I RESPONSE=10 D DISPL^BPSNCPD4(WFLG,"10^Claim Will Be Reversed But Will Not Be Resubmitted^D^2",$G(BPSELIG))
 ;to make LOG backward compatible
 D LOG^BPSOSL(IEN59,$T(+0)_"-After Submit of Reversal. Return Value: "_$S(RESPONSE=0:1,1:0))
 D DISPL^BPSNCPD4(WFLG,BPRETV,$G(BPSELIG))
 I RESPONSE=10 S CLMSTAT=$P(BPRETV,U,5) Q
 S CLMSTAT=$P(BPRETV,U,2)
 I RESPONSE=0 Q
 D LOG^BPSOSL(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;
 ;== Resubmits for Payable claims - DO NOT resubmit
RSPAID ;
 S RESPONSE=1
 ; Message varies depending the the previous response
 ; Reversal Accepted would not get here so this must be rejected, stranded, or other
 I OLDRESP["REVERSAL" S CLMSTAT="Can not resubmit a rejected or stranded reversal"
 E  S CLMSTAT="Previously billed through ECME: "_OLDRESP
 D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 D LOG^BPSOSL(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;== Reversals for Non-Payable claims - DO NOT reverse
RVNPAID ;
 ;if this is return to stock OR delete - close the claim
 I ",RS,DE,"[(","_BWHERE_",") D  Q
 . D CLOSE2^BPSBUTL(BRXIEN,BFILL,BWHERE)
 . S RESPONSE=3
 . S CLMSTAT="Claim was not payable so it has been closed.  No ECME claim created."
 . D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 . D LOG^BPSOSL(IEN59,$T(+0)_"-"_CLMSTAT)
 S RESPONSE=1
 S CLMSTAT="Claim has status "_OLDRESP_".  Not reversed."
 D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 D LOG^BPSOSL(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;== Resubmits AND Reversals+Resubmits for Non-Payable claims
RVRSNPD ;
 ; resubmit a claim
 S BPRETV=$$REVRESNP^BPSNCPD5(.BP77NEW,BRXIEN,BFILL,DOS,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPSDELAY,BPCOBIND,BPJOBFLG,IEN59,BPACTTYP,DFN,.BPSTART,$G(BPREQIEN),OLDRESP,.BPSELIG,$G(BPSRTYPE),$G(BPSPLAN),.BPSPRDAT)
 S RESPONSE=+BPRETV
 ;to make LOG backward compatible
 D LOG^BPSOSL(IEN59,$T(+0)_"-After Submit of Reversal. Return Value: "_$S(RESPONSE=0:1,1:0))
 S CLMSTAT=$P(BPRETV,U,2)
 D DISPL^BPSNCPD4(WFLG,BPRETV,$G(BPSELIG))
 I RESPONSE=0 Q
 D LOG^BPSOSL(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;
 ; if Back Billing
BB ;
 S RESPONSE=1
 S CLMSTAT="Previously billed through ECME: "_OLDRESP
 D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 D LOG^BPSOSL(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;
 ; if we do not have a status for pre-existing claim AND this is a reversal request - DO NOT reverse
RVNEW ;
 S RESPONSE=1
 S CLMSTAT="Prescription not previously billed through ECME.  Cannot Reverse claim."
 D DISPL^BPSNCPD4(WFLG,RESPONSE_U_CLMSTAT_"^D^2",$G(BPSELIG))
 D LOG^BPSOSL(IEN59,$T(+0)_"-"_CLMSTAT)
 Q
 ;
 ; This was meant to called by BPSSCR04 to collect requests for the User Screen that don't have BPS TRANSACTION records 
 ; However, it is currently not called.  This is still here in case, it is needed in the future.  The call that should
 ; be used is D LOOK77^BPSNCPD6(BPBDT,BPEDT,BPTMP1)
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
