PSGEUDD ;BIR/MV-EXTRA UNITS DISPENSED REPORT ;14 JAN 97 / 9:22 AM
 ;;5.0; INPATIENT MEDICATIONS ;**27,31,59,111**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191
 ; Reference to ^DIC(42 is supported by DBIA# 10039
 ;
NEW ;***New needed variables.
 K ^TMP($J)
 NEW AMT,DRG,ND,NO,PPN,TM,WHO,XDESC,XSAVE,XTRTN,PSJACNWP
 ;
ASK ;***Ask for date range and output device
 Q:$$STDATE^PSJMDIR  S PSGSDT=Y
 K DIR S DIR(0)="DAO^"_PSGSDT_"::,EXAR",DIR("A")="Enter Ending Date and Time: ",DIR("?")="Please enter a date and time that is greater than the Start Date" D ^DIR S PSGEDT=Y Q:$$STOP^PSJMDIR
 Q:$$GWP^PSJMDIR1(0)
 Q:$$SELDEV^PSJMUTL
 W:'$D(IO("Q")) !,"this may take a while...(you should QUEUE the Extra Units Dispensed report)"
 ;***Queue to sort in the background.
 I $D(IO("Q")) D  G EXIT
 . S XDESC="Extra Unit Dose Dispensed (Sort)"
 . ;Added PSGWGNM to XSAVE to enable printing of ward group total for queued prints
 . S XSAVE="PSGWGNM;PSGSDT;PSGEDT;PSGSS;PSGIO;PSGWG;PSGWD;PSGWN;PSGTMALL;PSGTM;PSGPAT(;PSGP(;PSGIODOC"
 . S XTRTN="START^PSGEUDD"
 . D SETSORTQ^PSJMUTL(XDESC,XSAVE,XTRTN)
 D START
 ;
EXIT ;***Exit report here.
 D ENKV^PSGSETU
 D EXIT^PSJMUTL
 K ^TMP($J),PSGDT,PSGEDT,PSGIO,PSGORD,PSGP,PSGPAT,PSGSDT,PSGSS,PSGTM,PSGTMALL,PSGWD,PSGWG,PSGWGNM,PSGWN,PSJSTOP
 Q
START ;***Start queuing here.
 D @PSGSS
 ;***Queue to the printer.
 I $D(PSGIO) D  G EXIT
 . S XDESC="Extra Unit Dose Dispensed (Print)"
 . S XSAVE="^TMP($J,;PSGWGNM;PSGTMALL;PSGTM;PSGSDT;PSGEDT;PSGSS;PSGIODOC"
 . S XTRTN="^PSGEUDP"
 . D SETPRTQ^PSJMUTL(XDESC,XSAVE,XTRTN)
 D ^PSGEUDP
 Q
 ;
P ;***Select by Patient
 S PPN="" F  S PPN=$O(PSGPAT(PPN)) Q:PPN=""  S PSGP=PSGPAT(PPN),PSJACNWP="" K PSJPPID,PSJPRB D ^PSJAC,LOOP
 Q
 ;
C ;***Select by CLINIC
 N DT,CLIN
 S TM="ZZ",PSJACNWP=""
 S DT=PSGSDT F  S DT=$O(^PS(55,"AUDC",DT)) Q:DT>PSGEDT!(DT="")  S CLIN=0 F  S CLIN=$O(^PS(55,"AUDC",DT,CLIN)) Q:'CLIN  D
 .S PSGP=0 F  S PSGP=$O(^PS(55,"AUDC",DT,CLIN,PSGP)) Q:'PSGP   D ^PSJAC S PPN=PSGP(0) D LOOP
 Q
G ;***Select by WARD GROUP
 D WARDGP
 Q
W ;***Select by Ward
 D WARD
 Q
WARDGP ;*** Find wards within a ward group
 S PSGWD="",TM="ZZ" F  S PSGWD=$O(^PS(57.5,"AC",PSGWG,PSGWD)) Q:'PSGWD  I $D(^DIC(42,+PSGWD,0)) S PSGWN=$P(^(0),U) D WARD
 Q
 ;
WARD ;*** Go through each patient within a given WARD
 ;*** Var used in PSJAC. Set to null to skip WP^PSJAC
 S PSJACNWP=""
 F PSGP=0:0 S PSGP=$O(^DPT("CN",PSGWN,PSGP)) Q:'PSGP  D ^PSJAC S PPN=PSGP(0) D:PSGSS="W" TEAM D:PSGSS="G" LOOP
 Q
TEAM ;*** Look up selected team.  PSGTMALL= All teams were selected.
 S TM=""
 I PSGTMALL D ALLTM,LOOP Q
 I 'PSGTM S TM="ZZ" D LOOP Q
 D ALLTM D:$D(PSGTM(TM)) LOOP
 Q
 ;
ALLTM ;*** Get UNIT DOSE information from ^PS(55
 ;
 S TM="ZZ"
 S TM=$S(PSJPRB="":0,1:+$O(^PS(57.7,"AWRT",PSGWD,PSJPRB,0))),TM=$S('TM:"ZZ",'$D(^PS(57.7,PSGWD,1,TM,0)):TM,$P(^(0),U)]"":$P(^(0),U),1:TM)
 Q
 ;
LOOP ;***Loop thru ^PS(55 on the Dispense log multiple.
 F PSGORD=0:0 S PSGORD=$O(^PS(55,+PSGP,5,PSGORD)) Q:'PSGORD  D
 . S PSGDT=PSGSDT-.000001
 . F  S PSGDT=$O(^PS(55,+PSGP,5,+PSGORD,11,"B",PSGDT)) Q:'PSGDT!(PSGEDT<PSGDT)  D
 ..F NO=0:0  S NO=$O(^PS(55,+PSGP,5,+PSGORD,11,"B",PSGDT,NO)) Q:'NO  S ND=^PS(55,+PSGP,5,+PSGORD,11,NO,0) D
 ...I $P(ND,U,5)=3 S DRG=$$ENDDN^PSGMI($P(ND,U,2)),AMT=$P(ND,U,3),WHO=$P(ND,U,6) D @($S(PSGSS="P":"TMPPT",1:"TMPWG"))
 Q
 ;
TMPWG ;***Set ^TMP global for selected by Ward/Ward Group.
 S ^TMP($J,PSGWN,TM,DRG,$E(PPN,1,10)_"^"_+PSGP,PSGDT)=AMT_U_WHO_U_PSJPBID
 Q
 ;
TMPPT ;***Set ^TMP global for selected by patient.
 S ^TMP($J,$E(PPN,1,10)_"^"_+PSGP,DRG,PSGDT)=AMT_U_WHO_U_PSJPPID_U_PSJPRB_U_PSJPWDN
 Q
