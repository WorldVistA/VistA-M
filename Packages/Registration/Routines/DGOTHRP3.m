DGOTHRP3 ;SLC/RM - OTH PATIENT PERIOD STATUS REPORT CONT. ;MAY 8, 2018@5:15
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;     Last Edited: SHRPE/RM - MAY 8, 2018 17:15
 ;
 ; ICR# TYPE      DESCRIPTION
 ;----- ----      ---------------------
 ;10024 Sup       WAIT^DICD
 ;10063 Sup       $$S^%ZTLOAD
 ;10086 Sup       HOME^%ZIS
 ;10089 Sup       ^%ZISC
 ;10103 Sup       ^XLFDT: $$FMTE, $$NOW
 ;10112 Sup       $$SITE^VASITE
 ;10015 Sup       GETS^DIQ
 ;10026 Sup       ^DIR
 ;
 ;This routine will be used to display or print Other Than Honorable 
 ;patient treated under OTH authority.
 ;
 ; INPUT:  DGSORT() - see comments at the top of routine DGOTHRPT for
 ;         explanation of DGSORT array
 ;
 ; Output:  A formatted report of Other Than Honorable Statistical Report
 ;
 ;- no direct entry
 Q
 ;
START ; compile and print report
 I $E(IOST)="C" D WAIT^DICD
 N HERE S HERE=$$SITE^VASITE ;extract the IEN and facility name
 N TRM S TRM=($E(IOST)="C")
 N DGLIST ;temp global name used for report list
 N DGQRT   ;array or report parameters for quarters
 S DGLIST=$NA(^TMP("DGOTHST",$J))
 N DGCNT,DGNET
 K @DGLIST,DGCNT,DGNET
 S (DGCNT,DGNET)=0
 D LOOP(.DGSORT,DGLIST)
 D PRINT1(.DGSORT,DGLIST,.DGCNT) ;by month or all month in the quarters
 K @DGLIST
 W !
 D EXIT^DGOTHRP2
 Q
 ;
LOOP(DGSORT,DGLIST) ;
 I 123[$P(DGSORT("DGMON"),U) D LOOP2(.DGSORT,DGLIST) ;by month
 I 4[$P(DGSORT("DGMON"),U) D LOOP1(.DGSORT,DGLIST) ;all month in the quarter
 I 5[$P(DGSORT("DGMON"),U) D LOOP3(.DGSORT,DGLIST) ;fiscal year
 Q
 ;
LOOP1(DGSORT,DGLIST) ;
 ; If 4[$P(DGSORT("DGMON"),U)
 ;    - Then, build DGSORT("DGBEG") and DGSORT("DGEND") 
 ;      for each month on the fly
 N DGMON,II
 S II="" F  S II=$O(DGSORT("DGMON",II)) Q:II=""  D
 . S DGMON=$$CALRNGE^DGOTHRPT(.DGSORT,"",II)
 . S DGSORT("DGBEG")=$P(DGMON,U)
 . S DGSORT("DGEND")=$P(DGMON,U,2)
 . D LOOP2(.DGSORT,DGLIST)
 Q
 ;
LOOP2(DGSORT,DGLIST) ;
 N DGDFN,DGDIEN,DGQ,DGRES,DGIEN,DGOLD,DGQNUM,DGARR,DGRET,DGERR,DG90A,RET
 ;loop variable pointer flag x-ref file to run report
 S (DGDFN,DGIEN,DGOLD)="",DGQ=0
 F  S DGDFN=$O(^DGOTH(33,"B",DGDFN)) Q:DGDFN=""  D
 . N DGIEN33,DFN,DGRES,DGPTSTAT,DGOSTAT,DGLS365D,DGLS365I
 . K DGARR,DGRET,DGERR,DG90A,DGCLCK,RET
 . S DGIEN33=$O(^DGOTH(33,"B",DGDFN,0)),(DGRES,DGOSTAT)=0
 . D GETS^DIQ(33,DGIEN33_",",".01;.02;1*;2*","EI","DGARR","DGERR")
 . Q:$D(DGERR)
 . S DFN=$G(DGARR(33,DGIEN33_",",.01,"I")) ;patient's DFN
 . D CLOCK^DGOTHRP2(DGIEN33)
 . Q:'$D(DGCLCK)
 . I $$MSNGPRD^DGOTHBTN(DGLS365D,.DGCLCK) Q
 . D RESULT(.DGARR,.DG90A,DGIEN33)
 . Q:'$D(DGRET)
 . D SORT(.DGRET,.DGSORT,.DGCLCK)
 Q
 ;
LOOP3(DGSORT,DGLIST) ;Fiscal year detail
 ; If 5[$P(DGSORT("DGMON"),U)
 ;    - Then, build DGSORT("DGBEG") and DGSORT("DGEND") 
 ;      for each month in the quarter on the fly
 N DGMON,DGQRTR,M,Q
 S Q="" F  S Q=$O(DGSORT("DGMON",Q)) Q:Q=""  D
 . S M="" F  S M=$O(DGSORT("DGMON",Q,M)) Q:M=""  D
 . . S DGMON=$$CALRNGE^DGOTHRPT(.DGSORT,Q,M)
 . . S DGSORT("DGBEG")=$P(DGMON,U)
 . . S DGSORT("DGEND")=$P(DGMON,U,2)
 . . S DGQRTR=Q
 . . D LOOP2(.DGSORT,DGLIST)
 Q
 ;
RESULT(DGARR,DG90A,DGIEN33) ;extract the 365 and 90 day period data for OTH patient
 ;
 N DGIENS,DGDATE,I,II,DGAUTH,DGSDT,DGENDT,DGDIFF,DONE,DATASTR
 S DGRES="",DONE=0
 S DGDATE=$S($G(DGDATE)>0:DGDATE,1:DT)
 F I=1:1:DGLS365D D  Q:DONE
 . I '$D(DGCLCK(I)) K DGRET S DONE=1,DGRES="" Q
 . S DGRET(I)="",DGAUTH=""
 . F II=1:1:DGCLCK(I) D  Q:DONE
 . . K DGIENS,DGSDT,DGENDT,DGDIFF,DATASTR
 . . I DGCLCK(I,II)'=II K DGRET S DONE=1,DGRES="" Q
 . . Q:DGCLCK(I,II)<1
 . . S DGIENS=DGCLCK(I,II)_","_I_","_+DGIEN33_","
 . . S DATASTR=$$GET90DT^DGOTHUT1(+DGIEN33,I,II)
 . . S DGSDT=$P(DATASTR,U) ;start date
 . . S DGENDT=$P(DATASTR,U,2) ;end date
 . . I DGENDT'>0 S DGENDT=""
 . . S DGDIFF=$P(DATASTR,U,3) ;days remaining
 . . S DGAUTH=DGARR(33.11,DGIENS,.04,"I")
 . . S DGRES=DGRES_DGSDT_U_DGENDT_U_DGDIFF_U
 . . S DGRET(I,II)=DGSDT_U_DGENDT_U_DGDIFF_U_$S(II=1:"",1:DGAUTH)
 . . ;determine which 90-Day period is considered "active" within the current 365-Day period
 . . I DGRET(I)="" D
 . . . I DGDIFF<1 S DGRET(I)=0 Q
 . . . S DGRET(I)=II
 . . I (DGDIFF>0),(DGDIFF<90),DGSDT<=DT S DGRET(I)=II Q
 . . I DGDIFF=90,DGSDT>=DT,DGRET(I)<1 S DGRET(I)=II
 Q DGRES
 ;
SORT(DGRET,DGSORT,DGCLCK) ;
 ;check if OTH-90 Patient will be included or
 ;excluded into the statistical report
 N II,DG90,DGBEG,DGEND,DGNACTVN,DATA,DGDTOK
 F II=1:1:DGLS365D D
 . Q:'$D(DGCLCK(II))
 . S DG90="" F  S DG90=$O(DGRET(II,DG90)) Q:DG90=""  D
 . . K DGBEG,DGEND,DGNACTVN,DATA,DGDTOK
 . . S DGBEG=$P(DGRET(II,DG90),U)
 . . S DGEND=$P(DGRET(II,DG90),U,2)
 . . S DGNACTVN=""
 . . ;check if 90-Day period dates fall within the date range specified by the user
 . . S DGDTOK=$$PRDDT(.DGSORT,DGBEG,DGEND) I DGDTOK D
 . . . ;check OTH-90 patient status
 . . . ;get the inactivation date if there is one
 . . . I $G(DGARR(33,DGIEN33_",",.02,"I"))<1 S DGNACTVN=$P($$CROSS^DGOTHINQ(DGIEN33),U,3)
 . . . S DGIENS=DGCLCK(II,DG90)_","_II_","_+DGIEN33_","
 . . . S DGPTNM=DGARR(33,DGIEN33_",",.01,"E")
 . . . S DGSSN=$$GET1^DIQ(2,DFN_",",.0905,"","DGERR")
 . . . S DGAUTH=$S($G(DGARR(33.11,DGIENS,.07,"E"))="":"N/A",1:$G(DGARR(33.11,DGIENS,.07,"E")))
 . . . S DATA=II_U_DG90_U_DGSSN_U_$P(DGRET(II,DG90),U)_U_$P(DGRET(II,DG90),U,2)_U_$P(DGRET(II,DG90),U,3)_U_DGAUTH_U_DGNACTVN
 . . . D BLD(.DGSORT,DGLIST,.DGRET,.DGARR,DATA,DGDTOK)
 Q
 ;
PRDDT(DGSORT,DGBEG,DGEND) ;
 ;check if period of care dates fall within the date range specified by the user
 N OK
 S OK=0
 S:DGBEG>=DGSORT("DGBEG")&(DGBEG<=DGSORT("DGEND")) OK=1
 S:DGEND>=DGSORT("DGBEG")&(DGEND<=DGSORT("DGEND")) OK=2
 S:DGBEG<=DGSORT("DGEND")&(DGEND>=DGSORT("DGEND")) OK=1
 Q OK
 ;
BLD(DGSORT,DGLIST,DGRET,DGARR,DATA,DGDTOK) ;
 ;build and count the new and old oth patients
 N DGMON,DGVASSN
 S DGMON=$S(DGDTOK=1:+$E($P(DATA,U,4),4,5),1:+$E($P(DATA,U,5),4,5))
 I DGSORT("DGBEG")<=$P(DATA,U,4),(DGSORT("DGEND"))>=$P(DATA,U,4) D
 . D BLDNEW(DGPTNM,DATA)
 . S DGCNT("NEW")=$G(DGCNT("NEW"))+1
 . I 123[$P(DGSORT("DGMON"),U) S DGCNT("NEW",$P(DATA,U,2))=$G(DGCNT("NEW",$P(DATA,U,2)))+1
 . E  S DGCNT("NEW",DGMON)=$G(DGCNT("NEW",DGMON))+1
 . D CALCIN(DATA,1,DGMON)
 E  D
 . I DGDTOK>1,$D(DGRET(II,DG90+1)),DGMON=+$E($P(DGRET(II,DG90+1),U),4,5) D  Q
 . . ;means patient has a consecutive treatment whose date
 . . ;falls within the date range.
 . . ;so do not list them as carryover per request of Dr. Garcia
 . . D BLDNEW(DGPTNM,DATA)
 . D BLDOLD(DGPTNM,DATA)
 . S DGCNT("OLD")=$G(DGCNT("OLD"))+1
 . I 123[$P(DGSORT("DGMON"),U) S DGCNT("OLD",$P(DATA,U,2))=$G(DGCNT("OLD",$P(DATA,U,2)))+1
 . E  S DGCNT("OLD",+$E(DGSORT("DGBEG"),4,5))=$G(DGCNT("OLD",+$E(DGSORT("DGBEG"),4,5)))+1
 . D CALCIN(DATA,0,+$E(DGSORT("DGBEG"),4,5))
 S DGCNT=$G(DGCNT("NEW"))+$G(DGCNT("OLD"))
 ;count the total unique OTH patients for the entire fiscal year
 I 5[$P(DGSORT("DGMON"),U),'$D(DGNET(DGIEN33,DGPTNM)) D
 . S DGNET(DGIEN33,DGPTNM)=""
 . S DGNET=DGNET+1
 Q
 ;
BLDNEW(DGPTNM,DATA) ;
 S @DGLIST@("NEW",DGMON,$S(1234[$P(DGSORT("DGMON"),U):$P(DGSORT("DGQTR"),U),1:DGQRTR),DGPTNM,$P(DATA,U,2))=DATA
 Q
 ;
BLDOLD(DGPTNM,DGMON,DGCLCK,DGTMP) ;
 S @DGLIST@("OLD",+$E(DGSORT("DGBEG"),4,5),$S(1234[$P(DGSORT("DGMON"),U):$P(DGSORT("DGQTR"),U),1:DGQRTR),DGPTNM,$P(DATA,U,2))=DATA
 Q
 ;
PRINT1(DGSORT,DGLIST,DGCNT) ;display by month or month in the quarter
 N DGPAGE,DDASH,DGFLG,DGQ,DGSTDT,DGPTNM,DGSTR,DGOLD,DGMON
 N DGPR1,DGPR2,DGSTAT,DGMNAME,DGP1TOT,DGP2TOT,DGQRTR,DGC1,DGC2
 S (DGQ,DGPAGE)=0,(DDASH,DGLN,DGOLD)="",$P(DDASH,"-",81)=""
 I $O(@DGLIST@(""))="" D  Q
 . D HEAD
 . W !!," >>> No Records were found using the report criteria.",!
 . D ASKCONT^DGOTHMG2
 ; loop and display report
 S (DGPR1,DGPR2,DGC1,DGC2,DGP1TOT,DGP2TOT)=0
 ;loop and display report by monthly or all months in the quarter
 I 1234[$P(DGSORT("DGMON"),U) D  Q:DGQ
 . S DGMON="" F  S DGMON=$O(DGSORT("DGMON",DGMON)) Q:DGMON=""  D  Q:DGQ
 . . S DGMNAME=$P(DGSORT("DGMON",DGMON),U) ;month name
 . . D PRINT2
 ;loop and display report for the entire FISCAL YEAR
 I 5[$P(DGSORT("DGMON"),U) D  Q:DGQ
 . D FYEAR
 ;
 I DGQ W:$D(ZTQUEUED) !!,"REPORT STOPPED AT USER REQUEST" Q
 N DGLN,DGTOTQ,DGTOTP1,DGTOTP2,DGGRND
 S DGLN=""
 I $E(IOST)'="C" W !
 S (DGTOTQ,DGTOTP1,DGTOTP2,DGGRND)=0
 I 123[$P(DGSORT("DGMON"),U) D MRPTSUM  ;monthly report summary
 ;quarterly/fiscal report summary
 I 45[$P(DGSORT("DGMON"),U) D CONT^DGOTHRP4(.DGSORT)
 W !!,"<END OF REPORT>"
 D ASKCONT^DGOTHMG2
 Q
 ;
PRINT2 ;
 ;OTH-90 patient that newly started their treatment
 N STATUS
 S STATUS=1
 I $D(@DGLIST@("NEW",DGMON)) D  Q:DGQ
 . D HEAD,SUBHEAD(1,DGMNAME),PRNTNEW
 E  D HEAD,SUBHEAD(1,DGMNAME),NOREC(1)
 Q:DGQ
 ;per Dr. Garcia, do not display the lists of carry-over OTH-90 patients
 ;if user selects all months in the quarter, instead, immediately display
 ;the total number of all carry-over OTH-90 patients for that month
 I 45[$P(DGSORT("DGMON"),U) D DSPLYCRY Q
 ;OTH-90 patient whose treatment has been carried-over
 ;or continued to the following month
 Q:DGQ
 I $D(@DGLIST@("OLD",DGMON)) D  Q:DGQ
 . D HEAD,SUBHEAD(0,DGMNAME),PRNTOLD
 E  D HEAD,SUBHEAD(0,DGMNAME),NOREC(0)
 Q:DGQ
 Q
 ;
FYEAR ;loop and display report for the entire FISCAL YEAR
 N DGQRT,DGMON
 S DGQRT="" F  S DGQRT=$O(DGSORT("DGMON",DGQRT)) Q:DGQRT=""  D  Q:DGQ
 . S DGMON="" F  S DGMON=$O(DGSORT("DGMON",DGQRT,DGMON)) Q:DGMON=""  D  Q:DGQ
 . . S DGMNAME=$P(DGSORT("DGMON",DGQRT,DGMON),U) ;month name
 . . D PRINT2
 . Q:DGQ
 Q
 ;
NOREC(STATUS) ;
 W !," *** No "_$S(STATUS=1:"NEW",1:"CARRY-OVER")_" OTH-90 patient records were found",!
 W:STATUS "     that started treatment for this month."
 I 123[$P(DGSORT("DGMON"),U) D
 . I STATUS>0 W ! D DSPLYNW Q
 . W !! D DSPLYCRY
 I 45[$P(DGSORT("DGMON"),U) D DSPLYNW
 Q
 ;
PRNTNEW ;OTH-90 newly started their treatment
 S DGQRTR="" F  S DGQRTR=$O(@DGLIST@("NEW",DGMON,DGQRTR)) Q:DGQRTR=""  D  Q:DGQ
 . S DGPTNM="" F  S DGPTNM=$O(@DGLIST@("NEW",DGMON,DGQRTR,DGPTNM)) Q:DGPTNM=""  D  Q:DGQ
 . . S DGCLCK="" F  S DGCLCK=$O(@DGLIST@("NEW",DGMON,DGQRTR,DGPTNM,DGCLCK)) Q:DGCLCK=""  D  Q:DGQ
 . . . S DGSTR=@DGLIST@("NEW",DGMON,DGQRTR,DGPTNM,DGCLCK)
 . . . W !
 . . . I $Y>(IOSL-4) D PAUSE^DGOTHRP2(.DGQ) Q:DGQ  D HEAD W !
 . . . I DGPTNM'=DGOLD W $E(DGPTNM,1,20),?23,$P(DGSTR,U,3) ;patient name and PID
 . . . S DGOLD=DGPTNM ;display the name and PID only once
 . . . W ?31,$P(DGSTR,U,2),?37,$$FMTE^XLFDT($P(DGSTR,U,4),"5Z"),?49,$$FMTE^XLFDT($P(DGSTR,U,5),"5Z")
 . . . ;display N/A in replacement for days remaining if 90-Day has been inactivated
 . . . W ?61,$S($P(DGSTR,U,8)'="":$J("N/A",4),1:$J($P(DGSTR,U,6),4))
 . . W ?68,$$FMTE^XLFDT($P(DGSTR,U,8),"5Z")
 . . Q:DGQ
 . Q:DGQ
 Q:DGQ
DSPLYNW ;
 W:45[$P(DGSORT("DGMON"),U) !
 W !!,"New for "_DGMNAME,?26,"="
 I 123[$P(DGSORT("DGMON"),U) W $S($G(DGCNT("NEW"))>0:$J(DGCNT("NEW"),5),1:$J(0,5)),!
 E  W $S($G(DGCNT("NEW",DGMON))>0:$J(DGCNT("NEW",DGMON),5),1:$J(0,5)),!
 D:123[$P(DGSORT("DGMON"),U) PAUSE^DGOTHRP2(.DGQ) Q:DGQ
 Q
 ;
PRNTOLD ;OTH-90 whose treatment carried/continued to the following month
 S DGQRTR="" F  S DGQRTR=$O(@DGLIST@("OLD",DGMON,DGQRTR)) Q:DGQRTR=""  D  Q:DGQ
 . S DGPTNM="" F  S DGPTNM=$O(@DGLIST@("OLD",DGMON,DGQRTR,DGPTNM)) Q:DGPTNM=""  D  Q:DGQ
 . . S DGCLCK="" F  S DGCLCK=$O(@DGLIST@("OLD",DGMON,DGQRTR,DGPTNM,DGCLCK)) Q:DGCLCK=""  D  Q:DGQ
 . . . S DGSTR=@DGLIST@("OLD",DGMON,DGQRTR,DGPTNM,DGCLCK)
 . . . I 45[$P(DGSORT("DGMON"),U) Q
 . . . W !
 . . . I $Y>(IOSL-4) D PAUSE^DGOTHRP2(.DGQ) Q:DGQ  D HEAD W !
 . . . I DGPTNM'=DGOLD W $E(DGPTNM,1,20),?23,$P(DGSTR,U,3) ;patient name and PID
 . . . S DGOLD=DGPTNM ;display the name and PID only once
 . . . W ?31,$P(DGSTR,U,2),?37,$$FMTE^XLFDT($P(DGSTR,U,4),"5Z"),?49,$$FMTE^XLFDT($P(DGSTR,U,5),"5Z")
 . . . ;display N/A in replacement for days remaining if 90-Day has been inactivated
 . . . W ?61,$S($P(DGSTR,U,8)'="":$J("N/A",4),1:$J($P(DGSTR,U,6),4))
 . . W:123[$P(DGSORT("DGMON"),U) ?68,$$FMTE^XLFDT($P(DGSTR,U,8),"5Z")
 . . Q:DGQ
 . Q:DGQ
 Q:DGQ
 W !!
DSPLYCRY W "Carryover for "_DGMNAME,?26,"="
 I 123[$P(DGSORT("DGMON"),U) W $S($G(DGCNT("OLD"))>0:$J(DGCNT("OLD"),5),1:$J(0,5)),!
 E  D
 . W $S($G(DGCNT("OLD",DGMON))>0:$J(DGCNT("OLD",DGMON),5),1:$J(0,5)),!
 . W "================================",!
 . W "TOTAL",?26," ",$J(($G(DGCNT("NEW",DGMON)))+($G(DGCNT("OLD",DGMON))),5),!
 D PAUSE^DGOTHRP2(.DGQ) Q:DGQ
 Q
 ;
CALCIN(DGSTR,DGSTAT,DGMON) ;calculate inactivated OTH patients
 I $P(DGSTR,U,8)'="" D
 . I 123[$P(DGSORT("DGMON"),U) D
 . . I DGSTAT<1 S DGCNT("OLD",$P(DGSTR,U,2),0)=$G(DGCNT("OLD",$P(DGSTR,U,2),0))+1
 . . E  S DGCNT("NEW",$P(DGSTR,U,2),0)=$G(DGCNT("NEW",$P(DGSTR,U,2),0))+1
 . I 45[$P(DGSORT("DGMON"),U) S DGCNT("IN",DGMON)=$G(DGCNT("IN",DGMON))+1
 Q
 ;
MRPTSUM ;monthly report summary
 N TOTAL1,TOTAL2
 D HEAD
 W !,"REPORT SUMMARY for the month of ",$P(DGSORT("DGMON"),U,2),":"
 W !!,?16,"90-DAY",?29,"NEW",?39,"CARRY OVER",?55,"TOTAL",?64,"|",?65,"INACTIVATED"
 S $P(DGLN,"=",49)="" W !,?16,DGLN,?64,"|",?65,"============"
 N I,TOTAL
 S (TOTAL1,TOTAL2)=0
 F I=1:1:5 D
 . W !,?16,$J(I,4)
 . ;I $D(DGCNT("NEW",I))!($D(DGCNT("OLD",I))) D
 . I $D(DGCNT("NEW",I)) W ?29,$J(DGCNT("NEW",I),3)
 . I $D(DGCNT("OLD",I)) W ?39,$J(DGCNT("OLD",I),5)
 . I $D(DGCNT("NEW",I))!($D(DGCNT("OLD",I))) W ?55,$J($G(DGCNT("NEW",I))+($G(DGCNT("OLD",I))),5)
 . E  W ?55,$J(0,5)
 . W ?64,"|"
 . I $G(DGCNT("NEW",I,0))!($G(DGCNT("OLD",I,0))) D
 . . W ?65,$J($G(DGCNT("NEW",I,0))+($G(DGCNT("OLD",I,0))),6)
 . S TOTAL1=TOTAL1+($G(DGCNT("NEW",I)))+($G(DGCNT("OLD",I)))
 . S TOTAL2=TOTAL2+($G(DGCNT("NEW",I,0)))+($G(DGCNT("OLD",I,0)))
 S $P(DGLN,"=",65)="" W !,DGLN,?64,"|",?65,"============"
 W !,"TOTAL",?29,$J($G(DGCNT("NEW")),3),?39,$J($G(DGCNT("OLD")),5),?55,$J($G(TOTAL1),5),?64,"|",?65,$J($G(TOTAL2),6)
 Q
 ;
MONAME ;Month Name
 ;;1^January
 ;;2^February
 ;;3^March
 ;;4^April
 ;;5^May
 ;;6^June
 ;;7^July
 ;;8^August
 ;;9^September
 ;;10^October
 ;;11^November
 ;;12^December
 Q
 ;
HEAD ;Print/Display Page Header Detail
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1 Q
 N DGFACLTY,DGPRD
 I TRM!('TRM&DGPAGE) W @IOF
 S DGPAGE=$G(DGPAGE)+1
 S DGFACLTY="Facility: "_$P(HERE,U,2)
 W !,?80-$L(ZTDESC)\2,$G(ZTDESC),?71,"Page:",?77,DGPAGE
 W !,?80-$L(DGFACLTY)\2,DGFACLTY ;facility
 S DGPRD="Report Period: "_$S(123[$P(DGSORT("DGMON"),U):"Month of "_$P(DGSORT("DGMON"),U,2),1:$P(DGSORT("DGMON"),U,2))
 W !,?80-$L(DGPRD)\2,DGPRD
 W !,"Date Range:",?12,DGDTRNGE
 W ?45,"Date Printed:",?59,$$FMTE^XLFDT($$NOW^XLFDT,"MP")
 W !,DDASH
 W !,"PATIENT NAME",?23,"PID",?29,"PERIOD",?37,"START DATE",?49,"END DATE",?61,"DAYS",?68,"INACTIVATION"
 W !,?61,"LEFT",?68,"DATE"
 W !,DDASH,!
 Q
 ;
SUBHEAD(DGSTAT,DGMNAME) ;display sub header
 W !,$S(DGSTAT:"OTH-90 Patients that started treatment in  ",1:"Carry-over OTH-90 Patients for ")
 W DGMNAME_":"
 W !
 Q
 ;
HELP ;provide extended DIR("?") help text.
 ;
 I X'="?",X'="??" W !,"  Not a valid fiscal year.",!
 W !,"  Enter the fiscal year in this format: YY or YYYY"
 Q
 ;
