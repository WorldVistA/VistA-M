DGOTHRP1 ;SLC/RED - OTHD (OTHER THAN HONORABLE DISCHARGE) Reports ;May 9,2018@05:08
 ;;5.3;Registration;**952**;May 9, 2018;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;     Last Edited: SHRPE/RED - June 14, 2019 09:00
 ;
 ;  IA:  10103   ^XLFDT (sup)  - [$$FMADD^XLFDT, $$FMTE^XLFDT , $$NOW^XLFDT]
 ;       10015   ^DIQ    (sup)  - [GETS^DIQ]
 ;       10026    ^DIR   (sup)
 ;       10061    PID^VADPT (sup)
 ;       10063    ^%ZTLOAD (sup)
 ;       10089    ^%ZISC  (sup)
 ;
 Q  ; No Direct access
 ;                                                       Menu text:  Other Than Honorable MH Status Report
EN ;  CALLED BY -  DG OTH MH STATUS REPORT - menu option
 N DGIEN,DGART,DGIEN33,DGINTDT,DGDTEND,DGSTDT,PID,DGINA0,PAGE,EXIT,DASH,DGOUT,DGOTHIST,DGCNT,DGQ,DGRTYP,POP
 S (DGIEN33,DGIEN,DGCNT,DGINTDT,EXIT)=0,PAGE=1
 S DGOUT=$NA(^TMP($J,"DGOTHRP1")) K @DGOUT              ;Set and kill tmp global for report
 S @DGOUT@(0)="DG OTH STATUS REPORT"_U_DT               ; Set print header value
 S PROMPT=" Please select the report you'll like:",SET="S^1:Active;2:Inactive;3:All"
 S DGRTYP=$$SELECT("Select One of the Following:",SET)  ;report type
 I 'Y G EXIT                                            ;quit if no selection
 I Y S DGRTYP=$S(Y=1:"ACTIVE",Y=2:"INACT",1:"ALL")
 D DATESEL                                              ;get date selection for report
 Q:EXIT
 D INADEV
 ;
STAT ; Entry point if Queued
 N DGFAC,DGNAME,DGTYP,OTH90,DFN
 I POP G EXIT
 I $E(IOST)="C" D WAIT^DICD
 K DGARR
 F  S DGIEN33=$O(^DGOTH(33,DGIEN33)) Q:'DGIEN33!(POP)  D
 . K DGART D GETS^DIQ(33,DGIEN33_",",".01;.02;1*;2*","IE","DGART")
 . S OTH90=$$CROSS^DGOTHINQ(DGIEN33,.DGOTHIST)
 . Q:$P(OTH90,U,4)=""                                     ;No history on file
 . I DGRTYP="ACTIVE",$P(OTH90,U,4)=0 Q                    ;Looking for Active, not active OTH Pt, per entry in sub-file #33.02
 . I DGRTYP="ACTIVE",DGART(33,DGIEN33_",",.02,"I")=0 Q    ;Looking for Active, not active patient, per field #.05 in file #33
 . I DGRTYP="INACT",$P(OTH90,U,4)=1 Q                     ;Not an active OTH patient, per PE file history
 . I DGRTYP="INACT",DGART(33,DGIEN33_",",.02,"I")=1 Q     ;Not an active OTH patient, per file 33
 . S DGINTDT=$P(OTH90,U,3),DGTYP=$E($P(OTH90,U,2),1,12)
 . I DGINTDT<DGSTDT!(DGINTDT>DGDTEND) Q
 . S DFN=$$GETPAT^DGOTHD2(DGIEN33)
 . S PID=$$GET1^DIQ(2,DGART(33,DGIEN33_",",.01,"I"),".0905","E")
 . D DEM^VADPT S DGNAME=VADM(1) D KVA^VADPT
 . S DGCNT=0,@DGOUT@(DGNAME)=PID_U_DGINTDT D
 . . N J,DGLINE S J="9999" F  S J=$O(DGOTHIST(DGIEN33,J),-1) Q:J=""  D
 . . . S DGLINE=DGOTHIST(DGIEN33,J),DGCNT=DGCNT+1
 . . . Q:$P(DGLINE,U)=""!($P(DGIEN33,U)["EXPANDED")
 . . . S @DGOUT@(DGNAME,DGCNT)=$S($P(DGLINE,U)="":"N/A",$P(DGLINE,U)["OTH":"EXPANDED MH CARE NON-ENROLLEE",1:$P(DGLINE,U))_U_$S(($P(DGLINE,U)=""!($P(DGLINE,U)'["OTH")):"N/A",1:$P(DGLINE,U))
 . . . S @DGOUT@(DGNAME,DGCNT)=@DGOUT@(DGNAME,DGCNT)_U_$$FMTE^XLFDT($P(DGLINE,U,2),"5Z")
 I $D(@DGOUT@(0))=0 W !,"No patients found for this time frame",! Q
 W # S PAGE=1 D PRTHDR,PRTINA I $E(IOST,1,2)="C-" R !!?8,"End of the Report...Press Enter to Continue",X:DTIME W @IOF
 Q
 ;
PRTHDR ;
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1 Q
 W @IOF,?10,$S(DGRTYP="ALL":"ACTIVE/INACTIVE",DGRTYP="INACT":"INACTIVE",1:DGRTYP)," - Other Than Honorable MH Status Report",?70,"Page: ",PAGE
 W !?16,"Selected date range: ",$$FMTE^XLFDT(DGSTDT,"5Z")," to ",$$FMTE^XLFDT(DGDTEND,"5Z")
 W !,"Patient Name",?25,"PID",?32,"Status",?44,"Status",?55,"Eligibility",!,?32,"Change Dt.",!
 F DASH=1:1:75 W "-"
 Q
PRTINA ;
 N I,J,DGLINE S I=0,(EXIT,J)=0
 F  S I=$O(@DGOUT@(I)) Q:I=""!(EXIT)  D
 . I $Y+4>IOSL D  Q:EXIT           ;screen handler
 . . K DTOUT,DIRUT
 . . I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 . . I $G(DIRUT) S EXIT=1 G EXIT   ;User exited the report
 . . S PAGE=PAGE+1 D PRTHDR
 . W !,$E(I,1,22),?25,$P(@DGOUT@(I),U)
 . N J S J="9999" F  S J=$O(@DGOUT@(I,J),-1) Q:J=""  D
 . . S DGLINE=@DGOUT@(I,J)
 . . Q:$P(DGLINE,U)=""
 . . W ?32,$P(DGLINE,U,3),?44,$S($P(DGLINE,U)["EXPANDED":"Active",1:"Inactive"),?55,$S($P(DGLINE,U,2)["OTH":$P(DGLINE,U,2),1:$E($P(DGLINE,U),1,20)),!
 Q
 ;
DATESEL ;  select starting and ending dates in days
 ;  returns DGSTDT and DGDTEND
 N %,%DT,%H,%I,DEFAULT,X,Y,DESCR
STARTDT S DESCR=""
 S Y=$E(DT,1,5)_"01" D DD^%DT S DEFAULT=Y
 S %DT("A")="Start with "_$S(DESCR'="":DESCR_" ",1:"")_"Date: ",%DT="AEP",%DT(0)=-DT D ^%DT I Y<0,X'="^"  W !?25,"A date is required" G STARTDT
 I X="^" W !!?20,"Exiting as per request" S EXIT=1 Q  ; Variable X contains the actual entry from the User.
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 S DGSTDT=Y
 S Y=DT D DD^%DT S DEFAULT=Y
 S %DT("A")="  End with "_$S(DESCR'="":DESCR_" ",1:"")_"Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 G EXIT
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 I Y<DGSTDT W !,"END DATE MUST BE GREATER THAN OR EQUAL TO THE START DATE.",! G STARTDT
 S DGDTEND=Y,Y=DGSTDT D DD^%DT
 Q
 ;
INADEV ;
 N DIR,DIRUT,Y
 W ! S %ZIS="Q" D ^%ZIS I POP G EXIT
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 . S ZTDESC="Other than Honorable Exception Status report",ZTRTN="STAT^DGOTHRP1"
 . S ZTSAVE("DGSTDT")="",ZTSAVE("DGDTEND")="",ZTSAVE("ZTREQ")="@",ZTSAVE("DGRTYP")=""
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
 Q
 ;
EXIT ;
 K @DGOUT S EXIT=1
 Q
 ;
SELECT(PROMPT,SET) ; prompts for a report type
 ;INPUT:
 S DIR(0)=SET,DIR("A")="Please select report type",DIR("B")=3 D ^DIR K DIR
 Q:Y<0 EXIT
 Q Y
 ;
 ;END OF DGOTHRP1
