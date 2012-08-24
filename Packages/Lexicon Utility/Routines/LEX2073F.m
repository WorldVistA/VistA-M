LEX2073F ;ISL/KER - LEX*2.0*73 Post-Install - Mixed Case 3 ;01/03/2011
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
 D MES^XPDUTL("                                      7620-8630")
LEX ;; 7620-8630
 ;;7620;;304809;;Complete Atrophy of both Ovaries
 ;;7621;;124759;;Prolapse of Uterus
 ;;7622;;304810;;Displacement of Uterus
 ;;7623;;304811;;Surgical Complications of Pregnancy
 ;;7624;;104110;;Rectovaginal Fistula
 ;;7625;;304812;;Urethrovaginal Fistula
 ;;7626;;296488;;Surgery of the Breast
 ;;7627;;304813;;Malignant Neoplasm of Gynecological System or Breast
 ;;7628;;304814;;Benign Neoplasm of Gynecological System or Breast
 ;;7629;;40463;;Endometriosis
 ;;7700;;7161;;Pernicious Anemia
 ;;7702;;304815;;Acute Agranulocytosis
 ;;7703;;69420;;Leukemia
 ;;7704;;304816;;Primary Polycythemia
 ;;7705;;304817;;Purpura Hemorrhagica
 ;;7706;;113421;;Splenectomy
 ;;7707;;274824;;Injury to Spleen
 ;;7709;;304818;;Lymphogranulomatosis (Hodgkin's Disease)
 ;;7710;;304819;;Tuberculous Adenitis (Active or Inactive)
 ;;7714;;7198;;Sickle Cell Anemia
 ;;7715;;72695;;Non-Hodgkin's Lymphoma
 ;;7716;;7020;;Aplastic Anemia
 ;;7800;;304823;;Disfiguring Scars of the Head, Face or Neck
 ;;7801;;108133;;Deep Scars other than Head, Face or Neck
 ;;7802;;304824;;Superficial Scars other than Head, Face, or Neck
 ;;7803;;304827;;Superficial Scars (Unstable)
 ;;7804;;276699;;Superficial Scars (Painful)
 ;;7805;;304825;;Scars
 ;;7806;;38333;;Dermatitis or Eczema
 ;;7807;;304828;;Leishmaniasis, Americana (Mucocutaneous, Espundia)
 ;;7808;;304829;;Leishmaniasis, Old World (Cutaneous, Oriental Sore)
 ;;7809;;72148;;Lupus Erythematosus, Discoid
 ;;7811;;304830;;Tuberculosis Luposa (Lupus Vulgaris) (Active or Inactive)
 ;;7813;;33165;;Dermatophytosis
 ;;7815;;91124;;Pemphigus
 ;;7816;;100316;;Psoriasis
 ;;7817;;33046;;Dermatitis Exfoliativa
 ;;7818;;304831;;Malignant new Growths of Skin
 ;;7819;;304832;;Benign new Growths of Skin
 ;;7820;;1035;;Infections of the Skin
 ;;7821;;1036;;Skin Condition
 ;;7822;;278875;;Papulosquamous Disorders
 ;;7823;;127071;;Vitiligo
 ;;7824;;1037;;Diseases of Keratinization
 ;;7825;;124650;;Urticaria
 ;;7826;;1038;;Vasculitis (Primary Cutaneous)
 ;;7827;;1039;;Erythema Multiforme, Toxic Epidermal Necrolys
 ;;7828;;2143;;Acne
 ;;7829;;294072;;Chloracne
 ;;7830;;1040;;Scarring Alopecia
 ;;7831;;5095;;Alopecia Areata
 ;;7832;;60030;;Hyperhidrosis
 ;;7833;;75457;;Malignant Melanoma
 ;;7900;;60393;;Hyperthyroidism
 ;;7901;;304833;;Adenoma of the Thyroid Gland (Toxic)
 ;;7902;;263728;;Adenoma of the Thyroid Gland (non-Toxic)
 ;;7903;;60820;;Hypothyroidism
 ;;7904;;304834;;Hyperparathyroidism (Osteitis Fibrosa Cystica)
 ;;7905;;60635;;Hypoparathyroidism
 ;;7907;;304835;;Hyperpituitarism (Pituitary Basophilism, Cushing's Syndrome)
 ;;7908;;304836;;Hyperpituitarism (Acromegaly or Gigantism)
 ;;7909;;304837;;Hypopituitarism (Diabetes Insipidus)
 ;;7911;;304839;;Addison's Disease (Adrenal Cortical Hypofunction)
 ;;7912;;304840;;Pluriglandular Syndromes
 ;;7913;;33574;;Diabetes Mellitus
 ;;7914;;304842;;Malignant new Growth of any part of the Endocrine System
 ;;7915;;304843;;Benign new Growth of any part of the Endocrine System
 ;;7917;;59900;;Hyperaldosteronism
 ;;7918;;93245;;Pheochromocytoma
 ;;7919;;1041;;C-Cell Hyperplasia of the Thyroid
 ;;8000;;40032;;Chronic Epidemic Encephalitis
 ;;8002;;304845;;Malignant new Growth of the Brain
 ;;8003;;304846;;Benign new Growth of the Brain
 ;;8004;;304847;;Paralysis Agitans
 ;;8005;;89852;;Bulbar Palsy
 ;;8007;;304848;;Embolism of the Vessels of the Brain
 ;;8008;;304849;;Thrombosis of the Vessels of the Brain
 ;;8009;;304850;;Hemorrhage from the Vessels of the Brain
 ;;8010;;80399;;Myelitis
 ;;8011;;304851;;Poliomyelitis (Anterior)
 ;;8012;;55412;;Hematomyelia
 ;;8013;;304852;;Cerebrospinal Syphilis
 ;;8014;;116847;;Meningovascular Syphilis
 ;;8015;;117008;;Tabes Dorsalis
 ;;8017;;6639;;Amyotrophic Lateral Sclerosis
 ;;8018;;79761;;Multiple Sclerosis
 ;;8019;;304853;;Epidemic Cerebrospinal Meningitis
 ;;8020;;304854;;Abscess of the Brain
 ;;8021;;304855;;Malignant new Growths of the Spinal Cord
 ;;8022;;304856;;Benign new Growths of the Spinal Cord
 ;;8023;;79999;;Progressive Muscular Atrophy
 ;;8024;;116870;;Syringomyelia
 ;;8025;;80166;;Myasthenia Gravis
 ;;8045;;304857;;Brain Diseases due to Trauma
 ;;8046;;21571;;Cerebral Atherosclerosis
 ;;8100;;55511;;Migraine, unspecified, without mention of Intractable Migraine
 ;;8100;;55512;;Migraine Headache (without mention of Intractable Migraine)
 ;;8100;;55513;;Migraine Headache
 ;;8100;;55514;;Migraine Headaches
 ;;8100;;55515;;Hemicranias
 ;;8103;;304858;;Convulsive Tic
 ;;8104;;89912;;Paramyoclonus Multiplex
 ;;8105;;265149;;Sydenham's Chorea
 ;;8106;;59370;;Huntington's Chorea
 ;;8107;;304861;;Acquired Athetosis
 ;;8108;;81337;;Narcolepsy
 ;;8205;;304862;;Paralysis of the fifth Cranial Nerve (Trigeminal)
 ;;8207;;304863;;Paralysis of the Seventh Cranial Nerve (Facialis)
 ;;8209;;304883;;Paralysis of the Ninth Cranial Nerve (Glossopharyngeal)
 ;;8210;;304885;;Paralysis of the Tenth Cranial Nerve (Vagus)
 ;;8211;;304887;;Paralysis of the Eleventh Cranial Nerve (Accessorius)
 ;;8212;;304889;;Paralysis of the Twelfth Cranial Nerve (Hypoglossus)
 ;;8305;;304891;;Neuritis of the fifth Cranial Nerve (Trigeminal)
 ;;8307;;304893;;Neuritis of the Seventh Cranial Nerve (Facialis)
 ;;8309;;304895;;Neuritis of the Ninth Cranial Nerve (Glossopharyngeal)
 ;;8310;;304897;;Neuritis of the Tenth Cranial Nerve (Vagus)
 ;;8311;;304899;;Neuritis of the Eleventh Cranial Nerve (Accessorius)
 ;;8312;;304901;;Neuritis of the Twelfth Cranial Nerve (Hypoglossus)
 ;;8405;;1044;;Neuralgia of the fifth Cranial Nerve
 ;;8407;;1046;;Neuralgia of the Seventh Cranial Nerve
 ;;8409;;268490;;Neuralgia of the Ninth Cranial Nerve (Glossopharyngeal)
 ;;8410;;304905;;Neuralgia of the Tenth Cranial Nerve (Vagus)
 ;;8411;;304907;;Neuralgia of the Eleventh Cranial Nerve (Accessorius)
 ;;8412;;304909;;Neuralgia of the Twelfth Cranial Nerve (Hypoglossus)
 ;;8510;;304911;;Paralysis of upper Radicular Nerves Affecting all Shoulder and Elbow Movements
 ;;8511;;304912;;Paralysis of Middle Radicular Nerves Affecting Adduction, Abduction and Rotation of Arm, Flexion of Elbow and Extention of Wrist
 ;;8512;;304913;;Paralysis of lower Radicular Nerves Affecting the Intrinsic Muscles of the Hand and Flexors of the Wrist and Fingers
 ;;8513;;304914;;Paralysis of all Radicular Nerves Affecting the Shoulder, Arm, Wrist and Hand
 ;;8514;;304915;;Paralysis of the Musculospiral Nerve (Radial Nerve)
 ;;8515;;304916;;Paralysis of the Median Nerve
 ;;8516;;304917;;Paralysis of the Ulnar Nerve
 ;;8517;;304918;;Paralysis of the Musculocutaneous Nerve (Lateral Cord)
 ;;8518;;304919;;Paralysis of the Circumflex Nerve
 ;;8519;;304920;;Paralysis of the Long Thoracic Nerve
 ;;8520;;304921;;Paralysis of the Sciatic Nerve
 ;;8521;;304922;;Paralysis of the Lateral Popliteal Nerve (Common Peroneal)
 ;;8522;;304923;;Paralysis of the Musculocutaneous Nerve (Superficial Peroneal)
 ;;8523;;304924;;Paralysis of the Anterior Tibial Nerve (Deep Peroneal)
 ;;8524;;304925;;Paralysis of the Internal Popliteal Nerve (Tibial)
 ;;8525;;304926;;Paralysis of the Posterior Tibial Nerve
 ;;8526;;304927;;Paralysis of the Anterior Crural Nerve (Femoral)
 ;;8527;;304928;;Paralysis of the Internal Saphenous Nerve
 ;;8528;;304929;;Paralysis of the Obturator Nerve
 ;;8529;;304930;;Paralysis of the External Cutaneous Nerve of the Thigh
 ;;8530;;304931;;Paralysis of the Ilio-Inguinal Nerve
 ;;8540;;304932;;Soft-Tissue Sarcoma of Neurogenic Origin
 ;;8610;;304933;;Neuritis of upper Radicular Nerves Affecting all Shoulder and Elbow Movements
 ;;8611;;304934;;Neuritis of Middle Radicular Nerves Affecting Adduction, Abduction and Rotation of Arm, Flexion of Elbow and Extention of Wrist
 ;;8612;;304935;;Neuritis of lower Radicular Nerves Affecting the Intrinsic Muscles of the Hand and Flexors of the Wrist and Fingers
 ;;8613;;304936;;Neuritis of all Radicular Nerves Affecting the Shoulder, Arm, Wrist and Hand
 ;;8614;;304937;;Neuritis of the Musculospiral Nerve (Radial Nerve)
 ;;8615;;304938;;Neuritis of the Median Nerve
 ;;8616;;304939;;Neuritis of the Ulnar Nerve
 ;;8617;;304940;;Neuritis of the Musculocutaneous Nerve (Lateral Cord)
 ;;8618;;304941;;Neuritis of the Circumflex Nerve
 ;;8619;;304942;;Neuritis of the Long Thoracic Nerve
 ;;8620;;304943;;Neuritis of the Sciatic Nerve
 ;;8621;;304944;;Neuritis of the Lateral Popliteal Nerve (Common Peroneal)
 ;;8622;;304945;;Neuritis of the Musculocutaneous Nerve (Superficial Peroneal)
 ;;8623;;304946;;Neuritis of the Anterior Tibial Nerve (Deep Peroneal)
 ;;8624;;304953;;Neuritis of the Internal Popliteal Nerve (Tibial)
 ;;8625;;304947;;Neuritis of the Posterior Tibial Nerve
 ;;8626;;304948;;Neuritis of the Anterior Crural Nerve (Femoral)
 ;;8627;;304949;;Neuritis of the Internal Saphenous Nerve
 ;;8628;;304950;;Neuritis of the Obturator Nerve
 ;;8629;;304951;;Neuritis of the External Cutaneous Nerve of the Thigh
 ;;8630;;304952;;Neuritis of the Ilio-Inguinal Nerve
 ;;;;;;
