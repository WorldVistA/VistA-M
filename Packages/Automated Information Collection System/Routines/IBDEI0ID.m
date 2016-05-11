IBDEI0ID ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8525,1,3,0)
 ;;=3^Benign neoplasm of parotid gland
 ;;^UTILITY(U,$J,358.3,8525,1,4,0)
 ;;=4^D11.0
 ;;^UTILITY(U,$J,358.3,8525,2)
 ;;=^5001960
 ;;^UTILITY(U,$J,358.3,8526,0)
 ;;=D11.7^^39^460^8
 ;;^UTILITY(U,$J,358.3,8526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8526,1,3,0)
 ;;=3^Benign neoplasm of other major salivary glands
 ;;^UTILITY(U,$J,358.3,8526,1,4,0)
 ;;=4^D11.7
 ;;^UTILITY(U,$J,358.3,8526,2)
 ;;=^5001961
 ;;^UTILITY(U,$J,358.3,8527,0)
 ;;=D33.3^^39^460^6
 ;;^UTILITY(U,$J,358.3,8527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8527,1,3,0)
 ;;=3^Benign neoplasm of cranial nerves/Vestibular Schwannoma
 ;;^UTILITY(U,$J,358.3,8527,1,4,0)
 ;;=4^D33.3
 ;;^UTILITY(U,$J,358.3,8527,2)
 ;;=^13298
 ;;^UTILITY(U,$J,358.3,8528,0)
 ;;=D34.^^39^460^10
 ;;^UTILITY(U,$J,358.3,8528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8528,1,3,0)
 ;;=3^Benign neoplasm of thyroid gland
 ;;^UTILITY(U,$J,358.3,8528,1,4,0)
 ;;=4^D34.
 ;;^UTILITY(U,$J,358.3,8528,2)
 ;;=^5002141
 ;;^UTILITY(U,$J,358.3,8529,0)
 ;;=J34.2^^39^461^11
 ;;^UTILITY(U,$J,358.3,8529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8529,1,3,0)
 ;;=3^Deviated nasal septum
 ;;^UTILITY(U,$J,358.3,8529,1,4,0)
 ;;=4^J34.2
 ;;^UTILITY(U,$J,358.3,8529,2)
 ;;=^259087
 ;;^UTILITY(U,$J,358.3,8530,0)
 ;;=J33.0^^39^461^20
 ;;^UTILITY(U,$J,358.3,8530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8530,1,3,0)
 ;;=3^Polyp of nasal cavity
 ;;^UTILITY(U,$J,358.3,8530,1,4,0)
 ;;=4^J33.0
 ;;^UTILITY(U,$J,358.3,8530,2)
 ;;=^269880
 ;;^UTILITY(U,$J,358.3,8531,0)
 ;;=J33.8^^39^461^21
 ;;^UTILITY(U,$J,358.3,8531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8531,1,3,0)
 ;;=3^Polyp of sinus NEC
 ;;^UTILITY(U,$J,358.3,8531,1,4,0)
 ;;=4^J33.8
 ;;^UTILITY(U,$J,358.3,8531,2)
 ;;=^269884
 ;;^UTILITY(U,$J,358.3,8532,0)
 ;;=J31.0^^39^461^8
 ;;^UTILITY(U,$J,358.3,8532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8532,1,3,0)
 ;;=3^Chronic rhinitis
 ;;^UTILITY(U,$J,358.3,8532,1,4,0)
 ;;=4^J31.0
 ;;^UTILITY(U,$J,358.3,8532,2)
 ;;=^24434
 ;;^UTILITY(U,$J,358.3,8533,0)
 ;;=J31.2^^39^461^7
 ;;^UTILITY(U,$J,358.3,8533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8533,1,3,0)
 ;;=3^Chronic pharyngitis
 ;;^UTILITY(U,$J,358.3,8533,1,4,0)
 ;;=4^J31.2
 ;;^UTILITY(U,$J,358.3,8533,2)
 ;;=^269886
 ;;^UTILITY(U,$J,358.3,8534,0)
 ;;=J31.1^^39^461^5
 ;;^UTILITY(U,$J,358.3,8534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8534,1,3,0)
 ;;=3^Chronic nasopharyngitis
 ;;^UTILITY(U,$J,358.3,8534,1,4,0)
 ;;=4^J31.1
 ;;^UTILITY(U,$J,358.3,8534,2)
 ;;=^269888
 ;;^UTILITY(U,$J,358.3,8535,0)
 ;;=J32.9^^39^461^9
 ;;^UTILITY(U,$J,358.3,8535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8535,1,3,0)
 ;;=3^Chronic sinusitis, unspecified
 ;;^UTILITY(U,$J,358.3,8535,1,4,0)
 ;;=4^J32.9
 ;;^UTILITY(U,$J,358.3,8535,2)
 ;;=^5008207
 ;;^UTILITY(U,$J,358.3,8536,0)
 ;;=J32.4^^39^461^6
 ;;^UTILITY(U,$J,358.3,8536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8536,1,3,0)
 ;;=3^Chronic pansinusitis
 ;;^UTILITY(U,$J,358.3,8536,1,4,0)
 ;;=4^J32.4
 ;;^UTILITY(U,$J,358.3,8536,2)
 ;;=^5008206
 ;;^UTILITY(U,$J,358.3,8537,0)
 ;;=J35.01^^39^461^10
 ;;^UTILITY(U,$J,358.3,8537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8537,1,3,0)
 ;;=3^Chronic tonsillitis
 ;;^UTILITY(U,$J,358.3,8537,1,4,0)
 ;;=4^J35.01
 ;;^UTILITY(U,$J,358.3,8537,2)
 ;;=^259089
 ;;^UTILITY(U,$J,358.3,8538,0)
 ;;=J36.^^39^461^19
 ;;^UTILITY(U,$J,358.3,8538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8538,1,3,0)
 ;;=3^Peritonsillar abscess
 ;;^UTILITY(U,$J,358.3,8538,1,4,0)
 ;;=4^J36.
 ;;^UTILITY(U,$J,358.3,8538,2)
 ;;=^92333
 ;;^UTILITY(U,$J,358.3,8539,0)
 ;;=J37.0^^39^461^4
