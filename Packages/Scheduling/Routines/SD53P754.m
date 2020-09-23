SD53P754 ;MS/GN - TMP POST INSTALL;July 05, 2018
 ;;5.3;Scheduling;**754**;May 29, 2018;Build 5
 ;
 ;Post install routine for SD*5.3*754 to cleanup file 409.85 and add a CID date that was null.
 ;This routine will be left installed for possible UNDO tag execution during a backout patch scenario.
 ; ** Note: UNDO will not work if XTMP has been purged after its 90 day expiration date. **
 ;          Site can delete this routine anytime they prefer at a later date.
 ;
EN ;Begin Post Install
 S BEGDT=$P(^XPD(9.7,$O(^XPD(9.7,"B","SD*5.3*704","")),0),U,3)\1
 S ENDDT=$P(^XPD(9.7,$O(^XPD(9.7,"B","SD*5.3*714","")),0),U,3)\1
 D FIXCID(BEGDT,ENDDT)  ;strt date of search for bad data AFTER *704, end date of search after *714
 Q
FIXCID(BEGIN,END) ;Fix CID/PREFERRED DATE OF APPT field (#22) in SDEC APPOINTMENT REQUEST file (#409.85)
 N AP,APSTS,CDT,CNT,CNTD,ERRCNT,ERRDIS S (CNT,CNTD,ERRCNT,ERRDIS)=0
 S NAME="SD53P754"
 S ^XTMP(NAME,0)=$$FMADD^XLFDT(DT,90)_U_DT_U_"POST INSTALL SD53P754 TMP APPT CID DT FIX"
 D MES^XPDUTL("")
 D MES^XPDUTL("Beginning update of data in the SDEC APPT REQUEST file...")
 D MES^XPDUTL("")
 ;
 ;Save original 0 & "DIS" nodes prior to updating date fields to XTMP for 60 days, after 60 it will be auto deleted.
 ;
 ;Update recs with null CID/Preferred Date of Appt field #22 in the SDEC APPT REQUEST file (#409.85)
 S (CNT,CNTO)=0
 F ST="C","O" D
 . F DTE=BEGIN:0 S DTE=$O(^SDEC(409.85,"E",ST,DTE)) Q:('DTE)!(DTE>END)  D
 .. F AP=0:0 S AP=$O(^SDEC(409.85,"E",ST,DTE,AP)) Q:'AP  D:'$P(^SDEC(409.85,AP,0),U,16)
 ... S:ST="C" CNT=CNT+1 S:ST="O" CNTO=CNTO+1
 ... S APNODE0=^SDEC(409.85,AP,0),^XTMP(NAME,AP,"BEFOR")=APNODE0
 ... S APSTS=$P(APNODE0,U,17)                                         ;get appt sts
 ... S CDT=+$P(APNODE0,U,2) S:'CDT CDT=DT                             ;get CREATE DATE FIELD (#1) for updating CID date, else DT
 ... D UPDCID(AP,CDT)                                                 ;update CID field
 ... I '$P($G(^SDEC(409.85,AP,"DIS")),U) D
 .... S ^XTMP(NAME,AP,"DIS BEFOR")=$G(^SDEC(409.85,AP,"DIS"))
 .... D UPDDIS(AP,CDT,APSTS)                                            ;Update DIS nodes
 D MES^XPDUTL(""),MES^XPDUTL("==== Appt Records Fixed ====")
 D MES^XPDUTL(""),MES^XPDUTL("  Open sts Count: "_CNTO)
 D MES^XPDUTL(""),MES^XPDUTL("Closed sts Count: "_CNT)
 D MES^XPDUTL(""),MES^XPDUTL("     Total Count: "_(CNT+CNTO))
 S ^XTMP(NAME,0,"TOTAL EMPTY CID RECORDS UPDATED")=CNT
 S ^XTMP(NAME,0,"TOTAL EMPTY CID UPDATE ERRORS")=ERRCNT
 S ^XTMP(NAME,0,"TOTAL EMPTY DIS RECORDS UPDATED")=CNTD
 S ^XTMP(NAME,0,"TOTAL EMPTY DIS UPDATE ERRORS")=ERRDIS
 S ^XTMP(NAME,0,"TOTAL FILE ERRORS")=(ERRCNT+ERRDIS)
 D MES^XPDUTL("")
 D MES^XPDUTL("===== Update Completed =====")
 D MES^XPDUTL("")
 Q
UPDCID(AP,CDT)  ;Update 409.85 file field #22
 ; AP  - Rec ien for 409.85 file
 ; CDT - CID date (FM format no time) in Appt Req file
 N ERR,FDA
 S FDA(409.85,AP_",",22)=CDT
 D UPDATE^DIE(,"FDA","ERR")
 S ^XTMP(NAME,AP,"AFTER")=^SDEC(409.85,AP,0)
 I $D(ERR) D
 . D MES^XPDUTL("FileMan error when updating APPT recnum: "_AP) S ERRCNT=ERRCNT+1 M ^XTMP(NAME,AP,"ERR")=ERR
 E  D
 . S CNT=CNT+1
 Q
UPDDIS(AP,DDT,APSTS) ;Update the "DIS" node in 409.85 file field all fields especially date (#19)  
 ; AP  - Rec ien for 409.85 file
 ; CDT - Dispositioned date (FM format no time) in Appt Req file
 ;
 ;If DIS date is null then prodeed, else do nothing, update this node as follows:
 ;
 ;   DIS;1               19  DATE DISPOSITIONED   = same date used in CID update
 ;   DIS;2               20  DISPOSITIONED BY     = DUZ
 ;   DIS;3               21  DISPOSITION          = "SA"
 ;   DIS;4             21.1  DISPOSITION CLOSED BY CLEANUP =          <-- ???? LEAVE NULL FOR NOW ????
 ;         DESCRIPTION:      Enter Yes if Disposition is related to Open Request
 ;                           becoming Closed due  to the running of Cleanup Utility. 
 ;                           Otherwise enter No.
 N ERR,FDA
 D:'$P($G(^SDEC(409.85,AP,"DIS")),U)   ;If no 1st piece (date), then update this DIS node with all data
 . S FDA(409.85,AP_",",19)=$P(DDT,".")
 . S FDA(409.85,AP_",",20)=DUZ
 . S FDA(409.85,AP_",",21)="SA"
 . D UPDATE^DIE(,"FDA","ERR")
 . M ^XTMP(NAME,AP,"DIS AFTER")=^SDEC(409.85,AP,"DIS")
 I $D(ERR) D
 . D MES^XPDUTL("FileMan error when updating DIS recnum: "_AP) S ERRDIS=ERRDIS+1 M ^XTMP(NAME,AP,"ERR DIS")=ERR
 E  D
 . S CNTD=CNTD+1
 Q
DISP ;QUICK DISPLAY OF SDEC RECS TOUCHED IF CURIOUS?
 ; assumes Refletion display settings set to max of 999 memory to see all or,
 ; user will turn on logging to record to a flat file or,
 ; user will use %G to access XTMP directly
 N PG,LN S (PG,LN)=0 W # W #
 W !!!,"APPROXIMATE NUMBER OF SCREEN PAGES TO DISPLAY... ",^XTMP("SD53P754",0,"TOTAL EMPTY CID RECORDS UPDATED")\7 H 3 W #
 F AP=0:0 S AP=$O(^XTMP("SD53P754",AP)) Q:'AP  D
 . D:LN#7=0 HDR S LN=LN+1
 . W !,"0:     ",AP,?14,$P(^SDEC(409.85,AP,0),U,1,17)
 . W !,"DIS:",?15,$G(^SDEC(409.85,AP,"DIS")),!
 W #!,?20,"Ctrl + PgUp  for previous page.",!,?17,"(hold down both for continuous scrolling)",!
 W !?3,"Assumes Reflection Display Settings = 999 Memory blocks to retain all pages"
 Q
HDR ;Write screen header
 U 0
 S PG=PG+1
 W #
 W "Node 0: IEN ^ Create dte",?36,"<pg ",PG,">",?53,"^16 CID dte  ^17 Open/Close",!
 W "DIS node:       date  ^  duz  ^  sts"
 W !,"================================================================================"
 Q
CNT ;pre-post install null CID datre count entire 409.85 file
 S CNT=0,CNTERR=0
 F AP=0:0 S AP=$O(^SDEC(409.85,AP)) Q:'AP  S CNT=CNT+1 I '$P(^SDEC(409.85,AP,0),U,2),'$P(^SDEC(409.85,AP,0),U,17) S CNTERR=CNTERR+1
 W !,"cid null count: ",?40,$J(CNT,10),!,"date entered is also null count: ",?40,$J(CNTERR,10),!,"difference: ",?40,$J((CNT-CNTERR),10)
 Q
ALL ;ALL RECD COUNTED INEGRITY OF "E" XREF VS $O OF 0 NODES
 N ST,DTE,AP,CNT,ECNT,NCNT,DCNT,XCNT,XEC
 S (CNT,ECNT,NCNT,DCNT,XCNT,XEC)=0
 W !,"Analyzing."
 F AP=0:0 S AP=$O(^SDEC(409.85,AP)) Q:'AP  D
 . S APNODE0=^SDEC(409.85,AP,0)
 . S CNT=CNT+1 W:CNT#6000=0 "."
 . S:'$P(APNODE0,U,16) ECNT=ECNT+1
 . S:$P(APNODE0,U,17)="" NCNT=NCNT+1
 . I '$P(APNODE0,U,2) W !,AP,?20,APNODE0 S DCNT=DCNT+1
 F ST="C","O" F DTE=0:0 S DTE=$O(^SDEC(409.85,"E",ST,DTE)) Q:'DTE  D
 . F AP=0:0 S AP=$O(^SDEC(409.85,"E",ST,DTE,AP)) Q:'AP  S XCNT=XCNT+1 S:'$P(^SDEC(409.85,AP,0),U,16) XEC=XEC+1
 W !!,"TOTL ",CNT,!,"NCID ",ECNT,!,"NOST ",NCNT,!,"NODT ",DCNT,!!,"XREF ",XCNT,!,"XFIX ",XEC,!!
 Q
UNDO ;UNDO MY CURRENT UPDATE FOR CID & DIS 
 N AP,ERR,FDA
 F AP=0:0 S AP=$O(^XTMP("SD53P754",AP)) Q:'AP  D
 . W !,AP
 . ;update the CID/PREFERRED DATE OF APPT date field (#22) in the SDEC APPT REQUEST file (#409.85)
 . Q:'$D(^XTMP("SD53P754",AP,"AFTER"))
 . W !,AP,"<<<<<<"
 . S FDA(409.85,AP_",",22)="@"
 . D UPDATE^DIE(,"FDA","ERR")
 . K ^SDEC(409.85,AP,"DIS")
 Q
