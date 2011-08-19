IVMLINS1 ;ALB/KCL,TDM - IVM INSURANCE DISPLAY POLICY ; 12/23/08 3:44pm
 ;;2.0;INCOME VERIFICATION MATCH;**14,94,111,121**; 21-OCT-94;Build 45
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
DE ; - select patient for insurance information upload/purge
 ;
 ;  Input:   - ^TMP("IVMLST",$J,"IDX",CTR,CTR)=pat name_pat ssn_ivm ien_ivm sub ien
 ;
 ;
 ;
 S IVMDONE=0
 ;
 ; - generic seletor used within a list manager action call
 D EN^VALM2($G(XQORNOD(0)),"S")
 Q:'$D(VALMY)
 S IVMENT=0 F  S IVMENT=$O(VALMY(IVMENT)) Q:'IVMENT  D
 .;
 .; - get index for look-up
 .S IVMIDX=$G(^TMP("IVMLST",$J,"IDX",IVMENT,IVMENT)) I IVMIDX']"" Q
 .;
 .; - change if HL7 segment sep ever changes!
 .S HLFS="^",HLECH="~"
 .;
 .; - get patient name, ssn, da(1), da
 .S IVMNAME=$P(IVMIDX,"^",1),IVMSSN=$P(IVMIDX,"^",2),IVMI=$P(IVMIDX,"^",3),IVMJ=$P(IVMIDX,"^",4)
 .;
 .; - get data node from list manager storage array
 .S IVMDND=$G(^TMP("IVMIUPL",$J,IVMNAME,IVMI,IVMJ)),DFN=$P(IVMDND,"^",1)
 .;
 . S IVMIN1=$$GETIN1(IVMI,IVMJ)
 .;
 .; - alert user if date of death
 .I $P(IVMDND,"^",6)]""!($P($G(^DPT(+DFN,.35)),"^")]"") D DOD^IVMLINS2
 .;
 .; - display all insurance currently on file in DHCP
 .D CLEAR^VALM1,ALL
 .; - display insurance information received from IVM IN1 segment
 .D HDR,DISP1
 .S DIR(0)="E",DIR("A")="Press RETURN to continue or '^' to return to display screen" D ^DIR K DIR Q:'Y
 .;
 .; - ask user to add or purge
 .D ASK^IVMLINS2
 ;
DEQ ; - clean up variables
 D IVMQ
 Q
 ;
 ;
GETIN1(IVMI,IVMJ) ; get IN1 segment from (#301.5) file containing ins data
 S IVMIN1=$G(^IVM(301.5,IVMI,"IN",IVMJ,"ST"))
 ; - set if IN1 segment exceeds 245 chars
 S:$D(^IVM(301.5,IVMI,"IN",IVMJ,"ST1")) IVMIN1=IVMIN1_(^("ST1"))
 ;
 Q IVMIN1
 ;
ALL ; - display all insurance company information for patient in DHCP
 ;
 W !,?22,"INSURANCE POLICIES CURRENTLY ON FILE"
 ; - write dashed line
 W !,?7,$TR($J("",66)," ","*")
 ;
 ; - IB call to display all DHCP ins co. information
 D DISP^DGIBDSP
 W !
 Q
 ;
 ;
HDR ; - header for insurance data received from HEC
 W !,?23,"INSURANCE POLICY RECEIVED FROM HEC"
 ; - write dashed line
 W !,?7,$TR($J("",66)," ","*")
 Q
 ;
 ;
DISP1 ; - display insurance fields from IN1 segment
 ;
 ; - ins effec and exp dates in FM format
 S IVMEFF=$$FMDATE^HLFNC($P(IVMIN1,HLFS,12)),IVMEXP=$$FMDATE^HLFNC($P(IVMIN1,HLFS,13))
 ;
 S IVMADD=$P(IVMIN1,"^",5)
 S IVMPLAN=$P(IVMIN1,HLFS,15),IVMPLAN=$P($G(^IBE(355.1,+IVMPLAN,0)),"^")
 ;
 ; - display insurance policy fields from IVM
 W !,?2,"Company: ",?9,$E($P(IVMIN1,HLFS,4),1,32),?45,"Effective Date: ",?62,$$DAT2^IVMUFNC4(IVMEFF)
 W !,?2,"Phone #: ",?9,$E($P(IVMIN1,HLFS,7),1,25),?45,"Expiration Date: ",?62,$$DAT2^IVMUFNC4(IVMEXP)
 W !,?2,"Address: ",?45,"Subscriber ID: " W:$P(IVMIN1,HLFS,36)]"" ?59,$E($P(IVMIN1,HLFS,36),1,20) W !
 W:$P(IVMADD,HLECH,1)]"" ?4,$E($P(IVMADD,HLECH,1),1,35) W ?45,"Policy Holder: " W:$P(IVMIN1,HLFS,17)]"" ?59,$S($P(IVMIN1,HLFS,17)="v":"SELF",$P(IVMIN1,HLFS,17)="s":"SPOUSE",1:"OTHER")
 W:$P(IVMADD,HLECH,1)']"" !
 W:$P(IVMADD,HLECH,2)]"" !,?4,$E($P(IVMADD,HLECH,2),1,35)
 W:$P(IVMADD,HLECH,8)]"" !,?4,$E($P(IVMADD,HLECH,8),1,35) ; address line 3
 W:$P(IVMADD,HLECH,3)]""!($P(IVMADD,HLECH,4)]"")!($P(IVMADD,HLECH,5)]"") !,?4,$P(IVMADD,HLECH,3) W:$P(IVMADD,HLECH,3)]""&($P(IVMADD,HLECH,4)]"") ", ",$E($P(IVMADD,HLECH,4),1,2)
 W:$P(IVMADD,HLECH,5)]""&($P(IVMADD,HLECH,3)]""!($P(IVMADD,HLECH,4)]"")) " "
 W $P(IVMADD,HLECH,5)
 I $P(IVMADD,HLECH,2)']"" D
 .W !,?45,"Group Name: " W:$P(IVMIN1,HLFS,9)]"" ?59,$E($P(IVMIN1,HLFS,9),1,20)
 W:$P(IVMADD,HLECH,2)]"" ?45,"Group Name: " W:$P(IVMADD,HLECH,2)]""&($P(IVMIN1,HLFS,9)]"") ?59,$E($P(IVMIN1,HLFS,9),1,20)
 W !,?45,"Group Number: " W:$P(IVMIN1,HLFS,8)]"" ?59,$E($P(IVMIN1,HLFS,8),1,20)
 W !,?2,"Name of Insured: " W:$P(IVMIN1,HLFS,16)]"" ?9,$E($$FMNAME^HLFNC($P(IVMIN1,HLFS,16)),1,23) W:$P(IVMIN1,HLFS,16)']"" ?9,$E(IVMNAME,1,23)
 W ?45,"Pre-Cert. Req?: " W:$P(IVMIN1,HLFS,28)]"" ?60,$S($P(IVMIN1,HLFS,28)=1:"YES",$P(IVMIN1,HLFS,28)=0:"NO",1:"")
 I $P(IVMIN1,HLFS,16)]"" S $P(IVMIN1,HLFS,16)=$$FMNAME^HLFNC($P(IVMIN1,HLFS,16))
 W !,?45,"Plan Type: ",?55,$E(IVMPLAN,1,23) W !
 Q
 ;
 ;
DISP2 ; - display ins co. name and address
 W !,?4,"Insurance Company: ",$E($P(IVMIN1,HLFS,4),1,45),!
 W !,?4,"Company Address:   " W:$P(IVMADD,HLECH,1)]"" ?23,$E($P(IVMADD,HLECH,1),1,35) ; address line1
 W:$P(IVMADD,HLECH,2)]"" !?23,$E($P(IVMADD,HLECH,2),1,35) ; address line2
 W:$P(IVMADD,HLECH,8)]"" !,23,$E($P(IVMADD,HLECH,2),1,35) ; address line3
 W:$P(IVMADD,HLECH,3)]""!($P(IVMADD,HLECH,4)]"")!($P(IVMADD,HLECH,5)]"") !?23
 W $P(IVMADD,HLECH,3) W:$P(IVMADD,HLECH,3)]""&($P(IVMADD,HLECH,4)]"") ", " ; city
 W $E($P(IVMADD,HLECH,4),1,2) ; state
 W:$P(IVMADD,HLECH,5)]""&($P(IVMADD,HLECH,3)]""!($P(IVMADD,HLECH,4)]"")) " "
 W $P(IVMADD,HLECH,5) ; zip
 Q
 ;
 ;
IVMQ ; - kill variables used from all protocols
 ;
 ; - if action completed reset List Man array for display
 I $D(^TMP("IVMLST",$J)) D  ; Only if list manager array exists
 . I IVMDONE D INIT^IVMLINS
 . ;
 . S VALMBCK="R"
 K DA,DFN,IVM0NOD,IVMADD,IVMDND,IVMDONE,IVMEFF,IVMENT,IVMEXP
 K IVMI,IVMIDX,IVMIN1,IVMJ,IVMNAME,IVMPLAN,IVMSSN,Y
 Q
