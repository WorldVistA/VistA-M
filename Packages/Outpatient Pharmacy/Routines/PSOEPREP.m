PSOEPREP ;BIR/TJL - ePCS Report RPC Broker ;12/2/21  08:38
 ;;7.0;OUTPATIENT PHARMACY;**545**;8 May 96;Build 270
 ;
RPTEN(RESULTS,EPCSARY) ;RPC Broker entry point for ePCS Reports
 ;All ePCS GUI reports will call this line tag
 ;        RPC: PSO EPCS REPORTS
 ;INPUTS  EPCSARY   - Contains the following elements for report printing
 ;        EPCSDEV   - Print to queue, if device
 ;        EPCSQDT   - Queue to print (date/time), optional
 ;        EPCSPTYP  - Where to send output (P)rinter, (D)evice or screen
 ;
 ;OUTPUTS RESULTS - Array of help text in the HELP FRAM File (#9.2)
 ;
 N HLPDA,HND,EPCSSTR,EPCSFILR,EPCSERR,EPCSDIRY,EPCSUFIL,EPCSGUI
 N EPCSQTIM ;CMF should not need this!  %DT call below fails for future dates within this routine
 I '$G(DUZ) D
 . S DUZ=.5,DUZ(0)="@",U="^",DTIME=300
 . D NOW^%DTC S DT=X
 S EPCSERR=0,EPCSGUI=1 D PARSE,CHKDT I EPCSERR Q
 K ^TMP("EPCSMSG",$J),^TMP($J,"EPCSRPT")
 D  I EPCSERR D END Q
 . I EPCSPTYP="E" Q
 . I EPCSPTYP="D" D HFSOPEN(EPCSHNDL) Q
 . I '$D(EPCSDEV) S ^TMP("EPCSMSG",$J,1)="0^Device undefined",EPCSERR=1
 S HND=$P($T(@EPCSHNDL),";;",2) I HND="" D  Q
 . S ^TMP("EPCSMSG",$J,1)="0^Line Tag undefined" D END
 S ^XTMP("PSOEPRPT",0)=$$FMADD^XLFDT($$DT^XLFDT(),90)_"^"_$$DT^XLFDT()
 S ^XTMP("PSOEPRPT","PSOEPREP","EPCSQDTbefore")=$G(EPCSQDT)  ;;cmf diagnostic hack
 S:EPCSPTYP="P" EPCSQTIM=$TR($P(EPCSQDT,"@",2),":","")
 S EPCSQDT=$G(EPCSQDT,"NOW"),%DT="XT",X=EPCSQDT D ^%DT  ;Print time
 S EPCSQDT=$S(Y>0:Y,1:"NOW")
 S:EPCSPTYP="P"&(EPCSQDT="NOW") EPCSQDT=DT_"."_EPCSQTIM  ;Should not have to do this! %DT malfunctions inside this routine!!!
 D @$P(HND,";",2)
 I EPCSPTYP="D" D HFSCLOSE(EPCSFILR)
END D KILLVAR
 I $D(^TMP("EPCSMSG",$J)) S RESULTS=$NA(^TMP("EPCSMSG",$J)) Q
 S RESULTS=$NA(^TMP($J))
 Q
 ;
PARSE ;Parse data from array for filing
 N SUB
 S SUB="" F  S SUB=$O(EPCSARY(SUB)) Q:SUB=""  S @SUB=EPCSARY(SUB)
 Q
CHKDT ;Required Data Check
 N I,C
 S C=1
 F I="EPCSHNDL","EPCSPTYP" D
 .I $G(@I)="" S ^TMP("EPCSMSG",$J,C)="0^Key data missing "_I,C=C+1,EPCSERR=1
 Q
KILLVAR ;Kill variables
 N SUB
 S SUB="" F  S SUB=$O(EPCSARY(SUB)) Q:SUB=""  K @SUB
 K EPCSARY,POP,ECPSQDT
 Q
HFSOPEN(HANDLE) ; 
 ;S EPCSDIRY=$$GET^XPAR("DIV","EPCS HFS SCRATCH")
 S EPCSDIRY=$$DEFDIR^%ZISH()
 I EPCSDIRY="" S EPCSERR=1 D  Q
 .S ^TMP("EPCSMSG",$J,1)="0^A scratch directory for reports doesn't exist"
 S EPCSFILR="EPCS"_DUZ_".DAT",EPCSUFIL=EPCSFILR S ^TMP("JEN",$J,.1)=EPCSUFIL
 D OPEN^%ZISH(HANDLE,EPCSDIRY,EPCSFILR,"W") D:POP  Q:POP
 .S EPCSERR=1,^TMP("EPCSMSG",$J,1)="0^Unable to open file "_EPCSDIRY_EPCSFILR
 S IOM=132,IOSL=99999,IOST="P-DUMMY",IOF=""""""
 Q
 ;
HFSCLOSE(HANDLE) ; 
 N EPCSDEL
 D CLOSE^%ZISH(EPCSDIRY_HANDLE)
 K ^TMP($J)
 S EPCSDEL(EPCSFILR)=""
 S X=$$FTG^%ZISH(EPCSDIRY,EPCSFILR,$NAME(^TMP($J,1)),2)
 S X=$$DEL^%ZISH(EPCSDIRY,$NA(EPCSDEL))
 Q
EPCSEXP ;;DEA Expiration Date Report;EPCSEXP^PSOEPRPT
EPCSPPP ;;Print Prescribers with Privileges;EPCSPPP^PSOEPRPT
EPCSDIS ;;Print DISUSER Prescriber with Privileges;EPCSDIS^PSOEPRPT
EPCSAUD ;;Print Audits for Prescriber Editing;EPCSAUD^PSOEPRPT
EPCSLACA ;;Logical Access Control Audit;EPCSLACA^PSOEPRPT
EPCS1007 ;;File 100.7 Report;EPCS1007^PSOEPRPT
