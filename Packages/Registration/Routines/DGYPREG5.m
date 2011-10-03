DGYPREG5 ;ALB/REW - ZIP+4 POST-INIT CONVERSION ;4-JUN-93
 ;;5.3;Registration;;Aug 13, 1993
 ;
QUEZIP4 ;
 S ZTRTN="ZIP4PT^DGYPREG5",ZTDESC="PIMS 5.3 ZIP+4 CONVERSION",ZTIO=""
 D ^%ZTLOAD
 Q
ZIP4PT ;
 N DFN
 S DFN=0
 W:'$D(ZTQUEUED) !,">>> Populating ZIP+4 fields...",!
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  W:'(DFN#100)&('$D(ZTQUEUED)) "." D MAKEZIP4(DFN) D DISPZIP(DFN)
 W:'$D(ZTQUEUED) !!,"...ZIP+4 CONVERSION DONE "
 D SETUP^DGYPREG1(3)
 G:'$D(ZTQUEUED) QTZ4PT
 S DGXM=1 ;message line number
 D MESS^DGYPREG1("The Population of the following ZIP+4 fields is complete (Field #'s):")
 D MESS^DGYPREG1(".2201,.2202,.2203,.2204,.2205,.2206,.2207,.12112,.290012,.29013,.1112",1)
 D MESS^DGYPREG1("PIMS will use the above fields instead of the following ZIP CODE list:")
 D MESS^DGYPREG1(".338,.348,.2198,.3318,.3118,.257,.218,.1216,.2928,.2918,.116",1)
 D MESS^DGYPREG1(" - Also sub-field #38 of the DISPOSITION multiple is populated (A-ZIP+4)")
 D MESS^DGYPREG1("   it will be used instead of subfield #36 (A-ZIP CODE)",1)
 D END^DGYPREG1
QTZ4PT Q
DISPZIP(DFN) ;Populates the attorney's zip+4 in disposition multiple
 N DFN1
 S DFN1=0
 F  S DFN1=$O(^DPT(DFN,"DIS",DFN1)) Q:'DFN1  D
 .S:$P($G(^DPT(DFN,"DIS",DFN1,3)),U,7)&($P($G(^DPT(DFN,"DIS",DFN1,3)),U,7)']"") $P(^(3),U,9)=$P(^(3),U,7)
 Q
MAKEZIP4(DFN) ;Populates zip+4 fields with zip code fields
 ;ZIP->ZIP+4
 D FROMTO(DFN,.33,8,.22,1)
 D FROMTO(DFN,.34,8,.22,2)
 D FROMTO(DFN,.211,8,.22,3)
 D FROMTO(DFN,.331,8,.22,4)
 D FROMTO(DFN,.311,8,.22,5)
 D FROMTO(DFN,.25,7,.22,6)
 D FROMTO(DFN,.21,8,.22,7)
 D FROMTO(DFN,.121,6,.121,12)
 D FROMTO(DFN,.291,10,.291,12)
 D FROMTO(DFN,.29,10,.29,13)
 D FROMTO(DFN,.11,6,.11,12)
 Q
FROMTO(DFN,FROMNODE,FROMPC,TONODE,TOPC) ;POPULATES ZIP+4 WITH ZIP DATA
 ;VARIABLES:
 ;   DFN   - IEN of Patient File
 ;FROMNODE - zip code node
 ;TONODE   - zip+4 node
 ;FROMPC   - zip code piece
 ;TOPC     -zip+4 piece
 ;
 I '$G(DFN)!('$G(FROMNODE))!('$G(FROMPC))!('$G(TONODE))!('$G(TOPC)) D  Q
 .W:'$D(ZTQUEUED) !,"MISSING INPUT VARIABLE"
 I $P($G(^DPT(DFN,FROMNODE)),U,FROMPC) D
 .S:'$P($G(^DPT(DFN,TONODE)),U,TOPC) $P(^DPT(DFN,TONODE),U,TOPC)=$P(^DPT(DFN,FROMNODE),U,FROMPC)
 Q
