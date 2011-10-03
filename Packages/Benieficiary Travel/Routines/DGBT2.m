DGBT2 ;ALB/GAH - BENEFICIARY TRAVEL SCREEN 2 ; 10/11/2006
 ;;1.0;Beneficiary Travel;**7,8,13**;September 25, 2001;Build 11
 Q
SCREEN ;
 W @IOF
 W !?18,"Beneficiary Travel Claim Information <Screen 2>"
 D PID^VADPT6 W !!?8,"Name: ",VADM(1),?42,"PT ID: ",VA("PID"),?64,"DOB: ",$P(VADM(3),"^",2)
 D PAST,ADM
 W !!?2,"Visits For: " W $P(DGBTDTE,"@")
 S DGBTAS="" S:DGBTAD DGBTAS=$S($P(DGBTDD,".")=$P(DGBTDTI,"."):"D",$P(DGBTAD,".")=$P(DGBTDTI,"."):"A",$P(DGBTAD,".")&'$P(DGBTDD,"."):"I",$P(DGBTAD,".")&($P(DGBTDTI,".")'>$P(DGBTDD,".")):"II",1:"")
 I DGBTAS]"" W $S(DGBTAS="A":" * * * * ADMITTED ON THIS DATE * * * *",DGBTAS="D":" * * * * DISCHARGED ON THIS DATE * * * *",DGBTAS="I":" * * * * CURRENTLY AN INPATIENT * * * *",DGBTAS="II":" * * * INPATIENT STATUS * * *",1:"")
 I DGBTAS]"" W !!," Admitted On: " S Y=+DGBTAD X ^DD("DD") W Y K Y W:$D(^DPT(DFN,.1)) ?40,"Ward Location: ",^DPT(DFN,.1) I DGBTDD W ?40,"Discharge Date: " S Y=+DGBTDD X ^DD("DD") W Y K Y
 W !!,"Appointments: " W:'$D(DGBTCL) "NONE RECORDED FOR THIS DATE"
 D
 . I $D(DGBTCL("ERROR")) W ?14,DGBTCL("ERROR") Q
 . I $D(DGBTCL) F I=0:0 S I=$O(DGBTCL(I)) Q:'I  D APPT
 N DGVAL,DGCBK,DGDT1
 ;
 S DGVAL("DFN")=DFN,DGVAL("BDT")=DGBTDTI\1,DGVAL("EDT")=DGVAL("BDT")_".9999"
 S DGCBK="I $P(SDOE0,U,8)=2 D WRTVIS^DGBT2(SDOE0) S DGDT1=+SDOE0",DGDT1=""
 D SCAN^DGSDU("PATIENT/DATE",.DGVAL,"",DGCBK,1,.DGQUERY)
EXIT ;
 K VAIP
 Q
 ;
WRTVIS(DGBTCSN) ;
 S:$S('DGDT1:0,1:+SDOE0'=DGDT1) SDSTOP=1
 I '$G(DGDT1) W !!?45,"Elig for Visit:",?65,"Appt Type:",!?45,"______________",?65,"_________",!!,"Clinic Stop: "
 I 'SDSTOP D
 .N DGBTCS
 .S:$P(DGBTCSN,U,3) DGBTCS=$P(DGBTCSN,U,3)
 .W ?14,$E($S($D(^DIC(40.7,+$P($G(DGBTCSN),U,3),0)):$P(^(0),U),1:"Unknown"),1,20),?45,$S($D(^DIC(8,+$P(DGBTCSN,U,13),0)):$E($P(^(0),U),1,18),1:"")
 .D STOP
 Q
 ;
ADM S DGBTAN=$S($D(^DPT(DFN,.105)):^(.105),1:"")
 I 'DGBTAN D NOW^%DTC S DGBTDI=+$O(^DGPM("ATID3",DFN,9999999.9999999-%)),DGBTDN=+$O(^(DGBTDI,0)),DGBTAN=$S($D(^DGPM(DGBTDN,0)):$P(^(0),"^",14),1:"")
 S DGBTAD=$S($D(^DGPM(+DGBTAN,0)):^(0),1:""),DGBTDD=$S($D(^DGPM(+$P(DGBTAD,"^",17),0)):^(0),1:"")
 K %,DGBTDI,DGBTDN Q
STOP I $D(DGBTCS) W ?65,$E($S($D(^SD(409.1,+$P(DGBTCSN,"^",10),0)):$P(^(0),"^"),1:"REGULAR"),1,15),!
 Q
APPT ;
 I $D(DGBTCL) D
 .W ?14,$P(DGBTCL(I),U)," ("_$$FMTE^DILIBF(I,"5U")_")"
 .S X=$P(DGBTCL(I),U,2)
 .W ?50,$S(X["NT":"NO ACTION TAKEN",X["N":"NO-SHOW",X["C":"CANCELLED",1:"")
 .W ?66,$P("C&P^10-10^SCHED.^UNSCHED.",U,+$P(DGBTCL(I),U,3))
 .W ?73,$S($D(^SD(409.1,+$P(DGBTCL(I),U,4),0)):$P(^SD(409.1,+$P(DGBTCL(I),U,4),0),U),1:"REGULAR"),!
 Q
PAST W:'$O(^DGBT(392,"AI",DFN,9999999.99999-DGBTDTI)) !!,"Past Claims: NONE RECORDED" I $O(^DGBT(392,"AI",DFN,9999999.99999-DGBTDTI)) W !!?14,"Date/Time",?35,"Account",?55,"Deductible",?69,"Amt. Paid",!!,"Past Claims: "
 S J=0 F DGBTP=9999999.99999-DGBTDTI:0 S DGBTP=$O(^DGBT(392,"AI",DFN,DGBTP)) Q:'DGBTP  S DGBTPDT=^DGBT(392,"AI",DFN,DGBTP),VADAT("W")=DGBTPDT D ^VADATE W ?14,VADATE("E") D ACCT S J=J+1 Q:J=5
 Q
ACCT W ?35,$S($P(^DGBT(392,DGBTPDT,0),"^",6):$E($P(^DGBT(392.3,$P(^(0),"^",6),0),"^"),1,15),1:"") D AMT
 Q
AMT N X3 ;Fresh copy for COMMA^%DTC. Leftovers causing error.
 S X=$P(^DGBT(392,DGBTPDT,0),"^",9),X2="2$" D COMMA^%DTC W ?54,X S X=$P(^(0),"^",10) D COMMA^%DTC W ?67,X,! K VADAT,VADATE,X,X2
 Q
