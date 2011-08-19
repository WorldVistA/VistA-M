IBCEMSR1 ;WOIFO/AAT - MRA STATISTICS REPORT CONT. ;09/03/04
 ;;2.0;INTEGRATED BILLING;**155,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ; Report header
HDR N IBI
 S IBPAGE=IBPAGE+1
 W @IOF,"MRA Statistics Report for period covering "_$$DAT(IBBDT)_" thru "_$$DAT(IBEDT),"   ",?100,$$DAT(DT),"   Page ",IBPAGE
 W ! F IBI=1:1:$S($G(IOM):IOM,1:130) W "-"
 Q
 ;
REPORT N IBDVN,IBCLERK,IBPAGE,IBTU,IBTH
 S IBPAGE=0
 D HDR
 I '$D(@REF) W !,"No data meet the criteria." Q
 I 'IBSUM S IBDVN="" F  S IBDVN=$O(@REF@(IBDVN)) Q:IBDVN=""  D  Q:IBQ
 . D CHKP Q:IBQ  W !,"DIVISION: ",IBDVN
 . S IBCLERK="A" F  S IBCLERK=$O(@REF@(IBDVN,IBCLERK)) Q:IBCLERK=""  D  Q:IBQ
 . . D DETAILS
 Q:IBQ
 ; Summary section
 D:'IBSUM HDR W !,"SUMMARY"
 S IBDVN="" F  S IBDVN=$O(@REF@(IBDVN)) Q:IBDVN=""  D  Q:IBQ
 . D CHKP Q:IBQ  W !,"DIVISION: ",IBDVN
 . D SUMMARY
 Q
 ;
DETAILS ; Print Details
 N REFU,REFU,IBTXT,IBNU,IBNH,IBTU,IBTH
 ;
 S REFU=$NA(@REF@(IBDVN,IBCLERK,3))
 S REFH=$NA(@REF@(IBDVN,IBCLERK,2))
 ;
 D CHKP Q:IBQ  W !,"CLERK: ",IBCLERK
 D CHKP Q:IBQ  W !?7,"Primary UB-04 MRA Requests",?67,"Primary CMS-1500 MRA Requests"
 D CHKP Q:IBQ  W !?7,"--------------------------",?67,"-----------------------------"
 S IBTXT="Total number of MRA Requests:"
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(+$G(@REFU@("ALL")),5),?67,IBTXT,?110,$J(+$G(@REFH@("ALL")),5)
 S IBTXT="Number of unique MRA Requests:",IBTU=+$G(@REFU@("TOT")),IBTH=+$G(@REFH@("TOT"))
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(IBTU,5),?67,IBTXT,?110,$J(IBTH,5)
 S IBTXT="Requests with no response:",IBNU=+$G(@REFU@("NON")),IBNH=+$G(@REFH@("NON"))
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(IBNU,5),?67,IBTXT,?110,$J(IBNH,5)
 S IBTXT="Requests with final rejection:",IBNU=+$G(@REFU@("REJF")),IBNH=+$G(@REFH@("REJF"))
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(IBNU,5),?67,IBTXT,?110,$J(IBNH,5)
 ;
 S IBTXT="Requests with returned MRA:",IBNU=+$G(@REFU@("MRA")),IBNH=+$G(@REFH@("MRA"))
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(IBNU,5),?67,IBTXT,?110,$J(IBNH,5)
 S IBTXT="Processed MRA:"
 D CHKP Q:IBQ  W !?14,IBTXT,?35,$J($G(@REFU@("MRA"))-$G(@REFU@("MRAD")),5),?74,IBTXT,?90,$J($G(@REFH@("MRA"))-$G(@REFH@("MRAD")),5)
 S IBTXT="Denied MRA:"
 D CHKP Q:IBQ  W !?14,IBTXT,?35,$J(+$G(@REFU@("MRAD")),5),?74,IBTXT,?90,$J(+$G(@REFH@("MRAD")),5)
 D CHKP Q:IBQ  W !
 ;
 D SECONDRY Q:IBQ
 D CHKP Q:IBQ  W !
 Q
 ;
SUMMARY ;Print summary
 N REFU,REFH,IBTXT,IBNU,IBNH,IBTU,IBTH
 ;
 S REFU=$NA(@REF@(IBDVN,0,3))
 S REFH=$NA(@REF@(IBDVN,0,2))
 ;
 D CHKP Q:IBQ  W !?7,"Primary UB-04 MRA Requests",?67,"Primary CMS-1500 MRA Requests"
 D CHKP Q:IBQ  W !?7,"--------------------------",?67,"-----------------------------"
 S IBTXT="Total number of MRA Requests:",IBTU=+$G(@REFU@("ALL")),IBTH=+$G(@REFH@("ALL"))
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(IBTU,5),?67,IBTXT,?110,$J(IBTH,5)
 S IBTXT="Percent Resubmitted:",IBNU=+$G(@REFU@("ALLR")),IBNH=+$G(@REFH@("ALLR"))
 D CHKP Q:IBQ  W !?14,IBTXT,?50,$$%(IBNU,IBTU),?74,IBTXT,?110,$$%(IBNH,IBTH)
 S IBTXT="Percent Cancelled/Copied:",IBNU=+$G(@REFU@("ALLC")),IBNH=+$G(@REFH@("ALLC"))
 D CHKP Q:IBQ  W !?14,IBTXT,?50,$$%(IBNU,IBTU),?74,IBTXT,?110,$$%(IBNH,IBTH)
 S IBTXT="Number of unique MRA Requests:",IBTU=+$G(@REFU@("TOT")),IBTH=+$G(@REFH@("TOT"))
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(IBTU,5),?67,IBTXT,?110,$J(IBTH,5)
 S IBTXT="Requests with no response:",IBNU=+$G(@REFU@("NON")),IBNH=+$G(@REFH@("NON"))
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(IBNU,5),?67,IBTXT,?110,$J(IBNH,5)
 S IBTXT="Requests with final rejection:",IBNU=+$G(@REFU@("REJF")),IBNH=+$G(@REFH@("REJF"))
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(IBNU,5),?67,IBTXT,?110,$J(IBNH,5)
 S IBTXT="Percent with final rejection:"
 D CHKP Q:IBQ  W !?14,IBTXT,?50,$$%(IBNU,IBTU),?74,IBTXT,?110,$$%(IBNH,IBTH)
 S IBTXT="Requests with returned MRA:",IBTU=+$G(@REFU@("MRA")),IBTH=+$G(@REFH@("MRA"))
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(IBTU,5),?67,IBTXT,?110,$J(IBTH,5)
 S IBTXT="Processed MRA:",IBNU=IBTU-$G(@REFU@("MRAD")),IBNH=IBTH-$G(@REFH@("MRAD"))
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(IBNU,5),?67,IBTXT,?110,$J(IBNH,5)
 S IBTXT="Denied MRA:"
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(+$G(@REFU@("MRAD")),5),?67,IBTXT,?110,$J(+$G(@REFH@("MRAD")),5)
 S IBTXT="Percent Processed MRA:"
 D CHKP Q:IBQ  W !?14,IBTXT,?50,$$%(IBNU,IBTU),?74,IBTXT,?110,$$%(IBNH,IBTH)
 D CHKP Q:IBQ  W !
 ;
 D SECONDRY Q:IBQ
 S IBTXT="Percent Unique Req to Secondary:"
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J($$%(+$G(@REFU@("SEC")),+$G(@REFU@("TOT"))),5),?67,IBTXT,?110,$J($$%(+$G(@REFH@("SEC")),+$G(@REFH@("TOT"))),5)
 S IBTXT="Percent Auto-Generated:"
 D CHKP Q:IBQ  W !?14,IBTXT,?50,$J($$%($G(@REFU@("AT"))+$G(@REFU@("AP")),+$G(@REFU@("TOT"))),5),?67,IBTXT,?110,$J($$%($G(@REFH@("AT"))+$G(@REFH@("AP")),+$G(@REFH@("TOT"))),5)
 S IBTXT="Percent Manually-Processed:"
 D CHKP Q:IBQ  W !?14,IBTXT,?50,$J($$%($G(@REFU@("MT"))+$G(@REFU@("MP")),+$G(@REFU@("TOT"))),5),?67,IBTXT,?110,$J($$%($G(@REFH@("MT"))+$G(@REFH@("MP")),+$G(@REFH@("TOT"))),5)
 ;
 D CHKP Q:IBQ  W !
 Q
 ;
SECONDRY ; Print 2ndary claims info
 D CHKP Q:IBQ  W !?7,"Secondary UB-04 claims",?67,"Secondary CMS-1500 claims"
 D CHKP Q:IBQ  W !?7,"----------------------",?67,"-------------------------"
 S IBTXT="Authorized (not yet printed):"
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(+$G(@REFU@("AUT")),5),?67,IBTXT,?110,$J(+$G(@REFH@("AUT")),5)
 ;
 S IBTXT="Auto-generated to print:"
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(+$G(@REFU@("AP")),5),?67,IBTXT,?110,$J(+$G(@REFH@("AP")),5)
 S IBTXT="Total Primary Charges:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("AP1")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("AP1")),10,2)
 S IBTXT="Unreimb'd Medicare Exp:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("AP2")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("AP2")),10,2)
 S IBTXT="Total Secondary Charges:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("AP3")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("AP3")),10,2)
 ;
 S IBTXT="Auto-generated to transmit:"
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(+$G(@REFU@("AT")),5),?67,IBTXT,?110,$J(+$G(@REFH@("AT")),5)
 S IBTXT="Total Primary Charges:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("AT1")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("AT1")),10,2)
 S IBTXT="Unreimb'd Medicare Exp:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("AT2")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("AT2")),10,2)
 S IBTXT="Total Secondary Charges:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("AT3")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("AT3")),10,2)
 ;
 S IBTXT="Manually processed to print:"
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(+$G(@REFU@("MP")),5),?67,IBTXT,?110,$J(+$G(@REFH@("MP")),5)
 S IBTXT="Total Primary Charges:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("MP1")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("MP1")),10,2)
 S IBTXT="Unreimb'd Medicare Exp:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("MP2")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("MP2")),10,2)
 S IBTXT="Total Secondary Charges:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("MP3")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("MP3")),10,2)
 ;
 S IBTXT="Manually processed to transmit:"
 D CHKP Q:IBQ  W !?7,IBTXT,?50,$J(+$G(@REFU@("MT")),5),?67,IBTXT,?110,$J(+$G(@REFH@("MT")),5)
 S IBTXT="Total Primary Charges:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("MT1")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("MT1")),10,2)
 S IBTXT="Unreimb'd Medicare Exp:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("MT2")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("MT2")),10,2)
 S IBTXT="Total Secondary Charges:"
 D CHKP Q:IBQ  W !?14,IBTXT,?45,$J(+$G(@REFU@("MT3")),10,2),?74,IBTXT,?105,$J(+$G(@REFH@("MT3")),10,2)
 Q
 ;
 ;
%(VALUE,TOTAL) ;Percentage
 I 'TOTAL Q $J("0%",6)
 Q $J($J(VALUE*100/TOTAL,3,0)_"%",6)
 ;
CHKP ;Check for EOP
 I $Y>(IOSL-4) D:IBSCR PAUSE Q:IBQ  D HDR
 Q
 ;
PAUSE ;
 N X U IO(0) W !!,"Press RETURN to continue, '^' to exit:" R X:DTIME S:'$T X="^" S:X["^" IBQ=2
 U IO
 Q
 ;
PAUSE2 ;
 N X U IO(0) W !!,"Press RETURN to continue:" R X:DTIME S:'$T X="^" S:X["^" IBQ=2
 U IO
 Q
 ;
DAT(X) ;Convert FM date to displayable (mm/dd/yy) format.
 N DATE,YR
 I $G(X) S YR=$E(X,2,3)
 I $G(X) S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_YR,1:"")
 Q $G(DATE)
 ;
