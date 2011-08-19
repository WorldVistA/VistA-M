DGPFRPI2 ;ALB/RBS - PRF PRINCIPAL INVEST REPORT CONT. ; 6/14/04 10:39am
 ;;5.3;Registration;**554**;Aug 13, 1993
 ;
 ;This routine will be used to display/print all patient assignments
 ;for a Principal Investigator assigned to the Research record flag.
 ;
 ;- no direct entry
 QUIT
 ;
PRINT(DGSORT,DGLIST) ;output report
 ;  Input:
 ;      DGSORT - array of user selected report parameters
 ;      DGLIST - temp global name used for report list
 ;               ^TMP("DGPFRPI1",$J)
 ;
 ; Output: Formatted report to user selected device
 ;
 N DGBEG    ;sort beginning date
 N DGDFN    ;ien of patient
 N DGDT     ;date time report printed
 N DGFG     ;flag name
 N DGEND    ;sort ending date
 N DGHSTR   ;header string var
 N DGHSTR1  ;header string var
 N DGHSTR2  ;header string var
 N DGLINE   ;string of hyphens (80) for report header format
 N DGLN     ;loop var
 N DGPNAM   ;patient name
 N DGODFN   ;loop var flag
 N DGOFG    ;name switch flag
 N DGOPISTR ;pi name switch flag
 N DGPAGE   ;page counter
 N DGPISTR  ;pi name string for sub-header display
 N DGQ      ;quit flag
 N DGSTR    ;string of detail line to display
 N X,Y
 ;
 S DGHSTR="PATIENT RECORD FLAGS"
 S DGHSTR1="ASSIGNMENTS BY PRINCIPAL INVESTIGATOR REPORT"
 I DGSORT("DGPRINC")="A" S DGHSTR2="(A)ll Principal Investigators"
 E  S DGHSTR2="(S)ingle Principal Investigator: "_$P(DGSORT("DGPRINC"),U,2)
 S DGDT=$P($$FMTE^XLFDT($$NOW^XLFDT,"T"),":",1,2)
 S DGBEG=$$FDATE^VALM1(DGSORT("DGBEG"))
 S DGEND=$$FDATE^VALM1(DGSORT("DGEND"))
 S (DGQ,DGPAGE)=0,$P(DGLINE,"-",81)=""
 ;
 I $O(@DGLIST@(""))="" D  Q
 . D HEAD
 . W !!,"   >>> No Record Flag Assignments were found using the report criteria.",!
 ;
 ; loop and print report
 S (DGDFN,DGFG,DGLN,DGPISTR,DGPNAM,DGODFN,DGOFG,DGOPISTR,DGSTR)=""
 ;
 D HEAD
 F  S DGFG=$O(@DGLIST@(DGFG)) Q:DGFG=""  D  Q:DGQ
 . S DGPISTR=$$PISTR(DGFG)
 . I $Y>(IOSL-10) D PAUSE(.DGQ) Q:DGQ  D HEAD,HEAD1,HEAD2,HEAD3 S DGOFG=DGFG,DGOPISTR=DGPISTR
 . I DGOFG'=DGFG D
 . . W:DGOPISTR]"" !! D HEAD1,HEAD2,HEAD3 S DGOFG=DGFG,DGOPISTR=DGPISTR
 . S DGPNAM=0  ;starts looping after "0" princ invest node
 . F  S DGPNAM=$O(@DGLIST@(DGFG,DGPNAM)) Q:DGPNAM=""  D  Q:DGQ
 . . ; print patient detail line
 . . S DGODFN=""
 . . F  S DGDFN=$O(@DGLIST@(DGFG,DGPNAM,DGDFN)) Q:DGDFN=""  D  Q:DGQ
 . . . S DGLN=""
 . . . F  S DGLN=$O(@DGLIST@(DGFG,DGPNAM,DGDFN,DGLN)) Q:DGLN=""  D  Q:DGQ
 . . . . I $Y>(IOSL-3) D PAUSE(.DGQ) Q:DGQ  D HEAD,HEAD1,HEAD2,HEAD3 S DGODFN=""
 . . . . S DGSTR=$G(@DGLIST@(DGFG,DGPNAM,DGDFN,DGLN))
 . . . . W !
 . . . . I DGODFN'=DGDFN S DGODFN=DGDFN D  ;only print name once
 . . . . . W $E(DGPNAM,1,16),?18,$P(DGSTR,U)
 . . . . W ?30,$P(DGSTR,U,2),?48,$P(DGSTR,U,3),?60,$P(DGSTR,U,4),?71,$P(DGSTR,U,5)
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
 W:'($E(IOST,1,2)'="C-"&'DGPAGE) @IOF
 ;
 S DGPAGE=$G(DGPAGE)+1
 W !?(IOM/2)-($L(DGHSTR)/2),DGHSTR
 W !?(IOM/2)-($L(DGHSTR1)/2),DGHSTR1
 W ?68,"Page: ",$G(DGPAGE)
 W !,"Date Range: ",DGBEG_" to "_DGEND
 W ?50,"Printed: ",DGDT
 W !,"Sorted By: ",DGHSTR2
 W !,DGLINE,!
 Q
 ;
HEAD1 W !,"Flag Name: ",$G(DGFG)," - Category II (Local)"
 Q
 ;
HEAD2 W !,"Principal Investigator: "
 ;    <---- length = 24 ----->
 ; check string length so we don't wrap on screen/printer (80) max
 I $L(DGPISTR)'>55 W ?24,DGPISTR
 E  D
 . N X,Y
 . S X=""
 . F Y=1:1:$L(DGPISTR,"; ") D
 . . I $L(X_$P(DGPISTR,"; ",Y))>53 W ?24,X,";" S X="" W !
 . . S:X]"" X=X_"; "
 . . S X=X_$P(DGPISTR,"; ",Y)
 . W ?24,X
 Q
 ;
HEAD3 W !!,"PATIENT",?18,"SSN",?30,"ACTION",?48,"ACTION DT",?60,"REVIEW DT",?71,"STATUS"
 W !,"================",?18,"==========",?30,"================",?48,"=========",?60,"=========",?71,"========="
 Q
 ;
PISTR(DGFG) ;string Principal Investigators together for sub-header display
 ;
 ;  Input:
 ;      DGFG - flag name subscript
 ;
 ; Output:
 ;  Function Value - string of Principal Investigator names
 ;     i.e. -  "Johnny Cash; Bob Smith; Pete Best; ect..."
 ;
 N DGRSLT   ;returned function value
 N DGPI     ;principal investigator person ien
 S DGRSLT=""
 ;
 I $O(@DGLIST@(DGFG,0,""))="" D
 . S DGRSLT="No Principal Investigator names on file"
 ;
 I $O(@DGLIST@(DGFG,0,"")) D
 . S DGPI=""
 . F  S DGPI=$O(@DGLIST@(DGFG,0,DGPI)) Q:DGPI=""  D  Q:$L(DGRSLT)>450
 . . S:DGRSLT]"" DGRSLT=DGRSLT_"; "
 . . S DGRSLT=DGRSLT_$G(@DGLIST@(DGFG,0,DGPI))
 Q DGRSLT
