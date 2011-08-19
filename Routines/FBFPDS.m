FBFPDS ;WCIOFO/SAB-REPORT OF VENDORS WITHOUT FPDS DATA ;9/15/97
 ;;3.5;FEE BASIS;**9**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ; entry point
 ;
 S DIR(0)="Y",DIR("A")="Only check FPDS data for active vendors"
 S DIR("B")="YES"
 S DIR("?",1)="Enter YES if only active vendors should be checked for"
 S DIR("?",2)="missing FPDS data. A vendor is considered active if there"
 S DIR("?",3)="has been a treatment/invoice after a user-specified date."
 S DIR("?",4)=" "
 S DIR("?")="Enter either 'Y' or 'N'."
 D ^DIR K DIR G:$D(DIRUT) EXIT S FBACT=Y
 I FBACT D  G:$D(DIRUT) EXIT
 . S DIR(0)="D",DIR("A")="Consider vendor active when activity since"
 . S DIR("B")=$$FMTE^XLFDT($E($$FMADD^XLFDT(DT,-540),1,5)_"01")
 . D ^DIR K DIR Q:$D(DIRUT)  S FBACT("D")=Y
 ;
 S DIR(0)="Y",DIR("A")="Print detailed vendor demographic data"
 S DIR("B")="NO"
 D ^DIR K DIR G:$D(DIRUT) EXIT S FBVD=Y
 ;
 S VAR="FBACT^FBACT(^FBVD",PGM="QEN^FBFPDS" D ZIS^FBAAUTL G:FBPOP EXIT
 ;
QEN ; queued entry point
 U IO
 S FBOUT=0
 ; gather/sort data
 K ^TMP($J)
 S (FBIEN,FBT)=0 F  S FBIEN=$O(^FBAAV(FBIEN)) Q:'FBIEN  D  Q:FBOUT
 . S FBT=FBT+1
 . I '(FBT#100) W:$E(IOST,1,2)="C-" "." I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBOUT=1 Q
 . S FBBT=$P($G(^FBAAV(FBIEN,1)),U,10)
 . I FBBT]"" Q  ; FPDS Data exists *** groups? $O(^FBAAV(FBIEN,2,0))
 . ; processing vendors with blank FPDS data
 . Q:$P($G(^FBAAV(FBIEN,"ADEL")),U)="Y"  ; Austin Deleted: Don't report.
 . I FBACT D  Q:'FBVENACT  ; if user just asked for active vendors
 . . S FBVENACT=0 ; init vendor active flag
 . . ; is vendor active in Outpatient Medical
 . . S FBX=$O(^FBAAC("AX",FBIEN,0))
 . . S FBX("D")=$S(FBX:9999999.9999-FBX,1:"") ; treatment date
 . . I FBX("D")'<FBACT("D") S FBVENACT=1 Q  ; active medical vendor
 . . ; or is vendor active in Pharmacy
 . . S FBI=$O(^FBAA(162.1,"AN",FBIEN," "),-1) ; highest ien for vendor
 . . S FBX("D")=$S(FBI:$P($G(^FBAA(162.1,FBI,0)),U,2),1:"") ;invoice date
 . . I FBX("D")'<FBACT("D") S FBVENACT=1 Q  ; active pharmacy vendor
 . . ; or is vendor active in Inpatient
 . . S FBX=$O(^FBAAI("AF",FBIEN,0))
 . . S FBX("D")=$S(FBX:9999999.9999-FBX,1:"") ; invoice date
 . . I FBX("D")'<FBACT("D") S FBVENACT=1 Q  ; active inpatient vendor
 . ; save vendor in list
 . S FBNAME=$P($G(^FBAAV(FBIEN,0)),U) S:FBNAME="" FBNAME="UNKNOWN"
 . S ^TMP($J,FBNAME,FBIEN)=""
 ;
 ; print data
 S $P(FBDASH,"=",80)="",$P(FBDASH1,"-",80)="",FBPG=0
 S FBDTR=$$FMTE^XLFDT($$NOW^XLFDT())
 D HD
 S FBT=0
 S FBNAME="" F  S FBNAME=$O(^TMP($J,FBNAME)) Q:FBNAME=""  D  Q:FBOUT
 . S FBIEN=0 F  S FBIEN=$O(^TMP($J,FBNAME,FBIEN)) Q:'FBIEN  D  Q:FBOUT
 . . S FBT=FBT+1
 . . S FBY(0)=$G(^FBAAV(FBIEN,0))
 . . S FBNAME=$S($P(FBY(0),U)]"":$P(FBY(0),U),1:"UNKNOWN")
 . . S FBID=$S($P(FBY(0),U,2)]"":$P(FBY(0),U,2),1:"UNKNOWN")
 . . I 'FBVD D:$Y+6>IOSL HD Q:FBOUT  W !,FBNAME,?50,"ID: ",FBID Q
 . . ;
 . . I $Y+17>IOSL D HD Q:FBOUT
 . . F FBX=1,"ADEL","AMS" S FBY(FBX)=$G(^FBAAV(FBIEN,FBX))
 . . W !!,$J("Name:",13),?15,$E(FBNAME,1,30),?48,"ID Number: ",FBID
 . . I $P(FBY("ADEL"),U)="Y" W !?19,"==> FLAGGED FOR DELETION <=="
 . . E  I $$CKVEN^FBAADV(FBIEN) W !?20,"==> AWAITING AUSTIN APPROVAL <=="
 . . W !,$J("Address:",13),?15,$P(FBY(0),U,3)
 . . W ?48,"Specialty: ",$E($$GET1^DIQ(161.2,FBIEN,.05),1,20)
 . . I $P(FBY(0),U,14)]"" W !,$J("Address [2]:",13),?15,$P(FBY(0),U,14)
 . . W !,$J("City:",13),?15,$P(FBY(0),U,4)
 . . W ?53,"Type:",?59,$$EXTERNAL^DILFD(161.2,6,"",$P(FBY(0),U,7))
 . . W !,$J("State:",13),?15,$$GET1^DIQ(161.2,FBIEN,4)
 . . S FBX=$$GET1^DIQ(161.2,FBIEN,7)
 . . W ?39,"Participation Code:",?59,$S(FBX]"":$E(FBX,1,21),1:"UNKNOWN")
 . . W !,$J("ZIP:",13),?15,$P(FBY(0),U,6)
 . . W ?39,"Medicare ID Number:",?59,$P(FBY(0),U,17)
 . . W !,$J("County:",13),?15,$$GET1^DIQ(161.2,FBIEN,5.5)
 . . W ?52,"Chain: ",$P(FBY(0),U,10)
 . . W !,$J("Phone:",13),?15,$P(FBY(1),U)
 . . W !,$J("Fax:",13),?15,$P(FBY(1),U,9)
 . . W:$P(FBY("AMS"),U,2)="Y" ?44,"Pricer Exempt: Yes"
 . . W !,$J("Type (FPDS):",13)
 . . W ?15,$$EXTERNAL^DILFD(161.2,24,"",$P(FBY(1),U,10))
 . . S (FBC,FBI)=0 F  S FBI=$O(^FBAAV(FBIEN,2,FBI)) Q:'FBI  D
 . . . S FBX=$P($G(^FBAAV(FBIEN,2,FBI,0)),U) Q:'FBX
 . . . S FBX=$$GET1^DIQ(420.6,FBX,1) Q:FBX=""
 . . . S FBC=FBC+1
 . . . I '(FBC#2) W !,$J("Group (FPDS):",13),?15,$E(FBX,1,21)
 . . . I (FBC#2) W ?45,"Group (FPDS):",?59,$E(FBX,1,21)
 . . W !,$J("Austin Name:",13),?15,$P(FBY("AMS"),U)
 . . W !,$J("Last Change ",13),?44,"Last Change"
 . . I $P(FBY("ADEL"),U,5)]"" W " by ",$S($P(FBY("ADEL"),U,5)="000":"Non-Fee User",1:"Station "_$P(FBY("ADEL"),U,5))
 . . W !,$J("TO Austin:",13),?15,$$DATX^FBAAUTL($P(FBY("ADEL"),U,2))
 . . W ?46,"FROM Austin:  ",$$DATX^FBAAUTL($P(FBY("ADEL"),U,4))
 ;
 I FBOUT W !!,"JOB STOPPED AT USER REQUEST"
 I 'FBOUT W !!,"TOTAL number of vendors missing FPDS data: ",FBT
 I 'FBOUT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J),DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K FBDASH,FBDASH1,FBDTR,FBPG,FBOUT,FBPOP
 K FBACT,FBBT,FBC,FBI,FBID,FBIEN,FBNAME,FBT,FBVD,FBVENACT,FBX,FBY
 Q
 ;
HD ; header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBOUT=1 Q
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBOUT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF
 S FBPG=FBPG+1
 W !,"FEE BASIS VENDOR'S WITH BLANK FPDS DATA",?49,FBDTR,?72,"page ",FBPG
 I $G(FBACT) W !,"of those with activity since ",$$FMTE^XLFDT(FBACT("D"))
 W !,FBDASH
 Q
