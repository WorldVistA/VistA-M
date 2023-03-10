IBDEI0IJ ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8339,1,3,0)
 ;;=3^Cyclical Vomiting,In Migraine,Intractable
 ;;^UTILITY(U,$J,358.3,8339,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,8339,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,8340,0)
 ;;=G43.A0^^39^397^35
 ;;^UTILITY(U,$J,358.3,8340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8340,1,3,0)
 ;;=3^Cyclical Vomiting,In Migraine,Not intractable
 ;;^UTILITY(U,$J,358.3,8340,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,8340,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,8341,0)
 ;;=R11.15^^39^397^33
 ;;^UTILITY(U,$J,358.3,8341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8341,1,3,0)
 ;;=3^Cyclical Vomiting Syndrome,Unrelated to Migraine
 ;;^UTILITY(U,$J,358.3,8341,1,4,0)
 ;;=4^R11.15
 ;;^UTILITY(U,$J,358.3,8341,2)
 ;;=^5158141
 ;;^UTILITY(U,$J,358.3,8342,0)
 ;;=K20.90^^39^397^55
 ;;^UTILITY(U,$J,358.3,8342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8342,1,3,0)
 ;;=3^Esophagitis w/o Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,8342,1,4,0)
 ;;=4^K20.90
 ;;^UTILITY(U,$J,358.3,8342,2)
 ;;=^5159212
 ;;^UTILITY(U,$J,358.3,8343,0)
 ;;=K20.91^^39^397^54
 ;;^UTILITY(U,$J,358.3,8343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8343,1,3,0)
 ;;=3^Esophagitis w/ Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,8343,1,4,0)
 ;;=4^K20.91
 ;;^UTILITY(U,$J,358.3,8343,2)
 ;;=^5159213
 ;;^UTILITY(U,$J,358.3,8344,0)
 ;;=A54.00^^39^398^52
 ;;^UTILITY(U,$J,358.3,8344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8344,1,3,0)
 ;;=3^Gonococcal Infection Lower Genitourinary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,8344,1,4,0)
 ;;=4^A54.00
 ;;^UTILITY(U,$J,358.3,8344,2)
 ;;=^5000311
 ;;^UTILITY(U,$J,358.3,8345,0)
 ;;=A54.09^^39^398^53
 ;;^UTILITY(U,$J,358.3,8345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8345,1,3,0)
 ;;=3^Gonococcal Infection Lower Genitourinary Tract,Other
 ;;^UTILITY(U,$J,358.3,8345,1,4,0)
 ;;=4^A54.09
 ;;^UTILITY(U,$J,358.3,8345,2)
 ;;=^5000315
 ;;^UTILITY(U,$J,358.3,8346,0)
 ;;=A54.02^^39^398^54
 ;;^UTILITY(U,$J,358.3,8346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8346,1,3,0)
 ;;=3^Gonococcal Vulvovaginitis,Unspec
 ;;^UTILITY(U,$J,358.3,8346,1,4,0)
 ;;=4^A54.02
 ;;^UTILITY(U,$J,358.3,8346,2)
 ;;=^5000313
 ;;^UTILITY(U,$J,358.3,8347,0)
 ;;=A54.1^^39^398^51
 ;;^UTILITY(U,$J,358.3,8347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8347,1,3,0)
 ;;=3^Gonococcal Infection Lower GU Tract w/ Periureth & Acc Gland Abscess
 ;;^UTILITY(U,$J,358.3,8347,1,4,0)
 ;;=4^A54.1
 ;;^UTILITY(U,$J,358.3,8347,2)
 ;;=^5000316
 ;;^UTILITY(U,$J,358.3,8348,0)
 ;;=A54.01^^39^398^50
 ;;^UTILITY(U,$J,358.3,8348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8348,1,3,0)
 ;;=3^Gonococcal Cystitis & Urethritis,Unspec
 ;;^UTILITY(U,$J,358.3,8348,1,4,0)
 ;;=4^A54.01
 ;;^UTILITY(U,$J,358.3,8348,2)
 ;;=^5000312
 ;;^UTILITY(U,$J,358.3,8349,0)
 ;;=B37.49^^39^398^14
 ;;^UTILITY(U,$J,358.3,8349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8349,1,3,0)
 ;;=3^Candidiasis Urogenital,Other
 ;;^UTILITY(U,$J,358.3,8349,1,4,0)
 ;;=4^B37.49
 ;;^UTILITY(U,$J,358.3,8349,2)
 ;;=^5000618
 ;;^UTILITY(U,$J,358.3,8350,0)
 ;;=B37.41^^39^398^13
 ;;^UTILITY(U,$J,358.3,8350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8350,1,3,0)
 ;;=3^Candidal Cystitis & Urethritis
 ;;^UTILITY(U,$J,358.3,8350,1,4,0)
 ;;=4^B37.41
 ;;^UTILITY(U,$J,358.3,8350,2)
 ;;=^5000616
 ;;^UTILITY(U,$J,358.3,8351,0)
 ;;=B37.42^^39^398^12
 ;;^UTILITY(U,$J,358.3,8351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8351,1,3,0)
 ;;=3^Candidal Balanitis
