SPNPRT10 ;SAN/CM- Print basic info patient list ; 11/5/99
 ;;2.0;Spinal Cord Dysfunction;**11,12,13**;01/02/1997
 ;
EN1 ; Main Entry Point
 S SPNC=0 ;Line counter
 N SPNLEXIT,SPNIO
 S SPNLEXIT=0 D EN1^SPNPRTMT Q:SPNLEXIT  ;Filters
 F SPNG="SPNPAGE","SPNC","SPNNAME","SPNDFN" S:$D(@SPNG) ZTSAVE(SPNG)=""
 W !!,"### This report is designed for 132 column viewing/printing     ###"
 W !,"### Set your terminal display to 132 columns                    ###"
 W !,"### For screen viewing, answer DEVICE prompt with 0;132         ###"
 W !,"### For file capture, answer DEVICE prompt with 0;132;9999      ###"
 W !,"### For a hardcopy, answer with a 132 column printer or subtype ###",!
 D DEVICE^SPNPRTMT("PRINT^SPNPRT10","SCD Basic Patient Data",.ZTSAVE) Q:SPNLEXIT
 I SPNIO="Q" D EXIT Q  ; Print was Queued
 I IO'="" D PRINT D EXIT Q  ; Print was not Queued
 Q
EXIT ; Exit routine 
 K ^TMP($J,"SPN"),^TMP($J,"SPNPRT","AUTO"),^TMP($J,"SPNPRT","POST")
 K SPNANS,SPNC,SPNG,SPNNAME,ZTSAVE,VADM,VAPA,VA
 Q
PRINT ; Print main Body
 U IO
 K ^TMP($J,"SPN")
 S SPNLEXIT=$G(SPNLEXIT) ; Ensure that the exit is set
 N SPNDFN,SPNX
 S (SPNDFN,SPNLPRT)=0
 W !!?40,"************ BASIC PATIENT INFORMATION *************"
 W !?62,$$FMTE^XLFDT($$NOW^XLFDT,"5D")
 W !!,"Patient",?20,"SSN",?33,"DOB",?45,"Phone",?60,"Street Address 1",?88,"Street Address 2",?107,"City",?123,"St",?126,"Zip"
 F  S SPNDFN=$O(^SPNL(154,SPNDFN)) Q:SPNDFN<1  D  Q:SPNLEXIT
 . Q:SPNLEXIT
 . Q:$G(^SPNL(154,SPNDFN,0))=""  ; No Zero node
 . I '$$EN2^SPNPRTMT(SPNDFN) Q  ; Patient fail the filters
 . S DFN=SPNDFN D DEM^VADPT
 . S ^TMP($J,"SPN",VADM(1),SPNDFN)="" ; Sort the data
 . D KVAR^VADPT
 . Q
 I $D(^TMP($J,"SPN")) D  Q:SPNLEXIT  ; Indicates the report had data
 . S SPNNAME="" F  S SPNNAME=$O(^TMP($J,"SPN",SPNNAME)) Q:SPNNAME=""  Q:SPNLEXIT  S SPNDFN=0 F  S SPNDFN=$O(^TMP($J,"SPN",SPNNAME,SPNDFN)) Q:SPNDFN<1  D  Q:SPNLEXIT
 .. I $E(IOST,1)="C",(IOSL<26) S SPNC=SPNC+1 I SPNC=22 R !!,"Enter RETURN to continue or '^' to exit: ",SPNANS:DTIME
 .. I $G(SPNANS)="^" S SPNLEXIT=1
 .. I SPNC=22 S SPNC=0
 .. D PATIENT(SPNDFN)
 .. Q
 . Q
 E  W !,"     ******* No Data for this report *******"
 I $E(IOST,1)="C" N DIR S DIR(0)="E" D ^DIR  K Y
 D CLOSE^SPNPRTMT
 K ^TMP($J,"SPN")
 Q
PATIENT(SPNDFN) ;PRINT PATIENT DATA
 ;INPUT:
 ; SPNFDFN = patient DFN
 ;
 N SPNX
 S DFN=SPNDFN D DEM^VADPT ; Get patient data
 S DFN=SPNDFN D ADD^VADPT
 W !,$E(VADM(1),1,19),?20,VA("PID"),?33,$$FMTE^XLFDT(VADM(3),"5DZ"),?45,$S(VAPA(8)'="":VAPA(8),1:""),?60,$S(VAPA(1)'="":$E(VAPA(1),1,28),1:""),?88,$S(VAPA(2)'="":$E(VAPA(2),1,19),1:""),?107,$S(VAPA(4)'="":VAPA(4),1:"")
 W ?123,$S(VAPA(5)'="":$P(^DIC(5,$P(VAPA(5),U,1),0),U,2),1:""),?126,$S(VAPA(6)'="":VAPA(6),1:"")
 D KVAR^VADPT ; Clean up VA Stuff
 Q
