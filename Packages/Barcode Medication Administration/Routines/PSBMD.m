PSBMD ;BIRMINGHAM/EFC - BCMA MISSING DOSE FUNCTIONS ;4/23/21  08:34
 ;;3.0;BAR CODE MED ADMIN;**23,42,70,100,111,106,132**;Mar 2004;Build 1
 ;
 ; Reference/IA
 ; ^DIC(42/10039
 ; ^DPT(/10035
 ; IN5^VADPT/10061
 ; DEM^VADPT/10061
 ; ^XMB/10070
 ; 52.6/436
 ; 52.7/437
 ; ^DG(40.8/417
 ; 4/2171
 ; ^DG(40.8/2817
 ; ^VA(200/10060
 ; ^DIC(4/10090
 ; ^DG(43/6812
 ;
 ;*70 -  add new kernel variable for CO Missing Dose Printer.
 ;       use Clinc name if passed in for the new field Clinic or
 ;        assume Ward and get ien.
 ;*106-  add Hazardous Handle & Dispose flags
 ;
RPC(RESULTS,PSBDFN,PSBDRUG,PSBDOSE,PSBRSN,PSBADMIN,PSBNEED,PSBUID,PSBON,PSBSCHD,PSBCLIN,PSBCLNIEN) ;
 ;
 ; RPC: PSB SUBMIT MISSING DOSE
 ;
 ; Description:
 ; Allows the client to submit a missing dose interactively
 ;
 N DFN,PSBNOW,PSBFDA,PSBIENS,PSBMD,PSBMSG
 S PSBCLNIEN=+$G(PSBCLNIEN)    ;*70 insure numeric
 D NEW(.PSBMD)
 I +PSBMD(0)<1 S RESULTS(0)="-1^Unable to create missing dose request"  Q
 S PSBIENS=+PSBMD(0)_","
 D NOW^%DTC S PSBNOW=%
 S PSBFDA(53.68,PSBIENS,.02)=PSBNOW
 S PSBFDA(53.68,PSBIENS,.03)=DUZ
 S PSBFDA(53.68,PSBIENS,.04)=DUZ(2)
 S PSBFDA(53.68,PSBIENS,.11)=PSBDFN
 ; Ward or Clinic - use Clinic name if passed, else get Ward ien.  *70
 I PSBCLIN]"" D
 .S PSBFDA(53.68,PSBIENS,1)=PSBCLNIEN
 E  D
 .S X=$G(^DPT(PSBDFN,.1))
 .I X]"" S X=$O(^DIC(42,"B",X,0)) S:X PSBFDA(53.68,PSBIENS,.12)=X
 .S DFN=PSBDFN D IN5^VADPT S PSBFDA(53.68,PSBIENS,.18)=$P(VAIP(6),U,1)
 S PSBFDA(53.68,PSBIENS,.13)=PSBDRUG
 S PSBFDA(53.68,PSBIENS,.14)=PSBDOSE
 S PSBFDA(53.68,PSBIENS,.15)=PSBRSN
 S PSBFDA(53.68,PSBIENS,.16)=PSBADMIN
 S PSBFDA(53.68,PSBIENS,.17)=PSBNEED
 S PSBFDA(53.68,PSBIENS,.19)=PSBSCHD
 S PSBFDA(53.68,PSBIENS,.25)=PSBUID
 D FILE^DIE("","PSBFDA","PSBMSG")
 L +^PSB(53.68,+PSBIENS):$S($G(DILOCKTM)>0:DILOCKTM,1:3)  ; PSB*3*23
 I $G(PSBUID)'="" D
 .D PSJ1^PSBVT(PSBDFN,PSBON) K PSBADA,PSBSOLA
 .I '$D(PSBUIDA(PSBUID)) F  D PSJ1^PSBVT(PSBDFN,PSBPONX) K PSBADA,PSBSOLA Q:$D(PSBUIDA(PSBUID))  Q:PSBPONX=""
 .F I=1:1 S PSBAD=$P(PSBUIDA(PSBUID),U,I) Q:PSBAD=""  I PSBAD["ADD" S PSBADA($P(PSBAD,";",2))=""
 .I $D(PSBADA) S X="" F I=1:1 S X=$O(PSBADA(X)) Q:X=""  S PSBFDA(53.686,I_","_PSBIENS,.01)=X,^PSB(53.68,+PSBIENS,.6,I,0)=0 ;p132
 .F I=1:1 S PSBSOL=$P(PSBUIDA(PSBUID),U,I) Q:PSBSOL=""  I PSBSOL["SOL" S PSBSOLA($P(PSBSOL,";",2))=""
 .I $D(PSBSOLA) S X="" F I=1:1 S X=$O(PSBSOLA(X)) Q:X=""  S PSBFDA(53.687,I_","_PSBIENS,.01)=X,^PSB(53.68,+PSBIENS,.7,I,0)=0 ;p132
 I $G(PSBUID)="",$G(PSBDRUG)="" D
 .D PSJ1^PSBVT(PSBDFN,PSBON)
 .I $D(PSBADA) S X="" F I=1:1 S X=$O(PSBADA(X)) Q:X=""  S PSBFDA(53.686,I_","_PSBIENS,.01)=$P(PSBADA(X),U,2),^PSB(53.68,+PSBIENS,.6,I,0)=0 ;p132
 .I $D(PSBSOLA) S X="" F I=1:1 S X=$O(PSBSOLA(X)) Q:X=""  S PSBFDA(53.687,I_","_PSBIENS,.01)=$P(PSBSOLA(X),U,2),^PSB(53.68,+PSBIENS,.7,I,0)=0 ;p132
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
 N PSBWRD,PSBMG,PSBPRT,CLIEN
 S PSBWRD=$P(^PSB(53.68,DA,.1),U,2)
 S PSBWRD=+$G(^DIC(42,+PSBWRD,44))
 I PSBCLIN]"" S CLIEN=+$O(^PS(53.46,"B",PSBCLNIEN,""))
 ;
 ; Get Mail Group
 ;
 S PSBMG=$$GET^XPAR(PSBWRD_";SC(","PSB MG MISSING DOSE",,"E")
 S:PSBMG="" PSBMG=$$GET^XPAR("DIV","PSB MG MISSING DOSE",,"E")
 S $P(^PSB(53.68,DA,0),U,5)=PSBMG ; Add MG to notification
 ;
 ; Get Printer - If NO printer can be found, then DO NOT print!!
 ;*70 - get CO printer if Clinic orders, else IM med & get IM printer
 ; IM printer uses Variable PSB PRINTER MISSING DOSE
 ; CO printer can come from 3 sources:
 ;  1st from Clinic Defintion file for the specific Clinic if defined
 ;  2nd from the Variable PSB PRINTER CO MISSING DOSE if defined
 ;  3rd just use the IM med printer Variable.
 ;
 D:PSBCLIN]""                                             ;*70
 .S PSBPRT=$$GET1^DIQ(53.46,CLIEN,4)
 .S:PSBPRT="" PSBPRT=$$GET^XPAR("DIV","PSB PRINTER CO MISSING DOSE",,"E")
 .S:PSBPRT="" PSBPRT=$$GET^XPAR("DIV","PSB PRINTER MISSING DOSE",,"E")
 D:PSBCLIN=""                                             ;*70
 .S PSBPRT=$$GET^XPAR(PSBWRD_";SC(","PSB PRINTER MISSING DOSE",,"E")
 .S:PSBPRT="" PSBPRT=$$GET^XPAR("DIV","PSB PRINTER MISSING DOSE",,"E")
 ;
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
 N PSBFLD,PSBRET,DDIEN
 Q:'$D(^PSB(53.68,PSBMD,0))
 L +^PSB(53.68,PSBMD):$S($G(DILOCKTM)>0:DILOCKTM,1:3) ; PSB*3*23
 S PSBCFLD=$P(^PSB(53.68,PSBMD,.1),U,3)
 L -^PSB(53.68,PSBMD) ; PSB*3*23
 D:'$G(PSBMM)  ; It is not a mail message
 .W !,$TR($J("",75)," ","=")
 .W !,"Report:       MISSING DOSE REQUEST"
 .W !,"Date Created: " D NOW^%DTC S Y=% D D^DIQ W Y
 .W !,$TR($J("",75)," ","="),!
 ;I $G(PSBCFLD)'="" F PSBFLD=.01,.02,.03,.04,.05,.06,.11,.12,.18,1,.13,.14,.19,.15,.16,.17 D OUT  ;*70
 ;I $G(PSBCFLD)="" F PSBFLD=.01,.02,.03,.04,.05,.06,.11,.12,.18,1,.25,.15,.19,.16,.17 D OUT  ;*70
 ;I $D(^PSB(53.68,PSBMD,.6)) S X=0 F  S X=$O(^PSB(53.68,PSBMD,.6,X)) Q:'X  W !?3,"ADDITIVE:  ",$$GET1^DIQ(52.6,+^PSB(53.68,PSBMD,.6,X,0),.01)
 ;I $D(^PSB(53.68,PSBMD,.7)) S X=0 F  S X=$O(^PSB(53.68,PSBMD,.7,X)) Q:'X  W !?3,"SOLUTION:  ",$$GET1^DIQ(52.7,+^PSB(53.68,PSBMD,.7,X,0),.01)
 I $G(PSBCFLD)'="" D   ;*106 - added HAZ notifications for dispensed drugs
 . F PSBFLD=.01,.02,.03,.04,.05,.06,.11,.12,.18,1,.13 D OUT
 . S DDIEN=$$GET1^DIQ(53.68,PSBMD,.13,"I") D HAZOUT(DDIEN,31)
 . F PSBFLD=.14,.19,.15,.16,.17 D OUT  ;*70
 I $G(PSBCFLD)="" F PSBFLD=.01,.02,.03,.04,.05,.06,.11,.12,.18,1,.25,.15,.19,.16,.17 D OUT  ;*70
 I $D(^PSB(53.68,PSBMD,.6)) S X=0 D   ;*106 - added HAZ notifications for additives
 . F  S X=$O(^PSB(53.68,PSBMD,.6,X)) Q:'X  W !?3,"ADDITIVE:  ",$$GET1^DIQ(52.6,+^PSB(53.68,PSBMD,.6,X,0),.01) D
 . . S DDIEN=$$GET1^DIQ(52.6,+^PSB(53.68,PSBMD,.6,X,0),1,"I") D HAZOUT(DDIEN,14)
 I $D(^PSB(53.68,PSBMD,.7)) S X=0 D   ;*106 - added HAZ notifications for solutions
 . F  S X=$O(^PSB(53.68,PSBMD,.7,X)) Q:'X  W !?3,"SOLUTION:  ",$$GET1^DIQ(52.7,+^PSB(53.68,PSBMD,.7,X,0),.01) D
 . . S DDIEN=$$GET1^DIQ(52.7,+^PSB(53.68,PSBMD,.7,X,0),1,"I") D HAZOUT(DDIEN,14)
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
HAZOUT(P50,POS) ; Write warnings for drugs, additives and solutions that are Hazardous to Handle or Dispose *106
 N PSBHAZ
 S PSBHAZ=$$HAZ^PSSUTIL(P50)
 I $P(PSBHAZ,U)!$P(PSBHAZ,U,2) W !?POS W:$P(PSBHAZ,U) "<<HAZ Handle>> " W:$P(PSBHAZ,U,2) "<<HAZ Dispose>>"
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
CHK1 ; Start PSB*3*100 changes: use 'DIVAS' cross ref for multidivision sites
 ; DUZ(2), the user's division, is set at sign-on. At multidivision sites where a user has access
 ; to multiple divisions, allow selection of a division from the divisions defined in file #40.8.
 ; The user must have at least one division from file #40.8 in his file #200 record.
 K ^TMP("PSBMD",$J)
 N DIR
 W !
 S DIR(0)="SB^A:All Divisions;O:One Division"
 S DIR("?")="Select either All Divisions or One Division."
 S DIR("A")="Do you want (A)ll Divisions or just (O)ne Division"
 S DIR("B")="O"
 D ^DIR K DIR I $D(DUOUT)!$D(DTOUT)!$D(DIROUT)!$D(DIRUT) Q
 I Y="" Q
 I Y(0)="One Division" D ONE Q   ; regardless user divisions in file #200
 I Y(0)="All Divisions" D ALL Q
 Q
 ;
ALL ; user gets all divisions (current behavior); applicable to single division sites as well
 S Y(0)="All Divisions"
 S PSBDIV=DUZ(2)
 S PSBSTIEN=+$O(^DG(40.8,"AD",DUZ(2),"")) ; current IEN for station
 S Y=$$GET1^DIQ(40.8,PSBSTIEN,.01,"E")
 I '$D(Y) S Y=DUZ(2)
 S PSBNAME=$$NAME^XUAF4(DUZ(2))
 S PSBMUDV=0
 S ^TMP("PSBMD",$J)=PSBMUDV_U_PSBDIV_U_PSBNAME
 Q
 ;
ONE ; when user selects one division from many in file #200, look at file #40.8 for a match if available
 W !
 S PSBSTIEN=+$O(^DG(40.8,"AD",DUZ(2),"")) ; current IEN for station
 S PSBDVNM=$$GET1^DIQ(40.8,PSBSTIEN,.01,"I") ;division name
 S DIC("B")=PSBDVNM
 S DIC("A")="Select Division: ",DIC="^DG(40.8,",DIC(0)="AEMQ",DIC("S")="I $$SITE^VASITE(,+Y)>0"
 D ^DIC
 ; capture the division name and number after user selection
 S PSBNAME=$$GET1^DIQ(40.8,+Y,.01,"E")
 S PSBDPTR=$$GET1^DIQ(40.8,+Y,.07,"I") ; pointer to file #4
 S PSBDIV=PSBDPTR
 S ^TMP("PSBMD",$J)=PSBMUDV_U_PSBDIV_U_PSBNAME
 Q
 ;end of changes for PSB*3*100
 ;
FLWUP ; Follow-Up on missing dose
 ; start PSB*3*100 changes
 N D0,DIC,PSBDATA,PSBDPTR,PSBDIV,PSBDVNM,PSBNAME,PSBMUDV,PSBSTIEN,X,Y
 S D0=1,PSBMUDV=$S($$GET1^DIQ(43,D0,11,"I")=1:1,1:0)
 I $P($G(^VA(200,DUZ,2,0)),U,4)=0 W !!,$C(7),"You have no valid divisions in the NEW PERSON file." S Y="^" Q
 I '$O(^DG(40.8,"AD",DUZ(2),"")) W !!,$C(7),"Your NEW PERSON file division was not found in the MEDICAL CENTER DIVISION file." S Y="^" Q
 I PSBMUDV=1 D CHK1
 I PSBMUDV=0 D ALL
 I Y=""!(Y<0)!(Y="^") Q
 S PSBDIV=$P($G(^TMP("PSBMD",$J)),U,2)
 S PSBNAME=$P($G(^TMP("PSBMD",$J)),U,3)
 ; end of changes for PSB*3*100
 N DIR,PSBIEN,PSBX,DA,DR,DDSFILE,PSBHDR,PSBDRUG,LOC            ;*70
 N PSBHAZ,DDIEN                                                ;*106
 S Y="" F  Q:Y="^"  D
 .K ^TMP("PSB",$J) S X=""
 .;start PSB*3*100 changes: user did not select one division and will see all the records (single station functionality)
 .I $G(PSBMUDV)=0 D
 ..F  S X=$O(^PSB(53.68,"AS",1,X),-1) Q:'X  S Y=$O(^TMP("PSB",$J,""),-1)+1,^TMP("PSB",$J,Y)=X,^TMP("PSB",$J,0)=Y
 .;
 .; user selected one division
 .I $G(PSBMUDV)=1 D
 ..F  S X=$O(^PSB(53.68,"DIVAS",1,PSBDIV,X),-1) Q:'X  S Y=$O(^TMP("PSB",$J,""),-1)+1,^TMP("PSB",$J,Y)=X,^TMP("PSB",$J,0)=Y
 .;
 .I '$O(^TMP("PSB",$J,0)) W !!,"No Unresolved Missing Dose Requests Found." S Y="^" Q
 .I $G(PSBMUDV)=0 S PSBHDR="Currently Unresolved Missing Dose Requests"
 .I $G(PSBMUDV)=1 S PSBHDR="Currently Unresolved Missing Dose Requests for: "_PSBNAME
 .;end of changes for PSB*3*100
 .W @IOF,PSBHDR,!,$TR($J("",IOM)," ","-")
 .F PSBX=0:0 S PSBX=$O(^TMP("PSB",$J,PSBX)) Q:'PSBX!(Y="^")  S PSBIEN=^(PSBX)_"," D
 ..W !,$J(PSBX,2),". ",$$GET1^DIQ(53.68,PSBIEN,.01)
 ..W ?25,$$GET1^DIQ(53.68,PSBIEN,.11)
 ..; get correct location                                     ;*70
 ..S LOC=$S($$GET1^DIQ(53.68,PSBIEN,1)]"":$$GET1^DIQ(53.68,PSBIEN,1),1:$$GET1^DIQ(53.68,PSBIEN,.12))
 ..W ?57,LOC                                                  ;*70
 ..S PSBDRUG=$$GET1^DIQ(53.68,PSBIEN,.13),DDIEN=$$GET1^DIQ(53.68,PSBIEN,.13,"I")           ;*106
 ..I PSBDRUG]"" S PSBHAZ=$$HAZ^PSSUTIL(DDIEN) W !?5,PSBDRUG I $P(PSBHAZ,U)!$P(PSBHAZ,U,2) W !?5 W:$P(PSBHAZ,U) "<<HAZ Handle>> " W:$P(PSBHAZ,U,2) "<<HAZ Dispose>>"    ;*106
 ..I PSBDRUG="" D
 ...W !?5,"UNIQUE ID: ",$$GET1^DIQ(53.68,PSBIEN,.25)
 ...S X=0 F  S X=$O(^PSB(53.68,+PSBIEN,.6,X)) Q:'X  W !?10,"ADDITIVES:  ",$$GET1^DIQ(52.6,+^PSB(53.68,+PSBIEN,.6,X,0),.01)
 ...S X=0 F  S X=$O(^PSB(53.68,+PSBIEN,.7,X)) Q:'X  W !?10,"SOLUTIONS:  ",$$GET1^DIQ(52.7,+^PSB(53.68,+PSBIEN,.7,X,0),.01)
 ..S:$Y>(IOSL-5) Y=$$PAGE(PSBX)  ;use -5 so if Haz added line displayed, as 3rd line, then needs to not scroll line 1 HDR off screen in some cases     *106
 .S:Y'="^" Y=$$PAGE(PSBX)
 K ^TMP("PSB",$J),^TMP("PSBMD",$J) ; PSB*3*100
 Q
 ;
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
 .; start changes for PSB*3*100
 .I $G(PSBMUDV)=0,$D(^PSB(53.68,"AS",0,PSBCX)) K ^TMP("PSB",$J) S X="" F  S X=$O(^PSB(53.68,"AS",1,X),-1) Q:'X  S X1=$O(^TMP("PSB",$J,""),-1)+1,^TMP("PSB",$J,X1)=X,^TMP("PSB",$J,0)=X1
 .I $G(PSBMUDV)=1,$D(^PSB(53.68,"DIVAS",0,PSBDIV)) K ^TMP("PSB",$J) S X="" F  S X=$O(^PSB(53.68,"DIVAS",1,PSBDIV,X),-1) Q:'X  S X1=$O(^TMP("PSB",$J,""),-1)+1,^TMP("PSB",$J,X1)=X,^TMP("PSB",$J,0)=X1
 .; stop printing header twice (old bug) by checking PSBX before setting it to zero.
 .I PSBX>0 S PSBX=0 W @IOF,PSBHDR,!,$TR($J("",IOM)," ","-")
 ; end of changes for PSB*3*100
 ;
POST ;call from 'Patient' field of screenman form PSB MISSING DOSE REQUEST
 ; 
 N DFN
 S DFN=X D IN5^VADPT
 D PUT^DDSVAL(DIE,.DA,.12,$P(VAIP(5),U,2))  ; value of DIE is 53.68, BCMA MISSING DOSE REQUEST FILE called from ScreenMan
 D PUT^DDSVAL(DIE,.DA,.18,$P(VAIP(6),U,1),"","I")  ; value of DIE is 53.68, BCMA MISSING DOSE REQUEST FILE called from ScreenMan
 D REFRESH^DDSUTL
 Q
