IBDEI0DR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6318,0)
 ;;=R10.30^^30^391^72
 ;;^UTILITY(U,$J,358.3,6318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6318,1,3,0)
 ;;=3^Lower Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,6318,1,4,0)
 ;;=4^R10.30
 ;;^UTILITY(U,$J,358.3,6318,2)
 ;;=^5019210
 ;;^UTILITY(U,$J,358.3,6319,0)
 ;;=R10.33^^30^391^75
 ;;^UTILITY(U,$J,358.3,6319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6319,1,3,0)
 ;;=3^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,6319,1,4,0)
 ;;=4^R10.33
 ;;^UTILITY(U,$J,358.3,6319,2)
 ;;=^5019213
 ;;^UTILITY(U,$J,358.3,6320,0)
 ;;=R10.10^^30^391^84
 ;;^UTILITY(U,$J,358.3,6320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6320,1,3,0)
 ;;=3^Upper Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,6320,1,4,0)
 ;;=4^R10.10
 ;;^UTILITY(U,$J,358.3,6320,2)
 ;;=^5019205
 ;;^UTILITY(U,$J,358.3,6321,0)
 ;;=A54.00^^30^392^51
 ;;^UTILITY(U,$J,358.3,6321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6321,1,3,0)
 ;;=3^Gonococcal Infection Lower Genitourinary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,6321,1,4,0)
 ;;=4^A54.00
 ;;^UTILITY(U,$J,358.3,6321,2)
 ;;=^5000311
 ;;^UTILITY(U,$J,358.3,6322,0)
 ;;=A54.09^^30^392^52
 ;;^UTILITY(U,$J,358.3,6322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6322,1,3,0)
 ;;=3^Gonococcal Infection Lower Genitourinary Tract,Other
 ;;^UTILITY(U,$J,358.3,6322,1,4,0)
 ;;=4^A54.09
 ;;^UTILITY(U,$J,358.3,6322,2)
 ;;=^5000315
 ;;^UTILITY(U,$J,358.3,6323,0)
 ;;=A54.02^^30^392^53
 ;;^UTILITY(U,$J,358.3,6323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6323,1,3,0)
 ;;=3^Gonococcal Vulvovaginitis,Unspec
 ;;^UTILITY(U,$J,358.3,6323,1,4,0)
 ;;=4^A54.02
 ;;^UTILITY(U,$J,358.3,6323,2)
 ;;=^5000313
 ;;^UTILITY(U,$J,358.3,6324,0)
 ;;=A54.1^^30^392^50
 ;;^UTILITY(U,$J,358.3,6324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6324,1,3,0)
 ;;=3^Gonococcal Infection Lower GU Tract w/ Periureth & Acc Gland Abscess
 ;;^UTILITY(U,$J,358.3,6324,1,4,0)
 ;;=4^A54.1
 ;;^UTILITY(U,$J,358.3,6324,2)
 ;;=^5000316
 ;;^UTILITY(U,$J,358.3,6325,0)
 ;;=A54.01^^30^392^49
 ;;^UTILITY(U,$J,358.3,6325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6325,1,3,0)
 ;;=3^Gonococcal Cystitis & Urethritis,Unspec
 ;;^UTILITY(U,$J,358.3,6325,1,4,0)
 ;;=4^A54.01
 ;;^UTILITY(U,$J,358.3,6325,2)
 ;;=^5000312
 ;;^UTILITY(U,$J,358.3,6326,0)
 ;;=B37.49^^30^392^12
 ;;^UTILITY(U,$J,358.3,6326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6326,1,3,0)
 ;;=3^Candidiasis Urogenital,Other
 ;;^UTILITY(U,$J,358.3,6326,1,4,0)
 ;;=4^B37.49
 ;;^UTILITY(U,$J,358.3,6326,2)
 ;;=^5000618
 ;;^UTILITY(U,$J,358.3,6327,0)
 ;;=B37.41^^30^392^11
 ;;^UTILITY(U,$J,358.3,6327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6327,1,3,0)
 ;;=3^Candidal Cystitis & Urethritis
 ;;^UTILITY(U,$J,358.3,6327,1,4,0)
 ;;=4^B37.41
 ;;^UTILITY(U,$J,358.3,6327,2)
 ;;=^5000616
 ;;^UTILITY(U,$J,358.3,6328,0)
 ;;=B37.42^^30^392^10
 ;;^UTILITY(U,$J,358.3,6328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6328,1,3,0)
 ;;=3^Candidal Balanitis
 ;;^UTILITY(U,$J,358.3,6328,1,4,0)
 ;;=4^B37.42
 ;;^UTILITY(U,$J,358.3,6328,2)
 ;;=^5000617
 ;;^UTILITY(U,$J,358.3,6329,0)
 ;;=A59.03^^30^392^102
 ;;^UTILITY(U,$J,358.3,6329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6329,1,3,0)
 ;;=3^Trichomonal Cystitis & Urethritis
 ;;^UTILITY(U,$J,358.3,6329,1,4,0)
 ;;=4^A59.03
 ;;^UTILITY(U,$J,358.3,6329,2)
 ;;=^5000349
 ;;^UTILITY(U,$J,358.3,6330,0)
 ;;=E87.6^^30^392^61
 ;;^UTILITY(U,$J,358.3,6330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6330,1,3,0)
 ;;=3^Hypokalemia
 ;;^UTILITY(U,$J,358.3,6330,1,4,0)
 ;;=4^E87.6
 ;;^UTILITY(U,$J,358.3,6330,2)
 ;;=^60610
 ;;^UTILITY(U,$J,358.3,6331,0)
 ;;=F52.0^^30^392^60
