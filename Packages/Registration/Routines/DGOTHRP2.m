DGOTHRP2 ;SLC/RM - OTH PATIENT PERIOD STATUS REPORT CONT. ;MAY 8, 2018@5:15
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified
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
 ;10015/2056 Sup   GETS^DIQ
 ;10026 Sup       ^DIR
 ;
 ;This routine will be used to display or print Other Than Honorable
 ;Active 90-Day Period Status
 ;Expired 90-Day Period Status
 ;Both (Active and Expired) 90-Day Period Status
 ;
 ; INPUT:  DGSORT() - see comments at the top of routine DGOTHRPT for
 ;         explanation of DGSORT array
 ;
 ; Output:  A formatted report of Other Than Honorable
 ;          Active 90-Day Period Status
 ;
 ;- no direct entry
 Q
 ;
START ; compile and print report
 I $E(IOST)="C" D WAIT^DICD
 N HERE S HERE=$$SITE^VASITE ;extract the IEN and facility name
 N TRM S TRM=($E(IOST)="C")
 N DGLIST ;temp global name used for report list
 S DGLIST=$NA(^TMP("DGOTHR2",$J))
 K @DGLIST
 D LOOP(.DGSORT,DGLIST)
 D PRINT(.DGSORT,DGLIST)
 K @DGLIST
 D ASKCONT^DGOTHMG2
 D EXIT
 Q
 ;
LOOP(DGSORT,DGLIST) ;
 N DGDFN,DGDIEN,DGQ,DGRES,DGIEN,DGOLD,DGTOTAL,DGARR,DGRET,DGCLCK,DG90A,DGERR,RET
 ;loop variable pointer flag x-ref file to run report
 S (DGDFN,DGIEN,DGOLD)="",(DGTOTAL,DGQ)=0
 F  S DGDFN=$O(^DGOTH(33,"B",DGDFN)) Q:DGDFN=""  D
 . N DGIEN33,DFN,DGPTSTAT,DGLS365D,DGLS365I
 . K DGARR,DGRET,DGCLCK,DG90A,DGERR,RET
 . ;Patient's primary eligibility code is no longer EXPANDED MH CARE NON-ENROLLEE
 . Q:$$ISOTHD^DGOTHD(DGDFN)=0 
 . ;Patient's current MH CARE TYPE is no longer OTH-90
 . Q:'$$ISOTH90(DGDFN)
 . S DGIEN33=+$O(^DGOTH(33,"B",DGDFN,0))
 . D GETS^DIQ(33,DGIEN33_",",".01;.02;1*;2*","EI","DGARR","DGERR")
 . Q:$D(DGERR)
 . I DGARR(33,DGIEN33_",",.02,"I")<1 Q
 . D CLOCK(DGIEN33)
 . Q:'$D(DGCLCK)
 . I $$MSNGPRD^DGOTHBTN(DGLS365D,.DGCLCK) Q
 . D RESULT^DGOTHRP3(.DGARR,.DG90A,DGIEN33)
 . Q:'$D(DGRET)
 . S DFN=$G(DGARR(33,DGIEN33_",",.01,"I"))
 . I $D(DGSORT("DGSTATUS")) D ALL90(.DGSORT,DGLIST,.DGRET,DFN,DGIEN33,.DGARR,.DG90A)
 Q
 ;
ISOTH90(DGDFN) ;determine if patient is EMERGENT OTH
 N DGEXP
 S DGEXP=$$GETEXPR^DGOTHD(DGDFN)
 I DGEXP="" Q 0
 I DGEXP<0 Q 0
 I DGEXP'?1"OTH".E Q 0
 I $$ISOTH^DGOTHD(DGEXP)>1 Q 1
 Q 0
 ;
CLOCK(DGIEN33) ;
 N DGN
 S DGLS365D=+$O(^DGOTH(33,DGIEN33,1,"B",999),-1)
 S DGLS365I=+$O(^DGOTH(33,DGIEN33,1,"B",DGLS365D,0))
 F I=1:1:DGLS365D D
 . S DGN=0 F  S DGN=+$O(^DGOTH(33,DGIEN33,1,I,1,"B",DGN)) Q:DGN=0  D
 . . S DG90A(DGN)=+$O(^DGOTH(33,DGIEN33,1,I,1,"B",DGN,0))
 . . S DGCLCK(I)=$G(DGCLCK(I))+1,DGCLCK(I,$G(DGCLCK(I)))=DGN ;+$O(^DGOTH(33,DGIEN33,1,I,1,"B",DGN,0))
 Q
 ;
ALL90(DGSORT,DGLIST,DGRET,DFN,DGIEN33,DGARR,DG90A) ;
 N DGPTNM,DGSSN,DGAUTH,DGIENS,I,II,DGTMP,DG90,DGSDT,DGEDT,DGDYSLFT
 F I=1:1:DGLS365D D
 . S DG90="" F  S DG90=$O(DGRET(I,DG90)) Q:DG90=""  D
 . . K DGPTNM,DGSSN,DGAUTH,DGIENS,DGSDT,DGEDT,DGDYSLFT
 . . S DGSDT=$P(DGRET(I,DG90),U)
 . . S DGEDT=$P(DGRET(I,DG90),U,2)
 . . S DGDYSLFT=$P(DGRET(I,DG90),U,3)
 . . I 1[$P(DGSORT("DGSTATUS"),U),DGDYSLFT<1 Q
 . . I 2[$P(DGSORT("DGSTATUS"),U),DGRET(I)>0 Q
 . . I 2[$P(DGSORT("DGSTATUS"),U),DGRET(I)<1,$D(DGRET(I+1)) Q
 . . I $$CHKDATE(DGSDT,DGEDT) D
 . . . S DGPTNM=DGARR(33,DGIEN33_",",.01,"E")
 . . . S DGSSN=$$SSN(DFN)
 . . . S DGIENS=DGCLCK(I,DG90)_","_I_","_+DGIEN33_","
 . . . S DGAUTH=$S($G(DGARR(33.11,DGIENS,.07,"E"))="":"N/A",1:$G(DGARR(33.11,DGIENS,.07,"E")))
 . . . S DGTMP=DG90_U_DGSSN_U_$$FMTE^XLFDT(DGSDT,"5Z")_U_$$FMTE^XLFDT(DGEDT,"5Z")_U_DGDYSLFT_U_DGAUTH
 . . . D SORT(DGTMP,DGPTNM,DG90,DGDYSLFT,I)
 Q
 ;
SSN(DFN) ;extract patient's SSN4
 D GETS^DIQ(2,DFN_",",.0905,"ER","DGSSN")
 Q DGSSN(2,DFN_",","1U4N","E")
 ;
SORT(DGTMP,DGPTNM,DGCLCK,DGDYSLFT,I) ;
 ;1 = Sort by Patient Name
 I $P(DGSORT("DGSRTBY"),U)=1 S @DGLIST@(DGPTNM,I,DGCLCK)=DGTMP
 ;2 = Sort by Period
 I $P(DGSORT("DGSRTBY"),U)=2 S @DGLIST@(DGCLCK,I,DGPTNM)=DGTMP
 ;3 = Sort by Days Remaining
 I $P(DGSORT("DGSRTBY"),U)=3 S @DGLIST@(DGDYSLFT,I,DGPTNM)=DGTMP
 ;
 I DGOLD'=DGPTNM S DGTOTAL=DGTOTAL+1,DGOLD=DGPTNM
 I DGTOTAL>0 S @DGLIST@("DGTOTAL")=DGTOTAL
 Q
 ;
CHKDATE(DGSDT,DGEDT) ;check if dates fall within the Begin and End dates
 Q DGSORT("DGBEG")<=DGEDT&(DGSORT("DGEND")>=DGEDT)
 ;
PRINT(DGSORT,DGLIST) ;output report
 N DGPAGE,DDASH,DGQ,DGSUB1,DGSUB2,DGSUB3,DGSTR,DGOLD,DGOLD365,DGTOTAL
 S (DGQ,DGPAGE,DGTOTAL)=0,$P(DDASH,"-",81)=""
 S DGTOTAL=$G(@DGLIST@("DGTOTAL"))
 I $O(@DGLIST@(""))="" D  Q
 . D HEAD
 . W !!," >>> No Record were found using the report criteria.",!
 ; loop and print report
 S (DGSUB1,DGSUB2,DGSUB3,DGSTR,DGOLD,DGOLD365)=""
 D HEAD
 F  S DGSUB1=$O(@DGLIST@(DGSUB1)) Q:DGSUB1=""  D  Q:DGQ
 . F  S DGSUB2=$O(@DGLIST@(DGSUB1,DGSUB2)) Q:DGSUB2=""  D  Q:DGQ
 . . F  S DGSUB3=$O(@DGLIST@(DGSUB1,DGSUB2,DGSUB3)) Q:DGSUB3=""  D  Q:DGQ
 . . . K DGSTR
 . . . S DGSTR=$G(@DGLIST@(DGSUB1,DGSUB2,DGSUB3))
 . . . W !
 . . . I $Y>(IOSL-4) D PAUSE(.DGQ) Q:DGQ  D HEAD W !
 . . . I $P(DGSORT("DGSRTBY"),U)=1,DGSUB1'=DGOLD W $E(DGSUB1,1,18),?20,$P(DGSTR,U,2) S DGOLD=DGSUB1,DGOLD365=""
 . . . I $P(DGSORT("DGSRTBY"),U)=2!($P(DGSORT("DGSRTBY"),U)=3),DGSUB3'=DGOLD W $E(DGSUB3,1,18),?20,$P(DGSTR,U,2) S DGOLD=DGSUB3,DGOLD365=""
 . . . I DGSUB2'=DGOLD365 W ?27,DGSUB2 S DGOLD365=DGSUB2
 . . . W ?31,$P(DGSTR,U),?35,$P(DGSTR,U,3),?47,$P(DGSTR,U,4),?59,$P(DGSTR,U,5),?65,$E($P(DGSTR,U,6),1,15)
 . . Q:DGQ
 . Q:DGQ
 W !!,"Total "_$S(1[$P(DGSORT("DGSTATUS"),U):"Active",2[$P(DGSORT("DGSTATUS"),U):"Expired",1:"Active/Expired")
 W " OTH 90-DAY PERIOD from ",$$FMTE^XLFDT($G(DGSORT("DGBEG")),"5Z")
 W " to ",$$FMTE^XLFDT($G(DGSORT("DGEND")),"5Z"),":",$J($S(DGTOTAL>0:DGTOTAL,1:0),4),!
 W !,"<END OF REPORT>"
 Q
 ;
HEAD ;Print/Display Page Header
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1 Q
 N DGFACLTY
 I TRM!('TRM&DGPAGE) W @IOF
 S DGPAGE=$G(DGPAGE)+1
 S DGFACLTY="Facility: "_$P(HERE,U,2)
 W !,?80-$L(ZTDESC)\2,$G(ZTDESC),?71,"Page:",?77,DGPAGE
 W !,?80-$L(DGFACLTY)\2,DGFACLTY
 W !,"Date Range:",?12,$$FMTE^XLFDT(DGSORT("DGBEG"),"5Z")_" TO "_$$FMTE^XLFDT(DGSORT("DGEND"),"5Z")
 W ?48,"Sorted By:",?59,$E($P($G(DGSORT("DGSRTBY")),U,2),9,$L($P($G(DGSORT("DGSRTBY")),U,2)))
 W !,"Status    :",?12,$P($G(DGSORT("DGSTATUS")),U,2)
 W ?48,"Printed  :",?59,$$FMTE^XLFDT($$NOW^XLFDT,"MP")
 W !,DDASH
 W !,"PATIENT NAME",?20,"PID",?26,"365",?31,"90",?35,"START DATE",?47,"END DATE",?59,"DAYS",?65,"AUTHORIZED BY"
 W !,?26,"PRD",?31,"PRD",?59,"LEFT"
 W !,DDASH
 Q
 ;
PAUSE(DGQ) ; pause screen display
 ; Input: 
 ; DGQ - var used to quit report processing to user CRT
 ; Output:
 ; DGQ - passed by reference - 0 = Continue, 1 = Quit
 ;
 I $G(DGPAGE)>0,TRM K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQ=1
 Q
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"  ;tell TaskMan to delete Task log entry
 I '$D(ZTQUEUED) D
 . I 'TRM,$Y>0 W @IOF
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q
