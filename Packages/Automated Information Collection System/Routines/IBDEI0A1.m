IBDEI0A1 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24565,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,24565,1,4,0)
 ;;=4^S06.5X5S
 ;;^UTILITY(U,$J,358.3,24565,2)
 ;;=^5021073
 ;;^UTILITY(U,$J,358.3,24566,0)
 ;;=S06.5X6S^^76^1006^92
 ;;^UTILITY(U,$J,358.3,24566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24566,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,24566,1,4,0)
 ;;=4^S06.5X6S
 ;;^UTILITY(U,$J,358.3,24566,2)
 ;;=^5021076
 ;;^UTILITY(U,$J,358.3,24567,0)
 ;;=S06.5X3S^^76^1006^93
 ;;^UTILITY(U,$J,358.3,24567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24567,1,3,0)
 ;;=3^Traum subdr hem w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,24567,1,4,0)
 ;;=4^S06.5X3S
 ;;^UTILITY(U,$J,358.3,24567,2)
 ;;=^5021067
 ;;^UTILITY(U,$J,358.3,24568,0)
 ;;=S06.5X1S^^76^1006^94
 ;;^UTILITY(U,$J,358.3,24568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24568,1,3,0)
 ;;=3^Traum subdr hem w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,24568,1,4,0)
 ;;=4^S06.5X1S
 ;;^UTILITY(U,$J,358.3,24568,2)
 ;;=^5021061
 ;;^UTILITY(U,$J,358.3,24569,0)
 ;;=S06.5X2S^^76^1006^95
 ;;^UTILITY(U,$J,358.3,24569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24569,1,3,0)
 ;;=3^Traum subdr hem w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,24569,1,4,0)
 ;;=4^S06.5X2S
 ;;^UTILITY(U,$J,358.3,24569,2)
 ;;=^5021064
 ;;^UTILITY(U,$J,358.3,24570,0)
 ;;=S06.5X4S^^76^1006^96
 ;;^UTILITY(U,$J,358.3,24570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24570,1,3,0)
 ;;=3^Traum subdr hem w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,24570,1,4,0)
 ;;=4^S06.5X4S
 ;;^UTILITY(U,$J,358.3,24570,2)
 ;;=^5021070
 ;;^UTILITY(U,$J,358.3,24571,0)
 ;;=S06.5X9S^^76^1006^97
 ;;^UTILITY(U,$J,358.3,24571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24571,1,3,0)
 ;;=3^Traum subdr hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,24571,1,4,0)
 ;;=4^S06.5X9S
 ;;^UTILITY(U,$J,358.3,24571,2)
 ;;=^5021085
 ;;^UTILITY(U,$J,358.3,24572,0)
 ;;=S06.5X0S^^76^1006^98
 ;;^UTILITY(U,$J,358.3,24572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24572,1,3,0)
 ;;=3^Traum subdr hem w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,24572,1,4,0)
 ;;=4^S06.5X0S
 ;;^UTILITY(U,$J,358.3,24572,2)
 ;;=^5021058
 ;;^UTILITY(U,$J,358.3,24573,0)
 ;;=M84.351S^^76^1007^114
 ;;^UTILITY(U,$J,358.3,24573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24573,1,3,0)
 ;;=3^Stress fracture, right femur, sequela
 ;;^UTILITY(U,$J,358.3,24573,1,4,0)
 ;;=4^M84.351S
 ;;^UTILITY(U,$J,358.3,24573,2)
 ;;=^5013685
 ;;^UTILITY(U,$J,358.3,24574,0)
 ;;=M84.352S^^76^1007^113
 ;;^UTILITY(U,$J,358.3,24574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24574,1,3,0)
 ;;=3^Stress fracture, left femur, sequela
 ;;^UTILITY(U,$J,358.3,24574,1,4,0)
 ;;=4^M84.352S
 ;;^UTILITY(U,$J,358.3,24574,2)
 ;;=^5013691
 ;;^UTILITY(U,$J,358.3,24575,0)
 ;;=M84.451S^^76^1007^102
 ;;^UTILITY(U,$J,358.3,24575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24575,1,3,0)
 ;;=3^Pathological fracture, right femur, sequela
 ;;^UTILITY(U,$J,358.3,24575,1,4,0)
 ;;=4^M84.451S
 ;;^UTILITY(U,$J,358.3,24575,2)
 ;;=^5013907
 ;;^UTILITY(U,$J,358.3,24576,0)
 ;;=M84.452S^^76^1007^101
 ;;^UTILITY(U,$J,358.3,24576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24576,1,3,0)
 ;;=3^Pathological fracture, left femur, sequela
 ;;^UTILITY(U,$J,358.3,24576,1,4,0)
 ;;=4^M84.452S
 ;;^UTILITY(U,$J,358.3,24576,2)
 ;;=^5013913
 ;;^UTILITY(U,$J,358.3,24577,0)
 ;;=S72.021S^^76^1007^17
 ;;^UTILITY(U,$J,358.3,24577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24577,1,3,0)
 ;;=3^Displaced epiphy fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24577,1,4,0)
 ;;=4^S72.021S
 ;;^UTILITY(U,$J,358.3,24577,2)
 ;;=^5037136
 ;;^UTILITY(U,$J,358.3,24578,0)
 ;;=S72.022S^^76^1007^16
 ;;^UTILITY(U,$J,358.3,24578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24578,1,3,0)
 ;;=3^Displaced epiphy fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24578,1,4,0)
 ;;=4^S72.022S
 ;;^UTILITY(U,$J,358.3,24578,2)
 ;;=^5037152
 ;;^UTILITY(U,$J,358.3,24579,0)
 ;;=S72.024S^^76^1007^65
 ;;^UTILITY(U,$J,358.3,24579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24579,1,3,0)
 ;;=3^Nondisp epiphy fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24579,1,4,0)
 ;;=4^S72.024S
 ;;^UTILITY(U,$J,358.3,24579,2)
 ;;=^5037184
 ;;^UTILITY(U,$J,358.3,24580,0)
 ;;=S72.025S^^76^1007^64
 ;;^UTILITY(U,$J,358.3,24580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24580,1,3,0)
 ;;=3^Nondisp epiphy fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24580,1,4,0)
 ;;=4^S72.025S
 ;;^UTILITY(U,$J,358.3,24580,2)
 ;;=^5037200
 ;;^UTILITY(U,$J,358.3,24581,0)
 ;;=S72.031S^^76^1007^33
 ;;^UTILITY(U,$J,358.3,24581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24581,1,3,0)
 ;;=3^Displaced midcervical fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24581,1,4,0)
 ;;=4^S72.031S
 ;;^UTILITY(U,$J,358.3,24581,2)
 ;;=^5037232
 ;;^UTILITY(U,$J,358.3,24582,0)
 ;;=S72.032S^^76^1007^32
 ;;^UTILITY(U,$J,358.3,24582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24582,1,3,0)
 ;;=3^Displaced midcervical fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24582,1,4,0)
 ;;=4^S72.032S
 ;;^UTILITY(U,$J,358.3,24582,2)
 ;;=^5037248
 ;;^UTILITY(U,$J,358.3,24583,0)
 ;;=S72.034S^^76^1007^81
 ;;^UTILITY(U,$J,358.3,24583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24583,1,3,0)
 ;;=3^Nondisp midcervical fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24583,1,4,0)
 ;;=4^S72.034S
 ;;^UTILITY(U,$J,358.3,24583,2)
 ;;=^5037280
 ;;^UTILITY(U,$J,358.3,24584,0)
 ;;=S72.035S^^76^1007^80
 ;;^UTILITY(U,$J,358.3,24584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24584,1,3,0)
 ;;=3^Nondisp midcervical fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24584,1,4,0)
 ;;=4^S72.035S
 ;;^UTILITY(U,$J,358.3,24584,2)
 ;;=^5037296
 ;;^UTILITY(U,$J,358.3,24585,0)
 ;;=S72.041S^^76^1007^11
 ;;^UTILITY(U,$J,358.3,24585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24585,1,3,0)
 ;;=3^Displaced base of neck fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24585,1,4,0)
 ;;=4^S72.041S
 ;;^UTILITY(U,$J,358.3,24585,2)
 ;;=^5037328
 ;;^UTILITY(U,$J,358.3,24586,0)
 ;;=S72.042S^^76^1007^10
 ;;^UTILITY(U,$J,358.3,24586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24586,1,3,0)
 ;;=3^Displaced base of neck fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24586,1,4,0)
 ;;=4^S72.042S
 ;;^UTILITY(U,$J,358.3,24586,2)
 ;;=^5037344
 ;;^UTILITY(U,$J,358.3,24587,0)
 ;;=S72.044S^^76^1007^59
 ;;^UTILITY(U,$J,358.3,24587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24587,1,3,0)
 ;;=3^Nondisp base of neck fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24587,1,4,0)
 ;;=4^S72.044S
 ;;^UTILITY(U,$J,358.3,24587,2)
 ;;=^5037376
 ;;^UTILITY(U,$J,358.3,24588,0)
 ;;=S72.061S^^76^1007^9
 ;;^UTILITY(U,$J,358.3,24588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24588,1,3,0)
 ;;=3^Displaced articular fx of head of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24588,1,4,0)
 ;;=4^S72.061S
 ;;^UTILITY(U,$J,358.3,24588,2)
 ;;=^5037461
 ;;^UTILITY(U,$J,358.3,24589,0)
 ;;=S72.062S^^76^1007^8
 ;;^UTILITY(U,$J,358.3,24589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24589,1,3,0)
 ;;=3^Displaced articular fx of head of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24589,1,4,0)
 ;;=4^S72.062S
 ;;^UTILITY(U,$J,358.3,24589,2)
 ;;=^5037477
 ;;^UTILITY(U,$J,358.3,24590,0)
 ;;=S72.064S^^76^1007^57
 ;;^UTILITY(U,$J,358.3,24590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24590,1,3,0)
 ;;=3^Nondisp articular fx of head of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24590,1,4,0)
 ;;=4^S72.064S
 ;;^UTILITY(U,$J,358.3,24590,2)
 ;;=^5037509
 ;;^UTILITY(U,$J,358.3,24591,0)
 ;;=S72.065S^^76^1007^56
 ;;^UTILITY(U,$J,358.3,24591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24591,1,3,0)
 ;;=3^Nondisp articular fx of head of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24591,1,4,0)
 ;;=4^S72.065S
 ;;^UTILITY(U,$J,358.3,24591,2)
 ;;=^5037525
 ;;^UTILITY(U,$J,358.3,24592,0)
 ;;=S72.111S^^76^1007^19
 ;;^UTILITY(U,$J,358.3,24592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24592,1,3,0)
 ;;=3^Displaced greater trochanter fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24592,1,4,0)
 ;;=4^S72.111S
 ;;^UTILITY(U,$J,358.3,24592,2)
 ;;=^5037642
 ;;^UTILITY(U,$J,358.3,24593,0)
 ;;=S72.112S^^76^1007^18
 ;;^UTILITY(U,$J,358.3,24593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24593,1,3,0)
 ;;=3^Displaced greater trochanter fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24593,1,4,0)
 ;;=4^S72.112S
 ;;^UTILITY(U,$J,358.3,24593,2)
 ;;=^5037658
 ;;^UTILITY(U,$J,358.3,24594,0)
 ;;=S72.114S^^76^1007^67
 ;;^UTILITY(U,$J,358.3,24594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24594,1,3,0)
 ;;=3^Nondisp greater trochanter fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24594,1,4,0)
 ;;=4^S72.114S
 ;;^UTILITY(U,$J,358.3,24594,2)
 ;;=^5037690
 ;;^UTILITY(U,$J,358.3,24595,0)
 ;;=S72.115S^^76^1007^66
 ;;^UTILITY(U,$J,358.3,24595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24595,1,3,0)
 ;;=3^Nondisp greater trochanter fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24595,1,4,0)
 ;;=4^S72.115S
 ;;^UTILITY(U,$J,358.3,24595,2)
 ;;=^5037706
 ;;^UTILITY(U,$J,358.3,24596,0)
 ;;=S72.121S^^76^1007^25
 ;;^UTILITY(U,$J,358.3,24596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24596,1,3,0)
 ;;=3^Displaced lesser trochanter fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24596,1,4,0)
 ;;=4^S72.121S
 ;;^UTILITY(U,$J,358.3,24596,2)
 ;;=^5037738
 ;;^UTILITY(U,$J,358.3,24597,0)
 ;;=S72.122S^^76^1007^24
 ;;^UTILITY(U,$J,358.3,24597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24597,1,3,0)
 ;;=3^Displaced lesser trochanter fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24597,1,4,0)
 ;;=4^S72.122S
 ;;^UTILITY(U,$J,358.3,24597,2)
 ;;=^5037754
 ;;^UTILITY(U,$J,358.3,24598,0)
 ;;=S72.124S^^76^1007^73
 ;;^UTILITY(U,$J,358.3,24598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24598,1,3,0)
 ;;=3^Nondisp lesser trochanter fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24598,1,4,0)
 ;;=4^S72.124S
 ;;^UTILITY(U,$J,358.3,24598,2)
 ;;=^5037786
 ;;^UTILITY(U,$J,358.3,24599,0)
 ;;=S72.125S^^76^1007^72
 ;;^UTILITY(U,$J,358.3,24599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24599,1,3,0)
 ;;=3^Nondisp lesser trochanter fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24599,1,4,0)
 ;;=4^S72.125S
 ;;^UTILITY(U,$J,358.3,24599,2)
 ;;=^5037802
 ;;^UTILITY(U,$J,358.3,24600,0)
 ;;=S72.131S^^76^1007^7
 ;;^UTILITY(U,$J,358.3,24600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24600,1,3,0)
 ;;=3^Displaced apophyseal fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24600,1,4,0)
 ;;=4^S72.131S
 ;;^UTILITY(U,$J,358.3,24600,2)
 ;;=^5037834
 ;;^UTILITY(U,$J,358.3,24601,0)
 ;;=S72.132S^^76^1007^6
 ;;^UTILITY(U,$J,358.3,24601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24601,1,3,0)
 ;;=3^Displaced apophyseal fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24601,1,4,0)
 ;;=4^S72.132S
 ;;^UTILITY(U,$J,358.3,24601,2)
 ;;=^5037850
 ;;^UTILITY(U,$J,358.3,24602,0)
 ;;=S72.134S^^76^1007^55
 ;;^UTILITY(U,$J,358.3,24602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24602,1,3,0)
 ;;=3^Nondisp apophyseal fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24602,1,4,0)
 ;;=4^S72.134S
 ;;^UTILITY(U,$J,358.3,24602,2)
 ;;=^5037882
 ;;^UTILITY(U,$J,358.3,24603,0)
 ;;=S72.135S^^76^1007^54
 ;;^UTILITY(U,$J,358.3,24603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24603,1,3,0)
 ;;=3^Nondisp apophyseal fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24603,1,4,0)
 ;;=4^S72.135S
 ;;^UTILITY(U,$J,358.3,24603,2)
 ;;=^5037898
 ;;^UTILITY(U,$J,358.3,24604,0)
 ;;=S72.141S^^76^1007^21
 ;;^UTILITY(U,$J,358.3,24604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24604,1,3,0)
 ;;=3^Displaced intertrochanteric fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24604,1,4,0)
 ;;=4^S72.141S
 ;;^UTILITY(U,$J,358.3,24604,2)
 ;;=^5037930
 ;;^UTILITY(U,$J,358.3,24605,0)
 ;;=S72.142S^^76^1007^20
 ;;^UTILITY(U,$J,358.3,24605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24605,1,3,0)
 ;;=3^Displaced intertrochanteric fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24605,1,4,0)
 ;;=4^S72.142S
 ;;^UTILITY(U,$J,358.3,24605,2)
 ;;=^5037946
 ;;^UTILITY(U,$J,358.3,24606,0)
 ;;=S72.144S^^76^1007^69
 ;;^UTILITY(U,$J,358.3,24606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24606,1,3,0)
 ;;=3^Nondisp intertroch fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24606,1,4,0)
 ;;=4^S72.144S
 ;;^UTILITY(U,$J,358.3,24606,2)
 ;;=^5037978
 ;;^UTILITY(U,$J,358.3,24607,0)
 ;;=S72.145S^^76^1007^68
 ;;^UTILITY(U,$J,358.3,24607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24607,1,3,0)
 ;;=3^Nondisp intertroch fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24607,1,4,0)
 ;;=4^S72.145S
 ;;^UTILITY(U,$J,358.3,24607,2)
 ;;=^5037994
 ;;^UTILITY(U,$J,358.3,24608,0)
 ;;=S72.21XS^^76^1007^43
 ;;^UTILITY(U,$J,358.3,24608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24608,1,3,0)
 ;;=3^Displaced subtrochanteric fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24608,1,4,0)
 ;;=4^S72.21XS
 ;;^UTILITY(U,$J,358.3,24608,2)
 ;;=^5038026
 ;;^UTILITY(U,$J,358.3,24609,0)
 ;;=S72.22XS^^76^1007^42
 ;;^UTILITY(U,$J,358.3,24609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24609,1,3,0)
 ;;=3^Displaced subtrochanteric fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24609,1,4,0)
 ;;=4^S72.22XS
 ;;^UTILITY(U,$J,358.3,24609,2)
 ;;=^5038042
 ;;^UTILITY(U,$J,358.3,24610,0)
 ;;=S72.24XS^^76^1007^92
 ;;^UTILITY(U,$J,358.3,24610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24610,1,3,0)
 ;;=3^Nondisp subtrochanteric fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24610,1,4,0)
 ;;=4^S72.24XS
 ;;^UTILITY(U,$J,358.3,24610,2)
 ;;=^5038074
 ;;^UTILITY(U,$J,358.3,24611,0)
 ;;=S72.25XS^^76^1007^91
 ;;^UTILITY(U,$J,358.3,24611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24611,1,3,0)
 ;;=3^Nondisp subtrochanteric fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24611,1,4,0)
 ;;=4^S72.25XS
 ;;^UTILITY(U,$J,358.3,24611,2)
 ;;=^5038090
 ;;^UTILITY(U,$J,358.3,24612,0)
 ;;=S72.321S^^76^1007^51
 ;;^UTILITY(U,$J,358.3,24612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24612,1,3,0)
 ;;=3^Displaced transverse fx shaft of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24612,1,4,0)
 ;;=4^S72.321S
 ;;^UTILITY(U,$J,358.3,24612,2)
 ;;=^5038159
 ;;^UTILITY(U,$J,358.3,24613,0)
 ;;=S72.322S^^76^1007^50
 ;;^UTILITY(U,$J,358.3,24613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24613,1,3,0)
 ;;=3^Displaced transverse fx shaft of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24613,1,4,0)
 ;;=4^S72.322S
 ;;^UTILITY(U,$J,358.3,24613,2)
 ;;=^5038175
 ;;^UTILITY(U,$J,358.3,24614,0)
 ;;=S72.324S^^76^1007^100
 ;;^UTILITY(U,$J,358.3,24614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24614,1,3,0)
 ;;=3^Nondisp transverse fx shaft of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24614,1,4,0)
 ;;=4^S72.324S
 ;;^UTILITY(U,$J,358.3,24614,2)
 ;;=^5038207
 ;;^UTILITY(U,$J,358.3,24615,0)
 ;;=S72.325S^^76^1007^99
 ;;^UTILITY(U,$J,358.3,24615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24615,1,3,0)
 ;;=3^Nondisp transverse fx shaft of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24615,1,4,0)
 ;;=4^S72.325S
 ;;^UTILITY(U,$J,358.3,24615,2)
 ;;=^5038223
 ;;^UTILITY(U,$J,358.3,24616,0)
 ;;=S72.331S^^76^1007^35
 ;;^UTILITY(U,$J,358.3,24616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24616,1,3,0)
 ;;=3^Displaced oblique fx of shaft of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24616,1,4,0)
 ;;=4^S72.331S
 ;;^UTILITY(U,$J,358.3,24616,2)
 ;;=^5038255
 ;;^UTILITY(U,$J,358.3,24617,0)
 ;;=S72.332S^^76^1007^34
 ;;^UTILITY(U,$J,358.3,24617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24617,1,3,0)
 ;;=3^Displaced oblique fx of shaft of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24617,1,4,0)
 ;;=4^S72.332S
 ;;^UTILITY(U,$J,358.3,24617,2)
 ;;=^5038271
 ;;^UTILITY(U,$J,358.3,24618,0)
 ;;=S72.334S^^76^1007^83
 ;;^UTILITY(U,$J,358.3,24618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24618,1,3,0)
 ;;=3^Nondisp oblique fx shaft of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24618,1,4,0)
 ;;=4^S72.334S
 ;;^UTILITY(U,$J,358.3,24618,2)
 ;;=^5038303
 ;;^UTILITY(U,$J,358.3,24619,0)
 ;;=S72.335S^^76^1007^82
 ;;^UTILITY(U,$J,358.3,24619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24619,1,3,0)
 ;;=3^Nondisp oblique fx shaft of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24619,1,4,0)
 ;;=4^S72.335S
 ;;^UTILITY(U,$J,358.3,24619,2)
 ;;=^5038319
 ;;^UTILITY(U,$J,358.3,24620,0)
 ;;=S72.341S^^76^1007^41
 ;;^UTILITY(U,$J,358.3,24620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24620,1,3,0)
 ;;=3^Displaced spiral fx of shaft of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24620,1,4,0)
 ;;=4^S72.341S
 ;;^UTILITY(U,$J,358.3,24620,2)
 ;;=^5038351
 ;;^UTILITY(U,$J,358.3,24621,0)
 ;;=S72.342S^^76^1007^40
 ;;^UTILITY(U,$J,358.3,24621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24621,1,3,0)
 ;;=3^Displaced spiral fx of shaft of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24621,1,4,0)
 ;;=4^S72.342S
 ;;^UTILITY(U,$J,358.3,24621,2)
 ;;=^5038367
 ;;^UTILITY(U,$J,358.3,24622,0)
 ;;=S72.344S^^76^1007^90
 ;;^UTILITY(U,$J,358.3,24622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24622,1,3,0)
 ;;=3^Nondisp spiral fx shaft of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24622,1,4,0)
 ;;=4^S72.344S
 ;;^UTILITY(U,$J,358.3,24622,2)
 ;;=^5038399
 ;;^UTILITY(U,$J,358.3,24623,0)
 ;;=S72.345S^^76^1007^88
 ;;^UTILITY(U,$J,358.3,24623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24623,1,3,0)
 ;;=3^Nondisp spiral fx of shaft of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24623,1,4,0)
 ;;=4^S72.345S
 ;;^UTILITY(U,$J,358.3,24623,2)
 ;;=^5038415
 ;;^UTILITY(U,$J,358.3,24624,0)
 ;;=S72.351S^^76^1007^15
 ;;^UTILITY(U,$J,358.3,24624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24624,1,3,0)
 ;;=3^Displaced comminuted fx shaft of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24624,1,4,0)
 ;;=4^S72.351S
 ;;^UTILITY(U,$J,358.3,24624,2)
 ;;=^5038447
 ;;^UTILITY(U,$J,358.3,24625,0)
 ;;=S72.352S^^76^1007^14
 ;;^UTILITY(U,$J,358.3,24625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24625,1,3,0)
 ;;=3^Displaced comminuted fx shaft of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24625,1,4,0)
 ;;=4^S72.352S
 ;;^UTILITY(U,$J,358.3,24625,2)
 ;;=^5038463
 ;;^UTILITY(U,$J,358.3,24626,0)
 ;;=S72.354S^^76^1007^63
 ;;^UTILITY(U,$J,358.3,24626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24626,1,3,0)
 ;;=3^Nondisp comminuted fx of shaft of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24626,1,4,0)
 ;;=4^S72.354S
 ;;^UTILITY(U,$J,358.3,24626,2)
 ;;=^5038495
 ;;^UTILITY(U,$J,358.3,24627,0)
 ;;=S72.355S^^76^1007^62
 ;;^UTILITY(U,$J,358.3,24627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24627,1,3,0)
 ;;=3^Nondisp comminuted fx of shaft of left femur, sequela
 ;;^UTILITY(U,$J,358.3,24627,1,4,0)
 ;;=4^S72.355S
 ;;^UTILITY(U,$J,358.3,24627,2)
 ;;=^5038511
 ;;^UTILITY(U,$J,358.3,24628,0)
 ;;=S72.361S^^76^1007^39
 ;;^UTILITY(U,$J,358.3,24628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24628,1,3,0)
 ;;=3^Displaced segmental fx shaft of right femur, sequela
 ;;^UTILITY(U,$J,358.3,24628,1,4,0)
 ;;=4^S72.361S
