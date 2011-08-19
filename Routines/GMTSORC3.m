GMTSORC3 ; SLC/JER,KER - Current Orders (V3) ; 09/21/2001
 ;;2.7;Health Summary;**15,28,47**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10096    ^%ZOSF("TEST")
 ;   DBIA 10011    ^DIWP
 ;   DBIA  3154    EN^ORQ1
 ;                             
MAIN ; Current Orders (v3)
 N DIWF,DIWL,DIWR,GMTSDATA,GMTSDGRP,GMTSI,GMTSJ,GMTSK,GMTSLINE,GMTSORNM,GMTSSTAT,GMTSSTOP,GMTSSTRT,GMTSTTAB,GMTSWHEN,ORLIST,X S X="ORQ1" X ^%ZOSF("TEST") G:'$T EXIT D EXIT
 ;
 ; Call 
 ;  EN^ORQ1(PAT,GROUP,FLG,EXPAND,SDATE,EDATE,DETAIL,MULT,XREF,GETKID)
 ;     PAT    = #;DPT(     Patient VP
 ;     GROUP  = 1          Display Group
 ;     FLG    = 2          Active Current Orders
 ;     EXPAND = ""         IEN of Parent Order
 ;     SDATE  = GMTSBEG    Start Date
 ;     EDATE  = GMTSEND    End Date
 ;     DETAIL = 1          Return Details of Order
 ;     MULT   = 1          Allow Multiple Occurrences
 ;           
 D EN^ORQ1(DFN_";DPT(",1,2,"",GMTSBEG,GMTSEND,1,1,,1) G:'$D(^TMP("ORR",$J)) EXIT D HEAD S GMTSI=0
 F  S GMTSI=$O(^TMP("ORR",$J,ORLIST,GMTSI)) Q:GMTSI'>0!$D(GMTSQIT)  D PRT
EXIT ; Clean-up and quit
 K ^TMP("ORR",$J),^UTILITY($J,"W") Q
PRT ; Get the data
 S GMTSDATA=$G(^TMP("ORR",$J,ORLIST,GMTSI)),GMTSORNM=$P(GMTSDATA,U,1),GMTSDGRP=$P(GMTSDATA,U,2),GMTSWHEN=$P(GMTSDATA,U,3),GMTSSTRT=$P(GMTSDATA,U,4),GMTSSTOP=$P(GMTSDATA,U,5)
 I $L($P(GMTSDATA,U,7)) S GMTSSTAT=$P(GMTSDATA,U,7)
 E  S GMTSSTAT=$E($P(GMTSDATA,U,6),1,4)
 S GMTSSTRT=$$REGDTM(GMTSSTRT),GMTSSTOP=$$REGDTM(GMTSSTOP)
 I $O(^TMP("ORR",$J,ORLIST,GMTSI,"TX",0))'>0 D
 . S ^TMP("ORR",$J,ORLIST,GMTSI,"TX")=1,^TMP("ORR",$J,ORLIST,GMTSI,"TX",1)="*** Unknown ***"
 S GMTSJ=0,DIWL=1,DIWR=36,DIWF="" K ^UTILITY($J,"W",DIWL)
 F  S GMTSJ=$O(^TMP("ORR",$J,ORLIST,GMTSI,"TX",GMTSJ)) Q:GMTSJ'>0  D
 . S X=$G(^TMP("ORR",$J,ORLIST,GMTSI,"TX",GMTSJ)) D ^DIWP
 S (GMTSK,GMTSLINE,GMTSTTAB)=0
 F  S GMTSK=$O(^UTILITY($J,"W",DIWL,GMTSK)) Q:GMTSK'>0!$D(GMTSQIT)  D
 . D CKP^GMTSUP Q:$D(GMTSQIT)  I GMTSNPG D HEAD S GMTSLINE=0
 . S GMTSLINE=GMTSLINE+1
 . W ?GMTSTTAB,$G(^UTILITY($J,"W",DIWL,GMTSK,0)) S GMTSTTAB=2
 . W:GMTSLINE=1 ?39,GMTSSTAT,?45,GMTSSTRT,?63,GMTSSTOP W !
 Q
HEAD ; Print the header
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Item Ordered",?38,"Status",?45,"Start Date",?63,"Stop Date",!! Q
REGDTM(X) ; Convert an internal to an external date/time
 D:X]"" REGDTM4^GMTSU Q X
WRAP(TEXT,LENGTH) ; Breaks text string into substrings
 ;                
 ;    Input
 ;       TEXT = Text String
 ;       LENGTH = Maximum Length of Substrings
 ;                            
 ;    Output vertical bar delimted text
 ;       substring|substring|substring|substring|substring
 ;                            
 N GMTI,GMTJ,LINE,GMX,GMX1,GMX2,GMY I $G(TEXT)']"" Q ""
 F GMTI=1:1 D  Q:GMTI=$L(TEXT," ")
 . S GMX=$P(TEXT," ",GMTI)
 . I $L(GMX)>LENGTH D
 . . S GMX1=$E(GMX,1,LENGTH),GMX2=$E(GMX,LENGTH+1,$L(GMX)),$P(TEXT," ",GMTI)=GMX1_" "_GMX2
 S LINE=1,GMX(1)=$P(TEXT," ") F GMTI=2:1 D  Q:GMTI'<$L(TEXT," ")
 . S:$L($G(GMX(LINE))_" "_$P(TEXT," ",GMTI))>LENGTH LINE=LINE+1,GMY=1
 . S GMX(LINE)=$G(GMX(LINE))_$S(+$G(GMY):"",1:" ")_$P(TEXT," ",GMTI),GMY=0
 S GMTJ=0,TEXT="" F GMTI=1:1 S GMTJ=$O(GMX(GMTJ)) Q:+GMTJ'>0  S TEXT=TEXT_$S(GMTI=1:"",1:"|")_GMX(GMTJ)
 Q TEXT
