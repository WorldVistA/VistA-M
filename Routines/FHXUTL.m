FHXUTL ; HISC/NCA - OE/RR Post-Init Clean Up of 2.5 Protocols ;11/10/97  12:52
 ;;5.5;DIETETICS;;Jan 28, 2005
 I +$$VERSION^XPDUTL("OR")'=3 W !,?10,"You do not have version 3 of Order Entry.",!,?10,"The Protocols will not be removed." Q
 Q:'$D(^ORD(101,0))
 S FHX="FHW"
 S FHX=$O(^ORD(101,"B",FHX)) Q:FHX=""
 S FHX1=$O(^ORD(101,"B",FHX,0)) Q:'FHX1
 K ^TMP($J,"FHPRO")
 ; Clean up protocols
 W !!,"Clean up 2.5 Dietetics Protocols..."
 S FHX="FHW" F  S FHX=$O(^ORD(101,"B",FHX)) Q:$E(FHX,1,3)'="FHW"  F FHX1=0:0 S FHX1=$O(^ORD(101,"B",FHX,FHX1)) Q:FHX1<1  S:FHX'="FHWMAS" ^TMP($J,"FHPRO",FHX1)=FHX
 F FHX="OR" F  S FHX=$O(^ORD(101,"B",FHX)) Q:$E(FHX,1,2)'="OR"  F FHX1=0:0 S FHX1=$O(^ORD(101,"B",FHX,FHX1)) Q:FHX1<1  I $E($P($G(^ORD(101,FHX1,0)),"^",1),1,2)="OR" D REMOV
 F FHX="FHW" F  S FHX=$O(^ORD(101,"B",FHX)) Q:$E(FHX,1,3)'="FHW"  F FHX1=0:0 S FHX1=$O(^ORD(101,"B",FHX,FHX1)) Q:FHX1<1  I $E($P($G(^ORD(101,FHX1,0)),"^",1),1,3)="FHW" D REMOV
 F FHX=0:0 S FHX=$O(^TMP($J,"FHPRO",FHX)) Q:FHX<1  S DA=FHX I DA S DIK="^ORD(101," D ^DIK W !,"Protocol ",$G(^TMP($J,"FHPRO",FHX))," Removed"
 W !,"...Done"
 K ^TMP($J,"FHPRO"),DA,DIC,DIK,FHX,FHX1,FHX3
 Q
REMOV ; Check if FHW protocols is used as Items and delete them.
 S DA(1)=FHX1
 F FHX3=0:0 S FHX3=$O(^TMP($J,"FHPRO",FHX3)) Q:FHX3<1  S DA=$O(^ORD(101,DA(1),10,"B",FHX3,0)) I DA S DIK="^ORD(101,DA(1),10," D ^DIK W !,"Protocol ",$G(^TMP($J,"FHPRO",FHX3))," Removed From ",FHX
 Q
