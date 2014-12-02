IBDEI09R ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4517,1,5,0)
 ;;=5^553.3
 ;;^UTILITY(U,$J,358.3,4517,2)
 ;;=^33903
 ;;^UTILITY(U,$J,358.3,4518,0)
 ;;=153.5^^37^345^5
 ;;^UTILITY(U,$J,358.3,4518,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4518,1,4,0)
 ;;=4^CA of Appendix
 ;;^UTILITY(U,$J,358.3,4518,1,5,0)
 ;;=5^153.5
 ;;^UTILITY(U,$J,358.3,4518,2)
 ;;=CA of Appendix^267084
 ;;^UTILITY(U,$J,358.3,4519,0)
 ;;=153.4^^37^345^18
 ;;^UTILITY(U,$J,358.3,4519,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4519,1,4,0)
 ;;=4^CA of Ileocecal Valve
 ;;^UTILITY(U,$J,358.3,4519,1,5,0)
 ;;=5^153.4
 ;;^UTILITY(U,$J,358.3,4519,2)
 ;;=CA of Ileocecal Valve^267083
 ;;^UTILITY(U,$J,358.3,4520,0)
 ;;=154.0^^37^345^9
 ;;^UTILITY(U,$J,358.3,4520,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4520,1,4,0)
 ;;=4^CA of Colon and Rectum
 ;;^UTILITY(U,$J,358.3,4520,1,5,0)
 ;;=5^154.0
 ;;^UTILITY(U,$J,358.3,4520,2)
 ;;=CA of Colon and Rectum^267089
 ;;^UTILITY(U,$J,358.3,4521,0)
 ;;=153.6^^37^345^6
 ;;^UTILITY(U,$J,358.3,4521,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4521,1,4,0)
 ;;=4^CA of Ascending Colon
 ;;^UTILITY(U,$J,358.3,4521,1,5,0)
 ;;=5^153.6
 ;;^UTILITY(U,$J,358.3,4521,2)
 ;;=CA of Ascending Colon^267085
 ;;^UTILITY(U,$J,358.3,4522,0)
 ;;=153.8^^37^345^12
 ;;^UTILITY(U,$J,358.3,4522,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4522,1,4,0)
 ;;=4^CA of Colon/Contiguous Sites
 ;;^UTILITY(U,$J,358.3,4522,1,5,0)
 ;;=5^153.8
 ;;^UTILITY(U,$J,358.3,4522,2)
 ;;=CA of Colon/Contiguous Sites^267087
 ;;^UTILITY(U,$J,358.3,4523,0)
 ;;=153.2^^37^345^13
 ;;^UTILITY(U,$J,358.3,4523,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4523,1,4,0)
 ;;=4^CA of Descending Colon
 ;;^UTILITY(U,$J,358.3,4523,1,5,0)
 ;;=5^153.2
 ;;^UTILITY(U,$J,358.3,4523,2)
 ;;=CA of Descending Colon^267081
 ;;^UTILITY(U,$J,358.3,4524,0)
 ;;=153.3^^37^345^28
 ;;^UTILITY(U,$J,358.3,4524,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4524,1,4,0)
 ;;=4^CA of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,4524,1,5,0)
 ;;=5^153.3
 ;;^UTILITY(U,$J,358.3,4524,2)
 ;;=Ca of Sigmoid Colon^267082
 ;;^UTILITY(U,$J,358.3,4525,0)
 ;;=153.1^^37^345^37
 ;;^UTILITY(U,$J,358.3,4525,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4525,1,4,0)
 ;;=4^CA of Transverse Colon
 ;;^UTILITY(U,$J,358.3,4525,1,5,0)
 ;;=5^153.1
 ;;^UTILITY(U,$J,358.3,4525,2)
 ;;=CA of Transverse Colon^267080
 ;;^UTILITY(U,$J,358.3,4526,0)
 ;;=153.0^^37^345^11
 ;;^UTILITY(U,$J,358.3,4526,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4526,1,4,0)
 ;;=4^CA of Colon, Hepatic Flexure.
 ;;^UTILITY(U,$J,358.3,4526,1,5,0)
 ;;=5^153.0
 ;;^UTILITY(U,$J,358.3,4526,2)
 ;;=CA of Colon at Hepatic Flexure^267079
 ;;^UTILITY(U,$J,358.3,4527,0)
 ;;=153.7^^37^345^10
 ;;^UTILITY(U,$J,358.3,4527,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4527,1,4,0)
 ;;=4^CA of Colon at Splenic Flexure
 ;;^UTILITY(U,$J,358.3,4527,1,5,0)
 ;;=5^153.7
 ;;^UTILITY(U,$J,358.3,4527,2)
 ;;=CA of Colon at Splenic Flexure^267086
 ;;^UTILITY(U,$J,358.3,4528,0)
 ;;=151.9^^37^345^29
 ;;^UTILITY(U,$J,358.3,4528,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4528,1,4,0)
 ;;=4^CA of Stomach
 ;;^UTILITY(U,$J,358.3,4528,1,5,0)
 ;;=5^151.9
 ;;^UTILITY(U,$J,358.3,4528,2)
 ;;=CA of Stomach^73532
 ;;^UTILITY(U,$J,358.3,4529,0)
 ;;=151.2^^37^345^4
 ;;^UTILITY(U,$J,358.3,4529,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4529,1,4,0)
 ;;=4^CA of Antrum of Stomach
 ;;^UTILITY(U,$J,358.3,4529,1,5,0)
 ;;=5^151.2
 ;;^UTILITY(U,$J,358.3,4529,2)
 ;;=CA of Antrum of Stomach^267065
 ;;^UTILITY(U,$J,358.3,4530,0)
 ;;=151.4^^37^345^30
 ;;^UTILITY(U,$J,358.3,4530,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4530,1,4,0)
 ;;=4^CA of Stomach Body
