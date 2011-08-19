PRCHNPO3 ;WISC/RSD/RHD/SC-CONT. OF NEW PO ; 4/23/99 1:39pm
V ;;5.1;IFCAP;**112,115,143**;Oct 20, 2000;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 S PRCHSZ=1
 ;
EN0 W !,"Enter a 2237 reference number. The FCP,Cost Center,Service,Delivery",!?3,"Location" W:PRCHSZ " and Line Items" W " will be transferred into this Purchase Order."
 W !!,?10,"The 2237 Fiscal Year and Quarter must be earlier or same",!,?10,"as the P.O. Date Fiscal Year and Quarter.",!
 I $O(^PRC(442,PRCHPO,13,0)) W !?3,"This Purchase Order already contains:" F I=0:0 S I=$O(^PRC(442,PRCHPO,13,I)) Q:'I  I $D(^PRCS(410,I,0)) W !?3,$P(^(0),U,1)
 I '$D(^PRC(442,PRCHPO,1)),$P(^(1),U,15)="" W !!,"Cannot precede without a P.O. DATE" G Q
 ;
EN K PRCHSY S PRCHD=$P(^PRC(442,PRCHPO,1),U,15),PRCHSP=$P(^(0),U,12)
 ;screen-out the Issue Book order if status is 65--Assigned to PPM Clerk, for nois MWV-0293-20011
 S DIC="^PRC(443,"
 S DIC(0)="AQEMZ"
 I $G(PRCHZZZ9)'=1 S DIC("S")="I $P(^(0),U,3)]"""",""65,72""'[$P(^(0),U,7),$D(^PRCS(410,+Y,0)),+^(0)=PRC(""SITE""),$P(^(0),U,2)=""O"",$P(^(0),U,4)'=5,$D(^(""IT"",""AB"")) D EN3^PRCHNPO6"
 I $G(PRCHZZZ9)=1 S DIC("S")="I $P(^(0),U,3)]"""",$P(^(0),U,7)=65,$D(^PRCS(410,+Y,0)),+^(0)=PRC(""SITE""),$P(^(0),U,2)=""O"",$P(^(0),U,4)'=5,$D(^(""IT"",""AB"")) D EN3^PRCHNPO6"
 D ^DIC K DIC G:Y<0 Q S PRCHSY=+Y,PRCHSY(0)=Y(0),Y(0)=^PRCS(410,+Y,0),PRCHSX=$P(Y(0),U,1) I $D(^(1)),$P(^(1),U,3)="EM" W $C(7),!,"*** EMERGENCY ***"
 ;I $D(^PRCS(410,+Y,0)),$P(^(0),U,4)=5 W !?3,"This is an Issue Book Order, and it can't be processed into a Purchase Order." Q
 ;
EN1 S PRCHRFQT=$$DATE^PRC0C($P(Y(0),"^",11),"I"),PRCHRFQT=$P(PRCHRFQT,U,1,2)
 S PRC("BBFY")=+$$DATE^PRC0C($P(^PRCS(410,+Y,3),"^",11),"I")
 ;S PRCHCFQT=$$DATE^PRC0C($P(^PRC(420,PRC("SITE"),0),U,9),"I"),PRCHCFQT=$P(PRCHCFQT,U,1,2)
 S PRCHPFQT=$$DATE^PRC0C($P(^PRC(442,PRCHPO,1),"^",15),"I"),PRCHPFQT=$P(PRCHPFQT,U,1,2)
 I PRCHRFQT'=PRCHPFQT W !,?10,"The Fiscal Year and Quarter on this 2237 is not",!,?10,"compatible with the PO Date.",!,$C(7) K PRCHRFQT,PRCHPFQT G EN
 K PRCHRFQT,PRCHPFQT
 I $P(^PRC(442,PRCHPO,0),U,3)]"",+$P(^PRC(442,PRCHPO,0),U,3)'=+$P(^PRCS(410,PRCHSY,3),U,1) W !?3,"Fund Control Point for this 2237 doesn't match the existing FCP in P.O.",$C(7) G EN
 I $P(^PRC(442,PRCHPO,0),U,5)]"",+$P(^PRC(442,PRCHPO,0),U,5)'=+$P(^PRCS(410,PRCHSY,3),U,3) W !?3,"Cost Center for this 2237 doesn't match the Cost Center in P.O.",$C(7) G EN
 S X="",Z="" I $D(^PRC(420,PRC("SITE"),1,+^PRCS(410,PRCHSY,3),0)) S X=$P(^(0),U,12),Z=$P(^(0),U,18)
 I X'=2 S:Z'="" $P(^PRC(442,PRCHPO,17),U,1)=$E(Z,1,3) I Z="" W $C(7),!?3,"Fund Control point is missing LOG Department Number!!" G EN
 I X I PRCHN("MP")=4!((X=3)&(PRCHN("MP")=3)) S Y=$P(^PRCD(442.5,PRCHN("MP"),0),U,1) W $C(7),!?3,"This Fund Control Point is not valid for a "_Y_" order." G EN
 S EN=0 I $D(^PRC(411,"UP",PRC("SITE"))) D  G EN:EN=1
 .I $P($G(^PRCS(410,+Y,0)),U,10)="" W $C(7),!!?3,"This 2237 does not have a substation.",! S EN=1 Q
 .I $P($G(^PRCS(410,+Y,0)),U,10)'=$P($G(^PRC(442,PRCHPO,23)),U,7) W $C(7),!!?3,"The substation on this 2237 does not match the substation entered",!?3,"on this "_$S($D(PRCHNRQ):"requisition.",1:"purchase order."),! S EN=1
 D SPRMK^PRCHNPO6
 ;
N Q:'PRCHSZ  K ^TMP($J,"PRCHS"),PRCHSIT S J=0,K=1,PRCHSIT(K)="" G:$D(PRCHPOST) 1
 W !?3,"Line Items: " R PRCHX:DTIME G Q:PRCHX["^"!(PRCHX=""),HLP:$E(PRCHX)="?",1:"Aa"[$E(PRCHX)
 F  Q:'$F(PRCHX,",,")  S PRCHX=$P(PRCHX,",,",1)_","_$P(PRCHX,",,",2,99) ; *112 remove consecutive commas
 S:$E(PRCHX)="," PRCHX=$E(PRCHX,2,$L(PRCHX)) ; *112 remove leading comma
 S:$E(PRCHX,$L(PRCHX))="," PRCHX=$E(PRCHX,1,$L(PRCHX)-1) ; *112 remove trailing comma
 F I=1:1 S X=$P(PRCHX,",",I) Q:X=""  I +X'=X S X(1)=$P(X,":",1),X(2)=$P(X,":",2) K:+X(1)'=X(1)!(+X(2)'=X(2))!'(X(1)<X(2)) PRCHX Q:'$D(PRCHX)  S $P(PRCHX,",",I)=X(1)_":1:"_X(2)
 I '$D(PRCHX) W " ??",$C(7) G N
 X "F I="_PRCHX_" D IT Q:'$O(^TMP($J,""PRCHS"",0))" G:'$O(^TMP($J,"PRCHS",0)) N S ^(0)=J
 ;
3 G 2:J=+^PRCS(410,PRCHSY,10),Q:'$O(^TMP($J,"PRCHS",0)) W !,"A new 2237 will now be created with the following items: " F K=0:0 S K=$O(PRCHSIT(K)) Q:'K  W !?3,PRCHSIT(K)
 S %A="     Do you wish to proceed",%B="",%=1 D ^PRCFYN I %'=1 G N
 Q:$D(PRCHG)  S PRCHSIT=J,PRCHS=PRCHSY D WAIT^DICD,^PRCHSP D:PRCHSY=-1 ERR D:PRCHSY=-3 ERR1 D:PRCHSY=-2 ERR2 G:PRCHSY<0 EN D EN4^PRCHNPO2
 G EN
 ;
1 S I=0 F  S I=$O(^PRCS(410,PRCHSY,"IT","AB",I)) Q:I=""  D IT
 S:$O(^TMP($J,"PRCHS",0)) ^(0)=J
 G 3
 ;
2 Q:$D(PRCHG)  S PRCHSIT=J,PRCHS="" D WAIT^DICD,^PRCHSP1
 D:PRCHSY=-1 ERR
 D:PRCHSY=-2 ERR2
 D:PRCHSY=-3 ERR1
 G:PRCHSY<0 EN
 D EN4^PRCHNPO2
 G EN
 ;
IT I $D(^PRCS(410,PRCHSY,"IT","AB",I)),$D(^PRCS(410,PRCHSY,"IT",$O(^(I,0)),0)) S ^TMP($J,"PRCHS",I)="",J=J+1 S:$L(PRCHSIT(K))>72 K=K+1,PRCHSIT(K)="" S PRCHSIT(K)=PRCHSIT(K)_I_"," Q
 W !?5,"** ",I," IS AN INVALID LINE ITEM NUMBER",$C(7) K ^TMP($J,"PRCHS")
 Q
 ;
HLP W !?3,"ENTER A LINE ITEM NUMBER IN THE FOLLOWING FORMAT:  1,2,3,4 OR 1:4 ",!?5," OR ENTER 'A' FOR ALL LINE ITEMS " S DIC="^PRCS(410,+PRCHSY,""IT"",",DIC(0)="E",X="??",D="AB" D IX^DIC K DIC G N
 Q
 ;
Q S (DA,D0)=PRCHPO K C,DIC,X,PRCH,PRCHD,PRCHS,PRCHSP,PRCHSIT,PRCHJ,PRCHK,PRCHSLI,PRCHSX,PRCHSY,PRCHSZ,PRCHX,^TMP($J,"PRCHS"),EN,Y
 S:0 Y="@1" ;<<< Removed the SET Y="@1" from this routine and put it into the template PRCH2138. <<<
 Q
 ;
DT S X="T" D ^%DT S DT=Y
 Q
 ;
EN2 ;CHECKS FCP PARAMETERS & SET Y, CALLED FROM PRCH2138,PRCHIFREG
 S PRCHN("SFC")=+$P(^PRC(442,DA,0),"^",19)
 S $P(^PRC(442,DA,18),U,2)=$S((PRCHN("SFC")=2)&(PRCHN("MP")=12):"B",PRCHN("SFC")=2:"A",PRCHN("SFC")=3:"J",1:"")
 S Y(0)=+$P(^PRC(442,DA,0),"^",3)
 I $G(PRCHCC)'="",$G(Y(0))'="",'$D(^PRC(420,PRC("SITE"),1,+Y(0),2,+PRCHCC)) S PRCHCC="" K DE(2)
 Q
 ;
ERR W !,$C(7),"Cannot get a transaction number at this time for the new transaction being split",!,"out.  Try again later!"
 Q
 ;
ERR1 W !,$C(7),"Cannot find the 2237 you selected in file 410."
 Q
 ;
ERR2 W !,$C(7),"Not continuing with this 2237."
 Q
 ;
VENMSG ;message to alert users that vendors don't match and that IMF will
 ;be updated.
 W !!,"NOTE-Vendors on PO and 2237 don't match.  If you proceed IMF info"," will be used.  If there is no IMF entry for the item for this vendor one will ","be created."
 N % S %=0
 W !,"Would you like to proceed" D YN^DICN W !! I %'=1 S PRCHFLG=1
 Q
