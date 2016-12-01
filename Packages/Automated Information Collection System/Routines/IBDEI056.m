IBDEI056 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6390,0)
 ;;=I50.32^^26^400^5
 ;;^UTILITY(U,$J,358.3,6390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6390,1,3,0)
 ;;=3^Diastolic Heart Failure,Chronic
 ;;^UTILITY(U,$J,358.3,6390,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,6390,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,6391,0)
 ;;=I50.33^^26^400^4
 ;;^UTILITY(U,$J,358.3,6391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6391,1,3,0)
 ;;=3^Diastolic Heart Failure,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,6391,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,6391,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,6392,0)
 ;;=I50.40^^26^400^9
 ;;^UTILITY(U,$J,358.3,6392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6392,1,3,0)
 ;;=3^Systolic & Diastolic Congestive Heart Failure,Combined Unspec
 ;;^UTILITY(U,$J,358.3,6392,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,6392,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,6393,0)
 ;;=I51.7^^26^400^2
 ;;^UTILITY(U,$J,358.3,6393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6393,1,3,0)
 ;;=3^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,6393,1,4,0)
 ;;=4^I51.7
 ;;^UTILITY(U,$J,358.3,6393,2)
 ;;=^5007257
 ;;^UTILITY(U,$J,358.3,6394,0)
 ;;=I42.6^^26^400^1
 ;;^UTILITY(U,$J,358.3,6394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6394,1,3,0)
 ;;=3^Alcoholic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,6394,1,4,0)
 ;;=4^I42.6
 ;;^UTILITY(U,$J,358.3,6394,2)
 ;;=^5007197
 ;;^UTILITY(U,$J,358.3,6395,0)
 ;;=I50.1^^26^400^8
 ;;^UTILITY(U,$J,358.3,6395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6395,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,6395,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,6395,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,6396,0)
 ;;=I50.20^^26^400^13
 ;;^UTILITY(U,$J,358.3,6396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6396,1,3,0)
 ;;=3^Systolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,6396,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,6396,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,6397,0)
 ;;=I50.21^^26^400^10
 ;;^UTILITY(U,$J,358.3,6397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6397,1,3,0)
 ;;=3^Systolic Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,6397,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,6397,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,6398,0)
 ;;=I50.22^^26^400^12
 ;;^UTILITY(U,$J,358.3,6398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6398,1,3,0)
 ;;=3^Systolic Heart Failure,Chronic
 ;;^UTILITY(U,$J,358.3,6398,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,6398,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,6399,0)
 ;;=I50.23^^26^400^11
 ;;^UTILITY(U,$J,358.3,6399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6399,1,3,0)
 ;;=3^Systolic Heart Failure,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,6399,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,6399,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,6400,0)
 ;;=I50.30^^26^400^6
 ;;^UTILITY(U,$J,358.3,6400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6400,1,3,0)
 ;;=3^Diastolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,6400,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,6400,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,6401,0)
 ;;=I50.9^^26^400^7
 ;;^UTILITY(U,$J,358.3,6401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6401,1,3,0)
 ;;=3^Heart Failure,Unspec (CHF Unspec)
 ;;^UTILITY(U,$J,358.3,6401,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,6401,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,6402,0)
 ;;=I50.31^^26^400^3
 ;;^UTILITY(U,$J,358.3,6402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6402,1,3,0)
 ;;=3^Diastolic Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,6402,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,6402,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,6403,0)
 ;;=I30.0^^26^401^5
 ;;^UTILITY(U,$J,358.3,6403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6403,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,6403,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,6403,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,6404,0)
 ;;=I34.8^^26^401^6
 ;;^UTILITY(U,$J,358.3,6404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6404,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,6404,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,6404,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,6405,0)
 ;;=I34.0^^26^401^13
 ;;^UTILITY(U,$J,358.3,6405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6405,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,6405,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,6405,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,6406,0)
 ;;=I34.9^^26^401^12
 ;;^UTILITY(U,$J,358.3,6406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6406,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,6406,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,6406,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,6407,0)
 ;;=I34.2^^26^401^7
 ;;^UTILITY(U,$J,358.3,6407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6407,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,6407,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,6407,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,6408,0)
 ;;=I35.0^^26^401^10
 ;;^UTILITY(U,$J,358.3,6408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6408,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,6408,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,6408,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,6409,0)
 ;;=I35.1^^26^401^9
 ;;^UTILITY(U,$J,358.3,6409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6409,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,6409,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,6409,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,6410,0)
 ;;=I35.2^^26^401^11
 ;;^UTILITY(U,$J,358.3,6410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6410,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,6410,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,6410,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,6411,0)
 ;;=I35.9^^26^401^8
 ;;^UTILITY(U,$J,358.3,6411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6411,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,6411,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,6411,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,6412,0)
 ;;=I38.^^26^401^4
 ;;^UTILITY(U,$J,358.3,6412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6412,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,6412,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,6412,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,6413,0)
 ;;=I05.0^^26^401^18
 ;;^UTILITY(U,$J,358.3,6413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6413,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,6413,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,6413,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,6414,0)
 ;;=I05.8^^26^401^19
 ;;^UTILITY(U,$J,358.3,6414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6414,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,6414,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,6414,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,6415,0)
 ;;=I05.9^^26^401^20
 ;;^UTILITY(U,$J,358.3,6415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6415,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6415,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,6415,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,6416,0)
 ;;=I07.1^^26^401^21
 ;;^UTILITY(U,$J,358.3,6416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6416,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,6416,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,6416,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,6417,0)
 ;;=I07.9^^26^401^22
 ;;^UTILITY(U,$J,358.3,6417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6417,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6417,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,6417,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,6418,0)
 ;;=I08.0^^26^401^16
 ;;^UTILITY(U,$J,358.3,6418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6418,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,6418,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,6418,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,6419,0)
 ;;=I09.89^^26^401^17
 ;;^UTILITY(U,$J,358.3,6419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6419,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,6419,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,6419,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,6420,0)
 ;;=I47.1^^26^401^24
 ;;^UTILITY(U,$J,358.3,6420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6420,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,6420,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,6420,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,6421,0)
 ;;=I48.0^^26^401^15
 ;;^UTILITY(U,$J,358.3,6421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6421,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,6421,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,6421,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,6422,0)
 ;;=I49.5^^26^401^23
 ;;^UTILITY(U,$J,358.3,6422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6422,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,6422,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,6422,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,6423,0)
 ;;=I49.8^^26^401^3
 ;;^UTILITY(U,$J,358.3,6423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6423,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,6423,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,6423,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,6424,0)
 ;;=I49.9^^26^401^2
 ;;^UTILITY(U,$J,358.3,6424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6424,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,6424,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,6424,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,6425,0)
 ;;=R00.1^^26^401^1
 ;;^UTILITY(U,$J,358.3,6425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6425,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,6425,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,6425,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,6426,0)
 ;;=I34.1^^26^401^14
 ;;^UTILITY(U,$J,358.3,6426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6426,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
