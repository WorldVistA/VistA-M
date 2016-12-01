IBDEI0NZ ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30401,0)
 ;;=S82.425A^^86^1307^17
 ;;^UTILITY(U,$J,358.3,30401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30401,1,3,0)
 ;;=3^Nondisp transverse fracture of shaft of left fibula, init
 ;;^UTILITY(U,$J,358.3,30401,1,4,0)
 ;;=4^S82.425A
 ;;^UTILITY(U,$J,358.3,30401,2)
 ;;=^5041778
 ;;^UTILITY(U,$J,358.3,30402,0)
 ;;=S82.424A^^86^1307^18
 ;;^UTILITY(U,$J,358.3,30402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30402,1,3,0)
 ;;=3^Nondisp transverse fracture of shaft of right fibula, init
 ;;^UTILITY(U,$J,358.3,30402,1,4,0)
 ;;=4^S82.424A
 ;;^UTILITY(U,$J,358.3,30402,2)
 ;;=^5041762
 ;;^UTILITY(U,$J,358.3,30403,0)
 ;;=S82.292A^^86^1307^9
 ;;^UTILITY(U,$J,358.3,30403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30403,1,3,0)
 ;;=3^Fracture of shaft of left tibia, init for clos fx NEC
 ;;^UTILITY(U,$J,358.3,30403,1,4,0)
 ;;=4^S82.292A
 ;;^UTILITY(U,$J,358.3,30403,2)
 ;;=^5136798
 ;;^UTILITY(U,$J,358.3,30404,0)
 ;;=S82.291A^^86^1307^10
 ;;^UTILITY(U,$J,358.3,30404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30404,1,3,0)
 ;;=3^Fracture of shaft of right tibia, init for clos fx NEC
 ;;^UTILITY(U,$J,358.3,30404,1,4,0)
 ;;=4^S82.291A
 ;;^UTILITY(U,$J,358.3,30404,2)
 ;;=^5041619
 ;;^UTILITY(U,$J,358.3,30405,0)
 ;;=M79.672^^86^1307^21
 ;;^UTILITY(U,$J,358.3,30405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30405,1,3,0)
 ;;=3^Pain in left foot
 ;;^UTILITY(U,$J,358.3,30405,1,4,0)
 ;;=4^M79.672
 ;;^UTILITY(U,$J,358.3,30405,2)
 ;;=^5013351
 ;;^UTILITY(U,$J,358.3,30406,0)
 ;;=M79.605^^86^1307^22
 ;;^UTILITY(U,$J,358.3,30406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30406,1,3,0)
 ;;=3^Pain in left leg
 ;;^UTILITY(U,$J,358.3,30406,1,4,0)
 ;;=4^M79.605
 ;;^UTILITY(U,$J,358.3,30406,2)
 ;;=^5013329
 ;;^UTILITY(U,$J,358.3,30407,0)
 ;;=M79.662^^86^1307^23
 ;;^UTILITY(U,$J,358.3,30407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30407,1,3,0)
 ;;=3^Pain in left lower leg
 ;;^UTILITY(U,$J,358.3,30407,1,4,0)
 ;;=4^M79.662
 ;;^UTILITY(U,$J,358.3,30407,2)
 ;;=^5013348
 ;;^UTILITY(U,$J,358.3,30408,0)
 ;;=M79.652^^86^1307^24
 ;;^UTILITY(U,$J,358.3,30408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30408,1,3,0)
 ;;=3^Pain in left thigh
 ;;^UTILITY(U,$J,358.3,30408,1,4,0)
 ;;=4^M79.652
 ;;^UTILITY(U,$J,358.3,30408,2)
 ;;=^5013345
 ;;^UTILITY(U,$J,358.3,30409,0)
 ;;=M79.675^^86^1307^25
 ;;^UTILITY(U,$J,358.3,30409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30409,1,3,0)
 ;;=3^Pain in left toe(s)
 ;;^UTILITY(U,$J,358.3,30409,1,4,0)
 ;;=4^M79.675
 ;;^UTILITY(U,$J,358.3,30409,2)
 ;;=^5013354
 ;;^UTILITY(U,$J,358.3,30410,0)
 ;;=M79.671^^86^1307^26
 ;;^UTILITY(U,$J,358.3,30410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30410,1,3,0)
 ;;=3^Pain in right foot
 ;;^UTILITY(U,$J,358.3,30410,1,4,0)
 ;;=4^M79.671
 ;;^UTILITY(U,$J,358.3,30410,2)
 ;;=^5013350
 ;;^UTILITY(U,$J,358.3,30411,0)
 ;;=M79.604^^86^1307^27
 ;;^UTILITY(U,$J,358.3,30411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30411,1,3,0)
 ;;=3^Pain in right leg
 ;;^UTILITY(U,$J,358.3,30411,1,4,0)
 ;;=4^M79.604
 ;;^UTILITY(U,$J,358.3,30411,2)
 ;;=^5013328
 ;;^UTILITY(U,$J,358.3,30412,0)
 ;;=M79.661^^86^1307^28
 ;;^UTILITY(U,$J,358.3,30412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30412,1,3,0)
 ;;=3^Pain in right lower leg
 ;;^UTILITY(U,$J,358.3,30412,1,4,0)
 ;;=4^M79.661
 ;;^UTILITY(U,$J,358.3,30412,2)
 ;;=^5013347
 ;;^UTILITY(U,$J,358.3,30413,0)
 ;;=M79.651^^86^1307^29
 ;;^UTILITY(U,$J,358.3,30413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30413,1,3,0)
 ;;=3^Pain in right thigh
 ;;^UTILITY(U,$J,358.3,30413,1,4,0)
 ;;=4^M79.651
 ;;^UTILITY(U,$J,358.3,30413,2)
 ;;=^5013344
 ;;^UTILITY(U,$J,358.3,30414,0)
 ;;=M79.674^^86^1307^30
 ;;^UTILITY(U,$J,358.3,30414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30414,1,3,0)
 ;;=3^Pain in right toe(s)
 ;;^UTILITY(U,$J,358.3,30414,1,4,0)
 ;;=4^M79.674
 ;;^UTILITY(U,$J,358.3,30414,2)
 ;;=^5013353
 ;;^UTILITY(U,$J,358.3,30415,0)
 ;;=M84.464A^^86^1307^31
 ;;^UTILITY(U,$J,358.3,30415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30415,1,3,0)
 ;;=3^Pathological fracture, left fibula, init encntr for fracture
 ;;^UTILITY(U,$J,358.3,30415,1,4,0)
 ;;=4^M84.464A
 ;;^UTILITY(U,$J,358.3,30415,2)
 ;;=^5013950
 ;;^UTILITY(U,$J,358.3,30416,0)
 ;;=M84.463A^^86^1307^35
 ;;^UTILITY(U,$J,358.3,30416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30416,1,3,0)
 ;;=3^Pathological fracture, right fibula, init for fx
 ;;^UTILITY(U,$J,358.3,30416,1,4,0)
 ;;=4^M84.463A
 ;;^UTILITY(U,$J,358.3,30416,2)
 ;;=^5013944
 ;;^UTILITY(U,$J,358.3,30417,0)
 ;;=M84.461A^^86^1307^37
 ;;^UTILITY(U,$J,358.3,30417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30417,1,3,0)
 ;;=3^Pathological fracture, right tibia, init encntr for fracture
 ;;^UTILITY(U,$J,358.3,30417,1,4,0)
 ;;=4^M84.461A
 ;;^UTILITY(U,$J,358.3,30417,2)
 ;;=^5013932
 ;;^UTILITY(U,$J,358.3,30418,0)
 ;;=T79.A22A^^86^1307^41
 ;;^UTILITY(U,$J,358.3,30418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30418,1,3,0)
 ;;=3^Traumatic compartment syndrome of left lower extremity, init
 ;;^UTILITY(U,$J,358.3,30418,1,4,0)
 ;;=4^T79.A22A
 ;;^UTILITY(U,$J,358.3,30418,2)
 ;;=^5137969
 ;;^UTILITY(U,$J,358.3,30419,0)
 ;;=T79.A21A^^86^1307^42
 ;;^UTILITY(U,$J,358.3,30419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30419,1,3,0)
 ;;=3^Traumatic compartment syndrome of r low extrem, init
 ;;^UTILITY(U,$J,358.3,30419,1,4,0)
 ;;=4^T79.A21A
 ;;^UTILITY(U,$J,358.3,30419,2)
 ;;=^5054335
 ;;^UTILITY(U,$J,358.3,30420,0)
 ;;=S82.102A^^86^1307^11
 ;;^UTILITY(U,$J,358.3,30420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30420,1,3,0)
 ;;=3^Fracture of upper end of left tibia, init for clos fx,Unspec
 ;;^UTILITY(U,$J,358.3,30420,1,4,0)
 ;;=4^S82.102A
 ;;^UTILITY(U,$J,358.3,30420,2)
 ;;=^5040562
 ;;^UTILITY(U,$J,358.3,30421,0)
 ;;=S82.101A^^86^1307^12
 ;;^UTILITY(U,$J,358.3,30421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30421,1,3,0)
 ;;=3^Fracture of upper end of right tibia, init for clos fx,Unspec
 ;;^UTILITY(U,$J,358.3,30421,1,4,0)
 ;;=4^S82.101A
 ;;^UTILITY(U,$J,358.3,30421,2)
 ;;=^5040546
 ;;^UTILITY(U,$J,358.3,30422,0)
 ;;=M80.072D^^86^1307^1
 ;;^UTILITY(U,$J,358.3,30422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30422,1,3,0)
 ;;=3^Age-rel osteopor w crnt path fx, l ank/ft, subs encntr
 ;;^UTILITY(U,$J,358.3,30422,1,4,0)
 ;;=4^M80.072D
 ;;^UTILITY(U,$J,358.3,30422,2)
 ;;=^5013484
 ;;^UTILITY(U,$J,358.3,30423,0)
 ;;=M80.071D^^86^1307^2
 ;;^UTILITY(U,$J,358.3,30423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30423,1,3,0)
 ;;=3^Age-rel osteopor w crnt path fx, r ank/ft, subs encntr
 ;;^UTILITY(U,$J,358.3,30423,1,4,0)
 ;;=4^M80.071D
 ;;^UTILITY(U,$J,358.3,30423,2)
 ;;=^5013478
 ;;^UTILITY(U,$J,358.3,30424,0)
 ;;=S80.12XD^^86^1307^6
 ;;^UTILITY(U,$J,358.3,30424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30424,1,3,0)
 ;;=3^Contusion of left lower leg, subsequent encounter
 ;;^UTILITY(U,$J,358.3,30424,1,4,0)
 ;;=4^S80.12XD
 ;;^UTILITY(U,$J,358.3,30424,2)
 ;;=^5039904
 ;;^UTILITY(U,$J,358.3,30425,0)
 ;;=S80.11XD^^86^1307^8
 ;;^UTILITY(U,$J,358.3,30425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30425,1,3,0)
 ;;=3^Contusion of right lower leg, subsequent encounter
 ;;^UTILITY(U,$J,358.3,30425,1,4,0)
 ;;=4^S80.11XD
 ;;^UTILITY(U,$J,358.3,30425,2)
 ;;=^5039901
 ;;^UTILITY(U,$J,358.3,30426,0)
 ;;=S82.292D^^86^1307^13
 ;;^UTILITY(U,$J,358.3,30426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30426,1,3,0)
 ;;=3^Fx shaft of left tibia, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,30426,1,4,0)
 ;;=4^S82.292D
 ;;^UTILITY(U,$J,358.3,30426,2)
 ;;=^5136803
 ;;^UTILITY(U,$J,358.3,30427,0)
 ;;=S82.291D^^86^1307^14
 ;;^UTILITY(U,$J,358.3,30427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30427,1,3,0)
 ;;=3^Fx shaft of right tibia, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,30427,1,4,0)
 ;;=4^S82.291D
 ;;^UTILITY(U,$J,358.3,30427,2)
 ;;=^5041622
 ;;^UTILITY(U,$J,358.3,30428,0)
 ;;=S82.102D^^86^1307^15
 ;;^UTILITY(U,$J,358.3,30428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30428,1,3,0)
 ;;=3^Fx upper end of l tibia, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,30428,1,4,0)
 ;;=4^S82.102D
 ;;^UTILITY(U,$J,358.3,30428,2)
 ;;=^5040565
 ;;^UTILITY(U,$J,358.3,30429,0)
 ;;=S82.101D^^86^1307^16
 ;;^UTILITY(U,$J,358.3,30429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30429,1,3,0)
 ;;=3^Fx upper end of r tibia, subs for clos fx w routn heal
 ;;^UTILITY(U,$J,358.3,30429,1,4,0)
 ;;=4^S82.101D
 ;;^UTILITY(U,$J,358.3,30429,2)
 ;;=^5040549
 ;;^UTILITY(U,$J,358.3,30430,0)
 ;;=S82.425D^^86^1307^19
 ;;^UTILITY(U,$J,358.3,30430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30430,1,3,0)
 ;;=3^Nondisp transverse fx shaft of l fibula, subs encntr
 ;;^UTILITY(U,$J,358.3,30430,1,4,0)
 ;;=4^S82.425D
 ;;^UTILITY(U,$J,358.3,30430,2)
 ;;=^5041781
 ;;^UTILITY(U,$J,358.3,30431,0)
 ;;=S82.424D^^86^1307^20
 ;;^UTILITY(U,$J,358.3,30431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30431,1,3,0)
 ;;=3^Nondisp transverse fx shaft of r fibula, subs encntr
 ;;^UTILITY(U,$J,358.3,30431,1,4,0)
 ;;=4^S82.424D
 ;;^UTILITY(U,$J,358.3,30431,2)
 ;;=^5041765
 ;;^UTILITY(U,$J,358.3,30432,0)
 ;;=M84.464D^^86^1307^32
 ;;^UTILITY(U,$J,358.3,30432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30432,1,3,0)
 ;;=3^Pathological fracture, left fibula, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,30432,1,4,0)
 ;;=4^M84.464D
 ;;^UTILITY(U,$J,358.3,30432,2)
 ;;=^5013951
 ;;^UTILITY(U,$J,358.3,30433,0)
 ;;=M84.461D^^86^1307^38
 ;;^UTILITY(U,$J,358.3,30433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30433,1,3,0)
 ;;=3^Pathological fracture, right tibia, subs for fx w routn heal
 ;;^UTILITY(U,$J,358.3,30433,1,4,0)
 ;;=4^M84.461D
 ;;^UTILITY(U,$J,358.3,30433,2)
 ;;=^5013933
 ;;^UTILITY(U,$J,358.3,30434,0)
 ;;=M84.462A^^86^1307^33
 ;;^UTILITY(U,$J,358.3,30434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30434,1,3,0)
 ;;=3^Pathological fracture, left tibia, init encntr for fracture
