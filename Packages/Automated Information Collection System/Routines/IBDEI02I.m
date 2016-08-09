IBDEI02I ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2051,1,3,0)
 ;;=3^Presence of Xenogenic Heart Valve
 ;;^UTILITY(U,$J,358.3,2051,1,4,0)
 ;;=4^Z95.3
 ;;^UTILITY(U,$J,358.3,2051,2)
 ;;=^5063671
 ;;^UTILITY(U,$J,358.3,2052,0)
 ;;=Z95.4^^14^158^5
 ;;^UTILITY(U,$J,358.3,2052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2052,1,3,0)
 ;;=3^Presence of Heart Valve Replacement NEC
 ;;^UTILITY(U,$J,358.3,2052,1,4,0)
 ;;=4^Z95.4
 ;;^UTILITY(U,$J,358.3,2052,2)
 ;;=^5063672
 ;;^UTILITY(U,$J,358.3,2053,0)
 ;;=Z79.01^^14^158^2
 ;;^UTILITY(U,$J,358.3,2053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2053,1,3,0)
 ;;=3^Long Term Current Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,2053,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,2053,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,2054,0)
 ;;=I10.^^14^159^3
 ;;^UTILITY(U,$J,358.3,2054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2054,1,3,0)
 ;;=3^Hypertension,Essential
 ;;^UTILITY(U,$J,358.3,2054,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,2054,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,2055,0)
 ;;=I11.0^^14^159^6
 ;;^UTILITY(U,$J,358.3,2055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2055,1,3,0)
 ;;=3^Hypertensive Heart Disease w/ Heart Failure
 ;;^UTILITY(U,$J,358.3,2055,1,4,0)
 ;;=4^I11.0
 ;;^UTILITY(U,$J,358.3,2055,2)
 ;;=^5007063
 ;;^UTILITY(U,$J,358.3,2056,0)
 ;;=I11.9^^14^159^7
 ;;^UTILITY(U,$J,358.3,2056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2056,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,2056,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,2056,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,2057,0)
 ;;=I15.8^^14^159^5
 ;;^UTILITY(U,$J,358.3,2057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2057,1,3,0)
 ;;=3^Hypertension,Secondary
 ;;^UTILITY(U,$J,358.3,2057,1,4,0)
 ;;=4^I15.8
 ;;^UTILITY(U,$J,358.3,2057,2)
 ;;=^5007074
 ;;^UTILITY(U,$J,358.3,2058,0)
 ;;=I15.0^^14^159^4
 ;;^UTILITY(U,$J,358.3,2058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2058,1,3,0)
 ;;=3^Hypertension,Renovascular
 ;;^UTILITY(U,$J,358.3,2058,1,4,0)
 ;;=4^I15.0
 ;;^UTILITY(U,$J,358.3,2058,2)
 ;;=^5007071
 ;;^UTILITY(U,$J,358.3,2059,0)
 ;;=I70.1^^14^159^1
 ;;^UTILITY(U,$J,358.3,2059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2059,1,3,0)
 ;;=3^Atherosclerosis of Renal Artery
 ;;^UTILITY(U,$J,358.3,2059,1,4,0)
 ;;=4^I70.1
 ;;^UTILITY(U,$J,358.3,2059,2)
 ;;=^269760
 ;;^UTILITY(U,$J,358.3,2060,0)
 ;;=R03.0^^14^159^2
 ;;^UTILITY(U,$J,358.3,2060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2060,1,3,0)
 ;;=3^Elevated B/P Reading w/o HTN Diagnosis
 ;;^UTILITY(U,$J,358.3,2060,1,4,0)
 ;;=4^R03.0
 ;;^UTILITY(U,$J,358.3,2060,2)
 ;;=^5019171
 ;;^UTILITY(U,$J,358.3,2061,0)
 ;;=I95.1^^14^159^10
 ;;^UTILITY(U,$J,358.3,2061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2061,1,3,0)
 ;;=3^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,2061,1,4,0)
 ;;=4^I95.1
 ;;^UTILITY(U,$J,358.3,2061,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,2062,0)
 ;;=I95.2^^14^159^8
 ;;^UTILITY(U,$J,358.3,2062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2062,1,3,0)
 ;;=3^Hypotension d/t Drugs
 ;;^UTILITY(U,$J,358.3,2062,1,4,0)
 ;;=4^I95.2
 ;;^UTILITY(U,$J,358.3,2062,2)
 ;;=^5008077
 ;;^UTILITY(U,$J,358.3,2063,0)
 ;;=I95.81^^14^159^11
 ;;^UTILITY(U,$J,358.3,2063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2063,1,3,0)
 ;;=3^Postprocedural Hypotension
 ;;^UTILITY(U,$J,358.3,2063,1,4,0)
 ;;=4^I95.81
 ;;^UTILITY(U,$J,358.3,2063,2)
 ;;=^5008078
 ;;^UTILITY(U,$J,358.3,2064,0)
 ;;=I95.9^^14^159^9
 ;;^UTILITY(U,$J,358.3,2064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2064,1,3,0)
 ;;=3^Hypotension,Unspec
 ;;^UTILITY(U,$J,358.3,2064,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,2064,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,2065,0)
 ;;=B25.9^^14^160^5
 ;;^UTILITY(U,$J,358.3,2065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2065,1,3,0)
 ;;=3^CMV Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2065,1,4,0)
 ;;=4^B25.9
 ;;^UTILITY(U,$J,358.3,2065,2)
 ;;=^5000560
 ;;^UTILITY(U,$J,358.3,2066,0)
 ;;=I30.1^^14^160^7
 ;;^UTILITY(U,$J,358.3,2066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2066,1,3,0)
 ;;=3^Infective Pericarditis
 ;;^UTILITY(U,$J,358.3,2066,1,4,0)
 ;;=4^I30.1
 ;;^UTILITY(U,$J,358.3,2066,2)
 ;;=^5007158
 ;;^UTILITY(U,$J,358.3,2067,0)
 ;;=I30.0^^14^160^1
 ;;^UTILITY(U,$J,358.3,2067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2067,1,3,0)
 ;;=3^Acute Nonspecific Idiopathic Pericarditis
 ;;^UTILITY(U,$J,358.3,2067,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,2067,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,2068,0)
 ;;=I33.0^^14^160^3
 ;;^UTILITY(U,$J,358.3,2068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2068,1,3,0)
 ;;=3^Acute/Subacute Infective Endocarditis
 ;;^UTILITY(U,$J,358.3,2068,1,4,0)
 ;;=4^I33.0
 ;;^UTILITY(U,$J,358.3,2068,2)
 ;;=^5007167
 ;;^UTILITY(U,$J,358.3,2069,0)
 ;;=I33.9^^14^160^2
 ;;^UTILITY(U,$J,358.3,2069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2069,1,3,0)
 ;;=3^Acute/Subacute Endocarditis,Unspec
 ;;^UTILITY(U,$J,358.3,2069,1,4,0)
 ;;=4^I33.9
 ;;^UTILITY(U,$J,358.3,2069,2)
 ;;=^5007168
 ;;^UTILITY(U,$J,358.3,2070,0)
 ;;=I31.0^^14^160^4
 ;;^UTILITY(U,$J,358.3,2070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2070,1,3,0)
 ;;=3^Adhesive Pericarditis,Chronic
 ;;^UTILITY(U,$J,358.3,2070,1,4,0)
 ;;=4^I31.0
 ;;^UTILITY(U,$J,358.3,2070,2)
 ;;=^5007161
 ;;^UTILITY(U,$J,358.3,2071,0)
 ;;=I31.1^^14^160^6
 ;;^UTILITY(U,$J,358.3,2071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2071,1,3,0)
 ;;=3^Constrictive Pericarditis,Chronic
 ;;^UTILITY(U,$J,358.3,2071,1,4,0)
 ;;=4^I31.1
 ;;^UTILITY(U,$J,358.3,2071,2)
 ;;=^5007162
 ;;^UTILITY(U,$J,358.3,2072,0)
 ;;=E78.0^^14^161^5
 ;;^UTILITY(U,$J,358.3,2072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2072,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,2072,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,2072,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,2073,0)
 ;;=E78.1^^14^161^6
 ;;^UTILITY(U,$J,358.3,2073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2073,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,2073,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,2073,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,2074,0)
 ;;=E78.2^^14^161^4
 ;;^UTILITY(U,$J,358.3,2074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2074,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,2074,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,2074,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,2075,0)
 ;;=E78.4^^14^161^1
 ;;^UTILITY(U,$J,358.3,2075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2075,1,3,0)
 ;;=3^Hyperlipidemia NEC
 ;;^UTILITY(U,$J,358.3,2075,1,4,0)
 ;;=4^E78.4
 ;;^UTILITY(U,$J,358.3,2075,2)
 ;;=^5002968
 ;;^UTILITY(U,$J,358.3,2076,0)
 ;;=E78.5^^14^161^2
 ;;^UTILITY(U,$J,358.3,2076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2076,1,3,0)
 ;;=3^Hyperlipidemia,Unspec
 ;;^UTILITY(U,$J,358.3,2076,1,4,0)
 ;;=4^E78.5
 ;;^UTILITY(U,$J,358.3,2076,2)
 ;;=^5002969
 ;;^UTILITY(U,$J,358.3,2077,0)
 ;;=E78.6^^14^161^3
 ;;^UTILITY(U,$J,358.3,2077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2077,1,3,0)
 ;;=3^Lipoprotein Deficiency
 ;;^UTILITY(U,$J,358.3,2077,1,4,0)
 ;;=4^E78.6
 ;;^UTILITY(U,$J,358.3,2077,2)
 ;;=^5002970
 ;;^UTILITY(U,$J,358.3,2078,0)
 ;;=I22.0^^14^162^7
 ;;^UTILITY(U,$J,358.3,2078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2078,1,3,0)
 ;;=3^Subsequent STEMI of Anterior Wall
 ;;^UTILITY(U,$J,358.3,2078,1,4,0)
 ;;=4^I22.0
 ;;^UTILITY(U,$J,358.3,2078,2)
 ;;=^5007089
 ;;^UTILITY(U,$J,358.3,2079,0)
 ;;=I21.09^^14^162^2
 ;;^UTILITY(U,$J,358.3,2079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2079,1,3,0)
 ;;=3^STEMI Involving Coronary Artery of Anterior Wall
 ;;^UTILITY(U,$J,358.3,2079,1,4,0)
 ;;=4^I21.09
 ;;^UTILITY(U,$J,358.3,2079,2)
 ;;=^5007082
 ;;^UTILITY(U,$J,358.3,2080,0)
 ;;=I21.02^^14^162^4
 ;;^UTILITY(U,$J,358.3,2080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2080,1,3,0)
 ;;=3^STEMI Involving Left Anterior Descending Coronary Artery
