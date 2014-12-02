IBDEI0GH ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8004,1,3,0)
 ;;=3^Bullous Keratopathy
 ;;^UTILITY(U,$J,358.3,8004,1,4,0)
 ;;=4^371.23
 ;;^UTILITY(U,$J,358.3,8004,2)
 ;;=^268967
 ;;^UTILITY(U,$J,358.3,8005,0)
 ;;=371.50^^58^605^22
 ;;^UTILITY(U,$J,358.3,8005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8005,1,3,0)
 ;;=3^Corneal Dystrophy,Unspec
 ;;^UTILITY(U,$J,358.3,8005,1,4,0)
 ;;=4^371.50
 ;;^UTILITY(U,$J,358.3,8005,2)
 ;;=Dystrophy, Corneal^28381
 ;;^UTILITY(U,$J,358.3,8006,0)
 ;;=930.0^^58^605^44
 ;;^UTILITY(U,$J,358.3,8006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8006,1,3,0)
 ;;=3^Foreign Body, Cornea
 ;;^UTILITY(U,$J,358.3,8006,1,4,0)
 ;;=4^930.0
 ;;^UTILITY(U,$J,358.3,8006,2)
 ;;=Corneal Foreign Body^275485
 ;;^UTILITY(U,$J,358.3,8007,0)
 ;;=054.43^^58^605^64
 ;;^UTILITY(U,$J,358.3,8007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8007,1,3,0)
 ;;=3^Keratitis, Disciform (HSV)
 ;;^UTILITY(U,$J,358.3,8007,1,4,0)
 ;;=4^054.43
 ;;^UTILITY(U,$J,358.3,8007,2)
 ;;=Herpes Simplex Keratitis^266564
 ;;^UTILITY(U,$J,358.3,8008,0)
 ;;=370.23^^58^605^42
 ;;^UTILITY(U,$J,358.3,8008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8008,1,3,0)
 ;;=3^Filamentary Keratitis
 ;;^UTILITY(U,$J,358.3,8008,1,4,0)
 ;;=4^370.23
 ;;^UTILITY(U,$J,358.3,8008,2)
 ;;=^268924
 ;;^UTILITY(U,$J,358.3,8009,0)
 ;;=370.33^^58^605^68
 ;;^UTILITY(U,$J,358.3,8009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8009,1,3,0)
 ;;=3^Keratoconjunctivitis Sicca
 ;;^UTILITY(U,$J,358.3,8009,1,4,0)
 ;;=4^370.33
 ;;^UTILITY(U,$J,358.3,8009,2)
 ;;=Keratoconjunctivitis Sicca^268931
 ;;^UTILITY(U,$J,358.3,8010,0)
 ;;=371.60^^58^605^70
 ;;^UTILITY(U,$J,358.3,8010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8010,1,3,0)
 ;;=3^Keratoconus
 ;;^UTILITY(U,$J,358.3,8010,1,4,0)
 ;;=4^371.60
 ;;^UTILITY(U,$J,358.3,8010,2)
 ;;=Keratoconus^66799
 ;;^UTILITY(U,$J,358.3,8011,0)
 ;;=371.13^^58^605^73
 ;;^UTILITY(U,$J,358.3,8011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8011,1,3,0)
 ;;=3^Krunkenberg's Spindle
 ;;^UTILITY(U,$J,358.3,8011,1,4,0)
 ;;=4^371.13
 ;;^UTILITY(U,$J,358.3,8011,2)
 ;;=^268961
 ;;^UTILITY(U,$J,358.3,8012,0)
 ;;=371.03^^58^605^91
 ;;^UTILITY(U,$J,358.3,8012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8012,1,3,0)
 ;;=3^Opacity, Corneal, Central
 ;;^UTILITY(U,$J,358.3,8012,1,4,0)
 ;;=4^371.03
 ;;^UTILITY(U,$J,358.3,8012,2)
 ;;=Corneal Opacity, Central^21253
 ;;^UTILITY(U,$J,358.3,8013,0)
 ;;=371.02^^58^605^92
 ;;^UTILITY(U,$J,358.3,8013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8013,1,3,0)
 ;;=3^Opacity, Periph, Corneal
 ;;^UTILITY(U,$J,358.3,8013,1,4,0)
 ;;=4^371.02
 ;;^UTILITY(U,$J,358.3,8013,2)
 ;;=Opacity, Peripheral^268955
 ;;^UTILITY(U,$J,358.3,8014,0)
 ;;=371.42^^58^605^108
 ;;^UTILITY(U,$J,358.3,8014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8014,1,3,0)
 ;;=3^Recurrent Erosion, Cornea
 ;;^UTILITY(U,$J,358.3,8014,1,4,0)
 ;;=4^371.42
 ;;^UTILITY(U,$J,358.3,8014,2)
 ;;=Recurrent Cornea Erosion^268978
 ;;^UTILITY(U,$J,358.3,8015,0)
 ;;=370.03^^58^605^118
 ;;^UTILITY(U,$J,358.3,8015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8015,1,3,0)
 ;;=3^Ulcer, Central Cornea
 ;;^UTILITY(U,$J,358.3,8015,1,4,0)
 ;;=4^370.03
 ;;^UTILITY(U,$J,358.3,8015,2)
 ;;=Corneal Ulcer, Central^268910
 ;;^UTILITY(U,$J,358.3,8016,0)
 ;;=370.01^^58^605^119
 ;;^UTILITY(U,$J,358.3,8016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8016,1,3,0)
 ;;=3^Ulcer, Marginal Cornea
 ;;^UTILITY(U,$J,358.3,8016,1,4,0)
 ;;=4^370.01
 ;;^UTILITY(U,$J,358.3,8016,2)
 ;;=Corneal Ulcer,Marginal^268908
 ;;^UTILITY(U,$J,358.3,8017,0)
 ;;=371.57^^58^605^48
 ;;^UTILITY(U,$J,358.3,8017,1,0)
 ;;=^358.31IA^4^2
