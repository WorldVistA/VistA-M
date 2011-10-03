ACKQAG06        ;DDC/PJU - AUDIOGRAM UTILITY FOR ACKQAG01 ;7/13/05
 ;;3.0;QUASAR AUDIOMETRIC MODULE;**3,12**;11/01/02
GETDATA(ACKQI,ACKI)    ;called from ACKQAG01- Puts values in ACKQARR()
 ;input the entry number in the Audiometic Exam Data file (ACKQI)
 ;and current return array subscript value by reference(.ACKI)
 ;ACKQA1=air initial threshold
 ;ACKQA2=air REPEAT THRESHOLD
 ;ACKQA3=air FINAL THRESHOLD
 ;ACKQAML=AIR MASK LEVEL
 ;ACKQB1=bone initial threshold
 ;ACKQB2=bone REPEAT THRESHOLD
 ;ACKQB3=bone FINAL THRESHOLD
 ;ACKQBML=bone MASK level
 ;P=piece of the air nodes, P1=piece of the bone nodes
 ;SB=Bone node, X is the Hz reading to start and then a string holding variable
 ;X1 is a string holding variable, I is an integer used for looping
 ;S0 is a node holder
 N ACKQA1,ACKQA2,ACKQA3,ACKQAML
 N ACKQB1,ACKQB2,ACKQB3,ACKQBML
 N I,P,P1,S0,SB,X,X1
RA F P=1:1:12 D  ;R ear Air
 .S (ACKQA1,ACKQA2,ACKQA3,ACKQAML,ACKQB1,ACKQB2,ACKQB3,ACKQBML)=""
 .S ACKI=ACKI+1 ;counter subscript for array
 .S X=$S(P=1:125,P=2:250,P=3:500,P=4:750,P=5:1000,P=6:1500,P=7:2000,1:"")
 .S:X="" X=$S(P=8:3000,P=9:4000,P=10:6000,P=11:8000,P=12:12000,1:"")
 .S ACKQARR(ACKI)=X_U_ACKQI_U_"R"_U Q:ACKI=12  ;12 node used for repeat test data
 .S ACKQA1=$P($G(^ACK(509850.9,ACKQI,10)),U,P) ;init val
 .S ACKQA2=$P($G(^ACK(509850.9,ACKQI,15)),U,P) ;RETEST val
 .S ACKQA3=$P($G(^ACK(509850.9,ACKQI,20)),U,P) ;FINAL val
 .S ACKQAML=$P($G(^ACK(509850.9,ACKQI,51)),U,P) ;MASK level
 .S:ACKQAML="CNM" ACKQAML=""
 .S $P(ACKQARR(ACKI),U,4)="" ;default air Y
 .S $P(ACKQARR(ACKI),U,5)="" ;default mask *** obsolete
 .S $P(ACKQARR(ACKI),U,6)="" ;default mask level
 .D LOGIC(ACKQA1,ACKQA2,ACKQA3,ACKQAML,"A") ;Air Conduction
RB .;
 .I X>125,X<7000 D  ;R bone conduction
 ..S P1=P-1 ;125 not a bone reading so pc's 1 less
 ..S ACKQB1=$P($G(^ACK(509850.9,ACKQI,70)),U,P1) ;init bone
 ..S ACKQB2=$P($G(^ACK(509850.9,ACKQI,72)),U,P1) ;RETEST bone
 ..S ACKQB3=$P($G(^ACK(509850.9,ACKQI,75)),U,P1) ;FINAL bone
 ..S ACKQBML=$P($G(^ACK(509850.9,ACKQI,91)),U,P1) ;bone MASK level
 ..S $P(ACKQARR(ACKI),U,7)="" ;default bone Y
 ..S $P(ACKQARR(ACKI),U,8)="" ;default mask *** obsolete
 ..S $P(ACKQARR(ACKI),U,9)="" ;default mask level
 ..D LOGIC(ACKQB1,ACKQB2,ACKQB3,ACKQBML,"B") ;bone conduction rules
RIAR .;IAR R
 .S SB=$G(^ACK(509850.9,ACKQI,120))
 .I (X=500) D
 ..S $P(ACKQARR(ACKI),U,10)=$P(SB,U,4) ;R IAR500
 .E  I (X=1000) D
 ..S $P(ACKQARR(ACKI),U,10)=$P(SB,U,5) ;R IAR1000
 .E  I (X=2000) D
 ..S $P(ACKQARR(ACKI),U,10)=$P(SB,U,6) ;R IAR2000
 .E  I (X=4000) D
 ..S $P(ACKQARR(ACKI),U,10)=$P(SB,U,7) ;R IAR4000
RCAR  .;CAR
 .S SB=$G(^ACK(509850.9,ACKQI,121))
 .I (X=500) D
 ..S $P(ACKQARR(ACKI),U,11)=$P(SB,U,8) ;R CAR500
 .E  I (X=1000) D
 ..S $P(ACKQARR(ACKI),U,11)=$P(SB,U,9) ;R CAR1000
 .E  I (X=2000) D
 ..S $P(ACKQARR(ACKI),U,11)=$P(SB,U,10) ;R CAR2000
 .E  I (X=4000) D
 ..S $P(ACKQARR(ACKI),U,11)=$P(SB,U,11) ;R CAR4000
 ;
LA F P=1:1:12 D  ;L ear air
 .S (ACKQA1,ACKQA2,ACKQA3,ACKQAML,ACKQB1,ACKQB2,ACKQB3,ACKQBML)=""
 .S ACKI=ACKI+1 ;counter subscript for array
 .S X=$S(P=1:125,P=2:250,P=3:500,P=4:750,P=5:1000,P=6:1500,P=7:2000,1:"")
 .S:X="" X=$S(P=8:3000,P=9:4000,P=10:6000,P=11:8000,P=12:12000,1:"")
 .S ACKQARR(ACKI)=X_U_ACKQI_U_"L"_U Q:ACKI=24  ;24 node used for speech test data
 .S ACKQA1=$P($G(^ACK(509850.9,ACKQI,30)),U,P) ;init val
 .S ACKQA2=$P($G(^ACK(509850.9,ACKQI,35)),U,P) ;RETEST val
 .S ACKQA3=$P($G(^ACK(509850.9,ACKQI,40)),U,P) ;FINAL val
 .S ACKQAML=$P($G(^ACK(509850.9,ACKQI,61)),U,P) ;MASK level
 .S:ACKQAML="CNM" ACKQAML=""
 .S $P(ACKQARR(ACKI),U,4)="" ;default air Y
 .S $P(ACKQARR(ACKI),U,5)="" ;default mask *** obsolete
 .S $P(ACKQARR(ACKI),U,6)="" ;default mask level
 .D LOGIC(ACKQA1,ACKQA2,ACKQA3,ACKQAML,"A") ;Air Conduction
 .;
LB .I X>125,X<7000 D  ;L bone conduction
 ..S P1=P-1 ;125 not a bone reading so pc's 1 less
 ..S ACKQB1=$P($G(^ACK(509850.9,ACKQI,80)),U,P1) ;init bone
 ..S ACKQB2=$P($G(^ACK(509850.9,ACKQI,82)),U,P1) ;RETEST bone
 ..S ACKQB3=$P($G(^ACK(509850.9,ACKQI,85)),U,P1) ;FINAL bone
 ..S ACKQBML=$P($G(^ACK(509850.9,ACKQI,101)),U,P1) ;bone MASK level
 ..S $P(ACKQARR(ACKI),U,7)="" ;default bone Y
 ..S $P(ACKQARR(ACKI),U,8)="" ;default mask *** obsolete
 ..S $P(ACKQARR(ACKI),U,9)="" ;default mask level
 ..D LOGIC(ACKQB1,ACKQB2,ACKQB3,ACKQBML,"B") ;bone conduction rules
LIAR .;IAR L
 .S SB=$G(^ACK(509850.9,ACKQI,121))
 .I (X=500) D
 ..S $P(ACKQARR(ACKI),U,10)=$P(SB,U,4) ;L IAR500
 .I (X=1000) D
 ..S $P(ACKQARR(ACKI),U,10)=$P(SB,U,5) ;L IAR1000
 .I (X=2000) D
 ..S $P(ACKQARR(ACKI),U,10)=$P(SB,U,6) ;L IAR2000
 .I (X=4000) D
 ..S $P(ACKQARR(ACKI),U,10)=$P(SB,U,7) ;L IAR4000
LCAR .;CAR L
 .S SB=$G(^ACK(509850.9,ACKQI,120))
 .I (X=500) D
 ..S $P(ACKQARR(ACKI),U,11)=$P(SB,U,8) ;L CAR500
 .I (X=1000) D
 ..S $P(ACKQARR(ACKI),U,11)=$P(SB,U,9) ;L CAR1000
 .I (X=2000) D
 ..S $P(ACKQARR(ACKI),U,11)=$P(SB,U,10) ;L CAR2000
 .I (X=4000) D
 ..S $P(ACKQARR(ACKI),U,11)=$P(SB,U,11) ;L CAR4000
SPCH ;next lines are only done 1 time for the table (2364)
 S ACKI=25 ;25 node- first 10 pc's are word %
 S S0=$G(^ACK(509850.9,ACKQI,110)) D  ;R speech
 .F I=1:1:5 S $P(ACKQARR(25),U,I)=$P(S0,U,(4+(5*(I-1))))
 ;S X="" F I=3:5:23 S X=$P(S0,U,I) Q:$L(X)
 S X=$P(S0,U,3)
 I $L(X) D
 .S X1="" I (X=3)!(X=6) S X1="CNC"
 .I (X=2)!(X=5) S X1="CIDW"
 .E  I (X=1)!(X=4) S X1="NU"
 .S:X1="" X1="OTHER"
 .S $P(ACKQARR(25),U,17)=X1 ;MATERIAL R
 ;S X="" F I=5:5:25 S X=$P(S0,U,I) Q:$L(X)
 S X=$P(S0,U,5)
 I $L(X) D
 .S X1="" I (X=1)!(X=2) S X1="REC"
 .I (X=3) S X1="MLV"
 .S $P(ACKQARR(25),U,18)=X1 ;PRES METH R
 ;
 S J=20,X="" F I=28:1:32 S X=$P(S0,U,I) D
 .;S X1=""
 .;S:X=3 X1="25" S:X=6 X1="50" ;CNC
 .;S:X=2 X1="25" S:X=5 X1="50" ;W22
 .;S:X=1 X1="25" S:X=4 X1="50" ;NU
 .;S:X1=7 X1="OTH"
 .S J=J+1
 .S $P(ACKQARR(25),U,J)=X ;LISTS R
 ;
 S S0=$G(^ACK(509850.9,ACKQI,111)) D  ;L Speech
 .F I=1:1:5 D
 ..S J=I+5 S $P(ACKQARR(25),U,J)=$P(S0,U,(4+(5*(I-1))))
 S X="" F I=3:5:23 S X=$P(S0,U,I) Q:$L(X)
 I $L(X) D
 .S X1="" I (X=3)!(X=6) S X1="CNC"
 .I (X=2)!(X=5) S X1="CIDW"
 .I (X=1)!(X=4) S X1="NU"
 .S:X1="" X1="OTHER"
 .S $P(ACKQARR(25),U,19)=X1 ;Material L if 3*3
 S X="" F I=5:5:25 S X=$P(S0,U,I) Q:$L(X)
 I $L(X) D
 .S X1="" I (X=1)!(X=2) S X1="REC"
 .E  I (X=3) S X1="MLV"
 .S $P(ACKQARR(25),U,20)=X1 ;PRES METH R
 ;
 S J=25 F I=28:1:32 S X=$P(S0,U,I) D
 .;S X1=""
 .;S:X=3 X1="25" S:X=6 X1="50" ;CNC
 .;S:X=2 X1="25" S:X=5 X1="50" ;W22
 .;S:X=1 X1="25" S:X=4 X1="50" ;NU
 .;S:X1=7 X1="OTH"
 .S J=J+1
 .S $P(ACKQARR(25),U,J)=X ;LISTS L
 ;
 S S0=$G(^ACK(509850.9,ACKQI,115))
 S $P(ACKQARR(25),U,11)=$P(S0,U,9),$P(ACKQARR(25),U,12)=$P(S0,U,11) ;R MAX & PIPB
 S $P(ACKQARR(25),U,14)=$P(S0,U,12),$P(ACKQARR(25),U,15)=$P(S0,U,14) ;L MAX & PIPB
SRT ;next section lines go in array nodes 24 only
 S $P(ACKQARR(24),U,31)=$P(S0,U,1) ;SRT R1
 S $P(ACKQARR(24),U,32)=$P(S0,U,2) ;SRT R2
 S $P(ACKQARR(24),U,35)=$P(S0,U,3) ;R init SRT Mask Lev
 S $P(ACKQARR(24),U,36)=$P(S0,U,4) ;R final SRT Mask Lev
 S $P(ACKQARR(24),U,33)=$P(S0,U,5) ;SRT L1
 S $P(ACKQARR(24),U,34)=$P(S0,U,6) ;SRT L2
 S $P(ACKQARR(24),U,37)=$P(S0,U,7) ;L init SRT Mask Lev
 S $P(ACKQARR(24),U,38)=$P(S0,U,8) ;L final SRT Mask Lev
 S $P(ACKQARR(24),U,39)=$P(S0,U,17) ;R SRT initial tag
 S $P(ACKQARR(24),U,40)=$P(S0,U,18) ;L SRT initial tag
 S $P(ACKQARR(24),U,41)=$P(S0,U,15) ;R SRT final tag
 S $P(ACKQARR(24),U,42)=$P(S0,U,16) ;L SRT final tag
ITC S S0=$G(^ACK(509850.9,ACKQI,120)),X=$P(S0,U,16) ;additions to 25 node
 S $P(ACKQARR(25),U,13)=$S(X=1:"GOOD",X=2:"FAIR",X=3:"POOR",1:"") ;R consistency
 S SB=$G(^ACK(509850.9,ACKQI,121)),X=$P(SB,U,16)
 S $P(ACKQARR(25),U,16)=$S(X=1:"GOOD",X=2:"FAIR",X=3:"POOR",1:"") ;L consistency
REF ;set referral reason,source & transducer type into node 24
 S S0=$G(^ACK(509850.9,ACKQI,0)) ;additions to 24 node
 S $P(ACKQARR(24),U,1)=$P(S0,U,7) ;TYPE OF VISIT
 S X1="" S X=$P(S0,U,4) I X S X1=$P($G(^SC(X,0)),U,1) ;referral source
 S $P(ACKQARR(24),U,2)=X1 ;referral source
 S X1=$P(S0,U,8),$P(ACKQARR(24),U,3)=X1 ;transducer type
 Q
 ;
LOGIC(R1,R2,R3,ML,AB)     ;
 ;Chart logic:
 ;R1=init read-R1
 ;R2=repeat read-R2
 ;R3=FINAL read-R3
 ;ML=MASK level-ML
 ;AB=air or bone
 ;defaults set above: (BONE IS 7,8,9)
 ;$P(ACKQARR(ACKI),U,4)="" ;default air Y
 ;$P(ACKQARR(ACKI),U,5)="" ;default mask *** obsolete
 ;$P(ACKQARR(ACKI),U,6)="" ;default mask level
 I (R1="DNT")!(R1="CNT") Q  ;leave at "" if not tested
 I R3'="" D  Q  ;masked, value in R3 (R3 could contain +)
 .S:AB="A" $P(ACKQARR(ACKI),U,4)=R3,$P(ACKQARR(ACKI),U,6)=ML
 .S:AB="B" $P(ACKQARR(ACKI),U,7)=R3,$P(ACKQARR(ACKI),U,9)=ML
 I R2="" D SET1 Q
 I R1="" D SET2 Q
 I R1["+",R2'["+" D SET2 Q
 I R1'["+",R2["+" D SET1 Q
 I R1<R2 D SET1 Q
 E  D SET2
 Q
SET1 ;
 S:AB="A" $P(ACKQARR(ACKI),U,4)=R1,$P(ACKQARR(ACKI),U,6)=ML
 S:AB="B" $P(ACKQARR(ACKI),U,7)=R1,$P(ACKQARR(ACKI),U,9)=ML
 Q
SET2 ;
 S:AB="A" $P(ACKQARR(ACKI),U,4)=R2,$P(ACKQARR(ACKI),U,6)=ML
 S:AB="B" $P(ACKQARR(ACKI),U,7)=R2,$P(ACKQARR(ACKI),U,9)=ML
 Q
