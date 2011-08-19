PRCHAM8 ;WISC/RHD,AKS-AMENDMENTS TO P.O. ASKER & SIGNER ;
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ASK(PRCHPO,PRCHAN) ;Ask user for their Esig
 ;USAGE: $$ASK^PRCHAM8(PODA,AN)
 ;PRCHPO is internal PO number
 ;PRCHAN is internal amendment number
 ;RETURN is the return value passed back to caller, 0=FAIL  1=SUCCESS
 ;P is the pointer of who was assigned to the amendment
 ;PNAM is the name of the person identified by P in file 200
 N P,PRCSIG,ROUTINE
 S RETURN=0,P=+$G(^PRC(443.6,PRCHPO,6,PRCHAN,1))
 I P<1 W !?5,"Purchasing Agent Field is undefined !",$C(7) Q RETURN
 I P'=DUZ D  Q RETURN
 .N PNAM S PNAM=$P($G(^VA(200,P,0)),"^",1)
 .W !?5,PNAM," was assigned to this Amendment."
 .W !?5,"Either have them sign the Amendment or"
 .W !?5,"reassign the Amendment to yourself.",$C(7)
 .Q
 S PRCSIG="" D ESIG^PRCUESIG(P,.PRCSIG) I PRCSIG<1 W !?5,"<NO ACTION TAKEN>" S ROUTINE="PRCUESIG" D QQ Q RETURN
 S RETURN=1
 Q RETURN
 ;
COMMIT(PRCHPO,PRCHAN,RETURN) ;put on validation code
 ;USAGE:  D COMMIT^PRCHAM8(PODA,AN,.Y) then check Y value
 ;PRCHPO is internal PO number
 ;PRCHAN is internal amendment number
 ;RETURN is the return value passed back to caller, 0=FAIL  1=SUCCESS
 ;DO NOT 'NEW' THE VARIABLE 'RETURN' IN HERE
 ;              SINCE IT IS PASSED BACK TO CALLING ROUTINE!
 N PRCSUM,PRCSIG,ROUTINE
 S RETURN=0
 Q:'$D(^PRC(442,PRCHPO,0)) RETURN
 Q:'$D(^PRC(443.6,PRCHPO,0)) RETURN
 S PRCSUM=$$SUM^PRCUESIG(PRCHPO_"^"_$$STRING^PRCHES5(^PRC(442,PRCHPO,0),^PRC(442,PRCHPO,1),^PRC(442,PRCHPO,12)))
 S PRCSIG="" D ENCODE^PRCHES10(PRCHPO,PRCHAN,DUZ,.PRCSIG) S ROUTINE="PRCHMA" I PRCSIG<1 G QQ
 ;S X=$P(^PRC(443.6,PRCHPO,6,PRCHAN,1),U,4) S:X]"" $P(^PRC(443.6,PRCHPO,7),U,1)=X
 S PRCSIG="" D RECODE^PRCHES12(PRCHPO,PRCSUM,.PRCSIG) S ROUTINE="PRCHMA" I PRCSIG<1 G QQ
 S RETURN=1
 Q
 ;
QQ ;error reporter
 N DIR
 S:'$D(ROUTINE) ROUTINE=$T(+0)
 W !!,$$ERR^PRCHQQ(ROUTINE,PRCSIG) W:PRCSIG=0!(PRCSIG=-3) !,"Notify Application Coordinator!"
 S DIR(0)="EAO",DIR("A")="Press <Return> to continue " D ^DIR
 Q
