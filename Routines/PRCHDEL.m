PRCHDEL ;WISC/AKS-CHECKING OLDER AMENDMENTS ;
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N PO,AM,X,EXPO,EXPO1,AUTODEL,N,PRCTMP
 S PO=0 F  S PO=$O(^PRC(443.6,PO)) Q:'PO  D
 .S AM=0 F  S AM=$O(^PRC(443.6,PO,6,AM)) Q:'AM  I $D(^PRC(443.6,PO,6,AM,0)) D
 ..;X variable created with NOW^%DTC must be available for DW^%DTC.
 ..D NOW^%DTC I X'<$P($P(^PRC(443.6,PO,6,AM,0),U,12),".") D
 ...I $P($G(^PRC(443.6,PO,6,AM,1)),U,2)]"" D  Q
 ....I $G(X)>0 D DW^%DTC I X="SATURDAY"!(X="SUNDAY") Q
 ....N SUBINFO S SUBINFO="443.67^15^"_AM
 ....D GENDIQ^PRCFFU7(443.6,+PO,50,"IEN",SUBINFO)
 ....S AUTODEL=$G(PRCTMP(443.67,+AM,15,"E"))
 ....D BULLET^PRCHAMBL(+PO,+AM,AUTODEL)
 ...S EXPO=$P(^PRC(443.6,PO,0),U),EXPO1=$P(EXPO,"-",2)
 ...S N=0 F  S N=$O(^PRC(441.7,"B",EXPO,N)) Q:N'>0  D
 ....S DA=N,DIE=441.7,DR=".01///@" D ^DIE K DA,DIE,DR
 ...K ^PRC(443.6,"B",EXPO),^PRC(443.6,"C",PO),^PRC(443.6,"D",PO)
 ...K ^PRC(443.6,"E",EXPO1),^PRC(443.6,PO)
 QUIT
