RCXVSRV ;DAOU/ALA-AR Data Extract Server Program
 ;;4.5;Accounts Receivable;**201**;Mar 20, 1995
 ;
 ;**Program Description**
 ;  This program will parse an incoming message
 ;  either as an acknowledgement or as a request
 ;  for a historical extract
 ;
EN ;  Entry point
 K ^TMP("ARCXV")
 S RCXMZ=XMZ,VJOB=$J K ^TMP("RCXVSRV",VJOB)
 S CT=0 F  D  Q:XMER'=0
 . X XMREC Q:XMER'=0
 . S CT=XMPOS
 . S ^TMP("RCXVSRV",VJOB,CT)=$G(XMRG)
 ;
REC ;  Process a record
 S N="",LFN=1
 F  S N=$O(^TMP("RCXVSRV",VJOB,N)) Q:N=""  D
 . I $G(^TMP("RCXVSRV",VJOB,N))["ACK|"!($G(^TMP("RCXVSRV",VJOB,N))["HIS|") S LFN=N
 ;
 S XMRG=$G(^TMP("RCXVSRV",VJOB,LFN)) I XMRG="" Q
 S ^TMP("ARCXV","XMRG")=$G(XMRG)
 ;  If the type of message is not an ACK (acknowledgement)
 ;  or a HIS (historical extract request), quit
 S RCXVTYP=$P(XMRG,"|")
 I RCXVTYP'["ACK"&(RCXVTYP'["HIS") Q
 ;
ACK I RCXVTYP["ACK" D
 . S RCXVNAME=$P(XMRG,"|",2),RCVALUE=$P(XMRG,"|",3),RCFRWD=$P(XMRG,"|",4)
 . S RCXVNAME=$$UP^XLFSTR(RCXVNAME),RCVALUE=$$UP^XLFSTR(RCVALUE)
 . I RCVALUE'["AA" Q
 . S RCXVNAME=$P(RCXVNAME,".TXT",1)
 . I $E(RCXVNAME,1,4)'="RCXV" S RCXVNAME="RCXV"_$P(RCXVNAME,"RCXV",2)
 . S RCXVBTN=$E(RCXVNAME,15,$L(RCXVNAME))
 . ;
 . S ^TMP("ARCXV","BATCH")=$G(RCXVBTN)
 . S ^TMP("ARCXV","FILE")=$G(RCXVNAME)
 . S ^TMP("ARCXV","XMZ")=$G(RCXMZ)
 . S ^TMP("ARCXV","FDOM")=$G(RCFRWD)
 . ;
 . S RCXVLEG=$$GET1^DIQ(342,"1,",20.07,"I")
 . I '+RCXVLEG,$G(RCFRWD)'="" D FWD Q
 . ;  Find the IEN of the batch number
 . K ^TMP("RCXVA",VJOB)
 . D FIND^DIC(348.4,"","","OP",RCXVBTN,"","B","","","^TMP(""RCXVA"",VJOB)")
 . S RCXVDA=$P($G(^TMP("RCXVA",VJOB,"DILIST",0)),U,1)
 . S ^TMP("ARCXV","DA")=$G(RCXVDA)
 . I +RCXVDA=0 Q
 . S DA=$P($G(^TMP("RCXVA",VJOB,"DILIST",RCXVDA,0)),U,1)
 . I +DA=0 Q
 . S RCXVUP(348.4,DA_",",.09)=$$NOW^XLFDT(),RCXVUP(348.4,DA_",",.03)="C"
 . D FILE^DIE("I","RCXVUP","RCXVERR")
 ;
 I RCXVTYP["HIS" D
 . S RCXVFFD=$P(XMRG,"|",2),RCXVFTD=$P(XMRG,"|",3)
 . S RCXVFFD=$$DATE^RCXVUTIL(RCXVFFD)
 . S RCXVFTD=$$DATE^RCXVUTIL(RCXVFTD)
 . ;
 . ;  Get the next Saturday date
 . S CURDT=$$DT^XLFDT()
 . S CDOW=$$DOW^XLFDT(CURDT,1),NDAYS=6-CDOW
 . S FDATE=$$FMADD^XLFDT(CURDT,NDAYS)
 . ;
 . ;  Set up TaskMan
 . S RCVXDSC="CBO HISTORICAL EXTRACT"
 . S ZTDESC=RCVXDSC,ZTRTN="HIS^RCXVTSK",ZTIO=""
 . S ZTSAVE("RCXVFTD")="",ZTSAVE("RCXVFFD")=""
 . S ZTDTH=FDATE_".06"
 . D ^%ZTLOAD
 ;
EXIT K RCXVDA,DA,RCXVUP,RCXVFFD,RCXVFTD,CURDT,CDOW,NDAYS,FDATE,ZTSK
 K ZTDESC,RCXVDSC,ZTSAVE,ZTDTH,ZTIO,ZTRTN,RCXVTYP,RCXVNAME,RCVALUE
 K CT,LFN,N,XMER,XMPOS,XMREC,XMRG,XMZ,RCFRWD,RCVXDSC,RCXMZ,RCXVBTN
 K ^TMP("RCXVA",VJOB),^TMP("RCXVSRV",VJOB),VJOB,XMY,RCXVLEG
 Q
 ;
FWD ;  Forward the mail message
 I $G(DUZ)="" S DUZ=.5
 I $G(XMZ)="" S XMZ=RCXMZ
 S XMY(RCFRWD)=""
 D ENT2^XMD
 Q
