IVMLERR ;ALB/RMO,ERC - IVM Transmission Error Processing - List Manager Screen; 15-SEP-1997 ; 5/25/07 11:09am
 ;;2.0;INCOME VERIFICATION MATCH;**9,121**; 21-OCT-94;Build 45
 ;
EN ;Main entry point for IVM transmission error processing option
 ; Input  -- None
 ; Output -- None
 ;
 ;Invoke IVM TRANSMISSION ERRORS list template
 D EN^VALM("IVM TRANSMISSION ERRORS")
 Q
 ;
HDR ;Header code
 ;
 ;Sort by
 S VALMHDR(1)="Sort By: "_$S(IVMSRTBY="P":"Patient Name",IVMSRTBY="D":"Date/Time ACK Received",IVMSRTBY="E":"Error Message",IVMSRTBY="O":"Person Not Found",1:"Unknown")
 ;
 ;Date range
 S VALMHDR(1)=$$SETSTR^VALM1("Date Range: "_$$FDATE^VALM1(IVMBEG)_" thru "_$$FDATE^VALM1(IVMEND),VALMHDR(1),46,80)
 ;
 ;Error processing status
 N HDR,PCE,STA
 S HDR=""
 F PCE=1:1 S STA=$P(IVMEPSTA,U,PCE) Q:STA=""  D
 . S:HDR'="" HDR=HDR_"/"
 . S HDR=HDR_$$LOWER^VALM1($$EXT^IVMTLOG("ERROR STATUS",STA))
 S VALMHDR(2)="Error Processing Statuses: "_$S(HDR="":"Unknown",1:HDR)
 Q
 ;
INIT ;Init variables and list array
 N VALMB,VALMBEG,VALMEND,X,X1,X2
 K IVMBEG,IVMEND,IVMEPSTA,IVMSRTBY
 ;
 S VALMSG=$$MSG
 ;
 ;Ask user for date range - default two weeks prior to today
 S X1=DT,X2=-14 D C^%DTC S VALMB=X
 D RANGE^VALM1
 I 'VALMBEG!('VALMEND) S VALMQUIT=1 G INITQ
 S IVMBEG=VALMBEG,IVMEND=VALMEND
 ;
ASK ;
 ;ask user for sort criteria
 N DIROUT,DUOUT
 N IVMFLG ;flag indicating that the report has not yet run
 N IVMY
 S IVMFLG=1
 S IVMEPSTA=1
 W !!?5,"How would you like this display sorted?",!
 D SL^IVMLERR2
 I $D(DUOUT)!($D(DIROUT)) S VALMQUIT=1 G INITQ
 ;Build IVM transmission error screen
 D BLD
INITQ Q
 ;
BLD ;Build IVM transmission error screen
 D CLEAN^VALM10
 K IVMARY,VALMHDR
 S IVMARY="IVMERR"
 K ^TMP(IVMARY_"SRT",$J),^TMP(IVMARY_"IDX",$J)
 S VALMBG=1,VALMCNT=0
 ;
 ;Build header
 D HDR
 ;
 ;Build list area for transmission errors
 D EN^IVMLERR1(IVMARY,IVMBEG,IVMEND,IVMEPSTA,IVMSRTBY,.VALMCNT)
 Q
 ;
MSG() ;Custom message for list manager 'message window'
 Q "* = Patient has been flagged for transmission"
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K IVMBEG,IVMEND,IVMEPSTA,IVMSRTBY,^TMP(IVMARY_"SRT",$J),^TMP(IVMARY_"IDX",$J),IVMARY
 Q
 ;
EXPND ;Expand code
 Q
 ;
