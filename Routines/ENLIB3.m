ENLIB3 ;WCIOFO/DH,SAB-Package Utilities (FAP) ;9/2/1998
 ;;7.0;ENGINEERING;**25,33,35,37,39,46,57**;Aug 17,1993
PO ; Populate appropriate equipment data from IFCAP purchase order.
 ; Normally called when PO entered into Equipment File
 ; Input Variables
 ;   X  => PO# 
 ;   DA => Equipment IEN
 N BBFY,FCP,FSC,PO,PODATE
 S PO("E")=X
 ; make sure item has not been reported to FAP
 I $D(^ENG(6915.2,"B",DA)),+$$CHKFA^ENFAUTL(DA) Q  ; active FA Document
 ; find P.O.
 S PO("I")=$$FIND1^DIC(442,"","X",PO("E"),"C^B")
 Q:'PO("I")  ; couldn't find IFCAP P.O.
 ; update Vendor Pointer when null
 I $P($G(^ENG(6914,DA,2)),U)="" D
 . S X=$$GET1^DIQ(442,PO("I"),5,"I")
 . I X]"" S $P(^ENG(6914,DA,2),U)=X
 ; update Acquisition Source when null
 I $P($G(^ENG(6914,DA,2)),U,14)="" D
 . S X=$$GET1^DIQ(442,PO("I"),8,"I")
 . I X]"" S $P(^ENG(6914,DA,2),U,14)=X
 ; update Service Pointer when null
 I $P($G(^ENG(6914,DA,3)),U,2)="" D
 . S X=$$GET1^DIQ(442,PO("I"),5.2,"I")
 . I X]"" S $P(^ENG(6914,DA,3),U,2)=X,^ENG(6914,"AC",X,DA)=""
 ; update Fund Control Point when null
 S FCP=$$GET1^DIQ(442,PO("I"),1)
 I $P($G(^ENG(6914,DA,8)),U,3)="" D
 . I FCP]"" S $P(^ENG(6914,DA,8),U,3)=FCP
 ; update Cost Center when null ***obsolete: now computed from CMR***
 ;I $P($G(^ENG(6914,DA,8)),U,4)="" D
 ;. S X=$$GET1^DIQ(442,PO("I"),2,"I")
 ;. I X]"" S $P(^ENG(6914,DA,8),U,4)=X
 ; check availability of data
 S FSC=$P($$GET1^DIQ(6914,DA,18),"-")
 S PODATE=$$GET1^DIQ(442,PO("I"),.1,"I")
 S BBFY=$$GET1^DIQ(442,PO("I"),26,"I")
 Q:FCP=""!(PODATE="")!(BBFY="")!(FSC'?4N)  ; can't proceed
 ;
FAP N AO,BOC,BOCX,BUDFY,DEPT,DOCFY,ENI,ENX,ENY,EQUITY,FUND,FUNDX
 N IENS,SGL,STATION
 S STATION=$P($$GET1^DIQ(442,PO("I"),.01),"-")
 S DOCFY=$E($E(PODATE,1,3)+$E(PODATE,4),2,3) ; 2 digit document FY
 S BUDFY=$E(BBFY,1,3)+1700 ; 4 digit beginning budget FY
 S DEPT=$E($$GET1^DIQ(6914,DA,19),1,2)
 ; determine BOC
 ;   loop thru item multiple for item matching FSC
 S ENI=0,BOC="",BOCX=""
 F  S ENI=$O(^PRC(442,PO("I"),2,ENI)) Q:'ENI  D  Q:BOC]""
 . S IENS=ENI_","_PO("I")_","
 . Q:$$GET1^DIQ(442.01,IENS,8)'=FSC
 . S BOCX=$E($$GET1^DIQ(442.01,IENS,3.5),1,4)
 . I BOCX]"" S BOC=$$BOCI(BOCX)
 ;   if not found then loop thru BOC multiple for a NX BOC
 I BOC="" S ENI=0 F  S ENI=$O(^PRC(442,PO("I"),22,ENI)) Q:'ENI  D  Q:BOC]""
 . S IENS=ENI_","_PO("I")_","
 . S BOCX=$E($$GET1^DIQ(442.041,IENS,.01),1,4)
 . I BOCX]"" S BOC=$$BOCI(BOCX)
 ; determine SGL
 I $G(BOC)>0 S SGL=$P(^ENG(6914.4,BOC,0),U,3)
 E  S SGL=10 ;Expensed NX
 ; determine AO and FUND
 S X=$$ACC^PRC0C(STATION,FCP_U_DOCFY_U_BUDFY)
 I $P(X,U)]"" S AO=$O(^ENG(6914.7,"B",$P(X,U),0))
 I $P(X,U,5)]"" S FUND="",FUNDX=$P(X,U,5) D
 . ; check for matching Fund table entry
 . S FUND=$$FUNDI(FUNDX) Q:FUND]""
 . ; then how about a Fund table entry that matches the 1st 5 char
 . I $L(FUNDX)>5 S FUND=$$FUNDI($E(FUNDX,1,5)) Q:FUND]""
 . ; then how about a Fund table entry that matches the 1st 4 char
 . I $L(FUNDX)>4 S FUND=$$FUNDI($E(FUNDX,1,4)) Q:FUND]""
 . ; then how about a Fund table entry whose associated fund field
 . ;   matches the 1st four char
 . I $L(FUNDX)>3 S FUND=$$AFUNDI($E(FUNDX,1,4)) Q:FUND]""
 . ; then how about a Fund table entry that starts with the 1st 4 char
 . I $L(FUNDX)>3 S ENX=$E(FUNDX,1,4)_" " F  D  Q:ENX=""!(FUND]"")
 . . S ENX=$O(^ENG(6914.6,"B",ENX)) ; next fund in table
 . . I $E(ENX,1,4)'=$E(FUNDX,1,4) S ENX="" Q  ; can stop looking
 . . S FUND=$$FUNDI(ENX)
 ;
 I $G(FUND)="" D
 . I DEPT="06" S FUND=2 Q  ; CANTEEN
 . I DEPT=56 S FUND=3 Q  ; CWT
 . ;S FUND=1 ; AMAF ; Stopped using AMAF with Patch EN*7*57 (9/98)
 ;
 ;I $G(AO)="" D  ;Disabled at request of FMS (9/96)
 ;. I DEPT>59,DEPT<69 S AO=4 Q
 ;. I DEPT=57!(DEPT=58) S AO=5 Q
 ;. I DEPT=72 S AO=2 Q
 ;. S X=$E(STATION) I X=3 S AO=4 Q
 ;. I "8^9"[X S AO=5 Q
 ;. I "4^5^6"[X S AO=3
 ;
 S EQUITY=$S("^5^12^"[(U_$G(FUND)_U):3402,$G(AO)=3:3299,$G(AO)=4:3210,$G(AO)=5:3210,$G(AO)=7:3210,1:"")
 ;
 S ENY=$G(^ENG(6914,DA,8))
 S:$P(ENY,U,6)="" $P(ENY,U,6)=$G(SGL)
 S ^ENG(6914,DA,8)=ENY
 ;
 S ENY=$G(^ENG(6914,DA,9))
 S:$P(ENY,U,6)="" $P(ENY,U,6)=$G(BOC)
 S:$P(ENY,U,7)="" $P(ENY,U,7)=$G(FUND)
 S:$P(ENY,U,8)="" $P(ENY,U,8)=$G(AO)
 S:$P(ENY,U,9)="" $P(ENY,U,9)=$G(EQUITY)
 S ^ENG(6914,DA,9)=ENY
 Q
 ;
BOCI(ENBOC) ; Returns ien of active BOC or null value
 N ENI,ENDT
 S ENI=$S(ENBOC]"":$O(^ENG(6914.4,"B",ENBOC,0)),1:"")
 ; check if deactivated
 I ENI S ENDT=$P($G(^ENG(6914.4,ENI,0)),U,5) I ENDT]"",ENDT'>DT S ENI=""
 Q ENI
 ;
FUNDI(ENFUND) ; Returns ien of active FUND or null value
 N ENI,ENDT
 S ENI=$S(ENFUND]"":$O(^ENG(6914.6,"B",ENFUND,0)),1:"")
 ; check if deactivated
 I ENI S ENDT=$P($G(^ENG(6914.6,ENI,0)),U,5) I ENDT]"",ENDT'>DT S ENI=""
 Q ENI
 ;
TYPE N A,ENX I '$D(^ENG(6915.2,"B",DA)) Q
 I $D(^ENG(6915.5,"B",DA)) S ENX=$$CHKFA^ENFAUTL(DA) Q:'$P(ENX,U)
 S A(1)="This item has been reported to the Fixed Assets Package. TYPE"
 S A(2)="cannot be changed until an FD document is processed."
 D EN^DDIOL(.A)
 K X
 Q
 ;
CAP N A,ENX I '$D(^ENG(6915.2,"B",DA)) Q
 I $D(^ENG(6915.5,"B",DA)) S ENX=$$CHKFA^ENFAUTL(DA) Q:'$P(ENX,U)
 S A(1)="This item has been reported to the Fixed Assets Package. It cannot"
 S A(2)="be expensed until an FD document is processed."
 D EN^DDIOL(.A)
 K X
 Q
 ;
NX N A,ENX I '$D(^ENG(6915.2,"B",DA)) Q
 I $D(^ENG(6915.5,"B",DA)) S ENX=$$CHKFA^ENFAUTL(DA) I '$P(ENX,U) Q
 S A(1)="Since this item has been reported to FAP, this field may be edited"
 S A(2)="only by means of an FAP document."
 D EN^DDIOL(.A)
 K X
 Q
 ;
DTCHK(ENFLD) ;Input Transform Check that TURN-IN DATE, REPLACEMENT DATE, and
 ; DISPOSITION DATE follow ACQUISITION DATE.
 ;     DA => Equipment Entry Number
 ;     ENFLD => Field being checked (16, 20.5, or 22)
 ;     X => value entered (internal format) - killed if check fails
 I X'>$P($G(^ENG(6914,DA,2)),U,4) D  K X ; failed check
 . N ENLBL
 . S ENLBL=$$GET1^DID(6914,ENFLD,"","LABEL")
 . D EN^DDIOL(ENLBL_" must follow ACQUISITION DATE")
 Q
 ;
DISPM ;  Expand DISPOSITION METHOD on DJ screens ENEQ2*
 ;    Expects value (1U) in loc var V(V)
 ;    Returns expanded value in V(V)
 ;    Called by PRE-ACTION field of DJ Screen File
 ;
 Q:$G(V(V))'?1U  N X
 S X=$O(^ENG(6914.8,"B",V(V),0)) I X>0,$D(^ENG(6914.8,X,0)) S V(V)=V(V)_"  "_$E($P(^(0),U,2),1,25)
 Q
 ;
DISPW ;  Prohibit direct edit of DISPOSITION METHOD for capitalized assets
 ;
 W !,"Capitalized asset. DISP METHOD may be edited only by means of FAP documents."
 W !,"Press <RETURN> to continue..." R X:DTIME
 Q
 ;
AFUNDI(ENFUND) ; Returns ien of active FUND or null value
 ; input - associated fund
 N ENI,ENJ,ENDT
 S ENI=""
 ; loop thru associated fund x-ref looking for active entry that matches
 S ENJ=0
 I ENFUND]"" F  S ENJ=$O(^ENG(6914.6,"E",ENFUND,ENJ)) Q:'ENJ!(ENI]"")  D
 . ; check if deactivated
 . S ENDT=$P($G(^ENG(6914.6,ENJ,0)),U,5) I ENDT]"",ENDT'>DT Q
 . S ENI=ENJ ; found active fund entry for associated fund value
 Q ENI
 ;
 ;ENLIB3
