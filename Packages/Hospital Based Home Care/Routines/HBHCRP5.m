HBHCRP5 ;LR VAMC(IRMS)/MJT - HBHC report on file 631 (Discharge); May 22, 2021@15:09
 ;;1.0;HOSPITAL BASED HOME CARE;**2,5,6,22,25,32**;NOV 01, 1993;Build 58
 ;
 ; This routine references the following supported ICRs:
 ; 5747    $$CODEC^ICDEX
 ;
PROMPT ; Prompt user for patient name
 K DIC S DIC="^HBHC(631,",DIC(0)="AEMQZ" D ^DIC
 G:Y=-1 EXIT
 S HBHCDFN=+Y,HBHCY0=Y(0),%ZIS="Q" K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCRP5",ZTDESC="HBPC Patient Discharge Data Report",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 S $P(HBHCY,"-",81)="",HBHCHOSP=$S($P(^HBHC(631.9,1,0),U,5)]"":$E($P($G(^DIC(4,$P(^HBHC(631.9,1,0),U,5),99)),U),1,7),1:""),HBHCHEAD="Patient Discharge Data",HBHCCOLM=(80-(20+$L(HBHCHEAD))\2) S:HBHCCOLM'>0 HBHCCOLM=1
 N HBHCHOSPX
 S HBHCHOSPX=""
 ;Find patient's parent site
 D PARENT^HBHCUTL1
 ;strip off spaces added by HBHCUTL1
 S HBHCHOSPX=$P(HBHCHOSPX," ")
 ;If patient does not have a parent site, use default site.
 ;(The patient might have been admitted before the install of HBH*1.0*32.)
 I HBHCHOSPX="" S HBHCHOSPX=HBHCHOSP
 D TODAY^HBHCUTL
 W ?HBHCCOLM,">>> HBPC ",HBHCHEAD," Report <<<" W !!,"Run Date: ",HBHCTDY,!!,HBHCZ
PROCESS ; Process record
 S HBHCDPT0=^DPT(+(HBHCY0),0),HBHCNOD1=$G(^HBHC(631,HBHCDFN,1))
 W !,"Patient Name:  ",$P(HBHCDPT0,U),?46,"Last Four:",?58,$E($P(HBHCDPT0,U,9),6,9),!,HBHCZ
 ;HBH*1.0*32 - Display patient's parent site as Hospital Number.
 W !," 1.  Hospital Number:",?29,$J(HBHCHOSPX,7),?38,"|"
 W ?41,"20.  Primary Diagnosis @ D/C:",?72,$J($S($P(HBHCY0,U,47)]"":$$CODEC^ICDEX(80,$P(HBHCY0,U,47)),1:""),8),!,HBHCY
 W !," 2.  Discharge Date:",?28,$S($P(HBHCY0,U,40)]"":$E($P(HBHCY0,U,40),4,5)_"-"_$E($P(HBHCY0,U,40),6,7)_"-"_$E($P(HBHCY0,U,40),2,3),1:""),?38,"|",?41,"21.  Secondary Diagnoses @ D/C:"
 I HBHCNOD1]"" W:$P(HBHCNOD1,U,16)]"" !?38,"|",?46,$P(HBHCNOD1,U,16)
 W !,HBHCY
 W !," 3.  Eligibility @ Discharge:",?34,$P(HBHCY0,U,41),?38,"|",?41,"22.  Vision @ Discharge:",?79,$P(HBHCY0,U,48),!,HBHCY
 W !," 4.  Marital Status @ Discharge:",?35,$P(HBHCY0,U,42),?38,"|",?46,"Hearing @ Discharge:",?79,$P(HBHCY0,U,49),!,HBHCY
 W !," 5.  Living Arrangements @ D/C:",?35,$P(HBHCY0,U,43),?38,"|",?41,"23.  Expressive Communication @ D/C:",?79,$P(HBHCY0,U,50),!,HBHCY
 W !," 6.  Discharge Status:",?35,$P(HBHCY0,U,44),?38,"|",?41,"24.  Receptive Communication @ D/C:",?79,$P(HBHCY0,U,51),!,HBHCY
 W !," 7.  Transfer Destination:",?35,$P(HBHCY0,U,45),?38,"|",?41,"25.  Bathing @ Discharge:",?79,$P(HBHCY0,U,52),!,HBHCY
 W !," 8.  Type of Destination Agency:",?35,$P(HBHCY0,U,46),?38,"|",?46,"Dressing @ Discharge:",?79,$P(HBHCY0,U,53),!,HBHCY
 W !," 9.  Cause of Death:",?38,"|",?46,"Toilet Usage @ Discharge:",?79,$P(HBHCY0,U,54) I HBHCNOD1]"" W:$P(HBHCNOD1,U,15)]"" !?5,$P(HBHCNOD1,U,15),?38,"|"
 W !,HBHCY
 W !?5,"Name:",?25,$S($P(HBHCY0,U,18)]"":$E($P(HBHCY0,U,18),4,5)_$E($P(HBHCY0,U,18),6,7)_$E($P(HBHCY0,U,18),2,3),1:"")_$E($P(HBHCDPT0,U),1,5),?38,"|",?46,"Transferring @ Discharge:",?79,$P(HBHCY0,U,55),!,HBHCY
 W !?5,"Last Four:",?25,$E($P(HBHCDPT0,U,9),6,9),?38,"|",?46,"Eating @ Discharge:",?79,$S($P(HBHCNOD1,U)]"":$P(HBHCNOD1,U),1:""),!,HBHCY
 W !?38,"|",?46,"Walking @ Discharge:",?79,$S($P(HBHCNOD1,U,2)]"":$P(HBHCNOD1,U,2),1:""),!,HBHCY
 W !?38,"|",?41,"26.  Bowel Continence @ Discharge:",?79,$S($P(HBHCNOD1,U,3)]"":$P(HBHCNOD1,U,3),1:""),!,HBHCY
 W !?38,"|",?46,"Bladder Continence @ Discharge:",?79,$S($P(HBHCNOD1,U,4)]"":$P(HBHCNOD1,U,4),1:""),!,HBHCY
 W !?38,"|",?41,"27.  Mobility @ Discharge:",?79,$S($P(HBHCNOD1,U,5)]"":$P(HBHCNOD1,U,5),1:""),!,HBHCY
 W !?38,"|",?41,"28.  Adaptive Tasks @ Discharge:",?79,$S($P(HBHCNOD1,U,6)]"":$P(HBHCNOD1,U,6),1:""),!,HBHCY
 W !?38,"|",?41,"29.  Behavior Problems @ Discharge:",?79,$S($P(HBHCNOD1,U,7)]"":$P(HBHCNOD1,U,7),1:""),!,HBHCY
 W !?38,"|",?41,"30.  Disorientation @ Discharge:",?79,$S($P(HBHCNOD1,U,8)]"":$P(HBHCNOD1,U,8),1:""),!,HBHCY
 W !?38,"|",?41,"31.  Mood Disturbance @ Discharge:",?79,$S($P(HBHCNOD1,U,9)]"":$P(HBHCNOD1,U,9),1:""),!,HBHCY
 W !?38,"|",?41,"32.  Caregiver Limitations @ D/C:",?79,$S($P(HBHCNOD1,U,10)]"":$P(HBHCNOD1,U,10),1:""),!,HBHCY
 W !?38,"|",?41,"33.  Person Completing Discharge:",?76,$J($S($P(HBHCNOD1,U,11)]"":$P(^HBHC(631.4,$P(HBHCNOD1,U,11),0),U),1:""),4),!,HBHCY
 W !?38,"|",?46,"Date Discharge Completed:",?72,$S($P(HBHCNOD1,U,12)]"":$E($P(HBHCNOD1,U,12),4,5)_"-"_$E($P(HBHCNOD1,U,12),6,7)_"-"_$E($P(HBHCNOD1,U,12),2,3),1:""),!,HBHCY
EXIT ; Exit module
 D ^%ZISC
 K DIC,HBHCCOLM,HBHCDFN,HBHCDPT0,HBHCHEAD,HBHCHOSP,HBHCNOD1,HBHCTDY,HBHCY,HBHCY0,HBHCZ,Y
 Q
