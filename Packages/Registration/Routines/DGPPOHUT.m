DGPPOHUT ;SLC/RM - PRESUMPTIVE PSYCHOSIS OTHER THAN HONORABLE UTILITY ; February 25, 2021@1:00 pm
 ;;5.3;Registration;**1035**;Aug 13, 1993;Build 14
 ;
 ;Global References      Supported by ICR#     Type
 ;-----------------      -----------------     ----------
 ; ^TMP($J               SACC 2.3.2.5.1
 ;
  ;External References
 ;-------------------
 ; PSS^PSO59              4827                 Supported
 Q
 ;
REFILL(LIST) ;extract rx refill for this patient
 N JJ,DGRFFILDT,DGDIV,DGSTA,DGSTANAME,DGLSTUSR,RXNCOPAY
 I +$P(^TMP($J,LIST,DGDFN,DGRXIEN,"RF",0),U)>0 D
 . F JJ=1:1:+$P(^TMP($J,LIST,DGDFN,DGRXIEN,"RF",0),U) D
 . . ;only include Rx record that do not have charges in file #350. This is to avoid duplicates.
 . . I +$G(^TMP($J,LIST,DGDFN,DGRXIEN,"IB",0))>0 D  Q:'RXNCOPAY  ;this is already handled by IBEFMSUT routine. No need to include this record here and to avoid duplicate record.
 . . . S RXNCOPAY=0
 . . . I $G(^TMP($J,LIST,DGDFN,DGRXIEN,"IB",JJ,9))="" S RXNCOPAY=1 ;include those rx refill not handled by IBEFSMUT. These are the rx with no copay.
 . . S DGRFFILDT=^TMP($J,LIST,DGDFN,DGRXIEN,"RF",JJ,17) ;rx refill released date
 . . I +DGRFFILDT<1,+$P(^TMP($J,LIST,DGDFN,DGRXIEN,"RF",JJ,14),U)>1 S DGRFFILDT=$P(^TMP($J,LIST,DGDFN,DGRXIEN,"RF",JJ,14),U) ;extract the RETURN TO STOCK date release date/time
 . . I $G(DGPPFLGRPT)=1 S DGOTHREGDT=DGSORT("DGBEG"),DGELGDTV=DGSORT("DGEND") ;this for PP multiple report processing
 . . ;check if the rx refill date is within the date range patient became OTH and when PE is verified
 . . Q:'$$CHKDATE^DGOTHFSM(+DGRFFILDT\1,DGOTHREGDT,DGELGDTV)
 . . S DGDIV=$P(^TMP($J,LIST,DGDFN,DGRXIEN,"RF",JJ,8),U) ;division ien
 . . K ^TMP($J,"PSOSITERF") D PSS^PSO59(DGDIV,,"PSOSITERF") S DGSTA=$G(^TMP($J,"PSOSITERF",DGDIV,.06)) ;station number
 . . S DGSTANAME=$P(^TMP($J,LIST,DGDFN,DGRXIEN,"RF",JJ,8),U,2) ;division name
 . . S DGLSTUSR=$P(^TMP($J,LIST,DGDFN,DGRXIEN,"RF",JJ,4),U,2) ;pharmacist entered this rx
 . . S DGLSTUSR=$S(DGLSTUSR="":"UNKNOWN",1:DGLSTUSR)
 . . S DGENCNT=DGENCNT+1
 . . S @RECORD@(+DGRFFILDT\1,DGSTA,52,DGENCNT)=DGSTANAME_U_DGSTA_U_$S(DGCLNC'="":DGCLNC,1:"NON-VA")_U_"N/A"_U_DGLSTUSR_U_DGDIV_U_"RX - "_DGRXNUM_":"_DGRXIEN
 K ^TMP($J,"PSOSITERF")
 Q
 ;
PARTIAL(LIST) ;Extract Rx Partial Refill
 N JJJ,DGPRTLRELDT,DGPRTLDIV,DGPRTLSTA,DGPRTLSTN,DGPRTLUSR,DGNUMOFREF,DGPRTLDSRF,DGCPTIER,DGPRTLFLDT,DATA1,DATA2,PTSTATUS
 I $G(PPIBRX)!($G(OTHIBRX)) S JJJ=$P(RESULT,":",5) D PARTIAL1 Q
 I DGPRTLTOT>0 D
 . F JJJ=1:1:DGPRTLTOT D
 . . I $G(DGPPFLGPRTL)=1,$D(^TMP($J,"DGPPDRX52","B",DGRXNUM,DGRXIEN,JJJ_"P")) Q
 . . I $G(DGOTHFLGPRTL)=1,$D(^TMP($J,"OTHFSMR2","B",DGRXNUM,DGRXIEN,JJJ_"P")) Q
 . . D PARTIAL1
 Q
 ;
PARTIAL1 ;
 S DGPRTLRELDT=$P($G(^TMP($J,LIST,DFN,DGRXIEN,"P",+JJJ,8)),U) ;Rx partial fill released date
 I +DGPRTLRELDT<1,+$P(^TMP($J,LIST,DFN,DGRXIEN,"P",+JJJ,5),U)>1 S DGPRTLRELDT=$P(^TMP($J,LIST,DGDFN,DGRXIEN,"P",+JJJ,5),U)_"R" ;extract the Rx Partial Fill RETURN TO STOCK date
 Q:'$$CHKDATE^DGOTHFSM(+DGPRTLRELDT\1,DGSORT("DGBEG"),DGSORT("DGEND"))
 S DGPRTLDIV=+$P(^TMP($J,LIST,DFN,DGRXIEN,"P",+JJJ,.09),U) ;rx partial fill division ien
 K ^TMP($J,"PSOSITERF") D PSS^PSO59(DGPRTLDIV,,"PSOSITERF") S DGPRTLSTA=$G(^TMP($J,"PSOSITERF",DGPRTLDIV,.06)) ;station number
 I $G(DGOTHFLGPRTL)=1 D CPTIER^DGOTHFS3 ;extract the copay tier
 I $G(DGPPFLGPRTL)=1 D CPTIER^DGPPDRP1 ;extract the copay tier
 S DGNUMOFREF=$P(^TMP($J,LIST,DFN,DGRXIEN,9),U) ;# of refills
 S DGPRTLDSRF=$P(^TMP($J,LIST,DFN,DGRXIEN,"P",+JJJ,.041),U) ;rx partial fill days supply
 S DGPRTLSTN=$P(^TMP($J,LIST,DFN,DGRXIEN,"P",+JJJ,.09),U,2) ;rx partial fill division name
 S DGPRTLUSR=$P(^TMP($J,LIST,DFN,DGRXIEN,"P",+JJJ,.05),U,2) ;pharmacist entered this rx partial fill
 S DGPRTLFLDT=$P(^TMP($J,LIST,DFN,DGRXIEN,"P",+JJJ,.01),U) ;rx partial fill date
 S DGPRTLUSR=$S(DGPRTLUSR="":"UNKNOWN",1:DGPRTLUSR)
 I $G(DGPPFLGPRTL)=1 S PTSTATUS=$P(^TMP($J,"DGPPDRX52",DFN,DGRXIEN,3),U,2) ;Patient status
 S DATA1=DGRXNUM_"("_+JJJ_")"_U_DGCPTIER_U_DGNUMOFREF_U_DGPRTLDSRF_U_DGPRTLSTA_U_DGPRTLFLDT_U_DGPRTLRELDT_"P"
 I $G(OTHIBRX) D IBSTAT^DGOTHFS3 ;Extract the IB Status in File #350/File #399
 I $G(PPIBRX) D IBSTAT^DGPPDRX
 I $G(DGOTHFLGPRTL)=1 D  ;for OTH partial rx recording
 . I $P(DGSORT("SORTRXBY"),U)=1 S CNTR=CNTR+1,^TMP($J,"OTHFSMRX",+DGPRTLRELDT\1,DGPRTLSTA,DFN,DGRXNUM,CNTR)=DATA1_$S($G(OTHIBRX):U_DATA2,1:"")
 . E  S CNTR=CNTR+1,^TMP($J,"OTHFSMRX",DGPRTLSTA,+DGPRTLRELDT\1,DFN,DGRXNUM,CNTR)=DATA1_$S($G(OTHIBRX):U_DATA2,1:"")
 . S DGPRTLRXFL=1,^TMP($J,"OTHFSMR2","B",DGRXNUM,DGRXIEN,+JJJ_"P")=""
 I $G(DGPPFLGPRTL)=1 D  ;for PP partial rx recording
 . I $P(DGSORT("SORTRXBY"),U)=1 S CNTR=CNTR+1,^TMP($J,"DGALLPPDRX",DGRXNUM,+DGPRTLRELDT\1,DGPRTLSTA,DFN,CNTR)=DATA1_$S($G(PPIBRX):U_DATA2,1:"^^^^")_U_PTSTATUS
 . E  S CNTR=CNTR+1,^TMP($J,"DGALLPPDRX",DGRXNUM,DGPRTLSTA,+DGPRTLRELDT\1,DFN,CNTR)=DATA1_$S($G(PPIBRX):U_DATA2,1:"^^^^")_U_PTSTATUS
 . S DGPPRXPRTLFL=1,^TMP($J,"DGPPDRX52","B",DGRXNUM,DGRXIEN,+JJJ_"P")=""
 K ^TMP($J,"PSOSITERF")
 Q
 ;
