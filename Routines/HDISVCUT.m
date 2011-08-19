HDISVCUT ;CT/GRR ; 19 Apr 2006  10:57 AM
 ;;1.0;HEALTH DATA & INFORMATICS;**6**;Feb 22, 2005
BLDSTAT(HDISFILE,HDISFN,HDISSC,HDISSDT,HDISARRY) ;
 N HDISOUT,CODE,HDISTDTX,Y
 I HDISFILE=""!(HDISFN="")!(HDISARRY="") S HDISOUT=0_"^Parameter Missing" G QUIT
 K @HDISARRY
 S DIC=7115.3,DIC(0)="Z",X="DOMAIN STATUS UPDATE" D ^DIC K DIC
 I Y<0 S HDISOUT=0_"^DOMAIN STATUS UPDATE Template Missing" G QUIT
 S HDIST=+Y,HDISY=Y,HDISY(0)=Y(0)
 S HDISSRC=$P($$SITE^VASITE(),"^",3)
 S HDISPROD=$$PROD^XUPROD()
 S HDISTDTX=$$FMTXML^HDISVU01(HDISSDT,"","")
 S HDISMD=$G(^XMB("NETNAME"))
 S @HDISARRY@(1)="<?xml version=""1.0"" encoding=""utf-8"" ?>"
 ;S @HDISARRY@(1)=$$XMLHDR^XOBVLIB()
 S @HDISARRY@(2)="<"_$P(HDISY(0),"^",4)_" "_$G(^HDIS(7115.3,HDIST,1))_">"
 N Z K Z D ZINIT
 S Z(20)=HDISSRC
 S Z(22)=HDISPROD
 S Z(30)=HDISMD
 S Z(60)=HDISFILE
 S Z(70)=HDISFN
 S Z(80)=HDISSC
 S Z(90)=HDISTDTX
 D XMLOUT^HDISXML(HDIST,"20,22,30,60,70,80,90,10/","Z",HDISARRY,.HDERR)
 S HDISOUT=1
QUIT Q HDISOUT
 ;
ZINIT S Z(22)="" F Z=10:10:100 S Z(Z)=""
 Q
 ;
 ;
BLDSND(HDISFILE,HDISFN,HDISSTCD,HDISSDT,HDISARRY,HDISINP) ;
 ;Updating of central server disabled (return success)
 I $$GETSDIS^HDISVF03() Q 1
 N HDISOUT
 S:HDISSDT="" HDISSDT=DT
 S:HDISARRY="" HDISARRY=$NA(^TMP("HDISSBUILD",$J))
 S HDISOUT=$$BLDSTAT(HDISFILE,HDISFN,HDISSTCD,HDISSDT,HDISARRY)
 I 'HDISOUT Q HDISOUT
 S HDISOUT=$$SNDXML^HDISVM02(HDISARRY,2,HDISINP)
 Q HDISOUT
 ;
STATUPD(FILE,FIELD,CODE,DATE) ;Encompassing local status update call
 ; Input : FILE - File number
 ;         FIELD - Field number (defaults to .01)
 ;         CODE - Status code to set (defaults to "not started")
 ;         DATE - FileMan date/time to return status for (optional)
 ;                (defaults to NOW)
 ;Output : 1 = Success     0^Text = Failure
 ; Notes : This call will update the local status, build the Status
 ;         Update XML document, and forward the Status Update XML
 ;         document to the centralized server
 ;       : If time is not included with the date, 1 second past
 ;         midnight will be used as the time
 ;       : If an entry for the given file/field and date/time already
 ;         exists, the existing entry will be updated to reflect the
 ;         given status
 N XMLARR,TMPARR,OUTPUT
 ;Check input
 S FILE=+$G(FILE)
 I 'FILE Q "0^Parameter FILE was not passed"
 S FIELD=+$G(FIELD)
 I 'FIELD S FIELD=.01
 S CODE=+$G(CODE)
 S DATE=+$G(DATE)
 I 'DATE S DATE=$$NOW^XLFDT()
 I '$P(DATE,".",2) S $P(DATE,".",2)="000001"
 ;Update local status
 D SETSTAT^HDISVF01(FILE,FIELD,CODE,DATE,1)
 ;Updating of central server disabled (return success)
 I $$GETSDIS^HDISVF03() Q 1
 ;Create status update xml doc and send to central server
 S XMLARR=$NA(^TMP("HDISVCUT",$J,"XML"))
 S TMPARR=$NA(^TMP("HDISVCUT",$J,"HDISINP"))
 K @XMLARR,@TMPARR
 S OUTPUT=$$BLDSND^HDISVCUT(FILE,FIELD,CODE,DATE,XMLARR,TMPARR)
 K @XMLARR,@TMPARR
 Q OUTPUT
 ;
VUID(HDDOM,HDROUT) ;Instantiate VUIDs for set of code fields
 ; Input:
 ;     HDDOM - Domain Name (i.e. ORDERS)
 ;     HDROUT - Routine containing VUID Sets-Of-Code data (i.e. HDI1005B)
 ;Output: 0 = Stop post-install (error)
 ;        1 = Continue with post-install
 N HDIMSG
 S HDIMSG(1)=" "
 S HDIMSG(2)="Seeding XTID VUID FOR SET OF CODES file (#8985.1) with "_HDDOM_" data"
 S HDIMSG(3)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$VUIDL^HDISVU02(HDDOM,HDROUT) Q 0
 Q 1
 ;
UPDTDOM(HDDOM,HDISDFFS) ;Add Domain info to the HDIS DOMAIN file
 ;
 ; Input: HDDOM - Domain Name
 ;        HDISDFFS - Array containing File number set equal to Field Number (optional, .01 assumed)
 ;                      (i.e.   HDISDFFS(100.01)="")
 ;Output: HDISERR - Set to 1 when error incurred
 N HDIEN,HDIMSG
 S HDIMSG(1)=" "
 S HDIMSG(2)="Adding "_HDDOM_" Domain and related fields to"
 S HDIMSG(3)="HDIS DOMAIN file (#7115.1)"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$FINDDOM^HDISVF09(HDDOM,.HDISDFFS,1,.HDISDIEN,.HDISERRM) D  Q 0
 .N HDIEN,HDIMSG
 .S HDIMSG(1)=" "
 .S HDIMSG(2)="Error occurred when updating HDIS DOMAIN file."
 .S HDIMSG(3)=HDISERRM
 .S HDIMSG(4)="  "
 .D MES^XPDUTL(.HDIMSG) K HDIMSG
 Q 1
 ;
 ;
TESTACT() ;Set's the HDIS SYSTEM file fields to reflect a mirrored test account and remove any multiple entries
 ;
 ;Check file for multiple entries and delete if found
 ;PATCH 6
 ;
 I $O(^HDISF(7118.21,1))>0 D  ;multiple entries found
 .N IEN,FDA,DA,DIK
 .S IEN=1
 .F  S IEN=$O(^HDISF(7118.21,IEN)) Q:IEN'>0  D
 ..S DA=IEN
 ..S DIK="^HDISF(7118.21,"
 ..D ^DIK
 K FDA(1)
 S FDA(1,7118.21,"?+1,",.01)=$P($G(^HDISF(7118.21,1,0)),"^",1)
 S FDA(1,7118.21,"?+1,",.02)=$G(^XMB("NETNAME"))
 S FDA(1,7118.21,"?+1,",.03)=$$PROD^XUPROD()
 D UPDATE^DIE("","FDA(1)","RSLT","ERR(1)")
 Q 1
 ;
