GMTSPXEP ; SLC/SBW,KER - PCE Patient Education comp ; 08/27/2002
 ;;2.7;Health Summary;**8,10,28,35,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA  3063  EDUC^PXRHS08
 ;   DBIA 10011  ^DIWP
 ;                     
PTED ; Patient Education
 N GMTSOVT K ^TMP("PXPE",$J) S GMTSOVT="AICTSORXHDE"
 ;                      
 ;   GMTSOVT is a sting containing a set of Service 
 ;   Categories for:
 ;                      
 ;    Ambulatory                      A
 ;    Inpatient                       I
 ;    Chart Review                    C
 ;    Telecommunications              T
 ;    Day Surgery                     S
 ;    Observation                     O
 ;    Nursing Home                    R
 ;    Ancillary                       X
 ;    Hospitalization                 H
 ;    Daily Hospitalization Ancillary D
 ;    Event-Historical                E
 ;                      
 D EDUC^PXRHS08(DFN,GMTSEND,GMTSBEG,GMTSNDM,GMTSOVT)
 Q:'$D(^TMP("PXPE",$J))  D CKP^GMTSUP Q:$D(GMTSQIT)  D HDR,EDMAIN
 Q
MRPTED ; Most recent patient education
 N GMTSOVT,LATEST K ^TMP("PXPE",$J) S LATEST="R",GMTSOVT="AICTSORXHDE"
 ;                      
 ;   Returns most recent Patient Education Topic Types 
 ;   for time period.  GMTSOVT is a sting containing a
 ;   set of Service Categories for:
 ;                      
 ;    Ambulatory                      A
 ;    Inpatient                       I
 ;    Chart Review                    C
 ;    Telecommunications              T
 ;    Day Surgery                     S
 ;    Observation                     O
 ;    Nursing Home                    R
 ;    Ancillary                       X
 ;    Hospitalization                 H
 ;    Daily Hospitalization Ancillary D
 ;    Event-Historical                E
 ;                      
 D EDUC^PXRHS08(DFN,GMTSEND,GMTSBEG,LATEST,GMTSOVT)
 Q:'$D(^TMP("PXPE",$J))
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 D EDMAIN
 Q
HDR ; Header
 W ?2,"Date",?12,"Facility",?25,"Topic - Understanding Level",!!
 Q
EDMAIN ; Main Education Display
 N GMDT,GMED,GMIFN,GMN0,GMN1,X,GMTSDAT,ED,LEVEL,GMSITE,PSITE,PDT,LTXT
 N COMMENT,GMICL,GMTSLN,GMTAB
 S GMDT=0
 F  S GMDT=$O(^TMP("PXPE",$J,GMDT)) Q:GMDT'>0  D  Q:$D(GMTSQIT)
 . S GMED=""
 . F  S GMED=$O(^TMP("PXPE",$J,GMDT,GMED)) Q:GMED']""  D  Q:$D(GMTSQIT)
 . . S GMIFN=0
 . . F  S GMIFN=$O(^TMP("PXPE",$J,GMDT,GMED,GMIFN)) Q:GMIFN'>0  D  Q:$D(GMTSQIT)
 . . . S GMN0=$G(^TMP("PXPE",$J,GMDT,GMED,GMIFN,0))
 . . . Q:GMN0']""
 . . . S GMN1=$G(^TMP("PXPE",$J,GMDT,GMED,GMIFN,1))
 . . . S GMSITE=$S($P(GMN1,U,3)]"":$E($P(GMN1,U,3),1,10),$P(GMN1,U,4)]"":$E($P(GMN1,U,4),1,10),1:"No Site")
 . . . S X=$P(GMN0,U,2) D REGDT4^GMTSU S GMTSDAT=X
 . . . S LTXT="",ED=$P(GMN0,U),LEVEL=$P(GMN0,U,3)
 . . . I LEVEL]"" S LTXT=" - "_LEVEL
 . . . I LEVEL="POOR"!(LEVEL="FAIR")!(LEVEL="GOOD") S LTXT=LTXT_" UNDERSTANDING"
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 . . . I GMTSDAT'=$G(PDT)!GMTSNPG W GMTSDAT S PDT=GMTSDAT,PSITE=""
 . . . I GMSITE'=$G(PSITE) W ?12,GMSITE S PSITE=GMSITE
 . . . W ?25,ED,$G(LTXT),!
 . . . S COMMENT="",COMMENT=$P(^TMP("PXPE",$J,GMDT,GMED,GMIFN,"COM"),U)
 . . . I COMMENT]"" S GMICL=26,GMTAB=2 D FORMAT I $D(^UTILITY($J,"W")) D 
 . . . . F GMTSLN=1:1:^UTILITY($J,"W",DIWL) D LINE Q:$D(GMTSQIT)
 K ^TMP("PXPE",$J)
 Q
FORMAT ; Format Line
 N DIWR,DIWF,X S DIWL=3,DIWR=80-(GMICL+GMTAB)
 K ^UTILITY($J,"W") S X=COMMENT D ^DIWP
 Q
LINE ; Write Line
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?26,^UTILITY($J,"W",DIWL,GMTSLN,0),!
 Q
