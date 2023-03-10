SDESAPPTLETTERS ;ALB/BWF - VISTA SCHEDULING RPCS - LETTER PRINT ; August 29, 2022
 ;;5.3;Scheduling;**824**;Aug 13, 1993;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to DIVISION in ICR #7024
 ; Reference to PATIENT in ICR #7025
 ;
 Q
 ; print single letter
PRINTLETTER(SDRES,APPTIEN,LTYPE,SDEAS) ;
 N APPTLIST,ERRORS,GBL,LETTERS,LINE,LCNT
 S APPTIEN=$G(APPTIEN),LTYPE=$G(LTYPE),SDEAS=$G(SDEAS)
 D VALAPPT(.ERRORS,APPTIEN)
 D VALLETTYPE(.ERRORS,LTYPE)
 D VALIDATEEAS(.ERRORS,SDEAS)
 I $D(ERRORS) D  Q
 .D BUILDJSON^SDESBUILDJSON(.SDRES,.ERRORS)
 D APPTLETTER(.GBL,APPTIEN,LTYPE)
 S LCNT=0
 I '$D(@GBL) D  Q
 .S LCNT=LCNT+1
 .S LETTERS("Letters",LCNT,"AppointmentID")=APPTIEN
 .S LETTERS("Letters",LCNT,"Error")="No letter returned."
 S LCNT=LCNT+1
 S LETTERS("Letters",LCNT,"AppointmentID")=APPTIEN
 I $G(@GBL@(0))["ERROR" S LETTERS("Letters",LCNT,"Error")=$G(@GBL@(1)) Q
 S LINE=0 F  S LINE=$O(@GBL@(LINE)) Q:'LINE  D
 .S LETTERS("Letters",LCNT,"Text",LINE)=$G(@GBL@(LINE))
 I '$D(LETTERS) S LETTERS("Letters",1)=""
 I $D(ERRORS) M LETTERS=ERRORS
 D BUILDJSON^SDESBUILDJSON(.SDRES,.LETTERS)
 Q
 ; print multiple letters
PRINTLETTERS(SDRES,APPTLIST,LTYPE,SDEAS) ;
 N APPTIEN,ERRORS,LETIEN,LCNT,GBL,LETTERS,LINE
 I '$D(APPTLIST) D
 .D ERRLOG^SDESJSON(.ERRORS,254)
 S LTYPE=$G(LTYPE),SDEAS=$G(SDEAS)
 D VALAPPTS(.ERRORS,.APPTLIST)
 S LETIEN=$$VALLETTYPE(.ERRORS,LTYPE)
 D VALIDATEEAS(.ERRORS,SDEAS)
 I 'LETIEN!($D(ERRORS)) D  Q
 .S ERRORS("Letters",1)=""
 .D BUILDJSON^SDESBUILDJSON(.SDRES,.ERRORS)
 S (APPTIEN,LCNT)=0
 ; build appointment letter for each appointment
 F  S APPTIEN=$O(APPTLIST(APPTIEN)) Q:'APPTIEN  D
 .D APPTLETTER(.GBL,APPTIEN,LTYPE)
 .I '$D(@GBL) D  Q
 ..S LCNT=LCNT+1
 ..S LETTERS("Letters",LCNT,"AppointmentID")=APPTIEN
 ..S LETTERS("Letters",LCNT,"Error")="No letter returned."
 .S LCNT=LCNT+1
 .S LETTERS("Letters",LCNT,"AppointmentID")=APPTIEN
 .I $G(@GBL@(0))["ERROR" S LETTERS("Letters",LCNT,"Error")=$G(@GBL@(1)) Q
 .S LINE=0 F  S LINE=$O(@GBL@(LINE)) Q:'LINE  D
 ..S LETTERS("Letters",LCNT,"Text",LINE)=$G(@GBL@(LINE))
 I '$D(LETTERS) S LETTERS("Letters",1)=""
 I $D(ERRORS) M LETTERS=ERRORS
 D BUILDJSON^SDESBUILDJSON(.SDRES,.LETTERS)
 Q
 ; validate appointment list
VALAPPTS(ERRORS,LIST) ;
 N APPT
 I '$O(LIST(0)) D ERRLOG^SDESJSON(.ERRORS,254)
 S APPT=0 F  S APPT=$O(LIST(APPT)) Q:'APPT  D
 .I '$D(^SDEC(409.84,APPT)) D ERRLOG^SDESJSON(.ERRORS,52,"Invalid appointment ID "_APPT)
 Q
VALAPPT(ERRORS,APPTIEN) ;
 I '$L(APPTIEN) D ERRLOG^SDESJSON(.ERRORS,14) Q
 I '$D(^SDEC(409.84,APPTIEN)) D ERRLOG^SDESJSON(.ERRORS,15)
 Q
 ; validate letter type
VALLETTYPE(ERRORS,LTYPE) ;
 N LIEN,RESOURCE,CLIN
 I '$L(LTYPE) D ERRLOG^SDESJSON(.ERRORS,228) Q "" ; missing letter type
 I '$D(^VA(407.6,"B",LTYPE)) D ERRLOG^SDESJSON(.ERRORS,226) Q ""  ;Invalid letter type.
 S LIEN=$$FIND1^DIC(407.6,,"B",LTYPE)
 Q LIEN
VALIDATEEAS(ERRORS,SDEAS) ;
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL($G(SDEAS))
 I $P($G(SDEAS),U)=-1 D ERRLOG^SDESJSON(.ERRORS,142)
 Q
 ; print single appointment letter
APPTLETTER(SDECY,SDECAPID,LT)  ;Print Appointment Letter
 ;APPTLETR(SDECY,SDECAPID,LT)  external parameter tag is in SDEC
 ; SDECAPPT = Pointer to appointment in SDEC APPOINTMENT file 409.84
 ; LT       = Letter type - "N"=No Show; "P"=Pre-Appointment; "A"=Cancelled by Patient; "C"=Cancelled by Clinic
 ;
 N SDECI,DFN,RES,CLINICIEN,SDLET,SDT,X1,X2,Y,TIMEZONE
 N SDIV,SDFORM,SDNAM,SDECDATA,SCLETFLD,ERRTXT
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00080ERRORID"_$C(30)
 D GETS^DIQ(409.84,SDECAPID_",",".01;.05;.07","I","SDECDATA")
 S SDT=$G(SDECDATA(409.84,SDECAPID_",",.01,"I"))
 S DFN=$G(SDECDATA(409.84,SDECAPID_",",.05,"I"))
 S RES=$G(SDECDATA(409.84,SDECAPID_",",.07,"I"))
 ; future consideration - it seems the letter should still print if there is no clinic.. may need to activate the following line
 ; I 'RES D ERRLOG^SDESJSON(.ERRORS,52,"No resource defined for this appointment.") Q
 S CLINICIEN=$$GET1^DIQ(409.831,RES,.04,"I")
 S SCLETFLD=$S(LT="N":2508,LT="P":2509,LT="C":2510,LT="A":2511,1:2509)
 S SDLET=$$GET1^DIQ(44,CLINICIEN,SCLETFLD,"I")
 I SDLET="" D  Q
 .S ERRTXT=$S(LT="N":"No-Show",LT="P":"Pre-Appointment",LT="C":"Clinic Cancellation",1:"Patient Cancellation")_" Letter not defined for Clinic "_$$GET1^DIQ(44,CLINICIEN,.01,"E")
 .S SDECI=SDECI+1,^TMP("SDEC",$J,SDECI)=ERRTXT
 S SDIV=$$GET1^DIQ(44,CLINICIEN,3.5,"I")
 S SDIV=$S(SDIV:SDIV,1:$O(^DG(40.8,0)))
 ; address location on letters 1 - bottom, 0 - top
 S SDFORM=$$GET1^DIQ(40.8,SDIV,30.01,"I")
 ; data header
 S ^TMP("SDEC",$J,0)="T00080TEXT"_$C(30)
 D PRT(DFN,CLINICIEN,SDT,LT,SDLET,SDFORM)
 D WRAPP(DFN,CLINICIEN,SDT,LT,SDLET)
 D REST(DFN,CLINICIEN,SDT,LT,SDLET,SDFORM)
 S SDECI=SDECI+1 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""
 Q
 ;
 ;
PRT(DFN,SDC,SD,LT,SDLET,SDFORM) ;
 ;  DFN - pointer to PATIENT file 2
 ;  SDC - pointer to HOSPITAL LOCATION file 44
 ;  SD  - appointment time in FM format
 ;  LT  - Letter type - "N"=No Show; "P"=Pre-Appointment; "A"=Cancelled by Patient; "C"=Cancelled by Clinic
 ;  SDLET - pointer to LETTER file 407.5
 ;  SDFORM - address location on letters (1 - bottom, 0 - top)
 ;WRITE GREETING AND OPENING TEXT OF LETTER
 N DPTNAME,INITSEC,X,Y
 Q:DFN=""
 Q:LT=""
 S SDFORM=$G(SDFORM)
 S Y=DT
 S Y=$TR($$FMTE^XLFDT(Y,"5DF")," ","0")
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(64," ")_Y
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(64," ")_$$LAST4(DFN)
 I 'SDFORM D
 .F I=1:1:4 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""
 .D ADDR(DFN)
 .F I=1:1:4 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""
 ;
 S DPTNAME("FILE")=2,DPTNAME("FIELD")=".01",DPTNAME("IENS")=(+DFN)_","
 S X=$$NAMEFMT^XLFNAME(.DPTNAME,"G","M")
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="Dear "_X_"," ;VSE-693;LEG 5/12/21
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""
 ;loop and display initial section of Letter
 S INITSEC=0 F  S INITSEC=$O(^VA(407.5,SDLET,1,INITSEC)) Q:INITSEC'>0  D
 .S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$GET1^DIQ(407.52,INITSEC_","_SDLET_",",.01,"E")
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""
 Q
 ;
WRAPP(DFN,SDC,SD,LT,SDLET) ;WRITE APPOINTMENT INFORMATION
 N B,S,SDCL,SDDAT,SDHX,SDX,SDX1,X,PTAPPIENS
 S SDX=SD
 S SDCL=$$GET1^DIQ(44,+SDC,.01,"E")
 S SDCL="    Clinic:  "_SDCL D FORM(SDC,SDCL,SDX) ; SD*5.3*622 end changes
 S SDX1=SDX
 S PTAPPIENS=SD_","_DFN_","
 I $$GET1^DIQ(2.98,PTAPPIENS,5,"I")]"" D
 .S SDCL="LAB",SDX=$$GET1^DIQ(2.98,PTAPPIENS,5,"I") D FORM(SDC,SDCL,SDX,1)
 I $$GET1^DIQ(2.98,PTAPPIENS,6,"I")]"" D
 .S SDCL="XRAY",SDX=$$GET1^DIQ(2.98,PTAPPIENS,6,"I") D FORM(SDC,SDCL,SDX,1)
 I $$GET1^DIQ(2.98,PTAPPIENS,7,"I")]"" D
 .S SDCL="EKG",SDX=$$GET1^DIQ(2.98,PTAPPIENS,7,"I") D FORM(SDC,SDCL,SDX,1)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""  ;alb/sat 665
 S (SDX,X)=SDX1
 Q
 ; SD*5.3*622 - add more detail for appointment and format it
 ; SDC - clinic ien
 ; SDCL - clinic name or xray/lab/ekg
 ; SDX - date/time
 ; LEXPROC - is only passed in when this is a lab/xray/ekg date
 ;
 ;  Change display time for noon and midnight from 12:00 PM to 12:00 Noon and 12:00 Midnight
FORM(SDC,SDCL,SDX,LEXPROC) ;
 N TIMEZONE,X,J,SDLOC,SDPROV,SDPRNM,SDTEL,SDTELEXT,SDTMP,SDHX,SDT0,DOW
 S TIMEZONE=$$TIMEZONEDATA^SDESUTIL($G(SDC)),TIMEZONE=$P($G(TIMEZONE),U)
 S:$D(SDX) X=SDX S SDHX=X D DW^%DTC S DOW=X,X=SDHX ;
 I $P(X,".",2)=12!($P(X,".",2)=24) S X="12:00 "_$S($P(X,".",2)=12:"N",1:"M") ;
 E  X ^DD("FUNC",2,1) ;
 S SDT0=X,SDDAT=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",$E(SDHX,4,5))_" "_+$E(SDHX,6,7)_", "_(1700+$E(SDHX,1,3))
 I '$D(LEXPROC) D
 .S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="     Date/Time: "_DOW_"  "_$J(SDDAT,12)_$S('$D(LEXPROC)&$D(SDC):$J(SDT0,9),1:"")_" "_TIMEZONE
 I '$D(LEXPROC),$D(SDC) D
 .S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="    "_SDCL
 ; get default provider if defined for a given clinic, print it on the
 ; letter only if we have a YES on file, same for clinic location
 ; skip printing the provider label if the field is empty in file #44
 S SDLOC=$$GET1^DIQ(44,+SDC,10,"I") ; physical location of the clinic
 S SDTEL=$$GET1^DIQ(44,+SDC,99,"I")        ; telephone number of clinic
 S SDTELEXT="" I SDTEL]"",$$GET1^DIQ(44,+SDC,99.1,"I")]"" D
 .S SDTELEXT=$$GET1^DIQ(44,+SDC,99.1,"I")  ; telephone ext of clinic
 ; get default provider, if any
 F J=0:0 S J=$O(^SC(+SDC,"PR",J)) Q:'J>0  D
 .I $$GET1^DIQ(44.1,J_","_+SDC_",",.02,"I")'=1 Q
 .S SDPROV=$$GET1^DIQ(44.1,J_","_+SDC_",",.01,"I")
 I $D(SDC),'$D(LEXPROC),$$GET1^DIQ(44,SDLET,5,"I")="Y" D
 .I SDLOC]"" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="     "_"Location:  "_SDLOC
 I $D(SDC),'$D(LEXPROC),SDTEL]"" D
 .S SDTMP="    Telephone:  "_SDTEL
 .I SDTELEXT]"" S SDTMP=SDTMP_"   Telephone Ext.:  "_SDTELEXT
 .S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDTMP
 I $D(SDPROV) D
 .I $D(SDC),SDPROV>0 S SDPRNM=$P(^VA(200,SDPROV,0),U,1)
 .I $D(SDC),'$D(LEXPROC),$P($G(^VA(407.5,SDLET,3)),U,1)="Y" I SDPRNM]"" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="     Provider:  "_$G(SDPRNM)
 ; call handler for LAB, XRAY, and EKG tests
 I $D(LEXPROC) D TST(SDCL,DOW)
 Q
REST(DFN,SDC,SD,LT,SDLET,SDFORM) ;WRITE THE REMAINDER OF LETTER
 N FINSEC
 ;loop and display final section of Letter
 S FINSEC=0 F  S FINSEC=$O(^VA(407.5,SDLET,2,FINSEC)) Q:FINSEC'>0  D
 .S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$GET1^DIQ(407.53,FINSEC_","_SDLET_",",.01,"E")
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""
 I SDFORM=1 D ADDR(DFN)
 Q
ADDR(DFN) ;
 K VAHOW
 N SDIENS,X,SDCCACT1,SDCCACT2,LL,VAPA
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$$FILL(11," ")_$$FML^DGNFUNC(DFN)
 I $D(^DG(43,1,"BT")),$$GET1^DIQ(43,1,722,"I") S VAPA("P")=""
 D ADD^VADPT
 ;CHANGE STATE TO ABBR.
 I $D(VAPA(5)) S SDIENS=+VAPA(5)_",",X=$$GET1^DIQ(5,SDIENS,1),$P(VAPA(5),U,2)=X
 I $D(VAPA(17)) S SDIENS=+VAPA(17)_",",X=$$GET1^DIQ(5,SDIENS,1),$P(VAPA(17),U,2)=X
 S SDCCACT1=VAPA(12),SDCCACT2=$P($G(VAPA(22,2)),"^",3)
 ;if confidential address is not active for scheduling/appointment letters, print to regular address
 I ($G(SDCCACT1)=0)!($G(SDCCACT2)'="Y") D
 .F LL=1:1:3 I VAPA(LL)]"" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(11," ")_VAPA(LL)
 .;if country is blank display as USA
 .I (VAPA(25)="")!($P(VAPA(25),"^",2)="UNITED STATES")  D  ;display city,state,zip
 ..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(11," ")_VAPA(4)_" "_$P(VAPA(5),U,2)_"  "_$P(VAPA(11),U,2)
 .E  D  ;display postal code,city,province
 ..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(11," ")_VAPA(24)_" "_VAPA(4)_" "_VAPA(23)_$C(13,10)
 .I ($P(VAPA(25),"^",2)'="UNITED STATES") S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(11," ")_$P(VAPA(25),U,2) ;display country
 ;if confidential address is active for scheduling/appointment letters, print to confidential address
 I $G(SDCCACT1)=1,$G(SDCCACT2)="Y" D
 .F LL=13:1:15 I VAPA(LL)]"" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(11," ")_VAPA(LL)
 .I (VAPA(28)="")!($P(VAPA(28),"^",2)="UNITED STATES") D
 ..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(11," ")_VAPA(16)_" "_$P(VAPA(17),U,2)_"  "_$P(VAPA(18),U,2)
 .E  D
 ..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(11," ")_VAPA(27)_" "_VAPA(16)_" "_VAPA(26)
 .I ($P(VAPA(28),"^",2)'="UNITED STATES") S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(11," ")_$P(VAPA(28),U,2)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""
 D KVAR^VADPT
 Q
 ;
DTS(Y) ;
 Q:'Y ""
 Q $TR($$FMTE^XLFDT(Y,"5DF")," ","0")
 ;
LAST4(DFN) ;Return patient "last four"
 N RET
 D DEM^VADPT
 S RET=$E(VADM(1))_$E($P(VADM(2),U,1),6,9)
 K VADM
 Q RET
 ;
BADADD ;Print patients with a Bad Address Indicator
 I '$D(^TMP($J,"BADADD")) Q
 N SDHDR,SDHDR1,SDNAM,SDDFN
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(79,"*")
 S SDHDR="BAD ADDRESS INDICATOR LIST" S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL((80-$L(SDHDR)/2)," ")_SDHDR
 S SDHDR1="** THE LETTER FOR THESE PATIENT(S) DID NOT PRINT DUE TO A BAD ADDRESS INDICATOR."
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="Last 4"
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)="of SSN   "_"Patient Name"
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$FILL(79,"*")
 S SDNAM="" F  S SDNAM=$O(^TMP($J,"BADADD",SDNAM)) Q:SDNAM=""  D
 .S SDDFN=0 F  S SDDFN=$O(^TMP($J,"BADADD",SDNAM,SDDFN)) Q:'SDDFN  D
 ..S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=$$LAST4(SDDFN)_"      "_SDNAM_$C(13,10)
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=""
 S SDECI=SDECI+1 S ^TMP("SDEC",$J,SDECI)=SDHDR1
 Q
 ;
TST(SDCL,DOW) ; handle scheduled tests
 I ($L(SDCL)=3&($E(SDCL,1,3)="LAB")) D
 .S SDECI=SDECI+1
 .S ^TMP("SDEC",$J,SDECI)=" "_SDCL_" SCHEDULED:  "_DOW_"  "_$J(SDDAT,12)_"  "_$J(SDT0,5)  ;alb/sat 665 add space
 I ($L(SDCL)=4&($E(SDCL,1,4)="XRAY")) D
 .S SDECI=SDECI+1
 .S ^TMP("SDEC",$J,SDECI)=SDCL_" SCHEDULED:  "_DOW_"  "_$J(SDDAT,12)_"  "_$J(SDT0,5)
 I ($L(SDCL)=3&($E(SDCL,1,3)="EKG")) D
 .S SDECI=SDECI+1
 .S ^TMP("SDEC",$J,SDECI)=" "_SDCL_" SCHEDULED:  "_DOW_"  "_$J(SDDAT,12)_"  "_$J(SDT0,5)  ;alb/sat 665 add space
 Q
FILL(PADS,CHAR)  ;pad string
 N I,RET
 S CHAR=$G(CHAR)
 S:CHAR="" CHAR=" "
 S RET=""
 F I=1:1:PADS S RET=RET_CHAR
 Q RET
