IBDFLST ;ALM/MAF - Maintenance Utility Invalid Codes List ;05/17/95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**9,38,51,63**;APR 24, 1997;Build 80
 ;
 ;
 ;
START ;  -- Ask what invalid code you want to display CPT/ ICD9/ Visit
 N IBDFDIS
 D FULL^VALM1
 S DIR("B")="CPT"
 ;
 S DIR(0)="SA^C:CPT;I:ICD9;D:ICD10;V:VISIT",DIR("A")="Display invalid codes for [C]PT, [I]CD9, IC[D]10, [V]ISIT: " D ^DIR
 K DIR I $D(DIRUT)!(Y<0) G QUIT
 ;W !!,"Display invalid codes for CPT// " D ZSET1^IBDFLST1 S X="" R X:DTIME G QUIT:X="^"!('$T) I X=""!("Cc"[X) S X="1"
 S X=$S("Ii"[X:2,"Dd"[X:3,"Vv"[X:4,1:1) ; 
 ;I X="?" D ZSET1^IBDFLST1,HELP1^IBDFLST1 G START
 S IBDFTYP=$E(X)  ; D IN^DGHELP W ! I %=-1 D ZSET1^IBDFLST1,HELP1^IBDFLST1 G START
 S IBDFDIS=$S(IBDFTYP=1:"CPT",IBDFTYP=2:"ICD9",IBDFTYP=3:"ICD10",IBDFTYP=4:"VISIT",1:"QUIT")
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
 N IBDFCODE,IBDFDESC,IBDFIFN,IBDFCAT,IBDFNODE
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
 ;  -- Gets ICD9 listing of invalid codes
 ;  -- Use api for ICD9
ICD9 ;;F IBDFIFN=0:0 S IBDFIFN=$O(^ICD9(IBDFIFN)) Q:'IBDFIFN  S IBDFNODE=$G(^ICD9(IBDFIFN,0)) I $P(IBDFNODE,"^",9)]"" D
 ;
 ;Use ICD API to check the status for CSV.  No date is passed so the
 ;default day is DT (today).  $P10 = status 0-inactive 1-active
 D ICD9LST
 ;F IBDFIFN=0:0 S IBDFIFN=$O(^ICD9(IBDFIFN)) Q:'IBDFIFN  S IBDFNODE=$$ICDDX^ICDCODE(IBDFIFN) I '$P(IBDFNODE,U,10) D
 S IBDFIFN="" F  S IBDFIFN=$O(^TMP("IBDICD9",$J,"DILIST","ICD",IBDFIFN)) Q:IBDFIFN=""  S IBDFNODE=^TMP("IBDICD9",$J,"DILIST","ICD",IBDFIFN) D
 .S IBDFCODE=$P(IBDFNODE,"^",2),IBDFDESC=$P(IBDFNODE,"^",4),IBDFCAT=$S($P(IBDFNODE,"^",6)]""&($G(^ICM(+$P(IBDFNODE,"^",6),0))]""):$P(^ICM($P(IBDFNODE,"^",6),0),"^",1),1:"UNKNOWN") D ALPHA
 D LOOP
 Q
 ;
ICD10 ;
 ;Use ICD API to check the status for CSV. No date is passed so the
 ;default day is DT (today). $P10 = status 0-inactive 1-active 2-inactive
 D ICD10LST
 S IBDFIFN=0 F  S IBDFIFN=$O(^TMP("IBDICD10",$J,"DILIST","ICD",IBDFIFN)) Q:IBDFIFN=""  S IBDFNODE=^TMP("IBDICD10",$J,"DILIST","ICD",IBDFIFN) D
 .S IBDFCODE=$P(IBDFNODE,"^",2),IBDFDESC=$P(IBDFNODE,"^",4),IBDFCAT=$S($P(IBDFNODE,"^",6)]""&($G(^ICM(+$P(IBDFNODE,"^",6),0))]""):$P(^ICM($P(IBDFNODE,"^",6),0),"^",1),1:"UNKNOWN") D ALPHA
 D LOOP
 Q
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
LOOP ;  -- Loop thru global ^TMP("IBDALPHA",$J) alphabetic by category
 I '$D(^TMP("IBDALPHA",$J)),IBDFDIS="ICD10" D  Q  ;
 .S X="There are no ICD10 invalid code lists on file."
 .S IBDCNT1=IBDCNT1+1,VALMCNT=VALMCNT+1
 .S ^TMP("IBDCODE",$J,2,0)=X
 .S ^TMP("IBDCODE",$J,"IDX",VALMCNT,IBDCNT1)=""
 S IBDFCAT=0
 F IBDCAT=0:0 S IBDFCAT=$O(^TMP("IBDALPHA",$J,IBDFCAT)) Q:IBDFCAT']""  F IBDFIFN=0:0 S IBDFIFN=$O(^TMP("IBDALPHA",$J,IBDFCAT,IBDFIFN)) Q:'IBDFIFN  S IBDFNODE=$G(^TMP("IBDALPHA",$J,IBDFCAT,IBDFIFN)) D
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
 S IBDFVAL=$J(IBDCNT1_")",7)
 S X=$$SETSTR(IBDFVAL,X,1,7)
 S IBDFVAL=IBDFCODE
 S X=$$SETSTR(IBDFVAL,X,9,8)
 S IBDFVAL=IBDFDESC
 S X=$$SETSTR(IBDFVAL,X,19,20)
 S IBDFVAL=IBDFCAT
 S X=$$SETSTR(IBDFVAL,X,41,20)
 ;
 ;
TMP ; -- Set up Array
 S ^TMP("IBDCODE",$J,IBDCNT,0)=$S($G(IBDFDIS)["ICD9":X,$G(IBDFDIS)["ICD10":X,1:$$LOWER^VALM1(X))
 S ^TMP("IBDCODE",$J,"IDX",VALMCNT,IBDCNT1)=""
 S ^TMP("CODEIDX",$J,IBDCNT1)=VALMCNT_"^"_IBDFIFN_"^"_IBDFCODE_"^"_IBDFCAT_"^"_IBDFDESC
 Q
 ;
 ;
ALPHA ;  - Alphabetize by category
 S ^TMP("IBDALPHA",$J,IBDFCAT,IBDFIFN)=IBDFIFN_"^"_IBDFCODE_"^"_IBDFCAT_"^"_IBDFDESC
 Q
 ;
 ;
QUIT ;  -- Kill variables and reset to last display if no change has been taken place.
 ;
 ;
EXIT K ^TMP("IBDCODE",$J),^TMP("CODEIDX",$J),^TMP("IBDALPHA",$J),^TMP("IBDICD9",$J),^TMP("IBDICD10",$J)
 K ^TMP("IBDMSG9"),^TMP("IBDMSG10")
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
 ;NEW CODE
 ; ICD-9 ICR 2051/5745 (by subscription) 
ICD9LST ;
 N IBDSCREN
 K ^TMP("IBDICD9",$J)
 S IBDSCREN="N ICD S ICD=$$ICDDX^ICDEX(+Y,$G(DT),1,""I"") I $P(ICD,U,10)=""0"",$P(ICD,U,12)?7N,$P(ICD,U,20)=1 S ^TMP(""IBDICD9"",$J,""DILIST"",""ICD"",+Y)=ICD"
 D LIST^DIC(80,,,,,,,,IBDSCREN,,"^TMP(""IBDICD9"",$J)","^TMP(""IBDMSG9"",$J)")
 Q
 ;;
 ; ICD-10 ICR 2051/5745 (by subscription) 
 ;This returns no entries since there are no invalid ICD-10 codes
ICD10LST ;
 N IBDSCREN
 K ^TMP("IBDICD10",$J)
 S IBDSCREN="N STATUS S STATUS=$$STATCHK^IBDUTICD(""10D"",+Y,$G(DT)) I STATUS=0!(STATUS=2) N ICD S ICD=$$ICDDATA^ICDXCODE(""10D"",+Y,$G(DT)) I $P(ICD,U,20)=30 S ^TMP(""IBDICD10"",$J,""DILIST"",""ICD"",+Y)=ICD"
 D LIST^DIC(80,,,,,,,,IBDSCREN,,"^TMP(""IBDICD10"",$J)","^TMP(""IBDMSG10"",$J)")
 Q
 ;IBDFLST
