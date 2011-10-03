IBNCPBB ;DALOI/AAT - ECME BACKBILLING ;24-JUN-2003
 ;;2.0;INTEGRATED BILLING;**276,347,384**;21-MAR-94;Build 74
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 Q
EN ;[IB GENERATE ECME RX BILLS] entry
 N IBMOD1,IBMOD3,IBPAT,IBRX,IBBDT,IBEDT,IBSEL,IBREF,IBPAUSE
 S IBREF=$NA(^TMP($J,"IBNCPBB"))
 S IBPAUSE=1
 K @IBREF D
 . N IBEXIT
 . S IBEXIT=0
 . D MODE I IBEXIT Q
 . I IBMOD1="P" D SELECT I IBEXIT Q
 . I IBMOD1="R" D SELECT2 I IBEXIT Q
 . D CONFIRM I IBEXIT Q
 . D PROCESS^IBNCPBB1 I IBEXIT Q
 I IBPAUSE W ! D PAUSE()
 K @IBREF
 Q
 ;
CT(IBTRN) ;CT ENTRY
 N IBZ,IBRX,IBRXN,IBFIL,IBEXIT,IBPAT,IBRDT,IBFDT,IBRES,IBBIL,IBBN,IBQ,IBSCRES,IBERR
 S IBQ=0
 D FULL^VALM1
 W !!,"This option sends electronic Pharmacy Claims to the Payer"
 S VALMBCK="R"
 S IBZ=$G(^IBT(356,IBTRN,0)) Q:IBZ=""
 S IBRX=$P(IBZ,U,8),IBFIL=$P(IBZ,U,10)
 I 'IBRX D  Q
 . W !!,"This is not a Pharmacy Claims Tracking record",*7,!
 . D PAUSE("Cannot submit to ECME")
 ;
 ;Release date:
 I IBFIL=0 S IBRDT=$$FILE^IBRXUTL(IBRX,31)
 E  S IBRDT=$$SUBFILE^IBRXUTL(IBRX,IBFIL,52,17)
 I 'IBRDT D  Q
 . W !!,"The Prescription is not released.",!
 . D PAUSE("Cannot submit to ECME")
 ; -- Drug DEA ROI check.
 S IBPAT=$P(IBZ,U,2)
 S IBDRUG=$$FILE^IBRXUTL(IBRX,6)
 ; Fill/Refill Date:
 S IBFDT=$S('IBFIL:$$FILE^IBRXUTL(IBRX,22),1:$$SUBFILE^IBRXUTL(IBRX,IBFIL,52,.01))
 I $$INSUR^IBBAPI(IBPAT,IBFDT,"P",.IBANY,1) S IBINS=+$G(IBANY("IBBAPI","INSUR",1,1)) S IBQ=$$ROICHK^IBNCPDR4(IBPAT,IBDRUG,IBINS,IBFDT) D:IBQ=1 ROICLN^IBNCPDR4(IBTRN) I 'IBQ D PAUSE() Q  ;Requires ROI
 ;
 I $$SC($P(IBZ,U,19)) D  Q:IBQ
 . N DIR,DIE,DA,DR,Y
 . W !!,"The Rx is marked 'non-billable' in CT: ",$P($G(^IBE(356.8,+$P(IBZ,U,19),0)),U)
 . W !,"If you continue, the NON-BILLABLE REASON will be deleted.",!
 . S DIR(0)="Y",DIR("A")="Are you sure you want to bill this episode"
 . S DIR("B")="NO"
 . S DIR("?")="If you want to bill this Rx, enter 'Yes' - otherwise, enter 'No'"
 . W ! D ^DIR K DIR
 . I 'Y S IBQ=1 Q
 . S DIE="^IBT(356,",DA=IBTRN,DR=".19///@" D ^DIE ;clean NB reason
 . S IBSCRES(IBRX,IBFIL)=1 ; sc resolved flag
 ;
 S IBZ=$G(^IBT(356,IBTRN,0)) ; refresh
 I $P(IBZ,U,19) D  Q
 . W !!,"The Prescription is marked 'non-billable' in Claims Tracking",*7
 . W !,"Reason non-billable: ",$P($G(^IBE(356.8,+$P(IBZ,U,19),0),"Unknown"),U),!
 . D PAUSE("Cannot submit to ECME")
 ; Is the patient billable at the released date?
 S IBRES=$$ECMEBIL^IBNCPDPU(IBPAT,IBFDT)
 I 'IBRES D  Q
 . W !!,"The patient is not ECME Billable at the ",$S(IBFIL:"re",1:""),"fill date."
 . W !,"Reason: ",$P(IBRES,U,2,255),!
 . D PAUSE("Cannot submit to ECME")
 ;
 S IBRXN=$$FILE^IBRXUTL(IBRX,.01)
 S IBBIL=$$BILL(IBRXN,IBRDT)
 I IBBIL,'$P($G(^DGCR(399,IBBIL,"S")),U,16) D  Q
 . W !!,"Rx# ",IBRXN," was previously billed."
 . W !,"Please manually cancel the bill# ",$P($G(^DGCR(399,IBBIL,0)),U)," before submitting claim to ECME.",!
 . D PAUSE("Cannot submit to ECME")
 I IBBIL W !,"The bill# ",$P($G(^DGCR(399,IBBIL,0)),U)," has been cancelled.",!
 ;
 D CONFRX(IBRXN) Q:$G(IBEXIT)
 ;
 W !!,"Submitting Rx# ",IBRXN W:IBFIL ", Refill# ",IBFIL W " ..."
 S IBRES=$$SUBMIT^IBNCPDPU(IBRX,IBFIL) W !,"  ",$S(+IBRES=0:"S",1:"Not s")_"ent through ECME."
 I +IBRES'=0 W !,"  *** ECME returned status: ",$$STAT(IBRES),!
 I +IBRES=0 W !!,"The Rx have been submitted to ECME for electronic billing",!
 D PAUSE()
 Q
 ;
MODE ;
 ; IBMOD1: "P"-Single Patient, "R"-Single Rx
 ; IBMOD3 (if IBMOD1="P"): "U"-Unbilled, "A"-All Rx
 ; IBPAT (if IBMOD1="P"): Patient's DFN
 ; IBBDT,IBEDT (if IBMOD1="P"): From/To dates inclusive
 N DIR,DIC,DIRUT,DUOUT,Y,PSOFILE
 S (IBMOD1,IBMOD3)=""
 S DIR(0)="S^P:SINGLE (P)ATIENT;R:SINGLE (R)X"
 S DIR("A")="SINGLE (P)ATIENT, SINGLE (R)X"
 S DIR("B")="P"
 D ^DIR K DIR I $D(DIRUT) S IBEXIT=1,IBPAUSE=0 Q
 S IBMOD1=Y
 ; Enter Rx
 I IBMOD1="R" W ! S PSOFILE=52,DIC="^PSRX(",DIC(0)="AEQMN" D DIC^PSODI(PSOFILE,.DIC) S:$D(DUOUT) IBEXIT=1 S IBRX=$S(Y>0:+Y,1:0) S:'IBRX IBEXIT=1,IBPAUSE=0
 K PSODIY
 I IBMOD1="R" Q
 ;
 I IBMOD1'="P" W !,"???" S IBEXIT=1 Q  ; Invalid mode
 ;Enter Patient
 S DIC="^DPT(",DIC(0)="AEQMN" D ^DIC S:$D(DUOUT) IBEXIT=1 S IBPAT=$S(Y>0:+Y,1:0) S:'IBPAT IBEXIT=1,IBPAUSE=0
 Q:IBEXIT
 I '$$ECMEBIL^IBNCPDPU(IBPAT,DT) W *7,!!,"Warning! The patient is currently not ECME billable!"
 ;
 D DATE I IBEXIT S IBPAUSE=0 Q
 ;
 S DIR(0)="S^U:UNBILLED;A:ALL RX"
 S DIR("A")="(U)NBILLED, (A)LL RX"
 S DIR("B")="U"
 D ^DIR K DIR I $D(DIRUT) S IBEXIT=1,IBPAUSE=0 Q
 S IBMOD3=Y
 Q
 ;
 ;begin/end date
DATE ;
 N Y,%DT
 S (IBBDT,IBEDT)=DT
 W !
 S %DT="AEX"
 S %DT("A")="START WITH DATE: ",%DT("B")="TODAY"
 D ^%DT K %DT
 I Y'>0 S IBEXIT=1 Q
 S IBBDT=+Y
 S %DT="AEX"
 S %DT("A")="GO TO DATE: ",%DT("B")="TODAY" ;$$DAT2^IBOUTL(IBBDT)
 D ^%DT K %DT
 I Y'>0 S IBEXIT=1 Q
 S IBEDT=+Y
 Q
 ;
SELECT ;Select from patient's list
 ; (IBPAT,IBBDT,IBEDT,IBMOD3)
 N IBD,IBRX,IBZ,IBDATA,IBCNT,Y,PDFN,LIST,LIST2,NODE,RXNUMEXT,LIST,IBDATE,CNT1,CNT2,RFNUM
 S CNT1=0,CNT2=0,IBCNT=0
 S LIST="IBRXSELARR"
 S NODE=2
 D RX^PSO52API(IBPAT,LIST,,,NODE,,)
 S RXNUMEXT=0 F  S RXNUMEXT=$O(^TMP($J,LIST,"B",RXNUMEXT)) Q:'RXNUMEXT  D
 . S IBRX=0 F  S IBRX=$O(^TMP($J,LIST,"B",RXNUMEXT,IBRX)) Q:'IBRX  D
 .. S IBDATE=$P(^TMP($J,LIST,IBPAT,IBRX,31),"^",1)
 .. I (IBDATE>IBBDT)&(IBDATE<IBEDT) D
 ... S IBZ=$$RXZERO^IBRXUTL(IBPAT,IBRX) Q:IBZ=""
 ... I $P(IBZ,U,2)'=IBPAT Q
 ... I '$$FILE^IBRXUTL(IBRX,31) Q  ; not released
 ... S IBDATA=$$RXDATA(IBRX,0)
 ... I ('$P(IBDATA,U,6))!(IBMOD3="A") S IBCNT=IBCNT+1,@IBREF@(IBCNT)=IBDATA
 ... S LIST2="IBCPBBRF"
 ... S NODE="R"
 ... D RX^PSO52API(IBPAT,LIST2,IBRX,,NODE,,)
 ... S RFNUM=0 F  S RFNUM=$O(^TMP($J,LIST2,IBPAT,IBRX,"RF",RFNUM)) Q:RFNUM'>0  D:$$SUBFILE^IBRXUTL(IBRX,RFNUM,52,17)
 .... S IBDATA=$$RXDATA(IBRX,RFNUM)
 .... I $P(IBDATA,U,6),IBMOD3'="A" Q  ; unbilled only
 .... S IBCNT=IBCNT+1,@IBREF@(IBCNT)=IBDATA
 ... K ^TMP($J,LIST2)
 K ^TMP($J,LIST)
 D MKCHOICE
 Q
SELECT2 ;Select from Rx list
 ; (IBRX)
 N IBCNT,Y,PDFN,RIFN,LST
 S RIFN=0
 W ! S IBPAUSE=1
 S PDFN=$$FILE^IBRXUTL(IBRX,2)
 S LST="SEL2LST"
 I $$RXZERO^IBRXUTL(PDFN,IBRX)="" W !,"The Rx does not exist. Please try again." S IBEXIT=1 Q
 I $$FILE^IBRXUTL(IBRX,31)="" W !,"The Rx has not been released. Please try again." S IBEXIT=1 Q
 S IBCNT=1,@IBREF@(IBCNT)=$$RXDATA(IBRX,0)
 D RX^PSO52API(PDFN,LST,IBRX,,"R",,)
 S RIFN=0 F  S RIFN=$O(^TMP($J,LST,PDFN,IBRX,"RF",RIFN)) Q:RIFN'>0  D:$$SUBFILE^IBRXUTL(IBRX,RIFN,52,17)
 .S IBCNT=IBCNT+1,@IBREF@(IBCNT)=$$RXDATA(IBRX,RIFN)
 K ^TMP($J,LST)
 D MKCHOICE
 Q
 ;
MKCHOICE ;
 N Y
 W !
 S Y=0 F  S Y=$O(@IBREF@(Y)) Q:'Y  D DISP(Y)
 ;
 I $O(@IBREF@(0))="" S IBEXIT=1 W !!," No Rxs meet the entered criteria. Please try again." Q
 I $O(@IBREF@(""),-1)=1 S IBSEL(1)="" Q  ; one item only
 F  W !!,"Enter Line Item(s) to submit to ECME or (A)LL :" R IBSEL:DTIME S:'$T IBEXIT=1 Q:IBEXIT  Q:IBSEL'["?"  D
 . W !?10,"Enter number(s) or item range(s) separated by comma."
 . W !?10,"Example: 1,3,7-11"
 Q:IBEXIT
 I IBSEL'="",$TR(IBSEL,"al","AL")=$E("ALL",1,$L(IBSEL)),$L(IBSEL)<3 W $E("ALL",$L(IBSEL)+1,3) S IBSEL="ALL"
 I IBSEL="" S IBEXIT=1 W " Nothing selected" Q
 I IBSEL="^" S IBEXIT=1 W " Cancelled" Q
 ;Collect the required into the IBSEL(i) local array
 D PARSE(.IBSEL)
 I $O(IBSEL(0))="" S IBEXIT=1 W !!,"No item(s) match the selection." Q
 Q
 ;
CONFIRM ;
 N DIR,Y
 W !
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Submit the selected RX(s) to ECME for electronic billing"
 D ^DIR I Y'=1 S IBEXIT=1
 Q
 ;
CONFRX(IBRX) ;
 N DIR,Y
 W !
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Submit the Rx# "_IBRX_" to ECME for electronic billing"
 D ^DIR I Y'=1 S IBEXIT=1
 Q
 ;
STAT(X) ;
 I +X<6 Q $P(X,"^",2)
 Q "Unknown Status"
 ;
BILL(IBRXN,IBDT) ;Bill IEN (if any) or null
 N RES,X,IBZ
 S IBDT=$P(IBDT,".")
 S RES=""
 S X="" F  S X=$O(^IBA(362.4,"B",IBRXN,X),-1) Q:X=""  D:X  Q:RES
 . S IBZ=$G(^IBA(362.4,X,0))
 . I $P($P(IBZ,U,3),".")=IBDT,$P(IBZ,U,2) S RES=+$P(IBZ,U,2)
 Q RES
 ;
 ;
RXDATA(IBRX,IBFIL) ;
 ;RxIEN^Rx#^Fill#^RelDate^DrugIEN^BillIEN
 N IBRXN,IBDT,IBDRUG,IBBIL,DATRET
 S IBRXN=$$FILE^IBRXUTL(IBRX,.01)
 I IBFIL=0 S IBDT=$$FILE^IBRXUTL(IBRX,22)
 E  S IBDT=$$SUBFILE^IBRXUTL(IBRX,IBFIL,52,.01)
 S IBDT=$P(IBDT,".")
 S IBDRUG=$$FILE^IBRXUTL(IBRX,6)
 S IBBIL=$$BILL(IBRXN,IBDT)
 S DATRET=IBRX_"^"_IBRXN_"^"_IBFIL_"^"_IBDT_"^"_IBDRUG_"^"_IBBIL
 Q DATRET
 ;
DISP(IBITEM) ;
 N IBD,IBBILN,IBDRUG,IBBIL
 S IBD=$G(@IBREF@(IBITEM)) Q:IBD=""
 W !,IBITEM," ",?4,$P(IBD,U,2)," ",?15,$P(IBD,U,3)," ",?20,$$DAT2^IBOUTL($P(IBD,U,4))," "
 W ?32,$E($$DRUG^IBRXUTL1(+$P(IBD,U,5)),1,30)
 S IBBIL=$P(IBD,U,6)
 I IBBIL W ?64,$P($G(^DGCR(399,+IBBIL,0)),U) I $P($G(^DGCR(399,IBBIL,"S")),U,16) W "(canc)"
 Q
 ;
PARSE(X) ;
 N I,J,N
 S X=$TR(X," ")
 S X=$TR(X,";",",")
 I $TR(IBSEL,"al","AL")="ALL" D  Q
 . F I=1:1 Q:'$D(@IBREF@(I))  S IBSEL(I)=""
 F I=1:1:$L(X,",") S N=$P(X,",",I) D:N'=""
 . I N'["-" D:N  Q
 . . I $D(@IBREF@(N)) S X(N)=""
 . ; Processing range
 . N N1,N2
 . S N1=+$P(N,"-",1),N2=+$P(N,"-",2)
 . F J=N1:$S(N2<N1:-1,1:1):N2 I $D(@IBREF@(J)) S X(J)=""
 Q
 ;
PAUSE(MESSAGE) ;
 D EN^DDIOL("","","!")
 I $G(MESSAGE)'="" D EN^DDIOL(MESSAGE) D EN^DDIOL(". ","","?0")
 D EN^DDIOL("Press RETURN to continue: ")
 R %:DTIME
 Q
 ;
SC(IEN) ;Service connected
 N IBT
 I 'IEN Q 0
 S IBT=$P($G(^IBE(356.8,IEN,0)),U)
 I IBT="NEEDS SC DETERMINATION" Q 1
 I IBT="OTHER" Q 1
 Q 0
 ;
 ;IBNCPBB
