PSJPATMR        ;BIR/RSB,LDT-UTILITY FOR PATIENT MERGE ;28 Oct 99 / 12:53 PM
 ;;5.0; INPATIENT MEDICATIONS ;**36**;16 DEC 97
 ;
 ; Reference to ^PS(55 supported by DBIA #2191.
 ; Reference to ^PS(52.6 is supported by DBIA 1231
 ; Reference to ^PS(52.7 is supported by DBIA 2173
 ; Reference to ^PSDRUG( is supported by DBIA 2192
 ;
EN(DFN1,DFN2)   ;
 ; check active IV, UD, and Orders on a pick list
 I $$CHKIVACT(DFN1)!($$CHKUDACT(DFN1))!($$CHKPL(DFN1)) Q 0
 N DUPUD,DUPIV K ^TMP("PSJMERGE_UD",$J),^TMP("PSJMERGE_IV",$J)
 S DUPUD=$$CHKUDDUP(DFN1,DFN2),DUPIV=$$CHKIVDUP(DFN1,DFN2)
 I +DUPUD=1 D
 .S DUPUD=$P(DUPUD,"^",2) D MOVEUD(DFN1,DUPUD)
 I +DUPIV=1 D
 .S DUPIV=$P(DUPIV,"^",2) D MOVEIV(DFN1,DUPIV)
 K ^TMP("PSJMERGE_UD",$J),^TMP("PSJMERGE_IV",$J)
 Q 1
 ;
CHKUDDUP(PSJDFN1,PSJDFN2)       ;
 ; check for Unit Dose orders in ^PS(55, with duplicate order numbers for both patients
 N ORD1,ORD2,O1,O2,PSJFLAG,DUP1,DUP2,DUP,HIGHEST
 S (PSJFLAG,HIGHEST)=0
 F ORD1=0:0 S ORD1=$O(^PS(55,PSJDFN1,5,"B",ORD1)) Q:'ORD1  D
 . F O1=0:0 S O1=$O(^PS(55,PSJDFN1,5,"B",ORD1,O1)) Q:'O1  D 
 . . S DUP1(O1)="" S:O1>HIGHEST HIGHEST=O1
 F ORD2=0:0 S ORD2=$O(^PS(55,PSJDFN2,5,"B",ORD2)) Q:'ORD2  D
 . F O2=0:0 S O2=$O(^PS(55,PSJDFN2,5,"B",ORD2,O2)) Q:'O2  D
 . . S DUP2(O2)="" S:O2>HIGHEST HIGHEST=O2
 F DUP=0:0 S DUP=$O(DUP1(DUP)) Q:'DUP!(PSJFLAG=1)  D
 . I $D(DUP2(DUP)) S PSJFLAG=1  ; duplicate order numbers found
 Q PSJFLAG_$S(PSJFLAG=1:"^"_(HIGHEST+1),1:"")
 ;
MOVEUD(DFN1,COUNT)      ;  move all Unit Dose orders for FROM patient
 N ORDERS,XREF,STOP,X S STOP=COUNT
 F ORDERS=0:0 S ORDERS=$O(^PS(55,DFN1,5,ORDERS)) Q:'ORDERS!(ORDERS=STOP)  D
 . M ^PS(55,DFN1,5,COUNT)=^PS(55,DFN1,5,ORDERS)  ; Move to new order
 . ; set .01 order number if not a number from 53.1
 . I ORDERS=+$P($G(^PS(55,DFN1,5,ORDERS,0)),"^") S $P(^PS(55,DFN1,5,COUNT,0),"^")=COUNT
 . ; kill xrefs
 . K DA S DA=ORDERS,DA(1)=DFN1
 . S X=$P($G(^PS(55,DA(1),5,DA,0)),"^",7) I $D(^PS(55,DA(1),5,DA,2)),$P(^(2),"^",4) K ^PS(55,DA(1),5,"AU",X,+$P(^(2),"^",4),DA)
 . K ^PS(55,"ANV",DA(1),DA)
 . K ^PS(55,"APV",DA(1),DA)
 . K ^PS(55,"AUE",DA(1),DA)
 . K ^PS(55,DA(1),5,"B",$P($G(^PS(55,DA(1),5,DA,0)),"^"),DA)
 . S X=$P($G(^PS(55,DA(1),5,DA,2)),"^",4) K ^PS(55,"AUD",$E(X,1,30),DA(1),DA)
 . K ^PS(55,DA(1),5,"AUS",+X,DA) I $P($G(^PS(55,DA(1),5,DA,0)),"^",7)]"" K ^PS(55,DA(1),5,"AU",$P(^(0),"^",7),+X,DA)
 . S X=$P($G(^PS(55,DA(1),5,DA,2)),"^",2) K ^PS(55,"AUDDD",$E(X,1,30),DA(1),DA)
 . K ^PS(55,"AUDS",$E(X,1,30),DA(1),DA)
 . S X=$P($G(^PS(55,DA(1),5,DA,.1)),"^") K:+X ^PS(55,DA(1),5,"C",$E(X,1,30),DA)
 . ; set table for previous and following order numbers
 . S ^TMP("PSJMERGE_UD",$J,ORDERS)=ORDERS_"^"_$P($G(^PS(55,DFN1,5,ORDERS,0)),"^",25)_"^"_$P($G(^PS(55,DFN1,5,ORDERS,0)),"^",26)_"^"_COUNT
 . ; kill entire order 
 . K ^PS(55,DFN1,5,ORDERS)
 . ; Set new X-refs
 . K DIK,DA S DA=COUNT,DA(1)=DFN1,DIK="^PS(55,"_DA(1)_",5,"
 . F XREF=7,51,50,34,64,10,".01^AUE^B" S DIK(1)=XREF D EN^DIK
 . D CNVUD(DFN1,COUNT)
 . D EN1^PSJHL2(DFN1,"SC",COUNT_"U")  ;  Update CPRS pointer to order
 . S COUNT=COUNT+1
 ; Check Previous and Following order numbers
 N PREV,FOLL,NEW,OLD,SUB,PREVIEN,FOLLIEN S SUB="PSJMERGE_UD"
 F ORDERS=0:0 S ORDERS=$O(^TMP(SUB,$J,ORDERS)) Q:'ORDERS  D
 . S (NEW,OLD,PREV,FOLL,PREVIEN,FOLLIEN)=""
 . S:$P(^TMP(SUB,$J,ORDERS),"^",4)]"" NEW=$P(^TMP(SUB,$J,ORDERS),"^",4)
 . S:$P(^TMP(SUB,$J,ORDERS),"^")]"" OLD=$P(^TMP(SUB,$J,ORDERS),"^")
 . S:$P(^TMP(SUB,$J,ORDERS),"^",2)]"" PREV=$P(^TMP(SUB,$J,ORDERS),"^",2)
 . S:$P(^TMP(SUB,$J,ORDERS),"^",3)]"" FOLL=$P(^TMP(SUB,$J,ORDERS),"^",3)
 . I PREV]"" S PREVIEN=$S($D(^TMP(SUB,$J,+PREV)):$P(^TMP(SUB,$J,+PREV),"^",4),1:PREV) D
 . . I PREV["P",$D(^PS(53.1,+PREVIEN,0)) S $P(^PS(53.1,+PREVIEN,0),"^",26)=NEW_"U"
 . . I PREV["U",$D(^PS(55,DFN1,5,+PREVIEN,0)) S $P(^PS(55,DFN1,5,+PREVIEN,0),"^",26)=NEW_"U"
 . I FOLL]"" S FOLLIEN=$S($D(^TMP(SUB,$J,+FOLL)):$P(^TMP(SUB,$J,+FOLL),"^",4),1:FOLL) D
 . . S:$D(@("^PS(55,"_DFN1_",5,"_+FOLLIEN_",0)")) $P(@("^PS(55,"_DFN1_",5,"_+FOLLIEN_",0)"),"^",25)=NEW_"U"
 S $P(^PS(55,DFN1,5,0),"^",3)=COUNT-1  ; reset last used IEN for FROM patient
 S $P(^PS(55,DFN2,5,0),"^",3)=COUNT-1  ; reset last used IEN for TO patient
 Q
 ;
CHKIVDUP(PSJDFN1,PSJDFN2)       ;
 ; check for IV orders in ^PS(55, with duplicate order numbers for both patients
 N ORD1,ORD2,O1,O2,PSJFLAG,DUP1,DUP2,DUP,HIGHEST
 S (PSJFLAG,HIGHEST)=0
 F ORD1=0:0 S ORD1=$O(^PS(55,PSJDFN1,"IV","B",ORD1)) Q:'ORD1  D
 . F O1=0:0 S O1=$O(^PS(55,PSJDFN1,"IV","B",ORD1,O1)) Q:'O1  D 
 . . S DUP1(O1)="" S:O1>HIGHEST HIGHEST=O1
 F ORD2=0:0 S ORD2=$O(^PS(55,PSJDFN2,"IV","B",ORD2)) Q:'ORD2  D
 . F O2=0:0 S O2=$O(^PS(55,PSJDFN2,"IV","B",ORD2,O2)) Q:'O2  D
 . . S DUP2(O2)="" S:O2>HIGHEST HIGHEST=O2
 F DUP=0:0 S DUP=$O(DUP1(DUP)) Q:'DUP!(PSJFLAG=1)  D
 . I $D(DUP2(DUP)) S PSJFLAG=1  ; duplicate order numbers found
 Q PSJFLAG_$S(PSJFLAG=1:"^"_(HIGHEST+1),1:"")
 ;
MOVEIV(DFN1,COUNT)        ;  move all IV orders for FROM patient
 N ORDERS,STOP,X S STOP=COUNT
 F ORDERS=0:0 S ORDERS=$O(^PS(55,DFN1,"IV",ORDERS)) Q:'ORDERS!(ORDERS=STOP)  D
 . M ^PS(55,DFN1,"IV",COUNT)=^PS(55,DFN1,"IV",ORDERS)  ; Move to new order
 . ; set .01 order number if not a number from 53.1
 . I ORDERS=+$P($G(^PS(55,DFN1,"IV",ORDERS,0)),"^") S $P(^PS(55,DFN1,"IV",COUNT,0),"^")=COUNT
 . ; kill xrefs
 . K DA S DA=ORDERS,DA(1)=DFN1
 . S X=$P($G(^PS(55,DFN1,"IV",ORDERS,0)),"^",17) K:X'="D"&($D(^PS(55,DA(1),"IV",DA,"ADC"))) ^PS(55,"ADC",^PS(55,DA(1),"IV",DA,"ADC"),DA(1),DA)
 . K:X'="N" ^PS(55,"ANVO",DA(1),DA)
 . S X=$P($G(^PS(55,DFN1,"IV",ORDERS,0)),"^",3) K ^PS(55,DA(1),"IV","AIS",$E(X,1,30),DA)
 . I $P($G(^PS(55,DA(1),"IV",DA,0)),U,4)]"" K ^PS(55,DA(1),"IV","AIT",$P(^(0),U,4),+X,DA)
 . K ^PS(55,"AIV",+$E(X,1,30),DA(1),DA)
 . S X=$P($G(^PS(55,DFN1,"IV",ORDERS,0)),"^",2) K ^PS(55,"AIVS",$E(X,1,30),DA(1),DA)
 . S X=$P($G(^PS(55,DFN1,"IV",ORDERS,0)),"^") K ^PS(55,DA(1),"IV","B",$E(X,1,30),DA)
 . S ^TMP("PSJMERGE_IV",$J,ORDERS)=ORDERS_"^"_$P($G(^PS(55,DFN1,"IV",ORDERS,2)),"^",5)_"^"_$P($G(^PS(55,DFN1,"IV",ORDERS,2)),"^",6)_"^"_COUNT
 . ; Delete old order
 . K ^PS(55,DFN1,"IV",ORDERS)
 . ; Set new X-refs
 . K DIK,DA S DA=COUNT,DA(1)=DFN1,DIK="^PS(55,"_DA(1)_",""IV"","
 . F XREF="100^ADC^ANVO",".03^AIS^AIT^AIV",".02^AIVS",".01^B" S DIK(1)=XREF D EN^DIK
 . D CNVIV(DFN1,COUNT)
 . D EN1^PSJHL2(DFN1,"SC",COUNT_"V")  ;  Update CPRS pointer to order
 . S COUNT=COUNT+1
 ; Check Previous and Following order numbers
 N PREV,FOLL,NEW,OLD,SUB,PREVIEN,FOLLIEN S SUB="PSJMERGE_IV"
 F ORDERS=0:0 S ORDERS=$O(^TMP(SUB,$J,ORDERS)) Q:'ORDERS  D
 . S (NEW,OLD,PREV,FOLL,PREVIEN,FOLLIEN)=""
 . S:$P(^TMP(SUB,$J,ORDERS),"^",4)]"" NEW=$P(^TMP(SUB,$J,ORDERS),"^",4)
 . S:$P(^TMP(SUB,$J,ORDERS),"^")]"" OLD=$P(^TMP(SUB,$J,ORDERS),"^")
 . S:$P(^TMP(SUB,$J,ORDERS),"^",2)]"" PREV=$P(^TMP(SUB,$J,ORDERS),"^",2)
 . S:$P(^TMP(SUB,$J,ORDERS),"^",3)]"" FOLL=$P(^TMP(SUB,$J,ORDERS),"^",3)
 . I PREV]"" S PREVIEN=$S($D(^TMP(SUB,$J,+PREV)):$P(^TMP(SUB,$J,+PREV),"^",4),1:PREV) D
 . . I PREV["P",$D(^PS(53.1,+PREVIEN,0)) S $P(^PS(53.1,+PREVIEN,0),"^",26)=NEW_"V"
 . . I PREV["V",$D(^PS(55,DFN1,"IV",+PREVIEN,0)) S $P(^PS(55,DFN1,"IV",+PREVIEN,2),"^",6)=NEW_"V"
 . I FOLL]"" S FOLLIEN=$S($D(^TMP(SUB,$J,+FOLL)):$P(^TMP(SUB,$J,+FOLL),"^",4),1:FOLL) D
 . . S:$D(^PS(55,DFN1,"IV",+FOLLIEN,0)) $P(^PS(55,DFN1,"IV",+FOLLIEN,2),"^",5)=NEW_"V"     Q
 S $P(^PS(55,DFN1,"IV",0),"^",3)=COUNT-1  ; reset last used IEN for FROM patient
 S $P(^PS(55,DFN2,"IV",0),"^",3)=COUNT-1  ; reset last used IEN for TO patient
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
CHKPL(PSJDFN1)       ;
 ; check to see if FROM patient is contained on any pick lists
 N PLNUM,PSJFLAG
 S PSJFLAG=0
 F PLNUM=0:0 S PLNUM=$O(^PS(53.5,PLNUM)) Q:'PLNUM  D
 . I $D(^PS(53.5,PLNUM,1,"B",PSJDFN1,PSJDFN1)) S PSJFLAG=1 Q
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
  
