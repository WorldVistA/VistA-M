ONCSYMP ;Hines OIFO/GWB - LUNG AND COLON SYMPTOMS ;05/24/05
 ;;2.11;ONCOLOGY;**43,47**;Mar 07, 1995;Build 19
 ;
LUNG S SECTION="Cancer Identification" D SECTION^ONCOAIP
 W !," SYMPTOMS AND INITIAL DIAGNOSTIC STUDIES"
 W !," ---------------------------------------"
 N DI,DIC,DR,DA,DIQ,ONC
 S DIC="^ONCO(165.5,"
 S DR="174;174.1;186;186.1;187;187.1;188;188.1;189;189.1;190;175;175.1;176;176.1;177;177.1;178;178.1;179;179.1"
 S DA=D0,DIQ="ONC" D EN^DIQ1
 F I=174,186,187,188,189,190,175,176,177,178,179 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 W !," Blood in Sputum Per Pt.......: ",ONC(165.5,D0,174.1),?44,ONC(165.5,D0,174)
 W !," Dyspnea......................: ",ONC(165.5,D0,186.1),?44,ONC(165.5,D0,186)
 W !," Increased Cough..............: ",ONC(165.5,D0,187.1),?44,ONC(165.5,D0,187)
 W !," Fever........................: ",ONC(165.5,D0,188.1),?44,ONC(165.5,D0,188)
 W !," Night Sweats.................: ",ONC(165.5,D0,189.1),?44,ONC(165.5,D0,189)
 W !," Weight Loss Per Pt...........: ",?44,ONC(165.5,D0,190)
 W !," Chest X-Ray..................: ",ONC(165.5,D0,175.1),?44,ONC(165.5,D0,175)
 W !," CT Scan......................: ",ONC(165.5,D0,176.1),?44,ONC(165.5,D0,176)
 W !," Bronchoscopy.................: ",ONC(165.5,D0,177.1),?44,ONC(165.5,D0,177)
 W !," Mediastinoscopy..............: ",ONC(165.5,D0,178.1),?44,ONC(165.5,D0,178)
 W !," PET Scan.....................: ",ONC(165.5,D0,179.1),?44,ONC(165.5,D0,179)
 W !,DASHES
 Q
 ;
COLON S HDL=$L("Cancer Identification"),TAB=(80-HDL)\2,TAB=TAB-1
 W @IOF,DASHES
 W !,?1,PATNAM,?TAB,"Cancer Identification",?SITTAB,SITEGP
 W !,?1,SSN,?TOPTAB,TOPNAM," ",TOPCOD
 W !,DASHES
 W !," SYMPTOMS AND INITIAL DIAGNOSTIC STUDIES"
 W !," ---------------------------------------"
 N DI,DIC,DR,DA,DIQ,ONC
 S DIC="^ONCO(165.5,"
 S DR="180;180.1;191;711;712;809;713;181;181.1;182;182.1;183;183.1;185;185.1;184;184.1;179;179.1;192"
 S DA=D0,DIQ="ONC" D EN^DIQ1
 F I=180,191,711,712,809,713,181,182,183,184,185,179,192 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 W !," Ulcerative Colitis (UC)...................: ",?45,ONC(165.5,D0,191)
 W !," Familial Adenomatous Polyps...............: ",?45,ONC(165.5,D0,711)
 W !," HNPCC.....................................: ",?45,ONC(165.5,D0,712)
 W !," Crohn's Disease...........................: ",?45,ONC(165.5,D0,809)
 W !," Inflammatory Bowel Disease................: ",?45,ONC(165.5,D0,713)
 W !," Sporadic Polyps...........................: ",?45,ONC(165.5,D0,192)
 W !," Change in Bowel Habits Per Pt.: ",ONC(165.5,D0,180.1),?45,ONC(165.5,D0,180)
 W !," Fecal Occult Blood Test (FOBT): ",ONC(165.5,D0,181.1),?45,ONC(165.5,D0,181)
 W !," Barium Enema..................: ",ONC(165.5,D0,182.1),?45,ONC(165.5,D0,182)
 W !," Sigmoidoscopy.................: ",ONC(165.5,D0,183.1),?45,ONC(165.5,D0,183)
 W !," Colonoscopy...................: ",ONC(165.5,D0,185.1),?45,ONC(165.5,D0,185)
 W !," CT of Abdomen/Pelvis..........: ",ONC(165.5,D0,184.1),?45,ONC(165.5,D0,184)
 W !," PET Scan......................: ",ONC(165.5,D0,179.1),?45,ONC(165.5,D0,179)
 W !,DASHES
 Q
 ;
UCASE S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
 ;
STUFF ;Stuff symptom date with 00/00/0000 or 99/99/9999
 S:X=0 $P(^ONCO(165.5,D0,2.2),U,PIECE)="0000000"
 S:X=9 $P(^ONCO(165.5,D0,2.2),U,PIECE)=9999999
 Q
