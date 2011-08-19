TIUALRT1 ; SLC/JER - More alert processing ;4/9/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**100**;Jun 20, 1997
SENDID(DA) ; Generates "ID Entry attached" alert
 N TIU0,TIU12,TIU13,TIU14,TIU15,TIU21,TIUPNM,TIUSSN,TIUTRAN,TIU,TIUTITLE
 N TIUDPRM,XQA,XQAMSG,XQAFLG,XQADATA,XQAROU,TIUESNR,TIUDATE,TIUESNM
 N TIUO0,TIUO12,TIUO13,TIUECSNR
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 D IDDEL(DA)
 ; Don't send if notifications not enabled
 I '+$P(TIUPRM1,U,7) Q
 S TIU0=$G(^TIU(8925,+DA,0))
 S TIU12=$G(^TIU(8925,+DA,12)),TIU13=$G(^(13)),TIU14=$G(^(14))
 S TIU15=$G(^TIU(8925,+DA,15)),TIU21=$G(^(21))
 Q:+TIU21'>0
 S TIUO0=$G(^TIU(8925,+TIU21,0)),TIUO12=$G(^(12)),TIUO13=$G(^(13))
 ; Only send if document parameter indicates you should
 D DOCPRM^TIULC1(+TIUO0,.TIUDPRM,DA)
 Q:'+$P(TIUDPRM(0),U,19)
 S TIUPNM=$E($$PTNAME^TIULC1(+$P(TIU0,U,2)),1,9)
 S TIUESNM=$$NAME^TIULS($$PERSNAME^TIULC1(+$P(TIU12,U,2)),"LAST,FI MI")
 S TIUTITLE=$E($$PNAME^TIULC1(+TIUO0),1,20)
 S TIUDATE=$S(+$P(TIUO13,U):$P(TIUO13,U),1:$G(DT))
 S TIUDATE=$$DATE^TIULS(TIUDATE)
 D PATVADPT^TIULV(.TIU,+$P(TIU0,U,2)) ;Used to get SSN. Date not important.
 S TIUSSN=$E(TIUPNM,1)_$P($G(TIU("SSN")),"-",3)
 S TIUTRAN=$P(TIU13,U,2)
 ;Expected Cosigner and Author of original document
 S TIUECSNR=$P($G(^TIU(8925,+TIU21,12)),U,8),TIUESNR=$P($G(^(12)),U,4)
 ; Not attached by Expected Signer: SET Expected Signer as recipient
 I TIUESNR'=DUZ,$D(^VA(200,+TIUESNR,0)) S XQA(TIUESNR)=""
 ; Not attached by Expected Cosigner: SET Expected Cosigner as recipient
 I +TIUECSNR,(TIUECSNR'=DUZ),$D(^VA(200,+TIUECSNR,0)) S XQA(TIUECSNR)=""
 Q:$D(XQA)'>9
 S XQAID="TIUID"_+DA_";",XQADATA=+DA_U,XQAROU="ACTID^TIUALRT1"
 S XQAMSG=TIUPNM_" ("_TIUSSN_"): ID Entry added by "_TIUESNM_" for "_TIUTITLE_" of "_TIUDATE
 D SETUP^XQALERT
 Q
 ;
ACTID    ; Act on ID Entry alerts
 N TIUQUIK,TIUDA,TIUPRM0,TIUPRM1,TIUPRM3 S TIUQUIK=1 K XQAKILL
 S TIUDA=$P(XQADATA,U),XQAKILL=1
 I '$D(^TIU(8925,+TIUDA,0)) D IDDEL(TIUDA) Q
 W !!,"A NEW Interdisciplinary Entry has been added to your document...",!
 W:$L($P($G(XQX),U,3)) !,$P($G(XQX),U,3),!
 I '+$$READ^TIUU("YAO","Do you wish to Browse the Interdisciplinary Entry now? ","NO") Q
 D:'$D(TIUPRM0)!'$D(TIUPRM1) SETPARM^TIULE
 D EN^VALM("TIU BROWSE FOR CLINICIAN")
 Q
 ;
IDDEL(DA) ; Delete alert associated with ID Entry added
 N XQA,XQAID,XQAKILL S XQAID="TIUID"_DA_";"
 D DELETEA^XQALERT
 Q
