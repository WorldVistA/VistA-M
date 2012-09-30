LEX2073D ;ISL/KER - LEX*2.0*73 Post-Install - Mixed Case 2 ;01/03/2011
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
 D MES^XPDUTL("                                      5260-6354")
LEX ;; 5260-6354
 ;;5260;;304531;;Limitation of Flexion of Leg
 ;;5261;;304532;;Limitation of Extension of Leg
 ;;5262;;304533;;Impairment of Tibia and Fibula
 ;;5263;;265468;;Genu Recurvatum
 ;;5270;;304534;;Ankylosis of Ankle
 ;;5271;;304535;;Limitation of Motion of Ankle
 ;;5272;;304536;;Ankylosis of Subastragalar or Tarsal Joint
 ;;5273;;304537;;Malunion of Os Calcis or Astragalus
 ;;5274;;304545;;Astragalectomy
 ;;5275;;304539;;Shortening of Bones of the lower Extremity
 ;;5276;;46749;;Flatfoot
 ;;5277;;304540;;Weak Foot (Bilateral)
 ;;5278;;272746;;Claw Foot (Pes Cavus), Acquired
 ;;5279;;304541;;Anterior Metatarsalgia (Morton's Disease)
 ;;5280;;53764;;Hallux Valgus
 ;;5281;;265483;;Hallux Rigidus
 ;;5282;;186911;;Hammer Toe
 ;;5283;;304542;;Nonunion or Malunion of the Tarsal or Metatarsal Bones
 ;;5284;;304543;;Foot Injuries
 ;;5295;;12249;;Back Strain
 ;;5296;;304556;;Loss of part of the Skull (both Inner and outer Tables)
 ;;5297;;304557;;Removal of Ribs
 ;;5298;;304558;;Removal of Coccyx
 ;;5301;;304559;;Injury to the Extrinsic Muscles of the Shoulder Girdle (Group I Function: Upward Rotation of Scapula)
 ;;5302;;304566;;Injury to the Extrinsic Muscles of the Shoulder Girdle (Group II Function: Depression of Arm)
 ;;5303;;304567;;Injury to the Intrinsic Muscles of the Shoulder Girdle (Group III Function: Elevation and Abduction of Arm)
 ;;5304;;304568;;Injury to the Intrinsic Muscles of the Shoulder Girdle (Group IV Function: Stabilization of Shoulder)
 ;;5305;;304569;;Injury to the Flexor Muscles of the Elbow (Group V Function: Elbow Supination)
 ;;5306;;304570;;Injury to the Extensor Muscles of the Elbow (Group VI Function: Extension of Elbow)
 ;;5307;;304571;;Injury to the Muscles from the Internal Condyle of the Humerus (Group VII Function: Flexion of Wrist and Fingers)
 ;;5308;;304572;;Injury to the Muscles from the External Condyle of the Humerus (Group VIII Function: Extension of Wrist, Fingers, Thumb)
 ;;5309;;304573;;Injury to the Muscles of the Hand (Group IX Function: Forearm Muscles)
 ;;5310;;304574;;Injury to the Muscles of the Foot (Group X Function: Movement of Forefoot and Toes)
 ;;5311;;304575;;Injury to the Posterior and Lateral Muscles of the Leg (Group XI Function: Propulsion of Foot)
 ;;5312;;304576;;Injury to the Anterior Muscles of the Leg (Group XII Function: Dorsiflexion)
 ;;5313;;304577;;Injury to the Posterior Muscles of the Thigh (Group XIII Function: Extension of Hip and Flexion of Knee)
 ;;5314;;304578;;Injury to the Anterior Muscles of the Thigh (Group XIV Function: Extension of Knee)
 ;;5315;;304579;;Injury to the Mesial Muscles of the Thigh (Group Xv Function: Adduction of Hip)
 ;;5316;;304580;;Injury to the Muscles of the Pelvic Girdle (Group XVI Function: Flexion of Hip)
 ;;5317;;304581;;Injury to the Muscles of the Pelvic Girdle (Group XVII Function: Extension of Hip)
 ;;5318;;304582;;Injury to the Muscles of the Pelvic Girdle (Group XVIII Function: Outward Rotation of Thigh)
 ;;5319;;304583;;Injury to the Muscles of the Abdominal Wall (Group XIX Function: Abdominal Wall and lower Thorax)
 ;;5320;;304584;;Injury to the Muscles of the Spine (Group XX Function: Postural Support of Body)
 ;;5321;;304585;;Injury to the Muscles Involved with Respiration (Group XXI Function: Respiration)
 ;;5322;;304586;;Injury to the Muscles of the Front of the Neck (Group XXII Function: Rotary and Forward Movements, Head)
 ;;5323;;304587;;Injury to the Lateral and Posterior Muscles of the Neck (Group XXIII Function: Movements of Head)
 ;;5324;;304588;;Rupture of Diaphragm
 ;;5325;;304589;;Injury to the Muscles of the Face
 ;;5326;;304590;;Muscle Hernia
 ;;5327;;1054;;Malignant Neoplasm of Muscle
 ;;5328;;304606;;Benign Neoplasm of Muscle
 ;;5329;;304607;;Soft Tissue Sarcoma of Muscle, Fat or Connective Tissue
 ;;6000;;124827;;Uveitis
 ;;6001;;66755;;Keratitis
 ;;6002;;108564;;Scleritis
 ;;6003;;65605;;Iritis
 ;;6004;;29915;;Cyclitis
 ;;6005;;23985;;Choroiditis
 ;;6006;;105686;;Retinitis
 ;;6007;;304591;;Intraocular Hemorrhage, Recent
 ;;6008;;105529;;Retinal Detachment
 ;;6009;;304592;;Unhealed Injury of the Eye
 ;;6010;;304593;;Tuberculosis of the Eye
 ;;6011;;304594;;Localized Retinal Scars
 ;;6012;;304595;;Glaucoma (Congestive or Inflammatory)
 ;;6013;;304596;;Glaucoma (Simple, Primary, Noncongestive)
 ;;6014;;304597;;Malignant new Growths of the Eye
 ;;6015;;304598;;Benign new Growths of the Eye and Adnexa
 ;;6016;;304599;;Nystagmus, Central
 ;;6017;;304600;;Trachomatous Conjunctivitis (Chronic)
 ;;6018;;269008;;Chronic Conjunctivitis
 ;;6019;;15283;;Ptosis (Drooping Eyelid)
 ;;6020;;38326;;Ectropion
 ;;6021;;41016;;Entropion
 ;;6022;;265452;;Lagophthalmos
 ;;6023;;304601;;Loss of Eyebrows
 ;;6024;;304603;;Loss of Eyelashes
 ;;6025;;265453;;Epiphora
 ;;6026;;86002;;Optic Neuritis
 ;;6027;;268802;;Traumatic Cataract
 ;;6028;;20264;;Cataract
 ;;6029;;9445;;Aphakia
 ;;6030;;304605;;Paralysis of Accommodation
 ;;6031;;30880;;Dacryocystitis
 ;;6032;;304608;;Loss of a Portion of an Eyelid
 ;;6033;;304609;;Dislocation of Crystalline Lens
 ;;6034;;304610;;Pterygium
 ;;6035;;66799;;Keratoconus
 ;;6061;;304611;;Anatomical Loss of both Eyes
 ;;6062;;304613;;Blindness in both Eyes Having only Light Perception
 ;;6063;;304614;;Anatomical Loss of One Eye and 5/200 or less in the other Eye
 ;;6064;;304615;;Anatomical Loss of One Eye and 20/200 or less in the other Eye
 ;;6065;;304616;;Anatomical Loss of One Eye and Impaired Vision in the other Eye
 ;;6066;;304617;;Anatomical Loss of One Eye and Normal Vision in the other Eye
 ;;6067;;304618;;Blindnes of One Eye (Having only Light Perception) and 5/200 or less in the other Eye
 ;;6068;;304619;;Blindnes of One Eye (Having only Light Perception) and 20/200 or less in the other Eye
 ;;6069;;304620;;Blindnes of One Eye (Having only Light Perception) and Impaired Vision in the other Eye
 ;;6070;;304621;;Blindnes of One Eye (Having only Light Perception) and Normal Vision in the other Eye
 ;;6071;;304622;;Total Blindnes of both Eyes (5/200 or less)
 ;;6072;;304623;;Total Blindnes of One Eye (5/200 or less) and 20/200 or less in the other Eye
 ;;6073;;304624;;Total Blindnes of One Eye (5/200 or less) and Impaired Vision in the other Eye
 ;;6074;;304625;;Total Blindnes of One Eye (5/200 or less) and Normal Vision in the other Eye
 ;;6075;;304626;;Partial Blindnes of both Eyes (20/200 or less)
 ;;6076;;304627;;Partial Blindnes of One Eye (20/200 or less) and Impaired Vision in the other Eye
 ;;6077;;304628;;Partial Blindnes of One Eye (20/200 or less) and Normal Vision in the other Eye
 ;;6078;;304629;;Partial Blindnes of both Eyes (unspecified)
 ;;6079;;304630;;Partial Blindnes of One Eye (unspecified)
 ;;6080;;304631;;Impairment of Field Vision
 ;;6081;;304632;;Unilateral Pathological Scotoma
 ;;6090;;304634;;Impairment of Ocular Muscle Function
 ;;6091;;265885;;Symblepharon
 ;;6092;;304633;;Diplopia due to Limited Muscle Funciton
 ;;6200;;186937;;Chronic Suppurative Otitis Media
 ;;6201;;304646;;Chronic Catarrhal Otitis Media
 ;;6202;;88333;;Otosclerosis
 ;;6204;;67891;;Labyrinthitis
 ;;6205;;75725;;Meniere's Syndrome
 ;;6207;;304649;;Loss or Deformity of Auricle
 ;;6208;;304650;;Malignant new Growth of Ear (other than Skin only)
 ;;6209;;304651;;Benign new Growth of Ear (other than Skin only)
 ;;6210;;304653;;Disease of Auditory Canal
 ;;6211;;259079;;Perforation of Tympanic Membrane
 ;;6260;;119771;;Tinnitus
 ;;6275;;304654;;Loss of Sense of Smell
 ;;6276;;304655;;Loss of Sense of Taste
 ;;6300;;304656;;Asiatic Cholera
 ;;6301;;304657;;Kala-Azar (Visceral Leishmaniasis)
 ;;6302;;304669;;Leprosy (Hansen's Disease)
 ;;6304;;73348;;Malaria
 ;;6305;;46368;;Filariasis
 ;;6306;;12767;;Bartonella Infections
 ;;6307;;94858;;Plague
 ;;6308;;104564;;Relapsing Fever
 ;;6309;;105990;;Rheumatic Fever
 ;;6310;;116808;;Syphilis
 ;;6311;;122716;;Tuberculosis (Miliary)
 ;;6313;;11962;;Avitaminosis
 ;;6314;;13556;;Beriberi
 ;;6315;;91049;;Pellagra
 ;;6316;;304658;;Brucellosis (Malta or Undulant Fever)
 ;;6317;;108735;;Scrub Typhus
 ;;6318;;75520;;Melioidosis
 ;;6319;;72315;;Lyme Disease
 ;;6320;;90094;;Parasitic Diseases NOS
 ;;6350;;304660;;Systemic Lupus Erythematosus (Disseminated)
 ;;6351;;304652;;Human Immunodeficiency Virus (HIV) Related Illness (unspecified)
 ;;6354;;304659;;Chronic Fatigue Syndrome
 ;;;;;;
