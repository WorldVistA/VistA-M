ACKQAG04        ;DDC/PJU - Utility for ACKQAG03 - Transmission to DDC;5/16/05
 ;;3.0;QUASAR AUDIOMETRIC MODULE;**3,12**;4/01/03
 ;;see descriptions in ACKQAG.TXT
START(ACKQA,DFN)   ;
 K ACKQE
 I '$G(DFN) D  G END
 .S ACKQE="**ERROR** Must have a DFN to run routine RMPFRPC2 "
 I '$D(^ACK(509850.9,0)) D  G END
 .S ACKQE="**ERROR** QUASAR file 509850.9 (Audiometric Exam Data file)"
 .S ACKQE=ACKQE_" is not available"
 I '$D(^ACK(509850.9,"DFN",DFN)) D  G END
 .S ACKQE="**ERROR** patient not in audiogram file"
 S ACKQDATE="A",ACKQ1IEN=""
S1 S ACKQDATE=$O(^ACK(509850.9,"DFN",DFN,ACKQDATE),-1)
 I 'ACKQDATE D  G END
 .S ACKQE="**ERROR** No current audiograms for patient in file"
 S ACKQ1IEN=0
S2 S ACKQ1IEN=$O(^ACK(509850.9,"DFN",DFN,ACKQDATE,ACKQ1IEN))
 I 'ACKQ1IEN D  G S1
 .S ACKQE="**ERROR** No data exists for visit on "_$$FMTE^XLFDT(ACKQDATE)
 ;W !,"Entry number found: ",ACKQ1IEN
 I '$D(^ACK(509850.9,ACKQ1IEN,0)) D  G S1
 .S ACKQE="**ERROR** Node missing in file for this visit"
 G EN2
EN(ACKQA,ACKQ1IEN,DFN) ;called from ACKQAG03 for data transmission
EN2 ;entry from S2 to skip EN
 K ACKQE N SSN,SD,X,NM,DOB,AGE F I=1:1:35 S ACKQA(I)=""
 S ACKQA(1)=0,ACKQN=0
 S S0=$G(^ACK(509850.9,ACKQ1IEN,0))
 I $P(S0,U,2)'=DFN D  G END  ;already checked in calling routine
 .S ACKQE="***URGENT AUDIOGRAM FILE ERROR*** wrong DFN"
 .S ACKQE=ACKQE_" in Cross Reference or record: "_DFN
 ;Set up ACKQA(1)
 S SD=$P(S0,U,1) ;DATE SEEN
 S AGE=$P(S0,U,5)
 S ACKQA(1)="BGN"_U_ACKQ1IEN
 D DEM^VADPT I $G(VAERR) D  G END
 .S ACKQE="***UNABLE TO ACCESS PATIENT DEMOGRAPHICS***"
 D ELIG^VADPT I $G(VAERR) D  G END
 .S ACKQE="***UNABLE TO ACCESS PATIENT ELIGIBILITY***"
 S NM=VADM(1),NM=$E(NM,1,30),SSN=$P(VADM(2),U,1),DOB=$P(VADM(3),U,1)
 S $P(ACKQA(1),U,3)=NM
 S $P(ACKQA(1),U,4)=SSN ;encrypted in ACKQAG03
 ;;5th pc is for err msg
 S $P(ACKQA(1),U,6)=DOB
 I $P(S0,U,3) D  ;audiologist
 .S Y=$P(S0,U,3),X=$$TITLE^ACKQAG01(Y),X=$E($P(X,U,1),1,30)
 .S $P(ACKQA(1),U,7)=X ;title
 I '$P(S0,U,3) S $P(ACKQA(1),U,7)="Unknown"
 S $P(ACKQA(1),U,8)=$P(S0,U,9) ;dt signed
 S $P(ACKQA(1),U,9)=SD ;FM exam dt
 S $P(ACKQA(1),U,10)=$S(VAEL(4):"Y",1:"N") ;vet Y/N
 S $P(ACKQA(1),U,11)=$P(VAEL(6),U,2) ;DFN Type
 S $P(ACKQA(1),U,12)=AGE
 S $P(ACKQA(1),U,13)=$P(S0,U,8) ;;transducer type(.08)
 S $P(ACKQA(1),U,14)=$P(S0,U,14) ;;claim #(.14)
 S $P(ACKQA(1),U,15)=$P(S0,U,15) ;;retrans dt(.15)
 D GETDATA(ACKQ1IEN)  ;array of test results
END ;
 S:'$D(ACKQA(1)) ACKQA(1)=0
 I $G(ACKQE)'="" D  D WRTERR
 .F I=2:1:39 S:$D(ACKQA(I)) ACKQA(I)=""
 K ACKQE,ACKQDATE,S0,VADM,VAEL,I
 Q
 ;
GETDATA(ACKQRMI)    ;
 ;;input: entry number in the Audiometic Exam Data file (ACKQRMI)
 ;;output: set up rest of array ACKQA() subscripts 2-35
 N P,P1,S0 ;P is the piece of the A nodes, 
 ;P1 is pc of the B nodes, S0 is a node holder
 N X ;X is the Hz
 N ACKQN S ACKQN=1 ;counter subscript(ACKQA(1) is filled above)
 ;subs (2-13) 125-12000 R A & B
 F P=1:1:12 D  ;START R A 
 .S ACKQN=ACKQN+1
 .S X=$S(P=1:125,P=2:250,P=3:500,P=4:750,P=5:1000,P=6:1500,P=7:2000,1:"")
 .S:X="" X=$S(P=8:3000,P=9:4000,P=10:6000,P=11:8000,P=12:12000,1:"")
 .S ACKQA(ACKQN)=X_U_"R"_U_"" ;X^ear^ien^Y
 .S $P(ACKQA(ACKQN),U,4)=$P($G(^ACK(509850.9,ACKQRMI,10)),U,P) ;1st Y val
 .S $P(ACKQA(ACKQN),U,5)=$P($G(^ACK(509850.9,ACKQRMI,11)),U,P) ;1st tag(send anyway)
 .S $P(ACKQA(ACKQN),U,6)=$P($G(^ACK(509850.9,ACKQRMI,50)),U,P) ;1st mask level
 .S $P(ACKQA(ACKQN),U,12)=$P($G(^ACK(509850.9,ACKQRMI,20)),U,P) ;final val
 .S $P(ACKQA(ACKQN),U,13)=$P($G(^ACK(509850.9,ACKQRMI,21)),U,P) ;final tag(send anyway)
 .S $P(ACKQA(ACKQN),U,14)=$P($G(^ACK(509850.9,ACKQRMI,51)),U,P) ;final mask lev
 .;R B
 .I X>125,X<7000 D
 ..S P1=P-1 ;125 not B reading so pc's 1 less
 ..S $P(ACKQA(ACKQN),U,7)=$P($G(^ACK(509850.9,ACKQRMI,70)),U,P1) ;1st B
 ..;S $P(ACKQA(ACKQN),U,8)=$P($G(^ACK(509850.9,ACKQRMI,71)),U,P1) ;1st bTAG(send anyway)
 ..S $P(ACKQA(ACKQN),U,9)=$P($G(^ACK(509850.9,ACKQRMI,90)),U,P1) ;1st mask level
 ..S $P(ACKQA(ACKQN),U,15)=$P($G(^ACK(509850.9,ACKQRMI,75)),U,P1) ;final B
 ..;S $P(ACKQA(ACKQN),U,16)=$P($G(^ACK(509850.9,ACKQRMI,76)),U,P1) ;f bTAG(send anyway)
 ..S $P(ACKQA(ACKQN),U,17)=$P($G(^ACK(509850.9,ACKQRMI,91)),U,P1) ;f B mask
 .;IAR/CAR AR-DECAY AR-HALFLIFE
 .S S0=$G(^ACK(509850.9,ACKQRMI,120))
 .I (X=500) D
 ..S $P(ACKQA(ACKQN),U,10)=$P(S0,U,4) ;R IAR 500
 ..S $P(ACKQA(ACKQN),U,11)=$P(S0,U,8) ;R CAR 500
 ..S $P(ACKQA(ACKQN),U,18)=$P(S0,U,12) ;R AR decay 500
 ..S $P(ACKQA(ACKQN),U,19)=$P(S0,U,14) ;R AR HL 500
 .I (X=1000) D
 ..S $P(ACKQA(ACKQN),U,10)=$P(S0,U,5) ;R IAR 1000
 ..S $P(ACKQA(ACKQN),U,11)=$P(S0,U,9) ;R CAR 1000
 ..S $P(ACKQA(ACKQN),U,18)=$P(S0,U,13) ;R AR decay 1000
 ..S $P(ACKQA(ACKQN),U,19)=$P(S0,U,15) ;R AR HL 1000
 .I (X=2000) D
 ..S $P(ACKQA(ACKQN),U,10)=$P(S0,U,6) ;R IAR 2000
 ..S $P(ACKQA(ACKQN),U,11)=$P(S0,U,10) ;R CAR 2000
 .I (X=4000) D
 ..S $P(ACKQA(ACKQN),U,10)=$P(S0,U,7) ;R IAR 4000
 ..S $P(ACKQA(ACKQN),U,11)=$P(S0,U,11) ;R CAR 4000
 ;;subs (14-25) 125-12000 L A&B
 F P=1:1:12 D  ;start L A
 .S ACKQN=ACKQN+1 ;counter sub for array
 .S X=$S(P=1:125,P=2:250,P=3:500,P=4:750,P=5:1000,P=6:1500,1:"")
 .S:X="" X=$S(P=7:2000,P=8:3000,P=9:4000,P=10:6000,P=11:8000,1:12000)
 .S ACKQA(ACKQN)=X_U_"L"_U_"" ; X^ear^IEN^Y
 .S $P(ACKQA(ACKQN),U,4)=$P($G(^ACK(509850.9,ACKQRMI,30)),U,P) ;1st value
 .S $P(ACKQA(ACKQN),U,5)=$P($G(^ACK(509850.9,ACKQRMI,31)),U,P) ;1st tag(lv for now)
 .S $P(ACKQA(ACKQN),U,6)=$P($G(^ACK(509850.9,ACKQRMI,60)),U,P) ;1st mlev
 .S $P(ACKQA(ACKQN),U,12)=$P($G(^ACK(509850.9,ACKQRMI,40)),U,P) ;final val
 .S $P(ACKQA(ACKQN),U,13)=$P($G(^ACK(509850.9,ACKQRMI,41)),U,P) ;f tag(lv for now)
 .S $P(ACKQA(ACKQN),U,14)=$P($G(^ACK(509850.9,ACKQRMI,61)),U,P) ;f mlev
 .;L ear bone conduction
 .I X>125,X<7000 D
 ..S P1=P-1 ;125 not a bone reading so pc's 1 less
 ..S $P(ACKQA(ACKQN),U,7)=$P($G(^ACK(509850.9,ACKQRMI,80)),U,P1) ;1st val
 ..S $P(ACKQA(ACKQN),U,8)=$P($G(^ACK(509850.9,ACKQRMI,81)),U,P1) ;1st tag(lv for now)
 ..S $P(ACKQA(ACKQN),U,9)=$P($G(^ACK(509850.9,ACKQRMI,100)),U,P1) ;1st mlev
 ..S $P(ACKQA(ACKQN),U,15)=$P($G(^ACK(509850.9,ACKQRMI,85)),U,P1) ;final val
 ..S $P(ACKQA(ACKQN),U,16)=$P($G(^ACK(509850.9,ACKQRMI,86)),U,P1) ;f tag(lv for now)
 ..S $P(ACKQA(ACKQN),U,17)=$P($G(^ACK(509850.9,ACKQRMI,101)),U,P1) ;f mlev
 .; IAR/CAR AR-DECAY AR-HL
 .S S0=$G(^ACK(509850.9,ACKQRMI,121))
 .I (X=500) D
 ..S $P(ACKQA(ACKQN),U,10)=$P(S0,U,4) ;L IAR 500
 ..S $P(ACKQA(ACKQN),U,11)=$P(S0,U,8) ;L CAR 500
 ..S $P(ACKQA(ACKQN),U,18)=$P(S0,U,12) ;L AR decay 500
 ..S $P(ACKQA(ACKQN),U,19)=$P(S0,U,14) ;L AR HL 500
 .I (X=1000) D
 ..S $P(ACKQA(ACKQN),U,10)=$P(S0,U,5) ;L IAR 1000
 ..S $P(ACKQA(ACKQN),U,11)=$P(S0,U,9) ;L CAR 1000
 ..S $P(ACKQA(ACKQN),U,18)=$P(S0,U,13) ;L AR decay 1000
 ..S $P(ACKQA(ACKQN),U,19)=$P(S0,U,15) ;L AR HL 1000
 .I (X=2000) D
 ..S $P(ACKQA(ACKQN),U,10)=$P(S0,U,6) ;L IAR 2000
 ..S $P(ACKQA(ACKQN),U,11)=$P(S0,U,10) ;L CAR 2000
 .I (X=4000) D
 ..S $P(ACKQA(ACKQN),U,10)=$P(S0,U,7) ;L IAR 4000
 ..S $P(ACKQA(ACKQN),U,11)=$P(S0,U,11) ;L CAR 4000
 S ACKQN=ACKQN+1 ;sub(26) R Sp
 S ACKQA(ACKQN)="WDL^R^"_$G(^ACK(509850.9,ACKQRMI,110))
 S ACKQN=ACKQN+1 ;subscript(27) L Sp
 S ACKQA(ACKQN)="WDL^L^"_$G(^ACK(509850.9,ACKQRMI,111))
 S $P(ACKQA(ACKQN),U,1)="WDL",$P(ACKQA(ACKQN),U,2)="L"
 S ACKQN=ACKQN+1 ;sub(28) R&L PTA,MCL,UCL,tymp type
 S ACKQA(ACKQN)="PTA^B^"_$G(^ACK(509850.9,ACKQRMI,1))
 S S0=$G(^ACK(509850.9,ACKQRMI,120)) D  ;add 3 pcs to (28)
 .S $P(ACKQA(ACKQN),U,15)=$P(S0,U,1) ;middle ear pres R
 .S $P(ACKQA(ACKQN),U,16)=$P(S0,U,2) ;pk immit 226 R
 .S $P(ACKQA(ACKQN),U,17)=$P(S0,U,16) ;int test consis R
 S S0=$G(^ACK(509850.9,ACKQRMI,121)) D  ;add 3 more pcs to (28)
 .S $P(ACKQA(ACKQN),U,18)=$P(S0,U,1) ;middle ear pres L
 .S $P(ACKQA(ACKQN),U,19)=$P(S0,U,2) ;pk immit 226 L
 .S $P(ACKQA(ACKQN),U,20)=$P(S0,U,16) ;int tst consis L
 S ACKQN=ACKQN+1 ;sub(29) R&L SRT,PIPB
 S ACKQA(ACKQN)="SRT^B^"_$G(^ACK(509850.9,ACKQRMI,115)) ;16+2 pcs
 S ACKQN=ACKQN+1 ;sub(30) R A retest
 S ACKQA(ACKQN)="RTSTR^R^"_$G(^ACK(509850.9,ACKQRMI,15)) ;11+2 pcs
 S ACKQN=ACKQN+1 ;sub(31) L A retest
 S ACKQA(ACKQN)="RTSTL^L^"_$G(^ACK(509850.9,ACKQRMI,35)) ;11+2 pcs
 S ACKQN=ACKQN+1 ;sub(32) R B retest
 S ACKQA(ACKQN)="RTSTRB^R^"_$G(^ACK(509850.9,ACKQRMI,72)) ;9+2 pcs
 S ACKQN=ACKQN+1 ;sub(33) L B retest
 S ACKQA(ACKQN)="RTSTLB^L^"_$G(^ACK(509850.9,ACKQRMI,82)) ;9+2 pcs
 S ACKQN=ACKQN+1 ;sub(34) R AI & word node
 S ACKQA(ACKQN)="RAI^R^"_$G(^ACK(509850.9,ACKQRMI,120)) ;23+2 pcs
 S ACKQN=ACKQN+1 ;sub(35) L AI & word node
 S ACKQA(ACKQN)="LAI^L^"_$G(^ACK(509850.9,ACKQRMI,121)) ;23+2 pcs
 D COMMTS
 Q
WRTERR ;
 I $L($G(ACKQE)) D
 .S $P(ACKQA(1),U,5)=ACKQE
 Q
COMMTS ;add comments to transmit
 ;INPUT ACKQRMI,ACKQN
 Q:'$D(^ACK(509850.9,ACKQRMI,122))  Q:'$O(^ACK(509850.9,ACKQRMI,122,0))
 N C,X S C=0
C1 S C=$O(^ACK(509850.9,ACKQRMI,122,C)) Q:'C  D
 .S ACKQN=ACKQN+1,X=$G(^ACK(509850.9,ACKQRMI,122,C,0))
 .S X=$TR(X,"^","")
 .S ACKQA(ACKQN)="COM^"_C_U_X
 G C1
