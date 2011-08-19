PSDHLP ;BIR/LTL-HL7 inteface setup for logical links on protocols ; 21 Feb 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
NONK ;non-kids type call by ^PSDHL7 & ^PSDHLX
 W !!,"Updating Clients with your selected logical link:",!!
 I $G(PSD(3)) D  Q
 .S DIC="^ORD(101,",DIC(0)="ML",DLAYGO=101
 .F PSD(4)=1:1:3 S X="PSD"_PSD(3)_" A0"_PSD(4)_" CLIENT" D ^DIC W $P(Y,U,2),!! M ^ORD(101,+Y)=^ORD(101,+$O(^ORD(101,"B","PSD A0"_PSD(4)_" CLIENT",0))) S $P(^ORD(101,+Y,0),U)=X,DIK=DIC,(DA,PSD(5))=+Y D IX1^DIK D
 ..S DA=PSD(5),DIE=DIC,DR="770.7////"_$G(PSDL) D ^DIE
 .K DIC,DLAYGO,DIK,DA,DR,DIE
 N DIE,DA,DR,PSD S PSD="PSD",DIE="^ORD(101,"
 F  S PSD=$O(^ORD(101,"B",PSD)) Q:PSD']""!($E(PSD,1,3)'="PSD")  D:PSD["C"
 .S DR="770.7////"_$G(PSDL)
 .W PSD,!! S DA=$O(^ORD(101,"B",PSD,0)) D ^DIE
DG ;S DIR(0)="Y",DIR("A")="Would you like to add the PSD PAT ADT Protocol to the DGPM Event Driver now",DIR("?")="^N XQH S XQH =""PSD HL7 ADT"" D EN^XQH"
 ;D ^DIR K DIR D:Y=1 ^PSDONIT
 Q
