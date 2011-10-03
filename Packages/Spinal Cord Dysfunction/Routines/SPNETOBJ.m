SPNETOBJ ;SD/CM- ETIOLOGY OBJECT; 2-14-2003
 ;;2.0;Spinal Cord Dysfunction;**20,23**;01/02/97
EN(DFN) S U="^",SPNET="",X="Etiologies:"
 S CNT=0
 K ^TMP($J,"ETIOL")
 I '$D(^SPNL(154,DFN,0)) S SPNET="No data available" Q "Etiologies: "_SPNET
 I $O(^SPNL(154,DFN,"E",0))<1 S SPNET="No data available" Q "Etiologies: "_SPNET
 N SPNETI,SPNDFLG
 S (SPNETI,SPNDFLG)=0
 F  S SPNETI=$O(^SPNL(154,DFN,"E",SPNETI)) Q:SPNETI<1  D
 .N SPNETO
 .S CNT=CNT+1
 .S SPNETO=$P($G(^SPNL(154,DFN,"E",SPNETI,0)),U) Q:SPNETO=""
 .W !
 .;W ?12,$E($$GET^DDSVAL(154.03,SPNETO,.01,"","E"),1,30),?44,$$FMTE^XLFDT($P($G(^SPNL(154,DFN,"E",SPNETI,0)),U,2),"5DZP"),?58,$$GET^DDSVAL(154.03,SPNETO,.02,"","E")
 .S ^TMP($J,"ETIOL",CNT)=CNT_") "_$E($$GET^DDSVAL(154.03,SPNETO,.01,"","E"),1,30)
 .S X=X_"  "_^TMP($J,"ETIOL",CNT) I '+CNT S X=X_"No data available"
 .Q
 Q X
