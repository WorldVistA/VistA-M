DGRUGS ;ALB/MLI,PHH - RUG-II STATUS REPORT ; 13 SEPT 88 @2000
 ;;5.3;Registration;**89,173,568**;Aug 13, 1993
 ;
EN D Q,ASK2^SDDIV G:Y<0 Q
 N ERR S ERR=$$CHOSE^DGRUGU1()
 I +ERR<0 G Q
 I $D(DGCL),$D(DGW) I '+$O(DGCL(0))&(+'$O(DGW(0)))&(DGW'=1)&(DGCL'=1) Q
 S SEL=$P(ERR,"^",2)
ASK W !!,"Sort by (A)ssessment or (T)ransfer/Admission Date: T//" S Z="^TRANSFER/ADMISSION^ASSESSMENT" R X:DTIME G Q:X["^"!('$T) I X="" S X="T" W X
 D IN^DGHELP
 I %=-1 W !!,?12,"CHOOSE FROM:",!?12,"A - Date range for the search is by Assessment Date",!?12,"T - Date range is by Transfer or admission date",! S %="" G ASK
 S DGX=$S(X="T":"AC",1:"AA")
 D DATE^DGSDUTL G:POP Q K BEGDATE,ENDATE
 S DGB=SDBD-.1,DGE=SDED+.9
 S DGPGM="1^DGRUGS",DGVAR="VAUTD#^DGW#^DGB^DGE^DGX^DGCL#"
 D ZIS^DGUTQ G:POP Q
1 U IO S I=DGB
 F  S I=$O(^DG(45.9,DGX,I)) Q:I'>0!(I>DGE)  D
 .S J=""
 .F  S J=$O(^DG(45.9,DGX,I,J)) Q:J'>0!'$D(^DG(45.9,+J,0))!'$D(^("R"))!'$D(^("C"))  D
 ..S DGR=^("R"),DG0=^(0),DGC=^("C"),DGWD=$P(DGR,"^")
 ..I $P(DG0,"^",6)'=3,$D(^DIC(42,+DGWD,0)) S DGS=^(0) D S
 ..I $P(DG0,"^",6)=3,$D(^FBAAV(+DGWD,0)) S DGS=^(0) D S
 S (DGNEW,DGPG)=0,I="" D NOW^DGPTOTRL
 S DGFL=0,FIRST=1
 F  S I=$O(^UTILITY($J,"S",I)) Q:I=""!(DGFL)  D
 .D HD
 .S FIRST=FIRST+1
 .Q:DGFL
 .S J=""
 .F  S DGHJ=J,J=$O(^UTILITY($J,"S",I,J)) Q:J=""!(DGFL)  D
 ..S K=""
 ..F  S K=$O(^UTILITY($J,"S",I,J,K)) Q:K=""!(DGFL)  D
 ...S L=""
 ...F  S L=$O(^UTILITY($J,"S",I,J,K,L)) Q:L=""!(DGFL)  D
 ....D PT
 ....Q:DGFL
Q W ! K %,^UTILITY($J),DG0,DGAD,DGAS,DGB,DGC,DGDV,DGE,DGHJ,DFN,DGFL
 K DGNEW,DGNM,DGNOW,DGPG,DGPGM,DGR,DGS,DGSSN,DGVAR,DGW,DGWD,DGWN,DGX
 K DGYR,ENDDATE,I,J,K,L,M,PG,SDBD,SDED,X,Y,VAUTD,Z,FIRST,DGCL,SEL
 D CLOSE^DGUTQ
 Q
S S DGWN=$P(DGS,"^") ;ward or cnh name
 I $P(DG0,"^",6)'=3 S DGDV=$S($P(DGS,"^",11)]"":$P(DGS,"^",11),1:$O(^DG(40.8,0))) Q:'VAUTD&'$D(VAUTD(+DGDV))
 I $P(DG0,"^",6)'=3 Q:'$D(DGW)  Q:'DGW&'$D(DGW(+DGWD))
 I $P(DG0,"^",6)=3 Q:'$D(DGCL)  Q:'DGCL&'$D(DGCL(+DGWD))
 Q:'$D(^DPT($P(DG0,"^"),0))
 S DGNM=$P(^(0),"^"),DGSSN=$S($P(^(0),"^",9)]"":$P(^(0),"^",9),1:0)
 S DGS=$P(DGC,"^")
 S DGS=$S(DGS=1:"COMPLETED",DGS=2:"CLOSED",DGS=3:"RELEASED",DGS=4:"TRANSMITTED",DGS=5:"INCOMPLETE",DGS=0:"OPEN",1:"UNSPECIFIED")
 S DGAS=$P(DG0,"^",2)
 S ^UTILITY($J,"S",DGWN,DGS,DGNM,DGSSN,DGAS)=$P(DG0,"^",2)_"^"_$P(DG0,"^",6)_"^"_$P(DG0,"^",7)_"^"_$P(DGR,"^",2)_"^"_$P(DGR,"^",3)
 Q
PT F M=0:0 S M=$O(^UTILITY($J,"S",I,J,K,L,M)) Q:'M  D
 .S DG0=^UTILITY($J,"S",I,J,K,L,M)
 .W ! W:DGHJ'=J!DGNEW !,$E(J,1,6)
 .S DGHJ=J
 .W ?10,$E(K,1,15),?27,L,?41
 .W $$FMTE^XLFDT($P(DG0,"^"),"5DZ")
 .W " ",$S($P(DG0,"^",2)=1:"A/T",$P(DG0,"^",2)=2:"S-A",$P(DG0,"^",2)=3:"CNH")
 .D W
 Q
W W ?58,$$FMTE^XLFDT($P(DG0,U,3),"5DZ")
 W ?71,$J($P(DG0,"^",5),2),?76,$J($P(DG0,"^",4),2)
 D FY
 S DGNEW=0
 I $Y>(IOSL-6)&($O(^UTILITY($J,"S",I,J,K))'="") D HD S DGNEW=1
 Q
HD D END
 Q:DGFL
 S DGPG=DGPG+1
 I FIRST>1!($E(IOST)="C") W @IOF
 W !?28,"RUG-II RECORD STATUS REPORT",!?30,$$FMTE^XLFDT(DGB+.1,"5DZ")," - ",$$FMTE^XLFDT(DGE,"5DZ"),!?32,"RUN: ",DGNOW,!!,"LOCATION: ",I,?71,"PAGE: ",$J(DGPG,3)
 W !!,"RECORD",?13,"PATIENT",?42,"ASSESSMENT",?70,"ADL",!,"STATUS",?13,"NAME",?30,"SSN",?42,"DATE/PURPOSE",?58,"A/T DATE",?70,"SUM",?75,"RUG",?81,"WWU" K X S $P(X,"_",85)="" W !,X,!
 Q
END S DGFL=0
 Q:'DGPG!($E(IOST)'="C")
 F PG=$Y:1:(IOSL-6) W !
 R !!,"Enter <RETURN> to continue, '^' to halt",X:DTIME
 S:(X["^")!('$T) DGFL=1
 Q
FY Q:'$P(DG0,"^",4)
 K DGWWU
 S DGAD=$P(DG0,"^",1),DGYR=$E(DGAD,1,3)_"0000"
 S:$E(DGAD,4,5)>9 DGYR=DGYR+10000
 W ?80,$J($S($D(^DG(45.91,$P(DG0,"^",4),"FY",DGYR,0)):$P(^(0),"^",2),1:"N/A"),4)
 Q
