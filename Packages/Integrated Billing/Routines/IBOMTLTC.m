IBOMTLTC ;OAKOIFO/ELZ-MT/LTC COPAY REMOTE QUERY ;20-AUG-2002
 ;;2.0;INTEGRATED BILLING;**188**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
QUERY ; main entry point for user to request a query of mt and ltc copay info
 ;
 N IBBDT,IBEDT,DIC,DFN,X,Y,IBT,DIR,DTOUT,DUOUT,DIRUT,DIROUT,IBICN,IBTFL,%ZIS,ZTDESC,ZTREQ,ZTRTN,ZTSAVE,POP
 ;
 S DIC="^DPT(",DIC(0)="AEMNQ" D ^DIC Q:Y<1  S DFN=+Y
 ;
 D DATE^IBOUTL Q:IBEDT<1
 ;
 S IBT=$$TFL^IBARXMU(DFN,.IBTFL)
 S IBICN=$$ICN^IBARXMU(DFN) I 'IBICN,IBT W !,"There is no ICN for this patient." K IBTFL S IBT=0
 ;
 I IBT W !,"This patient has remote facilities." S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to perform remote queries" D ^DIR Q:$D(DIRUT)  I 'Y S IBT=0
 ;
 I 'IBT W !!,"Performing query locally only" W:$D(IBTFL)>9 "." I $D(IBTFL)<10 W ", the patient has no remote facilities."
 ;
 S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQ^IBOMTLTC",ZTDESC="MT/LTC COPAY REMOTE QUERY"
 . S (ZTSAVE("DFN"),ZTSAVE("IB*"))="" D ^%ZTLOAD,HOME^%ZIS K IO("Q")
 ;
DQ ; tasked entry point
 N IBS,IBX,IBH,IBQ,IBC,IBP,IBHERE
 K ^TMP("IBOMTLTC",$J)
 ;
 ; data will be gathered in ^tmp("ibomtltc",$j,site,n) nodes in final
 ; output format. (where site is the internal value from file 4 locally)
 ;
 S IBS=+$$SITE^VASITE ; store the internal value for file 4
 D DEM^VADPT
 ;
 ; send off queries (if needed)
 I IBT S IBX=0 F  S IBX=$O(IBTFL(IBX)) Q:IBX<1  D
 . ;
 . W:'$D(ZTQUEUED) !,"Now sending query to ",$P(IBTFL(IBX),"^",2)," ..."
 . D EN1^XWB2HL7(.IBH,+IBTFL(IBX),"IBO MT LTC COPAY QUERY","",IBICN,"",IBBDT,IBEDT)
 . I $G(IBH(0))="" S IBR="-1^No handle returned from RPC" Q
 . S $P(IBTFL(IBX),"^",3)=IBH(0) ; save handle for later.
 ;
 ; now while waiting for remote stuff, let's do local stuff.
 D RETURN($NA(^TMP("IBOMTLTC",$J,IBS)),"",DFN,IBBDT,IBEDT)
 ;
 ; now lets look for the remote data
 I IBT S IBX=0 F  S IBX=$O(IBTFL(IBX)) Q:IBX<1  D
 . ;
 . F IBC=1:1:10 D RPCCHK^XWB2HL7(.IBR,$P(IBTFL(IBX),"^",3)) Q:$G(IBR(0))["Done"  H 2
 . ; if done get data.
 . I $G(IBR(0))["Done" D
 .. K IBR,IBHERE
 .. D RTNDATA^XWBDRPC(.IBHERE,$P(IBTFL(IBX),"^",3))
 .. I $D(IBHERE)>10 M ^TMP("IBOMTLTC",$J,+$$LKUP^XUAF4(+IBTFL(IBX)))=IBHERE
 .. E  M ^TMP("IBOMTLTC",$J,+$$LKUP^XUAF4(+IBTFL(IBX)))=^TMP($J,"XWB") K ^TMP($J,"XWB")
 .. D CLEAR^XWBDRPC(.IBZ,$P(IBTFL(IBX),"^",3))
 . E  S ^TMP("IBOMTLTC",$J,+$$LKUP^XUAF4(+IBTFL(IBX)),0)="Unable to get remote information from this site."
 ;
 ; now that I have the info, time to print
 ;
 U IO S (IBQ,IBP)=0
 S IBS=0 F  S IBS=$O(^TMP("IBOMTLTC",$J,IBS)) Q:IBS<1!(IBQ)  D
 . S IBS(0)=$$NNT^XUAF4(IBS)
 . D PAUSE(1)
 . S IBX=-1 F  S IBX=$O(^TMP("IBOMTLTC",$J,IBS,IBX)) Q:IBX=""!(IBQ)  W !,^(IBX) D PAUSE()
 ;
 I 'IBQ,$E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR
 ;
 D ^%ZISC
 ;
 K ^TMP("IBOMTLTC",$J) D KVAR^VADPT
 S:$D(ZTQUEUED) ZTREQ="@"
 ;
 Q
 ;
PAUSE(IBNEW) ;
 ; IBNEW = optional variable, it is a flag for new site
 ;
 N DIR,DIRUT,DIROUT,DTOUT,X,Y
 I IBQ Q
 I $Y+6<IOSL,IBP,'$D(IBNEW) Q
 I IBP,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR I $D(DIRUT) S IBQ=1 Q
 S IBP=IBP+1
 W @IOF,!,"MT and LTC Copay Information ",$$FMTE^XLFDT(IBBDT)," to ",$$FMTE^XLFDT(IBEDT),?IOM-15,"Page: ",IBP
 W !,"Patient:  ",VADM(1)," (",$P(VADM(2),"-",3),")  For Site:  ",$P(IBS(0),"^")," (",$P(IBS(0),"^",2),")",!
 F X=1:1:IOM W "-"
 Q
 ;
RETURN(IBR,IBICN,DFN,IBBDT,IBEDT) ;
 ; this is called from the main query for local data and from the remote
 ; procedure IBO MT LTC COPAY QUERY for remote data.  The return is
 ; in a global array.
 ; if DFN then that will be used to identify the patient
 ; if no DFN, then the ICN (ibicn) needs to be there to identify patient
 ;
 N IBA,IBX,IBT,IBZ,IBL,IBS,IBF,IBFRDT,Y,Y1,IBD,IBSTAT,IBTYP,IBAX,IBCHG
 ;
 I '$D(IBR) S IBR=$NA(^TMP("IBOMTLTC",$J))
 ;
 S IBL=0
 I '$G(DFN) S DFN=+$$DFN^IBARXMU($G(IBICN)) I 'DFN S @IBR@(1)="-1^Patient not found" Q
 ;
 ; look for MT clocks and get info
 S IBX=0 F  S IBX=$O(^IBE(351,"C",DFN,IBX)) Q:'IBX  D
 . S IBZ=^IBE(351,IBX,0)
 . I '$P(IBZ,"^",10) S $P(IBZ,"^",10)=$$FMADD^XLFDT($P(IBZ,"^",3),364)
 . I $P(IBZ,"^",3)>IBEDT!($P(IBZ,"^",10)<IBBDT) Q
 . D GETS^DIQ(351,IBX,".03:.1","ENR","IBT")
 ;
 ; look for LTC clocks and get info
 S IBX=0 F  S IBX=$O(^IBA(351.81,"C",DFN,IBX)) Q:'IBX  D
 . S IBZ=^IBA(351.81,IBX,0)
 . I $P(IBZ,"^",3)>IBEDT,$P(IBZ,"^",4)>IBBDT Q
 . D GETS^DIQ(351.81,IBX,".03:.06","ENR","IBT")
 . ; get the free days (store in date order with a "[" flag)
 . S IBF=0 F  S IBF=$O(^IBA(351.81,IBX,1,IBF)) Q:IBF<1  S IBFRDT=$P(^IBA(351.81,IBX,1,IBF,0),"^",2),IBT(351.81,IBX_",","["_IBFRDT_"EXEMPT DATE","E")=$$FMTE^XLFDT(IBFRDT)
 ;
 ; move the data to return area
 F IBF=351,351.81,351.811 S IBX="" F  S IBX=$O(IBT(IBF,IBX)) Q:IBX=""  D SPACE($S(IBF=351:"MT",1:"LTC")_" Billing Clock") S IBA="" F  S IBA=$O(IBT(IBF,IBX,IBA)) Q:IBA=""  D
 . I $L(@IBR@(IBL))>40!($L(IBA_": "_IBT(IBF,IBX,IBA,"E"))>40) S IBL=IBL+1,@IBR@(IBL)=$S($E(IBA)="[":$E(IBA,9,99),1:IBA)_": "_IBT(IBF,IBX,IBA,"E") Q
 . S IBS="",$P(IBS," ",40-$L(@IBR@(IBL)))="",@IBR@(IBL)=@IBR@(IBL)_IBS_$S($E(IBA)="[":$E(IBA,9,99),1:IBA)_": "_IBT(IBF,IBX,IBA,"E")
 ;
 ; get billing info from 350
 ; first find the charges and sort
 K ^TMP("IBECEA",$J)
 S Y="" F  S Y=$O(^IB("AFDT",DFN,Y)) Q:'Y  I -Y'>IBEDT S Y1=0 F  S Y1=$O(^IB("AFDT",DFN,Y,Y1)) Q:'Y1  D
 . S IBX=0 F  S IBX=$O(^IB("AF",Y1,IBX)) Q:'IBX  D
 .. Q:'$D(^IB(IBX,0))  S IBZ=^(0)
 .. Q:$P(IBZ,"^",8)["ADMISSION"
 .. I $P(IBZ,"^",15)<IBBDT!($P(IBZ,"^",14)>IBEDT) Q
 .. S ^TMP("IBECEA",$J,+$P(IBZ,"^",14),IBX)=""
 ;
 S Y=0  F  S Y=$O(^IB("ACVA",DFN,Y)) Q:'Y  I Y'>IBEDT S Y1=0 F  S Y1=$O(^IB("ACVA",DFN,Y,Y1)) Q:'Y1  D
 . S IBX=0 F  S IBX=$O(^IB("AD",Y1,IBX)) Q:'IBX  D
 .. Q:'$D(^IB(IBX,0))  S IBZ=^(0)
 .. I $P(IBZ,"^",15)<IBBDT!($P(IBZ,"^",14)>IBEDT) Q
 .. S ^TMP("IBECEA",$J,Y,IBX)=""
 ;
 ; now store for return
 D SPACE("Patient Charges")
 I $D(^TMP("IBECEA",$J)) S IBL=IBL+1,@IBR@(IBL)="Bill From  Bill To   Charge Type          Stop  Bill #   Status       Charge"
 S IBD="" F  S IBD=$O(^TMP("IBECEA",$J,IBD)) Q:'IBD  D
 . S IBX="" F  S IBX=$O(^TMP("IBECEA",$J,IBD,IBX)) Q:'IBX  D
 .. S IBZ=^IB(IBX,0) Q:$P(IBZ,"^",7)=""
 .. S IBL=IBL+1
 .. S IBSTAT=$$EXTERNAL^DILFD(350,.05,"",$P(IBZ,"^",5))
 .. S IBATYP=$P($G(^IBE(350.1,+$P(IBZ,"^",3),0)),"^")
 .. S:$E(IBATYP,1,2)="DG" IBATYP=$E(IBATYP,4,99)
 .. ;  if ouptatient charge and clinic stop, show it
 .. I $E(IBATYP,1,3)="OPT",$P(IBZ,"^",20) S IBATYP=$E(IBATYP_"          ",1,21)_" "_$P($G(^IBE(352.5,+$P(IBZ,"^",20),0)),"^")
 .. S IBCHG=$S(IBATYP["CANCEL":"(",1:" ")_"$"_$P(IBZ,"^",7)_$S(IBATYP["CANCEL":")",1:"")
 .. S IBAX=$$SETSTR^VALM1($$DAT1^IBOUTL(IBD),"",1,9)
 .. S IBAX=$$SETSTR^VALM1($$DAT1^IBOUTL($S($P(IBZ,"^",8)["RX COPAY":IBD,1:$P(IBZ,"^",15))),IBAX,12,8)
 .. S IBAX=$$SETSTR^VALM1(IBATYP,IBAX,22,26)
 .. S IBAX=$$SETSTR^VALM1($P($P(IBZ,"^",11),"-",2),IBAX,49,8)
 .. S IBAX=$$SETSTR^VALM1(IBSTAT,IBAX,58,12)
 .. S IBAX=$$SETSTR^VALM1(IBCHG,IBAX,71,9)
 .. S @IBR@(IBL)=IBAX
 I '$D(IBAX) S @IBR@(IBL+1)=" ",@IBR@(IBL+2)="No charges meet criteria"
 K ^TMP("IBECEA",$J)
 ;
 Q
 ;
SPACE(IBTEXT) ; spaces out return info (sub-header info)
 S IBL=IBL+1,@IBR@(IBL)="",IBL=IBL+1,$P(@IBR@(IBL),"-",80)=""
 S IBL=IBL+1,$P(@IBR@(IBL)," ",80-$L(IBTEXT)/2)=IBTEXT
 Q
 ;
