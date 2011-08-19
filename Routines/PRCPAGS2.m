PRCPAGS2 ;WISC/RFJ-autogen secondary order (build, reports)         ;01 Dec 92
 ;;5.1;IFCAP;**1**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CONT ;  continue auto-generation
 N D,DESCNSN,DISTDA,GNM,ITEMDA,PRCPERR,PRCPNOT,PRCPNOV,PRCPORD,VDA,VNM,X
 ;
 D OPTIONAL^PRCPAGU1
 ;
 I $O(^TMP($J,"PRCPAG","OK",""))="" D
 . W:'$D(PRCPSCHE) !!,"NO ITEMS HAVE BEEN ORDERED !!"
 . S:$D(PRCPSCHE) $P(PRCPSCHE,"^",2)=3
 E  W !!,"<<< Building distribution orders ..." D
 .   S VNM="" F  S VNM=$O(^TMP($J,"PRCPAG","OK",VNM)) Q:VNM=""  S VDA=0 F  S VDA=$O(^TMP($J,"PRCPAG","OK",VNM,VDA)) Q:'VDA  D
 .   .   W !?5,VNM
 .   .   D NEWORDER^PRCPOPUS(VDA) I '$G(X) D  Q
 .   .   .   W ?25,"Order NOT built, could not get next order number"
 .   .   .   S:$D(PRCPSCHE) $P(PRCPSCHE,"^",2)=1
 .   .   S DISTDA=+$$ADDNEW^PRCPOPUS(X,VDA,PRCP("I"))
 .   .   S PRCPORD=$G(^PRCP(445.3,DISTDA,0)) I PRCPORD="" D  Q
 .   .   .   W ?25,"Order NOT built, could not add a new order"
 .   .   .   S:$D(PRCPSCHE) $P(PRCPSCHE,"^",2)=2
 .   .   W ?25,"Order number: ",+PRCPORD
 .   .   S ^TMP($J,"PRCPAG","VO",VDA)=+PRCPORD I $G(PRCPFBAR) S ^TMP($J,"PRCPBAL3",DISTDA)=""
 .   .   S GNM="" F  S GNM=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM)) Q:GNM=""  S DESCNSN="" F  S DESCNSN=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM,DESCNSN)) Q:DESCNSN=""  D
 .   .   .   S X="",ITEMDA=0 F %=0:1 S ITEMDA=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM,DESCNSN,ITEMDA)) Q:'ITEMDA  S X=ITEMDA,D=^(ITEMDA) D
 .   .   .   .   S ^PRCP(445.3,DISTDA,1,ITEMDA,0)=ITEMDA_"^"_$P(D,"^",11)_"^"_$P(D,"^",14)
 .   .   .   .   S ^PRCP(445.3,DISTDA,1,"B",ITEMDA,ITEMDA)=""
 .   .   .   S ^PRCP(445.3,DISTDA,1,0)="^445.37PIA^"_X_"^"_%
 ;
 ;  prcpfbar is set by the barcode upload programs to prevent printing
 ;  the reports
 I '$G(PRCPFBAR),'$D(PRCPSCHE) D REPORTS^PRCPAGU1 K ^TMP($J,"PRCPBAL3")
 Q
