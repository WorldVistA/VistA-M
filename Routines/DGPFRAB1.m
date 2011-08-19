DGPFRAB1 ;ALB/RBS - PRF APPROVED BY REPORT CONT. ; 6/4/04 11:17am
 ;;5.3;Registration;**554**;Aug 13, 1993
 ;
 ;This routine will be used to display or print all Patient Record
 ;Flag Assignment History Actions for the Approved By Person who
 ;authorized the new entry or edit of an assignment to the patient.
 ;
 ; Input: The following sort array contains the report parameters:
 ;  DGSORT("DGAPROV") = pointer to NEW PERSON (#200) file^Person Name
 ;                      or
 ;                    = "A" = All approved by persons
 ;  DGSORT("DGCAT") = CATEGORY
 ;                      1^Category I (National)
 ;                      2^Category II (Local)
 ;                      3^Both
 ;  DGSORT("DGSTATUS") = Assignment Status to report on
 ;                         1^Active
 ;                         2^Inactive
 ;                         3^Both
 ;  DGSORT("DGBEG") = BEGINNING DATE  (internal FileMan date)
 ;  DGSORT("DGEND") = ENDING DATE     (internal FileMan date)
 ;
 ; Output:  A formatted report of the Approved By person's assignments
 ;          that they have authorized to be assigned to a patient.
 ;
 ;- no direct entry
 QUIT
 ;
START ; compile and print report
 I $E(IOST)="C" D WAIT^DICD
 N DGLIST ;temp global name used for report list
 S DGLIST=$NA(^TMP("DGPFRAB1",$J))
 K @DGLIST
 D LOOP(.DGSORT,DGLIST)
 D PRINT(.DGSORT,DGLIST)
 K @DGLIST
 D EXIT
 Q
 ;
LOOP(DGSORT,DGLIST) ;use sort var's for record searching to build list
 ;  Input:
 ;      DGSORT - array of user selected report parameters
 ;      DGLIST - temp global name
 ;
 ; Output:
 ;      ^TMP("DGPFRAB1",$J) - temp global containing report output
 ;
 N DGABIEN  ;approved by person ien
 N DGAIEN   ;approved by history assignment ien
 N DGAPROV  ;approved by sort
 N DGBEG    ;sort beginning date
 N DGC      ;var used to check which category is being reported on
 N DGCAT    ;sort flag category
 N DGCATG   ;category 1 or 2
 N DGEND    ;sort ending date
 N DGHIEN   ;history assignment ien
 N DGPFA    ;assignment data array
 N DGPFAH   ;assignment history data array
 N DGQ      ;quit var
 N DGSTAT   ;status of assignment
 N DGSTATUS ;sort status
 N DGSUB    ;loop flag
 N DGX      ;loop var
 ;
 ; setup variables equal to user input parameter subscripts
 ;   "DGAPROV", "DGCAT", "DGSTATUS", "DGBEG", "DGEND"
 S DGX="" F  S DGX=$O(DGSORT(DGX)) Q:DGX=""  S @DGX=DGSORT(DGX)
 ;
 S DGABIEN=+DGAPROV  ; if 0, then All Approved By sort
 S DGC=$S(+DGCAT=3:0,1:+DGCAT)  ; 0=Both categories sort
 S:DGC DGC=$S(DGC=1:26.15,1:26.11)  ; specific file
 S DGSTAT=+DGSTATUS   ; assignments status to report on
 S:DGSTAT=2 DGSTAT=0  ; inactive status value is '0'
 ;
 ; seed var to start at user selected values
 S (DGQ,DGSUB)=0
 S DGSUB=DGBEG-1
 ;
 ; loop history assignment d/t & approve by x-ref file
 F  S DGSUB=$O(^DGPF(26.14,"D",DGSUB)) Q:DGSUB=""  D  Q:DGQ
 . I DGSUB>(DGEND+.999999999) S DGQ=1 Q
 . S DGAIEN=""
 . S:DGABIEN DGAIEN=DGABIEN-1  ;seed var to start before selection
 . F  S DGAIEN=$O(^DGPF(26.14,"D",DGSUB,DGAIEN)) Q:DGAIEN=""  D
 .. I DGABIEN,(DGAIEN>DGABIEN) Q
 .. S DGHIEN=""
 .. F  S DGHIEN=$O(^DGPF(26.14,"D",DGSUB,DGAIEN,DGHIEN)) Q:DGHIEN=""  D
 ...K DGPFAH
 ...Q:'$$GETHIST^DGPFAAH(DGHIEN,.DGPFAH)
 ...I DGABIEN,(+DGPFAH("APPRVBY")'=DGABIEN) Q
 ...K DGPFA
 ...Q:'$$GETASGN^DGPFAA(+DGPFAH("ASSIGN"),.DGPFA)
 ...I DGC,DGPFA("FLAG")'[DGC Q  ;not correct category
 ...I DGSTAT'=3,+DGPFA("STATUS")'=DGSTAT Q  ;not correct status
 ...S DGCATG=$S(DGPFA("FLAG")[26.15:1,1:2)
 ...D BLDTMP(.DGPFA,.DGPFAH,DGHIEN,DGCATG,DGLIST)
 Q
 ;
BLDTMP(DGPFA,DGPFAH,DGHIEN,DGCATG,DGLIST) ; list global builder
 ;  Input:
 ;      DGPFA  - array of assignment record data
 ;      DGPFAH - array of assignment history record data
 ;      DGHIEN - ien to PRF ASSIGNMENT HISTORY (#26.14) file record
 ;      DGCATG - category of flag 1=National, 2=Local
 ;      DGLIST - temp global name used for report list
 ;
 ; Output:
 ;      ^TMP("DGPFRFA1",$J) - temp global containing report output
 ;
 N DG1,DG2 ;subscript var's
 N DGACTDT ;initial entry date
 N DGDFN   ;pointer to patient being reported on
 N DGFGNM  ;flag name
 N DGLINE  ;report detail line
 N DGPAT   ;array of patient demographics
 N DGPNM   ;patient name
 N DGREV   ;review date
 ;
 ; get patient demographics
 S DGDFN=$P(DGPFA("DFN"),U)
 K DGPAT
 Q:'$$GETPAT^DGPFUT2(DGDFN,.DGPAT)
 S DGPNM=DGPAT("NAME")
 S:DGPNM']"" DGPNM="MISSING PATIENT NAME"
 S DGFGNM=$P(DGPFA("FLAG"),U,2)
 S:DGFGNM']"" DGFGNM="MISSING FLAG NAME"
 S DGACTDT=$$FDATE^VALM1(+DGPFAH("ASSIGNDT"))
 I +DGPFA("REVIEWDT") D
 .S DGREV=$$FDATE^VALM1(+DGPFA("REVIEWDT"))
 E  S DGREV="N/A"
 S DGLINE=DGPAT("SSN")_U_$P(DGPFAH("ACTION"),U,2)_U_DGACTDT_U_DGREV_U_$P(DGPFA("STATUS"),U,2)
 ; setup subscripts -
 ; - Approved By Name, IEN, Cat, Flag Name, Pat Name, DFN, History IEN
 S DG1=$P(DGPFAH("APPRVBY"),U,2),DG2=$P(DGPFAH("APPRVBY"),U)
 S @DGLIST@(DG1,DG2,DGCATG,DGFGNM,DGPNM,DGDFN,DGHIEN)=DGLINE
 Q
 ;
PRINT(DGSORT,DGLIST) ;output report
 ;  Input:
 ;      DGSORT - array of user selected report parameters
 ;      DGLIST - temp global name used for report list
 ;
 ; Output: Formatted report to user selected device
 ;
 N DGAPNM  ;approved by name
 N DGCAT   ;flag category
 N DGCNT   ;counter of detail lines
 N DGDFN   ;ien of patient
 N DGDT    ;date time report printed
 N DGFG    ;flag name
 N DGIEN   ;approved by ien
 N DGLINE  ;string of hyphens (80) for report header format
 N DGLN    ;loop var
 N DGNAM   ;patient name
 N DGOCAT  ;category switch flag
 N DGODFN  ;loop var flag
 N DGOFG   ;name switch flag
 N DGOIEN  ;ien switch flag
 N DGPAGE  ;page counter
 N DGQ     ;quit flag
 N DGSTR   ;string of detail line to display
 N X,Y
 ;
 S (DGCNT,DGQ,DGPAGE)=0,$P(DGLINE,"-",81)=""
 S DGDT=$P($$FMTE^XLFDT($$NOW^XLFDT,"T"),":",1,2)
 ;
 I $O(@DGLIST@(""))="" D  Q
 . D HEAD
 . W !!,"   >>> No Record Flag Assignments were found using the report criteria.",!
 ;
 ; loop and print report
 S (DGIEN,DGOIEN,DGAPNM,DGCAT,DGOCAT,DGFG,DGOFG,DGNAM,DGDFN,DGODFN,DGLN,DGSTR)=""
 D HEAD
 F  S DGAPNM=$O(@DGLIST@(DGAPNM)) Q:DGAPNM=""  D  Q:DGQ
 . F  S DGIEN=$O(@DGLIST@(DGAPNM,DGIEN)) Q:DGIEN=""  D  Q:DGQ
 . . I $Y>(IOSL-8) D PAUSE(.DGQ) Q:DGQ  D HEAD,HEAD1 S DGOIEN=DGIEN
 . . I DGOIEN'=DGIEN S DGOIEN=DGIEN W:DGCNT ! D HEAD1
 . . F  S DGCAT=$O(@DGLIST@(DGAPNM,DGIEN,DGCAT)) Q:DGCAT=""  D  Q:DGQ
 . . . F  S DGFG=$O(@DGLIST@(DGAPNM,DGIEN,DGCAT,DGFG)) Q:DGFG=""  D  Q:DGQ
 . . . . I $Y>(IOSL-8) D PAUSE(.DGQ) Q:DGQ  D HEAD,HEAD1,HEAD2 S DGOFG=DGFG
 . . . . I DGOFG'=DGFG W:DGOFG]"" !! D HEAD2 S DGOFG=DGFG
 . . . . ; print patient detail line
 . . . . D PRNTPAT
 . ; reset var's to pop header's
 . S (DGOIEN,DGOCAT,DGOFG)=""
 ;
 ;Shutdown if stop task requested
 I DGQ W:$D(ZTQUEUED) !!,"REPORT STOPPED AT USER REQUEST" Q
 ;
 W !!,"<End of Report>"
 Q
 ;
PRNTPAT ; loop and print all patients for flag
 ;
 S DGODFN=""
 F  S DGNAM=$O(@DGLIST@(DGAPNM,DGIEN,DGCAT,DGFG,DGNAM)) Q:DGNAM=""  D  Q:DGQ
 . F  S DGDFN=$O(@DGLIST@(DGAPNM,DGIEN,DGCAT,DGFG,DGNAM,DGDFN)) Q:DGDFN=""  D  Q:DGQ
 . . F  S DGLN=$O(@DGLIST@(DGAPNM,DGIEN,DGCAT,DGFG,DGNAM,DGDFN,DGLN)) Q:DGLN=""  D  Q:DGQ
 . . . I $Y>(IOSL-3) D PAUSE(.DGQ) Q:DGQ  D HEAD,HEAD1,HEAD2 S DGODFN=""
 . . . S DGSTR=$G(@DGLIST@(DGAPNM,DGIEN,DGCAT,DGFG,DGNAM,DGDFN,DGLN))
 . . . W !
 . . . I DGODFN'=DGDFN S DGODFN=DGDFN D  ;only print name once
 . . . . W $E(DGNAM,1,16),?18,$P(DGSTR,U)
 . . . W ?30,$P(DGSTR,U,2),?48,$P(DGSTR,U,3),?60,$P(DGSTR,U,4),?71,$P(DGSTR,U,5)
 . . . S DGCNT=DGCNT+1
 Q
 ;
PAUSE(DGQ) ; pause screen display
 ;  Input: 
 ;      DGQ - var used to quit report processing to user CRT
 ; Output:
 ;      DGQ - passed by reference - 0 = Continue, 1 = Quit
 ;
 I $G(DGPAGE)>0,$E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQ=1
 Q
 ;
HEAD ;Print/Display page header
 ;
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1 Q
 W:'($E(IOST,1,2)'="C-"&'DGPAGE) @IOF
 ;
 S DGPAGE=$G(DGPAGE)+1
 W !?25,"PATIENT RECORD FLAGS"
 W !?20,"ASSIGNMENTS APPROVED BY REPORT",?68,"Page: ",$G(DGPAGE)
 W !,"Date Range: ",$$FDATE^VALM1(DGSORT("DGBEG"))_" to "_$$FDATE^VALM1(DGSORT("DGEND"))
 W ?50,"Printed: ",DGDT
 W !,DGLINE
 Q
 ;
HEAD1 W !!,"Approved By: ",DGAPNM
 Q
 ;
HEAD2 W !,"Flag Name: ",$G(DGFG)," - ",$S(+DGCAT=1:"Category I (National)",1:"Category II (Local)")
 ;
 W !!,"PATIENT",?18,"SSN",?30,"ACTION",?48,"ACTION DT",?60,"REVIEW DT",?71,"STATUS"
 W !,"================",?18,"==========",?30,"================",?48,"=========",?60,"=========",?71,"========="
 Q
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q
