SDSCRP2 ;ALB/JAM/RBS - Recovered Costs Report for ASCD ; 3/13/07 2:50pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ;**Program Description**
 ;  This program will report on all bills generated and amounts
 ;  received for encounters whose Service Connected was changed
 ;  from 'Yes' to 'No'.
 Q
EN ;  Entry point - find all records
 ;  Get Division
 N SDSCDVSL,SDSCDVLN,SDRUN,ZTDESC,ZTRTN,ZTIO,ZTSAVE,DIR,X,Y
 D DIV^SDSCUTL
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) G EXIT
 S SDSCDVSL=Y,SDSCDVLN=SCLN K DIR,Y,X,SCLN
 S SDRUN=$$HTE^XLFDT($H,1),ZTDESC="RECOVERED COSTS REPORT",ZTRTN="BEG^SDSCRP2"
 ;  Get start and end date for report.
 D GETDATE^SDSCOMP I SDSCTDT="" G EXIT
 W !!,"You will need a 132 column printer for this report!",!
 K %ZIS S %ZIS="QM" D ^%ZIS G EXIT:POP
 I '$D(IO("Q")) K ZTDESC G @ZTRTN
 S ZTIO=ION,ZTSAVE("*")=""
 D ^%ZTLOAD
 G EXIT
 ;
BEG ;  Begin report
 N P,L,SDABRT,CT,SDSCDIV,SDSCDNM,THDR,SDI,DFTOTB,DFTOTP,DTTOTB,DTTOTP
 S (P,L,SDABRT,CT)=0
 S SDSCDIV=$S(SDSCDVSL'[SDSCDVLN:SDSCDVSL,1:"")
 I SDSCDIV="" S SDSCDNM="ALL" D FND G EXT
 I SDSCDIV'="" D
 . S THDR=""
 . F SDI=1:1:$L(SDSCDVSL,",") S SDSCDIV=$P(SDSCDVSL,",",SDI) Q:SDSCDIV=""  D  Q:$G(SDABRT)=1
 .. S SDSCDNM=$P(^DG(40.8,SDSCDIV,0),"^",1),THDR=THDR_SDSCDNM_",",CT=CT+1 D FND
 G EXT
 ;
FND ;  Find records
 N SDATA,SDOEDT,SDOE,DFN,ENCDT,SDCLM,GTOTB,GTOTP,FTOTB,FTOTP,TTOTB,TTOTP
 N BILN,TCHRG,TPAY,AUTHDT,SDWHO,PYMDT,ENCDT,SDSCD,SDPAT,VADM,SCVAL,SDBTR
 K ^TMP($J,"SDSCBILL")
 S SDOEDT=SDSCTDT
 F  S SDOEDT=$O(^SDSC(409.48,"C","C",SDOEDT)) Q:SDOEDT=""!(SDOEDT\1>SDEDT)  D
 . S SDOE=0
 . F  S SDOE=$O(^SDSC(409.48,"C","C",SDOEDT,SDOE)) Q:'SDOE  D
 .. S SDATA=$G(^SDSC(409.48,SDOE,0)) I SDATA="" Q
 .. I $P(SDATA,U,5)'="C" Q
 .. I SDSCDIV'="" Q:$P(SDATA,U,12)'=SDSCDIV
 .. I '+$$GETOE^SDOE(SDOE) Q
 .. ;find only encounters that were changed by ASCD from SC to NSC
 .. S SCVAL=$$SCHNG^SDSCUTL(SDOE) I '+SCVAL Q
 .. I $P(SCVAL,U,3) Q
 .. D FPCK
 .. D TPCK
PRT ;
 U IO D HDR I $G(SDABRT)=1 Q
 S (GTOTB,GTOTP,FTOTB,FTOTP,TTOTB,TTOTP)=0
 I SDSCDIV'="" S DFTOTB(SDSCDNM)=0,DFTOTP(SDSCDNM)=0,DTTOTB(SDSCDNM)=0,DTTOTP(SDSCDNM)=0
 S SDOE=""
 F  S SDOE=$O(^TMP($J,"SDSCBILL","COPAY",SDOE)) Q:SDOE=""  D  Q:$G(SDABRT)=1
 . S BILN=""
 . F  S BILN=$O(^TMP($J,"SDSCBILL","COPAY",SDOE,BILN)) Q:BILN=""  D  Q:$G(SDABRT)=1
 .. S SDBTR=^TMP($J,"SDSCBILL","COPAY",SDOE,BILN)
 .. S TCHRG=$P(SDBTR,U,5)
 .. S TPAY=$P(SDBTR,U,3)
 .. S AUTHDT=$P(SDBTR,U,2)\1
 .. S SDWHO=$$SVCC(SDOE)
 .. S PYMDT=$P(SDBTR,U,4)
 .. S SDSCD=$G(^SDSC(409.48,SDOE,0))
 .. S ENCDT=$P(SDSCD,U,7)\1
 .. S DFN=$P(SDSCD,U,11)
 .. D DEM^VADPT S SDPAT=$E(VADM(1),1,25)_" ("_$E($P(VADM(2),U),6,9)_")"
 .. S GTOTB=GTOTB+TCHRG,GTOTP=GTOTP+TPAY,FTOTB=FTOTB+TCHRG,FTOTP=FTOTP+TPAY
 .. S DFTOTB(SDSCDNM)=$G(DFTOTB(SDSCDNM))+TCHRG,DFTOTP(SDSCDNM)=$G(DFTOTP(SDSCDNM))+TPAY
 .. I L+3>IOSL D HDR Q:$G(SDABRT)=1
 .. W !,SDOE,?10,SDPAT,?45,$$FMTE^XLFDT(ENCDT,"5Z")
 .. W ?60,$$FMTE^XLFDT($P(SDWHO,"^",2),"5Z")
 .. W ?75,$$FMTE^XLFDT(AUTHDT,"5Z"),?90,$$FMTE^XLFDT(PYMDT,"5Z")
 .. W ?105,$J(TCHRG,10,2),?115,$J(TPAY,10,2)
 .. S L=L+1
 I $G(SDABRT)=1 Q
 ;
 I L+6>IOSL D HDR I $G(SDABRT)=1 Q
 W !,$TR($J(" ",IOM)," ","-"),!
 W !,"TOTAL FIRST PARTY: ",?105,$J(FTOTB,10,2),?115,$J(FTOTP,10,2),!!
 S L=L+5
 ;  Print Third Party
 S SDOE=""
 F  S SDOE=$O(^TMP($J,"SDSCBILL","THIRD",SDOE)) Q:SDOE=""  D  Q:$G(SDABRT)=1
 . S BILN=""
 . F  S BILN=$O(^TMP($J,"SDSCBILL","THIRD",SDOE,BILN)) Q:BILN=""  D  Q:$G(SDABRT)=1
 .. S SDBTR=^TMP($J,"SDSCBILL","THIRD",SDOE,BILN)
 .. S TPAY=$P(SDBTR,U,3)
 .. S AUTHDT=$P(SDBTR,U,2)\1
 .. S SDWHO=$$SVCC(SDOE)
 .. S PYMDT=$P(SDBTR,U,4)
 .. S SDSCD=$G(^SDSC(409.48,SDOE,0))
 .. S ENCDT=$P(SDSCD,U,7)\1
 .. S DFN=$P(SDSCD,U,11)
 .. D DEM^VADPT S SDPAT=$E(VADM(1),1,25)_" ("_$E($P(VADM(2),U),6,9)_")"
 .. S TCHRG=$P(SDBTR,U)
 .. S GTOTB=GTOTB+TCHRG,GTOTP=GTOTP+TPAY,TTOTB=TTOTB+TCHRG,TTOTP=TTOTP+TPAY
 .. S DTTOTB(SDSCDNM)=$G(DTTOTB(SDSCDNM))+TCHRG,DTTOTP(SDSCDNM)=$G(DTTOTP(SDSCDNM))+TPAY
 .. I L+3>IOSL D HDR Q:$G(SDABRT)=1
 .. W !,SDOE,?10,SDPAT,?45,$$FMTE^XLFDT(ENCDT,"5Z")
 .. W ?60,$$FMTE^XLFDT($P(SDWHO,"^",2),"5Z")
 .. W ?75,$$FMTE^XLFDT(AUTHDT,"5Z"),?90,$$FMTE^XLFDT(PYMDT,"5Z")
 .. W ?105,$J(TCHRG,10,2),?115,$J(TPAY,10,2)
 .. S L=L+1
 I $G(SDABRT)=1 Q
 ;
 I L+6>IOSL D HDR I $G(SDABRT)=1 Q
 W !,$TR($J(" ",IOM)," ","-"),!
 W !,"TOTAL THIRD PARTY: ",?105,$J(TTOTB,10,2),?115,$J(TTOTP,10,2),!!
 S L=L+5
 I L+6>IOSL D HDR I $G(SDABRT)=1 Q
 W !,$TR($J(" ",IOM)," ","-"),!
 W !,"TOTAL FOR BOTH: ",?105,$J(GTOTB,10,2),?115,$J(GTOTP,10,2),!!
 S L=L+5
 Q
 ;
FPCK ;Check for First Party Bill
 N SCBLNS,SCARTR
 S SCBLNS=$$FPBILL^IBRSUTL(SDOE) I (SCBLNS="")!($P(SCBLNS,U))="" Q
 S SCARTR=$$GETDATA^PRCAAPI($P(SCBLNS,U)) I SCARTR="" Q
 S $P(SCARTR,U,5)=$P(SCBLNS,U,3)
 S ^TMP($J,"SDSCBILL","COPAY",SDOE,$P(SCBLNS,U))=SCARTR
 Q
 ;
TPCK ;Check for Third Party Bill
 N SCBLNS,SCBID,SCARTR,SCI
 S SCBLNS=$$TPBILL^IBRSUTL(SDOE) I SCBLNS="" Q
 F SCI=1:1 S SCBID=$P(SCBLNS,U,SCI) Q:SCBID=""  D
 . S SCARTR=$$GETDATA^PRCAAPI(SCBID)
 . I SCARTR="" Q
 . S ^TMP($J,"SDSCBILL","THIRD",SDOE,SCBID)=SCARTR
 Q
 ;
HDR ; Header
 ; Do not ask 'RETURN' before first page on CRT.
 I $E(IOST,1,2)="C-",P D  I 'Y S SDABRT=1 Q
 .N DIR S DIR(0)="E" D ^DIR
 ; Do not print a form feed before first page on printer. Top of form is set at end of previous report.
 I $E(IOST,1,2)="C-"!P W @IOF
 S P=P+1,L=4
 W "Recovered Costs Report by Division: "_SDSCDNM_" ",?90,"Run Date: ",SDRUN,?124,"Page ",$J(P,3)
 W !,"Enc #",?10,"Patient",?45,"Enc Date",?60,"Change Date",?75,"Auth Date",?90,"Pay Date",?105,"Prncpl Bill",?117,"Prncpl Pay"
 W !,$TR($J(" ",IOM)," ","-"),!
 Q
 ;
EXT ;
 N L,TOTALB,TOTALP,DIV
 I CT>1,$G(SDABRT)'=1 D
 . I $E(IOST,1,2)="C-",P N DIR S DIR(0)="E" D ^DIR I 'Y S SDABRT=1 Q
 . ; Do not print a form feed before first page on printer. Top of form is set at end of previous report.
 . I $E(IOST,1,2)="C-"!P W @IOF
 . S P=P+1,L=4,TOTALB=0,TOTALP=0
 . I $E(THDR,$L(THDR))="," S THDR=$E(THDR,1,$L(THDR)-1)
 . W "Recovered Costs Report",?90,"Run Date: ",SDRUN,?124,"Page ",$J(P,3)
 . W !,"By Division(s) "_THDR
 . W !,?105,"Prncpl Bill",?117,"Prncpl Pay"
 . W !,$TR($J(" ",IOM)," ","-"),!
 . W !,?10,"FIRST PARTY TOTAL"
 . S DIV="" F  S DIV=$O(DFTOTB(DIV)) Q:DIV=""  D
 .. W !,?30,DIV,?105,$J(DFTOTB(DIV),10,2),?115,$J(DFTOTP(DIV),10,2)
 .. S TOTALB=TOTALB+DFTOTB(DIV),TOTALP=TOTALP+DFTOTP(DIV)
 . W !,$TR($J(" ",IOM)," ","-"),!
 . W !,?10,"THIRD PARTY TOTAL"
 . S DIV="" F  S DIV=$O(DTTOTB(DIV)) Q:DIV=""  D
 .. W !,?30,DIV,?105,$J(DTTOTB(DIV),10,2),?115,$J(DTTOTP(DIV),10,2)
 .. S TOTALB=TOTALB+DTTOTB(DIV),TOTALP=TOTALP+DTTOTP(DIV)
 . W !,$TR($J(" ",IOM)," ","-"),!
 . W !,?10,"TOTAL FOR BOTH FIRST AND THIRD PARTY",?105,$J(TOTALB,10,2),?115,$J(TOTALP,10,2)
 D RPTEND^SDSCRPT1
 ;
EXIT ; Exit tag
 K SDQFL,SDRUN,SDEDT,SDOE,SDOEDT,SDSCTDT,SDSCBDT,SDSCEDT,POP,SDABRT,BILL
 K BILT,FIND,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y,SCLN D KVA^VADPT
 K ^TMP($J,"SDSCBILL")
 Q
 ;
SVCC(SDENC) ; Service Connected Last Edit Change
 ;
 ;  Input:
 ;    SDENC = Encounter IEN
 ;
 ;  Output:
 ;    Function = "" - (null if undefined)
 ;             = EDITED BY_"^"_DATE EDITED  - (WHO^WHEN)
 ;
 N SDJ,SDVAL,SDX
 S SDVAL="",SDJ=999999
 S SDJ=$O(^SDSC(409.48,SDENC,1,SDJ),-1)
 I SDJ D
 . S SDX=$G(^SDSC(409.48,SDENC,1,SDJ,0))
 . I $P(SDX,U,5)=0 D
 . . S SDVAL=$P(SDX,U,3)_"^"_$P(SDX,U,2)
 Q SDVAL
