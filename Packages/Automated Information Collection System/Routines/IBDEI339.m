IBDEI339 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,49318,0)
 ;;=J45.52^^187^2444^26
 ;;^UTILITY(U,$J,358.3,49318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49318,1,3,0)
 ;;=3^Asthma,Severe Persistent w/ Status Asthmaticus
 ;;^UTILITY(U,$J,358.3,49318,1,4,0)
 ;;=4^J45.52
 ;;^UTILITY(U,$J,358.3,49318,2)
 ;;=^5008253
 ;;^UTILITY(U,$J,358.3,49319,0)
 ;;=J45.901^^187^2444^14
 ;;^UTILITY(U,$J,358.3,49319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49319,1,3,0)
 ;;=3^Asthma w/ Acute Exacerbation,Unspec
 ;;^UTILITY(U,$J,358.3,49319,1,4,0)
 ;;=4^J45.901
 ;;^UTILITY(U,$J,358.3,49319,2)
 ;;=^5008254
 ;;^UTILITY(U,$J,358.3,49320,0)
 ;;=J45.902^^187^2444^15
 ;;^UTILITY(U,$J,358.3,49320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49320,1,3,0)
 ;;=3^Asthma w/ Status Asthmaticus,Unspec
 ;;^UTILITY(U,$J,358.3,49320,1,4,0)
 ;;=4^J45.902
 ;;^UTILITY(U,$J,358.3,49320,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,49321,0)
 ;;=J45.909^^187^2444^28
 ;;^UTILITY(U,$J,358.3,49321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49321,1,3,0)
 ;;=3^Asthma,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,49321,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,49321,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,49322,0)
 ;;=J95.01^^187^2444^57
 ;;^UTILITY(U,$J,358.3,49322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49322,1,3,0)
 ;;=3^Tracheostomy Stoma Hemorrhage
 ;;^UTILITY(U,$J,358.3,49322,1,4,0)
 ;;=4^J95.01
 ;;^UTILITY(U,$J,358.3,49322,2)
 ;;=^5008322
 ;;^UTILITY(U,$J,358.3,49323,0)
 ;;=J95.02^^187^2444^58
 ;;^UTILITY(U,$J,358.3,49323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49323,1,3,0)
 ;;=3^Tracheostomy Stoma Infection
 ;;^UTILITY(U,$J,358.3,49323,1,4,0)
 ;;=4^J95.02
 ;;^UTILITY(U,$J,358.3,49323,2)
 ;;=^5008323
 ;;^UTILITY(U,$J,358.3,49324,0)
 ;;=J95.03^^187^2444^59
 ;;^UTILITY(U,$J,358.3,49324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49324,1,3,0)
 ;;=3^Tracheostomy Stoma Malfunction
 ;;^UTILITY(U,$J,358.3,49324,1,4,0)
 ;;=4^J95.03
 ;;^UTILITY(U,$J,358.3,49324,2)
 ;;=^5008324
 ;;^UTILITY(U,$J,358.3,49325,0)
 ;;=J95.04^^187^2444^55
 ;;^UTILITY(U,$J,358.3,49325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49325,1,3,0)
 ;;=3^Tracheo-Esophageal Fistula Following Tracheostomy
 ;;^UTILITY(U,$J,358.3,49325,1,4,0)
 ;;=4^J95.04
 ;;^UTILITY(U,$J,358.3,49325,2)
 ;;=^5008325
 ;;^UTILITY(U,$J,358.3,49326,0)
 ;;=J95.09^^187^2444^56
 ;;^UTILITY(U,$J,358.3,49326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49326,1,3,0)
 ;;=3^Tracheostomy Complication,Other
 ;;^UTILITY(U,$J,358.3,49326,1,4,0)
 ;;=4^J95.09
 ;;^UTILITY(U,$J,358.3,49326,2)
 ;;=^5008326
 ;;^UTILITY(U,$J,358.3,49327,0)
 ;;=J95.1^^187^2444^7
 ;;^UTILITY(U,$J,358.3,49327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49327,1,3,0)
 ;;=3^Acute Pulmonary Insufficiency Following Thoracic Surgery
 ;;^UTILITY(U,$J,358.3,49327,1,4,0)
 ;;=4^J95.1
 ;;^UTILITY(U,$J,358.3,49327,2)
 ;;=^5008327
 ;;^UTILITY(U,$J,358.3,49328,0)
 ;;=J95.2^^187^2444^8
 ;;^UTILITY(U,$J,358.3,49328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49328,1,3,0)
 ;;=3^Acute Pulmonary Insufficiency Following Non-Thoracic Surgery
 ;;^UTILITY(U,$J,358.3,49328,1,4,0)
 ;;=4^J95.2
 ;;^UTILITY(U,$J,358.3,49328,2)
 ;;=^5008328
 ;;^UTILITY(U,$J,358.3,49329,0)
 ;;=J95.3^^187^2444^36
 ;;^UTILITY(U,$J,358.3,49329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49329,1,3,0)
 ;;=3^Chronic Pulmonary Insufficiency Following Surgery
 ;;^UTILITY(U,$J,358.3,49329,1,4,0)
 ;;=4^J95.3
 ;;^UTILITY(U,$J,358.3,49329,2)
 ;;=^5008329
