LEX2073G ;ISL/KER - LEX*2.0*73 Post-Install - Mixed Case 3 ;01/03/2011
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
 . S LEXSO=$P(LEXLN,";;",1),LEXIEN=$P(LEXLN,";;",2),LEXEXP=$P(LEXLN,";;",3) Q:'$L(LEXSO)  Q:+LEXIEN'>0  Q:'$D(^LEX(757.01,+LEXIEN,0))  Q:'$L(LEXEXP)
 . K LEXFDA S LEXIENS=LEXIEN_",",LEXFDA(757.01,LEXIENS,.01)=$G(LEXEXP)
 . D FILE^DIE("","LEXFDA") S DA=LEXIEN,DIK="^LEX(757.01," D IX1^DIK
 Q
 D MES^XPDUTL("                                      8710-9916")
 ;;CODE;;757.01;;EXP
LEX ;; 8710-9916
 ;;8710;;304954;;Neuralgia of upper Radicular Nerves Affecting all Shoulder and Elbow Movements
 ;;8711;;304955;;Neuralgia of Middle Radicular Nerves Affecting Adduction, Abduction and Rotation of Arm, Flexion of Elbow and Extention of Wrist
 ;;8712;;304956;;Neuralgia of lower Radicular Nerves Affecting the Intrinsic Muscles of the Hand and Flexors of the Wrist and Fingers
 ;;8713;;304957;;Neuralgia of all Radicular Nerves Affecting the Shoulder, Arm, Wrist and Hand
 ;;8714;;304958;;Neuralgia of the Musculospiral Nerve (Radial Nerve)
 ;;8715;;304959;;Neuralgia of the Median Nerve
 ;;8716;;304960;;Neuralgia of the Ulnar Nerve
 ;;8717;;304961;;Neuralgia of the Musculocutaneous Nerve (Lateral Cord)
 ;;8718;;304962;;Neuralgia of the Circumflex Nerve
 ;;8719;;304963;;Neuralgia of the Long Thoracic Nerve
 ;;8720;;304964;;Neuralgia of the Sciatic Nerve
 ;;8721;;304965;;Neuralgia of the Lateral Popliteal Nerve (Common Peroneal)
 ;;8722;;304966;;Neuralgia of the Musculocutaneous Nerve (Superficial Peroneal)
 ;;8723;;304967;;Neuralgia of the Anterior Tibial Nerve (Deep Peroneal)
 ;;8724;;304968;;Neuralgia of the Internal Popliteal Nerve (Tibial)
 ;;8725;;304969;;Neuralgia of the Posterior Tibial Nerve
 ;;8726;;304970;;Neuralgia of the Anterior Crural Nerve (Femoral)
 ;;8727;;304971;;Neuralgia of the Internal Saphenous Nerve
 ;;8728;;304972;;Neuralgia of the Obturator Nerve
 ;;8729;;304973;;Neuralgia of the External Cutaneous Nerve of the Thigh
 ;;8730;;304974;;Neuralgia of the Ilio-Inguinal Nerve
 ;;8910;;41462;;Epilepsy (Grand Mal)
 ;;8911;;41507;;Epilepsy (Petit Mal)
 ;;8912;;304975;;Epilepsy (Jacksonian and Focal Motor or Sensory)
 ;;8913;;304976;;Epilepsy (Diencephalic)
 ;;8914;;189204;;Epilepsy (Psychomotor)
 ;;9201;;108318;;Schizophrenia (Disorganized Type)
 ;;9202;;108305;;Schizophrenia (Catatonic Type)
 ;;9203;;108330;;Schizophrenia (Paranoid Type)
 ;;9204;;108345;;Schizophrenia (Undifferentiated Type)
 ;;9205;;88157;;Other Specified Types of Schizophrenia
 ;;9208;;304979;;Delusional Disorder
 ;;9210;;11537;;Psychotic Disorder
 ;;9211;;108264;;Schizoaffective Disorder
 ;;9300;;304981;;Delirium
 ;;9301;;304983;;Dementia due to Infection
 ;;9304;;304989;;Dementia due to Head Trauma
 ;;9305;;304990;;Multi-Infarct Dementia with Cerebral Arteriosclerosis
 ;;9310;;304995;;Dementia of Unknown Etiology
 ;;9312;;98227;;Dementia of Alzheimer's type
 ;;9326;;186640;;Dementia due to other Medical Conditions
 ;;9327;;86314;;Organic Mental Disorder
 ;;9400;;50059;;Generalized Anxiety Disorder
 ;;9403;;93431;;Specific (Simple) Phobia
 ;;9404;;84900;;Obsessive-Compulsive Disorder
 ;;9410;;83041;;Other and unspecified Neurosis
 ;;9411;;305004;;Post-Traumatic Stress Disorder
 ;;9412;;89489;;Panic Disorder
 ;;9413;;9211;;Anxiety Disorder
 ;;9416;;303640;;Amnesia, Fugue, Identity Disorder
 ;;9417;;32878;;Depersonalization Disorder
 ;;9421;;112280;;Somatization Disorder
 ;;9422;;1048;;Pain Disorder
 ;;9423;;123543;;Undifferentiated Somatoform Disorder
 ;;9424;;28139;;Conversion Disorder
 ;;9425;;60556;;Hypochondriasis
 ;;9431;;30028;;Cyclothymic Disorder
 ;;9432;;14791;;Bipolar Disorder
 ;;9433;;303478;;Dysthymic Disorder
 ;;9434;;73302;;Major Depressive Disorder
 ;;9435;;303635;;Mood Disorder
 ;;9440;;1049;;Chronic Adjustment Disorder
 ;;9520;;7942;;Anorexia Nervosa
 ;;9521;;17407;;Bulimia Nervosa
 ;;9900;;305017;;Osteomyelitis or Osteoradionecrosis of Maxilla or Mandible
 ;;9901;;305018;;Complete Loss of Mandible between Angles
 ;;9902;;305019;;Loss of Approximately One-Half of Mandible
 ;;9903;;305020;;Nonunion of Mandible
 ;;9904;;305021;;Malunion of Mandible
 ;;9905;;305022;;Limitation of Motion of Temporomandibular Articulation
 ;;9906;;305023;;Loss of Whole or part of the Mandibular Ramus
 ;;9907;;305024;;Loss of less than One-Half of the Substance of the Madibular Ramus without Involving a Loss of Continuity
 ;;9908;;305025;;Loss of Condylar Process of Mandible (One or both Sides)
 ;;9909;;305026;;Loss of Coronoid Process of Mandible
 ;;9911;;305028;;Loss of Half or more of the Hard Palate
 ;;9912;;305029;;Loss of less than Half of the Hard Palate
 ;;9913;;305030;;Loss of Teeth due to Loss of the Substance of the Body of the Maxilla or Mandible without a Loss of Continuity
 ;;9914;;305031;;Loss of more than Half of the Maxilla
 ;;9915;;305032;;Loss of Half or less of the Maxilla
 ;;9916;;305033;;Nonunion or Malunion of the Maxilla
 ;;333.72;;334067;;Acute Dystonia due to Drugs
 ;;333.79;;334068;;Other Acquired Torsion Dystonia
 ;;;;;;
