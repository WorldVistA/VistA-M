PSBMD ;BIRMINGHAM/EFC - BCMA MISSING DOSE FUNCTIONS ;6/28/10 1:37pm
 ;;3.0;BAR CODE MED ADMIN;**23,42**;Mar 2004;Build 23
 ;
 ; Reference/IA
 ; ^DIC(42/10039
 ; ^DPT(/10035
 ; IN5^VADPT/10061
 ; DEM^VADPT/10061
 ; ^XMB/10070
 ; 52.6/436
 ; 52.7/437
 ;
RPC(RESULTS,PSBDFN,PSBDRUG,PSBDOSE,PSBRSN,PSBADMIN,PSBNEED,PSBUID,PSBON,PSBSCHD) ;
 ;
 ; RPC: PSB SUBMIT MISSING DOSE
 ;
 ; Description:
 ; Allows the client to submit a missing dose interactively
 ;
 N DFN,PSBNOW,PSBFDA,PSBIENS,PSBMD,PSBMSG
 D NEW(.PSBMD)
 I +PSBMD(0)<1 S RESULTS(0)="-1^Unable to create missing dose request"  Q
 S PSBIENS=+PSBMD(0)_","
 D NOW^%DTC S PSBNOW=%
 S PSBFDA(53.68,PSBIENS,.02)=PSBNOW
 S PSBFDA(53.68,PSBIENS,.03)=DUZ
 S PSBFDA(53.68,PSBIENS,.04)=DUZ(2)
 S PSBFDA(53.68,PSBIENS,.11)=PSBDFN
 S X=$G(^DPT(PSBDFN,.1)) I X]"" S X=$O(^DIC(42,"B",X,0)) S:X PSBFDA(53.68,PSBIENS,.12)=X
 S PSBFDA(53.68,PSBIENS,.13)=PSBDRUG
 S PSBFDA(53.68,PSBIENS,.14)=PSBDOSE
 S PSBFDA(53.68,PSBIENS,.15)=PSBRSN
 S PSBFDA(53.68,PSBIENS,.16)=PSBADMIN
 S PSBFDA(53.68,PSBIENS,.17)=PSBNEED
 S PSBFDA(53.68,PSBIENS,.19)=PSBSCHD
 S PSBFDA(53.68,PSBIENS,.25)=PSBUID
 S DFN=PSBDFN D IN5^VADPT S PSBFDA(53.68,PSBIENS,.18)=$P(VAIP(6),U,1)
 D FILE^DIE("","PSBFDA","PSBMSG")
 L +^PSB(53.68,+PSBIENS):$S($G(DILOCKTM)>0:DILOCKTM,1:3)  ; PSB*3*23
 I $G(PSBUID)'="" D
 .D PSJ1^PSBVT(PSBDFN,PSBON) K PSBADA,PSBSOLA
 .I '$D(PSBUIDA(PSBUID)) F  D PSJ1^PSBVT(PSBDFN,PSBPONX) K PSBADA,PSBSOLA Q:$D(PSBUIDA(PSBUID))  Q:PSBPONX=""
 .F I=1:1 S PSBAD=$P(PSBUIDA(PSBUID),U,I) Q:PSBAD=""  I PSBAD["ADD" S PSBADA($P(PSBAD,";",2))=""
 .I $D(PSBADA) S X="" F I=1:1 S X=$O(PSBADA(X)) Q:X=""  S PSBFDA(53.686,I_","_PSBIENS,.01)=X,^PSB(53.68,+PSBIENS,.6,I,0)=I
 .F I=1:1 S PSBSOL=$P(PSBUIDA(PSBUID),U,I) Q:PSBSOL=""  I PSBSOL["SOL" S PSBSOLA($P(PSBSOL,";",2))=""
 .I $D(PSBSOLA) S X="" F I=1:1 S X=$O(PSBSOLA(X)) Q:X=""  S PSBFDA(53.687,I_","_PSBIENS,.01)=X,^PSB(53.68,+PSBIENS,.7,I,0)=I
 I $G(PSBUID)="",$G(PSBDRUG)="" D
 .D PSJ1^PSBVT(PSBDFN,PSBON)
 .I $D(PSBADA) S X="" F I=1:1 S X=$O(PSBADA(X)) Q:X=""  S PSBFDA(53.686,I_","_PSBIENS,.01)=$P(PSBADA(X),U,2),^PSB(53.68,+PSBIENS,.6,I,0)=X
 .I $D(PSBSOLA) S X="" F I=1:1 S X=$O(PSBSOLA(X)) Q:X=""  S PSBFDA(53.687,I_","_PSBIENS,.01)=$P(PSBSOLA(X),U,2),^PSB(53.68,+PSBIENS,.7,I,0)=X
 D FILE^DIE("","PSBFDA","PSBMSG")
 L -^PSB(53.68,+PSBIENS) ; PSB83*23
 D SUBMIT(+PSBIENS)
 S RESULTS(0)="1^Missing Dose Submitted^"_+PSBIENS
 D CLEAN^PSBVT
 Q
 ;
XQ ; Called via Kernel Menus
 N PSBMD,PSBSAVE,DA,DIK,DR,DDSFILE,XMY,XMTEXT,XMSUB
 D NEW(.PSBMD)
 I +PSBMD(0)<1 W !,"Error: ",$P(PSBMD(0),U,2) S DIR(0)="E" D ^DIR Q
 S DA=+PSBMD(0),DR="[PSB MISSING DOSE REQUEST]",DDSFILE=53.68 D ^DDS
 W @IOF
 I 'PSBSAVE W !,"Cancelling Request..." S DIK="^PSB(53.68," D ^DIK W "Cancelled!"
 D:PSBSAVE SUBMIT(DA)
 Q
 ;
SUBMIT(DA) ; Submit Request to Pharmacy
 N PSBWRD,PSBMG,PSBPRT
 S PSBWRD=$P(^PSB(53.68,DA,.1),U,2)
 S PSBWRD=+$G(^DIC(42,+PSBWRD,44))
 ;
 ; Get Mail Group
 ;
 S PSBMG=$$GET^XPAR(PSBWRD_";SC(","PSB MG MISSING DOSE",,"E")
 S:PSBMG="" PSBMG=$$GET^XPAR("DIV","PSB MG MISSING DOSE",,"E")
 S $P(^PSB(53.68,DA,0),U,5)=PSBMG ; Add MG to notification
 ;
 ; Get Printer
 ;
 S PSBPRT=$$GET^XPAR(PSBWRD_";SC(","PSB PRINTER MISSING DOSE",,"E")
 S:PSBPRT="" PSBPRT=$$GET^XPAR("DIV","PSB PRINTER MISSING DOSE",,"E")
 S $P(^PSB(53.68,DA,0),U,6)=PSBPRT ; Add MG to notification
 ;
 ; Send the report to the specified printer
 ;
 D:PSBPRT]""
 .W !,"Submitting Request To Pharmacy on device ",PSBPRT,"..."
 .D NOW^%DTC
 .S ZTIO=PSBPRT
 .S ZTDTH=%
 .S ZTDESC="BCMA - MISSING DOSE REQUEST"
 .S ZTRTN="DQ^PSBMD("_DA_")"
 .D ^%ZTLOAD
 .W "Done!"
 ;
 ; Send the same stuff to the mail group
 ;
 D:PSBMG]""
 .W !,"Notifying Pharmacy via Mail Group ",PSBMG,"..."
 .D HFSOPEN^PSBUTL("MISSING DOSE")
 .U IO D DQ(DA,1)
 .D HFSCLOSE^PSBUTL("MISSING DOSE")
 .S XMY("G."_PSBMG)="",XMTEXT="^TMP(""PSBO"",$J,"
 .S XMSUB="BCMA - Missing Dose Request"
 .D ^XMD
 .W "Done!"
 Q
 ;
DQ(PSBMD,PSBMM) ; Dequeue report from Taskman
 N PSBFLD,PSBRET
 Q:'$D(^PSB(53.68,PSBMD,0))
 L +^PSB(53.68,PSBMD):$S($G(DILOCKTM)>0:DILOCKTM,1:3) ; PSB*3*23
 S PSBCFLD=$P(^PSB(53.68,PSBMD,.1),U,3)
 L -^PSB(53.68,PSBMD) ; PSB*3*23
 D:'$G(PSBMM)  ; It is not a mail message
 .W !,$TR($J("",75)," ","=")
 .W !,"Report:       MISSING DOSE REQUEST"
 .W !,"Date Created: " D NOW^%DTC S Y=% D D^DIQ W Y
 .W !,$TR($J("",75)," ","="),!
 I $G(PSBCFLD)'="" F PSBFLD=.01,.02,.03,.04,.05,.06,.11,.12,.18,.13,.14,.19,.15,.16,.17 D OUT
 I $G(PSBCFLD)="" F PSBFLD=.01,.02,.03,.04,.05,.06,.11,.12,.18,.25,.15,.19,.16,.17 D OUT
 I $D(^PSB(53.68,PSBMD,.6)) S X=0 F  S X=$O(^PSB(53.68,PSBMD,.6,X)) Q:'X  W !?3,"ADDITIVE:  ",$$GET1^DIQ(52.6,+^PSB(53.68,PSBMD,.6,X,0),.01)
 I $D(^PSB(53.68,PSBMD,.7)) S X=0 F  S X=$O(^PSB(53.68,PSBMD,.7,X)) Q:'X  W !?3,"SOLUTION:  ",$$GET1^DIQ(52.7,+^PSB(53.68,PSBMD,.7,X,0),.01)
 Q
OUT ;
 D FIELD^DID(53.68,PSBFLD,"","LABEL","PSBRET")
 W !?3,PSBRET("LABEL"),":" F  Q:$X>30  W "."
 W $$GET1^DIQ(53.68,PSBMD_",",PSBFLD)
 I PSBFLD=.11 D
 .N DFN,VA,VADM S DFN=$$GET1^DIQ(53.68,PSBMD_",",.11,"I") D DEM^VADPT
 .W !?3,$$GET^XPAR("ALL","PSB PATIENT ID LABEL")
 .I $G(DUZ("AG"))="I" D
 ..W ":" F  Q:$X>30  W "."
 .E  D
 ..W " (LAST 4 NUMBERS):" F  Q:$X>30  W "."
 .W VA("BID")
 W:PSBFLD=.13 " ("_$P($G(^PSB(53.68,PSBMD,.1)),U,3)_")"
 S ZTREQ="@"
 Q
 ;
NEW(RESULTS) ; Create a new missing dose request
 ; Called interactively and via RPCBroker
 N DIC
 K RESULTS
 I '+$G(DUZ) S RESULTS(0)="-1^Undefined User" Q
 I '$G(DUZ(2)) S RESULTS(0)="-1^Undefined Division" Q
 ; Lock Log
 L +^PSB(53.68,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 E  S RESULTS(0)="-1^Request Log Locked" Q
 ; Generate Unique Entry and Create
 F  D NOW^%DTC S X=$E(%_"000000",1,14),X=(1700+$E(X,1,3))_$E(X,4,14),X="MD-"_$TR(X,".","-") Q:'$D(^PSB(53.68,"B",X))
 S DIC="^PSB(53.68,",DIC(0)="L"
 S DIC("DR")=".02///N;.03////^S X=DUZ;.04////^S X=DUZ(2);.07///1"
 K D0         ;VRN
 D FILE^DICN
 L -^PSB(53.68,0)
 ; Okay, setup return and Boogie
 I +Y<1 S RESULTS(0)="-1^Error Creating Request"
 E  S RESULTS(0)=Y
 Q
 ;
VAL(PSBFLDS) ; Validate that fields in PSBFLDS are filled in
 N PSB,PSBFLD,PSBMSG
 F PSB=1:1 Q:$P(PSBFLDS,";",PSB)=""  S PSBFLD=$P(PSBFLDS,";",PSB),PSBFLD(PSBFLD)=$$GET^DDSVAL(53.68,DA,PSBFLD)
 I $D(PSBFLD(.21)) K:PSBFLD(.21)="N" PSBFLD(.22),PSBFLD(.23)
 S PSB=""  F  S PSB=$O(PSBFLD(PSB)) Q:PSB=""  D:PSBFLD(PSB)=""
 .I '$D(PSBMSG) S PSBMSG(0)="UNABLE TO FILE REQUEST",PSBMSG(1)=" ",PSBMSG(2)="ERROR: MISSING DATA - ALL FIELDS ARE REQUIRED"
 .D FIELD^DID(53.68,PSB,"","TITLE;LABEL","PSB")
 .S X="  Missing Field: "_$S(PSB("TITLE")]"":PSB("TITLE"),1:PSB("LABEL")),PSBMSG($O(PSBMSG(""),-1)+1)=X
 Q:'$D(PSBMSG)  ; All is well
 D MSG^DDSUTL(.PSBMSG)
 S DDSERROR=1
 Q
 ;
FLWUP ; Follow-Up on missing dose
 N DIR,PSBIEN,PSBX,DA,DR,DDSFILE,PSBHDR,PSBDRUG
 S Y="" F  Q:Y="^"  D
 .K ^TMP("PSB",$J) S X=""
 .F  S X=$O(^PSB(53.68,"AS",1,X),-1) Q:'X  S Y=$O(^TMP("PSB",$J,""),-1)+1,^TMP("PSB",$J,Y)=X,^TMP("PSB",$J,0)=Y
 .I '$O(^TMP("PSB",$J,0)) W !!,"No Unresolved Missing Dose Requests Found." S Y="^" Q
 .S PSBHDR="Currently Unresolved Missing Dose Requests"
 .W @IOF,PSBHDR,!,$TR($J("",IOM)," ","-")
 .F PSBX=0:0 S PSBX=$O(^TMP("PSB",$J,PSBX)) Q:'PSBX!(Y="^")  S PSBIEN=^(PSBX)_"," D
 ..W !,$J(PSBX,2),". ",$$GET1^DIQ(53.68,PSBIEN,.01)
 ..W ?25,$$GET1^DIQ(53.68,PSBIEN,.11)
 ..W ?57,$$GET1^DIQ(53.68,PSBIEN,.12)
 ..S PSBDRUG=$$GET1^DIQ(53.68,PSBIEN,.13)
 ..I PSBDRUG]"" W !?5,PSBDRUG
 ..I PSBDRUG="" D
 ...W !?5,"UNIQUE ID: ",$$GET1^DIQ(53.68,PSBIEN,.25)
 ...S X=0 F  S X=$O(^PSB(53.68,+PSBIEN,.6,X)) Q:'X  W !?10,"ADDITIVES:  ",$$GET1^DIQ(52.6,+^PSB(53.68,+PSBIEN,.6,X,0),.01)
 ...S X=0 F  S X=$O(^PSB(53.68,+PSBIEN,.7,X)) Q:'X  W !?10,"SOLUTIONS:  ",$$GET1^DIQ(52.7,+^PSB(53.68,+PSBIEN,.7,X,0),.01)
 ..S:$Y>(IOSL-4) Y=$$PAGE(PSBX)
 .S:Y'="^" Y=$$PAGE(PSBX)
 Q
PAGE(PSBIX) ;
 ;
 N X,X1,PSBCX,PSBDX
 S DIR("A")="Select Missing Dose Request # (<RET> to continue, '^' to quit)"
 I PSBIX="" S DIR("A")="Select Missing Dose Request # (<RET> or '^' to quit)"
 S DIR(0)="NO^1:"_$S(PSBIX="":$O(^TMP("PSB",$J,PSBX),-1),1:PSBIX)_":0"
 D ^DIR S PSBDX=+Y
 I PSBIX="",Y="" S Y="^" Q Y
 I $G(DTOUT) S Y="^" Q Y
 I Y="^" Q Y
 I Y="" W @IOF,PSBHDR,!,$TR($J("",IOM)," ","-") Q Y
 S (DA,PSBCX)=^TMP("PSB",$J,+Y),DR="[PSB MISSING DOSE FOLLOWUP]",DDSFILE=53.68
 D  Q Y
 .D ^DDS
 .I $D(^PSB(53.68,"AS",0,PSBCX)) K ^TMP("PSB",$J) S X="" F  S X=$O(^PSB(53.68,"AS",1,X),-1) Q:'X  S X1=$O(^TMP("PSB",$J,""),-1)+1,^TMP("PSB",$J,X1)=X,^TMP("PSB",$J,0)=X1
 .S PSBX=0 W @IOF,PSBHDR,!,$TR($J("",IOM)," ","-")
 ;
POST ;call from 'Patient' field of screenman form PSB MISSING DOSE REQUEST
 ; 
 N DFN
 S DFN=X D IN5^VADPT
 D PUT^DDSVAL(DIE,.DA,.12,$P(VAIP(5),U,2))  ; value of DIE is 53.68, BCMA MISSING DOSE REQUEST FILE called from ScreenMan
 D PUT^DDSVAL(DIE,.DA,.18,$P(VAIP(6),U,1),"","I")  ; value of DIE is 53.68, BCMA MISSING DOSE REQUEST FILE called from ScreenMan
 D REFRESH^DDSUTL
 Q
