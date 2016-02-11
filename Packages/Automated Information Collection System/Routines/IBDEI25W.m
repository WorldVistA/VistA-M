IBDEI25W ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36253,0)
 ;;=R87.610^^166^1835^19
 ;;^UTILITY(U,$J,358.3,36253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36253,1,3,0)
 ;;=3^Atyp squam cell of undet signfc cyto smr crvx (ASC-US)
 ;;^UTILITY(U,$J,358.3,36253,1,4,0)
 ;;=4^R87.610
 ;;^UTILITY(U,$J,358.3,36253,2)
 ;;=^5019668
 ;;^UTILITY(U,$J,358.3,36254,0)
 ;;=R87.611^^166^1835^18
 ;;^UTILITY(U,$J,358.3,36254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36254,1,3,0)
 ;;=3^Atyp squam cell not excl hi grd intrepith lesn cyto smr crvx
 ;;^UTILITY(U,$J,358.3,36254,1,4,0)
 ;;=4^R87.611
 ;;^UTILITY(U,$J,358.3,36254,2)
 ;;=^5019669
 ;;^UTILITY(U,$J,358.3,36255,0)
 ;;=R87.612^^166^1835^65
 ;;^UTILITY(U,$J,358.3,36255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36255,1,3,0)
 ;;=3^Low grade intrepith lesion cyto smr crvx (LGSIL)
 ;;^UTILITY(U,$J,358.3,36255,1,4,0)
 ;;=4^R87.612
 ;;^UTILITY(U,$J,358.3,36255,2)
 ;;=^5019670
 ;;^UTILITY(U,$J,358.3,36256,0)
 ;;=R87.613^^166^1835^56
 ;;^UTILITY(U,$J,358.3,36256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36256,1,3,0)
 ;;=3^High grade intrepith lesion cyto smr crvx (HGSIL)
 ;;^UTILITY(U,$J,358.3,36256,1,4,0)
 ;;=4^R87.613
 ;;^UTILITY(U,$J,358.3,36256,2)
 ;;=^5019671
 ;;^UTILITY(U,$J,358.3,36257,0)
 ;;=R87.810^^166^1835^27
 ;;^UTILITY(U,$J,358.3,36257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36257,1,3,0)
 ;;=3^Cervical high risk HPV DNA test positive
 ;;^UTILITY(U,$J,358.3,36257,1,4,0)
 ;;=4^R87.810
 ;;^UTILITY(U,$J,358.3,36257,2)
 ;;=^331573
 ;;^UTILITY(U,$J,358.3,36258,0)
 ;;=R87.614^^166^1835^36
 ;;^UTILITY(U,$J,358.3,36258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36258,1,3,0)
 ;;=3^Cytologic evidence of malignancy on smear of cervix
 ;;^UTILITY(U,$J,358.3,36258,1,4,0)
 ;;=4^R87.614
 ;;^UTILITY(U,$J,358.3,36258,2)
 ;;=^5019672
 ;;^UTILITY(U,$J,358.3,36259,0)
 ;;=Z85.3^^166^1835^77
 ;;^UTILITY(U,$J,358.3,36259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36259,1,3,0)
 ;;=3^Personal history of malignant neoplasm of breast
 ;;^UTILITY(U,$J,358.3,36259,1,4,0)
 ;;=4^Z85.3
 ;;^UTILITY(U,$J,358.3,36259,2)
 ;;=^5063416
 ;;^UTILITY(U,$J,358.3,36260,0)
 ;;=Z85.43^^166^1835^78
 ;;^UTILITY(U,$J,358.3,36260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36260,1,3,0)
 ;;=3^Personal history of malignant neoplasm of ovary
 ;;^UTILITY(U,$J,358.3,36260,1,4,0)
 ;;=4^Z85.43
 ;;^UTILITY(U,$J,358.3,36260,2)
 ;;=^5063420
 ;;^UTILITY(U,$J,358.3,36261,0)
 ;;=Z80.41^^166^1835^51
 ;;^UTILITY(U,$J,358.3,36261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36261,1,3,0)
 ;;=3^Family history of malignant neoplasm of ovary
 ;;^UTILITY(U,$J,358.3,36261,1,4,0)
 ;;=4^Z80.41
 ;;^UTILITY(U,$J,358.3,36261,2)
 ;;=^5063348
 ;;^UTILITY(U,$J,358.3,36262,0)
 ;;=Z30.011^^166^1835^60
 ;;^UTILITY(U,$J,358.3,36262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36262,1,3,0)
 ;;=3^Initial Prescription of Contraceptive Pills
 ;;^UTILITY(U,$J,358.3,36262,1,4,0)
 ;;=4^Z30.011
 ;;^UTILITY(U,$J,358.3,36262,2)
 ;;=^5062810
 ;;^UTILITY(U,$J,358.3,36263,0)
 ;;=Z30.018^^166^1835^61
 ;;^UTILITY(U,$J,358.3,36263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36263,1,3,0)
 ;;=3^Initial Prescription of Contraceptives NEC
 ;;^UTILITY(U,$J,358.3,36263,1,4,0)
 ;;=4^Z30.018
 ;;^UTILITY(U,$J,358.3,36263,2)
 ;;=^5062814
 ;;^UTILITY(U,$J,358.3,36264,0)
 ;;=Z30.012^^166^1835^43
 ;;^UTILITY(U,$J,358.3,36264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36264,1,3,0)
 ;;=3^Emergency Contraception Prescription
 ;;^UTILITY(U,$J,358.3,36264,1,4,0)
 ;;=4^Z30.012
 ;;^UTILITY(U,$J,358.3,36264,2)
 ;;=^5062811
 ;;^UTILITY(U,$J,358.3,36265,0)
 ;;=Z30.02^^166^1835^32
