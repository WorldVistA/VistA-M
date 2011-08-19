IVMLINS2 ;ALB/KCL - IVM INSURANCE POLICY PURGE ; 3/23/01 4:36pm
 ;;2.0;INCOME VERIFICATION MATCH;**14,34,111**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
ASK ; - ask user to 'T'ransfer or 'P'urge IVM insurance policy
 S DIR(0)="S^1:Transfer IVM Insurance Policy to insurance module;2:Purge IVM Insurance Policy;3:Return to Display Screen"
 S DIR("A")="Select Action",DIR("?")="^D HLP1^IVMLINS2"
 D ^DIR K DIR S IVMACT=Y G:$D(DIRUT)!($D(DUOUT))!(IVMACT=3) IVMQ^IVMLINS3
 I IVMACT[1 D TRANSFER^IVMLINS3(0) Q
 ;
 ;
PURGE ; - purge IVM insurance information - ask for reason why
 ;
 W !!,"The 'Purge IVM Insurance Policy' action has been selected."
 ;
 W !!,"This action will cause the insurance information which has been"
 W !,"received from HEC to be deleted from the system!",!,*7
 ;
 W !,"Please select a reason for purging the IVM insurance information."
 S DIC="^IVM(301.91,",DIC("A")="Select reason for purging: ",DIC(0)="QEAMZ"
 D ^DIC K DIC G:Y<0!($D(DTOUT))!($D(DUOUT)) ASK
 S IVMREPTR=+Y
 ;
 ; - ask user 'are you sure you want to purge'
 W ! S DIR(0)="Y",DIR("A")="Are you sure that you want to purge IVM insurance policy"
 ;
 ; - set default = 'NO'
 S DIR("B")="NO"
 ;
 ; - user help
 S DIR("?")="Answer 'Y'ES to go ahead with this action or 'N'O to abort"
 D ^DIR K DIR G:'Y ASK
 ;
 ; - update the INSURANCE SEGMENT multiple stored in (#301.5) file 
 W !!,"Purging the 'Insurance Policy' received from IVM... "
 N DA,DR,DIE,IVMINSST
 ;
 ; stuff UPLOAD INSURANCE DATA(.04) and REASON NOT UPLOADING INSURANCE
 ; (.08)
 S DA=IVMJ,DA(1)=IVMI
 S DIE="^IVM(301.5,"_DA(1)_",""IN"","
 S DR=".04////0;.08////^S X=IVMREPTR" D ^DIE
 ;
 S IVMINSST=0
 D HL7 ;send HL7 message to HEC
 ;
DELETE ; - delete segment name (.02 field of 301.501 multiple) from IVM PATIENT
 ;   file to remove from ASEG cross-reference
 ;
 S DA=IVMJ,DA(1)=IVMI
 S DIE="^IVM(301.5,"_DA(1)_",""IN"",",DR=".02////@" D ^DIE
 ;
 ; - delete incoming segments strings
 K ^IVM(301.5,DA(1),"IN",DA,"ST"),^("ST1")
 W "completed.",!
 ;
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 ;
 ; - delete entry from the List Manager display once purged
 K ^TMP("IVMIUPL",$J,IVMNAME,IVMI,IVMJ)
 ;
 ; - action completed
 S IVMDONE=1
 D IVMQ^IVMLINS3
 Q
 ;
HL7 ; - send HL7 message to HEC
 ;
 N IVMIN1,IVMIN2,IVMZIV
 N HLEID,HL,HLRESLT
 ;
 ; MESSAGE PROTOCOL
 S HLEID="VAMC "_$P($$SITE^VASITE,"^",3)_" ORU-Z04 SERVER V"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 ;
 ; - initialize variables for HL7/IVM
 D INIT^IVMUFNC(HLEID,.HL) S HLMTN="ORU"
 ;
 ;
 ; - create PID,IN1,ZIV segments
 ;
 ; - PID segment
 K IVMPID,VAFPID
 S IVMPID=$$EN^VAFHLPID(DFN,"1,3,5,7,19")
 I $P(IVMPID,HLFS,20)["P" D PSEUDO^IVMPTRN1
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=IVMPID
 K IVMPID,VAFPID
 ;
 ; - IN1 segment
 S IVMIN1="IN1^1"
 S IVMIN2=$G(^IVM(301.5,IVMI,"IN",IVMJ,"ST"))_$G(^("ST1"))
 S $P(IVMIN1,"^",5)=$P(IVMIN2,"^",4)
 S $P(IVMIN1,"^",37)=$P(IVMIN2,"^",36)
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=IVMIN1
 ;
 ; - ZIV segment
 S IVMZIV="ZIV^1"
 ; - get ivm ien, strip off date of death
 S $P(IVMZIV,"^",10)=$P($P($G(^IVM(301.5,IVMI,"IN",IVMJ,0)),"^",7),"/")
 S $P(IVMZIV,"^",11)=IVMINSST
 S:IVMINSST=0 $P(IVMZIV,"^",12)=IVMREPTR
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=IVMZIV
 ;
 D GENERATE^HLMA(HLEID,"GM",1,.HLRESLT)  ; - create mail message
 K ^TMP("HLS",$J)
 D CLEAN^IVMUFNC
 Q
 ;
DOD ; - Alert user if date of death reported in DHCP or from HEC
 ;
 W !!,*7,"'Date of Death' reported for this patient "
 W $S($P($G(^DPT(+DFN,.35)),"^")]"":"in DHCP as "_$$DAT2^IVMUFNC4($P($G(^DPT(+DFN,.35)),"^")),$P(IVMDND,"^",6)]"":"by HEC as "_$$DAT2^IVMUFNC4($P(IVMDND,"^",6)))_".",!
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 Q
 ;
 ;
HLP1 ; - help for ASK  Transfer or Purge
 ;
 ; - if user enters single '?'
 I X="?" D
 .W !!,"Enter one of the following responses:"
 .W !,"    1   -  to transfer the Insurance Policy that was received from HEC to the insurance module"
 .W !,"    2   -  to delete the Insurance Policy that was received from HEC"
 .W !,"    3   -  to return to the previous display screen"
 .W !,"   '^'  -  to return to the previous display screen"
 ;
 ; - if user enters double '??'
 I X="??" D
 .W !!,"Entering '1' at this prompt will allow the user to transfer the Insurance Policy"
 .W !,"that was received from HEC to the insurance module.  Entering '2' at this prompt"
 .W !,"will allow the user to delete the Insurance Policy that was received from HEC."
 .W !,"Entering '3' or '^' will abort this action."
 Q
