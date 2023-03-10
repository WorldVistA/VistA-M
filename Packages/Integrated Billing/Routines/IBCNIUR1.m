IBCNIUR1 ;AITC/VAD - Interfacility Ins. Update Report;3-FEB-2021
 ;;2.0;INTEGRATED BILLING;**687**; 21-MAR-94;Build 88
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Variables:
 ;IBCNFAC(ien) = Facilities (if IBCNFAC=1, include all)
 ;IBCNIRTN = "IBCNIUR1" (routine name for queueing)
 ;IBCNIUR("BEGDT") = Begin Date
 ;IBCNIUR("ENDDT") = End Date
 ;IBCNIUR("IBOUT") = "E"xcel, "R"eport
 ;IBCNIUR("PS") = processing status: 1-With, 0-Without
 ;IBCNIUR("SD") = "S"ummary or "D"etail
 ;IBCNIUR("SORT") = "D"ate or "F"acility
 ;IBCNIUR("SR") = "S"ent or "R"eceived
 ;
 ;ICR #10090 - File 4
 ;
 Q
 ;
EN ;entry point
 N %ZIS,I,IBCNFAC,IBCNIUR,IBCNIRTN,IBDFLTDT,IBOUT,IBRPTPS,IBRPTSD,IBRPTSR
 N IBRPTSRX,POP,STOP
 N ZTDESC,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE
 S STOP=0,IBCNIRTN="IBCNIUR1"
 K ^TMP($J,IBCNIRTN)
 W @IOF,!,"Interfacility Ins. Update Report",!
 ;
P10 ;Summary or Detail
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^S:Summary;D:Detailed;"
 S DIR("A")="Summary or Detailed:// "
 S DIR("??")="^D HELPDS^IBCNIUR1"
 D ^DIR
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) G EXIT
 S IBCNIUR("SD")=Y,IBRPTSD=Y
 I IBCNIUR("SD")="S" S IBCNFAC=1,IBCNIUR("SORT")=""
 ;
P20 ;Received or Sent 
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !!,"To view what your facility sent to other VAMCs choose SENT."
 W !,"To view what your facility received from other VAMCs choose RECEIVED.",!
 S DIR(0)="SA^S:Sent;R:Received"
 S DIR("A")="Report Type - (S)ent or (R)eceived Report// "
 S DIR("??")="^D HELPSR^IBCNIUR1"
 D ^DIR
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) G:$$STOP^IBCNINSU EXIT G P10
 S IBCNIUR("SR")=Y,IBRPTSR=Y
 W !
 ;If the rpt is "Sent", skip Processing Status prompt
 I IBCNIUR("SD")="S"!(IBCNIUR("SR")="S") G P30
 ;
P25 ;Include or exclude Processing Status
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !,"To know which records filed to buffer and which did not,"
 W !,"select ""YES"" to include processing status.",!
 S DIR(0)="Y",DIR("A")="Include processing status"
 S DIR("B")="YES",DIR("??")="^D HELPPS^IBCNIUR1"
 D ^DIR
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) G:$$STOP^IBCNINSU EXIT G P20
 S IBCNIUR("PS")=Y,IBRPTPS=Y K DIR
 W !
 ;
P30 ;Get Default date
 S IBRPTSRX=$S(IBRPTSR="S":"SSR",1:"DIR")
 S IBDFLTDT=$O(^IBCN(365.19,IBRPTSRX,IBRPTSR,""))
 I IBDFLTDT="" S IBDFLTDT=$$NOW^XLFDT     ;If no date, use the current date
 S IBDFLTDT=IBDFLTDT\1
 ;
P35 ;Begin Date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="D^::EX"
 S DIR("A",1)=$S(IBRPTSR="S":"Sent",1:"Receiving")_" Date Range:"
 S DIR("A")=" Earliest Date "_$S(IBRPTSR="R":"Received",1:"Sent")
 S DIR("B")=$S(IBDFLTDT:$$FMTE^XLFDT(IBDFLTDT,5),1:"")
 D ^DIR
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) G:$$STOP^IBCNINSU EXIT  G:(IBCNIUR("SD")="S"!(IBCNIUR("SR")="S")) P20  G P25
 I Y<IBDFLTDT!(Y>DT) D  G P35
 . W !,"Invalid date entered."
 . W !,"Date must be within the range of ",$$FMTE^XLFDT(IBDFLTDT,5)," and ",$$FMTE^XLFDT(DT,5),"...please re-enter.",!
 S IBCNIUR("BEGDT")=Y
 ;
P36 ;End date
 K DIR("A")
 S DIR("A")=" Latest Date "_$S(IBRPTSR="S":"Sent",1:"Received"),DIR("B")="TODAY"
 D ^DIR I $D(DUOUT)!$D(DTOUT)!(Y=-1) G:$$STOP^IBCNINSU EXIT  G P35
 I Y<IBCNIUR("BEGDT") W !," Latest Date must not precede the Earliest Date." G P36
 I Y<IBCNIUR("BEGDT")!(Y>DT) D  G P36
 . W !,"Invalid date entered."
 . W !,"Date must be within the range of ",$$FMTE^XLFDT(IBCNIUR("BEGDT"),5)," and ",$$FMTE^XLFDT(DT,5),"...please re-enter.",!
 S IBCNIUR("ENDDT")=Y
 ;
P40 ;Facility Selection
 W !
 I IBCNIUR("SD")="D" D INST^IBCNINSL(.IBCNFAC,$S(IBCNIUR("SR")="S":"Destination",1:"Originating")_" Facility")
 I $D(DUOUT)!$D(DTOUT) G:$$STOP^IBCNINSU EXIT G P35
 ;
P50 ;Report or Excel
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) G:$$STOP^IBCNINSU EXIT G:IBCNIUR("SD")="D" P40  G P35
 S (IBOUT,IBCNIUR("IBOUT"))=Y
 I IBCNIUR("IBOUT")="E" S IBCNIUR("SORT")="D" G P70
 ;
P60 ;Sort by Date, Patient or Facility
 I IBCNIUR("SD")'="D" G P70  ; If Summary, skip Facility prompt 
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^D:Date "_$S(IBCNIUR("SR")="S":"Sent",1:"Received")_";P:Patient Name;F:Facility "_$S(IBCNIUR("SR")="S":"Destination",1:"Originated From")
 S DIR("A",1)="Select one of the following:"
 S DIR("A",2)=""
 S DIR("A",3)="    D     Date "_$S(IBCNIUR("SR")="S":"Sent",1:"Received")
 S DIR("A",4)="    P     Patient Name"
 S DIR("A",5)="    F     Facility "_$S(IBCNIUR("SR")="S":"Destination",1:"Originated From")
 S DIR("A",6)=""
 S DIR("A")="Sort the report by: "
 D ^DIR I $D(DIRUT) G:$$STOP^IBCNINSU EXIT G P50
 S IBCNIUR("SORT")=Y
 ;
P70 ; Proceed to compile the data and generate the output of the rpt
 S STOP=0
 I '$D(ZTQUEUED) D
 . I IBCNIUR("IBOUT")="R" D  Q
 . . I IBCNIUR("SD")="D" W !,"*** This report is 132 characters wide ***",!  ;For DETAIL
 . W !,"*** To avoid wrapping, enter '0;256;999' at the 'DEVICE' prompt. ***",!
 D DEVICE(IBCNIRTN,.IBCNIUR,.IBCNFAC)
 I +STOP,IBCNIUR("IBOUT")="E" G:$$STOP^IBCNINSU EXIT  G P50
 I +STOP,IBCNIUR("SD")'="D" G:$$STOP^IBCNINSU EXIT  G P50
 I +STOP,IBCNIUR("SD")="D" G:$$STOP^IBCNINSU EXIT  G P60
 G EXIT
 ; =============================
DEVICE(IBCNIRTN,IBCNIUR,IBCNFAC) ; Device Handler and possible TaskManager calls
 ; Input params:
 ;  IBCNIRTN = Routine name for ^TMP($J,...
 ;  IBCNIUR  = Array passed by ref of the report params
 ;  IBOUT    = "R" for Report format or "E" for Excel format
 ;
 N POP,ZTDESC,ZTRTN,ZTSAVE
 ;
 S ZTRTN="COMPILE^IBCNIUR1(.IBCNFAC,.IBCNIUR,"""_IBCNIRTN_""")"
 S ZTDESC="IBCNIU - Interfacility Ins. Update Report"
 S ZTSAVE("IBCNFAC")=""
 S ZTSAVE("IBCNFAC(")=""
 S ZTSAVE("IBCNIUR(")=""
 S ZTSAVE("IBCNIRTN")=""
 S ZTSAVE("IBOUT")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
 I POP S STOP=1
 Q
 ;
HELPDS ;Help for Summary/Detail
 W !,"Please enter 'S' for 'Summary' or 'D' for a Detailed Report."
 Q
 ;
HELPPS ;Help for (W)ith or With(O)ut Processing Status
 W !,"Enter 'YES' to include the processing status for the records received."
 W !,"This identifies which records filed to the buffer and which did not."
 W !,"Enter 'NO' to exclude the processing status on the report."
 Q
 ;
HELPSR ;Help for (S)ent or (R)eceived Report
 W !,"Please enter 'R' for 'Received' or 'S' for 'Sent'."
 Q
 ;
EXIT ;
 K ^TMP($J,IBCNIRTN),IBCNIRTN,IBCNIUR
 Q
 ;
COMPILE(IBCNFAC,IBCNIUR,IBCNIRTN) ; Compile the data.
 N DSENT,FNAME,FSENT,IBBDT,IBEDT,IBOUT,IBRPTPS,IBRPTSD,IBRPTSR,IBSORT
 N PNAME,PSENT,SDATE,SITENO,SUBID
 S IBBDT=$G(IBCNIUR("BEGDT"))  ;Begin Date
 S IBEDT=$G(IBCNIUR("ENDDT"))  ;End Date
 S IBOUT=$G(IBCNIUR("IBOUT"))  ;"E"xcel, "R"eport
 S IBRPTPS=$G(IBCNIUR("PS"))   ;Processing status: 1-With, 0-Without
 S IBRPTSD=$G(IBCNIUR("SD"))   ;"S"ummary or "D"etail
 S IBRPTSR=$G(IBCNIUR("SR"))   ;"S"ent or "R"eceived
 S IBSORT=$G(IBCNIUR("SORT"))  ;"D"ate or "F"acility or "P"atient
 S ^TMP($J,IBCNIRTN)=0
 ;
 I IBRPTSR="R" D GETRECV  ;Get RECEIVED data
 I IBRPTSR="S" D GETSENT  ;Get SENT data
 D PRINT^IBCNIUR2
 Q
 ;
GETRECV ;Get RECEIVED Data
 N COB,DATAREC,IIUIENS,IIURCV,IIUVAMC,INSNAM,INSNAME,OVAMC,OVAMCIEN,OVAMCNAM,OVAMCSTA
 N PATIEN,PATSSN,PATSSN4,PNAME,RCVDTTM,RDATE,RDTTM,RPROCSTAT,SUBID,VAMCSQ
 ;
 S RCVDTTM=IBBDT   ;Set begin date
 F  S RCVDTTM=$O(^IBCN(365.19,"DIR","R",RCVDTTM)) Q:RCVDTTM=""!((RCVDTTM\1)>IBEDT)  D
 .S IIURCV=""
 .;Loop thru receiving records by date
 .F  S IIURCV=$O(^IBCN(365.19,"DIR","R",RCVDTTM,IIURCV)) Q:IIURCV=""  D
 ..S IIUIENS=IIURCV_","
 ..S PATIEN=$$GET1^DIQ(365.19,IIUIENS,.01,"I"),PNAME=$$GET1^DIQ(365.19,IIUIENS,.01)  ;Patient IEN & Patient Name
 ..S PNAME=$S(IBOUT="R":$E(PNAME,1,25),1:PNAME)  ;Truncate for REPORT
 ..S PATSSN=$$GET1^DIQ(2,PATIEN_",",.09,"I")
 ..;Last 4 of Patient's SSN
 ..S PATSSN4=$S($E(PATSSN,$L(PATSSN))="P":$E(PATSSN,$L(PATSSN)-4,$L(PATSSN)),1:$E(PATSSN,$L(PATSSN)-3,$L(PATSSN)))
 ..S RDTTM=$$GET1^DIQ(365.19,IIUIENS,2.02,"I"),RDATE=RDTTM\1   ;Received Date/Time
 ..S RPROCSTAT=$$GET1^DIQ(365.19,IIUIENS,2.01,"E")  ;get the RECEIVER PROCESSING STATUS
 ..S RPROCSTAT=$S(IBOUT="R":$E(RPROCSTAT,1,23),1:RPROCSTAT)   ;Truncate for REPORT
 ..;
 ..S IIUVAMC="1,"_IIUIENS  ;get the Originating VAMC data
 ..S OVAMCIEN=$$GET1^DIQ(365.192,IIUVAMC,.01,"I")  ;VAMC IEN
 ..I $G(IBCNFAC)'=1,'$D(IBCNFAC(OVAMCIEN)) Q       ;** NOT a selected facility
 ..S OVAMCNAM=$$GET1^DIQ(365.192,IIUVAMC,.01,"E")  ;VAMC name
 ..S OVAMCSTA=$$GET1^DIQ(4,OVAMCIEN,99,"E")        ;VAMC station #  (ICR #10090)
 ..S OVAMC=$E(OVAMCNAM,1,$S(+IBRPTPS:11,1:22))_" ("_+OVAMCSTA_")"  ;VAMC name & station #
 ..I IBOUT="E" S OVAMC=OVAMCNAM_" ("_+OVAMCSTA_")" ;Don't truncate VAMC name/station for EXCEL
 ..;
 ..;STORE counter data.
 ..S $P(^TMP($J,IBCNIRTN),U,1)=$P($G(^TMP($J,IBCNIRTN)),U,1)+1  ;# of transmissions received
 ..I '$D(^TMP($J,IBCNIRTN,"VAMCNAME",OVAMC)) D                  ;A new VAMC
 ...S $P(^TMP($J,IBCNIRTN),U,2)=$P(^TMP($J,IBCNIRTN),U,2)+1     ;# of VAMCs 
 ..S ^TMP($J,IBCNIRTN,"VAMCNAME",OVAMC)=$G(^TMP($J,IBCNIRTN,"VAMCNAME",OVAMC))+1 ;increment # per VAMC
 ..I IBRPTSD="S" Q  ;If SUMMARY quit
 ..;
 ..;If DETAIL, gather DETAILED RECEIVED data
 ..S INSNAME=$$GET1^DIQ(365.192,IIUVAMC,.03,"E")    ;Insurance Company Name
 ..S INSNAM=$E(INSNAME,1,$S(+IBRPTPS:25,1:30))
 ..I IBOUT="E" S INSNAM=INSNAME          ;Don't truncate Ins. name for EXCEL
 ..S SUBID=$$GET1^DIQ(365.192,IIUVAMC,1.03)         ;Subscriber ID
 ..S SUBID=$S(IBOUT="R":$E(SUBID,1,20),1:SUBID)     ;Truncate for REPORT
 ..S COB=$E($$GET1^DIQ(365.192,IIUVAMC,1.05,"E"),1)
 ..;
 ..S DATAREC=PNAME_U_PATSSN4_U_INSNAM_U_SUBID_U_COB_U_OVAMC_U_$$FMTE^XLFDT(RDATE,"2Z")  ;STORE Originating VAMC info
 ..I +IBRPTPS S DATAREC=DATAREC_U_RPROCSTAT  ;If including Receiver Processing Status
 ..I IBSORT="D" S ^TMP($J,IBCNIRTN,"DATE",RDATE,OVAMC,PNAME_U_PATSSN4_U_PATIEN_U_IIURCV)=DATAREC
 ..I IBSORT="F" S ^TMP($J,IBCNIRTN,"FNAME",OVAMC,RDATE,PNAME_U_PATSSN4_U_PATIEN_U_IIURCV)=DATAREC
 ..I IBSORT="P" S ^TMP($J,IBCNIRTN,"PNAME",PNAME_U_PATSSN4_U_PATIEN_U_IIURCV,RDATE,OVAMC)=DATAREC
 Q
 ;
GETSENT ;Get SENT Data
 N COB,DATAREC,DVAMC,DVAMCIEN,DVAMCNAM,DVAMCSTA,IIUIENS,IIUSNT,IIUVAMC,IIUVIENS,INSIEN,INSNAM
 N PATIEN,PATSSN,PATSSN4,PNAME,SNTDTTM,SDATE,SDTTM,SUBID,VAMCSQ
 ;
 S SNTDTTM=IBBDT   ;Set the begin date
 ;
 ;Only want transmissions that were successfully SENT
 F  S SNTDTTM=$O(^IBCN(365.19,"SSR","S",SNTDTTM)) Q:SNTDTTM=""!((SNTDTTM\1)>IBEDT)  D
 .S IIUSNT=""
 .F  S IIUSNT=$O(^IBCN(365.19,"SSR","S",SNTDTTM,IIUSNT)) Q:IIUSNT=""  D
 ..;
 ..S IIUIENS=IIUSNT_","
 ..;Patient IEN & Patient Name
 ..S PATIEN=$$GET1^DIQ(365.19,IIUIENS,.01,"I"),PNAME=$$GET1^DIQ(365.19,IIUIENS,.01)
 ..S PNAME=$S(IBOUT="R":$E(PNAME,1,28),1:PNAME)  ; Truncate Patient Name for REPORT
 ..S PATSSN=$$GET1^DIQ(2,PATIEN_",",.09,"I")
 ..;Last 4 of Patient's SSN
 ..S PATSSN4=$S($E(PATSSN,$L(PATSSN))="P":$E(PATSSN,$L(PATSSN)-4,$L(PATSSN)),1:$E(PATSSN,$L(PATSSN)-3,$L(PATSSN)))
 ..S INSIEN=$$GET1^DIQ(365.19,IIUIENS,1.03,"E")         ;Ins. Company IEN
 ..S INSNAM=$$GET1^DIQ(2.312,INSIEN_","_PATIEN_",",.01) ;Ins. Company Name
 ..S INSNAM=$S(IBOUT="R":$E(INSNAM,1,30),1:INSNAM)    ;Truncate Ins. Company Name for REPORT
 ..S SUBID=$$GET1^DIQ(365.19,IIUIENS,1.06)            ;Subscriber ID
 ..S SUBID=$S(IBOUT="R":$E(SUBID,1,20),1:SUBID)       ;Truncate for REPORT
 ..S COB=$E($$GET1^DIQ(365.19,IIUIENS,1.07,"E"),1)
 ..;
 ..S IIUVIENS=0
 ..F  S IIUVIENS=$O(^IBCN(365.19,"SSR","S",SNTDTTM,IIUSNT,IIUVIENS)) Q:'(+IIUVIENS)  D  ;Process each VAMC that was SENT to.
 ...S IIUVAMC=IIUVIENS_","_IIUIENS     ;Get the Destination VAMC data
 ...I $$GET1^DIQ(365.191,IIUVAMC,.02,"I")'="S" Q    ;Only want "S"ENT records
 ...S DVAMCIEN=$$GET1^DIQ(365.191,IIUVAMC,.01,"I")  ;VAMC IEN
 ...I $G(IBCNFAC)'=1,'$D(IBCNFAC(DVAMCIEN)) Q       ;**NOT a selected facility
 ...S DVAMCNAM=$$GET1^DIQ(365.191,IIUVAMC,.01,"E")  ;VAMC name
 ...S DVAMCSTA=$$GET1^DIQ(4,DVAMCIEN,99,"E")        ;VAMC station #
 ...S DVAMC=$S(IBOUT="R":$E(DVAMCNAM,1,22),1:DVAMCNAM)_" ("_+DVAMCSTA_")"  ;VAMC name & station #
 ...S SDTTM=$$GET1^DIQ(365.191,IIUVAMC,.03,"I"),SDATE=SDTTM\1  ;Sent Date/Time
 ...;
 ...;If STORE counter data
 ...S $P(^TMP($J,IBCNIRTN),U,1)=$P($G(^TMP($J,IBCNIRTN)),U,1)+1  ;# of transmissions sent
 ...I '$D(^TMP($J,IBCNIRTN,"VAMCNAME",DVAMC)) D                  ;A new VAMC
 ....S $P(^TMP($J,IBCNIRTN),U,2)=$P(^TMP($J,IBCNIRTN),U,2)+1     ;# of VAMCs 
 ...S ^TMP($J,IBCNIRTN,"VAMCNAME",DVAMC)=$G(^TMP($J,IBCNIRTN,"VAMCNAME",DVAMC))+1 ;increment # per VAMC
 ...I IBRPTSD="S" Q  ;If SUMMARY quit
 ...;
 ...;If DETAIL, gather DETAILED SENT data
 ...S DATAREC=PNAME_U_PATSSN4_U_INSNAM_U_SUBID_U_COB_U_DVAMC_U_$$FMTE^XLFDT(SDATE,"2Z")
 ...I IBSORT="D" S ^TMP($J,IBCNIRTN,"DATE",SDATE,DVAMC,PNAME_U_PATSSN4_U_PATIEN_U_IIUSNT)=DATAREC
 ...I IBSORT="F" S ^TMP($J,IBCNIRTN,"FNAME",DVAMC,SDATE,PNAME_U_PATSSN4_U_PATIEN_U_IIUSNT)=DATAREC
 ...I IBSORT="P" S ^TMP($J,IBCNIRTN,"PNAME",PNAME_U_PATSSN4_U_PATIEN_U_IIUSNT,SDATE,DVAMC)=DATAREC
 Q
