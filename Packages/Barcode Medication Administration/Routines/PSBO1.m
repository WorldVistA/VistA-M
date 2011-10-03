PSBO1 ;BIRMINGHAM/EFC-BCMA OUTPUTS ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**4,13,32,2,43,28**;Mar 2004;Build 9
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
NEW(RESULTS,PSBRTYP) ; Create a new report request
 ; Called interactively and via RPCBroker
 K RESULTS
 ; Check Type
 I '$F("DL^MD^MH^ML^MM^MV^MT^PE^PM^WA^BL^PI^AL^DO^VT^PF^XA^ST^SF^IV^CM^CP^CE^CI^BZ^",PSBRTYP) S RESULTS(0)="-1^Invalid Report Type" Q
 I '+$G(DUZ) S RESULTS(0)="-1^Undefined User" Q
 I '$G(DUZ(2)) S RESULTS(0)="-1^Undefined Division" Q
 ; Lock Log
 L +(^PSB(53.69,0)):$S($G(DILOCKTM)>30:DILOCKTM,1:30)
 E  S RESULTS(0)="-1^Request Log Locked" Q
 ; Generate Unique Entry and Create
 F  D NOW^%DTC S X=$E(%_"000000",1,14) S X=(1700+$E(X,1,3))_$E(X,4,14),X=PSBRTYP_"-"_$TR(X,".","-") Q:'$D(^PSB(53.69,"B",X))
 S DIC="^PSB(53.69,",DIC(0)="L"
 S DIC("DR")=".02///N;.03////^S X=DUZ;.04////^S X=DUZ(2);.05///^S X=PSBRTYP"
 K DD,DO D FILE^DICN
 L -(^PSB(53.69,0))
 ; Okay, setup return and Boogie
 I +Y<1 S RESULTS(0)="-1^Error Creating Request"
 E  S RESULTS(0)=Y
 K DO
 Q
 ;
PRINT ;
 N ZTDTH,ZTRTN,ZTSK,ZTDESC,ZTSAVE,DA
 S DA=+PSBRPT(0)
 S IOP=$$GET1^DIQ(53.69,DA_",",.06,"I"),PSBSIO=0 I IOP]"" D
 .S IOP="`"_IOP,%ZIS="N"
 .D ^%ZIS
 .I IO=IO(0) S PSBSIO=1
 .D HOME^%ZIS K IOP
 I $$GET1^DIQ(53.69,DA_",",.06)["BROWSER"!(PSBSIO=1) S IOP=$$GET1^DIQ(53.69,DA_",",.06)_";132" D ^%ZIS U IO D DQ^PSBO(DA) D ^%ZISC K IOP Q
 W @IOF,"Submitting Your Report Request to TaskMan..."
 S ZTIO=$$GET1^DIQ(53.69,DA_",",.06)_";132"
 S ZTDTH=$S($$GET1^DIQ(53.69,DA_",",.07,"I")]"":$$GET1^DIQ(53.69,DA_",",.07,"I"),1:$H)
 S ZTDESC="BCMA - "_$$GET1^DIQ(53.69,DA_",",.05)
 S ZTRTN="DQ^PSBO("_DA_")"
 F I="PSBDFN","PSBTYPE" S ZTSAVE(I)=""
 I $G(PSBORDNM)]"" S ZTSAVE("PSBORDNM")=""
 D ^%ZTLOAD
 I $D(ZTSK) S ^TMP("PSBO",$J,1)="0^Report queued. (Task #"_ZTSK_")"
 E  S ^TMP("PSBO",$J,1)="-1^Task Rejected."
 Q
 ;
LIST(XLIST) ;  Place List Criteria into subfile #53.692 (multiple)
 F XL1=$O(XLIST("")):1:$O(XLIST("B"),-1)  Q:+XL1=""  D
 .I $P(XLIST(XL1),U)=PSBTYPE D
 ..K PSBFDA,PSBRET,PSBIENX D CLEAN^DILF
 ..S PSBIENX="+"_(XL1+1)_","_PSBIENS
 ..D VAL^DIE(53.692,"+"_(XL1+1)_","_PSBIENS,.01,"F",$TR(XLIST(XL1),"^","~"),"PSBRET","PSBFDA")
 ..D UPDATE^DIE("","PSBFDA","PSBIENX","PSBRET")
 Q
 ;
