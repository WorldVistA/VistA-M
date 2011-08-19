PRCFFU13 ;WISC/SJG-ROUTINE TO PROCESS OBLIGATIONS CONT ;6/13/94  14:34
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; Allows FIscal to edit Cost Center and BOCs prior to 1358 obligation
1358 ; 1358 Correction
 N CCEDIT,BOCEDIT D PROMPT
 Q:'Y!($D(DIRUT))
 S ESIGCHK=$$VERIFY^PRCSC1(OB) I 'ESIGCHK W !!,"This 1358 Miscellaneous Obligation has been tampered with.  Please notify IFCAP APPLICATION COORDINATOR." Q
 S (BOCEDIT,CCEDIT)=0
 S OLDCC=$P(TRNODE(3),U,3),OLDBOC=+$P(TRNODE(3),U,6)
 W !! K MSG S MSG="...now editing Cost Center and BOC information..." D EN^DDIOL(MSG) K MSG W !
 D OB^PRCS58OB(DA)
 S:+OLDCC'=+NEWCC CCEDIT=1 S:+OLDBOC'=+NEWBOC BOCEDIT=1
 I CCEDIT!(BOCEDIT) D   Q
 .S FISCEDIT=1,ESIGMSG="",ROUTINE=$T(+0)
 .D RECODE^PRCSC1(OB,.ESIGMSG)
 .I ESIGMSG<1 D
 ..S:'$D(ROUTINE) ROUTINE=$T(+0)
 ..W !!,$$ERROR(ROUTINE,ESIGMSG)
 ..W:ESIGMSG=0!(ESIGMSG=-3) !,"Notify IFCAP APPLICATION COORDINATOR!",$C(7)
 ..S DIR(0)="EAO",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 ..Q
 .N X S X=$P($G(TRNODE(4)),U,5) D VER^PRCH58OB(.PRC,.X) I X]"" D
 ..S PO=POIEN K ^PRC(442,POIEN,22) S NODE=$G(^PRC(442,POIEN,22,0)) I NODE="" D
 ...S ^PRC(442,POIEN,22,0)="^"_$P(^DD(442,41,0),U,2)
 ...N DA S DIE=442,DA=POIEN,DR="3///^S X=+NEWBOC" D ^DIE K DIE,DR
 ...D MSG1,NODE22^PRCFFU5
 .Q
 D MSG6
 Q
PROMPT ; Prompt for user
 S DIR(0)="Y",DIR("A")="Should the Cost Center or BOC information be edited at this time",DIR("B")="NO"
 S DIR("?")="Enter 'NO' or 'N' or 'RETURN' if no editing is needed."
 S DIR("?",1)="Enter '^' to exit the option."
 S DIR("?",2)="Enter 'YES' or 'Y' to edit this information."
 W ! D ^DIR K DIR
 Q
 ; Message processing
MSG1 K MSG W !! S MSG="...now recalculating FMS accounting lines..." D EN^DDIOL(MSG) K MSG W !
 Q
 ;
MSG2 K MSG W !! S MSG(1)="...Cost Center is missing - cannot continue..."
MSG21 S MSG(2)=" ",MSG(3)="No further action is being taken on this obligation."
 D EN^DDIOL(.MSG) K MSG W !
 Q
 ;
MSG3 K MSG W !! S MSG="BOC "_+SA_" is not valid with Cost Center "_$P(PO(0),U,5)_"."
 D EN^DDIOL(MSG) K MSG W !
 Q
 ;
MSG4 W !! S DIR(0)="Y",DIR("A",1)="I will now enter BOC "_+SA_" on all line items.",DIR("A")="Is this OK",DIR("B")="YES"
 D ^DIR K DIR
 Q
 ;
MSG5 K MSG W !! S MSG="...now changing the BOCs on all line items..."
 D EN^DDIOL(MSG) K MSG W !
 Q
MSG6 I (CCEDIT=1)!(BOCEDIT=1) Q
 K MSG W !!
 S MSG(1)=" ",MSG(2)=" "
 S:CCEDIT=0 MSG(1)="Cost Center has not changed.",MSG(3)=" "
 S:BOCEDIT=0 MSG(2)="BOC has not changed.",MSG(4)=" "
 S MSG(5)="No further editing is being done on this obligation.",MSG(6)=" "
 S MSG(7)="Returning to the Obligation processing."
 D EN^DDIOL(.MSG) K MSG W !
 Q
ERROR(ROUTINE,ERROR) ;
 I ROUTINE'="PRCUESIG" G NEXT
 I ERROR=-3 Q "NO SIGNATURE BLOCK IN FILE 200."
 I ERROR=-2 Q "TIME OUT OCCURRED DURING SIGNING PROCESS."
 I ERROR=-1 Q "USER CANCELLED SIGNING PROCESS."
 I ERROR=0 Q "INVALID SIGNATURE ENTERED."
 Q "PROBLEM WITH ELECTRONIC SIGNATURE.  ERROR= "_ERROR_" CALLING ROUTINE "_ROUTINE
NEXT I ERROR=-4 Q "CAN'T RE-SIGN RECORD."
 I ERROR=-3 Q "NO VALID USER NUMBER FOR FILING."
 I ERROR=-2 Q "NO SIGNATURE BLOCK IN FILE 200."
 I ERROR=-1 Q "A REQUIRED RECORD IS NULL."
 Q "PROBLEM WITH ELECTRONIC SIGNATURE.  ERROR= "_ERROR_" CALLING ROUTINE "_ROUTINE
 Q
