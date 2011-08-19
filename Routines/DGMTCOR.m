DGMTCOR ;ALB/CAW,SCG,LBD,TMK - Check Copay Test Requirements ; 07/28/08
 ;;5.3;Registration;**21,45,182,290,305,330,344,495,564,773**;Aug 13, 1993;Build 7
 ;
 ;A patient may apply for a copay test under the following conditions:
 ;  - Applicant is a veteran
 ;  - Applicant's primary or other eligibility does NOT contain
 ;    - Service Connected 50% to 100% or
 ;    - Aid and Attendance or
 ;    - Housebound or
 ;    - VA Pension
 ;  - Primary Eligibility is NSC
 ;    - who has NOT been means tested
 ;    - who claims exposure to agent orange or ionizing radiation
 ;    - who is eligible for medicaid
 ;  - Applicants who have answered 'no' to Receiving A&A, HB, or Pension
 ;  - Applicants who have previously qualified and applied for a copay 
 ;      exemption, still qualify and have NOT been copay tested in the
 ;      past year
 ;  - Applicants who are not currently a DOM patient or inpatient
 ;      (they are temporarily exempt from copay testing) DG*5.3*290
 ;  - Applicants who do not have POW eligibility (DG*5.3*564 - HVE III)
 ;  - Applicants who do not meet criteria for Unemployable: 
 ;      Unemployable="Y", SC%>0, not receiving A&A, HB or Pension, and
 ;      Total VA Check Amount>0  (DG*5.3*564 - HVE III) 
 ;
 ; Input  -- DFN     Patient IEN
 ;           DGADDF  Means Test Add Flag (optional)
 ;           DGNOIVMUPD Do Not Update IVM Copay Test Flag (optional)
 ; Output -- DGMTCOR  Copay Test Flag
 ;                   (1 if eligible and 0 if not eligible)
 ;
 ;
EN ;
 Q:$G(VAFCA08)=1
 N DGMTI,DGMTYPT,DGMDOD
 D ON^DGMTCOU G:'Y ENQ
 S DGRGAUTO=1 ;possible change in cp status w/o call to cp event driver
 D CHK
 ;
 Q:($G(DGWRT)=8)!($G(DGWRT)=9)   ;brm;quit if inpatient or dom;DG*5.3*290
 S IVMZ10F=+$G(IVMZ10F)
 I 'DGMTCOR,'$G(DGADDF),'$G(DGMDOD),'IVMZ10F D NLA
 I DGMTCOR,'$G(DGADDF),'$G(DGMDOD) D INC
 I DGRGAUTO&'$G(DGADDF) D QREGAUTO ;if cp event driver not fired off & NOT a new means test
 ;
ENQ Q
 ;
CHK N STATUS,DGELIG,DGE,DGI,DGNODE,DGMDOD,DGMTDT,DGMTI,DGMTL
 S DGMTCOR=1,DGMT="",DGMTYPT=2
 I $P($G(^DPT(DFN,"VET")),U,1)'="Y" S DGMTCOR=0,DGWRT=1 G CHKQ ;NON-VET
 ;Added with DG*5.3*344
 S DGMTL=$$LST^DGMTU(DFN),DGMTI=+DGMTL,DGMTDT=$P(DGMTL,U,2)
 S DGMDOD=$P($G(^DPT(DFN,.35)),U)
 I 'DGMTI,$G(DGMDOD) S DGMTCOR=0 Q
 I DGMDOD,(DGMTCOR),(DGMTDT>(DGMDOD-1)) S DGMTCOR=0 G CHKQ
 ;
 I '$P($G(^DPT(DFN,.36)),U) S DGMTCOR=0,DGWRT=2 G CHKQ  ;NO PRIM ELIG
 I +$G(DGMDOD) S DGNOCOPF=1
 ;
 ;This doesn't work! The "AEL" x-ref not there when changing the primary
 ;eligibility! Problem with order that the cross-references are called
 ;in, DGMTR is called before the "AEL" x-ref is set!
 ;F  S DGMTI=$O(^DPT("AEL",DFN,DGMTI)) Q:'DGMTI  S DGMTE=$P($G(^DIC(8,DGMTI,0)),U,9) I "^1^2^4^15^"[("^"_DGMTE_"^") S DGMTCOR=0,DGWRT=3 G CHKQ
 ;
 ;
 S DGI=$P($G(^DPT(DFN,.36)),"^"),DGELIG=U_$P($G(^DIC(8,+DGI,0)),U,9)_U
 S DGI=0 F  S DGI=$O(^DPT(DFN,"E",DGI)) Q:'DGI  S DGE=$P($G(^DPT(DFN,"E",DGI,0)),U),DGELIG=DGELIG_$P($G(^DIC(8,+DGE,0)),U,9)_U
 I (DGELIG["^1^") S DGMTCOR=0,DGWRT=3 G CHKQ  ;SC 50-100%
 F DGI=.3,.362,.52 S DGNODE(DGI)=$G(^DPT(DFN,DGI))
 I $P(DGNODE(.362),U,12)["Y"!(DGELIG["^2^") S DGMTCOR=0,DGWRT=5 G CHKQ ;A&A
 I $P(DGNODE(.362),U,13)["Y"!(DGELIG["^15^") S DGMTCOR=0,DGWRT=6 G CHKQ ;HB
 I $P(DGNODE(.362),U,14)["Y"!(DGELIG["^4^") S DGMTCOR=0,DGWRT=7 G CHKQ ;PENSION
 I $P(DGNODE(.52),U,5)["Y"!(DGELIG["^18^") S DGMTCOR=0,DGWRT=10 G CHKQ ;POW (DG*5.3*564)
 I $P(DGNODE(.3),U,5)["Y"&($P(DGNODE(.3),U,2)>0)&($P(DGNODE(.362),U,20)>0) S DGMTCOR=0,DGWRT=11 G CHKQ ;UNEMPLOYABLE (DG*5.3*564)
 ;brm added next 3 lines for DG*5.3*290
 N DGDOM,DGDOM1,VAHOW,VAROOT,VAINDT,VAIP,VAERR,NOW
 D DOM^DGMTR I $G(DGDOM) S DGMTCOR=0,DGRGAUTO=0,DGWRT=8 Q        ;DOM
 D IN5^VADPT I $G(VAIP(1))'="" S DGMTCOR=0,DGRGAUTO=0,DGWRT=9 Q  ;INP
 I DGMTI,'$$OLD^DGMTU4(DGMTDT) S STATUS=$P($G(^DGMT(408.31,+DGMTI,0)),U,3) I STATUS'="3" S DGMTCOR=0,DGWRT=4 G CHKQ
CHKQ Q
 ;
NLA ; Change Status to NO LONGER APPLICABLE - if appropriate
 ;
 N DGCS,DGMTI,DGMT0,DGINI,DGINR,DGVAL,DGFL,DGFLD,DGIEN,DGMTACT,TDATE
 S DGMTI=+$$LST^DGMTU(DFN,"",2) Q:'DGMTI!($P($G(^DGMT(408.31,DGMTI,0)),U,3)=10)
 ; Do not allow update of IVM test by site
 I $G(DGNOIVMUPD),$$IVMCVT^DGMTCOR(DGMTI) D  Q  ;Check if converted IVM MT
 . ;I '$G(DGMSGF),$G(DGNOIVMUPD)<2 W !,"IVM RX COPAY TEST EXISTS, BUT VISTA CALCULATES 'NO LONGER APPLICABLE'",!,"CONTACT IVM TO CLEAR UP THE DISCREPANCY - YOU CANNOT UPDATE AN IVM TEST"
 . S DGNOIVMUPD=2 ; Prevent double printing of the message
 S DGMT0=$G(^DGMT(408.31,DGMTI,0)) Q:'DGMT0
 S DGCS=$P(DGMT0,U,3)
 S TDATE=+DGMT0
 S DGMTACT="STA" D PRIOR^DGMTEVT
 ;
 D SAVESTAT^DGMTU4(DGMTI)
 ;
 S DGFL=408.31,DGIEN=DGMTI
 S DGFLD=.03 I DGCS]"" S DGVAL=DGCS D KILL^DGMTR
 S DGVAL=10,$P(^DGMT(408.31,DGMTI,0),"^",3)=DGVAL D SET^DGMTR
 S DGFLD=.17,DGVAL=DT,$P(^DGMT(408.31,DGMTI,0),"^",17)=DT D SET^DGMTR
 W:'$G(DGMTMSG)&'$D(ZTQUEUED) !,"COPAY TEST NO LONGER APPLICABLE"
 D GETINCOM^DGMTU4(DFN,TDATE)
 S DGMTYPT=2 D QUE^DGMTR
 S DGRGAUTO=0
NLAQ Q
 ;
INC ;Update copay status to 'INCOMPLETE' if applicable OR restore completed test
 N DGMTACT,DGMTI,DGFL,DGFLD,DGIEN,DGMTP,DGVAL,DGMT0,AUTOCOMP,ERROR
 S AUTOCOMP=0
 S DGMTI=+$$LST^DGMTU(DFN,"",2)
 D
 .Q:'DGMTI
 .I ($P($G(^DGMT(408.31,DGMTI,0)),U,3)'=10) S AUTOCOMP=1 Q
 .S DGMT0=$G(^DGMT(408.31,DGMTI,0)),DGCS=$P(DGMT0,U,3)
 .Q:'DGMT0
 .S DGMTACT="STA" D PRIOR^DGMTEVT
 .S AUTOCOMP=$$AUTOCOMP^DGMTR(DGMTI)
 .W:'AUTOCOMP&'$G(DGMTMSG)&'$D(ZTQUEUED) !,"COPAY EXEMPTION TEST UPDATED TO INCOMPLETE"
 .W:AUTOCOMP&'$G(DGMTMSG)&'$D(ZTQUEUED) !,"COPAY EXEMPTION TEST UPDATED TO ",$$GETNAME^DGMTH($P($G(^DGMT(408.31,DGMTI,0)),"^",3))
 .S DGMTYPT=2 D QUE^DGMTR
 .S DGRGAUTO=0
 ;
 I $G(IVMZ10)'="UPLOAD IN PROGRESS",$G(DGQSENT)'=1,'AUTOCOMP,'$$OPEN^IVMCQ2(DFN),'$$SENT^IVMCQ2(DFN) D QRYQUE2^IVMCQ2(DFN,$G(DUZ),0,$G(XQY)) S DGQSENT=1 I '$D(ZTQUEUED),'$G(DGMSGF) W !!,"Financial query queued to be sent to HEC..."
 ;
INCQ Q
 ;
QREGAUTO ;Queues off test done by IB recalculating CP status
 ;  Input: DFN
 ;  Action: Possible update of Copay Status
 ;
 Q:'$D(^IBA(354.1,"APIDT",DFN,1))  ;No action if no status on file
 S ZTDESC="CHECK PATIENT FILE CHANGES VS CP STATUS",ZTDTH=$H,ZTRTN="REGAUTO^IBARXEU5",ZTSAVE("DFN")="",ZTIO=""
 D ^%ZTLOAD
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
IVMCVT(IVMTIEN) ; Check for a converted IVM Means Test
 ;  Input  IVMTIEN - MT IEN to check
 ;  Return 1 - if converted MT
 ;         0 - if not a converted MT
 ;
 N FLAG,IVMAR
 S FLAG=0
 I '$G(IVMTIEN) G IVMQ
 D GETS^DIQ(408.31,IVMTIEN,".23;.25","E","IVMAR")
 ; To identify an IVM converted test in the ANNUAL MEANS TEST, #408.31, if the Source of Test (#.23)
 ; is equal to 'IVM' OR the Date IVM Verified MT Completed (#.25) is populated, then the test should
 ; be considered a converted test. 
 I IVMAR(408.31,IVMTIEN_",",.23,"E")="IVM" S FLAG=1 G IVMQ
 I IVMAR(408.31,IVMTIEN_",",.25,"E")]"" S FLAG=1 G IVMQ
IVMQ ;
 Q FLAG
