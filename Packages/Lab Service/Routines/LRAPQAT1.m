LRAPQAT1 ;AVAMC/REG/CYM,WOIFO/PMK - QA CODE SEARCH ;12/31/2014 11:06 AM
 ;;5.2;LAB SERVICE;**201,315,422,442**;Sep 27, 1994;Build 15
 ;
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ; Reference to $$ICDOP^ICDEX supported by ICR #5747
 ; Reference to DGPTFUT supported by IA #6130
 ;
 D EN^LRUA S (LR("W"),LRS(5),LRQ(9),LRQ(3))=1,LRSDT=9999999-LRSDT,LRP=0
 F LRB=0:0 S LRP=$O(^TMP("LRAP",$J,LRP)) Q:LRP=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^TMP("LRAP",$J,LRP,LRDFN)) Q:'LRDFN!(LR("Q"))  S X=^(LRDFN) D L
 Q
L S DFN=$P(X,"^",2),LRQ=0,SEX=$P(X,"^",4),SSN=$P(X,"^"),Y=$P(X,"^",3) S DOB=$$FMTE^XLFDT(Y)
 G:'$D(^LR(LRDFN,"SP"))&('$D(^LR(LRDFN,"CY")))&('$D(^LR(LRDFN,"EM"))) AU
 D ^LRAPT1 Q:LR("Q")
AU I $D(^LR(LRDFN,"AU")),+^("AU") D ^LRAPT2
 Q:'DFN!(LR("Q"))  D INP^VADPT Q:VAIN(1)']""  D A
 Q
A S LRPTF=VAIN(10)
 S LRADM=$P(VAIN(7),U,2)
 S LRWARD=$P(VAIN(4),U,2)
 S LRTS=$P(VAIN(3),U,2)
 K VAIN
 N LRC,LRF
 W !,"Adm: ",$P(LRADM,"@"),?35,LRWARD
 W !,?12,"Specialty: ",$P(LRADM,"@"),?35,LRTS
 Q:'LRPTF
 D LOOKUP(LRPTF,.LRF,.LRC)
 ; output the results 
 N LRTMP,LRX
 F LRTMP=0:0 S LRTMP=$O(LRF(LRTMP)) Q:'LRTMP  D
 . S LRX=$$ICDDX^ICDEX(LRTMP,,,"I")
 . I +LRX=-1 Q
 . W !,$P(LRX,"^",2),?10,$P(LRX,"^",4)
 . Q
 F LRTMP=0:0 S LRTMP=$O(LRC(LRTMP)) Q:'LRTMP  D
 . S LRX=$$ICDOP^ICDEX(LRTMP,,,"I")
 . I +LRX=-1 Q
 . W !,$P(LRX,"^",2),?10,$P(LRX,"^",5)
 . Q
 Q
 ;
LOOKUP(LRPTF,LRF,LRC) ; get icd codes from Patient Treatment File
 D GETCODES(701,LRPTF,.LRF) ; 70 - primary/secondary diagnosis
 D GETCODES(501,LRPTF,.LRF) ; M - movements
 D GETCODES(601,LRPTF,.LRC) ; P - procedures
 D GETCODES(401,LRPTF,.LRC) ; S - surgeries
 Q
 ;
GETCODES(DGA,DGB,ARRAY) ; get codes from Patient Treatment File (#45)
 N DGC,DGD,I
 I DGA=701 D
 . D PTFICD^DGPTFUT(DGA,DGB,,.DGD),COPY(.DGD,.ARRAY)
 . Q
 E  D
 . D PTFIEN^DGPTFUT(DGA,DGB,.DGC)
 . S I="" F  S I=$O(DGC(I)) Q:I=""  D
 . . D PTFICD^DGPTFUT(DGA,DGB,I,.DGD),COPY(.DGD,.ARRAY)
 . . Q
 . Q
 Q
 ;
COPY(DGD,ARRAY) ; copy results into ARRAY
 N I
 S I="" F  S I=$O(DGD(I)) Q:I=""  S ARRAY($P(DGD(I),"^",1))=""
 Q
 ;
