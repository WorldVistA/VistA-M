PSSLOCK ;BIR/RSB-Pharmacy patient lock ;09/15/97 13:30
 ;;1.0;PHARMACY DATA MANAGEMENT;**26,58,125**;9/30/97;Build 2
 ;
 ; Reference to ^ORX2 supported by DBIA #867
 ; Reference to ^PS(53.1 supported by DBIA #2140
 ; Reference to ^PS(52.41 supported by DBIA #2844
 ; Reference to ^PSRX supported by DBIA #2845
 ; Reference to ^PS(55 supported by DBIA #2191
 ;
L(DFN,DIS) ; 
 I $G(PSONOLCK) Q 1
 N FLAG S ^XTMP("PSSLOCK",0)=$$PDATE
 I '$D(^XTMP("PSSLOCK",DFN)) D  Q FLAG
 . D NOW^%DTC S ^XTMP("PSSLOCK",DFN)=DUZ_"^"_%
 . L +^XTMP("PSSLOCK",DFN):$S($G(DILOCKTM)>0:DILOCKTM,1:3) S FLAG=$S($T=1:$T,1:0)
 I $D(^XTMP("PSSLOCK",DFN)) Q $$R
UL(DFN) ; unlock
 I $G(PSONOLCK) Q
 L -^XTMP("PSSLOCK",DFN) K ^XTMP("PSSLOCK",DFN)
 Q
 ;
R() ; check lock on node
 ;if user has same patient already locked, Q 1, will only lock once
 I $P($G(^XTMP("PSSLOCK",DFN)),"^")=DUZ Q 1
 L +^XTMP("PSSLOCK",DFN):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 I $T=1 D NOW^%DTC S ^XTMP("PSSLOCK",DFN)=DUZ_"^"_% Q 1
 I $T=0 W:DIS=1 !,$$WHO(DFN) S Y=$P($G(^XTMP("PSSLOCK",DFN)),"^",2) X ^DD("DD") Q $S(DIS=0:0_"^"_$P($G(^VA(200,+$P($G(^XTMP("PSSLOCK",DFN)),"^"),0)),"^")_"^"_Y,1:0)
 ;
PDATE() ;
 N X1,X2 S X1=DT,X2=+14 D C^%DTC
 Q X_"^"_DT_"^Pharmacy patient locks"
 ;
WHO(DFN) ;
 S Y=$P($G(^XTMP("PSSLOCK",DFN)),"^",2) X ^DD("DD")
 Q $P($G(^VA(200,+$P($G(^XTMP("PSSLOCK",DFN)),"^"),0)),"^")_" is editing orders for this patient ("_Y_")"
 ;
 ;
LS(DFN,X) ;
 ;LOCK CPRS ORDER
 ;DFN is patient #, X is PSJORD OR PSGORD
 N OR100 S OR100=$$ORD(DFN,X) I OR100=0 Q 1
 N L S L=$$LOCK1^ORX2(OR100)
 I L Q 1
 I 'L W !,$P(L,"^",2),$C(7) D PAUSE^VALM1 Q 0
 Q 0
 ;
UNL(DFN,X) ;
 ; unlocks order in file 100
 ; DFN is patient #, X is PSJORD OR PSGORD
 D UNLK1^ORX2($$ORD(DFN,X))
 Q
 ;
ORD(DFN,X) ;
 ; return order number in file 100 from entry in 53.1 or 55.
 ; DFN is patient #, X is PSJORD OR PSGORD
 N ORD100
 S ORD100=$S(X["N"!(X["P"):"^PS(53.1,"_+X_",0)",X["V":"^PS(55,"_DFN_",""IV"","_+X_",0)",1:"^PS(55,"_DFN_",5,"_+X_",0)",1:"NA")
 Q +$P(@ORD100,"^",21)
 ;
PSOL(X) ;
 S PSOMSG=1
 I X["S" D  Q
 .S X=+$P($G(^PS(52.41,+$G(X),0)),"^") I X S PSOMSG=$$LOCK1^ORX2(X)
 S X=+$P($G(^PSRX(+$G(X),"OR1")),"^",2) I X S PSOMSG=$$LOCK1^ORX2(X)
 Q
PSOUL(X) ;
 I X["S" D  Q
 .S X=+$P($G(^PS(52.41,+$G(X),0)),"^") I X D UNLK1^ORX2(X)
 S X=+$P($G(^PSRX(+$G(X),"OR1")),"^",2) I X D UNLK1^ORX2(X)
 Q
