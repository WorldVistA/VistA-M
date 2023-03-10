ECINCPT ;ALB/JAM-Procedure Codes with Inactive CPTs Report ;Jan 04, 2021@17:52
 ;;2.0;EVENT CAPTURE;**72,119,152**;8 May 96;Build 19
 ; Routine to report National/Local Procedure Codes with Inactive CPT
 ; Codes Report
EN ;entry point
 N ZTIO,ZTDESC,ZTRTN,ECPG,ECOUT
 S ZTIO=ION
 S ZTDESC="NATIONAL/LOCAL PROCEDURE CODES WITH INACTIVE CPT"
 S ZTRTN="START^ECINCPT"
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
 I POP Q
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 Q
START ; Routine execution
 ;     Variables passed in -152
 ;       ECPTYP   - Where to send output (P)rinter, (D)evice or screen
 ;                  or (E)xport
 ;       ECRN     - Preferred Report (N-ational, L-ocal or Both)
 ;       ECSM     - Sort Method (P-rocedure Name, N-ational Number,C-PT Code,D-Inactive Date)
 ;       ECSORT  - Sort Order "A"scending, "D"escending
 ;
 ;
 N ECI,EC0,ECPT,ECN,ECD,ECPI,ECDT,ECPG,ECOUT,ECRDT,CNT ;119
 S (ECI,ECOUT)=0,ECPG=1,CNT=1 ;119
 N ECPTDT,ECINDX,I,NM,IEN,DATA,ECSRTBY ;152
 S %H=$H S ECRDT=$$HTE^XLFDT(%H,1)
 ;I $G(ECPTYP)="E" S ^TMP($J,"ECRPT",CNT)="NATIONAL NUMBER^NATIONAL NAME^CPT CODE^INACTIVE DATE" ;119,152 - Commented this line
 ;I $G(ECPTYP)'="E" D HEADER ;119,152 - Commented this line
 S ECSRTBY(ECSM)=$S(ECSM="P":"ECD",ECSM="N":"ECN",ECSM="C":"ECPT",1:"ECPTDT") ;152
 F  S ECI=$O(^EC(725,ECI)) Q:'ECI  D  I ECOUT Q
 .S EC0=$G(^EC(725,ECI,0)),ECPT=$P(EC0,"^",5)
 .Q:EC0=""  Q:ECPT=""
 .S ECN=$P(EC0,"^",2),ECD=$P(EC0,"^"),ECPI=$$CPT^ICPTCOD(ECPT)
 .Q:+ECPI<1  Q:$P(ECPI,"^",7)
 .;152 - Begins
 .I $G(ECRN)="N"&(ECI>89999) Q  ; If looking for nation entries and entry has a local number, quit
 .I $G(ECRN)="L"&(ECI<90000) Q  ; If looking for local entries and entry has a national number, quit
 .S ECDT=$TR($$FMTE^XLFDT($P(ECPI,"^",8),"2F")," ","0")
 .S ECPTDT=$P(ECPI,U,8),ECPT=$P(ECPI,U,2)
 .;I $G(ECPTYP)'="E" I ($Y+3)>IOSL D PAGE Q:ECOUT  D HEADER ;119
 .;I $G(ECPTYP)="E" S CNT=CNT+1,^TMP($J,"ECRPT",CNT)=ECN_U_ECD_U_$P(ECPI,U,2)_U_ECDT Q  ;119
 .;W !,ECN,?10,ECD,?60,$P(ECPI,"^",2),?68,ECDT 
 .S ^TMP($J,"ECRPT",@ECSRTBY(ECSM),ECN,ECD)=ECN_U_ECD_U_$P(ECPI,U,2)_U_ECDT
 .;152 - Ends
 D PRINT(ECSORT) ;152 - Added this line 
 ;I $G(ECPTYP)'="E" I 'ECOUT D PAGE ;119,152 - Commented this line
 Q
PRINT(PORD) ; 152 - Added this tag to print report according to the sort order
 ; PORD to Print: "A"scending or "D"escending
 N I,I1,I2,LINE
 S PORD=$S(PORD="A":1,1:-1)
 I $G(ECPTYP)="E" D EXPORT(PORD) G END
 S I=""
 I $G(ECPTYP)'="E" D HEADER
 F  S I=$O(^TMP($J,"ECRPT",I),PORD) Q:I=""  D
 .S I1="" F  S I1=$O(^TMP($J,"ECRPT",I,I1),PORD) Q:I1=""  D
 ..S I2="" F  S I2=$O(^TMP($J,"ECRPT",I,I1,I2),PORD) Q:I2=""  D
 ...S LINE=^TMP($J,"ECRPT",I,I1,I2)
 ...W !,$P(LINE,U),?10,$P(LINE,U,2),?60,$P(LINE,U,3),?68,$P(LINE,U,4)
 ...I ($Y+4)>IOSL D HEADER  ;D PAGE Q:ECOUT  D HEADER ;152
 .I ($Y+4)>IOSL D HEADER ;152
 I $G(ECPTYP)'="E" I 'ECOUT D PAGE ;119
END D ^ECKILL Q:$D(ECGUI)!($G(ECPTYP)="E")  W @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"  ;152
 Q
HEADER ;
 N I,SORT ;152
 S SORT=$S(ECSM="P":"Procedure Name",ECSM="N":"Procedure Number",ECSM="C":"CPT Code",1:"CPT Inactive Date") ;152
 W:$E(IOST,1,2)="C-"!(ECPG>1) @IOF
 W $S(ECRN="N":"NATIONAL",ECRN="L":"LOCAL",1:"NATIONAL/LOCAL")_" PROCEDURE CODES WITH INACTIVE CPT CODES" ;152
 W ?68,"Page: ",ECPG,!?(80-(10+$L(ECRDT))\2),"Run Date : ",ECRDT,! ;152 center the 2nd  line
 W ?(80-(9+$L(SORT))\2),"Sorted by ",SORT,! ;152
 W "Procedure",?60,"CPT",?68,"Inactive",! ;152 Changed "National" to "Procedure"
 W "Number",?10,"Procedure Name",?60,"Code",?68,"Date",! ;152 Change "National" to "Procedure"
 S ECPG=ECPG+1
 F I=1:1:80 W "-"
 Q
PAGE ;
 N SS,JJ
 I $D(ECPG),$E(IOST,1,2)="C-" D
 . S SS=22-$Y F JJ=1:1:SS W !
 . S DIR(0)="E" W ! D ^DIR K DIR I 'Y S ECOUT=1
 Q
EXPORT(PORD) ;152 - Created this tag for export format
 ;PORD: Print Order : Ascending or Descending.
 N I,I1,I2,LINE
 Q:'$D(^TMP($J,"ECRPT"))
 M ^TMP("ECINCPT",$J)=^TMP($J,"ECRPT")
 K ^TMP($J,"ECRPT")
 S CNT=1,I=""
 S ^TMP($J,"ECRPT",CNT)="PROCEDURE NUMBER^PROCEDURE NAME^CPT CODE^INACTIVE DATE"
 F  S I=$O(^TMP("ECINCPT",$J,I),PORD) Q:I=""  D
 .S I1="" F  S I1=$O(^TMP("ECINCPT",$J,I,I1),PORD) Q:I1=""  D
 ..S I2="" F  S I2=$O(^TMP("ECINCPT",$J,I,I1,I2),PORD) Q:I2=""  D
 ...S LINE=^TMP("ECINCPT",$J,I,I1,I2)
 ...S CNT=CNT+1
 ...S ^TMP($J,"ECRPT",CNT)=LINE
 K ^TMP("ECINCPT",$J)
 Q
