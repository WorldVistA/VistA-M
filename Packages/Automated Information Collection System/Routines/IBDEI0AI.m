IBDEI0AI ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4945,0)
 ;;=272.0^^41^478^55
 ;;^UTILITY(U,$J,358.3,4945,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4945,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,4945,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,4945,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,4946,0)
 ;;=272.1^^41^478^58
 ;;^UTILITY(U,$J,358.3,4946,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4946,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,4946,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,4946,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,4947,0)
 ;;=272.2^^41^478^63
 ;;^UTILITY(U,$J,358.3,4947,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4947,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,4947,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,4947,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,4948,0)
 ;;=396.0^^41^478^11
 ;;^UTILITY(U,$J,358.3,4948,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4948,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,4948,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,4948,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,4949,0)
 ;;=414.02^^41^478^18
 ;;^UTILITY(U,$J,358.3,4949,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4949,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,4949,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,4949,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,4950,0)
 ;;=459.10^^41^478^73
 ;;^UTILITY(U,$J,358.3,4950,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4950,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,4950,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,4950,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,4951,0)
 ;;=428.20^^41^478^50
 ;;^UTILITY(U,$J,358.3,4951,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4951,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,4951,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,4951,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,4952,0)
 ;;=428.21^^41^478^42
 ;;^UTILITY(U,$J,358.3,4952,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4952,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,4952,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,4952,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,4953,0)
 ;;=428.22^^41^478^44
 ;;^UTILITY(U,$J,358.3,4953,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4953,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,4953,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,4953,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,4954,0)
 ;;=428.23^^41^478^49
 ;;^UTILITY(U,$J,358.3,4954,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4954,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,4954,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,4954,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,4955,0)
 ;;=428.30^^41^478^45
 ;;^UTILITY(U,$J,358.3,4955,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4955,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,4955,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,4955,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,4956,0)
 ;;=428.31^^41^478^41
 ;;^UTILITY(U,$J,358.3,4956,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4956,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,4956,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,4956,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,4957,0)
 ;;=428.32^^41^478^43
 ;;^UTILITY(U,$J,358.3,4957,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4957,1,4,0)
 ;;=4^428.32
