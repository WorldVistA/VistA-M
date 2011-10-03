GMRCYP57 ;BP/WAT - POST INSTALL FOR GMRC*3*57 ;JUL 24, 2007 0830
 ;;3.0;CONSULT/REQUEST TRACKING;**57**;DEC 27, 1997;Build 10
 ;
 ;This patch creates a new entry into the Request Services file, #123.5.
 ;This new entry supports the entering of IFCs originating from the VA's Suicide Prevention Hotline
 ;External References
 ;$$LKUP^XUAF4(): Institution Lookup, ICR # 2171
 ;BMES^XPDUTL(): Output a Message, ICR# 10141
 ;^DIC
 ;MIX^DIC1
 ;UPDATE^DIE
 ;^DIK
 ;SVC^GMRC101H
 ;MSG^XQOR
 ;****LOCAL VARIABLES****
 ;FDA - FileMan Data Array
 ;GMRCERR - array to hold any errors returned by UPDATE^DIE
 ;GMRCIEN - Internal Entry Number Array - used to return the IEN of the newly added service and pass that IEN to the second UPDATE^DIE call as part of the FDA(2) array
 N FDA,GMRC,ERR,GMRCIEN,STAIEN,ERRMSG
 S ERRMSG(1)="INSTALL ABORTED - NO CHANGES WERE MADE TO YOUR SYSTEM."
 S ERRMSG(2)="COULD NOT FIND ""UPSTATE NEW YORK HCS"" IN INSTITUTION FILE"
 S ERRMSG(3)="CONFIRM FILE ENTRY AND RE-INSTALL"
 S ERRMSG(4)="IF STILL UNSUCCESSFUL, CONTACT VA NAT'L HELP DESK OR SUBMIT REMEDY TICKET"
 S STAIEN=$$LKUP^XUAF4(528) ;return IEN from INSTITUTION file for this station number
 I 'STAIEN D BMES^XPDUTL(ERRMSG)
 Q:'STAIEN
 D ADDENTRY
 D AD2ALSVC
 D ORDUPDT
 Q
ADDENTRY ; add new service to 123.5
 S FDA(1,123.5,"+1,",.01)="SUICIDE HOTLINE"
 S FDA(1,123.5134,"+2,+1,",.01)=STAIEN
 S FDA(1,123.5,"+1,",2)="2"
 D UPDATE^DIE("","FDA(1)","GMRCIEN","GMRCERR($J)")
 Q
AD2ALSVC ;add new service as sub-serivce of All Services
 S FDA(2,123.5,"?1,",.01)="ALL SERVICES"
 S FDA(2,123.51,"+4,?1,",.01)=$P(GMRCIEN(1),U,1)
 D UPDATE^DIE("","FDA(2)","GMRCIEN","GMRCERR($J)")
 Q
ORDUPDT ;update orderable items file with new service entry
 ;GMRCSRVC - ien of new service, GMRCSSNM - name of new service
 N DIC,GMRCMSG,GMRCSRVC,GMRCSSNM,GMRCACT
 S DIC="^GMR(123.5,",DIC(0)="B",X="SUICIDE HOTLINE" D ^DIC Q:Y=-1
 S GMRCSRVC=$P(Y,U)
 S GMRCSSNM=$P(Y,U,2)
 S GMRCACT="MUP"
 D SVC^GMRC101H(GMRCSRVC,GMRCSSNM,GMRCACT),MSG^XQOR("GMRC ORDERABLE ITEM UPDATE",.GMRCMSG)
 K X,Y
 Q
PRE ;clean up and old entries of SUICIDE CONSULTS from previous test versions
 N DIC,DIK,DA,SVCIEN,SBSVCIEN,SVCIENSH
 ;SVCIEN - IEN of "ALL SERVICES"
 ;SBSVCIEN - IEN corresponding to SUICIDE HOTLINE entry in SUBSERVICE of ALL SERVICES
 ;SVCIENSH - IEN of 'SUICIDE HOTLINE"
 S DIC="^GMR(123.5,",DIC(0)="B",X="ALL SERVICES" D ^DIC
 Q:Y=-1  S SVCIEN=$P(Y,U) K X,Y
 ;now i have IEN for all services
 S DIC="^GMR(123.5,1,10,",DIC(0)="",D="AC",X="SUICIDE HOTLINE" D MIX^DIC1
 ;1st piece is subservice ien, 2nd piece is top leve ien for suicide hotline
 Q:Y=-1
 S SBSVCIEN=$P(Y,U),SVCIENSH=$P(Y,U,2) K X,Y,D
 ;now i have ien for suicide subservice and ien for suicide top level entry
 ;remove suicide as a subservice of all services
 S DIK="^GMR(123.5,"_SVCIEN_",10,",DA=SBSVCIEN,DA(1)=SVCIEN D ^DIK
 Q:Y=-1
 N GMRCMSG,GMRCSRVC,GMRCSSNM,GMRCACT
 S DIC="^GMR(123.5,",DIC(0)="B",X="SUICIDE HOTLINE" D ^DIC Q:Y=-1
 S GMRCSRVC=$P(Y,U)
 S GMRCSSNM=$P(Y,U,2)
 S GMRCACT="MDC"
 D SVC^GMRC101H(GMRCSRVC,GMRCSSNM,GMRCACT),MSG^XQOR("GMRC ORDERABLE ITEM UPDATE",.GMRCMSG)
 ;remove suicide from 123.5
 S DIK="^GMR(123.5,",DA=SVCIENSH D ^DIK
 K X,Y
 Q
