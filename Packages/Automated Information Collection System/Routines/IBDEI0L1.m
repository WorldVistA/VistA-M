IBDEI0L1 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10288,1,2,0)
 ;;=2^578.1
 ;;^UTILITY(U,$J,358.3,10288,1,5,0)
 ;;=5^Blood in Stool
 ;;^UTILITY(U,$J,358.3,10288,2)
 ;;=^276839
 ;;^UTILITY(U,$J,358.3,10289,0)
 ;;=578.9^^61^669^18
 ;;^UTILITY(U,$J,358.3,10289,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10289,1,2,0)
 ;;=2^578.9
 ;;^UTILITY(U,$J,358.3,10289,1,5,0)
 ;;=5^GI Bleed
 ;;^UTILITY(U,$J,358.3,10289,2)
 ;;=^49525
 ;;^UTILITY(U,$J,358.3,10290,0)
 ;;=571.3^^61^670^2
 ;;^UTILITY(U,$J,358.3,10290,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10290,1,2,0)
 ;;=2^571.3
 ;;^UTILITY(U,$J,358.3,10290,1,5,0)
 ;;=5^Alcholic Liver Damage
 ;;^UTILITY(U,$J,358.3,10290,2)
 ;;=Alcholic Liver Damage^4638
 ;;^UTILITY(U,$J,358.3,10291,0)
 ;;=571.5^^61^670^7
 ;;^UTILITY(U,$J,358.3,10291,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10291,1,2,0)
 ;;=2^571.5
 ;;^UTILITY(U,$J,358.3,10291,1,5,0)
 ;;=5^Cirrhosis, Unspecified
 ;;^UTILITY(U,$J,358.3,10291,2)
 ;;=Cirrhosis, Unspecified^24731
 ;;^UTILITY(U,$J,358.3,10292,0)
 ;;=571.2^^61^670^3
 ;;^UTILITY(U,$J,358.3,10292,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10292,1,2,0)
 ;;=2^571.2
 ;;^UTILITY(U,$J,358.3,10292,1,5,0)
 ;;=5^Alcoholic Cirrhosis Liver
 ;;^UTILITY(U,$J,358.3,10292,2)
 ;;=Cirrhosis, Alcoholic^71505
 ;;^UTILITY(U,$J,358.3,10293,0)
 ;;=572.0^^61^670^8
 ;;^UTILITY(U,$J,358.3,10293,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10293,1,2,0)
 ;;=2^572.0
 ;;^UTILITY(U,$J,358.3,10293,1,5,0)
 ;;=5^Hepatic Abscess
 ;;^UTILITY(U,$J,358.3,10293,2)
 ;;=Hepatic Abscess^71453
 ;;^UTILITY(U,$J,358.3,10294,0)
 ;;=070.1^^61^670^9
 ;;^UTILITY(U,$J,358.3,10294,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10294,1,2,0)
 ;;=2^070.1
 ;;^UTILITY(U,$J,358.3,10294,1,5,0)
 ;;=5^Hepatitis A
 ;;^UTILITY(U,$J,358.3,10294,2)
 ;;=Hepatitis A^126486
 ;;^UTILITY(U,$J,358.3,10295,0)
 ;;=070.30^^61^670^10
 ;;^UTILITY(U,$J,358.3,10295,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10295,1,2,0)
 ;;=2^070.30
 ;;^UTILITY(U,$J,358.3,10295,1,5,0)
 ;;=5^Hepatitis B w/o Coma
 ;;^UTILITY(U,$J,358.3,10295,2)
 ;;=Hepatitis B w/o coma^266626
 ;;^UTILITY(U,$J,358.3,10296,0)
 ;;=070.51^^61^670^13
 ;;^UTILITY(U,$J,358.3,10296,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10296,1,2,0)
 ;;=2^070.51
 ;;^UTILITY(U,$J,358.3,10296,1,5,0)
 ;;=5^Hepatitis C,Acute w/o Coma
 ;;^UTILITY(U,$J,358.3,10296,2)
 ;;=Hepatitis C w/o coma^266632
 ;;^UTILITY(U,$J,358.3,10297,0)
 ;;=571.40^^61^670^17
 ;;^UTILITY(U,$J,358.3,10297,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10297,1,2,0)
 ;;=2^571.40
 ;;^UTILITY(U,$J,358.3,10297,1,5,0)
 ;;=5^Hepatitis,Unspecified
 ;;^UTILITY(U,$J,358.3,10297,2)
 ;;=Hepatitis, Unspecified^24390
 ;;^UTILITY(U,$J,358.3,10298,0)
 ;;=155.0^^61^670^22
 ;;^UTILITY(U,$J,358.3,10298,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10298,1,2,0)
 ;;=2^155.0
 ;;^UTILITY(U,$J,358.3,10298,1,5,0)
 ;;=5^Mal Neo Liver Primary
 ;;^UTILITY(U,$J,358.3,10298,2)
 ;;=CA of Liver, Primary^73526
 ;;^UTILITY(U,$J,358.3,10299,0)
 ;;=155.1^^61^670^20
 ;;^UTILITY(U,$J,358.3,10299,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10299,1,2,0)
 ;;=2^155.1
 ;;^UTILITY(U,$J,358.3,10299,1,5,0)
 ;;=5^Mal Neo Intrahepatic Ducts
 ;;^UTILITY(U,$J,358.3,10299,2)
 ;;=CA of Intrahepatic Ducts^267095
 ;;^UTILITY(U,$J,358.3,10300,0)
 ;;=197.7^^61^670^23
 ;;^UTILITY(U,$J,358.3,10300,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10300,1,2,0)
 ;;=2^197.7
 ;;^UTILITY(U,$J,358.3,10300,1,5,0)
 ;;=5^Mal Neo Liver Secondary
 ;;^UTILITY(U,$J,358.3,10300,2)
 ;;=CA of Liver, Secondary^267328
 ;;^UTILITY(U,$J,358.3,10301,0)
 ;;=155.2^^61^670^21
 ;;^UTILITY(U,$J,358.3,10301,1,0)
 ;;=^358.31IA^5^2
