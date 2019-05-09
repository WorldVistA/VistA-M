IBY608PO ;ALB/KDM - POST-INSTALL FOR IB*2.0*608 ;13-DEC-2017
 ;;2.0;INTEGRATED BILLING;**608**;21-MAR-94;Build 90
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;KDM 12/2017 US1909 
 ; run report of all insurance companies that have the current setting for Transmit Electronically set to zero- which is NO
 ; send email of report to eBiz rapid response group
 N IBA,RNAME
 S RNAME="IBY608PO"
 K ^TMP(RNAME,$J)
 S IBA(2)="IB*2*608 Post-Install...",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 D MES^XPDUTL(">> Running Insurance Company EDI Parameter Report...please stand by....")
 D RPT
 D MES^XPDUTL(">> Report Completed.")
 D CMNCPT
 D:$$PROD^XUPROD(1) EMAIL     ;LIVE
 S IBA(2)="IB*2*608 Post-Install Complete.",(IBA(1),IBA(3))=" " D MES^XPDUTL(.IBA) K IBA
 Q
 ;
RPT ; Get all Insurance companies that have the 3.01- transmit electronically field blank or set to No.
 ;N IBADDRESS,IBCITY,IBNAME,IBPIEN,IBSTATE,STATE,TRANSCD,TRANSMIT
 N IBADDRESS,IBCITY,IBNAME,IBPIEN,IBSTATE,INACTFLG,STATE,TRANSMIT
 S IBNAME=""
 F  S IBNAME=$O(^DIC(36,"B",IBNAME)) Q:IBNAME=""  D
 . S IBPIEN=0
 . F  S IBPIEN=$O(^DIC(36,"B",IBNAME,IBPIEN)) Q:'+IBPIEN  D
 . . S TRANSMIT=$$GET1^DIQ(36,IBPIEN,3.01,"I")
 . . Q:+TRANSMIT  ;Only want to report the insurance companies that have a setting of 0 or NULL
 . . S (IBADDRESS,IBCITY,IBSTATE,INACTFLG,STATE)=""
 . . S IBADDRESS=$$GET1^DIQ(36,IBPIEN,.111)
 . . S IBCITY=$$GET1^DIQ(36,IBPIEN,.114)
 . . S IBSTATE=$$GET1^DIQ(36,IBPIEN,.115,"I")
 . . I +IBSTATE S STATE=$$GET1^DIQ(5,+IBSTATE,1)
 . . S INACTFLG=$$GET1^DIQ(36,IBPIEN,.05)
 . . I INACTFLG="" S INACTFLG=""
 . . S ^TMP(RNAME,$J,IBNAME,IBPIEN)=IBADDRESS_U_IBCITY_U_STATE_U_INACTFLG_U_$S(TRANSMIT="":"",1:"NO")
 Q
 ;
EMAIL ; Send an email message to eBiz Rapid Response group with the report.
 N ADDRESS,CITY,DATA,FULLADD,IBNAME,IBNAMEX,IBPIEN,INACTFLG,LN,MSG
 N SPACES,SITE,SITENAME,SITENO,STATE,STATION,SUBJ,TOTAL,TRANS,TRANSCD,XMINSTR,XMTO
 D BMES^XPDUTL(">> Sending Email...")
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Sending email notification to eBiz Rapid response group ... ")
 ;S SPACES=$J(" ",100)
 S $P(SPACES,"_",100)="_"
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENO=$P(SITE,U,1),STATION=$P(SITE,U,3)
 S SUBJ="PATCH IB*2.0*608 - Insurance Company EDI Report"_" for Station# "_$P(SITE,U,3)_" - "_$P(SITE,U,2)
 S SUBJ=$E(SUBJ,1,65)
 S MSG(1)="PATCH IB*2.0*608 - Insurance Company EDI Parameter Report"
 S MSG(2)=""
 S MSG(3)="Site: "_SITENO_" "_SITENAME_" - Station "_STATION
 S MSG(4)="Domain: "_$G(^XMB("NETNAME"))
 S MSG(5)="Date/Time: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S MSG(6)=""
 S MSG(7)="INSURANCE COMPANY__________________ADDRESS__________________________________________________________INACTIVE____EDI-TRANSMIT"
 S MSG(8)="============================================================================================================================"
 S MSG(9)=""
 S LN=10,IBNAME="",TOTAL=0
 F  S IBNAME=$O(^TMP(RNAME,$J,IBNAME)) Q:IBNAME=""  D
 . S IBPIEN=""
 . F  S IBPIEN=$O(^TMP(RNAME,$J,IBNAME,IBPIEN)) Q:IBPIEN=""  D
 . . S DATA=^TMP(RNAME,$J,IBNAME,IBPIEN)
 . . S IBNAMEX=$$UNSPACE($E(IBNAME,1,30))
 . . S ADDRESS=$$UNSPACE($E($P(DATA,U,1),1,30)),CITY=$$UNSPACE($E($P(DATA,U,2),1,25)),STATE=$$UNSPACE($P(DATA,U,3))
 . . S FULLADD=ADDRESS_", "_CITY_", "_STATE
 . . I '$L(ADDRESS),'$L(CITY),'$L(STATE) S FULLADD=""
 . . S INACTFLG=$P(DATA,U,4)
 . . S TRANS=$P(DATA,U,5)
 . . S LN=LN+1,MSG(LN)=IBNAMEX_$E(SPACES,1,35-$L(IBNAMEX))_FULLADD_$E(SPACES,1,68-$L(FULLADD))
 . . S MSG(LN)=MSG(LN)_INACTFLG_$E(SPACES,1,15-$L(INACTFLG))_TRANS
 . . S TOTAL=TOTAL+1
 S LN=LN+1,MSG(LN)=""
 S LN=LN+1,MSG(LN)="Total: "_+TOTAL
 S LN=LN+1,MSG(LN)=""
 S LN=LN+1,MSG(LN)="End of Report"
 ;
 ; ***testing email to vito,anne,cj,jane vs live*** must change back to live before putting in build ***
 ;S XMTO("vito.d'amico@domain.ext")=""
 ;S XMTO("anne.debacker@domain.ext")=""
 ;S XMTO("cherie.minch@domain.ext")=""
 ;S XMTO("jane.balchunas@domain.ext")=""
 ;S XMTO("william.jutzi@domain.ext")=""
 S XMTO("VHAeBillingRR@domain.ext")=""
 ;
 S XMINSTR("FROM")="VistA-eBilling"
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO,.XMINSTR)
 ;
EMAILX ;
 D MES^XPDUTL(" Done.")
 D CLEAN^DILF
 Q
 ;
UNSPACE(FLDX) ; Eliminate spaces at the end of the field.
 N I
 F  S I=$L(FLDX) Q:($E(FLDX,I)'=" ")  I $E(FLDX,I)=" " S FLDX=$E(FLDX,1,I-1)
 Q FLDX
 ;
CMNCPT ;Set CMN CPT CODES in IB System Parameters
 D MES^XPDUTL("Setting CMN CPT Codes in IB SITE PARAMETER file.....")
 N CODES,CPTCD,CPTIEN,CPTS,DA,DIC,DIE,DR,ERRMSG,FDA,I,RETIEN
 S CODES=""
 F I=1:1 S CPTS=$P($T(CPTCD+I),";;",2) Q:CPTS=""  S CODES=$S(CODES="":CPTS,1:CODES_U_CPTS)
 F I=1:1 S CPTCD=$P(CODES,U,I) Q:CPTCD=""  D
 . S CPTIEN=$$FIND1^DIC(81,,"X",CPTCD) Q:'CPTIEN
 . I $D(^IBE(350.9,1,16,"B",CPTIEN)) Q
 . K FDA,ERRMSG,RETIEN
 . S FDA(350.916,"+1,1,",.01)=CPTIEN
 . D UPDATE^DIE("","FDA","RETIEN","ERRMSG")
 D MES^XPDUTL(".....CMN CPT Codes set. ")
 Q
 ;
CPTCD ;
 ;;B4102^B4103^B4104^B4149^B4150^B4152^B4153^B4154^B4155^B4157^B4158^B4159^B4160^B4161^B4162^B4164^B4168
 ;;B4172^B4176^B4178^B4180^B4185^B4189^B4193^B4197^B4199^B4216^B5000^B5100^B5200^B9002^B9004^B9006^E0424
 ;;E0431^E0433^E0434^E0439^E0441^E0442^E0443^E0444^E0776^E0791^E1390^E1391^E1392^E1405^E1406^K0738
 ;
