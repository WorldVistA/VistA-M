PRCFFUD ;WISC/SJG-UTILITY FOR CARRY FORWARD ;7/24/00  23:14
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
 ; No top level entry
 ;
OBDT() ; Check if obligation processing date is valid for the open quarter
 N GOFLAG,MOP,STNQTR,PODATE,PRIMARY,SDATE1,SDATE2,SDATE3,SDATE4,SPIECE1,SPIECE2,SPIECE3,SPIECE4,RBQTR,AMDDATE
 S GOFLAG=0
 S MOP=$$NP^PRC0B("^PRC(442,"_+PO_",",0,2)
 S PRIMARY=$$NP^PRC0B("^PRC(442,"_+PO_",",0,12)
 S STNQTR=$$NP^PRC0B("^PRC(420,"_+PRC("SITE")_",",0,9)
 ; If obligation is an original entry, use PO date
 ; If obligation is an amendment, use amendment date
 I '$D(PRCFA("AMEND#")) S PODATE=$$NP^PRC0B("^PRC(442,"_+PO_",",1,15)
 I $D(PRCFA("AMEND#")),MOP'=21 D  S PODATE=$G(AMDDATE)
 .; If amendment is initial document, get info from file 443.6
 .I PRCFA("RETRAN")=0 D  Q
 ..N SUBINFO S SUBINFO="443.67^1^"_PRCFA("AMEND#")
 ..K PRCTMP(443.67,PRCFA("AMEND#"),1)
 ..D GENDIQ^PRCFFU7(443.6,PRCFA("PODA"),50,"IEN",SUBINFO)
 ..S AMDDATE=$G(PRCTMP(443.67,PRCFA("AMEND#"),1,"I"))
 ..K PRCTMP(443.67,PRCFA("AMEND#"),1)
 ..Q
 .; If amendment is rebuild, get info from file 442
 .I PRCFA("RETRAN")=1 D  Q
 ..N SUBINFO S SUBINFO="442.07^1^"_PRCFA("AMEND#")
 ..K PRCTMP(442.07,PRCFA("AMEND#"),1)
 ..D GENDIQ^PRCFFU7(442,PRCFA("PODA"),50,"IEN",SUBINFO)
 ..S AMDDATE=$G(PRCTMP(442.07,PRCFA("AMEND#"),1,"I"))
 ..K PRCTMP(442.07,PRCFA("AMEND#"),1)
 ..Q
 .Q
 S SDATE1=$$DATE^PRC0C(PODATE,"I"),SDATE2=$$DATE^PRC0C(PRCFA("OBLDATE"),"I"),SDATE3=$$DATE^PRC0C(STNQTR,"I")
 S SPIECE1=$P(SDATE1,U,1,2),SPIECE2=$P(SDATE2,U,1,2),SPIECE3=$P(SDATE3,U,1,2)
 ; Check if transaction is a 1358
 I MOP=21 D  G QUIT
 .S RBQTR=$$NP^PRC0B("^PRCS(410,"_PRIMARY_",",0,11)
 .S SDATE4=$$DATE^PRC0C(RBQTR,"I"),SPIECE4=$P(SDATE4,U,1,2)
 .I SPIECE2=SPIECE4 S GOFLAG=1 Q
 ; Check if transaction has a 2237 request
 I $G(PRIMARY)="" D  G QUIT
 .; allow PO/oblig date from current qtr
 .I SPIECE1=SPIECE2,SPIECE2=SPIECE3 S GOFLAG=1 Q
 .; allow PO/oblig date for fut qtr if PO date qtr same as oblig qtr
 .I SPIECE3=SPIECE2,SPIECE2]SPIECE1 S GOFLAG=1 Q
 .; allow PO/oblig date for fut qtr if oblig qtr later than stn open qtr
 .I SPIECE2]SPIECE3 S GOFLAG=1 Q
 I $G(PRIMARY)]"" D  G QUIT
 .; allow PO/oblig date from current qtr
 .I SPIECE1=SPIECE2,SPIECE2=SPIECE3 S GOFLAG=1 Q
 .; allow PO/oblig date from future qtr
 .I SPIECE1=SPIECE2,SPIECE2]SPIECE3 S GOFLAG=1 Q
 .; allow PO/oblig date from prior qtr if open qtr same as oblig qtr
 .I SPIECE2=SPIECE3,SPIECE3]SPIECE1 S GOFLAG=1 Q
QUIT QUIT GOFLAG
 ;
NEW410 ; Create an entry in File 410 for any PO that does not have a request
 Q:$G(PRCFA("RETRAN"))=1
 W ! D EN^DDIOL("...now creating entry in File 410...")
 N POAMT,P410,NEW410
 S POAMT=+$S($P(PRCFMO,"^",12)="N":$P(PO(0),"^",16),1:$P(PO(0),"^",15))
 S P410=+PRCFA("REF")_U_+$P(PO(0),U,3)_U_"A"_U_2_U_PRCFA("OBLDATE")_U_POAMT_U_$P(PRCFA("REF"),"-",2)_"WR"_U_"ST"_U_+PO
 S $P(P410,U,10,11)=PRC("FYQDT")_U_PRC("BBFY")
 D A410^PRC0F(.NEW410,P410) S PRCFA("NEW410")=NEW410
 QUIT
 ;
AMEND ; Create an entry in File 410 for each amendment to a purchase order
 ; Case 1 - amendment with no cancelled documents
 Q:$G(PRCFA("RETRAN"))=1
 N AMDEXT S AMDEXT="-"_$G(PRCFA("AMEND#"))
 W ! D EN^DDIOL("...now creating entry in File 410 for the amendment...")
 I '$D(PRCFA("CANCEL")) D  Q
 .N AMDAMT,P410,NEW410 S AMDAMT=$$AMDAMT()
 .S P410=+PRCFA("REF")_U_+$P(PO(0),U,3)_U_"A"_U_2_U_PRCFA("OBLDATE")_U_AMDAMT_U_$P(PRCFA("REF"),"-",2)_AMDEXT_U_"ST"_U_+PO
 .S $P(P410,U,10,11)=PRC("FYQDT")_U_PRC("BBFY")
 .D A410^PRC0F(.NEW410,P410) S PRCFA("NEW410")=NEW410
 .Q
 ; Case 2 - amendment types: vendor change, FCP change, PO number change
 I $D(PRCFA("CANCEL")),'PRCFA("AUTHE") D  Q
 .; First update for the old record
 .N AMDAMT,POREF,AMDNO,FCP,OLDFCP
 .S AMDAMT=$$AMDAMT1()
 .I $G(PRCFA("PO"))=1 S POREF=PRCFA("OLDPODA")_U_PRCFA("OLDREF")
 .I $G(PRCFA("PO"))="" S POREF=PRCFA("PODA")_U_PRCFA("REF")
 .I $G(PRCFA("FCP"))=1 D  S FCP=+OLDFCP
 ..N LOOP ; "AC" cross ref sorts changes by field# (1=FCP) and amendment type (30=FCP edit)
 ..S LOOP=$O(^PRC(442,PRCFA("PODA"),6,PRCFA("AMEND#"),3,"AC",30,1,0))
 ..I LOOP]"" S OLDFCP=^PRC(442,PRCFA("PODA"),6,PRCFA("AMEND#"),3,LOOP,1,1,0)
 ..Q
 .I $G(PRCFA("FCP"))="" S FCP=+$P(PO(0),U,3)
 .S P410=+$P(POREF,U,2)_U_FCP_U_"A"_U_2_U_PRCFA("OBLDATE")_U_AMDAMT_U_$P($P(POREF,U,2),"-",2)_AMDEXT_U_"ST"_U_+POREF
 .S $P(P410,U,10,11)=PRC("FYQDT")_U_PRC("BBFY")
 .D A410^PRC0F(.NEW410,P410)
 .; Then update for new record
 .S AMDAMT=-AMDAMT
 .I $G(PRCFA("PO"))=1 S POREF=PRCFA("NEWPODA")_U_PRCFA("NEWREF"),AMDEXT=""
 .I $G(PRCFA("PO"))="" S POREF=PRCFA("PODA")_U_PRCFA("REF")
 .S P410=+$P(POREF,U,2)_U_+$P(PO(0),U,3)_U_"A"_U_2_U_PRCFA("OBLDATE")_U_AMDAMT_U_$P($P(POREF,U,2),"-",2)_AMDEXT_U_"ST"_U_+POREF
 .S $P(P410,U,10,11)=PRC("FYQDT")_U_PRC("BBFY")
 .D A410^PRC0F(.NEW410,P410)
 .Q
 ; Case 3 - amendments type - cancel by Authority E
 I $D(PRCFA("CANCEL")),PRCFA("AUTHE") D  Q
 .N AMDAMT S AMDAMT=$$AMDAMT1(),AMDEXT=AMDEXT_"#"
 .S P410=+PRCFA("REF")_U_+$P(PO(0),U,3)_U_"A"_U_2_U_PRCFA("OBLDATE")_U_AMDAMT_U_$P(PRCFA("REF"),"-",2)_AMDEXT_U_"ST"_U_+PO
 .S $P(P410,U,10,11)=PRC("FYQDT")_U_PRC("BBFY")
 .D A410^PRC0F(.NEW410,P410) S PRCFA("NEW410")=NEW410
 .Q
 QUIT
PO ; Updating Running Balance Status Field (#449) in File 410 for 
 ; purchase order
 Q:$G(PRCFA("RETRAN"))=1
 Q:$G(PRCTMP(442,+PO,.07,"I"))=""
 I $G(PRCTMP(442,+PO,.07,"I"))]""  D  Q
 .W !!,"...updating running balance status fields in 410...WITH 2237"
 .N LOOP S LOOP=0
 .F  S LOOP=$O(^PRC(442,+PO,13,LOOP)) Q:LOOP=""!(LOOP'>0)  I LOOP>0 D EDIT410(LOOP,"O")
 .Q
 QUIT
AMD ; Updating Running Balance Status Field (#449) in File 410 for
 ; purchase order amendment
 Q:$G(PRCFA("RETRAN"))=1
 W !!,"...updating running balance status fields in 410...FOR AMENDMENT"
 D EDIT410(NEW410,"O")
 QUIT
 ;
EDIT410(TRDAIEN,TRSTAT) ; Edit running balance status and running balance quarter fields in 410
 D ERS410^PRC0G(TRDAIEN_"^"_TRSTAT)
 QUIT
 ;
 ; Message processing
AMDAMT() ; Get dollar amount for AMENDMENT from amendment multiple
 N SUBINFO,AMDAMT S SUBINFO="442.07^2^"_PRCFA("AMEND#")
 D GENDIQ^PRCFFU7(442,PRCFA("PODA"),50,"IEN",SUBINFO)
 S AMDAMT=$G(PRCTMP(442.07,PRCFA("AMEND#"),2,"E"))
 Q AMDAMT
AMDAMT1() ; Get dollar amount for AMENDMENT from zero node
 N AMDAMT
 S AMDAMT=-$S($P(PRCFMO,"^",12)="N":$P(PO(0),"^",16),1:$P(PO(0),"^",15))
 Q AMDAMT
MSG1 ;
 K MSG W !
 S MSG(1)="The Obligation Processing Date is not a valid date for this transaction."
 S MSG(2)="Please enter a date which matches the requests or p.o. quarter."
 D EN^DDIOL(.MSG) K MSG W !
 QUIT
