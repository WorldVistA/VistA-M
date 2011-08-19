IBDFLST1 ;ALM/MAF - Maintenance Utility Invalid Codes List - MAY 17 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
 ;
HEADER ;  -- Set up header line for the display
 S IBDCNT1=IBDCNT1+1
 S IBDCNT=IBDCNT+1,VALMCNT=VALMCNT+1
 S X=""
 S IBDFC(IBDFCAT)=IBDCNT_"^"_IBDFIFN
 S X=$$SETSTR(" ",X,1,3) D TMP
 S X="",IBDCNT=IBDCNT+1,VALMCNT=VALMCNT+1
 S IBDVAL=IBDFCAT
 S IBDVAL1=$L(IBDVAL) S IBDVAL1=(80-IBDVAL1)/2 S IBDVAL1=IBDVAL1\1 S X=$$SETSTR(" ",X,1,IBDVAL1)
 S X=$$SETSTR(IBDVAL,X,IBDVAL1,25) D TMP,CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM,0)
 S X="",IBDCNT=IBDCNT+1,VALMCNT=VALMCNT+1
 S X=$$SETSTR(" ",X,1,3) D TMP
 S IBDCNT1=IBDCNT1-1
 Q
 ;
 ;
SETSTR(S,V,X,L) ; -- insert text(S) into variable(V)
 ;    S := string
 ;    V := destination
 ;    X := @ col X
 ;    L := # of chars
 ;
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
 ;
 ;
TMP ; -- Set up Array
 S ^TMP("CODE",$J,IBDCNT,0)=$$LOWER^VALM1(X),^TMP("CODE",$J,"IDX",VALMCNT,IBDCNT1)=""
 S ^TMP("CODEIDX",$J,IBDCNT1)=VALMCNT_"^"_IBDFIFN_"^"_IBDFCODE_"^"_IBDFCAT_"^"_IBDFDESC
 Q
 ;
 ;  -- Help code for display choices
HELP1 W !!,"Choose a number or first initial :" F K=2:1:4 W !?15,$P(Z,"^",K)
 W ! Q
 ;
 ;  -- Selections listed
ZSET1 S Z="^1 [C]PT^2 [I]CD9^3 [V]ISIT^" Q
 ;
 ;
