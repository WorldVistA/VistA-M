TIUALRT ; SLC/JER,AJB - SEND ALERTS ;04/06/23  06:16
 ;;1.0;TEXT INTEGRATION UTILITIES;**21,84,79,88,58,61,151,158,175,221,227,259,355,358**;Jun 20, 1997;Build 16
 ;
 ; Reference to ^DPT( supported by IA #10035
 ;
 Q
SEND(DA,OVERDUE,TIUXQA) ;
 ; DA         document IEN
 ; [OVERDUE]  send alert as overdue
 ; [TIUXQA]   third party alerts, passed by reference, TIUXQA(<IEN>)=""  recipients
 ;            TIUXQA=0 delete current alerts, TIUXQA=1 keep current alerts
 N ADDENDUM,FDA,NODE,TIUAAALRT,TIUDPRM,TIUPRM0,TIUPRM1,XQA,XQAARCH,XQADATA,XQADFN,XQAID,XQAMSG,XQAROU
 S NODE(0)=$G(^TIU(8925,+DA,0)) Q:'NODE(0)  S NODE(12)=$G(^(12)),NODE(13)=$G(^(13))
 S NODE(14)=$G(^TIU(8925,+DA,14)),NODE(15)=$G(^(15)),OVERDUE=+$G(OVERDUE,0)
 S ADDENDUM=$S($P($G(^TIU(8925.1,+NODE(0),0)),U)["ADDENDUM"&$P(NODE(0),U,6):1,1:0) ;    is document an addendum?
 I '$G(TIUXQA) D ALERTDEL(DA) ;                                                         delete alerts for a document
 D SETPARM^TIULE S (TIUDPRM(0),TIUDPRM(5))="" D DOCPRM^TIULC1(+NODE(0),.TIUDPRM,DA)  ;  get basic & document parameters
 S TIUAAALRT=$G(TIUADDL,0) ;                                                            from nightly task, if additional signer overdue, TIUADDL=1
 Q:'$D(TIUDPRM(0))  ;                                                                   quit if no document parameters (? - original code)
 Q:'+$P(TIUPRM1,U,7)  ;                                                                 quit if notification enable date not set
 Q:+$P(TIUPRM1,U,7)>+$P(NODE(12),U)  ;                                                  quit if entry date/time earlier than notification date
 Q:$P(NODE(0),U,5)=15  ;                                                                quit, document status is retracted
 N TIU S TIU("Status")=$P(NODE(0),U,5),TIU("Author/Dictator")=$P(NODE(12),U,2) ;        set field data
 S TIU("Expected Signer")=$P(NODE(12),U,4),TIU("Signature Date/Time")=$P(NODE(15),U)
 S TIU("Expected Co-signer")=$P(NODE(12),U,8),TIU("Attending Physician")=$P(NODE(12),U,9)
 S TIU("Co-signature Date/Time")=$P(NODE(15),U,7)
 I +$G(TIUXQA)!(TIU("Status")>6) G TPA ;                                                send only third party or additional signer alerts
 I +$P(TIUDPRM(0),U,2),TIU("Status")=3,'+$P(NODE(13),U,4) Q  ;                          requires release, unreleased, no release date/time
 I +$P(TIUDPRM(0),U,3),TIU("Status")=4,'+$P(NODE(13),U,5) Q  ;                          requires verification, unverified, no verification date/time
 I 'TIU("Expected Signer"),TIU("Author/Dictator") D  ;                                  no expected signer, set expected signer to author/dictator
 . S TIU("Expected Signer")=TIU("Author/Dictator")
 . S FDA(8925,DA_",",1204)=TIU("Expected Signer") D FILE^DIE(,"FDA")
 I 'TIU("Expected Co-signer"),TIU("Attending Physician") D  ;                           no co-signer, set expected co-signer to attending physician
 . S TIU("Expected Co-signer")=TIU("Attending Physician")
 . S FDA(8925,DA_",",1208)=$P(NODE(12),U,9) D FILE^DIE(,"FDA")
 ; signer as recipient
 I $P(TIUDPRM(0),U,4),'TIU("Signature Date/Time"),TIU("Expected Signer") D  ;           require author to sign, no signature
 . Q:TIU("Status")>5  S XQA(TIU("Expected Signer"))="" ;                                verify status, add as recipient
 ; co-signer as recipient
 I TIU("Expected Co-signer"),'TIU("Co-signature Date/Time"),TIU("Status")<7 D
 . I '$P(TIUDPRM(0),U,20),$P(TIUDPRM(0),U,4),'TIU("Signature Date/Time") Q  ;           send co-signer alert, require author to sign, unsigned
 . S XQA(TIU("Expected Co-signer"))=""
 I ADDENDUM,'TIUAAALRT D SENDADD(DA) ;                                                  if from nightly task, do not send addendum added alert
TPA S TIUXQA=0 F  S TIUXQA=$O(TIUXQA(TIUXQA)) Q:'TIUXQA  S XQA(TIUXQA)="" ;                set third party alert recipients
 Q:'$D(XQA)&'$O(^TIU(8925.7,"B",DA,0))  ;                                               quit, no recipients or additional signers
 N D0,PT,XQALERR D PATVADPT^TIULV(.PT,$P(NODE(0),U,2)) ;                                get patient demographics
 ; if recipients, setup alert data and send alert
 I $D(XQA) D XQADATA(DA,.PT),SETUP^XQALERT Q:+$G(TIUXQA)  K XQA ;                       send , if third party alert quit
 I $P(NODE(0),U,5)>5,$O(^TIU(8925.7,"B",DA,0)) D  ;                                     for a signed document, check for additional signers
 . N I S I=0 F  S I=$O(^TIU(8925.7,"AC",+NODE(12),DA,I)) Q:'I  D  ;                     traverse "AC" for outstanding additional signers
 . . I '$D(^TIU(8925.7,I,0)) K ^TIU(8925.7,"AC",+NODE(12),DA,I) Q  ;                    remove "AC" if no entry
 . . I +$P($G(^TIU(8925.7,I,0)),U,4) K ^TIU(8925.7,"AC",+NODE(12),DA,I) Q  ;            remove "AC" if signed
 . . N USR S USR=$P($G(^TIU(8925.7,I,0)),U,3) S:+USR XQA(USR)="" ;                      set additional signer
 Q:'$D(XQA)  ;                                                                          quit, no outstanding additional signers
 D XQADATA(DA,.PT,1),SETUP^XQALERT ;                                                    send additional signer alert(s)
 Q
XQADATA(DA,PT,AS) ; setup message text
 ; DA  document IEN      PT  patient demographics [passed by reference]
 ; AS  additional signer [default 0]
 S XQAARCH=24000,XQADATA=+DA_U,XQADFN=$P(NODE(0),U,2),XQAID="TIU"_DA,XQAROU="ACT^TIUALRT"
 S XQAMSG=PT("PNM")_" ("_$E(PT("PNM"),1)_$P(PT("SSN"),"-",3)_"): "
 S XQAMSG=XQAMSG_$S(TIU("Status")=5&TIU("Expected Co-signer")&$P(TIUDPRM(0),U,20):"UNSIGNED/UNCOSIGNED",1:$$UP^XLFSTR($$GET1^DIQ(8925,DA,.05)))
 S XQAMSG=XQAMSG_$S($P(NODE(0),U,9)="P":" STAT ",1:" ")_$$PNAME^TIULC1(+NODE(0))
 S XQAMSG=XQAMSG_$S(OVERDUE:" Dated "_$$DATE^TIULS(+NODE(13))_" OVERDUE for ",1:" available for ")
 S XQAMSG=XQAMSG_$S(TIU("Status")'>5:"SIGNATURE",TIU("Status")=6&('$G(AS)):"COSIGNATURE",1:"ADDITIONAL SIGNATURE")
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
 N XQAID ;259
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
 ;I $D(^VA(200,+TIUTRAN,0)) S XQA(TIUTRAN)=""
 I $$PROVIDER^XUSER(TIUTRAN) S XQA(TIUTRAN)="" ;ICR #2343 In file 200 & not terminated
 Q:$D(XQA)'>9
 S TIUMSG=$S(TIUTRAN=TIUESNR:" needs editing",1:" needs retranscription.")
 S XQAID="TIU"_+DA
 S XQAMSG=TIUPNM_" ("_TIUSSN_"): "_TIUTYP_TIUMSG
 D SETUP^XQALERT
 Q
SENDADD(DA) ; Generates "Addendum added" alert
 N TIU12,TIU13,TIU14,TIU15,TIU0,TIUPNM,TIUSSN,TIUTRAN,TIU,TIUTITLE,TIUDPRM
 N XQA,XQAMSG,XQAFLG,XQADATA,XQAROU,TIUESNR,TIUDATE,TIUESNM,TIUO0,TIUO12,TIUO13
 N XQAID,TIUECSNR ;P259
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
