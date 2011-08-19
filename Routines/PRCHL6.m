PRCHL6 ;VACO/HNC/VAC - ITEM DETAIL GRID ; 1/31/07 3:38pm
 ;;5.1;IFCAP;**103**;Oct 20, 2000;Build 25
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;DBIA# 4345 giving permission to reference Prosthetics data
 ;VAC - Limit number of PO line items to 80 or less
 ;
 ;piece 1 - line item number
 ;piece 2 - Item Master number
 ;piece 3 - qty
 ;piece 4 - unit of purchase
 ;piece 5 - BOC
 ;piece 6 - contract BOA
 ;piece 7 - actual unit cost
 ;piece 8 - fed supply classification
 ;piece 9 - vendor stock number
 ;piece 10 - unit conversion factor
 ;piece 11 - total cost
 ;piece 12 - nif number
 ;piece 13 - item master short description 441- .05
 ;
 ;roll and scroll testing entry point
A1(IEN) G A2
 ;
EN(RESULTS,IEN) ;broker entry point
A2 ;
 I IEN="" S RESULTS(0)="No Data"_U_"No Items Found for this PO" Q
 ;First check number of line items on PO, stop if more than 80
 I $P(^PRC(442,IEN,0),U,14)>80 S RESULTS(0)="MORE THAN 80^TOO MANY" Q
 S CNT=0
 D GETS^DIQ(442,IEN,"40*;.01","EN","ITM")
 S PRCHPO=$G(ITM("442",IEN_",",".01","E"))
 S PRCHPIEN=""
 I PRCHPO'="" S PRCHPIEN=$O(^RMPR(664,"G",$P(PRCHPO,"-",2),PRCHPIEN))
 I PRCHPIEN'="" D GETS^DIQ(664,PRCHPIEN,"2*;11;12","E","PITMSTR")
 I $D(PITMSTR) D
 .;Prosthetic item
 .S PRCHB="" F  S PRCHB=$O(PITMSTR(664.02,PRCHB)) Q:'PRCHB  D
 .  .S QTY=$G(PITMSTR(664.02,PRCHB,3,"E"))
 .  .S UOP=$G(PITMSTR(664.02,PRCHB,4,"E"))
 .  .S CBOA=$G(PITMSTR(664.02,PRCHB,13,"E"))
 .  .S ITMD=$G(PITMSTR(664.02,PRCHB,1,"E"))
 .  .S AUC=$G(PITMSTR(664.02,PRCHB,6,"E"))
 .  .I AUC="" S AUC=$G(PITMSTR(664.02,PRCHB,2,"E"))
 .  .S HCPCS=$G(PITMSTR(664.02,PRCHB,16,"E"))
 .  .S VSN=$G(PITMSTR(664.02,PRCHB,15.4,"E"))
 .  .S TCST=QTY*AUC
 .  .S CNT=CNT+1
 .  .S RESULTS(CNT)="P "_CNT_U_HCPCS_U_QTY_U_UOP_U_""_U_CBOA_U_AUC_U_""_U_""_U_1_U_TCST_U_""_U_ITMD
 . S SHIP="",SHIPF=""
 . S SHIP=$G(PITMSTR(664,PRCHPIEN_",",11,"E"))
 . S SHIPF=$G(PITMSTR(664,PRCHPIEN_",",12,"E"))
 . I SHIPF'="" S SHIP=SHIPF
 . I SHIP'="" S CNT=CNT+1,RESULTS(CNT)="P "_CNT_U_"SHIPPING"_U_""_U_""_U_""_U_""_U_""_U_""_U_""_U_1_U_SHIP_U_""_U_"Shipping Cost"
 S B="" F  S B=$O(ITM(442.01,B)) Q:'B  D
 . S IFITM=$G(ITM(442.01,B,1.5,"E"))
 . D GETS^DIQ(441,IFITM,".01;.05;51","E","ITMSTR")
 . S ITMD=$G(ITMSTR(441,IFITM_",",.05,"E"))
 . S IFITM1=$G(ITMSTR(441,IFITM_",",.01,"E"))
 . S NIF=$G(ITMSTR(441,IFITM_",",51,"E"))
 . S LICNT=$P(B,",",1)
 . S QTY=$G(ITM(442.01,B,2,"E"))
 . S UOP=$G(ITM(442.01,B,3,"E"))
 . S BOC=$G(ITM(442.01,B,3.5,"E"))
 . S CBOA=$G(ITM(442.01,B,4,"E"))
 . S AUC=$TR($G(ITM(442.01,B,5,"E")),"$","")
 . S FSC=$G(ITM(442.01,B,8,"E"))
 . S VSN=$G(ITM(442.01,B,9,"E"))
 . S UCF=$G(ITM(442.01,B,9.7,"E"))
 . S TCST=$G(ITM(442.01,B,15,"E"))
 . S ITMDD=$G(ITM(442.01,B,1,1))
 . I ITMD'="" S ITMD=ITMD_" "
 . S ITMD=ITMD_"1st Line: "_ITMDD
 . K ITMDD
 . S CNT=CNT+1
 . S RESULTS(CNT)="I "_LICNT_U_IFITM1_U_QTY_U_UOP_U_BOC_U_CBOA_U_AUC_U_FSC_U_VSN_U_UCF_U_TCST_U_NIF_U_ITMD
END I '$D(RESULTS) S RESULTS(1)="No Data"_U_"No Item Detail"
 K IEN,CNT,ITM,ITMSTR,IFITM,ITMD,IFITM1,LICNT,QTY,UOP,BOC,CBOA,AUC,FSC,VSN,UCF,TCST,NIF,B,PRCHPO,PITMSTR,PRCHB,PRCHPIEN,HCPCS,SHIP,SHIPF
 Q
 ;END
