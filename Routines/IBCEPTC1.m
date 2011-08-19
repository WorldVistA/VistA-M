IBCEPTC1 ;ALB/TMK - EDI PREV TRANSMITTED CLAIMS REPORT OUTPUT ;01/20/05
 ;;2.0;INTEGRATED BILLING;**296,320**;21-MAR-94
 ;
RPT(IBSORT,IBDT1,IBDT2) ; Output transmitted claims report
 ; global ^TMP("IB_PREV_CLAIM",$J,srt1,srt2,ien of entry file 364)=""
 N IBDA,IBIFN,IBPAGE,IBSTOP,IBHDR,IBS1,IBS2,Z,IBZ,IBREP
 S (IBPAGE,IBSTOP)=0,IBPAGE(0)="",IBPAGE(1)="",IBREP="R"
 S IBHDR="Transmitted Claims Report for period covering "_$$FMTE^XLFDT(IBDT1,1)_" thru "_$$FMTE^XLFDT(IBDT2,1)_$J("",14)_$$HTE^XLFDT($H,"1M"),IBHDR=IBHDR_$J("",124-$L(IBHDR))_"Page"
 S IBS1="" F  S IBS1=$O(^TMP("IB_PREV_CLAIM",$J,IBS1)) Q:IBS1=""  D  Q:IBSTOP
 . ; First level sort
 . D:($Y+6)>IOSL!'IBPAGE HDR(IBHDR,IBSORT,.IBPAGE,.IBSTOP) Q:IBSTOP
 . S IBPAGE(1)=IBS1,IBPAGE(0)="" ; Hold data for hdr repeated on new pg
 . D HDR1(IBSORT,IBS1,.IBPAGE,.IBSTOP) Q:IBSTOP
 . ;
 . S IBPAGE(0)=1
 . S IBS2="" F  S IBS2=$O(^TMP("IB_PREV_CLAIM",$J,IBS1,IBS2)) Q:IBS2=""!IBSTOP  S IBDA=0 F  S IBDA=$O(^TMP("IB_PREV_CLAIM",$J,IBS1,IBS2,IBDA)) Q:'IBDA!IBSTOP  D
 .. S IBIFN=+$G(^IBA(364,+IBDA,0))
 .. ;
 .. D:($Y+5)>IOSL!'IBPAGE HDR(IBHDR,IBSORT,.IBPAGE,.IBSTOP) Q:IBSTOP
 .. D WRT^IBCEPTC2(IBS1,IBS2,IBDA,IBIFN,IBSORT,IBREP,"",.IBPAGE,.IBSTOP) Q:IBSTOP
 . S IBPAGE(0)=""
 ;
 G:IBSTOP STOP
 I 'IBPAGE D WRT^IBCEPTC2("NO PREVIOUSLY TRANSMITTED CLAIMS EXIST TO MATCH THE SEARCH CRITERIA SELECTED","",0,0,IBSORT,IBREP,IBHDR,0,0)
 ;
 I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR
 ;
STOP I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) W ! D ^%ZISC
 ;
 Q
 ;
HDR1(IBSORT,IBDATA,IBPAGE,IBSTOP) ; First level report sort headers
 ; IBSORT = sort type
 ; IBDATA = data at the 1st sort level
 I ($Y+11)>IOSL D HDR(IBHDR,IBSORT,.IBPAGE,.IBSTOP) Q:IBSTOP
 N Z,X,Y,Q
 I IBSORT=1 D
 . S Q="Batch Number: "_$P(IBDATA,U,2)_$S('$P(IBDATA,U,4):"",1:"  ** This batch was rejected **")_$S('$P(IBDATA,U,3):"",1:"  ** This batch was a test batch **")
 . W !!,Q W:$G(IBPAGE(0)) $J("",120-$L(Q)),"(Continued)" W !,"Date Last Transmitted: ",$$FMTE^XLFDT(99999999-IBDATA,1)
 . S Z="",$P(Z,"=",133)="" W !,Z
 . W !,"Claim #   Form Type Seq  Status      A/R  Current Payer",$J("",13),"Payer Address",$J("",17),"Other Payer(s)  Patient Name",!
 ;
 I IBSORT=2 D
 . N IBZ,IBIFN
 . S IBIFN=""
 . I IBDATA'="" S IBIFN=+$G(^TMP("IB_PREV_CLAIM",$J,IBDATA))
 . S Q="Current Payer: "_$P(IBDATA,U)
 . D F^IBCEF("N-CURR INS CO FULL ADDRESS","IBZ",,IBIFN)
 . S Q=Q_"  "_$G(IBZ(1))_$S($G(IBZ(1))'="":",",1:"")_" "_$G(IBZ(4))_$S($G(IBZ(4))'="":",",1:"")_" "_$P($G(^DIC(5,+$G(IBZ(5)),0)),U,2)
 . W !!,Q
 . I $G(IBPAGE(0)) D
 .. I $L(Q)>119 S Q="" W !
 .. W $J("",120-$L(Q)),"(Continued)"
 . S Z="",$P(Z,"=",133)="" W !,Z
 . W !,"Claim #   Form Type Seq  Status      A/R    Other Payer(s)",$J("",6),"Patient Name",$J("",10),"Last Transmit    Batch Number",!
 ;
 Q
 ;
HDR(IBHDR,IBSORT,IBPAGE,IBSTOP) ; Report header
 ;
 N Z,DIR,X,Y
 I IBPAGE D  Q:IBSTOP
 . I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR S IBSTOP=('Y) Q:IBSTOP
 . W @IOF
 S IBPAGE=IBPAGE+1,Z=IBHDR_$J(IBPAGE,4)
 W !,Z
 W !,"** A claim may appear on this report multiple times if it has been transmitted more than once. **"
 I IBSORT=2 D
 . W !,"** T indicates the claim was transmitted as a test claim prior to turning on EDI live for the payer. **"
 . W !,"** R indicates that the batch was rejected. **"
 I IBPAGE>1,$G(IBPAGE(0)) D HDR1(IBSORT,IBPAGE(1),.IBPAGE,.IBSTOP)
 Q
 ;
