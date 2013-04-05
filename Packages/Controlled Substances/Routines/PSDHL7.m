PSDHL7 ;BIR/LTL-HL7 inteface for Control Subs invoked by post init ; 21 Feb 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
CHECK ;check for Narcotic Dispensing Equipment System/HL7 interface
 N DA,DIC,DIE,DIR,DIRUT,DLAYGO,DR,PSD,X,Y
 S DIR(0)="Y"
 S DIR("A",1)="Do you want to enter/edit your interface setup"
 S DIR("A")="for Narcotic Dispensing Equipment Systems",DIR("B")="No"
 S DIR("?")="^N XQH S XQH=""PSD HL7"" D EN^XQH"
 D ^DIR K DIR G:Y'=1 END D:Y=1
 .W !!,"First, I'll check for a PSD-CS entry in your",!
 .W "HL7 DHCP APPLICATION PARAMETER file (#771)."
 .S (DIC,DIE)="^HL(771,",DIC(0)="L",DLAYGO=771,X="PSD-CS"
 .D ^DIC K DIC W:$P(Y,U,3) "  Added." I Y<0 W "Failed." G END
 .W "  Updating." S PSDC=+Y
 .S DIC="^DIC(4,",DR=99,DA=+$P($G(^XMB(1,1,"XUS")),U,17),DIQ="PSD"
 .D EN^DIQ1 S PSD=PSD(4,DA,99) K DIC,DR,DA,DIQ
 .S DA=PSDC,PSD(1)="^~\&"
 .S DR="2////a;3////"_PSD_";100////|;101////^S X=PSD(1)"
 .D ^DIE K DIE,DR
 .;S DIC="^HL(771,"_PSD_",""MSG"",",DIC(0)="L",DA(1)=PSD,X="DFT"
 .;S DIC("P")=$P(^DD(771,6,0),"^",2),DIC("DR")="1////PSDFT"
 .;D ^DIC K DA,DIC
 .W !!,"Now, let's check for a PSD-NDES entry in your",!
 .W "HL7 DHCP APPLICATION PARAMETER file (#771)."
 .S (DIC,DIE)="^HL(771,",DIC(0)="L",DLAYGO=771,X="PSD-NDES"
 .D ^DIC K DIC W:$P(Y,U,3) " Added." I Y<0 W "Failed." G END
 .W "  Updating.",!! S (DA,PSDN)=+Y
 .;S DR="2////"_PSD_";3////PSD-NDES;4////245;5////3;7////1;8////"_PSD_";9////30;14////P;100///Narcotic Dispensing Equipment System" D ^DIE
 .S DR="2////a;3////PSD-NDES" D ^DIE K DIE,DR,DLAYGO,DIC,PSD
PROTO ;Pick HLLP or X3.28 protocol
 S DIR(0)="S^H:Hybrid Lower Layer Protocol;X:X3.28 Protocol"
 S DIR("A")="Select a communications protocol",DIR("B")="H"
 S DIR("?")="Select the protocol that your Pharmacy's narcotic dispensing system vendor will use for communication." D ^DIR K DIR G:$D(DIRUT) END
 G:Y="X" ^PSDHLX
 S PSD="PSD-NDES HLLP",PSD(1)="PSD HLLP"
HLLP W !!,"Let's check for a ",PSD," entry in your",!
 W "HL LOWER LEVEL PROTOCOL PARAMETER file (#869.2)."
 S (DIC,DIE)="^HLCS(869.2,",DIC(0)="L",DLAYGO=869.2,X=PSD
 D ^DIC K DIC W:$P(Y,U,3) "Added." I Y<0 W "Failed." G END
 W "  Updating.",!! S (DA,PSDX)=+Y
 S DR=".02////2;200.08////21;200.01//" D ^DIE
 W !!,"Let's check for a ",PSD(1)," entry in your"
 W !,"HL LOGICAL LINK file (#870)."
 S (DIC,DIE)="^HLCS(870,",DIC(0)="L",DLAYGO=870,X=PSD(1)
 D ^DIC K DIC W:$P(Y,U,3) "Added." I Y<0 W "Failed." Q
 W "  Updating." S (DA,PSDL)=+Y
 S DR="2////"_$G(PSDX) D ^DIE K DIC,DA,DIE,DR,DLAYGO D NONK^PSDHLP
 S DIR(0)="Y",DIR("A")="Do you need to set up another LOGICAL LINK"
 S DIR("B")="No",DIR("?")="Are you a consolidated site?  Do you have more than one host?" W ! D ^DIR K DIR I Y=1 S PSD(3)=$G(PSD(3))+1,PSD=PSD_PSD(3),PSD(1)=PSD(1)_PSD(3) G HLLP
END Q
