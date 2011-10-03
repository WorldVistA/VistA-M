IBTUBOU ;ALB/RB - UNBILLED AMOUNTS (UTILITIES) ;03 Aug 2004  7:21 AM
 ;;2.0;INTEGRATED BILLING;**123,159,155**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DT1 ; - Select date range (returns variables IBBDT and IBEDT).
 N DT0,DT1,DTOUT,DUOUT,Y
 S DT0=$O(^IBT(356,"D",""))\1,DT1=""
 I DT0 S DT1=$$DAT3^IBOUTL(DT0),DIR("B")=DT1
 S DIR(0)="DA^"_DT0_":"_DT_":AEX",DIR("A")="Start with DATE: "
 S DIR("?",1)="If you enter a start date here, the report will look for"
 S DIR("?",2)="events ON or AFTER this date. Press <CR> if you want to"
 S DIR("?",3)="skip this prompt and have the report look thru ALL events"
 S DIR("?",4)="or enter '^' to exit.",DIR("?",5)=""
 S DIR("?",6)="NOTE: The earliest date that can be entered is "_DT1_","
 S DIR("?",7)="      which is the date of the first event on file, and"
 S DIR("?")="      it is NOT possible to enter a future date."
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S IBBDT="^" G DT1Q
 S IBBDT=Y,DT1=$$DAT3^IBOUTL(IBBDT)
 ;
 S DIR("B")=$$DAT3^IBOUTL(DT)
 S DIR(0)="DA^"_IBBDT_":"_DT_":AEX",DIR("A")="     Go to DATE: "
 S DIR("?",1)="If you enter a end date here, the report will look for"
 S DIR("?",2)="events from "_DT1_" to this date. Press <CR> to have"
 S DIR("?",3)="the report look at all events from "_DT1_" to today,"
 S DIR("?",4)="or enter '^' to exit."
 S DIR("?",5)=""
 S DIR("?",6)="NOTE: This date MUST NOT be earlier than "_DT1_" neither"
 S DIR("?")="      later than today."
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S IBBDT="^" G DT1Q
 S IBEDT=Y+.9
 ;
DT1Q Q
 ;
DT2(STR) ; - Select re-compile date (returns variable IBTIMON).
 ; Input: STR - String that describe the type of data that will be 
 ;        re-compiled: "Unbilled Amounts", "Average Bill Amounts", etc...
 ;
 N DIRUT,DT0,DT1,DT2,Y
 ; - AUG 1993 is the first month on file with Unbilled Amounts data
 S DT0=2930800,DT1=$$DAT2^IBOUTL(DT0)
 S DT2=$$M1^IBJDE(DT,1),DIR("B")=$$DAT2^IBOUTL(DT2)
 S DIR(0)="DA^"_$E(DT0,1,5)_"00:"_DT2_":AE^K:$E(Y,6,7)'=""00"" X"
 S DIR("A")="Re-compile "_$G(STR)_" through MONTH/YEAR: "
 S DIR("?",1)="Enter a past month/year (ex. Oct 2000).",DIR("?",2)=""
 S DIR("?",3)="NOTE: The earliest month/year that can be entered is "_DT1_", and"
 S DIR("?")="      it is NOT possible to enter the current or a future month/year."
 D ^DIR K DIR I $D(DIRUT) S IBTIMON="^" G DT2Q
 I $E(Y,6,7)'="00"!($E(Y,4,7)="0000") W "  ??" G DT2
 S IBTIMON=Y
 ;
DT2Q Q
 ;
YR2(D) ; - Return a date two years from date D.
 N X,X1,X2 S X="" G:'$G(D) YR2Q S X1=D,X2=-730 D C^%DTC
 ;
YR2Q Q X
 ;
COV(P,E,T) ; - Check if patient has insurance coverage.
 ;    Input: P=patient IEN, E=event date,
 ;           T=1-inpatient/2-outpatient/3-pharmacy
 ;   Output: Y=1-patient has coverage/0-no coverage or unknown
 N X,XY,Y S Y=0 G:'$G(P)!('$G(E))!('$G(T)) COVQ
 S X=$S(T=1:"INPATIENT",T=2:"OUTPATIENT",1:"PHARMACY")
 S Y=$$PTCOV^IBCNSU3(P,E,X,.XY)
 ;
COVQ Q Y
 ;
PTCHK(DFN,IBNODE) ; - See if patient has a non-veteran eligibility.
 ;    Input: DFN=patient IEN
 ;           IBNODE=zero node to CT entry
 ;   Output: IBFLAG=0-nonbillable, 1-billable 
 N IBFLAG S IBFLAG=0 G:'$G(DFN) PTCKQ
 I $D(^DPT(+DFN,.312)),$G(^("VET"))="Y" S IBFLAG=1
 I $P(IBNODE,U,4),$P($G(^DIC(8,+$$SCE^IBSDU(+$P(IBNODE,U,4),13),0)),U,5)="N" S IBFLAG=0
 ;
PTCKQ Q IBFLAG
 ;
NCCL(ENC) ; - Check if Encounter is NON-COUNT CLINIC
 ;    Input: ENC = Pointer to the ENCOUNTER file (#409.69)
 ;   Output: NCCL= 1 - NON-COUNT CLINIC / 0 - NO NON-COUNT CLINIC
 N NCCL,HLOC
 S NCCL=0,HLOC=$$SCE^IBSDU(+ENC,4)
 I HLOC,$P($G(^SC(+HLOC,0)),"^",17)="Y" S NCCL=1
 ;
 Q NCCL
 ;
HOSP(ADM) ; Is the patient still hospitalized (not discharged)?
 ; Input: ADM  = Pointer to the PATIENT MOVEMENT file (#405)
 ;Output: HOSP = 1 - Hospitalized / 0 - Discharged
 ;
 N HOSP,X
 S HOSP=1,X=$G(^DGPM(+ADM,0)) I $P(X,"^",17) S HOSP=0
 ;
 Q HOSP
 ;
CKBIL(X,Y) ; - Return valid claim data.
 ;    Input: X=IEN from file #399, Y=0-outpatient, 1-inpatient
 ;   Output: Z=rate^status^auth date^1-inst claim/2-prof claim^
 ;             event date (if Y=1), or null^req MRA date
 N X1,X2,Y1,Z S Z="" G:'$G(X) CKBLQ S:'$G(Y) Y=0
 S X1=$G(^DGCR(399,X,0)) G:X1="" CKBLQ
 I $G(DFN),$P(X1,U,2)'=DFN G CKBLQ ;              Invalid patient IEN.
 I '$G(IBRX),'Y,'$$NOTRX(X) G CKBLQ ;             Bill has RX rev codes.
 I $P(X1,U,5)<3,'Y G CKBLQ ;                      Not inpatient bill.
 I $P(X1,U,5)>2,Y G CKBLQ ;                       Not outpatient bill.
 I $P(X1,U,11)'="i" G CKBLQ ;                     Not an insurance bill.
 S X2=$P($G(^DGCR(399,X,"S")),U,10)
 I 'X2 G:$P(X1,U,13)'=2 CKBLQ ; No authorization date, not MRA req
 I $P(X1,U,13)<2!($P(X1,U,13)>5) G CKBLQ ; Status not auth, prin, trans.
 S Z=$P(X1,U,7)_U_$P(X1,U,13)_U_X2,Y1=$P($P(X1,U,3),".")
 S:$P(X1,U,13)=2 $P(Z,U,6)=$P($G(^DGCR(399,X,"S")),U,7)
 I $P(X1,U,27)=1!($P(X1,U,19)=3)!(Y1<2990901) S $P(Z,U,4)=1 G CKBL1
 I $P(X1,U,27)=2!($P(X1,U,19)=2) S $P(Z,U,4)=2
 I '$P(Z,U,4) S Z="" G CKBLQ ; Not institutional or professional bill.
CKBL1 I Y S $P(Z,U,5)=Y1
 ;
CKBLQ Q Z
 ;
CKENC(IBOE,IBOE0,IBQUIT) ; - Check outpatient encounters.
 N IBCK,IBZ,IBPB,IBZERR
 I $G(IBOE0)="" D GETGEN^SDOE(IBOE,"IBZ","IBZERR") S IBOE0=$G(IBZ(0))
 F IBZ=9,13,14 S IBCK(IBZ)=""
 I '$$BILLCK^IBAMTEDU(IBOE,IBOE0) S IBQUIT=1 ; Not billable.
 Q
 ;
SCAN(DFN,IBDT,IBQUERY) ; - Look at all visits for a day.
 N IBNDT,IBVAL,IBFILTER,IBCBK
 S IBVAL("DFN")=DFN,IBVAL("BDT")=IBDT,IBVAL("EDT")=IBDT,IBFILTER=""
 S IBCBK="I $P(Y0,U,8)=3,Y0>IBDT S:'IBNDT IBNDT=+Y0 D:IBNDT=+Y0 CKENC^IBTUBOU(Y,Y0,.IBQUIT) S:$S('$G(IBQUIT):1,1:Y0>IBNDT) SDSTOP=1"
 S IBNDT=0 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,IBFILTER,IBCBK,0,.IBQUERY)
 Q
 ;
SC(PTF) ; - If patient is SC, are movements for SC care.
 ;    Input: PTF=PTF record
 ;   Output: IBM=1-all movements PTF, 0-one or more not flagged as SC
 N M,IBM S IBM=1,M=0 G:$G(^DGPT(+$G(PTF),0))="" SCQ
 F  S M=$O(^DGPT(PTF,"M",M)) Q:'M  D  Q:'IBM
 .I $P($G(^DGPT(PTF,"M",M,0)),U,18)'=1 S IBM=0
 ;
SCQ Q IBM
 ;
LD(L,M) ; - Load average/unbilled totals into file #356.19
 ;   Input: L=1-average (mon), 2-average (12m), 3-unbilled
 ;          M=file #356.19 IEN
 I '$G(L)!('$G(M)) G LDQ
 S DA=M,DIE="^IBE(356.19,"
 S DR=$S(L=3:"[IBT UNBILLED AMOUNTS]",L=2:"[IBT AVERAGE BILL AMOUNTS (12M)]",1:"[IBT AVERAGE BILL AMOUNTS (MON)]")
 D ^DIE K DA,DIE,DR
 ;
LDQ Q
 ;
XTRACT ; - Calculate remaining extract totals and load into file #351.71
 ; - Set IB with the average and total amounts and call E^IBJDE
 N X,AVGS
 S AVGS=$$INPAVG(IBTIMON)
 S IB(2)=$J(IB(1)*$P(AVGS,"^"),0,2)
 S IB(4)=$J(IB(3)*$P(AVGS,"^",2),0,2)
 S IB(6)=$J(IB(2)+IB(4),0,2)
 S IB(13)=IB(9)+IB(11),IB(15)=IB(7)+IB(14)
 F X=8,10,12,18 S IB(X)=$J(IB(X),0,2)
 S IB(16)=$J(IB(8)+IB(10)+IB(12),0,2)
 S IB(19)=$J(IB(6)+IB(16)+IB(18),0,2)
 D E^IBJDE(37,0)
 Q
 ;
INPAVG(IBYRMO) ; - Calculate the Average Inpatient INST. & PROF. Billed Amounts
 ; Input: IBYRMO - YEAR/MONTH (YYYMM00) being calculated/updated
 ; Output: Avg.Inpt.Inst.Bill Amount ^ Avg.Inpt.Prof. Bill Amount
 ;
 N AVGI,AVGP,ND I '$G(IBYRMO) Q ""
 F  Q:$P($G(^IBE(356.19,IBYRMO,1)),"^",14)'=""!'IBYRMO  D
 . S IBYRMO=$O(^IBE(356.19,IBYRMO),-1)
 S (AVGI,AVGP)=0 I 'IBYRMO Q ""
 S ND=$G(^IBE(356.19,IBYRMO,1))
 I $P(ND,"^",9) S AVGI=$J($P(ND,"^",8)/$P(ND,"^",9),0,2)
 I $P(ND,"^",12) S AVGP=$J($P(ND,"^",11)/$P(ND,"^",12),0,2)
 Q (AVGI_"^"_AVGP)
 ;
NOTRX(BILL) ; - Determine if bill contains outpatient visit (use this check
 ;   to make sure not just rx bill returns one if contains a revenue
 ;   code for outpatient visit or a zero if no outpatient visit code
 ;   on bill).
 N IBRX,RC,X
 S (IBRX,RC)=0 G:'$O(^DGCR(399,BILL,"OP",0)) NOTRXQ
 F  S RC=$O(^DGCR(399,BILL,"RC",RC)) Q:'RC  I $P($G(^DGCR(399.1,+$P($G(^DGCR(399,BILL,"RC",RC,0)),U,5),0)),U)'="PRESCRIPTION" S IBRX=1 Q
 ;
NOTRXQ Q IBRX
