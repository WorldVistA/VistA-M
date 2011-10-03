PSDHLX ;BIR/LTL-HL7 inteface setup invoked by PSDHL7 for X3.28 ; 21 Feb 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
X328 W !!,"Let's check for a PSD-NDES X3.28 entry in your",!
 W "HL LOWER LEVEL PROTOCOL PARAMETER file (#829.2)."
 S (DIC,DIE)="^HLCS(869.2,",DIC(0)="L",DLAYGO=869.2,X="PSD-NDES X3.28"
 D ^DIC K DIC W:$P(Y,U,3) "Added." I Y<0 W "Failed." G END
 W "  Updating.",!! N PSDX S (DA,PSDX)=+Y
 S DR=".02////3;300.01//" D ^DIE K DIE,DR,DIC,DA
 W !!,"Let's check for a PSD X3.28 entry in your"
 W !,"HL LOGICAL LINK file (#870)."
 S (DIC,DIE)="^HLCS(870,",DIC(0)="L",DLAYGO=870,X="PSD X3.28"
 D ^DIC K DIC W:$P(Y,U,3) "Added." I Y<0 W "Failed." Q
 W "  Updating." N PSDL S (DA,PSDL)=+Y
 S DR="2////"_$G(PSDX) D ^DIE K DIC,DA,DIE,DLAYGO,DR D NONK^PSDHLP
END Q
