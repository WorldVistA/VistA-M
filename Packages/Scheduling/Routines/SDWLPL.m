SDWLPL ;IOFO BAY PINES/DMR,ESW - WAIT LIST PICK LIST ;JAN 15, 2016
 ;;5.3;scheduling;**327,394,417,446,538,627**;AUG 13, 1993;Build 249
 ;
 ;
 ;09/23/2006 Patch SD*5.3*417 Upper/Lower case usage.
 ;SD*5.3*446 - Included M - matched appointments
 ;
 I '$D(^SDWL(409.3,"B",DFN)) Q
 S NN=""
 W !,"This patient is currently on the Wait List."
 ;
ANS1 ;
 S DIR("B")="NO",DIR("A")="Do you want to display open Wait list entries? (Y or N): ",DIR(0)="Y^AO" D ^DIR
 K DIR
 Q:'Y
 ;
ANS2(DFN,ANS2) ;
 N STR S ANS2=" ",STR=",A,S,C,"
 F  Q:STR[ANS2!(ANS2="^")  D
TST .W !!,"Display Open Wait List entries selection:",!
 .S DIR(0)="S^A:ALL;C:Matching Appt CLINIC;S:matching Appt SPECIALTY",DIR("B")="A",DIR("A")="Select Entry or ""^"" to QUIT " D ^DIR S ANS2=Y
 .IF ANS2'="A"&(ANS2'="S")&(ANS2'="C")&(ANS2'="^") W !!,"PLEASE ENTER 'A' for All entries, 'C' for clinic or 'S' for current specialty/stop code or '^' to quit."
 K DIR
 Q:ANS2="^"
 D INIT(DFN,ANS2) I '$D(^TMP($J,"SDWLPL")) W !!,"No selected open EWL entry has been found!" Q
DISPLAY ;
 D LIST(ANS2,DFN)
 Q
 ;
INIT(DFN,ANS2,FLG) ;
 ; ANS2: A - ALL
 ;       S - All Specialties
 ;       C - All Clinics
 ;       M - Matches stop codes only
 ;  FLG: (optional)
 ;       NR - do not diplay entries with NON REMOVAL REASON - in check out
 S (INST,SCODE,CLINIC,DENTER,REQBY,DESIRD,SCPRI,IEN,SSN)="" K ^TMP("SDWLPL",$J),^TMP($J,"SDWLPL")
 F  S IEN=$O(^SDWL(409.3,"B",DFN,IEN)) Q:IEN=""  D
 .Q:$$GET1^DIQ(409.3,IEN_",",23,"I")="C"
 .;I $G(FLG)="NR" Q:$$GET1^DIQ(409.3,IEN_",",18,"I")'=""    ; include non-removed for 'NR flag
 .;Q:$$GET1^DIQ(409.3,IEN_",",18,"I")'=""    ;
 .Q:$D(^XTMP("SDECLKE-"_IEN))  ;do not display EWL if locked by VS GUI  ;alb/sat 627
 .S ^TMP("SDWLPL",$J,IEN)=$G(^SDWL(409.3,IEN,0)) S DENTER="",DENTER=$P($G(^TMP("SDWLPL",$J,IEN)),"^",2)
 .S (WLTYPE,TYPE,WLTN,NUM)="",TYPE=$P($G(^TMP("SDWLPL",$J,IEN)),"^",5)
 .IF DENTER'=""&(TYPE'="") D
 ..IF ANS2="A" D ARAY1
 ..IF ANS2="S" D ARAY2
 ..IF ANS2="C" D ARAY3
 ..IF ANS2="M" D ARAY4
 ;
 K ANS1,NN,INST,SCODE,CLINIC,DENTER,REQBY,DESIRD,SCPRI
 K CLINIC,WLTYPE,TYPE,WLTN,NUM,REC
 Q
 ;
ARAY1 ;
 IF TYPE=1 S WLTYPE="PCMM TEAM",NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",6),WLTNI=$$GET1^DIQ(404.51,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(404.51,NUM_",",.01)
 IF TYPE=2 S WLTYPE="PCMM POSITION",NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",7),WLTNI=$$GET1^DIQ(404.57,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(404.57,NUM_",",.01)
 IF TYPE=3 S WLTYPE="SERV/SPECIALTY",NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",8),WLTNI=$$GET1^DIQ(409.31,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(409.31,NUM_",",.01)
 IF TYPE=4 S WLTYPE="CLINIC",NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",9),WLTNI=$$GET1^DIQ(409.32,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(409.32,NUM_",",.01)
 D SAVE(TYPE,WLTNI,IEN)
 Q
 ;
ARAY2 ;
 IF TYPE=3 D
 .S SCODE=+$P($G(^TMP($J,"APPT",1)),U,13),NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",8),WLTNI=$$GET1^DIQ(409.31,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(409.31,NUM_",",.01)
 .;Q:SCODE'=WLTNI
 .S WLTYPE="SERV/SPECIAL"
 .D SAVE(TYPE,WLTNI,IEN)
 Q
 ;
ARAY3 ;
 IF TYPE=4 D
 .S CLINIC=+$P($G(^TMP($J,"APPT",1)),U,2),NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",9),WLTNI=$$GET1^DIQ(409.32,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(409.32,NUM_",",.01)
 .;Q:CLINIC'=WLTNI
 .S WLTYPE="CLINIC"
 .D SAVE(TYPE,WLTNI,IEN)
 Q
ARAY4 ;identify both clinic and specialties EWL matching by stop code with entered appointment
 S SCODE=+$P($G(^TMP($J,"APPT",1)),U,13)
 IF TYPE=3 D  Q
 .S NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",8),WLTNI=$$GET1^DIQ(409.31,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(409.31,NUM_",",.01)
 .Q:SCODE'=WLTNI
 .S WLTYPE="SERV/SPECIAL"
 .D SAVE(TYPE,WLTNI,IEN)
 IF TYPE=4 D
 .N SDCLSC
 .S NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",9),WLTNI=$$GET1^DIQ(409.32,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(409.32,NUM_",",.01)
 .S SDCLSC=$$GET1^DIQ(44,WLTNI_",",8,"I") ; STOP CODE
 .Q:SCODE'=SDCLSC
 .S WLTYPE="CLINIC"
 .D SAVE(TYPE,WLTNI,IEN)
 Q
 ;
SAVE(TYPE,WLTNI,IEN) ;
 S REQBY=$P($G(^TMP("SDWLPL",$J,IEN)),"^",12)
 S INST=$P($G(^TMP("SDWLPL",$J,IEN)),"^",3)
 N DESIRED S DESIRED=$P($G(^TMP("SDWLPL",$J,IEN)),"^",16)
 S SCPRI=$E($$GET1^DIQ(409.3,IEN_",",15)) ;SC priority
 N NAME,SSN S NAME=$$GET1^DIQ(2,DFN_",",.01),SSN=$$GET1^DIQ(2,DFN_",",.09)
 N SDBY S SDBY=$$GET1^DIQ(409.3,IEN_",",11),SDBY=$E(SDBY,1,3)
 N SDNR S SDNR=$$GET1^DIQ(409.3,IEN_",",18,"E") ; non removal reason
 S NN=$O(^TMP($J,"SDWLPL",""),-1)+1
 S ^TMP($J,"SDWLPL",NN)=IEN_U_WLTYPE_U_SCPRI_U_WLTN_U_INST_U_DENTER_U_SDBY_U_DESIRED
 ;
 N SPIEC S SPIEC=$S(TYPE=4:9,TYPE=3:10,TYPE=2:11,TYPE=1:12)
 S $P(^TMP($J,"SDWLPL",NN),U,SPIEC)=WLTNI
 S $P(^TMP($J,"SDWLPL",NN),U,13)=SDNR
 K ^TMP("SDWLPL",$J,IEN)
 Q
 ;
LIST(ANS2,DFN) ;
 W:$D(IOF) @IOF
 ;D APPTD^SDWLEVAL ;display appointment(s) again
 W !,"=========================================================================="
 N NAME,SSN S NAME=$$GET1^DIQ(2,DFN_",",.01),SSN=$$GET1^DIQ(2,DFN_",",.09)
 ;W !!,$S(ANS2="A":" All",ANS2="C":" All Clinics",ANS2="M":" Matched Entries:",ANS2="S":" All Specialties",1:" All")
 W !," Open EWL entries matching appointment specialty"
 W !,"------------------------------" I ANS2'="A" W "-----------"
 W !,"EW List Type   SC/P  Waiting for Institution  Orig Date   By  Des. Date Reopen"
 W !,"--------------------------------------------------------------------------------"
 S (REC,NUM)=""
 F  S NUM=$O(^TMP($J,"SDWLPL",NUM)) Q:NUM=""  S REC=^TMP($J,"SDWLPL",NUM) D
 .S IEN=+REC N SDP,SDR D
 ..S SDP=$E($$GET1^DIQ(409.3,IEN_",",10)) ;priority
 ..S SDR=$$GET1^DIQ(409.3,IEN_",",29,"I") ;reopen reason
 .N SDINS,SDIN S SDINS=$P(REC,"^",5) S SDIN=$$GET1^DIQ(4,SDINS_",",.01,"I")
 .W !,NUM_". ",$E($P(REC,"^",2),1,12),?16,$P(REC,"^",3)_"/"_SDP,?21,$E($P(REC,U,4),1,13),?35,SDIN,?47,$$FMTE^XLFDT($P(REC,"^",6),8),?59,$P(REC,"^",7),?63,$$FMTE^XLFDT($P(REC,"^",8),8),?77,SDR
 .N SDUP,SDLO
 .S SDUP="ABCDEFGHIJKLMNOPRSTUWQXYzv",SDLO="abcdefghijklmnoprstuwqxyzv"
 .N SMT S SMT=$$GET1^DIQ(409.3,IEN_",",25) I SMT'="" S SMT=$TR(SMT,SDUP,SDLO) W !?2,"Comment: ",SMT
 .N SMO S SMO=$$GET1^DIQ(409.3,IEN_",",30) I SMO'="" S SMO=$TR(SMO,SDUP,SDLO) W !?2,"Reopen: ",SMO
 .I $P(REC,U,13)'="" W !?2,"Non-Removal Reason: ",$P(REC,U,13)
 Q
