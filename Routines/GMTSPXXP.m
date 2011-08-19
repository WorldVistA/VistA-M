GMTSPXXP ; SLC/SBW,KER - PCE Examination Comp ; 08/27/2002
 ;;2.7;Health Summary;**8,10,28,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA  3063  EXAM^PXRHS05
 ;   DBIA 10011  ^DIWP
 ;                    
MRE ; Most Recent Examination
 K ^TMP("PXE",$J)
 N MAX S MAX=1
 ;                    
 ;   This routine could be expanded to included
 ;   occurrence limits by setting max to GMTSNDM
 ;   and enabling occurrence limit for the 
 ;   component. Component name would have to 
 ;   change also.
 ;                    
 D EXAM^PXRHS05(DFN,GMTSEND,GMTSBEG,MAX) Q:'$D(^TMP("PXE",$J))
 N GMEXAM,GMDT,GMIFN,GMW,GMSITE,GMN0,GMN1,X,GMTSDAT,EXAM,RESULT
 N COMMENT,GMICL,GMTAB,GMTSLN
 S GMEXAM="" D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 F  S GMEXAM=$O(^TMP("PXE",$J,GMEXAM)) Q:GMEXAM=""  D  Q:$D(GMTSQIT)
 . S (GMDT,GMW)=0
 . F  S GMDT=$O(^TMP("PXE",$J,GMEXAM,GMDT)) Q:GMDT'>0  D  Q:$D(GMTSQIT)
 . . S GMIFN=0
 . . F  S GMIFN=$O(^TMP("PXE",$J,GMEXAM,GMDT,GMIFN)) Q:GMIFN'>0  D EXAMDSP Q:$D(GMTSQIT)
 K ^TMP("PXE",$J)
 Q
HDR ; Header
 W ?5,"Exam",?32,"Result",?47,"Date",?55,"Facility",!!
 Q
EXAMDSP ; Display Exam Data
 S GMN0=$G(^TMP("PXE",$J,GMEXAM,GMDT,GMIFN,0)) Q:GMN0']""
 S GMN1=$G(^TMP("PXE",$J,GMEXAM,GMDT,GMIFN,1))
 S GMSITE=$S($P(GMN1,U,3)]"":$E($P(GMN1,U,3),1,10),$P(GMN1,U,4)]"":$E($P(GMN1,U,4),1,10),1:"No Site")
 S X=$P(GMN0,U,2) D REGDT4^GMTSU S GMTSDAT=X
 S EXAM=$P(GMN0,U),RESULT=$P(GMN0,U,4)
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR W:GMW'>0!GMTSNPG EXAM
 W ?32,RESULT,?45,GMTSDAT,?57,GMSITE,!
 S COMMENT=$P($G(^TMP("PXE",$J,GMEXAM,GMDT,GMIFN,"COM")),U)
 I COMMENT]"" S GMICL=13,GMTAB=2 D FORMAT I $D(^UTILITY($J,"W")) D
 . F GMTSLN=1:1:^UTILITY($J,"W",DIWL) D LINE Q:$D(GMTSQIT)
 S GMW=1
 Q
FORMAT ; Format Line
 N DIWR,DIWF,X S DIWL=3,DIWR=80-(GMICL+GMTAB) K ^UTILITY($J,"W")
 S X=COMMENT D ^DIWP
 Q
LINE ; Write Line
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?13,^UTILITY($J,"W",DIWL,GMTSLN,0),!
 Q
