GMTSPXEP ; SLC/SBW,KER,PKR - PCE Patient Education comp ; 08/24/2017
 ;;2.7;Health Summary;**8,10,28,35,56,122**;Oct 20, 1995;Build 28
 ;
 ; External References
 ;   DBIA  3063  EDUC^PXRHS08
 ;   DBIA 10011  ^DIWP
 ;   DBIA  6225  UCUMCODE^LEXMUCUM
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
 D EDUC^PXRHS08(DFN,GMTSBEG,GMTSEND,GMTSNDM,GMTSOVT)
 Q:'$D(^TMP("PXPE",$J))  D CKP^GMTSUP Q:$D(GMTSQIT)  D HDR,EDMAIN
 Q
 ;
MRPTED ; Most recent patient education
 N GMTSOVT K ^TMP("PXPE",$J) S GMTSOVT="AICTSORXHDE"
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
 D EDUC^PXRHS08(DFN,GMTSBEG,GMTSEND,1,GMTSOVT)
 Q:'$D(^TMP("PXPE",$J))
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 D EDMAIN
 Q
 ;
HDR ; Header
 W ?2,"Date",?12,"Facility",?25,"Topic - Understanding Level",!!
 Q
 ;
EDMAIN ; Main Education Display
 N COMMENT,DATASRC,ED,GMDT,GMED,GMICL,GMIFN,GMN0,GMN1,GMTSDATE,GMSITE
 N GMTSLN,GMTAB,LEVEL,LTXT,PSITE,PDT,TEXT,X
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
 . . . S X=$P(GMN0,U,2) D REGDT4^GMTSU S GMTSDATE=X
 . . . S LTXT="",ED=$P(GMN0,U),LEVEL=$P(GMN0,U,3)
 . . . I LEVEL]"" S LTXT=" - "_LEVEL
 . . . D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HDR
 . . . I GMTSDATE'=$G(PDT)!GMTSNPG W GMTSDATE S PDT=GMTSDATE,PSITE=""
 . . . I GMSITE'=$G(PSITE) W ?12,GMSITE S PSITE=GMSITE
 . . . S TEXT=ED_$G(LTXT)
 . . . I $L(TEXT)<56 W ?25,TEXT,!
 . . . E  D LONGTEXT(TEXT)
 . . . I $G(^TMP("PXPE",$J,GMDT,GMED,GMIFN,"MEASUREMENT"))'="" D
 . . . . N MEAS
 . . . . S MEAS=^TMP("PXPE",$J,GMDT,GMED,GMIFN,"MEASUREMENT")
 . . . . S TEXT="Measurement: "_$P(MEAS,U,1)
 . . . . I $P(MEAS,U,2)'="" S TEXT=TEXT_" "_$$UCUMCODE^LEXMUCUM($P(MEAS,U,2))
 . . . . I $L(TEXT)<56 W ?25,TEXT,!
 . . . . E  D LONGTEXT(TEXT)
 . . . S COMMENT=$P(^TMP("PXPE",$J,GMDT,GMED,GMIFN,"COM"),U,1)
 . . . I COMMENT]"" S GMICL=26,GMTAB=2 D FORMAT I $D(^UTILITY($J,"W")) D 
 . . . . F GMTSLN=1:1:^UTILITY($J,"W",DIWL) D LINE Q:$D(GMTSQIT)
 . . . S DATASRC=^TMP("PXPE",$J,GMDT,GMED,GMIFN,"S")
 . . . I DATASRC'="" D
 . . . . S DATASRC=$P(^PX(839.7,DATASRC,0),U,1)
 . . . . W ?25,"Data Source: ",DATASRC,!
 K ^TMP("PXPE",$J)
 Q
 ;
FORMAT ; Format Line
 N DIWR,DIWF,X S DIWL=3,DIWR=80-(GMICL+GMTAB)
 K ^UTILITY($J,"W") S X=COMMENT D ^DIWP
 Q
 ;
LINE ; Write Line
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?26,^UTILITY($J,"W",DIWL,GMTSLN,0),!
 Q
 ;
LONGTEXT(TEXT) ;
 N BPT,IND
 S BPT=55
 F IND=55:-1  Q:(BPT<55)!(IND=1)  I $E(TEXT,IND)=" " S BPT=IND
 W ?25,$E(TEXT,1,BPT),!
 W ?25,$E(TEXT,(BPT+1),$L(TEXT)),!
 Q
 ;
