FBNHDEC ;AISC/GRR-DISPLAY EPISODE OF CARE ;25AUG88
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D HED F J=0:0 S J=$O(^FBAACNH("AC",IFN,J)) Q:J'>0  I $D(^FBAACNH(J,0)) S Z=^(0) D:$Y>(IOSL+4) HED S Y=$P(Z,"^",1),FBAAAD=Y,FBTYPE=$P(Z,"^",3) D PDATE^FBAAUTL D ADD:FBTYPE="A",TRAN:FBTYPE="T",DIS:FBTYPE="D"
 K J,Z Q
ADD S FBAT=$P(Z,"^",6) W !,FBPDT,?26,"Admission",?40,$P($T(ADDT+FBAT),";;",2) Q
TRAN S FBAT=$P(Z,"^",7) W !,FBPDT,?26,"Transfer",?40,$P($T(TRANT+FBAT),";;",2) Q
DIS S FBAT=$P(Z,"^",8) W !,FBPDT,?26,"Discharge",?40,$P($T(DIST+FBAT),";;",2) Q
HED W @IOF,"Veteran: ",$P(^DPT(DFN,0),"^",1),?43,"SSN: ",$$SSN^FBAAUTL(DFN),!,?5,"Date/Time",?25,"Transaction",?42,"Type",!
 Q
ADDT ;;
 ;;After Re-hospitalization > 15 Days
 ;;Transfer from Other CNH
 ;;From ASIH < 15 Days
 ;;All Other
TRANT ;;
 ;;To Authorized Absence
 ;;To Un-authorized Absence
 ;;To ASIH
 ;;From Authorized Absence
 ;;From Un-authorized Absence
 ;;From ASIH
DIST ;;
 ;;Regular
 ;;Death
 ;;Transfer to Other CNH
 ;;ASIH
 ;;Death While ASIH
 ;;Regular - Private Pay
