PSOPMP0 ;BIRM/MFR - Patient Medication Profile - Listmanager ;10/28/06
 ;;7.0;OUTPATIENT PHARMACY;**260,281,303,289,382,313,427,500,482,570**;DEC 1997;Build 8
 ;Reference to EN1^GMRADPT supported by IA #10099
 ;Reference to EN6^GMRVUTL supported by IA #1120
 ;Reference to ^PS(55 supported by DBIA 2228
 ;
EN ;Menu option entry point
 N PSOEXPDC,PSOEXDCE,PSOSRTBY,PSORDER,PSOSIGDP,PSOSTSGP,PSOSTORD,PSORDCNT,PSOSTSEQ,PSORDSEQ,PSOCHNG
 N GRPLN,DIC,Y,DFN,GRPLN,HIGHLN,LASTLINE,VALMCNT
 ;
 ;Division selection
 I '$G(PSOSITE) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! G EXIT
 ;
 ;Patient selection
 W !! S DIC=2,DIC(0)="QEAM" D ^DIC G EXIT:Y<0  S DFN=+Y
 S PSODFN=DFN D CHKADDR^PSOBAI(DFN,1,1)  ;bad address flag/update
 D LST(PSOSITE,DFN)
 Q
 ;
LST(SITE,PSODFN) ;ListManager entry point
 ; Loading Division/User preferences
 D LOAD^PSOPMPPF(SITE,DUZ)
 W !,"Please wait..."
 D EN^VALM("PSO PMP MAIN")
 D FULL^VALM1
 G EXIT
 ;
HDR      ;Header
 N LINE,POS,LINE1,LINE2,LINE3,LINE4,WT,WTDT,HT,HTDT,VADM,DFN,PNAME,DOB,SEX,X,GMRAL,ADVREA
 K VADM S DFN=PSODFN D DEM^VADPT
 S PNAME=VADM(1)
 S DOB=$S(+VADM(3):$P(VADM(3),"^",2)_" ("_$G(VADM(4))_")",1:"UNKNOWN")
 S SEX=$P(VADM(5),"^",2)
 S (WT,X)="",GMRVSTR="WT" D EN6^GMRVUTL I X'="" S WT=$J($P(X,"^",8)/2.2046226,6,2),WTDT=$$DAT^PSOPMP1($P(X,"^")\1,"/",1)
 S (HT,X)="",GMRVSTR="HT" D EN6^GMRVUTL I X'="" S HT=$J($P(X,"^",8)*2.54,6,2),HTDT=$$DAT^PSOPMP1($P(X,"^")\1,"/",1)
 S LINE1=PNAME
 S LINE1=$$ALLERGY^PSOPMP1(LINE1,DFN)
 S LINE2="  PID: "_$P(VADM(2),"^",2),$E(LINE2,50)="HEIGHT(cm): "_$S(HT'="":HT_" ("_HTDT_")",1:"NOT AVAILABLE")
 S LINE3="  DOB: "_DOB,$E(LINE3,50)="WEIGHT(kg): "_$S(WT'="":WT_" ("_WTDT_")",1:"NOT AVAILABLE")
 S LINE4="  SEX: "_SEX,$E(LINE4,43)="EXP/CANCEL CUTOFF: "_PSOEXDCE_" DAYS"
 ;
 K VALMHDR S VALMHDR(1)=LINE1,VALMHDR(2)=LINE2,VALMHDR(3)=LINE3,VALMHDR(4)=LINE4
 D SETHDR^PSOPMP1()
 Q
 ;
INIT ;Populates the Body section for ListMan
 K ^TMP("PSOPMP0",$J),^TMP("PSOPMPSR",$J)
 D SETSORT(PSOSRTBY),SETLINE
 S VALMSG="Select the entry # to view or ?? for more actions"
 Q
 ;
SETLINE ;Sets the line to be displayed in ListMan
 N TYPE,STS,SUB,SEQ,LINE,Z,TOTAL,I,X,X1,ORDCNT,LBL,LN,IENSUB,GROUP,GRP,QTYL,ORNUM1,ERXIEN1
 I '$D(^TMP("PSOPMPSR",$J)) D  Q
 . F I=1:1:6 S ^TMP("PSOPMP0",$J,I,0)=""
 . S ^TMP("PSOPMP0",$J,7,0)="                    No prescriptions found for this patient."
 . S VALMCNT=1
 ;
 ;Resetting list to NORMAL video attributes
 F I=1:1:$G(LASTLINE) D RESTORE^VALM10(I)
 K GRPLN,HIGHLN
 ;Building the list (line by line)
 S (GROUP,STS,SUB)="",LINE=0 K ^TMP("PSOPMP0",$J)
 F  S GROUP=$O(^TMP("PSOPMPSR",$J,GROUP)) Q:GROUP=""  D
 . S GRP=$P(GROUP,"^")
 . I GRP'["R"!('PSOSTSGP&($O(^TMP("PSOPMPSR",$J,GROUP),-1)'="")) D
 . . D GROUP^PSOPMP1($P(GROUP,"^",2),+$G(^TMP("PSOPMPSR",$J,GROUP)),.LINE)
 . F  S STS=$O(^TMP("PSOPMPSR",$J,GROUP,STS)) Q:STS=""  D
 . . I STS'="<NULL>" D
 . . . D GROUP^PSOPMP1($P(STS,"^",2),+$G(^TMP("PSOPMPSR",$J,GROUP,STS)),.LINE)
 . . F  S SUB=$O(^TMP("PSOPMPSR",$J,GROUP,STS,SUB),$S(PSORDER="A":1,1:-1)) Q:SUB=""  D
 . . . S Z=$G(^TMP("PSOPMPSR",$J,GROUP,STS,SUB))
 . . . S X1="",SEQ=$G(SEQ)+1,X1=$J(SEQ,3)
 . . . I GRP'["P" K ERXIEN1 S ORNUM1=$$GET1^DIQ(52,+Z,39.3,"I") D:ORNUM1  S X1=X1_$S($G(ERXIEN1):"& ",1:"")
 . . . . S ERXIEN1=$$CHKERX^PSOERXU1(ORNUM1)
 . . . S QTYL=$L($P(Z,"^",4)) S:QTYL<5 QTYL=5
 . . . I GRP["R"!(GRP["T")!(GRP["H") S $E(X1,$S($G(ERXIEN1):6,1:5))=$P(Z,"^",2),$E(X1,19)=$E($P(Z,"^",3),1,(32-QTYL))
 . . . I GRP["P"!(GRP["N") K ERXIEN1 S ORNUM1=$$GET1^DIQ(52.41,+Z,.01,"I") D:ORNUM1  S $E(X1,4)=$S($G(ERXIEN1):"& ",1:" ")_$P(Z,"^",3)
 . . . . S ERXIEN1=$$CHKERX^PSOERXU1(ORNUM1)
 . . . I GRP["N" S $E(X1,49)="Date Documented:"
 . . . I GRP'["N" S $E(X1,52-QTYL)=$J($P(Z,"^",4),QTYL),$E(X1,53)=$P(Z,"^",5),$E(X1,57)=$P(Z,"^",6)
 . . . S $E(X1,66)=$P(Z,"^",7)
 . . . S $E(X1,74)=$J($P(Z,"^",8),3),$E(X1,78)=$J($P(Z,"^",9),3)
 . . . S LINE=LINE+1,^TMP("PSOPMP0",$J,LINE,0)=X1,HIGHLN(LINE)=""
 . . . S IENSUB=$S(GRP["R"!(GRP["T")!(GRP["H"):"RX",GRP["P":"PEN",1:"NVA")
 . . . S ^TMP("PSOPMP0",$J,SEQ,IENSUB)=$P(Z,"^")
 . . . I IENSUB="PEN"&($P($G(^PS(52.41,+$P(Z,"^"),0)),"^",23)=1) S ^TMP("PSOPMP0",$J,LINE,"RV")=1
 . . . I $G(PSOSIGDP) D SETSIG^PSOPMP1($S(GRP["R"!(GRP["T")!(GRP["H"):"R",GRP["P":"P",1:"N"),+Z,.LINE,PSODFN)
 ;
 ;Saving NORMAL video attributes to be reset later
 I LINE>$G(LASTLINE) D
 . F I=($G(LASTLINE)+1):1:LINE D SAVE^VALM10(I)
 . S LASTLINE=LINE
 D VIDEO^PSOPMP1()
 S VALMCNT=+$G(LINE) D RV^PSOPMP1
 Q
 ;
SETSORT(FIELD) ;Sets the data sorted by the FIELD specified
 N SEQ,RX,RXNUM,DRUG,DRNAME,QTY,STATUS,STS,ISSDT,DOCDAT,LSTFD,REFREM,DAYSUP,SIG,Z,ORD,GRPCNT,GROUP,RFRX,OI,PSOBADR,RDREJ
 K ^TMP("PSOPMPSR",$J)
 ;Loading prescription (file #55)
 S SEQ=0
 F  S SEQ=$O(^PS(55,PSODFN,"P",SEQ)) Q:'SEQ  D
 . S RX=+$G(^PS(55,PSODFN,"P",SEQ,0)) I 'RX!($G(^PSRX(RX,0))="") Q
 . I $$FILTER^PSOPMP1(RX) Q
 . S RXNUM=$$GET1^DIQ(52,RX,.01)
 . S DRUG=$$GET1^DIQ(52,RX,6,"I")
 . S DRNAME=$$GET1^DIQ(50,DRUG,.01)
 . S QTY=$$GET1^DIQ(52,RX,7)
 . S STATUS=$$STSINFO^PSOPMP1(RX)
 . S ISSDT=$$ISSDT^PSOPMP1(RX,"R")
 . S LSTFD=$$LSTFD^PSOPMP1(RX)
 . S REFREM=$$REFREM^PSOPMP1(RX)
 . S DAYSUP=$$GET1^DIQ(52,RX,8)
 . S PSOBADR=$O(^PSRX(RX,"L",9999),-1)
 . I PSOBADR'="" S PSOBADR=$G(^PSRX(RX,"L",PSOBADR,0)) I PSOBADR["(BAD ADDRESS)" S PSOBADR="B"
 . I PSOBADR'="B" S PSOBADR=""
 . S Z="",$P(Z,"^")=RX,$P(Z,"^",2)=RXNUM_$$COPAY^PSOPMP1(RX)_$$ECME^PSOBPSUT(RX)_$$TITRX^PSOUTL(RX),$P(Z,"^",3)=$E(DRNAME,1,30)
 . S $P(Z,"^",4)=QTY,$P(Z,"^",5)=$P(STATUS,"^",3)_$$CMOP^PSOPMP1(DRUG,RX)_PSOBADR,$P(Z,"^",6)=$P(ISSDT,"^",2)
 . S $P(Z,"^",7)=$P(LSTFD,"^",2),$P(Z,"^",8)=REFREM,$P(Z,"^",9)=DAYSUP
 . S SORT=$S(FIELD="RX":RXNUM_" ",FIELD="DR":DRNAME_RXNUM,FIELD="ID":+ISSDT_RXNUM_" ",FIELD="LF":+LSTFD_RXNUM_" ")
 . S STS="<NULL>" I $G(PSOSTSGP) S STS=$P(STATUS,"^")_"^"_$P(STATUS,"^",2)
 . S GROUP=$P(PSORDSEQ("R"),"^")_"R^"_$P(PSORDSEQ("R"),"^",2)
 . ; PSO*427 changes for RRR/TRI/CVA reject display
 . S RDREJ=0  ; initialize RTS/DUR reject flag to 0
 . I $$FIND^PSOREJUT(RX,,,"79,88") S GROUP=$P(PSORDSEQ("T"),"^")_"T^"_$P(PSORDSEQ("T"),"^",2),STS="<NULL>",RDREJ=1
 . ; next look for any unresolved TRI/CVA rejects  *427
 . I 'RDREJ,$$TRIC^PSOREJP1(RX),$$FIND^PSOREJUT(RX,,,,1) S GROUP=$P(PSORDSEQ("H"),U,1)_"H^"_$P(PSORDSEQ("H"),U,2),STS="<NULL>"
 . ; next look for any unresolved RRR rejects  *427
 . I 'RDREJ,'$$TRIC^PSOREJP1(RX),$$FIND^PSOREJUT(RX,,,,,1) S GROUP=$P(PSORDSEQ("H"),U,1)_"H^"_$P(PSORDSEQ("H"),U,2),STS="<NULL>"
 . S ^TMP("PSOPMPSR",$J,GROUP,STS,SORT)=Z
 . S GRPCNT(GROUP)=$G(GRPCNT(GROUP))+1,GRPCNT(GROUP,STS)=$G(GRPCNT(GROUP,STS))+1
 ;
 S GROUP=""
 F  S GROUP=$O(GRPCNT(GROUP)) Q:GROUP=""  D
 . S ^TMP("PSOPMPSR",$J,GROUP)=$G(GRPCNT(GROUP))
 . S STS="" F  S STS=$O(GRPCNT(GROUP,STS)) Q:STS=""  D
 . . S ^TMP("PSOPMPSR",$J,GROUP,STS)=GRPCNT(GROUP,STS)
 ;
 ;Loading pending orders (file #52.41)
 S ORD=0,GROUP=$P(PSORDSEQ("P"),"^")_"P^"_$P(PSORDSEQ("P"),"^",2)
 F  S ORD=$O(^PS(52.41,"P",PSODFN,ORD)) Q:'ORD  D
 . S TYPE=$$GET1^DIQ(52.41,ORD,2,"I")
 . I TYPE="DC"!(TYPE="DE")!(TYPE="HD") Q
 . S DRNAME="",DRUG=+$$GET1^DIQ(52.41,ORD,11,"I") I DRUG S DRNAME=$$GET1^DIQ(50,DRUG,.01)
 . I DRNAME="" D  Q:DRNAME=""
 . . S OI=$$GET1^DIQ(52.41,ORD,8,"I") I 'OI Q
 . . S DRNAME=$$GET1^DIQ(50.7,OI,.01)_" "_$$GET1^DIQ(50.7,OI,.02)
 . S QTY=$$GET1^DIQ(52.41,ORD,12)
 . S STATUS=$$GET1^DIQ(52.41,ORD,2,"I")
 . S ISSDT=$$ISSDT^PSOPMP1(ORD,"P")
 . S REFREM=$$GET1^DIQ(52.41,ORD,13)
 . S DAYSUP=$$GET1^DIQ(52.41,ORD,101)
 . S RFRX="" I STATUS="RF" S RFRX=$$GET1^DIQ(52.41,ORD,21,"I") I RFRX S RFRX=$$GET1^DIQ(52,RFRX,.01)
 . S Z="",$P(Z,"^")=ORD,$P(Z,"^",3)=$E(DRNAME,1,45),$P(Z,"^",4)=QTY,$P(Z,"^",5)=$E(STATUS,1,2)_$$CMOP^PSOPMP1(DRUG)
 . S $P(Z,"^",6)=$S(RFRX'="":"Rx#: "_RFRX,1:$P(ISSDT,"^",2)),$P(Z,"^",8)=REFREM,$P(Z,"^",9)=DAYSUP
 . S SORT=$S(FIELD="RX":DRNAME_ORD,FIELD="DR":DRNAME_ORD,FIELD="ID":+ISSDT_ORD,FIELD="LF":+ISSDT_ORD)
 . S ^TMP("PSOPMPSR",$J,GROUP,"<NULL>",SORT)=Z
 . S GRPCNT(GROUP)=$G(GRPCNT(GROUP))+1
 S:$G(GRPCNT(GROUP)) ^TMP("PSOPMPSR",$J,GROUP)=$G(GRPCNT(GROUP))
 ;
 ;Loading Non-VA Med orders (file #55, sub-file #55.05)
 S ORD=0,GROUP=$P(PSORDSEQ("N"),"^")_"N^"_$P(PSORDSEQ("N"),"^",2)
 F  S ORD=$O(^PS(55,PSODFN,"NVA",ORD)) Q:'ORD  D
 . I $$GET1^DIQ(55.05,ORD_","_PSODFN,5,"I") Q
 . S DRNAME=$$GET1^DIQ(55.05,ORD_","_PSODFN,1)
 . I DRNAME="" D  Q:DRNAME=""
 . . S OI=$$GET1^DIQ(55.05,ORD_","_PSODFN,.01,"I") I 'OI Q
 . . S DRNAME=$$GET1^DIQ(50.7,OI,.01)_" "_$$GET1^DIQ(50.7,OI,.02)
 . S DOCDAT=$P($$GET1^DIQ(55.05,ORD_","_PSODFN_",",11,"I"),".")
 . S Z="",$P(Z,"^")=ORD,$P(Z,"^",3)=$E(DRNAME,1,38),$P(Z,"^",7)=$$DAT^PSOPMP1(DOCDAT,"-")
 . S SORT=$S(FIELD="RX":DRNAME_ORD,FIELD="DR":DRNAME_ORD,FIELD="ID":DOCDAT_ORD,FIELD="LF":DOCDAT_ORD)
 . S ^TMP("PSOPMPSR",$J,GROUP,"<NULL>",SORT)=Z
 . S GRPCNT(GROUP)=$G(GRPCNT(GROUP))+1
 ;
 S:$G(GRPCNT(GROUP)) ^TMP("PSOPMPSR",$J,GROUP)=$G(GRPCNT(GROUP))
 Q
 ;
RX ;Sort by Rx
 D SORT("RX")
 Q
DR ;Sort by Drug
 D SORT("DR")
 Q
ID ;Sort by Issue Date
 D SORT("ID")
 Q
LF ;Sort by Last Fill Date
 D SORT("LF")
 Q
 ;
SORT(FIELD) ;Sort entries by FIELD
 I PSOSRTBY=FIELD S PSORDER=$S(PSORDER="A":"D",1:"A")
 E  S PSOSRTBY=FIELD,PSORDER="A"
 D REF
 Q
 ;
REF ;Screen Refresh
 W ?52,"Please wait..." D INIT,HDR S VALMBCK="R"
 Q
GS ;Group by Status
 W ?52,"Please wait..." S PSOSTSGP=$S($G(PSOSTSGP):0,1:1) D INIT,HDR S VALMBCK="R"
 Q
SIG ;Display SIG
 W ?52,"Please wait..." S PSOSIGDP=$S($G(PSOSIGDP):0,1:1) D INIT,HDR S VALMBCK="R"
 I 'PSOSIGDP S VALMBG=VALMBG\2
 I PSOSIGDP S VALMBG=VALMBG*2-1
 S:VALMBG>(VALMCNT-10) VALMBG=VALMCNT-10 S:VALMBG<1 VALMBG=1
 Q
PI ;Patient Information
 D EN^PSOLMPI S VALMBCK="R"
 Q
CV ;Change View
 D LST^PSOPMPPF(SITE,DUZ) W !?52,"Please wait..." D INIT,HDR
 S VALMBG=1,VALMBCK="R"
 Q
 ;
SEL ;Process selection of one entry
 N PSOSEL,TYPE,XQORM,ORD,TITLE,PSOLIS,XX
 S PSOLIS=$P(XQORNOD(0),"=",2) I 'PSOLIS S VALMSG="Invalid selection!",VALMBCK="R" Q
 F XX=1:1:$L(PSOLIS,",") Q:$P(PSOLIS,",",XX)']""  D
 .S PSOSEL=+$P(PSOLIS,",",XX) I 'PSOSEL S VALMSG="Invalid selection!",VALMBCK="R" Q
 .S TYPE=$O(^TMP("PSOPMP0",$J,PSOSEL,0)) I TYPE="" S VALMSG="Invalid selection!",VALMBCK="R" Q
 .S ORD=$G(^TMP("PSOPMP0",$J,PSOSEL,TYPE))
 .I 'ORD S VALMSG="Invalid selection!",VALMBCK="R" Q
 .S TITLE=VALM("TITLE")
 .;
 .;Regular prescription
 .I TYPE="RX" D  S VALMBCK="R" D REF
 .. N PSOVDA,PSOSAVE,DA,PS
 .. S (PSOVDA,DA)=ORD,PS="REJECTMP"
 .. N LINE,TITLE,PSODFN D DP^PSORXVW
 .;
 .;Pending Order
 .I TYPE="PEN" D  S VALMBCK="R" D REF
 .. N PSOACTOV,OR0
 .. S OR0=^PS(52.41,ORD,0),PSOACTOV=""
 .. N LINE,TITLE D PENHDR^PSOPMP1(PSODFN),DSPL^PSOORFI1
 .;
 .;Pending Order
 .I TYPE="NVA" D
 .. N LINE,TITLE D EN^PSONVAVW(PSODFN,ORD)
 .;
 S VALMBCK="R",VALM("TITLE")=TITLE
 Q
 ;
EXIT ;
 K ^TMP("PSOPMP0",$J),^TMP("PSOPMPSR",$J)
 Q
 ;
HELP Q
 ;
MEDPRO(RXIEN,FILL) ; MP Medication Profile
 ;
 ; This procedure relies on existing procedures which are part
 ; of Patient Medication Profile ListMan screen.
 ;
 ; New variables used in this procedure.
 ;
 N PSODFN,PSOSIGDP,PSOSITE,PSOSRTBY
 ;
 K ^TMP("PSOPMP0",$J),^TMP("PSOPMPSR",$J)
 ;
 ; Determine Division IEN, ptr to file# 59, and Patient IEN.
 ;
 S PSOSITE=+$$RXSITE^PSOBPSUT(RXIEN,FILL)
 S PSODFN=+$$GET1^DIQ(52,RXIEN,2,"I")
 ;
 ; LOAD determines Division or User preferences.
 ;
 D LOAD^PSOPMPPF(PSOSITE,DUZ)
 S PSOSIGDP=0  ; Do not include signature info.
 ;
 ; SETSORT collects medication data into ^TMP("PSOPMPSR").
 ; SETLINE takes the data collected in ^TMP("PSOPMPSR") and
 ; creates the display lines in ^TMP("PSOPMP0").
 ;
 D SETSORT(PSOSRTBY)
 D SETLINE
 ;
 K ^TMP("PSOPMPSR",$J)
 ;
 ; Clean up variable set but neither Newed nor Killed in LOAD^PSOPMPPF.
 ;
 K PSOEXDCE,PSORDCNT,PSORDER,PSOSRTBY,PSOSTSEQ,PSOSTSGP
 ;
 Q
