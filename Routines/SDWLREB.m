SDWLREB ;BP/ESW - EWL matched with Canceled and Rebooked Appointment by Clinic ; 11/16/05 1:16pm  ; Compiled October 25, 2006 17:29:46
 ;;5.3;Scheduling;**467,491**;Aug 13, 1993;Build 53
 ;
 ;SD*5.3*467 - Match canceled appointments in EWL entries 
 ;
 Q
REBOOK(DFN,SD,SC,RBFLG,SDTRB,SDCAN) ; rebook section
 ;create appt TMP to check for rebooking
 ;SD - appt date/time
 ;SC - Hospital Location IEN
 ;called by reference:
 ;       RBFLG - cancellation status from Appointment Multiple
 ;                       Only if RBFLG="CCR" - canceled by clinic, rebooked
 ;       SDTRB - asked for scheduled Date/Time of Rebooked Appointment
 ;       SDCAN - asked for cancellation date/time 
 N SDARR,SCNT
 S RBFLG=0,SDTRB="",SDCAN="NONE" ;initiate if not 'good' appointment
 S SDARR(1)=SD_";"_SD
 S SDARR(2)=SC
 S SDARR(4)=DFN
 S SDARR("FLDS")="1;2;3;24;25"
 N SAPP S SAPP=$$SDAPI^SDAMA301(.SDARR) D
 .N SDINST,SDFAC,SDINSTE
 .Q:'$D(^TMP($J,"SDAMA301",DFN))
 .N SDSTR S SDSTR=^TMP($J,"SDAMA301",DFN,SC,SD)
 .N SDSTAT S SDSTAT=$P(SDSTR,U,3)
 .K ^TMP($J,"SDAMA301",DFN,SC,SD)
 .S RBFLG=$P(SDSTAT,";")
 .S SDTRB=$P(SDSTR,U,24)
 .S SDCAN=$P(SDSTR,U,25)
 Q
DISREB(DFN,SDTRB,SC) ;DISPOSITION REBOOK OR NOT
 ; DFN - IEN of file #2 (Patient)
 ; SDTRB - Scheduled Date/Time of Rebooked Appt
 ; SC - Clinic IEN
 ; Temporary ^TMP($J,"APPT" will be created with rebooked appt data
 N SDARR,SCNT,SDDIV
 S SDDIV=""
 S SDARR(1)=SDTRB_";"_SDTRB
 S SDARR(2)=SC
 S SDARR(4)=DFN
 S SDARR("FLDS")="1;2;3;4;10;13;14"
 N SAPP S SAPP=$$SDAPI^SDAMA301(.SDARR) D
 .N SDINST,SDFAC,SDINSTE
 .Q:'$D(^TMP($J,"SDAMA301",DFN))
 .K ^TMP($J,"APPT") S SCNT=1
 .S ^TMP($J,"APPT",SCNT)=^TMP($J,"SDAMA301",DFN,SC,SDTRB)
 .N SFAC S SFAC=$$CLIN^SDWLPE(SC) D  ;SD/491
 ..S SDINST=+SFAC,SDINSTE=$P(SFAC,U,3),SDFAC=$P(SFAC,U,2)
 .S $P(^TMP($J,"APPT",SCNT),"^",15)=SDINST_";"_SDINSTE
 .S $P(^TMP($J,"APPT",SCNT),"^",16)=SDFAC
 .K ^TMP($J,"SDAMA301",DFN,SC,SDTRB)
 Q
OPENEWL(DFN,SDT,SC,SDREB,CEWL) ; SD*5.3*467 Open EWL entry if closed with appointment being canceled
 ;SDT - appointment date/time
 ;SC  - appointment clinic IEN
 ;SDREB - REBOOKING FLAG: 1 - cancel & rebook
 ;                        0 - cancel only
 ;CEWL - counter, optionally passed by reference with initial value=0 
 N DH,IEN,STATUS,CLINIC,WLAPPT,WLSTAT,SDNAM,SDAPPT,SSN,SCN
 K ^TMP("SDWLPL",$J),^TMP($J,"SDWLPL")
 I '$D(CEWL) D
 .I $D(^TMP("SDWLREB",$J)) S CEWL=$O(^TMP("SDWLREB",$J,""),-1)
 .E  S CEWL=0
 S IEN="" F  S IEN=$O(^SDWL(409.3,"B",DFN,IEN)) Q:IEN<1  D
 .S STATUS="" S STATUS=$$GET1^DIQ(409.3,IEN_",",23,"I") IF STATUS="C" D
 ..IF $G(^SDWL(409.3,IEN,"SDAPT")) D
 ...S CLINIC=$$GET1^DIQ(409.3,IEN_",",13.2,"I"),WLAPPT=$$GET1^DIQ(409.3,IEN_",",13,"I")
 ...IF CLINIC=SC&(WLAPPT=SDT) S WLSTAT=$$GET1^DIQ(409.3,IEN_",",21,"I") I WLSTAT="SA" D
 ....N Y S Y=WLAPPT D DD^%DT S SDAPPT=Y
 ....S SCN=$$GET1^DIQ(44,SC_",",.01),SCN=$E(SCN,1,20)
 ....S SDNAM=$$GET1^DIQ(2,DFN_",",.01,"I"),SDNAM=$E(SDNAM,1,25),SSN=$$GET1^DIQ(2,DFN_",",.09,"I")
 ....S SDFORM=$$FORM^SDFORM(SDNAM,23,SSN,12,SCN,24,SDAPPT,20)
 ....S CEWL=CEWL+1 S ^TMP("SDWLREB",$J,CEWL)=SDFORM
 ....N DIE,DA,DR
 ....S DIE="^SDWL(409.3,",DA=IEN,DR="23////^S X=""O""" D ^DIE
 ....S DR="13.8////^S X=""CC""" D ^DIE
 ....S DR="29////^S X=""CA""" D ^DIE
 ....S DR="19///@" D ^DIE
 ....S DR="20///@" D ^DIE
 ....S DR="21///@" D ^DIE
 ....S DR="13///@;13.1////@;13.2///@;13.3///@;13.4///@;13.5///@;13.6///@;13.8///@;13.7///@" D ^DIE
 ....I $D(^TMP("SDWLREB",$J)) I SDREB D ASKDISP(IEN)
 I '$D(^TMP($J,"SDWLPL")) Q  ; no closed EWL related entry
 I SDREB D DISP
 Q
MESS ; SD*5.3*467 - send message with a list of opened EWL entries because of canceled appointments
 S ^TMP("SDWLREB",$J,.01)="This message displays patients that had their EWL entry opened because of "
 S ^TMP("SDWLREB",$J,.02)="their matching appointment being now 'CANCELED BY CLINIC'. Some of those "
 S ^TMP("SDWLREB",$J,.03)="entries may be already closed again if new appointments were scheduled and "
 S ^TMP("SDWLREB",$J,.04)="matched with those EWL entries. You may use 'SD WAIT LIST REOPEN ENTRIES' "
 S ^TMP("SDWLREB",$J,.05)="to run report identifying the related EWL entries."
 N SDFORM S SDFORM=$$FORM^SDFORM("PATIENT NAME",23,"SSN",12,"CLINIC",24,"DATE/TIME of APPT",20) D  ;added
 .S ^TMP("SDWLREB",$J,.06)=SDFORM
 S ^TMP("SDWLREB",$J,.07)="-----------------------------------------------------------------------"
 S ^TMP("SDWLREB",$J,.08)=""
 N XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB="EWL opened entries with appointments 'CANCELED BY CLINIC'."
 S XMY("G.SD EWL BACKGROUND UPDATE")=""
 S XMTEXT="^TMP(""SDWLREB"",$J,"
 S XMDUZ="POSTMASTER"
 D ^XMD K ^TMP("SDWLREB",$J)
 Q
ASKDISP(IEN) ;
 ;IEN - pointer to 409.3 to get data and display
 N SDDIS S SDDIS=0 ; flag indicating disposition
 W ! N X,DIR,DENTER
 Q:$$GET1^DIQ(409.3,IEN_",",23,"I")="C"
 S ^TMP("SDWLPL",$J,IEN)=$G(^SDWL(409.3,IEN,0)) S DENTER="",DENTER=$P($G(^TMP("SDWLPL",$J,IEN)),"^",2)
 S (WLTYPE,TYPE,WLTN,NUM)="",TYPE=$P($G(^TMP("SDWLPL",$J,IEN)),"^",5)
 IF DENTER'=""&(TYPE'="") D
 .IF TYPE=1 S WLTYPE="PCMM TEAM",NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",6),WLTNI=$$GET1^DIQ(404.51,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(404.51,NUM_",",.01)
 .IF TYPE=2 S WLTYPE="PCMM POSITION",NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",7),WLTNI=$$GET1^DIQ(404.57,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(404.57,NUM_",",.01)
 .IF TYPE=3 S WLTYPE="SERV/SPECIALTY",NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",8),WLTNI=$$GET1^DIQ(409.31,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(409.31,NUM_",",.01)
 .IF TYPE=4 S WLTYPE="CLINIC",NUM=$P($G(^TMP("SDWLPL",$J,IEN)),"^",9),WLTNI=$$GET1^DIQ(409.32,NUM_",",.01,"I"),WLTN=$$GET1^DIQ(409.32,NUM_",",.01)
 E  Q
 D SAVE(TYPE,WLTNI,IEN)
 Q
SAVE(TYPE,WLTNI,IEN) ;
 ;TYPE - EWL type
 ;WLTNI - TYPE related name the EWL entry is waiting for
 ;IEN - pointer to 409.3 
 S REQBY=$P($G(^TMP("SDWLPL",$J,IEN)),"^",12)
 S INST=$P($G(^TMP("SDWLPL",$J,IEN)),"^",3)
 N DESIRED S DESIRED=$P($G(^TMP("SDWLPL",$J,IEN)),"^",16)
 N NAME,SSN S NAME=$$GET1^DIQ(2,DFN_",",.01),SSN=$$GET1^DIQ(2,DFN_",",.09)
 N SDBY S SDBY=$$GET1^DIQ(409.3,IEN_",",11),SDBY=$E(SDBY,1,3)
 S NN=$O(^TMP($J,"SDWLPL",""),-1)+1
 S ^TMP($J,"SDWLPL",NN)=IEN_U_WLTYPE_U_U_WLTN_U_INST_U_DENTER_U_SDBY_U_DESIRED
 ;
 N SPIEC S SPIEC=$S(TYPE=4:9,TYPE=3:10,TYPE=2:11,TYPE=1:12)
 S $P(^TMP($J,"SDWLPL",NN),U,SPIEC)=WLTNI
 K ^TMP("SDWLPL",$J,IEN)
 Q
DISP ;
 W !,"EWL Entry has just been opened because of its matching appointment",!,"being canceled.",!!
 N DIR S DIR("B")="YES" ; default to match and close rebooked appointments
 S DIR("A")="Do you wish to close this EWL entry with Rebooked Appointment(Yes/No)",DIR(0)="Y"
 W "Closing this entry will disposition it: SA - REMOVED/SCHEDULED-ASSIGNED",!,"with Rebooked Appointment.",!!
 S DIR("?")="Y(ES) will disposition this EWL entry as 'SA' with just rebooked appointment."
 D LIST ; disable displaying EWL entry per SRS.
 W ! D ^DIR
 N SDDIS S SDDIS=0 I Y S SDDIS=1
 E  Q
 N SDWLDISP,SDWLDA,SDWLDFN,NUM
 I SDDIS S SDWLDISP="SA",NUM="" F  S NUM=$O(^TMP($J,"SDWLPL",NUM)) Q:NUM=""  S REC=^TMP($J,"SDWLPL",NUM) D
 .S SDWLDA=+REC N SDP,SDR D
 .S DIE="^SDWL(409.3,",DA=SDWLDA,DR="21////^S X=SDWLDISP" D ^DIE
 .S DR="19////^S X=DT" D ^DIE
 .S DR="20////^S X=DUZ" D ^DIE
 .S DR="23////^S X=""C""" D ^DIE
 .;I SDWLDISP="SA" update with appointment data
 .;get appointment data to file (for a particular appt #)
 .I SDWLDISP="SA" N SDA D DATP^SDWLEVAL(1,.SDA) D
 ..I $D(SDA) S DIE="^SDWL(409.3,",DA=SDWLDA D
 ...S DR="13////"_SDA(1)_";13.1////"_DT_";13.2////"_SDA(2)_";13.3////"_SDA(15)_";13.4////"_SDA(13)_";13.5////"_SDA(14)_";13.6////"_SDA(16)_";13.8////"_SDA(3)_";13.7////"_DUZ
 ...D ^DIE
 .N SDWLSCL,SDWLSS,SDC
 .S SDC=1
 .S SDWLSCL=$P($G(^TMP($J,"SDWLPL",SDC)),U,9)
 .S SDWLSS=$P($G(^TMP($J,"SDWLPL",SDC)),U,10)
 .I SDWLSCL K:$D(^SDWL(409.3,"SC",SDWLSCL,SDWLDA)) ^SDWL(409.3,"SC",SDWLSCL,SDWLDA)
 .S SDWLDFN=$P($G(^TMP($J,"APPT",1)),U,4)
 .I SDWLSS,SDWLDFN K:$D(^SDWL(409.3,"SS",SDWLDFN,SDWLSS,SDWLDA)) ^SDWL(409.3,"SS",SDWLDFN,SDWLSS,SDWLDA)
 Q
LIST ;LIST
 ;may be called if EWL entry display would be needed
 S (REC,NUM)="" N SDPN
 F  S NUM=$O(^TMP($J,"SDWLPL",NUM)) Q:NUM=""  S REC=^TMP($J,"SDWLPL",NUM) D
 .S IEN=+REC N SDP,SDR D
 ..S SDPN=$$GET1^DIQ(409.3,IEN_",",.01) W !,"Patient: ",SDPN
 ..W !,"  EW List Type   P  Waiting for Institution  Orig Date   By  Des. Date Reopen"
 ..W !,"--------------------------------------------------------------------------"
 ..S SDP=$E($$GET1^DIQ(409.3,IEN_",",10)) ;priority
 ..S SDR=$$GET1^DIQ(409.3,IEN_",",29,"I") ;reopen reason
 .N SDINS,SDIN S SDINS=$P(REC,"^",5) S SDIN=$$GET1^DIQ(4,SDINS_",",.01,"I")
 .W !,NUM_". ",$E($P(REC,"^",2),1,12),?17,SDP,?21,$E($P(REC,U,4),1,13),?35,SDIN,?45,$$FMTE^XLFDT($P(REC,"^",6),8),?57,$P(REC,"^",7),?61,$$FMTE^XLFDT($P(REC,"^",8),8),?76,SDR
 .N SDUP,SDLO
 .S SDUP="ABCDEFGHIJKLMNOPRSTUWQXYzv",SDLO="abcdefghijklmnoprstuwqxyzv"
 .N SMT S SMT=$$GET1^DIQ(409.3,IEN_",",25) I SMT'="" S SMT=$TR(SMT,SDUP,SDLO) W !?2,"Comment: ",SMT
 .N SMO S SMO=$$GET1^DIQ(409.3,IEN_",",30) I SMO'="" S SMO=$TR(SMO,SDUP,SDLO) W !?2,"Reopen: ",SMO
 K ANS1,NN,INST,SCODE,CLINIC,DENTER,REQBY,DESIRD,SCPRI
 K CLINIC,WLTYPE,TYPE,WLTN,NUM,REC
 Q
