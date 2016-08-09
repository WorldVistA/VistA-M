IBDEI07H ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7395,1,3,0)
 ;;=3^Systolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,7395,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,7395,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,7396,0)
 ;;=I50.21^^42^496^10
 ;;^UTILITY(U,$J,358.3,7396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7396,1,3,0)
 ;;=3^Systolic Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,7396,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,7396,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,7397,0)
 ;;=I50.22^^42^496^12
 ;;^UTILITY(U,$J,358.3,7397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7397,1,3,0)
 ;;=3^Systolic Heart Failure,Chronic
 ;;^UTILITY(U,$J,358.3,7397,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,7397,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,7398,0)
 ;;=I50.23^^42^496^11
 ;;^UTILITY(U,$J,358.3,7398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7398,1,3,0)
 ;;=3^Systolic Heart Failure,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,7398,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,7398,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,7399,0)
 ;;=I50.30^^42^496^6
 ;;^UTILITY(U,$J,358.3,7399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7399,1,3,0)
 ;;=3^Diastolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,7399,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,7399,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,7400,0)
 ;;=I50.9^^42^496^7
 ;;^UTILITY(U,$J,358.3,7400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7400,1,3,0)
 ;;=3^Heart Failure,Unspec (CHF Unspec)
 ;;^UTILITY(U,$J,358.3,7400,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,7400,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,7401,0)
 ;;=I50.31^^42^496^3
 ;;^UTILITY(U,$J,358.3,7401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7401,1,3,0)
 ;;=3^Diastolic Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,7401,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,7401,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,7402,0)
 ;;=I30.0^^42^497^5
 ;;^UTILITY(U,$J,358.3,7402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7402,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,7402,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,7402,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,7403,0)
 ;;=I34.8^^42^497^6
 ;;^UTILITY(U,$J,358.3,7403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7403,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,7403,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,7403,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,7404,0)
 ;;=I34.0^^42^497^13
 ;;^UTILITY(U,$J,358.3,7404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7404,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,7404,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,7404,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,7405,0)
 ;;=I34.9^^42^497^12
 ;;^UTILITY(U,$J,358.3,7405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7405,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,7405,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,7405,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,7406,0)
 ;;=I34.2^^42^497^7
 ;;^UTILITY(U,$J,358.3,7406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7406,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,7406,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,7406,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,7407,0)
 ;;=I35.0^^42^497^10
 ;;^UTILITY(U,$J,358.3,7407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7407,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,7407,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,7407,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,7408,0)
 ;;=I35.1^^42^497^9
 ;;^UTILITY(U,$J,358.3,7408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7408,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,7408,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,7408,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,7409,0)
 ;;=I35.2^^42^497^11
 ;;^UTILITY(U,$J,358.3,7409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7409,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,7409,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,7409,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,7410,0)
 ;;=I35.9^^42^497^8
 ;;^UTILITY(U,$J,358.3,7410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7410,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,7410,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,7410,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,7411,0)
 ;;=I38.^^42^497^4
 ;;^UTILITY(U,$J,358.3,7411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7411,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,7411,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,7411,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,7412,0)
 ;;=I05.0^^42^497^18
 ;;^UTILITY(U,$J,358.3,7412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7412,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,7412,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,7412,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,7413,0)
 ;;=I05.8^^42^497^19
 ;;^UTILITY(U,$J,358.3,7413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7413,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,7413,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,7413,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,7414,0)
 ;;=I05.9^^42^497^20
 ;;^UTILITY(U,$J,358.3,7414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7414,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,7414,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,7414,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,7415,0)
 ;;=I07.1^^42^497^21
 ;;^UTILITY(U,$J,358.3,7415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7415,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,7415,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,7415,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,7416,0)
 ;;=I07.9^^42^497^22
 ;;^UTILITY(U,$J,358.3,7416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7416,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,7416,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,7416,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,7417,0)
 ;;=I08.0^^42^497^16
 ;;^UTILITY(U,$J,358.3,7417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7417,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,7417,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,7417,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,7418,0)
 ;;=I09.89^^42^497^17
 ;;^UTILITY(U,$J,358.3,7418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7418,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,7418,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,7418,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,7419,0)
 ;;=I47.1^^42^497^24
 ;;^UTILITY(U,$J,358.3,7419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7419,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,7419,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,7419,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,7420,0)
 ;;=I48.0^^42^497^15
 ;;^UTILITY(U,$J,358.3,7420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7420,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,7420,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,7420,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,7421,0)
 ;;=I49.5^^42^497^23
 ;;^UTILITY(U,$J,358.3,7421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7421,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,7421,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,7421,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,7422,0)
 ;;=I49.8^^42^497^3
 ;;^UTILITY(U,$J,358.3,7422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7422,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,7422,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,7422,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,7423,0)
 ;;=I49.9^^42^497^2
 ;;^UTILITY(U,$J,358.3,7423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7423,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,7423,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,7423,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,7424,0)
 ;;=R00.1^^42^497^1
