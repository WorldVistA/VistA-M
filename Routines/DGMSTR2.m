DGMSTR2 ;ALB/SCK - MST DETAILED DEMOGRAPHIC REPORT ; 11/19/03 10:56am
 ;;5.3;Registration;**195,555**;Aug 13, 1993
 ;
EN ; Main entry point for report
 ; Variable List
 ;     DGBEG   - Beginning of date range (FM date)
 ;     DGEND   - End of date range (FM Date)
 ;     DGMST   - array of MST status codes
 ;     DGSEX   - Patient gender to filter on
 ;     DGPOS   - array of period of service values to filter on
 ;     DGDISP  - Sort report on
 ;     DGSDAT  - start date selection
 ;     DGEDAT  - end date selection
 ;     RPTREF  - location of report data array
 ;     RPTARRY - temporary location of report array
 ;     DGX     - temporary variable
 ;     MSTST   - temporary variable holding MST status
 ;     MSTPOS  - temporary array of selected POS's
 ;     MSTNAME - temporary variable, patient name
 ;     MSTIEN  - temporary variable, IEN in MST HISTORY File (#29.11)
 ;     MSTACT  - temporary array, service in country indicated
 ;     MSTDT   - temporary variable, MST status change date
 ;
 N DGBEG,DGEND,DGMST,DGSEX,DGPOS,DGDISP,DGSDAT,DGEDAT,DIC,Y,X,ZTSAVE
 ;
 ;; Get beginning date for report
 K DIRUT
 S DIR(0)="DAO^:"_$$DT^XLFDT_":EX",DIR("A")="Start Date: "
 S DIR("?")="Enter beginning date of the reports date range."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S DGSDAT=+Y
 ;
 ;; Get ending date for report
 K DIRUT
 S DIR(0)="DAO^"_DGSDAT_":"_DT_":EX",DIR("A")="End Date: "
 S DIR("?")="Enter the ending date of the reports date range."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S DGEDAT=+Y_.9999
 ;
 ; Call procedure to select MST status codes to include
 D GETMST(.DGMST)
 Q:($O(DGMST(""))="")
 ;
 ;; Select gender for report
 K DIRUT
 S DIR(0)="SAO^M:Male;F:Female;B:Both"
 S DIR("A")="Gender to display MST status for: ",DIR("B")="Both"
 S DIR("?",1)="Select the gender to include on the report, either male,"
 S DIR("?")="female or both."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S DGSEX=Y
 ;
 ;; Select period of service to include
 N VAUTNI,VAUTSTR,VAUTVB
 S VAUTNI=0,VAUTSTR="Period of Service to include"
 S VAUTVB="DGPOS",DIC=21
 D FIRST^VAUTOMA
 ;
 ;; Select sort criteria
 K DIRUT
 S DIR(0)="SAO^P:Patient Name;S:Period of Service/Patient Name"
 S DIR("A")="Sort report by ",DIR("B")="Patient Name"
 S DIR("?",1)="Sort the report by either patient name, or by Period of"
 S DIR("?")="Service and within POS, by patient name."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S DGDISP=Y
 ;
 ;; Set up print device using KERNEL utility
 N ZTSAVE
 F X="DGPOS","DGPOS(","DGDISP","DGSEX","DGSDAT","DGEDAT","DGMST(" D
 . S ZTSAVE(X)=""
 W !!,"This report is formatted for 132 characters, and will not format"
 W !,"correctly on either an 80 column terminal or printer."
 W !!,"This report may take a while to build and print.  In order to"
 W !,"free up your workstation, please queue this report to print device."
 D EN^XUTMDEVQ("RPT^DGMSTR2","MST Detailed Report",.ZTSAVE)
 D HOME^%ZIS
 Q
 ;
RPT ; Main entry point for printing report form KERNEL device utility
 N FRSTPAS
 S RPTREF="^TMP(""DGMST DEM"","_$J_")"
 K @RPTREF
 D BUILD(DGSDAT,DGEDAT,.DGMST,DGSEX,.DGPOS,DGDISP,RPTREF)
 I DGDISP["P" D PRNNAME(DGSDAT,DGEDAT,DGDISP,RPTREF,.DGMST)
 I DGDISP["S" D PRNPOS(DGSDAT,DGEDAT,DGDISP,RPTREF,.DGMST)
 K @RPTREF,RPTREF
 Q
 ;
BUILD(DGBEG,DGEND,DGMST,DGSEX,DGPOS,DGDISP,RPTARRY) ;
 ;; Build the report array using the parameters entered by the user
 ;
 N MSTDT,DFN,LINE,MSTIEN,DGX,MSTDAT,VADM,VAEL,VAPA,VA
 S MSTDT=DGBEG
 F  S MSTDT=$O(^DGMS(29.11,"B",MSTDT)) Q:'MSTDT!(MSTDT>DGEND)  D
 . S MSTIEN=0
 . F  S MSTIEN=$O(^DGMS(29.11,"B",MSTDT,MSTIEN)) Q:'MSTIEN  D
 .. S MSTDAT=$G(^DGMS(29.11,MSTIEN,0))
 .. S DGX=$P(MSTDAT,U,3)
 .. Q:'($D(DGMST(DGX)))
 .. S DFN=$P(MSTDAT,U,2)
 .. S DGX=$$GETSTAT^DGMSTAPI(DFN)
 .. Q:MSTIEN'=+DGX
 .. D DEM^VADPT
 .. I '(DGSEX["B") Q:'(DGSEX[$P(VADM(5),U))
 .. D ELIG^VADPT
 .. I 'DGPOS S DGX=$P(VAEL(2),U) Q:'($D(DGPOS(+DGX)))
 .. S LINE=$G(LINE)+1
 .. I DGDISP["P" D
 ... S @RPTARRY@($P(MSTDAT,U,3),VADM(1),LINE)=DFN_U_MSTIEN
 .. E  D
 ... S @RPTARRY@($P(MSTDAT,U,3),$S(VAEL(2)]"":VAEL(2),1:"UNKNOWN"),VADM(1),LINE)=DFN_U_MSTIEN
 .. D KVAR^VADPT
 Q
 ;
PRNNAME(DGBEG,DGEND,DGDSP,RPTARRY,DGMST) ;
 ; Print out report on patient name sort.  One level of sort in the ^TMP global
 N MSTST,DFN,MSTPOS,MSTNAME,MSTIEN,DGQUIT,DGNDX,MSTDAT
 ;
 S MSTST=""
 F  S MSTST=$O(DGMST(MSTST)) Q:'(MSTST]"")  D  Q:$G(DGQUIT)
 . I $O(@RPTARRY@(MSTST,""))="" D  Q
 .. S X=$$HEADER(MSTST,DGDSP,DGBEG,DGEND)  ;DG*5.3*264
 .. W !!?5,"No data for MST status "_MSTST_" found."
 . S DGQUIT=$$HEADER(MSTST,DGDSP,DGBEG,DGEND) Q:$G(DGQUIT)
 . S (DGNDX,MSTNAME)=""
 . F  S MSTNAME=$O(@RPTARRY@(MSTST,MSTNAME)) Q:'(MSTNAME]"")  D  Q:$G(DGQUIT)
 .. F  S DGNDX=$O(@RPTARRY@(MSTST,MSTNAME,DGNDX)) Q:'(DGNDX]"")  D  Q:$G(DGQUIT)
 ... S MSTDAT=$G(^(DGNDX))
 ... S DFN=$P(MSTDAT,U),MSTIEN=$P(MSTDAT,U,2)
 ... D PRNTLN1(DFN,MSTIEN)
 ... I $Y+5>$G(IOSL) S DGQUIT=$$HEADER(MSTST,DGDSP,DGBEG,DGEND) Q:$G(DGQUIT)
 Q
 ;
PRNPOS(DGBEG,DGEND,DGDSP,RPTARRY,DGMST) ;
 ;  Print out report on period of service sort, Two levels of sort.
 N MSTST,DFN,MSTPOS,MSTNAME,MSTIEN,DGQUIT,DGX,DGNDX
 ;
 I '$O(@RPTARRY@(""))="" D  Q
 . S X=$$HEADER(MSTST,DGDSP,DGBEG,DGEND)
 . W !!?5,"No data for these parameters found."
 ;
 S MSTST=""
 F  S MSTST=$O(DGMST(MSTST)) Q:'(MSTST]"")  D  Q:$G(DGQUIT)
 . I $O(@RPTARRY@(MSTST,""))="" D  Q
 .. S X=$$HEADER(MSTST,DGDSP,DGBEG,DGEND)
 .. W !!?5,"No data for MST status "_MSTST_" found."
 . S DGQUIT=$$HEADER(MSTST,DGDSP,DGBEG,DGEND) Q:$G(DGQUIT)
 . S MSTPOS=""
 . F  S MSTPOS=$O(@RPTARRY@(MSTST,MSTPOS)) Q:'(MSTPOS]"")  D  Q:$G(DGQUIT)
 .. S (MSTNAME,DGNDX)=""
 .. F  S MSTNAME=$O(@RPTARRY@(MSTST,MSTPOS,MSTNAME)) Q:'(MSTNAME]"")  D  Q:$G(DGQUIT)
 ... F  S DGNDX=$O(@RPTARRY@(MSTST,MSTPOS,MSTNAME,DGNDX)) Q:'(DGNDX]"")  D  Q:$G(DGQUIT)
 .... S MSTDAT=$G(^(DGNDX))
 .... S DFN=$P(MSTDAT,U),MSTIEN=$P(MSTDAT,U,2)
 .... D PRNTLN1(DFN,MSTIEN)
 .... I $Y+5>$G(IOSL) S DGQUIT=$$HEADER(MSTST,DGDSP,DGBEG,DGEND) Q:$G(DGQUIT)
 Q
 ;
PRNTLN1(DFN,MSTIEN) ;  Format and print data for patient passed in
 N MSTACT,DGX,VADM,VAEL,VAPA,VA
 D DEM^VADPT,ELIG^VADPT,ADD^VADPT,ACTION(DFN,.MSTACT)
 ;
 W !,VA("BID")
 W ?6,$E(VADM(1),1,25)
 W ?32,$E(VAPA(1),1,25)
 W ?58,$P(VADM(5),U)
 W ?61,$E($P(VAEL(1),U,2),1,15)
 W ?80,$E($P(VAEL(2),U,2),1,15)
 W ?100,$G(MSTACT(1))
 W !
 S DGX=$E(VAPA(4),1,$L(VAPA(4)))_$S(VAPA(6)]"":", ",1:"  ")_$P(VAPA(5),U,2)_" "_VAPA(6)
 W ?32,$S($G(VAPA(2))]"":$E(VAPA(2),1,25),1:DGX)
 W ?100,$G(MSTACT(2))
 W !
 W ?32,$S($G(VAPA(2))]"":DGX,1:VAPA(8))
 W ?100,$G(MSTACT(3))
 W !
 W ?32,$S($G(VAPA(2))]"":VAPA(8),1:"")
 W ?100,$G(MSTACT(4))
 ;
 I $G(MSTACT(5))]"" D
 . W !?100,$G(MSTACT(5))
 . I $G(MSTACT(6))]"" D
 .. W !?100,$G(MSTACT(6))
 E  W !
 ;
 D KVAR^VADPT
 Q
 ;
HEADER(MSTST,DGDISP,DGBEG,DGEND) ;  Print report header
 N LINE,STR,SDASH
 I $G(FRSTPAS),$E(IOST,1,2)="C-" D PAUSE^VALM1 Q:'Y 1
 I '$G(FRSTPAS) D
 . S FRSTPAS=1
 . W @IOF
 E  D
 . W @IOF
 ;
 S STR="MST Detailed Demographic Report"
 S $P(LINE," ",(IOM/2)-($L(STR)/2))=""
 W !,LINE_STR
 S STR="MST Status: "_$S(MSTST["Y":"Yes",MSTST["N":"No",MSTST["D":"Declined",1:"Unknown")
 K LINE S $P(LINE," ",(IOM/2)-($L(STR)/2))=""
 W !,LINE_STR
 S STR="Sorted by: "_$S(DGDISP["P":"Patient",1:"Period of Service\Patient")
 K LINE S $P(LINE," ",(IOM/2)-($L(STR)/2))=""
 W !,LINE_STR
 S STR="Date Range: "_$$FMTE^XLFDT(DGBEG,"D")_" - "_$$FMTE^XLFDT(DGEND,"D")
 K LINE S $P(LINE," ",(IOM/2)-($L(STR)/2))=""
 W !,LINE_STR
 S STR="Date printed: "_$$FMTE^XLFDT($$NOW^XLFDT,"D")
 K LINE S $P(LINE," ",(IOM/2)-($L(STR)/2))=""
 W !,LINE_STR
 W !!
 W !?32,"ADDRESS",?82,"PERIOD"
 W !?6,"PATIENT",?32,"AND",?63,"ELIGIBILITY",?82,"OF"
 W !,"SSN",?6,"NAME",?32,"PHONE",?57,"SEX",?63,"CODE",?82,"SERVICE",?100,"SERVICE IND."
 W !
 S $P(SDASH,"-",IOM+1)=""
 W SDASH,!
 Q 0
 ;
ACTION(DFN,MSTRSLT) ;  Check for service indicated fields in PATIENT File (#2) for
 ; patient passed in.  Return local array with all entries flaged as yes in the 
 ; respective fields
 ;   .32101  - Vietnam
 ;   .3221   - Lebanon
 ;   .3224   - Grenada
 ;   .3227   - Panama
 ;   .32201  - Persian Gulf
 ;   .322016 - Somalia
 ; Output
 ;    MSTRSLT(n)="VIETNAM"
 ;
 N MSTACTN,NDX,LINE
 S DFN=DFN_","
 D GETS^DIQ(2,DFN,".32101;.3221;.3224;.3227;.32201;.322016","E","MSTACTN")
 S NDX=""
 F  S NDX=$O(MSTACTN(2,DFN,NDX)) Q:'NDX  D
 . S:MSTACTN(2,DFN,NDX,"E")["YES" LINE=$G(LINE)+1,MSTRSLT(LINE)=$$SERVICE(NDX)
 ;
 Q
 ;
SERVICE(NDX) ; Convert field number to text value
 Q $S(NDX=.32101:"VIETNAM",NDX=.3221:"LEBANON",NDX=.3224:"GRENADA",NDX=.3227:"PANAMA",NDX=.32201:"PERSIAN GULF",NDX=.322016:"SOMALIA",1:"UNKNOWN")
 ;
 ;
GETMST(MST) ; Multiple MST status code seletion, loops until user quites
NEXT S DIR(0)="29.11,3AO"
 S DIR("A")="Select MST status code: "
 S DIR("?")="Select one of the current MST status codes: Y/N/D/U."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S:'$D(MST(Y)) MST(Y)=""
 G NEXT
 Q
