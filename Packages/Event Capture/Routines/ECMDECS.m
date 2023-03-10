ECMDECS ;ALB/CMD - Event Capture Management Delete EC Screen ;12/10/21  15:06
 ;;2.0;EVENT CAPTURE ;**156**;8 May 96;Build 28
 ;
 ; Reference to $$CPT^ICPTCOD supported by ICR #1995
 ; Reference to $$GET1^DIQ supported by ICR #2056
 ; Reference to $$REPEAT^XLFSTR supported by ICR #10104
 ; Reference to ^XMD supported by ICR #10070
 ; Reference to ^XUSEC(key) supported by ICR #10076
 ; Reference to ^DIK supported by ICR #10013
 ; Reference to ^TMP supported by SACC 2.3.2.5.1
 ;
DELECSR ;Used by the RPC broker to delete EC Code Sreens in file #720.3
 ;  Variable passed in:
 ;    ECIEN - IEN of #720.3
 ;    ECDUZ - User IEN of #200
 ;  Variable return
 ;    ^TMP($J,"ECMSG",n)=Success or failure to remove entries in #720.3^Message
 ;
 N DIK,DA,ECERR
 K ^TMP($J,"ECSCRDEL")
 K ^TMP($J,"ECMSG")
 S ECERR=0
 I ECIEN="" S ECERR=1,^TMP($J,"ECMSG",1)="0^Event Code Screen is missing" Q
 D CHKDT I ECERR Q
 D CHKWRK(ECIEN) I ECERR Q
 D SENDMM(ECIEN) ; Send MailMan message to the holders of ECMGR
 S DIK="^ECJ(",DA=ECIEN D ^DIK
 S ^TMP($J,"ECMSG",1)="1^Event Code Screen Deleted"_U_$G(ECIEN)
 Q
 ;
CHKDT ;Required Data Check
 N I,C
 S C=1
 F I="ECIEN","ECDUZ" D
 .I $G(@I)="" S ^TMP($J,"ECMSG",C)="0^Key data missing "_I,C=C+1,ECERR=1
 Q
 ;
CHKWRK(IEN) ;Check if EC Screen had workload
 N ECSCR,ECL,ECD,ECC,ECP,ECCAT,ECHIEN,ECPROC,ECREC
 N ARRFND,GREF,STR
 S ECSCR=$$GET1^DIQ(720.3,IEN,".01","I")
 S ECL=$P(ECSCR,"-"),ECD=$P(ECSCR,"-",2),ECC=$P(ECSCR,"-",3),ECP=$P(ECSCR,"-",4)
 I ECC="" S ECC=0
 S GREF="^ECH(""ADT"",ECL)"
 S STR=ECL_"-"_ECD_"-"_ECC_"-"_ECP
 F  S GREF=$Q(@GREF) Q:$QS(GREF,1)'["ADT"  Q:$QS(GREF,2)'=ECL  D
 . I $QS(GREF,4)'=ECD Q
 . S ECHIEN=$QS(GREF,6)
 . S ECREC=^ECH(ECHIEN,0)
 . S ECCAT=$P(ECREC,U,8),ECPROC=$P(ECREC,U,9)
 . I (ECCAT=ECC),(ECPROC=ECP) D
 .. S ARRFND(STR,ECHIEN)=ECIEN
 I $O(ARRFND(STR,"")) S ^TMP($J,"ECMSG",1)="0^Event Code Screen had workload."_U_ECIEN,ECERR=1 Q
 Q
SENDMM(IEN) ;
 N ECMSG,ECTEXT,XMSUB,XMY,XMTEXT,XMDUZ,CNT,SCRSTAT,SYN,LOC,LOCDS,DEFCL,DSSU,CAT,CATD
 N INACTDT,PN,PRO,PROC,ECREC,ECSCR,ECPI
 S XMSUB="DELETION OF UNUSED EVENT CODE SCREENS FROM File #720.3",XMDUZ="EVENT CAPTURE PACKAGE"
 S XMTEXT="ECTEXT("
 D GETXMY("ECMGR",.XMY)
 S CNT=1
 S ECREC=^ECJ(IEN,0),ECSCR=$P(ECREC,U),INACTDT=$P(ECREC,U,2)
 S DSSU=$P(ECSCR,"-",2),LOC=$P(ECSCR,"-"),CAT=$P(ECSCR,"-",3)
 S PRO=$G(^ECJ(IEN,"PRO")),SYN=$P(PRO,U,2),PROC=$P($P(PRO,U),";"),DEFCL=+$P(PRO,U,4),PRO=$P(PRO,U)
 I PRO["EC" S PN=$G(^EC(725,PROC,0)),PROC=$P(PN,U)_" ("_$P(PN,U,2)_")"
 I PRO["ICPT" S ECPI=$$CPT^ICPTCOD(+PRO) I +ECPI>0 D
 . S PROC=$P(ECPI,U,3)_" ("_$P(ECPI,U,2)_")"
 S SCRSTAT=$S(INACTDT'="":"Inactve",1:"Active")
 S CATD=$S('CAT:"None",1:$P($G(^EC(726,CAT,0)),U))
 S LOCDS=$$GET1^DIQ(4,LOC,.01,"E")
 S ECTEXT(CNT)="The following Event Code Screen has been deleted, it had no workload",CNT=CNT+1
 S ECTEXT(CNT)="associated with it.",CNT=CNT+1
 S ECTEXT(CNT)=" ",CNT=CNT+1
 S ECTEXT(CNT)="DSS UNIT: "_$$GET1^DIQ(724,DSSU,.01,"E")_" ("_DSSU_")",CNT=CNT+1
 S ECTEXT(CNT)="  LOC: "_LOCDS_$$REPEAT^XLFSTR(" ",(27-$L(LOCDS)))_"PROC: "_PROC,CNT=CNT+1
 S ECTEXT(CNT)="  CAT: "_CATD_$$REPEAT^XLFSTR(" ",(27-$L(CATD)))_"SYN: "_SYN,CNT=CNT+1
 S ECTEXT(CNT)="  DEFAULT ASSOCIATED CLINIC: "_$$GET1^DIQ(44,DEFCL,.01,"E"),CNT=CNT+1
 S ECTEXT(CNT)="  STATUS: "_SCRSTAT,CNT=CNT+1
 S ECTEXT(CNT)=""
 D ^XMD
 Q
GETXMY(KEY,XMY) ;Put holders of the KEY into the XMY array to be recipients of the email
 I $G(KEY)'="" M XMY=^XUSEC(KEY)
 S:$G(DUZ) XMY(DUZ)="" ;Make sure there's at least one recipient
 Q
