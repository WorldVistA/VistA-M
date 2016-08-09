IBDEI0T8 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29429,1,3,0)
 ;;=3^Nondisp fx of head of right radius, subs encntr
 ;;^UTILITY(U,$J,358.3,29429,1,4,0)
 ;;=4^S52.124D
 ;;^UTILITY(U,$J,358.3,29429,2)
 ;;=^5029098
 ;;^UTILITY(U,$J,358.3,29430,0)
 ;;=M19.121^^111^1422^38
 ;;^UTILITY(U,$J,358.3,29430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29430,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, right elbow
 ;;^UTILITY(U,$J,358.3,29430,1,4,0)
 ;;=4^M19.121
 ;;^UTILITY(U,$J,358.3,29430,2)
 ;;=^5010826
 ;;^UTILITY(U,$J,358.3,29431,0)
 ;;=M19.122^^111^1422^37
 ;;^UTILITY(U,$J,358.3,29431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29431,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left elbow
 ;;^UTILITY(U,$J,358.3,29431,1,4,0)
 ;;=4^M19.122
 ;;^UTILITY(U,$J,358.3,29431,2)
 ;;=^5010827
 ;;^UTILITY(U,$J,358.3,29432,0)
 ;;=S53.402D^^111^1422^42
 ;;^UTILITY(U,$J,358.3,29432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29432,1,3,0)
 ;;=3^Sprain of left elbow, subsequent encounter
 ;;^UTILITY(U,$J,358.3,29432,1,4,0)
 ;;=4^S53.402D
 ;;^UTILITY(U,$J,358.3,29432,2)
 ;;=^5031365
 ;;^UTILITY(U,$J,358.3,29433,0)
 ;;=S53.401D^^111^1422^44
 ;;^UTILITY(U,$J,358.3,29433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29433,1,3,0)
 ;;=3^Sprain of right elbow, subsequent encounter
 ;;^UTILITY(U,$J,358.3,29433,1,4,0)
 ;;=4^S53.401D
 ;;^UTILITY(U,$J,358.3,29433,2)
 ;;=^5031362
 ;;^UTILITY(U,$J,358.3,29434,0)
 ;;=S70.12XA^^111^1423^1
 ;;^UTILITY(U,$J,358.3,29434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29434,1,3,0)
 ;;=3^Contusion of left thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,29434,1,4,0)
 ;;=4^S70.12XA
 ;;^UTILITY(U,$J,358.3,29434,2)
 ;;=^5036846
 ;;^UTILITY(U,$J,358.3,29435,0)
 ;;=S70.11XA^^111^1423^3
 ;;^UTILITY(U,$J,358.3,29435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29435,1,3,0)
 ;;=3^Contusion of right thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,29435,1,4,0)
 ;;=4^S70.11XA
 ;;^UTILITY(U,$J,358.3,29435,2)
 ;;=^5036843
 ;;^UTILITY(U,$J,358.3,29436,0)
 ;;=S72.352A^^111^1423^5
 ;;^UTILITY(U,$J,358.3,29436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29436,1,3,0)
 ;;=3^Displ comminuted fx shaft of left femur, init encntr
 ;;^UTILITY(U,$J,358.3,29436,1,4,0)
 ;;=4^S72.352A
 ;;^UTILITY(U,$J,358.3,29436,2)
 ;;=^5038448
 ;;^UTILITY(U,$J,358.3,29437,0)
 ;;=S72.351A^^111^1423^7
 ;;^UTILITY(U,$J,358.3,29437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29437,1,3,0)
 ;;=3^Displ comminuted fx shaft of right femur, init encntr
 ;;^UTILITY(U,$J,358.3,29437,1,4,0)
 ;;=4^S72.351A
 ;;^UTILITY(U,$J,358.3,29437,2)
 ;;=^5038432
 ;;^UTILITY(U,$J,358.3,29438,0)
 ;;=M61.052^^111^1423^9
 ;;^UTILITY(U,$J,358.3,29438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29438,1,3,0)
 ;;=3^Myositis ossificans traumatica, left thigh
 ;;^UTILITY(U,$J,358.3,29438,1,4,0)
 ;;=4^M61.052
 ;;^UTILITY(U,$J,358.3,29438,2)
 ;;=^5012424
 ;;^UTILITY(U,$J,358.3,29439,0)
 ;;=S72.354A^^111^1423^11
 ;;^UTILITY(U,$J,358.3,29439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29439,1,3,0)
 ;;=3^Nondisp commnt fx shaft of left femur, init encntr
 ;;^UTILITY(U,$J,358.3,29439,1,4,0)
 ;;=4^S72.354A
 ;;^UTILITY(U,$J,358.3,29439,2)
 ;;=^5038480
 ;;^UTILITY(U,$J,358.3,29440,0)
 ;;=M84.552A^^111^1423^15
 ;;^UTILITY(U,$J,358.3,29440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29440,1,3,0)
 ;;=3^Path fx in neopltc dis, left femur, init encntr
 ;;^UTILITY(U,$J,358.3,29440,1,4,0)
 ;;=4^M84.552A
 ;;^UTILITY(U,$J,358.3,29440,2)
 ;;=^5014124
 ;;^UTILITY(U,$J,358.3,29441,0)
 ;;=M84.551A^^111^1423^19
 ;;^UTILITY(U,$J,358.3,29441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29441,1,3,0)
 ;;=3^Path fx in oth disease, right femur, init encntr
 ;;^UTILITY(U,$J,358.3,29441,1,4,0)
 ;;=4^M84.551A
 ;;^UTILITY(U,$J,358.3,29441,2)
 ;;=^5014118
 ;;^UTILITY(U,$J,358.3,29442,0)
 ;;=M84.652A^^111^1423^21
 ;;^UTILITY(U,$J,358.3,29442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29442,1,3,0)
 ;;=3^Pathological fracture in oth disease, left femur, init
 ;;^UTILITY(U,$J,358.3,29442,1,4,0)
 ;;=4^M84.652A
 ;;^UTILITY(U,$J,358.3,29442,2)
 ;;=^5134003
 ;;^UTILITY(U,$J,358.3,29443,0)
 ;;=M61.051^^111^1423^10
 ;;^UTILITY(U,$J,358.3,29443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29443,1,3,0)
 ;;=3^Myositis ossificans traumatica, right thigh
 ;;^UTILITY(U,$J,358.3,29443,1,4,0)
 ;;=4^M61.051
 ;;^UTILITY(U,$J,358.3,29443,2)
 ;;=^5012423
 ;;^UTILITY(U,$J,358.3,29444,0)
 ;;=S72.355A^^111^1423^13
 ;;^UTILITY(U,$J,358.3,29444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29444,1,3,0)
 ;;=3^Nondisp commnt fx shaft of right femur, init encntr
 ;;^UTILITY(U,$J,358.3,29444,1,4,0)
 ;;=4^S72.355A
 ;;^UTILITY(U,$J,358.3,29444,2)
 ;;=^5038496
 ;;^UTILITY(U,$J,358.3,29445,0)
 ;;=M84.651A^^111^1423^22
 ;;^UTILITY(U,$J,358.3,29445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29445,1,3,0)
 ;;=3^Pathological fracture in oth disease, right femur, init
 ;;^UTILITY(U,$J,358.3,29445,1,4,0)
 ;;=4^M84.651A
 ;;^UTILITY(U,$J,358.3,29445,2)
 ;;=^5014262
 ;;^UTILITY(U,$J,358.3,29446,0)
 ;;=M84.452A^^111^1423^23
 ;;^UTILITY(U,$J,358.3,29446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29446,1,3,0)
 ;;=3^Pathological fracture, left femur, init encntr for fracture
 ;;^UTILITY(U,$J,358.3,29446,1,4,0)
 ;;=4^M84.452A
 ;;^UTILITY(U,$J,358.3,29446,2)
 ;;=^5013908
 ;;^UTILITY(U,$J,358.3,29447,0)
 ;;=M84.451A^^111^1423^25
 ;;^UTILITY(U,$J,358.3,29447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29447,1,3,0)
 ;;=3^Pathological fracture, right femur, init encntr for fracture
 ;;^UTILITY(U,$J,358.3,29447,1,4,0)
 ;;=4^M84.451A
 ;;^UTILITY(U,$J,358.3,29447,2)
 ;;=^5013902
 ;;^UTILITY(U,$J,358.3,29448,0)
 ;;=M84.352A^^111^1423^27
 ;;^UTILITY(U,$J,358.3,29448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29448,1,3,0)
 ;;=3^Stress fracture, left femur, initial encounter for fracture
 ;;^UTILITY(U,$J,358.3,29448,1,4,0)
 ;;=4^M84.352A
 ;;^UTILITY(U,$J,358.3,29448,2)
 ;;=^5013686
 ;;^UTILITY(U,$J,358.3,29449,0)
 ;;=M84.351A^^111^1423^29
 ;;^UTILITY(U,$J,358.3,29449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29449,1,3,0)
 ;;=3^Stress fracture, right femur, initial encounter for fracture
 ;;^UTILITY(U,$J,358.3,29449,1,4,0)
 ;;=4^M84.351A
 ;;^UTILITY(U,$J,358.3,29449,2)
 ;;=^5013680
 ;;^UTILITY(U,$J,358.3,29450,0)
 ;;=S70.12XD^^111^1423^2
 ;;^UTILITY(U,$J,358.3,29450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29450,1,3,0)
 ;;=3^Contusion of left thigh, subsequent encounter
 ;;^UTILITY(U,$J,358.3,29450,1,4,0)
 ;;=4^S70.12XD
 ;;^UTILITY(U,$J,358.3,29450,2)
 ;;=^5036847
 ;;^UTILITY(U,$J,358.3,29451,0)
 ;;=S70.11XD^^111^1423^4
 ;;^UTILITY(U,$J,358.3,29451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29451,1,3,0)
 ;;=3^Contusion of right thigh, subsequent encounter
 ;;^UTILITY(U,$J,358.3,29451,1,4,0)
 ;;=4^S70.11XD
 ;;^UTILITY(U,$J,358.3,29451,2)
 ;;=^5036844
 ;;^UTILITY(U,$J,358.3,29452,0)
 ;;=S72.352D^^111^1423^6
 ;;^UTILITY(U,$J,358.3,29452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29452,1,3,0)
 ;;=3^Displ comminuted fx shaft of left femur, subs encntr
 ;;^UTILITY(U,$J,358.3,29452,1,4,0)
 ;;=4^S72.352D
 ;;^UTILITY(U,$J,358.3,29452,2)
 ;;=^5038451
 ;;^UTILITY(U,$J,358.3,29453,0)
 ;;=S72.351D^^111^1423^8
 ;;^UTILITY(U,$J,358.3,29453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29453,1,3,0)
 ;;=3^Displ comminuted fx shaft of right femur, subs encntr
 ;;^UTILITY(U,$J,358.3,29453,1,4,0)
 ;;=4^S72.351D
 ;;^UTILITY(U,$J,358.3,29453,2)
 ;;=^5038435
 ;;^UTILITY(U,$J,358.3,29454,0)
 ;;=S72.354D^^111^1423^14
 ;;^UTILITY(U,$J,358.3,29454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29454,1,3,0)
 ;;=3^Nondisp commnt fx shaft of right femur, subs encntr
 ;;^UTILITY(U,$J,358.3,29454,1,4,0)
 ;;=4^S72.354D
 ;;^UTILITY(U,$J,358.3,29454,2)
 ;;=^5038483
 ;;^UTILITY(U,$J,358.3,29455,0)
 ;;=S72.355D^^111^1423^12
