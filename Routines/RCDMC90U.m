RCDMC90U ;WASH IRMFO@ALTOONA,PA/TJK-DMC 90 DAY ;7/17/97  8:14 AM ; 10/24/96  3:21 PM [ 02/24/97  12:17 PM ]
V ;;4.5;Accounts Receivable;**45,108,121,163**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
COMPILE(MAX,CNTR,LINES,TLINE) ;COMPILES CODESHEETS INTO MAILMAN MESSAGES
 ;BUILDS MESSAGE ARRAY
 N CNT,SEQ,REC,XMDUZ
 S (SEQ,REC)=0
 F CNT=1:1:CNTR D
 .D:CNT#MAX=1
 ..K ^XTMP("RCDMC90",$J,"BUILD") S SEQ=SEQ+1
 ..S REC=0
 ..Q
 .S REC=REC+1,^XTMP("RCDMC90",$J,"BUILD",REC)=^XTMP("RCDMC90",$J,CNT)
 .S:CNTR=CNT ^XTMP("RCDMC90",$J,"BUILD",REC+1)="END OF TRANSMISSION FOR SITE# "_SITE_":  TOTAL RECORDS: "_(CNT/LINES)
 .I $S(CNTR=CNT:1,CNT#MAX=0:1,1:0) D
 ..N XMY,XMSUB
 ..S XMDUZ="AR PACKAGE"
 ..S:RCDOC="W" XMY("XXX@Q-DMX.MED.VA.GOV")=""
 ..S:RCDOC="M" XMY("XXX@Q-DMR.MED.VA.GOV")=""
 ..S XMSUB=SITE_"/DMC REPORT"_"/SEQ#: "_SEQ_"/"_$$NOW()
 ..S XMTEXT="^XTMP(""RCDMC90"","_$J_",""BUILD"","
 ..D ^XMD
 ..Q
 .Q
 S XMDUZ="AR PACKAGE"
 S:RCDOC="W" XMY("G.DMX")=""
 S:RCDOC="M" XMY("G.DMR")=""
 S XMSUB=$S(RCDOC="W":"WEEKLY UPDATE ",1:"MASTER FILE ")_"RECORDS SENT TO DMC ON "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S ^XTMP("RCDMC90",$J,"REC1",1)="Name                          Last4   Principle Interest     Admin     Total"
 S ^XTMP("RCDMC90",$J,"REC1",2)="----                          -----   --------- --------     -----     -----"
 S ^XTMP("RCDMC90",$J,"REC1",RCNT+1)="Total Records Sent: "_(RCNT-2)
 F I=1,2,3 D
 .S ^XTMP("RCDMC90",$J,"REC1",RCNT+I+1)="Total "_$S(I=1:"Principle:     ",I=2:"Interest:      ",1:"Admin:         ")_$J($P(TLINE,U,I),15,2)
 .Q
 S ^XTMP("RCDMC90",$J,"REC1",RCNT+5)="Total:               "_$J($P(TLINE,U)+$P(TLINE,U,2)+$P(TLINE,U,3),15,2)
 S X="",I=2 F  S X=$O(^XTMP("RCDMC90",$J,"REC",X)) Q:X=""  S I=I+1,^XTMP("RCDMC90",$J,"REC1",I)=^(X)
 S XMTEXT="^XTMP(""RCDMC90"","_$J_",""REC1"","
 D ^XMD
COMPQ Q
PSEUDO(DFN,PSSN) ;Screens out patients with Pseudo-SSN's and sends mail message
 N XMSUB,XMY,XMTEXT,MSG,XMDUZ
 S XMSUB="Notice of debtor eligible for DMC with Pseudo-SSN"
 S XMY("G.DMR")=""
 S XMDUZ="AR PACKAGE",XMTEXT="MSG("
 S MSG(1)="The following patient is eligible for DMC collection,"
 S MSG(2)="but can not be submitted because of a Pseudo-SSN."
 S MSG(3)="A valid SSN needs to be entered for this patient."
 S MSG(4)=" "
 S MSG(5)="Patient: "_$P(^DPT(DFN,0),U)_" Pseudo-SSN: "_PSSN
 D ^XMD
 Q
NOW() N X,Y,%,%H
 S %H=$H D YX^%DTC
 Q Y
REPORT ;PRINT REPORT
 N DIC,DIS,L,BY,FR,TO,FLDS,PG,PRINTOT,ADMTOT,INTTOT,DIOEND
 W !!,"DMC 90 DAY REFERRAL REPORT",!!
 W !,"Select type of report"
 S DIR(0)="SM^D:DETAILED;S:SUMMARY",DIR("A")="Enter Report Type"
 S DIR("?")="Enter 'D' or 'S':"
 S DIR("?",1)="A detailed report prints out current totals for each individual debtor at DMC."
 S DIR("?",2)="A summary report prints out current totals of all accounts at DMC."
 D ^DIR Q:(Y="")!(Y="^")
 S L=0,(FR,TO)="",DIC=340
 I Y="S" S BY=3.01,FLDS="[RCDMC90B]" G PRINT
 S (PRINTOT,ADMTOT,INTTOT)=0
 S DIS(0)="I $D(^RCD(340,""DMC"",1,D0))"
 S BY=.01,FLDS="[RCDMC90A]"
 S DIOEND="D PRNTOT^RCDMC90U"
PRINT D EN1^DIP
REPORTQ Q
PRNTOT N DASH
 S DASH="",$P(DASH,"-",81)=""
 W !!,DASH
 W !,?6,"TOTALS:",?26,"PRINCIPLE",?36,"$"_$J(PRINTOT,15,2)
 W !,?26,"INTEREST",?36,"$"_$J(INTTOT,15,2),!,?26,"ADMIN",?36,"$"_$J(ADMTOT,15,2)
 W !,?26,"TOTAL",?36,"$"_$J(PRINTOT+INTTOT+ADMTOT,15,2)
 Q
STARTUP ;Displays reminder message for mailgroups
 N RCMSG S RCMSG(1)="Mailgroup 'DMR' to receive master transaction messages has been set up"
 S RCMSG(2)="Mailgroup 'DMX' to receive weekly transacton messages have been sent up."
 S RCMSG(3)="****Remember to add users to these mailgroups.****"
 D MES^XPDUTL(.RCMSG)
 Q
LESSW ;ENTRY POINT FOR MENU OPTION TO ALLOW LESSER WITHHOLDING
 N DIC,DIR,DEBTOR
 W !,"DMC Lesser Withholding..."
 S DIC=340,DIC(0)="AEQM",DIC("S")="I $D(^RCD(340,""DMC"",1,+Y))"
 D ^DIC G LESSWQ:Y<0 S DEBTOR=+Y
LESSWA S DIR(0)="340,3.09",DIR("B")=$S($P($G(^RCD(340,DEBTOR,3)),U,9):$J($P(^RCD(340,DEBTOR,3),U,9),0,2),1:"0.00") D ^DIR G LESSWQ:'Y
 I +Y>$P(^RCD(340,DEBTOR,3),U,5) W !!,*7,"Amount entered exceeds the amount currently at DMC which is ",$P(^(3),U,5),!,"Re-enter lesser amount" G LESSWA
 S $P(^RCD(340,DEBTOR,3),U,9)=+Y
LESSWQ Q
CANC ;ENTRY POINT FOR MENU OPTION TO ALLOW VAMC TO CANCEL DMC WITHOLDING
 W !,"Deletion of Debtor From DMC"
 N DEBTOR,DIC,DIR,DELETE,Y
CANC1 S DIC=340,DIC(0)="AEQM",DIC("A")="Enter Debtor To Be Removed From DMC:  "
 S DIC("S")="I $D(^RCD(340,""DMC"",1,+Y))" D ^DIC G CANCQ:+Y<0 S DEBTOR=+Y
 S DIR(0)="YA",DIR("A")="Are you sure you wish to delete this debtor from DMC? "
 S DIR("B")="NO" D ^DIR G CANC1:'Y
 S ^RCD(340,DEBTOR,3)="1^^^^^^^^^1"
CANC2 S I=0 F  S I=$O(^PRCA(430,"C",DEBTOR,I)) Q:I'?1N.N  K ^PRCA(430,I,12)
 G CANC1:'$G(DELETE)
 K ^RCD(340,DEBTOR,3),^RCD(340,"DMC",1,DEBTOR)
 Q
CANC3(DEBTOR,DELETE) ;ENTRY POINT FOR AUTODELETION BY SERVER
 N I
 D CANC2
CANCQ Q
 ;
ERROR(RCDOC,LKUP,DFN)   ; send bulletin if address is not in correct format
 N XMSUB,XMY,XMDUZ,XMTEXT,MSG
 S XMSUB="Notice of Unknown/Corrupted Address to DMC"
 S XMY("G.DMR")=""
 S XMDUZ="AR PACKAGE"
 S XMTEXT="MSG("
 I RCDOC="M" S MSG(1)="Master Record-Monthly was not sent because:"
 S MSG(2)="Address is "_$S(LKUP=2:"invalid",1:"unknown")_". Verify and re-enter"
 S MSG(3)="address for the following patient: "
 S MSG(4)=" "
 S MSG(5)="   "_$P(^DPT(DFN,0),U)_"   SSN: "_$P(^(0),U,9)
 I RCDOC="W" S MSG(6)=" ",MSG(7)="PLEASE NOTE: SENT WEEKLY UPDATE WITH ZERO BALANCE!"
 D ^XMD
ERRORQ Q
