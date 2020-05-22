IBDEI14S ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18160,1,3,0)
 ;;=3^Pneumonia d/t Hemophilus Influenzae
 ;;^UTILITY(U,$J,358.3,18160,1,4,0)
 ;;=4^J14.
 ;;^UTILITY(U,$J,358.3,18160,2)
 ;;=^5008171
 ;;^UTILITY(U,$J,358.3,18161,0)
 ;;=J15.0^^88^912^7
 ;;^UTILITY(U,$J,358.3,18161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18161,1,3,0)
 ;;=3^Pneumonia d/t Klebsiella Pneumoniae
 ;;^UTILITY(U,$J,358.3,18161,1,4,0)
 ;;=4^J15.0
 ;;^UTILITY(U,$J,358.3,18161,2)
 ;;=^269931
 ;;^UTILITY(U,$J,358.3,18162,0)
 ;;=J15.1^^88^912^16
 ;;^UTILITY(U,$J,358.3,18162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18162,1,3,0)
 ;;=3^Pneumonia d/t Pseudomonas
 ;;^UTILITY(U,$J,358.3,18162,1,4,0)
 ;;=4^J15.1
 ;;^UTILITY(U,$J,358.3,18162,2)
 ;;=^269932
 ;;^UTILITY(U,$J,358.3,18163,0)
 ;;=J15.20^^88^912^18
 ;;^UTILITY(U,$J,358.3,18163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18163,1,3,0)
 ;;=3^Pneumonia d/t Staphylococcus,Unspec
 ;;^UTILITY(U,$J,358.3,18163,1,4,0)
 ;;=4^J15.20
 ;;^UTILITY(U,$J,358.3,18163,2)
 ;;=^321179
 ;;^UTILITY(U,$J,358.3,18164,0)
 ;;=J15.211^^88^912^9
 ;;^UTILITY(U,$J,358.3,18164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18164,1,3,0)
 ;;=3^Pneumonia d/t Methicillin Suscep Staph
 ;;^UTILITY(U,$J,358.3,18164,1,4,0)
 ;;=4^J15.211
 ;;^UTILITY(U,$J,358.3,18164,2)
 ;;=^336833
 ;;^UTILITY(U,$J,358.3,18165,0)
 ;;=J15.212^^88^912^8
 ;;^UTILITY(U,$J,358.3,18165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18165,1,3,0)
 ;;=3^Pneumonia d/t Methicillin Resistant Staph Aureus
 ;;^UTILITY(U,$J,358.3,18165,1,4,0)
 ;;=4^J15.212
 ;;^UTILITY(U,$J,358.3,18165,2)
 ;;=^336602
 ;;^UTILITY(U,$J,358.3,18166,0)
 ;;=J15.29^^88^912^11
 ;;^UTILITY(U,$J,358.3,18166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18166,1,3,0)
 ;;=3^Pneumonia d/t Oth Staph
 ;;^UTILITY(U,$J,358.3,18166,1,4,0)
 ;;=4^J15.29
 ;;^UTILITY(U,$J,358.3,18166,2)
 ;;=^5008172
 ;;^UTILITY(U,$J,358.3,18167,0)
 ;;=J15.3^^88^912^20
 ;;^UTILITY(U,$J,358.3,18167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18167,1,3,0)
 ;;=3^Pneumonia d/t Streptococcus,Group B
 ;;^UTILITY(U,$J,358.3,18167,1,4,0)
 ;;=4^J15.3
 ;;^UTILITY(U,$J,358.3,18167,2)
 ;;=^5008173
 ;;^UTILITY(U,$J,358.3,18168,0)
 ;;=J15.4^^88^912^15
 ;;^UTILITY(U,$J,358.3,18168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18168,1,3,0)
 ;;=3^Pneumonia d/t Other Streptococci
 ;;^UTILITY(U,$J,358.3,18168,1,4,0)
 ;;=4^J15.4
 ;;^UTILITY(U,$J,358.3,18168,2)
 ;;=^5008174
 ;;^UTILITY(U,$J,358.3,18169,0)
 ;;=J15.5^^88^912^5
 ;;^UTILITY(U,$J,358.3,18169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18169,1,3,0)
 ;;=3^Pneumonia d/t Escherichia Coli
 ;;^UTILITY(U,$J,358.3,18169,1,4,0)
 ;;=4^J15.5
 ;;^UTILITY(U,$J,358.3,18169,2)
 ;;=^5008175
 ;;^UTILITY(U,$J,358.3,18170,0)
 ;;=J15.6^^88^912^12
 ;;^UTILITY(U,$J,358.3,18170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18170,1,3,0)
 ;;=3^Pneumonia d/t Other Aerobic Gram-Neg Bacteria
 ;;^UTILITY(U,$J,358.3,18170,1,4,0)
 ;;=4^J15.6
 ;;^UTILITY(U,$J,358.3,18170,2)
 ;;=^5008176
 ;;^UTILITY(U,$J,358.3,18171,0)
 ;;=J15.7^^88^912^10
 ;;^UTILITY(U,$J,358.3,18171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18171,1,3,0)
 ;;=3^Pneumonia d/t Mycoplasma Pneumoniae
 ;;^UTILITY(U,$J,358.3,18171,1,4,0)
 ;;=4^J15.7
 ;;^UTILITY(U,$J,358.3,18171,2)
 ;;=^5008177
 ;;^UTILITY(U,$J,358.3,18172,0)
 ;;=J15.8^^88^912^13
 ;;^UTILITY(U,$J,358.3,18172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18172,1,3,0)
 ;;=3^Pneumonia d/t Other Spec Bacteria
