FBAAPLU ;AISC/DMK-PHARMACY VENDOR LOOK-UP ;27JUL88
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D DT^DICRW
RDV K FBAANQ W !! S FBAAOUT=0,DIC="^FBAAV(",DIC(0)="AEQM",DIC("A")="Select Pharmacy Vendor: ",DIC("S")="I $P(^(0),""^"",7)=3" D ^DIC K DIC("A"),DIC("S") G Q:X="^"!(X=""),RDV:Y<0 S FDA=+Y,FBVEN=$P(Y,"^",2)
 D DATE^FBAAUTL G:FBPOP RDV S ZZ=9999999,BEG=ZZ-ENDDATE,END=ZZ-BEGDATE
 S VAR="FDA^BEG^END^FBVEN",VAL=FDA_"^"_BEG_"^"_END_"^"_FBVEN,PGM="START^FBAAPLU" D ZIS^FBAAUTL G:FBPOP Q S:IO=IO(0) FBAANQ=1
 ;
START S Q="",$P(Q,"=",80)="=",HNAM="" U IO W:$E(IOST,1,2)="C-" @IOF D HED
 S (J,K,L)=0
 F I=BEG-1:0 S I=$O(^FBAA(162.1,"AK",FDA,I)) Q:I>END!(I'>0)!(FBAAOUT)  F  S J=$O(^FBAA(162.1,"AK",FDA,I,J)) Q:J'>0!(FBAAOUT)  F  S K=$O(^FBAA(162.1,"AK",FDA,I,J,K)) Q:K'>0!(FBAAOUT)  D  Q:FBAAOUT
 .F  S L=$O(^FBAA(162.1,"AK",FDA,I,J,K,L)) Q:L'>0!(FBAAOUT)  D  Q:FBAAOUT
 ..I K]"" Q:'$D(^FBAA(162.1,K,0))&('$D(^FBAA(162.1,K,"RX",L,0)))  S Y(0)=^(0),Y(1)=$G(^FBAA(162.1,K,"RX",L,2))
 ..S FBINVN=$P(^FBAA(162.1,K,0),"^"),N=$P(Y(0),"^",5),FBNM=$S($D(^DPT(N,0)):$P(^DPT(N,0),"^"),1:""),FBSSN=$S(N]"":$TR($$SSN^FBAAUTL(N),"-",""),1:"")
 ..S FBRX=$P(Y(0),"^"),FBDRUG=$P(Y(0),"^",2),FBFD=$P(Y(0),"^",3),FBAC=$P(Y(0),"^",4),FBAP=$P(Y(0),"^",16),FBSUSP=$P(Y(0),"^",8),FBPD=$P(Y(0),"^",19),FBBATCH=$P(Y(0),"^",17) Q:FBBATCH']""
 ..Q:$P(^FBAA(161.7,FBBATCH,0),"^",12)']""  S FBBATCH=$P($G(^FBAA(161.7,FBBATCH,0)),"^")
 ..I FBSUSP]"" S FBSUSP=$P($G(^FBAA(161.27,FBSUSP,0)),"^")
 ..S FBREIM=$S($P(Y(0),"^",20)="R":"*",1:""),FBSTR=$P(Y(0),"^",12),FBQTY=$P(Y(0),"^",13),A1=FBAC+.00001,A2=FBAP+.00001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2),FBPV=""
 ..I $D(Y(1)) S FBPV=$S($P(Y(1),"^",3)="V":"#",1:"")
 ..D FBCKP^FBAACCB1(K,L)
 ..D WRT
 G:$D(FBAANQ) RDV
Q K J,K,L,DIC,BEG,BEGDATE,END,ENDDATE,FBNM,FBSSN,FBVEN,FDA,HNAM,I,X,ZZ,FBRX,FBFD,FBAC,FBAP,A1,A2,FBPV,FBSUSP,FBSTR,FBQTY,FBAAOUT,FBBATCH,FBDRUG,FBINVN,FBPD,FBREIM,N,Q,VAL,VAR,PGM,Y
 D CLOSE^FBAAUTL
 Q
WRT I $E(IOST,1,2)["C-",$Y+4>IOSL S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1 Q:FBAAOUT  W @IOF D HED
 E  I $Y+4>IOSL W @IOF D HED
 W:FBNM'=HNAM !,FBNM,?40,FBSSN,!
 W !,FBREIM,FBPV,$S($G(FBCAN)]"":"+",1:""),?3,$$DATX^FBAAUTL(FBFD),!," Rx: "_FBRX,?15,FBDRUG,?45,FBSTR,?63,FBQTY
 W !,?4,$J(A1,4),?12,$J(A2,4),?20,FBSUSP,?24,FBINVN,?35,FBBATCH,?53,$$DATX^FBAAUTL(FBPD),!
 D PMNT^FBAACCB2
 S HNAM=FBNM
 Q
HED S FBAAOUT=0 W ?20,"** PHARMACY VENDOR LOOK-UP **",!,!,"Vendor: ",FBVEN,?40,"ID #: ",$P(^FBAAV(FDA,0),"^",2),?60,"Chain #: ",$P(^(0),"^",10),!!,?15,"('*' Reimbursement to Patient   '+' Cancellation Activity)",!,?15,"('#' Voided Payment)",!
 W ?3,"Patient",?40,"SSN",!,"Fill Date",?15,"Drug Name",?44,"Strength",?60,"Quantity",!,?2,"Claimed",?11," Paid",?19,"Code",?24,"Invoice #",?35,"Batch #",?50,"Date Finalized",!,Q
 Q
