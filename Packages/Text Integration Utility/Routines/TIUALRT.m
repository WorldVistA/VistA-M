TIUALRT ; SLC/JER,AJB - Notify Author and Attending. ; Mar 17, 2003
 ;;1.0;TEXT INTEGRATION UTILITIES;**21,84,79,88,58,61,151,158,175,221,227**;Jun 20, 1997;Build 15
SEND(DA,OVERDUE) ; Generate "available for signature" alert
 N TIU0,TIU12,TIU13,TIU14,TIU15,TIUESNR,TIUPNM,TIUECSNR,TIUSIG,TIUDPRM
 N TIUCOSG,TIUEDT,TIUSSN,TIU,TIUTYP,XQA,XQAKILL,XQAMSG,XQAROU,XQAID
 N XQAFLG,STATUS,SIGACT,ECSNRFLG
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 I '$D(TIUTMP("NODEL")) D ALERTDEL(DA)
 S TIU0=$G(^TIU(8925,+DA,0)),TIU12=$G(^(12)),TIU13=$G(^(13))
 S TIU14=$G(^TIU(8925,+DA,14)),TIU15=$G(^(15))
 D DOCPRM^TIULC1(+TIU0,.TIUDPRM,DA)
 ; Quit if notifications not enabled
 I '$D(TIUDPRM(0)) Q
 ; If document is an addendum, and the original is incomplete, quit
 ; per NOIS DUR-0101-32087
 ; I +$$ISADDNDM^TIULC1(DA),($P($G(^TIU(8925,+$P(TIU0,U,6),0)),U,5)<7) Q
 I '+$P(TIUPRM1,U,7)!(+$P(TIU12,U)<+$P(TIUPRM1,U,7)) Q
 ;VMP/ELR  PATCH 221  DO NOT SEND ALERTS FOR RETRACTED DOCUMENTS
 I +$P(TIU0,U,5)=15 Q
 ; If third party alert from TIUALFUN **158**
 I $D(TIUTMP("THIRD PARTY ALERTS")) G THIRD
 ; If document is completed, jump to additional signers
 I (+$P(TIU0,U,5)'<7) G ADDSNR
 I +$P(TIU0,U,5)=3,+$P($G(TIUDPRM(0)),U,2),'+$P(TIU13,U,4) Q  ; not released **175**
 ; If Verification required, and not verified, don't send
 I +$P(TIU0,U,5)=4,+$$REQVER^TIULC(DA,+$P($G(TIUDPRM(0)),U,3)),'+$P(TIU13,U,5) Q  ; **175**
 ; Set up for call to XQALERT
 S TIUEDT=$$DATE^TIULS($P(TIU0,U,7))
 S TIUESNR=$P(TIU12,U,4)
 S TIUSIG=$P(TIU15,U)
 S TIUECSNR=$P(TIU12,U,8),TIUCOSG=$P(TIU15,U,7)
 ; If author has been identified, but not Expected Signer, make
 ; author the expected signer
 I +TIUESNR'>0,(+$P(TIU12,U,2)>0) D
 . N DIE,DR
 . S TIUESNR=$P(TIU12,U,2)
 . S DIE=8925,DR="1204////^S X=TIUESNR" D ^DIE
 ; If attending has been identified, but not Expected Cosigner, make
 ; attending the expected cosigner
 I +TIUECSNR'>0,(+$P(TIU12,U,9)>0) D
 . N DIE,DR
 . S TIUECSNR=$P(TIU12,U,9)
 . S DIE=8925,DR="1208////^S X=TIUECSNR" D ^DIE
 ; If first signature required and the expected signer is authorized
 ; to sign this record, and the record is not yet signed
 ; ** Set AUTHOR as recipient
 I '+$G(TIUSIG),(+TIUESNR>0),(+$P(TIUDPRM(0),U,4)>0) S XQA(TIUESNR)=""
 ; If the record requires cosignature, and is not yet cosigned
 ; ** Set Expected Cosigner as recipient
 I TIUECSNR]"",(+$P(TIU0,U,5)<7),(+$G(TIUCOSG)'>0) D
 . N TIUDA S TIUDA=DA
 . ; For documents other than Discharge Summaries, defer alerting
 . ; Expected Cosigner 'til AUTHOR has signed
 . ; If current document is an addendum apply test to its parent
 . I +$$ISADDNDM^TIULC1(DA) S TIUDA=$P(^TIU(8925,DA,0),U,6)
 . ; If cosigner alerts are to be deferred until signature, quit
 . I '+$P(TIUDPRM(0),U,20),'+$G(TIUSIG),+$P(TIUDPRM(0),U,4) Q  ; **84,112/151**
 . S XQA(TIUECSNR)="",ECSNRFLG=1 ; **151**
ADDSNR ; Send addendum alerts, check for additional signers
 ;VMP/ELR PATCH 221  DO NOT SEND AMENDMENT ALERT IF CAUSED BY A DELINQUENT ADDITIONAL SIGNER
 I +$$ISADDNDM^TIULC1(DA),$G(TIUADDL)'=1 D SENDADD(DA)
 ; If additional signers have been designated, alert them too
 I +$O(^TIU(8925.7,"B",DA,0)),(+$P(TIU0,U,5)>5) D
 . N TIUXTRA,TIUI D XTRASGNR^TIULG(.TIUXTRA,DA) Q:+$D(TIUXTRA)'>9
 . S TIUI=0 F  S TIUI=$O(TIUXTRA(TIUI)) Q:+TIUI'>0  S XQA(TIUI)=""
 Q:$D(XQA)'>9
THIRD ; **158**
 I $D(TIUTMP("THIRD PARTY ALERTS")) D
 . N TIUX
 . S TIUX="" F  S TIUX=$O(TIUXQA(TIUX)) Q:TIUX=""  S XQA(TIUX)=""
 ; Get demographics for alert message
 S TIUPNM=$E($P($G(^DPT(+$P(TIU0,U,2),0)),U),1,9)
 S TIUTYP=$$PNAME^TIULC1(+$G(TIU0))
 D PATVADPT^TIULV(.TIU,+$P(TIU0,U,2))
 S TIUSSN=$E(TIUPNM,1)_$P($G(TIU("SSN")),"-",3)
 S XQAID="TIU"_+DA,STATUS=$$UP^XLFSTR($$GET1^DIQ(8925,DA,.05)) ; **175** $$STATUS^TIULC(DA))
 S SIGACT=$S(STATUS="UNSIGNED":"SIGNATURE",STATUS="UNCOSIGNED":"COSIGNATURE",1:"ADD'L SIGNATURE")
 I $G(ECSNRFLG),$P(TIU0,U,5)=5 S STATUS="UNSIG/UNCOS'D" ; **151**
 S XQAMSG=TIUPNM_" ("_TIUSSN_"): "_STATUS_" "_$S($P(TIU0,U,9)="P":"STAT ",1:"")_TIUTYP
 I +$G(OVERDUE) S XQAMSG=XQAMSG_" OVERDUE for "_SIGACT_"." G ENDMSG
 S XQAMSG=XQAMSG_" available for "_SIGACT_"."
ENDMSG ;
 S XQAROU="ACT^TIUALRT",XQADATA=+DA_U
 D SETUP^XQALERT
 Q
ACT ; Act on alerts
 N TIUQUIK,TIUDA,TIUPRM0,TIUPRM1,TIUPRM3,RSTOK S TIUQUIK=1 K XQAKILL
 S TIUDA=$P(XQADATA,U)
 I '$D(^TIU(8925,+TIUDA,0)) D ALERTDEL(TIUDA) Q
 S RSTOK=$$DOCCHK^TIULRR(TIUDA)
 I RSTOK'>0 D  Q
 . W !!,$C(7),"Ok, no harm done...",! ; Echo denial message
 . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 I $P(^TIU(8925,+TIUDA,0),U,5)'<7,'+$$ISSIGNR(TIUDA,DUZ) S XQAKILL=1
 D:'$D(TIUPRM0)!'$D(TIUPRM1) SETPARM^TIULE
 D EN^VALM("TIU BROWSE FOR CLINICIAN")
 Q
SENDTRAN(DA) ; Generate "Send back to transcription" alert
 N TIUEDT,TIU0,TIUPNM,TIUSSN,TIUTRAN,TIU,XQA,XQAMSG,TIUMSG
 N TIUESNR,TIU12,TIU13,TIU14,TIU15,TIUTYP
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 D ALERTDEL(DA)
 ; Don't send if notifications not enabled
 I '+$P(TIUPRM1,U,7) Q
 S TIU0=$G(^TIU(8925,+DA,0)),TIU12=$G(^(12)),TIU13=$G(^(13))
 S TIU14=$G(^TIU(8925,+DA,14)),TIU15=$G(^(15))
 S TIUPNM=$E($P($G(^DPT(+$P(TIU0,U,2),0)),U),1,9)
 S TIUEDT=$$DATE^TIULS($P(TIU0,U,7))
 S TIUTYP=$$PNAME^TIULC1(+$G(TIU0))
 S TIUTRAN=$P(TIU13,U,2),TIUESNR=$P(TIU12,U,2) ; **175**
 D PATVADPT^TIULV(.TIU,+$P(TIU0,U,2)) ;Used to get SSN. Date not important.
 S TIUSSN=$E(TIUPNM,1)_$P($G(TIU("SSN")),"-",3)
 I $D(^VA(200,+TIUTRAN,0)) S XQA(TIUTRAN)=""
 Q:$D(XQA)'>9
 S TIUMSG=$S(TIUTRAN=TIUESNR:" needs editing",1:" needs retranscription.")
 S XQAID="TIU"_+DA
 S XQAMSG=TIUPNM_" ("_TIUSSN_"): "_TIUTYP_TIUMSG
 D SETUP^XQALERT
 Q
SENDADD(DA) ; Generates "Addendum added" alert
 N TIU12,TIU13,TIU14,TIU15,TIU0,TIUPNM,TIUSSN,TIUTRAN,TIU,TIUTITLE,TIUDPRM
 N XQA,XQAMSG,XQAFLG,XQADATA,XQAROU,TIUESNR,TIUDATE,TIUESNM,TIUO0,TIUO12,TIUO13
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 D ADDENDEL(DA)
 ; Don't send if notifications not enabled
 I '+$P(TIUPRM1,U,7) Q
 S TIU0=$G(^TIU(8925,+DA,0))
 ; Only send upon completion
 Q:+$P(TIU0,U,5)'>6
 D DOCPRM^TIULC1(+TIU0,.TIUDPRM,DA) Q:'+$P(TIUDPRM(0),U,17)
 S TIU12=$G(^TIU(8925,+DA,12)),TIU13=$G(^(13)),TIU14=$G(^(14)),TIU15=$G(^(15))
 S TIUO0=$G(^TIU(8925,$P(TIU0,U,6),0)),TIUO12=$G(^(12)),TIUO13=$G(^(13))
 S TIUPNM=$E($$PTNAME^TIULC1(+$P(TIU0,U,2)),1,9)
 S TIUESNM=$$NAME^TIULS($$PERSNAME^TIULC1(+$P(TIU12,U,2)),"LAST,FI MI")
 S TIUTITLE=$E($$PNAME^TIULC1(+TIUO0),1,20)
 S TIUDATE=$S(+$P(TIUO13,U):$P(TIUO13,U),1:$G(DT))
 S TIUDATE=$$DATE^TIULS(TIUDATE)
 D PATVADPT^TIULV(.TIU,+$P(TIU0,U,2)) ;Used to get SSN. Date not important.
 S TIUSSN=$E(TIUPNM,1)_$P($G(TIU("SSN")),"-",3)
 S TIUTRAN=$P(TIU13,U,2)
 ;Expected Cosigner and Author of original document
 S TIUECSNR=$P($G(^TIU(8925,$P(TIU0,U,6),12)),U,8),TIUESNR=$P($G(^(12)),U,4)
 ; Not entered by Expected Signer: SET Expected Signer as recipient
 I TIUESNR'=TIUTRAN,$D(^VA(200,+TIUESNR,0)) S XQA(TIUESNR)=""
 ; Not entered by Expected Cosigner: SET Expected Cosigner as recipient
 ; VMP/RJT - *227 - If user is the expected cosigner, do not send alert
 I +TIUECSNR>0,(TIUECSNR'=DUZ),(TIUECSNR'=TIUTRAN),$D(^VA(200,+TIUECSNR,0)) S XQA(TIUECSNR)=""
 Q:$D(XQA)'>9
 S XQAID="TIUADD"_+DA,XQADATA=+DA_U,XQAROU="ACTADD^TIUALRT"
 S XQAMSG=TIUPNM_" ("_TIUSSN_"): ADDENDUM to "_TIUTITLE_" of "_TIUDATE_" by "_TIUESNM
 D SETUP^XQALERT
 Q
ACTADD ; Act on ADDENDUM alerts
 N TIUQUIK,TIUDA,TIUPRM0,TIUPRM1,TIUPRM3 S TIUQUIK=1 K XQAKILL
 S TIUDA=$P(XQADATA,U),XQAKILL=1
 I '$D(^TIU(8925,+TIUDA,0)) D ADDENDEL(TIUDA) Q
 W !!,"A NEW Addendum has been added to your document...",!
 W:$L($P($G(XQX),U,3)) !,$P($G(XQX),U,3),!
 I '+$$READ^TIUU("YAO","Do you wish to Browse the Addendum now? ","NO") Q
 D:'$D(TIUPRM0)!'$D(TIUPRM1) SETPARM^TIULE
 D EN^VALM("TIU BROWSE FOR CLINICIAN")
 Q
ALERTDEL(DA) ; Delete alerts associated with a given document
 N XQA,XQAID,XQAKILL S XQAID="TIU"_DA
 D DELETEA^XQALERT
 Q
ADDENDEL(DA) ; Delete alert associated with a Addendum added
 N XQA,XQAID,XQAKILL S XQAID="TIUADD"_DA
 D DELETEA^XQALERT
 Q
ISSIGNR(DA,USER) ; Is USER an additional signer of document DA?
 N TIUY,TIUSDA,TIUSD0 S (TIUY,TIUSDA)=0
 S TIUSDA=+$O(^TIU(8925.7,"AE",DA,USER,0)) G:'TIUSDA ISSIGNX
 S TIUSD0=$G(^TIU(8925.7,TIUSDA,0)) G:'$L(TIUSD0) ISSIGNX
 I +$P(TIUSD0,U,4)'>0 S TIUY=1
ISSIGNX Q TIUY
