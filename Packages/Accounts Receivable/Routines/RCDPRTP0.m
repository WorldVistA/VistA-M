RCDPRTP0 ;ALB/LDB - CLAIMS MATCHING REPORT ;5/24/00 10:48 AM
 ;;4.5;Accounts Receivable;**151,315,339,338**;Mar 20, 1995;Build 69
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PAT      ;find patient bills
 S RCNAM=$$NAM^RCFN01(RCDEBT)
 S RCSSN=$$SSN^RCFN01(RCDEBT)
 S RCBIL=0 F  S RCBIL=$O(^PRCA(430,"E",RCDFN,RCBIL)) Q:'RCBIL  D
 .I '$$SCRNARCT^RCDPRTP($P($G(^PRCA(430,+RCBIL,0)),"^",2)) Q
 .S RCPAY=0 F  S RCPAY=$O(^PRCA(433,"C",RCBIL,RCPAY)) Q:'RCPAY  D
 ..S RCPAY1=$G(^PRCA(433,+RCPAY,1)) Q:RCPAY1=""
 ..I "^2^34^"[("^"_$P(RCPAY1,"^",2)_"^"),($P(RCPAY1,"^",9)'<DATESTRT),($P(RCPAY1,"^",9)<(DATEEND_".999999")) D
 ...S DFN=RCDFN D DEM^VADPT,ELIG^VADPT
 ...S RCTYPE=$$TYP^IBRFN(RCBIL) ; added care type - 315
 ...S RCTYPE=$S(RCTYPE="":-1,RCTYPE="PR":"P",RCTYPE="PH":"R",1:RCTYPE)
 ...I $D(RCTYPE(RCTYPE)) D  Q:'RCTYPE
 ....S ^TMP("RCDPRTPB",$J,RCNAM)=$P($G(VADM(3)),"^",2)_"^"_$P($G(VAEL(1)),"^",2)_"^"_RCSSN
 ....S ^TMP("RCDPRTPB",$J,RCNAM,RCBIL)=$P($P(RCPAY1,"^",9),".")
 ....K DFN,VA,VADM,VAEL,VAERR
 K RCDFN,RCDEBT
 Q
 ;
DATE     ;find third party bills by date of payments
 N RCDFN,RCDEBT
 F RCTYP=2,34 S DAT=$$FMADD^XLFDT(DATESTRT,-1)_".999999" F  S DAT=$O(^PRCA(433,"AT",RCTYP,DAT)) Q:'DAT!(DAT>(DATEEND_".999999"))  D
 .S RCPAY=0 F  S RCPAY=$O(^PRCA(433,"AT",RCTYP,DAT,RCPAY)) Q:'RCPAY  D
 ..S RCBIL=$P($G(^PRCA(433,+RCPAY,0)),"^",2)
 ..S RCBIL0=$G(^PRCA(430,+RCBIL,0)) Q:RCBIL0=""
 ..Q:'$$SCRNARCT^RCDPRTP($P(RCBIL0,"^",2))   ;PRCA*4.5*338
 ..S RCDFN=$P(RCBIL0,"^",7)
 ..S RCDEBT=$O(^RCD(340,"B",RCDFN_";DPT(",0)) Q:'RCDEBT
 ..S RCNAM=$$NAM^RCFN01(RCDEBT)
 ..S RCSSN=$$SSN^RCFN01(RCDEBT)
 ..S DFN=RCDFN D DEM^VADPT,ELIG^VADPT
 ..S ^TMP("RCDPRTPB",$J,RCNAM_"^"_RCDEBT)=$P($G(VADM(3)),"^",2)_"^"_$P($G(VAEL(1)),"^",2)_"^"_RCSSN
 ..S ^TMP("RCDPRTPB",$J,RCNAM_"^"_RCDEBT,RCBIL)=$P(DAT,".")
 ..K DFN,VA,VADM,VAEL,VAERR
 Q
 ;
TYPE     ;find third party bills by care type PRCA*4.5*315
 N RCDFN,RCDEBT,RCTYP
 F RCTYP=2,34 S DAT=$$FMADD^XLFDT(DATESTRT,-1)_".999999" F  S DAT=$O(^PRCA(433,"AT",RCTYP,DAT)) Q:'DAT!(DAT>(DATEEND_".999999"))  D
 .S RCPAY=0 F  S RCPAY=$O(^PRCA(433,"AT",RCTYP,DAT,RCPAY)) Q:'RCPAY  D
 ..S RCBIL=$P($G(^PRCA(433,+RCPAY,0)),"^",2)
 ..S RCBIL0=$G(^PRCA(430,+RCBIL,0)) Q:RCBIL0=""
 ..Q:'$$SCRNARCT^RCDPRTP($P(RCBIL0,"^",2))   ;PRCA*4.5*338
 ..S RCDFN=$P(RCBIL0,"^",7)
 ..S RCDEBT=$O(^RCD(340,"B",RCDFN_";DPT(",0)) Q:'RCDEBT
 ..S RCNAM=$$NAM^RCFN01(RCDEBT)
 ..S RCSSN=$$SSN^RCFN01(RCDEBT)
 ..S DFN=RCDFN D DEM^VADPT,ELIG^VADPT
 ..S RCTYPE=$$TYP^IBRFN(RCBIL)
 ..S RCTYPE=$S(RCTYPE="":-1,RCTYPE="PR":"P",RCTYPE="PH":"R",1:RCTYPE)
 ..I $D(RCTYPE(RCTYPE)) D  Q:'RCTYPE
 ...S ^TMP("RCDPRTPB",$J,RCNAM_"^"_RCDEBT)=$P($G(VADM(3)),"^",2)_"^"_$P($G(VAEL(1)),"^",2)_"^"_RCSSN
 ...S ^TMP("RCDPRTPB",$J,RCNAM_"^"_RCDEBT,RCBIL)=$P(DAT,".")
 ...K DFN,VA,VADM,VAEL,VAERR
 Q
BILL     ;set TMP array
 S RCDEBT=$O(^RCD(340,"B",RCDFN_";DPT(",0)) Q:'RCDEBT
 S RCNAM=$$NAM^RCFN01(RCDEBT)
 S RCSSN=$$SSN^RCFN01(RCDEBT)
 S DFN=+$G(^RCD(340,RCDEBT,0))
 D DEM^VADPT,ELIG^VADPT
 S RCTP=0 F  S RCTP=$O(^PRCA(433,"C",RCBILL,RCTP)) Q:'RCTP  I "^2^34^"[("^"_$P($G(^PRCA(433,+RCTP,1)),"^",2)_"^") S RCTP(0)=$P($P($G(^PRCA(433,+RCTP,1)),"^",9),".")
 S ^TMP("RCDPRTPB",$J,RCNAM)=$P($G(VADM(3)),"^",2)_"^"_$P($G(VAEL(1)),"^",2)_"^"_RCSSN
 S ^TMP("RCDPRTPB",$J,RCNAM,RCBILL)=RCTP
 K DFN,VA,VADM,VAEL,VAERR,RCBILL,RCTP
 Q
 ;
REC      ;find receipt payments
 N RCDEBT,RCDFN,RCREC1,RCPAY1,RCBIL,RCBIL0,RCDFN,RCDEBT,RCSSN
 S RCREC1=0 F  S RCREC1=$O(^PRCA(433,"AF",RCPT,RCREC1)) Q:'RCREC1  D
 .S RCPAY1=$G(^PRCA(433,+RCREC1,1)) Q:RCPAY1=""
 .S RCBIL=0 I "^2^34^"[("^"_$P(RCPAY1,"^",2)_"^") S RCBIL=$P($G(^PRCA(433,+RCREC1,0)),"^",2)
 .Q:'RCBIL
 .S RCBIL0=$G(^PRCA(430,+RCBIL,0))
 .Q:'$$SCRNARCT^RCDPRTP($P(RCBIL0,"^",2))   ;PRCA*4.5*338
 .S RCDFN=$P(RCBIL0,"^",7) Q:'RCDFN
 .S RCDEBT=$O(^RCD(340,"B",RCDFN_";DPT(",0)) Q:'RCDEBT
 .S RCSSN=$$SSN^RCFN01(RCDEBT)
 .S RCNAM=$$NAM^RCFN01(RCDEBT)
 .S DFN=RCDFN D DEM^VADPT,ELIG^VADPT
 .S ^TMP("RCDPRTPB",$J,RCNAM_"^"_RCDEBT)=$P($G(VADM(3)),"^",2)_"^"_$P($G(VAEL(1)),"^",2)_"^"_RCSSN
 .K DFN,VA,VADM,VAEL,VAERR
 .S ^TMP("RCDPRTPB",$J,RCNAM_"^"_RCDEBT,RCBIL)=$P($P($G(^PRCA(433,+RCREC1,1)),"^",9),".")
 Q
 ;
TYPEPIC(RCTYPE) ; function for user selection of care types PRCA*4.5*315
 ; RCTYPE is an output array, pass by reference
 ; RCTYPE(type)="" where type can be (I)npatient, (O)utpatient,(P)rosthetics or (R)x (Prescription)
 ; Function value is 1 if at least 1 care type was selected, 0 otherwise
 ; User can select one, all or a combination of care types.
 ;
 N DIR,X,Y,OK,DTOUT,DUOUT,DIRUT,DIROUT,RC
 K RCTYPE
 S OK=1 ; all OK default
 S DIR(0)="S"
 S RC=";I:Inpatient"
 S RC=RC_";O:Outpatient"
 S RC=RC_";P:Prosthetic"
 S RC=RC_";R:Prescription"
 S RC=RC_";ALL:All"
 S $P(DIR(0),U,2)=RC,DIR("B")="ALL"
 S DIR("A")="Select a Care Type"
 W ! D ^DIR K DIR
 I (Y["A") D  Q  ; all types selected so set & quit
 . F X="I","O","P","R" S RCTYPE(X)=""
 . Q
 I $D(DIRUT)!(Y="") Q
 S X=$$UP^XLFSTR(X)
 S RCTYPE(X)=""                 ; Toggle back on
 ; Select another type
 I (Y'["A") F  D  Q:X=""!(RCQUIT)
 . I ($G(DIRUT)'="") S OK=0,RCQUIT=1 Q
 . S DIR(0)="SBO^I:Inpatient;O:Outpatient;P:Prosthetic;R:Prescription"
 . S DIR("A")="Select another Care Type" D ^DIR K DIR
 . I $G(DUOUT) W !!,"User exited with '^', quitting",! S RCQUIT=1 Q
 . I $D(DIRUT) S OK=0 Q
 . I (X="") Q
 . S X=$$UP^XLFSTR(X)
 . S RCTYPE(X)=""
 . Q
 I $D(DUOUT)!$D(DTOUT) S OK=0 ; exit if "^" or time-out
 I '$D(RCTYPE) S OK=0 W $C(7)
 Q OK
 ;
FORMAT(RCEXCEL) ; capture the report format from the user (normal or CSV output) PRCA*4.5*315
 ; RCEXCEL=0 for normal output
 ; RCEXCEL=1 (^ separated values) for Excel output
 ; pass parameter by reference
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S RCEXCEL=0
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("B")="NO"
 S DIR(0)="Y"
 S DIR("?",1)="If you want to capture the output from this report in a ^-separated"
 S DIR("?",2)="values (Excel) format, then answer YES here."
 S DIR("?",3)=" "
 S DIR("?")="If you just want a normal report output, then answer NO here."
 W ! D ^DIR K DIR
 I $D(DIRUT) S RCQUIT=1 Q 0     ; get out
 S RCEXCEL=Y
 Q RCEXCEL
 ;
DEVICE ; Device Selection for Excel output PRCA*4.5*315
 ; RCEXCEL=1 for Excel ('^' separated values) output
 ;
 N ZTRTN,ZTDESC,ZTSAVE,POP,ZTSK,DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT
 D EXMSG
 ;
 S ZTRTN="PRINT^RCDPRTEX"
 S ZTDESC="Claims Matching Excel Report"
 S ZTSAVE("DATEEND")="",ZTSAVE("DATESTRT")="",ZTSAVE("RCQUIT")="",ZTSAVE("RCSORT")="",ZTSAVE("RCEXCEL")=""
 S ZTSAVE("RCAN")="",ZTSAVE("ZTREQ")="@",ZTSAVE("^TMP(""RCDPRTPB"",$J,")=""
 I RCSORT=1 S ZTSAVE("RCDEBT")="",ZTSAVE("RCDFN")="",ZTSAVE("RCTYPE*")=""
 I RCSORT=2 S ZTSAVE("RCBILL")="",ZTSAVE("RCDFN")="",ZTSAVE("RCDEBT")=""
 I RCSORT=4 S ZTSAVE("RCPT")=""
 I RCSORT=5 S ZTSAVE("RCTYPE*")="",ZTSAVE("DATE*")=""
 ;
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1) Q:POP
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 Q
 ;
EXMSG ; - Displays the message about capturing to an Excel file format
 ;
 W !!?5,"This report may take a while to run. It is recommended that you Queue it."
 W !!?5,"To capture as an Excel format, it is recommended that you queue this"
 W !?5,"report to a spool device with margins of 256 and page length of 99999"
 W !?5,"(e.g. spoolname;256;99999). This should help avoid wrapping problems."
 W !!?5,"Another method would be to set up your terminal to capture the detail"
 W !?5,"report data. On some terminals, this can be done by clicking on the"
 W !?5,"'Tools' menu above, then click on 'Capture Incoming Data' to save to"
 W !?5,"Desktop.  To avoid undesired wrapping of the data saved to the file,"
 W !?5,"please enter '0;256;99999' at the 'DEVICE:' prompt.",!
 Q
 ;
