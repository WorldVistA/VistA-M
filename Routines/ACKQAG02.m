ACKQAG02        ;DDC/PJU - Module to get data for Audiogram E/E and Transmit to DDC ;07/21/05
 ;;3.0;QUASAR AUDIOMETRIC MODULE;**3,12**;11/01/02
 ;input: ref to array and DFN
 ;return: array of VALUES in ACKQARR, ACKQERR if an error was found
 ;Called by RPC ACKQAUD2
 ;Used by the the E/E - One Audiogram at a time
 ;IEN needed in 1st pc for the Enter/edit program
 ;ACKQARR(1)=audiogram local ien^name of patient^last date seen^tester1^error msg
 ;ACKQARR(ctr)=pcs in rest of counter nodes
 ; 1=Xvalue
 ; 2=ear[L,R]
 ; 3=
 ; 4=iAirY
 ; 5=iAirMask[0-6]-not used in 3*12
 ; 6=iAirMaskL
 ; 7=iBoneY
 ; 8=iBoneMask[0-1]-not used in 3*12
 ; 9=iBoneMaskL
 ; 10=IAR
 ; 11=CAR
 ; 12=fAirY
 ; 13=fAirMask[0-6]-not used in 3*12
 ; 14=fAirMaskL
 ; 15=fBoneY
 ; 16=fBoneMask[0-1]-not used in 3*12
 ; 17=fBoneMaskL
 ; 18=AR DECAY
 ; 19=HALF LF
 ;will return to the Delphi app as subscripted array
 ;subscripts: 1(gen), 2-13(R), 14-25(L), 26(gen)
START(ACKQARR,DFN)   ;
 K ACKQERR
 ;ACKQN is a number counter, S0 is a node holder
 ;ACKQERR is an error holder
 ;ACKQFMD hold dates, ACKQ1IEN  holds the entry number
 I '$G(DFN) D  G END
 .S ACKQERR="**ERROR** Must have a DFN to run routine RMPFRPC2 "
 I '$D(^ACK(509850.9,0)) D  G END
 .S ACKQERR="**ERROR** QUASAR file 509850.9 (Audiometric Exam Data file) is not available"
 ;look up DFN in file
 I '$D(^ACK(509850.9,"DFN",DFN)) D  G END
 .S ACKQERR="**ERROR** patient not in audiogram file"
 ;determine if 1 or 2 audiograms - set flag
 S ACKQFMD="A",ACKQ1IEN=""
S1 S ACKQFMD=$O(^ACK(509850.9,"DFN",DFN,ACKQFMD),-1)
 ;set up array for latest one in file
 I 'ACKQFMD D  G END
 .S ACKQERR="**ERROR** No current audiograms for patient in file"
 S ACKQIEN=0
S2 S ACKQIEN=$O(^ACK(509850.9,"DFN",DFN,ACKQFMD,ACKQIEN))
 I 'ACKQIEN D  G S1
 .S ACKQERR="**ERROR** No data exists for visit on "_$$FMTE^XLFDT(ACKQFMD)
 I '$D(^ACK(509850.9,ACKQIEN,0)) D  G S1
 .S ACKQERR="**ERROR** Node missing in file for this visit"
 G EN2 ;to skip following line
EN(ACKQARR,ACKQIEN,DFN) ;
EN2 ;from S2
 N ACK,ACKD,ACKDF,ACKT
 S ACKQARR(1)=0 ;default
 K ACKQERR F I=2:1:25 S ACKQARR(I)=""
 S S0=$S(ACKQIEN="":"",1:$G(^ACK(509850.9,ACKQIEN,0))) ;HD63875
 I S0="" S ACKQFMD="A" G S1 ;HD63875
 I $P(S0,U,2)'=DFN D  G S2 ;should be already checked in calling routine
 .S ACKQERR="***URGENT ERROR*** File error - wrong DFN in xref DFN or record: "_DFN
 S DIC=2,DA=DFN,DIQ="AK",DR=".01" D EN^DIQ1 S ACKD=AK(2,DFN,.01) ;DFN name
 K DIC,DA,DIQ,DR,AK
 ;(1)=ien^patient^FM date seen^tester
 S ACKDF=$P(^ACK(509850.9,ACKQIEN,0),U,1)
 S ACKQARR(1)=ACKQIEN_U_ACKD_U_ACKDF
 I '$P(S0,U,3) S $P(ACKQARR(1),U,4)="Unknown"
 E  D
 .S Y=$P(S0,U,3),X=$$TITLE^ACKQAG01(Y) K Y
 .S $P(ACKQARR(1),U,4)=$P(X,U,1) ;tester name
 D GETDATA(ACKQIEN)
END ;if errors, then handle errors and stop
 S:'$D(ACKQARR(1)) ACKQARR(1)=0
 I $G(ACKQERR)'="" D  D WRTERR ;5th pc of 0 node is err msg
 .F I=2:1:25 S ACKQARR(I)=""
 K ACKQERR,ACKQFMD,I,S0
 Q
 ;
GETDATA(ACKQIEN)    ;
 ;input the entry number in the Audiometic Exam Data file (ACKQIEN)
 ;and current return array subscript value(ACKQN)
 N ACKQA1,ACKQA2,ACKQA1T,ACKQA2T,ACKQA1L,ACKQA2L ;air initial & repeat values, air tags initial & repeat, air Mask Levels
 N ACKQB1,ACKQB2,ACKQB1T,ACKQB2T,ACKQB1L,ACKQB2L ;bone initial & repeat values, bone masking init & repeat
 N P,P1 ;P is the piece of the air nodes, P1 is the piece of the bone nodes
 N X ;X is the Hz
 S ACKQN=1 ;counter subscript for array - subsc 1 filled in above
 ;START R ear
 ; Air
 F P=1:1:12 D  ;set pcs in ACKQARR node
 .S ACKQN=ACKQN+1
 .S X=$S(P=1:125,P=2:250,P=3:500,P=4:750,P=5:1000,P=6:1500,P=7:2000,1:"")
 .S:X="" X=$S(P=8:3000,P=9:4000,P=10:6000,P=11:8000,P=12:12000,1:"")
 .S ACKQARR(ACKQN)=X_U_"R"_U_"" ;X^ear^ien^Y
 .S ACKQA1=$P($G(^ACK(509850.9,ACKQIEN,10)),U,P) ;init Y val
 .S ACKQA1T=$P($G(^ACK(509850.9,ACKQIEN,11)),U,P) ;init tag
 .S ACKQA1L=$P($G(^ACK(509850.9,ACKQIEN,50)),U,P) ;init tag level
 .S ACKQA2=$P($G(^ACK(509850.9,ACKQIEN,20)),U,P) ;repeat val
 .S ACKQA2T=$P($G(^ACK(509850.9,ACKQIEN,21)),U,P) ;repeat tag
 .S ACKQA2L=$P($G(^ACK(509850.9,ACKQIEN,51)),U,P) ;repeat tag level
 .S $P(ACKQARR(ACKQN),U,4)=ACKQA1,$P(ACKQARR(ACKQN),U,5)=ACKQA1T ;default
 .S $P(ACKQARR(ACKQN),U,6)=ACKQA1L,$P(ACKQARR(ACKQN),U,12)=ACKQA2
 .S $P(ACKQARR(ACKQN),U,13)=ACKQA2T,$P(ACKQARR(ACKQN),U,14)=ACKQA2L
 .; bone conduction
 .I X>125,X<7000 D
 ..S P1=P-1 ;125 not a bone reading so pc's 1 less
 ..S ACKQB1=$P($G(^ACK(509850.9,ACKQIEN,70)),U,P1) ;init bone
 ..S ACKQB1T=$P($G(^ACK(509850.9,ACKQIEN,71)),U,P1) ;init bone TAG
 ..S ACKQB1L=$P($G(^ACK(509850.9,ACKQIEN,90)),U,P1) ;init bone level
 ..S ACKQB2=$P($G(^ACK(509850.9,ACKQIEN,75)),U,P1) ;repeat bone
 ..S ACKQB2T=$P($G(^ACK(509850.9,ACKQIEN,76)),U,P1) ;repeat bone TAG
 ..S ACKQB2L=$P($G(^ACK(509850.9,ACKQIEN,91)),U,P1) ;repeat bone mask
 ..S $P(ACKQARR(ACKQN),U,7)=ACKQB1,$P(ACKQARR(ACKQN),U,8)=ACKQB1T
 ..S $P(ACKQARR(ACKQN),U,9)=ACKQB1L,$P(ACKQARR(ACKQN),U,15)=ACKQB2
 ..S $P(ACKQARR(ACKQN),U,16)=ACKQB2T,$P(ACKQARR(ACKQN),U,17)=ACKQB2L
 .;IAR/CAR AR-DECAY AR-HALFLIFE
 .I (X=500) D
 ..S $P(ACKQARR(ACKQN),U,10)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,4)
 ..S $P(ACKQARR(ACKQN),U,11)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,8)
 ..S $P(ACKQARR(ACKQN),U,18)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,12)
 ..S $P(ACKQARR(ACKQN),U,19)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,14)
 .I (X=1000) D
 ..S $P(ACKQARR(ACKQN),U,10)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,5)
 ..S $P(ACKQARR(ACKQN),U,11)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,9)
 ..S $P(ACKQARR(ACKQN),U,18)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,13)
 ..S $P(ACKQARR(ACKQN),U,19)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,15)
 .I (X=2000) D
 ..S $P(ACKQARR(ACKQN),U,10)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,6)
 ..S $P(ACKQARR(ACKQN),U,11)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,10)
 .I (X=4000) D
 ..S $P(ACKQARR(ACKQN),U,10)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,7)
 ..S $P(ACKQARR(ACKQN),U,11)=$P($G(^ACK(509850.9,ACKQIEN,120)),U,11)
 ;start L ear
 ; air
 F P=1:1:12 D
 .S ACKQN=ACKQN+1 ;counter subscript for array
 .S X=$S(P=1:125,P=2:250,P=3:500,P=4:750,P=5:1000,P=6:1500,1:"")
 .S:X="" X=$S(P=7:2000,P=8:3000,P=9:4000,P=10:6000,P=11:8000,1:12000)
 .S ACKQARR(ACKQN)=X_U_"L"_U_"" ; X^ear^IEN^Y
 .S ACKQA1=$P($G(^ACK(509850.9,ACKQIEN,30)),U,P) ;initial read null
 .S ACKQA1T=$P($G(^ACK(509850.9,ACKQIEN,31)),U,P) ;init tag
 .S ACKQA1L=$P($G(^ACK(509850.9,ACKQIEN,60)),U,P) ;init level
 .S ACKQA2=$P($G(^ACK(509850.9,ACKQIEN,40)),U,P) ;repeat val
 .S ACKQA2T=$P($G(^ACK(509850.9,ACKQIEN,41)),U,P) ;repeat tag
 .S ACKQA2L=$P($G(^ACK(509850.9,ACKQIEN,61)),U,P) ;repeat level
 .S $P(ACKQARR(ACKQN),U,4)=ACKQA1,$P(ACKQARR(ACKQN),U,5)=ACKQA1T
 .; bone conduction
 .I X>125,X<7000 D
 ..S P1=P-1 ;125 not a bone reading so pc's 1 less
 ..S ACKQB1=$P($G(^ACK(509850.9,ACKQIEN,80)),U,P1) ;init val
 ..S ACKQB1T=$P($G(^ACK(509850.9,ACKQIEN,81)),U,P1) ;init tag
 ..S ACKQB1L=$P($G(^ACK(509850.9,ACKQIEN,100)),U,P1) ;init mask level
 ..S ACKQB2=$P($G(^ACK(509850.9,ACKQIEN,85)),U,P1) ;repeat val
 ..S ACKQB2T=$P($G(^ACK(509850.9,ACKQIEN,86)),U,P1) ;repeat tag
 ..S ACKQB2L=$P($G(^ACK(509850.9,ACKQIEN,101)),U,P1) ;repeat mask level
 ..S $P(ACKQARR(ACKQN),U,7)=ACKQB1,$P(ACKQARR(ACKQN),U,8)=ACKQB1T ;default
 ..S $P(ACKQARR(ACKQN),U,9)=ACKQB1L,$P(ACKQARR(ACKQN),U,15)=ACKQB2
 ..S $P(ACKQARR(ACKQN),U,16)=ACKQB2T,$P(ACKQARR(ACKQN),U,17)=ACKQB2L
 .; IAR/CAR AR-DECAY AR-HALFLIFE
 .I (X=500) D
 ..S $P(ACKQARR(ACKQN),U,10)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,4)
 ..S $P(ACKQARR(ACKQN),U,11)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,8)
 ..S $P(ACKQARR(ACKQN),U,18)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,12)
 ..S $P(ACKQARR(ACKQN),U,19)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,14)
 .I (X=1000) D
 ..S $P(ACKQARR(ACKQN),U,10)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,5)
 ..S $P(ACKQARR(ACKQN),U,11)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,9)
 ..S $P(ACKQARR(ACKQN),U,18)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,12)
 ..S $P(ACKQARR(ACKQN),U,19)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,14)
 .I (X=2000) D
 ..S $P(ACKQARR(ACKQN),U,10)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,6)
 ..S $P(ACKQARR(ACKQN),U,11)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,10)
 .I (X=4000) D
 ..S $P(ACKQARR(ACKQN),U,10)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,7)
 ..S $P(ACKQARR(ACKQN),U,11)=$P($G(^ACK(509850.9,ACKQIEN,121)),U,11)
 Q
 ;
WRTERR ;
 I $L($G(ACKQERR)) D
 .S $P(ACKQARR(1),U,5)=ACKQERR ;
 ;W !!,?10,ACKQERR ;used for direct call testing
 Q
