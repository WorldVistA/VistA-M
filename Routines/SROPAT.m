SROPAT ;B'HAM ISC/MAM - TRANSMIT PATIENT INFO ON REFERRAL ; 20 FEB 1990  7:00 AM
 ;;3.0; Surgery ;;24 Jun 93
 W @IOF,! S SRSOUT=0
 K DIC,DA S DIC=2,DIC(0)="QEAMZ",DIC("A")="Transmit data for which Patient ?  " D ^DIC I Y<0 S SRSOUT=1 G END
 S DFN=+Y D DEM^VADPT,ELIG^VADPT,ADD^VADPT
 K DIC S DIC=4.2,DIC(0)="QEAMZ",DIC("A")="Transmit Patient Information to which Medical Center ?  " D ^DIC I Y<0 S SRSOUT=1 G END
 S X="G.SURGERY REFERRAL@"_$P(Y(0),"^"),XMY(X)=""
 K ^TMP("SR",$J)
 S ^TMP("SR",$J,1)="Patient Name: "_$P(VADM(1),"^"),^TMP("SR",$J,2)="ID#: "_VA("PID")
 S ^TMP("SR",$J,3)="Date of Birth: "_$P(VADM(3),"^",2)_"    Sex: "_$P(VADM(5),"^",2),^TMP("SR",$J,4)="Marital Status: "_$P(VADM(10),"^",2)
 S ^TMP("SR",$J,5)="Religion: "_$P(VADM(9),"^",2),^TMP("SR",$J,6)="Elig. Code: "_$P(VAEL(1),"^",2)
 S ^TMP("SR",$J,7)="Period of Service: "_$P(VAEL(2),"^",2),^TMP("SR",$J,8)="Veteran (Y/N): "_$S($P(VAEL(4),"^"):"YES",1:"NO")
 S ^TMP("SR",$J,9)="Patient Type: "_$P(VAEL(6),"^",2)
 S ^TMP("SR",$J,10)=" ",^TMP("SR",$J,11)=" "
 S ^TMP("SR",$J,12)="Patient Address: "
 S ^TMP("SR",$J,13)=VAPA(1),^TMP("SR",$J,14)=VAPA(4)_", "_$P(VAPA(5),"^",2)_"  "_VAPA(6),^TMP("SR",$J,16)="Home Phone: "_VAPA(8)
 S XMSUB="REFERRAL FOR SURGERY",XMTEXT="^TMP(""SR"",$J,",XMDUZ=DUZ D ^XMD
 W !!,"Message Transmitted..."
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 K DA,DIC,SRSOUT,VADM,VAEL,VAPA,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,^TMP("SR",$J) W @IOF
 Q
