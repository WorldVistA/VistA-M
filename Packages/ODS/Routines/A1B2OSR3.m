A1B2OSR3 ;ALB/AAS - PRINT ODS SUMMARY REPORT ; 11-JAN-91
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
 ;
RPRT ;  --write report
 D HDR^A1B2OSR2 W !
 S X="Total Admissions",Y=$S($D(^UTILITY($J,"ODS-ADM-NAT")):^("ODS-ADM-NAT"),1:0) D LINE^A1B2OSR2 Q:A1B2QUIT
 S X="Total Discharges",Y=$S($D(^UTILITY($J,"ODS-DIS-NAT")):^("ODS-DIS-NAT"),1:0) D LINE^A1B2OSR2 Q:A1B2QUIT
 S X="Patients Treated",Y=Y+$S($D(^UTILITY($J,"ODS-PTRM-NAT")):^("ODS-PTRM-NAT"),1:0) D LINE^A1B2OSR2 Q:A1B2QUIT
 S X="No. Unique Patients Admitted",Y=$S($D(^UTILITY($J,"ODS-UNQ-ADM-NAT")):^("ODS-UNQ-ADM-NAT"),1:0) D LINE^A1B2OSR2 Q:A1B2QUIT
 I $D(^UTILITY($J,"ODS-UNQA-SPC-NAT")) W ! S X="No. Pts. Admitted to",Y="" D LINE^A1B2OSR2 Q:A1B2QUIT  D SPC Q:A1B2QUIT
 I $D(^UTILITY($J,"ODS-UNQA-BOS-NAT")) W ! S X="No. Pts. Admitted from",Y="" D LINE^A1B2OSR2 Q:A1B2QUIT  D BOS Q:A1B2QUIT
 W ! S X="No. ODS pts. to Non-VA Care",Y=$S($D(^UTILITY($J,"ODS-TRF-NVA-NAT")):^("ODS-TRF-NVA-NAT"),1:0) D LINE^A1B2OSR2 Q:A1B2QUIT
 S X="No. Vets Displaced to Non-VA Care",Y=$S($D(^UTILITY($J,"ODS-DISP-NVA-NAT")):^("ODS-DISP-NVA-NAT"),1:0) D LINE^A1B2OSR2 Q:A1B2QUIT
 S X="No. Vets Displaced to VA Care",Y=$S($D(^UTILITY($J,"ODS-DISP-VA-NAT")):^("ODS-DISP-VA-NAT"),1:0) D LINE^A1B2OSR2 Q:A1B2QUIT
 F M=0:0 Q:($Y+6)>IOSL  W !
 W ?IOM-30,"DATE PRINTED: ",A1B2DATE,!
 Q
 ;
SPC S SPC="" F J=0:0 S SPC=$O(^UTILITY($J,"ODS-UNQA-SPC-NAT",SPC)) Q:SPC=""!(A1B2QUIT)  S Y=^(SPC),X=$P($T(@(SPC)),";",3) D LINE^A1B2OSR2 Q:A1B2QUIT
 Q
 ;
BOS S BOS="" F J=0:0 S BOS=$O(^UTILITY($J,"ODS-UNQA-BOS-NAT",BOS)) Q:BOS=""!(A1B2QUIT)  S Y=^(BOS),X=$S($D(^DIC(23,BOS,0)):$P(^(0),"^"),1:"UNKNOWN") D LINE^A1B2OSR2 Q:A1B2QUIT
 Q
 ;
M ;;Medicine
S ;;Surgery
R ;;Rehab Medicine
P ;;Psychiatry
NH ;;NHCU
I ;;Intermediate
SCI ;;Spinal Cord Injury
D ;;Domiciliary
B ;;Blind Rehab
RE ;;Respite Care
NE ;;Neurology
