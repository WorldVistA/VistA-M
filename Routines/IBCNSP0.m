IBCNSP0 ;ALB/AAS - INSURANCE MANAGEMENT - EXPANDED POLICY ;05-MAR-1993
 ;;2.0;INTEGRATED BILLING;**28,43,52,85,93,103,137,229,251,363,371,399**;21-MAR-94;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
CONTACT ; -- Insurance Contact Information
 N OFFSET,START
 ;
 ; The start of this section is designed to start on the same line
 ; as the User Information section (see VER^IBCNSP01).
 ;
 S START=$O(^TMP("IBCNSVP",$J,""),-1)-8
 S IB1ST("CONTACT")=START
 S OFFSET=42
 N IBTRC,IBTRCD,IBTCOD
 S IBTCOD=$O(^IBE(356.11,"ACODE",85,0))
 ;
 S IBTRC=0,IBTRCD=""
 F  S IBTRC=$O(^IBT(356.2,"D",DFN,IBTRC)) Q:'IBTRC  D
 .Q:$P($G(^IBT(356.2,+IBTRC,1)),"^",5)'=IBCDFN  ; must be same policy
 .Q:$P($G(^IBT(356.2,+IBTRC,0)),"^",4)'=IBTCOD  ; must be ins. ver. type
 .S IBTRCD=$G(^IBT(356.2,+IBTRC,0))
 ;
 D SET(START,OFFSET," Insurance Contact (last) ",IORVON,IORVOFF)
 D SET(START+1,OFFSET," Person Contacted: "_$$EXPAND^IBTRE(356.2,.06,$P(IBTRCD,"^",6)))
 D SET(START+2,OFFSET,"Method of Contact: "_$$EXPAND^IBTRE(356.2,.17,$P(IBTRCD,"^",17)))
 D SET(START+3,OFFSET,"  Contact's Phone: "_$$EXPAND^IBTRE(356.2,.07,$P(IBTRCD,"^",7)))
 D SET(START+4,OFFSET,"    Call Ref. No.: "_$$EXPAND^IBTRE(356.2,.09,$P(IBTRCD,"^",9)))
 D SET(START+5,OFFSET,"     Contact Date: "_$$EXPAND^IBTRE(356.2,.01,$P(IBTRCD,"^")))
 ; no blank lines here because the User Information section is on the
 ; left and it is bigger than this section
 Q
 ;
POLICY ; -- Policy Region
 ; -- if pointer to policy file exists get data from policy file
 N OFFSET,START,IBP,IBX,IBPLNID,IBPLNNM,IBPLNNA,IBPLNLA
 S (IBPLNID,IBPLNNM,IBPLNNA,IBPLNLA)=""
 S START=1,OFFSET=2
 D GPLAN(+IBCPOLD2)
 D SET(START,OFFSET," Plan Information ",IORVON,IORVOFF)
 D SET(START+1,OFFSET,"   Is Group Plan: "_$S($P(IBCPOLD,"^",2)=1:"YES",1:"NO"))
 D SET(START+2,OFFSET,"      Group Name: "_$P(IBCPOLD,"^",3))
 D SET(START+3,OFFSET,"    Group Number: "_$P(IBCPOLD,"^",4))
 D SET(START+4,OFFSET,"             BIN: "_$P(IBCPOLD2,"^",2)) ;;Daou/EEN
 D SET(START+5,OFFSET,"             PCN: "_$P(IBCPOLD2,"^",3)) ;;04/09/04
 D SET(START+6,OFFSET,"    Type of Plan: "_$E($P($G(^IBE(355.1,+$P(IBCPOLD,"^",9),0)),"^"),1,23))
 S IBX=7
 I $P(IBCPOLD,U,14)]"" D
 . D SET(START+IBX,OFFSET,"   Plan Category: "_$$EXPAND^IBTRE(355.3,.14,$P(IBCPOLD,"^",14))) S IBX=IBX+1
 I $P(IBCPOLD,U,15)]"" D
 . D SET(START+IBX,OFFSET," Electronic Type: "_$$EXPAND^IBTRE(355.3,.15,$P(IBCPOLD,"^",15))) S IBX=IBX+1
 D SET(START+IBX,OFFSET,"  Plan Filing TF: "_$P(IBCPOLD,"^",13)_$S($P(IBCPOLD,U,16):" ("_$$FTFN^IBCNSU31(IBCPOL)_")",1:"")) S IBX=IBX+1
 ;
 D SET(START+IBX,OFFSET,"      ePharmacy Plan ID: "_IBPLNID) S IBX=IBX+1
 D SET(START+IBX,OFFSET,"    ePharmacy Plan Name: "_IBPLNNM) S IBX=IBX+1
 D SET(START+IBX,OFFSET,"  ePharmacy Natl Status: "_IBPLNNA) S IBX=IBX+1
 D SET(START+IBX,OFFSET," ePharmacy Local Status: "_IBPLNLA) S IBX=IBX+1
 ;
 ; -- in case pointer is missing
 I '$G(^IBA(355.3,+$P(IBCDFND,"^",18),0)) D
 .D SET(START+1,OFFSET,"Insurance Number: "_$P(IBCDFND,"^",2))
 .D SET(START+2,OFFSET,"      Group Name: "_$P(IBCDFND,"^",15))
 .D SET(START+3,OFFSET,"    Group Number: "_$P(IBCDFND,"^",3))
 .Q
 Q
 ;
INS ; -- Insurance Co. Region
 N OFFSET,START,IBADD,IBCDFNDA,IBCDFNDB
 S START=1,OFFSET=45
 D SET(START,OFFSET," Insurance Company ",IORVON,IORVOFF)
 D SET(START+1,OFFSET,"   Company: "_$P($G(^DIC(36,+IBCDFND,0)),"^"))
 S IBCDFNDA=$G(^DIC(36,+IBCDFND,.11)),IBCDFNDB=$G(^(.13))
 G:IBCDFNDA="" INSQ
 D SET(START+2,OFFSET,"    Street: "_$P(IBCDFNDA,"^")) S IBADD=1
 I $P(IBCDFNDA,"^",2)'="" D SET(START+3,OFFSET,"  Street 2: "_$P(IBCDFNDA,"^",2)) S IBADD=2
 I $P(IBCDFNDA,"^",3)'="" D SET(START+4,OFFSET,"  Street 3: "_$P(IBCDFNDA,"^",3)) S IBADD=3
 D SET(START+2+IBADD,OFFSET,"City/State: "_$E($P(IBCDFNDA,"^",4),1,15)_$S($P(IBCDFNDA,"^",4)="":"",1:", ")_$P($G(^DIC(5,+$P(IBCDFNDA,"^",5),0)),"^",2)_" "_$E($P(IBCDFNDA,"^",6),1,5))
 D SET(START+3+IBADD,OFFSET,"Billing Ph: "_$P(IBCDFNDB,"^",2))
 D SET(START+4+IBADD,OFFSET,"Precert Ph: "_$$PHONE^IBCNSC01(IBCDFNDB))
 ;
INSQ Q
 ;
SPON ; -- Sponsor (Insured Person) Region
 N IBC3,IBZIP,START,OFFSET,IBA,DA,DR,DIC,DIQ
 S IBC3=$G(^DPT(DFN,.312,IBCDFN,3))
 S DA=+$P(IBC3,"^",2),DR=.01,DIQ(0)="E",DIC="^DIC(23,",DIQ="IBA" D EN^DIQ1
 S START=$O(^TMP("IBCNSVP",$J,""),-1)+1,OFFSET=4
 D SET(START,OFFSET," Insured Person's Information (use Subscriber Update Action) ",IORVON,IORVOFF)
 D SET(START+1,OFFSET,"    Insured's DOB: "_$$DAT3^IBOUTL($P(IBC3,"^")))
 D SET(START+2,OFFSET,"    Insured's Sex: "_$$EXTERNAL^DILFD(2.312,3.12,,$P(IBC3,U,12)))
 D SET(START+3,OFFSET," Insured's Branch: "_$G(IBA(23,DA,.01,"E")))
 D SET(START+4,OFFSET,"   Insured's Rank: "_$P(IBC3,"^",3))
 ;
 S OFFSET=43
 S Y=$P(IBC3,"^",10) D ZIPOUT^VAFADDR S IBZIP=Y
 D SET(START+1,OFFSET," Str 1: "_$P(IBC3,"^",6))
 D SET(START+2,OFFSET," Str 2: "_$P(IBC3,"^",7))
 D SET(START+3,OFFSET,"  City: "_$P(IBC3,"^",8))
 D SET(START+4,OFFSET,"St/Zip: "_$P($G(^DIC(5,+$P(IBC3,"^",9),0)),"^",2)_"  "_IBZIP)
 D SET(START+5,OFFSET," Phone: "_$P(IBC3,"^",11))
 ;
 ; blank lines at end of section
 D SET(START+6,2," ")
 D SET(START+7,2," ")
 Q
 ;
BLANK(LINE) ; -- Build blank line
 D SET^VALM10(.LINE,$J("",80))
 Q
 ;
SET(LINE,COL,TEXT,ON,OFF) ; -- set display info in array
 D:'$D(@VALMAR@(LINE,0)) BLANK(.LINE)
 D SET^VALM10(.LINE,$$SETSTR^VALM1(.TEXT,@VALMAR@(LINE,0),.COL,$L(TEXT)))
 D:$G(ON)]""!($G(OFF)]"") CNTRL^VALM10(.LINE,.COL,$L(TEXT),$G(ON),$G(OFF))
 W:'(LINE#5) "."
 Q
 ;
GPLAN(IBPLDA) ; get data from PLAN file (#366.03) related to the
 ; GROUP INSURANCE PLAN file (#355.3) and the INSURANCE COMPANY file (#36)
 ; that is associated with the PATIENT
 ; input - IBPLDA - ien of the PLAN file (#366.03)
 N IBPLN0,IBAIEN,IBAPIEN,IBAP0
 S IBPLN0=$G(^IBCNR(366.03,IBPLDA,0)) ;; Q:'$P(IBPLN0,"^",3) ;quit if payer not defined 
 S IBPLNID=$P(IBPLN0,"^"),IBPLNNM=$P(IBPLN0,"^",2)
 S IBAIEN=$O(^IBCNR(366.13,"B","E-PHARM","")) Q:'IBAIEN
 S IBAPIEN=$O(^IBCNR(366.03,IBPLDA,3,"B",IBAIEN,"")) Q:'IBAPIEN
 S IBAP0=$G(^IBCNR(366.03,IBPLDA,3,IBAPIEN,0))
 S IBPLNNA=$S($P(IBAP0,"^",2)=0:"NOT ACTIVE",1:"ACTIVE")
 S IBPLNLA=$S($P(IBAP0,"^",3)=0:"NOT ACTIVE",1:"ACTIVE")
 Q
 ;
 ;IBCNSP0
