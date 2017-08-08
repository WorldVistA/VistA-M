PSBVDLTB ;BIRMINGHAM/EFC-BCMA VIRTUAL DUE LIST FUNCTIONS (CONT) ;03/06/16 3:06pm
 ;;3.0;BAR CODE MED ADMIN;**3,4,16,68,70,78,83,92**;Mar 2004;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference/IA
 ; EN^PSJBCMA/2828
 ; IN5^VADPT/10061
 ; DEM^VADPT/10061
 ; INP^VADPT/10061
 ; $$FMADD^XLFDT/10103
 ; $$GET^XPAR/2263
 ; 
 ;*68 - add new parameter to use new SI/OPI word processing fields
 ;*70 - add Clinic order request IN param flag (true/false 0/1).
 ;      also add to return array(1) 6th, 7th piece = IM & CO ord count
 ;      also add to return array order line 32 piece, Clinic name for 
 ;      CO orders.
 ;*83 - cleanup variables here instead of in each tab rtn
 ;
 ; ** Warning: PSBSIOPI & PSBCLINORD will be used as global variables
 ;             for all down stream calls from this RPC tag.
 ;
RPC(RESULTS,DFN,PSBTAB,PSBDT,PSBSIOPI,PSBCLINORD,PSBSRCHDIR) ;
 N PSBCNT,PSBORDCNT,PSBPATCH,PSBINFUS,PSBIVSTP,PSBA               ;*70
 N PSBNOW                                                         ;*83
 K RESULTS,^TMP("PSB",$J),^TMP("PSJ",$J)
 S PSBSIOPI=+$G(PSBSIOPI)   ;*68 init to 0 if not present or 1 if sent
 S PSBCLINORD=+$G(PSBCLINORD)                   ;*70 set to 0 if NULL
 S PSBSRCHDIR=$$UP^XLFSTR($G(PSBSRCHDIR))       ;*70 set to NULL/upper
 S PSBTRFL=0
 S RESULTS=$NAME(^TMP("PSB",$J,PSBTAB))
 ;
 Q:$$DECEASED(DFN)
 ;
 ;Set date & time window varaibles
 ;
 S PSBNOW=+$G(PSBDT)
 I 'PSBNOW D NOW^%DTC S PSBNOW=+$E(%,1,10)
 S PSBDT=$P(PSBNOW,".",1)
 ;
 ;check if fast search requested and valid direction passed, then
 ; get the next date tha order data exists and Not Given
 I PSBCLINORD,(PSBSRCHDIR="B")!(PSBSRCHDIR="F") D
 . N PSBSRCHDT,SRCHDIR
 . S SRCHDIR=$S(PSBSRCHDIR="B":-1,1:1)
 . S PSBSRCHDT=$$FINDORD^PSBVDLU1(SRCHDIR,DFN,PSBDT,PSBTAB)
 . S:PSBSRCHDT'=-1 (PSBNOW,PSBDT)=PSBSRCHDT
 ;
 ;*70 - if CO, set window of time to the entire day
 I PSBCLINORD D
 .S PSBWBEG=$P(PSBDT,".")_".0000"
 .S PSBWEND=$P(PSBDT,".")_".2400"
 E  D
 .S PSBWBEG=$$FMADD^XLFDT(PSBNOW,"",-12)
 .S PSBWEND=$$FMADD^XLFDT(PSBNOW,"",12)
 ;
 ;Create variable for valid order start date/time against admin window
 S PSBWADM=$$GET^XPAR("DIV","PSB ADMIN BEFORE")
 S:PSBCLINORD PSBWADM=99999
 D NOW^%DTC S PSBWADM=$$FMADD^XLFDT(%,"","",+PSBWADM) ; correction for start date issue, PSB*3*78
 ;
 ;Use last movement for API
 S VAIP("D")="LAST" D IN5^VADPT S PSBTRDT=+VAIP(3),PSBTRTYP=$P(VAIP(2),U,2),PSBMVTYP=$P(VAIP(4),U,2) K VAIP
 ;
 ;Get patient transfer notification timeframe to determine pop-up box
 S PSBPTTR=$$GET^XPAR("DIV","PSB PATIENT TRANSFER") I PSBPTTR="" S PSBPTTR=72
 D NOW^%DTC S PSBNTDT=$$FMADD^XLFDT(%,"",-PSBPTTR) I PSBNTDT'>PSBTRDT S PSBTRFL=1
 ;
 ;Passing PSBDT as 3rd parameter turns off the V.1.0 One-Time lookback
 ;*70 check if IM or CO orders exists for mode lights
 S PSBORDCNT=$$MODELITE^PSBVDLU1                ;mode lights
 S PSBPATCH=$$PATCHON^PSBVDLU1(DFN,.PSBA)       ;patch on light
 S:PSBA("I") $P(PSBORDCNT,U)=1 S:PSBA("C") $P(PSBORDCNT,U,2)=1
 S PSBIVSTP=$$STOPPED^PSBVDLU1(DFN,.PSBA)       ;IV stopped light
 S:PSBA("I") $P(PSBORDCNT,U)=1 S:PSBA("C") $P(PSBORDCNT,U,2)=1
 S PSBINFUS=$$INFUSING^PSBVDLU1(DFN,.PSBA)      ;IV infusing light
 S:PSBA("I") $P(PSBORDCNT,U)=1 S:PSBA("C") $P(PSBORDCNT,U,2)=1
 ;
 ; Setup the ^TMP("PSJ",$J global for use below 
 K ^TMP("PSJ",$J)
 D EN^PSJBCMA(DFN,PSBNOW,PSBDT)
 D:PSBCLINORD INCLUDCO^PSBVDLU1
 D:'PSBCLINORD REMOVECO^PSBVDLU1
 ;
 ;initialize tabs
 D TABINIT
 ;
 ;The following calls must be made in the order below since the ^TMP global is reused
 D EN^PSBVDLUD(DFN,PSBDT)
 D EN^PSBVDLPB(DFN,PSBDT)
 D EN^PSBVDLIV(DFN,PSBDT)
 ; adding a special check for lighting the Unit Dose Tab light.
 ; Patches sent to GUI via this API will send both IM and CO patches
 ; that are expired/dc'd and are still on the patient. So there is a
 ; a scenario when a unit dose patch can be on TMP global and it is
 ; the only order in TMP but was for a different mode than currently
 ; viewing.  In this case CNT will = 0 and use it to turn on the light
 N CNT,QQ,NODE S CNT=0
 I $D(^TMP("PSB",$J,"UDTAB",2))>0 D           ;unit dose tab check *70
 . F QQ=2:1  Q:'$D(^TMP("PSB",$J,"UDTAB",QQ))  D  Q:CNT
 .. S NODE=^TMP("PSB",$J,"UDTAB",QQ)
 .. I $L(NODE,U)>27,$P(NODE,U,2)?.N1A D
 ... ;  first order found Activ per correct mode, then quit with cnt=1
 ... I PSBCLINORD,$P(NODE,U,33),($P(NODE,U,22)="A"!($P(NODE,U,22)="H")!($P(NODE,U,22)="R")) S CNT=1 Q
 ... I 'PSBCLINORD,'$P(NODE,U,33),($P(NODE,U,22)="A"!($P(NODE,U,22)="H")!($P(NODE,U,22)="R")) S CNT=1 Q
 ... Q:'$P(NODE,U,28)  ;not a given patch
 ... I PSBCLINORD,$P($P(NODE,U,26),".")'>DT,'$P(NODE,U,33) Q
 ... I 'PSBCLINORD,$P($P(NODE,U,26),".")'>DT,$P(NODE,U,33) Q
 ... S CNT=1
 S $P(PSBATAB,U,1)=$S(CNT:1,1:0)            ;*70 use CNT for UD light
 S $P(PSBATAB,U,2)=$S($D(^TMP("PSB",$J,"PBTAB",2))>0:1,1:0)
 S $P(PSBATAB,U,3)=$S($D(^TMP("PSB",$J,"IVTAB",2))>0:1,1:0)
 S:PSBTAB="UDTAB" PSBCNT=$O(^TMP("PSB",$J,"UDTAB",""),-1)
 S:PSBTAB="IVTAB" PSBCNT=$O(^TMP("PSB",$J,"IVTAB",""),-1)
 S:PSBTAB="PBTAB" PSBCNT=$O(^TMP("PSB",$J,"PBTAB",""),-1)
 ;
 I PSBTAB="NO TAB" D
 .S ^TMP("PSB",$J,PSBTAB,0)=1
 .S ^TMP("PSB",$J,PSBTAB,1)=PSBATAB
 .S $P(^TMP("PSB",$J,PSBTAB,1),U,5,6)=PSBORDCNT  ;*70 Cvsht offset cnt
 .S $P(^TMP("PSB",$J,PSBTAB,1),U,7)=PSBINFUS     ;*70 IV infuse light
 .S $P(^TMP("PSB",$J,PSBTAB,1),U,8)=PSBIVSTP     ;*70 IV stop light
 .S $P(^TMP("PSB",$J,PSBTAB,1),U,9)=PSBPATCH     ;*70 patch light
 E  D
 .I $G(PSBCNT)>0 S ^TMP("PSB",$J,PSBTAB,0)=PSBCNT
 .I $G(PSBCNT)>1 S ^TMP("PSB",$J,PSBTAB,1)=PSBATAB_U_$S(PSBTRFL:PSBTRTYP_U_PSBMVTYP,1:"")
 .I $G(PSBCNT)'>1 S ^TMP("PSB",$J,PSBTAB,1)=PSBATAB
 .S $P(^TMP("PSB",$J,PSBTAB,1),U,6,7)=PSBORDCNT   ;*70 Tabs Ord cnt
 .S $P(^TMP("PSB",$J,PSBTAB,1),U,8)=PSBINFUS      ;*70 IV infuse light
 .S $P(^TMP("PSB",$J,PSBTAB,1),U,9)=PSBIVSTP      ;*70 IV stop light
 .S $P(^TMP("PSB",$J,PSBTAB,1),U,10)=PSBPATCH     ;*70 patch light
 ;
 F X="UDTAB","PBTAB","IVTAB" I X'=PSBTAB K ^TMP("PSB",$J,X)
 D CLEAN^PSBVT
 K ^TMP("PSJ",$J),PSBATAB,PSBWADM,PSBWBEG,PSBWEND,PSBNOW,PSBTRDT,PSBPTTR,PSBTRFL,PSBNTDT,PSBTRTYP,PSBMVTYP  ;*83
 Q
 ;
TABINIT ;
 F PSBX="UDTAB","PBTAB","IVTAB" D
 .K ^TMP("PSB",$J,PSBX)
 .S ^TMP("PSB",$J,PSBX,0)=1
 .S ^TMP("PSB",$J,PSBX,1)="-1^No Administration(s) due at this time." Q
 ;
DECEASED(DFN) ; Patient Deceased?
 ;
 S DECEASED=0
 D DEM^VADPT I VADM(6)]"" S DECEASED=1 K VADM D  Q DECEASED
 .F PSBX="UDTAB","PBTAB","IVTAB","NO TAB" D
 ..K ^TMP("PSB",$J,PSBX)
 ..S ^TMP("PSB",$J,PSBX,0)=1,^TMP("PSB",$J,PSBX,1)="0^0^0^-1^A ""DATE OF DEATH"" has been logged for this patient."
 Q DECEASED
