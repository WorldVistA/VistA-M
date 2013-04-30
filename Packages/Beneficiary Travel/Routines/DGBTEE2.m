DGBTEE2 ;ALB/SCK BENEFICIARY TRAVEL ENTER/EDIT CONT; 03/23/93
 ;;1.0;Beneficiary Travel;**17,20**;September 25, 2001;Build 185
START ;
 Q
STUFF ;  stuff departure=home address, destination=division(ins) address, and attendant/payee=patient        
 S DGBTFR1=$S($G(CHZFLG):$P(DGBTVAR("D"),"^",1),1:VAPA(1)),DGBTFR2=$S($G(CHZFLG):$P(DGBTVAR("D"),"^",2),1:VAPA(2)),DGBTFR3=$S($G(CHZFLG):$P(DGBTVAR("D"),"^",3),1:VAPA(3)),DGBTAP=VADM(1)
 ;S DGBTFR1=$S('$G(CHZFLG):VAPA(1),1:$P(DGBTVAR("D"),"^",1)),DGBTFR2=$S('$G(CHZFLG):VAPA(2),1:$P(DGBTVAR("D"),"^",2)),DGBTFR3=$S('$G(CHZFLG):VAPA(3),1:$P(DGBTVAR("D"),"^",3)),DGBTAP=VADM(1)
 ; function call $$DEPCTY passes the zip code from the patient data, and returns with the departure city name or a null.
 ; if a null for the city is returned, the city name in the patient data is defaulted to.
 I '$G(CHZFLG) S XX=$$DEPCTY^DGBTUTL($P(VAPA(11),U,1)) S X=$S(+XX>0:$P(XX,U,2),1:VAPA(4))
 I $G(CHZFLG) S XX=$$DEPCTY^DGBTUTL($P(DGBTVAR("D"),"^",6)) S X=$S(+XX>0:$P(XX,U,2),1:$P(DGBTVAR("D"),"^",4))
 D UP^DGBTHELP S DGBTFR4=X
 K DGBTVAR(0) S DGBTVAR(0)=$S($D(^DGBT(392,DGBTDT,0)):^(0),1:"")
 S (DGBTDIV,DGBTDV1)=$P(DGBTVAR(0),"^",11),DGBTTO1=$P(^DG(40.8,DGBTDIV,0),"^"),DGBTDIV=$P(^DG(40.8,DGBTDIV,0),"^",7)
 S (DGBTTO2,DGBTTO3,DGBTTO4,X)=""
 I ('$G(CHZFLG)&($D(^DIC(4,DGBTDIV,1))#10=1)) S DGBTTO2=$P(^DIC(4,DGBTDIV,1),"^"),DGBTTO3=$P(^(1),"^",2),X=$P(^(1),"^",3) D UP^DGBTHELP S DGBTTO4=X Q  ; ref file #4, institution file by selected div
 S DGBTTO1=$P(DGBTVAR("T"),U),DGBTTO2=$P(DGBTVAR("T"),U,2),DGBTTO3=$P(DGBTVAR("T"),U,3) ;RFE DGBT*1.0*20
 S XX=$$DEPCTY^DGBTUTL($P(DGBTVAR("T"),"^",6)) S X=$S(+XX>0:$P(XX,U,2),1:$P(DGBTVAR("T"),"^",4)) ;RFE DGBT*1.0*20
 D UP^DGBTHELP S DGBTTO4=X ;RFE DGBT*1.0*20
 Q
DED ;
 I $D(^DG(43.1,$O(^DG(43.1,(9999999.99999-DGBTDT))),"BT")) D
 . S DGBTRATE=^("BT"),DGBTDPV=$P(DGBTRATE,"^"),DGBTDPM=$P(DGBTRATE,"^",2),DGBTMR=$P(DGBTRATE,"^",3) ; ref file #43, MAS parameters file for BT settings
 .; DGBTDPV = DEDUCTIBLE/VISIT     DGBTDPM = DEDUCTIBLE/MONTH     DGBTMR = MILEAGE RATE    DGBTDCM = Deductible paid for this month
 I $D(^DGBT(392,DGBTDT,"M")) I $P(^("M"),"^")=1 S DGBTDPV=DGBTDPV/2 ; ref file #392, claims file.
 S DGBTDRM=DGBTDPM-DGBTDCM ; Deductible to be paid
 I DGBTDRM<0 S DGBTDRM=0
 S DGBTDCV=0
 I DGBTDCM'<DGBTDPM S DGBTDCV=0
 I DGBTDRM'<DGBTDPV&(DGBTTC'<DGBTDPV) S DGBTDCV=DGBTDPV
 I DGBTDRM'<DGBTDPV&(DGBTTC'>DGBTDPV) S DGBTDCV=DGBTTC
 I DGBTDRM'>DGBTDPV&(DGBTTC'>DGBTDRM) S DGBTDCV=DGBTTC
 I DGBTDRM'>DGBTDPV&(DGBTTC'<DGBTDRM) S DGBTDCV=DGBTDRM
 S DGBTDCV=$S(DGBTMLT-DGBTDCV'>0:DGBTMLT,1:DGBTDCV)
 I $G(DGBTDCV)>$G(DGBTDPV) S DGBTDCV=DGBTDPV
 I $G(DGBTCC),'$G(DGBTCCREQ),$G(DGBTME) S DGBTMETC=(DGBTMETC+DGBTMAF)
DED1 ;
 S DGBTDCV1=DGBTDCV    ;save orig value for deductible
 S DGBTDCVX="Computed"
 S:DGBTDCV (DGBTWAIVER,DGBTDCV)=$$DWAIVER^DGBTUTL(DFN,DGBTDCV,DGBTDT),DGBTDCVX=$P(DGBTDCV,U,2),DGBTDCV=+DGBTDCV    ;added by Pavel for patch 20
 I '$G(DGBTREF),$G(DGBTDCV) S DGBTDCV=$S($P(MONTOT,"^",1)>6:0,1:$G(DGBTDCV)),DGBTDCVX="Computed"
 I '$G(DGBTREF),$G(DGBTDCV),$G(DGBTCCREQ),$G(DGBTCC),$G(DGBTMLT),'$G(DGBTME) D  S DGBTDCVX="Mode of transportation is Common Carrier/with Mileage" Q
 .I '$G(DGBTREF),$G(DGBTWAIVER)'["Pension" S DGBTDCV=DGBTDCV1
 .I '$G(DGBTREF),DGBTDCV>$G(DGBTMLT) S DGBTDCV=DGBTMLT-DGBTDCV S:DGBTDCV<0 DGBTDCV=0,DGBTTC=DGBTTC-DGBTMLT
 I '$G(DGBTREF),$G(DGBTDCV),$G(DGBTCCREQ),$G(DGBTCC) S DGBTDCV=0,DGBTDCVX="Mode of transportation is Common Carrier" Q
 I '$G(DGBTREF),'$G(DGBTDCV),$G(DGBTCCREQ),$G(DGBTCC),'$G(DGBTME),'$G(DGBTMLT) S DGBTDCV=0,DGBTDCVX="Mode of transportation is Common Carrier" Q
 I '$G(DGBTREF),'$G(DGBTDCV),$G(DGBTCCREQ),$G(DGBTCC),$G(DGBTME),'$G(DGBTMLT) S DGBTDCV=0,DGBTDCVX="Mode of transportation is Common Carrier" Q
 I $G(DGBTREF),$G(DGBTDCV) S DGBTDCV=$S($P(MONTOT,"^",1)>6:0,1:$G(DGBTDCV)),DGBTDCVX="Patient refuse to provide financial information"
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
