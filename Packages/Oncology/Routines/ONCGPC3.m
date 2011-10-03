ONCGPC3 ;Hines OIFO/GWB - 2001 Gastric Cancers PCE Study ;03/08/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;First Course of Treatment 
 S SUR=$$GET1^DIQ(165.5,ONCONUM,58.2)
 S RAD=$$GET1^DIQ(165.5,ONCONUM,51.2,"I")
 S CHE=$$GET1^DIQ(165.5,ONCONUM,53.2,"I")
 S IMM=$$GET1^DIQ(165.5,ONCONUM,55.2,"I")
 K DR S DIE="^ONCO(165.5,",DA=ONCONUM,DR=""
 W @IOF D HEAD^ONCGPC0
 W !," FIRST COURSE OF TREATMENT - SURGERY"
 W !," -----------------------------------"
 S DR(1,165.5,3)="I (SUR="""")!($E(SUR,1,2)=""00"")!($E(SUR,1,2)=99) D NOSUR^ONCGPC3 S Y=$S($D(DUOUT):""@99"",1:""@38"")"
 S DR(1,165.5,4)="1556 28. ADHERENCE OF RESECTED PRIMARY                                                    SPECIMEN....................."
 S DR(1,165.5,5)="W !"
 S DR(1,165.5,6)="1557 29. MARGIN STATUS OF RESECTED                                                        PRIMARY SPECIMEN............."
 S DR(1,165.5,7)="W !"
 S DR(1,165.5,8)="W !,"" 30. EXTENT OF FREE MARGIN:"""
 S DR(1,165.5,9)="1558      PROXIMAL MARGIN.............."
 S DR(1,165.5,10)="1558.1      DISTAL MARGIN................"
 S DR(1,165.5,11)="W !"
 S DR(1,165.5,12)="W !,"" 31. RESECTION BEYOND STOMACH:"""
 S DR(1,165.5,13)="1559      SPLEEN......................."
 S DR(1,165.5,14)="1559.1      TRANVERSE COLON.............."
 S DR(1,165.5,15)="1559.2      LIVER........................"
 S DR(1,165.5,16)="1559.3      DIAPHRAGM...................."
 S DR(1,165.5,17)="1559.4      PANCREAS....................."
 S DR(1,165.5,18)="1559.5      ABDOMINAL WALL..............."
 S DR(1,165.5,19)="1559.6      ADRENAL GLAND................"
 S DR(1,165.5,20)="1559.7      KIDNEY......................."
 S DR(1,165.5,21)="1559.8      SMALL INTESTINE.............."
 S DR(1,165.5,22)="1559.9      RETROPERITONEUM.............."
 S DR(1,165.5,23)="1560      PERIGASTRIC LYMPH NODES......"
 S DR(1,165.5,24)="1560.1      COMMON HEPATIC LYMPH NODES..."
 S DR(1,165.5,25)="1560.2      CELIAC LYMPH NODES..........."
 S DR(1,165.5,26)="1560.3      SPLENIC LYMPH NODES.........."
 S DR(1,165.5,27)="1560.4      OTHER INTRA-ABDOMINAL NODES.."
 S DR(1,165.5,28)="W !"
 S DR(1,165.5,29)="1561 32. GROSSLY INVOLVED REGIONAL                                                        LYMPH NODES.................."
 S DR(1,165.5,30)="W !"
 S DR(1,165.5,31)="1562 33. HCT (HEMATOCRIT) VALUES BEFORE                                                   TRANSFUSION.................."
 S DR(1,165.5,32)="W !"
 S DR(1,165.5,33)="1563 34. TOTAL OPERATIVE BLOOD                                                            REPLACEMENT.................."
 S DR(1,165.5,34)="W !"
 S DR(1,165.5,35)="1564 35. INTRA/PERI-OPERATIVE DEATH...."
 S DR(1,165.5,36)="W !"
 S DR(1,165.5,37)="W !,"" 36. COMPLICATIONS REQUIRING RE-OPERATION:"""
 S DR(1,165.5,38)="1565      ANASTOMOTIC LEAK............."
 S DR(1,165.5,39)="1565.1      STUMP LEAK..................."
 S DR(1,165.5,40)="1565.2      BLEEDING....................."
 S DR(1,165.5,41)="1565.3      WOUND INFECTION.............."
 S DR(1,165.5,42)="1565.4      SEPSIS......................."
 S DR(1,165.5,43)="1565.5      PANCREATITIS................."
 S DR(1,165.5,44)="1565.6      DEAD BOWEL..................."
 S DR(1,165.5,45)="1565.7      OTHER........................"
 S DR(1,165.5,46)="W !"
 S DR(1,165.5,47)="1566 37. DATE OF SURGICAL DISCHARGE...."
 S DR(1,165.5,48)="W ! K DIR S DIR(0)=""E"" D ^DIR S Y=""@38"" S:$D(DUOUT) Y=""@99"""
 S DR(1,165.5,49)="@38"
 S DR(1,165.5,50)="D HEAD^ONCGPC0"
 S DR(1,165.5,51)="W !,"" FIRST COURSE OF TREATMENT - RADIATION"""
 S DR(1,165.5,52)="W !,"" -------------------------------------"""
 S DR(1,165.5,53)="I (RAD="""")!(RAD=0)!(RAD=9) D NORAD^ONCGPC3 S Y=$S($D(DUOUT):""@99"",1:""@42"")"
 S DR(1,165.5,54)="442 38. REGIONAL DOSE (cGy)..........."
 S DR(1,165.5,55)="W !"
 S DR(1,165.5,56)="1575 39. BOOST DOSE (cGy).............."
 S DR(1,165.5,57)="W !"
 S DR(1,165.5,58)="1567 40. INTRA-OPERATIVE RADIATION                                                        THERAPY, DOSE (cGy).........."
 S DR(1,165.5,59)="W !"
 S DR(1,165.5,60)="1568 41. CONCURRENT CHEMOTHERAPY......."
 S DR(1,165.5,61)="W ! K DIR S DIR(0)=""E"" D ^DIR S Y=""@42"" S:$D(DUOUT) Y=""@99"""
 S DR(1,165.5,62)="@42"
 S DR(1,165.5,63)="D HEAD^ONCGPC0"
 S DR(1,165.5,64)="W !,"" FIRST COURSE OF TREATMENT - CHEMOTHERAPY"""
 S DR(1,165.5,65)="W !,"" ----------------------------------------"""
 S DR(1,165.5,66)="I (CHE="""")!(CHE=0)!(CHE=9) D NOCHE^ONCGPC3 S Y=$S($D(DUOUT):""@99"",1:""@46"")"
 S DR(1,165.5,67)="W !,"" 42. TYPE OF CHEMOTHERAPEUTIC AGENTS ADMINISTERED:"""
 S DR(1,165.5,68)="1576      AGENT #1....................."
 S DR(1,165.5,69)="1576.1      AGENT #2....................."
 S DR(1,165.5,70)="1576.2      AGENT #3....................."
 S DR(1,165.5,71)="W !"
 S DR(1,165.5,72)="1569 43. INTRAPERITONEAL CHEMOTHERAPY.."
 S DR(1,165.5,73)="W !"
 S DR(1,165.5,74)="1577 44. CHEMOTHERAPEUTIC TOXICITY....."
 S DR(1,165.5,75)="W !"
 S DR(1,165.5,76)="1578 45. CHEMOTHERAPY/SURGERY SEQUENCE."
 S DR(1,165.5,77)="W ! K DIR S DIR(0)=""E"" D ^DIR S Y=""@46"" S:$D(DUOUT) Y=""@99"""
 S DR(1,165.5,78)="@46"
 S DR(1,165.5,79)="D HEAD^ONCGPC0"
 S DR(1,165.5,80)="W !,"" FIRST COURSE OF TREATMENT - IMMUNOTHERAPY"""
 S DR(1,165.5,81)="W !,"" -----------------------------------------"""
 S DR(1,165.5,82)="I (IMM="""")!(IMM=0)!(IMM=9) D NOIMM^ONCGPC3 S Y=""@99"""
 S DR(1,165.5,83)="1570 46. ADMINSTRATION OF INTERFERON..."
 S DR(1,165.5,84)="@99"
 D ^DIE
 K DR
 W ! K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
EXIT K DIC,DR,DA,DIQ,DIE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K SUR,RAD,CHE,IMM
 Q
NOSUR ;No surgery
 F PIECE=71:1:74 S $P(^ONCO(165.5,D0,"GAS1"),U,PIECE)=""
 F PIECE=1:1:28 S $P(^ONCO(165.5,D0,"GAS2"),U,PIECE)=""
 W !," No surgery of the primary site was performed."
 W !," Proceed to data item 38."
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DUOUT) Y="@99"
 K PIECE
 Q
NORAD ;No radiation
 S $P(^ONCO(165.5,D0,"THY1"),U,43)=0
 S $P(^ONCO(165.5,D0,"GAS2"),U,42)="00000"
 S $P(^ONCO(165.5,D0,"GAS2"),U,29)="00000"
 S $P(^ONCO(165.5,D0,"GAS2"),U,30)=""
 W !," No radiation therapy was administered."
 W !," Code data items 38-40 to 00000."
 W !," Do not answer data item 41, and proceed to data item 42."
 W !
 W !," 38. REGIONAL DOSE (cGy)...........: 00000"
 W !
 W !," 39. BOOST DOSE (cGy)..............: Not administered"
 W !
 W !," 40. INTRA-OPERATIVE RADIATION"
 W !,"      THERAPY, DOSE (cGy)..........: Not administered"
 W !
 W !," 41. CONCURRENT CHEMOTHERAPY.......:"
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DUOUT) Y="@99"
 Q
NOCHE ;No chemotherapy
 W !," No chemotherapy was administered."
 W !," Proceed to data item 46."
 S $P(^ONCO(165.5,D0,"GAS2"),U,43)=""
 S $P(^ONCO(165.5,D0,"GAS2"),U,44)=""
 S $P(^ONCO(165.5,D0,"GAS2"),U,45)=""
 S $P(^ONCO(165.5,D0,"GAS2"),U,31)=""
 S $P(^ONCO(165.5,D0,"GAS2"),U,46)=""
 S $P(^ONCO(165.5,D0,"GAS2"),U,47)=""
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DUOUT) Y="@99"
 Q
NOIMM ;No immunotherapy
 W !," No immunotherapy administered."
 W !," Proceed to Treatment Complications."
 S $P(^ONCO(165.5,D0,"GAS2"),U,32)=""
 Q
