GMVSC0 ;HOIFO/MD,YH,FT-CUMULATIVE VITALS/MEASUREMENTS FOR PATIENT OVER GIVEN DATE RANGE ;6/6/07
 ;;5.0;GEN. MED. REC. - VITALS;**23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ; #10039 - FILE 42 references     (supported)
 ; #10061 - ^VADPT calls           (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ;
EN1(RESULT,GMVDATA) ; GMV CUMULATIVE REPORT [RPC entry point]
 ; Cumulative Vitals Report
 ; DFN      - patient internal entry number (FILE 2)
 ; GMRVSDT  - start date/time of report range
 ; GMRVFDT  - end date/time of report range
 ; GMVDEV   - device name
 ; GMVIEN   - device internal entry name (FILE 3.5)
 ; GMVPDT   - date/time to print the report
 ; GMVWARD  - ward internal entry number (FILE 42)
 ; GMVHLOC  - hospital location internal entry number (FILE 44)
 ; GMVRMLST - list of room numbers separated by commas (e.g., 200,210)
 ;
 N DFN,GMRVSDT,GMRVFDT,GMVDEV,GMVIEN,GMVPDT,GMVWARD,GMVHLOC,GMVRMLST
 S DFN=$P(GMVDATA,U,1),GMRVSDT=$P(GMVDATA,U,2),GMRVFDT=$P(GMVDATA,U,3),GMVDEV=$P(GMVDATA,U,5),GMVIEN=+$P(GMVDATA,U,6),GMVPDT=$P(GMVDATA,U,7),GMVWARD=$P(GMVDATA,U,8),GMVHLOC=$P(GMVDATA,U,9),GMVRMLST=$P(GMVDATA,U,10)
 S ZTIO=GMVDEV ;device
 S ZTDTH=$S($G(GMVPDT)>0:GMVPDT,1:$$NOW^XLFDT()) ;date/time to print
 S (ZTSAVE("DFN"),ZTSAVE("GMRVSDT"),ZTSAVE("GMRVFDT"))=""
 S (ZTSAVE("GMVWARD"),ZTSAVE("GMVHLOC"),ZTSAVE("GMVRMLST"))=""
 S ZTDESC="Cumulative vital/measurement report"
 S ZTRTN="START^GMVSC0"
 D ^%ZTLOAD
 S RESULT=$S($G(ZTSK)>0:"Report sent to device. Task #: "_ZTSK,1:"Unable to task the report.")
 K ZTSK,ZTIO,ZTDTH,ZTSAVE,ZTDESC,ZTRTN
 Q
START ; Start the report output
 S:$D(ZTQUEUED) ZTREQ="@"
 ; if selected roombeds, then set up GMVROOM array
 I $L(GMVRMLST)>0 D
 .F GMVLOOP=1:1 Q:$P(GMVRMLST,",",GMVLOOP)=""  D
 ..S GMVROOM($P(GMVRMLST,",",GMVLOOP))=""
 ..Q
 .Q
 S GMVEDB=$S(DFN>0:"P",GMVRMLST]"":"S",1:"A") ;P is one patient, A is whole ward, S is selected rooms
 S GMVWARD(1)=$S(GMVWARD>0:$P($G(^DIC(42,GMVWARD,0)),U,1),1:"") ;ward name
 I $G(GMVEDB)="P" D
 .D DEM^VADPT,INP^VADPT
 .S GMRRMBD=$S(VAIN(5)'="":VAIN(5),1:"  BLANK") ;roombed
 .S GMVNAME=$S(VADM(1)'="":VADM(1),1:"  BLANK") ;patient name
 .S GMVWARD=$P(VAIN(4),"^") ;ward ien
 .S GMVWARD(1)=$P(VAIN(4),"^",2) ;ward name
 .D KVAR^VADPT K VA ;kill VADPT variables
 .S ^TMP($J,GMRRMBD,GMVNAME,DFN)=""
 E  D WARD^GMVDS1 ;returns TMP global with list of patients
 S (GMROUT,GMRPG)=0
 S GMVRANGE=$$FMTE^XLFDT(GMRVSDT)_"-"_$$FMTE^XLFDT(GMRVFDT)
 D NOW^%DTC S Y=% D D^DIQ
 S GMRPDT=$P(Y,"@")_" ("_$P($P(Y,"@",2),":",1,2)_")"
 S $P(GMRDSH,"-",80)=""
 U IO
 S GMRRMBD=""
 N GPEDIS S GPEDIS=$O(^GMRD(120.52,"B","DORSALIS PEDIS",0)) Q:GPEDIS'>0
 F  S GMRRMBD=$O(^TMP($J,GMRRMBD)) Q:GMRRMBD=""!GMROUT  S GMRNAM="" F  S GMRNAM=$O(^TMP($J,GMRRMBD,GMRNAM)) Q:GMRNAM=""!GMROUT  S DFN=0 F  S DFN=$O(^TMP($J,GMRRMBD,GMRNAM,DFN)) Q:DFN'>0!GMROUT  S GMRPG=0 D WRT Q:GMROUT  D EN1^GMVSC1
Q ; kill variables and quit
 D Q^GMVSC1
 K ^TMP($J)
 K GMRBMI,GMRVHT,GMRINF,GMRPG,GMREDB,GMRNAM,GMRRMBD,GMRVWLOC,GMRWARD,GMRMSL,GMRROOM,GMRRMST,GMRVHLOC,GMRLEN,GMRI,GMROUT,GMRVSDT,GMRVFDT,GPRT,GMVLOOP
 K GMVRMLST,GMVRANGE
 D ^%ZISC
 Q
FOOTER ;REPORT FOOTER {called from GMVSC1, GMVSC2} 
 W !!,"*** (E) - Error entry",!! W:VADM(1)'="" ?$X-3,$E(VADM(1),1,15) W:VADM(2)'="" ?17,$E($P(VADM(2),"^",2),8,11) W:VADM(3)'="" ?30,$P(VADM(3),"^",2) W:VADM(4)'="" ?43,$P(VADM(4),"^")_" YRS"
 W:VADM(5)'="" ?51,$P(VADM(5),"^",2)
 W ?65,"VAF 10-7987j" W !,"Unit: "_$S($P(VAIN(4),"^",2)'="":$P(VAIN(4),"^",2),1:"     "),?32,"Room: "_$S($P(VAIN(5),"^")'="":$P(VAIN(5),"^"),1:"   "),!
 I '$D(GMRVHLOC) S GMRVHLOC=$$HOSPLOC^GMVUTL1(+$G(VAIN(4)))
 W "Division: "_$$DIVISION^GMVUTL1(+GMRVHLOC),!
 Q
WRT ;
 S GMR1ST=1
 K GMRSITE
 D DEM^VADPT,INP^VADPT
 S GWARD=$S($P(VAIN(4),"^",2)'="":$P(VAIN(4),"^",2),1:"   ")
 S GBED=$S(VAIN(5)'="":$P(VAIN(5),"^"),1:"   ")
 D HDR^GMVSC2
 Q
