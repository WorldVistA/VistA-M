VIAAIPDE ;ALB/CR - RTLS Get all items in Inventory Point ;4/20/16 10:08 pm
 ;;1.0;RTLS;**4**;April 22, 2013;Build 21
 ;
 Q
 ;
 ; Access to file #441 covered by IA #5921
 ; Access to file #445 covered by IA #5923
 ;
IPQRY(RETSTA,IPNAME) ; query inventory point for all its items
 ; RPC [VIAA GET INVENTORY POINT ITEMS]
 ;
 ;--input parameters:
 ;   inventory point name, required
 ;   retsta is the variable that carries the call result
 ;
 ;-- output result sent back in ^TMP("VIAAIPDE",$J) via retsta:
 ;   inventory name, item master number, short description from file
 ;   #445 if available, otherwise, use field from file #441
 ;-- for a faiure the following format is used: "-###^"_failure_msg
 ;   where '###' is a 3-digit code
 ;
 N DATA,ITEM,ITEMDESC,IT441DES,IT445DES,IPIEN,RCNT,VIAA,IPIEN
 S VIAA="VIAAIPDE"
 K ^TMP(VIAA)
 ;
 I $G(IPNAME)="" S ^TMP(VIAA,$J,0)="-400^Inventory Point name cannot be null",RETSTA=$NA(^TMP(VIAA,$J)) Q
 I $G(IPNAME)=0 S ^TMP(VIAA,$J,0)="-400^Inventory Point cannot be zero",RETSTA=$NA(^TMP(VIAA,$J)) Q
 I '$D(^PRCP(445,"B",IPNAME)) S ^TMP(VIAA,$J,0)="-404^Inventory Point "_IPNAME_" is invalid",RETSTA=$NA(^TMP(VIAA,$J)) Q
 S IPIEN=+$O(^PRCP(445,"B",IPNAME,""))
 D ITEM(IPIEN)
 S RETSTA=$NA(^TMP(VIAA,$J))
 Q
 ;
ITEM(IPIEN) ; get all the items in the IP
 S RCNT=0
 S ITEM=0
 F  S ITEM=$O(^PRCP(445,IPIEN,1,"B",ITEM)) Q:'ITEM  D
 . S RCNT=$G(RCNT)+1
 . S IT445DES=$P($G(^PRCP(445,IPIEN,1,ITEM,6)),U,1) ; short item desc from file #445
 . S IT441DES=$P($G(^PRC(441,ITEM,0)),"^",2)        ; short item desc from file #441
 . S ITEMDESC=$S(IT445DES'="":IT445DES,1:IT441DES)
 . S DATA=IPNAME_"^"_IPIEN_"^"_ITEMDESC_"^"_ITEM
 . S ^TMP(VIAA,$J,RCNT,0)=DATA
 I '$D(^TMP(VIAA,$J)) S ^TMP(VIAA,$J,0)="-404^No data found for Inventory Point "_IPNAME
 Q
