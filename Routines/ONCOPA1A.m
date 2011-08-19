ONCOPA1A ;Hines OIFO/GWB - PRINT COMPLETE ABSTRACT continued ;12/01/10
 ;;2.11;ONCOLOGY;**15,19,27,33,34,36,40,44,45,46,47,49,51,52**;Mar 07, 1995;Build 13
 ;
 I (COC=10)!(COC=11)!(COC=12)!(COC=13)!(COC=14),$E(TOP,3,4)=34 D
 .W !,"     Blood in Sputum Per Pt: ",ONCAB(165.5,IEN,174.1)," ",ONCAB(165.5,IEN,174) D P Q:EX=U
 .W !,"                    Dyspnea: ",ONCAB(165.5,IEN,186.1)," ",ONCAB(165.5,IEN,186) D P Q:EX=U
 .W !,"            Increased Cough: ",ONCAB(165.5,IEN,187.1)," ",ONCAB(165.5,IEN,187) D P Q:EX=U
 .W !,"                      Fever: ",ONCAB(165.5,IEN,188.1)," ",ONCAB(165.5,IEN,188) D P Q:EX=U
 .W !,"               Night Sweats: ",ONCAB(165.5,IEN,189.1)," ",ONCAB(165.5,IEN,189) D P Q:EX=U
 .W !,"         Weight Loss Per Pt: ",ONCAB(165.5,IEN,190) D P Q:EX=U
 .W !,"                Chest X-ray: ",ONCAB(165.5,IEN,175.1)," ",ONCAB(165.5,IEN,175) D P Q:EX=U
 .W !,"                    CT Scan: ",ONCAB(165.5,IEN,176.1)," ",ONCAB(165.5,IEN,176) D P Q:EX=U
 .W !,"               Bronchoscopy: ",ONCAB(165.5,IEN,177.1)," ",ONCAB(165.5,IEN,177) D P Q:EX=U
 .W !,"            Mediastinoscopy: ",ONCAB(165.5,IEN,178.1)," ",ONCAB(165.5,IEN,178) D P Q:EX=U
 .W !,"                   PET Scan: ",ONCAB(165.5,IEN,179.1)," ",ONCAB(165.5,IEN,179) D P Q:EX=U
 I (COC=10)!(COC=11)!(COC=12)!(COC=13)!(COC=14),($E(TOP,3,4)=18)!(TOP=67199)!(TOP=67209) D
 .W !,"    Ulcerative Colitis (UC): ",ONCAB(165.5,IEN,191) D P Q:EX=U
 .W !,"Familial Adenomatous Polyps: ",ONCAB(165.5,IEN,711) D P Q:EX=U
 .W !,"                      HNPCC: ",ONCAB(165.5,IEN,712) D P Q:EX=U
 .W !,"            Crohn's Disease: ",ONCAB(165.5,IEN,809) D P Q:EX=U
 .W !," Inflammatory Bowel Disease: ",ONCAB(165.5,IEN,713) D P Q:EX=U
 .W !,"            Sporadic Polyps: ",ONCAB(165.5,IEN,192) D P Q:EX=U
 .W !," Change Bowel Habits Per Pt: ",ONCAB(165.5,IEN,180.1)," ",ONCAB(165.5,IEN,180) D P Q:EX=U
 .W !,"    Fecal Occult Blood Test: ",ONCAB(165.5,IEN,181.1)," ",ONCAB(165.5,IEN,181) D P Q:EX=U
 .W !,"               Barium Enema: ",ONCAB(165.5,IEN,182.1)," ",ONCAB(165.5,IEN,182) D P Q:EX=U
 .W !,"              Sigmoidoscopy: ",ONCAB(165.5,IEN,183.1)," ",ONCAB(165.5,IEN,183) D P Q:EX=U
 .W !,"                Colonoscopy: ",ONCAB(165.5,IEN,185.1)," ",ONCAB(165.5,IEN,185) D P Q:EX=U
 .W !,"       CT of Abdomen/Pelvis: ",ONCAB(165.5,IEN,184.1)," ",ONCAB(165.5,IEN,184) D P Q:EX=U
 .W !,"                   PET Scan: ",ONCAB(165.5,IEN,179.1)," ",ONCAB(165.5,IEN,179) D P Q:EX=U
 ;
 S NAME="EXTENT OF DISEASE AT DIAGNOSIS" D FORMAT^ONCOPA1
 W !!,TITLE
 W !!,"   TNM Clinical:  ",ONCAB(165.5,IEN,37),?67,"TNM Pathologic:  ",ONCAB(165.5,IEN,89.1) D P Q:EX=U
 W !,"   Clinical T:  ",$E(ONCAB(165.5,IEN,37.1),1,48),?67,"Pathologic T:  ",$E(ONCAB(165.5,IEN,85),1,48) D P Q:EX=U
 W !,"   Clinical N:  ",$E(ONCAB(165.5,IEN,37.2),1,48),?67,"Pathologic N:  ",$E(ONCAB(165.5,IEN,86),1,48) D P Q:EX=U
 W !,"   Clinical M:  ",$E(ONCAB(165.5,IEN,37.3),1,48),?67,"Pathologic M:  ",$E(ONCAB(165.5,IEN,87),1,48) D P Q:EX=U
 W !,"   Stage Group Clinical:  ",ONCAB(165.5,IEN,38),$P(ONCAB(165.5,IEN,241,"E"),"(",1),?67,"Stage Group Pathologic:  ",ONCAB(165.5,IEN,88),$P(ONCAB(165.5,IEN,242,"E"),"(",1) D P Q:EX=U
 W !,"   Staged By (Clin):  ",ONCAB(165.5,IEN,19),?67,"Staged By (Path):  ",ONCAB(165.5,IEN,89) D P Q:EX=U
 W !,"   Lymphatic Vessel Invasion (L):  ",ONCAB(165.5,IEN,149) D P Q:EX=U
 W !,"   Venous Invasion (V):  ",ONCAB(165.5,IEN,151) D P Q:EX=U
 W !,"   Other Staging System:  ",ONCAB(165.5,IEN,39) D P Q:EX=U
 W !,"   Physician's Stage:  ",ONCAB(165.5,IEN,65),?67,"Physician Staging:  ",ONCAB(165.5,IEN,66) D P Q:EX=U
 W !,"   TNM Form Assigned:  ",ONCAB(165.5,IEN,25,"E"),?67,"TNM Form Completed:  ",ONCAB(165.5,IEN,44,"E") D P Q:EX=U
 W !!,"   Performance Status at Dx: ",ONCAB(165.5,IEN,227,"E") D P Q:EX=U
 W !,"   Tumor Size:  ",ONCAB(165.5,IEN,29) D P Q:EX=U
 W !,"   Extension:   ",ONCAB(165.5,IEN,30) D P Q:EX=U
 I $P($G(^ONCO(165.5,IEN,0)),U,16)>2971231 D
 .S TPX=$P($G(^ONCO(165.5,IEN,2)),U,1) I TPX'=67619 Q
 .W !,"   Pathologic Extension:  ",ONCAB(165.5,IEN,30.1) D P Q:EX=U
 W !,"   Lymph Nodes: ",ONCAB(165.5,IEN,31),?67,"Metastasis 1:  ",ONCAB(165.5,IEN,34) D P Q:EX=U
 W !,"   Regional Nodes Examined:  ",$E(ONCAB(165.5,IEN,33),1,34),?67,"Metastasis 2:  ",ONCAB(165.5,IEN,34.1) D P Q:EX=U
 W !,"   Regional Nodes Positive:  ",$E(ONCAB(165.5,IEN,32),1,34),?67,"Metastasis 3:  ",ONCAB(165.5,IEN,34.2) D P Q:EX=U
 W !,"   General Summary Stage:  ",ONCAB(165.5,IEN,35) D P Q:EX=U
 W !,"   Peripheral Blood Involvement:  ",ONCAB(165.5,IEN,30.5) D P Q:EX=U
 W !,"   Associated With HIV:  ",ONCAB(165.5,IEN,41) D P Q:EX=U
 ;
 I $P($G(^ONCO(165.5,IEN,0)),U,16)<3040000 G FCT
 S NAME="COLLABORATIVE STAGING" D FORMAT^ONCOPA1
 W !!,TITLE
 I $L(ONCAB(165.5,IEN,32,"I"))=1 S ONCAB(165.5,IEN,32,"I")="0"_ONCAB(165.5,IEN,32,"I") D P Q:EX=U
 I $L(ONCAB(165.5,IEN,33,"I"))=1 S ONCAB(165.5,IEN,33,"I")="0"_ONCAB(165.5,IEN,33,"I") D P Q:EX=U
 W !," Tumor Size (CS):          ",ONCAB(165.5,IEN,29.2,"I"),?35,"Derived AJJC-6 T:            ",ONCAB(165.5,IEN,160,"E") D P Q:EX=U
 W !," Extension (CS):           ",ONCAB(165.5,IEN,30.2,"I"),?35,"Derived AJCC-6 T Descriptor: ",ONCAB(165.5,IEN,161,"E") D P Q:EX=U
 W !," Tumor Size/Ext Eval (CS): ",ONCAB(165.5,IEN,29.1,"I"),?35,"Derived AJCC-6 N:            ",ONCAB(165.5,IEN,162,"E") D P Q:EX=U
 W !," Lymph Nodes (CS):         ",ONCAB(165.5,IEN,31.1,"I"),?35,"Derived AJCC-6 N Descriptor: ",ONCAB(165.5,IEN,163,"E") D P Q:EX=U
 W !," Lymph Nodes Eval (CS):    ",ONCAB(165.5,IEN,32.1,"I"),?35,"Derived AJCC-6 M:            ",ONCAB(165.5,IEN,164,"E") D P Q:EX=U
 W !," Regional Nodes Examined:  ",ONCAB(165.5,IEN,33,"I"),?35,"Derived AJCC-6 M Descriptor: ",ONCAB(165.5,IEN,165,"E") D P Q:EX=U
 W !," Regional Nodes Positive:  ",ONCAB(165.5,IEN,32,"I"),?35,"Derived AJCC-6 Stage Group:  ",ONCAB(165.5,IEN,166,"E") D P Q:EX=U
 W !," Mets at DX (CS):          ",ONCAB(165.5,IEN,34.3,"I"),?35,"Derived AJJC-7 T:            ",ONCAB(165.5,IEN,160.7,"E") D P Q:EX=U
 W !," Mets at DX-Bone:          ",ONCAB(165.5,IEN,34.31,"E"),?35,"Derived AJCC-7 T Descriptor: ",ONCAB(165.5,IEN,161.7,"E") D P Q:EX=U
 W !," Mets at DX-Brain:         ",ONCAB(165.5,IEN,34.32,"E"),?35,"Derived AJCC-7 N:            ",ONCAB(165.5,IEN,162.7,"E") D P Q:EX=U
 W !," Mets at DX-Liver:         ",ONCAB(165.5,IEN,34.33,"E"),?35,"Derived AJCC-7 N Descriptor: ",ONCAB(165.5,IEN,163.7,"E") D P Q:EX=U
 W !," Mets at DX-Lung:          ",ONCAB(165.5,IEN,34.34,"E"),?35,"Derived AJCC-7 M:            ",ONCAB(165.5,IEN,164.7,"E") D P Q:EX=U
 W !," Mets Eval (CS):           ",ONCAB(165.5,IEN,34.4,"I"),?35,"Derived AJCC-7 M Descriptor: ",ONCAB(165.5,IEN,165.7,"E") D P Q:EX=U
 W !," Site-Specific Factor 1:   ",ONCAB(165.5,IEN,44.1,"I"),?35,"Derived AJCC-7 Stage Group:  ",ONCAB(165.5,IEN,166.7,"E") D P Q:EX=U
 W !," Site-Specific Factor 2:   ",ONCAB(165.5,IEN,44.2,"I"),?35,"Derived SS1977:              ",ONCAB(165.5,IEN,167,"E") D P Q:EX=U
 W !," Site-Specific Factor 3:   ",ONCAB(165.5,IEN,44.3,"I"),?35,"Derived SS2000:              ",ONCAB(165.5,IEN,168,"E") D P Q:EX=U
 W !," Site-Specific Factor 4:   ",ONCAB(165.5,IEN,44.4,"I") D P Q:EX=U
 W !," Site-Specific Factor 5:   ",ONCAB(165.5,IEN,44.5,"I") D P Q:EX=U
 W !," Site-Specific Factor 6:   ",ONCAB(165.5,IEN,44.6,"I") D P Q:EX=U
 W !," Site-Specific Factor 7:   ",ONCAB(165.5,IEN,44.7,"I") D P Q:EX=U
 W !," Site-Specific Factor 8:   ",ONCAB(165.5,IEN,44.8,"I") D P Q:EX=U
 W !," Site-Specific Factor 9:   ",ONCAB(165.5,IEN,44.9,"I") D P Q:EX=U
 W !," Site-Specific Factor 10:  ",ONCAB(165.5,IEN,44.101,"I") D P Q:EX=U
 W !," Site-Specific Factor 11:  ",ONCAB(165.5,IEN,44.11,"I") D P Q:EX=U
 W !," Site-Specific Factor 12:  ",ONCAB(165.5,IEN,44.12,"I") D P Q:EX=U
 W !," Site-Specific Factor 13:  ",ONCAB(165.5,IEN,44.13,"I") D P Q:EX=U
 W !," Site-Specific Factor 14:  ",ONCAB(165.5,IEN,44.14,"I") D P Q:EX=U
 W !," Site-Specific Factor 15:  ",ONCAB(165.5,IEN,44.15,"I") D P Q:EX=U
 W !," Site-Specific Factor 16:  ",ONCAB(165.5,IEN,44.16,"I") D P Q:EX=U
 W !," Site-Specific Factor 17:  ",ONCAB(165.5,IEN,44.17,"I") D P Q:EX=U
 W !," Site-Specific Factor 18:  ",ONCAB(165.5,IEN,44.18,"I") D P Q:EX=U
 W !," Site-Specific Factor 19:  ",ONCAB(165.5,IEN,44.19,"I") D P Q:EX=U
 W !," Site-Specific Factor 20:  ",ONCAB(165.5,IEN,44.201,"I") D P Q:EX=U
 W !," Site-Specific Factor 21:  ",ONCAB(165.5,IEN,44.21,"I") D P Q:EX=U
 W !," Site-Specific Factor 22:  ",ONCAB(165.5,IEN,44.22,"I") D P Q:EX=U
 W !," Site-Specific Factor 23:  ",ONCAB(165.5,IEN,44.23,"I") D P Q:EX=U
 W !," Site-Specific Factor 24:  ",ONCAB(165.5,IEN,44.24,"I") D P Q:EX=U
 W !," Site-Specific Factor 25:  ",ONCAB(165.5,IEN,44.25,"I") D P Q:EX=U
 ;
FCT I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue with this abstract" D ^DIR Q:'Y  D HDR G PA2
 D P Q:EX=U
PA2 D ^ONCOPA2
 ; WILL CALL ONCOPA2 ROUTINE FROM HERE TO CONTINUE...
 ;
 Q
P ;
 I ($Y'<(LINE-1)) D  Q:EX=U  W !
 .I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue with this abstract" D ^DIR I 'Y S EX=U Q
 .D HDR Q
 Q
HDR ; Header
 W @IOF S PG=PG+1
 W CRA,!
 W ?5," Patient Name:  ",PATNAME,?84,"SSN:  ",SSAN,!
 Q
 ;
CLEANUP ;Cleanup
 K COC,CRA,EX,IEN,LINE,NAME,ONCAB,PATNAME,PG,SSAN,TITLE,TOP,TPX,Y
