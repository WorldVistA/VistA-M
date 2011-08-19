MDCVT1 ; HOIFO/NCA - Medicine Package Conversion (Cont.) ;1/6/05  15:12
 ;;1.0;CLINICAL PROCEDURES;**5**;Apr 01, 2004;Build 1
 ; Integration Agreements:
 ; IA# 4630 [Subscription] Calls to GMRCCP.
 ; IA# 3535 [Subscription] Calls to TIUSRVP.
 ; IA# 4508 [Subscription] Call to TIUSRVPT.
 ; IA# 4588 [Subscription] Call to MAGMC2CP
 ; IA# 2729 [Supported] Calls to XMXAPI.
 ; IA#10063 [Supported] %ZTLOAD routine calls.
 ;
CONVERT(MDNOD,MDGLB) ; [Function] Convert Medicine Report to TIU Document
 ; Input parameters
 ;  1. MDNOD [Literal/Required] 
 ;  2. MDGLB [Reference/Required] 
 ;
 ; Returns the TIU Note IEN
 ; or 0 if report is skipped because Convert flag is set to "NO" or Report Converted
 ; or -1^Error message
 ; (Note: Error messages will be filed in Subfile 703.92 field .1)
 ;
 N MDCONV,MDEX,MDFIEN,MDFILE,MDFLG,MDGN,MDP,MDPROC,MDRES,MDTITL,MDUSER,MDX
 S (MDGN,MDP)=MDNOD
 S (MDEX,MDRES)="",MDFLG=0
 S MDFIEN=+MDP Q:'MDFIEN "-1^No IEN for "_MDP
 S MDFILE=+$P(MDP,"MCAR(",2) Q:'MDFILE "-1^No File Number for "_MDP
 I $O(^MDD(702,"ACONV",MDFIEN_";MCAR("_MDFILE_",",0)) Q "-1^Already Converted."
 S MDPAT=$$GET1^DIQ(MDFILE,MDFIEN_",","MEDICAL PATIENT","I")
 I 'MDPAT S MDPAT=$$GET1^DIQ(MDFILE,MDFIEN_",","PATIENT","I")
 I 'MDPAT Q "-1^No Medical Patient."
 ; Get Medicine Parameter
 S MDPROC=$G(^MDD(703.9,1,1,MDFILE,0))
 ; Get CP Definition and Convert?
 S MDCONV=$P(MDPROC,"^",3) I '+MDCONV D SKIP^MDCVT(MDP,"CONVERT Y/N flag set to No.") Q 0
 S MDTITL=$P(MDPROC,"^",5) S:'MDTITL MDTITL=$$LOCATN^MDSTATU(MDGN)
 Q:MDTITL'>0 "-1^No Historical Note Title."
 S MDPROC=$P(MDPROC,"^",2) S:'MDPROC MDPROC=$$LOCATP^MDSTATU(MDGN)
 Q:'MDPROC "-1^No CP definition for "_MDP
 S MDUSER=$P($G(^MDD(703.9,1,0)),U,3) I 'MDUSER Q "-1^No Administrative Closure User Designated."
 ; Get Existing TIU Note
 S MDX=$O(^MDD(703.9,1,2,"B",MDP,0))
 I +MDX S MDX=$G(^MDD(703.9,1,2,+MDX,0))
 I +$P(MDX,"^",3) S MDEX=+$P(MDX,"^",3) Q MDEX
 ; Create TIU Note
 S MDRES=$$NEWTIU(MDFILE,MDPAT,MDFIEN,MDPROC,MDTITL,MDUSER,.MDGLB) I +MDRES<1 D LOGERR^MDCVT(MDP,$P(MDRES,"^",2)) S $P(MDRES,"^")=-1 Q MDRES
 Q +MDRES
 ;
NEWTIU(MDFILE,MDPAT,MDFIEN,MDPROC,MDTITL,MDU,MDGLB) ; [Function] Create New TIU Note for Medicine Reports
 ; Input parameters
 ;  1. MDFILE [Literal/Required] 
 ;  2. MDPAT [Literal/Required] 
 ;  3. MDFIEN [Literal/Required] 
 ;  4. MDPROC [Literal/Required] 
 ;  5. MDTITL [Literal/Required]
 ;  6. MDGLB [Reference/Required] 
 ;
 N MDADD,MDCHKI,MDCODE,MDD,MDDT,MDERR,MDFDA,MDIEN,MDIENS,MDK,MDLOC,MDNOTE,MDRET,MDSSTR,MDVST,MDVSTR,MDWP
 ; Get Hospital Location
 S MDLOC=$$HOSP^MDSTATU(MDFIEN_";MCAR("_MDFILE)
 I 'MDLOC S MDLOC=$$GET1^DIQ(702.01,+MDPROC_",",.05,"I")
 Q:'MDLOC "0^No Hospital Location."
 S MDCODE=$$GET1^DIQ(MDFILE,MDFIEN_",","SUMMARY","I")
 I MDCODE'="" S MDCODE=$S(MDCODE="N":1,MDCODE="A":2,MDCODE="B":3,MDCODE="MI":2,MDCODE="MO":2,MDCODE="S":2,1:4)
 E  S MDCHKI=$$CHKINT(MDFILE,MDFIEN),MDCODE=$S(+MDCHKI:(MDCHKI+4),1:"")
 S MDDT=$$GET1^DIQ(MDFILE,MDFIEN_",",.01,"I")
 ; Set Un-dictated status
 ;S MDWP(.05)=1
 ; Set Author/Dictator and Entered By
 ;S MDWP(1202)=MDU,MDWP(1302)=MDU
 ; Set Procedure Summary Code and Date/Time of Procedure
 S MDWP(70201)=MDCODE,MDWP(70202)=MDDT
 F MDK=0:0 S MDK=$O(@MDGLB@(MDK)) Q:'MDK  S MDWP("TEXT",MDK,0)=$G(@MDGLB@(MDK))
 D NOW^%DTC S MDD=% K %
 S MDFDA(702,"+1,",.01)=MDPAT
 S MDFDA(702,"+1,",.02)=MDD
 S MDFDA(702,"+1,",.03)=DUZ
 S MDFDA(702,"+1,",.04)=MDPROC
 S MDFDA(702,"+1,",.09)=4  ; Status = Checked-In
 D UPDATE^DIE("","MDFDA","MDIEN","MDERR") Q:$D(MDERR)
 S MDRET=$$EN1^MDPCE(MDIEN(1),MDDT,MDPROC_"^"_MDLOC,"E","A")
 I +MDRET S MDVST=+MDRET,MDSSTR=$P(MDRET,"^",2),MDVSTR=$P(MDSSTR,";",3)_";"_$P(MDSSTR,";",2)_";"_$P(MDSSTR,";")
 I +MDRET<1 D DELETE(MDIEN(1)) Q MDRET
 S MDNOTE="" D MAKE^TIUSRVP(.MDNOTE,MDPAT,MDTITL,$P(MDVSTR,";",2),MDLOC,MDVST,.MDWP,MDVSTR,1,1)
 ; Add the TIU Document Reference
 S MDIENS=MDIEN(1)_","
 I +MDNOTE S MDFDA(702,MDIENS,.06)=MDNOTE D FILE^DIE("","MDFDA","MDERR")
 I +MDNOTE'>0 D DELETE(MDIEN(1))
 Q MDNOTE
 ;
UPD(MDGB,MDNOD,MDTI,MDT) ; Do consults and Imaging update and log response
 N MDCONS,MDECON,MDUSR,MDEFLG,MDIMG,MDNOTE,MDR,MDR1,MDRET,MDSTUD,MDTT,MDWP,MDX1 S (MDEFLG,MDRET)=0
 ; Get the existing study
 ;
 S MDSTUD=$O(^MDD(702,"ATIU",+MDTI,0)) Q:'MDSTUD
 ;
 ;Get existing consult
 ;
 S MDECON=$$GET1^DIQ(702,MDSTUD_",",.05,"I")
 ;
 ; Get Administrative Closure Person
 ;
 S MDUSR=$P($G(^MDD(703.9,1,0)),U,3) Q:'MDUSR
 S MDTT=$S(+$G(MDT)>0:0,1:1)
 S MDCONS=$$CVTCONS^MDCVT1(MDTT,MDNOD,+MDTI)
 I +MDCONS<0&($P(MDCONS,U,2)'["No MC results sent") D LOGERR^MDCVT(MDNOD,"Consults error: "_$P(MDCONS,U,2)) Q
 I +MDCONS>0 K MDWP I +$P(MDCONS,U,3) D  Q:MDEFLG
 .S MDWP(1405)=+$P(MDCONS,U,3)_";GMR(123,"
 .D UPDATE^TIUSRVP(.MDNOTE,+MDTI,.MDWP,1)
 .I +MDNOTE<1 D LOGERR^MDCVT(MDNOD,"COULDN'T UPDATE THE NOTE") S MDEFLG=1 Q
 .I +$P(MDCONS,U,3) S MDFDA(702,MDSTUD_",",.05)=+$P(MDCONS,U,3) D FILE^DIE("","MDFDA")
 .Q
 ; Do imaging update and log response
 Q:$$GET1^DIQ(702,MDSTUD_",",.09,"I")=3
 I $O(@MDGB@(2005,0)) D  Q:MDRET<0  ; Quit on Imaging error
 .S (MDIMG,MDX1)=0
 .F  S MDX1=$O(@MDGB@(2005,MDX1)) Q:'MDX1  D  Q:MDRET<0
 ..S MDIMG=+@MDGB@(2005,MDX1,0)
 ..S MDRET=$$CVTIMG(MDTT,MDNOD,MDTI,MDIMG)
 ..D:MDRET<0 LOGERR^MDCVT(MDNOD,"Imaging error: "_$P(MDRET,U,2))
 Q:MDRET<0  K MDFDA S MDFDA(702,MDSTUD_",",.09)=3,MDFDA(702,MDSTUD_",",.3)=MDNOD D FILE^DIE("","MDFDA") W "."
 ;
 ; Close the record with Administrative Closure
 S (MDR,MDR1)=""
 I +MDTI D ADMNCLOS^TIUSRVPT(.MDR,+MDTI,"M",MDUSR) I '+MDR D DELETE^TIUSRVP(.MDR1,+MDTI) D LOGERR^MDCVT(MDNOD,"Can't Administrative close document")
 Q
PROC(MDX5,MDX6) ; Get Medicine Procedure Name
 N LL,LL6,LL8
 I MDX5="MCAR(699" S LL=$P($G(^MCAR(699,MDX6,0)),U,12) Q:LL'>0  S LL=$P($G(^MCAR(697.2,+LL,0)),U) Q LL
 I MDX5="MCAR(699.5" D
 .S LL6=$P($G(^MCAR(699.5,MDX6,0)),U,6),LL8=$P($G(^MCAR(699.5,MDX6,0)),U,8)
 .S LL=$P($G(^MCAR(699.5,MDX6,0)),U,6) Q:'LL  S LL=$P($G(^MCAR(697.2,LL,0)),U) Q LL
 I MDX5[694 S LL=$P($G(^MCAR(694,MDX6,0)),U,3) Q:'LL  S LL=$P(^MCAR(697.2,LL,0),U) Q LL
 S LL=$O(^MCAR(697.2,"C",MDX5,0)),LL=$P(^MCAR(697.2,LL,0),U,1)
 Q LL
CVTIMG(MDTST,MDN,MDTIU,MDIMAGES) ; Call Imaging API
 Q $$TIU^MAGMC2CP(MDTST,MDN,MDTIU,.MDIMAGES)
CVTCONS(MDTST,MDN,MDTIU) ; Call Consults API
 Q $$MCCNVT^GMRCCP(MDTST,MDN,MDTIU)
CHKINT(MDFL,MDMREC) ; Check to see if record from Medical Device
 ; Returns 1 or 0
 N MDN1,MDF
 I MDFL=691 S MDN1=$G(^MCAR(691,+MDMREC,10,0)) I +$P(MDN1,U,3)&($P(MDN1,U,3)>1) Q 1
 I MDFL=691.1 S MDN1=$G(^MCAR(691.1,+MDMREC,43,0)) I +$P(MDN1,U,3)&($P(MDN1,U,3)>1) Q 1
 I MDFL=691.5 S MDN1=$G(^MCAR(691.5,+MDMREC,9,0)) I +$P(MDN1,U,3)&($P(MDN1,U,3)>1) Q 1
 I MDFL=691.6 S MDN1=$G(^MCAR(691.6,+MDMREC,7,0)) I +$P(MDN1,U,3)&($P(MDN1,U,3)>1) Q 1
 I MDFL=691.8 S MDN1=$G(^MCAR(691.8,+MDMREC,12,0)) I +$P(MDN1,U,3)&($P(MDN1,U,3)>1) Q 1
 I MDFL=698.3 S MDN1=$G(^MCAR(698.3,+MDMREC,10,0)) I +$P(MDN1,U,3)&($P(MDN1,U,3)>1) Q 1
 I MDFL=699 S MDN1=$G(^MCAR(699,+MDMREC,33,0)) I +$P(MDN1,U,3)&($P(MDN1,U,3)>1) Q 1
 I MDFL=700 S MDF=0 D  Q:MDF 1
 .S MDN1=$G(^MCAR(700,+MDMREC,25,0))
 .I +$P(MDN1,U,3)&($P(MDN1,U,3)>1) S MDF=1 Q
 .S MDN1=$G(^MCAR(700,+MDMREC,3,0))
 .I +$P(MDN1,U,3)&($P(MDN1,U,3)>1) S MDF=1 Q
 .S MDN1=$G(^MCAR(700,+MDMREC,4,0))
 .I +$P(MDN1,U,3)&($P(MDN1,U,3)>1) S MDF=1 Q
 I +$P($G(^MCAR(MDFL,+MDMREC,2005,0)),U,4)>0 Q 1
 Q 0
BLD() ; Build the list of reports to convert
 W ! K DIR S DIR(0)="YA",DIR("A")="Build the list of reports to convert? "
 S DIR("A",1)="You can rebuild the list to check for new Medicine Reports that"
 S DIR("A",2)="may have been added since the last time you ran the Build Conversion List.",DIR("B")="NO" D ^DIR K DIR
 ;
 Q:Y<1 1  ; User said no to re-build
 Q:$D(DIRUT)!$D(DIROUT)!(Y<1) 0  ; User has cancelled
 ;
 K DIR S DIR(0)="YA",DIR("A")="Queue the conversion list build? ",DIR("B")="YES" D ^DIR K DIR
 I Y=0 D QBLD Q 1  ; User has opted to do it now
 I Y=1 D  Q 0  ; User has queued the build
 .S ZTRTN="QBLD^MDCVT1"
 .S ZTDESC="Medicine Conversion List Build"
 .S ZTREQ="@",ZTSAVE("ZTREQ")="",MDQUE=1,MDDUZ=DUZ,ZTSAVE("MDDUZ")="",ZTSAVE("MDQUE")=""
 .S (ZTDTH,ZTIO)=""
 .D ^%ZTLOAD
 .I $G(ZTSK) W "Task Queued"
 .E  W "Task Cancelled"
 Q 0  ; User cancelled out of the queueing
 ;
QBLD ; Queued entry point for re-build
 L +(^MDD(703.9,1,2)):5 E  Q
 N MDGBL,MDPTR,MDFDA,MDFL,MDIEN,MDY,X2
 S X2="" F  S X2=$O(^MDD(703.9,1,1,X2)) Q:X2=""  S MDY=$G(^(X2,0)) D
 .Q:'+$P(MDY,U,3)
 .S MDFL=$P(MDY,U),MDGBL="^MCAR("_MDFL_",""B"")"
 .F  S MDGBL=$Q(@MDGBL) Q:MDGBL=""  Q:$QS(MDGBL,2)'="B"  D
 ..Q:'$P($G(^MCAR(MDFL,+$QS(MDGBL,4),0)),U,2)
 ..S MDPTR=$QS(MDGBL,4)_";MCAR("_MDFL_","
 ..D SYNC^MDCVT(MDPTR)
 L -(^MDD(703.9,1,2))
 I +$G(MDQUE) D
 .N TXT,XMTO,XMBODY,XMDUZ,XMSUBJ
 .S XMINSTR("FROM")=.5,XMSUBJ="Conversion List"
 .S XMTO=$G(MDDUZ) Q:'XMTO
 .S TXT(1)="The Queued Conversion List is finished."
 .S TXT(2)="You can run the Medicine report conversion process.",XMBODY="TXT"
 .D SENDMSG^XMXAPI(DUZ,XMSUBJ,XMBODY,XMTO,.XMINSTR)
 .K MDQUE,MDDUZ
 Q
DELETE(MDIN) ; Delete study upon unsuccessful Note Creation
 N MDFDA
 S MDFDA(702,MDIN_",",.01)=""
 D FILE^DIE("","MDFDA")
 N DA,DIK S DA=+MDIN,DIK="^MDD(702," D ^DIK
 Q
TOTALS(MDSTAT) ; Count by Status
 S MDSTAT("E")=0
 S MDSTAT("E")=MDSTAT("TOT")-(MDSTAT("S")+MDSTAT("CR")+MDSTAT("CT"))
 W @IOF,!,"Conversion Totals",!,$TR($J("",35)," ","-")
 W !,"Converted REAL Mode: ",$J(+$G(MDSTAT("CR")),9)
 W !,"Converted TEST Mode: ",$J(+$G(MDSTAT("CT")),9)
 W !,"Skipped:             ",$J(+$G(MDSTAT("S")),9)
 W !,"Error:               ",$J(+$G(MDSTAT("E")),9)
 Q
