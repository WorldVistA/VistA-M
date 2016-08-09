IBDEI02F ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1965,1,4,0)
 ;;=4^I27.0
 ;;^UTILITY(U,$J,358.3,1965,2)
 ;;=^265310
 ;;^UTILITY(U,$J,358.3,1966,0)
 ;;=I27.1^^14^155^32
 ;;^UTILITY(U,$J,358.3,1966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1966,1,3,0)
 ;;=3^Kyphoscoliotic Hrt Disease
 ;;^UTILITY(U,$J,358.3,1966,1,4,0)
 ;;=4^I27.1
 ;;^UTILITY(U,$J,358.3,1966,2)
 ;;=^265120
 ;;^UTILITY(U,$J,358.3,1967,0)
 ;;=I27.2^^14^155^52
 ;;^UTILITY(U,$J,358.3,1967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1967,1,3,0)
 ;;=3^Secondary Pulmonary Hypertension NEC
 ;;^UTILITY(U,$J,358.3,1967,1,4,0)
 ;;=4^I27.2
 ;;^UTILITY(U,$J,358.3,1967,2)
 ;;=^5007151
 ;;^UTILITY(U,$J,358.3,1968,0)
 ;;=I27.89^^14^155^50
 ;;^UTILITY(U,$J,358.3,1968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1968,1,3,0)
 ;;=3^Pulmonary Hrt Diseases NEC
 ;;^UTILITY(U,$J,358.3,1968,1,4,0)
 ;;=4^I27.89
 ;;^UTILITY(U,$J,358.3,1968,2)
 ;;=^5007153
 ;;^UTILITY(U,$J,358.3,1969,0)
 ;;=I27.81^^14^155^18
 ;;^UTILITY(U,$J,358.3,1969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1969,1,3,0)
 ;;=3^Cor Pulmonale,Chronic
 ;;^UTILITY(U,$J,358.3,1969,1,4,0)
 ;;=4^I27.81
 ;;^UTILITY(U,$J,358.3,1969,2)
 ;;=^5007152
 ;;^UTILITY(U,$J,358.3,1970,0)
 ;;=I42.1^^14^155^36
 ;;^UTILITY(U,$J,358.3,1970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1970,1,3,0)
 ;;=3^Obstructive Hypertrophic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,1970,1,4,0)
 ;;=4^I42.1
 ;;^UTILITY(U,$J,358.3,1970,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,1971,0)
 ;;=I42.2^^14^155^31
 ;;^UTILITY(U,$J,358.3,1971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1971,1,3,0)
 ;;=3^Hypertrophic Cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,1971,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,1971,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,1972,0)
 ;;=I42.5^^14^155^51
 ;;^UTILITY(U,$J,358.3,1972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1972,1,3,0)
 ;;=3^Restrictive Cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,1972,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,1972,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,1973,0)
 ;;=I42.6^^14^155^4
 ;;^UTILITY(U,$J,358.3,1973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1973,1,3,0)
 ;;=3^Alcoholic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,1973,1,4,0)
 ;;=4^I42.6
 ;;^UTILITY(U,$J,358.3,1973,2)
 ;;=^5007197
 ;;^UTILITY(U,$J,358.3,1974,0)
 ;;=I43.^^14^155^8
 ;;^UTILITY(U,$J,358.3,1974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1974,1,3,0)
 ;;=3^Cardiomyopathy in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,1974,1,4,0)
 ;;=4^I43.
 ;;^UTILITY(U,$J,358.3,1974,2)
 ;;=^5007201
 ;;^UTILITY(U,$J,358.3,1975,0)
 ;;=I42.7^^14^155^7
 ;;^UTILITY(U,$J,358.3,1975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1975,1,3,0)
 ;;=3^Cardiomyopathy d/t Drug/External Agent
 ;;^UTILITY(U,$J,358.3,1975,1,4,0)
 ;;=4^I42.7
 ;;^UTILITY(U,$J,358.3,1975,2)
 ;;=^5007198
 ;;^UTILITY(U,$J,358.3,1976,0)
 ;;=I42.9^^14^155^9
 ;;^UTILITY(U,$J,358.3,1976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1976,1,3,0)
 ;;=3^Cardiomyopathy,Unspec
 ;;^UTILITY(U,$J,358.3,1976,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,1976,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,1977,0)
 ;;=I50.9^^14^155^22
 ;;^UTILITY(U,$J,358.3,1977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1977,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1977,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,1977,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,1978,0)
 ;;=I50.1^^14^155^33
 ;;^UTILITY(U,$J,358.3,1978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1978,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,1978,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,1978,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,1979,0)
 ;;=I50.20^^14^155^55
 ;;^UTILITY(U,$J,358.3,1979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1979,1,3,0)
 ;;=3^Systolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1979,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,1979,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,1980,0)
 ;;=I50.30^^14^155^19
 ;;^UTILITY(U,$J,358.3,1980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1980,1,3,0)
 ;;=3^Diastolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1980,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,1980,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,1981,0)
 ;;=I50.40^^14^155^54
 ;;^UTILITY(U,$J,358.3,1981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1981,1,3,0)
 ;;=3^Systolic & Diastolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1981,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,1981,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,1982,0)
 ;;=I51.7^^14^155^6
 ;;^UTILITY(U,$J,358.3,1982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1982,1,3,0)
 ;;=3^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,1982,1,4,0)
 ;;=4^I51.7
 ;;^UTILITY(U,$J,358.3,1982,2)
 ;;=^5007257
 ;;^UTILITY(U,$J,358.3,1983,0)
 ;;=I97.111^^14^155^42
 ;;^UTILITY(U,$J,358.3,1983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1983,1,3,0)
 ;;=3^Postprocedural Cardiac Insufficiency Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1983,1,4,0)
 ;;=4^I97.111
 ;;^UTILITY(U,$J,358.3,1983,2)
 ;;=^5008084
 ;;^UTILITY(U,$J,358.3,1984,0)
 ;;=I97.120^^14^155^38
 ;;^UTILITY(U,$J,358.3,1984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1984,1,3,0)
 ;;=3^Postprocedural Cardiac Arrest Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1984,1,4,0)
 ;;=4^I97.120
 ;;^UTILITY(U,$J,358.3,1984,2)
 ;;=^5008085
 ;;^UTILITY(U,$J,358.3,1985,0)
 ;;=I97.121^^14^155^39
 ;;^UTILITY(U,$J,358.3,1985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1985,1,3,0)
 ;;=3^Postprocedural Cardiac Arrest Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1985,1,4,0)
 ;;=4^I97.121
 ;;^UTILITY(U,$J,358.3,1985,2)
 ;;=^5008086
 ;;^UTILITY(U,$J,358.3,1986,0)
 ;;=I97.130^^14^155^44
 ;;^UTILITY(U,$J,358.3,1986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1986,1,3,0)
 ;;=3^Postprocedural Heart Failure Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1986,1,4,0)
 ;;=4^I97.130
 ;;^UTILITY(U,$J,358.3,1986,2)
 ;;=^5008087
 ;;^UTILITY(U,$J,358.3,1987,0)
 ;;=I97.131^^14^155^45
 ;;^UTILITY(U,$J,358.3,1987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1987,1,3,0)
 ;;=3^Postprocedural Heart Failure Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1987,1,4,0)
 ;;=4^I97.131
 ;;^UTILITY(U,$J,358.3,1987,2)
 ;;=^5008088
 ;;^UTILITY(U,$J,358.3,1988,0)
 ;;=I97.190^^14^155^40
 ;;^UTILITY(U,$J,358.3,1988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1988,1,3,0)
 ;;=3^Postprocedural Cardiac Function Disturbance Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1988,1,4,0)
 ;;=4^I97.190
 ;;^UTILITY(U,$J,358.3,1988,2)
 ;;=^5008089
 ;;^UTILITY(U,$J,358.3,1989,0)
 ;;=I97.191^^14^155^41
 ;;^UTILITY(U,$J,358.3,1989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1989,1,3,0)
 ;;=3^Postprocedural Cardiac Function Disturbance Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1989,1,4,0)
 ;;=4^I97.191
 ;;^UTILITY(U,$J,358.3,1989,2)
 ;;=^5008090
 ;;^UTILITY(U,$J,358.3,1990,0)
 ;;=I97.0^^14^155^37
 ;;^UTILITY(U,$J,358.3,1990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1990,1,3,0)
 ;;=3^Postcardiotomy Syndrome
 ;;^UTILITY(U,$J,358.3,1990,1,4,0)
 ;;=4^I97.0
 ;;^UTILITY(U,$J,358.3,1990,2)
 ;;=^5008082
 ;;^UTILITY(U,$J,358.3,1991,0)
 ;;=I97.110^^14^155^43
 ;;^UTILITY(U,$J,358.3,1991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1991,1,3,0)
 ;;=3^Postprocedural Cardiac Insufficiency Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1991,1,4,0)
 ;;=4^I97.110
 ;;^UTILITY(U,$J,358.3,1991,2)
 ;;=^5008083
 ;;^UTILITY(U,$J,358.3,1992,0)
 ;;=T86.20^^14^155^11
 ;;^UTILITY(U,$J,358.3,1992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1992,1,3,0)
 ;;=3^Complication of Heart Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,1992,1,4,0)
 ;;=4^T86.20
 ;;^UTILITY(U,$J,358.3,1992,2)
 ;;=^5055713
 ;;^UTILITY(U,$J,358.3,1993,0)
 ;;=T86.21^^14^155^25
 ;;^UTILITY(U,$J,358.3,1993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1993,1,3,0)
 ;;=3^Heart Transplant Rejection
