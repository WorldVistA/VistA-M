DGPFRPA1 ;ALB/RBS - PRF PATIENT ASSIGNMENTS REPORT CONT. ; 5/21/04 12:53pm
 ;;5.3;Registration;**554**;Aug 13, 1993
 ;
 ;This routine will be used to display or print all the record flag
 ;assignments of a patient.
 ;
 ; Input: The following sort array contains the report parameters:
 ;      DGSORT("DGDFN") = Patient IEN of (#2) file to report on
 ;   DGSORT("DGSTATUS") = Assignment Status to report on
 ;                      = 1;Active, 2:Inactive, 3:Both
 ;
 ; Output:
 ;    A formatted report of Record Flag Assignments for a patient.
 ;
 ;- no direct entry
 QUIT
 ;
START ; compile and print report
 I $E(IOST)="C" D WAIT^DICD
 N DGLIST ;temp global name used for report list
 S DGLIST=$NA(^TMP("DGPFRPA1",$J))
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
 ;      ^TMP("DGPFRPA1",$J) - temp global used for report output
 ;
 N DGDFN    ;pointer to patient being reported on
 N DGIEN    ;ien of assignment record
 N DGIENS   ;array of ien's of the patients assignments records
 N DGPAT    ;patient data array
 N DGPFA    ;assignment data array
 N DGSSN    ;patient ssn
 N DGSTAT   ;status of assignment
 N DGSTATUS ;assignment status to report on
 N DGX      ;loop var
 ;
 ; setup variables equal to user input parameter subscripts
 ;   "DGDFN", "DGSTATUS"
 S DGX="" F  S DGX=$O(DGSORT(DGX)) Q:DGX=""  S @DGX=DGSORT(DGX)
 ;
 S DGSTAT=+DGSTATUS   ; assignments status to report on
 S:DGSTAT=2 DGSTAT=0  ; inactive status value is '0'
 ;
 ; get patient demographics to setup patient name & ssn
 K DGPAT
 Q:'$$GETPAT^DGPFUT2(DGDFN,.DGPAT)
 ; add patient name & ssn to DGSORT for printing
 S DGSSN=$E(DGPAT("SSN"),1,3)_"-"_$E(DGPAT("SSN"),4,5)_"-"_$E(DGPAT("SSN"),6,10)
 S DGSORT("DGDFN")=DGSORT("DGDFN")_U_DGPAT("NAME")_U_DGSSN
 ; get list of all assignments for patient
 Q:'$$GETALL^DGPFAA(DGDFN,.DGIENS)
 S DGIEN=0
 F  S DGIEN=$O(DGIENS(DGIEN)) Q:'DGIEN  D
 . ; get assignment record fields
 . K DGPFA
 . Q:'$$GETASGN^DGPFAA(DGIEN,.DGPFA)
 . I +DGSTATUS'=3,($P(DGPFA("STATUS"),U)'=DGSTAT) Q
 . ; call to build temp global
 . D BLDTMP(.DGPFA,DGIEN,DGLIST)
 ;
 Q
 ;
BLDTMP(DGPFA,DGIEN,DGLIST) ; list global builder
 ;  Input:
 ;      DGPFA  - array of assignment record data
 ;      DGIEN  - ien pointer to PRF ASSIGNMENT (#26.13) file record
 ;      DGLIST - temp global name used for report list
 ;
 ; Output:
 ;      ^TMP("DGPFRPA1",$J) - temp global containing report output
 ;
 N DGACTDT  ;initial entry date
 N DGAPRVBY ;approved by person name
 N DGCATG   ;category of flag
 N DGFGNM   ;flag name
 N DGLINE   ;report detail display line
 N DGPCAT   ;print output of category
 N DGPFAH   ;array of assignment history data
 N DGREVDT  ;review date
 ;
 ; get initial assignment history
 Q:'$$GETHIST^DGPFAAH($$GETFIRST^DGPFAAH(DGIEN),.DGPFAH)
 Q:'$G(DGPFAH("ASSIGNDT"))
 S DGACTDT=$$FDATE^VALM1(+DGPFAH("ASSIGNDT"))
 S DGREVDT=+DGPFA("REVIEWDT")
 S DGREVDT=$S(DGREVDT:$$FDATE^VALM1(DGREVDT),1:"N/A")
 S DGFGNM=$P(DGPFA("FLAG"),U,2)
 S:DGFGNM']"" DGFGNM="MISSING FLAG NAME"
 S DGAPRVBY=$P(DGPFAH("APPRVBY"),U,2)
 S:DGAPRVBY']"" DGAPRVBY="Missing Name"
 S DGCATG=$S(DGPFA("FLAG")[26.15:1,1:2)  ;category
 S DGPCAT=$S(DGCATG=1:"I",1:"II")
 S DGLINE=$E(DGFGNM,1,15)_U_DGPCAT_U_$E(DGAPRVBY,1,15)_U_DGACTDT_U_DGREVDT_U_$P(DGPFA("STATUS"),U,2)_U_$E($P(DGPFA("OWNER"),U,2),1,15)
 S @DGLIST@(DGCATG,+DGPFAH("ASSIGNDT"))=DGLINE
 Q
 ;
PRINT(DGSORT,DGLIST) ;output report
 ;  Input:
 ;      DGSORT - array of user selected report parameters
 ;      DGLIST - temp global name used for report list
 ;
 ; Output: Formatted report to user selected device
 ;
 N DGCAT  ;flag category
 N DGCNT  ;flag counter
 N DGDFN  ;ien of patient
 N DGDT   ;date time report printed
 N DGFG   ;flag name
 N DGLINE ;string of hyphens (80) for report header format
 N DGNAM  ;patient name
 N DGPAGE ;page counter
 N DGQ    ;quit flag
 N DGSTAT ;status report is run for
 N DGSTR  ;string of detail line to display
 N X,Y
 ;
 S (DGCNT,DGQ,DGPAGE)=0,$P(DGLINE,"-",81)=""
 S DGDT=$P($$FMTE^XLFDT($$NOW^XLFDT,"T"),":",1,2)
 S DGSTAT=+DGSORT("DGSTATUS")
 ;
 I $O(@DGLIST@(""))="" D  Q
 . D HEAD
 . W !!,"   >>> No Record Flag Assignments were found using the report criteria.",!
 ;
 ; loop and print report
 S (DGCAT,DGFG,DGNAM,DGDFN,DGSTR)="",DGCNT=0
 D HEAD
 F  S DGCAT=$O(@DGLIST@(DGCAT)) Q:DGCAT=""  D  Q:DGQ
 . F  S DGFG=$O(@DGLIST@(DGCAT,DGFG)) Q:DGFG=""  D  Q:DGQ
 .. I $Y>(IOSL-4) D PAUSE(.DGQ) Q:DGQ  D HEAD
 .. S DGSTR=$G(@DGLIST@(DGCAT,DGFG))
 .. S DGCNT=DGCNT+1
 .. W !,DGCNT,?3,$E($P(DGSTR,U),1,17),?21,$P(DGSTR,U,2),?25,$E($P(DGSTR,U,3),1,11),?38,$P(DGSTR,U,4),?48,$P(DGSTR,U,5),?59,$P(DGSTR,U,6),?69,$E($P(DGSTR,U,7),1,11)
 . Q:DGQ
 ;
 ;Shutdown if stop task requested
 I DGQ W:$D(ZTQUEUED) !!,"REPORT STOPPED AT USER REQUEST" Q
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
 W !?22,"PATIENT ASSIGNMENTS REPORT",?68,"Page: ",$G(DGPAGE)
 W !,"Report Selected: "_$S(DGSTAT=1:"ACTIVE",DGSTAT=2:"INACTIVE",1:"Both (ACTIVE & INACTIVE)")
 W ?50,"Printed: ",DGDT
 W !,DGLINE
 W !!,"Patient: ",$P(DGSORT("DGDFN"),U,2),"  ",$P(DGSORT("DGDFN"),U,3)
 W !!?3,"FLAG NAME",?15,"CATEGORY",?25,"APPROVED BY",?38,"ENTERED",?48,"REVIEW DT",?59,"STATUS",?69,"OWNING SITE"
 W !,"------------------",?20,"---",?25,"-----------",?38,"--------",?48,"---------",?59,"--------",?69,"-----------"
 Q
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q
