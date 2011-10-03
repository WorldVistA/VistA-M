PXRRPCR3 ;HIN/MjK - Clinic Specfic Workload Reports - Demographics ;6/7/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
DEMOGR D SET^PXRRPCR4,DEMOG^PXRRPCR S PXRS=1
 I '$D(^TMP($J,"CLINIC TOTALS",PXRRCLIN)) W !?5,"o There were no encounters recorded for this clinic within the",!?7,"selected date range." G QT
 W ?2,"Number of patient encounters",?55,$P($J(PXRRRTVS,5,1),".")
 W ?65,"-",?74,"-"
 W !?2,"Number of clinic sessions",?55,$P($J(PXRRSESS,5,1),".")
 W ?65,"-",?74,"-"
 W !?2,"Number of patients per clinic session",?55,$J(PXRRPTSS,5,1)
 W ?65,"-",?74,"-"
 W !?2,"Median patient age in years",?55,$P($J(PXRRAG,5,1),".")
 W ?65,"-",?74,"-"
 W !?2,"Patients with:",?17,"Coronary Artery Disease",?55,$P($J(PXRRCAD,5,1),".")
 W ?64,$J(PXRR("CAD"),5,1),?73,$J(^TMP($J,"MEAN",5),5,1)
 W !?17,"Diabetes ",?55,$P($J(PXRRDM,5,1),".")
 W ?64,$J(PXRR("DM"),5,1),?73,$J(^TMP($J,"MEAN",7),5,1)
 W !?17,"Hypertension",?55,$P($J(PXRRHTN,5,1),".")
 W ?64,$J(PXRR("HTN"),5,1),?73,$J(^TMP($J,"MEAN",9),5,1)
 W !?17,"Hyperlipidemia",?55,$P($J(PXRRHLIP,5,1),".")
 W ?64,$J(PXRR("HLIP"),5,1),?73,$J(^TMP($J,"MEAN",25),5,1)
 W !?17,"Diabetes and Hypertension",?55,$P($J(PXRRHTDM,5,1),".")
 W ?64,$J(PXRR("HTDM"),5,1),?73,$J(^TMP($J,"MEAN",11),5,1)
 W ! F L=1:1:IOM W "_"
 D HOLD G:'+PXRS QT
 W ! D PREVMD^PXRRPCR D HOLD G:'+PXRS QT
 W !?2,"Patients who smoke.",?55,$P($J(PXRRSMYR,5,1),"."),?64,$J(PXRR("SMOKE"),5,1)
 W ?73,$J(^TMP($J,"MEAN",22),5,1) D HOLD G:'+PXRS QT
 W !?2,"Females >50 who had a mammogram in the last year",?55,$S(PXRR("MAMGRM")="N/A":"N/A",1:$P($J(PXRRMMYR,5,1),"."))
 W ?64,$S(PXRR("MAMGRM")="N/A":"N/A",1:$J(PXRR("MAMGRM"),5,1))
 W ?73,$S(PXRR("MAMGRM")="N/A":"N/A",1:$J(^TMP($J,"MEAN",23),5,1))
 W !?4,"(There were ",PXRRF50," females >50 years of age)."
 D HOLD G:'+PXRS QT
 W ! D QLM^PXRRPCR
QLM W !?2,"Average HBA1C of your patients with Diabetes",?64,$S(+PXRRHBA1:$J(PXRRHBA1,5,1),1:PXRRHBA1)
 W ?73,$S(+^TMP($J,"MEAN",12):$J(^TMP($J,"MEAN",12),5,1),1:^TMP($J,"MEAN",12))
 W !?2,"Patients with HBA1C> 7%",?64,$P($J(PXRRHBG7,5,1),".")
 W ?73,$J(^TMP($J,"MEAN",30),5,1)
 W !?2,"Patients w/ Coronary Artery Disease who smoke",?64,$P($J(PXRRCDSM,5,1),".")
 W ?73,$J(^TMP($J,"MEAN",13),5,1)
 W !?2,"Ave. LDL for patients with Coronary Artery Disease",?64,$S(+PXRRLDL:$J(PXRRLDL,5,1),1:PXRRLDL)
 W ?73,$S(^TMP($J,"MEAN",14)="N/A":"N/A",1:$J(^TMP($J,"MEAN",14),5,1))
 W !?5,"(",PXRRNOLD," of ",PXRRCDSX," pats. with CAD had no LDL results.)"
 W !?2,"Number of patients with:",?27,"Glucose >240",?64,$P($J(PXRRGL,5,1),".")
 W ?73,$J(^TMP($J,"MEAN",31),5,1)
 W !?27,"Cholesterol >200",?64,$P($J(PXRRCHOL,5,1),".")
 W ?73,$J(^TMP($J,"MEAN",32),5,1)
 W !?27,"Either a Systolic  bp >160 or",!?36,"Diastolic bp > 90"
 W ?64,$P($J(PXRRBPT,5,1),"."),?73,$J(^TMP($J,"MEAN",36),5,1)
 W !?2,"Unscheduled encounters per patient.",?64,$J(PXRR("SXUN"),5,1)
 W ?73,$J(^TMP($J,"MEAN",16),5,1)
 W !?2,"Emergency Room encounters per patient.",?64,$J(PXRR("SXER"),5,1)
 W ?73,$J(^TMP($J,"MEAN",17),5,1)
 W !?2,"Hospitalizations per patient.",?64,$J(PXRR("SXHP"),5,1)
 W ?73,$J(^TMP($J,"MEAN",18),5,1)
 D HOLD G:'+PXRS QT
 W ! F L=1:1:IOM W "_"
 W ! D UTIL^PXRRPCR
 W !?2,"Number of male patients",?64,$P($J(PXRRMPAT,5,1),".")
 W ?74,"-"
 W !?2,"Number of female patients",?64,$P($J(PXRRFPAT,5,1),".")
 W ?74,"-"
 W !?2,"Average number of encounters per patient",?64,$J(PXRRUTVS,5,1)
 W ?73,$J(^TMP($J,"MEAN",21),5,1)
 W !?2,"Average number of active outpt. medications per patient"
 W ?64,$J(PXRRPSUT,5,1)
 W ?73,$J(^TMP($J,"MEAN",34),5,1)
 W !?2,"Average pharmacy cost per patient",?61,"$",?64,$J(PXRRCOST,5,1)
 W ?73,$J(^TMP($J,"MEAN",35),5,1)
 D HOLD G:'+PXRS QT
QT D CLEAN^PXRRPCEQ Q
HOLD I (IOST?1"C-".E)&($Y>(IOSL-6)) S DIR(0)="E" D ^DIR K DIR S PXRS=+Y W:Y @IOF
 Q
