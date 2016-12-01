IBDEI0PG ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32258,1,3,0)
 ;;=3^Rheumatoid nodule, right knee
 ;;^UTILITY(U,$J,358.3,32258,1,4,0)
 ;;=4^M06.361
 ;;^UTILITY(U,$J,358.3,32258,2)
 ;;=^5010112
 ;;^UTILITY(U,$J,358.3,32259,0)
 ;;=M06.311^^94^1415^78
 ;;^UTILITY(U,$J,358.3,32259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32259,1,3,0)
 ;;=3^Rheumatoid nodule, right shoulder
 ;;^UTILITY(U,$J,358.3,32259,1,4,0)
 ;;=4^M06.311
 ;;^UTILITY(U,$J,358.3,32259,2)
 ;;=^5010097
 ;;^UTILITY(U,$J,358.3,32260,0)
 ;;=M06.331^^94^1415^79
 ;;^UTILITY(U,$J,358.3,32260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32260,1,3,0)
 ;;=3^Rheumatoid nodule, right wrist
 ;;^UTILITY(U,$J,358.3,32260,1,4,0)
 ;;=4^M06.331
 ;;^UTILITY(U,$J,358.3,32260,2)
 ;;=^5010103
 ;;^UTILITY(U,$J,358.3,32261,0)
 ;;=M06.38^^94^1415^80
 ;;^UTILITY(U,$J,358.3,32261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32261,1,3,0)
 ;;=3^Rheumatoid nodule, vertebrae
 ;;^UTILITY(U,$J,358.3,32261,1,4,0)
 ;;=4^M06.38
 ;;^UTILITY(U,$J,358.3,32261,2)
 ;;=^5010118
 ;;^UTILITY(U,$J,358.3,32262,0)
 ;;=M05.572^^94^1415^81
 ;;^UTILITY(U,$J,358.3,32262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32262,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of left ank/ft
 ;;^UTILITY(U,$J,358.3,32262,1,4,0)
 ;;=4^M05.572
 ;;^UTILITY(U,$J,358.3,32262,2)
 ;;=^5009974
 ;;^UTILITY(U,$J,358.3,32263,0)
 ;;=M05.522^^94^1415^82
 ;;^UTILITY(U,$J,358.3,32263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32263,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of left elbow
 ;;^UTILITY(U,$J,358.3,32263,1,4,0)
 ;;=4^M05.522
 ;;^UTILITY(U,$J,358.3,32263,2)
 ;;=^5009959
 ;;^UTILITY(U,$J,358.3,32264,0)
 ;;=M05.542^^94^1415^83
 ;;^UTILITY(U,$J,358.3,32264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32264,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of left hand
 ;;^UTILITY(U,$J,358.3,32264,1,4,0)
 ;;=4^M05.542
 ;;^UTILITY(U,$J,358.3,32264,2)
 ;;=^5009965
 ;;^UTILITY(U,$J,358.3,32265,0)
 ;;=M05.552^^94^1415^84
 ;;^UTILITY(U,$J,358.3,32265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32265,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of left hip
 ;;^UTILITY(U,$J,358.3,32265,1,4,0)
 ;;=4^M05.552
 ;;^UTILITY(U,$J,358.3,32265,2)
 ;;=^5009968
 ;;^UTILITY(U,$J,358.3,32266,0)
 ;;=M05.562^^94^1415^85
 ;;^UTILITY(U,$J,358.3,32266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32266,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of left knee
 ;;^UTILITY(U,$J,358.3,32266,1,4,0)
 ;;=4^M05.562
 ;;^UTILITY(U,$J,358.3,32266,2)
 ;;=^5009971
 ;;^UTILITY(U,$J,358.3,32267,0)
 ;;=M05.512^^94^1415^86
 ;;^UTILITY(U,$J,358.3,32267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32267,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of left shoulder
 ;;^UTILITY(U,$J,358.3,32267,1,4,0)
 ;;=4^M05.512
 ;;^UTILITY(U,$J,358.3,32267,2)
 ;;=^5009956
 ;;^UTILITY(U,$J,358.3,32268,0)
 ;;=M05.532^^94^1415^87
 ;;^UTILITY(U,$J,358.3,32268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32268,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of left wrist
 ;;^UTILITY(U,$J,358.3,32268,1,4,0)
 ;;=4^M05.532
 ;;^UTILITY(U,$J,358.3,32268,2)
 ;;=^5009962
 ;;^UTILITY(U,$J,358.3,32269,0)
 ;;=M05.59^^94^1415^88
 ;;^UTILITY(U,$J,358.3,32269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32269,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of mult site
 ;;^UTILITY(U,$J,358.3,32269,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,32269,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,32270,0)
 ;;=M05.571^^94^1415^89
 ;;^UTILITY(U,$J,358.3,32270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32270,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of right ank/ft
 ;;^UTILITY(U,$J,358.3,32270,1,4,0)
 ;;=4^M05.571
 ;;^UTILITY(U,$J,358.3,32270,2)
 ;;=^5009973
 ;;^UTILITY(U,$J,358.3,32271,0)
 ;;=M05.521^^94^1415^90
 ;;^UTILITY(U,$J,358.3,32271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32271,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of right elbow
 ;;^UTILITY(U,$J,358.3,32271,1,4,0)
 ;;=4^M05.521
 ;;^UTILITY(U,$J,358.3,32271,2)
 ;;=^5009958
 ;;^UTILITY(U,$J,358.3,32272,0)
 ;;=M05.541^^94^1415^91
 ;;^UTILITY(U,$J,358.3,32272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32272,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of right hand
 ;;^UTILITY(U,$J,358.3,32272,1,4,0)
 ;;=4^M05.541
 ;;^UTILITY(U,$J,358.3,32272,2)
 ;;=^5009964
 ;;^UTILITY(U,$J,358.3,32273,0)
 ;;=M05.541^^94^1415^92
 ;;^UTILITY(U,$J,358.3,32273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32273,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of right hand
 ;;^UTILITY(U,$J,358.3,32273,1,4,0)
 ;;=4^M05.541
 ;;^UTILITY(U,$J,358.3,32273,2)
 ;;=^5009964
 ;;^UTILITY(U,$J,358.3,32274,0)
 ;;=M05.551^^94^1415^93
 ;;^UTILITY(U,$J,358.3,32274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32274,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of right hip
 ;;^UTILITY(U,$J,358.3,32274,1,4,0)
 ;;=4^M05.551
 ;;^UTILITY(U,$J,358.3,32274,2)
 ;;=^5009967
 ;;^UTILITY(U,$J,358.3,32275,0)
 ;;=M05.561^^94^1415^94
 ;;^UTILITY(U,$J,358.3,32275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32275,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of right knee
 ;;^UTILITY(U,$J,358.3,32275,1,4,0)
 ;;=4^M05.561
 ;;^UTILITY(U,$J,358.3,32275,2)
 ;;=^5009970
 ;;^UTILITY(U,$J,358.3,32276,0)
 ;;=M05.511^^94^1415^95
 ;;^UTILITY(U,$J,358.3,32276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32276,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of right shoulder
 ;;^UTILITY(U,$J,358.3,32276,1,4,0)
 ;;=4^M05.511
 ;;^UTILITY(U,$J,358.3,32276,2)
 ;;=^5009955
 ;;^UTILITY(U,$J,358.3,32277,0)
 ;;=M05.531^^94^1415^96
 ;;^UTILITY(U,$J,358.3,32277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32277,1,3,0)
 ;;=3^Rheumatoid polyneurop w rheumatoid arthritis of right wrist
 ;;^UTILITY(U,$J,358.3,32277,1,4,0)
 ;;=4^M05.531
 ;;^UTILITY(U,$J,358.3,32277,2)
 ;;=^5009961
 ;;^UTILITY(U,$J,358.3,32278,0)
 ;;=M06.9^^94^1415^33
 ;;^UTILITY(U,$J,358.3,32278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32278,1,3,0)
 ;;=3^Rheumatoid arthritis, unspecified
 ;;^UTILITY(U,$J,358.3,32278,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,32278,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,32279,0)
 ;;=F31.81^^94^1416^8
 ;;^UTILITY(U,$J,358.3,32279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32279,1,3,0)
 ;;=3^Bipolar II disorder
 ;;^UTILITY(U,$J,358.3,32279,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,32279,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,32280,0)
 ;;=F41.9^^94^1416^7
 ;;^UTILITY(U,$J,358.3,32280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32280,1,3,0)
 ;;=3^Anxiety disorder, unspecified
 ;;^UTILITY(U,$J,358.3,32280,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,32280,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,32281,0)
 ;;=F34.1^^94^1416^10
 ;;^UTILITY(U,$J,358.3,32281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32281,1,3,0)
 ;;=3^Dysthymic disorder
 ;;^UTILITY(U,$J,358.3,32281,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,32281,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,32282,0)
 ;;=F60.4^^94^1416^11
 ;;^UTILITY(U,$J,358.3,32282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32282,1,3,0)
 ;;=3^Histrionic personality disorder
 ;;^UTILITY(U,$J,358.3,32282,1,4,0)
 ;;=4^F60.4
 ;;^UTILITY(U,$J,358.3,32282,2)
 ;;=^5003636
 ;;^UTILITY(U,$J,358.3,32283,0)
 ;;=F60.7^^94^1416^9
 ;;^UTILITY(U,$J,358.3,32283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32283,1,3,0)
 ;;=3^Dependent personality disorder
 ;;^UTILITY(U,$J,358.3,32283,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,32283,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,32284,0)
 ;;=F43.21^^94^1416^3
 ;;^UTILITY(U,$J,358.3,32284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32284,1,3,0)
 ;;=3^Adjustment disorder with depressed mood
 ;;^UTILITY(U,$J,358.3,32284,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,32284,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,32285,0)
 ;;=F93.0^^94^1416^17
 ;;^UTILITY(U,$J,358.3,32285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32285,1,3,0)
 ;;=3^Separation anxiety disorder of childhood
 ;;^UTILITY(U,$J,358.3,32285,1,4,0)
 ;;=4^F93.0
 ;;^UTILITY(U,$J,358.3,32285,2)
 ;;=^5003702
 ;;^UTILITY(U,$J,358.3,32286,0)
 ;;=F43.22^^94^1416^2
 ;;^UTILITY(U,$J,358.3,32286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32286,1,3,0)
 ;;=3^Adjustment disorder with anxiety
 ;;^UTILITY(U,$J,358.3,32286,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,32286,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,32287,0)
 ;;=F43.23^^94^1416^5
 ;;^UTILITY(U,$J,358.3,32287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32287,1,3,0)
 ;;=3^Adjustment disorder with mixed anxiety and depressed mood
 ;;^UTILITY(U,$J,358.3,32287,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,32287,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,32288,0)
 ;;=F43.24^^94^1416^4
 ;;^UTILITY(U,$J,358.3,32288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32288,1,3,0)
 ;;=3^Adjustment disorder with disturbance of conduct
 ;;^UTILITY(U,$J,358.3,32288,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,32288,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,32289,0)
 ;;=F43.25^^94^1416^1
 ;;^UTILITY(U,$J,358.3,32289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32289,1,3,0)
 ;;=3^Adjustment disorder w mixed disturb of emotions and conduct
 ;;^UTILITY(U,$J,358.3,32289,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,32289,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,32290,0)
 ;;=F43.10^^94^1416^15
 ;;^UTILITY(U,$J,358.3,32290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32290,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,32290,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,32290,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,32291,0)
 ;;=F43.12^^94^1416^14
 ;;^UTILITY(U,$J,358.3,32291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32291,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,32291,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,32291,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,32292,0)
 ;;=F43.8^^94^1416^16
