PSBVDLTB ;BIRMINGHAM/EFC-BCMA VIRTUAL DUE LIST FUNCTIONS (CONT) ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**3,4,16**;Mar 2004
 ;
 ; Reference/IA
 ; EN^PSJBCMA/2828
 ; IN5^VADPT/10061
 ; DEM^VADPT/10061
 ; INP^VADPT/10061
 ; $$FMADD^XLFDT/10103
 ; $$GET^XPAR/2263
 ; 
 ;
RPC(RESULTS,DFN,PSBTAB,PSBDT) ;
 K RESULTS,^TMP("PSB",$J),^TMP("PSJ",$J)
 N PSBCNT
 S PSBTRFL=0
 S RESULTS=$NAME(^TMP("PSB",$J,PSBTAB))
 ;
 Q:$$DISCHRGD(DFN)
 ;
 S PSBNOW=+$G(PSBDT)
 I 'PSBNOW D NOW^%DTC S PSBNOW=+$E(%,1,10),PSBDT=$P(%,".",1)
 ; use fileman function to determine window
 S PSBWBEG=$$FMADD^XLFDT(PSBNOW,"",-12)
 S PSBWEND=$$FMADD^XLFDT(PSBNOW,"",12)
 ;
 ; Create variable for valid order start date/time against admin window
 S PSBWADM=$$GET^XPAR("DIV","PSB ADMIN BEFORE")
 D NOW^%DTC S PSBWADM=$$FMADD^XLFDT(%,"","",+PSBWADM)
 ;
 ; use last movement for API
 S VAIP("D")="LAST" D IN5^VADPT S PSBTRDT=+VAIP(3),PSBTRTYP=$P(VAIP(2),U,2),PSBMVTYP=$P(VAIP(4),U,2) K VAIP
 ;
 ;Get patient transfer notification timeframe to determine pop-up box
 S PSBPTTR=$$GET^XPAR("DIV","PSB PATIENT TRANSFER") I PSBPTTR="" S PSBPTTR=72
 D NOW^%DTC S PSBNTDT=$$FMADD^XLFDT(%,"",-PSBPTTR) I PSBNTDT'>PSBTRDT S PSBTRFL=1
 ;determine order type and load to table
 ;
 ; Setup the ^TMP("PSJ",$J global for use below 
 ; Passing PSBDT as 3rd parameter turns off the V.1.0 One-Time lookback
 D EN^PSJBCMA(DFN,PSBNOW,PSBDT)
 ;initialize tabs
 D TABINIT
 ;
 ;The following calls must be made in the order below since the ^TMP global is reused
 D EN^PSBVDLUD(DFN,PSBDT),EN^PSBVDLPB(DFN,PSBDT),EN^PSBVDLIV(DFN,PSBDT)
 S $P(PSBATAB,U,1)=$S($D(^TMP("PSB",$J,"UDTAB",2))>0:1,1:0)
 S $P(PSBATAB,U,2)=$S($D(^TMP("PSB",$J,"PBTAB",2))>0:1,1:0)
 S $P(PSBATAB,U,3)=$S($D(^TMP("PSB",$J,"IVTAB",2))>0:1,1:0)
 S:PSBTAB="UDTAB" PSBCNT=$O(^TMP("PSB",$J,"UDTAB",""),-1)
 S:PSBTAB="IVTAB" PSBCNT=$O(^TMP("PSB",$J,"IVTAB",""),-1)
 S:PSBTAB="PBTAB" PSBCNT=$O(^TMP("PSB",$J,"PBTAB",""),-1)
 I PSBTAB="NO TAB" D
 .S ^TMP("PSB",$J,PSBTAB,0)=1
 .S ^TMP("PSB",$J,PSBTAB,1)=PSBATAB
 E  D
 .I $G(PSBCNT)>0 S ^TMP("PSB",$J,PSBTAB,0)=PSBCNT
 .I $G(PSBCNT)>1 S ^TMP("PSB",$J,PSBTAB,1)=PSBATAB_U_$S(PSBTRFL:PSBTRTYP_U_PSBMVTYP,1:"")
 .I $G(PSBCNT)'>1 S ^TMP("PSB",$J,PSBTAB,1)=PSBATAB_U_^TMP("PSB",$J,PSBTAB,1)
 F X="UDTAB","PBTAB","IVTAB" I X'=PSBTAB K ^TMP("PSB",$J,X)
 D CLEAN^PSBVT K ^TMP("PSJ",$J),PSBATAB,PSBWADM,PSBWBEG,PSBWEND,PSBNOW,PSBTRDT,PSBPTTR,PSBTRFL,PSBNTDT,PSBTRTYP,PSBMVTYP
 Q
 ;
TABINIT ;
 F PSBX="UDTAB","PBTAB","IVTAB" D
 .K ^TMP("PSB",$J,PSBX)
 .S ^TMP("PSB",$J,PSBX,0)=1
 .S ^TMP("PSB",$J,PSBX,1)="-1^No Administration(s) due at this time." Q
 Q
 ;
DISCHRGD(DFN) ; Patient Discharged OR Deceased?
 ;
 S DISCHRGD=0
 D DEM^VADPT I VADM(6)]"" S DISCHRGD=1 K VADM D  Q DISCHRGD
 .F PSBX="UDTAB","PBTAB","IVTAB","NO TAB" D
 ..K ^TMP("PSB",$J,PSBX)
 ..S ^TMP("PSB",$J,PSBX,0)=1,^TMP("PSB",$J,PSBX,1)="0^0^0^-1^A ""DATE OF DEATH"" has been logged for this patient."
 D INP^VADPT I VAIN(1)']"" S DISCHRGD=1 K VAIN D  Q DISCHRGD
 .F PSBX="UDTAB","PBTAB","IVTAB","NO TAB" D
 ..K ^TMP("PSB",$J,PSBX)
 ..S ^TMP("PSB",$J,PSBX,0)=1,^TMP("PSB",$J,PSBX,1)="0^0^0^-1^The selected patient has been DISCHARGED."
 Q DISCHRGD
 ;
