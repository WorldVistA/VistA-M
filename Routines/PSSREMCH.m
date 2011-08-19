PSSREMCH ;BIR/RTR-Pre release Orderable Item report ;02/14/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**34**;9/30/97
 S PSSOUT=0 D TEXT^PSSUTLPR I $G(PSSOUT) K PSSOUT Q
 G ADDRP^PSSUTLPR
ADD ;
 N AAZ,AAZZ,SSZ,SSZZ,PSSATMP,PSSSTMP
 U IO S PSSOUT=0 K PSSADSUM,PSSTOTAL,PSSIVID,PSSIVIDL,PSSSOSUM
 S PSSDV=$S($E(IOST)="C":"C",1:"P"),PSSCOT=1
 S PSSIVID=$S($P($G(^PS(59.7,1,31)),"^",2)'="":$P($G(^(31)),"^",2),1:"IV") S PSSIVIDL=$L(PSSIVID)
 I $G(PSSTYPE)="S" G SOL
 S PSSWH="A"
 N ADD,AA,OI,PAD,ADDIEN,ZERO,LEN,COUNT,PSSAD,PAA,PZZ,PDD,OINAME,OIDOSE,OILT,TOTAL,PSSPADZ,AOILT,NEWOI,NEWOIL,ADDLT,PSSADIN,PSSADID,OIDATE,OIDATED,PSSPADX,PSSPADZZ,OIZD,OIZDZ,PSINDAT,PSINDATE
 K ^TMP($J,"PSSAD")
 D ADDH
 S ADD="" F  S ADD=$O(^PS(52.6,"B",ADD)) Q:ADD=""!($G(PSSOUT))  F ADDIEN=0:0 S ADDIEN=$O(^PS(52.6,"B",ADD,ADDIEN)) Q:'ADDIEN!($G(PSSOUT))  D
 .Q:'$P($G(^PS(52.6,ADDIEN,0)),"^",11)
 .S ZERO=$G(^PS(52.6,ADDIEN,0)),LEN=$L($P(ZERO,"^"))
 .K PSSADID S PSSADIN=$P($G(^PS(52.6,ADDIEN,"I")),"^") I PSSADIN S PSSADID="("_$E(PSSADIN,4,5)_"/"_$E(PSSADIN,6,7)_"/"_$E(PSSADIN,2,3)_")"
 .S LEN=LEN+$S($G(PSSADID)'="":11,1:0)
 .K PAD S $P(PAD,"=",(42-LEN))="",PAD=$G(PAD)_"> "
 .S OINAME=$P($G(^PS(50.7,+$P(ZERO,"^",11),0)),"^"),OIDOSE=$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^"),OILT=$L($G(OINAME))+$L($G(OIDOSE))+2
 .K OIDATED S OIDATE=$P($G(^PS(50.7,+$P(ZERO,"^",11),0)),"^",4) I OIDATE S OIDATED="("_$E(OIDATE,4,5)_"/"_$E(OIDATE,6,7)_"/"_$E(OIDATE,2,3)_")"
 .S ADDLT=$L(ADDIEN)+3
 .S PSSTOTAL=+$G(ADDLT)+45+$G(OILT)+$S($G(OIDATED)'="":11,1:0)+$G(PSSIVIDL)
 .S PSSPADZ=+$G(ADDLT)+42
 .I ($Y+5)>IOSL D ADDH Q:$G(PSSOUT)
 .W !!,?3,"Current Additive/Orderable Item match:",!
 .I $G(PSSTOTAL)<132 W "("_$G(ADDIEN)_") "_$P(ZERO,"^")_$S($G(PSSADID)'="":" "_$G(PSSADID),1:"")_$G(PAD)_$G(OINAME)_"  "_$G(OIDOSE)_$S($G(OIDATED)'="":" "_$G(OIDATED),1:"")_"  "_$G(PSSIVID)
 .I $G(PSSTOTAL)>131 W "("_$G(ADDIEN)_") "_$P(ZERO,"^")_$S($G(PSSADID)'="":" "_$G(PSSADID),1:"")_$G(PAD) W !,"=====> ",$G(OINAME)_"  "_$G(OIDOSE)_$S($G(OIDATED)'="":" "_$G(OIDATED),1:"")_"  "_$G(PSSIVID)
 .S OI=$P($G(^PSDRUG(+$P(ZERO,"^",2),2)),"^") I 'OI W !?5,"cannot re-match, no Orderable Item for the Dispense Drug" Q
 .S PSSATMP=$P($G(^PS(50.7,OI,0)),"^")_"  "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^")
 .S ^TMP($J,"PSSAD",PSSATMP,ADDIEN)=OI
 .S NEWOI=$P($G(^PS(50.7,+$G(OI),0)),"^")_"  "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^")
 .K OIZDZ S OIZD=$P($G(^PS(50.7,+$G(OI),0)),"^",4) I OIZD S OIZDZ="("_$E(OIZD,4,5)_"/"_$E(OIZD,6,7)_"/"_$E(OIZD,2,3)_")"
 .K PSSPADZZ S PSSPADX=$G(PSSPADZ)-18 S $P(PSSPADZZ,"=",PSSPADX)=""
 .S PSSPADZZ=PSSPADZZ_"> "
 .W !,"New Orderable Item"_$G(PSSPADZZ)_$G(NEWOI)_$S($G(OIZDZ)'="":" "_$G(OIZDZ),1:"")
 .W !?2,"Dispense Drugs matched to Orderable Item:"
 .F PAA=0:0 S PAA=$O(^PSDRUG("ASP",OI,PAA)) Q:'PAA!($G(PSSOUT))  D
 ..I ($Y+4)>IOSL D ADDH Q:$G(PSSOUT)
 ..K PSINDATE S PSINDAT=$P($G(^PSDRUG(PAA,"I")),"^") I PSINDAT S PSINDATE=" "_"("_$E(PSINDAT,4,5)_"/"_$E(PSINDAT,6,7)_"/"_$E(PSINDAT,2,3)_")"
 ..I PSINDAT,PSINDAT<$G(PSSYRX) Q
 ..W !?4,$P($G(^PSDRUG(PAA,0)),"^")_$G(PSINDATE) I PAA=$P(ZERO,"^",2) W ?55,"(Additive link)"
 I $G(PSSOUT) G ADDX
 D ADDHS G:$G(PSSOUT) ADDX
 S PSSADSUM=1
 S AA="" F  S AA=$O(^TMP($J,"PSSAD",AA)) Q:AA=""!($G(PSSOUT))  D
 .S AAZ=$O(^TMP($J,"PSSAD",AA,0)),AAZZ=+$G(^TMP($J,"PSSAD",AA,+$G(AAZ)))
 .I ($Y+4)>IOSL D ADDH Q:$G(PSSOUT)
 .W !!,"OI => ",AA_$S($P($G(^PS(50.7,AAZZ,0)),"^",4)="":"",1:" ("_$E($P($G(^(0)),"^",4),4,5)_"/"_$E($P($G(^(0)),"^",4),6,7)_"/"_$E($P($G(^(0)),"^",4),2,3)_")")
 .F PZZ=0:0 S PZZ=$O(^TMP($J,"PSSAD",AA,PZZ)) Q:'PZZ!($G(PSSOUT))  D
 ..I ($Y+4)>IOSL D ADDH Q:$G(PSSOUT)
 ..W !,"("_$G(PZZ)_") ",?13,$P($G(^PS(52.6,PZZ,0)),"^")_$S($P($G(^("I")),"^")="":"",1:" ("_$E($P($G(^("I")),"^"),4,5)_"/"_$E($P($G(^("I")),"^"),6,7)_"/"_$E($P($G(^("I")),"^"),2,3)_")"),?69,"(Additive)"
 .Q:$G(PSSOUT)
 .W !?2,"Dispense Drugs matched to OI:"
 .F PDD=0:0 S PDD=$O(^PSDRUG("ASP",AAZZ,PDD)) Q:'PDD!($G(PSSOUT))  D
 ..I ($Y+4)>IOSL D ADDH Q:$G(PSSOUT)
 ..I $P($G(^PSDRUG(PDD,"I")),"^"),$P($G(^("I")),"^")<$G(PSSYRX) Q
 ..W !,?11,$P($G(^PSDRUG(PDD,0)),"^")_$S($P($G(^("I")),"^")="":"",1:" ("_$E($P($G(^("I")),"^"),4,5)_"/"_$E($P($G(^("I")),"^"),6,7)_"/"_$E($P($G(^("I")),"^"),2,3)_")")
ADDX ;
 K ^TMP($J,"PSSAD")
 I $G(PSSTYPE)="B",'$G(PSSOUT) G SOL
 I '$G(PSSOUT) D PDIR
 G END
SOL ;
 K ^TMP($J,"PSSOL"),PSSCOTX
 S PSSWH="S"
 N SOL,SLDD,SZZ,SOLAA,SAA,SOLIEN,SNAME,SLNEWOI,SOINAME,SOIDOSE,SOILT,SOILTX,STOTAL,SLOI,SDA,SDAT,SDOI,SDOID,SOLLT,PSSSOLZ,SOIZD,SOIZDZ,SZL,SZLA,SLID,SLIDD
 D SOLH S PSSCOTX=1
 I $G(PSSOUT) G SEND
 S SOL="" F  S SOL=$O(^PS(52.7,"B",SOL)) Q:SOL=""!($G(PSSOUT))  F SOLIEN=0:0 S SOLIEN=$O(^PS(52.7,"B",SOL,SOLIEN)) Q:'SOLIEN!($G(PSSOUT))  D
 .Q:'$P($G(^PS(52.7,SOLIEN,0)),"^",11)
 .S ZERO=$G(^PS(52.7,SOLIEN,0))
 .S SNAME=$P(ZERO,"^")_"  ("_$P(ZERO,"^",3)_")",LEN=$L(SNAME)
 .K SDAT S SDA=$P($G(^PS(52.7,SOLIEN,"I")),"^") I SDA S SDAT="("_$E(SDA,4,5)_"/"_$E(SDA,6,7)_"/"_$E(SDA,2,3)_")"
 .S LEN=LEN+$S($G(SDAT)'="":11,1:0)
 .K PAD S $P(PAD,"=",(53-LEN))="",PAD=$G(PAD)_"> "
 .S SOINAME=$P($G(^PS(50.7,+$P(ZERO,"^",11),0)),"^"),SOIDOSE=$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^"),SOILT=$L($G(SOINAME))+$L($G(SOIDOSE))+2
 .K SDOID S SDOI=$P($G(^PS(50.7,+$P(ZERO,"^",11),0)),"^",4) I SDOI S SDOID="("_$E(SDOI,4,5)_"/"_$E(SDOI,6,7)_"/"_$E(SDOI,2,3)_")"
 .S SOLLT=$L(SOLIEN)+3
 .S PSSTOTAL=+$G(SOLLT)+67+$G(SOILT)+$S($G(PDOID)'="":11,1:0)+$G(PSSIVIDL)
 .S PSSSOLZ=+$G(SOLLT)+53
 .I ($Y+5)>IOSL D SOLH Q:$G(PSSOUT)
 .W !!?3,"Current Solution/Orderable Item match:",!
 .I $G(PSSTOTAL)<132 W "("_$G(SOLIEN)_") "_$G(SNAME)_$S($G(SDAT)'="":" "_$G(SDAT),1:"")_$G(PAD)_$G(SOINAME)_"  "_$G(SOIDOSE)_$S($G(SDOID)'="":" "_$G(SDOID),1:"")_"  "_$G(PSSIVID)
 .I $G(PSSTOTAL)>131 W "("_$G(SOLIEN)_") "_$G(SNAME)_$S($G(SDAT)'="":" "_$G(SDAT),1:"")_$G(PAD) D:($Y+4)>IOSL SOLH Q:$G(PSSOUT)  W !,"=====> ",$G(SOINAME)_"  "_$G(SOIDOSE)_$S($G(SDOID)'="":" "_$G(SDOID),1:"")_"  "_$G(PSSIVID)
 .S SLOI=$P($G(^PSDRUG(+$P(ZERO,"^",2),2)),"^") I 'SLOI W !?5,"cannot rematch, no Item for the Dispense Drug" Q
 .S PSSSTMP=$P($G(^PS(50.7,+$G(SLOI),0)),"^")_"  "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^")
 .S ^TMP($J,"PSSOL",PSSSTMP,SOLIEN)=SLOI
 .S SLNEWOI=$P($G(^PS(50.7,+$G(SLOI),0)),"^")_"  "_$P($G(^PS(50.606,+$P($G(^(0)),"^",2),0)),"^")
 .K SOIZDZ S SOIZD=$P($G(^PS(50.7,+$G(SLOI),0)),"^",4) I SOIZD S SOIZDZ="("_$E(SOIZD,4,5)_"/"_$E(SOIZD,6,7)_"/"_$E(SOIZD,2,3)_")"
 .K SZL S SZLA=$G(PSSSOLZ)-18 S $P(SZL,"=",SZLA)="" S SZL=SZL_"> "
 .W !,"New Orderable Item"_$G(SZL)_$G(SLNEWOI)_$S($G(SOIZDZ)'="":" "_$G(SOIZDZ),1:"")
 .W !?2,"Dispense Drugs matched to Orderable Item:"
 .F SAA=0:0 S SAA=$O(^PSDRUG("ASP",SLOI,SAA)) Q:'SAA!($G(PSSOUT))  D
 ..I ($Y+4)>IOSL D SOLH Q:$G(PSSOUT)
 ..K SLID S SLIDD=$P($G(^PSDRUG(SAA,"I")),"^") I SLIDD S SLID=" "_"("_$E(SLIDD,4,5)_"/"_$E(SLIDD,6,7)_"/"_$E(SLIDD,2,3)_")"
 ..I SLIDD,SLIDD<$G(PSSYRX) Q
 ..W !?4,$P($G(^PSDRUG(SAA,0)),"^")_$G(SLID) I SAA=$P(ZERO,"^",2) W ?59,"(Solution link)"
 I $G(PSSOUT) G SEND
 D SOLHS G:$G(PSSOUT) SEND
 S PSSSOSUM=1
 S SOLAA="" F  S SOLAA=$O(^TMP($J,"PSSOL",SOLAA)) Q:SOLAA=""!($G(PSSOUT))  D
 .S SSZ=$O(^TMP($J,"PSSOL",SOLAA,0)),SSZZ=+$G(^TMP($J,"PSSOL",SOLAA,+$G(SSZ)))
 .I ($Y+4)>IOSL D SOLH Q:$G(PSSOUT)
 .W !!,"OI => ",SOLAA_$S($P($G(^PS(50.7,SSZZ,0)),"^",4)="":"",1:" ("_$E($P($G(^(0)),"^",4),4,5)_"/"_$E($P($G(^(0)),"^",4),6,7)_"/"_$E($P($G(^(0)),"^",4),2,3)_")")
 .F SZZ=0:0 S SZZ=$O(^TMP($J,"PSSOL",SOLAA,SZZ)) Q:'SZZ!($G(PSSOUT))  D
 ..I ($Y+4)>IOSL D SOLH Q:$G(PSSOUT)
 ..W !,"("_$G(SZZ)_") ",?13,$P($G(^PS(52.7,SZZ,0)),"^")_"   ("_$P($G(^(0)),"^",3)_")"_$S($P($G(^("I")),"^")="":"",1:" ("_$E($P($G(^("I")),"^"),4,5)_"/"_$E($P($G(^("I")),"^"),6,7)_"/"_$E($P($G(^("I")),"^"),2,3)_")") W ?67,"(Solution)"
 .Q:$G(PSSOUT)
 .W !?2,"Dispense Drugs matched to OI:"
 .F SLDD=0:0 S SLDD=$O(^PSDRUG("ASP",SSZZ,SLDD)) Q:'SLDD!($G(PSSOUT))  D
 ..I ($Y+4)>IOSL D SOLH Q:$G(PSSOUT)
 ..I $P($G(^PSDRUG(SLDD,"I")),"^"),$P($G(^("I")),"^")<$G(PSSYRX) Q
 ..W !?11,$P($G(^PSDRUG(SLDD,0)),"^")_$S($P($G(^("I")),"^")="":"",1:" ("_$E($P($G(^("I")),"^"),4,5)_"/"_$E($P($G(^("I")),"^"),6,7)_"/"_$E($P($G(^("I")),"^"),2,3)_")")
 I '$G(PSSOUT) D PDIR
SEND ;
 K ^TMP($J,"PSSOL")
END I $G(PSSDV)="C" W !
 E  W @IOF
 K PSSTOTAL,PSSIVID,PSSIVIDL,PSSTYPE,PSSDV,PSSWH,PSSCOT,PSSOUT,PSSCOTX,PSSADSUM,PSSSOSUM,PSSYRX
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
ADDH ;
 I $G(PSSCOT)=1 W @IOF W !?5,"ADDITIVE REPORT    (Additive Internal number in parenthesis)",?67,"PAGE: "_$G(PSSCOT) S PSSCOT=PSSCOT+1 Q
 I $G(PSSDV)="C" K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 W @IOF W !?8,"ADDITIVE "_$S('$G(PSSADSUM):"REPORT",1:"SUMMARY")_"   (continued)" W ?67,"PAGE: "_$G(PSSCOT) S PSSCOT=PSSCOT+1
 Q
ADDHS ;
 I $G(PSSDV)="C" K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit"  D ^DIR K DIR I 'Y S PSSOUT=1 Q
 W @IOF W !!?5,"ADDITIVE SUMMARY" W ?67,"PAGE: "_$G(PSSCOT) S PSSCOT=PSSCOT+1
 Q
SOLH ;
 I '$G(PSSCOTX) D  Q:$G(PSSOUT)  W @IOF W !?5,"SOLUTION REPORT   (Solution Internal number in parenthesis)",?67,"PAGE: "_$G(PSSCOT) S PSSCOT=PSSCOT+1 Q
 .I $G(PSSDV)="C",$G(PSSCOT)'=1 K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSOUT=1
 I $G(PSSDV)="C" K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 W @IOF W !?8,"SOLUTION "_$S('$G(PSSSOSUM):"REPORT",1:"SUMMARY")_"   (continued)" W ?67,"PAGE: "_$G(PSSCOT) S PSSCOT=PSSCOT+1
 Q
SOLHS ;
 I $G(PSSDV)="C" K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 W @IOF W !!?5,"SOLUTION SUMMARY" W ?67,"PAGE: "_$G(PSSCOT) S PSSCOT=PSSCOT+1
 Q
PDIR ;
 Q:$G(PSSDV)'="C"
 W ! S DIR(0)="E",DIR("A")="Pres Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSOUT=1
 Q
