ONCOCFP1 ;Hines OIFO/RVD - [PT Automatic Casefinding-PTF Search 1] ;09/10/15
 ;;2.2;ONCOLOGY;**7**;Jul 31, 2013;Build 5
 ;
 ; rvd - 0403/12 p56. Use ICD API (#3990) instead of direct global call
L10 ;
 W !
 ;List of ICD10
 W !?3,"*** COMPREHENSIVE ICD-10-CM Casefinding Code List for Reportable Tumors"
 W !?3,"          (Effective 10/1/2015-9/30/2016). ***"
 W !
 W !?3,"C00._- C43._,C45._-C96._  Malignant neoplasms (excluding category C44),"
 W !?3,"                  stated or presumed to be primary (of specified site)"
 W !?3,"                  and certain specified histologies"
 W !?3,"C44.00_, C44.09    Unspecified/other malignant neoplasm of skin of lip"
 W !?3,"C44.10_, C44.19_  Unspecified/other malignant neoplasm of skin of eyelid"
 W !?3,"C44.20_, C44.29_  Unspecified/other malignant neoplasm skin of ear and"
 W !?3,"                  external auricular canal"
 W !?3,"C44.30_, C44.39_  Unspecified/other malignant neoplasm of skin of"
 W !?3,"                  other/unspecified parts of face"
 W !?3,"C44.40_, C44.49   Unspecified/other malignant neoplasm of skin of"
 W !?3,"                  scalp & neck"
 W !?3,"C44.50_, C44.59_  Unspecified/other malignant neoplasm of skin of trunk"
 W !?3,"C44.60_, C44.69_  Unspecified/other malignant neoplasm of skin of upper"
 W !?3,"                  limb, incl. shoulder"
 W !?3,"C44.70_, C44.79_  Unspecified/other malignant neoplasm of skin of lower "
 W !?3,"                   limb, including hip"
 W !?3,"C44.80_, C44.89   Unspecified/other malignant neoplasm of skin of"
 W !?3,"                   overlapping sites of skin"
 W !?3,"C44.90_, C44.99   Unspecified/other malignant neoplasm of skin of"
 W !?3,"                   unspecified sites of skin"
 W !?3,"D00._- D09._      In-situ neoplasms (Note: Carcinoma in situ of the cervix"
 W !?3,"                   (C/N III-8077/2) and Prostatic Intraepithelial Carcinoma"
 W !?3,"                   (PIN III-8148/2) are not reportable)."
 W !?3,"D18.02            Hemangioma of intracranial structures and any site"
 W !?3,"D18.1             Lymphangioma, any site (Note: Includes Lymphangiomas of"
 W !?3,"                   Brain, Other parts of nervous system and endocrine glands,"
 W !?3,"                   which are reportable)"
 W !?3,"D32._          Benign neoplasm of meninges (cerebral, spinal and unspecified)"
 W !?3,"D33._          Benign neoplasm of brain and other parts of central nervous"
 W !?3,"                   system"
 W !?3,"D35.2 - D35.4  Benign neoplasm of pituitary gland, craniopharyngeal duct and"
 W !?3,"                   pineal gland"
 W !?3,"D42._, D43._   Neoplasm of uncertain or unknown behavior of meninges, brain,"
 W !?3,"                   CNS"
 W !?3,"D44.3 - D44.5  Neoplasm of uncertain or unknown behavior of pituitary gland,"
 W !?3,"                   craniopharyngeal duct and pineal gland"
 W !?3,"D45            Polycythemia vera (9950/3)"
 W !?3,"D46._          Myelodysplastic syndromes (9980, 9982, 9983, 9985, 9986, 9989,"
 W !?3,"                  9991, 9992)"
 W !?3,"D47.1          Chronic myeloproliferative disease (9963/3)"
 W !?3,"D47.3          Essential (hemorrhagic) thrombocythemia (9962/3)"
 W !?3,"D47.4          Osteomyelofibrosis (9961/3)"
 W !?3,"D47.7          Other specified neoplasms of uncertain/unknown behavior of"
 W !?3,"             lymphoid, hematopoietic (9965/3, 9966/3, 9967/3, 9971/3, 9975/3)"
 W !?3,"D47.Z_         Other neoplasms of uncertain behavior of lymphoid,"
 W !?3,"                  hematopoietic related tissue"
 W !?3,"D47.9          Neoplasm of uncertain behavior of lymphoid, hematopoietic and"
 W !?3,"                    related tissue, unspecified (9970/1, 9931/3)"
 W !?3,"D49.6, D49.7   Neoplasm of unspecified behavior of brain, endocrine glands"
 W !?3,"                    and other CNS"
 ;
 I SBCIND="YES" D
 .W !?3,"C44.01, C44.02   Basal/squamous cell carcinoma of skin of lip"
 .W !?3,"C44.11_, C44.12_ Basal/squamous cell carcinoma of skin of eyelid"
 .W !?3,"C44.21_, C44.22_ Basal/squamous cell carcinoma of skin of ear and"
 .W !?3,"                   external auricular canal"
 .W !?3,"C44.31_, C44.32_ Basal/squamous cell carcinoma of skin of other and"
 .W !?3,"                   unspecified parts of face"
 .W !?3,"C44.41, C44.42   Basal/squamous cell carcinoma of skin of scalp and neck"
 .W !?3,"C44.51_, C44.52_ Basal/squamous cell carcinoma of skin of trunk"
 .W !?3,"C44.61_, C44.62_ Basal/squamous cell carcinoma of skin of upper limb,"
 .W !?3,"                   including shoulder"
 .W !?3,"C44.71_, C44.72_ Basal/squamous cell carcinoma of skin of lower limb,"
 .W !?3,"                   including hip"
 .W !?3,"C44.81, C44.82  Basal/squamous cell carcinoma of skin of overlapping sites"
 .W !?3,"                   of skin"
 .W !?3,"C44.91, C44.92  Basal/squamous cell carcinoma of skin of unspecified sites"
 .W !?3,"                   of skin"
 ;
 W !?3,"D47.2           Monoclonal gammopathy"
 W !
 W !?3,"*** Note: Screen for incorrectly coded Waldenstrom's macro globulinemia ***"
 W !
 W !?3,"D64.81         Anemia due to antineoplastic chemotherapy"
 W !?3,"D70.1          Agranulocytosis secondary to cancer chemotherapy"
 W !?3,"D72.1          Eosinophilia (Note: Code for eosinophilia (9964/3). Not every"
 W !?3,"                 case of eosinophilia is a malignancy. Reportable Diagnosis"
 W !?3,"                 is Hypereosonophilic syndrome.)"
 W !?3,"D76._          Other specified diseases with participation of lymphoreticular"
 W !?3,"                  and reticulohistiocytic tissue"
 W !?3,"E34.0          Carcinoid syndrome"
 W !?3,"E88.3          Tumor lysis syndrome (following antineoplastic chemotherapy)"
 W !?3,"K22.711        Barrett's esophagus with high grade dysplasia"
 W !?3,"K92.81         Gastrointestinal mucositis (ulcerated) (due to antineoplastic"
 W !?3,"                  therapy)"
 W !?3,"R18.0          Malignant ascites"
 W !?3,"R53.0          Neoplastic (malignant) related fatigue"
 W !?3,"T45.1          Poisoning by, adverse effect of and under dosing of"
 W !?3,"                 antineoplastic and immunosuppressive drugs"
 W !?3,"T66             Unspecified effects of radiation"
 W !?3,"Y63.2           Overdose of radiation given during therapy"
 W !?3,"Y84.2           Radiological procedure and radiotherapy as the cause of"
 W !?3,"                 abnormal reaction of the patient, or of later complication,"
 W !?3,"                 without mention of misadventure at the time of the procedure"
 W !?3,"Z08             Encounter for follow-up examination after completed"
 W !?3,"                 treatment for malignant neoplasm"
 W !?3,"Z12._           Encounter for screening for malignant neoplasms"
 W !?3,"Z17.0, Z17.1    Estrogen receptor positive and negative status"
 W !?3,"Z40.0_          Encounter for prophylactic surgery for risk factors related"
 W !?3,"                  to malignant neoplasms"
 W !?3,"Z42.1           Encounter for breast reconstruction following mastectomy"
 W !?3,"Z48.290         Encounter for aftercare following bone marrow transplant"
 W !?3,"Z51.0           Encounter for antineoplastic radiation therapy"
 W !?3,"Z51.1_          Encounter for antineoplastic chemotherapy and immunotherapy"
 W !?3,"Z51.5, Z51.89   Encounter for palliative care and other specified aftercare"
 W !?3,"Z85._           Personal history of malignant neoplasm"
 W !?3,"Z86.0_, Z86.01_,Z86.03  Personal history of in situ and benign neoplasms and"
 W !?3,"                          neoplasms of uncertain behavior"
 W !?3,"Z92.21, Z92.23, Z92.25,Z92.3  Personal history of antineoplastic"
 W !?3,"                      chemotherapy, estrogen therapy, immunosuppression"
 W !?3,"                      therapy or irradiation (radiation)"
 W !?3,"Z94.81, Z94.84  Bone marrow and stem cell transplant status"
 W !
 Q
 ;
IC10 ;Search for ICD10 codes
 I X71'="",CI10=0 F F=5:1:15 S ICP=+$P(X71,U,F) I ICP>0 S IC10=$$GET1^DIQ(80,ICP,.01,"I") D FD10 Q:CI10=1
 Q
 ;
FD10 ;Check for valid ICD10 CM code for Oncology.
 I (SBCIND="YES"),($E(IC10)="C") S CI10=1 Q
 I (SBCIND="NO"),($E(IC10)="C") D  Q
 .I ($E(IC10,2,7)<44.01)!($E(IC10,2,7)>44.92) S CI10=1
 .Q
 I ((IC10="D18.02")!(IC10="D18.1")!(IC10="D35.2")!(IC10="D35.4")!(IC10="D45")!(IC10="D47.2")!(IC10="D64.81")) S CI10=1 Q
 I ((IC10="D47.1")!(IC10="D47.3")!(IC10="D47.4")!(IC10="D47.7")!(IC10="D47.9")!(IC10="D49.6")!(IC10="D49.7")) S CI10=1 Q
 I ((IC10="D70.1")!(IC10="D72.1")!(IC10="E34.0")!(IC10="E88.3")!(IC10="K22.711")!(IC10="K92.81")!(IC10="R18.0")) S CI10=1 Q
 I ((IC10="R53.0")!(IC10="T66")!(IC10="Y63.2")!(IC10="Y84.2")!(IC10="Z08")!(IC10="Z17.0")!(IC10="Z17.1")) S CI10=1 Q
 I ((IC10="Z42.1")!(IC10="Z48.290")!(IC10="Z51.0")!(IC10="Z51.5")!(IC10="Z51.89")!(IC10="Z86.03")!(IC10="Z92.21")) S CI10=1 Q
 I ((IC10="Z92.23")!(IC10="Z92.25")!(IC10="Z92.3")!(IC10="Z94.81")!(IC10="Z94.84")) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>00)&($E(IC10,2,7)<09.9999)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>32)&($E(IC10,2,7)<33.9999)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>42)&($E(IC10,2,7)<43.9999)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>44.29999)&($E(IC10,2,7)<44.5555)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>46)&($E(IC10,2,7)<46.9999)) S CI10=1 Q
 I ($E(IC10,1,5)="D47.Z"),(($E(IC10,6,7)>0)&($E(IC10,6,7)<9999)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>75.9999)&($E(IC10,2,7)<76.9999)) S CI10=1 Q
 I ($E(IC10)="T"),(($E(IC10,2,7)>45.1)&($E(IC10,2,7)<45.1999)) S CI10=1 Q
 I ($E(IC10)="Z"),(($E(IC10,2,7)>11.9999)&($E(IC10,2,7)<12.9999)) S CI10=1 Q
 I ($E(IC10)="Z"),(($E(IC10,2,7)>40.0)&($E(IC10,2,7)<40.0999)) S CI10=1 Q
 I ($E(IC10)="Z"),(($E(IC10,2,7)>51.1)&($E(IC10,2,7)<51.1999)) S CI10=1 Q
 I ($E(IC10)="Z"),(($E(IC10,2,7)>85)&($E(IC10,2,7)<86.0199)) S CI10=1 Q
 Q
 ;
EX ;KILL variables
 K %DT,%T,%ZIS,ADT,AFFDIV,BY,CD,CI,D0,DA,DD,DIC,DIE,DIOEND,DIR,DO,DR
 K DVMTCH,ED,F,FLDS,FR,GLO,HT,IC,IC9,ICD,ICP,INST,IOP,L,MCDV,NM,O2
 K ONCDIVS,ONCDIVSP,ONCIEN,ONCO,ONCS,ONCSUB,OSP,P,POP,PTFD0,PTFDT,PTMV
 K SD,SDDEF,SDT,TO,WED,WSD,X,X1,X2,X70,X71,XD0,XD1,XDT,XDX,XED,Y,Z
 K ZTDESC,ZTRTN,ZTSAVE
 K ^TMP("ONCO",$J)
 D ^%ZISC
 Q
