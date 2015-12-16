IBDEI03K ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1131,1,3,0)
 ;;=3^Epigastric abdominal tenderness
 ;;^UTILITY(U,$J,358.3,1131,1,4,0)
 ;;=4^R10.816
 ;;^UTILITY(U,$J,358.3,1131,2)
 ;;=^5019218
 ;;^UTILITY(U,$J,358.3,1132,0)
 ;;=R10.826^^3^37^43
 ;;^UTILITY(U,$J,358.3,1132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1132,1,3,0)
 ;;=3^Epigastric rebound abdominal tenderness
 ;;^UTILITY(U,$J,358.3,1132,1,4,0)
 ;;=4^R10.826
 ;;^UTILITY(U,$J,358.3,1132,2)
 ;;=^5019225
 ;;^UTILITY(U,$J,358.3,1133,0)
 ;;=R74.8^^3^37^2
 ;;^UTILITY(U,$J,358.3,1133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1133,1,3,0)
 ;;=3^Abnormal levels of other serum enzymes
 ;;^UTILITY(U,$J,358.3,1133,1,4,0)
 ;;=4^R74.8
 ;;^UTILITY(U,$J,358.3,1133,2)
 ;;=^5019566
 ;;^UTILITY(U,$J,358.3,1134,0)
 ;;=R79.89^^3^37^1
 ;;^UTILITY(U,$J,358.3,1134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1134,1,3,0)
 ;;=3^Abnormal Findings of Blood Chemistry NEC
 ;;^UTILITY(U,$J,358.3,1134,1,4,0)
 ;;=4^R79.89
 ;;^UTILITY(U,$J,358.3,1134,2)
 ;;=^5019593
 ;;^UTILITY(U,$J,358.3,1135,0)
 ;;=R19.5^^3^37^49
 ;;^UTILITY(U,$J,358.3,1135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1135,1,3,0)
 ;;=3^Fecal Abnormalites NEC
 ;;^UTILITY(U,$J,358.3,1135,1,4,0)
 ;;=4^R19.5
 ;;^UTILITY(U,$J,358.3,1135,2)
 ;;=^5019274
 ;;^UTILITY(U,$J,358.3,1136,0)
 ;;=Z87.11^^3^37^83
 ;;^UTILITY(U,$J,358.3,1136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1136,1,3,0)
 ;;=3^Personal history of peptic ulcer disease
 ;;^UTILITY(U,$J,358.3,1136,1,4,0)
 ;;=4^Z87.11
 ;;^UTILITY(U,$J,358.3,1136,2)
 ;;=^5063482
 ;;^UTILITY(U,$J,358.3,1137,0)
 ;;=Z86.010^^3^37^82
 ;;^UTILITY(U,$J,358.3,1137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1137,1,3,0)
 ;;=3^Personal history of colonic polyps
 ;;^UTILITY(U,$J,358.3,1137,1,4,0)
 ;;=4^Z86.010
 ;;^UTILITY(U,$J,358.3,1137,2)
 ;;=^5063456
 ;;^UTILITY(U,$J,358.3,1138,0)
 ;;=Z83.71^^3^37^46
 ;;^UTILITY(U,$J,358.3,1138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1138,1,3,0)
 ;;=3^Family history of colonic polyps
 ;;^UTILITY(U,$J,358.3,1138,1,4,0)
 ;;=4^Z83.71
 ;;^UTILITY(U,$J,358.3,1138,2)
 ;;=^5063386
 ;;^UTILITY(U,$J,358.3,1139,0)
 ;;=Z83.79^^3^37^47
 ;;^UTILITY(U,$J,358.3,1139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1139,1,3,0)
 ;;=3^Family history of other diseases of the digestive system
 ;;^UTILITY(U,$J,358.3,1139,1,4,0)
 ;;=4^Z83.79
 ;;^UTILITY(U,$J,358.3,1139,2)
 ;;=^5063387
 ;;^UTILITY(U,$J,358.3,1140,0)
 ;;=A54.00^^3^38^21
 ;;^UTILITY(U,$J,358.3,1140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1140,1,3,0)
 ;;=3^Gonococcal infection of lower genitourinary tract, unsp
 ;;^UTILITY(U,$J,358.3,1140,1,4,0)
 ;;=4^A54.00
 ;;^UTILITY(U,$J,358.3,1140,2)
 ;;=^5000311
 ;;^UTILITY(U,$J,358.3,1141,0)
 ;;=B37.42^^3^38^10
 ;;^UTILITY(U,$J,358.3,1141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1141,1,3,0)
 ;;=3^Candidal balanitis
 ;;^UTILITY(U,$J,358.3,1141,1,4,0)
 ;;=4^B37.42
 ;;^UTILITY(U,$J,358.3,1141,2)
 ;;=^5000617
 ;;^UTILITY(U,$J,358.3,1142,0)
 ;;=A59.03^^3^38^60
 ;;^UTILITY(U,$J,358.3,1142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1142,1,3,0)
 ;;=3^Trichomonal cystitis and urethritis
 ;;^UTILITY(U,$J,358.3,1142,1,4,0)
 ;;=4^A59.03
 ;;^UTILITY(U,$J,358.3,1142,2)
 ;;=^5000349
 ;;^UTILITY(U,$J,358.3,1143,0)
 ;;=C61.^^3^38^41
 ;;^UTILITY(U,$J,358.3,1143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1143,1,3,0)
 ;;=3^Malignant neoplasm of prostate
 ;;^UTILITY(U,$J,358.3,1143,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,1143,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,1144,0)
 ;;=E11.21^^3^38^61
 ;;^UTILITY(U,$J,358.3,1144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1144,1,3,0)
 ;;=3^Type 2 diabetes mellitus with diabetic nephropathy
