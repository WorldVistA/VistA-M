PSODEMSB ;EPIP/RTW - PSODEM subroutines ; 7/29/17 3:24pm
 ;;7.0;OUTPATIENT PHARMACY;**452,564,570**;Dec 1997;Build 8
 ;------------------------------------------------------------------
 ; External reference  to $$OUTPTTM^SDUTL3  supported by ICR  1252
 ; External reference  to ^DIE              supported by ICR  2022
 ; External references to $$GET1^DIQ        supported by ICR  2056
 ; External reference  to ^PS(55            supported by ICR  2228
 ; External reference  to $$GETALL^SCAPMCA  supported by ICR  2848
 ; External reference  to VST^ORWCV         supported by ICR  4211
 ; External reference  to $$SDAPI^SDMACA301 supported by ICR  4433
 ; External reference  to ^DD("DILOCKTM"    supported by ICR  4909
 ; External reference  to ^DIC              supported by ICR 10006
 ; External reference  to ^DIR              supported by ICR 10026
 ; External reference  to ^DPT(             supported by ICR 10035
 ; External reference  to ^VA(200           supported by ICR 10060
 ; External reference  to LOCK^DILF($NA(    supported by ICR  2054
 ;------------------------------------------------------------------
DEMOG(PSODFN) ;
 ;     Extend patient demographics with PC Team, Current Facility
 ;     Remarks, and Clinical Alerts, pause the screen until <Enter>
 ; Input:
 ;   DFN ; Required ; IEN of Patient file (#2) entry
 ;
 Q:$D(XQORNOD(0))
 N PSOTEAM,PSOCLINA,DIR,DIRUT,PG,X,Y
 I $G(XQY0)["PSO P",(IO=IO(0)) D  ;
 . W !
 . S DIR("T")=DTIME,DIR(0)="EA",DIR("A")="Press <Enter> to continue: " D ^DIR
 ;
 S PG=0
 D PCTEAM(PSODFN)
 I 'PSOTEAM W !! D HDR("Extended Patient Demographics:")
 D REMARKS(PSODFN)
 W !?1,"Assigned/Recent Facility: ",$$CURRFAC(PSODFN)
 D CA(PSODFN)
 Q:$D(DIRUT)
 I $G(XQY0)'["OR CPRS GUI CHART",(IO=IO(0)),$E(IOST)="C" D  ;
 . W !
 . S DIR("T")=DTIME,DIR(0)="EA",DIR("A")="Press <Enter> to continue: " D ^DIR
 Q
 ;------------------------------------------------------------------
CA(PSODFN) ; Print PHARMACY PATIENT CLINICAL ALERTS multiple field (#2)
 ; Input:
 ;   DFN ; Required ; IEN of Patient file (#2) entry
 ;
 N PSOFLAG1,PSODATER
 ;
 Q:'$G(PSODFN)  ; Quit, if no Patient IEN
 Q:'$P($G(^PS(55,PSODFN,2,0)),U,4)  ; No CLINICAL ALERTS
 ;
 S PSOFLAG1=1,PSOCLINA=0 ; First time flag to display field header
 ;
 ; PSODATER format DINUMed: 9999999.999999-CLINICAL ALERT DATE/TIME
 S PSODATER=0
 F  S PSODATER=$O(^PS(55,PSODFN,2,PSODATER)) Q:'PSODATER  D  Q:$D(DIRUT)  ;
 . I PSOFLAG1=1 W !!,"Clinical Alerts:" S PSOFLAG1=0
 . ; Display CLINICAL ALERT DATE/TIME (#.01) & CLINICAL ALERT (#1)
 . W !!,?2,$$GET1^DIQ(55.0109,PSODATER_","_PSODFN,.01)
 . W "  ",$$GET1^DIQ(55.0109,PSODATER_","_PSODFN,1)
 . I '$G(PAGE)!($Y+7>IOSL),$O(^PS(55,PSODFN,2,PSODATER)) D HDR("Clinical Alerts:")
 Q
 ;------------------------------------------------------------------
HDR(HDR) ;
 N DIR
 W !
 I PG,IO=IO(0) S DIR("T")=DTIME,DIR(0)="EA",DIR("A")="Type <Enter> to continue or '^' to exit Clinical Alerts:" D ^DIR I $D(DIRUT) Q
 I HDR]"" W @IOF S PAGE=$G(PAGE)+1 W HDR,?70,"Page: ",PAGE,! S $Y=1
 Q
CURRFAC(PSODFN) ; Return: The Assigned/Recent Facility INSTITUTION for the Patient's DFN
 ; Input:
 ;   DFN ; Required ; IEN of Patient file (#2) entry
 ;
 N DATA,DTBEG,DTEND,FLAGQ,IEN4,ORVISIT,PCTEAM,PREVSCDT,RETURN,SUB
 ;
 S RETURN="" ; Default return value is null
 ;
 I $$GET1^DIQ(2,PSODFN,.351,"I") Q RETURN ; .351 Patient DATE OF DEATH
 ;
 ; The first choice for returning the INSTITUTION would be the
 ; INSTITUTION field (#.07) of the TEAM file (#404.51)
 ;
 S PCTEAM=$$OUTPTTM^SDUTL3(PSODFN,DT,1) ; IEN^NAME of file (#404.51) ; ICR #1252
 ; *** End   patch #1 change #1 by R2/Confer on 08/07/2015
 I +PCTEAM>0 D  Q RETURN
 . S RETURN=$$GET1^DIQ(404.51,+PCTEAM,.07) ; INSTITUTION [R*P4']
 ;
 ; Return future appointments and past visits for a patient
 ;
 S DTBEG=DT-20000 ; Begin with TODAY - 2 years
 S DTEND=DT+20000 ; End   with TODAY + 2 years
 D VST^ORWCV(.ORVISIT,PSODFN,DTBEG,DTEND) ; ICR #4211
 ;
 ; Process ORVISIT array in reverse chronological order.  Quantify
 ; visits & appointments based upon the INSTITUTION pointer field (#3)
 ; of the HOSPITAL LOCATION file (#44).  Once the count reaches
 ; 3 for a given INSTITUTION, that INSTITUION is returned.
 ;
 S FLAGQ=0 ; Quit flag, set to 1 once the Institution is determined
 S PREVSCDT="" ; Previous appt/visit date
 S SUB=":" ;.... Sequential number of ORVISIT array subscript
 F  S SUB=$O(ORVISIT(SUB),-1) Q:'SUB!FLAGQ  D  ;
 . N DATA,SC,SCDT
 . S DATA=ORVISIT(SUB)
 . S SC=$P($P(DATA,U),";",3) Q:'SC  ; HOSPITAL LOCATION file (#44) IEN
 . S IEN4=+$$GET1^DIQ(44,SC,3,"I") ; INSTITUTION file (#4) IEN
 . S SCDT=$P($P(DATA,U),";",2) Q:'SCDT  ; Appt/visit date (fm format)
 . S SCDT=$P(SCDT,".") ; Strip the time
 . Q:SCDT=PREVSCDT  ; Appt/visit must be a N day
 . I '$D(IEN4(IEN4)) S IEN4(IEN4)=0 ; Initialize INSTITUTION counter
 . S IEN4(IEN4)=IEN4(IEN4)+1 ; Quantify by INSTITUTION ien
 . I IEN4(IEN4)=3 D  Q  ; When count reaches 3, INSTITUTION found
 . . S RETURN=$$GET1^DIQ(4,IEN4,.01) ; INSTITUTION NAME (#.01)
 . . S FLAGQ=1
 . ;
 . S PREVSCDT=SCDT ; Save as previous appt/visit date
 ;
 ; IF  no PCTEAM INSTITUTION
 ; AND three appt/visits were not found for an INSTITUTION ien
 ; AND at least one appt/visit was found
 ; THEN
 ;     return the most recent appt/visit INSTITUTION
 ;
 I RETURN="" D  ;
 . N DATA,IEN4,SC,SUB
 . S SUB=$O(ORVISIT(":"),-1) Q:'SUB
 . S DATA=ORVISIT(SUB)
 . S SC=$P($P(DATA,U),";",3) Q:'SC  ; HOSPITAL LOCATION file (#44) IEN
 . S IEN4=$$GET1^DIQ(44,SC,3,"I") ; INSTITUTION file (#4) IEN
 . S RETURN=$$GET1^DIQ(4,IEN4,.01) ; INSTITUTION file (#4) NAME (#.01)
 ;
 Q RETURN
 ;------------------------------------------------------------------
PCTEAM(PSODFN) ; Display current PC TEAM, PC Provider, and phone.
 ; Input:
 ;   DFN ; Required ; IEN of Patient file (#2) entry
 ;
 S PSOTEAM=0
 N DATA,PAGER,PCPOS,PCPROV,PCPROVI,PHONE,PCTM
 N SCDT2,SCP,SDI,TEAM,TEAMI
 ;
 S PCTM="^TMP(""SDPLIST"",$J)"
 K @PCTM
 S SDI=$$GETALL^SCAPMCA(PSODFN,DT,PCTM) Q:'SDI  ; ICR #2848
 S SDI=0
 F  S SDI=$O(^TMP("SDPLIST",$J,PSODFN,"PCTM",SDI)) Q:'SDI  D  ;
 . ;
 . ; "PCTM" node (PC Team)
 . S PSOTEAM=1
 . S DATA=$G(^TMP("SDPLIST",$J,PSODFN,"PCTM",SDI)) Q:DATA=""
 . S TEAMI=$P(DATA,U,1) ; IEN  of TEAM file (#404.51)
 . S TEAM=$P(DATA,U,2) ;. NAME of TEAM file entry
 . ;
 . ; "PCPR" node (PC Provider)
 . S DATA=$G(^TMP("SDPLIST",$J,PSODFN,"PCPR",SDI))
 . S PCPROVI=+$P(DATA,U,1) ; IEN of PC Provider
 . S PCPROV=$P(DATA,U,2) ;. PC Provider
 . S PCPOS=$P(DATA,U,4) ;.. PC Provider Position
 . S PAGER=$$GET1^DIQ(200,PCPROVI,.138) ; DIGITAL PAGER
 . S:PAGER="" PAGER=$$GET1^DIQ(200,PCPROVI,.137) ;  VOICE PAGER
 . S PHONE=$$GET1^DIQ(200,PCPROVI,.132) ; OFFICE PHONE
 . ;
 . I PSOTEAM W !! D HDR("Extended Patient Demographics:")
 . ;
 . W !," Primary Care Team: ",TEAM
 . W ?52,"   Phone: ",$$GET1^DIQ(404.51,TEAMI,.02) ; TEAM PHONE NUMBER
 . ;
 . W !,"       PC Provider: ",PCPROV
 . W ?52,"Position: ",$E(PCPOS,1,18)
 . ;
 . W !?13,"Pager: ",PAGER
 . W ?52,"   Phone: ",PHONE
 ;
 K @PCTM
 Q
 ;------------------------------------------------------------------
REMARKS(PSODFN) ; Display PATIENT file (#2) REMARKS field (#.091)
 ; Input:
 ;   DFN ; Required ; IEN of Patient file (#2) entry
 ;
 W !?11,"Remarks: ",$$GET1^DIQ(2,PSODFN_",",.091)
 ;
 Q
 ;------------------------------------------------------------------
ENTER ; PSO CLINICAL ENTER/EDIT OPTION ENTRY POINT.
 N PSODFN
PROMPT ;
 W @IOF,!?1,"*** CLINICAL ALERT ENTER/EDIT ***"
START ;
 W !
 S PSODFN=+$$PATIENT G:'PSODFN EXIT  W ! ; Prompt for Select PHARMACY PATIENT
 D EDITCA(PSODFN) ; Edit CLINICAL ALERTS (multiple)
 G START
 ;
EXIT ;
 Q
 ;------------------------------------------------------------------
EDITCA(PSODFN) ; Edit the CLINICAL ALERTS multiple (#109) of file (#55)
 ; Input:
 ;   DFN ; Patient file (#2) entry internal entry number
 ;
 NEW %,%X,%Y,D,D0,D1,DA,DG,DI,DIC,DIDEL,DIE,DIERR,DIW,DQ,DR,DTOUT,X
 ;
 S DA=PSODFN
 S DIE="^PS(55,",DR="[PSO CLINICAL ALERT ENTER/EDIT]"
 ;
 D LOCK^DILF($NA(^PS(55,DA))) E  D  Q
 . W $C(7),!?4
 . W "Patient ",$$GET1^DIQ(2,DA,.01)," is being edited by another user."
 D ^DIE
 LOCK -^PS(55,DA)
 ;
 Q
 ;-----------------------------------------------------------------
PATIENT() ; Extrinsic, prompt for 'Select PHARMACY PATIENT: '
 ; Output:
 ;   IEN^Name ; Of the selected Pharmacy Patient file #55 entry
 ;              Return null if no patient selected
 ;
 N %,%H,%I,%X,%Y,C,D,D0,DA,DDH,DG,DIC,DILN,DINUM,DIPGM,DIY
 N DLAYGO,DTOUT,DUOUT,I,RETURN,X,Y
 ;
 S RETURN=""
 S DIC="^PS(55,"
 S DIC(0)="AEMQZ"
 D ^DIC I Y>0 S RETURN=+Y_"^"_Y(0,0)
 ;
 Q RETURN
 ;
APPT() ; get appointments up to +/-2 yrs from now
 ;  return null or name of institution
 ;  ICR# 10061 - VADPT supported
 ;  ICR# 10040 - FM read of file 44, field 3 supported
 ;  ICR# 2171  - $$NS^XUAF4
 N I,X,Y,DIV,F4,GL,NOW,VAERR,VAST,XI,XE
 S GL=$NA(^UTILITY("VASD",$J)) K @GL
 S NOW=$$NOW^XLFDT
 S VASD("F")=DT-20000
 S VASD("T")=DT+20000
 D SDA^VADPT
 ;   div("F",inst)=total count of visits
 ;   div("F",0) = appt_dt ^ inst_ptr
 ;   div("P") set up similarly for past kept appointments
 ;   ^utility("VASD",$j,inc,"I"/"E")=appt_dt^clinic^status^appt_type
 ;   only use one visit per day for division count
 ;   if institution has more than 2 future appts, use that
 ;   if institution has more than 2 past appts, use that
 ;   if future appts, use institution of next appt
 ;   if past appts, use institution of last appt
 ;   use ^UTILITY("VASD",$J,"D",DATE)="" to track visit days
 S F4="",I=0 F  S I=$O(@GL@(I)) Q:'I  S XI=^(I,"I"),XE=^("E") D  Q:F4>2
 . N CL,APPT,DATE,INST
 . S APPT=+XI,CL=+$P(XI,U,2) Q:'CL
 . S DATE=$P(APPT,".") Q:$D(@GL@("D",DATE))  S ^(DATE)=""
 . S INST=+$$GET1^DIQ(44,SC,3,"I") Q:'INST
 . I APPT>NOW D
 . . S Y=1+$G(DIV("F",INST)) I Y>2 S F4=INST Q
 . . S DIV("F",INST)=Y I '$D(DIV("F",0)) S DIV("F",0)=APPT_U_INST Q
 . . I APPT<DIV("F",0) S DIV("F",0)=APPT_U_INST
 . . Q
 . I APPT'>NOW D
 . . S Y=1+$G(DIV("P",INST)),DIV("F",INST)=Y
 . . I '$D(DIV("P",0)) S DIV("F",0)=APPT_U_INST Q
 . . I APPT>DIV("P",0) S DIV("F",0)=APPT_U_INST
 . . Q
 . Q
 I 'F4 S (I,X,Y)=0 D
 . F  S I=$O(DIV("P",I)) Q:'I  I DIV("P",I)>Y S X=I,Y=DIV("P",I)
 . I X,Y>2 S F4=X Q
 . S X=$G(DIV("F",0)) I +X S F4=$P(X,U,2) Q
 . S X=$G(DIV("P",0)) I +X S F4=$P(X,U,2)
 . Q
 I F4 S F4=$P($$NS^XUAF4(F4),U)
 K @GL
 Q F4
