SCRPW301 ; BPFO/JRC - Performance Monitor Detailed Report ; 2/3/04 7:33am
 ;;5.3;SCHEDULING;**292,335**;AUG 13, 1993
 ;
EN ;Main entry point for generation of local detailed report
 ;Declare variable(s) and arrays
 N SCRNARR,SORTARR
 S SCRNARR="^TMP(""SCRPW"",$J,""SCRNARR"")"
 S SORTARR="^TMP(""SCRPW"",$J,""SORTARR"")"
 K @SCRNARR,@SORTARR
 ;Get time limit
 I '$$TLMT^SCRPW302(SCRNARR) D EX1 Q
 ;Get date frame
 I '$$DATE^SCRPW302("","",SCRNARR) D EX1 Q
 ;Get division (one/many/all)
 I '$$DIV^SCRPW302(SCRNARR) D EX1 Q
 ;Get provider (one/many/all)
 I '$$PROV^SCRPW302(SCRNARR) D EX1 Q
 ;Get stop code (one/man/all)
 I '$$DSS^SCRPW303(SCRNARR) D EX1 Q
 ;Include scanned notes
 I '$$SCAN^SCRPW302(SCRNARR) D EX1 Q
 ;Get primary & secondary sort
 I '$$SORT^SCRPW303(SORTARR) D EX1 Q
 ;Queue report
 W !!,"** REPORT REQUIRES 132 COLUMNS TO PRINT CORRECTLY **",!!
 N ZTDESC,ZTIO,ZTSAVE,TMP
 S ZTIO=""
 S ZTDESC="Performance Monitor Detailed Report"
 S ZTSAVE("SCRNARR")=""
 S TMP=$$OREF^DILF(SCRNARR)
 S ZTSAVE(TMP)=""
 I $D(@SCRNARR)#2 S ZTSAVE(SCRNARR)=""
 S ZTSAVE("SORTARR")=""
 S TMP=$$OREF^DILF(SORTARR)
 S ZTSAVE(TMP)=""
 I $D(@SORTARR)#2 S ZTSAVE(SORTARR)=""
 D EN^XUTMDEVQ("EN1^SCRPW301",ZTDESC,.ZTSAVE)
 D EX1
 Q
 ;
EN1 ;Tasked entry point
 ;Input  : SCRNARR - Screen array
 ;         SORTARR - Sort array
 ;Output : None
 ;
 ;Declare variables
 N OUTARR,PAGENUM,ENODE,DFN,TMP
 N SUB1,SUB2,PTRENC,DIV,PROV,TNODE,STOP
 S OUTARR="^TMP(""SCRPW"",$J,""OUTARR"")"
 S STOP=0
 K @OUTARR
 ;Get data
 D GETDATA^SDPMUT1(SCRNARR,SORTARR,OUTARR)
 ;Print summary page
 S PAGENUM=1
 D SUMMARY,WAIT I STOP D EXIT Q
 ;Print detailed report
 I '$D(@OUTARR) D EXIT Q
 ;Loop through data
 S STOP=0
 S SUB1="" F  S SUB1=$O(@OUTARR@("DETAIL",SUB1)) Q:SUB1=""  D  Q:STOP
 .D PRTHEAD
 .S SUB2="" F  S SUB2=$O(@OUTARR@("DETAIL",SUB1,SUB2)) Q:SUB2=""  D  Q:STOP
 ..S DFN=0 F  S DFN=+$O(@OUTARR@("DETAIL",SUB1,SUB2,DFN)) Q:'DFN  D  Q:STOP
 ...S PTRENC=0 F  S PTRENC=+$O(@OUTARR@("DETAIL",SUB1,SUB2,DFN,PTRENC)) Q:'PTRENC  D  Q:STOP
 ....S INFO=$G(@OUTARR@("DETAIL",SUB1,SUB2,DFN,PTRENC))
 ....D PRTDTL
 ....I $Y>(IOSL-5) D WAIT Q:STOP  D PRTHEAD
 ....Q
 ...Q
 ..Q
 .Q:STOP
 .D SUB1SUM,WAIT
 .Q
 ;Clean up and quit
 D EXIT
 Q
 ;
SUMMARY ;Summary Page
 ;Input  : SCRNARR - Screen array
 ;         OUTARR - Data array
 ;         PAGENUM - Page number
 ;Output : None
 ;         PAGENUM is incremented by 1
 ;
 N DIV,PROV,DSS,INFO,PS
 I $E(IOST)="C" W @IOF
 W !,"Performance Monitor Detailed Report",?120,"Page: ",PAGENUM
 W !!,"Run Date: ",$$HTE^XLFDT($H)
 W !!,"Encounter Date Range: ",?15,$$FMTE^XLFDT($P(@SCRNARR@("RANGE"),U,1))
 W " to ",$$FMTE^XLFDT($P(@SCRNARR@("RANGE"),U,2))
 W !!,"Time limit for acceptable signatures: ",@SCRNARR@("TLMT")
 W !!,"Division(s): "
 I @SCRNARR@("DIVISION")=0 D
 .S PS=0
 .S DIV=0 F  S DIV=$O(@SCRNARR@("DIVISION",DIV)) Q:'DIV  D
 ..S INFO=@SCRNARR@("DIVISION",DIV)
 ..I ($L(INFO)+$X+3)>(IOM-1) W !,?13,"/ " S PS=0
 ..I PS W " / "
 ..W INFO
 ..S PS=1
 .Q
 I @SCRNARR@("DIVISION")=1 W "All"
 W !!,"Provider(s): "
 I @SCRNARR@("PROVIDERS")=0 D
 .S PS=0
 .S PROV=0 F  S PROV=$O(@SCRNARR@("PROVIDERS",PROV)) Q:'PROV  D
 ..S INFO=@SCRNARR@("PROVIDERS",PROV)
 ..I ($L(INFO)+$X+3)>(IOM-1) W !,?13,"/ " S PS=0
 ..I PS W " / "
 ..W INFO
 ..S PS=1
 .Q
 I @SCRNARR@("PROVIDERS")=1 W "All"
 W !!,"DSS ID(s)  : "
 I @SCRNARR@("DSS")=0 D
 .I @SCRNARR@("DSS-NTNL") W "All stop codes & credit pairs in national cohort" Q
 .S PS=0
 .S DSS=0 F  S DSS=$O(@SCRNARR@("DSS",DSS)) Q:'DSS  D
 ..S INFO=@SCRNARR@("DSS",DSS)
 ..I ($L(INFO)+$X+3)>(IOM-1) W !,?13,"/ " S PS=0
 ..I PS W " / "
 ..W INFO
 ..S PS=1
 I @SCRNARR@("DSS")=1 W "All"
 W !!,"Count encounters with scanned notes: ",$S(@SCRNARR@("SCANNED"):"YES",1:"NO")
 I '$D(@OUTARR) D  Q
 .W !
 .W !,"*********************************************"
 .W !,"*  NOTHING TO REPORT FOR SELECTED CRITERIA  *"
 .W !,"*********************************************"
 S INFO=$$SITE^VASITE()
 W !!,"Total for facility ",$P(INFO,"^",2)," (",$P(INFO,"^",3),")"
 I $$S^%ZTLOAD() W !! Q
 S INFO=$G(@OUTARR@("SUMMARY"))
 D PRTSUMS
 Q
 ;
PRTSUMS ;Print summaries
 ;Input  : INFO - Summary information to print
 ;         SCRNARR - Screen array
 ;Output : None
 ;
 N VAL
 W !,"Encounters (denominator): ",+$P(INFO,U,1)
 W ?34,"Compliant Notes (numerator): ",+$P(INFO,U,2)
 W ?69,"Compliance Rate: "
 S VAL=0 I +$P(INFO,U,1)&($P(INFO,U,1)-$P(INFO,U,7))>0 S VAL=100*($P(INFO,U,2)/($P(INFO,U,1)-$P(INFO,U,7)))
 W $TR($J(VAL,3,0)," ")_" %"
 W !,?5,"Encounter Providers: ",+$P(INFO,U,4)
 W ?34,"DSS IDs: ",+$P(INFO,U,5),?53,"Ave Time: "
 S VAL=0 I +$P(INFO,U,8) S VAL=$P(INFO,U,6)/$P(INFO,U,8)
 W $TR($J(VAL,3,0)," ")
 I $G(@SCRNARR@("SCANNED")) W ?71,"Scanned Notes: ",+$P(INFO,U,7)
 Q
 ;
WAIT ;End of page logic
 ;Input  : None
 ;Output : STOP - Flag indicating if printing should continue
 ;                1 = Stop     0 = Continue
 ;
 S STOP=0
 ;CRT - Prompt for continue
 I $E(IOST,1,2)="C-"&(IOSL'>24) D  Q
 .F  Q:$Y>(IOSL-3)  W !
 .N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 .S DIR(0)="E"
 .D ^DIR
 .S STOP=$S(Y'=1:1,1:0)
 ;Background task - check TaskMan
 S STOP=$$S^%ZTLOAD()
 I STOP D
 .W !,"*********************************************"
 .W !,"*  PRINTING OF REPORT STOPPED AS REQUESTED  *"
 .W !,"*********************************************"
 Q
 ;
PRTHEAD ;Report Heading
 ;Input  : SORTARR - Sort array
 ;         PAGENUM - Page number
 ;         SUB1 - Primary sort value
 ;Output : None
 ;         PAGENUM is incremented by 1
 ;
 N SORT,SORTTEXT,DASH,TYPE
 S SORT=$G(@SORTARR)
 S SORTTEXT=$G(@SORTARR@("TEXT"))
 S PAGENUM=PAGENUM+1
 S $P(DASH,"-",IOM)="-"
 W @IOF
 W !,"Performance indicator detailed report",?120,"Page: ",PAGENUM
 W !!,"Report for ",$P(SORTTEXT,U,1)," "
 S TYPE=$P(SORT,U,1) D
 .I TYPE=1 W $P(SUB1,U,1)," (",$P(SUB1,U,2),")" Q
 .I TYPE=5 W $$FMTE^XLFDT(SUB1,"D") Q
 .W SUB1
 W " sorted by ",$P(SORTTEXT,U,2)
 W !!,"Encounter",?40,"Primary Encounter",?62,"DSS"
 W ?89,"Acceptable Provider",?112,"Date",?122,"Time"
 W !,"Date",?11,"Patient Name",?34,"SSN",?40,"Provider",?62,"ID"
 W ?67,"Clinic Name",?89,"Signing Progress Note",?112,"Signed"
 W ?122,"Span"
 W !,$E(DASH,1,9),?11,$E(DASH,1,21),?34,$E(DASH,1,4),?40,$E(DASH,1,20)
 W ?62,$E(DASH,1,3),?67,$E(DASH,1,20),?89,$E(DASH,1,21),?112,$E(DASH,1,8)
 W ?122,$E(DASH,1,5)
 Q
 ;
PRTDTL ;Print detail line
 ;Input  : INFO - Detail information to print
 ;         DFN - Pointer to Patient
 ;         PTRENC - Pointer to Outpatient Encounter
 ;Output : None
 ;
 N PROV,ENODE,VAL,VADM,VAERR,VA
 D DEM^VADPT
 S PROV=$$ENCPROV^SDPMUT2(PTRENC)
 S ENODE=$G(^SCE(PTRENC,0))
 S VAL=$$FMTE^XLFDT($P(ENODE,U,1),"2DF")
 W !,$TR(VAL," ","0")
 W ?11,$E(VADM(1),1,21)
 W ?34,$E($P(VADM(2),U,1),6,10)
 I PROV W ?40,$E($P($G(^VA(200,PROV,0)),U,1),1,20)
 I 'PROV W ?40,"Provider Unknown"
 S VAL=$P(ENODE,U,3)
 S VAL=$P($G(^DIC(40.7,VAL,0)),U,2)
 S:VAL="" VAL="???"
 W ?62,VAL
 S VAL=$P(ENODE,U,4)
 S VAL=$P($G(^SC(VAL,0)),U,1)
 S:VAL="" VAL="Clinic Unknown"
 W ?67,$E(VAL,1,20)
 S VAL=$P(INFO,U,1)
 I VAL W ?89,$E($P($G(^VA(200,VAL,0)),U,1),1,21)
 S VAL=$P(INFO,U,2)
 I VAL S VAL=$$FMTE^XLFDT(VAL,"2DF") W ?112,$TR(VAL," ","0")
 W ?122,$P(INFO,U,3)
 Q
 ;
SUB1SUM ;Summary for primary sort
 ;Input  : SORTARR - Sort array
 ;         OUTARR - Data array
 ;         SUB1 - Primary sort value (1st subscript in OUTARR)
 ;Output : None
 ;
 N SORT,SORTTEXT,TYPE,INFO
 I $Y>(IOSL+6) D WAIT Q:STOP  D PRTHEAD
 S SORT=$G(@SORTARR)
 S SORTTEXT=$G(@SORTARR@("TEXT"))
 S INFO=$G(@OUTARR@("SUBTOTAL",SUB1))
 W !!,"Total for ",$P(SORTTEXT,U,1)," "
 S TYPE=$P(SORT,U,1) D
 .I TYPE=1 W $P(SUB1,U,1)," (",$P(SUB1,U,2),")" Q
 .I TYPE=5 W $$FMTE^XLFDT(SUB1,"D") Q
 .W SUB1
 D PRTSUMS
 Q
 ;
EXIT ;Kill temporary arrays
 K @OUTARR
EX1 K @SCRNARR,@SORTARR
 Q
