VIAAIMUP ;ALB/CR - RTLS Send Item Master Update to WaveMark ;4/20/16 10:07 pm
 ;;1.0;RTLS;**4**;April 22, 2013;Build 21
 ;
 Q
 ; Access to file #441 covered by IA #5921
 ; Access to file #440 covered by IA #5922
 ; Access to file #445 covered by IA #5923
 ; Access to file #445.6 covered by IA #6067
 ; Access to file #420.5 covered by IA #6068
 ;
 ;-- input required:
 ;   item master # (IEN) - required
 ;   inventory point name - required
 ;
 ;-- output: sent back in ^TMP("ITEMUPDATE",$J) via retsta
 ;   item master number, #441
 ;   vendor name, vendor ien, file #440
 ;   item short description from #445 (preferred) or #441
 ;   vendor stock #
 ;   inventory point name
 ;   unit of issue, from sub-file #445.01
 ;   average cost, sub-file #445.01, field # 4.8
 ;   group category code
 ;   due-in
 ;-- for a failure a 3-digit code and a short message is returned
 ;   to the calling application using the following format:
 ;   "-###^"_failure_message
 ;
ITEM(RETSTA,IPNAME,ITEM) ; RPC call starts here
 ; RPC [VIAA GET ITEM MASTER UPDATE]
 ;
 N DATA,DATAV,I,ITEMDESC,IPIEN,IPIEN1,AVGCOST,UNISSUE,VENDSTCK,VENDCNT,IT445DES,IT441DES,VENDPTR,VENDNAME,GCCODE,ITDUEIN
 N VIAA
 S VIAA="VIAAIMUP"
 K ^TMP(VIAA)
 I $G(IPNAME)="" S ^TMP(VIAA,$J,0)="-400^Inventory Point name cannot be null" D EXIT Q
 I '$O(^PRCP(445,"B",IPNAME,"")) S ^TMP(VIAA,$J,0)="-404^"_IPNAME_" is not a legal Inventory Point" D EXIT Q
 S IPIEN=$O(^PRCP(445,"B",IPNAME,""))
 ;
 I $G(ITEM)="" S ^TMP(VIAA,$J,0)="-400^Item Master # cannot be null" D EXIT Q
 I +ITEM=0 S ^TMP(VIAA,$J,0)="-400^Item Master # cannot be zero" D EXIT Q
 I '$D(^PRC(441,"B",ITEM)) S ^TMP(VIAA,$J,0)="-404^Item Master # "_ITEM_" not found in File #441" D EXIT Q
 I '$D(^PRCP(445,IPIEN,1,ITEM,0)) S ^TMP(VIAA,$J,0)="-404^Item Master # "_ITEM_" not found in Inventory Point "_IPNAME D EXIT Q
 ;
 ; -- get the item details WaveMark needs. IEN of IP below can be for
 ; a primary or a secondary IP
 S IPIEN=$O(^PRCP(445,"B",IPNAME,"")) ; IEN of IP we start with
 D T1(ITEM)
 I $G(DATAV)="" S DATAV=""
 ;
 ; We need to refresh the IP info in case we have a secondary IP
 S IPIEN1=$O(^PRCP(445,"B",IPNAME,""))
 S IPTYPE=$P(^PRCP(445,IPIEN1,0),U,3) ; primary or secondary IP type
 I IPTYPE="S" S IPIEN=IPIEN1
 ;
 S VENDCNT=$P($G(^PRC(441,ITEM,2,0)),U,4) ; vendors in a multiple
 F I=1:1:VENDCNT D
 . S VENDPTR=+$O(^PRC(441,ITEM,2,"B",I)) I 'VENDPTR Q
 . S VENDNAME=$P($G(^PRC(440,VENDPTR,0)),U,1)
 . I '$D(VENDNAME) S VENDNAME=""
 . S UNISSUE=$$GET1^DIQ(445.01,ITEM_","_IPIEN_",",4,"E")
 . I '$D(UNISSUE)="" S UNISSUE=""
 . S AVGCOST=$P($G(^PRCP(445,IPIEN,1,ITEM,0)),U,22)
 . I '$D(AVGCOST) S AVGCOST=""
 . S IT445DES=$P($G(^PRCP(445,IPIEN,1,ITEM,6)),U,1)
 . S IT441DES=$P($G(^PRC(441,ITEM,0)),U,2)
 . S ITEMDESC=$S(IT445DES'="":IT445DES,1:IT441DES)
 . S GCCODE=$$GET1^DIQ(445.01,ITEM_","_IPIEN_",",.5,"E") ; gr cat code
 . S ITDUEIN=$$GET1^DIQ(445.01,ITEM_","_IPIEN_",",8.1,"E") ; due-in
 . S DATA=ITEMDESC_U_ITEM_U_DATAV_U_IPNAME_U_UNISSUE_U_AVGCOST_U_GCCODE_U_ITDUEIN
 . S ^TMP(VIAA,$J,0)=DATA
 ;
 I '$D(^TMP(VIAA,$J)) S ^TMP(VIAA,$J,0)="-404^No data found for Inventory Point "_IPNAME
EXIT S RETSTA=$NA(^TMP(VIAA,$J))
 Q
 ;
T1(ITEM) ; vendor detail: get mandatory and procurement sources
 N IPTYPE,MVIEN,MVNAME,MVROOT,PRVEN,PRNAME,ROOT,VENDCNT,VSTCKMAN
 N FLDEL,RECDEL,PRIMIP
 S RECDEL="|" ; record delimiter within a multiple
 S FLDEL="~" ; field delimiter within a record
 ; see if the inventory point (IP) is a secondary attached to a primary IP
 ; and get the vendor info from the parent primary IP. Otherwise, we have
 ; a stand-alone primary IP.
 S IPIEN1=$O(^PRCP(445,"B",IPNAME,"")) ; prepare to swap child and parent IP
 S IPTYPE=$P(^PRCP(445,IPIEN1,0),U,3) ; primary or secondary IP type
 I IPTYPE="S" S PRIMIP=$P($P(^PRCP(445,IPIEN1,1,ITEM,0),U,12),";",1)
 I $G(PRIMIP)'="" S IPIEN=PRIMIP            ; primary IP Parent IEN
 S MVROOT=$P($G(^PRCP(445,IPIEN,1,ITEM,0)),U,12) ; mandatory vendor
 ;
 S MVIEN=$P($G(MVROOT),";",1) ; we need the IEN for the vendor
 I MVIEN="" S MVNAME=""
 I +MVIEN>0 S MVNAME=$P(^PRC(440,MVIEN,0),U,1) ; mandatory vendor name
 S VSTCKMAN=$$GET1^DIQ(441.01,MVIEN_","_ITEM_",",3,"E") ; vendor stock # for mandatory vendor
 S DATAV=""
 ;
 F VENDCNT=0:0 S VENDCNT=$O(^PRCP(445,IPIEN,1,ITEM,5,VENDCNT)) Q:'VENDCNT  D
 . S PRVEN=$P($G(^PRCP(445,IPIEN,1,ITEM,5,VENDCNT,0)),";",1)
 . Q:PRVEN=""
 . S PRNAME=$P($G(^PRC(440,PRVEN,0)),U,1) ; procurement vendor name
 . ; get procurement source stock #
 . S VENDSTCK=$$GET1^DIQ(441.01,PRVEN_","_ITEM_",",3,"E") ;
 . Q:PRNAME=""
 . I MVIEN=PRVEN Q  ; don't list twice a vendor as proc and mandatory
 . S DATAV=DATAV_RECDEL_PRNAME_FLDEL_PRVEN_FLDEL_VENDSTCK
 S MVIEN=MVIEN_FLDEL_VSTCKMAN ; attach vendor stock #
 S DATAV=MVNAME_FLDEL_MVIEN_DATAV  ; mandatory & proc. vendor names
 Q
