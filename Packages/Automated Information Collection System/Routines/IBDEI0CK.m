IBDEI0CK ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5438,0)
 ;;=C15.4^^40^367^66
 ;;^UTILITY(U,$J,358.3,5438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5438,1,3,0)
 ;;=3^Malig Neop of Middle Third of Esophagus
 ;;^UTILITY(U,$J,358.3,5438,1,4,0)
 ;;=4^C15.4
 ;;^UTILITY(U,$J,358.3,5438,2)
 ;;=^267060
 ;;^UTILITY(U,$J,358.3,5439,0)
 ;;=C15.5^^40^367^65
 ;;^UTILITY(U,$J,358.3,5439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5439,1,3,0)
 ;;=3^Malig Neop of Lower Third of Esophagus
 ;;^UTILITY(U,$J,358.3,5439,1,4,0)
 ;;=4^C15.5
 ;;^UTILITY(U,$J,358.3,5439,2)
 ;;=^267061
 ;;^UTILITY(U,$J,358.3,5440,0)
 ;;=C15.9^^40^367^59
 ;;^UTILITY(U,$J,358.3,5440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5440,1,3,0)
 ;;=3^Malig Neop of Esophagus,Unspec
 ;;^UTILITY(U,$J,358.3,5440,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,5440,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,5441,0)
 ;;=C16.0^^40^367^54
 ;;^UTILITY(U,$J,358.3,5441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5441,1,3,0)
 ;;=3^Malig Neop of Cardia
 ;;^UTILITY(U,$J,358.3,5441,1,4,0)
 ;;=4^C16.0
 ;;^UTILITY(U,$J,358.3,5441,2)
 ;;=^267063
 ;;^UTILITY(U,$J,358.3,5442,0)
 ;;=C16.1^^40^367^60
 ;;^UTILITY(U,$J,358.3,5442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5442,1,3,0)
 ;;=3^Malig Neop of Fundus of Stomach
 ;;^UTILITY(U,$J,358.3,5442,1,4,0)
 ;;=4^C16.1
 ;;^UTILITY(U,$J,358.3,5442,2)
 ;;=^267066
 ;;^UTILITY(U,$J,358.3,5443,0)
 ;;=C16.2^^40^367^53
 ;;^UTILITY(U,$J,358.3,5443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5443,1,3,0)
 ;;=3^Malig Neop of Body of Stomach
 ;;^UTILITY(U,$J,358.3,5443,1,4,0)
 ;;=4^C16.2
 ;;^UTILITY(U,$J,358.3,5443,2)
 ;;=^267067
 ;;^UTILITY(U,$J,358.3,5444,0)
 ;;=C16.3^^40^367^74
 ;;^UTILITY(U,$J,358.3,5444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5444,1,3,0)
 ;;=3^Malig Neop of Pyloric Antrum
 ;;^UTILITY(U,$J,358.3,5444,1,4,0)
 ;;=4^C16.3
 ;;^UTILITY(U,$J,358.3,5444,2)
 ;;=^267065
 ;;^UTILITY(U,$J,358.3,5445,0)
 ;;=C16.4^^40^367^75
 ;;^UTILITY(U,$J,358.3,5445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5445,1,3,0)
 ;;=3^Malig Neop of Pylorus
 ;;^UTILITY(U,$J,358.3,5445,1,4,0)
 ;;=4^C16.4
 ;;^UTILITY(U,$J,358.3,5445,2)
 ;;=^267064
 ;;^UTILITY(U,$J,358.3,5446,0)
 ;;=C16.5^^40^367^64
 ;;^UTILITY(U,$J,358.3,5446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5446,1,3,0)
 ;;=3^Malig Neop of Lesser Curvature of Stomach,Unspec
 ;;^UTILITY(U,$J,358.3,5446,1,4,0)
 ;;=4^C16.5
 ;;^UTILITY(U,$J,358.3,5446,2)
 ;;=^5000920
 ;;^UTILITY(U,$J,358.3,5447,0)
 ;;=C16.6^^40^367^61
 ;;^UTILITY(U,$J,358.3,5447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5447,1,3,0)
 ;;=3^Malig Neop of Greater Curvature of Stomach,Unspec
 ;;^UTILITY(U,$J,358.3,5447,1,4,0)
 ;;=4^C16.6
 ;;^UTILITY(U,$J,358.3,5447,2)
 ;;=^5000921
 ;;^UTILITY(U,$J,358.3,5448,0)
 ;;=C16.8^^40^367^70
 ;;^UTILITY(U,$J,358.3,5448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5448,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Stomach
 ;;^UTILITY(U,$J,358.3,5448,1,4,0)
 ;;=4^C16.8
 ;;^UTILITY(U,$J,358.3,5448,2)
 ;;=^5000922
 ;;^UTILITY(U,$J,358.3,5449,0)
 ;;=C16.9^^40^367^80
 ;;^UTILITY(U,$J,358.3,5449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5449,1,3,0)
 ;;=3^Malig Neop of Stomach,Unspec
 ;;^UTILITY(U,$J,358.3,5449,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,5449,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,5450,0)
 ;;=C18.0^^40^367^55
 ;;^UTILITY(U,$J,358.3,5450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5450,1,3,0)
 ;;=3^Malig Neop of Cecum
 ;;^UTILITY(U,$J,358.3,5450,1,4,0)
 ;;=4^C18.0
 ;;^UTILITY(U,$J,358.3,5450,2)
 ;;=^267083
 ;;^UTILITY(U,$J,358.3,5451,0)
 ;;=C18.1^^40^367^50
 ;;^UTILITY(U,$J,358.3,5451,1,0)
 ;;=^358.31IA^4^2
