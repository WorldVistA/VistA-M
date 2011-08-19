HDISVF09 ;ALB/RMO,ALB/GRR - 7115.1 File Utilities/API Cont.; 2/1/06@09:56:00
 ;;1.0;HEALTH DATA & INFORMATICS;**6**;Feb 22, 2005
 ;
 ;---- Begin HDIS Domain file (#7115.1) API(s) ----
 ;
FINDDOM(HDISDOM,HDISDFFS,HDISADDF,HDISDIEN,HDISERRM) ;Find or Add a New Domain Entry
 ; Input  -- HDISDOM  Domain Name
 ;           HDISDFFS Domain File/Field Array  (Optional)
 ;                    Pass by HDISDFFS(File #)=Field # (Field # optional- Default .01)
 ;                    Example: HDISDFFS(100.1)=""
 ;           HDISADDF Add a New Entry Flag  (Optional- Default 0)
 ;                    1=Yes and 0=No
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISDIEN  HDIS Domain file IEN
 ;           If Failure:
 ;           HDISERRM  Error Message  (Optional)
 N HDISOKF
 ;Initialize output
 S (HDISDIEN,HDISERRM)=""
 ;Check for missing variable, exit if not defined
 I $G(HDISDOM)="" D  G FINDDOMQ
 . S HDISERRM="Unable to Find or Add Domain.  Required Variable Missing."
 ;Check for existing Domain, return entry and exit if it exists
 I $D(^HDIS(7115.1,"B",HDISDOM)) D  G FINDDOMQ:$G(HDISDIEN)
 . S HDISDIEN=$O(^HDIS(7115.1,"B",HDISDOM,0))
 . S HDISOKF=1
 ;If flag set, Add a New Domain Entry
 I $G(HDISADDF) S HDISOKF=$$ADDDOM(HDISDOM,.HDISDFFS,.HDISDIEN,.HDISERRM)
FINDDOMQ Q +$G(HDISOKF)
 ;
ADDDOM(HDISDOM,HDISDFFS,HDISDIEN,HDISERRM) ;Add a New Domain Entry
 ; Input  -- HDISDOM  Domain Name
 ;           HDISDFFS Domain File/Field Array  (Optional)
 ;                    Pass by HDISDFFS(File #)=Field # (Field # optional- Default .01)
 ;                    Example: HDISDFFS(100.1)=""
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISDIEN  HDIS Domain file IEN
 ;           If Failure:
 ;           HDISERRM  Error Message  (Optional)
 N HDISFDA,HDISIEN,HDISMSG,HDISOKF
 ;Initialize output
 S (HDISDIEN,HDISERRM)=""
 ;Check for missing variable, exit if not defined
 I $G(HDISDOM)="" D  G ADDDOMQ
 . S HDISERRM="Unable to Add Domain.  Required Variable Missing."
 ;Check for existing Domain, return error and exit if it exists
 I $D(^HDIS(7115.1,"B",HDISDOM)) D  G ADDDOMQ
 . S HDISERRM="Domain already exists."
 ;Set array for Domain Name
 S HDISFDA(7115.1,"+1,",.01)=$G(HDISDOM)
 D UPDATE^DIE("E","HDISFDA","HDISIEN","HDISMSG")
 ;Check for error
 I $D(HDISMSG("DIERR")) D
 . S HDISERRM=$G(HDISMSG("DIERR",1,"TEXT",1))
 ELSE  D
 . S HDISDIEN=+$G(HDISIEN(1))
 . S HDISOKF=1
 D CLEAN^DILF
 ;If Domain File/Field Array is passed, Add Domain File/Fields
 I $G(HDISDIEN)>0,$D(HDISDFFS) S HDISOKF=$$ADDDFFS(HDISDIEN,.HDISDFFS,.HDISERRM)
ADDDOMQ Q +$G(HDISOKF)
 ;
ADDDFFS(HDISDIEN,HDISDFFS,HDISERRM) ;Add Domain File/Fields
 ; Input  -- HDISDIEN HDIS Domain file (#7115.1) IEN
 ;           HDISDFFS Domain File/Field Array
 ;                    Pass by HDISDFFS(File #)=Field # (Field # optional- Default .01)
 ;                    Example: HDISDFFS(100.1)=""
 ; Output -- 1=Successful and 0=Failure
 ;           If Failure:
 ;           HDISERRM  Error Message  (Optional)
 N HDISCNT,HDISFARY,HDISFDA,HDISFFNM,HDISFIEN,HDISFILN,HDISFLDN,HDISIEN,HDISMSG,HDISOKF
 ;Initialize output
 S HDISERRM=""
 ;Check for missing variables, exit if not defined
 I $G(HDISDIEN)'>0!('$D(HDISDFFS)) D  G ADDDFFSQ
 . S HDISERRM="Unable to Add Domain File/Fields.  Required Variable Missing."
 ;Add a new File/Field Entry
 S HDISFILN=0
 F  S HDISFILN=$O(HDISDFFS(HDISFILN)) Q:'HDISFILN  D  G ADDDFFSQ:HDISERRM'=""
 . ;Set Field Number to default of .01, if not defined
 . S HDISFLDN=$S($G(HDISDFFS(HDISFILN))>0:$G(HDISDFFS(HDISFILN)),1:.01)
 . I $$ADDFFNM^HDISVF05(HDISFILN,HDISFLDN,.HDISFIEN,.HDISERRM) D  Q:HDISERRM'=""
 . . S HDISFARY(HDISFIEN)=""
 . ELSE  D
 . . ;Set error message, if unable to add file/field
 . . S HDISERRM="Unable to Add File/Field "_HDISFILN_"~"_HDISFLDN_"."
 ;
 ;Set array for File/Field
 S HDISFIEN=0
 S HDISCNT=1
 F  S HDISFIEN=$O(HDISFARY(HDISFIEN)) Q:'HDISFIEN  I $D(^HDIS(7115.6,HDISFIEN,0)) S HDISFFNM=$P(^(0),"^",1) D
 . S HDISCNT=HDISCNT+1
 . S HDISFDA(7115.11,"+"_HDISCNT_","_HDISDIEN_",",.01)=HDISFFNM
 D UPDATE^DIE("E","HDISFDA","HDISIEN","HDISMSG")
 ;Check for error
 I $D(HDISMSG("DIERR")) D
 . S HDISERRM=$G(HDISMSG("DIERR",1,"TEXT",1))
 ELSE  D
 . S HDISOKF=1
ADDDFFSQ Q +$G(HDISOKF)
 ;
GETFILS(HDISDIEN,HDISCODE,HDISFILS) ;Get an Array of Files by Domain and Client Status Code
 ; Input  -- HDISDIEN HDIS Domain file (#7115.1) IEN
 ;           HDISCODE Client Status Code  (Optional- Default 0=Not Started for Client)
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISFILS Array Subscripted by File # (i.e. HDISFILS(120.8)="")
 N HDISFIEN,HDISFILN,HDISFLDN
 ;Initialize ouput
 K HDISFILS
 ;Check for missing variable, exit if not defined
 I $G(HDISDIEN)'>0 G GETFILSQ
 ;Set Status Code to default of 0=Not Started for Client, if needed
 S HDISCODE=$S('$D(HDISCODE):0,1:HDISCODE)
 ;Check Status of File/Fields and build array
 S HDISFIEN=0
 F  S HDISFIEN=$O(^HDIS(7115.1,HDISDIEN,"FILE","B",HDISFIEN)) Q:'HDISFIEN  D
 . I $$GETFF^HDISVF05(HDISFIEN,.HDISFILN,.HDISFLDN),$P($$GETSTAT^HDISVF01(HDISFILN,HDISFLDN),"^",1)=HDISCODE D
 . . S HDISFILS(HDISFILN)=""
GETFILSQ Q +$S($D(HDISFILS):1,1:0)
 ;
GETIEN(HDISDOM,HDISDIEN) ;Get IEN for a Domain by Domain
 ; Input  -- HDISDOM  Domain Name
 ; Output -- 1=Successful and 0=Failure
 ;           If Successful:
 ;           HDISDIEN HDIS Domain file IEN
 ;Initialize ouput
 S HDISDIEN=""
 ;Check for missing variable, exit if not defined
 I $G(HDISDOM)="" G GETIENQ
 ;Check for entry by Domain
 S HDISDIEN=$O(^HDIS(7115.1,"B",HDISDOM,0))
GETIENQ Q +$S($G(HDISDIEN)>0:1,1:0)
 ;
 ;---- End HDIS Domain file (#7115.1) API(s) ----
 ;
 ;Error processing utility
 ;
ERR(HDISP1,HDISP2,HDISP3) ;
 ;;Input: HDISP1 - Network Name (parameter 1 of bulletin)
 ;;       HDISP2 - Date/Time (parameter 2 of bulletin)
 ;;       HDISP3 - Error Message (parameter 3 of bulletin)
 ;;Output: None
 ;;
 N HDISP,HDISTASK,NAME,ERRARR,HDISE
 S HDISE="" S ERRARR="HDISE",HDISE(1)=""
 S HDISP(1)=HDISP1
 S Y=HDISP2 D DD^%DT S HDISP(2)=Y
 S HDISP(3)=HDISP3
 S NAME="HDIS ERRORS"
 S HDISFLAG("FROM")="HDIS DS Client"
 D TASKBULL^XMXAPI(DUZ,NAME,.HDISP,ERRARR,,.HDISFLAG,.HDISTASK)
 I $G(XMERR) D
 .;Error generating bulletin - log error text
 .D ERR2XTMP^HDISVU01("HDI-XM","General error bulletin",$NA(^TMP("XMERR",$J)))
 .K XMERR,^TMP("XMERR",$J)
 Q
 ;
ERTBULL(HDISP1,HDISP2,HDISP3,HDISP4,HDISP5,HDISP6) ;
 N ERRARR,HDISP,NAME,HDISFLAG,HDISTASK
 S ERRARR=$NA(^TMP("HDIS ERRORS",$J)),^TMP("HDIS ERRORS",$J,1)=""
 S HDISP(1)=HDISP1
 S HDISP(2)=HDISP2
 N Y S Y=HDISP3 D DD^%DT
 S HDISP(3)=Y
 S HDISP(4)=HDISP4
 S HDISP(5)=HDISP5
 S HDISP(6)=HDISP6
 S NAME="HDIS NOTIFY ERT"
 S HDISFLAG("FROM")="HDIS Data Standardization Server"
 D TASKBULL^XMXAPI(DUZ,NAME,.HDISP,ERRARR,,.HDISFLAG,.HDISTASK)
 I $G(XMERR) D
 .;Error generating bulletin - log error text
 .D ERR2XTMP^HDISVU01("HDI-XM","ERT bulletin",$NA(^TMP("XMERR",$J)))
 .K XMERR,^TMP("XMERR",$J)
 Q
 ;
MFSUP(HDISFILE,HDISERR,HDISFN) ; Update status to complete and send HDR Bulletin
 ;;Input: HDISFILE - File Number of file just updated  (Required)
 ;;       HDISERR - Error indicator from MFS (1 or 0) (Required)
 ;;       HDISFN - Field number (Optional)
 ;;       
 ;;Output: None
 N HDISCODE,HDISARRY,HDISOUT,HDISNM,HDISMESS,FILE,HDISTASK,NAME,OOPS,SYSTYPE,TMP
 S HDISCODE=$$GETSTAT^HDISVF01(HDISFILE)
 S FILE=HDISFILE
 Q:$P(HDISCODE,"^",1)'=4&($P(HDISCODE,"^",1)'=5)
 S HDISARRY=$NA(^TMP("HDIS STATUS",$J))
 I $G(HDISERR) S HDISNM=$G(^XMB("NETNAME")) D ERR^HDISVF09(HDISNM,$$NOW^XLFDT(),"Error from MFS") S HDISOUT=$$BLDSND^HDISVCUT(HDISFILE,.01,5,$$NOW^XLFDT(),HDISARRY,"") D SETSTAT^HDISVF01(HDISFILE,.01,5,$$NOW^XLFDT()) Q
 S HDISOUT=$$BLDSND^HDISVCUT(HDISFILE,.01,6,$$NOW^XLFDT(),HDISARRY,"")
 I HDISOUT=0 S HDISMESS="Staus update to complete failed",HDISNM=$G(^XMB("NETNAME")) D ERR^HDISVF09(HDISNM,$$NOW^XLFDT(),HDISMESS) Q
 D SETSTAT^HDISVF01(HDISFILE,.01,6,$$NOW^XLFDT())
 I HDISOUT=0 S HDISMESS="Staus update to complete failed",HDISNM=$G(^XMB("NETNAME")) D ERR^HDISVF09(HDISNM,$$NOW^XLFDT(),HDISMESS) Q
 ;Notify HDR that triggers should be turned on
 N FACPTR,FACNAME,FACNUM,DOMAIN,SYSTYP,FILENAME,HDISBDT
 S OOPS=0
 I '$$GETFAC^HDISVF07(,.FACPTR) S OOPS=1
 I '$$GETDIP^HDISVF07(,.DOMAIN) S OOPS=1
 I '$$GETTYPE^HDISVF07(,,.SYSTYPE) S OOPS=1
 I OOPS=1 D
 .S FACPTR=$$FACPTR^HDISVF01()
 .S DOMAIN=$G(^XMB("NETNAME"))
 .S SYSTYPE=$$PROD^XUPROD()
 .S SYSTYPE=$S(SYSTYPE:"PRODUCTION",1:"TEST")
 S TMP=$$NS^XUAF4(FACPTR)
 S FACNAME=$P(TMP,"^",1)
 S FACNUM=$P(TMP,"^",2)
 I (FACNAME="")!(FACNUM="") D
 .S TMP=$$SITE^VASITE()
 .S FACNAME=$P(TMP,"^",2)
 .S FACNUM=$P(TMP,"^",3)
 S FACNAME=FACNAME_" (#"_FACNUM_") with Domain/IP Address "_DOMAIN
 S FILENAME=$$GET1^DID(FILE,,,"NAME")
 S FILENAME=FILENAME_" (#"_FILE_")"
 S HDISBDT=$$NOW^XLFDT()
 S ERRARR=$NA(^TMP("HDIS ERRORS",$J)),^TMP("HDIS ERRORS",$J,1)=""
 N HDISP
 S HDISP(1)=FACNAME
 S HDISP(2)=FILENAME
 N Y S Y=$$NOW^XLFDT() D DD^%DT
 S HDISP(3)=Y
 S HDISP(4)=SYSTYPE
 S HDISP(5)=FACNUM
 S HDISP(6)=FILE
 S NAME="HDIS NOTIFY HDR"
 S HDISFLAG("FROM")="HDIS Data Standardization Server"
 D TASKBULL^XMXAPI(DUZ,NAME,.HDISP,ERRARR,,.HDISFLAG,.HDISTASK)
 I $G(XMERR) D
 .;Error generating bulletin - log error text
 .D ERR2XTMP^HDISVU01("HDI-XM","HDR bulletin",$NA(^TMP("XMERR",$J)))
 .K XMERR,^TMP("XMERR",$J)
 Q
