IBDEI0ER ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7099,1,3,0)
 ;;=3^Corneal Dystrophy,Unspec
 ;;^UTILITY(U,$J,358.3,7099,1,4,0)
 ;;=4^371.50
 ;;^UTILITY(U,$J,358.3,7099,2)
 ;;=Dystrophy, Corneal^28381
 ;;^UTILITY(U,$J,358.3,7100,0)
 ;;=930.0^^49^554^44
 ;;^UTILITY(U,$J,358.3,7100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7100,1,3,0)
 ;;=3^Foreign Body, Cornea
 ;;^UTILITY(U,$J,358.3,7100,1,4,0)
 ;;=4^930.0
 ;;^UTILITY(U,$J,358.3,7100,2)
 ;;=Corneal Foreign Body^275485
 ;;^UTILITY(U,$J,358.3,7101,0)
 ;;=054.43^^49^554^64
 ;;^UTILITY(U,$J,358.3,7101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7101,1,3,0)
 ;;=3^Keratitis, Disciform (HSV)
 ;;^UTILITY(U,$J,358.3,7101,1,4,0)
 ;;=4^054.43
 ;;^UTILITY(U,$J,358.3,7101,2)
 ;;=Herpes Simplex Keratitis^266564
 ;;^UTILITY(U,$J,358.3,7102,0)
 ;;=370.23^^49^554^42
 ;;^UTILITY(U,$J,358.3,7102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7102,1,3,0)
 ;;=3^Filamentary Keratitis
 ;;^UTILITY(U,$J,358.3,7102,1,4,0)
 ;;=4^370.23
 ;;^UTILITY(U,$J,358.3,7102,2)
 ;;=^268924
 ;;^UTILITY(U,$J,358.3,7103,0)
 ;;=370.33^^49^554^68
 ;;^UTILITY(U,$J,358.3,7103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7103,1,3,0)
 ;;=3^Keratoconjunctivitis Sicca
 ;;^UTILITY(U,$J,358.3,7103,1,4,0)
 ;;=4^370.33
 ;;^UTILITY(U,$J,358.3,7103,2)
 ;;=Keratoconjunctivitis Sicca^268931
 ;;^UTILITY(U,$J,358.3,7104,0)
 ;;=371.60^^49^554^70
 ;;^UTILITY(U,$J,358.3,7104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7104,1,3,0)
 ;;=3^Keratoconus
 ;;^UTILITY(U,$J,358.3,7104,1,4,0)
 ;;=4^371.60
 ;;^UTILITY(U,$J,358.3,7104,2)
 ;;=Keratoconus^66799
 ;;^UTILITY(U,$J,358.3,7105,0)
 ;;=371.13^^49^554^73
 ;;^UTILITY(U,$J,358.3,7105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7105,1,3,0)
 ;;=3^Krunkenberg's Spindle
 ;;^UTILITY(U,$J,358.3,7105,1,4,0)
 ;;=4^371.13
 ;;^UTILITY(U,$J,358.3,7105,2)
 ;;=^268961
 ;;^UTILITY(U,$J,358.3,7106,0)
 ;;=371.03^^49^554^91
 ;;^UTILITY(U,$J,358.3,7106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7106,1,3,0)
 ;;=3^Opacity, Corneal, Central
 ;;^UTILITY(U,$J,358.3,7106,1,4,0)
 ;;=4^371.03
 ;;^UTILITY(U,$J,358.3,7106,2)
 ;;=Corneal Opacity, Central^21253
 ;;^UTILITY(U,$J,358.3,7107,0)
 ;;=371.02^^49^554^92
 ;;^UTILITY(U,$J,358.3,7107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7107,1,3,0)
 ;;=3^Opacity, Periph, Corneal
 ;;^UTILITY(U,$J,358.3,7107,1,4,0)
 ;;=4^371.02
 ;;^UTILITY(U,$J,358.3,7107,2)
 ;;=Opacity, Peripheral^268955
 ;;^UTILITY(U,$J,358.3,7108,0)
 ;;=371.42^^49^554^108
 ;;^UTILITY(U,$J,358.3,7108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7108,1,3,0)
 ;;=3^Recurrent Erosion, Cornea
 ;;^UTILITY(U,$J,358.3,7108,1,4,0)
 ;;=4^371.42
 ;;^UTILITY(U,$J,358.3,7108,2)
 ;;=Recurrent Cornea Erosion^268978
 ;;^UTILITY(U,$J,358.3,7109,0)
 ;;=370.03^^49^554^118
 ;;^UTILITY(U,$J,358.3,7109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7109,1,3,0)
 ;;=3^Ulcer, Central Cornea
 ;;^UTILITY(U,$J,358.3,7109,1,4,0)
 ;;=4^370.03
 ;;^UTILITY(U,$J,358.3,7109,2)
 ;;=Corneal Ulcer, Central^268910
 ;;^UTILITY(U,$J,358.3,7110,0)
 ;;=370.01^^49^554^119
 ;;^UTILITY(U,$J,358.3,7110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7110,1,3,0)
 ;;=3^Ulcer, Marginal Cornea
 ;;^UTILITY(U,$J,358.3,7110,1,4,0)
 ;;=4^370.01
 ;;^UTILITY(U,$J,358.3,7110,2)
 ;;=Corneal Ulcer,Marginal^268908
 ;;^UTILITY(U,$J,358.3,7111,0)
 ;;=371.57^^49^554^48
 ;;^UTILITY(U,$J,358.3,7111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7111,1,3,0)
 ;;=3^Guttata
 ;;^UTILITY(U,$J,358.3,7111,1,4,0)
 ;;=4^371.57
 ;;^UTILITY(U,$J,358.3,7111,2)
 ;;=^268988
 ;;^UTILITY(U,$J,358.3,7112,0)
 ;;=370.34^^49^554^41
 ;;^UTILITY(U,$J,358.3,7112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7112,1,3,0)
 ;;=3^Exposure Keratonconjunctivitis,Lid Path
