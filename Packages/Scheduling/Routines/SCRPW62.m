SCRPW62 ;BP-CIOFO/KEITH - SC veterans awaiting appointments ; 23 August 2002@20:23  ; Compiled August 20, 2007 14:21:08
 ;;5.3;Scheduling;**267,269,358,491**;AUG 13, 1993;Build 53
 ;
 ;Prompt for report parameters
 ;
 N SDOUT,DIR,DTOUT,DUOUT,SDFMT,SDATES,SDDIV,SDRPT,SDSCVT
 N SDELIM,SDX,ZTSAVE,X,Y
 S SDOUT=0
 D TITL^SCRPW50("SC Veterans Awaiting Appointments")
 W !,"Note: Once the scheduling replacement application has been implemented at your"
 W !,"site, this report will no longer be accurate."
RPT D SUBT^SCRPW50("**** Report Type Selection ****")
 S DIR(0)="S^E:ENTERED WITH NO APPOINTMENT PROVIDED;A:APPOINTMENTS BEYOND DATE DESIRED",DIR("A")="Select report type"
 S DIR("?",1)="Specify 'E' to return SC veterans entered but not yet provided an appointment,"
 S DIR("?")="'A' to return SC veterans with appointments beyond the date desired."
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 G EXIT
 K DIR S SDRPT=Y D ENT:SDRPT="E",APPT:SDRPT="A" G:SDOUT EXIT
 D SUBT^SCRPW50("**** Patient Eligibility Selection ****")
 S DIR(0)="S^1:50-100% SC Veterans;2:0-50% SC Veterans;3:All SC Veterans"
 S DIR("A")="Select eligibility type"
 S DIR("?")="Specify the eligibility of the patients you wish to include."
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 G EXIT
 K DIR S SDSCVT=Y
FMT D SUBT^SCRPW50("**** Report Format Selection ****")
 S DIR(0)="S^D:DETAILED REPORT;S:STATISTICS ONLY"
 S DIR("A")="Select report format"
 S DIR("?")="Specify the report format desired."
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 G EXIT
 K DIR S SDFMT=Y
 I SDFMT="S" S SDELIM=0 G QUE
 D SUBT^SCRPW50("**** Output Format Selection ****")
 S DIR(0)="Y",DIR("A")="Return report output in delimited format"
 S DIR("B")="NO"
 S DIR("?",1)="Specify if you would like the report output to be in delimited format for"
 S DIR("?",2)="transfer to a spreadsheet.  The delimited output will not include rated SC"
 S DIR("?")="disabilities for 0-50% SC veterans (as included in the text formatted report)."
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 G EXIT
 S SDELIM=Y
 ;
QUE ;Queue output
 ;W !!,"This report requires ",$S(SDELIM:"greater than ",1:""),"132 columns for output!"
 W !!,"This report requires the following steps to be converted to 'EXCEL':"
 W !,"1 - Copy it into WORD and replace '!^p' with null"
 W !,"2 - Save this file as *.txt format"
 W !,"3 - Open this file in 'EXCEL' with the All Files(*.*) type of file, listing it with one delimiter: '^'."
 F SDX="SDELIM","SDRPT","SDSCVT","SDATES","SDDIV","SDDIV(","SDFMT" S ZTSAVE(SDX)=""
 W ! D EN^XUTMDEVQ("START^SCRPW62","SC Veterans Awaiting Appointments",.ZTSAVE) D DISP0^SCRPW23
 Q
 ;
ENT ;Date entered parameters
 S SDATES=1 Q
 ;
 ;Following logic suppressed by request
 D SUBT^SCRPW50("**** Report Time Frame ****")
 S DIR(0)="S^1:THE PAST YEAR;2:THE PAST TWO YEARS;3:THE PAST 3 YEARS"
 S DIR("A")="Include SC veterans entered during"
 S DIR("?")="Specify the time frame in which these patients were entered in VistA."
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 S SDATES=Y
 Q
 ;
APPT ;Appointment delay parameters
 I '$$DIVA^SCRPW17(.SDDIV) S SDOUT=1 Q
 S SDATES=30 Q
 ;
 ;Following logic suppressed by request
 D SUBT^SCRPW50("**** Report Time Frame ****")
 S DIR(0)="S^30:>30 DAYS BEYOND 'DESIRED DATE';60:>60 DAYS BEYOND 'DESIRED DATE;90:>90 DAYS BEYOND 'DESIRED DATE';180:>180 DAYS BEYOND 'DESIRED DATE'"
 S DIR("A")="Include SC veterans with future appointments greater than"
 S DIR("?")="Specify the difference between 'desired date' and the appointement date."
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 S SDATES=Y
 Q
 ;
START ;Gather report data
 N SDSTOP,SDOUT,SDSTOP,SDPAGE,SDLINE,SDPNOW,SDT,SDX
 I '$D(ZTQUEUED),$E(IOST)="C" D WAIT^DICD
 K ^TMP("SCRPW",$J) S (SDSTOP,SDOUT)=0,SDPAGE=1,SDLINE=""
 S $P(SDLINE,"-",(IOM+1))=""
 S SDPNOW=$$FMTE^XLFDT($E($$NOW^XLFDT(),1,12))
 S SDX=$S(SDSCVT=1:"SC 50-100% ",SDSCVT=2:"SC < 50% ",1:"")
 S SDT(1)="<*>  SC VETERANS AWAITING APPOINTMENTS  <*>"
 S SDT(2)=$S(SDRPT="E":SDX_"PATIENTS ENTERED IN THE PAST "_$S(SDATES=1:"YEAR",1:SDATES_" YEARS")_" WITHOUT AN APPOINTMENT",1:SDX_"PATIENTS WAITING > "_SDATES_" DAYS BEYOND APPOINTMENT 'DESIRED DATE'")
 D @(SDRPT_"^SCRPW63") W !!
 D EXIT
 Q
 ;
SCEL(SDE,SDSCVT) ;Gather SC eligibility codes
 ;Input: SDE=array to return list of codes in the format SDE(n) where
 ;           'n' is the ifn in file #8 (pass by reference)
 ;       SDSCVT=type of SC vets to include
 N SDE81,SDX,SDI,SDII
 S SDI=0 F  S SDI=$O(^DIC(8.1,SDI)) Q:'SDI  D
 .S SDX=$G(^DIC(8.1,SDI,0))
 .Q:$P(SDX,U,5)'="Y"  S SDX=$P(SDX,U,4)
 .I SDSCVT=1,SDX'=1 Q  ;50-100% SC only
 .I SDSCVT=2,SDX'=3 Q  ;0-50% SC only
 .I SDSCVT=3,(SDX'=1&(SDX'=3)) Q  ;SC only
 .S SDII=0 F  S SDII=$O(^DIC(8,"D",SDI,SDII)) Q:'SDII  D
 ..S SDE(SDII)=SDX
 ..Q
 .Q
 Q
 ;
EXIT K ZTQUEUED,ZTSTOP,SDATES,SDDIV,SDFMT,SDRPT,SDELIM
 D END^SCRPW50 Q
 ;
HDR ;Print report header
 N X
 I SDELIM D HDRD Q
 I $E(IOST)="C",SDPAGE>1 N DIR S DIR(0)="E" D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP^SCRPW63 Q:SDOUT
 W:SDPAGE>1!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0)
 W:$X $$XY^SCRPW50("",0,0) W SDLINE
 S X=0 F  S X=$O(SDT(X)) Q:'X  W !?(IOM-$L(SDT(X))\2),SDT(X)
 W !,SDLINE,!,"Date printed: ",SDPNOW,?((IOM-6)-$L(SDPAGE)),"Page: "
 W SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1 Q
 ;
HDRD ;Header for delimited report
 Q:SDPAGE>1
 W !,SDLINE S X=0 F  S X=$O(SDT(X)) Q:'X  W !,SDT(X)
 W !,"Date printed: ",SDPNOW,!,SDLINE
 N ARR S ARR(1)="NAME^SSN^PRIM. ELIG.^DATE ENTERED^STREET ADDRESS^CITY^STATE^ZIP^PHONE NUMBER"
 S:SDRPT="A" ARR(1)=ARR(1)_"^APPOINTMENT DATE^CLINIC^CREDIT PAIR^DIVISION^DATE APPT. ENTERED^DESIRED DATE^DIFFERENCE (DESIRED DATE - APPT. DATE)^DIFFERENCE (DATE APPT. ENTERED - DESIRED DATE)"
 D DELIM(.ARR)
 S SDPAGE=SDPAGE+1 Q
 Q
 ;W !,"NAME^SSN^PRIM. ELIG.^DATE ENTERED^STREET ADDRESS^CITY^STATE^ZIP^PHONE NUMBER"
 ;W:SDRPT="A" "^APPOINTMENT DATE^CLINIC^CREDIT PAIR^DIVISION^DATE APPT. ENTERED^DESIRED DATE^DIFFERENCE (DESIRED DATE - APPT. DATE)^DIFFERENCE (DATE APPT. ENTERED - DESIRED DATE)"
 ;S SDPAGE=SDPAGE+1 Q
DELIM(ARR) ;enter delimiter in the end of wrapped line
 ;ARR - array of lines
 N DELIM,II,LN,LL,JJ
 S DELIM="!"
 F II=1:1 S LN=$G(ARR(II)),LL=$L(LN) Q:'LL  S LN=$P(LN," ")_DELIM_$P(LN," ",2,$L(LN," ")) F JJ=1:79:LL W !,$E(LN,JJ,JJ+78) W:JJ+79<LL DELIM I JJ+79=LL W $E(LN,LL) Q
