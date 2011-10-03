LA7DVEXT ;SFCIOFO/MJM/DALOI/PWC - Chemistry Extract Routine ;01/14/2000
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**53**;Sep 27, 1994
XTRCT ; Call with LRDFN, GMTS1, GMTS2, MAX (#occurrences) & SEX (M or F)
 N IDT,CNT,AGE
 I '$D(AGE) D DEM^VADPT
 S AGE=VADM(4)
 K ^TMP("LRC",$J)
 S IDT=GMTS1,CNT=0 F  S IDT=$O(^LR(LRDFN,"CH",IDT)) Q:IDT<1!(IDT>GMTS2)  D:CNT'>MAX CHSET
 K VADM
 Q
CHSET ; Sets Chemistry locals for printing
 N CDT,SITE,SPEC,PTR,ISVALID,GMI,ACC,LOC,COM,RDT,SNOMED
 S ISVALID=$P(^LR(LRDFN,"CH",IDT,0),U,3) Q:ISVALID=""
 S SNOMED=""
 S CDT=+^LR(LRDFN,"CH",IDT,0),SITE=$P(^(0),U,5),SPEC=$P(^LAB(61,SITE,0),U),SNOMED=$P(^(0),U,2),CNT=CNT+1
 I $D(EXPAND) S SPEC=SNOMED_";"_SPEC,ACC=$P(^LAB(61,SITE,0),U,6),ACC=$P(ACC," ",2,3)_" "_$P(ACC," "),LOC=$P(^(0),U,11) S RDT=$$HLDATE^HLFNC($P(^LR(LRDFN,"CH",IDT,0),U,3)),X=CDT D DATE S CDT=$$HLDATE^HLFNC(CDT)
 S PTR=1 F  S PTR=$O(^LR(LRDFN,"CH",IDT,PTR)) Q:PTR<1  D NXTST
 I $D(^LR(LRDFN,"CH",IDT,1,0)),($D(^TMP("LRC",$J,IDT))) D
 . S COM=0 F GMI=1:1 S COM=$O(^LR(LRDFN,"CH",IDT,1,COM)) Q:+COM'>0  S ^TMP("LRC",$J,IDT,"C",GMI)=^LR(LRDFN,"CH",IDT,1,COM,0)
 Q
DATE ; convert date from internal date format to MM/DD/YY TT:TT
 S X=$TR($$FMTE^XLFDT(X,"2ZM"),"@"," ")
 Q
NXTST ; Visit next node in ^(PTR) subtree
 N RESULT,FLAG,TEST,GMPC,GMSQN,TNM,DESCR,THER,UNIT,HI,LO,CIS
 S RESULT=$P(^LR(LRDFN,"CH",IDT,PTR),U),FLAG=$P(^(PTR),U,2),CIS=""
 I $D(EXPAND),(FLAG["*") S FLAG=$S(FLAG="L*":"LL",FLAG="H*":"HH",1:FLAG)
 S TEST=$O(^LAB(60,"C","CH;"_PTR_";1",0)) Q:TEST'>0
 S TNM=$S($L($P(^LAB(60,TEST,0),U))<19:$P(^(0),U),1:$P(^(.1),U))
 ; If Test Type field is neither "Output" or "Both" then quit
 I $S("BO"'[$P(^LAB(60,TEST,0),U,3):1,1:0) Q
 S GMSQN=$S($P($G(^LAB(60,TEST,.1)),U,6):$P($G(^(.1)),U,6),1:PTR/1000000)
 I $D(^LAB(60,TEST,10)) S CIS=^(10)
 I '$D(CIS) S CIS=""
 ;I $D(EXPAND),'$L(CIS) Q
 I $D(EXPAND) S TNM=CIS_";"_TNM
 ; Execute Print Code from file 60 to evaluate RESULT
 S RESULT=$$RESULT(TEST,RESULT,$G(RWIDTH))
 S DESCR=$S($D(^LAB(60,TEST,1,SITE,0)):^(0),1:""),THER=$S($L($P(DESCR,U,11,12))>1:1,1:0)
 S UNIT=$P(DESCR,U,7),LO=$S(THER:$P(DESCR,U,11),1:$P(DESCR,U,2)),HI=$S(THER:$P(DESCR,U,12),1:$P(DESCR,U,3))
 S @("LO="_$S($L(LO):LO,1:"""""")),@("HI="_$S($L(HI):HI,1:""""""))
 I $D(EXPAND),'$L(FLAG),(+$G(HI)'<+$G(RESULT)),(+$G(LO)'>+$G(RESULT)) S FLAG="N"
 F  Q:'$D(^TMP("LRC",$J,IDT,GMSQN))  Q:TEST=+^(GMSQN)  S GMSQN=GMSQN+1
 Q:$D(^TMP("LRC",$J,IDT,GMSQN))
 S ^TMP("LRC",$J,IDT,GMSQN)=CDT_U_SPEC_U_TNM_U_RESULT_U_FLAG_U_UNIT_U_LO_U_HI
 I $D(EXPAND) D XPND
 Q
XPND ; Appends additional data if required
 S ^TMP("LRC",$J,IDT,GMSQN)=^TMP("LRC",$J,IDT,GMSQN)_U_ACC_U_RDT_U_LOC
 Q
RESULT(TEST,RESULT,LRCW) ;Convert result to external format
 ;TEST=Test ptr to file 60
 ;RESULT=Test result
 ;LRCW=Optional width of variable. Default is 0
 N X,X1
 I +$G(LRCW)'>0 S LRCW=0
 S X1=$P($G(^LAB(60,TEST,.1)),"^",3),X1=$S($L(X1):X1,1:"$J(X,LRCW)"),X=RESULT,@("X="_X1)
 Q X
