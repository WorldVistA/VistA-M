IBDEI0DN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5945,1,4,0)
 ;;=4^D78.22
 ;;^UTILITY(U,$J,358.3,5945,2)
 ;;=^5002402
 ;;^UTILITY(U,$J,358.3,5946,0)
 ;;=K91.82^^40^380^22
 ;;^UTILITY(U,$J,358.3,5946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5946,1,3,0)
 ;;=3^Postprocedural Hepatic Failure
 ;;^UTILITY(U,$J,358.3,5946,1,4,0)
 ;;=4^K91.82
 ;;^UTILITY(U,$J,358.3,5946,2)
 ;;=^5008908
 ;;^UTILITY(U,$J,358.3,5947,0)
 ;;=K91.83^^40^380^23
 ;;^UTILITY(U,$J,358.3,5947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5947,1,3,0)
 ;;=3^Postprocedural Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,5947,1,4,0)
 ;;=4^K91.83
 ;;^UTILITY(U,$J,358.3,5947,2)
 ;;=^5008909
 ;;^UTILITY(U,$J,358.3,5948,0)
 ;;=K91.3^^40^380^24
 ;;^UTILITY(U,$J,358.3,5948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5948,1,3,0)
 ;;=3^Postprocedural Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,5948,1,4,0)
 ;;=4^K91.3
 ;;^UTILITY(U,$J,358.3,5948,2)
 ;;=^5008902
 ;;^UTILITY(U,$J,358.3,5949,0)
 ;;=K68.11^^40^380^25
 ;;^UTILITY(U,$J,358.3,5949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5949,1,3,0)
 ;;=3^Postprocedural Retroperitoneal Abscess
 ;;^UTILITY(U,$J,358.3,5949,1,4,0)
 ;;=4^K68.11
 ;;^UTILITY(U,$J,358.3,5949,2)
 ;;=^5008782
 ;;^UTILITY(U,$J,358.3,5950,0)
 ;;=K91.850^^40^380^26
 ;;^UTILITY(U,$J,358.3,5950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5950,1,3,0)
 ;;=3^Pouchitis
 ;;^UTILITY(U,$J,358.3,5950,1,4,0)
 ;;=4^K91.850
 ;;^UTILITY(U,$J,358.3,5950,2)
 ;;=^338261
 ;;^UTILITY(U,$J,358.3,5951,0)
 ;;=C34.91^^40^381^22
 ;;^UTILITY(U,$J,358.3,5951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5951,1,3,0)
 ;;=3^Malig Neop of Right Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,5951,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,5951,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,5952,0)
 ;;=C34.92^^40^381^21
 ;;^UTILITY(U,$J,358.3,5952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5952,1,3,0)
 ;;=3^Malig Neop of Left Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,5952,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,5952,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,5953,0)
 ;;=J20.9^^40^381^10
 ;;^UTILITY(U,$J,358.3,5953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5953,1,3,0)
 ;;=3^Acute Bronchitis,Unspec
 ;;^UTILITY(U,$J,358.3,5953,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,5953,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,5954,0)
 ;;=J20.8^^40^381^5
 ;;^UTILITY(U,$J,358.3,5954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5954,1,3,0)
 ;;=3^Acute Bronchitis d/t Organisms NEC
 ;;^UTILITY(U,$J,358.3,5954,1,4,0)
 ;;=4^J20.8
 ;;^UTILITY(U,$J,358.3,5954,2)
 ;;=^5008194
 ;;^UTILITY(U,$J,358.3,5955,0)
 ;;=J20.5^^40^381^7
 ;;^UTILITY(U,$J,358.3,5955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5955,1,3,0)
 ;;=3^Acute Bronchitis d/t Respiratory Syncytial Virus
 ;;^UTILITY(U,$J,358.3,5955,1,4,0)
 ;;=4^J20.5
 ;;^UTILITY(U,$J,358.3,5955,2)
 ;;=^5008191
 ;;^UTILITY(U,$J,358.3,5956,0)
 ;;=J20.6^^40^381^8
 ;;^UTILITY(U,$J,358.3,5956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5956,1,3,0)
 ;;=3^Acute Bronchitis d/t Rhinovirus
 ;;^UTILITY(U,$J,358.3,5956,1,4,0)
 ;;=4^J20.6
 ;;^UTILITY(U,$J,358.3,5956,2)
 ;;=^5008192
 ;;^UTILITY(U,$J,358.3,5957,0)
 ;;=J20.2^^40^381^9
 ;;^UTILITY(U,$J,358.3,5957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5957,1,3,0)
 ;;=3^Acute Bronchitis d/t Streptococcus
 ;;^UTILITY(U,$J,358.3,5957,1,4,0)
 ;;=4^J20.2
 ;;^UTILITY(U,$J,358.3,5957,2)
 ;;=^5008188
 ;;^UTILITY(U,$J,358.3,5958,0)
 ;;=J20.4^^40^381^6
 ;;^UTILITY(U,$J,358.3,5958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5958,1,3,0)
 ;;=3^Acute Bronchitis d/t Parainfluenza Virus
 ;;^UTILITY(U,$J,358.3,5958,1,4,0)
 ;;=4^J20.4
 ;;^UTILITY(U,$J,358.3,5958,2)
 ;;=^5008190
