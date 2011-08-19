YSDGDEM ;ALB/ASF,ALB/XAK,ALB/MJK-Patient Demographic Lookup ;3/28/90  14:09 ;07/28/93 15:36
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
P ;
 W ! S DIC="^DPT(",DIC(0)="QEAM" D ^DIC Q:Y<0  S YSDFN=+Y D EN G P
EN ;  Called by routine YSPPJ
 S DFN=YSDFN D DEM^VADPT,PID^VADPT
 S PTI(0)=^DPT(YSDFN,0),PTI(.11)=$G(^(.11)),PTI(.13)=$G(^(.13)),I=+$P(PTI(0),U,3),PTI(.362)=$G(^(.362)),PTI(.361)=$P($G(^(.361)),U),YSSSN=VA("PID")
 I $D(^DPT(YSDFN,.121)) S X=$S($P(^(.121),U,8):$P(^(.121),U,8),1:9999999) I DT'<$P(^(.121),U,7),DT'>X S PTI(.11)=^(.121),YSADFL=""
 I '$D(IOF) S IOP=IO D ^%ZIS K IOP
 W @IOF,!,VADM(1),?32,"SSN: ",YSSSN,?58,"DOB: ",$P(VADM(3),U,2)
 W !,$P(PTI(.11),U),?32,"C-#: ",$S($D(^DPT(YSDFN,.31)):$P(^(.31),U,3),1:"Unknown"),?53,"Religion: ",$E($E($G(^DIC(13,+$P(PTI(0),U,8),0)),U),1,17)
 W !,$P(PTI(.11),U,4),?42,"Elig: " I $D(^DPT(YSDFN,.36)),$D(^DIC(8,+^(.36),0)) W $P(^(0),U)
 W !,$P($G(^DIC(5,+$P(PTI(.11),U,5),0)),U)
 W "  ",$$ZIP4^YSPP(+YSDFN,1),?42,"HB:",$P(PTI(.362),U,2),?55,"A&A:",$P(PTI(.362),U)
 W !,"PHONE: ",$P(PTI(.13),U),?42,"***ELIGIBILITY ",$S(PTI(.361)="P":"PENDING VERIFICATION",PTI(.361)="R":"PENDING RE-VERIFICATION",PTI(.361)="V":"VERIFIED",1:"NOT VERIFIED"),"***"
 I $D(YSADFL) S YSEND=$P(PTI(.11),U,8) W !,"(Temporary Address - ",$S('YSEND:"no end date",1:"until "_$$FMTE^XLFDT(YSEND,"5ZD")),")" K YSADFL,YSEND
 G ^YSDGDEM0
