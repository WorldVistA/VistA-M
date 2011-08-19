PRCPAGU2 ;WISC/RFJ-autogenerate find quantity                       ;11 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
QTYORD ;  continue with auto-generation; get quantity to order
 ;  available=onhand+duein-dueout
 ;  if available<standard or available<optional, order it
 ;  up to normal stock level or temp stock level
 N DUEIN,DUEOUT
 S DUEIN=$$GETIN^PRCPUDUE(PRCP("I"),ITEMDA),DUEOUT=$$GETOUT^PRCPUDUE(PRCP("I"),ITEMDA)
 S QTYAVAIL=$P(ITEMDATA,"^",7)+DUEIN-DUEOUT
 S LEVEL=$P(ITEMDATA,"^",9),TEMPLVL="" I $P(ITEMDATA,"^",23) S LEVEL=$P(ITEMDATA,"^",23),TEMPLVL="*"
 S QTY=0,TYPE=""
 ;  its less than optional reorder point
 I QTYAVAIL'>$P(ITEMDATA,"^",4) S QTY=LEVEL-QTYAVAIL,TYPE="OPT"
 ;  its less than stand reorder point, but optional is entered
 I QTYAVAIL'>$P(ITEMDATA,"^",10),QTY S TYPE="STA"
 ;  its less than stand reorder point, no optional
 I QTYAVAIL'>$P(ITEMDATA,"^",10),'QTY S QTY=LEVEL-QTYAVAIL,TYPE="STA"
 I 'QTY S ORDER="NOT" D SET Q
 S QTY=QTY/CONV I $P(QTY,".",2)>0 S QTY=$P(QTY,".")+1
 ;  bring quantity up to minum issue qty and issue multiple
 I QTY<MINISS S QTY=MINISS
 I ISSMULT>1 S %=QTY#ISSMULT I % S QTY=QTY+ISSMULT-%
 S TOTITEMS=TOTITEMS+1,ORDER="OK"
SET ;  set temp global with orders ORDER = "OK" or "NOT" ordered
 S %="^"_QTYAVAIL_"^"_$P(ITEMDATA,"^",10)_"^"_$P(ITEMDATA,"^",4)_"^"_TYPE_"^"_LEVEL_"^"_TEMPLVL_"^"_CONV_"^"_QTY_"^"_UNITI_"^"_UNITR_"^"_COST_"^"_MINISS_"^"_ISSMULT
 S ^TMP($J,"PRCPAG",ORDER,$E(VENDORNM,1,10),VENDOR,GROUPNM,DESCNSN,ITEMDA)=$P(ITEMDATA,"^",7)_"^"_DUEIN_"^"_DUEOUT_%
 I ORDER="NOT" Q
 S ^TMP($J,"PRCPAG","V+",VENDOR,TYPE)="" Q
