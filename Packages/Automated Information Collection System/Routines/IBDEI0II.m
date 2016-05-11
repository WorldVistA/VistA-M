IBDEI0II ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8591,1,4,0)
 ;;=4^H65.111
 ;;^UTILITY(U,$J,358.3,8591,2)
 ;;=^5006577
 ;;^UTILITY(U,$J,358.3,8592,0)
 ;;=H65.112^^39^462^7
 ;;^UTILITY(U,$J,358.3,8592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8592,1,3,0)
 ;;=3^Acute/subacute allergic otitis media, left ear
 ;;^UTILITY(U,$J,358.3,8592,1,4,0)
 ;;=4^H65.112
 ;;^UTILITY(U,$J,358.3,8592,2)
 ;;=^5006578
 ;;^UTILITY(U,$J,358.3,8593,0)
 ;;=H66.001^^39^462^5
 ;;^UTILITY(U,$J,358.3,8593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8593,1,3,0)
 ;;=3^Acute suppr otitis media w/o spon rupt ear drum, right
 ;;^UTILITY(U,$J,358.3,8593,1,4,0)
 ;;=4^H66.001
 ;;^UTILITY(U,$J,358.3,8593,2)
 ;;=^5006613
 ;;^UTILITY(U,$J,358.3,8594,0)
 ;;=H66.002^^39^462^6
 ;;^UTILITY(U,$J,358.3,8594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8594,1,3,0)
 ;;=3^Acute suppr otitis media w/o spon rupt ear drum, left e
 ;;^UTILITY(U,$J,358.3,8594,1,4,0)
 ;;=4^H66.002
 ;;^UTILITY(U,$J,358.3,8594,2)
 ;;=^5006614
 ;;^UTILITY(U,$J,358.3,8595,0)
 ;;=H66.3X1^^39^462^18
 ;;^UTILITY(U,$J,358.3,8595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8595,1,3,0)
 ;;=3^Chronic suppurative otitis media, right ear NEC
 ;;^UTILITY(U,$J,358.3,8595,1,4,0)
 ;;=4^H66.3X1
 ;;^UTILITY(U,$J,358.3,8595,2)
 ;;=^5006633
 ;;^UTILITY(U,$J,358.3,8596,0)
 ;;=H66.3X2^^39^462^17
 ;;^UTILITY(U,$J,358.3,8596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8596,1,3,0)
 ;;=3^Chronic suppurative otitis media, left ear NEC
 ;;^UTILITY(U,$J,358.3,8596,1,4,0)
 ;;=4^H66.3X2
 ;;^UTILITY(U,$J,358.3,8596,2)
 ;;=^5133538
 ;;^UTILITY(U,$J,358.3,8597,0)
 ;;=H74.01^^39^462^63
 ;;^UTILITY(U,$J,358.3,8597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8597,1,3,0)
 ;;=3^Tympanosclerosis, right ear
 ;;^UTILITY(U,$J,358.3,8597,1,4,0)
 ;;=4^H74.01
 ;;^UTILITY(U,$J,358.3,8597,2)
 ;;=^5006796
 ;;^UTILITY(U,$J,358.3,8598,0)
 ;;=H74.02^^39^462^62
 ;;^UTILITY(U,$J,358.3,8598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8598,1,3,0)
 ;;=3^Tympanosclerosis, left ear
 ;;^UTILITY(U,$J,358.3,8598,1,4,0)
 ;;=4^H74.02
 ;;^UTILITY(U,$J,358.3,8598,2)
 ;;=^5006797
 ;;^UTILITY(U,$J,358.3,8599,0)
 ;;=H74.11^^39^462^10
 ;;^UTILITY(U,$J,358.3,8599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8599,1,3,0)
 ;;=3^Adhesive right middle ear disease
 ;;^UTILITY(U,$J,358.3,8599,1,4,0)
 ;;=4^H74.11
 ;;^UTILITY(U,$J,358.3,8599,2)
 ;;=^5006800
 ;;^UTILITY(U,$J,358.3,8600,0)
 ;;=H74.12^^39^462^9
 ;;^UTILITY(U,$J,358.3,8600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8600,1,3,0)
 ;;=3^Adhesive left middle ear disease
 ;;^UTILITY(U,$J,358.3,8600,1,4,0)
 ;;=4^H74.12
 ;;^UTILITY(U,$J,358.3,8600,2)
 ;;=^5006801
 ;;^UTILITY(U,$J,358.3,8601,0)
 ;;=H81.01^^39^462^41
 ;;^UTILITY(U,$J,358.3,8601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8601,1,3,0)
 ;;=3^Meniere's disease, right ear
 ;;^UTILITY(U,$J,358.3,8601,1,4,0)
 ;;=4^H81.01
 ;;^UTILITY(U,$J,358.3,8601,2)
 ;;=^5006860
 ;;^UTILITY(U,$J,358.3,8602,0)
 ;;=H81.02^^39^462^40
 ;;^UTILITY(U,$J,358.3,8602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8602,1,3,0)
 ;;=3^Meniere's disease, left ear
 ;;^UTILITY(U,$J,358.3,8602,1,4,0)
 ;;=4^H81.02
 ;;^UTILITY(U,$J,358.3,8602,2)
 ;;=^5006861
 ;;^UTILITY(U,$J,358.3,8603,0)
 ;;=H81.391^^39^462^52
 ;;^UTILITY(U,$J,358.3,8603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8603,1,3,0)
 ;;=3^Peripheral vertigo, right ear NEC
 ;;^UTILITY(U,$J,358.3,8603,1,4,0)
 ;;=4^H81.391
 ;;^UTILITY(U,$J,358.3,8603,2)
 ;;=^5006876
 ;;^UTILITY(U,$J,358.3,8604,0)
 ;;=H81.392^^39^462^51
 ;;^UTILITY(U,$J,358.3,8604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8604,1,3,0)
 ;;=3^Peripheral vertigo, left ear NEC
