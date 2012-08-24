LEX2073E ;ISL/KER - LEX*2.0*73 Post-Install - Mixed Case 3 ;01/03/2011
 ;;2.0;LEXICON UTILITY;**73**;Sep 23, 1996;Build 10
 ;               
 ; External Global Variables
 ;    None
 ;               
 ; External References
 ;    FILE^DIE            ICR   2053
 ;    IX1^DIK             ICR  10013
 ;    MES^XPDUTL          ICR  10141
 ;               
 Q
EN ;
 N DA,DIK,DIE,LEXEX,LEXEXP,LEXFDA,LEXIC,LEXIEN,LEXIENS,LEXLN,LEXSO,LEXTG,LEXTX
 S LEXTG="LEX",LEXTX="" F LEXIC=1:1 D  Q:'$L(LEXTX)
 . S LEXTX="" S LEXEX="S LEXTX=$T("_LEXTG_"+"_LEXIC_")" X LEXEX N LEXLN,LEXSO,LEXIEN,LEXIENS,LEXEXP
 . S LEXLN=$P(LEXTX,";;",2,$L(LEXTX,";;")) S:'$L($TR(LEXLN,";","")) LEXTX="" Q:'$L(LEXTX)
 . S LEXSO=$P(LEXLN,";;",1),LEXIEN=$P(LEXLN,";;",2),LEXEXP=$P(LEXLN,";;",3) Q:LEXSO'?4N  Q:+LEXIEN'>0  Q:'$D(^LEX(757.01,+LEXIEN,0))  Q:'$L(LEXEXP)
 . K LEXFDA S LEXIENS=LEXIEN_",",LEXFDA(757.01,LEXIENS,.01)=$G(LEXEXP)
 . D FILE^DIE("","LEXFDA") S DA=LEXIEN,DIK="^LEX(757.01," D IX1^DIK
 Q
 D MES^XPDUTL("                                      6502-7619")
LEX ;; 6502-7619
 ;;6502;;304662;;Deflection of Nasal Septum
 ;;6504;;304663;;Loss of part of or Scarring of Nose
 ;;6510;;304664;;Chronic Pansinusitis (Sinusitis)
 ;;6511;;24376;;Chronic Ethmoidal Sinusitis
 ;;6512;;24380;;Chronic Frontal Sinusitis
 ;;6513;;24407;;Chronic Maxillary Sinusitis
 ;;6514;;24437;;Chronic Sphenoidal Sinusitis
 ;;6515;;304665;;Laryngeal Tuberculosis (Active or Inactive)
 ;;6516;;269902;;Chronic Laryngitis
 ;;6518;;68385;;Laryngectomy
 ;;6519;;304666;;Organic Aphonia
 ;;6520;;304668;;Stenosis of Larynx
 ;;6522;;1005;;Allergic or Vasomotor Rhinitis
 ;;6523;;1008;;Bacterial Rhinitis
 ;;6524;;1023;;Granulomatous Rhinitis
 ;;6600;;24358;;Chronic Bronchitis
 ;;6601;;17134;;Bronchiectasis
 ;;6602;;11129;;Asthma (Bronchial)
 ;;6603;;101045;;Emphysema (Pulmonary)
 ;;6604;;72072;;Chronic Obstructive Pulmonary Disease
 ;;6701;;304670;;Active Chronic Pulmonary Tuberculosis (Far Advanced)
 ;;6702;;304671;;Active Chronic Pulmonary Tuberculosis (Moderately Advanced)
 ;;6703;;304672;;Active Chronic Pulmonary Tuberculosis (Minimally Advanced)
 ;;6704;;304673;;Active Chronic Pulmonary Tuberculosis (Advancement Unspecified)
 ;;6721;;304674;;Inactive Chronic Pulmonary Tuberculosis (Far Advanced)
 ;;6722;;304675;;Inactive Chronic Pulmonary Tuberculosis (Moderately Advanced)
 ;;6723;;304676;;Inactive Chronic Pulmonary Tuberculosis (Minimally Advanced)
 ;;6724;;304677;;Inactive Chronic Pulmonary Tuberculosis (Advancement Unspecified)
 ;;6730;;304678;;Active Chronic Pulmonary Tuberculosis
 ;;6731;;304679;;Inactive Chronic Pulmonary Tuberculosis
 ;;6732;;304680;;Tuberculosis Pleurisy (Active or Inactive)
 ;;6817;;304695;;Chronic Passive Congestion of the Lung
 ;;6819;;304697;;Malignant new Growth (excluding Skin) of Respiratory System
 ;;6820;;304698;;Benign new Growth of Respiratory System
 ;;6822;;2439;;Actinomycosis
 ;;6823;;83659;;Nocardiosis
 ;;6824;;1024;;Chronic Lung Abscess
 ;;6825;;1056;;Fibrosis of Lung (Diffuse Interstitial)
 ;;6826;;1057;;Desquamative Interstitial Pneumonitis
 ;;6827;;100985;;Pulmonary Alveolar Proteinosis
 ;;6828;;41185;;Eosinophilic Granuloma
 ;;6829;;1025;;Drug-Induced Pneumonitis/Fibrosis
 ;;6830;;1026;;Radiation-Induced Pneumonitis/Fibrosis
 ;;6831;;276631;;Hypersensitivity Pneumonitis
 ;;6832;;95539;;Pneumoconiosis
 ;;6833;;10704;;Asbestosis
 ;;6834;;1027;;Histoplasmosis of Lung
 ;;6835;;25617;;Coccidioidomycosis
 ;;6836;;15213;;Blastomycosis
 ;;6837;;29608;;Cryptococcosis
 ;;6838;;10935;;Aspergillosis
 ;;6839;;79602;;Mucormycosis
 ;;6840;;1029;;Diaphragm Paralysis or Paresis
 ;;6841;;1058;;Spinal Cord Injury with Respiratory Insufficiency
 ;;6842;;1060;;Kyphoscoliosis, Pectus Excavatum/Carinatum
 ;;6843;;1061;;Traumatic Chest Wall Defect
 ;;6844;;1030;;Post-Surgical/Respiratory System
 ;;6845;;1032;;Chronic Pleural Effusion or Fibrosis
 ;;6846;;107916;;Sarcoidosis
 ;;6847;;111251;;Sleep Apnea Syndromes
 ;;7000;;106006;;Valvular Heart Disease (including Rheumatic Heart Disease)
 ;;7001;;304699;;Endocarditis
 ;;7002;;304700;;Pericarditis
 ;;7003;;304701;;Pericardial Adhesions
 ;;7004;;304702;;Syphilitic Heart Disease
 ;;7005;;303853;;Arteriosclerotic Heart Disease
 ;;7006;;304704;;Myocardial Infarction
 ;;7007;;265127;;Hypertensive Heart Disease
 ;;7008;;304705;;Hyperthyroid Heart Disease
 ;;7010;;304708;;Supraventricular Arrhythmias
 ;;7011;;304707;;Ventricular Arrhythmias
 ;;7015;;304712;;Auriculoventricular Block
 ;;7016;;304713;;Heart Valve Replacement (Prosthesis)
 ;;7017;;28486;;Coronary Artery Bypass
 ;;7018;;1033;;Cardiac Pacemaker
 ;;7019;;298421;;Cardiac Transplant
 ;;7020;;80559;;Cardiomyopathy
 ;;7101;;304716;;Hypertensive Vascular Disease
 ;;7110;;7389;;Aneurysm
 ;;7111;;304718;;Aneurysm of any Large Artery
 ;;7112;;304719;;Aneurysmal Dilation of a Small Artery
 ;;7113;;304724;;Arteriovenous Aneurysm (Traumatic)
 ;;7114;;10345;;Arteriosclerosis Obliterans
 ;;7115;;118944;;Thromboangiitis Obliterans (Buerger's Disease)
 ;;7117;;103164;;Raynaud's Disease
 ;;7118;;7527;;Angioneurotic Edema
 ;;7119;;42310;;Erythromelalgia
 ;;7120;;125417;;Varicose Veins
 ;;7121;;93355;;Post-Phlebitic Syndrome
 ;;7122;;304726;;Cold Injury Residuals
 ;;7123;;304727;;Soft Tissue Sarcoma
 ;;7200;;304728;;Injury of the Mouth
 ;;7201;;304729;;Injury of the Lips
 ;;7202;;304730;;Loss of Whole or part of Tongue
 ;;7203;;259420;;Esophageal Stricture
 ;;7204;;304733;;Spasm of the Esophagus (Cardiospasm)
 ;;7205;;270063;;Diverticulum of Esophagus (Acquired)
 ;;7301;;304735;;Adhesions of Peritoneum
 ;;7304;;304731;;Gastric Ulcer
 ;;7305;;37298;;Duodenal Ulcer
 ;;7306;;74053;;Marginal Ulcer (Gastrojejunal)
 ;;7307;;304736;;Hypertrophic Gastritis (Identified by Gastroscope)
 ;;7308;;97010;;Postgastrectomy Syndrome
 ;;7309;;304737;;Stenosis of the Stomach
 ;;7310;;304738;;Injury to Stomach (Residuals)
 ;;7311;;259861;;Injury to Liver
 ;;7312;;71492;;Cirrhosis of the Liver
 ;;7314;;186925;;Chronic Cholecystitis
 ;;7315;;304741;;Chronic Cholelithiasis
 ;;7316;;304742;;Chronic Cholangitis
 ;;7317;;274809;;Injury of Gallbladder
 ;;7318;;23324;;Removal of Gallbladder
 ;;7319;;65682;;Irritable Bowel Syndrome
 ;;7321;;5818;;Amebiasis
 ;;7322;;37510;;Dysentery (Bacillary)
 ;;7323;;26044;;Ulcerative Colitis
 ;;7324;;304752;;Distomiasis (Intestinal or Hepatic)
 ;;7325;;304753;;Chronic Enteritis
 ;;7326;;304754;;Chronic Enterocolitis
 ;;7327;;35883;;Diverticulitis
 ;;7328;;304755;;Resection of Small Intestine
 ;;7329;;304756;;Resection of Large Intestine
 ;;7330;;64808;;Intestinal Fistula
 ;;7331;;304757;;Peritonitis
 ;;7332;;304758;;Impairment of Rectum and Anus
 ;;7333;;304759;;Stricture of Rectum and Anus
 ;;7334;;304760;;Prolapse of Rectum
 ;;7335;;304761;;Anorectal Fistula
 ;;7336;;304762;;Hemorrhoids (External or Internal)
 ;;7337;;100061;;Pruritus Ani
 ;;7338;;304763;;Inguinal Hernia
 ;;7339;;304764;;Ventral Hernia (Postoperative)
 ;;7340;;56693;;Femoral Hernia
 ;;7342;;126672;;Visceroptosis
 ;;7343;;304765;;Malignant new Growths within the Digestive System (Exclusive of Skin)
 ;;7344;;304766;;Benign new Growths within the Digestive System (Exclusive of Skin)
 ;;7345;;304767;;Chronic Liver Disease without Cirrhosis
 ;;7346;;56705;;Hiatal Hernia
 ;;7347;;89450;;Pancreatitis
 ;;7348;;125239;;Vagotomy
 ;;7351;;299329;;Liver Transplant
 ;;7354;;56447;;Hepatitis C
 ;;7500;;304768;;Removal of a Kidney
 ;;7501;;304769;;Abscess of Kidney
 ;;7502;;304770;;Chronic Nephritis
 ;;7504;;186934;;Chronic Pyelonephritis
 ;;7505;;122766;;Tuberculosis of Kidney
 ;;7507;;304771;;Arteriolar Nephrosclerosis
 ;;7508;;82291;;Nephrolithiasis
 ;;7509;;59672;;Hydronephrosis
 ;;7510;;124126;;Ureterolithiasis
 ;;7511;;304772;;Stricture of Ureter
 ;;7512;;304774;;Chronic Cystitis
 ;;7515;;304775;;Calculus in Bladder
 ;;7516;;304776;;Fistula of Bladder
 ;;7517;;304777;;Injury of Bladder
 ;;7518;;304778;;Stricture of Urethra
 ;;7519;;304779;;Fistula of Urethra
 ;;7520;;304780;;Removal of Half or more of the Penis
 ;;7521;;304781;;Removal of Glans Penis
 ;;7522;;304782;;Deformity of Penis with Loss of Erectile Power
 ;;7523;;304783;;Complete Atrophy of Testis
 ;;7524;;304784;;Removal of Testis
 ;;7525;;304785;;Chronic Epididymo-Orchitis
 ;;7527;;304786;;Prostate Gland Injury
 ;;7528;;304788;;Malignant Neoplasm of the Genitourinary System
 ;;7529;;304789;;Benign Neoplasm of Genitourinary System
 ;;7530;;304790;;Chronic Renal Disease Requiring Regular Dialysis
 ;;7531;;67227;;Kidney Transplant
 ;;7532;;304791;;Renal Tubular Disorders
 ;;7533;;67291;;Cystic Kidney Disease
 ;;7534;;304792;;Atherosclerotic Renal Disease
 ;;7535;;264157;;Toxic Nephropathy
 ;;7536;;51359;;Glomerulonephritis
 ;;7537;;304794;;Interstitial Nephritis
 ;;7538;;304795;;Papillary Necrosis
 ;;7539;;304793;;Renal Amyloid Disease
 ;;7540;;304796;;Disseminated Intravascular Coagulation with Renal Cortical Necrosis
 ;;7541;;304797;;Renal Involvement in Systemic Diseases
 ;;7542;;304798;;Neurogenic Bladder
 ;;7610;;304799;;Disease or Injury of Vulva
 ;;7611;;304800;;Disease or Injury of Vagina
 ;;7612;;304801;;Disease or Injury of Cervix
 ;;7613;;304802;;Disease, Injury or Adhesions of Uterus
 ;;7614;;304803;;Disease, Injury or Adhesions of Fallopian Tube
 ;;7615;;304804;;Disease, Injury or Adhesions of Ovary
 ;;7617;;304805;;Complete Removal of Uterus and both Ovaries
 ;;7618;;304806;;Removal of Uterus including Corpus
 ;;7619;;304808;;Removal of Ovary
 ;;;;;;
