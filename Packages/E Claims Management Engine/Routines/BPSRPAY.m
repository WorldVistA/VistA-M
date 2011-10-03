BPSRPAY ;BHAM ISC/BEE - ECME REPORTS ;11/15/07  14:13
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ; Payer Sheet Display Report
 ;
 ;User Prompts
EN N BPFILE,BPIEN,BPSCR,BPQ
 S BPFILE=9002313.92
 ;
 ;Select Payer Sheet
 I $D(IOF) W @IOF
 W !,"Payer Sheet Detail Report",!!
 S BPIEN=$$BPIEN(BPFILE)
 ;
 ;Check for Valid Entry
 I BPIEN=-1 G EXIT
 ;
 ;Select Device
 I $$DEVICE=-1 G EXIT
 ;
 ;Display Data
 D RUN(BPFILE,BPIEN)
 ;
 ;Exit
EXIT Q
 ;
 ;Display the Payer Sheet Info
 ;
RUN(BPFILE,BPIEN) N BPQ
 D PSPRNT(BPFILE,BPIEN)
 Q
 ;
 ; Select a payer sheet
BPIEN(BPFILE) N DIC,DIRUT,DTOUT,DUOUT,X,Y
 S DIC=$$ROOT^DILFD(BPFILE),DIC(0)="AEMQ"
 S DIC("A")="Select Payer Sheet: "
 D ^DIC
 Q +Y
 ;
 ;Select the output Device
DEVICE() N %ZIS,ZTSK,ZTRTN,ZTIO,ZTSAVE,ZTDESC,POP,BPQ
 S BPQ=0
 S %ZIS="QM"
 W ! D ^%ZIS
 I POP Q -1
 S BPSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 I $D(IO("Q")) D  S BPQ=-1
 . S ZTRTN="RUN^BPSRPAY(BPFILE,BPIEN)"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="PAYER SHEET DETAIL REPORT"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 Q BPQ
 ;
 ; Payer Sheet Display
PSPRNT(BPFILE,EN) N BPSHDR,BPIEN,BPPAGE,BPQ,CD,L,N,N1,N2,NAME,NM,NUM,SEG,SP
 N SEGNM,TB,WP,X,X0,X5,ZTREQ
 ;
 ; Build List of Segment Header Names
 D INIT
 ;
 ; Get header information
 S BPIEN=EN_","
 D GETS^DIQ(BPFILE,EN,".01;1.02;1.03;1.06;1.07;1.13;1.14;1001","","BPSHDR")
 ;
 ; Display Header Information
 S BPQ=0,BPPAGE=0,SEGNM=""
 D HDR
 ;
 ; Field Detail Information
 ; Loop through Segments
 S SEG=99 F  S SEG=$O(^BPSF(BPFILE,EN,SEG)) Q:SEG=""!(SEG>230)!(SEG="REVERSAL")  D  I BPQ Q
 . ;
 . ;Make sure there are entries for the segment
 . I $P($G(^BPSF(BPFILE,EN,SEG,0)),U,4)<1 Q
 . ;
 . ; Get and display Segment Name
 . S SEGNM=$G(NAME(SEG))
 . ; Check that we can display the Segment Name and at least one additional field
 . D CHKP(2) I BPQ Q
 . I BPPAGE=1!($Y>5) W !,?((60-$L(SEGNM)+8)/2),"*** ",SEGNM," ***"
 . ; Loop through the Field via the Sequence Number
 . S N=0 F  S N=$O(^BPSF(BPFILE,EN,SEG,"B",N)) Q:N=""  D  I BPQ Q
 .. S N1=0 F  S N1=$O(^BPSF(BPFILE,EN,SEG,"B",N,N1)) Q:N1=""  D  I BPQ Q
 ... ;
 ... ; Get Field Data and Format the Field Number
 ... S X=$G(^BPSF(BPFILE,EN,SEG,N1,0))
 ... S NUM=$P(X,U,2),SP=$P(X,U,3)
 ... I NUM S X0=$G(^BPSF(9002313.91,NUM,0)),X5=$G(^BPSF(9002313.91,NUM,5))
 ... E  S (X0,X5)=""
 ... S NUM=$P(X0,U,1)_"-"_$P(X5,U,1),NM=$P(X0,U,3)
 ... ;
 ... ; Display the field information
 ... D CHKP(1) I BPQ Q
 ... W !,N,?5,NUM,?17,NM,?71,$J(SP,9)
 ... ;
 ... ; If there is special code, display it
 ... I SP="X" S N2=0 F  S N2=$O(^BPSF(BPFILE,EN,SEG,N1,1,N2)) Q:N2=""  D  I BPQ Q
 .... S CD=$G(^BPSF(BPFILE,EN,SEG,N1,1,N2,0))
 .... S TB=19,L=61,WP=0
 .... F  D CHKP(1) Q:BPQ  W ! D  Q:CD=""
 ..... W:N2=1 ?5,"Special Code: "
 ..... W:WP=1 ?12,"<cont>"
 ..... W ?19,$E(CD,1,L)
 ..... S CD=$E(CD,L+1,200) Q:CD=""
 ..... S WP=1
 . I BPQ Q
 .D CHKP(1) Q:BPQ  W !
 I 'BPSCR W !,@IOF
 E  I 'BPQ D PAUSE2
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
XPRT Q
 ;
 ;Display Report Header
 ;
HDR S BPPAGE=$G(BPPAGE)+1
 W @IOF
 W "Payer Sheet Detail Report"
 W ?48,"Print Date: "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 W "    Page:",$J(BPPAGE,3)
 W !,$J("Payer Sheet Name: ",20),$G(BPSHDR(BPFILE,BPIEN,.01))
 W ?40,$J("Version Number: ",20),$G(BPSHDR(BPFILE,BPIEN,1.14))
 I BPPAGE=1 D
 . W !,$J("Status: ",20),$G(BPSHDR(BPFILE,BPIEN,1.06))
 . W ?40,$J("NCPDP Version: ",20),$G(BPSHDR(BPFILE,BPIEN,1.02))
 . W !,$J("Reversal Format: ",20),$G(BPSHDR(BPFILE,BPIEN,1.07))
 . W ?40,$J("Reversal Sheet: ",20),$G(BPSHDR(BPFILE,BPIEN,1001))
 . W !,$J("Transaction Count: ",20),$G(BPSHDR(BPFILE,BPIEN,1.03))
 . W ?40,$J("Certification ID: ",20),$G(BPSHDR(BPFILE,BPIEN,1.13))
 ;
 ; Display subheader
 W !!,"Seq",?5,"Field",?17,"Field Name",?71,"Proc Mode"
 W !,"---",?5,"-----",?17,"----------",?71,"---------"
 I $G(SEGNM)]"" W !,?((60-$L(SEGNM)+8)/2),"*** ",SEGNM," ***"
 Q
 ;
 ;Check for End of Page
 ;
 ; Input variable -> BPLINES - Number of lines from bottom
 ;                      CONT - 0 = New Entry, 1 = Continue Entry
 ;
CHKP(BPLINES) S BPLINES=BPLINES+1
 I $G(BPSCR) S BPLINES=BPLINES+3
 I $Y>(IOSL-BPLINES) D:$G(BPSCR) PAUSE Q:$G(BPQ) 0 D HDR Q 1
 Q 0
 ;
PAUSE ;
 N X
 U IO(0)
 R !!,"Press RETURN to continue, '^' to exit: ",X:DTIME
 I '$T S X="^"
 I X["^" S BPQ=1
 U IO
 Q
 ;
PAUSE2 ;
 N X
 U IO(0)
 R !,"Press RETURN to continue: ",X:DTIME
 U IO
 Q
 ;
INIT ; Create local array of segment header names
 S NAME(100)="Transaction Header Segment",NAME(110)="Patient Segment"
 S NAME(120)="Insurance Segment",NAME(130)="Claim Segment"
 S NAME(140)="Pharmacy Provider Segment",NAME(150)="Prescriber Segment"
 S NAME(160)="COB/Other Payments Segment",NAME(170)="Workers' Compensation Segment"
 S NAME(180)="DUR/PPS Segment",NAME(190)="Pricing Segment"
 S NAME(200)="Coupon Segment",NAME(210)="Compound Segment"
 S NAME(220)="Prior Authorization Segment",NAME(230)="Clinical Segment"
 Q
