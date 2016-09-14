SDECV ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
CHKIN(BSDEVT,BSDCLN,BSDDT,APTN,DFN,BSDVSTN) ;EP; -- ask visit related check-in questions
 ; called by Scheduling Event driver
 ; user interface for 2 questions (clinic code and provider)
 ; Input variables:
 ;      BSDEVT = type of event (4=checkin)
 ;      BSDCLN = clinic ien
 ;      BSDDT  = appt date/time
 ;      APTN   = ien for appt under date multiple
 ;      DFN    = patient ien
 Q:$G(BSDEVT)'=4  ;quit if not a checkin
 Q:'$G(DFN)  Q:'$G(BSDCLN)  Q:'$G(BSDDT)  Q:'$G(APTN)
 ;I $$GET1^DIQ(9009017.2,+BSDCLN,.09)'="YES" Q  ;don't create visit
 ; if patient already checked in, use VDATE code
 ;I $P(SDATA("BEFORE","STATUS"),U,4)]"" D  Q
 ;. N BSDMSG
 ;. D VDATE(BSDEVT,BSDCLN,BSDDT,APTN,DFN,$P(SDATA("BEFORE","STATUS"),U,4),.BSDMSG)
 ;. D VSTUPD(BSDCLN,BSDDT,APTN,DFN,.BSDMSG)
 ;. ;
 ;. ; display any messages (error messages in reverse video)
 ;. I $D(BSDMSG) D
 ;.. NEW I F I=1:1 Q:'$D(BSDMSG(I))  D
 ;... I $P(BSDMSG(I),U)>0,$G(IORVON) D MSG(IORVON_$P(BSDMSG(I),U,2)_IORVOFF,1,0),PAUSE^SDECU Q
 ;... D MSG($P(BSDMSG(I),U,2),1,0)
 Q:'$G(^SC(+BSDCLN,"S",BSDDT,1,APTN,"C"))  ;not checked-in
 N BSDCC,BSDVP,BSDMSG
 S BSDCC=$$CLNCODE(BSDCLN)        ;ask clinic code
 S BSDVP=$$PROV(BSDCLN)           ;ask visit provider
 ; call to new API - GETVISIT^SDECAPI4
 NEW BSDVAR,BSDOUT
 S BSDVAR("NEVER ADD")=1              ;first time through just check for matches
 D SETVAR                             ;set basic variables for API call
 D GETVISIT^SDECAPI4(.BSDVAR,.BSDOUT)   ;call new API
 K BSDVAR
 I BSDOUT(0)=1 S BSDVSTN=$O(BSDOUT(0))         ;if match found, set visit IEN
 D VISIT(BSDCLN,BSDDT,APTN,DFN,BSDCC,BSDVP,.BSDMSG)   ;create visit call
 I $D(BSDMSG) D
 . NEW I F I=1:1 Q:'$D(BSDMSG(I))  D MSG($P(BSDMSG(I),U,2),1,0)
 . D PAUSE^SDECU
 Q
 ;
VISIT(BSDCLN,BSDDT,APTN,DFN,BSDCC,BSDPROV,BSDOPT,BSDMSG,BSDVSTN,SDECC) ;EP; -- create visit
 ;
 ; called by CHKIN subroutine above and by applications where
 ; all data is already known
 ; silent update to database; no user interface
 ; Input variables:
 ;      BSDCLN  = clinic ien
 ;      BSDDT   = appt date/time
 ;      APTN    = ien for appt under date multiple
 ;      DFN     = patient ien
 ;      BSDCC   = clinic code ien
 ;      BSDPROV = visit provider ien
 ;      BSDOPT  = option used to create visit (optional)
 ;      BSDMSG  = called by reference, upon exit contains user msgs
 ;                first piece is error code; 2nd piece is message
 ;                Error = 0 (no problems)
 ;                        1 (problem setting visit variables)
 ;                        2 (problem creating visit)
 ;                        3 (problem changing visit date/time)
 Q:'$G(BSDCLN)  Q:'$G(BSDDT)  Q:'$G(APTN)  Q:'$G(DFN)
 Q:'$G(BSDCC)
 Q:'$G(^SC(+BSDCLN,"S",BSDDT,1,APTN,"C"))  ;not checked-in
 I $G(BSDVSTN) D PROVUPD,HOSLUPD Q   ;if have visit already, update providers & clinic then quit
 ; else create visit, add provider and create VCN
 N BSDVAR,BSDR,BSDRET
 D SETVAR
 S BSDVAR("APCDAPPT")=$S($P(^DPT(DFN,"S",BSDDT,0),U,7)=3:"A",$P(^DPT(DFN,"S",BSDDT,0),U,7)=4:"W",1:"U")    ;walk-in vs appt
 I "CT"[BSDVAR("SRV CAT") K BSDVAR("APCDAPPT")  ; not needed for phone calls & cr
 I $G(BSDOPT)]"" S BSDVAR("APCDOPT")=$O(^DIC(19,"B",BSDOPT,0))  ;option used
 E  S BSDVAR("APCDOPT")=$O(^DIC(19,"B","SDAM APPT MGT",0))
 S BSDVAR("SHOW VISITS")=1  ; variable to show visits to link to
 S BSDVAR("CALLER")="SDEC CHECKIN"  ; add variable that shows who the caller is for API
 K BSDR("VIEN")  ; hangs around after a multiple visit
 S BSDVAR("ADT")=$G(SDECC("ADT"))
 S BSDVAR("CDT")=$G(SDECC("CDT"))
 S BSDVAR("CLN")=$G(SDECC("CLN"))
 S BSDVAR("PROVIDER")=$G(SDECC("PROVIDER"))
 S BSDVAR("VISIT TYPE")=$G(SDECC("VISIT TYPE"))
 D GETVISIT^SDECAPI4(.BSDVAR,.BSDRET)
 I BSDRET(0)>1 D
 . ;D SELECT^BSDAPI5(.BSDVAR,.BSDRET)
 I '$G(BSDR("VIEN")) D
 . S BSDVAR("FORCE ADD")=1
 . D GETVISIT^SDECAPI4(.BSDVAR,.BSDRET)
 D MSGADD(0,"Visit Attached/Created.")
 S BSDVSTN=$O(BSDRET(0))
 I '$G(BSDVSTN) S MAW="S $ZE=""BSDV NO VISIT CREATED"" D ^ZTER" X MAW K MAW Q  ; quit if no visit
 I $G(BSDR("VIEN")) S BSDVSTN=BSDR("VIEN")  ; set to selected visit var
 ; -- add provider to visit
 I $G(BSDPROV),'$$PP(BSDVSTN,BSDPROV),$P($G(^AUPNVSIT(BSDVSTN,0)),U,5)=DFN D  ;make sure visit patient and dfn are same before adding provider
 . K SDEC
 . S SDEC("PRO")=BSDPROV
 . S SDEC("PAT")=DFN
 . S SDEC("VST")=BSDVSTN
 . S SDEC("TMP")="[SDECALVR 9000010.06 (ADD)]"
 . S SDEC("TPS")="P"
 . S SDEC("TOA")=""
 . S SDEC("CDT")=$G(BSDVAR("CDT"))
 . D VPROV^SDECALVR(.SDEC)
 . D MSGADD(0,"Provider added to visit.")
 ;DO NOT KILL BSDVSTN, BSDVCN OR BSDOPT; KILLED AT END OF EVT DRIVER
VSTEND D EN1^SDECEKL,EN2^SDECEKL K SDECALVR,X
 Q
 ;
PP(VSTN,PROV) ;
 N FOUND,IEN,PRIM,PRV
 S (IEN,FOUND,PRIM)=0
 I '$G(VSTN) Q FOUND
 F  S IEN=$O(^AUPNVPRV("AD",VSTN,IEN)) Q:'IEN  D
 . I $P($G(^AUPNVPRV(IEN,0)),U)=PROV S FOUND=1   ;provider on visit
 . I $$GET1^DIQ(9000010.06,IEN,.04)="PRIMARY" S FOUND=1  ;do not allow multiple primary providers
 I $G(FOUND) S MAW="S $ZE=""BSDV MULT PRIM PROV PROBLEM"" D ^ZTER" X MAW K MAW
 Q $G(FOUND)           ;PRIMARY already on visit
 ;
VDATE(BSDEVT,BSDCLN,BSDDT,APTN,DFN,BSDCKO,BSDMSG) ;EP
 ;if new time entered, update visit
 ; called by Scheduling Event Driver; use if check-in time was changed
 ; silent update to database; no user interface
 ; Input variables:
 ;    BSDEVT    =  type of event (4=checkin)
 ;    BSDCLN    =  clinic ien
 ;    BSDDT     =  appt date & time
 ;    APTN      =  ien for appt under date multiple
 ;    DFN       =  Patient ien
 ;    BSDCKO    =  old check-in date/time
 ;    BSDMSG    =  called by reference, upon exit contains user msgs
 ;
 Q:$G(BSDEVT)'=4   ;quit if not a checkin
 ;I $$GET1^DIQ(9009017.2,+BSDCLN,.09)'="YES" Q  ;don't create visit
 N APCDVSIT,BSDCK
 ; find visit based on old check-in time
 S APCDVSIT=$O(^AUPNVSIT("AA",DFN,$$RDT(BSDCKO),0)) Q:'APCDVSIT
 I $O(^AUPNVSIT("AA",DFN,$$RDT(BSDCKO),APCDVSIT)) D MSGADD(4,"More than 1 visit for date/time; visit must be updated manually.") Q
 ; get new check-in time
 S BSDCK=$G(^SC(BSDCLN,"S",BSDDT,1,APTN,"C")) Q:BSDCK=BSDCKO
 Q
 ;
RDT(X) ; -- reverse date
 Q 9999999-$P(X,".")_"."_$P(X,".",2)
 ;
CLNCODE(CLINIC) ; -- asks user for clinic code
 N Y,DIR,CODE
 F  Q:$G(Y)>0  D
 . S DIR(0)="P^40.7:EMZQ",DIR("A")="CLINIC CODE for VISIT"
 . S CODE=$$GET1^DIQ(40.7,+$$GET1^DIQ(44,CLINIC,8,"I"),1)  ;code #
 . ;do not set default if multiple clinic codes used in clinic
 . ;I CODE,$$GET1^DIQ(9009017.2,CLINIC,.13)'="YES" S DIR("B")=CODE
 . I CODE]"",$$GET1^DIQ(9009017.2,CLINIC,.13)'="YES" S DIR("B")=CODE
 . S DIR("?")="This is required.  Please try again"
 . D ^DIR
 Q +Y
 ;
PROV(CLINIC) ; - asks user for visit provider
 N DIC,X,Y
 F  Q:($G(Y)>0)  D
 . S DIC=200,DIC(0)="AMEQZ",DIC("A")="VISIT PROVIDER:  "
 . S DIC("B")=$$GET1^DIQ(200,+$$PRV^SDECU(CLINIC),.01)
 . I DIC("B")="" K DIC("B")
 . S DIC("S")="I $D(^XUSEC(""PROVIDER"",+Y))"
 . D ^DIC K DIC
 . I Y<1,$$GET1^DIQ(9009017.2,CLINIC,.14)'="YES" S Y="1^QUIT" Q
 . I Y<1 D MSG("This is required.  Please try again.",1,0)
 I $P(Y,U,2)="QUIT" Q 0
 Q $$PRVIEN(+Y)
 ;
PRVIEN(Y) ; -- determines correct provider file to use
 I $P(^DD(9000010.06,.01,0),U,2)["200" Q +Y
 Q $P(^VA(200,+Y,0),U,16)
 ;
 ;
MSGADD(ERROR,STRING) ; -- put message string into array
 N I
 S I=$O(BSDMSG(""),-1)+1   ;get next subscript
 S BSDMSG(I)=ERROR_U_STRING
 Q
 ;
MSG(DATA,PRE,POST) ; -- writes line to device
 N I,FORMAT
 S FORMAT="" I PRE>0 F I=1:1:PRE S FORMAT=FORMAT_"!"
 D EN^DDIOL(DATA,"",FORMAT)
 I POST>0 F I=1:1:POST D EN^DDIOL("","","!")
 Q
 ;
FAC(CLINIC) ; -- return facility location ien for clinic
 ; try institution field in file 44, then institution based on division
 ; then try user's division and make sure it is a PCC site
 N FAC
 S FAC=$$GET1^DIQ(44,CLINIC,3,"I")
 I 'FAC S FAC=$$GET1^DIQ(40.8,+$$GET1^DIQ(44,BSDCLN,3.5,"I"),.07,"I")
 I 'FAC S FAC=$G(DUZ(2))
 ;I '$D(^APCDSITE(+FAC)) S FAC=0
 Q FAC
 ;
SERCAT(CLINIC,PAT) ;EP; -- returns service category for visit
 NEW CLNCAT
 I $G(^DPT(PAT,.1))]"" Q "I"                       ;in hospital if inpt
 S CLNCAT=$$GET1^DIQ(9009017.2,CLINIC,.12,"I")     ;clinic's service category
 Q $S(CLNCAT]"":CLNCAT,1:"A")
 ;
VSTUPD(BSDCLN,BSDDT,APTN,DFN,BSDMSG) ; interactive updating of visit data during check-in edit
 ; if check in time different, update visit if there is one
 N BSDCK,AUPNVSIT,DIE,DA,DR,VPROV
 ; get new check-in time
 S BSDCK=+$G(^SC(BSDCLN,"S",BSDDT,1,APTN,"C")) Q:'BSDCK
 ;
 ; find visit based on new check-in time
 S AUPNVSIT=$O(^AUPNVSIT("AA",DFN,$$RDT(BSDCK),0)) Q:'AUPNVSIT
 I $O(^AUPNVSIT("AA",DFN,$$RDT(BSDCK),AUPNVSIT)) D MSGADD(4,"More than 1 visit for date/time; visit must be updated manually.") Q
 ; if visit already has provider, edit it
 NEW DA,DIE,DR
 S DA=$O(^AUPNVPRV("AD",AUPNVSIT,0)) I DA D  Q
 . L +^AUPNVPRV(AUPNVSIT):10  Q:'$T
 . S DIE=9000010.06,DR=".01" D ^DIE
 . L -^AUPNVPRV(AUPNVSIT)
 ; else, add v provider entry
 NEW VPROV S VPROV=$$PROV(BSDCLN) I VPROV>0 D
 . NEW APCDALVR
 . S APCDALVR("APCDTPRO")="`"_VPROV
 . S APCDALVR("APCDPAT")=DFN
 . S APCDALVR("APCDVSIT")=AUPNVSIT
 . S APCDALVR("APCDATMP")="[APCDALVR 9000010.06 (ADD)]"
 . S APCDALVR("APCDTPS")="P",APCDALVR("APCDTOA")=""
 . D ^SDECALVR
 . D MSGADD(0,"Provider added to visit.")
 Q
 ;
PROVUPD ; will update provider on visit that was created earlier
 ;if provider sent is not already on visit, assume provider should be primary
 Q:'$D(BSDPROV)    ;no provider sent
 Q:'$G(BSDPROV)    ;quits if provider is set to zero PATCH 1012 8/19/2010
 ;look at providers on visit
 N FOUND,IEN,PRIM,PRV
 S (IEN,FOUND,PRIM)=0
 F  S IEN=$O(^AUPNVPRV("AD",BSDVSTN,IEN)) Q:'IEN  D
 . I $P($G(^AUPNVPRV(IEN,0)),U)=BSDPROV S FOUND=1   ;provider on visit
 . I $$GET1^DIQ(9000010.06,IEN,.04)="PRIMARY" S PRIM=IEN
 ;
 I FOUND Q           ;provider already on visit, leave alone
 ;
 ; if other provider is primary, switch him/her to secondary
 I PRIM L +^AUPNVPRV(PRIM):10  I $T S DIE=9000010.06,DA=PRIM,DR=".04///S" D ^DIE L -^AUPNVPRV(PRIM)
 ;
 I $G(BSDVSTN),$P($G(^AUPNVSIT(BSDVSTN,0)),U,5)'=$G(DFN) Q  ; don't allow a v provider update if not the correct patient for some reason
 K APCDALVR
 S APCDALVR("APCDTPRO")="`"_BSDPROV
 S APCDALVR("APCDPAT")=DFN
 S APCDALVR("APCDVSIT")=BSDVSTN
 S APCDALVR("APCDATMP")="[APCDALVR 9000010.06 (ADD)]"
 S APCDALVR("APCDTPS")="P",APCDALVR("APCDTOA")=""
 ;D ^APCDALVR
 D ^SDECALVR
 D MSGADD(0,"Provider added to visit.")
 Q
 ;
HOSLUPD ; update hospital location on visit
 N DIE,DA,DR
 L +^AUPNVSIT(BSDVSTN):10
 Q:'$T
 S DIE="^AUPNVSIT(",DA=BSDVSTN,DR=".22///`"_BSDCLN
 D ^DIE
 L -^AUPNVSIT(BSDVSTN)
 Q
 ;
SETVAR ; sets basic variables needed by API call
 S BSDVAR("PAT")=DFN,BSDVAR("VISIT DATE")=+$G(^SC(BSDCLN,"S",BSDDT,1,APTN,"C"))
 S BSDVAR("SITE")=$$FAC(BSDCLN)
 S BSDVAR("VISIT TYPE")=$$GET1^DIQ(9001001.2,BSDVAR("SITE"),.11,"I")
 I BSDVAR("VISIT TYPE")="" S BSDVAR("VISIT TYPE")=$$GET1^DIQ(9001000,BSDVAR("SITE"),.04,"I")
 I BSDVAR("VISIT TYPE")="" K BSDVAR("VISIT TYPE")
 S BSDVAR("SRV CAT")=$$SERCAT(BSDCLN,DFN)
 S BSDVAR("CLINIC CODE")=BSDCC
 S BSDVAR("HOS LOC")=+BSDCLN
 S BSDVAR("APPT DATE")=BSDDT
 S BSDVAR("USR")=DUZ
 S BSDVAR("TIME RANGE")=-1
 Q
 ;
EN1 ;CLEANUP
 ;
 K Y
 K AICDHLIM,XTLKHLIM
 K APCDCAT,APCDCLN,APCDDATE,APCDLOC,APCDTIME,APCDTYPE,APCDVSIT,APCDLOOK,APCDTPCC,APCDTACC,APCDFV,APCDAX,APCDAL,APCDNOK,APCDEQX,APCDMOD,APCDMPQ,APCDTVST,APCDTLOC,APCDTTYP,APCDTCAT,APCDTCLN,APCDEXIT,APCDOLOC
 K APCDTBP,APCDPVL,APCDAPPT,APCDEVM,APCDCODT,APCDLS,APCDVELG,APCDHL,APCDOPT,APCDPROT,APCDAPDT
 K APCDPAT,APCDDOB,APCDSEX,APCDDOD,APCDRV
 K AUPNDOB,AUPNDOD,AUPNPAT,AUPNSEX,AUPNDAYS,AUPNVSIT  ;,AUPNLK("INAC")
 K APCDLPAT,APCDLDAT,APCDLVST,APCDMNE,APCDNOCL,APCDNOXV,APCDAMN
 K APCDAPP,APCDBEEP,APCDDUZ,APCDDUZ2,APCDFLG,APCDL,APCDMODE,APCDOCAT,APCDODAT,APCDOTYP,APCDOVRR,APCDPVC,APCDTPLT,APCDVLK,APCDX,APCDENV,APCDEMF,APCDEIN,APCD,APCDNOXV
 Q
EN2 ;CLEANUP
 ;I '$D(APMFMENU) K AUPNLK("ALL")
 K APCDPARM,APCDNRV,APCDRVON,APCDRVOF,APCDSITE,APCDTRM,APCDDEFL,APCDDEFS,APCDDEFC,APCDDEFT
 Q
