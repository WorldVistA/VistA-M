IBDEI02P ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3078,2)
 ;;=^5008353
 ;;^UTILITY(U,$J,358.3,3079,0)
 ;;=J95.822^^17^216^18
 ;;^UTILITY(U,$J,358.3,3079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3079,1,3,0)
 ;;=3^Respiratory Failure,Postprocedural,Acute/Chronic
 ;;^UTILITY(U,$J,358.3,3079,1,4,0)
 ;;=4^J95.822
 ;;^UTILITY(U,$J,358.3,3079,2)
 ;;=^5008339
 ;;^UTILITY(U,$J,358.3,3080,0)
 ;;=J44.1^^17^216^1
 ;;^UTILITY(U,$J,358.3,3080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3080,1,3,0)
 ;;=3^COPD w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,3080,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,3080,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,3081,0)
 ;;=J90.^^17^216^11
 ;;^UTILITY(U,$J,358.3,3081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3081,1,3,0)
 ;;=3^Pleural Effusion NEC
 ;;^UTILITY(U,$J,358.3,3081,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,3081,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,3082,0)
 ;;=J18.9^^17^216^13
 ;;^UTILITY(U,$J,358.3,3082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3082,1,3,0)
 ;;=3^Pneumonia,Organism Unspec
 ;;^UTILITY(U,$J,358.3,3082,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,3082,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,3083,0)
 ;;=J15.9^^17^216^12
 ;;^UTILITY(U,$J,358.3,3083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3083,1,3,0)
 ;;=3^Pneumonia,Bacterial
 ;;^UTILITY(U,$J,358.3,3083,1,4,0)
 ;;=4^J15.9
 ;;^UTILITY(U,$J,358.3,3083,2)
 ;;=^5008178
 ;;^UTILITY(U,$J,358.3,3084,0)
 ;;=J69.0^^17^216^14
 ;;^UTILITY(U,$J,358.3,3084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3084,1,3,0)
 ;;=3^Pneumonitis d/t Inhalation of Food/Vomit
 ;;^UTILITY(U,$J,358.3,3084,1,4,0)
 ;;=4^J69.0
 ;;^UTILITY(U,$J,358.3,3084,2)
 ;;=^5008288
 ;;^UTILITY(U,$J,358.3,3085,0)
 ;;=J11.00^^17^216^3
 ;;^UTILITY(U,$J,358.3,3085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3085,1,3,0)
 ;;=3^Flu d/t Flu Virus w/ Unspec Type of Pneumonia
 ;;^UTILITY(U,$J,358.3,3085,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,3085,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,3086,0)
 ;;=C34.91^^17^216^8
 ;;^UTILITY(U,$J,358.3,3086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3086,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,3086,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,3086,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,3087,0)
 ;;=C34.92^^17^216^5
 ;;^UTILITY(U,$J,358.3,3087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3087,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,3087,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,3087,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,3088,0)
 ;;=I26.99^^17^216^15
 ;;^UTILITY(U,$J,358.3,3088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3088,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,3088,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,3088,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,3089,0)
 ;;=R07.82^^17^216^4
 ;;^UTILITY(U,$J,358.3,3089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3089,1,3,0)
 ;;=3^Intercostal Pain
 ;;^UTILITY(U,$J,358.3,3089,1,4,0)
 ;;=4^R07.82
 ;;^UTILITY(U,$J,358.3,3089,2)
 ;;=^5019199
 ;;^UTILITY(U,$J,358.3,3090,0)
 ;;=R07.89^^17^216^2
 ;;^UTILITY(U,$J,358.3,3090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3090,1,3,0)
 ;;=3^Chest Pain,Other
 ;;^UTILITY(U,$J,358.3,3090,1,4,0)
 ;;=4^R07.89
 ;;^UTILITY(U,$J,358.3,3090,2)
 ;;=^5019200
 ;;^UTILITY(U,$J,358.3,3091,0)
 ;;=C34.11^^17^216^10
 ;;^UTILITY(U,$J,358.3,3091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3091,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Upper Lobe
 ;;^UTILITY(U,$J,358.3,3091,1,4,0)
 ;;=4^C34.11
 ;;^UTILITY(U,$J,358.3,3091,2)
 ;;=^5000961
 ;;^UTILITY(U,$J,358.3,3092,0)
 ;;=C34.12^^17^216^7
 ;;^UTILITY(U,$J,358.3,3092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3092,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Upper Lobe
 ;;^UTILITY(U,$J,358.3,3092,1,4,0)
 ;;=4^C34.12
 ;;^UTILITY(U,$J,358.3,3092,2)
 ;;=^5000962
 ;;^UTILITY(U,$J,358.3,3093,0)
 ;;=C34.31^^17^216^9
 ;;^UTILITY(U,$J,358.3,3093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3093,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Lower Lobe
 ;;^UTILITY(U,$J,358.3,3093,1,4,0)
 ;;=4^C34.31
 ;;^UTILITY(U,$J,358.3,3093,2)
 ;;=^5133321
 ;;^UTILITY(U,$J,358.3,3094,0)
 ;;=C34.32^^17^216^6
 ;;^UTILITY(U,$J,358.3,3094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3094,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Lower Lobe
 ;;^UTILITY(U,$J,358.3,3094,1,4,0)
 ;;=4^C34.32
 ;;^UTILITY(U,$J,358.3,3094,2)
 ;;=^5133322
 ;;^UTILITY(U,$J,358.3,3095,0)
 ;;=M47.12^^17^217^6
 ;;^UTILITY(U,$J,358.3,3095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3095,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,3095,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,3095,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,3096,0)
 ;;=M48.06^^17^217^5
 ;;^UTILITY(U,$J,358.3,3096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3096,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,3096,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,3096,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,3097,0)
 ;;=M48.02^^17^217^4
 ;;^UTILITY(U,$J,358.3,3097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3097,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,3097,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,3097,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,3098,0)
 ;;=M17.0^^17^217^1
 ;;^UTILITY(U,$J,358.3,3098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3098,1,3,0)
 ;;=3^Osteoarthritis of Knee,Primary Bilateral
 ;;^UTILITY(U,$J,358.3,3098,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,3098,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,3099,0)
 ;;=M17.11^^17^217^3
 ;;^UTILITY(U,$J,358.3,3099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3099,1,3,0)
 ;;=3^Osteoarthritis of Knee,Primary Right
 ;;^UTILITY(U,$J,358.3,3099,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,3099,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,3100,0)
 ;;=M17.12^^17^217^2
 ;;^UTILITY(U,$J,358.3,3100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3100,1,3,0)
 ;;=3^Osteoarthritis of Knee,Primary Left
 ;;^UTILITY(U,$J,358.3,3100,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,3100,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,3101,0)
 ;;=E87.5^^17^218^11
 ;;^UTILITY(U,$J,358.3,3101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3101,1,3,0)
 ;;=3^Hyperkalemia
 ;;^UTILITY(U,$J,358.3,3101,1,4,0)
 ;;=4^E87.5
 ;;^UTILITY(U,$J,358.3,3101,2)
 ;;=^60041
 ;;^UTILITY(U,$J,358.3,3102,0)
 ;;=E87.1^^17^218^12
 ;;^UTILITY(U,$J,358.3,3102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3102,1,3,0)
 ;;=3^Hypo-osmolality and Hyponatremia
 ;;^UTILITY(U,$J,358.3,3102,1,4,0)
 ;;=4^E87.1
 ;;^UTILITY(U,$J,358.3,3102,2)
 ;;=^5003019
 ;;^UTILITY(U,$J,358.3,3103,0)
 ;;=R42.^^17^218^7
 ;;^UTILITY(U,$J,358.3,3103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3103,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,3103,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,3103,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,3104,0)
 ;;=R41.82^^17^218^3
 ;;^UTILITY(U,$J,358.3,3104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3104,1,3,0)
 ;;=3^Altered Mental Status,Unspec
 ;;^UTILITY(U,$J,358.3,3104,1,4,0)
 ;;=4^R41.82
 ;;^UTILITY(U,$J,358.3,3104,2)
 ;;=^5019441
 ;;^UTILITY(U,$J,358.3,3105,0)
 ;;=T78.3XXA^^17^218^4
 ;;^UTILITY(U,$J,358.3,3105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3105,1,3,0)
 ;;=3^Angioneurotic Edema,Init Encntr
 ;;^UTILITY(U,$J,358.3,3105,1,4,0)
 ;;=4^T78.3XXA
 ;;^UTILITY(U,$J,358.3,3105,2)
 ;;=^5054281
 ;;^UTILITY(U,$J,358.3,3106,0)
 ;;=E11.69^^17^218^6
 ;;^UTILITY(U,$J,358.3,3106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3106,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oth Spec Complications
 ;;^UTILITY(U,$J,358.3,3106,1,4,0)
 ;;=4^E11.69
 ;;^UTILITY(U,$J,358.3,3106,2)
 ;;=^5002664
 ;;^UTILITY(U,$J,358.3,3107,0)
 ;;=R55.^^17^218^15
 ;;^UTILITY(U,$J,358.3,3107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3107,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,3107,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,3107,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,3108,0)
 ;;=E87.70^^17^218^9
 ;;^UTILITY(U,$J,358.3,3108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3108,1,3,0)
 ;;=3^Fluid Overload,Unspec
 ;;^UTILITY(U,$J,358.3,3108,1,4,0)
 ;;=4^E87.70
 ;;^UTILITY(U,$J,358.3,3108,2)
 ;;=^5003023
 ;;^UTILITY(U,$J,358.3,3109,0)
 ;;=E87.79^^17^218^8
 ;;^UTILITY(U,$J,358.3,3109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3109,1,3,0)
 ;;=3^Fluid Overload,Other
 ;;^UTILITY(U,$J,358.3,3109,1,4,0)
 ;;=4^E87.79
 ;;^UTILITY(U,$J,358.3,3109,2)
 ;;=^5003025
 ;;^UTILITY(U,$J,358.3,3110,0)
 ;;=R73.09^^17^218^1
 ;;^UTILITY(U,$J,358.3,3110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3110,1,3,0)
 ;;=3^Abnormal Glucose
 ;;^UTILITY(U,$J,358.3,3110,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,3110,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,3111,0)
 ;;=D62.^^17^218^2
 ;;^UTILITY(U,$J,358.3,3111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3111,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,3111,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,3111,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,3112,0)
 ;;=F06.8^^17^218^13
 ;;^UTILITY(U,$J,358.3,3112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3112,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition NEC
 ;;^UTILITY(U,$J,358.3,3112,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,3112,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,3113,0)
 ;;=F05.^^17^218^5
 ;;^UTILITY(U,$J,358.3,3113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3113,1,3,0)
 ;;=3^Delirium d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,3113,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,3113,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,3114,0)
 ;;=R73.9^^17^218^10
 ;;^UTILITY(U,$J,358.3,3114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3114,1,3,0)
 ;;=3^Hyperglycemia,Unspec
 ;;^UTILITY(U,$J,358.3,3114,1,4,0)
 ;;=4^R73.9
 ;;^UTILITY(U,$J,358.3,3114,2)
 ;;=^5019564
 ;;^UTILITY(U,$J,358.3,3115,0)
 ;;=K56.0^^17^218^14
 ;;^UTILITY(U,$J,358.3,3115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3115,1,3,0)
 ;;=3^Paralytic Ileus
