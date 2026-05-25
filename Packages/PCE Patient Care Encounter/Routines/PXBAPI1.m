PXBAPI1 ;ISL/JVS,DEE - PCE's API - interview questions ;Aug 04, 2025@08:38:06
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**1,9,23,56,104,111,113,122,116,130,147,151,124,164,182,168,211,240,244**;Aug 12, 1996;Build 37
 ;;
 ; Reference to $$ELIG^DGCOMPACTELIG in ICR #7462
 ; Reference to ^DPT(D0,"S", in ICR #1301
 ; Reference to SC( 0;7 in ICR #1295
 ; Reference to DATE^SCDXUTL in ICR #1575
 ; Reference to ELAP^SDPCE in ICR #2026
 ;
 Q
 ;
PROCESS(PXBEXIT) ;
 N PXBREQ
 I WHAT="INTV" D
 . ;-- Interview is all of the questions
 . D ADQ(.PXBEXIT) I PXBEXIT<1 Q
1 . D PRV(.PXBEXIT) I PXBEXIT<1 Q
3 . D POV(.PXBEXIT) I PXBEXIT<1 Q
2 . D CPT(.PXBEXIT) I PXBEXIT<1 Q
 . I $P($G(^AUPNVSIT($G(PXBVST),150)),"^",3)="O" S PXBEXIT=0 Q
 . I '$$DISPOSIT^PXUTL1($G(PXBPAT),$P($G(^AUPNVSIT(PXBVST,0)),"^",1),$G(PXBVST)) D STP(.PXBEXIT) I PXBEXIT<1 Q
 E  I WHAT="ADDEDIT" D
 . D ADDEDIT
 E  I WHAT="ADQ" D
 . ;-- Administrative questions
 . D ADQ(.PXBEXIT)
 E  I WHAT="CODT" D
 . ;-- Check out Date/Time
 . D CODT(.PXBEXIT)
 . Q:PXBEXIT<1
 . D VISIT(.PXBEXIT)
 . I PXBVST'>0 S PXBEXIT=-2 Q
 E  I WHAT="SCC" D
 . ;-- Service connected conditions
 . S PXCECAT="VST" D SCC(.PXBEXIT) K PXCECAT
 . Q:PXBEXIT<1
 . D VISIT(.PXBEXIT)
 . I PXBVST'>0 S PXBEXIT=-2 Q
 E  I WHAT="PRV" D
 . ;-- Providers
 . D PRV(.PXBEXIT)
 E  I WHAT="CPT" D
 . ;-- Providers and CPT codes
 . D CPT(.PXBEXIT)
 E  I WHAT="POV" D
 . ;-- Diagnoses
 . D POV(.PXBEXIT)
 E  I WHAT="STP" D
 . ;-- Stop Codes
 . D STP(.PXBEXIT)
 E  S PXBEXIT=-3 W !,"Procedure ""INTV^PXAPI"" was called incorrectly, contact IRM."
 ;
 ;PX*1*240 Set VISIT pointer from checkout interview
 I $G(^TMP("PXCOMPACT",$J,"ASC"))=1 D VISIT^PXCOMPACT(PXBVST,"O",$$GETEOC^PXCOMPACT(PXBPAT),PXBPAT)
 K ^TMP("PXCOMPACT",$J,"ASC")
 Q
 ;
ADDEDIT ;
 N PXANS
ADDEDIT1 ;
 D ADQ(.PXBEXIT)
 G:PXBEXIT<1 ADDEDIT2
 D PRV(.PXBEXIT)
 G:PXBEXIT<1 ADDEDIT2
 D POV(.PXBEXIT)
 G:PXBEXIT<1 ADDEDIT2
 ;
 ;Call to CPT is not determined by a credit stop code any more
 ;
 D CPT(.PXBEXIT)
 G:PXBEXIT<1 ADDEDIT2
 I PXBVST>0,'$D(^AUPNVCPT("AD",PXBVST)) D ADDEDIT3   ;PX*1.0*182
 Q   ; PX*1.0*182 added quit, otherwise user is forced to delete enc.
 ;
ADDEDIT2 ;
 I PXBVST>0,'$D(^AUPNVCPT("AD",PXBVST)),'$D(^AUPNVSIT("AD",PXBVST)) D  I PXANS'=1 S PXBEXIT=1 G ADDEDIT1
 . N DIR,X,Y
 . W !!
 . S DIR(0)="Y"
 . S DIR("A",1)="Must have a STOP CODE or a PROCEDURE to complete this action."
 . S DIR("A")="Do you want to delete this encounter"
 . S DIR("B")="NO"
 . D ^DIR
 . S PXANS=Y
 . Q:PXANS'=1
 . I $$DELVFILE^PXAPIDEL("ALL",PXBVST,"","","","","")=1 S PXBEXIT=-1
 I PXBVST>0,'$D(^AUPNVSIT(PXBVST,0)) S PXBVST=""
 Q
 ;
ADDEDIT3 ;added PX*1.0*182
 N DIR,X,Y
 W !!
 S DIR(0)="Y"
 S DIR("A",1)="Must have a STOP CODE or a PROCEDURE to complete this action."
 S DIR("A")="Do you want to delete this encounter"
 S DIR("B")="NO"
 D ^DIR
 Q:Y'=1
 I $$DELVFILE^PXAPIDEL("ALL",PXBVST,"","","","","")=1 S PXBVST=""
 Q
 ;
ADQ(PXBEXIT) ;Ask the Administration questions
 I PXBVST'>0 D
 . ;This is only done for new visits
 . I PXBPAT'>0 S PXBPAT=$$ASKPAT I PXBPAT'>0 S PXBEXIT=-1 Q
 . I PXBHLOC'>0 S PXBHLOC=$$ASKHL I PXBHLOC'>0 S PXBEXIT=-1 Q
 . S PXBVSTDT=$S(PXBAPPT>0:PXBAPPT,1:$$ASKDT) I PXBVSTDT'>0 S PXBEXIT=-1 Q
 . I PXBAPPT'>0&PXBHLOC'=+$G(^DPT(PXBPAT,"S",PXBVSTDT,0)) D
 .. ;This is only done if there is no appointment.
 .. S PXELAP=$$ELAP^SDPCE(PXBPAT,PXBHLOC)
 I PXBEXIT'<1,PXBHLOC'>0 S PXBHLOC=$$ASKHL I PXBHLOC'>0 S PXBEXIT=-1 Q
 I PXBEXIT'<1 D CODT(.PXBEXIT)
 I PXBEXIT'<1,WHAT'="INTV" S PXCECAT="VST" D SCC(.PXBEXIT) K PXCECAT
 I PXBEXIT'<1 D
 . D VISIT(.PXBEXIT)
 . I PXBVST'>0 S PXBEXIT=-2 Q
 Q
 ;
ASKPAT() ;Ask user for a patient
 ;DIC on file 9000001
 N DIR,DIC,Y,X,DA
 S DIR(0)="P^9000001:AEMQ"
 S DIR("A")="Patient Name"
 D ^DIR
 Q $S(+Y>0:+Y,1:-1)
 ;
ASKHL() ;Ask user for a Hospital Location
ASKHL2 ;DIC on file 44
 N DIR,DIC,Y,X,DA,PXRES
 S DIR(0)="PA^44:AEMQ"
 S DIR("A")="Clinic: "
 ; not occasion of service and not dispositioning
 ;I PXALHLOC S DIR("S")="I '+$G(^(""OOS""))&'$O(^PX(815,1,""DHL"",""B"",Y,0))"
 ; not occasion of service only   ;PX*1.0*116
 I PXALHLOC S DIR("S")="I '+$G(^(""OOS""))"   ;PX*1.0*116
 ; only clinic that are not occasion of service and not dispositioning
 ;E  S DIR("S")="I $P(^(0),U,3)=""C""&'+$G(^(""OOS""))&'$O(^PX(815,1,""DHL"",""B"",Y,0))"
 E  S DIR("S")="I $P(^(0),U,3)=""C""&'+$G(^(""OOS""))"   ;PX*1.0*116
 D ^DIR
 ;enable to select a disposition clinic   ;PX*1.0*116
 ;I $D(^PX(815,1,"DHL","B",+Y)) D HELPDISP^PXCEVSIT W !,$C(7) G ASKHL2
 ; disallow selection of clinics with non conforming stop codes
 I +Y>0 S PXRES=$$CLNCK^SDUTL2(+Y,1) I 'PXRES D  G ASKHL2
 .W !,?5,"Clinic MUST be corrected before continuing."
 Q $S(+Y>0:+Y,1:-1)
 ;
ASKDT() ;Ask user for the encounter Date/Time
 N DIR,Y,X,DA
 S DIR(0)="D^"_$S(PXLIMDT>2960000:PXLIMDT,1:"")_":"_(DT+.24)_":AEPRSX"
 S DIR("A")="Encounter Date and Time"
 S DIR("?")="Enter the Date and Time of this encounter"
 D ^DIR
 Q $S(+Y>0:+Y,1:-1)
 ;
CODT(PXBEXIT) ;Ask the user the Check out Date/Time
 N DATA,PXCHKOUT
 D CHIKOUT^PXBAPI2("",PXBPAT,PXBHLOC,PXBVSTDT)
 S PXBCODT=PXCHKOUT
 S:PXCHKOUT=-1 PXBCODT=""
 ;; PX*1*113 - Change for EAS*1*3 Appointment processing removed
 ;S X="EASMTCHK" X ^%ZOSF("TEST") I $T D  Q:PXBEXIT<1
 ;. S:$G(EASACT)'="W" EASACT="C"
 ;. I $$MT^EASMTCHK(PXBPAT,"",EASACT,PXBVSTDT) D  S PXBEXIT=-1
 ;. . D PAUSE^VALM1
 I WHAT'["ADDEDIT",PXCHKOUT=-1 S PXBEXIT=-1
 I $G(PXBVST),$$DISPOSIT^PXUTL1(PXBPAT,$P($G(^AUPNVSIT(PXBVST,0)),"^",1),PXBVST) S PXBEXIT=1
 ;make call to determine patient eligibility
 N ELIG S ELIG=$$ELIG^DGCOMPACTELIG(PXBPAT,"PXBAPI1")
 W !!,"COMPACT Act Administrative Eligibility: ",ELIG
 I ELIG'="NOT ELIGIBLE" D
 . S DATA=$$DISPLAY^PXCOMPACT(PXBPAT)
 . I DATA'="" W !,$P(DATA,"^",1),": ",$P(DATA,"^",2),"   ",$P(DATA,"^",3),": ",$P(DATA,"^",4)
 . K ^TMP("PXCOMPACT",$J,"ASC")
 . ;prompt for Treatment Related To Acute Suicidal Crisis
 . I $$ASC^PXCOMPACT(PXBPAT)="N" Q
 . N DIR,Y,DIRUT
 . S DIR("A")="Was treatment for Acute Suicidal Crisis",DIR(0)="Y"
 . S DIR("?")="Enter YES if visit is related to an Acute Suicidal Crisis or NO if it is not."
 . W ! D ^DIR I $D(DIRUT) S Y=""
 . S ^TMP("PXCOMPACT",$J,"ASC")=$G(Y)
 ;
 Q
 ;
SCC(PXBEXIT) ;Ask the user the Service connected conditions
 N PXBDATA,PXBCLASS,PXBOUTEN,PXDOD
 S (PXBOUTEN,PXDOD)=""
 ;I $$APPOINT^PXUTL1(PXBPAT,PXBVSTDT,PXBHLOC) D
 ;. S PXBOUTEN=$P($G(^DPT(+PXBPAT,"S",+PXBVSTDT,0)),"^",20)
 ;E  I $$DISPOSIT^PXUTL1(PXBPAT,PXBVSTDT,PXBVST) D
 ;. S PXBOUTEN=+$P($G(^DPT(+PXBPAT,"DIS",9999999-PXBVSTDT,0)),"^",18)
 ;I 'PXBOUTEN,$G(PXBVST)>0 S PXBOUTEN=$O(^SCE("AVSIT",PXBVST,0))
 ;D CLASS^PXBAPI21(PXBOUTEN,PXBPAT,PXBVSTDT,PXBHLOC)
 D CLASS^PXBAPI21(PXBOUTEN,PXBPAT,PXBVSTDT,PXBHLOC,PXBVST)
 M PXB900=PXBDATA
 Q
 ;
VISIT(PXBEXIT) ;Create or edit the Visit
 ;Set up ^TMP("PXK",$J and call PXK
 K ^TMP("PXK",$J)
 N CODE,IDX,NODE,OLD800,OLD900,PIECE,PXBNODE,PXBAFTER,PXKERROR,SAS,TEMP
 F PXBNODE=0,21,150,800,811,812 D
 . S PXBAFTER(PXBNODE)=$S(PXBVST>0:$G(^AUPNVSIT(PXBVST,PXBNODE)),1:"")
 . S ^TMP("PXK",$J,"VST",1,PXBNODE,"BEFORE")=PXBAFTER(PXBNODE)
 I PXBVST>0 D
 .D GETSAFORVISITDET^PXSPECAUTH(.OLD900,.OLD800,PXBVST)
 .M ^TMP("PXK",$J,"VST",1,900,"BEFORE")=OLD900
 .I OLD800'="" S ^TMP("PXK",$J,"VST",1,800,"BEFORE")=OLD800
 I PXBVST'>0 D
 . S $P(PXBAFTER(0),"^",1)=PXBVSTDT
 . S $P(PXBAFTER(0),"^",5)=PXBPAT
 . S $P(PXBAFTER(0),"^",8)=$P(^SC(PXBHLOC,0),"^",7)
 . S:PXBAPPT>0 $P(PXBAFTER(0),"^",7)="A" ;PX*1*124
 . S $P(PXBAFTER(150),"^",3)="P"
 . S $P(PXBAFTER(812),"^",2)=PXBPKG
 . S $P(PXBAFTER(812),"^",3)=PXBSOURC
 S $P(PXBAFTER(0),"^",18)=$G(PXBCODT)
 S:$P(PXBAFTER(0),"^",22)="" $P(PXBAFTER(0),"^",22)=PXBHLOC
 M PXBAFTER(900)=PXB900
 I $D(PXELAP)#2 D
 . S $P(PXBAFTER(0),"^",21)=+PXELAP
 F PXBNODE=0,21,150,800,811,812 D
 . S ^TMP("PXK",$J,"VST",1,PXBNODE,"AFTER")=PXBAFTER(PXBNODE)
 M ^TMP("PXK",$J,"VST",1,900,"AFTER")=PXBAFTER(900)
 S IDX=0 F  S IDX=$O(PXBAFTER(900,IDX)) Q:IDX'>0  D
 .S NODE=PXBAFTER(900,IDX,0)
 .S CODE=$$GETCODE^PXSPECAUTH($P(NODE,U))
 .S SAS(CODE)=$P(NODE,U,2)
 I $D(SAS) S TEMP="" D SETOLD800^PXSPECAUTH(.TEMP,.SAS,0) I TEMP'="" S ^TMP("PXK",$J,"VST",1,800,"AFTER")=TEMP
 S ^TMP("PXK",$J,"VST",1,"IEN")=$S(PXBVST>0:PXBVST,1:"")
 S ^TMP("PXK",$J,"SOR")=PXBSOURC
 D EN1^PXKMAIN
 S PXBVST=$G(^TMP("PXK",$J,"VST",1,"IEN"))
 Q
 ;
CPT(PXBEXIT) ;Ask the user Providers and CTPs
 D CPT^PXBMCPT(PXBVST) K PRVDR
 Q
 ;
POV(PXBEXIT) ;Ask the user Diagnoses
 D POV^PXBMPOV(PXBVST) K PRVDR
 Q
 ;
PRV(PXBEXIT) ;Ask the user Providers
 D PRV^PXBMPRV(PXBVST,"PRV") K PRVDR
 Q
 ;
STP(PXBEXIT) ;Ask the user Stop Codes
 I $L($T(DATE^SCDXUTL)),$$DATE^SCDXUTL(+$G(^AUPNVSIT(PXBVST,0))) Q
 D STP^PXBMSTP(PXBVST) K PRVDR
 Q
