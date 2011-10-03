LRBLPUS2 ;AVAMC/REG/CYM - PATIENT UNIT SELECTION ;08/20/2001 4:45 PM
 ;;5.2;LAB SERVICE;**139,247,275**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S X=$P(F,"^",7)_"000" D H^%DTC
 S O(1)=%H,O(2)=$S(X'[".":0,1:$E(X,9,10)*60+$E(X,11,12))
 S X="N",%DT="T" D ^%DT K %DT
 S X=Y_"000" D H^%DTC
 S H(1)=%H,H(2)=$E(X,9,10)*60+$E(X,11,12)
 S L=O(1)-H(1)
 I 'O(2) W !,$P(F,"^",2)," EXPIRE" W:L>0 "S IN ",L,$S(L>1:" DAYS",1:" DAY") W:'L&'(O(2)) "S TODAY" I L<0 W $C(7),"D ",-1*L,$S(L=-1:" DAY",1:" DAYS")," AGO !",! Q
 I O(2) D T Q:'$D(L)
 S I=+F F A=0:0 S A=$O(^LRD(65,I,2,A)) Q:'A  D
 . I $D(^LRD(65,"AP",A,I)) S X=^LR(A,0),Y=$P(X,U,3),X=$P(X,U,2),X=^DIC(X,0,"GL"),N=@(X_Y_",0)") W !,"Assigned/xmatched to ",$P(N,U,1)," ",$P(N,U,9)
 W !!,"UNIT OK for ",LRP," ",SSN,"  "
 S %=1 D YN^LRU Q:%'=1  L -^LRD(65,I)
 S:$D(G(1)) LRI(1)=$O(^LRO(68,LRAA,1,G(1),1,G(3),4,0))
 L +^LRD(65,I,2):99
 S:'$D(^LRD(65,I,2,0)) ^(0)="^65.01IA^^" I '$D(^(LRDFN,0)) S ^(0)=LRDFN,X=^LRD(65,I,2,0),^(0)="^65.01IA^"_LRDFN_"^"_($P(X,"^",4)+1)
 L -^LRD(65,I,2)
 I 'C(9)!(C(9)=2&('$D(G))) G END
 L +^LRD(65,I,2):99
 S:'$D(^LRD(65,I,2,LRDFN,1,0)) ^(0)="^65.02DA^^" S X=$P(G,"^",2)
 I '$D(^LRD(65,I,2,LRDFN,1,X)) S ^(X,0)=+G_"^"_LRS_"^"_LRMD_"^^^"_$P(G,"^",3)_"^"_LRS(1)_"^"_LRMD(1),Y=^LRD(65,I,2,LRDFN,1,0),^(0)="^65.02DA^"_X_"^"_($P(Y,"^",4)+1),^LRD(65,I,2,LRDFN,1,"B",+G,X)=""
 L -^LRD(65,I,2) I C(9)'=1 G END
 L +^LR(LRDFN,1.8):99
 S:'$D(^LR(LRDFN,1.8,0)) ^(0)="^63.084PA^^"
 I '$D(^LR(LRDFN,1.8,C,0)) S ^(0)=C,Y=^LR(LRDFN,1.8,0),^(0)="^63.084PA^"_C_"^"_($P(Y,"^",4)+1)
 S:'$D(^LR(LRDFN,1.8,C,1,0)) ^(0)="^63.0841PA^^"
 ; 
 ; LR*5.2*275 - Specific Requirement 2 from SRS
 ; BNT - Update the Units Selected for Xmatch node with the correct
 ; specimen Inverse Specimen Date.
 ; I = Pointer to Blood Product file 65 for selected Unit.
 ; X = Inverse Specimen Date of selected specimen/accession
 S ^LR(LRDFN,1.8,C,1,I,0)=I_"^"_X
 S Y=^LR(LRDFN,1.8,C,1,0),^(0)="^63.0841PA^"_I_"^"_($P(Y,"^",4)+1)
 ;
 L -^LR(LRDFN,1.8) Q
 ;
T S M=O(2)-H(2) S:M<0 L=L-1,O(2)=O(2)+1440,M=O(2)-H(2) S H=M\60,M=M#60 W ! W:L>0 L," DAY",$S(L=1:" ",1:"S ")
 I L>-1 W:H>0 H," HOUR",$S(H=1:" ",1:"S ") W:M>0 M," MINUTE",$S(M=1:" ",1:"S ") W:(H+M)>0 " LEFT" Q
 W !,$C(7),"UNIT EXPIRED ",-1*L,$S(-1*L:" DAY(S) ",1:" "),H," HOUR(S) ",M," MINUTE(S) AGO" K L Q
 ;
ORD S Y=^LRO(68,LRAA,1,G(1),1,G(3),0),Y(4)=$P(Y,"^",4),Y(5)=$P(Y,"^",5)
 I Y(4),Y(5),$D(^LRO(69,Y(4),1,Y(5),3)) S $P(^(3),"^",2)=DT
 Q
 ;
END S DIE="^LRD(65,I,2,",DA=LRDFN,DA(1)=I,DR=".02///NOW;S X(1)=X"
 D ^DIE K DIE,DR,DA
 S X=^LRD(65,I,0),Y(7)=$P(X,"^",7),Y(8)=$P(X,"^",8),Y=X(1)
 D DT^LRU
 S Y(1)=$P(X,"^")_"^"_LRP_" "_SSN_"^"_"Patient "_LRPABO_" "_LRPRH_" "_Y_"^"_"Unit    "_Y(7)_" "_Y(8)_" # "_$P(X,"^")_"   "_LRWHO_"^"_"NO CROSSMATCH REQUIRED"
 D EN^LRBLPX Q
