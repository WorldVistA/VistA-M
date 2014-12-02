IBDEI0HN ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8575,1,4,0)
 ;;=4^054.42
 ;;^UTILITY(U,$J,358.3,8575,2)
 ;;=Dendritic Keratitis^66763
 ;;^UTILITY(U,$J,358.3,8576,0)
 ;;=370.01^^58^612^65
 ;;^UTILITY(U,$J,358.3,8576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8576,1,3,0)
 ;;=3^Marginal Corneal Ulcer
 ;;^UTILITY(U,$J,358.3,8576,1,4,0)
 ;;=4^370.01
 ;;^UTILITY(U,$J,358.3,8576,2)
 ;;=Marginal Corneal Ulcer^268908
 ;;^UTILITY(U,$J,358.3,8577,0)
 ;;=375.30^^58^612^47
 ;;^UTILITY(U,$J,358.3,8577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8577,1,3,0)
 ;;=3^Dacrocystitis
 ;;^UTILITY(U,$J,358.3,8577,1,4,0)
 ;;=4^375.30
 ;;^UTILITY(U,$J,358.3,8577,2)
 ;;=Dacrocystitis^30880
 ;;^UTILITY(U,$J,358.3,8578,0)
 ;;=376.01^^58^612^69
 ;;^UTILITY(U,$J,358.3,8578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8578,1,3,0)
 ;;=3^Orbital Cellulitis
 ;;^UTILITY(U,$J,358.3,8578,1,4,0)
 ;;=4^376.01
 ;;^UTILITY(U,$J,358.3,8578,2)
 ;;=Orbital Cellulitis^259068
 ;;^UTILITY(U,$J,358.3,8579,0)
 ;;=682.0^^58^612^6
 ;;^UTILITY(U,$J,358.3,8579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8579,1,3,0)
 ;;=3^Cellulitis of Face
 ;;^UTILITY(U,$J,358.3,8579,1,4,0)
 ;;=4^682.0
 ;;^UTILITY(U,$J,358.3,8579,2)
 ;;=Cellulitis of Face^271888
 ;;^UTILITY(U,$J,358.3,8580,0)
 ;;=473.9^^58^612^84
 ;;^UTILITY(U,$J,358.3,8580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8580,1,3,0)
 ;;=3^Sinusitis,Unspec
 ;;^UTILITY(U,$J,358.3,8580,1,4,0)
 ;;=4^473.9
 ;;^UTILITY(U,$J,358.3,8580,2)
 ;;=Sinusitis^123985
 ;;^UTILITY(U,$J,358.3,8581,0)
 ;;=017.30^^58^612^90
 ;;^UTILITY(U,$J,358.3,8581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8581,1,3,0)
 ;;=3^Tuberculosis,Eye
 ;;^UTILITY(U,$J,358.3,8581,1,4,0)
 ;;=4^017.30
 ;;^UTILITY(U,$J,358.3,8581,2)
 ;;=^122722
 ;;^UTILITY(U,$J,358.3,8582,0)
 ;;=076.9^^58^612^88
 ;;^UTILITY(U,$J,358.3,8582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8582,1,3,0)
 ;;=3^Trachoma,Unspec
 ;;^UTILITY(U,$J,358.3,8582,1,4,0)
 ;;=4^076.9
 ;;^UTILITY(U,$J,358.3,8582,2)
 ;;=^120805
 ;;^UTILITY(U,$J,358.3,8583,0)
 ;;=077.0^^58^612^31
 ;;^UTILITY(U,$J,358.3,8583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8583,1,3,0)
 ;;=3^Conjunctivitis,Inclusion
 ;;^UTILITY(U,$J,358.3,8583,1,4,0)
 ;;=4^077.0
 ;;^UTILITY(U,$J,358.3,8583,2)
 ;;=^27600
 ;;^UTILITY(U,$J,358.3,8584,0)
 ;;=077.1^^58^612^61
 ;;^UTILITY(U,$J,358.3,8584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8584,1,3,0)
 ;;=3^Keratoconjunctivitis,Epidemic EKC
 ;;^UTILITY(U,$J,358.3,8584,1,4,0)
 ;;=4^077.1
 ;;^UTILITY(U,$J,358.3,8584,2)
 ;;=^41251
 ;;^UTILITY(U,$J,358.3,8585,0)
 ;;=077.8^^58^612^37
 ;;^UTILITY(U,$J,358.3,8585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8585,1,3,0)
 ;;=3^Conjunctivitis,Viral,Oth
 ;;^UTILITY(U,$J,358.3,8585,1,4,0)
 ;;=4^077.8
 ;;^UTILITY(U,$J,358.3,8585,2)
 ;;=^88239
 ;;^UTILITY(U,$J,358.3,8586,0)
 ;;=078.5^^58^612^46
 ;;^UTILITY(U,$J,358.3,8586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8586,1,3,0)
 ;;=3^Cytomegaloviral Disease
 ;;^UTILITY(U,$J,358.3,8586,1,4,0)
 ;;=4^078.5
 ;;^UTILITY(U,$J,358.3,8586,2)
 ;;=^30676
 ;;^UTILITY(U,$J,358.3,8587,0)
 ;;=090.3^^58^612^59
 ;;^UTILITY(U,$J,358.3,8587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8587,1,3,0)
 ;;=3^Keratitis,Interstitial,Syphilitic
 ;;^UTILITY(U,$J,358.3,8587,1,4,0)
 ;;=4^090.3
 ;;^UTILITY(U,$J,358.3,8587,2)
 ;;=^266697
 ;;^UTILITY(U,$J,358.3,8588,0)
 ;;=091.50^^58^612^93
 ;;^UTILITY(U,$J,358.3,8588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8588,1,3,0)
 ;;=3^Uveitis Syphilitica,Unspec
 ;;^UTILITY(U,$J,358.3,8588,1,4,0)
 ;;=4^091.50
 ;;^UTILITY(U,$J,358.3,8588,2)
 ;;=^266715
 ;;^UTILITY(U,$J,358.3,8589,0)
 ;;=094.83^^58^612^83
