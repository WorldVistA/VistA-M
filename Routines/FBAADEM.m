FBAADEM ;AISC/DMK-DISPLAY PATIENT DEMOGRAPHICS ;2/12/2003
 ;;3.5;FEE BASIS;**52**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$D(IOSL) D HOME^%ZIS
 I $S('$D(DFN):1,'DFN:1,1:0) Q
 S VAPA("P")="" D 6^VADPT G END:VAERR
 S:'$D(IOF) IOF="#" S FBAAOUT=""
 I $E(IOST,1,2)="C-" W @IOF
 W !
 W:+VADM(6) !,*7,"*** Patient Died on ",$P(VADM(6),"^",2)
 W !,VADM(1),?39,"Pt.ID: ",$P(VADM(2),"^",2)
 W !,VAPA(1),?41,"DOB: ",$P(VADM(3),"^",2)
 I VAPA(2)]"" W !,VAPA(2)
 I VAPA(3)]"" W !,VAPA(3)
 W !,VAPA(4),?41,"TEL: ",$S(VAPA(8)]"":VAPA(8),1:"Not on File")
 W !,$P(VAPA(5),"^",2)_" "_$S('+$G(VAPA(11)):VAPA(6),$P(VAPA(11),U,2)]"":$P(VAPA(11),U,2),1:VAPA(6)),?37,"CLAIM #: ",$S(VAEL(7)]"":VAEL(7),1:"Not on File")
 S FBCOUNTY=$S($P(VAPA(7),"^",2)]"":$P(VAPA(7),"^",2),1:"Not on File")
 W !?38,"COUNTY: ",FBCOUNTY
 N FBCCADR S FBCCADR=$$CCADR^FBAACO0(0)
 D ELIG,DIS^DGRPDB
 I FBCCADR>0,$E(IOST,1,2)="C-" W ! S DIR(0)="E" D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1 D END Q
 D INS^DGRPDB
 I '$G(FBPHOUT) D ^FBUINS ;I $D(DIRUT) S FBAAOUT=1 D END Q
 I $G(FBPHOUT),$E(IOST,1,2)="C-" W ! S DIR(0)="E" D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1 D END Q
 I $E(IOST,1,2)="C-" W @IOF
 I $D(^FBAAA(DFN,0)) D ^FBAADEM1
 ;
END D KVA^VADPT K FBCOUNTY,FBDEL Q
 ;
ELIG N I,I1 W !!,"Primary Elig. Code: ",$P(VAEL(1),"^",2),"  --  ",$S(VAEL(8)']"":"NOT VERIFIED",1:$P(VAEL(8),"^",2))
 I VAEL(8)]"" S Y=$P($G(^DPT(DFN,.361)),"^",2) W "  " D DT^DIQ
 W !,"Other Elig. Code(s): " I $D(VAEL(1))>9 S (I,I1)=0 F  S I=$O(VAEL(1,I)) Q:'I  S I1=I1+1 W:I1>1 !?21 W $P(VAEL(1,I),"^",2)
 E  W "NO ADDITIONAL ELIGIBILITIES IDENTIFIED"
 Q
