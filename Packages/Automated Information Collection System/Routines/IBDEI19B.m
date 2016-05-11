IBDEI19B ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21351,1,4,0)
 ;;=4^Y36.230S
 ;;^UTILITY(U,$J,358.3,21351,2)
 ;;=^5061627
 ;;^UTILITY(U,$J,358.3,21352,0)
 ;;=Y36.7X0S^^84^948^130
 ;;^UTILITY(U,$J,358.3,21352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21352,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,21352,1,4,0)
 ;;=4^Y36.7X0S
 ;;^UTILITY(U,$J,358.3,21352,2)
 ;;=^5061783
 ;;^UTILITY(U,$J,358.3,21353,0)
 ;;=F02.81^^84^949^11
 ;;^UTILITY(U,$J,358.3,21353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21353,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,21353,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,21353,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,21354,0)
 ;;=F02.80^^84^949^12
 ;;^UTILITY(U,$J,358.3,21354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21354,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,21354,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,21354,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,21355,0)
 ;;=F03.91^^84^949^13
 ;;^UTILITY(U,$J,358.3,21355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21355,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,21355,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,21355,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,21356,0)
 ;;=G31.83^^84^949^14
 ;;^UTILITY(U,$J,358.3,21356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21356,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,21356,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,21356,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,21357,0)
 ;;=F01.51^^84^949^30
 ;;^UTILITY(U,$J,358.3,21357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21357,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,21357,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,21357,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,21358,0)
 ;;=F01.50^^84^949^31
 ;;^UTILITY(U,$J,358.3,21358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21358,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,21358,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,21358,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,21359,0)
 ;;=A81.9^^84^949^6
 ;;^UTILITY(U,$J,358.3,21359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21359,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,21359,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,21359,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,21360,0)
 ;;=A81.09^^84^949^8
 ;;^UTILITY(U,$J,358.3,21360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21360,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,21360,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,21360,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,21361,0)
 ;;=A81.00^^84^949^9
 ;;^UTILITY(U,$J,358.3,21361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21361,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,21361,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,21361,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,21362,0)
 ;;=A81.01^^84^949^10
 ;;^UTILITY(U,$J,358.3,21362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21362,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,21362,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,21362,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,21363,0)
 ;;=A81.89^^84^949^7
 ;;^UTILITY(U,$J,358.3,21363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21363,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,21363,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,21363,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,21364,0)
 ;;=A81.2^^84^949^27
