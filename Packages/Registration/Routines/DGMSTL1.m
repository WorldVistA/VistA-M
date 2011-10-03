DGMSTL1 ;ALB/SCK - MST Status entry cont. ; 11/15/01 2:27pm
 ;;5.3;Registration;**195,379**;Aug 13, 1993
 Q
PAT ;
 N MSTDFN,DGMST,MSTST,MSTPV,MSTDT,DGDTFLG,MSTX,Y
 ;
 D FULL^VALM1
ASKP S MSTDFN=$$SELECT
 Q:MSTDFN<0
 ;
 S DGMST=$$GETSTAT^DGMSTAPI(MSTDFN)
 K DIRUT
 S DIR(0)="29.11,3AO",DIR("B")=$P(DGMST,U,2),DIR("A")="Enter MST Status: "
 D ^DIR K DIR
 G:$D(DIRUT) ASKP
 ;
 I Y=$P(DGMST,U,2) D  G ASKP
 . W !!," MST Status has not been changed, Nothing done.",!
 S MSTST=Y
 ;
 S MSTDT=$$ASKDATE^DGMSTL2("",+$P(DGMST,U,3))
 G:'MSTDT ASKP
 ;
 S MSTPV=$$ASKPROV^DGMSTL2($P(DGMST,U,4))
 G:'MSTPV ASKP
 ;
 S MSTX=$$NEWSTAT^DGMSTAPI(MSTDFN,MSTST,MSTDT,MSTPV,"",0)
 I +MSTX>0 D
 . D ADDSTR^DGMSTL2(MSTDFN,MSTST,MSTDT,MSTPV,+MSTX)
 ;
 I +MSTX<0 D
 . W !!,"The following occurred when saving this status:"
 . W !,$$EZBLD^DIALOG($P(MSTX,U,2)),!
 ;
 G ASKP
 Q
 ;
STAT ;
 N MSTST,MSTDT,MSTPV,MSTDFN,DGMST,DGDTFLG,Y
 ;
 D FULL^VALM1
 ;
ASKS K DIRUT S DIR(0)="29.11,3AO",DIR("A")="Enter MST status: "
 D ^DIR K DIR
 Q:$D(DIRUT)!(Y']"")
 S MSTST=Y
 ;
ASKS1 S MSTDFN=$$SELECT
 G:MSTDFN<0 ASKS
 S DGMST=$$GETSTAT^DGMSTAPI(MSTDFN)
 ;
 S MSTDT=$$ASKDATE^DGMSTL2
 G:'MSTDT ASKS1
 ;
 S MSTPV=$$ASKPROV^DGMSTL2($S($G(MSTPV)>0:MSTPV,1:""))
 G:'MSTPV ASKS1
 ;
 S MSTX=$$NEWSTAT^DGMSTAPI(MSTDFN,MSTST,MSTDT,MSTPV,"",0)
 I +MSTX>0 D
 . D ADDSTR^DGMSTL2(MSTDFN,MSTST,MSTDT,MSTPV,MSTX)
 ;
 I +MSTX<0 D
 . W !!,"The following occurred when saving this status:"
 . W !,$$EZBLD^DIALOG($P(MSTX,U,2)),!
 ;
 G ASKS1
 Q
 ;
EL ;  Edit MST status in current List Manager Display
 N MSTDFN,DGMST,MSTST,MSTPRV,MSTDT,MSTIEN,DGMSG,MSTIENC,MSTNEW
 ;
 Q:$$CHKNUL^DGMSTL2
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0),"S")
 S VALMI=0,VALMI=$O(VALMY(VALMI)) Q:'VALMI
 S MSTIEN=$O(^TMP("DGMST",$J,"IEN",VALMI,0))
 Q:(MSTIEN<0)
 ;
 ; Retreive information from file entry to be changed
 S MSTIENC=+MSTIEN_","
 D GETS^DIQ(29.11,MSTIENC,"*","IE","DGMST","DGMSG")
 I $D(DGMSG) D  Q
 . W !!,"Unable to retrieve data at this time."
 ;
 W !!,"Edit MST status for "_DGMST(29.11,MSTIENC,2,"E")
 ; Enter new MST status code, default is current MST status entered
 K DIRUT
 S DIR(0)="29.11,3AO",DIR("B")=DGMST(29.11,MSTIENC,3,"E"),DIR("A")="Enter MST Status: "
 D ^DIR K DIR
 Q:$D(DIRUT)
 S MSTST=Y
 ;
 ;  Ask for provider
 S MSTPRV=$$ASKPROV^DGMSTL2(DGMST(29.11,MSTIENC,4,"I"))
 Q:'MSTPRV
 ;
 ; Ask for status date
 S MSTDT=$$ASKDATE^DGMSTL2(DGMST(29.11,MSTIENC,.01,"I"))
 Q:'MSTDT
 ;
 W !
 K DIRUT
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Save Changes? "
 D ^DIR K DIR
 Q:$D(DIRUT)!('Y)
 ;
 ; Process edit
 S MSTNEW(1,29.11,MSTIENC,.01)=MSTDT
 S MSTNEW(1,29.11,MSTIENC,3)=MSTST
 S MSTNEW(1,29.11,MSTIENC,4)=MSTPRV
 S MSTNEW(1,29.11,MSTIENC,5)=DUZ
 ;
 L +^DGMS(29.11,MSTIEN)
 D FILE^DIE("S","MSTNEW(1)","DGERR")
 L -^DGMS(29.11,MSTIEN)
 ;
 ; Update List Manager display
 D FLDTEXT^VALM10(VALMI,"DATE",$$FMTE^XLFDT(MSTDT))
 D FLDTEXT^VALM10(VALMI,"PROVIDER",$$NAME^DGMSTAPI(MSTPRV))
 D FLDTEXT^VALM10(VALMI,"STATUS",MSTST)
 Q
 ;
DL ;  Delete entry from list and from the MST HISTORY File (#29.11)
 N MSTDFN,DGMST,MSG,MSTST,DGRSLT,DGERR,MSTCNT,MSTIEN,MSTIENC
 ;
 Q:$$CHKNUL^DGMSTL2
 ;
 D FULL^VALM1
 ; Retrieve entry to delete
 D EN^VALM2(XQORNOD(0)) S VALMI=0
 M ^TMP("DGMST RENUM",$J)=^TMP("DGMST",$J)
 F  S VALMI=$O(VALMY(VALMI)) Q:'VALMI  D
 . S MSTIEN=$O(^TMP("DGMST",$J,"IEN",VALMI,0))
 . D GETS^DIQ(29.11,MSTIEN_",","*","I","DGMST","DGERR")
 . Q:$D(DGERR)
 . Q:'($$CONFIRM(DGMST(29.11,MSTIEN_",",2,"I"),DGMST(29.11,MSTIEN_",",3,"I")))
 . S DGRSLT=$$DELMST^DGMSTAPI(MSTIEN)
 . I DGRSLT D
 .. K ^TMP("DGMST RENUM",$J,"IDX",VALMI)
 . E  D
 . W !!,$P(DGRSLT,U,2)
 ;
 S (VALMCNT,MSTCNT,IDX)=0
 K ^TMP("DGMST",$J)
 F  S IDX=$O(^TMP("DGMST RENUM",$J,"IDX",IDX)) Q:'IDX  D
 . S MSTIEN=$O(^TMP("DGMST RENUM",$J,"IEN",IDX,0)),MSTIENC=MSTIEN_","
 . D GETS^DIQ(29.11,MSTIENC,"*","I","DGMST")
 . D ADDSTR^DGMSTL2(DGMST(29.11,MSTIENC,2,"I"),DGMST(29.11,MSTIENC,3,"I"),DGMST(29.11,MSTIENC,.01,"I"),DGMST(29.11,MSTIENC,4,"I"),MSTIEN)
 ;
 D NUL^DGMSTL2
 Q
 ;
DP ; Display patient MST status history for a patient not in the current liST
 ;
 N DIC,MSTDFN
 K ^TMP("DGMST DP",$J)
 ;
 D FULL^VALM1
 S MSTDFN=$$SELECT
 ;
 I MSTDFN<0 D  Q
 . W !?5,"No patient found"
 . S VALMBCK="R"
 ;
 D EN^VALM("DGMST STATUS DISPLAY")
 S VALMBCK="R"
 Q
 ;
SENDMST ; Send HL7 messages for current list
 N MSTDFN,DGRSLT,IDX
 S MSTDFN=""
 D FULL^VALM1
 Q:'$D(^TMP("DGMST",$J,"DFN"))
 W !!,"Queuing MST updates for HL7 processing..." D HANG
 S IDX=""
 F  S IDX=$O(^TMP("DGMST",$J,"DFN",IDX)) Q:'IDX  D
 . S MSTDFN=$O(^TMP("DGMST",$J,"DFN",IDX,0))
 . Q:'MSTDFN
 . D SEND(MSTDFN,"Z07")
 W !!,"Queuing completed..." D HANG
 Q
 ;
SEND(DFN,EVNT) ; Send HL7 message
 N HLRSLT
 S DFN=$G(DFN)
 S EVNT=$G(EVNT)
 I EVNT="Z07" D AUTOUPD^DGENA2(DFN)
 Q
 ;
SELECT() ;
 N DGRSLT
 ;
 K DIRUT
 S DIC=2,DIC(0)="AEMQZ",DIC("A")="Select Patient: "
 S DIC("S")="I $G(^(""VET""))=""Y"",'+$G(^(.35))>0!(+$G(^(.35))>0&(+$G(^(.35))'<2921001))"
 D ^DIC K DIC
 I $D(DIRUT)!(Y="") S DGRSLT=-1
 E  D
 . S DGRSLT=+Y
 Q $G(DGRSLT)
 ;
CONFIRM(MSTDFN,MSTST) ;  Confirm deletion of patient's MST status
 ; Confirm deletion for this patient
 K DIRUT
 S DIR("A",1)=""
 S DIR("A",2)=$P(^DPT(MSTDFN,0),U)_" has a current status of "_$$EXTMST^DGMSTL2(MSTST)
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Delete this MST status entry? "
 D ^DIR K DIR
 Q:$D(DIRUT) 0
 Q $G(Y)
 ;
HANG ; This logic allows the messages to display briefly to the User.
 R DGPTHANG:4 K DGPTHANG
 Q
