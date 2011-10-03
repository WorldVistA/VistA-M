LEX2073C ;ISL/KER - LEX*2.0*73 Post-Install - Mixed Case 1 ;01/03/2011
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
 D MES^XPDUTL("     Mixed Case Expressions for codes 5000-5259")
ALL ; All Mixed Case
 D EN^LEX2073C,EN^LEX2073D,EN^LEX2073E,EN^LEX2073F,EN^LEX2073G
 Q
LEX ;; 5000-5259
 ;;5000;;304359;;Osteomyelitis (Acute, Subacute or Chronic)
 ;;5001;;276893;;Tuberculosis of Bones and Joints
 ;;5002;;304360;;Rheumatoid Arthritis (Atrophic)
 ;;5003;;304361;;Degenerative Arthritis (Hypertrophic or Osteoarthritis)
 ;;5004;;52564;;Arthritis(Gonorrheal)
 ;;5005;;304362;;Arthritis (Pneumococcal)
 ;;5006;;304363;;Arthritis (Typhoid)
 ;;5007;;304364;;Arthritis (Syphilitic)
 ;;5008;;304427;;Arthritis (Streptococcal)
 ;;5009;;10412;;Arthritis
 ;;5010;;304428;;Arthritis due to Trauma
 ;;5011;;304429;;Caisson Disease of Bones
 ;;5012;;304431;;Malignant new Growth of Bones
 ;;5013;;304430;;Osteoporosis with Joint Manifestations
 ;;5014;;87103;;Osteomalacia
 ;;5015;;304432;;Benign new Growth of Bones
 ;;5016;;86875;;Osteitis Deformans
 ;;5017;;52625;;Gout
 ;;5018;;259836;;Hydrarthrosis (Intermittent)
 ;;5019;;17635;;Bursitis
 ;;5020;;116765;;Synovitis
 ;;5021;;80761;;Myositis
 ;;5022;;92151;;Periostitis
 ;;5023;;80766;;Myositis Ossificans
 ;;5024;;117815;;Tenosynovitis
 ;;5025;;46261;;Fibromyalgia
 ;;5051;;304560;;Shoulder Replacement (Prosthesis)
 ;;5052;;304561;;Elbow Replacement (Prosthesis)
 ;;5053;;304562;;Wrist Replacement (Prosthesis)
 ;;5054;;304563;;Hip Replacement (Prosthesis)
 ;;5055;;304564;;Knee Replacement (Prosthesis)
 ;;5056;;304565;;Ankle Replacement (Prosthesis)
 ;;5104;;304437;;Anatomical Loss of One Hand and Loss of use of One Foot
 ;;5105;;304438;;Anatomical Loss of One Foot and Loss of use of One Hand
 ;;5106;;304439;;Anatomical Loss of both Hands
 ;;5107;;304440;;Anatomical Loss of both Feet
 ;;5108;;304441;;Anatomical Loss of One Hand and One Foot
 ;;5109;;304442;;Loss of use of both Hands
 ;;5110;;304443;;Loss of use of both Feet
 ;;5111;;304444;;Loss of use of One Hand and One Foot
 ;;5120;;304445;;Disarticulation of Arm
 ;;5121;;304446;;Amputation of Arm above Insertion of Deltoid
 ;;5122;;304447;;Amputation of Arm below Insertion of Deltoid
 ;;5123;;304448;;Amputation of Forearm above Insertion of Pronator Teres
 ;;5124;;304449;;Amputation of Forearm below Insertion of Pronator Teres
 ;;5125;;304450;;Amputation of Hand
 ;;5126;;304451;;Amputation of Five Digits of One Hand
 ;;5127;;304452;;Amputation of Four Digits of One Hand including the Thumb, Index, Middle and Ring Fingers
 ;;5128;;304453;;Amputation of Four Digits of One Hand including the Thumb, Index, Middle and Little Fingers
 ;;5129;;304454;;Amputation of Four Digits of One Hand including the Thumb, Index, Ring and Little Fingers
 ;;5130;;304455;;Amputation of Four Digits of One Hand including the Thumb, Middle, Ring and Little Fingers
 ;;5131;;304456;;Amputation of Four Digits of One Hand including the Index, Middle, Ring and Little Fingers
 ;;5132;;304457;;Amputation of Three Digits of One Hand including the Thumb, Index and Middle Fingers
 ;;5133;;304458;;Amputation of Three Digits of One Hand including the Thumb, Index and Ring Fingers
 ;;5134;;304459;;Amputation of Three Digits of One Hand including the Thumb, Index and Little Fingers
 ;;5135;;304460;;Amputation of Three Digits of One Hand including the Thumb, Middle and Ring Fingers
 ;;5136;;304461;;Amputation of Three Digits of One Hand including the Thumb, Middle and Little Fingers
 ;;5137;;304462;;Amputation of Three Digits of One Hand including the Thumb, Ring and Little Fingers
 ;;5138;;304463;;Amputation of Three Digits of One Hand including the Index, Middle and Ring Fingers
 ;;5139;;304464;;Amputation of Three Digits of One Hand including the Index, Middle and Little Fingers
 ;;5140;;304465;;Amputation of Three Digits of One Hand including the Index, Ring and Little Fingers
 ;;5141;;304466;;Amputation of Three Digits of One Hand including the Middle, Ring and Little Fingers
 ;;5142;;304467;;Amputation of Two Digits of One Hand including the Thumb and Index Finger
 ;;5143;;304468;;Amputation of Two Digits of One Hand including the Thumb and Middle Finger
 ;;5144;;304469;;Amputation of Two Digits of One Hand including the Thumb and Ring Finger
 ;;5145;;304470;;Amputation of Two Digits of One Hand including the Thumb and Little Finger
 ;;5146;;304471;;Amputation of Two Digits of One Hand including the Index and Middle Fingers
 ;;5147;;304472;;Amputation of Two Digits of One Hand including the Index and Ring Fingers
 ;;5148;;304473;;Amputation of Two Digits of One Hand including the Index and Little Fingers
 ;;5149;;304474;;Amputation of Two Digits of One Hand including the Middle and Ring Fingers
 ;;5150;;304475;;Amputation of Two Digits of One Hand including the Middle and Little Fingers
 ;;5151;;304476;;Amputation of Two Digits of One Hand including the Ring and Little Fingers
 ;;5152;;304477;;Amputation of the Thumb
 ;;5153;;304478;;Amputation of the Index Finger
 ;;5154;;304479;;Amputation of the Middle Finger
 ;;5155;;304480;;Amputation of the Ring Finger
 ;;5156;;304481;;Amputation of the Little Finger
 ;;5160;;304482;;Disarticulation of Thigh
 ;;5161;;304483;;Amputation of Upper Third of Thigh
 ;;5162;;304484;;Amputation of Middle or Lower Third of Thigh
 ;;5163;;304485;;Amputation of Leg with Defective Stump
 ;;5164;;304486;;Amputation of Leg with Loss of Natural Knee Action
 ;;5165;;304487;;Amputation of Leg at a lower Level Permitting Prosthesis
 ;;5166;;304488;;Amputation of Forefoot, Proximal to Metatarsal Bones
 ;;5167;;304489;;Loss of use of Foot
 ;;5170;;304490;;Amputation of all Toes without Metatarsal Loss
 ;;5171;;304491;;Amputation of Great Toe
 ;;5172;;304492;;Amputation of Toe other than the Great Toe
 ;;5173;;304493;;Amputation of Three or more Toes other than the Great Toe
 ;;5200;;304494;;Ankylosis of the Scapulohumeral Articulation
 ;;5201;;304495;;Limitation of Motion of Arm
 ;;5202;;304496;;Impairment of Humerus
 ;;5203;;304497;;Impairment of Clavicle or Scapula
 ;;5205;;304498;;Ankylosis of Elbow
 ;;5206;;304499;;Limitation of Flexion of Forearm
 ;;5207;;304500;;Limitation of Extension of Forearm
 ;;5208;;304501;;Forearm Flexion and Extension Limited
 ;;5209;;304502;;Impairment of Elbow
 ;;5210;;304506;;Nonunion of Radius and Ulna
 ;;5211;;304503;;Impairment of Ulna
 ;;5212;;304504;;Impairment of Radius
 ;;5213;;304505;;Impairment of Supination and Pronation of the Forearm
 ;;5214;;304507;;Ankylosis of Wrist
 ;;5215;;304508;;Limitation of Motion of Wrist
 ;;5216;;304509;;Unfavorable Ankylosis of Five Digits of One Hand
 ;;5217;;304510;;Unfavorable Ankylosis of Four Digits of One Hand
 ;;5218;;304511;;Unfavorable Ankylosis of Three Digits of One Hand
 ;;5219;;304512;;Unfavorable Ankylosis of Two Digits of One Hand
 ;;5220;;304513;;Favorable Ankylosis of Five Digits of One Hand
 ;;5221;;304514;;Favorable Ankylosis of Four Digits of One Hand
 ;;5222;;304515;;Favorable Ankylosis of Three Digits of One Hand
 ;;5223;;304516;;Favorable Ankylosis of Two Digits of One Hand
 ;;5224;;304517;;Ankylosis of Thumb
 ;;5225;;304518;;Ankylosis of Index Finger
 ;;5226;;304519;;Ankylosis of Middle Finger
 ;;5227;;304520;;Ankylosis of Ring or Little Finger
 ;;5228;;1050;;Limitation of Motion of the Thumb
 ;;5229;;1051;;Limitation of Motion of the Index or Long Finger
 ;;5230;;1052;;Limitation of Motion of the Ring or Little Finger
 ;;5235;;1053;;Vertebral Fracture or Dislocation
 ;;5236;;304554;;Sacroiliac Injury and Weakness
 ;;5237;;1001;;Lumbosacral or Cervical Strain
 ;;5238;;113278;;Spinal Stenosis
 ;;5239;;1002;;Spondylolisthesis or Segmental Instability
 ;;5240;;113484;;Ankylosing Spondylitis
 ;;5241;;113230;;Spinal Fusion
 ;;5242;;1004;;Degenerative Arthritis of the Spine
 ;;5243;;304553;;Intervertebral Disc Syndrome
 ;;5250;;304521;;Ankylosis of Hip
 ;;5251;;304522;;Limitation of Extension of Thigh
 ;;5252;;304523;;Limitation of Flexion of Thigh
 ;;5253;;304524;;Impairment of Thigh
 ;;5254;;304525;;Flail Joint of Hip
 ;;5255;;304526;;Impairment of Femur
 ;;5256;;304527;;Ankylosis of Knee
 ;;5257;;304528;;Impairment of Knee
 ;;5258;;304529;;Semilunar Cartilage Dislocation Involving the Knee
 ;;5259;;304530;;Semilunar Cartilage Removal Involving the Knee
 ;;;;;;
