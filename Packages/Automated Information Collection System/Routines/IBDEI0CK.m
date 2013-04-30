IBDEI0CK ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16732,1,5,0)
 ;;=5^Hypertension, Essential
 ;;^UTILITY(U,$J,358.3,16732,2)
 ;;=^186630
 ;;^UTILITY(U,$J,358.3,16733,0)
 ;;=272.0^^125^1065^53
 ;;^UTILITY(U,$J,358.3,16733,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16733,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,16733,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,16733,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,16734,0)
 ;;=272.1^^125^1065^56
 ;;^UTILITY(U,$J,358.3,16734,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16734,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,16734,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,16734,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,16735,0)
 ;;=272.2^^125^1065^59
 ;;^UTILITY(U,$J,358.3,16735,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16735,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,16735,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,16735,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,16736,0)
 ;;=396.0^^125^1065^11
 ;;^UTILITY(U,$J,358.3,16736,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16736,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,16736,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,16736,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,16737,0)
 ;;=414.02^^125^1065^16
 ;;^UTILITY(U,$J,358.3,16737,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16737,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,16737,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,16737,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,16738,0)
 ;;=459.10^^125^1065^69
 ;;^UTILITY(U,$J,358.3,16738,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16738,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,16738,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,16738,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,16739,0)
 ;;=428.20^^125^1065^49
 ;;^UTILITY(U,$J,358.3,16739,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16739,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,16739,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,16739,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,16740,0)
 ;;=428.21^^125^1065^41
 ;;^UTILITY(U,$J,358.3,16740,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16740,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,16740,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,16740,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,16741,0)
 ;;=428.22^^125^1065^43
 ;;^UTILITY(U,$J,358.3,16741,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16741,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,16741,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,16741,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,16742,0)
 ;;=428.23^^125^1065^48
 ;;^UTILITY(U,$J,358.3,16742,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16742,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,16742,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,16742,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,16743,0)
 ;;=428.30^^125^1065^44
 ;;^UTILITY(U,$J,358.3,16743,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16743,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,16743,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,16743,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,16744,0)
 ;;=428.31^^125^1065^40
 ;;^UTILITY(U,$J,358.3,16744,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16744,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,16744,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,16744,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,16745,0)
 ;;=428.32^^125^1065^42
 ;;^UTILITY(U,$J,358.3,16745,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16745,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,16745,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,16745,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,16746,0)
 ;;=428.33^^125^1065^46
 ;;^UTILITY(U,$J,358.3,16746,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16746,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,16746,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,16746,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,16747,0)
 ;;=428.40^^125^1065^45
 ;;^UTILITY(U,$J,358.3,16747,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16747,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,16747,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,16747,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,16748,0)
 ;;=428.41^^125^1065^47
 ;;^UTILITY(U,$J,358.3,16748,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16748,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,16748,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,16748,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,16749,0)
 ;;=428.42^^125^1065^51
 ;;^UTILITY(U,$J,358.3,16749,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16749,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,16749,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,16749,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,16750,0)
 ;;=428.43^^125^1065^50
 ;;^UTILITY(U,$J,358.3,16750,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16750,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,16750,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic
 ;;^UTILITY(U,$J,358.3,16750,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,16751,0)
 ;;=396.3^^125^1065^10
 ;;^UTILITY(U,$J,358.3,16751,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16751,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,16751,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,16751,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,16752,0)
 ;;=429.9^^125^1065^26
 ;;^UTILITY(U,$J,358.3,16752,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16752,1,4,0)
 ;;=4^429.9
 ;;^UTILITY(U,$J,358.3,16752,1,5,0)
 ;;=5^Diastolic Dysfunction
 ;;^UTILITY(U,$J,358.3,16752,2)
 ;;=^54741
 ;;^UTILITY(U,$J,358.3,16753,0)
 ;;=453.79^^125^1065^25
 ;;^UTILITY(U,$J,358.3,16753,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16753,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,16753,1,5,0)
 ;;=5^Chr Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,16753,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,16754,0)
 ;;=453.89^^125^1065^1
 ;;^UTILITY(U,$J,358.3,16754,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16754,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,16754,1,5,0)
 ;;=5^AC Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,16754,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,16755,0)
 ;;=454.0^^125^1065^78
 ;;^UTILITY(U,$J,358.3,16755,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16755,1,4,0)
 ;;=4^454.0
 ;;^UTILITY(U,$J,358.3,16755,1,5,0)
 ;;=5^Varicose Veins
 ;;^UTILITY(U,$J,358.3,16755,2)
 ;;=^125410
 ;;^UTILITY(U,$J,358.3,16756,0)
 ;;=454.2^^125^1065^79
 ;;^UTILITY(U,$J,358.3,16756,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16756,1,4,0)
 ;;=4^454.2
 ;;^UTILITY(U,$J,358.3,16756,1,5,0)
 ;;=5^Varicose Veins w/Ulcer&Inflam
 ;;^UTILITY(U,$J,358.3,16756,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,16757,0)
 ;;=271.3^^125^1066^10
 ;;^UTILITY(U,$J,358.3,16757,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16757,1,4,0)
 ;;=4^271.3
 ;;^UTILITY(U,$J,358.3,16757,1,5,0)
 ;;=5^Glucose Intolerance
 ;;^UTILITY(U,$J,358.3,16757,2)
 ;;=^64790
 ;;^UTILITY(U,$J,358.3,16758,0)
 ;;=611.1^^125^1066^15
 ;;^UTILITY(U,$J,358.3,16758,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16758,1,4,0)
 ;;=4^611.1
 ;;^UTILITY(U,$J,358.3,16758,1,5,0)
 ;;=5^Gynecomastia
 ;;^UTILITY(U,$J,358.3,16758,2)
 ;;=^60454
 ;;^UTILITY(U,$J,358.3,16759,0)
 ;;=704.1^^125^1066^16
 ;;^UTILITY(U,$J,358.3,16759,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16759,1,4,0)
 ;;=4^704.1
 ;;^UTILITY(U,$J,358.3,16759,1,5,0)
 ;;=5^Hirsutism
 ;;^UTILITY(U,$J,358.3,16759,2)
 ;;=^57407
 ;;^UTILITY(U,$J,358.3,16760,0)
 ;;=251.2^^125^1066^27
 ;;^UTILITY(U,$J,358.3,16760,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16760,1,4,0)
 ;;=4^251.2
 ;;^UTILITY(U,$J,358.3,16760,1,5,0)
 ;;=5^Hypoglycemia Nos
 ;;^UTILITY(U,$J,358.3,16760,2)
 ;;=^60580
 ;;^UTILITY(U,$J,358.3,16761,0)
 ;;=257.2^^125^1066^28
 ;;^UTILITY(U,$J,358.3,16761,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16761,1,4,0)
 ;;=4^257.2
 ;;^UTILITY(U,$J,358.3,16761,1,5,0)
 ;;=5^Hypogonadism,Male
 ;;^UTILITY(U,$J,358.3,16761,2)
 ;;=^88213
 ;;^UTILITY(U,$J,358.3,16762,0)
 ;;=253.2^^125^1066^31
 ;;^UTILITY(U,$J,358.3,16762,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16762,1,4,0)
 ;;=4^253.2
 ;;^UTILITY(U,$J,358.3,16762,1,5,0)
 ;;=5^Hypopituitarism
 ;;^UTILITY(U,$J,358.3,16762,2)
 ;;=^60686
 ;;^UTILITY(U,$J,358.3,16763,0)
 ;;=733.00^^125^1066^40
 ;;^UTILITY(U,$J,358.3,16763,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16763,1,4,0)
 ;;=4^733.00
 ;;^UTILITY(U,$J,358.3,16763,1,5,0)
 ;;=5^Osteoporosis Nos
 ;;^UTILITY(U,$J,358.3,16763,2)
 ;;=^87159
 ;;^UTILITY(U,$J,358.3,16764,0)
 ;;=278.00^^125^1066^37
 ;;^UTILITY(U,$J,358.3,16764,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16764,1,4,0)
 ;;=4^278.00
 ;;^UTILITY(U,$J,358.3,16764,1,5,0)
 ;;=5^Obesity
 ;;^UTILITY(U,$J,358.3,16764,2)
 ;;=^84823
 ;;^UTILITY(U,$J,358.3,16765,0)
 ;;=278.01^^125^1066^36
 ;;^UTILITY(U,$J,358.3,16765,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16765,1,4,0)
 ;;=4^278.01
 ;;^UTILITY(U,$J,358.3,16765,1,5,0)
 ;;=5^Morbid Obesity
 ;;^UTILITY(U,$J,358.3,16765,2)
 ;;=^84844
 ;;^UTILITY(U,$J,358.3,16766,0)
 ;;=250.80^^125^1066^9
 ;;^UTILITY(U,$J,358.3,16766,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,16766,1,4,0)
 ;;=4^250.80
 ;;^UTILITY(U,$J,358.3,16766,1,5,0)
 ;;=5^DM Type II with LE Ulcer
 ;;^UTILITY(U,$J,358.3,16766,2)
 ;;=DM Type II with LE Ulcer^267846^707.10
 ;;^UTILITY(U,$J,358.3,16767,0)
 ;;=250.00^^125^1066^4
 ;;^UTILITY(U,$J,358.3,16767,1,0)
 ;;=^358.31IA^5^2
