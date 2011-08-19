PRCHLO2 ;WOIFO/RLL/DAP-EXTRACT ROUTINE (cont.)CLO REPORT SERVER ; 10/16/06 2:09pm
V ;;5.1;IFCAP;**83,98**; Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ; Continuation of PRCHLO1. This program includes the extract
 ; logic for each of the 19 identified tables.
 ;
POITEM ; PoItem Table
 ;
 Q
 ;
POITEMH ; PoItem Table Header
 ;
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "LineItemIdNum^LineItemNumber^ItemMasterFileNumber^"
 W "ItemMasterDescription^NIFNumber^"
 ;
 W "Quantity^UnitOfPurchase^PackagingMultiple^ItemDeliveryPoints^"
 W "BOC^ContractBOA^ActualUnitCost^EstUnitCost^FedSupplyClass^"
 W "VendorStockNumber^NationalDrugCode^SKU^NSN^"
 W "UnitConversionFactor^TotalCost^DiscountedAmount^"
 W "Z410ItemNumber^LotNumber^SerialNumber"
 Q
POITEMW ; Write PO Item Data
 ;
 N GPOID,GPOND
 S GPOID=0,GPOND=""
 F  S GPOID=$O(^TMP($J,"POITEM",GPOID)) Q:GPOID=""  D
 . F  S GPOND=$O(^TMP($J,"POITEM",GPOID,GPOND)) Q:GPOND=""  D
 . . W !,$G(^TMP($J,"POITEM",GPOID,GPOND,0))
 . . Q
 . Q
 Q
POITLNH ; Write PO Line Inventory Point Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "LineItemIdNum^LineInvPtIdNum^LineInvPt^LineQty^LineDelivery^"
 W "QtyReceivedToDate",!
 Q
POITLNW ; Write PO Line Inventory Point Data
 N PITL,PITL1,PITL2
 S PITL=0,PITL1=0,PITL2=0
 F  S PITL=$O(^TMP($J,"POITEMLNINVPT",PITL)) Q:PITL=""  D
 . F  S PITL1=$O(^TMP($J,"POITEMLNINVPT",PITL,PITL1)) Q:PITL1=""  D
 . . W $G(^TMP($J,"POITEMLNINVPT",PITL,PITL1,1,0)),!
 . . Q
 . Q
 Q
GPOITEM ; Get PO Item record
 S U="^"
 N N0,N2,N4,PONUMB,STNUMB,PR2237,PODAT,CKIT,CKIT1,ITMID
 N POI1A,POI1B,POI1C,POIA,POIA1,POIA2,PO16E,PO16E1,PO16E2
 N PO17E,PO17E1,PO17E2,POIAF,POIA2A,IMID
 S CKIT=$G(^PRC(442,POID,2,0)),ITMID=0
 S CKIT1=$P(CKIT,U,3)
 I +CKIT1>0  D
 . S ITMID=0
 . F  S ITMID=$O(^PRC(442,POID,2,ITMID)) Q:ITMID=""  D
 . . I +ITMID>0  D  ; Got an item
 . . . S N0=$G(^PRC(442,POID,2,ITMID,0))
 . . . S N2=$G(^PRC(442,POID,2,ITMID,2))
 . . . S N4=$G(^PRC(442,POID,2,ITMID,4))
 . . . D LPPOITM   ; Loop on item
 . . . Q
 . . Q
 . Q
 Q
DITMD ; Set PO Item Description Data
 N ITMD,ITMD1,ITMD2,ITMD3
 ; get 1st 50 characters from 1st desc.
 S ITMD=$G(^PRC(442,POID,2,ITMID,1,1,0))
 Q:ITMD=""  ; make sure a description exists for the PO
 S ITMD1=$P(ITMD,U,1)
 S ITMD2=$E(ITMD1,1,175)
 S ITMD3=PPOKEY_U_ITMID_U_1_U_ITMD2
 S ^TMP($J,"POITEMDESC",POID,ITMID,0)=ITMD3
 Q
POLIDT ; PO line item date received
 N LIDT1,LIDT2,LIDT3,LIDT4,LIDT5,V1,V2,V3,V4,LDT1E,LDT1E1,LDT1E2
 S LIDT1=$G(^PRC(442,POID,2,ITMID,3,0))
 S LIDT2=$P(LIDT1,U,3)
 I +LIDT2>0  D
 . S LIDT3=0
 . F  S LIDT3=$O(^PRC(442,POID,2,ITMID,3,LIDT3)) Q:LIDT3=""  D
 . . Q:+LIDT3<0  ; quit at the x-ref
 . . S LIDT4=$G(^PRC(442,POID,2,ITMID,3,LIDT3,0))
 . . ; V1-V4 Get the data,$P the values, pad with "^" delimiters
 . . ; get external value for date received
 . . S LDT1E=$P(LIDT4,U,1)
 . . I LDT1E'="" S LDT1E1=$P(LDT1E,".",1),LDT1E2=$$FMTE^XLFDT(LDT1E1)
 . . I LDT1E="" S LDT1E2=""
 . . S V1=LDT1E2_U_$P(LIDT4,U,2)_U_$P(LIDT4,U,3)_U
 . . S V2=$P(LIDT4,U,4)_U_$P(LIDT4,U,5)_U
 . . S V3=$P(LIDT4,U,7)_U_$P(LIDT4,U,8),V4=V1_V2_V3
 . . S LIDT5=PPOKEY_U_ITMID_U_LIDT3_U_V4
 . . I +(LIDT3)>0 S ^TMP($J,"POITEMDATEREC",POID,ITMID,LIDT3,0)=LIDT5
 . . Q
 . Q
 Q
POLIINV ; PO line item Inventory Point multiple
 N POLIV,POLIV1,POLIV2,POLIV3,POLIV4,V1,V2,V3,POLE1,POLE2,POLE3
 S POLIV=$G(^PRC(442,POID,2,ITMID,5,0))
 S POLIV1=$P(POLIV,U,3)
 I +POLIV1>0  D
 . S POLIV2=0
 . S POLIV2=$O(^PRC(442,POID,2,ITMID,5,POLIV2)) Q:POLIV2=""  D
 . . Q:+POLIV2<0  ; quit at the x-ref ELSE Get data, $P values
 . . S POLIV3=$G(^PRC(442,POID,2,ITMID,5,POLIV2,0))  ;Get data values
 . . S POLE1=$P(POLIV3,U,1)
 . . I POLE1'="" S POLE2=$G(^PRCP(445,+POLE1,0)),POLE3=$P(POLE2,U,1)
 . . I POLE1="" S POLE3=""
 . . S V1=POLE3_U_$P(POLIV3,U,2)_U_$P(POLIV3,U,3)_U
 . . S V2=$P(POLIV3,U,4),V3=V1_V2
 . . S POLIV4=PPOKEY_U_ITMID_U_POLIV2_U_V3
 . . I +POLIV2>0 S ^TMP($J,"POITEMLNINVPT",POID,ITMID,POLIV2,0)=POLIV4
 . . Q
 . Q
 Q
LPPOITM ; Loop on PO Item
 ; Initialize with PPOKEY
 S ^TMP($J,"POITEM",POID,ITMID,0)=PPOKEY_U_ITMID
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,7)=$P(N0,U,1)  ; LineItem#
 ;
 ;
 ; get value for ItemMast.Description
 S POIA=$P(N0,U,5)
 I POIA'="" S POIA1=$G(^PRC(441,+POIA,0)),POIA2=$P(POIA1,U,2),IMID=$P(POIA1,U,1),POIA2A=$P(POIA1,U,1)
 I POIA="" S POIA2="",IMID=""
 ;
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,8)=IMID  ; ItemMast.ID#
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,9)=POIA2  ; ItemMast.Description
 ;
 ; Patch 98 CR1 fix . ITEM Master entry may have been deleted if
 ; POIA2'="", but value for lookup is missing (POIA2A="")
 ; If this is the case, S POIAF="ITEM MASTER FILE ERROR "_POIA
 ;
 I POIA2="" S POIAF=""
 I POIA2'=""  D  ; new logic RLL 8/9/06
 . I POIA2A="" S POIAF="ITEM MASTER FILE ERROR "_ITMID
 . I POIA2A'="" S POIAF=$P($G(^PRC(441,POIA2A,0)),U,15)
 . Q
 ; I POIA2'="" S POIAF=$P(^PRC(441,POIA2A,0),U,15)  ;original logic
 ; End Changes Patch 98 RLL 8/9/06
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,10)=POIAF  ; NIF #
 ;
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,11)=$P(N0,U,2)  ; Quantity
 ; Get external value of Unit of Purchase
 S POI1A=$P(N0,U,3)
 I POI1A'="" S POI1B=$G(^PRCD(420.5,+POI1A,0)),POI1C=$P(POI1B,U,1)
 I POI1A="" S POI1C=""
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,12)=POI1C  ;UnitOfPurchase
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,13)=$P(N0,U,12)  ; PkgMult
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,14)=$P(N0,U,8)  ; ItmDelPoints
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,15)=$P(N0,U,4)  ; BOC
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,16)=$P(N2,U,2)  ; Contract Boa
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,17)=$P(N0,U,9)  ; Act Unit Cost
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,18)=$P(N0,U,7)  ; Est Unit Cost
 ; get external value for Fed Supply Classification
 S PO17E=$P(N2,U,3)
 I PO17E'="" S PO17E1=$G(^PRC(441.2,+PO17E,0)),PO17E2=$P(PO17E1,U,1)
 I PO17E="" S PO17E2=""
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,19)=PO17E2  ;FedSupClass
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,20)=$P(N0,U,6)  ;VenStkNum
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,21)=$P(N0,U,15)  ;NatDrugCode
 ; get external value for SKU
 S PO16E=$P(N0,U,16)
 I PO16E'="" S PO16E1=$G(^PRCD(420.5,+PO16E,0)),PO16E2=$P(PO16E1,U,1)
 I PO16E="" S PO16E2=""
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,22)=PO16E2  ;SKU
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,23)=$P(N0,U,13)  ;NSN
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,24)=$P(N0,U,17)  ;UnitConFactor
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,25)=$P(N2,U,1)  ;TotalCost
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,26)=$P(N2,U,6)  ;DiscItmAmt
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,27)=$P(N2,U,13)  ;Z410ItmNum
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,28)=$P(N4,U,17)  ;LotNum
 S $P(^TMP($J,"POITEM",POID,ITMID,0),U,29)=$P(N4,U,18)  ;SerialNum
 D DITMD  ; get 1st Item Description from multiple
 D POLIDT  ; get Item Date received Data from multiple
 D POLIINV
 Q
 ;
POITDRCH ; PO Item Date Received Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "LineItemIdNum^DateRecIdNum^DateReceived^QtyReceived^Amount^"
 W "PartialNumber^DiscountedAmount^AdjustedQuantityRec^AdjustedAmt",!
 Q
POITDRCW ; PO Item Date Received Data
 N PIDRC,PIDRC1,PIDRC2,PIDRC3,PIDRC4
 S PIDRC=0,PIDRC1=0,PIDRC2=0,PIDRC3=0
 F  S PIDRC=$O(^TMP($J,"POITEMDATEREC",PIDRC)) Q:PIDRC=""  D
 . F  S PIDRC1=$O(^TMP($J,"POITEMDATEREC",PIDRC,PIDRC1)) Q:PIDRC1=""  D
 . . F  S PIDRC2=$O(^TMP($J,"POITEMDATEREC",PIDRC,PIDRC1,PIDRC2)) Q:PIDRC2=""  D
 . . . ;
 . . . W $G(^TMP($J,"POITEMDATEREC",PIDRC,PIDRC1,PIDRC2,0)),!
 . . Q
 . . Q
 . Q
 Q
POITDSH ; PO Item Description Header
 W "PoIdNum^PurchaseOrderNum^PoDate^MonthYrRun^StationNum^"
 W "LineItemIdNum^LineItemDescIdNum^Description",!
 Q
POITDSW ; PO Item Description Write Data
 N PDES,PDES1,PDES2,PDES3
 S PDES=0,PDES1=0
 F  S PDES=$O(^TMP($J,"POITEMDESC",PDES)) Q:PDES=""  D
 . F  S PDES1=$O(^TMP($J,"POITEMDESC",PDES,PDES1)) Q:PDES1=""  D
 . . W $G(^TMP($J,"POITEMDESC",PDES,PDES1,0)),!
 . . Q
 . Q
 Q
