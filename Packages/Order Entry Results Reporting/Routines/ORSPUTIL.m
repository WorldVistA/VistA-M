ORSPUTIL ; SUPPLY CONVERSION UTILITY [3/28/16 11:24am] ;05/03/16  09:15
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**423**;Dec 17, 1997;Build 19
 ;
SUPPLYNF ;if OI is marked as NON-FORMULARY and SUPPLY then set QO-ONLY to yes for SUPPLY
 W @IOF
 W "This utility will convert all items from the ORDERABLE ITEMS file that are "
 W !,"marked for both Supplies and Non-Formulary, to be QO-ONLY to YES for"
 W !,"Supplies."
 I '$$SURE("Are you sure you want to continue?") Q
 N I
 S I=0 F  S I=$O(^ORD(101.43,I)) Q:'I  D
 .Q:'$D(^ORD(101.43,I,"PS"))
 .Q:'$P(^ORD(101.43,I,"PS"),U,5)  ;quit if not set to supply
 .Q:'$P(^ORD(101.43,I,"PS"),U,6)  ;quit if not set to non-formulary
 .W !,"OI IEN: ",I,?20,"OI NAME: ",$P(^ORD(101.43,I,0),U)
 .D SET("SPLY",I)
 Q
 ;
COPYO2S ;if OI is marked QO-ONLY for OUTPATIENT Med then set QO-ONLY to yes for SUPPLY
 W @IOF
 W "This utility will convert all items from the ORDERABLE ITEMS file that are "
 W !,"marked for Supplies and also set as QO-ONLY yes for Outpatient Meds,"
 W !,"to be QO-ONLY to YES for Supplies."
 I '$$SURE("Are you sure you want to continue?") Q
 N I
 S I=0 F  S I=$O(^ORD(101.43,I)) Q:'I  D
 .Q:'$D(^ORD(101.43,I,"PS"))
 .Q:'$P(^ORD(101.43,I,"PS"),U,5)  ;quit if not set to supply
 .Q:'$$GET("O RX",I)  ;quit if not set to YES for QO-ONLY for outpatient meds
 .W !,"OI IEN: ",I,?20,"OI NAME: ",$P(^ORD(101.43,I,0),U)
 .D SET("SPLY",I)
 Q
 ;
GET(CODE,ORIEN) ;get the current status of QO-ONLY for a specific package type(CODE)
 N DA,ORY S ORY=0
 S DA=$O(^ORD(101.43,ORIEN,9,"B",CODE,""))
 I DA D
 .I $P($G(^ORD(101.43,ORIEN,9,DA,0)),U,2) S ORY=1
 Q ORY
 ;
SET(CODE,ORIEN) ;set the status of QO-ONLY to YES for a specific package type(CODE)
 N ORDA
 S ORDA=$O(^ORD(101.43,ORIEN,9,"B",CODE,""))
 I ORDA D
 .N DA,DR,DIE
 .S DA(1)=ORIEN,DA=ORDA,DR=2_"///YES",DIE="^ORD(101.43,"_DA(1)_",9," D ^DIE
 Q
 ;
SURE(ORMSG) ; -- sure you want to delete?
 N X,Y,DIR
 S DIR(0)="YA",DIR("A")="  "_ORMSG_" "
 S DIR("B")="NO" W $C(7) D ^DIR
 S:$D(DTOUT) Y="^"
 Q Y
 ;
