SD53121 ;ALB/JRP - PATCH 121 POST-INIT;18-APR-97
 ;;5.3;Scheduling;**121**;Aug 13, 1993
 ;
POST ;Main entry point of post-init
 D DELTRIG
 D SEED
 D ERRCODE
 D MGCHK
 Q
 ;
DELTRIG ;Delete obsolete triggers on the TRANSMISSION REQUIRED field (#.04)
 ; of the TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73)
 ;
 ;Declare variables
 N NODE,XREFNUM,X,DIK,DA,XPDIDTOT
 ;Print header
 D BMES^XPDUTL(">>> Deleting obsolete triggers on the TRANSMISSION REQUIRED field")
 D MES^XPDUTL("    (#.04) of the TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73).")
 D MES^XPDUTL("")
 ;Get last x-ref number
 S XPDIDTOT=+$O(^DD(409.73,.04,1,""),-1)
 ;Loop through list of x-refs
 S XREFNUM=0
 F  S XREFNUM=+$O(^DD(409.73,.04,1,XREFNUM)) Q:('XREFNUM)  D
 .;If KIDS install, show progress through status bar
 .D:($G(XPDNM)'="") UPDATE^XPDID(XREFNUM)
 .;Grab zero node
 .S NODE=$G(^DD(409.73,.04,1,XREFNUM,0))
 .;Make sure it's a trigger x-ref
 .Q:($P(NODE,"^",3)'="TRIGGER")
 .;Make sure it triggers a field in 409.73
 .Q:($P(NODE,"^",4)'=409.73)
 .;Make sure it's one of the fields that should no longer be triggered
 .S X=","_(+$P(NODE,"^",5))_","
 .Q:(",11,12,13,14,15,"'[X)
 .;Obsolete triggers delete their triggered fields
 .Q:($G(^DD(409.73,.04,1,XREFNUM,"CREATE VALUE"))'="@")
 .;Delete obsolete trigger
 .S DIK="^DD(409.73,.04,1,"
 .S DA(2)=409.73
 .S DA(1)=.04
 .S DA=XREFNUM
 .D ^DIK
 .S X="    Trigger cross reference number "_XREFNUM_" deleted"
 .D MES^XPDUTL(X)
 D BMES^XPDUTL("")
 Q
 ;
ERRCODE ;Update ERROR CODE DESCRIPTION field (#11) of the TRANSMITTED
 ; OUTPATIENT ENCOUNTER ERROR CODE file (#409.76) for error codes
 ; 420 & 105 (AAC changed descriptions to reflect receipt of info
 ; past close-out)
 ;
 ;Declare variables
 N SD53FDA,SD53IEN,SD53MSG
 ;Print info
 D BMES^XPDUTL(">>> Updating the ERROR CODE DESCRIPTION field (#11) of")
 D MES^XPDUTL("    the TRANSMITTED OUTPATIENT ENCOUNTER ERROR CODE file")
 D MES^XPDUTL("    (#409.76) for error codes 420 and 105.  Definitions")
 D MES^XPDUTL("    were modified to reflect receipt of data by NPCD")
 D MES^XPDUTL("    after close-out.")
 D MES^XPDUTL("")
 ;Set up call to FileMan Updater (call will find/create entry)
 S SD53FDA(409.76,"?+1,",.01)=420
 S SD53FDA(409.76,"?+1,",11)="Date of Encounter is invalid, after date of transmission, or after close-out."
 S SD53FDA(409.76,"?+2,",.01)=105
 S SD53FDA(409.76,"?+2,",11)="Event Date is missing, invalid, after processing date, or after close-out."
 ;Call FileMan Updater
 D UPDATE^DIE("ES","SD53FDA","SD53IEN","SD53MSG")
 ;Error
 I ($D(SD53MSG("DIERR"))) D
 .N SD53TMP
 .D BMES^XPDUTL("    *** The following error occurred while updating descriptions ***")
 .D MSG^DIALOG("ASE",.SD53TMP,70,5,"SD53MSG")
 .D MES^XPDUTL("")
 .D MES^XPDUTL(.SD53TMP)
 D BMES^XPDUTL("")
 Q
 ;
MGCHK ;Check to see if the LATE ACTIVITY MAIL GROUP field (#217) of the
 ; MAS PARAMETERS file (#43) contains a valid mail group
 ;
 ;Declare variables
 N NODE,XMDUZ,XMY,OK
 S OK=1
 ;Print header
 D BMES^XPDUTL(">>> Checking for existance of a valid mail group in the")
 D MES^XPDUTL("    LATE ACTIVITY MAIL GROUP field (#217) of the MAS")
 D MES^XPDUTL("    PARAMETERS file (#43).  Members of this mail group")
 D MES^XPDUTL("    will be notified of all late National Patient Care")
 D MES^XPDUTL("    Database activity.")
 D MES^XPDUTL("")
 ;Get pointer to mail group
 S NODE=$G(^DG(43,1,"SCLR"))
 S:('$P(NODE,"^",17)) OK=0
 ;Use call that builds XMY() - will validate pointer (also sets XMDUZ)
 I (OK) D XMY^SDUTL2($P(NODE,"^",17),0,0) S:('$D(XMY)) OK=0
 ;Valid mail group
 I (OK) D
 .S XMDUZ=$O(XMY(""))
 .D BMES^XPDUTL("    Late NPCD activity will be delivered to members of")
 .D MES^XPDUTL("    the "_$P(XMDUZ,".",2)_" mail group")
 ;Valid mail group not found
 I ('OK) D
 .D BMES^XPDUTL("    *** Valid mail group not found")
 .D BMES^XPDUTL("    *** Notification of late NPCD activity will not occur")
 .D BMES^XPDUTL("    *** Use the Scheduling Parameters option [SD PARM PARAMETERS]")
 .D MES^XPDUTL("        to select a mail group that will receive the notifications")
 D BMES^XPDUTL("")
 Q
 ;
SEED ;Seed NPCD ENCOUNTER MONTH multiple (#404.9171) of the SCHEDULING
 ; PARAMETER file (#404.91) with close-out dates for fiscal year 1997
 ;
 ;Declare variables
 N XPDIDTOT,LINE,DATES,WLMONTH,DBCLOSE,WLCLOSE,TMP
 ;Print header
 D BMES^XPDUTL(">>> Storing close-out dates for Fiscal Year 1997")
 S TMP=$$INSERT^SCDXUTL1("Workload","",7)
 S TMP=$$INSERT^SCDXUTL1("Database",TMP,27)
 S TMP=$$INSERT^SCDXUTL1("Workload",TMP,47)
 D BMES^XPDUTL(TMP)
 S TMP=$$INSERT^SCDXUTL1("Occured In","",6)
 S TMP=$$INSERT^SCDXUTL1("Close-Out",TMP,27)
 S TMP=$$INSERT^SCDXUTL1("Close-Out",TMP,47)
 D MES^XPDUTL(TMP)
 S TMP=$$INSERT^SCDXUTL1("------------","",5)
 S TMP=$$INSERT^SCDXUTL1("------------",TMP,25)
 S TMP=$$INSERT^SCDXUTL1("------------",TMP,45)
 D MES^XPDUTL(TMP)
 ;Loop through list of dates
 S XPDIDTOT=12
 F LINE=2:1:13 S TMP=$T(FY97+LINE),DATES=$P(TMP,";",3) Q:(DATES="")  D
 .;Break out info
 .S WLMONTH=$P(DATES,"^",1)
 .S DBCLOSE=$P(DATES,"^",2)
 .S WLCLOSE=$P(DATES,"^",3)
 .;Print close-out info
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(WLMONTH,"1D"),"",7)
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(DBCLOSE,"1D"),TMP,25)
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(WLCLOSE,"1D"),TMP,45)
 .D MES^XPDUTL(TMP)
 .;Store close-out info
 .S TMP=$$AECLOSE^SCDXFU04(WLMONTH,DBCLOSE,WLCLOSE)
 .;If KIDS install, show progress through status bar
 .D:($G(XPDNM)'="") UPDATE^XPDID(LINE-1)
 D BMES^XPDUTL("")
 Q
 ;
FY97 ;Close-out dates for fiscal year 1997
 ;  Month ^ Database Close-Out ^ Workload Close-Out
 ;;2961000^2970430^2970331
 ;;2961100^2970430^2970331
 ;;2961200^2970430^2970331
 ;;2970100^2970430^2970331
 ;;2970200^2970430^2970331
 ;;2970300^2970430^2970430
 ;;2970400^2971031^2970531
 ;;2970500^2971031^2970630
 ;;2970600^2971031^2970731
 ;;2970700^2971031^2970831
 ;;2970800^2971031^2970930
 ;;2970900^2971031^2971031
 ;
