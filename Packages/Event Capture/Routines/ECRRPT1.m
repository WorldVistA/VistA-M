ECRRPT1 ;ALB/JAM-Event Capture Report RPC Broker ;Sep 22, 2020@17:05:23
 ;;2.0;EVENT CAPTURE;**25,32,33,61,78,72,90,95,100,107,112,119,139,145,152**;8 May 96;Build 19
 ;
 ;119 Updated comments for reports to include (E)xport as a value for ECPTYP
ECRPRSN ;Procedure Reason Report for RPC Call
 ;     Variables passed in
 ;       ECSD     - Start Date or Report
 ;       ECED     - End Date or Report
 ;       ECL0..n  - Location to report (1,some or ALL)
 ;       ECD0..n  - DSS Unit to report (1,some or ALL)
 ;       ECRY0..n - Procedure reason (some or ALL)
 ;       ECPTYP   - Where to send output (P)rinter, (D)evice or screen
 ;                  or (E)xport
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECI,ECLOC,ECDSSU,ECDN,ECDATE,ECUN,ECNT,ECKEY,ECX,ECLINK,ECZ
 N ECROU,ECSAVE,ECDESC,ECW,DIC,X,Y,I,LIEN,ECJ
 S ECV="ECL0^ECD0^ECSD^ECED^ECRY0" D REQCHK^ECRRPT(ECV) I ECERR Q  ;112
 D  I '$D(ECLOC) S ^TMP("ECMSG",$J)="1^Invalid Location." Q
 . D LOCARRY^ECRUTL I ECL0="ALL" Q  ;112
 . K ECLOC F I=0:1 S LIEN=$G(@("ECL"_I)) Q:'+LIEN  I $D(ECLOC1(LIEN)) S ECLOC(I+1)=LIEN_"^"_ECLOC1(LIEN) ;112
 D  I '$D(ECDSSU) S ^TMP("ECMSG",$J)="1^Invalid DSS Unit." Q
 . I ECD0="ALL" D  Q
 . . I '$D(ECDUZ) Q
 . . S ECKEY=$S($D(^XUSEC("ECALLU",ECDUZ)):1,1:0) D ALLU^ECRUTL
 . S (ECI,ECNT)=0 F ECI=0:1 S ECX="ECD"_ECI Q:'$D(@ECX)  D
 . . K DIC S DIC=724,DIC(0)="QNZX",X=@ECX D ^DIC I Y<0 Q  ;145
 . . S ECNT=ECNT+1,ECDSSU(ECNT)=Y
 S ECX=0 D
 .I ECRY0="ALL" D PXREAS Q
 .N TLOC,TDSS,ECY
 .S ECI=0 F  S ECI=$O(ECLOC(ECI)) Q:'ECI  S TLOC(+ECLOC(ECI))=""
 .S ECI=0 F  S ECI=$O(ECDSSU(ECI)) Q:'ECI  S TDSS(+ECDSSU(ECI))=""
 .S ECI=0 F ECI=0:1 S ECZ="ECRY"_ECI Q:'$D(@ECZ)  D
 ..S ECW=0 F  S ECW=$O(^ECL("B",@ECZ,ECW)) Q:'ECW  D
 ...S ECY=$P($G(^ECL(ECW,0)),U,2) Q:ECY=""  S ECJ=$P($G(^ECJ(ECY,0)),U)
 ...Q:ECJ=""  Q:'$D(TLOC($P(ECJ,"-")))  Q:'$D(TDSS($P(ECJ,"-",2)))
 ...S ECLINK(ECW)=$P($G(^ECL(ECW,0)),U)
 D DATECHK^ECRRPT(.ECSD,.ECED) S ECSD=ECSD-.0001,ECED=ECED+.9999
 I ECPTYP="P" D  Q
 . S ECV="ECSD^ECED^ECPTYP",ECROU="STRPT^ECRPRSN2"
 . S (ECSAVE("ECLOC("),ECSAVE("ECDSSU("),ECSAVE("ECLINK("))=""
 . S ECDESC="EC Procedure Reason Report"
 . D QUEUE^ECRRPT
 D STRPT^ECRPRSN2 ;112
 Q
PXREAS ;Procedure reason link
 N ECZ,ECX,ECY,ECV
 S ECX=0 F  S ECX=$O(ECLOC(ECX)) Q:'ECX  S ECY=0 D
 . F  S ECY=$O(ECDSSU(ECY)) Q:'ECY  S ECV=+ECLOC(ECX)_"-"_+ECDSSU(ECY) D
 . . S ECZ=ECV_"-0-0"
 . . F  S ECZ=$O(^ECJ("B",ECZ)) Q:('ECZ)!($P(ECZ,"-",1,2)'=ECV)  D
 . . . S ECW=$O(^ECJ("B",ECZ,"")) Q:ECW=""  D REALNK
 Q
REALNK ;Reason link
 N XX,YY,ZZ
 S XX=0 F  S XX=$O(^ECL("AD",ECW,XX)) Q:'XX  S YY=0 D
 . F  S YY=$O(^ECL("AD",ECW,XX,YY)) Q:'YY  D
 . . Q:$G(^ECL(YY,0))=""  S ECLINK(YY)=XX
 Q
ECRPERS ;Inactive Person Class Report for RPC Call
 ;     Variables passed in
 ;       ECSD   - Start Date or Report
 ;       ECED   - End Date or Report
 ;       ECSORT - Sort by Patient (P) or Provider (R)
 ;       ECPTYP - Where to send output (P)rinter, (D)evice or screen
 ;                or (E)xport
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECDATE,ECBEGIN,ECEND,ECROU,ECDESC
 S ECV="ECSD^ECED^ECSORT" D REQCHK^ECRRPT(ECV) I ECERR Q
 D DATECHK^ECRRPT(.ECSD,.ECED)
 S ECBEGIN=ECSD-.0001,ECEND=ECED+.9999
 I ECPTYP="P" D  Q
 . S ECV="ECBEGIN^ECEND^ECSORT",ECROU="START^ECRPCLS"
 . S ECDESC="EC Invalid Provider Report"
 . D QUEUE^ECRRPT
 D START^ECRPCLS
 Q
ECDSS1 ;National/Local Procedure Reports for RPC Call
 ;     Variables passed in
 ;       ECRTN    - Procedure Report (A-active or I-inactive)
 ;       ECPTYP   - Where to send output (P)rinter, (D)evice or screen
 ;                  or (E)xport
 ;    If ECRTN=A, also
 ;       ECRN     - Preferred Report (N-ational, L-ocal or Both)
 ;       ECRD     - Sort Method (P-rocedure Name, N-ational Number)
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECDESC,ECROU,DQTIME
 S ECV=$S($G(ECRTN)="A":"ECRTN^ECRN^ECRD",1:"ECRTN")
 D REQCHK^ECRRPT(ECV) I ECERR Q
 S DQTIME=ECQDT
 I $G(ECPTYP)="E" D @$S(ECRTN="I":"LISTI^ECDSS1",1:"PRT^ECDSS1") Q  ;119
 I ECPTYP="P" D  Q
 . S ECV="ECRTN^ECRN^ECRD",ECROU=$S(ECRTN="I":"LISTI",1:"PRT")_"^ECDSS1"
 . S ECDESC="Event Capture National Procedure Report",ECDIP=1
 . ;S ECSAVE("IO*")=""
 .D QUEDIP D @$S(ECRTN="I":"LISTI^ECDSS1",1:"PRT^ECDSS1")
 D CLOSE^%ZISH(ECDIRY_ECFILER)
 S %ZIS("HFSNAME")=ECDIRY_ECFILER,%ZIS("HFSMODE")="W",IOP="HFS"_";132" ;145 Add right margin width
 D @$S(ECRTN="I":"LISTI^ECDSS1",1:"PRT^ECDSS1")
 Q
ECDSS3 ;Category Reports for RPC Call
 ;     Variables passed in
 ;       ECRTN    - Category Procedure Report
 ;                  (A-active, I-inactive or B-oth)
 ;       ECPTYP   - Where to send output (P)rinter, (D)evice or screen
 ;                  or (E)xport
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECDIP,DQTIME
 S ECV="ECRTN" D REQCHK^ECRRPT(ECV) I ECERR Q
 S DQTIME=ECQDT
 I $G(ECPTYP)="E" D PRINT^ECDSS3 Q  ;119
 I ECPTYP="P" D  Q
 . S ECV="ECRTN",ECROU="PRINT^ECDSS3"
 . S ECDESC="Event Capture Category Reports"
 . D QUEDIP D PRINT^ECDSS3
 D CLOSE^%ZISH(ECDIRY_ECFILER)
 S %ZIS("HFSNAME")=ECDIRY_ECFILER,%ZIS("HFSMODE")="W",IOP="HFS"_";132" ;145 Add right margin width
 D PRINT^ECDSS3
 Q
QUEDIP ;Queue when using DIP
 N DIC,X,Y
 D  I Y=-1 S ECERR=1 Q
 . S DIC(0)="MN",X=ECDEV,DIC="^%ZIS(1," D ^DIC
 . S:+Y>0 IOP="Q;"_$P(Y,U,2)
 . S Y=ECQDT X ^DD("DD") S DQTIME=Y
 Q
ECSUM ;Print Category and Procedure Summary (Report) for RPC Call
 ;     Variables passed in
 ;       ECL      - Location to report (1 or ALL)
 ;       ECD0...n - DSS Unit to report (ECD0, first unit, ECD1, second
 ;                  unit, etc.)
 ;       ECC      - Category (defaults to ALL, even if sent) (optional)
 ;       ECRTN    - Event Code Screen (Active, Inactive or Both)
 ;       ECPTYP   - Where to send output (P)rinter, (D)evice or screen
 ;                  or (E)xport
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECDN,ECCN,ECROU,ECSAVE,ECDESC,ECLOC,ECS,ECJLP,ECSN,ECALL,DIC,X,Y
 N ECSCN,ECUNITS,ECNUM ;139
 S (ECJLP,ECALL)=0,ECV="ECL^ECD0^ECRTN" D REQCHK^ECRRPT(ECV) I ECERR Q  ;139
 D  I '$D(ECLOC) S ^TMP("ECMSG",$J)="1^Invalid Location." Q
 . D LOCARRY^ECRUTL I ECL="ALL" Q
 . K ECLOC I $D(ECLOC1(ECL)) S ECLOC(1)=ECL_"^"_ECLOC1(ECL)
 S ECSCN=ECRTN,ECD="ALL",ECALL=1 ;139
 F ECNUM=0:1 Q:'$D(@("ECD"_ECNUM))  S ECUNITS(@("ECD"_ECNUM))="" K @("ECD"_ECNUM) ;139 Convert DSS units to array of units
 I ECALL D PXRUN Q
PXRUN I ECPTYP="P" D  Q
 . S ECV="ECALL^ECSCN",ECROU="START^ECSUM"
 . S ECSAVE("ECLOC(")=""
 . S ECSAVE("ECUNITS(")="" ;139 Save units for queued report
 . I 'ECALL S ECV=ECV_"^ECD^ECC^ECSN^ECDN^ECJLP^ECCN^ECSCN"
 . S ECDESC="EC Print Category and Procedure Summary"
 . D QUEUE^ECRRPT
 U IO D START^ECSUM
 Q
ECNTPCE ;ECS Records Failing Transmission to PCE
 ;     Variables passed in
 ;       ECSD   - Start Date or Report
 ;       ECED   - End Date or Report
 ;       ECPTYP - Where to send output (P)rinter, (D)evice or screen
 ;                or (E)xport
 ;       ECL0..n - Location to report (1,some or ALL)
 ;       ECD0..n - DSS unit to report (1,some or ALL)
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECDATE,ECROU,ECDESC
 N ECLOC,ECLOC1,ECDSSU,LIEN,ECNT,ECI,ECKEY,ECX,I,X,Y ; 152
 S ECV="ECSD^ECED^ECL0^ECD0" D REQCHK^ECRRPT(ECV) I ECERR Q  ;152 - Added Location and DSS Units
 ;*** 152 Starts ***
 D  I '$D(ECLOC) S ^TMP("ECMSG",$J)="1^Invalid Location." Q
 . D LOCARRY^ECRUTL I ECL0="ALL" Q  ;112
 . K ECLOC F I=0:1 S LIEN=$G(@("ECL"_I)) Q:'+LIEN  I $D(ECLOC1(LIEN)) S ECLOC(I+1)=LIEN_"^"_ECLOC1(LIEN)
 D  I '$D(ECDSSU) S ^TMP("ECMSG",$J)="1^Invalid DSS Unit." Q
 . I ECD0="ALL" D  Q
 . . I '$D(ECDUZ) Q
 . . S ECKEY=$S($D(^XUSEC("ECALLU",ECDUZ)):1,1:0) D ALLU^ECRUTL
 . S (ECI,ECNT)=0 F ECI=0:1 S ECX="ECD"_ECI Q:'$D(@ECX)  D
 . . K DIC S DIC=724,DIC(0)="QNZX",X=@ECX D ^DIC I Y<0 Q
 . . S ECNT=ECNT+1,ECDSSU(ECNT)=Y
 ;*** 152 Ends ***
 D DATECHK^ECRRPT(.ECSD,.ECED)
 S ECSD=ECSD-.0001,ECED=ECED+.9999
 I ECPTYP="P" D  Q
 . S ECV="ECSD^ECED^ECDATE^ECL0^ECD0",ECROU="START^ECNTPCE" ;152 - Added Location and DSS Units
 . S (ECSAVE("ECLOC("),ECSAVE("ECDSSU("))="" ;152
 . S ECDESC="ECS Records Failing Transmission to PCE Report"
 . D QUEUE^ECRRPT
 D START^ECNTPCE
 Q
ECSCPT ;Event Code Screens with CPT Codes
 ;     Variables passed in
 ;       ECL      - Location to report (1 or ALL)
 ;       ECD      - DSS Unit to report (1 or ALL), If ECD'="ALL" then ECC
 ;       ECC      - Category (1 or ALL) (optional)
 ;       ECCPT    - CPT Codes to Display (Active, Inactive or Both)
 ;       ECPTYP   - Where to send output (P)rinter, (D)evice or screen
 ;                  or (E)xport
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECDN,ECCN,ECROU,ECSAVE,ECDESC,ECLOC,ECS,ECJLP,ECALL,DIC,X,Y
 S (ECJLP,ECALL)=0,ECV="ECL^ECD^ECCPT" D REQCHK^ECRRPT(ECV) I ECERR Q
 D  I '$D(ECLOC) S ^TMP("ECMSG",$J)="1^Invalid Location." Q
 . I ECL="ALL" D LOCARRY^ECRUTL Q
 . S DIC=4,DIC(0)="QNZX",X=ECL D ^DIC Q:Y<0  S ECLOC(1)=+Y_U_$P(Y,U,2)
 D  I ECERR S ^TMP("ECMSG",$J)="1^Invalid DSS Unit." Q
 . I ECD="ALL" S ECALL=1 Q
 . K DIC S DIC=724,DIC(0)="QNZX",X=ECD D ^DIC I Y<0 S ECERR=1 Q  ;145
 . S ECDN=$P(Y,U,2)_$S($P($G(^ECD(+ECD,0)),"^",6):" **Inactive**",1:"")
 . S ECJLP=+$P(^ECD(ECD,0),"^",11)
 . I 'ECJLP S ECC=0,ECCN="None"
 I ECALL D CPTRUN Q
 S ECV="ECC" D REQCHK^ECRRPT(ECV) I ECERR Q
 D  I ECERR S ^TMP("ECMSG",$J)="1^Invalid Category." Q
 . I (ECC="ALL")!(ECC=0) Q
 . K DIC S DIC=726,DIC(0)="QNMZX",X=ECC D ^DIC I Y<0 S ECERR=1 Q
 . S ECCN=$P(Y,U,2)
CPTRUN I ECPTYP="P" D  Q
 . S ECV="ECALL^ECCPT",ECROU="START^ECSCPT"
 . S ECSAVE("ECLOC(")=""
 . I 'ECALL S ECV=ECV_"^ECD^ECC^ECDN^ECJLP^ECCN"
 . S ECDESC="Event Code Screens with CPT Codes"
 . D QUEUE^ECRRPT
 U IO D START^ECSCPT
 Q
ECINCPT ;National/Local Procedure Codes with Inactive CPT Reports for RPC Call
 ;     Variables passed in
 ;       ECPTYP  - Where to send output (P)rinter, (D)evice or screen
 ;                 or (E)xport
 ;  152 - Adding the next three variables
 ;       ECRN     - Preferred Report (N-ational, L-ocal or Both)
 ;       ECSM     - Sort Method (P-rocedure Name, N-ational Number,C-PT Code,D-Inactive Date)
 ;       ECSORT   - Sort Order "A"scending, "D"escending
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECL,ECDESC,ECROU,DQTIME,ECPG
 S ECV="ECRN^ECSM^ECSORT" D REQCHK^ECRRPT(ECV) I ECERR Q  ;152
 S ECPG=1
 I ECPTYP="P" D  Q
 . S ECV="ECRN^ECSM^ECSORT",ECROU="START^ECINCPT" ;152 ,ECV="ECL",ECL=""
 . S ECDESC="National/Local Procedure Codes with Inactive CPT"
 . D QUEUE^ECRRPT
 U IO D START^ECINCPT
 Q
ECGTP ;ECS Generic Table Printer
 ;     Variables passed in
 ;       ECOBHNDL   - Handle to generic table print obj
 ;       ECPTYP     - Where to send output (P)rinter, (D)evice or screen
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECROU,ECDESC
 S ECV="ECOBHNDL" D REQCHK^ECRRPT(ECV) I ECERR Q
 I ECPTYP="P" D  Q
 . S ECV="ECOBHNDL",ECROU="START^ECGTP"
 . S ECDESC="ECS Generic Table Printer"
 . D QUEUE^ECRRPT
 D START^ECGTP
 Q
ECSTPCD ;DSS Units with Associated Stop Code Error REPORT
 ;  EC*2*107 - added to GUI reports
 ;     Variables passed in
 ;       ECPTYP  - Where to send output (P)rinter, (D)evice or screen
 ;                 or (E)xport
 ;
 ;     Variable return
 ;       ^TMP($J,"ECRPT",n)=report output or to print device.
 N ECV,ECL,ECDESC,ECROU,DQTIME,ECPG
 S ECPG=1
 I ECPTYP="P" D  Q
 . S ECROU="STRTGUI^ECUNTRPT",ECV="ECL",ECL=""
 . S ECDESC="DSS Units with Associated Stop Code Error"
 . D QUEUE^ECRRPT
 U IO D STRTGUI^ECUNTRPT
 Q
