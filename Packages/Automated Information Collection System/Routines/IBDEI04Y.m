IBDEI04Y ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11976,1,4,0)
 ;;=4^S06.310D
 ;;^UTILITY(U,$J,358.3,11976,2)
 ;;=^5020787
 ;;^UTILITY(U,$J,358.3,11977,0)
 ;;=S06.389D^^50^543^7
 ;;^UTILITY(U,$J,358.3,11977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11977,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC,unsp duration,subsq
 ;;^UTILITY(U,$J,358.3,11977,1,4,0)
 ;;=4^S06.389D
 ;;^UTILITY(U,$J,358.3,11977,2)
 ;;=^5021024
 ;;^UTILITY(U,$J,358.3,11978,0)
 ;;=S06.380D^^50^543^8
 ;;^UTILITY(U,$J,358.3,11978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11978,1,3,0)
 ;;=3^Contus/lac/hem brnst w/o LOC,subsq
 ;;^UTILITY(U,$J,358.3,11978,1,4,0)
 ;;=4^S06.380D
 ;;^UTILITY(U,$J,358.3,11978,2)
 ;;=^5020997
 ;;^UTILITY(U,$J,358.3,11979,0)
 ;;=S06.379D^^50^543^9
 ;;^UTILITY(U,$J,358.3,11979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11979,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC,unsp duration,subsq
 ;;^UTILITY(U,$J,358.3,11979,1,4,0)
 ;;=4^S06.379D
 ;;^UTILITY(U,$J,358.3,11979,2)
 ;;=^5020994
 ;;^UTILITY(U,$J,358.3,11980,0)
 ;;=S06.370D^^50^543^10
 ;;^UTILITY(U,$J,358.3,11980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11980,1,3,0)
 ;;=3^Contus/lac/hem crblm w/o LOC,subsq
 ;;^UTILITY(U,$J,358.3,11980,1,4,0)
 ;;=4^S06.370D
 ;;^UTILITY(U,$J,358.3,11980,2)
 ;;=^5020967
 ;;^UTILITY(U,$J,358.3,11981,0)
 ;;=S06.2X9D^^50^543^11
 ;;^UTILITY(U,$J,358.3,11981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11981,1,3,0)
 ;;=3^Diffuse TBI w LOC,unsp duration,subsq
 ;;^UTILITY(U,$J,358.3,11981,1,4,0)
 ;;=4^S06.2X9D
 ;;^UTILITY(U,$J,358.3,11981,2)
 ;;=^5020754
 ;;^UTILITY(U,$J,358.3,11982,0)
 ;;=S06.2X0D^^50^543^12
 ;;^UTILITY(U,$J,358.3,11982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11982,1,3,0)
 ;;=3^Diffuse TBI w/o LOC,subsq
 ;;^UTILITY(U,$J,358.3,11982,1,4,0)
 ;;=4^S06.2X0D
 ;;^UTILITY(U,$J,358.3,11982,2)
 ;;=^5020727
 ;;^UTILITY(U,$J,358.3,11983,0)
 ;;=S06.4X9D^^50^543^13
 ;;^UTILITY(U,$J,358.3,11983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11983,1,3,0)
 ;;=3^Epidural hemorrhage w LOC,unsp duration,subsq
 ;;^UTILITY(U,$J,358.3,11983,1,4,0)
 ;;=4^S06.4X9D
 ;;^UTILITY(U,$J,358.3,11983,2)
 ;;=^5021054
 ;;^UTILITY(U,$J,358.3,11984,0)
 ;;=S06.4X0D^^50^543^14
 ;;^UTILITY(U,$J,358.3,11984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11984,1,3,0)
 ;;=3^Epidural hemorrhage w/o LOC,subsq
 ;;^UTILITY(U,$J,358.3,11984,1,4,0)
 ;;=4^S06.4X0D
 ;;^UTILITY(U,$J,358.3,11984,2)
 ;;=^5021027
 ;;^UTILITY(U,$J,358.3,11985,0)
 ;;=S06.829D^^50^543^15
 ;;^UTILITY(U,$J,358.3,11985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11985,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC,unsp duration,subsq
 ;;^UTILITY(U,$J,358.3,11985,1,4,0)
 ;;=4^S06.829D
 ;;^UTILITY(U,$J,358.3,11985,2)
 ;;=^5021174
 ;;^UTILITY(U,$J,358.3,11986,0)
 ;;=S06.820D^^50^543^16
 ;;^UTILITY(U,$J,358.3,11986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11986,1,3,0)
 ;;=3^Inj left int carotid, intcr w/o LOC,subsq
 ;;^UTILITY(U,$J,358.3,11986,1,4,0)
 ;;=4^S06.820D
 ;;^UTILITY(U,$J,358.3,11986,2)
 ;;=^5021147
 ;;^UTILITY(U,$J,358.3,11987,0)
 ;;=S06.819D^^50^543^17
 ;;^UTILITY(U,$J,358.3,11987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11987,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC,unsp duration,subsq
 ;;^UTILITY(U,$J,358.3,11987,1,4,0)
 ;;=4^S06.819D
 ;;^UTILITY(U,$J,358.3,11987,2)
 ;;=^5021144
 ;;^UTILITY(U,$J,358.3,11988,0)
 ;;=S06.810D^^50^543^18
 ;;^UTILITY(U,$J,358.3,11988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11988,1,3,0)
 ;;=3^Inj right int carotid, intcr w/o LOC,subsq
 ;;^UTILITY(U,$J,358.3,11988,1,4,0)
 ;;=4^S06.810D
 ;;^UTILITY(U,$J,358.3,11988,2)
 ;;=^5021117
 ;;^UTILITY(U,$J,358.3,11989,0)
 ;;=S06.359D^^50^543^21
 ;;^UTILITY(U,$J,358.3,11989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11989,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC,unsp duration,subsq
 ;;^UTILITY(U,$J,358.3,11989,1,4,0)
 ;;=4^S06.359D
 ;;^UTILITY(U,$J,358.3,11989,2)
 ;;=^5020934
 ;;^UTILITY(U,$J,358.3,11990,0)
 ;;=S06.350D^^50^543^22
 ;;^UTILITY(U,$J,358.3,11990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11990,1,3,0)
 ;;=3^Traum hemor left cerebrum w/o LOC,subsq
 ;;^UTILITY(U,$J,358.3,11990,1,4,0)
 ;;=4^S06.350D
 ;;^UTILITY(U,$J,358.3,11990,2)
 ;;=^5020907
 ;;^UTILITY(U,$J,358.3,11991,0)
 ;;=S06.349D^^50^543^23
 ;;^UTILITY(U,$J,358.3,11991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11991,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC,unsp duration,subsq
 ;;^UTILITY(U,$J,358.3,11991,1,4,0)
 ;;=4^S06.349D
 ;;^UTILITY(U,$J,358.3,11991,2)
 ;;=^5020904
 ;;^UTILITY(U,$J,358.3,11992,0)
 ;;=S06.340D^^50^543^24
 ;;^UTILITY(U,$J,358.3,11992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11992,1,3,0)
 ;;=3^Traum hemor right cerebrum w/o LOC,subsq
 ;;^UTILITY(U,$J,358.3,11992,1,4,0)
 ;;=4^S06.340D
 ;;^UTILITY(U,$J,358.3,11992,2)
 ;;=^5020877
 ;;^UTILITY(U,$J,358.3,11993,0)
 ;;=S06.5X9D^^50^543^25
 ;;^UTILITY(U,$J,358.3,11993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11993,1,3,0)
 ;;=3^Traum subdr hem w LOC,unsp duration,subsq
 ;;^UTILITY(U,$J,358.3,11993,1,4,0)
 ;;=4^S06.5X9D
 ;;^UTILITY(U,$J,358.3,11993,2)
 ;;=^5021084
 ;;^UTILITY(U,$J,358.3,11994,0)
 ;;=S06.5X0D^^50^543^26
 ;;^UTILITY(U,$J,358.3,11994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11994,1,3,0)
 ;;=3^Traum subdr hem w/o LOC,subsq
 ;;^UTILITY(U,$J,358.3,11994,1,4,0)
 ;;=4^S06.5X0D
 ;;^UTILITY(U,$J,358.3,11994,2)
 ;;=^5021057
 ;;^UTILITY(U,$J,358.3,11995,0)
 ;;=S06.6X9D^^50^543^27
 ;;^UTILITY(U,$J,358.3,11995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11995,1,3,0)
 ;;=3^Traum subrac hem w LOC,unsp duration,subsq
 ;;^UTILITY(U,$J,358.3,11995,1,4,0)
 ;;=4^S06.6X9D
 ;;^UTILITY(U,$J,358.3,11995,2)
 ;;=^5021114
 ;;^UTILITY(U,$J,358.3,11996,0)
 ;;=S06.6X0D^^50^543^28
 ;;^UTILITY(U,$J,358.3,11996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11996,1,3,0)
 ;;=3^Traum subrac hem w/o LOC,subsq
 ;;^UTILITY(U,$J,358.3,11996,1,4,0)
 ;;=4^S06.6X0D
 ;;^UTILITY(U,$J,358.3,11996,2)
 ;;=^5021087
 ;;^UTILITY(U,$J,358.3,11997,0)
 ;;=S06.1X9D^^50^543^19
 ;;^UTILITY(U,$J,358.3,11997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11997,1,3,0)
 ;;=3^Traum cerebral edema w LOC,unsp duration,subsq
 ;;^UTILITY(U,$J,358.3,11997,1,4,0)
 ;;=4^S06.1X9D
 ;;^UTILITY(U,$J,358.3,11997,2)
 ;;=^5020724
 ;;^UTILITY(U,$J,358.3,11998,0)
 ;;=S06.1X0D^^50^543^20
 ;;^UTILITY(U,$J,358.3,11998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11998,1,3,0)
 ;;=3^Traum cerebral edema w/o LOC,subsq
 ;;^UTILITY(U,$J,358.3,11998,1,4,0)
 ;;=4^S06.1X0D
 ;;^UTILITY(U,$J,358.3,11998,2)
 ;;=^5020697
 ;;^UTILITY(U,$J,358.3,11999,0)
 ;;=M84.750D^^50^544^1
 ;;^UTILITY(U,$J,358.3,11999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11999,1,3,0)
 ;;=3^Atypical Fx,Femur,Unspec,Subsq
 ;;^UTILITY(U,$J,358.3,11999,1,4,0)
 ;;=4^M84.750D
 ;;^UTILITY(U,$J,358.3,11999,2)
 ;;=^5138834
 ;;^UTILITY(U,$J,358.3,12000,0)
 ;;=M84.758D^^50^544^2
 ;;^UTILITY(U,$J,358.3,12000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12000,1,3,0)
 ;;=3^Complete Oblique Atyp Femoral Fx,Left,Subsq    
 ;;^UTILITY(U,$J,358.3,12000,1,4,0)
 ;;=4^M84.758D
 ;;^UTILITY(U,$J,358.3,12000,2)
 ;;=^5138882
 ;;^UTILITY(U,$J,358.3,12001,0)
 ;;=M84.757D^^50^544^3
 ;;^UTILITY(U,$J,358.3,12001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12001,1,3,0)
 ;;=3^Complete Oblique Atyp Femoral Fx,Right,Subsq    
 ;;^UTILITY(U,$J,358.3,12001,1,4,0)
 ;;=4^M84.757D
 ;;^UTILITY(U,$J,358.3,12001,2)
 ;;=^5138876
 ;;^UTILITY(U,$J,358.3,12002,0)
 ;;=M84.755D^^50^544^4
 ;;^UTILITY(U,$J,358.3,12002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12002,1,3,0)
 ;;=3^Complete Transverse Atyp Femoral Fx,Left,Subsq 
 ;;^UTILITY(U,$J,358.3,12002,1,4,0)
 ;;=4^M84.755D
 ;;^UTILITY(U,$J,358.3,12002,2)
 ;;=^5138864
 ;;^UTILITY(U,$J,358.3,12003,0)
 ;;=M84.754D^^50^544^5
 ;;^UTILITY(U,$J,358.3,12003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12003,1,3,0)
 ;;=3^Complete Transverse Atyp Femoral Fx,Right,Subsq 
 ;;^UTILITY(U,$J,358.3,12003,1,4,0)
 ;;=4^M84.754D
 ;;^UTILITY(U,$J,358.3,12003,2)
 ;;=^5138858
 ;;^UTILITY(U,$J,358.3,12004,0)
 ;;=S72.132D^^50^544^6
 ;;^UTILITY(U,$J,358.3,12004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12004,1,3,0)
 ;;=3^Displaced apophyseal Fx,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12004,1,4,0)
 ;;=4^S72.132D
 ;;^UTILITY(U,$J,358.3,12004,2)
 ;;=^5037838
 ;;^UTILITY(U,$J,358.3,12005,0)
 ;;=S72.131D^^50^544^7
 ;;^UTILITY(U,$J,358.3,12005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12005,1,3,0)
 ;;=3^Displaced apophyseal Fx,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12005,1,4,0)
 ;;=4^S72.131D
 ;;^UTILITY(U,$J,358.3,12005,2)
 ;;=^5037822
 ;;^UTILITY(U,$J,358.3,12006,0)
 ;;=S72.062D^^50^544^8
 ;;^UTILITY(U,$J,358.3,12006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12006,1,3,0)
 ;;=3^Displaced articular Fx,head,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12006,1,4,0)
 ;;=4^S72.062D
 ;;^UTILITY(U,$J,358.3,12006,2)
 ;;=^5037465
 ;;^UTILITY(U,$J,358.3,12007,0)
 ;;=S72.061D^^50^544^9
 ;;^UTILITY(U,$J,358.3,12007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12007,1,3,0)
 ;;=3^Displaced articular Fx,head,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12007,1,4,0)
 ;;=4^S72.061D
 ;;^UTILITY(U,$J,358.3,12007,2)
 ;;=^5037449
 ;;^UTILITY(U,$J,358.3,12008,0)
 ;;=S72.042D^^50^544^10
 ;;^UTILITY(U,$J,358.3,12008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12008,1,3,0)
 ;;=3^Displaced base of neck Fx,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12008,1,4,0)
 ;;=4^S72.042D
 ;;^UTILITY(U,$J,358.3,12008,2)
 ;;=^5037332
 ;;^UTILITY(U,$J,358.3,12009,0)
 ;;=S72.041D^^50^544^11
 ;;^UTILITY(U,$J,358.3,12009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12009,1,3,0)
 ;;=3^Displaced base of neck Fx,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12009,1,4,0)
 ;;=4^S72.041D
 ;;^UTILITY(U,$J,358.3,12009,2)
 ;;=^5037316
 ;;^UTILITY(U,$J,358.3,12010,0)
 ;;=S82.042D^^50^544^14
 ;;^UTILITY(U,$J,358.3,12010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12010,1,3,0)
 ;;=3^Displaced comminuted Fx,left patella,Subsq
 ;;^UTILITY(U,$J,358.3,12010,1,4,0)
 ;;=4^S82.042D
 ;;^UTILITY(U,$J,358.3,12010,2)
 ;;=^5040448
 ;;^UTILITY(U,$J,358.3,12011,0)
 ;;=S82.041D^^50^544^15
 ;;^UTILITY(U,$J,358.3,12011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12011,1,3,0)
 ;;=3^Displaced comminuted Fx,right patella,Subsq
 ;;^UTILITY(U,$J,358.3,12011,1,4,0)
 ;;=4^S82.041D
 ;;^UTILITY(U,$J,358.3,12011,2)
 ;;=^5040432
 ;;^UTILITY(U,$J,358.3,12012,0)
 ;;=S72.352D^^50^544^12
 ;;^UTILITY(U,$J,358.3,12012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12012,1,3,0)
 ;;=3^Displaced comminuted Fx shaft,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12012,1,4,0)
 ;;=4^S72.352D
 ;;^UTILITY(U,$J,358.3,12012,2)
 ;;=^5038451
 ;;^UTILITY(U,$J,358.3,12013,0)
 ;;=S72.351D^^50^544^13
 ;;^UTILITY(U,$J,358.3,12013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12013,1,3,0)
 ;;=3^Displaced comminuted Fx shaft,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12013,1,4,0)
 ;;=4^S72.351D
 ;;^UTILITY(U,$J,358.3,12013,2)
 ;;=^5038435
 ;;^UTILITY(U,$J,358.3,12014,0)
 ;;=S72.022D^^50^544^16
 ;;^UTILITY(U,$J,358.3,12014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12014,1,3,0)
 ;;=3^Displaced epiphy Fx,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12014,1,4,0)
 ;;=4^S72.022D
 ;;^UTILITY(U,$J,358.3,12014,2)
 ;;=^5037140
 ;;^UTILITY(U,$J,358.3,12015,0)
 ;;=S72.021D^^50^544^17
 ;;^UTILITY(U,$J,358.3,12015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12015,1,3,0)
 ;;=3^Displaced epiphy Fx,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12015,1,4,0)
 ;;=4^S72.021D
 ;;^UTILITY(U,$J,358.3,12015,2)
 ;;=^5037124
 ;;^UTILITY(U,$J,358.3,12016,0)
 ;;=S72.112D^^50^544^18
 ;;^UTILITY(U,$J,358.3,12016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12016,1,3,0)
 ;;=3^Displaced greater trochanter Fx,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12016,1,4,0)
 ;;=4^S72.112D
 ;;^UTILITY(U,$J,358.3,12016,2)
 ;;=^5037646
 ;;^UTILITY(U,$J,358.3,12017,0)
 ;;=S72.111D^^50^544^19
 ;;^UTILITY(U,$J,358.3,12017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12017,1,3,0)
 ;;=3^Displaced greater trochanter Fx,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12017,1,4,0)
 ;;=4^S72.111D
 ;;^UTILITY(U,$J,358.3,12017,2)
 ;;=^5037630
 ;;^UTILITY(U,$J,358.3,12018,0)
 ;;=S72.142D^^50^544^20
 ;;^UTILITY(U,$J,358.3,12018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12018,1,3,0)
 ;;=3^Displaced intertrochanteric Fx,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12018,1,4,0)
 ;;=4^S72.142D
 ;;^UTILITY(U,$J,358.3,12018,2)
 ;;=^5037934
 ;;^UTILITY(U,$J,358.3,12019,0)
 ;;=S72.141D^^50^544^21
 ;;^UTILITY(U,$J,358.3,12019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12019,1,3,0)
 ;;=3^Displaced intertrochanteric Fx,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12019,1,4,0)
 ;;=4^S72.141D
 ;;^UTILITY(U,$J,358.3,12019,2)
 ;;=^5037918
 ;;^UTILITY(U,$J,358.3,12020,0)
 ;;=S72.422D^^50^544^22
 ;;^UTILITY(U,$J,358.3,12020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12020,1,3,0)
 ;;=3^Displaced lateral condyle Fx,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12020,1,4,0)
 ;;=4^S72.422D
 ;;^UTILITY(U,$J,358.3,12020,2)
 ;;=^5038775
 ;;^UTILITY(U,$J,358.3,12021,0)
 ;;=S72.421D^^50^544^23
 ;;^UTILITY(U,$J,358.3,12021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12021,1,3,0)
 ;;=3^Displaced lateral condyle Fx,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12021,1,4,0)
 ;;=4^S72.421D
 ;;^UTILITY(U,$J,358.3,12021,2)
 ;;=^5038759
 ;;^UTILITY(U,$J,358.3,12022,0)
 ;;=S72.122D^^50^544^24
 ;;^UTILITY(U,$J,358.3,12022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12022,1,3,0)
 ;;=3^Displaced lesser trochanter Fx,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12022,1,4,0)
 ;;=4^S72.122D
 ;;^UTILITY(U,$J,358.3,12022,2)
 ;;=^5037742
 ;;^UTILITY(U,$J,358.3,12023,0)
 ;;=S72.121D^^50^544^25
 ;;^UTILITY(U,$J,358.3,12023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12023,1,3,0)
 ;;=3^Displaced lesser trochanter Fx,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12023,1,4,0)
 ;;=4^S72.121D
 ;;^UTILITY(U,$J,358.3,12023,2)
 ;;=^5037726
 ;;^UTILITY(U,$J,358.3,12024,0)
 ;;=S82.022D^^50^544^26
 ;;^UTILITY(U,$J,358.3,12024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12024,1,3,0)
 ;;=3^Displaced longitudinal Fx,left patella,Subsq
 ;;^UTILITY(U,$J,358.3,12024,1,4,0)
 ;;=4^S82.022D
 ;;^UTILITY(U,$J,358.3,12024,2)
 ;;=^5040256
 ;;^UTILITY(U,$J,358.3,12025,0)
 ;;=S82.021D^^50^544^27
 ;;^UTILITY(U,$J,358.3,12025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12025,1,3,0)
 ;;=3^Displaced longitudinal Fx,right patella,Subsq
 ;;^UTILITY(U,$J,358.3,12025,1,4,0)
 ;;=4^S82.021D
 ;;^UTILITY(U,$J,358.3,12025,2)
 ;;=^5040240
 ;;^UTILITY(U,$J,358.3,12026,0)
 ;;=S72.442D^^50^544^28
 ;;^UTILITY(U,$J,358.3,12026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12026,1,3,0)
 ;;=3^Displaced lower epiphysis Fx,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12026,1,4,0)
 ;;=4^S72.442D
 ;;^UTILITY(U,$J,358.3,12026,2)
 ;;=^5136230
 ;;^UTILITY(U,$J,358.3,12027,0)
 ;;=S72.441D^^50^544^29
 ;;^UTILITY(U,$J,358.3,12027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12027,1,3,0)
 ;;=3^Displaced lower epiphysis Fx,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12027,1,4,0)
 ;;=4^S72.441D
 ;;^UTILITY(U,$J,358.3,12027,2)
 ;;=^5038951
 ;;^UTILITY(U,$J,358.3,12028,0)
 ;;=S72.432D^^50^544^30
 ;;^UTILITY(U,$J,358.3,12028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12028,1,3,0)
 ;;=3^Displaced medial condyle Fx,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12028,1,4,0)
 ;;=4^S72.432D
 ;;^UTILITY(U,$J,358.3,12028,2)
 ;;=^5038871
 ;;^UTILITY(U,$J,358.3,12029,0)
 ;;=S72.431D^^50^544^31
 ;;^UTILITY(U,$J,358.3,12029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12029,1,3,0)
 ;;=3^Displaced medial condyle Fx,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12029,1,4,0)
 ;;=4^S72.431D
 ;;^UTILITY(U,$J,358.3,12029,2)
 ;;=^5038855
 ;;^UTILITY(U,$J,358.3,12030,0)
 ;;=S72.032D^^50^544^32
 ;;^UTILITY(U,$J,358.3,12030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12030,1,3,0)
 ;;=3^Displaced midcervical Fx,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12030,1,4,0)
 ;;=4^S72.032D
 ;;^UTILITY(U,$J,358.3,12030,2)
 ;;=^5037236
 ;;^UTILITY(U,$J,358.3,12031,0)
 ;;=S72.031D^^50^544^33
 ;;^UTILITY(U,$J,358.3,12031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12031,1,3,0)
 ;;=3^Displaced midcervical Fx,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12031,1,4,0)
 ;;=4^S72.031D
 ;;^UTILITY(U,$J,358.3,12031,2)
 ;;=^5037220
 ;;^UTILITY(U,$J,358.3,12032,0)
 ;;=S72.332D^^50^544^34
 ;;^UTILITY(U,$J,358.3,12032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12032,1,3,0)
 ;;=3^Displaced oblique Fx,shaft,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12032,1,4,0)
 ;;=4^S72.332D
 ;;^UTILITY(U,$J,358.3,12032,2)
 ;;=^5038259
 ;;^UTILITY(U,$J,358.3,12033,0)
 ;;=S72.331D^^50^544^35
 ;;^UTILITY(U,$J,358.3,12033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12033,1,3,0)
 ;;=3^Displaced oblique Fx,shaft,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12033,1,4,0)
 ;;=4^S72.331D
 ;;^UTILITY(U,$J,358.3,12033,2)
 ;;=^5038243
 ;;^UTILITY(U,$J,358.3,12034,0)
 ;;=S82.012D^^50^544^36
 ;;^UTILITY(U,$J,358.3,12034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12034,1,3,0)
 ;;=3^Displaced osteochondral Fx,left patella,Subsq
 ;;^UTILITY(U,$J,358.3,12034,1,4,0)
 ;;=4^S82.012D
 ;;^UTILITY(U,$J,358.3,12034,2)
 ;;=^5040160
 ;;^UTILITY(U,$J,358.3,12035,0)
 ;;=S82.011D^^50^544^37
 ;;^UTILITY(U,$J,358.3,12035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12035,1,3,0)
 ;;=3^Displaced osteochondral Fx,right patella,Subsq
 ;;^UTILITY(U,$J,358.3,12035,1,4,0)
 ;;=4^S82.011D
 ;;^UTILITY(U,$J,358.3,12035,2)
 ;;=^5040144
 ;;^UTILITY(U,$J,358.3,12036,0)
 ;;=S72.362D^^50^544^38
 ;;^UTILITY(U,$J,358.3,12036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12036,1,3,0)
 ;;=3^Displaced segmental Fx shaft,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12036,1,4,0)
 ;;=4^S72.362D
 ;;^UTILITY(U,$J,358.3,12036,2)
 ;;=^5038547
 ;;^UTILITY(U,$J,358.3,12037,0)
 ;;=S72.361D^^50^544^39
 ;;^UTILITY(U,$J,358.3,12037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12037,1,3,0)
 ;;=3^Displaced segmental Fx shaft,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12037,1,4,0)
 ;;=4^S72.361D
 ;;^UTILITY(U,$J,358.3,12037,2)
 ;;=^5038531
 ;;^UTILITY(U,$J,358.3,12038,0)
 ;;=S72.342D^^50^544^40
 ;;^UTILITY(U,$J,358.3,12038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12038,1,3,0)
 ;;=3^Displaced spiral Fx,shaft,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12038,1,4,0)
 ;;=4^S72.342D
 ;;^UTILITY(U,$J,358.3,12038,2)
 ;;=^5038355
 ;;^UTILITY(U,$J,358.3,12039,0)
 ;;=S72.341D^^50^544^41
 ;;^UTILITY(U,$J,358.3,12039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12039,1,3,0)
 ;;=3^Displaced spiral Fx,shaft,right femur,Subsq
 ;;^UTILITY(U,$J,358.3,12039,1,4,0)
 ;;=4^S72.341D
 ;;^UTILITY(U,$J,358.3,12039,2)
 ;;=^5038339
 ;;^UTILITY(U,$J,358.3,12040,0)
 ;;=S72.22XD^^50^544^42
 ;;^UTILITY(U,$J,358.3,12040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12040,1,3,0)
 ;;=3^Displaced subtrochanteric Fx,left femur,Subsq
 ;;^UTILITY(U,$J,358.3,12040,1,4,0)
 ;;=4^S72.22XD
 ;;^UTILITY(U,$J,358.3,12040,2)
 ;;=^5038030
 ;;^UTILITY(U,$J,358.3,12041,0)
 ;;=S72.21XD^^50^544^43
 ;;^UTILITY(U,$J,358.3,12041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12041,1,3,0)
 ;;=3^Displaced subtrochanteric Fx,right femur,Subsq
