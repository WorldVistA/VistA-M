ANRVPR ;AUG/JLTP - PRINT VIST PATIENT RECORD ; 8 Jan 91 / 9:20 AM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
 S DIC="^ANRV(2040,",DIC(0)="AEMQ",DIC("A")="Select VIST PATIENT: "
 D ^DIC K DIC G:Y<0 EXIT S DFN=+^ANRV(2040,+Y,0)
 S %ZIS="QM",%ZIS("B")="" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^ANRVPR",ZTDESC="Print VIST Patient Record",ZTSAVE("DFN")="" D ^%ZTLOAD G EXIT
DQ ;------ Non-interactive Entry Point ------
 N %I,AGE,ANFTI,ANLF,ANLT,ANRF,ANRHI,ANRM,ANRV,ANRVC,ANRVH,ANRVJ,ANRVMR
 N ANRVMRL,ANRVFN,ANRVI,ANRVPG,ANRVPS,ANTXT,ANWRD,D0,DA,DGA1,DGT,DGX,DIC
 N DIRUT,DIQ,DR,I,PNM,SSN,VA,VAERR,X,X1,X2,FIELD,OFFSET,ANRVD
 U IO D INIT^ANRVPR2,GETDATA^ANRVPR2
 D PRINT G:$D(DIRUT) EXIT D FINISH^ANRVPR1
EXIT ; close device
 K DFN
 D ^%ZISC
 Q
CNTR ;
 W ?(IOM\2-($L(X)\2)),X Q
HDR ;
 W @IOF,! S ANRVPG=ANRVPG+1
 F ANRHI=0:0 S ANRHI=$O(ANRVH(ANRHI)) Q:'ANRHI  W ! S X=ANRVH(ANRHI) D CNTR
 W !! Q
FTR ; print footer
 F ANFTI=$Y:1:(IOSL-4) W !
 W !,PNM_"  "_SSN S X="Page "_ANRVPG D CNTR W ! ;THIS ONE FOR OTHER SITES
 Q
PRINT ;
 D HDR
 S ANRVD=0 F ANRVI=1:1 D  Q:FIELD=""
 .S FIELD=$P($T(FIELD+ANRVI),";;",2) Q:FIELD=""
 .S ANRVD=$O(ANRV(ANRVD)) Q:'ANRVD
 .I $Y>(IOSL-6) D PAGE I $D(DIRUT) S ANRVI=99 Q
 .W !,FIELD,?30,ANRV(ANRVD) W:ANRVI=5 !
 Q:$D(DIRUT)
 I $O(ANRV(16,0)) W !,"Dependent(s) Name(s): " D
 .F I=0:0 S I=$O(ANRV(16,I)) Q:'I  D
 ..I $Y>(IOSL-6) D PAGE I $D(DIRUT) S I=999999 Q
 ..W !?30,ANRV(16,I)
 Q:$D(DIRUT)
 W !!!,"VIST Eligibility:",?30,ANRV(17)
 W !,"Rated Disability:"
 F I=0:0 S I=$O(ANRV(17.1,I)) Q:'I  D
 .W:I>1 !
 .W ?30,ANRV(17.1,I)
 D:$Y>(IOSL-6) PAGE Q:$D(DIRUT)  W !!,"Eye Diagnosis: "
 F I=0:0 S I=$O(ANRV(17.5,I)) Q:'I  W:I>1 ! W ?30,ANRV(17.5,I)
 S X1="Eye Exam Date (Last):^^Visual Acuity Right Eye:^Visual Acuity Left Eye:^Visual Field Right Eye:^Visual Field Left Eye:"
 S X2=ANRV(18) D MULT Q:$D(DIRUT)
 W ! S X1="VIST Review Date (Last):^Status of Review:^Type of Review:^Eligibility on Review Date:"
 S X2=ANRV(19) D MULT Q:$D(DIRUT)
 I $D(DIRUT) Q
 W !,"Field Visit Date (Last):",?30,ANRV(20)
 D PAGE Q:$D(DIRUT)  W !! S X="VIS TEAM ASSESSMENT" D CNTR
 F OFFSET=1:1 S ANRF=$P($T(ANRF+OFFSET),";;",2) Q:ANRF=""  D  Q:$D(DIRUT)
 .D WP^ANRVPR1
 Q:$D(DIRUT)
 I $Y>(IOSL-6) D PAGE Q:$D(DIRUT)
 W !! S X="PLAN" D CNTR S ANRF=12 D WP^ANRVPR1
 Q
MULT ;------ Print all fields from a single ^DIZ node ------
 F ANRM=1:1:$L(X1,U) D
 .I $Y>(IOSL-6) D PAGE I $D(DIRUT) S ANRM=$L(X1,U)+1 Q
 .W:$P(X1,U,ANRM)]"" !,$P(X1,U,ANRM),?30,$P(X2,U,ANRM)
 Q
PAGE ;------ Go to a new page ------
 K DIRUT
 D FTR
 I $E(IOST)="C" R !,"Type ^ to exit or press RETURN...",X:DTIME S:'$T X="^"
 I X=U S DIRUT=1 Q
 D HDR Q
FIELD ;;
 ;;Name:
 ;;Address:
 ;;City,State,Zip:
 ;;County:
 ;;Phone:
 ;;Social Security Number:
 ;;VA Claim Number:
 ;;Location of Claim File:
 ;;Service Dates:
 ;;Branch of Service (Last):
 ;;Date of Birth:
 ;;Place of Birth:
 ;;Age:
 ;;Employment Status:
 ;;Marital Status:
 ;;Living Arrangement:
 ;;Number of Dependents:
 ;;Name of Spouse:
 ;;
ANRF ;;
 ;;4^General Health:
 ;;16^Financial/Benefits:
 ;;17^Patient History:
 ;;18^Activities:
 ;;19^Adjustment to Blindness:
 ;;20^Impressions:
 ;;
