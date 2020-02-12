IBCEXTRP ;ALB/JEH - VIEW/PRINT EDI EXTRACT DATA ;4/22/03 9:59am
 ;;2.0;INTEGRATED BILLING;**137,197,211,348,349,377,592,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ;
INIT ;
 W !!,"This option will display the EDI extract data for a bill.",!
 N IBREC1,IBIEN,IBINC,DIC,X,Y,DIR,IB364IEN,IBVNUM,IBSEG,STOP,POP,DTOUT,DUOUT
 ;
 N DPTNOFZY S DPTNOFZY=1 ; Suppress PATIENT file fuzzy lookups
 S DIC="^DGCR(399,",DIC(0)="AEMQ",DIC("S")="I 234[$P(^(0),U,13)" D ^DIC
 I Y<1 G EXITQ
 S IBIEN=+Y,IBREC1=$G(^DGCR(399,IBIEN,0))
 S IB364IEN=$$LAST364^IBCEF4(IBIEN) I +$G(IB364IEN)=0 D  G EXITQ
 . W !,"There is no entry in the EDI Transmit Bill file for this bill number."
 S IBVNUM=$P($G(^IBA(364,IB364IEN,0)),U,2)
 ;JWS;IB*2.0*623;add check for 837 FHIR not on
 I +$G(IBVNUM)=0,'$$GET1^DIQ(350.9,"1,",8.21,"I") D  G EXITQ
 . W !!,"There is no batch # for this bill.  It has not been transmitted."
 I +$G(IBVNUM) S IBVNUM=$P($G(^IBA(364.1,IBVNUM,0)),U)
 S DIR("A")="Include Fields With No Data?: ",DIR("B")="NO",DIR(0)="YA"
 W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G EXITQ
 S IBINC=+Y
 ;
 ; IB*2*377 - esg - Ask for specific EDI segments to view
 ;
 W !
 S DIR(0)="SA^A:All EDI Segments;S:Selected EDI Segments"
 S DIR("A")="Include (A)ll or (S)elected EDI Segments?: "
 S DIR("B")="All EDI Segments"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G EXITQ
 I Y="A" G DEV                    ; all segments, skip to device prompt
 ;
 W !
 K IBSEG
 S STOP=0
 F  D  Q:STOP
 . S DIR(0)="FO^3:4"
 . S DIR("A")=" Select EDI Segment"
 . I $D(IBSEG) S DIR("A")="Another EDI Segment"
 . S DIR("?")="Enter the name of the EDI segment to include."
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S STOP=1 Q
 . S Y=$$UP^XLFSTR(Y),Y=$$TRIM^XLFSTR(Y)   ; uppercase/trim spaces
 . I Y="" S STOP=1 Q
 . S IBSEG(Y)=""
 . Q
 I $D(DTOUT)!$D(DUOUT) G EXITQ
 ;
DEV ; - Select device
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 W !
 S %ZIS="QM" D ^%ZIS G:POP EXITQ
 I $D(IO("Q")) D  G EXITQ
 . S ZTRTN="LIST^IBCEXTRP",ZTDESC="Transmitted Bill Extract Data"
 . S ZTSAVE("IB*")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
LIST ; - set up array and print data
 N IBPG,IBSEQ,IBPC,IBDA,IBREC,IBQUIT,IBILL,IBLINE,IBXDATA,IBERR,IBXERR,Z,Z0,Z1
 D EXTRACT(IBIEN,IBVNUM,8,1)
 S (IBPG,IBQUIT,IBSEQ,IBPC,IBDA,IBLINE)=0
 K ^TMP($J,"IBLINES")
 ;IB*2.0*211 - rely on form type instead of bill charge type
 N IBFMTYP S IBFMTYP=$$FT^IBCEF(IBIEN)
 ;JWS;IB*2.0*592 - Dental form 7 (J430D)
 S IBFMTYP=$S(IBFMTYP=2:"CMS-1500",IBFMTYP=3:"UB-04",IBFMTYP=7:"J430D",1:"OTHER"_"("_IBFMTYP_")")
 S IBILL=$S($$INPAT^IBCEF(IBIEN,1):"Inpt",1:"Oupt")_"/"_IBFMTYP
 ;
 I $D(^TMP("IBXERR",$J)) D  G EXITQ
 . S IBERR=0 F  S IBERR=$O(^TMP("IBXERR",$J,IBERR)) Q:'IBERR  W !,$G(^TMP("IBXERR",$J,IBERR))
 . Q
 ;
 F  S IBSEQ=$O(^IBA(364.6,"ASEQ",8,IBSEQ)) Q:'IBSEQ  I $$INCLUDE(IBSEQ) F  S IBPC=$O(^IBA(364.6,"ASEQ",8,IBSEQ,1,IBPC)) Q:'IBPC  F  S IBDA=$O(^IBA(364.6,"ASEQ",8,IBSEQ,1,IBPC,IBDA)) Q:'IBDA  D
 . N IBOK,Z,IBMULT,DSP,IBDATA,PCD,SN
 . S IBREC=$G(^IBA(364.6,IBDA,0))
 . I $P(IBREC,U,11)=1 Q     ; calculate only field
 . ;
 . ; processing for piece 1 of this EDI segment to see if there is any
 . ; other data that exists in this segment
 . I IBPC=1 S IBOK=0 D
 .. S Z=1 F  S Z=$O(^TMP("IBXDATA",$J,1,IBSEQ,1,Z)) Q:'Z  I $G(^(Z))'="" S IBOK=1 Q
 .. I IBOK Q   ; data exists so include segment normally
 .. S SN=$P($G(^TMP("IBXDATA",$J,1,IBSEQ,1,1)),U,1)   ; segment name
 .. I SN="" S SN=$P($P(IBREC,U,10),"'",2)
 .. S SN=SN_" (No Data - Record Not Sent)"
 .. S $P(^TMP("IBXDATA",$J,1,IBSEQ,1,1),U,1)=SN
 .. Q
 . ;
 . ; loop thru all multiple occurrences of this segment
 . S IBMULT=0 F  S IBMULT=$O(^TMP("IBXDATA",$J,1,IBSEQ,IBMULT)) Q:'IBMULT   D
 .. ;
 .. ; field with no data; check user preference
 .. I '$G(IBINC),$P($G(^TMP("IBXDATA",$J,1,IBSEQ,IBMULT,IBPC)),U,1)="" Q
 .. ;
 .. ; build display data
 .. S PCD="["_IBPC_"] "      ; piece#
 .. S DSP=$P(IBREC,U,10)     ; short description field
 .. S IBDATA=$P($G(^TMP("IBXDATA",$J,1,IBSEQ,IBMULT,IBPC)),U,1)   ; data
 .. S DSP=$J(PCD,5)_$$FO^IBCNEUT1(DSP,40)_": "_IBDATA
 .. S ^TMP($J,"IBLINES",IBSEQ,IBMULT,IBPC)=DSP
 .. Q
 . Q
 ;
 S IBQUIT=0
 W:$E(IOST,1,2)["C-" @IOF ; initial form feed for screen print
 N IBFMTYP S IBFMTYP=$$FT^IBCEF(IBIEN)
 ;JWS;IB*2.0*592 - Dental form 7 (J430D)
 S IBFMTYP=$S(IBFMTYP=2:"CMS-1500",IBFMTYP=3:"UB-04",IBFMTYP=7:"J430D",1:"OTHER"_"("_IBFMTYP_")")
 S IBILL=$S($$INPAT^IBCEF(IBIEN,1):"Inpt",1:"Oupt")_"/"_IBFMTYP
 D HDR
 S Z=0 F  S Z=$O(^TMP($J,"IBLINES",Z)) Q:'Z!IBQUIT  S Z0=0 F  S Z0=$O(^TMP($J,"IBLINES",Z,Z0)) Q:'Z0!IBQUIT  S Z1=0 F  S Z1=$O(^TMP($J,"IBLINES",Z,Z0,Z1)) Q:'Z1!IBQUIT  D  Q:IBQUIT
 . I IBLINE>(IOSL-3) D HDR Q:IBQUIT
 . ;JWS;IB*2.0*592;Wrap long Dental Proc Description
 . I Z=60,Z1=19 D  Q:IBQUIT
 . . N IBNOTE,X,IBDATA
 . . S IBDATA=$G(^TMP($J,"IBLINES",Z,Z0,Z1)) I IBDATA="" Q
 . . S IBDATA(1)=$P(IBDATA,": "),IBDATA(2)=$P(IBDATA,": ",2),IBDATA(1)=IBDATA(1)_": "
 . . S IBNOTE=$$WRAP^IBCSC10H(IBDATA(2),32,32,.IBNOTE)
 . . W !,IBDATA(1)
 . . S X=0 F  S X=$O(IBNOTE(X)) Q:X=""  Q:IBQUIT  W:X'=1 ! W ?47,IBNOTE(X) S IBLINE=IBLINE+1 I IBLINE>(IOSL-3) D HDR Q:IBQUIT
 . E  W !,^TMP($J,"IBLINES",Z,Z0,Z1)
 . S IBLINE=IBLINE+1
 . I IBLINE>(IOSL-3) D HDR Q:IBQUIT
 . ;
 . ; end of segment add an extra line feed
 . I '$O(^TMP($J,"IBLINES",Z,Z0,Z1)) W ! S IBLINE=IBLINE+1
 . Q
 ;
 K ^TMP($J,"IBLINES")
 G EXITQ
 ;
 ;
HDR ; - Report header
 N DIR,Y
 I IBPG D  Q:IBQUIT
 . I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR S IBQUIT=('Y) Q:IBQUIT
 . W @IOF
 ;
 S IBPG=IBPG+1
 W !,?25,"EDI Transmitted Bill Extract Data",!,"Bill #",?11,"Type",?27,"Patient Name",?52,"SSN",?57,$$FMTE^XLFDT(DT),?71,"Page: "_IBPG
 W !,$TR($J("",IOM)," ","=")
 W !,$P(IBREC1,U)_" "_"("_IBILL_")",?27,$P($G(^DPT(+$P(IBREC1,U,2),0)),U),?52,$P($G(^DPT($P(IBREC1,U,2),0)),U,9),!
 S IBLINE=6
 Q
 ;
EXITQ ; - clean up and exit
 I $E(IOST,1,2)["C-",'$G(IBQUIT) K DIR S DIR(0)="E" W ! D ^DIR K DIR
 K ^TMP("IBXERR",$J),^TMP("IBXDATA",$J),IBXERR
 D CLEAN^DILF
 Q
 ;
EXTRACT(IBIFN,IBBATCH,IBFORM,IBLOCAL) ; Extracts transmitted form data into global
 ; ^TMP("IBXDATA",$J).  Errors are in ^TMP("IBXERR",$J,err_num)=text.
 ; IBBATCH = Batch # of bill (if known), otherwise, set to 1.  This
 ;          variable must be > 0 to prevent a new batch from being added
 ; IBFORM = the ien of the form in file 353
 ; IBLOCAL = 1 if OK to use local form, 0 if not
 N IBVNUM,IBL,IBINC,IBSEG
 D FORMPRE^IBCFP1
 S IBVNUM=$G(IBBATCH)
 S IBL=$S('$G(IBLOCAL):IBFORM,1:"") ; No local form ... set = main form
 ; Get local form associated with parent, if any
 I IBL="" S IBL=$S($P($G(^IBE(353,+IBFORM,2)),U,8):$P(^(2),U,8),1:IBFORM)
 D SETUP^IBCE837(1)
 ;;JWS;IB*2.0*623;allow display without Batch #
 I $$GET1^DIQ(350.9,"1,",8.21,"I"),IB364IEN,$P(^IBA(364,IB364IEN,0),"^",2)="" S ^TMP("IBHDR",$J)="NOT YET ASSIGNED"
 D ROUT^IBCFP1(IBFORM,1,IBIFN,0,IBL)
 Q
 ;
INCLUDE(IBSEQ) ; Function to determine if segment should be included or not
 N OK,LZ,SEGNAME
 S OK=1                   ; default is to include it
 I '$D(IBSEG) G INCLX     ; if nothing in array, then include all
 I '$D(^TMP("IBXDATA",$J,1,IBSEQ)) S OK=0 G INCLX        ; no data there
 S LZ=+$O(^TMP("IBXDATA",$J,1,IBSEQ,""))   ; first line# found in data
 S SEGNAME=$P($G(^TMP("IBXDATA",$J,1,IBSEQ,LZ,1)),U,1)   ; piece 1
 S SEGNAME=$$TRIM^XLFSTR(SEGNAME)
 I SEGNAME'="",'$D(IBSEG(SEGNAME)) S OK=0   ; don't include
INCLX ;
 Q OK
 ;
