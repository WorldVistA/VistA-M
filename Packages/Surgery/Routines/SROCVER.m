SROCVER ;BIR/SJA - CODE SET VERSIONING UTILITY ;16 Oct 2013  3:23 PM
 ;;3.0;Surgery;**116,177**;24 Jun 93;Build 89
 ;
 ;Reference to $$CPT^ICPTCOD supported by DBIA #1995
 ;Reference to ^TMP("CSLSUR1" supported by DBIA #3498
 ;Reference to $$CODEC^ICDEX supported by DBIA #5747
 ;
VALIDAT N ATTD,SRBB,SRCC,DLN,SRII,SRJJ,SLN,OCOD,SRAA,SRCODE,SRDATE,SRMOD,SRND0,SRND1,SRND34,SRNON,SRJ,SROP,SRPD,SRT,SRY,SRX,SRX1,SRYY,XMY,Y
 K ^TMP("SRCVER",$J) S $P(DLN,"-",78)=""
 S SRTN=$S($D(SRTN):SRTN,1:DA),SRND0=$G(^SRF(SRTN,0)),SROP=$G(^SRF(SRTN,"OP")),SRND1=$G(^SRF(SRTN,.1)),SRNON=$G(^SRF(SRTN,"NON"))
 S SRPD=$S($D(^SRF(SRTN,"NON")):$P(SRNON,"^",6),1:$P(SRND1,"^",4)),ATTD=$S($D(^SRF(SRTN,"NON")):$P(SRNON,"^",7),1:$P(SRND1,"^",13)),SRND34=$G(^SRF(SRTN,34))
 S SRDATE=$S($P(SRND0,"^",9):$P(SRND0,"^",9),1:DT)
 ;
 S SRCODE=$P(SROP,"^",2) I SRCODE S SRT=$$CPT^ICPTCOD(SRCODE,SRDATE) I $P(SRT,"^",7)=0 S ^TMP("SRCVER",$J,"1;!;PRINCIPAL CPT CODE",$P(SRT,"^",2))=SRCODE D
 .S (SRJJ,SRII)=0 F  S SRII=$O(^SRF(SRTN,"OPMOD",SRII)) Q:'SRII  S SRMOD="" S (Y,SRT)=$P($G(^SRF(SRTN,"OPMOD",SRII,0)),"^") D DISPLAY^SROMOD S SRMOD=$S($G(SRMOD):SRMOD_","_Y,1:Y) D
 ..S ^TMP("SRCVER",$J,"1_1;; CPT MODIFIER",SRMOD)=SRT_"^"_SRII
 ;
 S (SRT,SRAA)=0 F  S SRAA=$O(^SRF(SRTN,13,SRAA)) Q:'SRAA  S OCOD=+$G(^(SRAA,2)) I OCOD S SRT=$$CPT^ICPTCOD(OCOD,SRDATE) I $P(SRT,"^",7)=0 S ^TMP("SRCVER",$J,"2;!;OTHER PROCEDURE CPT CODE",$P(SRT,"^",2))=OCOD_"^"_SRAA D
 .S SRBB=0 F  S SRBB=$O(^SRF(SRTN,13,SRAA,"MOD",SRBB)) Q:'SRBB  S SRMOD="" S (SRT,Y)=$P($G(^SRF(SRTN,13,SRAA,"MOD",SRBB,0)),"^") D DISPLAY^SROMOD S SRMOD=$S($G(SRMOD):SRMOD_","_Y,1:Y) D
 ..S ^TMP("SRCVER",$J,"2_1;; CPT MODIFIER",SRMOD)=$P(SRT,"^")_"^"_SRAA
 ;
 ; RBD - 10/15/13 - PATCH 177 - Logic expanded to include ICD-10
 I $P(SRND34,"^",3)'="" S SRT=$$ICD^SROICD(SRTN,$P(SRND34,"^",3)) I +$P(SRT,"^",10)=0 S ^TMP("SRCVER",$J,"3;!;PRIN DIAGNOSIS CODE",$$CODEC^ICDEX(80,$P(SRND34,"^",3)))=$P(SRND34,"^",3)
 ;
 S SRAA=0 F  S SRAA=$O(^SRF(SRTN,14,SRAA)) Q:'SRAA  S OCOD=$P(^SRF(SRTN,14,SRAA,0),"^",3) I OCOD S SRT=$$ICD^SROICD(SRTN,OCOD) I +$P(SRT,"^",10)=0 S ^TMP("SRCVER",$J,"4;!;OTHER PREOP DIAGNOSIS",$$CODEC^ICDEX(80,OCOD))=OCOD_"^"_SRAA
 ; End 177
 ;
DISP Q:'$D(^TMP("SRCVER",$J))
 W !!,DLN
 D EN^DDIOL("The following codes are no longer active and will be deleted for case #:"_SRTN,,"!")
 S SRAA="" F  S SRAA=$O(^TMP("SRCVER",$J,SRAA)) Q:SRAA=""  W:SRAA["!" ! S (SRBB,SRCC)="" F  S SRBB=$O(^TMP("SRCVER",$J,SRAA,SRBB)) Q:SRBB=""  S SRCC=SRCC+1 D
 .; RBD - 10/15/13 - PATCH 177 - Display Code Set Version also
 .W:SRCC=1 !,?10,$P(SRAA,";",3)_$S($P(SRAA,";",3)["DIAGNOSIS":" "_SRICDV,1:"")_": ",?40,SRBB W:SRCC>1 !,?40,SRBB
 D EN^DDIOL("New active codes must be re-entered. A MailMan message will be sent to",,"!!")
 D EN^DDIOL("the "_$S(SRNON'="":"provider and attending provider",1:"surgeon and attending surgeon")_" of record and to the user who edited",,"!")
 D EN^DDIOL("the record with case details for follow-up.",,"!")
 W !!,DLN
 W !!,"Press RETURN to continue  " R SRX:DTIME
 D SENDMSG
 Q
SENDMSG ;Send mail message when check is complete.
 Q:'$D(^TMP("SRCVER",$J))
 ; RBD - 10/15/13 - PATCH 177 - Logic expanded to include ICD-10
 K SR,XMY S XMDUZ="SURGERY PACKAGE",XMSUB="ICD"_$S($$ICD910^SROICD(SRTN)["10":"-9",1:"")_" OR CPT CODE DELETION",XMY(DUZ)="",SLN=0 D NOW^%DTC S Y=% X ^DD("DD")
 ; End 177
 F SRJJ=SRPD,ATTD,DUZ S:$G(SRJJ) XMY(SRJJ)=""
 S DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT
 S SR(1)="Patient: "_$E(VADM(1),1,20)_$J("",30-$L(VADM(1)))_" Case #: "_SRTN
 S Y=SRDATE D DD^%DT
 S SR(2)=$S(SRNON'="":"Procedure Date: ",1:"Operation Date: ")_Y_"      "_$P(SROP,"^"),SR(3)=""
 S SR(5)="The following codes are no longer active and were deleted for this"
 S SR(6)="case when the "_$S(SRNON'="":"Time Procedure Began",1:"Time Patient in OR")_" was entered."
 S SR(7)="",SLN=8
 S SRX=$J("",8),SRX1=$J("",40)
 ;
PCPT S SRAA=0,SRAA=$O(^TMP("SRCVER",$J,"1;!;PRINCIPAL CPT CODE",SRAA)) I SRAA S SR(SLN)=SRX_"PRINCIPAL CPT CODE:         "_SRAA D
 .K SRY S SRY(130,SRTN_",",27)="@" D FILE^DIE("","SRY")
 .S SRMOD="",SRJJ=0 F  S SRMOD=$O(^TMP("SRCVER",$J,"1_1;; CPT MODIFIER",SRMOD)) Q:SRMOD=""  D
 ..S SRJJ=SRJJ+1,SLN=SLN+1 S:SRJJ=1 SR(SLN)=SRX_" CPT MODIFIER:"_$J("",14)_SRMOD S:SRJJ>1 SR(SLN)=$J("",36)_SRMOD
 ..K SRY S SRY(130,SRTN_",",28)="@" D FILE^DIE("","SRY")
 S SLN=SLN+1,SR(SLN)=""
 ;
OCPT S SRAA=0,SLN=SLN+1 F  S SRAA=$O(^TMP("SRCVER",$J,"2;!;OTHER PROCEDURE CPT CODE",SRAA)) Q:'SRAA  S SR(SLN)=SRX_"OTHER PROCEDURE CPT CODE:   "_SRAA,SRJ=$P($G(^(SRAA)),"^",2) D
 .K SRY S SRY(130.16,SRJ_","_SRTN_",",3)="@" D FILE^DIE("","SRY")
 .S SRMOD="",SRJJ=0 F  S SRMOD=$O(^TMP("SRCVER",$J,"2_1;; CPT MODIFIER",SRMOD)) Q:SRMOD=""  S SRJ=$G(^(SRMOD)) D
 ..S SRJJ=SRJJ+1,SLN=SLN+1 S:SRJJ=1 SR(SLN)=SRX_" CPT MODIFIER:"_$J("",14)_SRMOD S:SRJJ>1 SR(SLN)=$J("",36)_SRMOD
 ..K SRY S SRY(130.16,SRJ_","_SRTN_",",4)="@" D FILE^DIE("","SRY")
 ;
PD ; RBD - 10/15/13 - PATCH 177 - Expanded to include ICD-10
 S SRAA=0,SLN=SLN+1,SRAA=$O(^TMP("SRCVER",$J,"3;!;PRIN DIAGNOSIS CODE",SRAA)) I SRAA'="" S SR(SLN)=SRX_"PRIN DIAGNOSIS CODE "_SRICDV_":"_SRX_SRAA K SRY S SRY(130,SRTN_",",32.5)="@" D FILE^DIE("","SRY") D
 .I +$P($$ICD^SROICD(SRTN,$P(SRND34,"^",2)),"^",10)=0 D
 ..K SRY S SRY(130,SRTN_",",66)="@" D FILE^DIE("","SRY")
 ;
OPD S (SRJJ,SRAA)=0 F  S SRAA=$O(^TMP("SRCVER",$J,"4;!;OTHER PREOP DIAGNOSIS",SRAA)) Q:SRAA=""  S SLN=SLN+1,SRJJ=SRJJ+1 S SRYY=$P($G(^(SRAA)),"^",2) D
 .S:SRJJ=1 SR(SLN)=SRX_"OTHER PREOP DIAGNOSIS "_SRICDV_":"_$J("",6)_SRAA S:SRJJ>1 SR(SLN)=$J("",36)_SRAA
 .K SRY S SRY(130.17,SRYY_","_SRTN_",",3)="@" D FILE^DIE("","SRY")
 ; End 177
 S (SR(SLN+1),SR(SLN+2))=""
 S SR(SLN+3)="New active codes must be re-entered."
 S XMTEXT="SR(" D ^XMD
 ; RBD - 10/15/13 - PATCH 177 - Date change so re-acquire Code Set Version
 S SRICDV=$$ICDSTR^SROICD(SRTN)
 ; End 177
 ;
CFLS ;This line of code to update Surgery-CoreFLS changes
 Q:'$D(^TMP("CSLSUR1",$J))
 S SRSITE=$S($D(SRSITE):SRSITE,1:$$SITE^SROUTL0(SRTN))
 ;JAS - 11/07/14 - PATCH 177 - Added code to preserve Fileman variables since ^SROERR0 was intermittently killing them
 N SRFMTMP
 S SRFMTMP("DC")=DC,SRFMTMP("DL")=DL,SRFMTMP("DP")=DP,SRFMTMP("DA")=DA,SRFMTMP("DR")=DR
 S SROERR=SRTN D ^SROERR0
 I $G(DC)="" S DC=SRFMTMP("DC")
 I $G(DL)="" S DL=SRFMTMP("DL")
 I $G(DP)="" S DP=SRFMTMP("DP")
 I $G(DA)="" S DA=SRFMTMP("DA")
 I $G(DR)="" S DR=SRFMTMP("DR")
 K SRFMTMP
 ;END 177
 Q
