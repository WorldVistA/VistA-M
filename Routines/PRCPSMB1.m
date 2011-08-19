PRCPSMB1 ;WISC/RFJ-isms transaction: balance update (create cs)     ;21 Oct 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
BALANCE(V1,V2) ;  balance transaction
 ;  v1=invptda, v2=itemda
 ;  returns code sheet or 'error'
 N AVG,COST,D,DUEOUT,NSN,ONHAND,SALE,UNIT,VALUE,WHSE
 I 'V1!('V2) Q "ERROR: invalid inventory point and item"
 S D=$G(^PRCP(445,+V1,1,+V2,0)) I D="" Q "ERROR: item not stored in inventory point"
 S NSN=$TR($$NSN^PRCPUX1(V2),"-") I NSN="" Q "ERROR: NSN is missing"
 S UNIT=$$UNITCODE^PRCPUX1($P(D,"^",5)) I UNIT["?" Q "ERROR: UNIT OF ISSUE is missing"
 S ONHAND=+$P(D,"^",7),ONHAND=$S(ONHAND:$P(ONHAND,".")_$P($J(ONHAND,0,2),".",2),1:0)
 S VALUE=+$P(D,"^",27),VALUE=$S(VALUE:$P(VALUE,".")_$P($J(VALUE,0,2),".",2),1:0)
 S DUEOUT=$$GETOUT^PRCPUDUE(+V1,+V2),DUEOUT=$S(DUEOUT:$P(DUEOUT,".")_$P($J(DUEOUT,0,2),".",2),1:0)
 S AVG=+$P(D,"^",22),AVG=$S(AVG:$P(AVG,".")_$P($J(AVG,0,4),".",2),1:0)
 S COST=+$P(D,"^",15),COST=$S(COST:$P(COST,".")_$P($J(COST,0,4),".",2),1:0)
 S WHSE=+$O(^PRC(440,"AC","S",0)),SALE=+$P($G(^PRC(441,V2,2,WHSE,0)),"^",2),SALE=$S(SALE:$P(SALE,".")_$P($J(SALE,0,4),".",2),1:0)
 Q "BU^"_NSN_"^"_UNIT_"^"_ONHAND_"^"_VALUE_"^"_DUEOUT_"^"_AVG_"^"_COST_"^"_SALE_"^|"
