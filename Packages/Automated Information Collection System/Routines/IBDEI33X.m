IBDEI33X ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,49625,1,3,0)
 ;;=3^Asthma w/ Status Asthmaticus,Unspec
 ;;^UTILITY(U,$J,358.3,49625,1,4,0)
 ;;=4^J45.902
 ;;^UTILITY(U,$J,358.3,49625,2)
 ;;=^5008255
 ;;^UTILITY(U,$J,358.3,49626,0)
 ;;=J45.909^^191^2474^28
 ;;^UTILITY(U,$J,358.3,49626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49626,1,3,0)
 ;;=3^Asthma,Unspec,Uncomplicated
 ;;^UTILITY(U,$J,358.3,49626,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,49626,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,49627,0)
 ;;=J95.01^^191^2474^57
 ;;^UTILITY(U,$J,358.3,49627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49627,1,3,0)
 ;;=3^Tracheostomy Stoma Hemorrhage
 ;;^UTILITY(U,$J,358.3,49627,1,4,0)
 ;;=4^J95.01
 ;;^UTILITY(U,$J,358.3,49627,2)
 ;;=^5008322
 ;;^UTILITY(U,$J,358.3,49628,0)
 ;;=J95.02^^191^2474^58
 ;;^UTILITY(U,$J,358.3,49628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49628,1,3,0)
 ;;=3^Tracheostomy Stoma Infection
 ;;^UTILITY(U,$J,358.3,49628,1,4,0)
 ;;=4^J95.02
 ;;^UTILITY(U,$J,358.3,49628,2)
 ;;=^5008323
 ;;^UTILITY(U,$J,358.3,49629,0)
 ;;=J95.03^^191^2474^59
 ;;^UTILITY(U,$J,358.3,49629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49629,1,3,0)
 ;;=3^Tracheostomy Stoma Malfunction
 ;;^UTILITY(U,$J,358.3,49629,1,4,0)
 ;;=4^J95.03
 ;;^UTILITY(U,$J,358.3,49629,2)
 ;;=^5008324
 ;;^UTILITY(U,$J,358.3,49630,0)
 ;;=J95.04^^191^2474^55
 ;;^UTILITY(U,$J,358.3,49630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49630,1,3,0)
 ;;=3^Tracheo-Esophageal Fistula Following Tracheostomy
 ;;^UTILITY(U,$J,358.3,49630,1,4,0)
 ;;=4^J95.04
 ;;^UTILITY(U,$J,358.3,49630,2)
 ;;=^5008325
 ;;^UTILITY(U,$J,358.3,49631,0)
 ;;=J95.09^^191^2474^56
 ;;^UTILITY(U,$J,358.3,49631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49631,1,3,0)
 ;;=3^Tracheostomy Complication,Other
 ;;^UTILITY(U,$J,358.3,49631,1,4,0)
 ;;=4^J95.09
 ;;^UTILITY(U,$J,358.3,49631,2)
 ;;=^5008326
 ;;^UTILITY(U,$J,358.3,49632,0)
 ;;=J95.1^^191^2474^7
 ;;^UTILITY(U,$J,358.3,49632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49632,1,3,0)
 ;;=3^Acute Pulmonary Insufficiency Following Thoracic Surgery
 ;;^UTILITY(U,$J,358.3,49632,1,4,0)
 ;;=4^J95.1
 ;;^UTILITY(U,$J,358.3,49632,2)
 ;;=^5008327
 ;;^UTILITY(U,$J,358.3,49633,0)
 ;;=J95.2^^191^2474^8
 ;;^UTILITY(U,$J,358.3,49633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49633,1,3,0)
 ;;=3^Acute Pulmonary Insufficiency Following Non-Thoracic Surgery
 ;;^UTILITY(U,$J,358.3,49633,1,4,0)
 ;;=4^J95.2
 ;;^UTILITY(U,$J,358.3,49633,2)
 ;;=^5008328
 ;;^UTILITY(U,$J,358.3,49634,0)
 ;;=J95.3^^191^2474^36
 ;;^UTILITY(U,$J,358.3,49634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49634,1,3,0)
 ;;=3^Chronic Pulmonary Insufficiency Following Surgery
 ;;^UTILITY(U,$J,358.3,49634,1,4,0)
 ;;=4^J95.3
 ;;^UTILITY(U,$J,358.3,49634,2)
 ;;=^5008329
 ;;^UTILITY(U,$J,358.3,49635,0)
 ;;=J95.4^^191^2474^32
 ;;^UTILITY(U,$J,358.3,49635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49635,1,3,0)
 ;;=3^Chemical Pneumonitis d/t Anesthesia
 ;;^UTILITY(U,$J,358.3,49635,1,4,0)
 ;;=4^J95.4
 ;;^UTILITY(U,$J,358.3,49635,2)
 ;;=^5008330
 ;;^UTILITY(U,$J,358.3,49636,0)
 ;;=J95.5^^191^2474^53
 ;;^UTILITY(U,$J,358.3,49636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49636,1,3,0)
 ;;=3^Subglottic Stenosis,Postprocedural
 ;;^UTILITY(U,$J,358.3,49636,1,4,0)
 ;;=4^J95.5
 ;;^UTILITY(U,$J,358.3,49636,2)
 ;;=^5008331
 ;;^UTILITY(U,$J,358.3,49637,0)
 ;;=J95.61^^191^2474^38
 ;;^UTILITY(U,$J,358.3,49637,1,0)
 ;;=^358.31IA^4^2
