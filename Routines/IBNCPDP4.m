IBNCPDP4 ;DALOI/AAT - HANDLE ECME EVENTS ;20-JUN-2003
 ;;2.0;INTEGRATED BILLING;**276,342,405,384,411**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;NCPDP PHASE III
 Q
 ;
CLOSE(DFN,IBD) ; Close Claim Event
 N IBADT,IBTRKR,IBTRKRN,IBRXN,IBFIL,IBEABD,IBRES,IBLOCK,IBDUZ
 N IBRXTYP,IBCR,DA,DIE,DR,IBUSR
 S IBDUZ=.5
 S IBRES=1,IBLOCK=0
 ;
 I 'DFN S IBRES="0^No patient" G CLOSEQ
 S IBADT=+$G(IBD("FILL DATE")) I 'IBADT S IBRES="0^No fill date" G CLOSEQ
 S IBRXN=+$G(IBD("PRESCRIPTION")) I 'IBRXN S IBRES="0^No Rx IEN" G CLOSEQ
 S IBFIL=+$G(IBD("FILL NUMBER"),-1) I IBFIL<0 S IBRES="0^No fill number" G CLOSEQ
 S IBCR=+$G(IBD("CLOSE REASON")) I 'IBCR S IBRES="0^No close reason" G CLOSEQ
 I '$L($G(IBD("CLAIMID"))) S IBRES="0^Missing ECME Number" G CLOSEQ
 S IBD("BCID")=$$BCID(IBD("CLAIMID"),IBADT)
 S IBUSR=$S(+$G(IBD("USER"))=0:DUZ,1:IBD("USER"))
 L +^DGCR(399,"AG",IBD("BCID")):5 S IBLOCK=$T
 ;
 ; closing secondary claims should not affect CT - esg 7/8/10
 I $G(IBD("RXCOB"))>1 D  S IBRES=1 G CLOSEQ
 . N IBACT
 . ;
 . ; release copay charges off hold if OPECC said to do so
 . I '$G(IBD("RELEASE COPAY")) Q
 . S IBACT=+$$RELCOPAY^IBNCPNB(DFN,IBRXN,IBFIL,1,IBADT,0)      ; release copay charges off hold
 . I IBACT=-1 D RELBUL^IBNCPEB(DFN,IBRXN,IBFIL,IBADT,IBACT,IBCR,$G(IBD("CLOSE COMMENT")),0,1)   ; send msg if error
 . Q
 ;
 ; -- claims tracking info
 S IBTRKR=$G(^IBE(350.9,1,6))
 ; date can't be before parameters
 S $P(IBTRKR,"^")=$S('$P(IBTRKR,"^",4):0,+IBTRKR&(IBADT<+IBTRKR):0,1:IBADT)
 S IBTRKRN=+$O(^IBT(356,"ARXFL",IBRXN,IBFIL,0))
 ;
 I 'IBTRKRN S IBRES="0^CT record not found" G CLOSEQ
 ;
 D NONBR^IBNCPNB(DFN,IBRXN,IBFIL,IBADT,IBCR,$G(IBD("DROP TO PAPER")),$G(IBD("RELEASE COPAY")),$G(IBD("CLOSE COMMENT")),IBUSR)
 ;
 S DIE="^IBT(356,",DA=IBTRKRN
 ; add ECME #,ECME flag, remove total charges
 S DR="1.1///"_IBD("CLAIMID")_";1.11///2;.29////@"
 D ^DIE
 ;
 S IBRES=1 ; OK
CLOSEQ ;
 D LOG^IBNCPDP2("CLOSE",IBRES)
 I IBLOCK L -^DGCR(399,"AG",IBD("BCID"))
 Q IBRES
 ;
 ;
RELEASE(DFN,IBD) ;
 N IBRES,IBADT,IBRXN,IBFIL,IBRDT,IBLOCK,IBLOCK2,IBTRKR,IBTRKRN
 N IBEABD,IBNBR,DA,DIE,DR,IBUSR
 S IBLOCK=0
 I 'DFN S IBRES="0^No patient" G RELQ
 S IBADT=+$G(IBD("FILL DATE")) I 'IBADT S IBRES="0^No fill date" G RELQ
 S IBRXN=+$G(IBD("PRESCRIPTION")) I 'IBRXN S IBRES="0^No Rx IEN" G RELQ
 S IBFIL=+$G(IBD("FILL NUMBER"),-1) I IBFIL<0 S IBRES="0^No fill number" G RELQ
 S IBRDT=+$G(IBD("RELEASE DATE"),-1) I 'IBRDT S IBRES="0^No release date" G RELQ
 I '$L($G(IBD("CLAIMID"))) S IBRES="0^Missing ECME Number" G RELQ
 S IBD("BCID")=$$BCID(IBD("CLAIMID"),IBADT)
 S IBUSR=$S(+$G(IBD("USER"))=0:DUZ,1:IBD("USER"))
 L +^DGCR(399,"AG",IBD("BCID")):5 S IBLOCK=$T
 ; -- claims tracking info
 S IBTRKR=$G(^IBE(350.9,1,6))
 ; date can't be before parameters
 S $P(IBTRKR,"^")=$S('$P(IBTRKR,"^",4):0,+IBTRKR&(IBADT<+IBTRKR):0,1:IBADT)
 S IBTRKRN=+$O(^IBT(356,"ARXFL",IBRXN,IBFIL,0))
 I 'IBTRKRN S IBRES="0^No CT record found." G RELQ
 ;
 ; Remove NBR from CT and set T+60 (if not billed yet)
 ; Set ECME flags in CT
 ;
 L +^IBT(356,IBTRKRN):5 S IBLOCK2=$T
 S DIE="^IBT(356,",DA=IBTRKRN,DR=""
 S IBNBR=+$P($G(^IBT(356,IBTRKRN,0)),U,19)
 ; Clean up "Rx not released"
 I IBNBR,$P($G(^IBE(356.8,IBNBR,0)),U)="PRESCRIPTION NOT RELEASED" S DR=DR_".19////@;",IBNBR=""
 ;
 ; Set EABD if no bill and no NBR
 I '$P($G(^IBT(356,IBTRKRN,0)),U,11),'IBNBR D
 . S IBEABD=$$EABD^IBTUTL($O(^IBE(356.6,"AC",4,0)),IBADT)
 . S:'IBEABD IBEABD=DT
 . S IBEABD=$$FMADD^XLFDT(IBEABD,60)
 . S DR=DR_".17////^S X=IBEABD;"
 ;
 ; Set ECME Flags
 S DR=DR_"1.1////"_IBD("CLAIMID")_";"
 ; Reject status will not be set here
 ;
 ; Check that the Fill Date is current
 I IBADT'=$P(^IBT(356,IBTRKRN,0),U,6) S DR=DR_".06////"_IBADT_";"
 ;
 D ^DIE
 S IBFDA(356,IBTRKRN_",",1.03)=DT  ; date last edited
 S IBFDA(356,IBTRKRN_",",1.04)=IBUSR   ; last edited by
 D FILE^DIE("","IBFDA"),MSG^DIALOG()
 I IBLOCK2 L -^IBT(356,IBTRKRN)
 ; 
 S IBRES=1
RELQ ;
 D LOG^IBNCPDP2("RELEASE",IBRES)
 I IBLOCK L -^DGCR(399,"AG",IBD("BCID"))
 Q IBRES
 ;
SUBMIT(DFN,IBD) ;
 N IBRES,IBLOCK,IBADT,IBRXN,IBFIL,IBRDT,IBNBR,IBFLAG,IBTRKR,IBTRKRN
 N IBRESP,DA,DIE,DR,IBUSR
 S IBLOCK=0
 I 'DFN S IBRES="0^No patient" G SUBQ
 S IBADT=+$G(IBD("FILL DATE")) I 'IBADT S IBRES="0^No fill date" G SUBQ
 S IBRXN=+$G(IBD("PRESCRIPTION")) I 'IBRXN S IBRES="0^No Rx IEN" G SUBQ
 S IBFIL=+$G(IBD("FILL NUMBER"),-1) I IBFIL<0 S IBRES="0^No fill number" G SUBQ
 S IBRESP=$G(IBD("RESPONSE")) I IBRESP="" S IBRES="0^No response from the payer" G SUBQ
 S IBRDT=+$G(IBD("RELEASE DATE"),-1)
 I '$L($G(IBD("CLAIMID"))) S IBRES="0^Missing ECME Number" G SUBQ
 S IBD("BCID")=$$BCID(IBD("CLAIMID"),IBADT)
 S IBUSR=$S(+$G(IBD("USER"))=0:DUZ,1:IBD("USER"))
 L +^DGCR(399,"AG",IBD("BCID")):5 S IBLOCK=$T
 ;
 ; -- claims tracking info
 S IBTRKR=$G(^IBE(350.9,1,6))
 ; date can't be before parameters
 S $P(IBTRKR,"^")=$S('$P(IBTRKR,"^",4):0,+IBTRKR&(IBADT<+IBTRKR):0,1:IBADT)
 S IBTRKRN=+$O(^IBT(356,"ARXFL",IBRXN,IBFIL,0))
 ;
 ; If the Rx is not released - set NBR in CT
 I 'IBRDT,'$P($G(^IBT(356,IBTRKRN,0)),U,19) D NONBR^IBNCPNB(DFN,IBRXN,IBFIL,IBADT,"PRESCRIPTION NOT RELEASED","","","",IBUSR)
 ;
 ; If the Rx is released - clean up NBR in CT
 I IBRDT,$P($G(^IBE(356.8,+$P($G(^IBT(356,IBTRKRN,0)),U,19),0)),U)="PRESCRIPTION NOT RELEASED" D NONBR^IBNCPNB(DFN,IBRXN,IBFIL,IBADT,"","","","",IBUSR)
 ; Set ECME fields in CT
 S DIE="^IBT(356,",DA=IBTRKRN
 S IBFLAG=$S(IBRESP["REJECT":1,1:0)
 S DR="1.1///"_IBD("CLAIMID")_";1.11///"_IBFLAG
 D ^DIE
 S IBRES=1
SUBQ ;
 D LOG^IBNCPDP2("SUBMIT",IBRES)
 I IBLOCK L -^DGCR(399,"AG",IBD("BCID"))
 Q IBRES
 ;
 ;
REOPEN(DFN,IBD) ;
 N IBRES,IBADT,IBRXN,IBFIL,IBRDT,IBLOCK,IBLOCK2,IBTRKRN
 N IBEABD,IBNBR,DA,DIE,DR,IBUSR,IBEABD
 S (IBLOCK,IBLOCK2)=0
 I 'DFN S IBRES="0^No patient" G REOPQ
 S IBADT=+$G(IBD("FILL DATE")) I 'IBADT S IBRES="0^No fill date" G REOPQ
 S IBRXN=+$G(IBD("PRESCRIPTION")) I 'IBRXN S IBRES="0^No Rx IEN" G REOPQ
 S IBFIL=+$G(IBD("FILL NUMBER"),-1) I IBFIL<0 S IBRES="0^No fill number" G REOPQ
 I '$L($G(IBD("CLAIMID"))) S IBRES="0^Missing ECME Number" G REOPQ
 S IBRDT=$$RXRLDT^PSOBPSUT(IBRXN,IBFIL)  ; release date (if null is returned then Rx is not released)
 S IBD("BCID")=$$BCID(IBD("CLAIMID"),IBADT)
 S IBUSR=$S(+$G(IBD("USER"))=0:DUZ,1:IBD("USER"))
 L +^DGCR(399,"AG",IBD("BCID")):5 S IBLOCK=$T
 ;
 ; re-opening secondary claims should not affect CT - esg 7/9/10
 I $G(IBD("RXCOB"))>1 S IBRES=1 G REOPQ
 ;
 S IBTRKRN=+$O(^IBT(356,"ARXFL",IBRXN,IBFIL,0))  ;get the claim entry associated with the Rx fill (or refill)
 L +^IBT(356,IBTRKRN):5 S IBLOCK2=$T
 S DIE="^IBT(356,",DA=IBTRKRN
 ;
 I IBRDT D   ; if Rx released assign earliest autobill date 
 . S IBEABD=$$EABD^IBTUTL($O(^IBE(356.6,"AC",4,0)),IBADT)
 . S:'IBEABD IBEABD=DT
 . S IBEABD=$$FMADD^XLFDT(IBEABD,60)
 ;
 N IBFDA
 S IBFDA(356,IBTRKRN_",",.19)=$S('IBRDT:$O(^IBE(356.8,"B","PRESCRIPTION NOT RELEASED","")),1:"@")  ;non-billable reason
 D FILE^DIE("","IBFDA"),MSG^DIALOG()
 K IBFDA
 S IBFDA(356,IBTRKRN_",",.17)=$S('IBRDT:"@",1:IBEABD)  ; earliest autobill date
 S IBFDA(356,IBTRKRN_",",1.08)="@"  ;additional comments
 S IBFDA(356,IBTRKRN_",",1.11)=0   ; reject flag - reset to "no"
 S IBFDA(356,IBTRKRN_",",1.03)=DT  ; date last edited
 S IBFDA(356,IBTRKRN_",",1.04)=IBUSR   ; last edited by
 D FILE^DIE("","IBFDA"),MSG^DIALOG()
 ; 
 S IBRES=1
REOPQ ;
 D LOG^IBNCPDP2("REOPEN",IBRES)
 I IBLOCK L -^DGCR(399,"AG",IBD("BCID"))
 I IBLOCK2 L -^IBT(356,IBTRKRN)
 Q IBRES
 ;
BCID(BCID,IBADT) ; changes BCID to always be 7 characters long
 Q $$RJ^XLFSTR($E(BCID,$L(BCID)-6,$L(BCID)),7,0)_";"_IBADT
