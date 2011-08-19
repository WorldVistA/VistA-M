YSCEN54 ;ALB/ASF,ALB/XAK,ALB/MJK-LONG PRINTOUT ;4/4/90  08:29 ;07/28/93 16:26
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
 ;
EN ;  Called from routine YSCEN5
 S YSEN=1,YY(0)=^DPT(YSDFN,0) D DEM^VADPT,PID^VADPT
 S Y(.11)=$G(^DPT(YSDFN,.11)),Y(.13)=$G(^(.13)),I=+$P(YY(0),U,3),Y(.362)=$G(^(.362)),Y(.361)=$P($G(^(.361)),U) I $D(^(.121)) S X=$S($P(^(.121),U,8):$P(^(.121),U,8),1:9999999) I DT'<$P(^(.121),U,7),DT'>X S Y(.11)=^(.121),YSADR=""
 S YSSSN=VA("PID"),YSBID=VA("BID")
 W @IOF,!,$P(YY(0),U),?32,"SSN: ",YSSSN,?58,"DOB: ",$S(I:$E(I,4,5)_"-"_$E(I,6,7)_"-"_(1700+$E(I,1,3)),1:"UNKNOWN")
 W !,$P(Y(.11),U),?32,"C-#: ",$S($D(^DPT(YSDFN,.31)):$P(^(.31),U,3),1:"Unknown"),?53,"Religion: ",$E($P($G(^DIC(13,+$P(YY(0),U,8),0)),U),1,17)
 W !,$P(Y(.11),U,4),?42,"Elig: " I $D(^DPT(YSDFN,.36)),$D(^DIC(8,+^(.36),0)) W $P(^(0),U)
 W !,$P($G(^DIC(5,+$P(Y(.11),U,5),0)),U)
 W "  ",$$ZIP4^YSPP(+YSDFN,9),?42,"HB:",$P(Y(.362),U,2),?55,"A&A:",$P(Y(.362),U)
 W !,"PHONE: ",$P(Y(.13),U),?42,"***ELIGIBILITY ",$S(Y(.361)="P":"PENDING VERIFICATION",Y(.361)="R":"PENDING RE-VERIFICATION",Y(.361)="V":"VERIFIED",1:"NOT VERIFIED"),"***"
 I $D(YSADR) S YSEND=$P(Y(.11),U,8) W !,"(Temporary Address - ",$S('YSEND:"no end date",1:"until "_$$FMTE^XLFDT(YSEND,"5ZD")),")" K YSADR,YSEND
 Q:'$D(^DPT(YSDFN,.33))  S Y(.33)=^(.33) W !!,"Emergency Contact: ",$P(Y(.33),U),?42,"E-Relationship: ",$P(Y(.33),U,2)
 W !,"E-Adress: ",$P(Y(.33),U,3),?42,"E-Phone: ",$P(Y(.33),U,9) W:$P(Y(.33),U,4)]"" !?10,$P(Y(.33),U,4),?42,$P(Y(.33),U,5) W !?3,$P(Y(.33),U,6),?$X+3
 W ?$X+3,$P($G(^DIC(5,+$P(Y(.33),U,7),0)),U,2),?$X+2,$$ZIP4^YSPP(+YSDFN,4) Q
 ;
ZZ ;  Called from routines YSCEN52, YSCEN53
 D HDD F ZZ=0:1:4,7 S @("G"_ZZ)=$G(^YSG("INP",DA,ZZ))
 I $P(G7,U,4) W !?10,"*** Current Admission ***",!
 W:G7 !,"Ward: ",$P(^DIC(42,+G7,0),U) W ?40,"Entry: " S Y=$P(G0,U,3) D ENDD^YSUTL W $P(Y,"  ")
 S Y=$P(G7,U,2) I Y?7N.E D ENDD^YSUTL W !?40,"Discharged: ",Y
 S Y=$P(G1,U) W !,$S(Y?1"v".E:"Voluntary patient",Y?1"i".E:"Involuntary patient",1:"Voluntary status undefined") S Y=$P(G1,U,2) W ?40,$S(Y?1"o".E:"Open ward",Y?1"c".E:"Closed ward",1:"open/closed undefined")
 S Y=$P(G1,U,3) I Y?1N W "  Level: ",Y
 W ! W:$P(G7,U,2) "Discharge " W "Team: ",$S($P(G0,U,4)?1N.N:$P(^YSG("SUB",$P(G0,U,4),0),U),1:"UNASSIGNED")
 W ?40,$S($P($G(^YSG("SUB",+$P(G0,U,4),0)),U,10):$P(^(0),U,10),1:"Staff"),": " S X=$P(G0,U,5) D:X?1N.E D3^YSCEN2
 I $P(G0,U,6)?1N.N!($P(G0,U,7)?1N.N) W !,"Physician: " S X=$P(G0,U,6) D:X?1N.N D3^YSCEN2 W ?40,"Resident: " S X=$P(G0,U,7) D:X?1N.N D3^YSCEN2
 I G1'=0 W !,"Hair: ",$P(G1,U,6),?15,"Eyes: ",$P(G1,U,7),?40,"Ht: ",$P(G1,U,8),?50,"Wt: ",$P(G1,U,9)
 I G2 W !,"Physical Description: ",G2
 W:G3 !,"** Medical Alert: ",G3 W:G4 !,"Special Diet: ",G4
PT ;
 W !,"Team history for this MH ward admission: " S X=0 F  S X=$O(^YSG("INP",DA,6,X)) Q:'X  S YSTP1=+^(X,0),Y=$P(^(0),U,2) W !?3,X,". ",$P(^YSG("SUB",YSTP1,0),U),"  on  " D DD^%DT W Y K YSTP1
COM ;
 D COM^YSCEN22 Q
HDD ;
 D ENPT^YSUTL S YY(0)=^DPT(YSDFN,0) I $Y+6>IOSL W @IOF G HDD1
 W ! F ZZ=1:1:10 W "========"
HDD1 ;
 W:'$D(YSEN) !,$P(YY(0),U),?32,"SSN: ",YSSSN,?58,"DOB: ",$S($P(YY(0),U,3):$$FMTE^XLFDT($P(YY(0),U,3),"5ZD"),1:"UNKNOWN")
 D:'$D(YSEN) CK^YSCEN5 K YSEN Q
