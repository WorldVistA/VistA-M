IBCNRDV ;OAKFO/ELZ - INSURANCE INFORMATION EXCHANGE VIA RDV ;27-MAR-03
 ;;2.0;INTEGRATED BILLING;**214,231,361,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine is used to exchange insurance information between
 ; facilities.
OPT ; Menu option entry point.  This is used to select a patient to request
 ; information about from the remote treating facilities.
 N DFN,DIC,X,Y,DTOUT,DUOUT,IBT,%,%Y,IBX,VADM,IBB,IBD,IBH,IBI,IBICN,IBR,IBRZ,IBX,IBY,IBZ,IBWAIT,IBL,DO,IBTYPE,IB1
 ;
 ; prompt for patient
AGAIN S DIC="^DPT(",DIC(0)="AEMNQ" D ^DIC Q:Y<1  S DFN=+Y
 ;
BACKGND ; background/tasked entry point
 ; IBTYPE is being used as a flag to indicate this is running in background
 ;
 ; look up treating facilities
 K IBT S IBT=$$TFL^IBARXMU(DFN,.IBT)
 I IBT<1,'$D(IBTYPE) W !!,"This patient has no remote treating facilities to query." G AGAIN
 I IBT<1 Q
 ;
 ; display and verify we want to do this
 I '$D(IBTYPE) D DEM^VADPT W !!,"The patient ",VADM(1)," has the following ",IBT," remote facilitie(s)",! S IBX=0 F  S IBX=$O(IBT(IBX)) Q:IBX<1  W !?10,$P(IBT(IBX),"^",2)
 I '$D(IBTYPE) W !!,"Do you want to perform this Remote Query" S %=1 D YN^DICN G:%'=1 AGAIN
 ;
 ; get ICN
 S IBICN=$$ICN^IBARXMU(DFN) I 'IBICN,'$D(IBTYPE) W !!,"No ICN for this patient" G AGAIN
 I 'IBICN Q
 ;
 ; sent off the remote queries and get back handles
 S IBX=0 F  S IBX=$O(IBT(IBX)) Q:IBX<1  D
 . D SEND(.IBH,IBX,IBICN,$S($D(IBTYPE):"IBCN INSURANCE QUERY TASK",1:"IBCN INSURANCE QUERY"))
 . X $S(IBH(0)'="":"S $P(IBT(IBX),U,5)=IBH(0)",1:"W:'$D(IBTYPE) !,""No handle returned for "",$P(IBT(IBX),U,2) K IBT(IBX)")
 ;
 ; no handles returned
 I $D(IBT)<9,'$D(IBTYPE) W !!,"Unable to perform any remote queries.",! G AGAIN
 I $D(IBT)<9 Q
 ;
 ; go through every IBT()
 S IBP="|",IBX=0 F  S IBX=$O(IBT(IBX)) Q:IBX<1!($D(IBT)<9)  D
 . ;
 . ; do I have a return data.
 . F IBWAIT=1:1:60 W:'$D(IBTYPE) "." H 1 D CHECK(.IBR,$P(IBT(IBX),"^",5)) I $G(IBR(0))["Done" Q
 . I $G(IBR(0))'["Done" W:'$D(IBTYPE) !!,"Unable to communicate with ",$P(IBT(IBX),U,2) Q
 . K IBR
 . D RETURN(.IBR,$P(IBT(IBX),"^",5))
 . ;
 . ; no data returned or error message
 . S IBRZ=$S(-1=+$G(IBR):IBR,$G(IBR(0))="":$G(IBR(1)),1:$G(IBR(0)))
 . ;
 . ; no info to proceed
 . I IBRZ<1 W:'$D(IBTYPE) !,"Response from ",$P(IBT(IBX),U,2),!,$P(IBRZ,"^",2) K IBT(IBX) D:IBRZ="-1^No insurance on file" FILE(0) Q
 . ;
 . ; received insurance info, need to file and display message
 . W:'$D(IBTYPE) !,"Received ",$G(IBR(0))," insurance companies from ",$P(IBT(IBX),U,2) D FILE(+IBR(0))
 . ;
 . S IBY=0 F  S IBY=$O(IBR(IBY))  Q:IBY<1  D
 .. F IBL=5:1  S IBT=$P($T(MAP+IBL),";",3) Q:IBT=""  D
 ... ;
 ... ; am I on the right MAP line
 ... I $P(IBT,IBP,3)=$S(IBY#6:IBY#6,1:6) S IBZ=$P(IBR(IBY),"^",$P(IBT,IBP,4)) I $L(IBZ) D
 .... ;
 .... ; xecute code to change external to internal
 .... X:$L($P(IBT,IBP,7)) $P(IBT,IBP,7)
 .... ;
 .... ; put the info in the array for the buffer file
 .... S:$D(IBZ) IBB($P(IBT,IBP,5))=IBZ
 .. ;
 .. ; need to avoid duplicates if possible.
 .. I $G(IBB(20.01))["MEDICARE (WNR)" S X=0 F  S X=$O(^DPT(DFN,.312,X)) Q:X<1  I $P($G(^DIC(36,+$P($G(^DPT(DFN,.312,X,0)),"^"),0)),"^")["MEDICARE (WNR)" K IBB Q
 .. Q:'$D(IBB)
 .. ;
 .. ; file in the buffer file & where else needed
 .. I IBY#6=0 D
 ... I $L($G(IBB(20.01))) D
 .... S IBB(.14)=$$IEN^XUAF4(+IBT(IBX))
 .... S IBB=$$ADDSTF^IBCNBES($G(IBB(.03),1),DFN,.IBB)
 ... I '$D(IB1),$D(IBTYPE),$L($G(IBB(20.01))) D SCH^IBTUTL2(DFN,$G(IBSAVEI),$G(IBSAVEJ)):IBTYPE="TRKR",ADM^IBTUTL($G(IBSAVE1),$G(IBSAVE2),$G(IBSAVE3),$G(IBSAVE4)):IBTYPE="ADM" S IB1=1
 ... W:'$D(IBTYPE)&($L($G(IBB(20.01)))) !,$P($G(IBB),"^")," Buffer File entry for ",$G(IBB(20.01))
 ... K IBB
 ;
 ; flag so I don't do this patient again within 90 days
 S ^IBT(356,"ARDV",DFN,$$FMADD^XLFDT(DT,90))=""
 ;
 Q
 ;
RPC(IBD,IBICN) ; RPC entry for looking up insurance info
 N DFN,IBZ,IBX,IBY,IBP,IBI,IBT,IBZ
 S DFN=$$DFN^IBARXMU(IBICN) I 'DFN S IBD(0)="-1^ICN Not found" Q
 D ALL^IBCNS1(DFN,"IBY",3)
 I '$D(IBY) S IBD(0)="-1^No insurance on file" Q
 ; set up return format
 ; IBD(0)   = # of insurance companies
 S IBD(0)=$G(IBY(0))
 ;
 ; where n starts at 1 and increments to 7 for each insurance company
 ; IBD(n) = 355.33, zero node format
 ; IBD(n+1) = 355.33, 20 node format
 ; IBD(n+2) = 355.33, 21 node format
 ; IBD(n+3) = 355.33, 40 node format
 ; IBD(n+4) = 355.33, 60 node format
 ; IBD(n+5) = 355.33, 61 node format
 ; IBD(n+6) = 355.33, 62 node format
 ;
 S IBP="|"
 S IBI=0 F  S IBI=$O(IBY(IBI))  Q:IBI<1  F IBL=5:1 S IBT=$P($T(MAP+IBL),";",3) Q:IBT=""  D
 . S IBZ=$P($G(IBY(IBI,+IBT)),"^",$P(IBT,IBP,2)) ; set the existing data
 . I $L($P(IBT,IBP,6)) X $P(IBT,IBP,6) ; output transform
 . S $P(IBD(IBI-1*7+$P(IBT,IBP,3)),"^",$P(IBT,IBP,4))=IBZ ; set data IBD
 Q
 ;
MAP ; this is a mapping of data returned from ALL^IBCNS1 to the buffer file
 ; format is:  node number | piece | extract node | extract piece
 ;             | 355.33 field number | format out code (if any)
 ;             | format in code (if any)
 ; the extract nodes will be sequential to match buffer file DD
 ;;0|1|2|1|20.01|N Z X "F Z=0,.11,.13 S IBY(IBI,36+Z)=$G(^DIC(36,IBZ,Z))" S IBZ=$P(IBY(IBI,36),"^");ins co name
 ;;0|2|5|4|60.04;subscriber id
 ;;0|4|5|3|60.03;experation date
 ;;0|6|5|5|60.05;who's insurance
 ;;0|8|5|2|60.02;effective date
 ;;0|16|5|6|60.06;pt relationship to insured
 ;;0|17|5|7|60.07;name of insured
 ;;0|20|5|12|60.12;coordination of benefits
 ;;1|3|1|10|.1||I IBZ<$$FMADD^XLFDT(DT,-180) K IBZ;date (last) verified
 ;;1|9|1|3|.03;source of information
 ;;2|1|6|5|61.05;send bill to employer
 ;;2|2|6|6|61.06;employer claims street address (line 1)
 ;;2|3|6|7|61.07;employer claims street address line 2
 ;;2|4|6|8|61.08;employer claims street address line 3
 ;;2|5|6|9|61.09;employer claims city
 ;;2|6|6|10|61.1|S IBZ=$$EXTERNAL^DILFD(2.312,2.06,"",IBZ)|N DIC,X,Y S DIC="^DIC(5,",X=IBZ,DIC(0)="OX" D ^DIC K:+Y<1 IBZ S:+Y>0 IBZ=+Y;employer claims state
 ;;2|7|6|11|61.11;employer claims zip code
 ;;2|8|6|12|61.12;employer claims phone
 ;;2|10|6|1|61.01;esghp
 ;;2|11|6|3|61.03;employment status
 ;;2|12|6|4|61.04;retirement date
 ;;3|1|5|8|60.08;insured's dob
 ;;3|5|5|9|60.09;insured's ssn
 ;;3|12|5|13|60.13;insured's sex
 ;;4|1|5|10|60.1;primary care provider
 ;;4|2|5|11|60.11;primary provider phone
 ;;5|1|7|1|62.01;patient id
 ;;355.3|2|4|1|40.01;is this a group policy
 ;;355.3|3|4|2|40.02;group name
 ;;355.3|4|4|3|40.03;group number
 ;;355.3|5|4|4|40.04;(is) utilization required
 ;;355.3|6|4|5|40.05;(is) pre-certification required
 ;;355.3|7|4|7|40.07;exclude pre-existing condition
 ;;355.3|8|4|8|40.08;benefits assignable
 ;;355.3|9|4|9|40.09;type of plan
 ;;355.3|12|4|6|40.06;ambulatory care certification
 ;;36|2|2|5|20.05;reimburse
 ;;36.11|1|3|1|21.01;street address line 1
 ;;36.11|2|3|2|21.02;street address line 2
 ;;36.11|3|3|3|21.03;street address line 3
 ;;36.11|4|3|4|21.04;city
 ;;36.11|5|3|5|21.05|S IBZ=$$EXTERNAL^DILFD(36,.115,"",IBZ)|N DIC,X,Y S DIC="^DIC(5,",X=IBZ,DIC(0)="OX" D ^DIC K:+Y<1 IBZ S:+Y>0 IBZ=+Y;state
 ;;36.11|6|3|6|21.06;zip code
 ;;36.13|1|2|2|20.02;phone number
 ;;36.13|2|2|3|20.03;billing phone number
 ;;36.13|3|2|4|20.04;precertification phone number
 ;;
 ;
SEND(IBH,IBX,IBICN,IBRPC) ; called to send off queries
 D EN1^XWB2HL7(.IBH,IBX,IBRPC,"",IBICN)
 Q
 ;
CHECK(IBR,IBH) ; called to check the return status of an RPC
 D RPCCHK^XWB2HL7(.IBR,IBH)
 Q
 ;
RETURN(IBR,IBH) ; called to get the return data and clear the broker
 N IBZ
 D RTNDATA^XWBDRPC(.IBR,IBH),CLEAR^XWBDRPC(.IBZ,IBH)
 Q
 ;
TASK ; queue off task job
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,ZTSAVE
 S ZTRTN="BACKGND^IBCNRDV",ZTDESC="Query Remote Facilities for Insurance",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT),(ZTIO,ZTSAVE("DFN"),ZTSAVE("IBSAVE*"),ZTSAVE("IBTYPE"))="" D ^%ZTLOAD
 Q
 ;
TRKR(DFN,IBSAVEI,IBSAVEJ,IBDUZ) ; claims tracking entry
 N IBTYPE,IBT
 Q:$D(^IBT(356,"ARDV",DFN))  ; have already done recently
 Q:'$$TFL^IBARXMU(DFN,.IBT)  ; no remote facilities
 S IBTYPE="TRKR" D
 . I DUZ=.5 N DUZ S DUZ=+$G(IBDUZ),DUZ(2)=+$$SITE^VASITE
 . D TASK
 Q
 ;
ADM(DFN,IBSAVE1,IBSAVE2,IBSAVE3,IBSAVE4) ; admit event entry
 N IBTYPE S IBTYPE="ADM" D TASK
 Q
 ;
FILE(IBX) ; updates data into the log file
 ;IBX = number of insurance co's found
 N DIC,DA,DIE,IBM,DO,X,Y,IBZ,DR
 S IBM=$E($$DT^XLFDT,1,5)_"00",DA=+$O(^IBA(355.34,"B",IBM,0))
 I 'DA K DA L +^IBA(355.34,"B",IBM):10 S X=IBM,DIC="^IBA(355.34,",DIC(0)="F" D FILE^DICN S DA=+Y L -^IBA(355.34,"B",IBM)
 L +^IBA(355.34,DA):10
 S IBZ=^IBA(355.34,DA,0),DIE="^IBA(355.34,"
 S DR=".02///"_($P(IBZ,"^",2)+1)_";.03///"_($P(IBZ,"^",3)+IBX) D ^DIE
 L -^IBA(355.34,DA)
 Q
