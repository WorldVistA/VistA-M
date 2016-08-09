IBDEI01H ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,953,1,4,0)
 ;;=4^E11.41
 ;;^UTILITY(U,$J,358.3,953,2)
 ;;=^5002645
 ;;^UTILITY(U,$J,358.3,954,0)
 ;;=E11.42^^6^71^46
 ;;^UTILITY(U,$J,358.3,954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,954,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,954,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,954,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,955,0)
 ;;=E11.43^^6^71^37
 ;;^UTILITY(U,$J,358.3,955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,955,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,955,1,4,0)
 ;;=4^E11.43
 ;;^UTILITY(U,$J,358.3,955,2)
 ;;=^5002647
 ;;^UTILITY(U,$J,358.3,956,0)
 ;;=E11.44^^6^71^36
 ;;^UTILITY(U,$J,358.3,956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,956,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,956,1,4,0)
 ;;=4^E11.44
 ;;^UTILITY(U,$J,358.3,956,2)
 ;;=^5002648
 ;;^UTILITY(U,$J,358.3,957,0)
 ;;=E11.51^^6^71^45
 ;;^UTILITY(U,$J,358.3,957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,957,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,957,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,957,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,958,0)
 ;;=E11.59^^6^71^53
 ;;^UTILITY(U,$J,358.3,958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,958,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Circulatory Complications
 ;;^UTILITY(U,$J,358.3,958,1,4,0)
 ;;=4^E11.59
 ;;^UTILITY(U,$J,358.3,958,2)
 ;;=^5002652
 ;;^UTILITY(U,$J,358.3,959,0)
 ;;=E11.610^^6^71^43
 ;;^UTILITY(U,$J,358.3,959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,959,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,959,1,4,0)
 ;;=4^E11.610
 ;;^UTILITY(U,$J,358.3,959,2)
 ;;=^5002653
 ;;^UTILITY(U,$J,358.3,960,0)
 ;;=E11.618^^6^71^54
 ;;^UTILITY(U,$J,358.3,960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,960,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,960,1,4,0)
 ;;=4^E11.618
 ;;^UTILITY(U,$J,358.3,960,2)
 ;;=^5002654
 ;;^UTILITY(U,$J,358.3,961,0)
 ;;=E11.620^^6^71^40
 ;;^UTILITY(U,$J,358.3,961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,961,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,961,1,4,0)
 ;;=4^E11.620
 ;;^UTILITY(U,$J,358.3,961,2)
 ;;=^5002655
 ;;^UTILITY(U,$J,358.3,962,0)
 ;;=E11.621^^6^71^47
 ;;^UTILITY(U,$J,358.3,962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,962,1,3,0)
 ;;=3^Diabetes Type 2 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,962,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,962,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,963,0)
 ;;=E11.622^^6^71^60
 ;;^UTILITY(U,$J,358.3,963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,963,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Skin Ulcer
 ;;^UTILITY(U,$J,358.3,963,1,4,0)
 ;;=4^E11.622
 ;;^UTILITY(U,$J,358.3,963,2)
 ;;=^5002657
 ;;^UTILITY(U,$J,358.3,964,0)
 ;;=E11.628^^6^71^59
 ;;^UTILITY(U,$J,358.3,964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,964,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Skin Complications
 ;;^UTILITY(U,$J,358.3,964,1,4,0)
 ;;=4^E11.628
 ;;^UTILITY(U,$J,358.3,964,2)
 ;;=^5002658
 ;;^UTILITY(U,$J,358.3,965,0)
 ;;=E11.630^^6^71^62
 ;;^UTILITY(U,$J,358.3,965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,965,1,3,0)
 ;;=3^Diabetes Type 2 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,965,1,4,0)
 ;;=4^E11.630
 ;;^UTILITY(U,$J,358.3,965,2)
 ;;=^5002659
 ;;^UTILITY(U,$J,358.3,966,0)
 ;;=E11.638^^6^71^58
 ;;^UTILITY(U,$J,358.3,966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,966,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Oral Complications
 ;;^UTILITY(U,$J,358.3,966,1,4,0)
 ;;=4^E11.638
 ;;^UTILITY(U,$J,358.3,966,2)
 ;;=^5002660
 ;;^UTILITY(U,$J,358.3,967,0)
 ;;=E11.69^^6^71^61
 ;;^UTILITY(U,$J,358.3,967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,967,1,3,0)
 ;;=3^Diabetes Type 2 w/ Other Specified Complication
 ;;^UTILITY(U,$J,358.3,967,1,4,0)
 ;;=4^E11.69
 ;;^UTILITY(U,$J,358.3,967,2)
 ;;=^5002664
 ;;^UTILITY(U,$J,358.3,968,0)
 ;;=E11.8^^6^71^67
 ;;^UTILITY(U,$J,358.3,968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,968,1,3,0)
 ;;=3^Diabetes Type 2 w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,968,1,4,0)
 ;;=4^E11.8
 ;;^UTILITY(U,$J,358.3,968,2)
 ;;=^5002665
 ;;^UTILITY(U,$J,358.3,969,0)
 ;;=H54.8^^6^72^2
 ;;^UTILITY(U,$J,358.3,969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,969,1,3,0)
 ;;=3^Legal Blindness (Defined in USA)
 ;;^UTILITY(U,$J,358.3,969,1,4,0)
 ;;=4^H54.8
 ;;^UTILITY(U,$J,358.3,969,2)
 ;;=^5006369
 ;;^UTILITY(U,$J,358.3,970,0)
 ;;=H91.90^^6^72^1
 ;;^UTILITY(U,$J,358.3,970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,970,1,3,0)
 ;;=3^Hearing Loss,Unspec
 ;;^UTILITY(U,$J,358.3,970,1,4,0)
 ;;=4^H91.90
 ;;^UTILITY(U,$J,358.3,970,2)
 ;;=^5006943
 ;;^UTILITY(U,$J,358.3,971,0)
 ;;=G23.8^^6^73^3
 ;;^UTILITY(U,$J,358.3,971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,971,1,3,0)
 ;;=3^Basal Ganglia Degenerative Diseases,Other Spec
 ;;^UTILITY(U,$J,358.3,971,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,971,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,972,0)
 ;;=F04.^^6^73^1
 ;;^UTILITY(U,$J,358.3,972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,972,1,3,0)
 ;;=3^Amnestic Disorder d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,972,1,4,0)
 ;;=4^F04.
 ;;^UTILITY(U,$J,358.3,972,2)
 ;;=^5003051
 ;;^UTILITY(U,$J,358.3,973,0)
 ;;=F05.^^6^73^4
 ;;^UTILITY(U,$J,358.3,973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,973,1,3,0)
 ;;=3^Delirium d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,973,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,973,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,974,0)
 ;;=F06.8^^6^73^6
 ;;^UTILITY(U,$J,358.3,974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,974,1,3,0)
 ;;=3^Mental Disorders d/t Known Physiological Condition
 ;;^UTILITY(U,$J,358.3,974,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,974,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,975,0)
 ;;=F32.9^^6^73^5
 ;;^UTILITY(U,$J,358.3,975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,975,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,975,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,975,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,976,0)
 ;;=F41.9^^6^73^2
 ;;^UTILITY(U,$J,358.3,976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,976,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,976,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,976,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,977,0)
 ;;=F43.10^^6^73^8
 ;;^UTILITY(U,$J,358.3,977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,977,1,3,0)
 ;;=3^PTSD,Unspec
 ;;^UTILITY(U,$J,358.3,977,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,977,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,978,0)
 ;;=F43.12^^6^73^7
 ;;^UTILITY(U,$J,358.3,978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,978,1,3,0)
 ;;=3^PTSD,Chronic
 ;;^UTILITY(U,$J,358.3,978,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,978,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,979,0)
 ;;=C34.90^^6^74^1
 ;;^UTILITY(U,$J,358.3,979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,979,1,3,0)
 ;;=3^Malig Neop Bronchus/Lung Unspec Part
 ;;^UTILITY(U,$J,358.3,979,1,4,0)
 ;;=4^C34.90
 ;;^UTILITY(U,$J,358.3,979,2)
 ;;=^5000966
 ;;^UTILITY(U,$J,358.3,980,0)
 ;;=G20.^^6^75^12
 ;;^UTILITY(U,$J,358.3,980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,980,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,980,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,980,2)
 ;;=^5003770
 ;;^UTILITY(U,$J,358.3,981,0)
 ;;=G30.9^^6^75^1
 ;;^UTILITY(U,$J,358.3,981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,981,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,981,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,981,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,982,0)
 ;;=G35.^^6^75^10
 ;;^UTILITY(U,$J,358.3,982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,982,1,3,0)
 ;;=3^Multiple Sclerosis
