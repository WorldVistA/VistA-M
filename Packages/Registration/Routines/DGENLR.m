DGENLR ;ALB/RMO - Patient Enrollment - Reader Utilities;26 JUN 1997 10:00 am
 ;;5.3;Registration;**121**;Aug 13, 1993
 ;
EN(DGNOD0,DGSUB,DGSELY) ;select entities from secondary list
 ; Input  -- DGNOD0   Selection in XQORNOD0 format
 ;           DGSUB    Secondary list subscript
 ; Output -- DGSELY   Selection array
 N DGCNT
 ;
 ;
 ;Initialize counter
 S DGCNT=+$G(^TMP("DGENIDX",$J,DGSUB,0))
 ;
 ;Exit if no entries to select
 I 'DGCNT D  G ENQ
 . I $P(DGNOD0,"^",4)["=" D
 . . W !,*7,">>> There are no items to select."
 . . S DGSELY("ERR")=""
 . . D PAUSE^VALM1
 ;
 ;Set selection array if only one entry
 I DGCNT,DGCNT=1,$P($P(DGNOD0,U,4),"=",2)="" S DGSELY(1)="" G ENQ
 ;
 ;determine if display area shows the history - if not, redisplay
 ;begining at the top of history
 I DGCNT D
 .N TOP
 .S TOP=+$O(^TMP("DGENIDX",$J,"EH",1,0))
 .I (VALMLST<TOP) D SETTOP(TOP-3)
 ;
 ;Process secondary selection list
 D SEL(DGNOD0,DGSUB,.DGSELY)
ENQ Q
 ;
SEL(DGNOD0,DGSUB,DGSELY) ;Process secondary list selection
 ; Input  -- DGNOD0   Selection in XQORNOD0 format
 ;           DGSUB    Secondary list subscript
 ; Output -- DGSELY   Selection array
 N I,DGBEG,DGEND,DGERR,X,Y
 ;
 ;Set begin and end, exit if no entries
 S DGBEG=1,DGEND=+$G(^TMP("DGENIDX",$J,DGSUB,0)) G SELQ:'DGEND
 ;
 ;Process pre-answers from user
 S Y=$$PARSE^VALM2(DGNOD0,DGBEG,DGEND)
 ;
 ;Ask user to select entries
 I 'Y S Y=$$ASK(DGCNT)
 ;
 ;Exit if timeout, '^' or no selection
 I 'Y S DGSELY("^")="" G SELQ
 ;
 ;Check for valid entries
 S DGERR=0
 F I=1:1 S X=$P(Y,",",I) Q:'X  D
 . I '$O(^TMP("DGENIDX",$J,DGSUB,X,0))!(X<DGBEG)!(X>DGEND) D
 . . W !,*7,">>> Selection '",X,"' is not a valid choice."
 . . S DGERR=1
 I DGERR S DGSELY("ERR")="" D PAUSE^VALM1 G SELQ
 ;
 ;Set selection array
 F I=1:1 S X=$P(Y,",",I) Q:'X  S DGSELY(X)=""
SELQ Q
 ;
ASK(DGCNT) ;Ask user to select from list
 ; Input  -- DGCNT    Number of entities
 ; Output -- Selection
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,LAST
 S LAST=$$LAST(DGCNT)
 S DIR("A")="Select Enrollment(s)"
 S DIR(0)="L"_U_"1"_":"_$S(LAST:LAST,1:DGCNT)
 D ^DIR I $D(DTOUT)!($D(DUOUT)) S Y="^" G ASKQ
ASKQ Q $G(Y)
 ;
LAST(DGCNT) ;
 ;determines number of last history item showing on the secondary
 ;list
 ;
 N LINE,ITEM
 ;
 ;if the end of the list is displayed, return DGCNT as the last item displayed
 Q:($O(^TMP("DGENIDX",$J,"EH",+DGCNT,0))'>VALMLST) DGCNT
 ;
 ;otherwise, must determine last item displayed
 S ITEM=0
 F  S ITEM=$O(^TMP("DGENIDX",$J,"EH",ITEM)) Q:'ITEM  S LINE=$O(^(ITEM,0)) I LINE=VALMLST Q
 Q +ITEM
 ;
SETTOP(TOP) ;
 ;sets top of screen to line=TOP and redisplays it
 ;
 N LINE
 S VALMLST=TOP+(VALMLST-VALMBG)
 S:(VALMLST>VALMCNT) VALMLST=VALMCNT
 S VALMBG=TOP
 F LINE=VALMBG:1:(VALMBG+15-1) D
 .I LINE'>VALMLST D WRITE^VALM10(LINE)
 .I LINE>VALMLST D SET^VALM10(LINE," "),WRITE^VALM10(LINE)
 Q
