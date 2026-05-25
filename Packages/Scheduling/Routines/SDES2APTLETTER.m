SDES2APTLETTER ;ALB/TJB,TJB,TJB,MCB,JHC,TJB,TJB - VISTA SCHEDULING RPCS - LETTER PRINT ; OCT 20, 2025
 ;;5.3;Scheduling;**895,898,899,901,903,922,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to DIVISION in ICR #7024
 ; Reference to PATIENT in ICR #7025
 ; SDES2 PRINT APPT LETTER
 ;
 ; Reference to DUZ^XUP is supported by IA #7487
 Q
 ; print single letter
 ; SDINPUT("Appointment IEN")=IEN of the Appointment from file 409.84
 ; SDINPUT("Letter Type")=Letter type - "N"=No Show; "P"=Pre-Appointment; "A"=Cancelled by Patient; "C"=Cancelled by Clinic
PRINTLETTER(RESULTS,SDCONTEXT,SDINPUT) ;
 N APPTLIST,APPTIEN,ERRORS,GBL,LETTERS,LINE,LCNT,LETIEN,LTYPE
 N %H,%,%T,%Y ; To clear leaking variables from called routines
 S APPTIEN=$G(SDINPUT("Appointment IEN")),LTYPE=$G(SDINPUT("Letter Type"))
 ; validate context array
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("letters",1)="" D BUILDJSON^SDES2JSON(.RESULTS,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 S LETIEN=$$VALLETTYPE(.ERRORS,LTYPE)
 D VALAPPT(.ERRORS,APPTIEN,LTYPE)
 I $D(ERRORS) D  Q
 . S ERRORS("letters",1)=""
 . D BUILDJSON^SDES2JSON(.RESULTS,.ERRORS)
 D APPTLETTER(.GBL,APPTIEN,LTYPE)
 M LETTERS("letters",1)=@GBL
 S LETTERS("letters",1,"appointmentID")=APPTIEN
 I $D(ERRORS) M LETTERS=ERRORS
 D BUILDJSON^SDES2JSON(.RESULTS,.LETTERS)
 Q
 ; print multiple letters
 ; SDES2 PRINT APPT LETTERS
 ; SDINPUT("Appointment IEN",IEN)="" IEN of the Appointment from file 409.84
 ; SDINPUT("Letter Type")=Letter type - "N"=No Show; "P"=Pre-Appointment; "A"=Cancelled by Patient; "C"=Cancelled by Clinic
PRINTLETTERS(RESULTS,SDCONTEXT,SDINPUT) ;
 N APPTIEN,ERRORS,LETIEN,LCNT,GBL,LETTERS,LINE,LTYPE,ERRAPT,ECNT
 N %H,%,%T,%Y ; To clear leaking variables from called routines
 ; validate context array
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("letters",1)="" D BUILDJSON^SDES2JSON(.RESULTS,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 I '$O(SDINPUT("Appointment IEN","")) D
 . D ERRLOG^SDES2JSON(.ERRORS,254)
 ; All Letters to be produced are only one type
 S LTYPE=$G(SDINPUT("Letter Type"))
 S LETIEN=$$VALLETTYPE(.ERRORS,LTYPE)
 I $D(ERRORS) S ERRORS("letters",1)="" D BUILDJSON^SDES2JSON(.RESULTS,.ERRORS) Q
 S (APPTIEN,LCNT,ECNT)=0
 ; build appointment letter for each appointment
 F  S APPTIEN=$O(SDINPUT("Appointment IEN",APPTIEN)) Q:'APPTIEN  D
 . K ERRAPT D VALAPPT(.ERRAPT,APPTIEN,LTYPE) I $D(ERRAPT) S ECNT=ECNT+1 S ERRORS("Error",ECNT)=ERRAPT("Error",1) Q
 . D APPTLETTER(.GBL,APPTIEN,LTYPE)
 . S LCNT=LCNT+1
 . M LETTERS("letters",LCNT)=@GBL
 . S LETTERS("letters",LCNT,"appointmentID")=APPTIEN
 I '$D(LETTERS) S LETTERS("letters",1)=""
 I $D(ERRORS) S:'$D(LETTERS) ERRORS("letters",1)="" M LETTERS=ERRORS
 D BUILDJSON^SDES2JSON(.RESULTS,.LETTERS)
 Q
 ; validate appointment list
VALAPPTS(ERRORS,LIST,LTYPE) ;
 N APPT
 I '$O(LIST("Appointment IEN",0)) D ERRLOG^SDES2JSON(.ERRORS,254)
 S APPT=0 F  S APPT=$O(LIST("Appointment IEN",APPT)) Q:'APPT  D VALAPPT(.ERRORS,APPT,LTYPE)
 Q
 ; Validate appointment and check for proper letter on clinic
VALAPPT(ERRORS,APPTIEN,LTYPE) ;
 N RES,CLINIEN,SCLETFLD,SDLET,LT,ERRTXT
 S LT=$G(LTYPE)
 I APPTIEN="" D ERRLOG^SDES2JSON(.ERRORS,14) Q
 I APPTIEN'="",'$D(^SDEC(409.84,APPTIEN,0)) D ERRLOG^SDES2JSON(.ERRORS,15,APPTIEN) Q
 S RES=$$GET1^DIQ(409.84,APPTIEN,.07,"I")
 S CLINIEN=$$GET1^DIQ(409.831,RES,.04,"I")
 S SCLETFLD=$S(LT="N":2508,LT="P":2509,LT="C":2510,LT="A":2511,1:2509)
 S SDLET=$$GET1^DIQ(44,CLINIEN,SCLETFLD,"I")
 I SDLET="" D  Q
 . S ERRTXT=$S(LT="N":"No-Show",LT="P":"Pre-Appointment",LT="C":"Clinic Cancellation",1:"Patient Cancellation")_" Letter not defined for Clinic "_$$GET1^DIQ(44,CLINIEN,.01,"E")
 . D ERRLOG^SDES2JSON(.ERRORS,227,ERRTXT)
 Q
 ; validate letter type
VALLETTYPE(ERRORS,LTYPE) ;
 N LIEN,RESOURCE,CLIN
 I '$L(LTYPE) D ERRLOG^SDES2JSON(.ERRORS,228) Q "" ; missing letter type
 I '$D(^VA(407.6,"B",LTYPE)) D ERRLOG^SDES2JSON(.ERRORS,226,LTYPE) Q ""  ;Invalid letter type.
 ;S LIEN=$$FIND1^DIC(407.6,,"B",LTYPE)
 S LIEN="",LIEN=$O(^VA(407.6,"B",LTYPE,LIEN))
 Q LIEN
 ; print single appointment letter
APPTLETTER(SDECY,SDECAPID,LT)  ;Print Appointment Letter
 ;APPTLETR(SDECY,SDECAPID,LT)  external parameter tag is in SDEC
 ; SDECAPPT = Pointer to appointment in SDEC APPOINTMENT file 409.84
 ; LT       = Letter type - "N"=No Show; "P"=Pre-Appointment; "A"=Cancelled by Patient; "C"=Cancelled by Clinic
 ;
 N SDECI,DFN,RES,CLINICIEN,SDLET,SDT,X1,X2,Y,TIMEZONE
 N SDIV,SDFORM,SDNAM,SDECDATA,SCLETFLD,ERRTXT
 S SDECI=0
 K ^TMP("SDEC_COMP",$J)
 S SDECY=$NA(^TMP("SDEC_COMP",$J))
 D GETS^DIQ(409.84,SDECAPID_",",".01;.05;.07","I","SDECDATA")
 S SDT=$G(SDECDATA(409.84,SDECAPID_",",.01,"I"))
 S DFN=$G(SDECDATA(409.84,SDECAPID_",",.05,"I"))
 S RES=$G(SDECDATA(409.84,SDECAPID_",",.07,"I"))
 S CLINICIEN=$$GET1^DIQ(409.831,RES,.04,"I")
 S SCLETFLD=$S(LT="N":2508,LT="P":2509,LT="C":2510,LT="A":2511,1:2509)
 S SDLET=$$GET1^DIQ(44,CLINICIEN,SCLETFLD,"I")
 S SDIV=$$GET1^DIQ(44,CLINICIEN,3.5,"I")
 S SDIV=$S(SDIV:SDIV,1:$O(^DG(40.8,0)))
 ; address location on letters 1 - bottom, 0 - top
 S SDFORM=$$GET1^DIQ(40.8,SDIV,30.01,"I")
 ; data header
 D PRT(DFN,CLINICIEN,SDT,LT,SDLET,SDFORM)
 D WRAPP(DFN,CLINICIEN,SDT,LT,SDLET)
 D REST(DFN,CLINICIEN,SDT,LT,SDLET,SDFORM)
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
 S SDECI=SDECI+1 S ^TMP("SDEC_COMP",$J,"topSection",SDECI)=$$FILL(64," ")_Y
 S SDECI=SDECI+1 S ^TMP("SDEC_COMP",$J,"topSection",SDECI)=$$FILL(64," ")_$$LILAST4(DFN)
 I 'SDFORM D ADDR(DFN)
 ;
 S DPTNAME("FILE")=2,DPTNAME("FIELD")=".01",DPTNAME("IENS")=(+DFN)_","
 S X=$$NAMEFMT^XLFNAME(.DPTNAME,"G","M")
 S SDECI=SDECI+1 S ^TMP("SDEC_COMP",$J,"salutation",SDECI)="Dear "_X_"," ;VSE-693;LEG 5/12/21
 ;loop and display initial section of Letter
 S INITSEC=0 F  S INITSEC=$O(^VA(407.5,SDLET,1,INITSEC)) Q:INITSEC'>0  D
 . S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"initialParagraph",SDECI)=$$GET1^DIQ(407.52,INITSEC_","_SDLET_",",.01,"E")
 Q
 ;
WRAPP(DFN,SDC,SD,LT,SDLET) ;WRITE APPOINTMENT INFORMATION
 N SDCL,SDDAT,SDHX,SDX,SDX1,X,PTAPPIENS
 S SDX=SD
 S SDCL=$$GET1^DIQ(44,+SDC,.01,"E")
 S SDCL="    Clinic:  "_SDCL D FORM(SDC,SDCL,SDX,,SDLET) ; SD*5.3*622 end changes
 S SDX1=SDX
 S PTAPPIENS=SD_","_DFN_","
 I $$GET1^DIQ(2.98,PTAPPIENS,5,"I")]"" D
 .S SDCL="LAB",SDX=$$GET1^DIQ(2.98,PTAPPIENS,5,"I") D FORM(SDC,SDCL,SDX,1)
 I $$GET1^DIQ(2.98,PTAPPIENS,6,"I")]"" D
 .S SDCL="XRAY",SDX=$$GET1^DIQ(2.98,PTAPPIENS,6,"I") D FORM(SDC,SDCL,SDX,1)
 I $$GET1^DIQ(2.98,PTAPPIENS,7,"I")]"" D
 .S SDCL="EKG",SDX=$$GET1^DIQ(2.98,PTAPPIENS,7,"I") D FORM(SDC,SDCL,SDX,1)
 S (SDX,X)=SDX1
 Q
 ; SD*5.3*622 - add more detail for appointment and format it
 ; SDC - clinic ien
 ; SDCL - clinic name or xray/lab/ekg
 ; SDX - date/time
 ; LEXPROC - is only passed in when this is a lab/xray/ekg date
 ;
 ;  Change display time for noon and midnight from 12:00 PM to 12:00 Noon and 12:00 Midnight
FORM(SDC,SDCL,SDX,LEXPROC,SDLET) ;
 N TIMEZONE,X,J,SDLOC,SDPROV,SDPRNM,SDTEL,SDTELEXT,SDTMP,SDHX,SDT0,DOW
 S TIMEZONE=$$TIMEZONEDATA^SDESUTIL($G(SDC)),TIMEZONE=$P($G(TIMEZONE),U)
 S:$D(SDX) X=SDX S SDHX=X D DW^%DTC S DOW=X,X=SDHX ;
 I $P(X,".",2)=12!($P(X,".",2)=24) S X="12:00 "_$S($P(X,".",2)=12:"N",1:"M") ;
 E  X ^DD("FUNC",2,1) ;
 S SDT0=X,SDDAT=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",$E(SDHX,4,5))_" "_+$E(SDHX,6,7)_", "_(1700+$E(SDHX,1,3))
 I '$D(LEXPROC) D
 .S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"scheduledAppointments",SDECI)="     Date/Time: "_DOW_"  "_$J(SDDAT,12)_$S('$D(LEXPROC)&$D(SDC):$J(SDT0,9),1:"")_" "_TIMEZONE
 I '$D(LEXPROC),$D(SDC) D
 .S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"scheduledAppointments",SDECI)="    "_SDCL
 ; get default provider if defined for a given clinic, print it on the
 ; letter only if we have a YES on file, same for clinic location
 ; skip printing the provider label if the field is empty in file #44
 S SDLOC=$$GET1^DIQ(44,+SDC,10,"I") ; physical location of the clinic
 S SDTEL=$$GET1^DIQ(44,+SDC,99,"I")        ; telephone number of clinic
 S SDTELEXT="" I SDTEL]"",$$GET1^DIQ(44,+SDC,99.1,"I")]"" D
 .S SDTELEXT=$$GET1^DIQ(44,+SDC,99.1,"I")  ; telephone ext of clinic
 ; get default provider, if any
 F J=0:0 S J=$O(^SC(+SDC,"PR",J)) Q:'J>0  D
 . I $$GET1^DIQ(44.1,J_","_+SDC_",",.02,"I")'=1 Q
 . S SDPROV=$$GET1^DIQ(44.1,J_","_+SDC_",",.01,"I")
 I $D(SDC),'$D(LEXPROC),$$GET1^DIQ(407.5,SDLET,5,"I")="Y" D
 . I SDLOC]"" S SDECI=SDECI+1 S ^TMP("SDEC_COMP",$J,"scheduledAppointments",SDECI)="     "_"Location:  "_SDLOC
 I $D(SDC),'$D(LEXPROC),SDTEL]"" D
 . S SDTMP="     Telephone:  "_SDTEL
 . I SDTELEXT]"" S SDTMP=SDTMP_"   Telephone Ext.:  "_SDTELEXT
 . S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"scheduledAppointments",SDECI)=SDTMP
 I $D(SDPROV) D
 . I $D(SDC),SDPROV>0 S SDPRNM=$P(^VA(200,SDPROV,0),U,1)
 . I $D(SDC),'$D(LEXPROC),$P($G(^VA(407.5,SDLET,3)),U,1)="Y" I SDPRNM]"" S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"scheduledAppointments",SDECI)="     Provider:  "_$G(SDPRNM)
 ; call handler for LAB, XRAY, and EKG tests
 I $D(LEXPROC) D TST(SDCL,DOW)
 Q
REST(DFN,SDC,SD,LT,SDLET,SDFORM) ;WRITE THE REMAINDER OF LETTER
 N FINSEC
 ;loop and display final section of Letter
 S FINSEC=0 F  S FINSEC=$O(^VA(407.5,SDLET,2,FINSEC)) Q:FINSEC'>0  D
 . S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"textClosing",SDECI)=$$GET1^DIQ(407.53,FINSEC_","_SDLET_",",.01,"E")
 I SDFORM=1 D ADDR(DFN)
 Q
ADDR(DFN) ;
 K VAHOW
 N SDIENS,X,SDCCACT1,SDCCACT2,LL,VAPA,VACNTRY
 S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"addressPatient",SDECI)=$$FILL(11," ")_$$FML^DGNFUNC(DFN)
 I $D(^DG(43,1,"BT")),'$$GET1^DIQ(43,1,722,"I") S VAPA("P")=""
 D ADD^VADPT
 ;CHANGE STATE TO ABBR.
 I $D(VAPA(5)) S SDIENS=+VAPA(5)_",",X=$$GET1^DIQ(5,SDIENS,1),$P(VAPA(5),U,2)=X
 I $D(VAPA(17)) S SDIENS=+VAPA(17)_",",X=$$GET1^DIQ(5,SDIENS,1),$P(VAPA(17),U,2)=X
 S SDCCACT1=VAPA(12),SDCCACT2=$P($G(VAPA(22,2)),"^",3)
 ;if confidential address is not active for scheduling/appointment letters, print to regular address
 I ($G(SDCCACT1)=0)!($G(SDCCACT2)'="Y") D
 . F LL=1:1:3 I VAPA(LL)]"" S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"addressPatient",SDECI)=$$FILL(11," ")_VAPA(LL)
 . ;if country is blank display as USA
 . I (VAPA(25)="")!($P(VAPA(25),"^",2)="UNITED STATES")  D  ;display city,state,zip
 .. S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"addressPatient",SDECI)=$$FILL(11," ")_VAPA(4)_" "_$P(VAPA(5),U,2)_"  "_$P(VAPA(11),U,2)
 . E  D  ;display postal code,city,province
 .. S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"addressPatient",SDECI)=$$FILL(11," ")_VAPA(24)_" "_VAPA(4)_" "_VAPA(23)_$C(13,10)
 . I ($P(VAPA(25),"^",2)'="UNITED STATES") S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"addressPatient",SDECI)=$$FILL(11," ")_$P(VAPA(25),U,2) ;display country
 ;if confidential address is active for scheduling/appointment letters, print to confidential address
 I $G(SDCCACT1)=1,$G(SDCCACT2)="Y" D
 . F LL=13:1:15 I VAPA(LL)]"" S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"addressPatient",SDECI)=$$FILL(11," ")_VAPA(LL)
 . I (VAPA(28)="")!($P(VAPA(28),"^",2)="UNITED STATES") D
 .. S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"addressPatient",SDECI)=$$FILL(11," ")_VAPA(16)_" "_$P(VAPA(17),U,2)_"  "_$P(VAPA(18),U,2)
 . E  D
 .. S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"addressPatient",SDECI)=$$FILL(11," ")_VAPA(27)_" "_VAPA(16)_" "_VAPA(26)
 . I ($P(VAPA(28),"^",2)'="UNITED STATES") S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"addressPatient",SDECI)=$$FILL(11," ")_$P(VAPA(28),U,2)
 D KVAR^VADPT
 Q
 ;
DTS(Y) ;
 Q:'Y ""
 Q $TR($$FMTE^XLFDT(Y,"5DF")," ","0")
 ;
BADADD ;Print patients with a Bad Address Indicator
 I '$D(^TMP($J,"BADADD")) Q
 N SDHDR,SDHDR1,SDNAM,SDDFN
 S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"BadAddress",SDECI)=$$FILL(79,"*")
 S SDHDR="BAD ADDRESS INDICATOR LIST" S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"BadAddress",SDECI)=$$FILL((80-$L(SDHDR)/2)," ")_SDHDR
 S SDHDR1="** THE LETTER FOR THESE PATIENT(S) DID NOT PRINT DUE TO A BAD ADDRESS INDICATOR."
 S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"BadAddress",SDECI)="Last 4"
 S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"BadAddress",SDECI)="of SSN   "_"Patient Name"
 S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"BadAddress",SDECI)=$$FILL(79,"*")
 S SDNAM="" F  S SDNAM=$O(^TMP($J,"BADADD",SDNAM)) Q:SDNAM=""  D
 . S SDDFN=0 F  S SDDFN=$O(^TMP($J,"BADADD",SDNAM,SDDFN)) Q:'SDDFN  D
 .. S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"BadAddress",SDECI)=$$LILAST4(SDDFN)_"      "_SDNAM_$C(13,10)
 S SDECI=SDECI+1,^TMP("SDEC_COMP",$J,"BadAddress",SDECI)=SDHDR1
 Q
 ;
TST(SDCL,DOW) ; handle scheduled tests
 I ($L(SDCL)=3&($E(SDCL,1,3)="LAB")) D
 . S SDECI=SDECI+1
 . S ^TMP("SDEC_COMP",$J,"scheduledAppointments",SDECI)=" "_SDCL_" SCHEDULED:  "_DOW_"  "_$J(SDDAT,12)_"  "_$J(SDT0,5)
 I ($L(SDCL)=4&($E(SDCL,1,4)="XRAY")) D
 . S SDECI=SDECI+1
 . S ^TMP("SDEC_COMP",$J,"scheduledAppointments",SDECI)=SDCL_" SCHEDULED:  "_DOW_"  "_$J(SDDAT,12)_"  "_$J(SDT0,5)
 I ($L(SDCL)=3&($E(SDCL,1,3)="EKG")) D
 . S SDECI=SDECI+1
 . S ^TMP("SDEC_COMP",$J,"scheduledAppointments",SDECI)=" "_SDCL_" SCHEDULED:  "_DOW_"  "_$J(SDDAT,12)_"  "_$J(SDT0,5)
 Q
FILL(PADS,CHAR)  ;pad string
 N I,RET
 S CHAR=$G(CHAR)
 S:CHAR="" CHAR=" "
 S RET=""
 F I=1:1:PADS S RET=RET_CHAR
 Q RET
LILAST4(DFN) ;Retrieve the first letter of the last name and append last 4 SSN of a patient
 N LAST4SSN,LASTIN,OUT
 S OUT="     " Q OUT
 ;
 S LASTIN=$E($$GET1^DIQ(2,DFN_",",.01,"E"),1,1)
 S LAST4SSN=$$GET1^DIQ(2,DFN_",",.09,"E")
 I LAST4SSN["P" S LAST4SSN=$E(LAST4SSN,6,10) Q LASTIN_LAST4SSN
 S LAST4SSN=$E(LAST4SSN,6,9)
 Q LASTIN_LAST4SSN
 ;
