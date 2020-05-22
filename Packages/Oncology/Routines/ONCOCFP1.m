ONCOCFP1 ;Hines OIFO/RVD - [PT Automatic Casefinding-PTF Search 1] ;09/10/15
 ;;2.2;ONCOLOGY;**7,10**;Jul 31, 2013;Build 20
 ;
 ; rvd - 0403/12 p56. Use ICD API (#3990) instead of direct global call
L10 ;
 W !
 ;List of ICD10
 W !?3,"*** COMPREHENSIVE ICD-10-CM Casefinding Code List for Reportable Tumors ***"
 W !
 W !?3,"C00._- C43._,C45._-C96._  Malignant neoplasms (excluding category C44),"
 W !?3,"                   stated or presumed to be primary (of specified site)"
 W !?3,"                   and certain specified histologies"
 W !?3,"C44.00_, C44.09   Unspecified/other malignant neoplasm of skin of lip"
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
 W !?3,"C44.80_, C44.89 Unspecified/other malignant neoplasm of skin of"
 W !?3,"                 overlapping sites of skin"
 W !?3,"C44.90_, C44.99 Unspecified/other malignant neoplasm of skin of"
 W !?3,"                   unspecified sites of skin"
 W !?3,"C45._, C45.9   Mesothelioma of pleura, peritoneum, pericardium, other"
 w !?3,"                 site and unspecified..."
 W !?3,"C46._, C46.9   Kaposi's sarcoma of skin, soft tissue, palate, lymph nodes"
 W !?3,"                 gastrointestinal sites, lung, unspecified lung, right"
 W !?3,"                 lung, left lung, other sites and unspecified..."
 W !?3,"C47._,C47.9    Malignant neoplasm of perpheral nerves..."
 W !?3,"C48._,C48.8    Malignant neoplasm of retroperitoneum and peritoneum..."
 W !?3,"C49._,C49.9    Malignant neoplasm of connective and soft tissue..."
 W !?3,"C49.A_,C49.A9  Gastrointestinal stromal tumors..."
 W !?3,"C4A._,C4A.9    Merkel cell carcinomas..."
 W !?3,"C50,C50._    Malignant neoplasm of breast, nipple, areola and breast unspecified.."
 W !?3,"C51._          Malignant neoplasm of vulva, labium majus, labium minus"
 W !?3,"                  clitoris and vulva unspecified..."
 W !?3,"C52            Malignant neoplasm of vagina"
 W !?3,"C53._          Malignant neoplasm of cervix uteri, endocervix, exocervix"
 W !?3,"                  overlapping sites of cervix uteri and unspecified..."
 W !?3,"C54._          Malignant neoplasm of corpus uteri, isthmus uteri,"
 W !?3,"                  endometrium, myometrium, fundus uteri and unspecified..."
 W !?3,"C55            Malignant neoplasm of uterus"
 W !?3,"C56._          Malignant neoplasm of ovary, right ovary, left ovary,"
 W !?3,"                  unspecified ovary..."
 W !?3,"C57._          Malignant neoplasm of other and unspecified female genital organs,"
 W !?3,"                  fallopian tube, broad and round ligament and parametrium..."
 W !?3,"C58            Malignant neoplasm of placenta"
 W !?3,"C60._          Malignant neoplasm of penis, prepuce, glans penis, testis, genital organ,"
 W !?3,"                epididymis, spermatic cord, scrotum, kidney, renal pelvis, bladder and eye..."
 W !?3,"C70_           Malignant neoplasm of meninges, brain, cerbrum, thyroid, adrenal,"
 W !?3,"                  endocrine, pituitary, intestine, appendex and others..."
 W !?3,"C80            Malignant neoplasm without specification of site"
 W !?3,"C81_           Hodgkin lymphoma, nodular sclerosis, lymphocyte and other..."
 W !?3,"C82._          Follicular lymphoma grade, unspecified and others..."
 W !?3,"C83            Non-follicular lymphoma"
 W !?3,"C83._          Small cell B-cell lymphoma, Burkitt, Lymphoblastic, non-follicular and other..."
 W !?3,"C84            Mature T/NK-cell lymphomas"
 W !?3,"C84._          Mycosis fungoides, sezary diseases, perpheral T-cell, anaplastic large cell..."
 W !?3,"C85._          Unspecified B-cell, Mediastinal Large B-cell, Non-Hodgkin lymphoma..."
 W !?3,"C86._          T/NK-cell, Extranodal NK/T-cell, Hepatosplenic T-cell, Blastic NK-cell..."
 W !?3,"C88._          Malignant immunoproliferative, Waldenstrom macroglobulinema, Heavy chain..."
 W !?3,"C90._          Multiple myeloma. PLasma cell leukemia, Extramedullary plasmacytoma..."
 W !?3,"C91._          Acute lymphoblastic leukemia, Chronic lymphocytic leukemia of B-cell type..."
 W !?3,"C92._          Acute and Chronic myeloid leukemia, BCR/ABL-positive,Myeloid leukemia ..."
 W !?3,"C93._          Monocytic, myelomonocytic leukemia, ..."
 W !?3,"C94._          Other Leukemias of specified cell type, erythroid, megakaryoblastic,"
 W !?3,"                 Mast cell..."
 W !?3,"C95._          Leukemia of uncpecified cell type, Acute and Chronic..."
 W !?3,"C96._          Other and unspecified malignant neoplasm, mast cell, Secondary"
 W !?3,"                 carcinoid tumors..."
 W !?3,"D00._- D09._   In-situ neoplasms (Note: Carcinoma in situ of the cervix"
 W !?3,"                 (C/N III-8077/2) and Prostatic Intraepithelial Carcinoma"
 W !?3,"                 (PIN III-8148/2) are not reportable)."
 W !?3,"D18.02         Hemangioma of intracranial structures and any site"
 W !?3,"D32._          Benign neoplasm of meninges (cerebral, spinal and unspecified)"
 W !?3,"D33._          Benign neoplasm of brain and other parts of central nervous"
 W !?3,"                   system"
 W !?3,"D35._          Benign neoplasm of pituitary gland, craniopharyngeal duct and"
 W !?3,"                   pineal gland"
 W !?3,"D42._, D43._   Neoplasm of uncertain or unknown behavior of meninges, brain,"
 W !?3,"                   CNS"
 W !?3,"D44.3, D44.4, D44.5  Neoplasm of uncertain or unknown behavior of pituitary"
 W !?3,"                     gland, craniopharyngeal duct and pineal gland"
 W !?3,"D45            Polycythemia vera (9950/3)"
 W !?3,"D46._          Myelodysplastic syndromes (9980, 9982, 9983, 9985, 9986, 9989,"
 W !?3,"                  9991, 9992)"
 W !?3,"D47.02         Systemic mastocytosis"
 W !?3,"D47.1          Chronic myeloproliferative disease (9963/3)"
 W !?3,"D47.3          Essential (hemorrhagic) thrombocythemia (9962/3)"
 W !?3,"D47.4          Osteomyelofibrosis (9961/3)"
 W !?3,"D47.Z_         Other neoplasms of uncertain behavior of lymphoid,"
 W !?3,"                  hematopoietic related tissue"
 W !?3,"D47.9          Neoplasm of uncertain behavior of lymphoid, hematopoietic"
 W !?3,"                 and related tissue, unspecified (9970/1, 9931/3)"
 W !?3,"D49.6, D49.7   Neoplasm of unspecified behavior of brain, endocrine glands"
 W !?3,"                    and other CNS"
 W !?3,"R85.614       Abnormal findings on cytological and histological examination"
 W !?3,"               of  digestive organs Note: see 'must collect' list for R85.614"
 W !?3,"R87.61_, R87.62_  Abnormal findings on cytological/histological examination"
 W !?3,"                   of female genital organs Note: see 'must collect' list for"
 W !?3,"                   R87.614 and R87.624"
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
 W !?3,"Z85._           Personal history of malignant neoplasm ICD-10-CM Coding"
 W !?3,"                 instruction: Code first any follow-up examination after"
 W !?3,"                 treatment of malignant neoplasm (Z08)"
 W !?3,"Z86.0_, Z86.01_,Z86.03  Personal history of in situ and benign neoplasms"
 W !?3,"                         and neoplasms of uncertain behavior"
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
 I ((IC10="D18.02")!(IC10="D35.2")!(IC10="D35.3")!(IC10="D35.4")!(IC10="D45")) S CI10=1 Q
 I ((IC10="D47.Z")!(IC10="D47.Z1")!(IC10="D47.Z9")!(IC10="D44.3")!(IC10="D44.4")!(IC10="D44.5")) S CI10=1 Q
 I ((IC10="D47.1")!(IC10="D47.3")!(IC10="D47.4")!(IC10="D47.02")!(IC10="D47.9")!(IC10="D49.6")!(IC10="D49.7")) S CI10=1 Q
 I ((IC10="R85.614")!(IC10="R87.614")!(IC10="R87.624")) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>00)&($E(IC10,2,7)<09.9999)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>31.9999)&($E(IC10,2,7)<33.9999)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>41.9999)&($E(IC10,2,7)<43.9999)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>45.9999)&($E(IC10,2,7)<46.9999)) S CI10=1 Q
 I ($E(IC10)="Z"),(($E(IC10,2,7)>84.9999)&($E(IC10,2,7)<86.031)) S CI10=1 Q
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
