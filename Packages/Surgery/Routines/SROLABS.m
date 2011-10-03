SROLABS ;BIR/SJA - ENTER/EDIT RISK MODEL LAB TEST ;05/03/10
 ;;3.0; Surgery ;**166,174**;24 Jun 93;Build 8
EN N SRIEN,SRSP,SRTNM,SRTP,SRX,Y
 S SRSOUT=0 D LIST G:SRSOUT END
 D DSPLY G:SRSOUT END
 I SREDIT D EDIT
 G EN
END D ^SRSKILL K SREDIT,SRFIRST,SRLABNM,SRSPNM
 Q
LIST ; display test list
 W @IOF,!,?11,"Risk Model Lab Test (Enter/Edit)",!!," Select item to edit from list below:",!
 W !," 1. ALBUMIN",?32,"14. INR"
 W !," 2. ALKALINE PHOSPHATASE",?32,"15. LDL"
 W !," 3. ANION GAP",?32,"16. PLATELET COUNT"
 W !," 4. B-TYPE NATRIURETIC PEPTIDE",?32,"17. POTASSIUM"
 W !," 5. BUN",?32,"18. PT"
 W !," 6. CHOLESTEROL",?32,"19. PTT"
 W !," 7. CPK",?32,"20. SGOT"
 W !," 8. CPK-MB",?32,"21. SODIUM"
 W !," 9. CREATININE",?32,"22. TOTAL BILIRUBIN"
 W !,"10. HDL",?32,"23. TRIGLYCERIDE"
 W !,"11. HEMATOCRIT",?32,"24. TROPONIN I"
 W !,"12. HEMOGLOBIN",?32,"25. TROPONIN T"
 W !,"13. HEMOGLOBIN A1C",?32,"26. WHITE BLOOD COUNT",!
 K DIR S DIR("?")="Select the number from the list for the lab test you want to edit."
 S DIR(0)="NAO^1:26",DIR("A")="Enter number (1-26): " D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRSOUT=1 Q
 D TEST
 Q
EDIT ; update selected field
 W ! K DR,DIE,DA S DA=SRIEN,DIE=139.2,DR="[SROALAB]" D ^DIE K DA,DIE,DR
 Q
DSPLY ; display test information from file 139.2
 W @IOF,!,?11,"Risk Model Lab Test (Enter/Edit)",!!!,?16,"Test Name: "_SRLABNM,!!,"  Laboratory Data Name(s): "
 I '$O(^SRO(139.2,SRIEN,1,0)) W "NONE ENTERED"
 S SRX=0,SRFIRST=1 F  S SRX=$O(^SRO(139.2,SRIEN,1,SRX)) Q:'SRX  D
 .S SRTP=$P($G(^SRO(139.2,SRIEN,1,SRX,0)),"^"),Y=SRTP,C=$P(^DD(139.21,.01,0),"^",2) D Y^DIQ S SRTNM=Y
 .W:'SRFIRST ! W ?27,SRTNM S SRFIRST=0
 S SRSPNM="NONE ENTERED",SRSP=$P($G(^SRO(139.2,SRIEN,2)),"^") I SRSP S Y=SRSP,C=$P(^DD(139.2,2,0),"^",2) D Y^DIQ S SRSPNM=Y
 W !!,?17,"Specimen: ",SRSPNM,!!
 K DIR S DIR(0)="YA",DIR("A")="Do you want to edit this test ? ",DIR("B")="NO" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S SREDIT=Y
 Q
TEST ; match with entry in file 139.2
 I Y<14 S SRIEN=$S(Y=2:15,Y=3:26,Y=4:28,Y=5:8,Y=6:24,Y=7:9,Y=8:10,Y=9:7,Y=10:21,Y=11:17,Y=12:1,Y=13:27,1:11)
 I Y>13 S SRIEN=$S(Y=14:25,Y=15:23,Y=16:18,Y=17:5,Y=18:19,Y=19:20,Y=20:13,Y=21:4,Y=22:14,Y=23:22,Y=24:2,Y=25:3,1:16)
 S SRLABNM=$P(^SRO(139.2,SRIEN,0),"^")
 Q
