IBDF9A3 ;ALB/CJM - ENCOUNTER FORM - (create,edit,delete selection list - continued) ;NOV 5,1994
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
GETSC(ARY,LIST) ;makes a list of subcolumns having text
 N SC,NODE
 S SC=0 F  S SC=$O(^IBE(357.2,LIST,2,SC)) Q:'SC  S NODE=$G(^IBE(357.2,LIST,2,SC,0)) I $P(NODE,"^",4)=1 S ARY(+NODE)=$P(NODE,"^",5)
 Q
DELSC(LIST,SC) ;delete subcolumn=SC for selections on LIST
 N SLCTN,SCIEN
 K DA,DIK
 S SLCTN=0 F  S SLCTN=$O(^IBE(357.3,"C",LIST,SLCTN)) Q:'SLCTN  S SCIEN=0 F  S SCIEN=$O(^IBE(357.3,SLCTN,1,"B",SC,SCIEN)) Q:'SCIEN  D
 .I $P($G(^IBE(357.3,SLCTN,1,SCIEN,0)),"^")=SC D
 ..S DIK="^IBE(357.3,"_SLCTN_",1,",DA(1)=SLCTN,DA=SCIEN D ^DIK
 .E  D
 ..K ^IBE(357.3,SLCTN,1,"B",SC,SCIEN)
 ..S DIK="^IBE(357.3,SLCTN,1,",DA(1)=SLCTN,DA=SCIEN D IX^DIK
 K DIK,DA
 Q
ADDSC(LIST,SC) ;ADD subcolumn=SC for selections on LIST if not already there, else set to blank
 N SLCTN,SCIEN ;,IBNEWSC,IBFLG
 ;S IBNEWSC=IBSCNEW(SC)
 ;S IBTHERE=0
 ;F  S IBTHERE=$O(IBSCOLD(IBTHERE)) Q:'IBTHERE D  Q:$D(IBFLG)
 ;.;I IBNEWSC=IBTHERE S IBFLG=1 Q
 ;.;I IBNEWSC=3,IBTHERE=2 S IBFLG=1 Q
 ;I $D(IBFLG) D
 ;.;I IBTHERE=IBNEWSC W !!,"The new subcolum "_IBNEWSC_" contains the same
 ;.;I IBTHERE=IBNEWSC W !!,"The new subcolum "_IBNEWSC_" contains the samedata as the the new subcolumn.",!,"**New subcolumn deleted**"
 ;W "The new subcolum "_IBNEWSC_" contains the samedata as the the new subcolumn, but different subcolumn width. ** Change subcolumn width**",!,"**New subcolumn deleted**"
 S SLCTN=0 F  S SLCTN=$O(^IBE(357.3,"C",LIST,SLCTN)) Q:'SLCTN  D
 .;re-index the record, to insure it is good 
 .K DIK,DA S DIK="^IBE(357.3,",DA=SLCTN D IX^DIK
 .S SCIEN=$O(^IBE(357.3,SLCTN,1,"B",SC,0))
 .;
 .;should be empty if it already exists
 .I SCIEN S $P(^IBE(357.3,SLCTN,1,SCIEN,0),"^",2)="" Q
 .;
 .;it doesnt already exist, so create it
 .K DA,DIC,DO,DINUM
 .S DIC="^IBE(357.3,"_SLCTN_",1,",DA(1)=SLCTN,X=SC,DIC(0)="" D FILE^DICN
 K DIC,DO,DA,DIK
 Q
 ;
OTHER ;
 N INPUT,NODE
 S NODE=$G(^IBE(357.6,16,0))
 S INPUT("NARRATIVE")=$P(NODE,"^"),INPUT("NARRATIVE","NAME")=$P(NODE,"^",2),INPUT("NARRATIVE","DATATYPE")=$P(NODE,"^",3),INPUT("CODE")=$P(NODE,"^",4),INPUT("CODE","NAME")=$P(NODE,"^",6),INPUT("CODE","DATATYPE")=$P(NODE,"^",7)
 Q
SCLOOP ;  -- Looping thru the subc setting up array(type of data)=subcolumn
 S (IBSC3,IBSC4)=0
 F  S IBSC3=$O(^IBE(357.2,IBLIST,2,"B",IBSC3)) Q:'IBSC3  F  S IBSC4=$O(^IBE(357.2,IBLIST,2,"B",IBSC3,IBSC4)) Q:'IBSC4  I $P($G(^IBE(357.2,IBLIST,2,IBSC4,0)),"^",5)]"" D
 .S IBSCRAY($P($G(^IBE(357.2,IBLIST,2,IBSC4,0)),"^",5))=$P($G(^IBE(357.2,IBLIST,2,IBSC4,0)),"^",1)
 Q
SCDEL ;  -- Deletes the new subcolumn if there is already a column for that
 ;     type of data.
 N DA,DIK
 I "^1^2^3^"'[X Q
 I IBSC1(IBSC1)'="^",X'=$P(IBSC1(IBSC1),"^",2) S X=$P(IBSC1(IBSC1),"^",2) S $P(^IBE(357.2,D0,2,D1,0),"^",5)=X D MSG1 Q
 Q:IBSC1(IBSC1)'="^"
 ;S DIK="^IBE(357.2,",DA=IBSC1
 I "^1^2^3^"[X I $D(IBSCRAY(X)) D DIK Q
 ;I X=2 I $D(IBSCRAY(3)) D DIK Q
 ;I X=3 I $D(IBSCRAY(2)) D DIK Q
 ;K DA,DIK Q
 Q
DIK ;  -- KILL SUBCOLUMN GLOBAL
 W !!,"*** SUBCOUMN "_IBSC1_" DELETED ***",!,"This data already exists in subcolumn "_IBSCRAY(X)_". Go in and edit its subcolumn number.",!!
 S DIK="^IBE(357.2,"_D0_",2,",DA(1)=D0,DA=D1 D ^DIK
 S IBDFFLG=1
 ;K DA,DIK Q
 Q
MSG1 ;
 W !!,"*** PREVENTING LOSS OF DATA - THIS FIELD CAN NOT BE EDITED ***",!,"You will need to add a new subcolumn to update this information",!!
 Q
