IBDFLST ;ALM/MAF - Maintenance Utility Invalid Codes List - MAY 17 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**9,38,51**;APR 24, 1997
 ;
 ;
START ;  -- Ask what invalid code you want to display CPT/ ICD9/ Visit
 N IBDFDIS
 D FULL^VALM1
 S DIR("B")="CPT",DIR(0)="SBM^C:CPT;I:ICD9;V:VISIT",DIR("A")="Display invalid codes for [C]PT, [I]CD9, [V]ISIT" D ^DIR
 K DIR I $D(DIRUT)!(Y<0) G QUIT
 ;W !!,"Display invalid codes for CPT// " D ZSET1^IBDFLST1 S X="" R X:DTIME G QUIT:X="^"!('$T) I X=""!("Cc"[X) S X="1"
 S X=$S("Ii"[X:2,"Vv"[X:3,1:1)
 ;I X="?" D ZSET1^IBDFLST1,HELP1^IBDFLST1 G START
 S IBDFTYP=$E(X)  ; D IN^DGHELP W ! I %=-1 D ZSET1^IBDFLST1,HELP1^IBDFLST1 G START
 S IBDFDIS=$S(IBDFTYP=1:"CPT",IBDFTYP=2:"ICD9",IBDFTYP=3:"VISIT",1:"QUIT")
 D WAIT^DICD
 D EN^VALM("IBDF UTIL COMPLETE LIST TEMP")
 Q
 ;
 ;
HDR ; -- header code
 S VALMHDR(1)="This screen displays the most current invalid codes for the "_IBDFDIS_" file."
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
INIT ;  -- Set up list for display
 N IBDFCODE,IBDFDESC,IBDFIFN,IBDFCAT
 S (IBDCNT,VALMCNT,IBDCNT1)=0
 D @(IBDFDIS)
 Q
 ;
 ;  -- Gets CPT listing of invalid codes
CPT D FULL^VALM1 F IBDFIFN=0:0 S IBDFIFN=$O(^ICPT(IBDFIFN)) Q:'IBDFIFN  D
 .;; --change to api cpt ; dhh
 .;;     --note: 7th piece is status 0-inactive 1-active
 . S IBDFNODE=$$CPT^ICPTCOD(IBDFIFN),IBDFNODE=$G(IBDFNODE)
 . I $P(IBDFNODE,"^",7)=0 D
 .. S IBDFCODE=$P(IBDFNODE,"^",2),IBDFDESC=$P(IBDFNODE,"^",3)
 .. S IBDFCAT=$S($P(IBDFNODE,"^",4)]"":$P(^DIC(81.1,$P(IBDFNODE,"^",4),0),"^",1),1:"UNKNOWN") D ALPHA
 D LOOP
 Q
 ;
 ;  -- Gets ICD9 listing onf invalid codes
 ;  -- Use api for ICD9
ICD9 ;;F IBDFIFN=0:0 S IBDFIFN=$O(^ICD9(IBDFIFN)) Q:'IBDFIFN  S IBDFNODE=$G(^ICD9(IBDFIFN,0)) I $P(IBDFNODE,"^",9)]"" D
 ;
 ;Use ICD API to check the status for CSV.  No date is passed so the
 ;default day is DT (today).  $P10 = status 0-inactive 1-active
 F IBDFIFN=0:0 S IBDFIFN=$O(^ICD9(IBDFIFN)) Q:'IBDFIFN  S IBDFNODE=$$ICDDX^ICDCODE(IBDFIFN) I '$P(IBDFNODE,U,10) D
 .S IBDFCODE=$P(IBDFNODE,"^",2),IBDFDESC=$P(IBDFNODE,"^",4),IBDFCAT=$S($P(IBDFNODE,"^",6)]""&($G(^ICM(+$P(IBDFNODE,"^",6),0))]""):$P(^ICM($P(IBDFNODE,"^",6),0),"^",1),1:"UNKNOWN") D ALPHA
 D LOOP
 Q
 ;
 ;
VISIT ;  -- Gets visit code listing of invalid codes
 N IEN
 F IBDFVST=0:0 S IBDFVST=$O(^IBE(357.69,"B",IBDFVST)) Q:'IBDFVST  D
 . S IEN=$O(^IBE(357.69,"B",IBDFVST,0))
 . Q:'IEN
 . S IBDFNODE=$$CPT^ICPTCOD(IBDFVST)
 . Q:$P(IBDFNODE,U,7)=1  ;(CSV) status 0-inactive 1-active
 . ;;Q:+IBDFNODE=-1
 . S IBDFIFN=+IBDFNODE
 . S IBDFCODE=$P(IBDFNODE,"^",2)
 . S IBDFDESC=$P(IBDFNODE,"^",3)
 . S IBDFCAT=$S($P(IBDFNODE,"^",4)]"":$P(^DIC(81.1,$P(IBDFNODE,"^",4),0),"^",1),1:"UNKNOWN")
 . D ALPHA
 D LOOP
 Q
 ;
 ;
LOOP ;  -- Loop thru global ^TMP("ALPHA",$J) alphabetic by category
 S IBDFCAT=0
 F IBDCAT=0:0 S IBDFCAT=$O(^TMP("ALPHA",$J,IBDFCAT)) Q:IBDFCAT']""  F IBDFIFN=0:0 S IBDFIFN=$O(^TMP("ALPHA",$J,IBDFCAT,IBDFIFN)) Q:'IBDFIFN  S IBDFNODE=$G(^TMP("ALPHA",$J,IBDFCAT,IBDFIFN)) D
 .S IBDFIFN=$P(IBDFNODE,"^",1)
 .S IBDFCODE=$P(IBDFNODE,"^",2)
 .S IBDFCAT=$P(IBDFNODE,"^",3)
 .S IBDFDESC=$P(IBDFNODE,"^",4)
 .D:'$D(IBDFC(IBDFCAT)) HEADER^IBDFLST1 D SET
 Q
 ;
 ;
SET ;  -- Set up list array
 S IBDCNT1=IBDCNT1+1
 S IBDCNT=IBDCNT+1,VALMCNT=VALMCNT+1
 S X=""
 S IBDFVAL=$J(IBDCNT1_")",5)
 S X=$$SETSTR(IBDFVAL,X,1,5)
 S IBDFVAL=IBDFCODE
 S X=$$SETSTR(IBDFVAL,X,7,8)
 S IBDFVAL=IBDFDESC
 S X=$$SETSTR(IBDFVAL,X,17,20)
 S IBDFVAL=IBDFCAT
 S X=$$SETSTR(IBDFVAL,X,39,20)
 ;
 ;
TMP ; -- Set up Array
 S ^TMP("CODE",$J,IBDCNT,0)=$$LOWER^VALM1(X),^TMP("CODE",$J,"IDX",VALMCNT,IBDCNT1)=""
 S ^TMP("CODEIDX",$J,IBDCNT1)=VALMCNT_"^"_IBDFIFN_"^"_IBDFCODE_"^"_IBDFCAT_"^"_IBDFDESC
 Q
 ;
 ;
ALPHA ;  - Alphabetize by category
 S ^TMP("ALPHA",$J,IBDFCAT,IBDFIFN)=IBDFIFN_"^"_IBDFCODE_"^"_IBDFCAT_"^"_IBDFDESC
 Q
 ;
 ;
QUIT ;  -- Kill variables and reset to last display if no change has been taken place.
 ;
 ;
EXIT K ^TMP("CODE",$J),^TMP("CODEIDX",$J),^TMP("ALPHA",$J)
 K IBDFC,IBDFTYP,IBDFCNT1,IBDCAT
 Q
 ;
 ;
JUMP ; -- Jump action to display a specific category on the screen.
 D FULL^VALM1
 I $D(XQORNOD(0)),$P(XQORNOD(0),"^",4)]"" S X=$P(XQORNOD(0),"^",4) S X=$P(X,"=",2) I X]"" D:X?1.6N JSEL S DIC=$S(IBDFDIS="ICD9":"^ICM(",1:"^DIC(81.1,"),DIC(0)="QEZ" D ^DIC K DIC G:Y<0 JMP S Y=+Y D JUMP1 Q
JMP S DIC=$S(IBDFDIS="ICD9":"^ICM(",1:"^DIC(81.1,"),DIC(0)="AEMN",DIC("A")="Select "_$S(IBDFDIS="ICD9":"ICD9",1:"CPT")_" category you wish to move to: "
 D ^DIC K DIC
 I X["^" S VALMBG=1,VALMBCK="R" Q
 ;
 ;
JUMP1 I Y<0 G JUMP
 N IBDFCAT
 S IBDFCAT=$S(IBDFDIS="ICD9":$P(^ICM(+Y,0),"^",1),1:$P(^DIC(81.1,+Y,0),"^",1))
 I '$D(IBDFC(IBDFCAT)) W !!,"There is no data listed for this Clinic Group" G JMP
 S VALMBG=+IBDFC(IBDFCAT) S VALMBCK="R" Q
 Q
 ;
 ;
JSEL ; -- Convert number selected to name
 S IBDVALM=X I $D(^TMP("CGIDX",$J,IBDVALM)) S X=$P(^TMP("CGIDX",$J,IBDVALM),"^",2),X=$P(^IBD(357.99,X,0),"^",1)
 Q
HLP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
