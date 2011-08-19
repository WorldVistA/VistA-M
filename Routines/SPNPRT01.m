SPNPRT01 ;HIRMFO/WAA- PRINT Mailing Labels ; 8/21/96
 ;;2.0;Spinal Cord Dysfunction;**11,15**;01/02/1997
 ;This routine is to store mailing labels into a file.
 ; 
EN1 ; Main Entry Point
 N SPNLEXIT,SPNIO,SPNPAGE S SPNPAGE=1
 S SPNLEXIT=0 D EN1^SPNPRTMT Q:SPNLEXIT  ;Filters
 S ZTSAVE("SPN*")=""
 D DEVICE^SPNPRTMT("PRINT^SPNPRT01","SCD Mailing Labels",.ZTSAVE) Q:SPNLEXIT
 I SPNIO="Q" D EXIT Q  ; Print was Queued
 I IO'="" D PRINT D EXIT Q  ; Print was not Queued
 Q
EXIT ; Exit routine
 K SPNLEXIT,SPNIO,SPNPAGE
 K ^TMP($J,"SPN"),^TMP($J,"SPNPRT","AUTO"),^TMP($J,"SPNPRT","POST")
 Q
PRINT ; Print main Body
 U IO
 S SPNLEXIT=$G(SPNLEXIT) ; Ensure that exit is set; **MOD CM/SD ,0
 N SPNDFN,SPNX
 I $E(IOST,1)="C" D  Q:SPNLEXIT
 .W !,"Prepare to capture list: Hit return when you are ready: "
 .W !,"When you see ---END--- Close the capture file and hit return."
 .R !,SPNX:DTIME I '$T S SPNX="^"
 .I SPNX="^" S SPNLEXIT=1 Q
 .Q
 ;W "NAME,ADDRESS1,ADDRESS2,ADDRESS3,CITY,STATE,ZIPCODE"
 W "FNAME,LNAME,ADDRESS1,ADDRESS2,ADDRESS3,CITY,STATE,ZIPCODE"
 S (SPNDFN,SPNLPRT)=0
 F  S SPNDFN=$O(^SPNL(154,SPNDFN)) Q:SPNDFN<1  D  Q:SPNLEXIT
 . N LINE,SPNPRT
 . S SPNPRT=0
 . Q:SPNLEXIT
 . Q:$G(^SPNL(154,SPNDFN,0))=""  ; No Zero node
 . I $L($$GET1^DIQ(2,SPNDFN_",",.351)) Q  ;Patient has passed on WDE
 . Q:$P(^SPNL(154,SPNDFN,0),"^",3)="X"  ; **MOD CM/SD No expired pts
 . I '$$EN2^SPNPRTMT(SPNDFN) Q  ; Patient fail the filters
 . S SPNLPRT=1 ; Indicates the report had data
 . S DFN=SPNDFN D ^VADPT
 . ;S LINE=""_$P(VADM(1),",",2)_" "_$P(VADM(1),",",1)_"" ; **MOD CM/SD
 . S LINE=""_$P($P(VADM(1),",",2)," ",1)_"" ; first name
 . S LINE=LINE_","_$P(VADM(1),",",1) ; last name
 . S DFN=SPNDFN D ADD^VADPT
 . I VAPA(1)=""!(VAPA(4)="")!($P(VAPA(5),U,2)="")!(VAPA(6)="") S SPNPRT=1
 . F I=1:1:4 D
 .. S:VAPA(I)["," VAPA(I)=""""_VAPA(I)_""""
 .. S LINE=LINE_","_VAPA(I)
 .. Q
 . S LINE=$S($P(VAPA(5),U,1)'="":LINE_","_$P($G(^DIC(5,$P(VAPA(5),U,1),0)),U,2),1:LINE_","_"UNKNOWN") ; **MOD CM/SD STATE
 . S LINE=LINE_","_VAPA(6)
 . I 'SPNPRT W !,LINE
 . D KVAR^VADPT
 . Q
 I 'SPNLPRT W !,"     ******* No Data for this report. *******"
 I $E(IOST,1)="C" D
 .R !,"---END---",SPNX:DTIME
 .Q
 D CLOSE^SPNPRTMT
 Q
HEAD ; Header Print
 I SPNPAGE'=1 Q:$Y<(IOSL-4)
 I $E(IOST,1)="C" D  Q:SPNLEXIT
 .I SPNPAGE=1 W @IOF Q
 .I SPNPAGE'=1 D  Q:SPNLEXIT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S SPNLEXIT=1
 ..K Y
 ..Q
 .Q
 Q:SPNLEXIT
 I SPNPAGE'=1 W @IOF
 S SPNPAGE=SPNPAGE+1
 I $D(ZTQUEUED) S:$$STPCK^SPNPRTMT SPNLEXIT=1
 Q
