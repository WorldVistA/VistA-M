LRCAPAM8 ;DALISC/J0 - RCS 14-4 REPORT LMIP PAGE PRINT ;5/10/93
 ;;5.2;LAB SERVICE;**201**;Sep 27, 1994
EN ;
PRNTSUM ;
 N LRDSHS,LRHDR
 S $P(LRDSHS,"-",245)="-"
 S LRMT=0,LRPRD=$TR($$FMTE^XLFDT($$NOW^XLFDT,"1M"),"@"," ")
 F  S LRMT=$O(^TMP($J,"LMIP",LRMT)) Q:LRMT<1  S LRMTP=$$FMTE^XLFDT(LRMT,"1D") D  Q:$G(LR("Q"))
 .W !,"LMIP REPORT printed ",LRPRD
 .W !,LRHD0
 .W ?((132-($L(LRMTP)+$L($P(LRDA,U,2)))\2)),$P(LRDA,U,2)_"   "_LRMTP
 .S LRPG=LRPG+1 W ?122,"Page ",LRPG,!
 .S LRHDR="Pathology Laboratory Medicine Service Workload Summary"
 .W !!,?(132-$L(LRHDR)\2),LRHDR,!
 .W !!,"LINE  SECTION",?28,"In-patient",?40,"Out-patient"
 .W ?53,"Non-patient",?70,"Total",?77,"Quality",?87,"Total"
 .W ?99,"Referred",?113,"Tests",!
 .W "No.",?30,"Tests",?43,"Tests",?54,"""Other"""
 .W ?70,"Tests",?77,"Control",?86,"On-site",?101,"Tests"
 .W ?111,"Performed",?124,"Stat",!
 .W ?55,"Tests",?67,"(Orderable)",?87,"Tests"
 .W ?98,"(Send Outs)",?112,"On-site",?124,"Tests",!
 .W $E(LRDSHS,1,132),!
 .W "LMIP Data Number",?28,"    #5    ",?40,"    #6     "
 .W ?53,"    #7     ",?66,"     #1  ",?86,"  #2   "
 .W ?95,"      #4      ",?111,"   #3    ",?122,"   #8  ",!
 .W $E(LRDSHS,1,132),!
 .D PRNTNAM
SUP ;
 D ^LRCAPAM9
 Q
PRNTNAM ;
 N LRRCNT,LRREC,LRLARE
 S LRRCNT=0
 W !,"Anatomic Pathology Division",!,$E(LRDSHS,1,27),!
 S LRLARE=0
 F  S LRLARE=$O(^TMP($J,"LMIP",LRMT,"AP",LRLARE)) Q:LRLARE=""  D
 .S LRREC=$G(^TMP($J,"LMIP",LRMT,"AP",LRLARE))
 .S LRRCNT=LRRCNT+1
 .W LRRCNT,?6,LRLARE
 .D PRNTREC
 .W !
 ;Write AP subtotals
 S LRLARE="AP subtotal"
 S LRREC=$G(^TMP($J,"LMIP",LRMT,"AP",0))
 W ?6,LRLARE
 D PRNTREC
 ;
 W !!,"Clinical Pathology Division",!,$E(LRDSHS,1,27),!
 S LRLARE=0
 F  S LRLARE=$O(^TMP($J,"LMIP",LRMT,"CP",LRLARE)) Q:LRLARE=""  D
 .S LRREC=$G(^TMP($J,"LMIP",LRMT,"CP",LRLARE))
 .S LRRCNT=LRRCNT+1
 .W LRRCNT,?6,LRLARE
 .D PRNTREC
 .W !
 ;Write CP subtotals
 S LRLARE="CP subtotal"
 S LRREC=$G(^TMP($J,"LMIP",LRMT,"CP",0))
 W ?6,LRLARE
 D PRNTREC
 ;Write grand totals
 W !
 W $E(LRDSHS,1,132),!
 S LRRCNT=LRRCNT+1,LRLARE="GRAND TOTAL"
 D EDIT1
 S LRREC=$G(^TMP($J,"LMIP",LRMT,"TOT-AP/CP"))
 W ?6,LRLARE
 D PRNTREC
 I $E(IOST,1,2)="C-" D M^LRU Q:$G(LR("Q"))
 W @IOF
 Q
PRNTREC ;
 W ?28,$J($P(LRREC,U),10),?40,$J($P(LRREC,U,2),11)
 W ?53,$J($P(LRREC,U,3),11),?66,$J($P(LRREC,U,4),9)
 W ?77,$J($P(LRREC,U,5),7),?86,$J($P(LRREC,U,6),7)
 W ?95,$J($P(LRREC,U,7),14),?111,$J($P(LRREC,U,8),9)
 W ?122,$J($P(LRREC,U,9),7),!
 Q
EDIT1 ;
 N I,LRAPSUB,LRCAPSUB,LRGTOT
 S LRAPSUB=$G(^TMP($J,"LMIP",LRMT,"AP",0))
 S LRCPSUB=$G(^TMP($J,"LMIP",LRMT,"CP",0))
 F I=1:1:9 D
 . S LRGTOT=$P(LRAPSUB,U,I)+$P(LRCPSUB,U,I)
 . S $P(^TMP($J,"LMIP",LRMT,"TOT-AP/CP"),U,I)=LRGTOT
 Q
