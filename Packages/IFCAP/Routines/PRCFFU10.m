PRCFFU10 ;WISC/SJG-OBLIGATION PROCESSING UTILITIES ;7/24/00  23:16
V ;;5.1;IFCAP;**58**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
 ; No top level entry
 ; Check overcommit for control point for P.O.
 ;
 ; AMT is obtained from PO (Net Amount field #92) if original entry 
 ; or from amendment multiple subfield (Amount Changed field #2)
 ; if modification
 ;
OVCOM N PARAM,AMT,TYPE
 S PRCFA("OVCOM")=0
 I '$D(PRCFA("MOD")) D  G OV1
 .S AMT=$P(PO(0),U,16)
 .I $D(^PRC(443.6,+PO,6)),$D(PO(6)) S AMT=$P(PO(6),U,3)
 .Q
 I $D(PRCFA("MOD")) S TYPE=$P(PRCFA("MOD"),U)
 S:TYPE="E" AMT=$P(PO(0),U,16)
 I $D(PO(6)) S:TYPE="M" AMT=$P(PO(6),U,3)
OV1 ;S PARAM=PRC("SITE")_U_+$P(PO(0),U,3)_U_PRC("FY")_U_PRC("QTR")
 ;S PRCFA("OVCOM")=$$YEAR^PRC0C(PRC("FY"))'<$$DATE^PRC0C("N","E")
 ;S:PRCFA("OVCOM") PRCFA("OVCOM")=$$OVCOM^PRCS0A(PARAM,AMT,1)
 ;
 ; **Add call to OBLDAT^PRCFFUD1 as part of PRC*5.1*58
 S PRCFA("OVCOM")=$$OVCOM^PRCS0A(PRC("SITE")_"^"_+PRC("CP")_"^"_$P($$DATE^PRC0C($$OBLDAT^PRCFFUD1(PRC("RBDT"),$G(PRC("AMENDT"))),"I"),"^",1,2),AMT,1)
 K OBLDAT
 ; **End fix for PRC*5.1*58
 ;
 Q
POFAIL ; Display error message for P.O if failure
 W !!,"  This Purchase Order would overcommit the funds available for the"
 W !,"  Fund Control Point.  Please return the Purchase Order to the Service.",!
 Q
OVCOM1 ; Check overcommit for control point for 1358
 N PARAM,AMT
 S PRCFA("OVCOM")=0,AMT=$P(TRNODE(4),U,8)
 ;S PARAM=PRC("SITE")_U_+$P(TRNODE(3),U)_U_PRC("FY")_U_PRC("QTR")
 ;S PRCFA("OVCOM")=$$YEAR^PRC0C(PRC("FY"))'<$$DATE^PRC0C("N","E")
 ;S:PRCFA("OVCOM") PRCFA("OVCOM")=$$OVCOM^PRCS0A(PARAM,AMT,1)
 S PRCFA("OVCOM")=$$OVCOM^PRCS0A(PRC("SITE")_"^"_PRC("CP")_"^"_$P($$DATE^PRC0C(PRC("RBDT"),"I"),"^",1,2),AMT,1)
 Q
REQFAIL ; Display error message for 1358 if failure
 W !!,"  This 1358 request would overcommit the funds available for the"
 W !,"  Fund Control Point.  Please return the 1358 to the Service."
 Q
