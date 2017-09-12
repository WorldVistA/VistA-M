LR382A ;HOIFO/JCH/LBC - Lab ADT Patch 382 Post Install routine ;April 06, 2011
 ;;5.2;LAB SERVICE;**382**;Sep 27, 1994;Build 188
 ;
 ; Reference to ^ORD(101,"B","VAFC ADT"* is supported by DBIA 4418
 ; Reference to ^HL(771 is supported by DBIA 10136
 ; Reference to ^HLCS(870 is supported by DBIA 1496
 ; Reference to ^DICN is supported by DBIA 10009
 ; Reference to ^DIE is supported by DBIA 10018
 ; Reference to ^DIK is supported by DBIA 10013
 ; Reference to ^DIR is supported by DBIA 10026
 ; 
EN ; Check answers to post install questions
 ;LBC- no post install questions
 ; INPUT             
 ;    XPDQUES("POST INSTALL2") (conditional - required if XPDQUES("POST INSTALL1")="I"   
 ;        values:  valid TCP/IP address. Format:  nn.nn.nn.nn
 ;    
 ;    XPDQUES("POST INSTALL3") (conditional - required if XPDQUES("POST INSTALL1")="I"
 ;        values:  valid TCP/IP port. Format: 1-9 numeric.
 ;        
 ; User selected to install (or reinstall) patch
 ;lbc;I $G(XPDQUES("POST INSTALL2"))!$G(XPDQUES("POST INSTALL3")) D ENI
 ;lbc;Q
 ;
ENI ; Patch 382 Post Install (Install)
 N DR,DA,DIC,DIE,DD,DO,STOP,TCPAD,TCPORT
 S STOP=0
 ;
 S PROTNM="VBECS ADT" F  S PROTNM=$O(^ORD(101,"B",PROTNM)) Q:($E(PROTNM,1,9))'="VBECS ADT"!$G(STOP)  D
 .Q:'(PROTNM["CLIENT")
 .S EVENT=$P($P(PROTNM,"-",2)," "),TOPROTNM="VAFC ADT-"_EVENT_" SERVER"
 .I $E(EVENT,2,3)>13 S STOP=1 Q
 .I EVENT["A08" D  Q
 ..N A8SUF F A8SUF=" SERVER","-SDAM SERVER","-TSP SERVER","-SCHED SERVER" S TOPROTNM="VAFC ADT-"_EVENT_A8SUF D ADD(PROTNM,TOPROTNM)
 .D ADD(PROTNM,TOPROTNM)
 ;
 ; Unlink VBECS ADT-A08 ROUTER protocol from VAFC ADT-A08 SERVER protocol
 S TOPROTNM="VAFC ADT-A08 SERVER"
 S TOPROT=$O(^ORD(101,"B",TOPROTNM,"")) Q:'TOPROT
 S NEXT=0 F  S NEXT=$O(^ORD(101,TOPROT,775,NEXT)) Q:'NEXT  D
 .S PROT=$G(^ORD(101,TOPROT,775,NEXT,0)),PROTNM=$P($G(^ORD(101,PROT,0)),U)
 .Q:'(PROTNM["VBECS ADT-A08 ROUTER")
 .S DIK="^ORD(101,"_TOPROT_",775,",DA(1)=TOPROT,DA=NEXT D ^DIK K DIK,DA
 ;
 Q
 ;
ADD(PROTNM,TOPROTNM) ; Add each PROTNM protocol as subscriber to TOPROTNM server protocol.
 ;
 N PROT,TOPROT,DUP
 S DUP=0
 S TOPROT=$O(^ORD(101,"B",TOPROTNM,"")),PROT=$O(^ORD(101,"B",PROTNM,""))
 N ND775,NXTSUB I $G(U)="" N U S U="^"
 S ND775=$G(^ORD(101,TOPROT,775,0)),NXTSUB=$P(ND775,U,3)+1
 S OTHSUBS=0 F  S OTHSUBS=$O(^ORD(101,TOPROT,775,OTHSUBS)) Q:'OTHSUBS!$G(DUP)  I ($G(^(OTHSUBS,0))=PROT) S DUP=1
 ; Don't add same protocol twice
 Q:$G(DUP)
 S DIC="^ORD(101,"_TOPROT_",775,",DIC("P")="101.0775PA",DINUM=NXTSUB,DA(1)=TOPROT,DIC(0)="L"
 S DIC("DR")=".01////"_PROT,X=DINUM
 D FILE^DICN K DR,DA,DIC
 Q
 ;
ADDITEM(PROTNM,TOPROTNM) ; Add the PROTNM protocol as an ITEM to the TOPROTNM protocol 
 N PROT,TOPROT,DUP
 S DUP=0
 S TOPROT=$O(^ORD(101,"B",TOPROTNM,"")),PROT=$O(^ORD(101,"B",PROTNM,""))
 N ND10,NXTITEM I $G(U)="" N U S U="^"
 S ND10=$G(^ORD(101,TOPROT,10,0)),NXTITEM=$P(ND10,U,3)+1
 S OTHITEMS=0 F  S OTHITEMS=$O(^ORD(101,TOPROT,10,OTHITEMS)) Q:'OTHITEMS!$G(DUP)  I ($G(^(OTHITEMS,0))=PROT) S DUP=1
 ; Don't add same item twice
 Q:$G(DUP)
 S DIC="^ORD(101,"_TOPROT_",10,",DIC("P")="101.01PA",DINUM=NXTITEM,DA(1)=TOPROT,DIC(0)="L"
 S DIC("DR")=".01////"_PROT,X=DINUM
 D FILE^DICN K DR,DA,DIC
 Q
 ;
GETADD ; Prompt for TCP/IP Address
 ; Get TCP/IP Address for Logical Link, Port for Logical Link
 N TCPADD,TCPORT,LINK,DIE,DIR
 S DIR("A")="Enter TCP/IP Address of LRADT Logical Link"
 S DIR(0)="F^7:16^K:X'?1.3N1"".""1.3N1"".""1.3N1"".""1.3N"
 D ^DIR
 I +$G(Y)>0 S TCPADD=Y
 S DIR("A")="Enter TCP/IP Port of LRADT Logical Link"
 S DIR(0)="N^1:99999999"
 D ^DIR
 I +$G(Y)>0 S TCPORT=Y
 Q
 ;
SETCP(ADD,PORT) ; Set TCP address and port into logical link
 Q:'ADD!'PORT
 S LINK=+$O(^HLCS(870,"B","LRADT","")) Q:'LINK
 S DIE="^HLCS(870,",DA=LINK,DR="400.01////"_ADD_";400.02////"_PORT
 D ^DIE
 Q
 ;
SETFAC ; Set Facility into HL7 Application Parameter
 N FAC,APP
 S FAC=0 S FAC=$O(^LRO(67.9,FAC)) Q:'FAC
 S APP="" F APP="LRADT","LRADT TRIGGER" D
 .S APPNUM=$O(^HL(771,"B",APP,""))
 .N DIE,DA,DR
 .S DIE="^HL(771,",DA=APPNUM,DR="3////"_FAC
 .D ^DIE K DIE,DA,DR
 Q
