SD53229P ;ALB-CIOFO/MRY - POST INSTALL SD*5.3*229 ; 20 Sep 99  09:00 AM
 ;;5.3;Scheduling;**229**;Aug 13 1993
 ;
SEED ;Seed NPCD ENCOUNTER MONTH multiple (#404.9171) of the SCHEDULING
 ; PARAMETER file (#404.91) with workload close-out dates for FY2001
 ;
 ;Declare variables
 N XPDIDTOT,LINE,DATES,WLMONTH,DBCLOSE,WLCLOSE,TMP
 ;Print header
 D BMES^XPDUTL(">>> Storing close-out dates for Fiscal Year 2001")
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
 F LINE=2:1:13 S TMP=$T(FY01+LINE),DATES=$P(TMP,";",3) Q:(DATES="")  D
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
 .;Write error message if datebase or workload dates not updated
 .I TMP<0 D MES^XPDUTL("       >>>>Could not update closeout dates for above month.")
 .;If KIDS install, show progress through status bar
 .D:($G(XPDNM)'="") UPDATE^XPDID(LINE-1)
 D BMES^XPDUTL("")
 Q
 ;
FY01 ;Revised Close-out dates for fiscal year 2001
 ;  Month ^ Database Close-Out ^ Workload Close-Out
 ;;3001000^3011012^3001110
 ;;3001100^3011012^3001208
 ;;3001200^3011012^3010112
 ;;3010100^3011012^3010209
 ;;3010200^3011012^3010309
 ;;3010300^3011012^3010406
 ;;3010400^3011012^3010511
 ;;3010500^3011012^3010608
 ;;3010600^3011012^3010706
 ;;3010700^3011012^3010810
 ;;3010800^3011012^3010907
 ;;3010900^3011012^3011012
 ;
 Q
