PSJPATMR ;BIR/RSB - UTILITY FOR PATIENT MERGE ;Apr 19, 2022@14:12
 ;;5.0;INPATIENT MEDICATIONS;**36,217,404,431**;16 DEC 97;Build 5
 ;
 ; Reference to ^PS(55 supported by DBIA #2191.
 ; Reference to ^PS(52.6 is supported by DBIA 1231
 ; Reference to ^PS(52.7 is supported by DBIA 2173
 ; Reference to ^PSDRUG( is supported by DBIA 2192
 ; Reference to ^PSB(53.79 is supported by DBIA 3370.
 ;
EN(DFN1,DFN2)   ; Patient DFN1 (FROM) / DFN2 (TO)
 ; check active IV, UD, and Orders on a pick list
 I $$CHKIVACT(DFN1)!($$CHKUDACT(DFN1))!($$CHKPL(DFN1)) Q 0
 K ^TMP("PSJMERGE_UD",$J),^TMP("PSJMERGE_IV",$J)
 D MOVEUD(DFN1,DFN2)
 D MOVEIV(DFN1,DFN2)
 K ^TMP("PSJMERGE_UD",$J),^TMP("PSJMERGE_IV",$J)
 Q 1
 ;
MOVEUD(DFN1,DFN2)      ;  move all Unit Dose orders for FROM patient
 N ORDERS,XREF,X,NEXT,INITIAL,LASTDFN1,LASTDFN2,HIGHEST
 S LASTDFN1=+$O(^PS(55,DFN1,5,9999999999),-1)
 S LASTDFN2=+$O(^PS(55,DFN2,5,9999999999),-1)
 S HIGHEST=$S(LASTDFN1>LASTDFN2:LASTDFN1,1:LASTDFN2)
 S (NEXT,INITIAL)=HIGHEST+1
 F ORDERS=0:0 S ORDERS=$O(^PS(55,DFN1,5,ORDERS)) Q:'ORDERS  D
 . M ^PS(55,DFN2,5,NEXT)=^PS(55,DFN1,5,ORDERS)  ; Move to new order
 . D UPDBML(DFN1,ORDERS_"U",DFN2,NEXT_"U")      ; Update BCMA MED LOG file (#53.79), ORDER REFERENCE NUMBER field (#.11)
 . ; set .01 order number if not a number from 53.1
 . I ORDERS=+$P($G(^PS(55,DFN1,5,ORDERS,0)),"^") S $P(^PS(55,DFN2,5,NEXT,0),"^")=NEXT
 . S $P(^PS(55,DFN2,5,NEXT,0),"^",15)=DFN2
 . ; kill xrefs
 . K DA S DA=ORDERS,DA(1)=DFN1
 . S X=$P($G(^PS(55,DA(1),5,DA,0)),"^",7) I $D(^PS(55,DA(1),5,DA,2)),$P(^(2),"^",4) K ^PS(55,DA(1),5,"AU",X,+$P(^(2),"^",4),DA)
 . K ^PS(55,"ANV",DA(1),DA)
 . K ^PS(55,"APV",DA(1),DA)
 . K ^PS(55,"AUE",DA(1),DA)
 . S X=$P($G(^PS(55,DA(1),5,DA,2)),"^",4) K ^PS(55,"AUD",$E(X,1,30),DA(1),DA)
 . S X=$P($G(^PS(55,DA(1),5,DA,2)),"^",2) K ^PS(55,"AUDDD",$E(X,1,30),DA(1),DA)
 . K ^PS(55,"AUDS",$E(X,1,30),DA(1),DA)
 . S X=$P($G(^PS(55,DA(1),5,DA,.1)),"^") K:+X ^PS(55,DA(1),5,"C",$E(X,1,30),DA)
 . ; set table for previous and following order numbers
 . S ^TMP("PSJMERGE_UD",$J,ORDERS)=ORDERS_"^"_$P($G(^PS(55,DFN1,5,ORDERS,0)),"^",25)_"^"_$P($G(^PS(55,DFN1,5,ORDERS,0)),"^",26)_"^"_NEXT
 . ; Set new X-refs
 . K DIK,DA S DA=NEXT,DA(1)=DFN2,DIK="^PS(55,"_DA(1)_",5,"
 . F XREF=.5,7,51,50,34,64,10,".01^AUE^B" S DIK(1)=XREF D EN^DIK
 . D CNVUD(DFN2,NEXT)
 . D EN1^PSJHL2(DFN1,"OC",ORDERS_"U")  ;  Cancel CPRS order from Patient 'From'
 . D EN1^PSJHL2(DFN2,"SC",NEXT_"U")  ;  Update CPRS with order from Patient 'To'
 . ; kill entire order 
 . K ^PS(55,DFN1,5,ORDERS)
 . S NEXT=NEXT+1
 ; Kills remaining x-refs
 F XREF="B","C","AU","AUS" K ^PS(55,DFN1,5,XREF)
 ;
 ; Check Previous and Following order numbers
 N ORDER,PREV,FOLL,NEW,OLD,PREVIEN
 F ORDERS=0:0 S ORDERS=$O(^TMP("PSJMERGE_UD",$J,ORDERS)) Q:'ORDERS  D
 . S (NEW,PREV,FOLL,PREVIEN)=""
 . S:$P(^TMP("PSJMERGE_UD",$J,ORDERS),"^",4)]"" NEW=$P(^TMP("PSJMERGE_UD",$J,ORDERS),"^",4)
 . S:$P(^TMP("PSJMERGE_UD",$J,ORDERS),"^",2)]"" PREV=$P(^TMP("PSJMERGE_UD",$J,ORDERS),"^",2)
 . I PREV]"" S PREVIEN=$S($D(^TMP("PSJMERGE_UD",$J,+PREV)):$P(^TMP("PSJMERGE_UD",$J,+PREV),"^",4),1:PREV) D
 . . I PREV["P",$D(^PS(53.1,+PREVIEN,0)) S $P(^PS(53.1,+PREVIEN,0),"^",26)=NEW_"U"
 F ORDER=INITIAL:1 Q:'$D(^PS(55,DFN2,5,ORDER))  D
 . S PREV=$P(^PS(55,DFN2,5,ORDER,0),"^",25),FOLL=$P(^PS(55,DFN2,5,ORDER,0),"^",26)
 . I PREV["U",$D(^TMP("PSJMERGE_UD",$J,+PREV)) D
 . . S $P(^PS(55,DFN2,5,ORDER,0),"^",25)=$P(^TMP("PSJMERGE_UD",$J,+PREV),"^",4)_"U"
 . I FOLL["U",$D(^TMP("PSJMERGE_UD",$J,+FOLL)) D
 . . S $P(^PS(55,DFN2,5,ORDER,0),"^",26)=$P(^TMP("PSJMERGE_UD",$J,+FOLL),"^",4)_"U"
 ;
 S $P(^PS(55,DFN1,5,0),"^",3,4)="0^0"  ; reset last used IEN for FROM patient
 S $P(^PS(55,DFN2,5,0),"^",3,4)=(NEXT-1)_"^"_(NEXT-1)  ; reset last used IEN for TO patient
 ;PSJ*5.0*431: set second piece with sub-file if not already set.
 I $P(^PS(55,DFN2,5,0),"^",2)="" S $P(^PS(55,DFN2,5,0),"^",2)="55.06IA"
 K ^PS(55,"CIMOU",DFN1)
 Q
 ;
MOVEIV(DFN1,DFN2)        ;  move all IV orders for FROM patient
 N ORDERS,X,XREF,NEXT,INITIAL,LASTDFN1,LASTDFN2,HIGHEST
 S LASTDFN1=+$O(^PS(55,DFN1,"IV",9999999999),-1)
 S LASTDFN2=+$O(^PS(55,DFN2,"IV",9999999999),-1)
 S HIGHEST=$S(LASTDFN1>LASTDFN2:LASTDFN1,1:LASTDFN2)
 S (NEXT,INITIAL)=HIGHEST+1
 F ORDERS=0:0 S ORDERS=$O(^PS(55,DFN1,"IV",ORDERS)) Q:'ORDERS  D
 . M ^PS(55,DFN2,"IV",NEXT)=^PS(55,DFN1,"IV",ORDERS)  ; Move to new order
 . D UPDBML(DFN1,ORDERS_"V",DFN2,NEXT_"V")            ; Update BCMA MED LOG file (#53.79), ORDER REFERENCE NUMBER field (#.11)
 . ; set .01 order number if not a number from 53.1
 . I ORDERS=+$P($G(^PS(55,DFN1,"IV",ORDERS,0)),"^") S $P(^PS(55,DFN2,"IV",NEXT,0),"^")=NEXT
 . ; kill xrefs
 . K DA S DA=ORDERS,DA(1)=DFN1
 . S X=$P($G(^PS(55,DFN1,"IV",ORDERS,0)),"^",17) K:X'="D"&($D(^PS(55,DA(1),"IV",DA,"ADC"))) ^PS(55,"ADC",^PS(55,DA(1),"IV",DA,"ADC"),DA(1),DA)
 . K:X'="N" ^PS(55,"ANVO",DA(1),DA)
 . S X=$P($G(^PS(55,DFN1,"IV",ORDERS,0)),"^",3) K ^PS(55,DA(1),"IV","AIS",$E(X,1,30),DA)
 . I $P($G(^PS(55,DA(1),"IV",DA,0)),U,4)]"" K ^PS(55,DA(1),"IV","AIT",$P(^(0),U,4),+X,DA)
 . K ^PS(55,"AIV",+$E(X,1,30),DA(1),DA)
 . S X=$P($G(^PS(55,DFN1,"IV",ORDERS,0)),"^",2) K ^PS(55,"AIVS",$E(X,1,30),DA(1),DA)
 . S X=$P($G(^PS(55,DFN1,"IV",ORDERS,0)),"^") K ^PS(55,DA(1),"IV","B",$E(X,1,30),DA)
 . S ^TMP("PSJMERGE_IV",$J,ORDERS)=ORDERS_"^"_$P($G(^PS(55,DFN1,"IV",ORDERS,2)),"^",5)_"^"_$P($G(^PS(55,DFN1,"IV",ORDERS,2)),"^",6)_"^"_NEXT
 . ; Set new X-refs
 . K DIK,DA S DA=NEXT,DA(1)=DFN2,DIK="^PS(55,"_DA(1)_",""IV"","
 . F XREF="100^ADC^ANVO",".03^AIS^AIT^AIV",".02^AIVS",".01^B" S DIK(1)=XREF D EN^DIK
 . D CNVIV(DFN2,NEXT)
 . D EN1^PSJHL2(DFN1,"OC",ORDERS_"V")  ;  Update CPRS pointer to old order
 . D EN1^PSJHL2(DFN2,"SC",NEXT_"V")  ;  Update CPRS pointer to new order
 . ; Delete old order
 . K ^PS(55,DFN1,"IV",ORDERS)
 . S NEXT=NEXT+1
 ; Kills remaining x-refs
 K ^PS(55,DFN1,"IV","AIN")
 ;
 ; Check Previous and Following order numbers
 N PREV,FOLL,NEW,PREVIEN
 F ORDERS=0:0 S ORDERS=$O(^TMP("PSJMERGE_IV",$J,ORDERS)) Q:'ORDERS  D
 . S (NEW,PREV,FOLL,PREVIEN)=""
 . S:$P(^TMP("PSJMERGE_IV",$J,ORDERS),"^",4)]"" NEW=$P(^TMP("PSJMERGE_IV",$J,ORDERS),"^",4)
 . S:$P(^TMP("PSJMERGE_IV",$J,ORDERS),"^",2)]"" PREV=$P(^TMP("PSJMERGE_IV",$J,ORDERS),"^",2)
 . I PREV]"" S PREVIEN=$S($D(^TMP("PSJMERGE_IV",$J,+PREV)):$P(^TMP("PSJMERGE_IV",$J,+PREV),"^",4),1:PREV) D
 . . I PREV["P",$D(^PS(53.1,+PREVIEN,0)) S $P(^PS(53.1,+PREVIEN,0),"^",26)=NEW_"V"
 F ORDER=INITIAL:1 Q:'$D(^PS(55,DFN2,"IV",ORDER))  D
 . S PREV=$P(^PS(55,DFN2,"IV",ORDER,2),"^",5),FOLL=$P(^PS(55,DFN2,"IV",ORDER,2),"^",6)
 . I PREV["V",$D(^TMP("PSJMERGE_IV",$J,+PREV)) D
 . . S $P(^PS(55,DFN2,5,ORDER,2),"^",5)=$P(^TMP("PSJMERGE_IV",$J,+PREV),"^",4)_"U"
 . I FOLL["V",$D(^TMP("PSJMERGE_IV",$J,+FOLL)) D
 . . S $P(^PS(55,DFN2,5,ORDER,2),"^",6)=$P(^TMP("PSJMERGE_IV",$J,+FOLL),"^",4)_"U"
 ;
 S $P(^PS(55,DFN1,"IV",0),"^",3,4)="0^0"  ; reset last used IEN for FROM patient
 S $P(^PS(55,DFN2,"IV",0),"^",3,4)=(NEXT-1)_"^"_(NEXT-1)  ; reset last used IEN for TO patient
 ;PSJ*5.0*431: set second piece with sub-file if not already set.
 I $P(^PS(55,DFN2,"IV",0),"^",2)="" S $P(^PS(55,DFN2,"IV",0),"^",2)=55.01
 Q
 ;
CHKIVACT(PSJDFN1)       ;
 ; check for active IV orders in ^PS(55, for FROM patient
 N DATE1,PSJFLAG,PSJDT
 D NOW^%DTC S PSJDT=%
 S PSJFLAG=0
 F DATE1=0:0 S DATE1=$O(^PS(55,PSJDFN1,"IV","AIS",DATE1)) Q:'DATE1  D
 . I DATE1>PSJDT S PSJFLAG=1 Q
 Q PSJFLAG
 ;
CHKUDACT(PSJDFN1)       ;
 ; check for active UD orders in ^PS(55, for FROM patient
 N DATE1,PSJFLAG,PSJDT
 D NOW^%DTC S PSJDT=%
 S PSJFLAG=0
 F DATE1=0:0 S DATE1=$O(^PS(55,PSJDFN1,5,"AUS",DATE1)) Q:'DATE1  D
 . I DATE1>PSJDT S PSJFLAG=1 Q
 Q PSJFLAG
 ;
CHKPL(PSJDFN1)       ;Check to see if FROM patient is contained on any pick lists
 N PLNUM,PSJFLAG
 S PSJFLAG=0
 F PLNUM=0:0 S PLNUM=$O(^PS(53.5,PLNUM)) Q:'PLNUM  D
 . ;*217 If pick list is filed away or to be filed away, it should not stop merge.
 . I $D(^PS(53.5,PLNUM,1,"B",PSJDFN1,PSJDFN1)),'$P(^PS(53.5,PLNUM,0),"^",5) S PSJFLAG=1 Q
 Q PSJFLAG
CNVUD(DFN,ON)        ;Convert UD orders.
 N PSJOI,ND,DDRG,XX
 I '$G(^PS(55,DFN,5,ON,.2)) D
 .S PSJOI="",ND=$G(^PS(55,DFN,5,+ON,.1)),DDRG=$O(^PS(55,DFN,5,ON,1,0)),XX=+$G(^PS(55,DFN,5,ON,1,+DDRG,0)) S:XX PSJOI=+$G(^PSDRUG(XX,2))
 .I 'PSJOI F DDRG=0:0 S DDRG=$O(^PSDRUG("AP",+ND,DDRG)) Q:'DDRG!PSJOI  S PSJOI=+$G(^PSDRUG(DDRG,2))
 .I PSJOI S ^PS(55,DFN,5,ON,.2)=PSJOI_U_$P(ND,U,2)
 Q
CNVIV(DFN,ON)        ;Convert IV orders.
 N PSJOI,ND,ADS,ON1,XX
 I '$G(^PS(55,DFN,"IV",ON,.2)) D
 .S PSJOI="",ND=$G(^PS(55,DFN,"IV",ON,6)) F ADS="AD","SOL" I 'PSJOI F ON1=0:0 S ON1=$O(^PS(55,DFN,"IV",ON,ADS,ON1))  Q:'ON1!PSJOI  S XX=+$G(^PS(55,DFN,"IV",ON,ADS,ON1,0)) D
 ..S:XX PSJOI=$S(ADS="AD":$P($G(^PS(52.6,XX,0)),U,11),1:$P($G(^PS(52.7,XX,0)),U,11)) I PSJOI  S ^PS(55,DFN,"IV",ON,.2)=PSJOI_U_$P(ND,U,2,3)
 Q
 ;
UPDBML(FROMDFN,FROMORD,TODFN,TOORD) ; Update the ORDER REFERENCE NUMBER field (#.11) on the BCMA MED LOG file (#53.79)
 ; Input: FROMDFN - From Patient IEN - Pointer to the PATIENT file (#2)
 ;        FROMORD - Original Order Number Pointer and Type of order being moved (e.g., "24U", "55V", etc.)
 ;        TODFN   - To Patient IEN - Pointer to the PATIENT file (#2)
 ;        TOORD   - New Order Number Pointer and Type of order being moved (e.g., "48U", "105V", etc.)
 ;
 N DTTM,BMLIEN,DIE,DA,DR
 S (DTTM,BMLIEN)=0
 F  S DTTM=$O(^PSB(53.79,"AORDX",FROMDFN,FROMORD,DTTM)) Q:'DTTM  D
 . F  S BMLIEN=$O(^PSB(53.79,"AORDX",FROMDFN,FROMORD,DTTM,BMLIEN)) Q:'BMLIEN  D
 . . S DIE="^PSB(53.79,",DA=BMLIEN,DR=".11////"_TOORD D ^DIE
 ; Setting (Beforehand) and Killing some x-refs that do not get set/cleaned up by the Merge routines
 M ^PSB(53.79,"AADT",TODFN)=^PSB(53.79,"AADT",FROMDFN)
 M ^PSB(53.79,"AEDT",TODFN)=^PSB(53.79,"AEDT",FROMDFN)
 M ^PSB(53.79,"AOIP",TODFN)=^PSB(53.79,"AOIP",FROMDFN)
 K ^PSB(53.79,"AADT",FROMDFN)
 K ^PSB(53.79,"AEDT",FROMDFN)
 K ^PSB(53.79,"AOIP",FROMDFN)
 Q
