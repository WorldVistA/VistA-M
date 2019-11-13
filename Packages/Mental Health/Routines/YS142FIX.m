YS142FIX ;SLC/KCM - Patch 142 fix scores with extra scales ; 03/20/2017
 ;;5.01;MENTAL HEALTH;**142**;Dec 30, 1994;Build 14
 ;
ADM2019 ; loop through administrations from 2019
 N YS142S,YS142T,YS142D,YS142A,YS142U ; scales,test,date,admin,updates
 D BLDSCL
 S ^XTMP("YTS-RESCORE",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"MH Extraneous Scores"
 S YS142U=0
 S YS142T=0 F  S YS142T=$O(^YTT(601.84,"AC",YS142T)) Q:'YS142T  D
 . S YS142D=3190000 F  S YS142D=$O(^YTT(601.84,"AC",YS142T,YS142D)) Q:'YS142D  D
 . . S YS142A=0 F  S YS142A=$O(^YTT(601.84,"AC",YS142T,YS142D,YS142A)) Q:'YS142A  D
 . . . I $$SCALERR(YS142A) D RESCORE(YS142A)
 S ^XTMP("YTS-RESCORE","SCALE-UPDATES")=YS142U
 Q
RESCORE(YS142A) ; delete results and rescore admin
 ; expects YS142U (update count)
 D DELRSLTS^YTSCOREV(YS142A)
 S $P(^YTT(601.84,YS142A,0),U,12)=0 ; force re-score to current revision
 I $$SCOREONE^YTSCOREV(YS142A) S YS142U=YS142U+1
 Q
SCALERR(YS142A) ; return 1 if more scale scores than expected
 N TEST,CNT,RSLT,IEN
 S TEST=$P($G(^YTT(601.84,YS142A,0)),U,3)
 I '$G(YS142S(TEST),0) QUIT 0
 ;
 S CNT=0,RSLT=0
 S IEN=0 F  S IEN=$O(^YTT(601.92,"AC",YS142A,IEN)) Q:'IEN  D  Q:RSLT
 . S CNT=CNT+1
 . I CNT>YS142S(TEST) S RSLT=1
 Q RSLT
 ;
BLDSCL ; Build scales into YS142S
 ; builds array of scale counts per instrument
 N TEST,SCLCNT,GSEQ,GRP,SSEQ,SCL
 S TEST=0 F  S TEST=$O(^YTT(601.71,TEST)) Q:'TEST  D
 . I $P($G(^YTT(601.71,TEST,2)),U,2)'="Y" QUIT  ; is active instrument?
 . S SCLCNT=0
 . S GSEQ=0 F  S GSEQ=$O(^YTT(601.86,"AC",TEST,GSEQ)) Q:'GSEQ  D
 . . S GRP=0 F  S GRP=$O(^YTT(601.86,"AC",TEST,GSEQ,GRP)) Q:'GRP  D
 . . . S SSEQ=0 F  S SSEQ=$O(^YTT(601.87,"AC",GRP,SSEQ)) Q:'SSEQ  D
 . . . . S SCL=0 F  S SCL=$O(^YTT(601.87,"AC",GRP,SSEQ,SCL)) Q:'SCL  D
 . . . . . S SCLCNT=SCLCNT+1
 . S YS142S(TEST)=SCLCNT ;_U_$P(^YTT(601.71,TEST,0),U)
 Q
QTASK(RESUME) ; Create background task for checking extraneous scales
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 S ZTIO=""
 S ZTRTN="ADM2019^YS142FIX"
 S ZTDESC="Check extraneous MH scales"
 S ZTDTH=RESUME
 D ^%ZTLOAD
 I '$G(ZTSK) D MES^XPDUTL("Unsuccessful queue of re-scoring job.")
 Q
