IBDEI21D ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35581,1,3,0)
 ;;=3^Cirrhosis of liver,Unspec
 ;;^UTILITY(U,$J,358.3,35581,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,35581,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,35582,0)
 ;;=K76.0^^189^2055^12
 ;;^UTILITY(U,$J,358.3,35582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35582,1,3,0)
 ;;=3^Fatty (change of) liver, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,35582,1,4,0)
 ;;=4^K76.0
 ;;^UTILITY(U,$J,358.3,35582,2)
 ;;=^5008831
 ;;^UTILITY(U,$J,358.3,35583,0)
 ;;=K76.89^^189^2055^14
 ;;^UTILITY(U,$J,358.3,35583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35583,1,3,0)
 ;;=3^Liver Disease NEC
 ;;^UTILITY(U,$J,358.3,35583,1,4,0)
 ;;=4^K76.89
 ;;^UTILITY(U,$J,358.3,35583,2)
 ;;=^5008835
 ;;^UTILITY(U,$J,358.3,35584,0)
 ;;=K70.30^^189^2055^5
 ;;^UTILITY(U,$J,358.3,35584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35584,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver without ascites
 ;;^UTILITY(U,$J,358.3,35584,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,35584,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,35585,0)
 ;;=K70.31^^189^2055^4
 ;;^UTILITY(U,$J,358.3,35585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35585,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver with ascites
 ;;^UTILITY(U,$J,358.3,35585,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,35585,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,35586,0)
 ;;=K75.4^^189^2055^6
 ;;^UTILITY(U,$J,358.3,35586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35586,1,3,0)
 ;;=3^Autoimmune hepatitis
 ;;^UTILITY(U,$J,358.3,35586,1,4,0)
 ;;=4^K75.4
 ;;^UTILITY(U,$J,358.3,35586,2)
 ;;=^336610
 ;;^UTILITY(U,$J,358.3,35587,0)
 ;;=K74.69^^189^2055^10
 ;;^UTILITY(U,$J,358.3,35587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35587,1,3,0)
 ;;=3^Cirrhosis of liver NEC
 ;;^UTILITY(U,$J,358.3,35587,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,35587,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,35588,0)
 ;;=K74.3^^189^2055^20
 ;;^UTILITY(U,$J,358.3,35588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35588,1,3,0)
 ;;=3^Primary biliary cirrhosis
 ;;^UTILITY(U,$J,358.3,35588,1,4,0)
 ;;=4^K74.3
 ;;^UTILITY(U,$J,358.3,35588,2)
 ;;=^5008819
 ;;^UTILITY(U,$J,358.3,35589,0)
 ;;=K75.81^^189^2055^19
 ;;^UTILITY(U,$J,358.3,35589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35589,1,3,0)
 ;;=3^Nonalcoholic steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,35589,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,35589,2)
 ;;=K830^5008828
 ;;^UTILITY(U,$J,358.3,35590,0)
 ;;=B16.9^^189^2055^1
 ;;^UTILITY(U,$J,358.3,35590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35590,1,3,0)
 ;;=3^Acute hepatitis B w/o delta-agent and without hepatic coma
 ;;^UTILITY(U,$J,358.3,35590,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,35590,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,35591,0)
 ;;=B18.1^^189^2055^8
 ;;^UTILITY(U,$J,358.3,35591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35591,1,3,0)
 ;;=3^Chronic viral hepatitis B without delta-agent
 ;;^UTILITY(U,$J,358.3,35591,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,35591,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,35592,0)
 ;;=Z94.4^^189^2055^16
 ;;^UTILITY(U,$J,358.3,35592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35592,1,3,0)
 ;;=3^Liver transplant status
 ;;^UTILITY(U,$J,358.3,35592,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,35592,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,35593,0)
 ;;=J90.^^189^2056^1
 ;;^UTILITY(U,$J,358.3,35593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35593,1,3,0)
 ;;=3^Pleural effusion, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,35593,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,35593,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,35594,0)
 ;;=C83.38^^189^2057^22
 ;;^UTILITY(U,$J,358.3,35594,1,0)
 ;;=^358.31IA^4^2
