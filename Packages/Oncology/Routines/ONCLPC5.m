ONCLPC5 ;Hines OIFO/GWB - 2001 Lung (NSCLC) Cancers PCE Study ;03/08/01
 ;;2.11;ONCOLOGY;**29,30,33**;Mar 07, 1995
 ;First Course of Treatment 
 S SUR=$$GET1^DIQ(165.5,ONCONUM,58.2)
 S RAD=$$GET1^DIQ(165.5,ONCONUM,51.2,"I")
 S CHE=$$GET1^DIQ(165.5,ONCONUM,53.2,"I")
 K DR S DIE="^ONCO(165.5,",DA=ONCONUM,DR=""
 W @IOF D HEAD^ONCLPC0
 W !," FIRST COURSE OF TREATMENT - SURGERY"
 W !," -----------------------------------"
 S DR(1,165.5,1)="I (SUR="""")!($E(SUR,1,2)=""00"")!($E(SUR,1,2)=99) D NOSUR^ONCLPC5 S Y=$S($D(DUOUT):""@99"",1:""@19"")"
 S DR(1,165.5,2)="W !,"" 15. SCOPE OF OPERATIVE MEDIASTINAL LYMPH NODE ASSESSMENT:"""
 S DR(1,165.5,3)="1419      HIGHEST MEDIASTINAL (level 1)"
 S DR(1,165.5,4)="1419.1      UPPER PARATRACHEAL  (level 2)"
 S DR(1,165.5,5)="1419.2      PREVASCULAR AND RETROTRACHEAL                                                                       (level 3)"
 S DR(1,165.5,6)="1419.3      LOWER PARATRACHEAL  (level 4)"
 S DR(1,165.5,7)="1419.4      SUBAORTIC           (level 5)"
 S DR(1,165.5,8)="1419.5      PARAORTIC           (level 6)"
 S DR(1,165.5,9)="1419.6      SUBCARINAL          (level 7)"
 S DR(1,165.5,10)="1419.7      PARAESOPHAGEAL      (level 8)"
 S DR(1,165.5,11)="1419.8      PULMONARY LIGAMENT  (level 9)"
 S DR(1,165.5,12)="W !"
 S DR(1,165.5,13)="1430 16. HCT (HEMOCRIT) VALUES BEFORE                                                     TRANSFUSION.................."
 S DR(1,165.5,14)="W !"
 S DR(1,165.5,15)="1420 17. TOTAL PERI-OPERATIVE BLOOD                                                       REPLACEMENT.................."
 S DR(1,165.5,16)="W !"
 S DR(1,165.5,17)="1421 18. PERI-OPERATIVE DEATH.........."
 S DR(1,165.5,19)="W ! K DIR,OUT S DIR(0)=""E"" D ^DIR S Y=""@19"" I $D(DUOUT) S Y=""@99"",OUT=""Y"""
 S DR(1,165.5,20)="@19"
 S DR(1,165.5,21)="D HEAD^ONCLPC0"
 S DR(1,165.5,22)="W !,"" FIRST COURSE OF TREATMENT - RADIATION THERAPY"""
 S DR(1,165.5,23)="W !,"" ---------------------------------------------"""
 S DR(1,165.5,24)="I (RAD="""")!(RAD=0)!(RAD=9) D NORAD^ONCLPC5 S Y=$S($D(DUOUT):""@99"",1:""@26"")"
 S DR(1,165.5,25)="442 19. REGIONAL DOSE (cGy)..........."
 S DR(1,165.5,26)="W !"
 S DR(1,165.5,27)="56 20. NUMBER OF TREATMENTS TO THIS                                                     VOLUME......................."
 S DR(1,165.5,28)="W !"
 S DR(1,165.5,29)="363 21. REGIONAL TREATMENT MODALITY..."
 S DR(1,165.5,30)="W !"
 S DR(1,165.5,31)="51.3 22. RADIATION/SURGERY SEQUENCE...."
 S DR(1,165.5,32)="W !"
 S DR(1,165.5,33)="1422 23. BOOST DOSE (cGy).............."
 S DR(1,165.5,34)="W !"
 S DR(1,165.5,35)="127 24. INTENT OF RADIATION TREATMENT."
 S DR(1,165.5,36)="W !"
 S DR(1,165.5,37)="75 25. REASON FOR NO RADIATION......."
 S DR(1,165.5,38)="W ! K DIR,OUT S DIR(0)=""E"" D ^DIR S Y=""@26"" I $D(DUOUT) S Y=""@99"",OUT=""Y"""
 S DR(1,165.5,39)="@26"
 S DR(1,165.5,40)="D HEAD^ONCLPC0"
 S DR(1,165.5,41)="W !,"" FIRST COURSE OF TREATMENT - CHEMOTHERAPY"""
 S DR(1,165.5,42)="W !,"" ----------------------------------------"""
 S DR(1,165.5,43)="I (CHE="""")!(CHE=0)!(CHE=9) D NOCHE^ONCLPC5 S Y=""@99"""
 S DR(1,165.5,44)="W !,"" 26. TYPE OF CHEMOTHERAPEUTIC AGENTS ADMINISTERED:"""
 S DR(1,165.5,45)="1423      AGENT #1....................."
 S DR(1,165.5,46)="1423.1      AGENT #2....................."
 S DR(1,165.5,47)="1423.2      AGENT #3....................."
 S DR(1,165.5,48)="W !"
 S DR(1,165.5,49)="1424 27. CHEMOTHERAPEUTIC TOXICITY....."
 S DR(1,165.5,50)="W !"
 S DR(1,165.5,51)="1425 28. CHEMOTHERAPY/SURGERY SEQUENCE."
 S DR(1,165.5,53)="@99"
 D ^DIE
 W !
 G:$G(OUT)="Y" EXIT
 K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
EXIT K DIC,DR,DA,DIQ,DIE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K SUR,RAD,CHE
 Q
NOSUR ;No surgery
 F PIECE=16:1:26 S $P(^ONCO(165.5,D0,"LUN2"),U,PIECE)=""
 S $P(^ONCO(165.5,D0,"LUN2"),U,43)=""
 W !," No surgery of the primary site was performed."
 W !," Do not answer data items 15-18."
 W !," Proceed to data item 19."
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DUOUT) Y="@99",OUT="Y"
 K PIECE
 Q
NORAD ;No radiation
 S $P(^ONCO(165.5,D0,"LUN2"),U,27)="00000"
 W !," 19. REGIONAL DOSE (cGy)...........: ",$$GET1^DIQ(165.5,D0,442)
 W !
 W !," 20. NUMBER OF TREATMENTS TO THIS"
 W !,"      VOLUME.......................: ",$$GET1^DIQ(165.5,D0,56)
 W !
 W !," 21. REGIONAL TREATMENT MODALITY...: ",$$GET1^DIQ(165.5,D0,363)
 W !
 W !," 22. RADIATION/SURGERY SEQUENCE....: ",$$GET1^DIQ(165.5,D0,51.3)
 W !
 W !," 23. BOOST DOSE (cGy)..............: Not administered"
 W !
 W !," 24. INTENT OF RADIATION TREATMENT.: ",$$GET1^DIQ(165.5,D0,127)
 W !
 W !," 25. REASON FOR NO RADIATION.......: ",$$GET1^DIQ(165.5,D0,75)
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DUOUT) Y="@99",OUT="Y"
 Q
NOCHE ;No chemotherapy
 F PIECE=28:1:32 S $P(^ONCO(165.5,D0,"LUN2"),U,PIECE)=""
 W !," No chemotherapy was administered."
 W !," Do not answer data items 26-28."
 W !," Proceed to data item 29."
 K PIECE
 Q
