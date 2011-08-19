PRCPAGU1 ;WISC/RFJ-autogenerate utilities                           ;01 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DELTEMP(V1,V2) ;  delete temp stock level for invpt v1, item v2
 I '$D(^PRCP(445,+V1,1,+V2,0)) Q
 N D0,DA,DIE,DR,X,Y
 S V1=+V1,V2=+V2,DIE="^PRCP(445,"_V1_",1,",DA(1)=V1,DA=V2,DR="9.5///@;9.6///@" D ^DIE Q
 ;
 ;
OPTIONAL ;  check for vendors with items only at optional reorder point
 ;  do not order optional reorder point if vendor not ordering
 ;  using standard reorder point
 N DESCNSN,GNM,ITEMDA,VDA,VNM
 S VNM="" F  S VNM=$O(^TMP($J,"PRCPAG","OK",VNM)) Q:VNM=""  S VDA=0 F  S VDA=$O(^TMP($J,"PRCPAG","OK",VNM,VDA)) Q:'VDA  I '$D(^TMP($J,"PRCPAG","V+",VDA,"STA")) D
 .   S GNM="" F  S GNM=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM)) Q:GNM=""  S DESCNSN="" F  S DESCNSN=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM,DESCNSN)) Q:DESCNSN=""  D
 .   .   S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM,DESCNSN,ITEMDA)) Q:'ITEMDA  S ^TMP($J,"PRCPAG","NOT",VNM,VDA,GNM,DESCNSN,ITEMDA)=^TMP($J,"PRCPAG","OK",VNM,VDA,GNM,DESCNSN,ITEMDA),TOTITEMS=TOTITEMS-1
 .   K ^TMP($J,"PRCPAG","OK",VNM,VDA)
 Q
 ;
 ;
REPORTS ;  ask to print reports
 N %,PRCPERR,PRCPFLAG,PRCPNOG,PRCPNOV,PRCPNOT
 I $O(^TMP($J,"PRCPAG","ER",""))'="" D  Q:$G(PRCPFLAG)
 .   S XP="Do you want to print errors occurring during auto-generation",XH="Enter 'YES' to print the error report, 'NO' to skip printing it, '^' to exit."
 .   W ! S %=$$YN^PRCPUYN(1)
 .   I %=2 Q
 .   I %=1 S PRCPERR=1 Q
 .   S PRCPFLAG=1
 I $O(^TMP($J,"PRCPAG","NOV",""))'="" D  Q:$G(PRCPFLAG)
 .   S XP="Do you want to print items with vendors not selected",XH="Enter 'YES' to print items with vendors not selected report,",XH(1)="      'NO' to skip printing it, '^' to exit."
 .   W ! S %=$$YN^PRCPUYN(1)
 .   I %=2 Q
 .   I %=1 S PRCPNOV=1 Q
 .   S PRCPFLAG=1
 I $O(^TMP($J,"PRCPAG","NOG",""))'="" D  Q:$G(PRCPFLAG)
 .   S XP="Do you want to print items with groups not selected",XH="Enter 'YES' to print items with groups not selected report,",XH(1)="      'NO' to skip printing it, '^' to exit."
 .   W ! S %=$$YN^PRCPUYN(1)
 .   I %=2 Q
 .   I %=1 S PRCPNOG=1 Q
 .   S PRCPFLAG=1
 I $O(^TMP($J,"PRCPAG","NOT",""))'="" D  Q:$G(PRCPFLAG)
 .   S XP="Do you want to print items which were not ordered",XH="Enter 'YES' to print the items not ordered, 'NO' to skip printing it, '^' to exit."
 .   W ! S %=$$YN^PRCPUYN(1)
 .   I %=2 Q
 .   I %=1 S PRCPNOT=1 Q
 .   S PRCPFLAG=1
 ;
 I $O(^TMP($J,"PRCPAG","OK",""))="",'$G(PRCPERR),'$G(PRCPNOG),'$G(PRCPNOV),'$G(PRCPNOT) Q
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZISC Q
 .   S ZTDESC="Auto-Generate "_PRCP("IN"),ZTRTN="DQ^PRCPAGU1"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("^TMP($J,")="",ZTSAVE("ZTREQ")="@"
 .   D ^%ZTLOAD K IO("Q"),ZTSK
 W !!,"<*> please wait <*>"
DQ ;  queue comes here to print reports
 K PRCPFLAG
 I $O(^TMP($J,"PRCPAG","OK",""))'="" D ORDER^PRCPAGRO I $G(PRCPFLAG) D Q Q
 I $G(PRCPERR) D ERROR^PRCPAGRE I $G(PRCPFLAG) D Q Q
 I $G(PRCPNOV) D NOVEND^PRCPAGRV I $G(PRCPFLAG) D Q Q
 I $G(PRCPNOG) D NOGROUP^PRCPAGRG I $G(PRCPFLAG) D Q Q
 I $G(PRCPNOT) D ITEMSNOT^PRCPAGRI
Q D ^%ZISC Q
