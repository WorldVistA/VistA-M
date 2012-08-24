A1B2OSR2 ;ALB/AAS - PRINT ODS SUMMARY REPORT ; 11-JAN-91
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
% S CNTF=0,PAGE=0,TAB=IOM/2,A1B2QUIT=0 S Y=DT D D^DIQ S A1B2DATE=Y
 I '$D(^UTILITY($J)) W !,"No Matches Found"
 I 'A1B2NSR S FAC="" F I=0:0 S FAC=$O(^UTILITY($J,"ODS-FAC",FAC)) Q:FAC=""!(A1B2QUIT)  S CNTF=CNTF+1 D RPRT,PAUSE:'A1B2QUIT Q:A1B2QUIT
 ;I 'A1B2QUIT S A1B2NSR=1 D ^A1B2OSR3
 G END
 Q
 ;
PAUSE I $E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR S A1B2QUIT='Y
 Q
LINE ;  --write line in report
 I ($Y+6)>IOSL S A1B2X=X,A1B2Y=Y D PAUSE Q:A1B2QUIT  D HDR S X=A1B2X,Y=A1B2Y
 W !?(TAB-$L(X)),X,": ",Y Q
 ;
RPRT ;  --write report
 D HDR W !
 S X="Total Admissions",Y=$S($D(^UTILITY($J,"ODS-ADM",FAC)):^(FAC),1:0) D LINE Q:A1B2QUIT
 S X="Total Discharges",Y=$S($D(^UTILITY($J,"ODS-DIS",FAC)):^(FAC),1:0) D LINE Q:A1B2QUIT
 S X="Patients Treated",Y=Y+$S($D(^UTILITY($J,"ODS-PTRM",FAC)):^(FAC),1:0) D LINE Q:A1B2QUIT
 S X="No. Unique Patients Admitted",Y=$S($D(^UTILITY($J,"ODS-UNQ-ADM",FAC)):^(FAC),1:0) D LINE Q:A1B2QUIT
 I $D(^UTILITY($J,"ODS-UNQA-SPC",FAC)) W ! S X="No. Pts. Admitted to",Y="" D LINE Q:A1B2QUIT  D SPC Q:A1B2QUIT
 I $D(^UTILITY($J,"ODS-UNQA-BOS",FAC)) W ! S X="No. Pts. Admitted from",Y="" D LINE Q:A1B2QUIT  D BOS Q:A1B2QUIT
 W ! S X="No. ODS pts. to Non-VA Care",Y=$S($D(^UTILITY($J,"ODS-TRF-NVA",FAC)):^(FAC),1:0) D LINE Q:A1B2QUIT
 S X="No. Vets Displaced to Non-VA Care",Y=$S($D(^UTILITY($J,"ODS-DISP-NVA",FAC)):^(FAC),1:0) D LINE Q:A1B2QUIT
 S X="No. Vets Displaced to VA Care",Y=$S($D(^UTILITY($J,"ODS-DISP-VA",FAC)):^(FAC),1:0) D LINE Q:A1B2QUIT
 F M=0:0 Q:($Y+6)>IOSL  W !
 W ?IOM-30,"DATE PRINTED: ",A1B2DATE
 Q
 ;
HDR S PAGE=PAGE+1,X="OPERATION DESERT SHIELD" W @IOF,?(IOM-$L(X))/2,X,?(IOM-10),"PAGE: ",PAGE
 S X="STATISTICAL SUMMARY REPORT" W !!,?(IOM-$L(X))/2,X
 I A1B2NSR S X="Medical Center Summary Report" W !!,?(IOM-$L(X))/2,X
 I 'A1B2NSR S Y=FAC_" - "_^UTILITY($J,"ODS-FAC",FAC)
 I 'A1B2NSR S X="Medical Center: "_Y W !!,?(IOM-$L(X))/2,X
 S X="For Period: " S Y=A1B2BDT D D^DIQ S Y1=Y,Y=A1B2EDT/1 D D^DIQ S X=X_Y1_"  to  "_Y W !!,?(IOM-$L(X))/2,X
 S X="-----------------------------" W !,?(IOM-$L(X))/2,X
 I A1B2NSR S X="-----------------------------" W !,?(IOM-$L(X))/2,X
 Q
 ;
SPC S X1="" F J=0:0 S X1=$O(^UTILITY($J,"ODS-UNQA-SPC",FAC,X1)) Q:X1=""!(A1B2QUIT)  S Y=^(X1),X=$P($T(@(X1)),";",3) D LINE Q:A1B2QUIT
 Q
 ;
BOS S X1="" F J=0:0 S X1=$O(^UTILITY($J,"ODS-UNQA-BOS",FAC,X1)) Q:X1=""!(A1B2QUIT)  S Y=^(X1),X=$S($D(^DIC(23,X1,0)):$P(^(0),"^"),1:"UNKNOWN") D LINE Q:A1B2QUIT
 Q
 ;
END Q
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
