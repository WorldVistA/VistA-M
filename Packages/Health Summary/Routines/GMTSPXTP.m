GMTSPXTP ; SLC/SBW,KER - PCE Treatment Comp ; 08/27/2002
 ;;2.7;Health Summary;**8,10,28,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA  1242  TREAT^PXRHS06
 ;   DBIA 10011  ^DIWP
 ;                      
TRTMT ; Treatments within a Date Range and Service Category
 N SERCAT S SERCAT="AICTSORXHDE"
 ;                   
 ;   SERCAT is a sting containing service categories:
 ;       Ambulatory                        A
 ;       Inpatient                         I
 ;       Chart Review                      C
 ;       Telecommunications                T
 ;       Day Surgery                       S
 ;       Observation                       O
 ;       Nursing Home                      R
 ;       Ancillary                         X
 ;       Hospitalization                   H
 ;       Daily Hospitalization Ancillary   D 
 ;       Historical event encounters       E
 ;                     
 K ^TMP("PXT",$J)
 D TREAT^PXRHS06(DFN,GMTSEND,GMTSBEG,GMTSNDM,SERCAT) Q:'$D(^TMP("PXT",$J))
 N GMDT,GMIFN,GMSITE,GMN0,GMN1,X,GMTSDAT,TREAT,NUM,PDT
 N GMTXT,GMTSICL,DIWL,GMTAB,GMTSX,GMCKP,PNARR,GMPSITE,GMTR,PSITE
 N GMTSLN,GMICL,GMTAB,COMMENT S GMTSICL=24,DIWL=0,GMTAB=2,GMDT=0
 D CKP^GMTSUP Q:$D(GMTSQIT)  D HDR
 F  S GMDT=$O(^TMP("PXT",$J,GMDT)) Q:GMDT'>0  D  Q:$D(GMTSQIT)
 . S GMTR=""
 . F  S GMTR=$O(^TMP("PXT",$J,GMDT,GMTR)) Q:GMTR']""  D  Q:$D(GMTSQIT)
 . . S GMIFN=0
 . . F  S GMIFN=$O(^TMP("PXT",$J,GMDT,GMTR,GMIFN)) Q:GMIFN'>0  D TREATDSP Q:$D(GMTSQIT)
 K ^TMP("PXT",$J)
 Q
HDR ; Display Header
 W ?2,"Date",?10,"Facility",?22,"Treatment (Qty) ; Provider Narrative",!!
 Q
TREATDSP ; Display Treatment Data
 S GMN0=$G(^TMP("PXT",$J,GMDT,GMTR,GMIFN,0)) Q:GMN0']""
 S GMN1=$G(^TMP("PXT",$J,GMDT,GMTR,GMIFN,1))
 S GMSITE=$S($P(GMN1,U,3)]"":$E($P(GMN1,U,3),1,10),$P(GMN1,U,4)]"":$E($P(GMN1,U,4),1,10),1:"No Site")
 S X=$P(GMN0,U,2)
 D REGDT4^GMTSU S GMTSDAT=X
 S TREAT=$P(GMN0,U),NUM=$P(GMN0,U,3)
 S PNARR=$G(^TMP("PXT",$J,GMDT,GMTR,GMIFN,"P")) S:PNARR=TREAT PNARR=""
 S GMTXT=TREAT_$S(NUM]"":" ("_NUM_")",1:"")_$S(PNARR]"":"; "_PNARR,1:"")
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 I GMTSDAT'=$G(PDT)!GMTSNPG W GMTSDAT S PDT=GMTSDAT,PSITE=""
 I GMSITE'=$G(PSITE) W ?12,GMSITE S PSITE=GMSITE
 D TXTFMT^GMTSPXU1(GMTXT,"",GMTSICL,GMTAB,DIWL)
 I '$D(^UTILITY($J,"W")) Q
 S (GMTSX,GMCKP)=0
 F  S GMTSX=$O(^UTILITY($J,"W",DIWL,GMTSX)) Q:GMTSX'>0!$D(GMTSQIT)  D
 . I GMCKP>0 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR W:GMTSNPG GMTSDAT,?10,GMSITE
 . S GMCKP=1
 . W ?GMTSICL+$S(GMTSX>1:GMTAB,1:0),$G(^UTILITY($J,"W",DIWL,GMTSX,0)),!
 S COMMENT=$P($G(^TMP("PXT",$J,GMDT,GMTR,GMIFN,"COM")),U)
 I COMMENT]"" S GMICL=26,GMTAB=2 D FORMAT I $D(^UTILITY($J,"W")) D
 . F GMTSLN=1:1:^UTILITY($J,"W",DIWL) D LINE Q:$D(GMTSQIT)
 Q
FORMAT ; Format Line
 N DIWR,DIWF,X S DIWL=3,DIWR=80-(GMICL+GMTAB) K ^UTILITY($J,"W")
 S X=COMMENT D ^DIWP
 Q
LINE ; Write Line
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?26,^UTILITY($J,"W",DIWL,GMTSLN,0),!
 Q
