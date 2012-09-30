IBDEI04P ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6087,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,6088,0)
 ;;=272.1^^59^418^56
 ;;^UTILITY(U,$J,358.3,6088,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6088,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,6088,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,6088,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,6089,0)
 ;;=272.2^^59^418^59
 ;;^UTILITY(U,$J,358.3,6089,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6089,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,6089,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,6089,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,6090,0)
 ;;=396.0^^59^418^11
 ;;^UTILITY(U,$J,358.3,6090,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6090,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,6090,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,6090,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,6091,0)
 ;;=414.02^^59^418^16
 ;;^UTILITY(U,$J,358.3,6091,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6091,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,6091,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,6091,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,6092,0)
 ;;=459.10^^59^418^69
 ;;^UTILITY(U,$J,358.3,6092,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6092,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,6092,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,6092,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,6093,0)
 ;;=428.20^^59^418^49
 ;;^UTILITY(U,$J,358.3,6093,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6093,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,6093,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,6093,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,6094,0)
 ;;=428.21^^59^418^41
 ;;^UTILITY(U,$J,358.3,6094,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6094,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,6094,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,6094,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,6095,0)
 ;;=428.22^^59^418^43
 ;;^UTILITY(U,$J,358.3,6095,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6095,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,6095,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,6095,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,6096,0)
 ;;=428.23^^59^418^48
 ;;^UTILITY(U,$J,358.3,6096,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6096,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,6096,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,6096,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,6097,0)
 ;;=428.30^^59^418^44
 ;;^UTILITY(U,$J,358.3,6097,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6097,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,6097,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,6097,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,6098,0)
 ;;=428.31^^59^418^40
 ;;^UTILITY(U,$J,358.3,6098,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6098,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,6098,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,6098,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,6099,0)
 ;;=428.32^^59^418^42
 ;;^UTILITY(U,$J,358.3,6099,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6099,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,6099,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,6099,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,6100,0)
 ;;=428.33^^59^418^46
 ;;^UTILITY(U,$J,358.3,6100,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6100,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,6100,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,6100,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,6101,0)
 ;;=428.40^^59^418^45
 ;;^UTILITY(U,$J,358.3,6101,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6101,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,6101,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,6101,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,6102,0)
 ;;=428.41^^59^418^47
 ;;^UTILITY(U,$J,358.3,6102,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6102,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,6102,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,6102,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,6103,0)
 ;;=428.42^^59^418^51
 ;;^UTILITY(U,$J,358.3,6103,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6103,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,6103,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,6103,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,6104,0)
 ;;=428.43^^59^418^50
 ;;^UTILITY(U,$J,358.3,6104,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6104,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,6104,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic
 ;;^UTILITY(U,$J,358.3,6104,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,6105,0)
 ;;=396.3^^59^418^10
 ;;^UTILITY(U,$J,358.3,6105,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6105,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,6105,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,6105,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,6106,0)
 ;;=429.9^^59^418^26
 ;;^UTILITY(U,$J,358.3,6106,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6106,1,4,0)
 ;;=4^429.9
 ;;^UTILITY(U,$J,358.3,6106,1,5,0)
 ;;=5^Diastolic Dysfunction
 ;;^UTILITY(U,$J,358.3,6106,2)
 ;;=^54741
 ;;^UTILITY(U,$J,358.3,6107,0)
 ;;=453.79^^59^418^25
 ;;^UTILITY(U,$J,358.3,6107,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6107,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,6107,1,5,0)
 ;;=5^Chr Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,6107,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,6108,0)
 ;;=453.89^^59^418^1
 ;;^UTILITY(U,$J,358.3,6108,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6108,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,6108,1,5,0)
 ;;=5^AC Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,6108,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,6109,0)
 ;;=454.0^^59^418^78
 ;;^UTILITY(U,$J,358.3,6109,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6109,1,4,0)
 ;;=4^454.0
 ;;^UTILITY(U,$J,358.3,6109,1,5,0)
 ;;=5^Varicose Veins
 ;;^UTILITY(U,$J,358.3,6109,2)
 ;;=^125410
 ;;^UTILITY(U,$J,358.3,6110,0)
 ;;=454.2^^59^418^79
 ;;^UTILITY(U,$J,358.3,6110,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6110,1,4,0)
 ;;=4^454.2
 ;;^UTILITY(U,$J,358.3,6110,1,5,0)
 ;;=5^Varicose Veins w/Ulcer&Inflam
 ;;^UTILITY(U,$J,358.3,6110,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,6111,0)
 ;;=271.3^^59^419^10
 ;;^UTILITY(U,$J,358.3,6111,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6111,1,4,0)
 ;;=4^271.3
 ;;^UTILITY(U,$J,358.3,6111,1,5,0)
 ;;=5^Glucose Intolerance
 ;;^UTILITY(U,$J,358.3,6111,2)
 ;;=^64790
 ;;^UTILITY(U,$J,358.3,6112,0)
 ;;=611.1^^59^419^15
 ;;^UTILITY(U,$J,358.3,6112,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6112,1,4,0)
 ;;=4^611.1
 ;;^UTILITY(U,$J,358.3,6112,1,5,0)
 ;;=5^Gynecomastia
 ;;^UTILITY(U,$J,358.3,6112,2)
 ;;=^60454
 ;;^UTILITY(U,$J,358.3,6113,0)
 ;;=704.1^^59^419^16
 ;;^UTILITY(U,$J,358.3,6113,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6113,1,4,0)
 ;;=4^704.1
 ;;^UTILITY(U,$J,358.3,6113,1,5,0)
 ;;=5^Hirsutism
 ;;^UTILITY(U,$J,358.3,6113,2)
 ;;=^57407
 ;;^UTILITY(U,$J,358.3,6114,0)
 ;;=251.2^^59^419^27
 ;;^UTILITY(U,$J,358.3,6114,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6114,1,4,0)
 ;;=4^251.2
 ;;^UTILITY(U,$J,358.3,6114,1,5,0)
 ;;=5^Hypoglycemia Nos
 ;;^UTILITY(U,$J,358.3,6114,2)
 ;;=^60580
 ;;^UTILITY(U,$J,358.3,6115,0)
 ;;=257.2^^59^419^28
 ;;^UTILITY(U,$J,358.3,6115,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6115,1,4,0)
 ;;=4^257.2
 ;;^UTILITY(U,$J,358.3,6115,1,5,0)
 ;;=5^Hypogonadism,Male
 ;;^UTILITY(U,$J,358.3,6115,2)
 ;;=^88213
 ;;^UTILITY(U,$J,358.3,6116,0)
 ;;=253.2^^59^419^31
 ;;^UTILITY(U,$J,358.3,6116,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6116,1,4,0)
 ;;=4^253.2
 ;;^UTILITY(U,$J,358.3,6116,1,5,0)
 ;;=5^Hypopituitarism
 ;;^UTILITY(U,$J,358.3,6116,2)
 ;;=^60686
 ;;^UTILITY(U,$J,358.3,6117,0)
 ;;=733.00^^59^419^40
 ;;^UTILITY(U,$J,358.3,6117,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6117,1,4,0)
 ;;=4^733.00
 ;;^UTILITY(U,$J,358.3,6117,1,5,0)
 ;;=5^Osteoporosis Nos
 ;;^UTILITY(U,$J,358.3,6117,2)
 ;;=^87159
 ;;^UTILITY(U,$J,358.3,6118,0)
 ;;=278.00^^59^419^37
 ;;^UTILITY(U,$J,358.3,6118,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6118,1,4,0)
 ;;=4^278.00
 ;;^UTILITY(U,$J,358.3,6118,1,5,0)
 ;;=5^Obesity (2nd dx only)
 ;;^UTILITY(U,$J,358.3,6118,2)
 ;;=^84823
 ;;^UTILITY(U,$J,358.3,6119,0)
 ;;=278.01^^59^419^36
 ;;^UTILITY(U,$J,358.3,6119,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6119,1,4,0)
 ;;=4^278.01
 ;;^UTILITY(U,$J,358.3,6119,1,5,0)
 ;;=5^Morbid Obesity
 ;;^UTILITY(U,$J,358.3,6119,2)
 ;;=^84844
 ;;^UTILITY(U,$J,358.3,6120,0)
 ;;=250.80^^59^419^9
 ;;^UTILITY(U,$J,358.3,6120,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6120,1,4,0)
 ;;=4^250.80
 ;;^UTILITY(U,$J,358.3,6120,1,5,0)
 ;;=5^DM Type II with LE Ulcer
 ;;^UTILITY(U,$J,358.3,6120,2)
 ;;=DM Type II with LE Ulcer^267846^707.10
 ;;^UTILITY(U,$J,358.3,6121,0)
 ;;=250.00^^59^419^4
 ;;^UTILITY(U,$J,358.3,6121,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6121,1,4,0)
 ;;=4^250.00
 ;;^UTILITY(U,$J,358.3,6121,1,5,0)
 ;;=5^DM Type II Dm W/O Complications
 ;;^UTILITY(U,$J,358.3,6121,2)
 ;;=^33605
 ;;^UTILITY(U,$J,358.3,6122,0)
 ;;=250.40^^59^419^5
 ;;^UTILITY(U,$J,358.3,6122,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6122,1,4,0)
 ;;=4^250.40
 ;;^UTILITY(U,$J,358.3,6122,1,5,0)
 ;;=5^DM Type II Dm with Nephropathy
 ;;^UTILITY(U,$J,358.3,6122,2)
 ;;=^267837^583.81
 ;;^UTILITY(U,$J,358.3,6123,0)
 ;;=250.50^^59^419^8
 ;;^UTILITY(U,$J,358.3,6123,1,0)
 ;;=^358.31IA^5^2
