DGBTEE2 ;ALB/SCK BENEFICIARY TRAVEL ENTER/EDIT CONT; 03/23/93
 ;;1.0;Beneficiary Travel;**17**;September 25, 2001;Build 6
START ;
 Q
STUFF ;  stuff departure=home address, destination=division(ins) address, and attendant/payee=patient        
 S DGBTFR1=VAPA(1),DGBTFR2=VAPA(2),DGBTFR3=VAPA(3),DGBTAP=VADM(1)
 ; function call $$DEPCTY passes the zip code from the patient data, and returns with the departure city name or a null.
 ; if a null for the city is returned, the city name in the patient data is defaulted to.
 S XX=$$DEPCTY^DGBTUTL($P(VAPA(11),U,1)) S X=$S(+XX>0:$P(XX,U,2),1:VAPA(4))
 D UP^DGBTHELP S DGBTFR4=X
 K DGBTVAR(0) S DGBTVAR(0)=$S($D(^DGBT(392,DGBTDT,0)):^(0),1:"")
 S (DGBTDIV,DGBTDV1)=$P(DGBTVAR(0),"^",11),DGBTTO1=$P(^DG(40.8,DGBTDIV,0),"^"),DGBTDIV=$P(^DG(40.8,DGBTDIV,0),"^",7)
 S (DGBTTO2,DGBTTO3,DGBTTO4,X)=""
 I $D(^DIC(4,DGBTDIV,1))#10=1 S DGBTTO2=$P(^DIC(4,DGBTDIV,1),"^"),DGBTTO3=$P(^(1),"^",2),X=$P(^(1),"^",3) D UP^DGBTHELP S DGBTTO4=X ; ref file #4, institution file by selected div
 Q
DED ;
 F I=$E(DGBTDT,1,5)_"00.2399":0 S I=$O(^DGBT(392,"C",DFN,I)) Q:'I!($E(I,1,5)>$E(DGBTDT,1,5))  S DGBTDCM=DGBTDCM+($P(^DGBT(392,I,0),"^",9))
 I $D(^DG(43.1,$O(^DG(43.1,(9999999.99999-DGBTDT))),"BT")) D
 . S DGBTRATE=^("BT"),DGBTDPV=$P(DGBTRATE,"^"),DGBTDPM=$P(DGBTRATE,"^",2),DGBTMR=$P(DGBTRATE,"^",3) ; ref file #43, MAS parameters file for BT settings
 I $D(^DGBT(392,DGBTDT,"M")) I $P(^("M"),"^")=1 S DGBTDPV=DGBTDPV/2 ; ref file #392, claims file.
 S DGBTDRM=DGBTDPM-DGBTDCM
 I DGBTDRM<0 S DGBTDRM=0
 S DGBTDCV=$S(DGBTDCM'<DGBTDPM:0,DGBTDRM'<DGBTDPV&(DGBTTC'<DGBTDPV):DGBTDPV,DGBTDRM'<DGBTDPV&(DGBTTC'>DGBTDPV):DGBTTC,DGBTDRM'>DGBTDPV&(DGBTTC'>DGBTDRM):DGBTTC,DGBTDRM'>DGBTDPV&(DGBTTC'<DGBTDRM):DGBTDRM,1:0)
DED1 ;
 S DR="9////"_DGBTDCV_";9;S DGBTDE=X S:DGBTDE>DGBTTC DGBTDE=DGBTTC,DGBTFlAG=2 S:DGBTDE>DGBTDRM DGBTDE=DGBTDRM,DGBTFLAG=1"
 Q
RATES ;  checks parameter to ask meals & lodging, ferrys & bridges        
 S DGBTMLFB=$S($D(^DG(43,1,"BT")):$P(^DG(43,1,"BT"),"^",2),1:0)
 ;  mileage rate
 S DGBTMR=$S($D(^DG(43.1,$O(^DG(43.1,(9999999.99999-DGBTDT))),"BT")):$P(^("BT"),"^",3),1:0) ; ref file #43.1, MAS event rates file for BT rates
 S DGBTMR1=$S($D(^DG(43.1,$O(^DG(43.1,(9999999.99999-DGBTDT))),"BT")):$P(^("BT"),"^",5),1:0) ; ref file #43.1, MAS event rates file for BT rates
ELIG ;  lookup current eligibilities for patient and put into TMP list
 S DGBTCT=1,^TMP("DGBT",$J,DGBTCT)=VAEL(1)
 F I=0:0 S I=$O(VAEL(1,I)) Q:'I  S DGBTCT=DGBTCT+1,^TMP("DGBT",$J,DGBTCT)=VAEL(1,I)
 Q
ELIST ;
 W !!?5,"Primary and other entitled eligibilities for patient:",!
 I DGBTCT>1 F I=0:0 S I=$O(^TMP("DGBT",$J,I)) Q:'I  W !?10,$P(^TMP("DGBT",$J,I),U,2)
 Q
EXIT ;
 Q
