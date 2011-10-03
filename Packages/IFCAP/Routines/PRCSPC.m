PRCSPC ;WISC/KMB-PURCHASE CARD UPDATE CP FILES ;2/17/98 @ 1:02 PM
 ;;5.1;IFCAP;**35**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;  quit if entry point not used
 Q
 ;
COMM(DA,SDATE) ;   set committed balance for PC order with no 2237
 Q:DA']""
 N AMT,FCP,FY,NODE,QT,STR,X S NODE=$G(^PRC(442,DA,0)) Q:NODE=""
 S CDA=$P(NODE,"^",12)
 S STA=+$P(NODE," -"),AMT=$P(NODE,"^",16),FCP=$P(NODE,"^",3),FCP=$P(FCP," ")
 I CDA'="" D UPDATE
 D NOW^%DTC
 S FY=$E(X,2,3)
 S QT=$E(X,4,5)
 S QT=$P("2^2^2^3^3^3^4^4^4^1^1^1","^",+QT)
 S:QT=1 FY=$E(($E(X,1,3)+1),2,3)
 S STR=STA_"^"_FCP_"^"_FY_"^"_QT_"^"_AMT
 D EBAL^PRCSEZ(STR,"C")
 Q
 ;
UPDATE ;
 Q:CDA']""
 N I,X,MESSAGE,STRING,TDA
 Q:'$D(^PRCS(410,CDA,4))  S NODE(0)=^PRCS(410,CDA,0)
 S TDA=DA,DA=CDA,X=$P(^PRCS(410,CDA,4),"^",8) D TRANK^PRCSES
 S DA=TDA D NOW^%DTC S $P(^PRCS(410,CDA,4),"^",4)=X
 S $P(^PRCS(410,CDA,9),"^",2)=SDATE
 F I=1,8 S $P(^PRCS(410,CDA,4),"^",I)=AMT
 D ERS410^PRC0G(CDA_"^A")
 S MESSAGE="" D ENCODE^PRCSC2(CDA,DUZ,.MESSAGE)
 I MESSAGE<1 W !,"Contact your Site manager for an electronic signature code" Q
 Q
 ;
LOOK ;  lookup for purchase card orders
 Q:'$D(DA)
 S (PRCHCDNO,PRCHXXX)=$P($G(^PRC(442,DA,23)),"^",8)
 N TIMES,START,END,EN,STA,FIN,REM,ORIG,A1,A2,AA,ERROR,FLAG,VALUE,VALUE1,COUNT,TEMP,I,J,STR,XXZ
 S FLAG=0
 D ARR
 S VALUE1=+$P($G(^PRC(442,DA,23)),"^",8)
 I VALUE1=0,COUNT=1 S VALUE1=$P(AA(DUZ,1),"^",3),FLAG=1
 W !,"PURCHASE CARD NAME: ",$P($G(^PRC(440.5,VALUE1,0)),"^",11),$S(VALUE1=0:"",1:"//") R XXZ:DTIME
 I XXZ="",VALUE1'=0 W "  ",$P($G(^PRC(440.5,VALUE1,0)),"^",11) S XXZ=FLAG D SET Q:$G(ERROR)=""  G LOOK
 I XXZ=" ",VALUE1'=0 W "  ",$P($G(^PRC(440.5,VALUE1,0)),"^",11) S XXZ=FLAG D SET Q:$G(ERROR)=""  G LOOK
 ;
 ; Allow user to get out gracefully.
 I XXZ="" S X=XXZ W !!,?5,"No card selected...",$C(7) Q
 I XXZ["^" S X=XXZ W !!,?5,"Card selection interrupted...",$C(7) Q
 I XXZ["?",'$D(AA(DUZ,1)) W !,"You are not a purchase card holder." Q
 S VALUE="" I XXZ["?" D  I VALUE="" W "??" G LOOK
 .D LOOK1
 .I XXZ=""!(XXZ["^") S VALUE="" Q
 .I '$D(AA(DUZ,XXZ)) S VALUE="" Q
 .W " ",$P(AA(DUZ,XXZ),"^",2)
 .D SET S:$G(ERROR)'="" VALUE=""
 Q:VALUE=1
 ;
TESTL ;
 I XXZ?1.6N D  I VALUE="" W "??" G LOOK
 .D LOOK1
 .I XXZ=""!(XXZ["^") S VALUE="" Q
 .I '$D(J(XXZ)) S VALUE="" Q
 .W " ",$P(AA(DUZ,XXZ),"^",2)
 .D SET S:$G(ERROR)'="" VALUE=""
 Q:VALUE=1
 D LOOK1
 I VALUE'=1 W " ??" G LOOK
 I (XXZ["^")!(XXZ="") W " ??" G LOOK
 I '$D(J(XXZ)) W "??" G LOOK
 W "  ",$P(AA(DUZ,XXZ),"^",2) D SET I $G(ERROR)'="" G LOOK
 Q
 ;
SET I XXZ=0 S ERROR=1 Q
 S TEMP=$P(AA(DUZ,XXZ),"^",3)
 S VALUE=1
 I $P($G(^PRC(440.5,TEMP,2)),U,2)="Y" W ?50,"Inactive Purchase Card.",! S ERROR=1,VALUE="" K TEMP Q 
 S PRCHXXX=TEMP
 Q
 ;
 ; Prevent use of card if it is inactive, or the approving official is
 ; missing, or the card has expired.
ARR S (COUNT,I)=0 F  S I=$O(^PRC(440.5,"C",DUZ,I)) Q:I=""  D
 .Q:$P($G(^PRC(440.5,I,2)),U,2)="Y"!($P($G(^PRC(440.5,I,0)),"^",9)="")
 .I $P(^PRC(440.5,I,2),U,4)]"" Q:$P($G(^PRC(440.5,I,2)),U,4)<DT
 .S COUNT=COUNT+1,STR=$P($G(^PRC(440.5,I,0)),"^",1),STR1=$P($G(^PRC(440.5,I,0)),"^",11)
 .I I=+$P($G(^PRC(442,DA,23)),"^",8) S FLAG=COUNT
 .S AA(DUZ,COUNT)=STR_"^"_STR1_"^"_I
 S REM=COUNT#20,END=COUNT-REM,TIMES=END/20
 Q
 ;
LOOK1 ;
 K J S OUT="" S ORIG=XXZ S:ORIG["?" ORIG="" S:TIMES=0 TIMES=1
 N BB,VAL,ZZ I ORIG'="" S VAL=0 F ZZ=1:1:COUNT D
 .I $P(AA(DUZ,ZZ),"^",2)[ORIG S VAL=VAL+1,BB=ZZ
 I $G(VAL)=1 S J(BB)=1,VALUE=1,XXZ=BB,OUT=1 Q
 S STA=0 F J=1:1:TIMES Q:$G(OUT)=1  D  Q:$G(OUT)=1
 .S START=1+((J-1)*20),EN=J*20 S:COUNT<20 EN=COUNT
 .F I=START:1:EN I $P(AA(DUZ,I),"^",2)[ORIG S J(I)=1,VALUE=1 W !,I,?5,$P(AA(DUZ,I),"^",2)
 .F I=START:1:EN I $G(J(I))=1 S FIN=I I STA=0 S STA=I
 .I $G(VALUE)=1 W !,"CHOOSE ",STA,"-",FIN,": " R XXZ:DTIME I '$T S OUT=1
 .I XXZ'="",XXZ>COUNT S OUT=1
 .I XXZ'="",XXZ'>EN S OUT=1
 Q:$G(OUT)=1
 I COUNT<20 Q
 K J S VALUE="" F I=END+1:1:COUNT I $P(AA(DUZ,I),"^",2)[ORIG S J(I)=1,VALUE=1 W !,I,?5,$P(AA(DUZ,I),"^",2)
 F I=END+1:1:COUNT I $G(J(I))=1 S FIN=I
 I $G(VALUE)=1 W !,"CHOOSE ",STA,"-",FIN,": " R XXZ:DTIME I XXZ'=""!'$T S OUT=1
 Q
 ;
REF ;Stop users atempting to enter a past date and clean up the P.O. DATE
 ;field and its cross reference, "AB".
 S PRCHX=@"^DD(442,.1,1,1,2)" X PRCHX K PRCHX
 S $P(^PRC(442,DA,1),"^",15)=""
 Q
