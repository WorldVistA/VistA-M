DGOIL2 ;ALB/AAS - CALCULATE LOS BY TRANSFER ; 28-SEPT-90
 ;;5.3;Registration;**93,498**;Aug 13, 1993
 ;
 ;INPUT   -   Admission ifn in DGPMIFN - call EN^
 ;
 ;OUTPUT  - x(t)=net los^auth absence days^pass days^unauth days^asih days^gross los^trf date^ward
 ;          x3=sum of x(t's)
 ;
EN N T,I S (LOP,LOA,LOUA,LOAS)=0
 S (X,X3)="0^0^0^0^0^0^0"
 I $S('$D(DGPMIFN):1,'$D(^DGPM(+DGPMIFN,0)):1,$P(^(0),"^",2)'=1:1,1:0) G END
 S B=^DGPM(DGPMIFN,0),DFN=$P(B,"^",3),A=+B
 I $P(B,"^",22) S:$L(A)=7 A=A_"." S A=A_"000000",A=$E(A,1,14)_$P(B,"^",22)
ASIH S DGASIH="" I $P(B,"^",18)=40,$P(B,"^",21),$P(^DGPM($P(B,"^",21),0),"^",14) S ADM=^DGPM($P(^DGPM($P(B,"^",21),0),"^",14),0),DIS=$P(ADM,"^",17) I DIS]"",$D(^DGPM(DIS,0)),+^(0)>DT S DGASIH="+" ;currently asih flag
 D MAX
 ;
 S (I,DGT)=1
ADM F DGT=DGT:1 S A1=A,DGPMIFN1=$O(^DGPM("APCA",DFN,DGPMIFN,A,0)) Q:'DGPMIFN1!('A)!('I)  D TRANS
 Q:$D(DGPMIFN(1))
 S $P(X3,"^",9)=DGASIH
 S $P(X3,"^",10)=$S($P($G(^DGPM(DGPMIFN,"DIR")),"^",1)'=0:"!",1:"")
 G END
 ;
EN1 ; - entry to find los for one transfer
 ; - input DGPMIFN1 = transfer
 ; - output in X(t) if '$d(DGT) t=1
 ;
 I $S('$D(DGPMIFN1):1,'$D(^DGPM(DGPMIFN1,0)):1,$P(^(0),"^",2)>2:1,1:0) S DGOUT=1 G EN1Q
 S DGPMIFN=$P(^DGPM(DGPMIFN1,0),"^",14) I $S('DGPMIFN:1,'$D(^DGPM(DGPMIFN,0)):1,1:0) S DGOUT=1 G EN1Q
 S B=^DGPM(DGPMIFN,0)
 S DGT=1 D MAX
TRANS S (DGOUT,LOP,LOA,LOUA,LOAS)=0
 S X(DGT)="0^0^0^0^0^0^0^0^"
 S B(DGT)=^DGPM(DGPMIFN1,0)
 S DGWRD=+$P(B(DGT),"^",6) I +DGWRD,$D(^DIC(42,+DGWRD,0)) S DGWRD=$P(^(0),"^")
 E  S DGWRD=""
 ;
 S DGDONE=0
 F I=A:0 S I=$O(^DGPM("APCA",DFN,DGPMIFN,I)) Q:'I  S:$E(I,1,$L(D))'=D A=I S DGS=$O(^(I,0)) I $D(^DGPM(+DGS,0)) S Z=DGS,DGS=^(0) I "^1^2^3^4^25^26^13^14^43^44^45^"[("^"_$P(DGS,"^",18)_"^") S X2=+DGS,DGS=("^"_$P(DGS,"^",18)_"^") D ABS Q:'I!DGOUT
 I 'DGDONE,'I S A1=A,A=D ;end of movements, a1=start of last trf, a=dschrg or now
 D TRFTOT
 I $D(DGS),"^13^"[DGS D ^DGOIL3
EN1Q K DGWRD
 Q
 ;
ABS ; - if patient was on absence, find return.
 ; - DGS = mvt type at start of absence
 ; - DGE = mvt type at end of absence
 ;
 I "^43^"[DGS S DGOF=$S($P(^DGPM(Z,0),"^",5):$S($D(^DIC(4,$P(^DGPM(Z,0),"^",5),0)):$P(^(0),"^"),1:"UNK"),1:"UNK")
 I "^4^13^43^"[DGS S DGOUT=1 Q  ;start new transfers
 ;
 I "^14^"[DGS S:$D(DGOF) DGOFF=1 S X1=A,X2=A1 D ^%DTC S LOAS=LOAS+X,DGOUT=1 Q
 ;
TF S X1=0 F I=I:0 S I=$O(^DGPM("APCA",DFN,DGPMIFN,I)) Q:'I  S DGE=$O(^(I,0)) I $D(^DGPM(+DGE,0)) S DGE=^(0) I "^4^13^14^22^23^24^25^26^43^"[("^"_$P(DGE,"^",18)_"^") S (X1,DGET)=+DGE,DGE="^"_$P(DGE,"^",18)_"^" Q
 ;
 I 'X1 S (A,X1)=D D ^%DTC S DGOUT=1 D NORET Q  ;if no return from absence use discharge or now 
 D ^%DTC
 ;
 ;if 22 or 26 add time in unauth
 I "^22^26^"[DGE S LOUA=LOUA+X,A=A1
 ;
 ;if 23 add time in pass
 I "^23^"[DGE S LOP=LOP+X,A=A1
 ;
 ;if 24 or 25 add time in auth
 I "^24^25^"[DGE S LOA=LOA+X,A=A1
 ;
 I "^14^"[DGE S LOAS=LOAS+X,DGOUT=1
 ;
 ;if 25 or 26 sets tranf to and looks for next return
 I "^25^26"[DGE S DGS=DGE,X2=DGET G TF
 ;
 I "^14^44^"[DGE S DGOUT=1 Q  ;I wonder if this is really necessary?
 Q
 ;
TOT ; -- total los from transfer x(t) into x3
 F JJ=1:1:6 S $P(X3,"^",JJ)=$P(X3,"^",JJ)+($P(X(DGT),"^",JJ))
 F JJ=7:1:8 S $P(X3,"^",JJ)=$P(X(DGT),"^",JJ)
 Q
 ;
TRFTOT ; los for transfer, set x(t)
 S X1=A,X2=A1 D ^%DTC
 S X(DGT)=(X-(LOA+LOUA))_"^"_LOA_"^"_LOP_"^"_LOUA_"^"_$S($D(DGPMIFN(1)):X,1:LOAS)_"^"_X_"^"_A1_"^"_$S($D(DGOFF):DGOF,1:DGWRD),DGOUT=1 K:$D(DGOFF) DGOFF,DGOF
 D TOT
 Q
 ;
NORET ;  -- If discharge while absent find absence up to discharge
 S DGDONE=1
 I "^1^"[DGS S LOP=LOP+X
 I "^2^26^"[DGS S LOA=LOA+X
 I "^3^25^"[DGS S LOUA=LOUA+X
 I "^14^43^44^45^"[DGS S LOAS=LOAS+X
 Q
END K A,A1,B,D,DGDONE,DGE,DGET,DGMAX,DGOUT,DGPMIFN,DGPMIFN1,DGS,DGT,DGWRD,I,JJ,LOA,LOAS,LOP,LOUA,T,X1,X2
 Q
MAX D NOW^%DTC S D=$S($D(^DGPM(+$P(B,"^",17),0)):+^(0),1:0) S D=$S('D:%,D>%:%,1:D) S X1=D,X2=A D ^%DTC S DGMAX=$S(X:X,1:1)
 Q
