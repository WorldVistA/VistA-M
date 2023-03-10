HBHCRP2 ;LR VAMC(IRMS)/MJT - HBHC report on file 631; May 22, 2021@14:49
 ;;1.0;HOSPITAL BASED HOME CARE;**1,2,5,6,9,19,22,25,32**;NOV 01, 1993;Build 58
 ;
 ; This routine references the following supported ICRs:
 ; 5747    $$CODEC^ICDEX
 ;
PROMPT ; Prompt user for patient name
 K DIC S DIC="^HBHC(631,",DIC(0)="AEMQZ" D ^DIC
 G:Y=-1 EXIT
 S HBHCDFN=+Y,HBHCY0=Y(0),%ZIS="Q" K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCRP2",ZTDESC="HBPC Patient Evaluation/Admission Data Report",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 N HBHCHOSPX
 S HBHCHOSPX=""
 ;Find patient's parent site
 D PARENT^HBHCUTL1
 ;strip off spaces added by HBHCUTL1
 S HBHCHOSPX=$P(HBHCHOSPX," ")
 ;If patient does not have a parent site, use default site.
 ;(The patient might have been admitted before the install of HBH*1.0*32.)
 I HBHCHOSPX="" S HBHCHOSPX=$S($P(^HBHC(631.9,1,0),U,5)]"":$E($P($G(^DIC(4,$P(^HBHC(631.9,1,0),U,5),99)),U),1,7),1:"")
 S $P(HBHCY,"-",81)="",HBHCHEAD="Patient Evaluation/Admission Data",HBHCCOLM=(80-(20+$L(HBHCHEAD))\2) S:HBHCCOLM'>0 HBHCCOLM=1
 D TODAY^HBHCUTL
 W ?HBHCCOLM,">>> HBPC ",HBHCHEAD," Report <<<" W !!,"Run Date: ",HBHCTDY,!!,HBHCZ
PROCESS ; Process record
 S HBHCDPT0=^DPT(+(HBHCY0),0),HBHCNOD1=$G(^HBHC(631,HBHCDFN,1))
 W !,"Patient Name:  ",$P(HBHCDPT0,U),?46,"Last Four:",?58,$E($P(HBHCDPT0,U,9),6,9),!,HBHCZ
 ;HBH*1.0*32 - Display patient's parent site as Hospital Number.
 W !," 1.  Hospital Number:",?29,$J(HBHCHOSPX,7)
 W ?38,"|",?41,"20.  Primary Diagnosis @ Adm:",?72,$J($S($P(HBHCY0,U,19)]"":$$CODEC^ICDEX(80,$P(HBHCY0,U,19)),1:""),8),!,HBHCY
 W !," 2.  Date:",?28,$S($P(HBHCY0,U,18)]"":$E($P(HBHCY0,U,18),4,5)_"-"_$E($P(HBHCY0,U,18),6,7)_"-"_$E($P(HBHCY0,U,18),2,3),$P(HBHCY0,U,2)]"":$E($P(HBHCY0,U,2),4,5)_"-"_$E($P(HBHCY0,U,2),6,7)_"-"_$E($P(HBHCY0,U,2),2,3),1:"")
 W ?38,"|",?41,"21.  Secondary Diagnoses @ Adm:" I HBHCNOD1]"" W:$P(HBHCNOD1,U,14)]"" !?38,"|",?46,$P(HBHCNOD1,U,14)
 W !,HBHCY
 W !," 3.  State Code:",?34,$S($P(HBHCY0,U,3)]"":$P(^DIC(5,(+^HBHC(631.8,($P(HBHCY0,U,3)),0)),0),U,3),1:""),?38,"|",?41,"22.  Vision @ Admission:",?79,$P(HBHCY0,U,20),!,HBHCY
 S HBHCCNTY="" S:(($P(HBHCY0,U,3)]"")&($P(HBHCY0,U,4)]"")) HBHCCNTY=$P($G(^DIC(5,(+^HBHC(631.8,($P(HBHCY0,U,3)),0)),1,$P(HBHCY0,U,4),0)),U,3)
 W !," 4.  County Code:",?33,HBHCCNTY,?38,"|",?46,"Hearing @ Admission:",?79,$P(HBHCY0,U,21),!,HBHCY
 W !," 5.  ZIP Code:",?26,$J($E($P(HBHCY0,U,5),1,5)_$S($E($P(HBHCY0,U,5),6,9)]"":"-"_$E($P(HBHCY0,U,5),6,9),1:""),10),?38,"|",?41,"23.  Expressive Communication @ Adm:",?79,$P(HBHCY0,U,22),!,HBHCY
 W !," 6.  Eligibility @ Evaluation:",?34,$P(HBHCY0,U,6),?38,"|",?41,"24.  Receptive Communication @ Adm:",?79,$P(HBHCY0,U,23),!,HBHCY
 W !," 7.  Birth Year:",?32,$S($P(HBHCDPT0,U,3):1700+$E($P(HBHCDPT0,U,3),1,3),1:""),?38,"|",?41,"25.  Bathing @ Admission:",?79,$P(HBHCY0,U,24),!,HBHCY
 W !," 8.  Period of Service:",?34,$S($P(HBHCY0,U,8)]"":$P($G(^HBHC(631.7,$P(HBHCY0,U,8),0)),U),1:""),?38,"|",?46,"Dressing @ Admission:",?79,$P(HBHCY0,U,25),!,HBHCY
 W !," 9.  Sex:",?35,$S($P(HBHCDPT0,U,2)="M":1,1:2),?38,"|",?46,"Toilet Usage @ Admission:",?79,$P(HBHCY0,U,26),!,HBHCY
 ; Obsolete with Race/Ethnicity Info Jan 2003 mandate; commented out historical reference  mjt
 ;S HBHCRC=$S($P(HBHCDPT0,U,6)]"":$P(^DIC(10,$P(HBHCDPT0,U,6),0),U,2),1:"")
 ;W !,"10.  Race:",?35,$S(HBHCRC=6:1,HBHCRC=4:2,(HBHCRC=1)!(HBHCRC=2):3,HBHCRC=3:4,HBHCRC=5:5,1:9),?38,"|",?46,"Transferring @ Admission:",?79,$P(HBHCY0,U,27),!,HBHCY
 ; Field retained until VA Form 10-0014 modified to remove field  mjt
 W !,"10.  Race:  Obsolete Field  Jan 2003",?38,"|",?46,"Transferring @ Admission:",?79,$P(HBHCY0,U,27),!,HBHCY
 W !,"11.  Marital Status @ Evaluation:",?35,$P(HBHCY0,U,11),?38,"|",?46,"Eating @ Admission:",?79,$P(HBHCY0,U,28),!,HBHCY
 W !,"12.  Living Arrangements @ Eval:",?35,$P(HBHCY0,U,12),?38,"|",?46,"Walking @ Admission:",?79,$P(HBHCY0,U,29),!,HBHCY
 W !,"13.  Last Agency Providing Care:",?35,$P(HBHCY0,U,13),?38,"|",?41,"26.  Bowel Continence @ Admission:",?79,$P(HBHCY0,U,30),!,HBHCY
 W !,"14.  Type of Last Care Agency:",?35,$P(HBHCY0,U,14),?38,"|",?46,"Bladder Continence @ Admission:",?79,$P(HBHCY0,U,31),!,HBHCY
 W !,"15.  Referred While Inpatient:",?35,$P(HBHCNOD1,U,29),?38,"|",?41,"27.  Mobility @ Admission:",?79,$P(HBHCY0,U,32),!,HBHCY
 W !,"16.  Admit/Reject Action:",?35,$P(HBHCY0,U,15),?38,"|",?41,"28.  Adaptive Tasks @ Admission:",?79,$P(HBHCY0,U,33),!,HBHCY
 W !,"17.  Reject/Withdraw Reason:",?34,$S($P(HBHCY0,U,16)]"":$P(^HBHC(631.1,$P(HBHCY0,U,16),0),U),1:""),?38,"|",?41,"29.  Behavior Problems @ Admission:",?79,$P(HBHCY0,U,34),!,HBHCY
 W !,"18.  Reject/Withdraw Disposition:",?35,$P(HBHCY0,U,17),?38,"|",?41,"30.  Disorientation @ Admission:",?79,$P(HBHCY0,U,35),!,HBHCY
 W !,"19.  Last Four:",?25,$E($P(HBHCDPT0,U,9),6,9),?38,"|",?41,"31.  Mood Disturbance @ Admission:",?79,$P(HBHCY0,U,36),!,HBHCY
 W !?38,"|",?41,"32.  Caregiver Limitations @ Adm:",?79,$P(HBHCY0,U,37),!,HBHCY
 W !?38,"|",?41,"33.  Person Completing Eval/Adm:",?76,$J($S($P(HBHCY0,U,38)]"":$P(^HBHC(631.4,$P(HBHCY0,U,38),0),U),1:""),4),!,HBHCY
 W !?38,"|",?46,"Date Eval/Adm Completed:",?72,$S($P(HBHCY0,U,39)]"":$E($P(HBHCY0,U,39),4,5)_"-"_$E($P(HBHCY0,U,39),6,7)_"-"_$E($P(HBHCY0,U,39),2,3),1:""),!,HBHCY
 W !?38,"|",?46,"Case Manager:",?76,$J($S($P(HBHCNOD1,U,13)]"":$P(^HBHC(631.4,$P(HBHCNOD1,U,13),0),U),1:""),4),!,HBHCY
EXIT ; Exit module
 D ^%ZISC
 K DIC,HBHCCNTY,HBHCCOLM,HBHCDFN,HBHCDPT0,HBHCHEAD,HBHCNOD1,HBHCRC,HBHCTDY,HBHCY,HBHCY0,HBHCZ,Y
 Q
