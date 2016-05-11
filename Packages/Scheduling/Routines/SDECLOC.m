SDECLOC ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;Input HIEN     - File 44 IEN
 ;      INACTIVE - Inactive flag.  0=return active only; 1=return active and inactive entries
 ;Output - Hospital Location IEN^Hospital Location Name^Privileged User IEN^Privileged User^INACTIVE
PRIVLOC(DATA,HIEN,INACTIVE) ;EP
 N LP,CNT,INACT
 S INACTIVE=$G(INACTIVE)
 S DATA=$$TMPGBL()
 S (LP,CNT)=0
 S @DATA@(0)="I00020HOSPLOCID^T00030HOSPLOCID^I00020NEWPERSONID^T00030NEWPERSONNAME^T00030INACTIVE"_$C(30)
 Q:'$G(HIEN)
 F  S LP=$O(^SC(HIEN,"SDPRIV",LP)) Q:'LP  D
 .S INACT=$$PC^SDEC45(LP)
 .I 'INACTIVE,INACT Q
 .S CNT=CNT+1,@DATA@(CNT)=HIEN_U_$P(^SC(HIEN,0),U)_U_LP_U_$$GET1^DIQ(200,LP,.01)_U_$S(+INACT:"INACTIVE",1:"ACTIVE")_$C(30)
 S @DATA@(CNT)=@DATA@(CNT)_$C(31)
 Q
 ; Update the list of privileged users for a hospital location
 ; Input - LOC = IEN of Hospital Location file entry
 ;         LST = Array of NEW PERSON IENs. For example,
 ;               LST(1)=34
 ;               LST(2)=65
UPDPRIV(DATA,LOC,LST) ;
 K DATA
 N LP,FDA,CNT,VAL,ERR,IENS,IEN
 I $L($G(LST)) D
 .S CNT=$L(LST,",") F LP=1:1:CNT S LST($P(LST,",",LP))=$P(LST,",",LP)
 .S LST=""
 S DATA(0)="I00020ERRORID^T00030ERRORTEXT"_$C(30)
 I '$G(LOC) D  Q
 .S DATA(1)="-1^MISSING LOCATION IEN"_$C(30,31)
 .D ^%ZTER
 I '$D(^SC(LOC,0)) D  Q
 .S DATA(1)="-1^LOCATION FILE ENTRY IS MISSING"_$C(30,31)
 .D ^%ZTER
 D PURGE(LOC)
 S CNT=0
 S LP=0 F  S LP=$O(LST(LP)) Q:'LP  D
 .S VAL=LST(LP)
 .S CNT=CNT+1
 .S IENS(CNT)=+VAL
 .S IEN="+"_CNT_","
 .S FDA(44.04,IEN_LOC_",",.01)=+VAL
 D:CNT UPDATE^DIE(,"FDA","IENS","ERR")
 I $D(ERR) D
 .S DATA(1)="-1^"_$G(ERR("DIERR",1,"TEXT",1))_$C(30,31)
 E  S DATA(1)="1^SUCCESSFUL"_$C(30,31)
 Q
 ; Purge existings entries prior to updating
 ; Input - IEN of Hospital Location file
PURGE(IEN) ;EP-
 N DIK,DA
 S DIK="^SC("_IEN_",""SDPRIV"","
 S DA(1)=IEN
 S DA=999999999 F  S DA=$O(^SC(IEN,"SDPRIV",DA),-1) Q:'DA  D ^DIK
 ;S DA=0 F  S DA=$O(^SC(IEN,"SDPRIV",DA)) Q:'DA  D ^DIK
 Q
TMPGBL() ;EP-
 K ^TMP("SDECLOC",$J) Q $NA(^($J))
