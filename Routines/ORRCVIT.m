ORRCVIT ;SLC/MKB - Vitals utilities ; 25 Jul 2003  9:31 AM
 ;;1.0;CARE MANAGEMENT;;Jul 15, 2003
 ; 
 ; ID = "VIT:"_PatientID_;_MeasurementDate everywhere below
 ;
LIST(ORY,DFN,SDATE,EDATE,VALS) ; -- Return MAX sets of measurements for DFN
 ; in @ORY@(#) = Item=ID^^MeasurementDate in HL7 format, and if VALS
 ;             = Data=Vital^Value^Unit^MetricValue^Unit^BMI^SuppO2^CriticalFlag^Qualifiers
 ; RPC = ORRC VITALS BY PATIENT
 N ORN,GMRVSTR,CNT,IDT,VDT,TYPE,IFN,DATA,X K ^UTILITY($J,"GMRVD")
 S SDATE=$$HL7TFM^XLFDT($G(SDATE)),EDATE=$$HL7TFM^XLFDT($G(EDATE))
 S DFN=+$G(DFN),MAX=$S(SDATE&EDATE:100,1:5)
 I $G(EDATE),$L(EDATE,".")<2 S EDATE=EDATE_".2359"
 S GMRVSTR="BP;T;R;P;HT;WT;CVP;CG;PO2;PN",GMRVSTR(0)=SDATE_U_EDATE_U_MAX_"^1"
 D EN1^GMRVUT0 S ORY=$NA(^TMP($J,"ORRCVIT")),(ORN,CNT)=0 K @ORY
 S IDT=0 F  S IDT=$O(^UTILITY($J,"GMRVD",IDT)) Q:IDT<1  D  Q:CNT'<MAX
 . S VDT=9999999-IDT,CNT=CNT+1
 . S ORN=ORN+1,@ORY@(ORN)="Item=VIT:"_DFN_";"_VDT_U_U_VDT Q:'$G(VALS)
 . S TYPE="" F  S TYPE=$O(^UTILITY($J,"GMRVD",IDT,TYPE)) Q:TYPE=""  D
 .. S IFN=0 F  S IFN=$O(^UTILITY($J,"GMRVD",IDT,TYPE,IFN)) Q:IFN<1  S X=$G(^(IFN)) D
 ... D @TYPE ;return DATA w/relevant pieces
 ... S ORN=ORN+1,@ORY@(ORN)="Data="_DATA
 K ^UTILITY($J,"GMRVD")
 Q
 ;
DETAIL(ORY,VITAL) ; -- Return details of VITALs
 ; where VITAL(#) = ID
 ; in @ORY@(#) = Item=ID^^MeasurementDate in HL7 format
 ;             = Data=Vital^Value^Unit^MetricValue^Unit^BMI^SuppO2^CriticalFlag^Qualifiers
 ; RPC = ORRC VITALS BY ID
 N GMRVSTR,DFN,STRT,STOP,ORN,ORI,ID,IDT,VDT,TYPE,IFN,DATA,X
 K ^UTILITY($J,"GMRVD") D RANGE
 S GMRVSTR="BP;T;R;P;HT;WT;CVP;CG;PO2;PN",GMRVSTR(0)=STRT_U_STOP_"^100^1"
 D EN1^GMRVUT0 S ORY=$NA(^TMP($J,"ORRCVIT")),ORN=0 K @ORY
 S ORI=0 F  S ORI=$O(VITAL(ORI)) Q:ORI<1  S ID=$G(VITAL(ORI)) D
 . S VDT=$P(ID,";",2),IDT=9999999-VDT
 . S ORN=ORN+1,@ORY@(ORN)="Item="_ID_U_U_VDT
 . S TYPE="" F  S TYPE=$O(^UTILITY($J,"GMRVD",IDT,TYPE)) Q:TYPE=""  D
 .. S IFN=0 F  S IFN=$O(^UTILITY($J,"GMRVD",IDT,TYPE,IFN)) Q:IFN<1  S X=$G(^(IFN)) D
 ... D @TYPE ;return DATA w/relevant pieces
 ... S ORN=ORN+1,@ORY@(ORN)="Data="_DATA
 K ^UTILITY($J,"GMRVD")
 Q
 ;
RANGE ; -- Get STRT,STOP,DFN from VITALs
 N ORI,ID,VDT  S (STRT,STOP)=""
 S ORI=0 F  S ORI=$O(VITAL(ORI)) Q:ORI<1  S ID=$G(VITAL(ORI)) D
 . S DFN=+$P(ID,":",2),VDT=$P(ID,";",2)
 . I $S('$L(STRT):1,VDT<STRT:1,1:0) S STRT=VDT
 . I $S('$L(STOP):1,VDT>STOP:1,1:0) S STOP=VDT
 Q
 ;
 ; Return formatted DATA string from X:
 ;
BP ; -- Blood Pressure = B/P^value^^^^^^[*]^Q1;..;Qn
 S DATA="B/P^"_$P(X,U,8)_"^^^^^^"_$P(X,U,12)_U_$P(X,U,17)
 Q
T ; -- Temperature = Temp.^value^F^metric^C^^^[*]^Q1;..;Qn
 S DATA="Temp.^"_$P(X,U,8)_"^F^"_$P(X,U,13)_"^C^^^"_$P(X,U,12)_U_$P(X,U,17)
 Q
R ; -- Respiration = Resp.^value^^^^^^[*]^Q1;..;Qn
 S DATA="Resp.^"_$P(X,U,8)_"^^^^^^"_$P(X,U,12)_U_$P(X,U,17)
 Q
P ; -- Pulse = Pulse^value^^^^^^[*]^Q1;..;Qn
 S DATA="Pulse^"_$P(X,U,8)_"^^^^^^"_$P(X,U,12)_U_$P(X,U,17)
 Q
HT ; -- Height = Ht.^value^in^metric^cm^^^[*]^Q1;..;Qn
 S DATA="Ht.^"_$P(X,U,8)_"^in^"_$P(X,U,13)_"^cm^^^"_$P(X,U,12)_U_$P(X,U,17)
 Q
WT ; -- Weight = Wt.^value^lb^metric^kg^BodyMassIndex^^[*]^Q1;..;Qn
 S DATA="Wt.^"_$P(X,U,8)_"^lb^"_$P(X,U,13)_"^kg^"_$P(X,U,14)_U_U_$P(X,U,12)_U_$P(X,U,17)
 Q
CVP ; -- CenVenPress = CVP^value^cmH2O^^^^^[*]^Q1;..;Qn
 S DATA="CVP^"_$P(X,U,8)_"^cmH2O^^^^^"_$P(X,U,12)_U_$P(X,U,17)
 Q
CG ; -- Circm/Girth = C/G^value^in^metric^cm^^^[*]^Q1;..;Qn
 S DATA="C/G^"_$P(X,U,8)_"^in^"_$P(X,U,13)_"^cm^^^"_$P(X,U,12)_U_$P(X,U,17)
 Q
PO2 ; -- PulseOx = Pulse Ox^value^^^^^l/min of supplemental O2^[*]^Q1;..;Qn
 S DATA="Pulse Ox^"_$P(X,U,8)_"^^^^^"_$P(X,U,15)_U_$P(X,U,12)_U_$P(X,U,17)
 Q
PN ; -- Pain = Pain^value^^^^^^[*]^Q1;..;Qn
 S DATA="Pain^"_$P(X,U,8)_"^^^^^^"_$P(X,U,12)_U_$P(X,U,17)
 Q
 ;
IDS(ORY,DFN,SDATE,EDATE) ; --Return recent measurement IDs for DFN
 ; in @ORY@(DFN) = #sets ^ 1 if any are critical
 ;    @ORY@(DFN,ID) = * if critical, else null
 ; [from ORRCDPT1]
 N GMRVSTR,MAX,CNT,ABN,IDT,VDT,X
 S ORY=$NA(^TMP($J,"ORRCVIT")) K @ORY,^UTILITY($J,"GMRVD")
 S DFN=+$G(DFN),MAX=$S($G(SDATE)&$G(EDATE):100,1:5)
 I $G(EDATE),$L(EDATE,".")<2 S EDATE=EDATE_".2359" ;end of day
 S GMRVSTR="BP;T;R;P;HT;WT;CVP;CG;PO2;PN",GMRVSTR(0)=$G(SDATE)_U_$G(EDATE)_U_MAX_"^1"
 D EN1^GMRVUT0 S CNT=0,ABN=""
 S IDT=0 F  S IDT=$O(^UTILITY($J,"GMRVD",IDT)) Q:IDT<1  D  Q:CNT'<MAX
 . S VDT=9999999-IDT,CNT=CNT+1,X=$$ABN(IDT)
 . S @ORY@(DFN,"VIT:"_DFN_";"_VDT)=X S:$L(X) ABN=1
 S:CNT @ORY@(DFN)=CNT_U_ABN
 K ^UTILITY($J,"GMRVD")
 Q
 ;
ABN(IDT) ; -- Return * if any value from measurement set is critical, else null
 N Y,TYPE,IFN S Y=""
 S TYPE="" F  S TYPE=$O(^UTILITY($J,"GMRVD",IDT,TYPE)) Q:TYPE=""  D
 . S IFN=0 F  S IFN=$O(^UTILITY($J,"GMRVD",IDT,TYPE,IFN)) Q:IFN<1  S:$G(^(IFN))["*" Y="*"
 Q Y
