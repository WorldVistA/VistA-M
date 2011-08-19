RANMUSE3 ;HISC/SWM-Nuclear Medicine Usage reports ;10/20/97  11:09
 ;;5.0;Radiology/Nuclear Medicine;**65**;Mar 16, 1998;Build 8
PGHD ; Page Header
 I RAPG!($E(IOST,1,2)="C-") W:$Y>0 @IOF
 S RAPG=RAPG+1
 W !?35,">>> "_RATITLE_" Report <<<",?90,"Run Date: ",RATDY
 W ?121,"Page: ",RAPG
 W !?50,$S($G(RAHDTYP)="D":"(Division",$G(RAHDTYP)="I":"(Imaging",1:"") W:$G(RAHDTYP)]"" " Summary)"
 W ?85,"For: ",RADTBEG("X")," - ",RADTEND("X")
 W !,"Division: ",RANUMD(RASEQD) W:$G(RAHDTYP)'="D" ?45,"Imaging Type: ",RANUMI(RASEQI)
 Q
COLHD ; Column Header for detailed report
 W !!,"Long-Case@Time",?16,"Patient Name",?35,"SSN",?44,"Radiopharm",?59,"Act.Drawn",?69,"Dose Adm'd",?83,"Low",?93,"High",?100,"Procedure",?116,"Who Adm'd"
 W !,RALN
 Q
COLHDS ; Column Header for summary report
 W !!,$S(RATITLE["Usage":"Radiopharm",1:"Who Admin Dose"),?35,"Total Drawn",?50,"Total Adm'd",?64,"No. cases",?79,"(%)",?90,"No. outside range"
 W !,RALN
 Q
SUM S RAXIT=$$EOS^RAUTL5 Q:RAXIT
 S RA0=0
SM0 S RA0=$O(^TMP($J,"RATUNIQ",RA0)) Q:'RA0  S RA1=0
SM2 S RA1=$O(^TMP($J,"RATUNIQ",RA0,RA1)) I RA1'=+RA1 D DIVSUM Q:RAXIT  G SM0
 ; if RA1 is alpha, then node is for division summary
 ; if RA1 is numeric, then node is for imaging summary
 S RASEQD=RA0,RASEQI=RA1
 S RAHDTYP="I" D PGHD,COLHDS
SM3 S RA2=$O(^TMP($J,"RATUNIQ",RA0,RA1,RA2)) I RA2="" D FOOTIMG S RAXIT=$$EOS^RAUTL5 Q:RAXIT  G SM2
 W !,$E(RA2,1,30)
 W ?30,$J($G(^TMP($J,"RATDRAWN",RA0,RA1,RA2)),15,4)
 W ?45,$J($G(^TMP($J,"RATDOSE",RA0,RA1,RA2)),15,4)
 W ?64,$J($G(^TMP($J,"RATUNIQ",RA0,RA1,RA2)),7)
 W ?78,$J(100*$S(+$G(^TMP($J,"RATUNIQ",RA0,RA1))=0:0,1:$G(^TMP($J,"RATUNIQ",RA0,RA1,RA2))/^TMP($J,"RATUNIQ",RA0,RA1)),5,2)
 W ?90,$J($G(^TMP($J,"RATOUTSD",RA0,RA1,RA2)),7)
 I ($Y+4)>IOSL!(RAPG=0) S RAXIT=$$EOS^RAUTL5 Q:RAXIT  D PGHD,COLHDS
 G SM3
DIVSUM ;
 ; skip div summary page if div has only 1 img typ
 Q:$O(^TMP($J,"RATUNIQ",RA0,0))=$O(^TMP($J,"RATUNIQ",RA0,"A"),-1)
 S RAHDTYP="D",RA2="A"
 D PGHD,COLHDS
DV1 S RA2=$O(^TMP($J,"RATUNIQ",RA0,RA2))
 I RA2="" D FOOTDIV S RAXIT=$$EOS^RAUTL5 Q
 W !,$E(RA2,1,30)
 W ?30,$J($G(^TMP($J,"RATDRAWN",RA0,RA2)),15,4)
 W ?45,$J($G(^TMP($J,"RATDOSE",RA0,RA2)),15,4)
 W ?64,$J($G(^TMP($J,"RATUNIQ",RA0,RA2)),7)
 W ?78,$J(100*$S(+$G(^TMP($J,"RATUNIQ",RA0))=0:0,1:$G(^TMP($J,"RATUNIQ",RA0,RA2))/^TMP($J,"RATUNIQ",RA0)),5,2)
 W ?90,$J($G(^TMP($J,"RATOUTSD",RA0,RA2)),7)
 I ($Y+4)>IOSL!(RAPG=0) S RAXIT=$$EOS^RAUTL5 Q:RAXIT  D PGHD,COLHDS
 G DV1
FOOTDIV ; footnotes division
 W !!,RANUMD(RASEQD),"'s Total number of unique cases: ",^TMP($J,"RATUNIQ",RA0)
 D FOOT Q
FOOTIMG ; footnotes img type
 W !!,RANUMI(RASEQI),"'s Total number of unique cases: ",^TMP($J,"RATUNIQ",RA0,RA1)
 D FOOT Q
FOOT W !!,"Notes: A case may have more than 1 radiopharm, so total no. unique cases may be less than total no. radiopharms listed."
 W !,"     *  denotes administered dosage outside of normal range."
 Q:RAINPUT
 W !!,$S(RATITLE["Usage":"Radiopharm",1:"Dose administerers")," selected for this report :" W !?6
 S RA2=0 F  S RA2=$O(^TMP($J,"RA EITHER",RA2)) Q:RA2=""  W:$X+$L(RA2)>(IOM+2) !?6 W RA2 W:$O(^(RA2))]"" ", "
 Q
ZERO ; zero out total for imaging type(s) and associated division(s) w/o data
 S RA0=""
Z1 S RA0=$O(^TMP($J,"RA D-TYPE",RA0)) Q:RA0']""  S RA1=""
Z2 S RA1=$O(RACCESS(DUZ,"DIV-IMG",RA0,RA1)) G:RA1']"" Z1
 G:'$D(^TMP($J,"RA I-TYPE",RA1)) Z2
 S:'$D(^TMP($J,"RATUNIQ",RASEQD(RA0),RASEQI(RA1))) ^TMP($J,"RATUNIQ",RASEQD(RA0),RASEQI(RA1))=0
 S:'($D(^TMP($J,"RATUNIQ",RASEQD(RA0)))#2) ^TMP($J,"RATUNIQ",RASEQD(RA0))=0
 G Z2
