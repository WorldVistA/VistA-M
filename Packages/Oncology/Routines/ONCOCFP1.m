ONCOCFP1 ;HINES OIFO/RVD - [PT Automatic Casefinding-PTF Search 1] ;09/10/15
 ;;2.2;ONCOLOGY;**7,10,13,14,17,18,21**;Jul 31, 2013;Build 6
 ;
 ; rvd - 0403/12 p56. Use ICD API (#3990) instead of direct global call
L10 ;
 W !
 ;List of ICD10
 W !?3,"*** COMPREHENSIVE ICD-10-CM Casefinding Code List for Reportable Tumors ***"
 W !
 W !?3,"(C00._ to C43._),C4A._,(C45._ to C48._),C49._ to C96._)"
 W !?3,"         Malignant neoplasms (excluding category C44), stated or presumed"
 W !?3,"          to be primary (of specified site) and certain specified histologies"
 W !?3,"C44.00_, C44.09   Unspecified/other malignant neoplasm of skin of lip"
 W !?3,"C44.10_, C44.19_  Unspecified/other malignant neoplasm of skin of eyelid"
 W !?3,"C44.13_           Sebaceous cell carcinoma of skin of eyelid, including canthus"
 W !?3,"C44.20_, C44.29_  Unspecified/other malignant neoplasm skin of ear and"
 W !?3,"                   external auricular canal"
 W !?3,"C44.30_, C44.39_  Unspecified/other malignant neoplasm of skin of"
 W !?3,"                   other/unspecified parts of face"
 W !?3,"C44.40_, C44.49   Unspecified/other malignant neoplasm of skin of"
 W !?3,"                   scalp & neck"
 W !?3,"C44.50_, C44.59_  Unspecified/other malignant neoplasm of skin of trunk"
 W !?3,"C44.60_, C44.69_  Unspecified/other malignant neoplasm of skin of upper"
 W !?3,"                   limb, incl. shoulder"
 W !?3,"C44.70_, C44.79_  Unspecified/other malignant neoplasm of skin of lower "
 W !?3,"                   limb, including hip"
 W !?3,"C44.80_, C44.89   Unspecified/other malignant neoplasm of skin of"
 W !?3,"                   overlapping sites of skin"
 W !?3,"C44.90_, C44.99   Unspecified/other malignant neoplasm of skin of"
 W !?3,"                   unspecified sites of skin"
 W !?3,"C49.A_            Gastrointestinal stromal tumors..."
 W !?3,"(D00._ to D05._), (D07._ to D09._) In-situ neoplasms (Note: Carcinoma in situ of the cervix"
 W !?3,"                   (C/N III-8077/2) and Prostatic Intraepithelial Carcinoma"
 W !?3,"                   (PIN III-8148/2) are not reportable)."
 W !?3,"D18.02            Hemangioma of intracranial structures and any site"
 W !?3,"D32._             Benign neoplasm of meninges (cerebral, spinal and unspecified)"
 W !?3,"D33._             Benign neoplasm of brain and other parts of central nervous"
 W !?3,"                   system"
 W !?3,"(D35.2 to D35.4)  Benign neoplasm of pituitary gland, craniopharyngeal"
 W !?3,"                   duct and pineal gland"
 W !?3,"D42._, D43._      Neoplasm of uncertain or unknown behavior of meninges, brain,"
 W !?3,"                   CNS"
 W !?3,"(D44.3 to D44.5)  Neoplasm of uncertain or unknown behavior of pituitary"
 W !?3,"                   gland, craniopharyngeal duct and pineal gland"
 W !?3,"D45               Polycythemia vera (9950/3)"
 W !?3,"D46._             Myelodysplastic syndromes (9980, 9982, 9983, 9985, 9986, 9989,"
 W !?3,"                   9991, 9992)"
 W !?3,"D47.02            Systemic mastocytosis"
 W !?3,"D47.1             Chronic myeloproliferative disease (9963/3)"
 W !?3,"D47.3             Essential (hemorrhagic) thrombocythemia (9962/3)"
 W !?3,"D47.4             Osteomyelofibrosis (9961/3)"
 W !?3,"                  Includes: Chronic idiopathic myelofibrosis"
 W !?3,"                  Myelofibrosis (idiopathic) (with myeloid metaplasia)"
 W !?3,"                  Myesclerosis (megakaryocytic) with myeloid metaplasia)"
 W !?3,"                  Secondary myelofibrosis in myeloproliferative disease)"
 W !?3,"D47.9             Neoplasms of uncertain behavior of lymphoid, hematopoitec"
 W !?3,"                   and related tissue, unspecified (9970/1,9931/3)"
 W !?3,"D47.Z_            Neoplasm of uncertain behavior of lymphoid, hematopoietic"
 W !?3,"                   and related tissue, unspecified (9960/3,9970/1,9971/3, 9931/3)"
 W !?3,"D49.6, D49.7      Neoplasm of unspecified behavior of brain, endocrine glands"
 W !?3,"                   and other CNS"
 W !,?3,"D72.11_           Hypereosonophilic syndrome (HES] (9964/3)"
 W !,?3,"K31.A22           Gastric intestinal metaplasia with high grade dysplasia"
 W !,?3,"N85.02            Endometrial intaepithelial neoplasia (EIN)"
 W !,?3,"R85.613           High grade squamous intraepithelial lesion on cytologic smear of anus (HGSIL)"
 W !?3,"R85.614           Cytologic evidence of malignacy on smear of anus"
 W !?3,"R87.614           Cytologic evidence of malignacy on smear of cervix"
 W !?3,"R87.623           High grade squamous intraepithelial lesion on cytologic smear of vagina (HGSIL)"
 W !?3,"R87.624           Cytologic evidence of malignacy on smear of vagina"
 W !?3,"R90.0             Intracranial space-occupying lesion found on diagnostic imaging"
 W !?3,"                  of central nervous system"
 w !
 ;
 ;I SBCIND="YES" D
 ;W !?3,"Basal/Squamous cell ICD-10-CM codes"
 W !
 Q
 ;
IC10 ;Search for ICD10 codes
 I X71'="",CI10=0 F F=5:1:15 S ICP=+$P(X71,U,F) I ICP>0 S IC10=$$GET1^DIQ(80,ICP,.01,"I") D FD10 Q:CI10=1
 Q
 ;
FD10 ;Check for valid ICD10 CM code for Oncology.
 ;I (SBCIND="YES"),($E(IC10)="C") S CI10=1 Q
 ;I (SBCIND="NO"),($E(IC10)="C") D  Q
 I ((IC10="D44.0")!(IC10="D44.1")!(IC10="D44.10")!(IC10="D44.11")!(IC10="D44.12")) S CI10=0 Q
 I ((IC10="D44.2")!(IC10="D44.6")!(IC10="D44.7")!(IC10="D44.9")) S CI10=0 Q
 I ($E(IC10,1,4)="D44.")!($E(IC10,1,6)="D72.11") S CI10=1 Q
 I ($E(IC10,1,5)="D35.0")!(IC10="D35.1")!(IC10="D35.5")!(IC10="D35.9") S CI10=0 Q
 I ($E(IC10,1,2)="C0")!($E(IC10,1,4)="C43.")!($E(IC10,1,4)="C4A.")!($E(IC10,1,4)="C40.") S CI10=1 Q
 I ($E(IC10,1,4)="C45.")!($E(IC10,1,4)="C48.")!($E(IC10,1,4)="C49.")!($E(IC10,1,4)="C96.") S CI10=1 Q
 I ($E(IC10,1,4)="C46.")!($E(IC10,1,4)="C47.") S CI10=1 Q
 I ($E(IC10,1,4)="C41.")!($E(IC10,1,4)="C42.") S CI10=1 Q
 I ($E(IC10,1,6)="C44.13")!($E(IC10,1,4)="C46.") S CI10=1 Q
 I ($E(IC10,1,6)="C44.00")!($E(IC10,1,6)="C44.09") S CI10=1 Q
 I ($E(IC10,1,6)="C44.10")!($E(IC10,1,6)="C44.19") S CI10=1 Q
 I ($E(IC10,1,6)="C44.20")!($E(IC10,1,6)="C44.29") S CI10=1 Q
 I ($E(IC10,1,6)="C44.30")!($E(IC10,1,6)="C44.39") S CI10=1 Q
 I ($E(IC10,1,6)="C44.40")!($E(IC10,1,6)="C44.49") S CI10=1 Q
 I ($E(IC10,1,6)="C44.50")!($E(IC10,1,6)="C44.59") S CI10=1 Q
 I ($E(IC10,1,6)="C44.60")!($E(IC10,1,6)="C44.69") S CI10=1 Q
 I ($E(IC10,1,6)="C44.70")!($E(IC10,1,6)="C44.79") S CI10=1 Q
 I ($E(IC10,1,6)="C44.80")!($E(IC10,1,6)="C44.89") S CI10=1 Q
 I ($E(IC10,1,6)="C44.90")!($E(IC10,1,6)="C44.99") S CI10=1 Q
 I ($E(IC10,1,2)="C5")!($E(IC10,1,2)="C6") S CI10=1 Q
 I ($E(IC10,1,2)="C7")!($E(IC10,1,2)="C8") S CI10=1 Q
 I ($E(IC10,1,2)="C9")!($E(IC10,1,2)="C1") S CI10=1 Q
 I ($E(IC10,1,2)="C2")!($E(IC10,1,2)="C3") S CI10=1 Q
 I ($E(IC10,1,3)="C40")!($E(IC10,1,2)="C0") S CI10=1 Q
 I ($E(IC10,1,4)="D00.")!($E(IC10,1,4)="D01.") S CI10=1 Q
 I ($E(IC10,1,4)="D02.")!($E(IC10,1,4)="D03.") S CI10=1 Q
 I ($E(IC10,1,4)="D04.")!($E(IC10,1,4)="D05.") S CI10=1 Q
 I ($E(IC10,1,4)="D07.")!($E(IC10,1,6)="D72.11") S CI10=1 Q
 I ($E(IC10,1,4)="D09.")!($E(IC10,1,6)="D47.Z1") S CI10=1 Q
 I ($E(IC10,1,3)="D32")!($E(IC10,1,6)="D18.02") S CI10=1 Q
 I ($E(IC10,1,3)="D42")!($E(IC10,1,3)="D33") S CI10=1 Q
 I ($E(IC10,1,3)="D45")!($E(IC10,1,4)="D43.") S CI10=1 Q
 I ($E(IC10,1,5)="D47.Z")!($E(IC10,1,5)="D47.1") S CI10=1 Q
 I ($E(IC10,1,5)="D47.3")!($E(IC10,1,5)="D47.4") S CI10=1 Q
 ;I ((IC10="D18.02")!(IC10="D35.2")!(IC10="D35.3")!(IC10="D35.4")!(IC10="D45")) S CI10=1 Q
 I ($E(IC10,1,4)="D44.")!($E(IC10,1,4)="D72.11") S CI10=1 Q
 I ((IC10="D72.110")!(IC10="D72.111")!(IC10="D72.118")!(IC10="D72.119")) S CI10=1 Q
 I ((IC10="D47.Z")!(IC10="D47.Z1")!(IC10="D47.Z9")!(IC10="D44.3")!(IC10="D44.4")!(IC10="D44.5")) S CI10=1 Q
 I ((IC10="D47.1")!(IC10="D47.3")!(IC10="D47.4")!(IC10="D47.02")!(IC10="D47.9")!(IC10="D49.6")!(IC10="D49.7")) S CI10=1 Q
 I ((IC10="R85.613")!(IC10="R85.614")!(IC10="R87.614")!(IC10="R87.623")!(IC10="R87.624")!(IC10="K31.A22")!(IC10="R90.0")) S CI10=1 Q
 ;I ($E(IC10)="D"),(($E(IC10,2,7)>00)&($E(IC10,2,7)<09.9999)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>31.9999)&($E(IC10,2,7)<33.9999)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>35.2000)&($E(IC10,2,7)<35.4001)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>41.9999)&($E(IC10,2,7)<43.9999)) S CI10=1 Q
 I ($E(IC10)="D"),(($E(IC10,2,7)>45.9999)&($E(IC10,2,7)<46.9999)) S CI10=1 Q
 I $E(IC10,1,6)="N85.02" S CI10=1 Q  ;Patch #18
 ;I ($E(IC10)="Z"),(($E(IC10,1,5)="Z85.1")!($E(IC10,1,5)="Z85.2")) S CI10=1 Q
 ;I ($E(IC10)="Z"),(($E(IC10,1,5)="Z85.3")!($E(IC10,1,5)="Z85.4")) S CI10=1 Q
 ;I ($E(IC10)="Z"),(($E(IC10,1,5)="Z85.5")!($E(IC10,1,5)="Z85.6")) S CI10=1 Q
 ;I ($E(IC10)="Z"),(($E(IC10,1,5)="Z85.7")!($E(IC10,1,5)="Z85.8")) S CI10=1 Q
 ;I ($E(IC10)="Z"),(($E(IC10,1,5)="Z85.9")!($E(IC10,1,5)="Z86.0")) S CI10=1 Q
 ;I ($E(IC10)="Z"),(($E(IC10,1,6)="Z86.00")!($E(IC10,1,6)="Z86.01")) S CI10=1 Q
 ;I ($E(IC10)="Z"),($E(IC10,1,6)="Z86.03") S CI10=1 Q
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
