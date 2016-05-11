IBDEI0IE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8539,1,3,0)
 ;;=3^Chronic laryngitis
 ;;^UTILITY(U,$J,358.3,8539,1,4,0)
 ;;=4^J37.0
 ;;^UTILITY(U,$J,358.3,8539,2)
 ;;=^269902
 ;;^UTILITY(U,$J,358.3,8540,0)
 ;;=J30.9^^39^461^2
 ;;^UTILITY(U,$J,358.3,8540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8540,1,3,0)
 ;;=3^Allergic rhinitis, unspecified
 ;;^UTILITY(U,$J,358.3,8540,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,8540,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,8541,0)
 ;;=J30.0^^39^461^23
 ;;^UTILITY(U,$J,358.3,8541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8541,1,3,0)
 ;;=3^Vasomotor rhinitis
 ;;^UTILITY(U,$J,358.3,8541,1,4,0)
 ;;=4^J30.0
 ;;^UTILITY(U,$J,358.3,8541,2)
 ;;=^5008201
 ;;^UTILITY(U,$J,358.3,8542,0)
 ;;=J34.3^^39^461^14
 ;;^UTILITY(U,$J,358.3,8542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8542,1,3,0)
 ;;=3^Hypertrophy of nasal turbinates
 ;;^UTILITY(U,$J,358.3,8542,1,4,0)
 ;;=4^J34.3
 ;;^UTILITY(U,$J,358.3,8542,2)
 ;;=^269909
 ;;^UTILITY(U,$J,358.3,8543,0)
 ;;=M95.0^^39^461^1
 ;;^UTILITY(U,$J,358.3,8543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8543,1,3,0)
 ;;=3^Acquired deformity of nose
 ;;^UTILITY(U,$J,358.3,8543,1,4,0)
 ;;=4^M95.0
 ;;^UTILITY(U,$J,358.3,8543,2)
 ;;=^5015367
 ;;^UTILITY(U,$J,358.3,8544,0)
 ;;=J38.00^^39^461^18
 ;;^UTILITY(U,$J,358.3,8544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8544,1,3,0)
 ;;=3^Paralysis of vocal cords and larynx, unspecified
 ;;^UTILITY(U,$J,358.3,8544,1,4,0)
 ;;=4^J38.00
 ;;^UTILITY(U,$J,358.3,8544,2)
 ;;=^5008219
 ;;^UTILITY(U,$J,358.3,8545,0)
 ;;=J38.1^^39^461^22
 ;;^UTILITY(U,$J,358.3,8545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8545,1,3,0)
 ;;=3^Polyp of vocal cord and larynx
 ;;^UTILITY(U,$J,358.3,8545,1,4,0)
 ;;=4^J38.1
 ;;^UTILITY(U,$J,358.3,8545,2)
 ;;=^5008222
 ;;^UTILITY(U,$J,358.3,8546,0)
 ;;=J38.7^^39^461^15
 ;;^UTILITY(U,$J,358.3,8546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8546,1,3,0)
 ;;=3^Larynx Diseases NEC
 ;;^UTILITY(U,$J,358.3,8546,1,4,0)
 ;;=4^J38.7
 ;;^UTILITY(U,$J,358.3,8546,2)
 ;;=^5008227
 ;;^UTILITY(U,$J,358.3,8547,0)
 ;;=K13.21^^39^461^16
 ;;^UTILITY(U,$J,358.3,8547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8547,1,3,0)
 ;;=3^Leukoplakia of oral mucosa, including tongue
 ;;^UTILITY(U,$J,358.3,8547,1,4,0)
 ;;=4^K13.21
 ;;^UTILITY(U,$J,358.3,8547,2)
 ;;=^270054
 ;;^UTILITY(U,$J,358.3,8548,0)
 ;;=R43.0^^39^461^3
 ;;^UTILITY(U,$J,358.3,8548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8548,1,3,0)
 ;;=3^Anosmia
 ;;^UTILITY(U,$J,358.3,8548,1,4,0)
 ;;=4^R43.0
 ;;^UTILITY(U,$J,358.3,8548,2)
 ;;=^7949
 ;;^UTILITY(U,$J,358.3,8549,0)
 ;;=R49.0^^39^461^12
 ;;^UTILITY(U,$J,358.3,8549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8549,1,3,0)
 ;;=3^Dysphonia
 ;;^UTILITY(U,$J,358.3,8549,1,4,0)
 ;;=4^R49.0
 ;;^UTILITY(U,$J,358.3,8549,2)
 ;;=^5019501
 ;;^UTILITY(U,$J,358.3,8550,0)
 ;;=R04.0^^39^461^13
 ;;^UTILITY(U,$J,358.3,8550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8550,1,3,0)
 ;;=3^Epistaxis
 ;;^UTILITY(U,$J,358.3,8550,1,4,0)
 ;;=4^R04.0
 ;;^UTILITY(U,$J,358.3,8550,2)
 ;;=^5019173
 ;;^UTILITY(U,$J,358.3,8551,0)
 ;;=J34.89^^39^461^17
 ;;^UTILITY(U,$J,358.3,8551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8551,1,3,0)
 ;;=3^Nose & Nasal Sinus Disorders,Oth Specified
 ;;^UTILITY(U,$J,358.3,8551,1,4,0)
 ;;=4^J34.89
 ;;^UTILITY(U,$J,358.3,8551,2)
 ;;=^5008211
 ;;^UTILITY(U,$J,358.3,8552,0)
 ;;=H60.391^^39^462^34
 ;;^UTILITY(U,$J,358.3,8552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8552,1,3,0)
 ;;=3^Infective otitis externa, right ear NEC
 ;;^UTILITY(U,$J,358.3,8552,1,4,0)
 ;;=4^H60.391
