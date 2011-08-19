IBECEA21 ;ALB/CPM-Cancel/Edit/Add... Edit Prompts;19-APR-93
 ;;2.0;INTEGRATED BILLING;**7,57,167,183,202,312**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Issue appropriate prompts for each charge type.  If the charge
 ; being edited has not been billed, handle that charge before
 ; returning to IBECEA2.
 ;
 N IBSTOPDA,IBTYPE,IBGMT
 N IBSWINFO S IBSWINFO=$$SWSTAT^IBBAPI()                    ;IB*2.0*312
 S IBGMT=0
 ;
 ; Handle Outpatient Charges
 I IBXA=4 D  G END
 .S (IBFR,IBTO,IBDT)=$P(IBND,"^",14),IBUNIT=IBUNITP
 .W !,"Re-calculating the OPT copay charge for ",$$DAT1^IBOUTL(IBFR)," ..."
 .;
 .; need to look up stop info to populate IBTYPE *167
 .S IBSTOPDA=$S($P($P(IBND,"^",4),":")=350:$P(IBND,"^",20),1:$$GETSC^IBEMTSCU($P(IBND,"^",4),$P(IBND,"^",17)))
 .S IBTYPE=$S(IBSTOPDA>0:$P($G(^IBE(352.5,+$G(IBSTOPDA),0)),"^",3),1:1)
 .;
 .S IBX="O" D TYPE^IBAUTL2 Q:IBY<0  W "   $",IBCHG
 .I 'IBH,IBCHG=IBCHGP W !,"This equals the billed amount - this charge cannot be edited." S IBY=-1 Q
 .I IBCHG=IBCHGP W !,"This charge is ready to be billed." D PASS^IBECEA22 S IBY=-1 Q
 .I IBH D UPCHG^IBECEA22(IBCHG) S IBY=-1 Q
 .S IBCRES=$O(^IBE(350.3,"B","MT CHARGE EDITED",0)) S:'IBCRES IBCRES=19
 .W !!,"The original charge will be cancelled and re-billed for $",IBCHG,"."
 ;
 ; Handle Pharmacy Copay Charges
 I IBXA=5 D  G END
 .D UNIT^IBECEAU2(IBUNITP) Q:IBY<0
 .I 'IBH,IBUNIT=IBUNITP W !!,"No change was made!" S IBY=-1 Q
 .I IBH D UPCHG^IBECEA22(IBCHG,IBUNIT) S IBY=-1 Q
 .W !!,"The original charge will be cancelled and re-billed for $",$J(IBCHG,"",2),"."
 ;
 ; Handle all Inpatient Charges
 S IBFRP=+$P(IBND,"^",14),IBTOP=+$P(IBND,"^",15),IBLIM=$S(IBXA=3:DT,1:$$FMADD^XLFDT(DT,-1))
 S IBGMT=$$ISGMTPT^IBAGMT(DFN,IBFRP) ;Check GMT Copayment Status
 D CLSTR^IBECEAU1(DFN,IBFRP)
 I 'IBCLDA W !!,"I cannot find a billing clock that was effective on ",$$DAT1^IBOUTL(IBFRP),"!",!,"Please adjust this patient's billing clocks before editing this charge." S IBY=-1 Q
 D CLDATA^IBAUTL3,DED^IBAUTL3 G:IBY<0 END
 ;For GMT Patients reduce Medicare Deductible to 20%
 I IBGMT>0 S IBMED=$$REDUCE^IBAGMT(IBMED) W !,"Medicare Deductible reduced due to GMT Copayment Status."
 S:IBXA=2 IBBS=$O(^DGCR(399.1,"AC",IBATYP,0))
 I IBXA=2,$P($G(^IBE(350.1,IBATYP,0)),"^",8)'["NHCU",IBCLDAY>90,IBCHGP'>IBCLDOL S IBMED=IBMED/2
 I IBXA=1,IBCLDAY>90 D MED^IBECEA34 G:IBY<0 END
 W !!,"  ** ",$S($P(IBCLST,"^",4)=1:"Active",1:"Closed")," Billing Clock **"
 W !?2,"Begin Date: ",$$DAT1^IBOUTL(IBCLDT),"   # Inpt Days: ",IBCLDAY,"   ",$$INPT^IBECEAU(IBCLDAY)," 90 days: $",IBCLDOL,!
 S:IBXA=3 IBDAYP=IBCLDAY-IBUNITP
 I IBXA=1!(IBXA=2) S IBDOLP=IBCLDOL-IBCHGP S:IBDOLP<0 IBDOLP=0
 ;
 ; - ask for 'Bill From' date
FR D FR^IBECEAU2(IBFRP) G:IBY<0 END
 I +IBSWINFO,(IBFR+1)>$P(IBSWINFO,"^",2) D  G FR          ;IB*2.0*312
   .W !!,"The 'Bill From' date cannot be on or AFTER "
   .W "the PFSS Effective Date: ",$$FMTE^XLFDT($P(IBSWINFO,"^",2))
 ; 
 I IBFR<IBCLDT W !!,"The 'Bill From' date cannot preceed the Billing Clock Begin Date.",! G FR
 S IBGMTR=0,IBGMT=$$ISGMTPT^IBAGMT(DFN,IBFR) ; GMT Status may change
 I IBXA=3 S IBDT=IBFR D COST^IBAUTL2 S:IBGMT>0 IBGMTR=1,IBCHG=$$REDUCE^IBAGMT(IBCHG) I 'IBCHG W !!,"Unable to determine the per diem rate. Please check your rate table." S IBY=-1 G END
 I IBXA=2 S IBDT=IBFR D COPAY^IBAUTL2 G:IBY<0 END S:IBGMT>0 IBGMTR=1,IBCHG=$$REDUCE^IBAGMT(IBCHG) I IBCHG+IBDOLP<IBMED W *7,"   ($",IBCHG,"/day)" W:IBGMTR " GMT Rate" G TO
 I IBXA=2,IBCHG=IBCHGP D CTBB^IBECEAU3 W !!,"No change was made!" S IBY=-1 G END
 ;
 ; - ask for 'Bill To' date
TO D TO^IBECEAU2(IBTOP) G:IBY<0 END
 I +IBSWINFO,(IBTO+1)>$P(IBSWINFO,"^",2) D  G TO          ;IB*2.0*312
  .W !!,"The 'Bill To' date cannot be on or AFTER "
  .W "the PFSS Effective Date: ",$$FMTE^XLFDT($P(IBSWINFO,"^",2))
 ; 
 I $P(IBCLST,"^",10),IBTO>$P(IBCLST,"^",10) W !!,"The 'Bill To' date cannot exceed the Billing Clock End Date (",$$DAT1^IBOUTL($P(IBCLST,"^",10)),")." G TO
 S IBUNIT=$$FMDIFF^XLFDT(IBTO,IBFR)
 I $$FMDIFF^XLFDT(IBTOP,IBFRP)<IBUNITP!(IBFR=IBTO) S IBUNIT=IBUNIT+1
 I IBTO'=IBFR,IBXA>0,IBXA<4,$$ISGMTPT^IBAGMT(DFN,IBTO)'=$$ISGMTPT^IBAGMT(DFN,IBFR) W !!,"The patient changed GMT Copayment status during the specified period!",! G TO
 I IBXA>1 D  G END
 . S IBCHG=IBUNIT*IBCHG S:IBXA=2 IBCHG=$S(IBDOLP+IBCHG>IBMED:IBMED-IBDOLP,1:IBCHG)
 . I IBCHG=IBCHGP D CTBB^IBECEAU3 W !!,"No change was made!" S IBY=-1 Q
 . S:IBXA=2 IBDOLA=IBDOLP+IBCHG,IBDAYA=0 S:IBXA=3 IBDAYA=IBDAYP+IBUNIT,IBDOLA=0
 . W !!,"New charge to be billed" W:IBGMTR "(GMT Rate)" W ": $",$J(IBCHG,"",2),!
 . I IBH D CHCL^IBECEA22
 ;
 ; - ask for 'Fee Amount'
 S IBCLDOLO=IBCLDOL,IBCLDOL=IBCLDOL-IBCHGP S:IBCLDOL<0 IBCLDOL=0
 I IBGMT>0 S IBGMTR=1 W !,"The patient has GMT Copayment Status! GMT rate must be applied.",!
 D FEE^IBECEAU2(IBCHGP) G:IBY<0 END
 I IBCHG=IBCHGP W !!,"No change was made!" S IBY=-1 G END
 S IBCLDOL=IBCLDOLO,IBDOLA=IBDOLP+IBCHG,IBDAYA=0
 I IBH D CHCL^IBECEA22
 ;
END Q
