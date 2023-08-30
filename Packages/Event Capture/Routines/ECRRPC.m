ECRRPC ;ALB/JAM - Event Capture Report RPC Broker ;Oct 19, 2022@15:30:12
 ;;2.0;EVENT CAPTURE;**25,47,61,72,95,101,100,107,112,131,139,156,159**;8 May 96;Build 61
 ;
 ; Reference to ^%DT in ICR #10003
 ; Reference to ^TMP supported by SACC 2.3.2.5.1
 ; Reference to ^%ZISH: $$FTG, $$OPEN, $$CLOSE, $$DEL, $$DEFDIR supported in IA #2320
 ;
RPTEN(RESULTS,ECARY) ;RPC Broker entry point for EC Reports
 ;All EC GUI reports will call this line tag
 ;        RPC: EC REPORTS
 ;INPUTS  ECARY   - Contains the following elements for report printing
 ;        ECDEV   - Print to queue, if device
 ;        ECQDT   - Queue to print (date/time), optional
 ;        ECPTYP  - Where to send output (P)rinter, (D)evice or screen, (E)xport
 ;
 ;OUTPUTS RESULTS - Array of help text in the HELP FRAM File (#9.2)
 ;
 N HLPDA,HND,ECSTR,ECFILER,ECERR,ECDIRY,ECUFILE,ECGUI
 N ECQTIME ;CMF should not need this!  %DT call below fails for future dates within this routine
 D SETENV^ECUMRPC
 S ECERR=0,ECGUI=1 D PARSE,CHKDT I ECERR Q
 K ^TMP("ECMSG",$J),^TMP($J,"ECRPT")
 D  I ECERR D END Q
 . I ECPTYP="E" Q  ;112 For exporable format, no device needed
 . I ECPTYP="D" D HFSOPEN(ECHNDL) Q
 . I '$D(ECDEV) S ^TMP("ECMSG",$J,1)="0^Device undefined",ECERR=1
 S HND=$P($T(@ECHNDL),";;",2) I HND="" D  Q
 . S ^TMP("ECMSG",$J,1)="0^Line Tag undefined" D END
 S ^XTMP("ECRRPT","ECRRPC","ECQDTbefore")=$G(ECQDT)  ;;cmf diagnostic hack
 S:ECPTYP="P" ECQTIME=$TR($P(ECQDT,"@",2),":","")
 S ECQDT=$G(ECQDT,"NOW"),%DT="XT",X=ECQDT D ^%DT  ;Print time
 S ECQDT=$S(Y>0:Y,1:"NOW")
 S:ECPTYP="P"&(ECQDT="NOW") ECQDT=DT_"."_ECQTIME  ;Should not have to do this! %DT malfunctions inside this routine!!!
 D @$P(HND,";",2)
 I ECPTYP="D" D HFSCLOSE(ECFILER) ;S RESULTS=$NA(^TMP($J))
END D KILLVAR
 I $D(^TMP("ECMSG",$J)) S RESULTS=$NA(^TMP("ECMSG",$J)) Q
 S RESULTS=$NA(^TMP($J))
 Q
 ;
PARSE ;Parse data from array for filing
 N SUB
 S SUB="" F  S SUB=$O(ECARY(SUB)) Q:SUB=""  S @SUB=ECARY(SUB)
 Q
CHKDT ;Required Data Check
 N I,C
 S C=1
 F I="ECHNDL","ECPTYP" D
 .I $G(@I)="" S ^TMP("ECMSG",$J,C)="0^Key data missing "_I,C=C+1,ECERR=1
 Q
KILLVAR ;Kill variables
 N SUB
 S SUB="" F  S SUB=$O(ECARY(SUB)) Q:SUB=""  K @SUB
 K ECARY,POP,ECQDT
 Q
HFSOPEN(HANDLE) ;
 ;S ECDIRY=$$GET^XPAR("DIV","EC HFS SCRATCH")
 S ECDIRY=$$DEFDIR^%ZISH()
 I ECDIRY="" S ECERR=1 D  Q
 .S ^TMP("ECMSG",$J,1)="0^A scratch directory for reports doesn't exist"
 S ECFILER="EC"_DUZ_".DAT",ECUFILE=ECFILER S ^TMP("JEN",$J,.1)=ECUFILE
 D OPEN^%ZISH(HANDLE,ECDIRY,ECFILER,"W") D:POP  Q:POP
 .S ECERR=1,^TMP("ECMSG",$J,1)="0^Unable to open file "_ECDIRY_ECFILER
 S IOM=132,IOSL=99999,IOST="P-DUMMY",IOF=""""""
 Q
 ;
HFSCLOSE(HANDLE) ;
 N ECDEL
 D CLOSE^%ZISH(ECDIRY_HANDLE)
 K ^TMP($J)
 S ECDEL(ECFILER)=""
 S X=$$FTG^%ZISH(ECDIRY,ECFILER,$NAME(^TMP($J,1)),2)
 S X=$$DEL^%ZISH(ECDIRY,$NA(ECDEL))
 Q
 ;added ECSTPCD for EC*2*107
 ;added ECDSSUA, ECRUDSS, ECRECER, ECRECSIC,ECRECSPC, ECRGP and ECRDSSEC for patch EC*2*112
 ;131 Added ECDSSSNR and ECDISSUM reports
 ;139 Added ECLATESH report
 ;156 Added ECRPROC Report
 ;159 Added ECREDIT Report
ECPAT ;;Patient Summary Report;ECPAT^ECRRPT
ECRDSSA ;;DSS Unit Activity;ECRDSSA^ECRRPT
ECRDSSU ;;DSS Unit Workload Summary;ECRDSSU^ECRRPT
ECPROV ;;Provider Summary Report;ECPROV^ECRRPT
PROSUM ;;Provider (1-7) Summary Report;PROSUM^ECRRPT
ECOSSUM ;;Ordering Section Summary Report;ECOSSUM^ECRRPT
ECPCER ;;PCE Data Summary Report;ECPCER^ECRRPT
ECRPERS ;;Inactive Person Class Report;ECRPERS^ECRRPT1
ECRPRSN ;;Procedure Reason Report;ECRPRSN^ECRRPT1
ECDSS1 ;;National/Local Procedure Reports;ECDSS1^ECRRPT1
ECDSS3 ;;Category Reports;ECDSS3^ECRRPT1
ECSUM ;;Print Category and Procedure Summary (Report);ECSUM^ECRRPT1
ECNTPCE ;;Records Failing Transmission to PCE Report;ECNTPCE^ECRRPT1
ECSCPT ;;Event Code Screens with CPT Codes;ECSCPT^ECRRPT1
ECINCPT ;;National/Local Procedure Codes with Inactive CPT;ECINCPT^ECRRPT1
ECGTP ;;Generic Table Printer;ECGTP^ECRRPT1
ECSTPCD ;;DSS Units with Associated Stop Code Error Report;ECSTPCD^ECRRPT1
ECRDSSUA ;;Users with access to selected DSS Unit;ECRDSSUA^ECRRPT2
ECRUDSS ;;DSS unit access by selected user;ECRUDSS^ECRRPT2
ECRDSSEC ;;Event code screen for selected DSS Unit;ECRDSSEC^ECRRPT2
ECRECER ;;Event capture encounters report;ECRECER^ECRRPT2
ECRECSIC ;;Event Code Screens with Inactive Clinics;ECRECSIC^ECRRPT2
ECRECSPC ;;Event Code Screens by Procedure Code;ECRECSPC^ECRRPT2
ECRGP ;;Generic print of report;ECRGP^ECRRPT2
ECDSSSNR ;;DSS Units set to send no records to PCE;ECDSSSNR^ECRRPT2
ECDISSUM ;;Disabled Category and Procedure Summary Report;ECDISSUM^ECRRPT2
ECLATESH ;;Possible Late State Home Entries Report;ECLATESH^ECRRPT2
ECRPROC ;;Procedure Summary Report;ECRPROC^ECRRPT2
ECREDIT ;;Event Capture Edit Log Report;ECREDIT^ECRRPT2
ECCLIPRO ;;Event Capture Procedure By Clinic Report;ECCLIPRO^ECRRPT2
