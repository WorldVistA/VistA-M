DGPFRAL1 ;ALB/RBS - PRF ACTION NOT LINKED REPORT CONT. ; 10/12/05 2:48pm
 ;;5.3;Registration;**554,650**;Aug 13, 1993;Build 3
 ;
 ;This routine will be used to display or print all of the patient
 ;assignment history records that are not linked to a progress note.
 ;
 ; Input: The following sort array contains the report parameters:
 ;   DGSORT("DGCAT") = Flag Category to report on
 ;                   = 1:National, 2:Local, 3:Both
 ;   DGSORT("DGBEG") = Beginning date to report on
 ;   DGSORT("DGEND") = Ending date to report on
 ;
 ; Output:  A formatted report of patient Assignment History Actions
 ;          that are not linked to a TIU Progress Note.
 ;
 ;- no direct entry
 QUIT
 ;
START ; compile and print report
 I $E(IOST)="C" D WAIT^DICD
 N DGLIST ;temp global name used for report list
 S DGLIST=$NA(^TMP("DGPFRAL1",$J))
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
 ;      ^TMP("DGPFRAL1",$J) - temp global containing report output
 ;
 N DGBEG    ;beginning date
 N DGC      ;var used to check which category is being reported on
 N DGCAT    ;flag category
 N DGCATG   ;category 1 or 2
 N DGCNT    ;flag counter
 N DGDFN    ;pointer to patient being reported on
 N DGDFNLST ;array of dfn's assigned to the flag
 N DGEND    ;ending date
 N DGHIENS  ;array subscripted by assignment history date
 N DGIEN    ;assignment ien
 N DGPAT    ;patient data array
 N DGPFA    ;assignment data array
 N DGQ      ;quit var
 N DGSUB    ;loop flag
 N DGX      ;loop var
 ;
 ; setup variables equal to user input parameter subscripts
 ;   "DGCAT", "DGBEG", "DGEND"
 S DGX="" F  S DGX=$O(DGSORT(DGX)) Q:DGX=""  S @DGX=DGSORT(DGX)
 S DGC=$S(+DGCAT=3:0,1:+DGCAT)
 S:DGC DGC=$S(DGC=1:26.15,1:26.11)
 ;
 ; loop assignment variable pointer flag x-ref file to run report
 S (DGDFN,DGIEN)="",(DGQ,DGSUB,DGCNT)=0
 F  S DGSUB=$O(^DGPF(26.13,"AFLAG",DGSUB)) Q:DGSUB=""  D  Q:DGQ
 . I DGC,DGSUB'[DGC Q  ;not correct file based on category
 . S DGCATG=$S(DGSUB[26.15:1,1:2)
 . K DGDFNLST
 . S DGCNT=$$ASGNCNT^DGPFLF6(DGSUB,.DGDFNLST)
 . Q:'DGCNT
 . S DGDFN=""
 . F  S DGDFN=$O(DGDFNLST(DGDFN)) Q:DGDFN=""  D
 . . S DGIEN=$G(DGDFNLST(DGDFN)) Q:DGIEN=""
 . . ; get assignment record
 . . K DGPFA
 . . Q:'$$GETASGN^DGPFAA(DGIEN,.DGPFA)
 . . ; check if calling site is owner site
 . . Q:'$$ISDIV^DGPFUT($P(DGPFA("OWNER"),U))
 . . ;
 . . ;filter patient when last action is ENTERED IN ERROR
 . . Q:$$ENTINERR(DGIEN)
 . . ;
 . . ;action ien array subscripted by assignment history date
 . . K DGHIENS
 . . Q:'$$GETALLDT^DGPFAAH(DGIEN,.DGHIENS)
 . . ; check if any Action's fall within the Begin and End dates
 . . I $P($O(DGHIENS("")),".")'>DGEND&($P($O(DGHIENS(""),-1),".")'<DGBEG) D
 . . . ;delete any action that is not within Begin and End dates
 . . . S DGX=0 F  S DGX=$O(DGHIENS(DGX)) Q:DGX=""  D
 . . . . I $P(DGX,".")<DGBEG!($P(DGX,".")>DGEND) K DGHIENS(DGX)
 . . . Q:'$O(DGHIENS(""))
 . . . ;
 . . . ; get patient demographics
 . . . K DGPAT
 . . . Q:'$$GETPAT^DGPFUT2(DGDFN,.DGPAT)
 . . . ;
 . . . ; call to build temp global
 . . . D BLDTMP(.DGPFA,.DGPAT,.DGHIENS,DGCATG,DGLIST)
 ;
 Q
 ;
BLDTMP(DGPFA,DGPAT,DGHIENS,DGCATG,DGLIST) ; list global builder
 ;  Input:
 ;      DGPFA  - array of assignment record data
 ;      DGPAT  - array of patient demographics
 ;      DGHIENS - array of history action IEN's sorted by d/t
 ;      DGCATG - category of flag 1=National, 2=Local
 ;      DGLIST - temp global name used for report list
 ;
 ; Output:
 ;      ^TMP("DGPFRFA1",$J) - temp global containing report output
 ;
 N DGACTDT ;initial entry date
 N DGFGNM  ;flag name
 N DGHIEN  ;assignment ien
 N DGLINE  ;report detail line
 N DGLNCNT ;unique subscript counter
 N DGPDFN  ;pointer to patient
 N DGPFAH  ;assignment history record data
 N DGPNM   ;patient name
 ;
 ; loop all assignment history ien's
 S DGHIEN="",DGLNCNT=0
 F  S DGHIEN=$O(DGHIENS(DGHIEN)) Q:DGHIEN=""  D
 . ; get assignment history record
 . K DGPFAH
 . Q:'$$GETHIST^DGPFAAH(DGHIENS(DGHIEN),.DGPFAH)
 . Q:+$G(DGPFAH("TIULINK"))   ;progress note pointer is setup
 . Q:+$G(DGPFAH("ACTION"))=5  ;don't report on ENTERED IN ERROR action
 . S DGACTDT=$$FDATE^VALM1(+DGPFAH("ASSIGNDT"))
 . S DGPNM=DGPAT("NAME")
 . S:DGPNM']"" DGPNM="MISSING PATIENT NAME"
 . S DGPDFN=$P(DGPFA("DFN"),U)
 . S DGFGNM=$P(DGPFA("FLAG"),U,2)
 . S:DGFGNM']"" DGFGNM="MISSING FLAG NAME"
 . S DGLINE=DGPAT("SSN")_U_$E(DGFGNM,1,17)_U_$P(DGPFAH("ACTION"),U,2)_U_DGACTDT
 . S DGLNCNT=DGLNCNT+1
 . S @DGLIST@(DGCATG,DGFGNM,DGPNM,DGPDFN,DGLNCNT)=DGLINE
 ;
 Q
 ;
PRINT(DGSORT,DGLIST) ;output report
 ;  Input:
 ;      DGSORT - array of user selected report parameters
 ;      DGLIST - temp global name used for report list
 ;
 ; Output: Formatted report to user selected device
 ;
 N DGCAT   ;flag category
 N DGCNT   ;counter of detail lines
 N DGDFN   ;ien of patient
 N DGDT    ;date time report printed
 N DGFG    ;flag name
 N DGGRAND ;flag to print grand totals
 N DGLINE  ;string of hyphens (80) for report header format
 N DGLN    ;loop var
 N DGNAM   ;patient name
 N DGODFN  ;print loop var flag
 N DGOFG   ;print loop var flag
 N DGPCAT  ;print form of category
 N DGPAGE  ;page counter
 N DGQ     ;quit flag
 N DGSTR   ;string of detail line to display
 N X,Y
 ;
 S (DGCNT,DGQ,DGPAGE,DGGRAND)=0,$P(DGLINE,"-",81)=""
 S DGDT=$P($$FMTE^XLFDT($$NOW^XLFDT,"T"),":",1,2)
 S (DGCAT,DGPCAT)=+DGSORT("DGCAT")
 ;
 I $O(@DGLIST@(""))="" D  Q
 . D HEAD
 . W !!,"   >>> No Record Flag Assignments were found using the report criteria.",!
 ;
 ; loop and print report
 S (DGCAT,DGFG,DGNAM,DGDFN,DGODFN,DGOFG,DGLN,DGSTR)=""
 F  S DGCAT=$O(@DGLIST@(DGCAT)) Q:DGCAT=""  D  Q:DGQ
 . D HEAD S DGCNT=0
 . F  S DGFG=$O(@DGLIST@(DGCAT,DGFG)) Q:DGFG=""  D  Q:DGQ
 .. F  S DGNAM=$O(@DGLIST@(DGCAT,DGFG,DGNAM)) Q:DGNAM=""  D  Q:DGQ
 ... F  S DGDFN=$O(@DGLIST@(DGCAT,DGFG,DGNAM,DGDFN)) Q:DGDFN=""  D  Q:DGQ
 .... F  S DGLN=$O(@DGLIST@(DGCAT,DGFG,DGNAM,DGDFN,DGLN)) Q:DGLN=""  D  Q:DGQ
 ..... S DGSTR=$G(@DGLIST@(DGCAT,DGFG,DGNAM,DGDFN,DGLN))
 ..... W !
 ..... I $Y>(IOSL-4) D PAUSE(.DGQ) Q:DGQ  D HEAD S DGODFN="" W !
 ..... ; - write name and ssn once
 ..... I DGODFN'=DGDFN S DGODFN=DGDFN,DGOFG=DGFG D
 ...... W $E(DGNAM,1,18),?20,$P(DGSTR,U),?32,$E($P(DGSTR,U,2),1,17)
 ..... ; - write new flag name
 ..... I DGOFG'=DGFG S DGOFG=DGFG W ?32,$E($P(DGSTR,U,2),1,17)
 ..... ; - write action detail
 ..... W ?51,$P(DGSTR,U,3),?69,$P(DGSTR,U,4)
 ..... S DGCNT=DGCNT+1,DGCNT(DGCAT)=$G(DGCNT(DGCAT))+1
 . Q:DGQ
 . I DGCNT D
 .. W !!,"Total Actions not Linked for Category "_$S(DGCAT=1:"I",1:"II")_":  ",?46,$J(+$G(DGCNT(DGCAT)),6)
 .. S DGCNT=0,DGODFN=""
 .. D:DGPCAT=3 PAUSE(.DGQ)
 ;
 ;Shutdown if stop task requested
 I DGQ W:$D(ZTQUEUED) !!,"REPORT STOPPED AT USER REQUEST" Q
 ;
 I +DGSORT("DGCAT")=3 D  ; Grand totals (B)oth Categories
 . S DGCAT=3,DGGRAND=1
 . D HEAD
 . W !!,"REPORT SUMMARY:",!,"---------------"
 . F DGCAT=1,2,3 D
 .. S:DGCAT'=3 DGCNT(3)=$G(DGCNT(3))+$G(DGCNT(DGCAT))
 .. W:DGCAT=3 !?48,"-------"
 .. W !,"Total Actions not Linked for Category "
 .. W $S(DGCAT=1:"I",DGCAT=2:"II",1:"I & II"),":"
 .. W ?49,$J(+$G(DGCNT(DGCAT)),6)
 ;
 W !!,"<End of Report>"
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
 ;
 W:'($E(IOST,1,2)'="C-"&'DGPAGE) @IOF
 ;
 S DGPAGE=$G(DGPAGE)+1
 W !?25,"PATIENT RECORD FLAGS"
 W !?8,"ASSIGNMENT ACTION NOT LINKED TO A PROGRESS NOTE REPORT",?68,"Page: ",$G(DGPAGE)
 W !,"Report Selected: "_$S($G(DGPCAT)=1:"Category I (National)",$G(DGPCAT)=2:"Category II (Local)",1:"Both (Category I & II)")
 W !?5,"DATE RANGE: ",$$FDATE^VALM1($G(DGSORT("DGBEG")))_" TO "_$$FDATE^VALM1($G(DGSORT("DGEND")))
 W ?50,"Printed: ",DGDT
 W !,DGLINE
 ;
 Q:DGGRAND
 ;
 W !!,"CATEGORY: "_$S($G(DGCAT)=1:"Category I (National)",$G(DGCAT)=2:"Category II (Local)",1:"Both (Category I & II)")
 W !!,"PATIENT",?20,"SSN",?32,"FLAG NAME",?51,"ACTION",?69,"ACTION DATE"
 W !,"------------------",?20,"----------",?32,"-----------------",?51,"----------------",?69,"-----------"
 Q
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q
 ;
ENTINERR(DGIEN) ;is last action ENTERED IN ERROR
 ;  Input:
 ;    DGIEN - (required) Pointer to PRF ASSIGNMENT (#26.13) file
 ;
 ;  Output:
 ;   Function Value - Return 1 on success, 0 on failure
 ;
 N DGPFAH
 ;
 I $$GETHIST^DGPFAAH($$GETLAST^DGPFAAH(DGIEN),.DGPFAH)
 Q +$G(DGPFAH("ACTION"))=5
