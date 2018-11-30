BPSSCR05 ;BHAM ISC/BNT - ECME USR SCREEN UTILITIES ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;Filter Eligibility of Veteran, Tricare, or ChampVA (ChampVA is reserved for future use)
 ;input:
 ;BP59 - ptr to #59
 ;BPARR - array with user's preferences
 ;returns :
 ;1 -okay, leave in the list
 ;0 -not okay, exclude from the list
FLTELIG(BP59,BPARR) ;
 Q:$G(BPARR(2.01))="A" 1
 I $G(BPARR(2.01))="" S BPARR(2.01)="V"
 Q $S($$ELIGCODE(BP59)=$G(BPARR(2.01)):1,1:0)
 ;Filter Submission Type of Billing Requests or Reversals
 ;input:
 ;BP59 - ptr to #59
 ;BPARR - array with user's preferences
 ;returns :
 ;1 -okay, leave in the list
 ;0 -not okay, exclude from the list
FLTSUBTP(BP59,BPARR) ;
 N BPSCLM,BPTRCD
 Q:$G(BPARR(2.03))="A" 1
 Q:$G(BPARR(2.03))="" 1
 ; Get the claim IEN
 S BPSCLM=$S($P($G(^BPST(BP59,4)),U)>0:$P($G(^BPST(BP59,4)),U),1:$P($G(^BPST(BP59,0)),U,4))
 Q:BPSCLM="" 0
 ; Get the Transaction Code from BPS CLAIMS
 S BPTRCD=$$TRNSCODE(BPSCLM)
 Q:BPTRCD="" 0
 ; Transaction Code B1 = Billing Request, B2 = Reversal
 Q $S((BPTRCD="B1")&($G(BPARR(2.03))="B"):1,(BPTRCD="B2")&($G(BPARR(2.03))="R"):1,1:0)
 ;
 ;Filter Insurance companies
 ;input:
 ;BP59 - ptr to #59
 ;BPARR - array with user's preferences
 ;returns :
 ;1 -okay, leave in the list
 ;0 -not okay, exclude from the list
FLTINS(BP59,BPARR) ;
 Q:$G(BPARR(1.11))="A" 1
 Q:$G(BPARR(2.04))="" 1
 N BPINS,BPJ,BPINSIEN,I
 S BPINSIEN=$P($G(^BPST(BP59,10,+$G(^BPST(BP59,9)),0)),U)
 S BPINS=0
 F I=2:1 S BPJ=$P(BPARR(2.04),";",I) Q:BPJ=""  D  Q:BPINS
 . S BPINS=$S($$INSPL^IBNCPDPI(BPINSIEN)=BPJ:1,1:0)
 Q BPINS
 ;
 ;/**
 ;Returns the Eligibility Code for the entry in file 59
 ;input:
 ;BP59 - ptr to file 59
 ;returns:
 ;V=Veteran, T=Tricare, C=ChampVA, or null
ELIGCODE(BP59) ; **/
 Q $P($G(^BPST(BP59,9)),U,4)
 ;
 ;Returns the Transaction Code for a claim
 ;input:
 ;BP02 - ptr to BPS CLAIMS file
 ;returns:
 ;Internal value of TRANSACTION CODE field
 ;B1 = Billing, B2 = Reversal, B3 = Rebill, etc.
TRNSCODE(BP02) ;
 Q $P($G(^BPSC(BP02,100)),U,3)
 ;
 ;MKNEWARR is called by CLOSE^BPSSCRCL to create an array
 ;of BP59 records for use by the Close Claims option.
 ;
MKNEWARR(BPARR,BPNEWARR,BPINSARR) ;
 N BP59,BPREJ,BPREJCNT,BPRELCNT,BPREL,BPINS,BPCLST,BPDFN
 S BPREJCNT=0,BPRELCNT=0
 S BPINS=0
 S BP59="" F  S BP59=$O(BPARR(BP59)) Q:BP59=""  D
 . S BPREJ=0
 . S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 . S BPCLST=$$CLAIMST^BPSSCRU3(BP59)
 . S BPREJ=$S($P(BPCLST,U)="E REJECTED":1,$P(BPCLST,U)="E REVERSAL ACCEPTED":1,1:0)
 . S:BPREJ BPREJCNT=BPREJCNT+1
 . S BPREL=$S($$RXAPI1^BPSUTIL1(+$P($$RXREF^BPSSCRU2(BP59),U),106,"I"):1,1:0)
 . S:BPREL BPRELCNT=BPRELCNT+1
 . S BPNEWARR(BPDFN,BP59)=BPARR(BP59)_U_BPREJ_U_BPREL
 . S BPINS=$P($$GETINSUR^BPSSCRU2(BP59),U,2)
 . I BPREJ=1,$L(BPINS)>0 S BPINSARR(BPDFN,BPINS,BP59)=BPARR(BP59)
 Q BPREJCNT_U_BPRELCNT
 ;
