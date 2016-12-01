IBDEI0NM ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29960,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left ankle & foot
 ;;^UTILITY(U,$J,358.3,29960,1,4,0)
 ;;=4^M19.172
 ;;^UTILITY(U,$J,358.3,29960,2)
 ;;=^5010836
 ;;^UTILITY(U,$J,358.3,29961,0)
 ;;=S93.402D^^86^1295^41
 ;;^UTILITY(U,$J,358.3,29961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29961,1,3,0)
 ;;=3^Sprain of unspec ligament of left ankle, subs encntr
 ;;^UTILITY(U,$J,358.3,29961,1,4,0)
 ;;=4^S93.402D
 ;;^UTILITY(U,$J,358.3,29961,2)
 ;;=^5045778
 ;;^UTILITY(U,$J,358.3,29962,0)
 ;;=S93.401D^^86^1295^42
 ;;^UTILITY(U,$J,358.3,29962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29962,1,3,0)
 ;;=3^Sprain of unspec ligament of right ankle, subs encntr
 ;;^UTILITY(U,$J,358.3,29962,1,4,0)
 ;;=4^S93.401D
 ;;^UTILITY(U,$J,358.3,29962,2)
 ;;=^5045775
 ;;^UTILITY(U,$J,358.3,29963,0)
 ;;=M25.571^^86^1295^30
 ;;^UTILITY(U,$J,358.3,29963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29963,1,3,0)
 ;;=3^Pain in right ankle & joints of right foot
 ;;^UTILITY(U,$J,358.3,29963,1,4,0)
 ;;=4^M25.571
 ;;^UTILITY(U,$J,358.3,29963,2)
 ;;=^5011617
 ;;^UTILITY(U,$J,358.3,29964,0)
 ;;=G56.22^^86^1296^23
 ;;^UTILITY(U,$J,358.3,29964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29964,1,3,0)
 ;;=3^Lesion of ulnar nerve, left upper limb
 ;;^UTILITY(U,$J,358.3,29964,1,4,0)
 ;;=4^G56.22
 ;;^UTILITY(U,$J,358.3,29964,2)
 ;;=^5004025
 ;;^UTILITY(U,$J,358.3,29965,0)
 ;;=G56.21^^86^1296^24
 ;;^UTILITY(U,$J,358.3,29965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29965,1,3,0)
 ;;=3^Lesion of ulnar nerve, right upper limb
 ;;^UTILITY(U,$J,358.3,29965,1,4,0)
 ;;=4^G56.21
 ;;^UTILITY(U,$J,358.3,29965,2)
 ;;=^5004024
 ;;^UTILITY(U,$J,358.3,29966,0)
 ;;=M00.822^^86^1296^1
 ;;^UTILITY(U,$J,358.3,29966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29966,1,3,0)
 ;;=3^Arthritis due to other bacteria, left elbow
 ;;^UTILITY(U,$J,358.3,29966,1,4,0)
 ;;=4^M00.822
 ;;^UTILITY(U,$J,358.3,29966,2)
 ;;=^5009674
 ;;^UTILITY(U,$J,358.3,29967,0)
 ;;=M00.821^^86^1296^2
 ;;^UTILITY(U,$J,358.3,29967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29967,1,3,0)
 ;;=3^Arthritis due to other bacteria, right elbow
 ;;^UTILITY(U,$J,358.3,29967,1,4,0)
 ;;=4^M00.821
 ;;^UTILITY(U,$J,358.3,29967,2)
 ;;=^5009673
 ;;^UTILITY(U,$J,358.3,29968,0)
 ;;=M24.522^^86^1296^3
 ;;^UTILITY(U,$J,358.3,29968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29968,1,3,0)
 ;;=3^Contracture, left elbow
 ;;^UTILITY(U,$J,358.3,29968,1,4,0)
 ;;=4^M24.522
 ;;^UTILITY(U,$J,358.3,29968,2)
 ;;=^5011406
 ;;^UTILITY(U,$J,358.3,29969,0)
 ;;=M24.521^^86^1296^4
 ;;^UTILITY(U,$J,358.3,29969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29969,1,3,0)
 ;;=3^Contracture, right elbow
 ;;^UTILITY(U,$J,358.3,29969,1,4,0)
 ;;=4^M24.521
 ;;^UTILITY(U,$J,358.3,29969,2)
 ;;=^5011405
 ;;^UTILITY(U,$J,358.3,29970,0)
 ;;=S50.02XA^^86^1296^5
 ;;^UTILITY(U,$J,358.3,29970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29970,1,3,0)
 ;;=3^Contusion of left elbow, initial encounter
 ;;^UTILITY(U,$J,358.3,29970,1,4,0)
 ;;=4^S50.02XA
 ;;^UTILITY(U,$J,358.3,29970,2)
 ;;=^5028488
 ;;^UTILITY(U,$J,358.3,29971,0)
 ;;=S50.01XA^^86^1296^7
 ;;^UTILITY(U,$J,358.3,29971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29971,1,3,0)
 ;;=3^Contusion of right elbow, initial encounter
 ;;^UTILITY(U,$J,358.3,29971,1,4,0)
 ;;=4^S50.01XA
 ;;^UTILITY(U,$J,358.3,29971,2)
 ;;=^5028485
 ;;^UTILITY(U,$J,358.3,29972,0)
 ;;=S52.122A^^86^1296^9
 ;;^UTILITY(U,$J,358.3,29972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29972,1,3,0)
 ;;=3^Disp fx of head of left radius, init for clos fx
 ;;^UTILITY(U,$J,358.3,29972,1,4,0)
 ;;=4^S52.122A
 ;;^UTILITY(U,$J,358.3,29972,2)
 ;;=^5029063
 ;;^UTILITY(U,$J,358.3,29973,0)
 ;;=S52.121A^^86^1296^11
 ;;^UTILITY(U,$J,358.3,29973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29973,1,3,0)
 ;;=3^Disp fx of head of right radius, init for clos fx
 ;;^UTILITY(U,$J,358.3,29973,1,4,0)
 ;;=4^S52.121A
 ;;^UTILITY(U,$J,358.3,29973,2)
 ;;=^5029047
 ;;^UTILITY(U,$J,358.3,29974,0)
 ;;=S52.032A^^86^1296^13
 ;;^UTILITY(U,$J,358.3,29974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29974,1,3,0)
 ;;=3^Disp fx of olecran pro w intartic extn left ulna, init
 ;;^UTILITY(U,$J,358.3,29974,1,4,0)
 ;;=4^S52.032A
 ;;^UTILITY(U,$J,358.3,29974,2)
 ;;=^5135098
 ;;^UTILITY(U,$J,358.3,29975,0)
 ;;=S52.031A^^86^1296^14
 ;;^UTILITY(U,$J,358.3,29975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29975,1,3,0)
 ;;=3^Disp fx of olecran pro w intartic extn right ulna, init
 ;;^UTILITY(U,$J,358.3,29975,1,4,0)
 ;;=4^S52.031A
 ;;^UTILITY(U,$J,358.3,29975,2)
 ;;=^5028849
 ;;^UTILITY(U,$J,358.3,29976,0)
 ;;=M77.12^^86^1296^21
 ;;^UTILITY(U,$J,358.3,29976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29976,1,3,0)
 ;;=3^Lateral epicondylitis, left elbow
 ;;^UTILITY(U,$J,358.3,29976,1,4,0)
 ;;=4^M77.12
 ;;^UTILITY(U,$J,358.3,29976,2)
 ;;=^5013305
 ;;^UTILITY(U,$J,358.3,29977,0)
 ;;=M77.11^^86^1296^22
 ;;^UTILITY(U,$J,358.3,29977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29977,1,3,0)
 ;;=3^Lateral epicondylitis, right elbow
 ;;^UTILITY(U,$J,358.3,29977,1,4,0)
 ;;=4^M77.11
 ;;^UTILITY(U,$J,358.3,29977,2)
 ;;=^5013304
 ;;^UTILITY(U,$J,358.3,29978,0)
 ;;=M24.022^^86^1296^25
 ;;^UTILITY(U,$J,358.3,29978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29978,1,3,0)
 ;;=3^Loose body in left elbow
 ;;^UTILITY(U,$J,358.3,29978,1,4,0)
 ;;=4^M24.022
 ;;^UTILITY(U,$J,358.3,29978,2)
 ;;=^5011282
 ;;^UTILITY(U,$J,358.3,29979,0)
 ;;=M24.021^^86^1296^26
 ;;^UTILITY(U,$J,358.3,29979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29979,1,3,0)
 ;;=3^Loose body in right elbow
 ;;^UTILITY(U,$J,358.3,29979,1,4,0)
 ;;=4^M24.021
 ;;^UTILITY(U,$J,358.3,29979,2)
 ;;=^5011281
 ;;^UTILITY(U,$J,358.3,29980,0)
 ;;=M77.02^^86^1296^27
 ;;^UTILITY(U,$J,358.3,29980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29980,1,3,0)
 ;;=3^Medial epicondylitis, left elbow
 ;;^UTILITY(U,$J,358.3,29980,1,4,0)
 ;;=4^M77.02
 ;;^UTILITY(U,$J,358.3,29980,2)
 ;;=^5013302
 ;;^UTILITY(U,$J,358.3,29981,0)
 ;;=M77.01^^86^1296^28
 ;;^UTILITY(U,$J,358.3,29981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29981,1,3,0)
 ;;=3^Medial epicondylitis, right elbow
 ;;^UTILITY(U,$J,358.3,29981,1,4,0)
 ;;=4^M77.01
 ;;^UTILITY(U,$J,358.3,29981,2)
 ;;=^5013301
 ;;^UTILITY(U,$J,358.3,29982,0)
 ;;=S52.125A^^86^1296^29
 ;;^UTILITY(U,$J,358.3,29982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29982,1,3,0)
 ;;=3^Nondisp fx of head of left radius, init for clos fx
 ;;^UTILITY(U,$J,358.3,29982,1,4,0)
 ;;=4^S52.125A
 ;;^UTILITY(U,$J,358.3,29982,2)
 ;;=^5029111
 ;;^UTILITY(U,$J,358.3,29983,0)
 ;;=S52.124A^^86^1296^31
 ;;^UTILITY(U,$J,358.3,29983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29983,1,3,0)
 ;;=3^Nondisp fx of head of right radius, init for clos fx
 ;;^UTILITY(U,$J,358.3,29983,1,4,0)
 ;;=4^S52.124A
 ;;^UTILITY(U,$J,358.3,29983,2)
 ;;=^5029095
 ;;^UTILITY(U,$J,358.3,29984,0)
 ;;=M70.22^^86^1296^33
 ;;^UTILITY(U,$J,358.3,29984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29984,1,3,0)
 ;;=3^Olecranon bursitis, left elbow
 ;;^UTILITY(U,$J,358.3,29984,1,4,0)
 ;;=4^M70.22
 ;;^UTILITY(U,$J,358.3,29984,2)
 ;;=^5013048
 ;;^UTILITY(U,$J,358.3,29985,0)
 ;;=M70.21^^86^1296^34
 ;;^UTILITY(U,$J,358.3,29985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29985,1,3,0)
 ;;=3^Olecranon bursitis, right elbow
 ;;^UTILITY(U,$J,358.3,29985,1,4,0)
 ;;=4^M70.21
 ;;^UTILITY(U,$J,358.3,29985,2)
 ;;=^5013047
 ;;^UTILITY(U,$J,358.3,29986,0)
 ;;=M25.522^^86^1296^35
 ;;^UTILITY(U,$J,358.3,29986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29986,1,3,0)
 ;;=3^Pain in left elbow
 ;;^UTILITY(U,$J,358.3,29986,1,4,0)
 ;;=4^M25.522
 ;;^UTILITY(U,$J,358.3,29986,2)
 ;;=^5011606
 ;;^UTILITY(U,$J,358.3,29987,0)
 ;;=M25.521^^86^1296^36
 ;;^UTILITY(U,$J,358.3,29987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29987,1,3,0)
 ;;=3^Pain in right elbow
 ;;^UTILITY(U,$J,358.3,29987,1,4,0)
 ;;=4^M25.521
 ;;^UTILITY(U,$J,358.3,29987,2)
 ;;=^5011605
 ;;^UTILITY(U,$J,358.3,29988,0)
 ;;=M19.022^^86^1296^39
 ;;^UTILITY(U,$J,358.3,29988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29988,1,3,0)
 ;;=3^Primary osteoarthritis, left elbow
 ;;^UTILITY(U,$J,358.3,29988,1,4,0)
 ;;=4^M19.022
 ;;^UTILITY(U,$J,358.3,29988,2)
 ;;=^5010812
 ;;^UTILITY(U,$J,358.3,29989,0)
 ;;=M19.021^^86^1296^40
 ;;^UTILITY(U,$J,358.3,29989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29989,1,3,0)
 ;;=3^Primary osteoarthritis, right elbow
 ;;^UTILITY(U,$J,358.3,29989,1,4,0)
 ;;=4^M19.021
 ;;^UTILITY(U,$J,358.3,29989,2)
 ;;=^5010811
 ;;^UTILITY(U,$J,358.3,29990,0)
 ;;=M12.522^^86^1296^45
 ;;^UTILITY(U,$J,358.3,29990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29990,1,3,0)
 ;;=3^Traumatic arthropathy, left elbow
 ;;^UTILITY(U,$J,358.3,29990,1,4,0)
 ;;=4^M12.522
 ;;^UTILITY(U,$J,358.3,29990,2)
 ;;=^5010623
 ;;^UTILITY(U,$J,358.3,29991,0)
 ;;=M12.521^^86^1296^46
 ;;^UTILITY(U,$J,358.3,29991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29991,1,3,0)
 ;;=3^Traumatic arthropathy, right elbow
 ;;^UTILITY(U,$J,358.3,29991,1,4,0)
 ;;=4^M12.521
 ;;^UTILITY(U,$J,358.3,29991,2)
 ;;=^5010622
 ;;^UTILITY(U,$J,358.3,29992,0)
 ;;=S42.402A^^86^1296^19
 ;;^UTILITY(U,$J,358.3,29992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29992,1,3,0)
 ;;=3^Fracture of lower end of left humerus, init for clos fx,Unspec
 ;;^UTILITY(U,$J,358.3,29992,1,4,0)
 ;;=4^S42.402A
 ;;^UTILITY(U,$J,358.3,29992,2)
 ;;=^5134713
 ;;^UTILITY(U,$J,358.3,29993,0)
 ;;=S42.401A^^86^1296^20
 ;;^UTILITY(U,$J,358.3,29993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29993,1,3,0)
 ;;=3^Fracture of lower end of right humerus, init,Unspec
 ;;^UTILITY(U,$J,358.3,29993,1,4,0)
 ;;=4^S42.401A
 ;;^UTILITY(U,$J,358.3,29993,2)
 ;;=^5027294
 ;;^UTILITY(U,$J,358.3,29994,0)
 ;;=S53.402A^^86^1296^41
 ;;^UTILITY(U,$J,358.3,29994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29994,1,3,0)
 ;;=3^Sprain of left elbow, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,29994,1,4,0)
 ;;=4^S53.402A
