MAGIPS99 ;Post init routine to queue site activity at install. ; 24 Jun 2008 3:12 PM
 ;;3.0;IMAGING;**99**;Mar 19, 2002;Build 2057;Apr 19, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
POST ;
 N CT,CNT,D,D0,D1,D2,DDATE,DG,DIC,DICR,DIW,MAGMSG,ST,XMID,XMY
 N MERGE
 ;
 S MERGE=$$CODEMERGE()
 ;
 D GETENV^%ZOSV
 S CNT=0
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE INSTALL"
 S CNT=CNT+1,MAGMSG(CNT)="SITE: "_$$KSP^XUPARAM("WHERE")
 S CNT=CNT+1,MAGMSG(CNT)="PACKAGE: "_XPDNM
 S CNT=CNT+1,MAGMSG(CNT)="Version: "_$$VER^XPDUTL(XPDNM)
 S ST=$$GET1^DIQ(9.7,XPDA,11,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Start time: "_$$FMTE^XLFDT(ST)
 S CT=$$GET1^DIQ(9.7,XPDA,17,"I") S:+CT'=CT CT=$$NOW^XLFDT()
 S CNT=CNT+1,MAGMSG(CNT)="Completion time: "_$$FMTE^XLFDT(CT)
 S CNT=CNT+1,MAGMSG(CNT)="Run time: "_$$FMDIFF^XLFDT(CT,ST,3)
 S CNT=CNT+1,MAGMSG(CNT)="Environment: "_Y
 S CNT=CNT+1,MAGMSG(CNT)="FILE COMMENT: "_$$GET1^DIQ(9.7,XPDA,6,"I")
 S CNT=CNT+1,MAGMSG(CNT)="DATE: "_$$NOW^XLFDT()
 S CNT=CNT+1,MAGMSG(CNT)="Installed by: "_$$GET1^DIQ(9.7,XPDA,9,"E")
 S CNT=CNT+1,MAGMSG(CNT)="Install Name: "_$$GET1^DIQ(9.7,XPDA,.01,"E")
 S DDATE=$$GET1^DIQ(9.7,XPDA,51,"I")
 S CNT=CNT+1,MAGMSG(CNT)="Distribution Date: "_$$FMTE^XLFDT(DDATE)
 S XMSUB=XPDNM_" INSTALLATION"
 S XMID=$G(DUZ) S:'XMID XMID=.5
 S XMY(XMID)=""
 S XMY("G.MAG SERVER")=""
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 S XMSUB=$E(XMSUB,1,63)
 D SENDMSG^XMXAPI(XMID,XMSUB,"MAGMSG",.XMY,,.XMZ,)
 I $G(XMERR) M XMERR=^TMP("XMERR",$J) S $EC=",U13-Cannot send MailMan message,"
 Q
 ;
CODEMERGE() ;
 ;P99 post-install code merge fixer
 ; MAGGTIA as installed in KIDS assumes no previous installs of 106/117 
 ; MAGZTEMP1 routine has the MAGGTIA with 106/117 code merge
 ; MAGZTEMP2 routine has the MAGGTIA with 106 code merge
 ; Both MAGZTEMP1 & MAGZTEMP2 will be deleted after install
 ; 
 N SCENARIO,SECLIN
 S SCENARIO=0
 I $$PATCH^XPDUTL("MAG*3.0*117") S SCENARIO=1
 I 'SCENARIO I $$PATCH^XPDUTL("MAG*3.0*106") S SCENARIO=2
 I SCENARIO=1 D SCEN1
 I SCENARIO=2 D SCEN2
 D CLEANUP
 ; Check the 2nd lines of MAGGTIA to confirm success
 S SECLINE=$P($T(+2^@"MAGGTIA"),";",5)
 I (SCENARIO=0&(SECLINE="**8,48,99")) Q 1
 I (SCENARIO=1&(SECLINE="**8,48,106,99**")) Q 1
 I (SCENARIO=2&(SECLINE="**8,48,106,99,117**")) Q 1
 Q -1
 ;
SCEN1 ;
 S X=$$DEL("MAGGTIA")
 D COPY("MAGZTEMP1","MAGGTIA")
 Q
SCEN2 ;
 S X=$$DEL("MAGGTIA")
 D COPY("MAGZTEMP2","MAGGTIA")
 Q
CLEANUP ;
 S X=$$DEL("MAGZTEMP1")
 S X=$$DEL("MAGZTEMP2")
 Q
 ;
COPY(FROM,TO) ;
 ;Cribbed & modified slightly from COPY^ZTMGRSET
 N ZTOS
 S ZTOS=$$OSNUM^ZTMGRSET() ;Determine local OS
 I ZTOS'=7,ZTOS'=8 X "ZL @FROM ZS @TO" Q
 ;For GT.M below
 N PATH,COPY,CMD S PATH=$$R
 S FROM=PATH_FROM_".m"
 S TO=PATH_$TR(TO,"%","_")_".m"
 S COPY=$S(ZTOS=7:"COPY",1:"cp")
 S CMD=COPY_" "_FROM_" "_TO
 X "ZSYSTEM CMD"
 Q
 ;
R() ; routine directory for GT.M
 ;Cribbed from R^ZTMGRSET
 N ZRO X "S ZRO=$ZRO"
 I ZTOS=7 D  Q $S(ZRO["(":$P($P(ZRO,"(",2),")"),1:ZRO)
 . S ZRO=$P(ZRO,",")
 . I ZRO["/SRC=" S ZRO=$P(ZRO,"=",2) Q  ;Source dir
 . S ZRO=$S(ZRO["/":$P(ZRO,"/"),1:ZRO) Q  ;Source and Obj in same dir
 I ZTOS=8 Q $P($S(ZRO["(":$P($P(ZRO,"(",2),")"),1:ZRO)," ")_"/" ;Use first source dir.
 E  Q ""
 ;
DEL(ROUTINE) ;
 N X
 S X=ROUTINE
 Q:X=-1  I $T(^@X)="" Q 0
 X ^%ZOSF("DEL")
 I $T(^@X)="" Q 1
 Q
