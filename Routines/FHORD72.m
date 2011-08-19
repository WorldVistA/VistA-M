FHORD72 ; HISC/NCA - Diet Order Utilities (cont) ;12/4/00  10:36
 ;;5.5;DIETETICS;;Jan 28, 2005
ADD ; Add diet associated Standing Orders and Supplemental Feeding Menu
 S PDFLG=0 Q:'X1  I $D(FHYES) Q:FHYES
 N FHOR S FHOR=$P($G(^FHPT(FHDFN,"A",ADM,"DI",X1,0)),"^",2,6)
 S X3="" F NX=0:0 S NX=$O(^FHPT(FHDFN,"A",ADM,"AC",NX)) Q:NX<1!(NX'<A1)  S X3=$P(^(NX,0),"^",2)
 G:X3=X1 KIL G:X3="" A1
 I FHOR=$P($G(^FHPT(FHDFN,"A",ADM,"DI",X3,0)),"^",2,6) D IND
 K N,P S LN=0
 F K=0:0 S K=$O(^FHPT("ASP",FHDFN,ADM,K)) Q:K<1  S X=^FHPT(FHDFN,"A",ADM,"SP",K,0) I $P(X,"^",9)="Y" S M=$P(X,"^",3),M=$S(M="BNE":"A",1:$E(M,1)),N(M,K)=$P(X,"^",2,3)_"^"_$P(X,"^",8),LN=LN+1,P(LN,+N(M,K))=K_"^"_N(M,K)
 F LN=1:1 Q:'$D(P(LN))  F Z=0:0 S Z=$O(P(LN,Z)) Q:Z<1  S SP=+Z D EN3^FHSPED
A1 S DPAT=$O(^FH(111.1,"AB",FHOR,0)) G:'DPAT A2 S LS=""
 F M1="BS","NS","ES" F L=0:0 S L=$O(^FH(111.1,DPAT,M1,L)) Q:L<1  S X=$G(^(L,0)),SP=+$P(X,"^",1),MEAL=$E(M1,1),NUM=$S($P(X,"^",2):$P(X,"^",2),1:1)_"^Y" D SO
A2 S SF=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",7) G:'SF A3 S X=$G(^FHPT(FHDFN,"A",ADM,"SF",SF,0))
 I $P(X,"^",4)=1!($P(X,"^",34)'="Y") G A4
 D CAN^FHNO5
A3 G:'DPAT A4
 S NM=$P($G(^FH(111.1,DPAT,0)),"^",8) G:'NM A4
 S PNO=$G(^FH(118.1,NM,1)) G:PNO="" A4
 S PNN="^"_NOW_"^"_DUZ_"^"_NM_"^"_PNO,NO="" D SF
A4 D UPD^FHMTK7
KIL K COM,DPAT,EVT,FP,L,LN,LP,LS,M,M1,M2,MEAL,N,NM,NO,NUM,NX,OPAT,P,PP,PNN,PNO,R1,SF,SP,X3,^TMP($J),Z
 Q
SO ; Add Standing Order
 L +^FHPT(FHDFN,"A",ADM,"SP",0)
 I '$D(^FHPT(FHDFN,"A",ADM,"SP",0)) S ^FHPT(FHDFN,"A",ADM,"SP",0)="^115.08^^"
 S X=^FHPT(FHDFN,"A",ADM,"SP",0),NO=$P(X,"^",3)+1,^(0)=$P(X,"^",1,2)_"^"_NO_"^"_($P(X,"^",4)+1)
 L -^FHPT(FHDFN,"A",ADM,"SP",0) I $D(^FHPT(FHDFN,"A",ADM,"SP",NO)) G SO
 S ^FHPT(FHDFN,"A",ADM,"SP",NO,0)=NO_"^"_SP_"^"_MEAL_"^"_NOW_"^"_DUZ_"^^^"_NUM,^FHPT("ASP",FHDFN,ADM,NO)="",LS=LS_NO_","
 S EVT="S^O^"_NO D ^FHORX Q
SF ; Add Supplemental Feeding
 L +^FHPT(FHDFN,"A",ADM,"SF",0)
 I '$D(^FHPT(FHDFN,"A",ADM,"SF",0)) S ^FHPT(FHDFN,"A",ADM,"SF",0)="^115.07^^"
 S X=^FHPT(FHDFN,"A",ADM,"SF",0),NO=$P(X,"^",3)+1,^(0)=$P(X,"^",1,2)_"^"_NO_"^"_($P(X,"^",4)+1)
 L -^FHPT(FHDFN,"A",ADM,"SF",0) I $D(^FHPT(FHDFN,"A",ADM,"SF",NO)) G SF
 S ^FHPT(FHDFN,"A",ADM,"SF",NO,0)=NO_"^"_$P(PNN,"^",2,99)
 S $P(^FHPT(FHDFN,"A",ADM,0),"^",7)=NO
 I NO'="" S EVT="F^O^"_NO D ^FHORX  ;file event, P30
UPD S:NO $P(^FHPT(FHDFN,"A",ADM,"SF",NO,0),"^",30,31)=NOW_"^"_DUZ
 S:NO $P(^FHPT(FHDFN,"A",ADM,"SF",NO,0),"^",34)="Y" Q
IND ; Restore Individual Pattern
 Q:'$D(^FHPT(FHDFN,"A",ADM,"DI",X3,2))
 S ^FHPT(FHDFN,"A",ADM,"DI",X1,2)=$G(^FHPT(FHDFN,"A",ADM,"DI",X3,2))
 S $P(^FHPT(FHDFN,"A",ADM,"DI",X1,3),"^",1,2)=DUZ_"^"_NOW
 I $P(^FHPT(FHDFN,"A",ADM,"DI",X3,0),"^",13) S $P(^FHPT(FHDFN,"A",ADM,"DI",X1,0),"^",13)=$P(^FHPT(FHDFN,"A",ADM,"DI",X3,0),"^",13),PDFLG=1
 Q
