YSCLDIS ;HINOI/RTW-DISCONTINUE CLOZAPINE PATIENT STATUS ; 11/27/18 5:24pm
 ;;5.01;MENTAL HEALTH;**122**;Dec 30, 1994;Build 112
 ; Reference to ^DPT supported by IA #10035
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to $$SITE^VASITE supported by IA #10112
 ; Reference to ^DIC supported by DBIA #2051
 ; Reference to ^DIE supported by DBIA #2053
 ; Reference to ^DIQ supported by DBIA #2056
 ; Reference to ^XLFDT supported by DBIA #10103
 ; Reference to ^XMD supported by DBIA #10070
 ; Reference to ^%DTC supported by DBIA #10000
 ;
 ;This routine will loop through ^PS(55,DFN,"ASAND" and check the last prescription
 ; enddate and/or the the Inpatient Order stop date. If the patient has not had an active
 ; prescription or Inpatent Clozapine Order in the last 56 days, the Active Treatment will STOP
 ; YSCLFLAG changes from 0 to 1 if criteria to avoid discontinue
 Q
START ;
 N YSLN,DFN,YSCLREGN,YSCLREGD,YSCLREGA,YSCLFLAG,YSARR
 S U="^" S:'$G(DT) DT=$P($$NOW^XLFDT,".") K ^XTMP("YSCLDIS",DT),^XTMP("YSCLDATA")
 D LIST^DIC(603.01,,1,"I",,,,,,,"YSARR")
 F YSLN=1:1 Q:'$D(YSARR("DILIST","ID",YSLN))  S DFN=YSARR("DILIST","ID",YSLN,1) D:DFN
 .S YSCLREGN=$$GET1^DIQ(55,DFN,53) Q:YSCLREGN=""
 .Q:$$GET1^DIQ(55,DFN,54,"I")="D"   ;Not checking those already discontinued
 .N YSCLDIS2,YSCLNEW,X,X1,X2
 .S YSCLREGD=$$GET1^DIQ(55,DFN,58,"I")
 .S X1=DT,X2=YSCLREGD D ^%DTC S YSCLREGA=X
 .I YSCLREGN?1U6N D:YSCLREGA>4  Q   ;temps greater than 4 days since registration
 ..S YSCLDIS2=3 D SET,DC,DMG^YSCLTST5
 .Q:YSCLREGA<28                     ;Not checking those registered 27 days or less
 .S ^XTMP("YSCLDATA",DT,DFN)=YSCLREGN_U_YSCLREGD,YSCLFLAG=0
 .S YSCLNEW=1                       ;Registration is new unless clozapine orders are found
 .D OPT Q:YSCLFLAG=1                ;Not checking further
 .D INP Q:YSCLFLAG=1
 .S YSCLDIS2=$S(YSCLNEW:1,1:2)
 .D SET,DC,DMG^YSCLTST5
 D:$D(^XTMP("YSCLDIS")) TR
 Q
OPT ; Outpatient orders
 N YSARRAY,YSCLOPT,YSCLRX,YSCLDRG,YSCLFLDT,YSCLSPDT,X,X1,X2,YSCLFLDA
 D LIST^DIC(55.03,","_DFN_",",,"I",,,,,,,"YSARRAY")
 S YSCLOPT="A" F  S YSCLOPT=$O(YSARRAY("DILIST",1,YSCLOPT),-1) Q:'YSCLOPT  D  Q:YSCLFLAG
 .S YSCLRX=YSARRAY("DILIST",1,YSCLOPT),YSCLDRG=$$GET1^DIQ(52,YSCLRX,6,"I") Q:'YSCLDRG
 .Q:'$L($$GET1^DIQ(50,YSCLDRG,17.5))  ;'$D(^PSDRUG("ACLOZ",+YSCLDRG))
 .S YSCLFLDT=$$GET1^DIQ(52,YSCLRX,22,"I") Q:YSCLFLDT<YSCLREGD   ;Fill Date before Registration
 .S YSCLNEW=0                                                   ;Not a new Registration
 .S YSCLSPDT=$$GET1^DIQ(52,YSCLRX,26,"I")
 .I YSCLSPDT'<DT S YSCLFLAG=1 Q                                 ;Not Expired yet
 .S X1=DT,X2=YSCLFLDT D ^%DTC S YSCLFLDA=X
 .I YSCLFLDA<56 S YSCLFLAG=1
 Q
INP ;Inpatient Orders
 N YSARRAY,YSARRAY1,YSCLIPT,YSLINE,YSCLDRG,YSCLORDT,YSCLSPDT,YSCLORDA,X,X1,X2
 D LIST^DIC(55.06,","_DFN_",",,"I",,,,,,,"YSARRAY")
 S YSCLIPT="A" F  S YSCLIPT=$O(YSARRAY("DILIST",1,YSCLIPT),-1) Q:'YSCLIPT  D  Q:YSCLFLAG
 .S YSLINE=YSARRAY("DILIST",2,YSCLIPT)
 .D LIST^DIC(55.07,","_YSLINE_","_DFN_",",,"I",,,,,,,"YSARRAY1")
 .S YSCLDRG=+$G(YSARRAY1("DILIST",1,1)) Q:'$G(YSCLDRG)
 .Q:$$GET1^DIQ(50,YSCLDRG,17.5)'="PSOCLO1"
 .S YSCLORDT=$$GET1^DIQ(55.06,YSLINE_","_DFN,27,"I") Q:YSCLORDT<YSCLREGD  ;Order date before Registration
 .S YSCLNEW=0                                                   ;Not a new Registration
 .S YSCLSPDT=$$GET1^DIQ(55.06,YSLINE_","_DFN,34,"I")
 .I YSCLSPDT'<DT S YSCLFLAG=1 Q                                 ;Not Stopped yet
 .S X1=DT,X2=YSCLORDT D ^%DTC S YSCLORDA=X
 .I YSCLORDA<56 S YSCLFLAG=1
 Q
 ;
SET ;XTMP BUILD USED FOR TESTING
 S ^XTMP("YSCLDIS",DT,DFN,0)=YSCLDIS2
 Q
DC ;
 N DIE,DR
 S DIE="^PS(55,",DA=DFN,DR="54///"_"D"_";56///1" D ^DIE
 Q
 ;
TR ;
 K ^TMP("YSCL",$J) X ^%ZOSF("UCI")
 D YSCLDRSN K XMY
 I $$GET1^DIQ(8989.3,1,501,"I") S XMY("G.CLOZAPINE ROLL-UP@AADOMAIN.EXT")=""
 E  S XMY("G.PSOCLOZ")=""
 D YSXMTEXT
 S XMDUZ="CLOZAPINE MONITOR",DT=$$NOW^XLFDT
 S ^TMP("YSCL",$J,1,0)="Clozapine Discontinued Patient(s) Data was transmitted, "_YSCLLN
 S ^(0)=^TMP("YSCL",$J,1,0)_" records were sent."
 S XMSUB=$P($$SITE^VASITE,U,2)_" Discontinued Status",^TMP("YSCL",$J,2,0)=" "
 S XMTEXT="^TMP(""YSCL"",$J," D ^XMD
 S $P(^YSCL(603.03,1,0),U,6)=DT
 K ^TMP("YSCL",$J)
 Q
 ;
YSXMTEXT ;CALLED BY YSCLTST3 /RTW Start: Added to build message of discontinued clozapine patients data for NCC
 S (YSCLLN,YSCLDATE)=0,YSCLCNT=2
 F  S YSCLDATE=$O(^XTMP("YSCLDIS",YSCLDATE)) Q:'YSCLDATE  D
 .S YSCLDFN=0 F  S YSCLDFN=$O(^XTMP("YSCLDIS",YSCLDATE,YSCLDFN)) Q:'YSCLDFN  D
 ..I $$GET1^DIQ(55,DFN,54,"I")'="D" Q                      ; quit if patient wasn't Discontinued
 ..S PSOLAST4=$E($$GET1^DIQ(2,YSCLDFN,.09),6,9),YSCLLN=YSCLLN+1
 ..S YSCLMESG=$$GET1^DIQ(2,YSCLDFN,.01)_" ("_PSOLAST4_")"
 ..S YSCLDIS2=$P(^XTMP("YSCLDIS",YSCLDATE,YSCLDFN,0),U)
 ..S MSG1=$S(YSCLDIS2=1:YSCLD1,YSCLDIS2=2:YSCLD2,1:YSCLD3)
 ..S MSG2=$S(YSCLDIS2=1:YSCLD11,YSCLDIS2=2:YSCLD22,1:YSCLD33)
 ..S MSG3=$S(YSCLDIS2=1:YSCLD111,YSCLDIS2=2:YSCLD222,1:YSCLD333)
 ..S ^TMP("YSCL",$J,$I(YSCLCNT),0)=YSCLMESG ;message from YSCLDRSN
 ..S ^TMP("YSCL",$J,$I(YSCLCNT),0)=MSG1
 ..S ^TMP("YSCL",$J,$I(YSCLCNT),0)=MSG2
 ..S ^TMP("YSCL",$J,$I(YSCLCNT),0)=MSG3
 ..S ^TMP("YSCL",$J,$I(YSCLCNT),0)="" ;blank line
 Q
YSCLDRSN ;CALLED BY YSCLTST3  discontinued reasons
 S YSCLD1="The patient status has changed to 'Discontinued' because the new clozapine"
 S YSCLD11="patient has not filled the prescription/order within 28 days of being marked "
 S YSCLD111="'Active'. "
 S YSCLD2="The patient status has changed to 'Discontinued' because the active clozapine"
 S YSCLD22="patient has not filled the prescription/order within 56 days of being "
 S YSCLD222="prescribed/ordered."
 S YSCLD3="The patient status has changed to 'Discontinued' because the temporary local "
 S YSCLD33="authorization number assigned has expired and NCCC has not issued a new "
 S YSCLD333="authorization number. "
 Q
