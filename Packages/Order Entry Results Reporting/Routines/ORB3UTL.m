ORB3UTL ;SLC/JMH - OE/RR Notification Utilities ;Aug 20, 2019@09:43
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**377**;Dec 17, 1997;Build 582
 ;
GENALRTS ;fire off due alerts
 ;get unfired records
 N ORI S ORI=0
 F  S ORI=$O(^OR(100.97,"C",0,ORI)) Q:'ORI  D
 .N ORWHEN S ORWHEN=$P($G(^OR(100.97,ORI,0)),U,3)
 .I ORWHEN<$$NOW^XLFDT() D GENALRT(ORI) W !,ORI
 Q
 ;
GENALRT(ORID) ;fire a specific scheduled alert
 N ORDUZ,ORMSG
 S ORDUZ($P($G(^OR(100.97,ORID,0)),U,4))=$P($G(^OR(100.97,ORID,0)),U,4)
 S ORMSG=$G(^OR(100.97,ORID,2))
 N ORI S ORI=0 F  S ORI=$O(^OR(100.97,ORID,3,ORI)) Q:'ORI  S ORMSG(ORI)=$G(^OR(100.97,ORID,3,ORI,0))
 N ORDFN S ORDFN=+$G(^OR(100.97,ORID,0))
 D EN^ORB3(90,ORDFN,"",.ORDUZ,.ORMSG,"")
 N ORXQAID S ORXQAID="OR,"_ORDFN_",90;"_$P($G(^OR(100.97,ORID,0)),U,4)_";"_$$NOW^XLFDT()
 K ORFDART,ORMSGRT
 S ORFDART(100.97,ORID_",",4)=ORXQAID
 S ORFDART(100.97,ORID_",",7)=$$NOW^XLFDT()
 D FILE^DIE("","ORFDART","ORMSGRT")
 Q ORXQAID
 ;
SCHALRT(ORDATA) ;Schedule a long text alert
 ;ORDATA fields
 ;    PATIENT - File 2 IEN - for the patient this alert is for
 ;    WHEN - date/time of when this alert will be generated
 ;    WHO - File 200 IEN of who will receive this alert
 ;    TITLE - Free Text title of alert
 ;    BODY(D0) - Word Processing body of the alert for long text
 N DIC,DIE,DR,DA,ORFDART,ORIENRT,ORMSGRT
 S ORFDART(100.97,"+1,",.01)=ORDATA("PATIENT")
 D UPDATE^DIE("","ORFDART","ORIENRT","ORMSGRT")
 I $D(ORIENRT(1)) S DA=ORIENRT(1)
 S DIC="^OR(100.97,",DIC(0)="F",DIE=DIC
 S DR="1////"_$$NOW^XLFDT()_";2////"_ORDATA("WHEN")_";3////"_ORDATA("WHO")_";5////"_ORDATA("TITLE")_";4////0;"
 D ^DIE
 D WP^DIE(100.97,DA_",",6,,"ORDATA(""BODY"")","ERROR")
 Q
 ;
DEFER(ORY,ORPROV,ORALERT,ORDT) ;defer an alert
 ;ORALERT - alert to defer
 ;ORPROV - provider to defer the alert for
 ;ORDT - date/time to defer the alert until
 N ORROOT
 S ORY=1
 ;CALL KERNEL API FOR DEFERRAL
 D DEFALERT^XQALDATA("ORROOT",ORPROV,ORDT,ORALERT)
 N ORRES S ORRES=$G(ORROOT(1),1)
 I $P(ORRES,U)<0 S ORY=ORRES
 Q
NOTIFPG(ORY,ORPAT,ORFROM,ORTO) ;page through a patients alerts
 ;ORPAT - patient DFN
 ;ORPG - page to get
 ;ORPGSZ - page size (defaults to 25)
 N URGLIST,REMLIST,NONORLST,ORY2,I,ORTOTU,ORTOT
 N ALRT,ALRTDFN,ALRTDT,ALRTI,ALRTLOC,ALRTMSG,ALRTPT,ALRTXQA,FWDBY,J,NONOR,ORHAS,ORN,ORN0,ORURG,PRE,REM,URG
 D INDNOT(.ORY2)
 K ORY
 K ^TMP("ORB2",$J),^TMP("ORBG",$J)
 D GETPAT3^XQALDATA("^TMP(""ORB2"",$J)",ORPAT,ORFROM,ORTO)
 D URGLIST^ORQORB(.URGLIST)
 D REMLIST^ORQORB(.REMLIST)
 D REMNONOR^ORQORB(.NONORLST)
 S (I,J)=0
 F  S I=$O(^TMP("ORB2",$J,I)) Q:'I  D
 .N ORPROV ; ajb
 .S ALRTDFN=""
 .S ALRT=^TMP("ORB2",$J,I)
 .S PRE=$E(ALRT,1,1)
 .S ALRTXQA=$P(ALRT,U,2)  ;XQAID
 .S NONOR="" F  S NONOR=$O(NONORLST(NONOR)) Q:NONOR=""  D
 ..I ALRTXQA[NONOR S REM=1  ;allow this type of alert to be Removed
 .S ALRTMSG=$P($P(ALRT,U),PRE_"  ",2)
 .I $E(ALRT,4,8)'="-----" D  ;not forwarded alert info/comment
 ..S ORURG="n/a"
 ..S ALRTI=$P(ALRT,"  ")
 ..S ALRTPT=""
 ..S ALRTLOC=""
 ..I $E($P(ALRTXQA,";"),1,3)="TIU" S ORURG="Moderate"
 ..I $P(ALRTXQA,",")="OR" D
 ...; ajb
 ... D
 .... N XQALERTD D ALERTDAT^XQALBUTL(ALRTXQA)
 .... S ORPROV=$$GET1^DIQ(100,+XQALERTD("2"),1)
 ...; ajb
 ...S ORN=$P($P(ALRTXQA,";"),",",3)
 ...S URG=$G(URGLIST(ORN))
 ...S ORURG=$S(URG=1:"HIGH",URG=2:"Moderate",1:"low")
 ...S REM=$G(REMLIST(ORN))
 ...S ORN0=$G(^ORD(100.9,+ORN,0))
 ...S ALRTI=$S(ORN=90:"L",$P(ORN0,U,6)="INFODEL":"I",1:"")
 ...S ALRTDFN=$P(ALRTXQA,",",2)
 ...S ALRTLOC=$G(^DPT(+$G(ALRTDFN),.1))
 ..S ALRTI=$S(ALRTI="I":"I",ALRTI="L":"L",1:"")
 ..I (ALRT["): ")!($G(ORN)=27&(ALRT[") CV")) D  ;WAT
 ...S ALRTPT=$P(ALRT,": ")
 ...S ALRTPT=$E(ALRTPT,4,$L(ALRTPT))
 ...I $G(ORN)=27&(ALRT[") CV") S ALRTMSG=$P($P(ALRT,U),": ",2) ;WAT
 ...E  S ALRTMSG=$P($P(ALRT,U),"): ",2) ;WAT
 ...I $E(ALRTMSG,1,1)="[" D
 ....S:'$L(ALRTLOC) ALRTLOC=$P($P(ALRTMSG,"]"),"[",2)
 ....S ALRTMSG=$P(ALRTMSG,"] ",2)
 ..I '$L($G(ALRTPT)) S ALRTPT="no patient"
 ..S ALRTDT=$P(ALRTXQA,";",3)
 ..S ALRTDT=$P(ALRTDT,".")_"."_$E($P(ALRTDT,".",2)_"0000",1,4)
 ..S ALRTDT=$E(ALRTDT,4,5)_"/"_$E(ALRTDT,6,7)_"/"_($E(ALRTDT,1,3)+1700)_"@"_$E($P(ALRTDT,".",2),1,2)_":"_$E($P(ALRTDT,".",2),3,4)
 ..;S ALRTDT=($E(ALRTDT,1,3)+1700)_"/"_$E(ALRTDT,4,5)_"/"_$E(ALRTDT,6,7)_"@"_$E($P(ALRTDT,".",2),1,2)_":"_$E($P(ALRTDT,".",2),3,4)
 ..S J=J+1,^TMP("ORBG",$J,J)=ALRTI_U_ALRTPT_U_ALRTLOC_U_ORURG_U_ALRTDT_U
 ..S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_ALRTMSG_U_U_ALRTXQA_U_$G(REM)_U
 .;
 .;if alert forward info/comment:
 .I $E(ALRTMSG,1,5)="-----" D
 ..S ALRTMSG=$P(ALRTMSG,"-----",2)
 ..I $E(ALRTMSG,1,14)=FWDBY D
 ...S J=J+1,^TMP("ORBG",$J,J)=FWDBY_U_$P($P(ALRTMSG,FWDBY,2),"Generated: ")_$P($P(ALRTMSG,FWDBY,2),"Generated: ",2)
 ..E  S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_U_""""_ALRTMSG_""""
 .S ORHAS=$S($D(ORY2(ALRTXQA)):1,1:0)
 .S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_U_ORHAS
 .I $G(ORPROV)'="" S ^TMP("ORBG",$J,J)=^TMP("ORBG",$J,J)_U_ORPROV ; ajb
 ;S ^TMP("ORBG",$J)=""
 S ^TMP("ORBG",$J,0)=^TMP("ORB2",$J,0)
 S ORY=$NA(^TMP("ORBG",$J))
 Q
 ;
INDNOT(ORY) ;index the user's alerts by the xqaldata, include deferred alerts
 N ORY2 D FASTUSER^ORWORB(.ORY2,0)
 N ORI S ORI=0 F  S ORI=$O(@ORY2@(ORI)) Q:'ORI  D
 . I $L($P(@ORY2@(ORI),U,8))>0 S ORY($P(@ORY2@(ORI),U,8))=@ORY2@(ORI)
 Q
 ;
GETNOTIF(RETURN,ALERT) ; Return a notification structure to the SMART Dialog System
 Set RETURN=$NA(^TMP($J)) Kill @RETURN
 New ORTMP,X,IEN,IENS,DFN
 Set DFN=+$Piece(ALERT,",",2)
 Set IEN=+$Piece(ALERT,",",3),IENS=IEN_","
 Set @RETURN@(0)="PROCESS AS SMART NOTIFICATION="_+$$GET1^DIQ(100.9,IENS,6.1,"I")
 Quit:'$Piece(@RETURN@(0),"=",2)  ; Flag not set for SMART processing
 Set @RETURN@(1)="NOTE TITLE="_$$GET1^DIQ(100.9,IENS,6.2,"E")
 Set @RETURN@(2)="NOTE TITLE IEN="_+$$GET1^DIQ(100.9,IENS,6.2,"I")
 Set @RETURN@(3)="NOTIFICATION IEN="_IEN
 Set @RETURN@(4)="NOTIFICATION NAME="_$$GET1^DIQ(100.9,IENS,.01,"E")
 Set @RETURN@(5)="ALLOW ADDENDUM="_+$$GET1^DIQ(100.9,IENS,6.3,"I")
 Set @RETURN@(6)="TIU OBJECT="_+$$GET1^DIQ(100.9,IENS,6.4,"I")
 Set @RETURN@(7)="DFN="_DFN
 Set @RETURN@(8)="ALERT="_ALERT
 Set @RETURN@(9)="PATIENT NAME="_$P($G(^DPT(DFN,0)),U)
 Quit
 ;
GETNOTES(RETURN,DOC,DFN) ; Returns existing notes that can be addended
 Set RETURN=$NA(^TMP($J)) Kill @RETURN
 New ROOT,STAT,IEN,LOOP
 For STAT=7,8 Do
 . Set LOOP=$Name(^TIU(8925,"APT",DFN,DOC,STAT))
 . Set ROOT=$Extract(LOOP,1,$Length(LOOP)-1)_","
 . For  Set LOOP=$Query(@LOOP) Quit:$Piece(LOOP,ROOT)'=""  Do
 . . S IEN=$QSubscript(LOOP,$QLength(LOOP))
 . . ; Validate MAKE ADDENDUM
 . . Q:'$$CANDO^TIULP(IEN,"MAKE ADDENDUM")
 . . Set @RETURN@(0)=$Get(@RETURN@(0))+1
 . . Set @RETURN@(@RETURN@(0))=IEN_U_$$GET1^DIQ(8925,IEN,.01)_U_$$GET1^DIQ(8925,IEN,1301)_U_$$GET1^DIQ(8925,IEN,1211)
 S @RETURN@(0)="COUNT="_$G(@RETURN@(0))
 Quit
 ;
GETDESC(RETURN,ALERT) ; Returns notification description
 S RETURN=$NA(^TMP($J)) K @RETURN
 N ORNOTID S ORNOTID=$P($P(ALERT,";"),",",3)
 I 'ORNOTID D  Q
 .S @RETURN@(0)="UNABLE TO DETERMINE ALERT"
 N ORTIUOBJ S ORTIUOBJ=$P($G(^ORD(100.9,ORNOTID,6)),U,4)
 I 'ORTIUOBJ D  Q
 .S @RETURN@(0)="NO DATA OBJECT SETUP"
 S ORTIUOBJ=$P($G(^TIU(8925.1,ORTIUOBJ,0)),U,1)
 I '$L(ORTIUOBJ) D  Q
 .S @RETURN@(0)="NO DATA OBJECT SETUP"
 N DFN S DFN=$P($P(ALERT,";"),",",2)
 I 'DFN D  Q
 .S @RETURN@(0)="UNABLE TO DETERMINE PATIENT"
 ; Value from the TIU OBJECT specified in file 100.9, field 6.4
 N ORBOIL S ORBOIL=$$BOIL^TIUSRVD("|"_ORTIUOBJ_"|")
 I $E(ORBOIL,0,2)="~@" D
 .N ORGLOB S ORGLOB=$P(ORBOIL,"~@",2)
 .I $D(@ORGLOB) D
 ..N ORGLOBI S ORGLOBI=0 F  S ORGLOBI=$O(@ORGLOB@(ORGLOBI)) Q:'ORGLOBI  D
 ...S @RETURN@(ORGLOBI-1)=@ORGLOB@(ORGLOBI,0)
 E  S @RETURN@(0)=ORBOIL
 Q
 ;
