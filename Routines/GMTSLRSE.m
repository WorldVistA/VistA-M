GMTSLRSE ; SLC/JER,KER - Selected Lab Test Extract ; 09/21/2001
 ;;2.7;Health Summary;**28,36,47,79**;Oct 20, 1995
 ;
 ; External References
 ;    DBIA    67   ^LAB(60
 ;    DBIA   524   ^LAB(61
 ;    DBIA   525   ^LR( 
 ;
XTRCT ; Extract Selected Lab Test
 ;
 ; Call with    LRDFN    lab patient
 ;              GMTS1    begin date
 ;              GMTS2    end date
 ;              MAX      occurence limit
 ;              SEX      "M" or "F"
 ;              TEST     IFN to ^LAB(60)
 ;              RWIDTH   optional
 ;
 ; Returns      ^TMP("LRS",$J,GMTSI,IDRWDT)=
 ;              DRWDT^SPEC^TEST^RESULT^FLAG^UNIT^LO^HI
 ;
 ; Where        GMTSI=Order (1 to MAX)
 ;              IDRWDT=9999999-Draw Date/time
 ;              DRWDT=Draw Date/Time (internal)
 ;              SPEC=Specimen (int;ext)
 ;              TEST=Test (int;ext)
 ;              RESULT=Numeric Result
 ;              FLAG=Reference flag (H,*H,L,*L)
 ;              UNIT=Unit of measure (ext)
 ;              LO=Reference/Therapeutic Lower bound
 ;              HI=Ref/Ther Upper Bound
 ;
 N CNT,AGE,COM,GMI,X K ^TMP("LRS",$J,GMTSI) I $S("BO"'[$P(^LAB(60,TEST,0),U,3):1,1:0) Q
 D DEM^GMTSU S AGE=GMTSAGE S CNT=0 D CHEM:$P(^LAB(60,TEST,0),U,4)="CH"
 Q
CHEM ; Gets all Chemistry tests w/in time/occurrence constraints
 N PTR,IDRWDT S PTR=+$P($P(^LAB(60,+TEST,0),U,5),";",2),IDRWDT=GMTS1
 F  S IDRWDT=$O(^LR(LRDFN,"CH",IDRWDT)) Q:'IDRWDT!(IDRWDT>GMTS2)!(CNT'<MAX)  I $P(^(IDRWDT,0),U,3),($D(^(PTR))) S CNT=CNT+1 D:CNT'>MAX CHSET
 Q
CHSET ; Sets Chemistry locals for printing
 N RESULT,FLAG,DRWDT,SITE,SPEC,TNM,DESCR,THER,UNIT,HI,LO,GMIDT,GMTSLRES
 S GMTSLRES=$$TSTRES^LRRPU(LRDFN,"CH",IDRWDT,PTR)
 ; S RESULT=$P(^LR(LRDFN,"CH",IDRWDT,PTR),U),FLAG=$P(^(PTR),U,2),DRWDT=9999999-IDRWDT
 S RESULT=$P(GMTSLRES,U,1),FLAG=$P(GMTSLRES,U,2),DRWDT=9999999-IDRWDT
 S RESULT=$$RESULT^GMTSLRCE(TEST,RESULT,$G(RWIDTH))
 S X=DRWDT D REGDTM4^GMTSU S DRWDT=X K X
 S SITE=$P(^LR(LRDFN,"CH",IDRWDT,0),U,5),SPEC=SITE_";"_$P(^LAB(61,SITE,0),U)
 S TNM=TEST_";"_$S($L($P(^LAB(60,TEST,0),U))<21:$P(^(0),U),1:$P(^(.1),U))
 ; S DESCR=$S($D(^LAB(60,TEST,1,SITE,0)):^(0),1:""),THER=$S($L($P(DESCR,U,11,12))>1:1,1:0)
 ; S UNIT=$P(DESCR,U,7),LO=$S(THER:$P(DESCR,U,11),1:$P(DESCR,U,2)),HI=$S(THER:$P(DESCR,U,12),1:$P(DESCR,U,3))
 S UNIT=$P(GMTSLRES,U,5),LO=$P(GMTSLRES,U,3),HI=$P(GMTSLRES,U,4)
 ; S @("LO="_$S($L(LO):LO,1:"""""")),@("HI="_$S($L(HI):HI,1:""""""))
 I $D(^TMP("LRS",$J,GMTSI,IDRWDT)) S GMIDT=IDRWDT+.0001
 S GMIDT=IDRWDT
 S ^TMP("LRS",$J,GMTSI,GMIDT)=DRWDT_U_$E(SPEC,1,10)_U_TNM_U_RESULT_U_FLAG_U_UNIT_U_LO_U_HI
 I $D(^LR(LRDFN,"CH",IDRWDT,1,0)) D
 . S COM=0
 . F GMI=1:1 S COM=$O(^LR(LRDFN,"CH",IDRWDT,1,COM)) Q:+COM'>0  S ^TMP("LRS",$J,"C",GMIDT,GMI)=^LR(LRDFN,"CH",IDRWDT,1,COM,0)
 Q
