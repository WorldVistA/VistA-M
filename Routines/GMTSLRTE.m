GMTSLRTE ; SLC/JER,KER - Transfusion Record Extract Routine ; 01/06/2003
 ;;2.7;Health Summary;**56,58**;Oct 20, 1995
 ;                     
 ; External References
 ;   DBIA 10035  ^DPT(
 ;   DBIA   528  ^LAB(66
 ;   DBIA   525  ^LR(
 ;                     
XTRCT ; Extract Transfusion Records
 N LRDFN,IDT,CNTR,TR,PN,PRODUCT
 S:'$D(GMTS1) GMTS1=6666666 S:'$D(GMTS2) GMTS2=9999999
 K ^TMP("LRT",$J)
 Q:'$D(^DPT(DFN,"LR"))  S LRDFN=+^DPT(DFN,"LR"),IDT=GMTS1-1
 I '$D(^LR(LRDFN)) Q
 S IDT=GMTS1-1 F  S IDT=$O(^LR(LRDFN,1.6,IDT)) Q:+IDT'>0!(IDT>GMTS2)  D
 . S TR=$G(^LR(LRDFN,1.6,IDT,0)) D SET
 S IDT=0 F  S IDT=$O(CNTR(IDT)) Q:+IDT'>0  D
 . S ^TMP("LRT",$J,IDT)=9999999-IDT_U
 . S PN=0 F  S PN=$O(CNTR(IDT,PN)) Q:PN'>0  D
 . . S PRODUCT=$G(^LAB(66,+PN,0)),^TMP("LRT",$J,$P(PRODUCT,U,2))=$P(PRODUCT,U)
 . . S ^TMP("LRT",$J,IDT)=^TMP("LRT",$J,IDT)_CNTR(IDT,PN)_"\"_$P(PRODUCT,U,2)_";"
 Q
SET ; Save Appropriate Data
 N COMP,UNITS,TDT,ITDT S TDT=9999999-IDT,ITDT=9999999-$P(TDT,".")
 S UNITS=+$P(TR,U,7) S:UNITS'>0 UNITS=1
 S CNTR(ITDT,+$P(TR,U,2))=+$G(CNTR(ITDT,+$P(TR,U,2)))+UNITS
 Q
