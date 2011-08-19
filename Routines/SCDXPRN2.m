SCDXPRN2 ;ALB/JRP - HISTORY FILE REPORTS;21-JUL-1997
 ;;5.3;Scheduling;**128,135,405**;AUG 13, 1993
 ;
FULLHIST ;Print full transmission history report
 ; - Report based within the ACRP Transmission History file (#409.77)
 ; - User prompted for selection criteria
 ;     Division (one/many/all)     Clinic (o/m/a)     Patient (o/m/a)
 ; - User prompted for transmission date range
 ; - Report formatted for 80 columns (allows output to screen)
 ;
 ;Declare variables
 N VAUTSTR,VAUTNI,VAUTVB,VAUTNALL,VAUTD,VAUTC,VAUTN
 N SCDXBEG,SCDXEND,SCDXGLO,X,Y,SCDXH,SCDXLOCK
 ;SD*5.3*405 lock user from running multiple times in same session
 I $D(^TMP("RPT-LOCK",$J,DUZ)) W !!,"Sorry, you either have this report already running or queued to run.",!,"Please try again later.",!! Q
 ;Initialize selection global
 S SCDXGLO=$NA(^TMP("SCDXPRN2",$J,"SELECT"))
 K @SCDXGLO
 ;Get division(s) - default to 'ALL' if single division
 S VAUTD=1 I ($P($G(^DG(43,1,"GL")),"^",2)) D DIVISION^VAUTOMA Q:(Y<0)
 ;Copy into global location [for tasking]
 ; Local array not deleted - it's required input for clinic selection
 M @SCDXGLO@("VAUTD")=VAUTD
 ;Get clinic(s)
 S VAUTNI=2 D CLINIC^VAUTOMA Q:(Y<0)
 ;Copy into global location [for tasking] and delete local array
 M @SCDXGLO@("VAUTC")=VAUTC
 K VAUTC
 ;Delete local array of selected divisions
 K VAUTD
 ;Get patient(s)
 S VAUTNI=2 D PATIENT^VAUTOMA Q:(Y<0)
 ;Copy into global location [for tasking] and delete array
 M @SCDXGLO@("VAUTN")=VAUTN
 K VAUTN
 ;Set allowable date range
 S SCDXBEG=2961001
 S SCDXEND=$$DT^XLFDT()
 ;Begin date help text
 S SCDXH("B",1)="Enter transmission date to begin search from"
 S SCDXH("B",2)=" "
 S SCDXH("B",3)=$$FMTE^XLFDT(SCDXBEG)_" is the earliest date allowed"
 S SCDXH("B",4)=$$FMTE^XLFDT(SCDXEND)_" will be the latest date allowed"
 S SCDXH("B",5)=" "
 S SCDXH("B",6)="Note: Encounter date does not always match date of"
 S SCDXH("B")="      transmission to the National Patient Care Database"
 ; End date help text
 S SCDXH("E",1)="Enter transmission date to end search at"
 S SCDXH("E",2)=" "
 S SCDXH("E",3)=$$FMTE^XLFDT(SCDXEND)_" is the latest date allowed"
 S SCDXH("E",4)=$$FMTE^XLFDT(SCDXBEG)_" was the earliest date allowed"
 S SCDXH("E",5)=" "
 S SCDXH("E",6)="Note: Encounter date does not always match date of"
 S SCDXH("E")="      transmission to the National Patient Care Database"
 S X=$$GETDTRNG^SCDXUTL1(SCDXBEG,SCDXEND,$NA(SCDXH("B")),$NA(SCDXH("E")))
 Q:(X<0)
 K SCDXH
 S SCDXBEG=+$P(X,"^",1)
 S SCDXEND=+$P(X,"^",2)
 S SCDXLOCK=$J_U_DUZ  ;SD*5.3*405 lock variable for when report is queued
 S ^TMP("RPT-LOCK",$J,DUZ)=""  ;SD*5.3*405 set lock for current user
 ;Queue/run
 W !!
 S ZTDESC="ACRP TRANSMISSION HISTORY REPORT"
 S ZTSAVE("SCDXBEG")=""
 S ZTSAVE("SCDXEND")=""
 S ZTSAVE("SCDXGLO")=""
 S ZTSAVE("SCDXLOCK")=""  ;SD*5.3*405
 S ZTSAVE($$OREF^DILF(SCDXGLO))=""
 S IOP="Q"
 D EN^XUTMDEVQ("PRINT^SCDXPRN2",ZTDESC,.ZTSAVE)
 ;Done - reset IO variables (safety measure) and quit
 I POP K ^TMP("RPT-LOCK",$J,DUZ)
 I $D(X) I X="^" K ^TMP("RPT-LOCK",$J,DUZ)
 D HOME^%ZIS
 Q
 ;
PRINT ;Print report
 ;Input  : SCDXBEG - Begin date (FileMan)
 ;                 - Refers to date/time of transmission (not encounter)
 ;         SCDXEND - End date (FileMan)
 ;                 - Refers to date/time of transmission (not encounter)
 ;         SCDXGLO - Global containing selection criteria
 ;         SCDXLOCK- Equals user's DUZ and locks the same user from
 ;                   queueing the report more than once at the same time
 ;                   This was output of calls to VAUTOMA for division,
 ;                   clinic, and patient (full global reference)
 ;           Divisions selected   Clinics selected     Patients selected
 ;           SCDXGLO("VAUTD")     SCDXGLO("VAUTC")     SCDXGLO("VAUTN")
 ;           SCDXGLO("VAUTD",x)   SCDXGLO("VAUTC",x)   SCDXGLO("VAUTN",x)
 ;Output : None
 ;Notes  : All input is REQUIRED - report will not be generated if
 ;         any of the variables are not defined
 ;       : All input (including global location) will be deleted on exit
 ;       : User will be prompted for device except on queued entry
 ;
 ;Declare variables
 N DIC,L,BY,FR,TO,DHD,FLDS,DISPAR,DIOBEG,DIOEND,IOP,SCDXSLVE,DOLJ
 ;Define sort criteria
 S DIC="^SD(409.77,"
 S L=0
 ;Define sort array
 S BY(0)="^TMP(""SCDXPRN2"",$J,""SORT"","
 S L(0)=6
 ;Make FileMan think sort already done (set fake value into array)
 S ^TMP("SCDXPRN2",$J,"SORT",1,2,3,4,5,6)=""
 ;Define sort routine
 S DIOBEG="D SORT^SCDXPRN2"
 ;Define post-report action
 S DIOEND="K ^TMP(""SCDXPRN2"",$J,""SORT"")"
 ;Form feed for each clinic
 S DISPAR(0,2)="#^;"
 ;Define print fields
 S FLDS="[SCDX XMIT HIST FULL PRINT]"
 ;Define header & footer
 S DHD="[SCDX XMIT HIST FULL HEADER]-[SCDX XMIT HIST FULL FOOTER]"
 ;Use current device
 S IOP=IO
 ;Remember IO("S")
 S SCDXSLVE=+$G(IO("S"))
 ;Print report
 D EN1^DIP
 ;Reset IO("S")
 S:(SCDXSLVE) IO("S")=SCDXSLVE
 ;Delete input array & variables
 K @SCDXGLO
 K SCDXBEG,SCDXEND,SCDXGLO
 ;If queued, purge task
 S:($D(ZTQUEUED)) ZTREQ="@"
 ;SD*5.3*405 remove lock for current user
 K ^TMP("RPT-LOCK",$P(SCDXLOCK,U,1),$P(SCDXLOCK,U,2))
 Q
 ;
SORT ;Sort routine
 ;Input  : See TASK entry point
 ;Output : Global containing sorted entries for printing
 ;           ^TMP("SCDXPRN2",$J,"SORT",Div,Clin,Pat,EncDate,VID,DA)
 ;             Div = Division name     Clin = Clinic name
 ;             Pat = Patient name      EncDate = Encounter date [no time]
 ;             VID = Visit ID          DA = Pointer to entry in 409.77
 ;Notes  : ^TMP("SCDXPRN2",$J,"SORT") will be initialized upon entry
 ;       : Existance & validity of input is assumed
 ;
 ;Declare variables
 N HISTPTR,NODE,DATE,NAME,CLINIC,DIVISION,VID
 N BEGDATE,ENDDATE,TMP,VAUTD,VAUTC,VAUTN
 ;Make begin and end dates opposing midnights
 S BEGDATE=$$FMADD^XLFDT($P(SCDXBEG,".",1),-1,23,59,59)
 S ENDDATE=$$FMADD^XLFDT($P(SCDXEND,".",1),0,23,59,59)
 ;All divisions selected ?
 S VAUTD=+$G(@SCDXGLO@("VAUTD"))
 ;All clinics selected ?
 S VAUTC=+$G(@SCDXGLO@("VAUTC"))
 ;All patients selected ?
 S VAUTN=+$G(@SCDXGLO@("VAUTN"))
 ;Initialize sort array
 K ^TMP("SCDXPRN2",$J,"SORT")
 ;Sort/screen
 F  S BEGDATE=+$O(^SD(409.77,"AXMIT",BEGDATE)) Q:(('BEGDATE)!(BEGDATE>ENDDATE))  D  Q:($$S^%ZTLOAD())
 .S HISTPTR=0
 .F  S HISTPTR=+$O(^SD(409.77,"AXMIT",BEGDATE,HISTPTR)) Q:('HISTPTR)  D  Q:($$S^%ZTLOAD())
 ..;Grab zero node of entry
 ..S NODE=$G(^SD(409.77,HISTPTR,0))
 ..;Get encounter date (strip time)
 ..S TMP=+$P(NODE,"^",2)
 ..S DATE=$P(TMP,".",1)
 ..;Get patient
 ..S TMP=+$P(NODE,"^",3)
 ..S NAME=$P($G(^DPT(TMP,0),"UNKNOWN"),"^",1)
 ..;Patient selection screen
 ..I ('VAUTN) Q:('$D(@SCDXGLO@("VAUTN",TMP)))
 ..;Get clinic
 ..S TMP=+$P(NODE,"^",4)
 ..S CLINIC=$P($G(^SC(TMP,0),"UNKNOWN"),"^",1)
 ..;Clinic selection screen
 ..I ('VAUTC) Q:('$D(@SCDXGLO@("VAUTC",TMP)))
 ..;Get division
 ..S TMP=+$P(NODE,"^",5)
 ..S DIVISION=$P($G(^DG(40.8,TMP,0),"UNKNOWN"),"^",1)
 ..;Division selection screen
 ..I ('VAUTD) Q:('$D(@SCDXGLO@("VAUTD",TMP)))
 ..;Get visit ID
 ..S VID=+$P(NODE,"^",6)
 ..;Store in pre-sort array
 ..S ^TMP("SCDXPRN2",$J,"SORT",DIVISION,CLINIC,NAME,DATE,VID,HISTPTR)=""
 ;Done
 Q
