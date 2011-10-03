DGPFRFR1 ;ALB/RBS - PRF ASSIGNMENTS DUE REVIEW REPORT CONT. ; 5/21/03 4:40pm
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
 ;This routine will create the ASSIGNMENTS DUE FOR REVIEW REPORT.
 ;This routine will be used to display or print all of the patient
 ; assignments due for Review for Category I and Category II PRF's.
 ;
 ;All sort input was created in routine DGPFRFR.
 ; Input: The following array contains the sort var's:
 ;   DGSORT("DGCAT")  = category reporting on (I, II, or (B)oth)
 ;   DGSORT("DGFLAG") = "A" = (A)ll Flags will be reported on
 ;                    = IEN of a (S)ingle Flag (#26.11)/(#26.15)
 ;                        example:  "1;DGPF(26.15,"
 ;   DGSORT("DGBEG")  = Beginning date to report on
 ;   DGSORT("DGEND")  = Ending date to report on
 ;
 ; Output: Formatted report of Record Flag Assignments due for review.
 ;
 ;- no direct entry
 QUIT
 ;
START ; compile and print report
 I $E(IOST)="C" D WAIT^DICD
 N DGLIST
 S DGLIST=$NA(^TMP("DGPFRFR1",$J))
 K @DGLIST
 D LOOP(.DGSORT)
 D PRINT(.DGSORT,DGLIST)
 D EXIT
 Q
 ;
LOOP(DGSORT) ;use sort var's for record searching to build list
 ;  Input:
 ;      DGSORT - array of user selected report parameters
 ;
 ; Output:
 ;      ^TMP("DGPFRFA1",$J) - temp global containing report output
 ;
 N DGCAT,DGFLAG,DGBEG,DGEND,DGIEN,DGDFN,DGC,DGX,DGQ,DGFG,DGSUB,DGNOW
 S (DGQ,DGFG)=0
 S DGX="" F  S DGX=$O(DGSORT(DGX)) Q:DGX=""  S @DGX=DGSORT(DGX)
 S DGC=$S(+DGCAT=3:0,1:+DGCAT)  ; 0 = both cat. I,II (National,Local)
 S:DGC DGC=$S(DGC=1:26.15,1:26.11)
 S DGFG=$P(DGFLAG,U)   ;"A"=all flags or "5;DGPF(26.11," is selection
 S DGSUB=DGBEG-1  ; seed var to start at user selected beginning date
 F  S DGSUB=$O(^DGPF(26.13,"AFREV",DGSUB)) Q:DGSUB=""  D  Q:DGQ
 . I DGSUB>DGEND S DGQ=1 Q
 . S DGDFN=""
 . F  S DGDFN=$O(^DGPF(26.13,"AFREV",DGSUB,DGDFN)) Q:DGDFN=""  D
 .. S DGIEN=""
 .. F  S DGIEN=$O(^DGPF(26.13,"AFREV",DGSUB,DGDFN,DGIEN)) Q:DGIEN=""  D
 ... Q:'$D(^DGPF(26.13,"D",DGDFN,1,DGIEN))  ;status not active
 ... I +DGFG,'$D(^DGPF(26.13,"C",DGDFN,DGFG,DGIEN)) Q  ;flag not found
 ... D BLDTMP(.DGSORT,DGDFN,DGIEN,DGLIST)
 Q
 ;
BLDTMP(DGSORT,DGDFN,DGIEN,DGLIST) ; list global builder
 ;  Input:
 ;      DGSORT - array of user selected report parameters
 ;      DGDFN  - ien of patient in PATIENT (#2) file
 ;      DGIEN  - ien pointer to PRF ASSIGNMENT (#26.13) file record
 ;
 ; Output:
 ;      ^TMP("DGPFRFA1",$J) - temp global containing report output
 ;
 N DGPFA,DGPFAH,DGPFPAT,DGPTR,DGINIT,DGCATG
 N DGLINE,DGNAME,DGREV,DGFG,DGNOT,DGYN
 S (DGPTR,DGINIT,DGCATG,DGLINE,DGNAME,DGREV,DGNOT,DGYN)=""
 K DGPFA,DGPFAH,DGPFPAT
 ;retrieve a single assign record
 Q:'$$GETASGN^DGPFAA(DGIEN,.DGPFA)
 I +DGC,$P(DGPFA("FLAG"),U)'[+DGC Q   ;not category selected
 ;retrieve initial history assign record
 Q:'$$GETHIST^DGPFAAH($$GETFIRST^DGPFAAH(DGIEN),.DGPFAH)
 ;-- get 'initial assignment' date
 S DGPFAH("INITASSIGN")=$G(DGPFAH("ASSIGNDT"))
 Q:'DGPFAH("INITASSIGN")
 Q:'$$GETPAT^DGPFUT2(DGDFN,.DGPFPAT)
 S DGCATG=$S($P(DGPFA("FLAG"),U)[26.15:1,1:2)
 S DGFG=$P(DGPFA("FLAG"),U,2)
 S DGNAME=DGPFPAT("NAME")
 S DGINIT=$$FDATE^VALM1(+DGPFAH("INITASSIGN"))
 I +DGPFA("REVIEWDT") D
 . S DGREV=$$FDATE^VALM1(+DGPFA("REVIEWDT"))
 . I +DGPFA("REVIEWDT")<DGNOW S DGREV=DGREV_" *"  ;past due indicator
 . ; calulate the notification date
 . S DGNOT=$$NOTIFYDT^DGPFAA3($P(DGPFA("FLAG"),U),$P(DGPFA("REVIEWDT"),U))
 . S DGYN=$S($D(^DGPF(26.13,"ANDAT",DGNOT,DGIEN)):"NO",1:"YES")
 E  S (DGREV,DGNOT,DGYN)="N/A"
 S DGLINE=DGPFPAT("SSN")_U_DGINIT_U_DGREV_U_DGYN
 S @DGLIST@(DGCATG,DGFG,DGNAME,DGDFN)=DGLINE
 K DGPFA,DGPFAH,DGPFPAT
 Q
 ;
PRINT(DGSORT,DGLIST) ;output report
 ;  Input:
 ;      DGSORT - array of user selected report parameters
 ;
 ; Output: Formated report to user selected device
 ;
 N DGCAT,DGFG,DGNAM,DGDFN,DGSTR,DGQ,DGPAGE,DGDT,DGCNT,DGOFG,X,Y,DGGRAND,DGLINE
 S (DGCNT,DGQ,DGPAGE,DGGRAND)=0,$P(DGLINE,"-",80)=""
 S DGDT=$P($$FMTE^XLFDT($$NOW^XLFDT,"T"),":",1,2)
 I $O(@DGLIST@(""))="" D  Q
 . S DGCAT=+DGSORT("DGCAT")
 . S DGFG=$S(DGSORT("DGFLAG")="A":"(A)ll Flags",1:$P(DGSORT("DGFLAG"),U,2))
 . D HEAD
 . W !!,"   >>> No Record Flag Assignments were found using the report criteria."
 ; loop and print report
 S (DGCAT,DGFG,DGNAM,DGDFN,DGSTR,DGOFG)=""
 F  S DGCAT=$O(@DGLIST@(DGCAT)) Q:DGCAT=""  D  Q:DGQ
 . F  S DGFG=$O(@DGLIST@(DGCAT,DGFG)) Q:DGFG=""  D  Q:DGQ
 .. I DGFG'=DGOFG D
 ... D:DGCNT SUB(.DGCNT,1)
 ... D HEAD
 ... S DGOFG=DGFG,DGCNT=0
 .. F  S DGNAM=$O(@DGLIST@(DGCAT,DGFG,DGNAM)) Q:DGNAM=""  D  Q:DGQ
 ... F  S DGDFN=$O(@DGLIST@(DGCAT,DGFG,DGNAM,DGDFN)) Q:DGDFN=""  D  Q:DGQ
 .... S DGCNT=DGCNT+1,DGCNT(DGCAT)=$G(DGCNT(DGCAT))+1
 .... D:$Y>(IOSL-4) HEAD
 .... Q:DGQ
 .... S DGSTR=$G(@DGLIST@(DGCAT,DGFG,DGNAM,DGDFN))
 .... W !,$E(DGNAM,1,20),?22,$P(DGSTR,U),?33,$P(DGSTR,U,2),?43,$P(DGSTR,U,3),?60,$P(DGSTR,U,4)
 . Q:DGQ
 . I DGCNT D
 .. D SUB(.DGCNT,1)
 .. D:DGSORT("DGFLAG")="A" SUB(.DGCNT,2)  ;only if (A)ll flags
 .. S DGOFG="",DGCNT=0
 ;
 ;Shutdown if stop task requested
 I DGQ W:$D(ZTQUEUED) !!,"REPORT STOPPED AT USER REQUEST" Q
 ;
 I +DGSORT("DGCAT")=3 D  ; Grand totals (B)oth Categories
 . S DGCAT=3,DGFG="All Flags",DGGRAND=1
 . D HEAD
 . W !!,"REPORT SUMMARY:",!,"---------------"
 . F DGCAT=1,2,3 D
 .. S:DGCAT'=3 DGCNT(3)=$G(DGCNT(3))+$G(DGCNT(DGCAT))
 .. W:DGCAT=3 !?46,"-------"
 .. W !,"Total Review Assignments for Category "
 .. W $S(DGCAT=1:"I",DGCAT=2:"II",1:"I & II"),":"
 .. W ?47,$J(+$G(DGCNT(DGCAT)),6)
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
SUB(CNT,TYP) ; print sub-totals
 ;  Input:
 ;      CNT - count of records printed
 ;      TYP - indicator of which total count is being printed
 ; Output: Write lines of Sub-Totals and Totals per Flag and Category
 ;
 N DGTYPE,DGCOUNT
 S DGTYPE=$S(TYP=1:"Flag",2:"Category "_$S(DGCAT=1:"I",1:"II"))
 S DGCOUNT=$S(TYP=1:CNT,1:DGCNT(DGCAT))
 W:TYP=1 !
 W !,"Total Review Assignments for "_DGTYPE_":  ",DGCOUNT
 W:TYP=1 !,"Note:  "" * "" indicates that review date is past due",!
 Q
 ;
HEAD ;Print/Display page header
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1 Q
 D PAUSE(.DGQ)
 Q:DGQ
 W:'($E(IOST,1,2)'="C-"&'DGPAGE) @IOF
 S DGPAGE=$G(DGPAGE)+1
 W !?22,"PATIENT RECORD FLAGS"
 W !?16,"ASSIGNMENTS DUE FOR REVIEW REPORT",?70,"Page: ",$G(DGPAGE)
 W !?16,"---------------------------------",?51,"Printed: ",DGDT
 W !?2,"CATEGORY: "_$S($G(DGCAT)=1:"Category I (National)",$G(DGCAT)=2:"Category II (Local)",1:"Both (Category I & II)")
 W !,"DATE RANGE: ",$$FDATE^VALM1($G(DGSORT("DGBEG")))_" TO "_$$FDATE^VALM1($G(DGSORT("DGEND")))
 W !?1,"FLAG NAME: ",$G(DGFG),!
 I DGGRAND W DGLINE Q
 W !,"PATIENT NAME",?22,"SSN",?33,"ASSIGNED",?43,"REVIEW DT",?54,"NOTIFICATION SENT"
 W !,"--------------------",?22,"---------",?33,"--------",?43,"---------",?54,"-----------------"
 Q
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K @DGLIST
 I '$D(ZTQUEUED) D
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q
