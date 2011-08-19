RMPRCT ;PHX/HNB-INPUT TRANSFORM ITEM COST/10-2421 ;10/19/1993
 ;;3.0;PROSTHETICS;**25**;Feb 09, 1996
EN I X'?.N.1".".2N!(X<0)!(X>999999.99) K X Q
 I '$D(RMPRF) Q
 Q:(RMPRF=1)  G:(RMPRF=2)!(RMPRF=9) AR G:'$D(RMPRAMT) CON
 S PQTY=$S($P(^RMPR(664,DA(1),1,DA,0),U,4):$P(^(0),U,4),1:1)
 I RMPRF=10&($D(RMPR90))&(X*PQTY>RMPRAMT) S RMPRF=1 K RMPRPSC W !,$C(7),$C(7),"This Form Type Has Been Changed to a 10-55!" Q
 I $D(RMPRAMT) I X*PQTY>RMPRAMT W !,$C(7),$C(7),"You Can Not Exceed $",$J(RMPRAMT,0,2),", You Must Issue a 10-55 For This Amount!",!,"If You Enter in an Amount That Exceeds the Above Amount"
 I  W !,"This Form Type will be CHANGED to a 10-55" K X S RMPR90=1
 I $D(X) S $P(^RMPR(664,DA(1),1,DA,0),U,3)=X
 Q
CON Q
AR ;10-2421 and No Form
 S (RMPRY,RMPRX)=0
 F RI=0:0 S RI=$O(^RMPR(664,DA(1),1,RI)) Q:RI'>0  D CHK
 I RMPRY=0 S RMPRX=$P(^RMPR(664,DA(1),1,DA,0),U,4)*X G ARE
 S PCST=$P(^RMPR(664,DA(1),1,DA,0),U,3),PQTY=$P(^RMPR(664,DA(1),1,DA,0),U,4)
 I 'PCST S RMPRX=RMPRY+(PQTY*X)
 I PCST S RMPRX=RMPRY-(PCST*PQTY)+(PQTY*X)
 W !,?5,"** Total for Previous Item(s) is $"_RMPRY,!,?5,"** Total With This Amount is $"_RMPRX
ARE I $D(RMPRCONT)&(RMPRX>999999!(X>999999)!(X'?.N.1".".2N)!(X<0)) D WR Q
 I '$D(RMPRCONT)&(RMPRX>999999!(X>999999)!(X'?.N.1".".2N)!(X<0)) D WR Q
 I $D(X),RMPRF="E",$D(RMX) S $P(^RMPR(664,DA(1),1,DA,0),U,7)=X
 K RMPRX,RMPRY,PCST,PQTY,RI,RMPR660,PACST,RMPR90,RMX Q
WR W $C(7),!!,?5,"Dollar Amount must be within Contract Authority Guidelines",! Q
EN1 ;Check for PSC card issue and Eyeglass items
 Q:'$D(RMPRF)  G:RMPRF["E" EN3
 I RMPRF=8 S R90=$P(^RMPR(661,X,0),U,3),RI=$P(^RMPR(661,X,0),U,4) K:(+R90=0)!(+RI=0) X
 I  I (+R90)&(+RI) I $P(^RMPR(663,R90,0),U,1)'=11,$P(^RMPR(663,RI,0),U,1)'="R06" W !,$C(7),"*** THIS ITEM HAS IMPROPER AMIS CODES AND CANNOT BE ENTERED ON A 2914" K X
 Q:(RMPRF'=1)&(RMPRF'=10)  S RMPRUP=0 S RMPRUP=$O(^RMPR(665,"C",X,RMPRDFN,RMPRUP))
 W:RMPRUP="" !,$C(7),"*** THIS PATIENT DOES NOT HAVE A PSC CARD FOR THIS ITEM YET!***" K:RMPRUP="" X
 Q
EN3 ;INPUT TRANSFORM TO NOT ALLOW ITEMS ENTERED
 K X W !,$C(7),"YOU MAY NOT CHANGE ITEMS AT THIS TIME!" Q
CHK I $P(^RMPR(664,DA(1),1,RI,0),U,4)&($P(^(0),U,7)) S RMPRY=RMPRY+($P(^(0),U,4)*$P(^(0),U,7)) Q
 I $P(^RMPR(664,DA(1),1,RI,0),U,4)&($P(^(0),U,3)) S RMPRY=RMPRY+($P(^(0),U,3)*$P(^(0),U,4)) Q
 Q
ITM ;Check item QTY and Cost
 I +X'=X!(X>300)!(X?.E1"."1N.N) K X Q
 I '$D(RMPRF) Q
 I '$P(^RMPR(664,DA(1),1,DA,0),U,3) Q
 Q:(RMPRF=1)  G:(RMPRF=2)!(RMPRF=9) TAR S RMPR660=$P(^RMPR(664,DA(1),1,DA,0),U,13) S:+RMPR660 RMPR660=$P(^RMPR(660,RMPR660,0),U,13) G:(RMPR660=2)!(RMPR660=9) TAR G:'$D(RMPRAMT) CON
 S RMPRY=$S($P(^RMPR(664,DA(1),1,DA,0),U,7):X*$P(^(0),U,7),1:+$P(^RMPR(664,DA(1),1,DA,0),U,3)*X)
 I (RMPRF=10)!(RMPRF="E") I RMPRY>RMPRAMT W !!,?5,"This will change the amount on this FORM to ","$ ",$J(RMPRY,0,2) W $C(7),!,?5,"Cost cannot exceed ","$ ",$J(RMPRAMT,0,2) K X
 I $D(X) S $P(^RMPR(664,DA(1),1,DA,0),U,4)=X
 Q
TAR S (RMPRY,RMPRX)=0
 F RI=0:0 S RI=$O(^RMPR(664,DA(1),1,RI)) Q:RI'>0  D CHK
 I RMPRY=0 G ARE
 S PCST=$P(^RMPR(664,DA(1),1,DA,0),U,3),PACST=$P(^(0),U,7),PQTY=$P(^RMPR(664,DA(1),1,DA,0),U,4) I $P(^(0),U,14)'="" S RMPRCONT=1
 S:+PACST PCST=PACST I 'PQTY S RMPRX=RMPRY+(PCST*X)
 I PQTY,PCST S RMPRX=RMPRY-(PCST*PQTY)+(PCST*X)
 W !,?5,"** Total for Previous Item(s) is $"_RMPRY,!,?5,"** Total With This number of Items is $"_RMPRX
 G ARE
ACT ;Check Actual cost for item
 S:X["$" X=$P(X,"$",2) I X'?.N.1".".2N!(X>999999)!(X<0) K X Q
 I '$D(RMPRF) Q
 Q:(RMPRF=1)  G:(RMPRF=2)!(RMPRF=9) SAR S RMPR660=$P(^RMPR(664,DA(1),1,DA,0),U,13) S:+RMPR660 RMPR660=$P(^RMPR(660,RMPR660,0),U,13) G:(RMPR660=2)!(RMPR660=9) SAR G:'$D(RMPRAMT) CON
 I (RMPRF="E")&$D(RMPRAMT) I $P(^RMPR(664,DA(1),DA,1,0),U,4)*X>RMPRAMT W !,$C(7),$C(7),"You Can Not Exceed $",$J(RMPRAMT,0,2)," For This 2520 Form." K X
 I $D(X) S $P(^RMPR(664,DA(1),1,DA,0),U,7)=X
 Q
SAR S (RMPRY,RMPRX)=0,RMX=1
 F RI=0:0 S RI=$O(^RMPR(664,DA(1),1,RI)) Q:RI'>0  D CHK
 S PACST=$P(^RMPR(664,DA(1),1,DA,0),U,7),PCST=$P(^(0),U,3),PQTY=$P(^(0),U,4) S:$P(^(0),U,14)'="" RMPRCONT=1
 I 'PACST S RMPRX=RMPRY-(PCST*PQTY)+(PQTY*X)
 I PACST S RMPRX=RMPRY-(PACST*PQTY)+(PQTY*X)
 W !,?5,"** Total for Previous Item(s) is $"_RMPRY,!,?5,"** Total with this actual amount is $"_RMPRX
 G ARE
CHECK ;CHECK PURCHASE FOR CONTRACT NUMBER AND COST
 I RMPRF="E" I $D(RMPRP),(RMPRP["PSC"!(RMPRP["2520")) Q
 I RMPRF=10!(RMPRF=1) Q
 I $D(RMPRCONT)&(RMPRTO>999999) K RMPRTO
 I '$D(RMPRCONT)&(RMPRTO>999999) K RMPRTO
 I '$D(RMPRTO) W !!,$C(7),?5,"Dollar Amount must be within Contract Authority Guidelines",! Q
