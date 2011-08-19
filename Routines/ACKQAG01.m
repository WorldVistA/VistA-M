ACKQAG01        ;DDC/PJU - Get data for Audiogram(s) Display from 509850.9 ;07/13/05
 ;;3.0;QUASAR AUDIOMETRIC MODULE;**3,12**;11/01/02
 ;input: ref to array and DFN. See ACKQAG.txt for information
START(ACKQARR,DFN,IEN)   ;;array name(.reference) and pointer to Patient file (#2)
 ;include IEN in 509850.9 if specific one, otherwise put 0 for last one
 ; see ACKQAG.txt for descriptions
 K ACKQARR ;make sure it starts empty
 N ACKT,BD,CL,S0,S1,SSN,TD,TT,TU,J2
 S (ACKQARR(0),ACKI,ACKQ)=0
 S ACKQERR="" F X=1:1:33 S ACKQARR(X)=""
 I '$D(^ACK(509850.9,0)) D  G END
 .S ACKQERR="**ERROR** QUASAR file 509850.9 (Audiometric Exam Data file) is not available"
 I '$G(DFN) D  G END
 .S ACKQERR="**ERROR** Must have a DFN for Display "
 I '$D(^ACK(509850.9,"DFN",DFN)) D  G END
 .S ACKQERR="**ERROR** patient not in audiogram file"
 D DEM^VADPT ; - demographic variables
 I $G(VAERR) S ACKQERR="**ERROR** Problem in retrieving Demographic values" G END
 S SSN=$P(VADM(2),U,1),BD=VADM(3)
 S ACKQDAT="A",ACKQ1IEN=""
 I $G(IEN) D  G S3
 .S (ACKQ1IEN,ACKQI)=IEN
 .S ACKQDAT=$P($G(^ACK(509850.9,IEN,0)),U,1)
 .S ACKQ=1
S1 S ACKQDAT=$O(^ACK(509850.9,"DFN",DFN,ACKQDAT),-1) ;get last IEN
 I 'ACKQ,'ACKQDAT D  G END
 .S ACKQERR="**ERROR** No current audiograms for patient in file"
 I ACKQ=1,'ACKQDAT G E1 ;only 1
 I ACKQ>0 S ACKI=ACKI+1 ;
 S ACKQI=0
S2 S ACKQI=$O(^ACK(509850.9,"DFN",DFN,ACKQDAT,ACKQI))
 I 'ACKQ,'ACKQI G S1
 G:'ACKQI S1
 ;W !,"Entry number found: ",ACKQI ;for testing
 I '$D(^ACK(509850.9,ACKQI,0)) D  G END
 .S ACKQERR="**ERROR** Node missing in file for this visit"
 S ACKQ=ACKQ+1 ;set flag # of Auds
S3 ;
 S S0=$G(^ACK(509850.9,ACKQI,0))
 I $P(S0,U,2)'=DFN D  G END
 .S ACKQERR="***URGENT** Actual Patient in Exam File entry:"_ACKQI_" is different than DFN cross-ref, notify IRM"
 I ACKQ=1 D  G:'$G(IEN) S2 G:$G(IEN) E1
 .S ACKQ1IEN=ACKQI,TD=$P(S0,U,1)
 .S X=$P($$FMTE^XLFDT(TD),"@",1)
 .S ACKQARR(0)=1_U_VADM(1)_U_X ;initial setup
 .I $P(S0,U,3) D  ;DUZ of tester
 ..S TU=$P(S0,U,3) D:TU>0
 ...S TT=$$TITLE(TU)
 ...S $P(ACKQARR(0),U,4)=$P(TT,U,1) ;tester1 name
 ...S $P(ACKQARR(0),U,6)=$P(TT,U,2) ;title
 .S $P(ACKQARR(0),U,5)=$P(S0,U,5) ;DFN age
 .S $P(ACKQARR(0),U,7)=SSN
 .S S1=$P(S0,U,10) D:S1
 ..K AK S DIC=4,DA=S1,DIQ="AK",DR=".01" D EN^DIQ1 ;
 ..S $P(ACKQARR(33),U,12)=AK(4,S1,.01) ;Sta name
 ..K AK,DIC,DA,DIQ,DR
 .S CL=$P(S0,U,14)
 .S $P(ACKQARR(33),U,11)=CL ;claim #
 .D GETDATA^ACKQAG06(ACKQI,.ACKI) ;fill air/bone & other nodes
 .S ACKT=ACKQ1IEN ;fill (26)
 .S S0=$G(^ACK(509850.9,ACKT,120)) ;R AI node
 .F X=1:1:15 S $P(ACKQARR(26),U,X)=$P(S0,U,X)
 .;PUT R EAR BBNs * IMMIT 678 HERE *****
 .S $P(ACKQARR(26),U,31)=$P(S0,U,17) ;R IAR BBN
 .S $P(ACKQARR(26),U,32)=$P(S0,U,18) ;R CAR BBN
 .S $P(ACKQARR(26),U,33)=$P(S0,U,19) ;R PkIm678
 .S S0=$G(^ACK(509850.9,ACKT,121)) ;L AI node
 .F X=1:1:15 S $P(ACKQARR(26),U,(X+15))=$P(S0,U,X)
 .;PUT L EAR BBNs * IMMIT 678 HERE ***
 .S $P(ACKQARR(26),U,34)=$P(S0,U,17) ;L IAR BBN
 .S $P(ACKQARR(26),U,35)=$P(S0,U,18) ;L CAR BBN
 .S $P(ACKQARR(26),U,36)=$P(S0,U,19) ;L PkIm678
 .;Modify (24) 12000 not used in 2364 display or 2364
 .S S0=$G(^ACK(509850.9,ACKT,110)),J=4 ;R speech
 .F X=6:5:26 D  ;6,11,16,21,26
 ..S J=J+1,$P(ACKQARR(24),U,J)=$P(S0,U,X) ;pre lev R
 ..S J=J+1,$P(ACKQARR(24),U,J)=$P(S0,U,(X+1)) ;mask lev R
 .S S0=$G(^ACK(509850.9,ACKT,111)) ;L speech
 .F X=6:5:26 D  ;6,11,16,21,26
 ..S J=J+1,$P(ACKQARR(24),U,J)=$P(S0,U,X) ;pre lev L
 ..S J=J+1,$P(ACKQARR(24),U,J)=$P(S0,U,(X+1)) ;mask lev L
 .S S0=$G(^ACK(509850.9,ACKT,1)),J=24
 .F X=5,3,1 D  ;R AVG'S 4,3,2
 ..S J=J+1,$P(ACKQARR(24),U,J)=$P(S0,U,X)
 .F X=6,4,2 D  ;L AVG'S 4,3,2
 ..S J=J+1,$P(ACKQARR(24),U,J)=$P(S0,U,X)
 .S $P(ACKQARR(33),U,9)=$P(S0,U,11) ;TYMP TYPE R
 .S $P(ACKQARR(33),U,10)=$P(S0,U,12) ;TYMP TYPE L
COM .F X=30,31,32 S ACKQARR(X)="" ;COMMENTS LINES
 .I $D(^ACK(509850.9,ACKT,122)) S X1="" D
 ..Q:'$D(^ACK(509850.9,ACKT,122,1,0))  S X1=$G(^(0))
 ..I $L(X1) D
 ...S ACKQARR(30)=$E(X1,1,110),X1=$E(X1,111,350)
 ...S:$L(X1) ACKQARR(31)=$E(X1,1,110)_" ",X1=$E(X1,111,350)
 ...S:$L(X1) ACKQARR(32)=$E(X1,1,110)_" "
 ..Q:$L(ACKQARR(32))>105
 ..Q:'$D(^ACK(509850.9,ACKT,122,2,0))  S X1=$G(^(0))
 ..I $L(X1) D
 ...S Z1=$L(ACKQARR(30))
 ...I Z1<108 S ACKQARR(30)=ACKQARR(30)_$E(X1,1,110-Z1)_" ",X1=$E(X1,111-Z1,350)
 ...S Z1=$L(ACKQARR(31)) I Z1<108,$L(X1) D
 ....S ACKQARR(31)=ACKQARR(31)_$E(X1,1,110-Z1)_" ",X1=$E(X1,111-Z1,350)
 ...S Z1=$L(ACKQARR(32)) I $L(X1),Z1<110 D
 ....S ACKQARR(32)=ACKQARR(32)_$E(X1,1,110-Z1)
 ..Q:$L(ACKQARR(32))>105
 ..Q:'$D(^ACK(509850.9,ACKT,122,3,0))  S X1=$G(^(0))
 ..I $L(X1) D
 ...S Z1=$L(ACKQARR(30))
 ...I Z1<108 S ACKQARR(30)=ACKQARR(30)_$E(X1,1,110-Z1)_" ",X1=$E(X1,111-Z1,350)
 ...S Z1=$L(ACKQARR(31)) I Z1<108,$L(X1) D
 ....S ACKQARR(31)=ACKQARR(31)_$E(X1,1,110-Z1)_" ",X1=$E(X1,111-Z1,350)
 ...S Z1=$L(ACKQARR(32)) I $L(X1),Z1<108 D
 ....S ACKQARR(32)=ACKQARR(32)_$E(X1,1,110-Z1)
 ..Q:$L(ACKQARR(32))>105
 ..Q:'$D(^ACK(509850.9,ACKT,122,4,0))  S X1=$G(^(0))
 ..I $L(X1) D
 ...S Z1=$L(ACKQARR(30))
 ...I Z1<108 S ACKQARR(30)=ACKQARR(30)_$E(X1,1,110-Z1)_" ",X1=$E(X1,111-Z1,350)
 ...S Z1=$L(ACKQARR(31)) I Z1<108,$L(X1) D
 ....S ACKQARR(31)=ACKQARR(31)_$E(X1,1,110-Z1)_" ",X1=$E(X1,111-Z1,350)
 ...S Z1=$L(ACKQARR(32)) I $L(X1),Z1<108 D 
 ....S ACKQARR(32)=ACKQARR(32)_$E(X1,1,110-Z1)
E1 ;for patch 12 add fin readings for display 2364
 ;sub retest for fin if fin="" for table
 S S0=$G(^ACK(509850.9,ACKT,20)) ;fin A test R
 S J=0 F P=2,3,5:1:11 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(12),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,75)) ;fin B test R
 F P=1,2,4:1:8 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(12),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,40)) ;fin A test L
 F P=2,3,5:1:11 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(12),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,85)) ;fin B test L
 F P=1,2,4:1:8 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(12),U,J)=X
E2 ;for patch 12 add init readings for disp of 2364
 S S0=$G(^ACK(509850.9,ACKT,10)) ;1 air test R
 S J=0 F P=2,3,5:1:11 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(27),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,70)) ;1 bone test R
 F P=1,2,4:1:8 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(27),U,J)=X
 ;
 S S0=$G(^ACK(509850.9,ACKT,15)) ;retest A R
 S J=0 F P=2,3,5:1:11 S X=$P(S0,U,P),J=J+1 D:(X'="")
 .I $P(ACKQARR(27),U,J)="" S $P(ACKQARR(27),U,J)=X ;sub for init R A
 .E  I $P(ACKQARR(27),U,J)["+",X'["+" S $P(ACKQARR(27),U,J)=X
 .E  I X<$P(ACKQARR(27),U,J) S $P(ACKQARR(27),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,72)) ;retest bone R
 F P=1,2,4:1:8 S X=$P(S0,U,P),J=J+1 D:(X'="")
 .I $P(ACKQARR(27),U,J)="" S $P(ACKQARR(27),U,J)=X ;sub for init R B
 .E  I $P(ACKQARR(27),U,J)["+",X'["+" S $P(ACKQARR(27),U,J)=X
 .E  I X<$P(ACKQARR(27),U,J) S $P(ACKQARR(27),U,J)=X
 S J2=J ;save j for start of L
 S S0=$G(^ACK(509850.9,ACKT,30)) ;1st A test L
 F P=2,3,5:1:11 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(27),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,80)) ;1st B test L
 F P=1,2,4:1:8 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(27),U,J)=X
 S J=J2 ;reset j to start of L ear & sub
 S S0=$G(^ACK(509850.9,ACKT,35)) ;retest A L
 F P=2,3,5:1:11 S X=$P(S0,U,P),J=J+1 D:(X'="")
 .I $P(ACKQARR(27),U,J)="" S $P(ACKQARR(27),U,J)=X ;sub for 1st L A
 .E  I $P(ACKQARR(27),U,J)["+",X'["+" S $P(ACKQARR(27),U,J)=X
 .E  I X<$P(ACKQARR(27),U,J) S $P(ACKQARR(27),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,82)) ;retest B L
 F P=1,2,4:1:8 S X=$P(S0,U,P),J=J+1 D:(X'="")
 .I $P(ACKQARR(27),U,J)="" S $P(ACKQARR(27),U,J)=X ;sub for 1st L B
 .E  I $P(ACKQARR(27),U,J)["+",X'["+" S $P(ACKQARR(27),U,J)=X
 .E  I X<$P(ACKQARR(27),U,J) S $P(ACKQARR(27),U,J)=X
E3 ;for patch 12 add init tag for disp of 2364
 S S0=$G(^ACK(509850.9,ACKT,11)) ;1st A tag R
 S J=0 F P=2,3,5:1:11 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(28),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,71)) ;1st B tag R
 F P=1,2,4:1:8 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(28),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,31)) ;1st A tag L
 F P=2,3,5:1:11 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(28),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,81)) ;1st B tag L
 F P=1,2,4:1:8 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(28),U,J)=X
E4 ;for patch 12 add final tag for display of 2364
 S S0=$G(^ACK(509850.9,ACKT,21)) ;final A tag R
 S J=0 F P=2,3,5:1:11 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(29),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,76)) ;final B tag R
 F P=1,2,4:1:8 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(29),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,41)) ;final A tag L
 F P=2,3,5:1:11 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(29),U,J)=X
 S S0=$G(^ACK(509850.9,ACKT,86)) ;final B tag L
 F P=1,2,4:1:8 S X=$P(S0,U,P),J=J+1,$P(ACKQARR(29),U,J)=X
E5 ;for patch 12 add OTHER TESTS score values
 S S0=$G(^ACK(509850.9,ACKT,120)) ;Oth Tests R
 F P=1:1:4 S $P(ACKQARR(33),U,P)=$P(S0,U,P+19)
 S S0=$G(^ACK(509850.9,ACKT,121)) ;Oth Tests L
 F P=1:1:4 S $P(ACKQARR(33),U,P+4)=$P(S0,U,P+19)
END ;if 0-1 charts and errors, then kill 1st, & pass error
 I $G(ACKQERR)'="",$G(ACKQ)=1 D  D WRTERR
 .S $P(ACKQARR(0),U,1)=0 F J=3:1:11 S $P(ACKQARR(0),U,J)=""
 .F ACKI=1:1:33 S ACKQARR(ACKI)=""
 K ACKI,ACKQERR,ACKQDAT,ACKQ,ACKQI,ACKQ1IEN,J,X
 Q
WRTERR ; Record error & write out if testing
 I $L($G(ACKQERR)) D
 .;W !!,?10,ACKQERR ;direct call testing
 .S $P(ACKQARR(0),U,8)=ACKQERR ;error for displ in Delphi
 Q
TITLE(ACKUSER)     ;input DUZ returns printable name and title
 N T1,T2,ACK,DIC,DA,DR,DIQ S (T1,T2)="Unknown"  G:'$G(ACKUSER) ENDT
 S DIC=200,DA=ACKUSER,DIQ="ACK",DR=".01;8" D EN^DIQ1
 S T1=$G(ACK(200,ACKUSER,.01))
 S T2=$G(ACK(200,ACKUSER,8))
 S:T1="" T1="Unknown" S:T2="" T2="Unknown"
ENDT Q T1_U_T2
