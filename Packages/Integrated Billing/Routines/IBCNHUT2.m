IBCNHUT2 ;ALB/GEF - HPID/OEID UTILITIES ;11-MAR-14
 ;;2.0;INTEGRATED BILLING;**519,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; this routine contains HL7 utilities for the HPID project.
 Q
 ;
PUR ;
 ; This section handles the purging of the HPID/OEID data stored in the
 ; HPID/OEID Transmission Queue file (#367.1) and in the HPID/OEID Response file (#367).
 ; This is called from a nightly tasked routine IBAMTC.  Data created within the last 2 weeks
 ; cannot be purged. Only requested data that has a NIF-ID response received will be purged.
 ; Unsolicited responses will also be purged as will those with a status of EXR (Exception 
 ; Report Reject), whether they have a NIF ID or not.
 ; The system will not purge entries with no response, entries that have dropped to 
 ; an exception queue, or entries with a response less than 14 days old.
 ; Uses this x-ref on file 367:  ^IBCNH(367,"E",future purge date/time,ien)=""
 ; and finds the corresponding entry in file 367.1 with:  ^IBCNH(367,ien,0)=2nd piece is ien in 367.1
 ;
 ; IB*2.0*549 - This segment also verifies that the HL7 logical link is up and running properly
 ;
 N ENDDT,TQIEN,RSIEN,DA,DIK,RDTA,STDT,RST,TST,ID,RTYP
 S ENDDT=$$FMADD^XLFDT(DT,-15)
 S STDT="" F  S STDT=$O(^IBCNH(367,"E",STDT)) Q:STDT=""!($P(STDT,".",1)>ENDDT)  D
 .S RSIEN="" F  S RSIEN=$O(^IBCNH(367,"E",STDT,RSIEN)) Q:RSIEN=""  D
 ..; double check to make sure they are both correct status with status R having a NIF ID before deleting
 ..S RDTA=$G(^IBCNH(367,RSIEN,0))
 ..S RST=$P(RDTA,U,5),RTYP=$P(RDTA,U,3)
 ..I $E(RST)'="R"&(RST'="EXR") Q
 ..; as of 6/23/14, do not purge EXR
 ..Q:RST="EXR"
 ..S TQIEN=$P(RDTA,U,2)
 ..I TQIEN'="" S TST=$P($G(^IBCNH(367.1,TQIEN,0)),U,4) I $E(TST)'="R" Q
 ..; if this is a requested response, make sure we got a NIF
 ..I RTYP="R",RST="R" Q:'$D(^IBCNH(367,"D",8,RSIEN))
 ..I RTYP="R",RST="R" S ID=$O(^IBCNH(367,"D",8,RSIEN,"")) Q:$P($G(^IBCNH(367,RSIEN,1,ID,0)),U,2)=""
 ..; OK TO DELETE
 ..S DA=RSIEN,DIK="^IBCNH(367," D ^DIK
 ..Q:TQIEN=""
 ..S DA=TQIEN,DIK="^IBCNH(367.1," D ^DIK
 ;
 K ENDDT,TQIEN,RSIEN,DA,DIK,RDTA,STDT,ID,RTYP
 ;
 ; IB*2.0*549 Set up for verifying logical link
 D SETUPVER
 Q
 ;
EXT ; kick off HL7 queries of each insurance company sent to the NIF for the initial HPID extract
 ; called from option IBCNH HPID NIF BATCH QUERY.  To be run once FSC notifies site that they are
 ; ready - ie. they have received and processed the data extracts and have the NIF ID's for each
 ; insurance company.
 ;
 N IBN,DIE,DA,DR,C
 ; activate HPID/OEID flag in IB SITE PARAMS
 S DIE="^IBE(350.9,",DA=$P($G(^IBE(350.9,0)),U,3),DR=70.01_"///"_1 D ^DIE
 S IBN=0,C=0 F  S IBN=$O(^DIC(36,IBN)) Q:'IBN  D
 .; update display with status
 .S C=C+1 I C#20 W "."
 .; don't send if we already have a pending message for this insurance company
 .Q:$D(^IBCNH(367.1,"INS",IBN))
 .; don't send if we already have a NIF ID for this insurance company
 .Q:$$NIF^IBCNHUT1(IBN)
 .; don't send if there are no patients associated with this ins.co. OR if there are no groups associated with this insurance co.
 .Q:'$D(^DPT("AB",IBN))
 .Q:'$D(^IBA(355.3,"B",IBN))
 .; only active insurance companies
 .Q:$P($G(^DIC(36,IBN,0)),U,5)=1
 .; from here we can kick off the HL7 message.  
 .D SEND^IBCNHHLO(IBN)
 K IBN,DIE,DA,DR,C
 Q
 ;
FM36(INS,DATA,TQN) ; updates file 36, 8 node with data received from the NIF
 ; INS = insurance company ien (REQUIRED)
 ; DATA=String containing HPID data in this format:  HPID^CHP/SHP^PARENT^NIF ID
 ;  NIF = NIF ID for insurance company
 ; TQN=ien of entry in file 367.1 (if data came from a requested response)
 ; returns "-1^Error code^Error reason" if entry not added and Processing Status if added/updated
 ;
 N DIC,DR,DA,DIE,I,X
 Q:INS="" "-1^ED^DATABASE Error:  Not a valid Insurance Company ien!"
 ; validate Vista Unique ID and HPID data format
 Q:'$D(^DIC(36,INS)) "-1^ED^Error:  Insurance ien does NOT exist at this site!"
 ; don't update insurance file if Legacy ID's have changed since we sent the request
 Q:$$LEG($G(TQN),INS) "-1^EL^LEGACY ID Error:  Legacy ID Changed!"
 ; ready to update file 36, fields 8.01, 8.02, 8.03 and 8.04 with DATA
 S DIE="^DIC(36,",DA=INS,DR="" K DIC
 F I=2:1:4 S DR=DR_"8.0"_I_"///^S X=$P(DATA,U,"_I_");"
 D ^DIE
 ; add HPID separately since if it fails input transform nothing else updates
 S DR="8.01///^S X=$P(DATA,U)" D ^DIE
 K DIE,DR,I,INS,X,LID,DIC
 Q DA_"^R^RESPONSE PROCESSED:  File 36 Updated"
 ;
FM71(INS,HLID) ; adds entry to file 367.1 (HPID/OEID TRANSMISSION QUEUE) and file 367 (HPID/OEID RESPONSE) 
 ; INS =insurance company ien (required)
 ; HLID =  message control ID number assigned by HL7 when HL7 message was created (required)
 ; returns ien of entry added to file 367.1
 ;
 N DIC,DR,DA,DIE,Y,IDN,DATA,TQN,RSN,X,DLAYGO
 Q:INS="" "-1^Error:  Not a valid Insurance Company ien!"
 Q:HLID="" "-1^Error:  No HL7 Control Number defined!"
 S DIC="^IBCNH(367.1,",DIC(0)="LS",X=$P($G(^IBCNH(367.1,0)),U,3)+1,DLAYGO=367.1 D ^DIC
 Q:Y=-1 "-1^Error:  HPID QUEUE entry NOT added!"
 S TQN=+Y
 ; add stub record in file 367
 S DIC="^IBCNH(367,",DIC(0)="LS",X=HLID,DLAYGO=367 D ^DIC
 ; update 367 with additional fields.
 S RSN=+Y
 I Y>0 S DIE=DIC,DA=+Y,DR=".01///"_HLID_";.02///"_TQN_";.03///R" K DIC D ^DIE
 ; now update new 367.1 entry with insurance company data fields on 2 node, response info and status of A for AWAITING RESPONSE
 Q:'$$R36(INS,.DATA)
 S DIE="^IBCNH(367.1,",DA=TQN,DR="" K DIC
 S DR=".02///"_INS_";"_".04///"_"A"_";.07///"_RSN
 F I=1:1:8 S DR=DR_";2.0"_I_"///^S X=$P(DATA(1),U,"_I_")"
 D ^DIE
 ; update ID multiple with ID data
 F IDN=1:1:10 I $P($G(DATA(2)),U,IDN)'="" D
 .; create ID multiple
 .S DIC="^IBCNH(367.1,"_TQN_",1,",DA(1)=TQN,DIC(0)="LS" S X="`"_IDN,DLAYGO=367.1 D ^DIC Q:Y=-1
 .; add ID data to new multiple entry
 .S DIE=DIC,DA=+Y,DR=".01///"_IDN_";.02///^S X=$P($G(DATA(2)),U,"_IDN_");.03///"_$P($G(DATA(3)),U,IDN) K DIC
 .D ^DIE
 K DIC,DR,DA,DIE,Y,IDN,DATA,RSN,X,DLAYGO
 Q TQN
 ;
FM367(IEN,DATA,ID,QL) ; updates entry to file 367 (HPID/OEID RESPONSE) for requested responses,
 ; or creates a new entry for unsolicited responses.
 ; IEN = ien of existing entry in file 367 (will only exist for requested responses)
 ; DATA = data string containing response data for 0 node (NOTE:  You do not have to pass all this data, but it must be in this format):
 ; HLID^TQN^RTY^INS NAME^NPS^STAT D/T^UID^PARENT HPID^CHP or SHP
 ;      TQN = Transaction ien in file 367.1 (HPID/OEID TRANSMISSION QUEUE), null for unsolicited responses 
 ;      RTY = Response Type:  R for Requested or U for Unsolicited
 ;      NPS = Processing status at NIF, either R for Response Processed or X for Exception Report or EXR for Rejected
 ;  HLID = control ID of HL7 message (required if this is an unsolicited response, not req'd if you have ien)
 ; ID = Data string of ID data sent from NIF.  MUST BE in this format: 
 ;(ie.  HPID must always be 9th piece, NIF must be 8, If no EDI numbers received, those pieces will be null, etc.):
 ; EDI ID NUMBER-PROF^EDI ID NUMBER-INST^EDI PROF SECONDARY ID(1)^EDI PROF SECONDARY ID(2)^EDI INST SECONDARY ID(1)^EDI INST SECONDARY ID(2)^VA NATIONAL ID^NIF ID^HPID/OEID^VISTA UNIQUE ID    
 ; QL=string of secondary ID qualifiers, in this format:  ^^QUAL1(PS1)^QUAL2(PS2)^QAUL3(IS1)^QUAL4(IS2)
 ; RETURNS:  IEN of file 367 entry that was updated, or -1 for error condition
 ;
 N DIC,DR,DA,DIE,Y,IDN,HLID,RTY,INS,TQN,PS,NPS,DLAYGO
 S DATA=$G(DATA),ID=$G(ID),QL=$G(QL)
 S HLID=$P($G(DATA),U),RTY=$P($G(DATA),U,3)
 I RTY="R",$G(IEN)="" Q "-1^Error:  No HPID/OEID Response ien!"
 I $G(IEN)="",$G(HLID)="" Q "-1^Error:  No HPID/OEID Response and no HL7 ien!"
 ; if NIF processing status is not R, update response status only and quit
 Q:$P(DATA,U,5)'="R" $$STAT^IBCNHUT1(IEN,$P(DATA,U,5))
 ; create new entry in 367 for unsolicited responses and update file 36 using NIF ID
 I RTY="U" S IEN=$$UNSOL^IBCNHUT1(HLID,RTY,ID,DATA)
 Q:$P(IEN,U)=-1 "-1^Error:  HPID RESPONSE entry NOT added!"
 ; create and update ID multiple
 F IDN=1:1:10 I $P(ID,U,IDN)'="" D
 .S DIC="^IBCNH(367,"_IEN_",1,",DA(1)=IEN,DIC(0)="LS",X="`"_IDN,DLAYGO=367 D ^DIC Q:Y=-1
 .S DIE=DIC,DA=+Y,DR=".01///"_IDN_";.02///^S X=$P(ID,U,"_IDN_");.03///"_$P(QL,U,IDN) K DIC
 .D ^DIE
 ; update 367 with additional fields.
 S DIE="^IBCNH(367,",DA=IEN,DR=""
 F I=3,4,7,8,9 S DR=DR_".0"_I_"///^S X=$P(DATA,U,"_I_");"
 D ^DIE
 ; now update the insurance company entry in file 36 for requested responses.  Use the insurance
 ; ien that was sent in the original request.  
 ; Unsolicited response are updated via previous call to $$UNSOL^IBCNHUT1
 Q:RTY="U" IEN
 S INS="",TQN=$P($G(^IBCNH(367,IEN,0)),U,2) S:TQN'="" INS=$P(^IBCNH(367.1,TQN,0),U,2)
 S PS=$$FM36(INS,$P(ID,U,9)_U_$P(DATA,U,9)_U_$P(DATA,U,8)_U_$P(ID,U,8),TQN)
 ; update field .05 in file 367 (PROCESSING STATUS)
 Q $$STAT^IBCNHUT1(IEN,$P(PS,U,2))
 ;
R36(INS,DATA) ; this function gathers all the insurance company data we need to send to the NIF
 ; INS= ien of insurance company entry (required)
 ; DATA=name of array to store data results in
 ; Returns:  DATA(0) = Insurance Ien^Insurance Company Name^INACTIVE FLAG^UID^NIF ID^HPID/OEID^CHP/SHP^PARENT HPID
 ;           DATA(1) = STREET ADDRESS 1^STR AD2^CITY^STATE^ZIP^BILLING CO NAME^TYPE OF COVERAGE^PHONE#
 ;           DATA(2) = string of ID's in this format: 
 ; EDI ID NUMBER-PROF^EDI ID NUMBER-INST^EDI PROF SECONDARY ID(1)^EDI PROF SECONDARY ID(2)^EDI INST SECONDARY ID(1)^EDI INST SECONDARY ID(2)^VA NATIONAL ID^NIF ID^HPID/OEID^VISTA UNIQUE ID
 ;           DATA(3) = string of ID qualifiers in this format:   ^^QUAL1(PS1)^QUAL2(PS2)^QAUL3(IS1)^QUAL4(IS2)
 ;
 N ID,QL,I,ND
 F I=0:1:3 S DATA(I)=""
 S ND(.11)=$G(^DIC(36,INS,.11)),ND(0)=$G(^DIC(36,INS,0))
 F I=1,2,4:1:7 S DATA(1)=DATA(1)_$P(ND(.11),U,I)_U
 S DATA(1)=DATA(1)_$P(ND(0),U,13)_U_$P($G(^DIC(36,INS,.13)),U)
 S ID(7)=$$VID^IBCNHUT1(INS),ND(6)=$G(^DIC(36,INS,6)),ND(3)=$G(^DIC(36,INS,3))
 S ID(3)=$P(ND(6),U,6),ID(4)=$P(ND(6),U,8),ID(5)=$P(ND(6),U,2),ID(6)=$P(ND(6),U,4)
 S QL(3)=$P(ND(6),U,5),QL(4)=$P(ND(6),U,7),QL(5)=$P(ND(6),U),QL(6)=$P(ND(6),U,3)
 S ID(1)=$P(ND(3),U,2),ID(2)=$P(ND(3),U,4),ID(10)=$$UID^IBCNHUT1(INS)
 S DATA(0)=INS_U_$P(ND(0),U)_U_$P(ND(0),U,5)_U_$$UID^IBCNHUT1(INS)_U_$$NIF^IBCNHUT1(INS)_U_$$HPD^IBCNHUT1(INS)_U_$$SHP^IBCNHUT1(INS)_U_$$PHP^IBCNHUT1(INS)
 S ID(8)=$P(DATA(0),U,5),ID(9)=$P(DATA(0),U,6)
 F I=1:1:10 S DATA(2)=DATA(2)_$G(ID(I))_U
 F I=1:1:6 S DATA(3)=DATA(3)_$G(QL(I))_U
 K ID,QL,I,ND
 Q 1
 ;
SETUPVER ; Set up verifying of IB NIF TCP logical link
 ; IB*2.0*549 added method
 ;
 N CURRTIME,MTIME
 N DIFROM,LLIEN,NIFTM,XMDUN,XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ,XX,YY,ZTRTN,ZTDESC
 N ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 ;
 I '$$PROD^XUPROD(1) G SETUPVRX             ; Only check for stuck messages in production
 ;
 S NIFTM=$$GET1^DIQ(350.9,"1,",51.29,"I")   ; Get IB NIF TCP data
 I NIFTM="" G SETUPVRX                      ; MM message time is not defined
 S LLIEN=$O(^HLCS(870,"B","IB NIF TCP","")) ; IB NIF TCP Logical Link
 I LLIEN="" G SETUPVRX
 ;
 S CURRTIME=$P($H,",",2)     ; current $H time
 S MTIME=DT_"."_NIFTM        ; build a FileMan date/time
 S MTIME=$$FMTH^XLFDT(MTIME) ; convert to $H format
 S MTIME=$P(MTIME,",",2)     ; $H time of MM message
 ;
 ; If the current time is after the MailMan message time, then schedule the message for tomorrow at that time.
 ; Otherwise, schedule it for later today.
 S ZTDTH=$S(CURRTIME>MTIME:$H+1,1:+$H)_","_MTIME
 ;
 ; Set up the other TaskManager variables
 S ZTRTN="VERFYLNK^IBCNHUT2"              ; The tag that we want TASKMAN to call
 S ZTDESC="Verify HL7 Logical link 'IB NIF TCP' is running"
 S ZTIO=""
 S ZTSAVE("LLIEN")=""
 S ZTSAVE("NIFTM")=""
 D ^%ZTLOAD ; Call TaskManager
 I '$G(ZTSK) D  ; Task # is not okay
 . ;
 . ; Send a MailMan message if this Task could not get scheduled
 . S MGRP="InsuranceRapidResponse@domain.ext"
 . ;
 . S XMSUB=" Daily verification of IB NIF TCP link Not Scheduled"
 . S XMTEXT="XMTEXT("
 . S XMTEXT(1)="TaskManager could not schedule the daily verification of IB NIF TCP link"
 . S XMTEXT(2)="at the specified time of "_$E(NIFTM,1,2)_":"_$E(NIFTM,3,4)_"."
 . D ^XMD
 ;
SETUPVRX ;
 Q
 ;
VERFYLNK ; Verify IB NIF TCP entry in the HL Logical Link file (#870) on a daily basis
 ; IB*2.0*549 added Method
 ; Input - LLIEN [thru ZTSAVE("LLIEN")]
 ;         NIFTM [thru ZTSAVE("NIFTM")]
 ;
 N FLG,IEN,X,XMSUB,XMTEXT,XMY,XX,YY
 S IEN=$O(^HLMA("AC","O",LLIEN,""))
 I IEN="" S FLG=1
 E  D
 . H 30
 . S FLG=$S('$D(^HLMA("AC","O",LLIEN,IEN)):1,1:0) ; Processing observed / No processing
 ;
 I 'FLG D  ; Link is apparently not processing records
 . S XX=$$SITE^VASITE()
 . S YY=$P(XX,"^",2)_"(#"_$P(XX,"^",1)_")"
 . S X="No activity seen in link"
 . ;
 . ; Send a MailMan message if link is not processing records
 . S XMY("InsuranceRapidResponse@domain.ext")=""
 . S XMY(.5)=""
 . ;
 . S XMSUB=" Daily verification of IB NIF TCP link: "_X
 . S XMTEXT="XMTEXT("
 . S XMTEXT(1)="Daily verification of IB NIF TCP was unsuccessful ("_X_")"
 . S XMTEXT(2)="at the specified time of "_$E(NIFTM,1,2)_":"_$E(NIFTM,3,4)_" for site: "_YY_"."
 . D ^XMD
 Q
 ;
LEG(TQN,INS) ; function to determine if legacy ID's changed since we sent them out
 ; returns a 0 if Legacy ID has not changed and a "1^EL^Error:  Legacy ID Changed!" if it has.
 ;
 N N,TID,I
 Q:TQN="" 0
 Q:INS="" 0
 F I=1,2 D
 .S N=$O(^IBCNH(367.1,TQN,1,"B",I,"")) Q:N=""
 .S TID(I)=$P($G(^IBCNH(367.1,TQN,1,N,0)),U,2)
 Q:$G(TID(1))'=$P($G(^DIC(36,INS,3)),U,2) "1^EL^Error:  Legacy ID Changed!"
 Q:$G(TID(2))'=$P($G(^DIC(36,INS,3)),U,4) "1^EL^Error:  Legacy ID Changed!"
 K N,TID,I
 Q 0
  ;
SMAIL(MGRP,XMSUB,MSG) ; Summary email
 ; IB*2.0*549 Send e-mail
 N DIFROM,XMDUN,XMDUZ,XMMG,XMTEXT,XMY,XMZ
 S XMY(MGRP)=""
 S XMTEXT=MSG
 D ^XMD
 Q
