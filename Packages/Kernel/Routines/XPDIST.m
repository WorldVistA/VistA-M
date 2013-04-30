XPDIST ;SFISC/RSD - site tracking ;03/05/2008
 ;;8.0;KERNEL;**66,108,185,233,350,393,486,539,547**;Jul 10, 1995;Build 15
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ;Returns ""=failed, XMZ=sent
 ;D0=ien in file 9.7, XPY=national site tracking^address(optional)
EN(D0,XPY) ;EF. send message
 N %,DIFROM,XPD,XPD0,XPD1,XPD2,XPDV,XPZ,X,X1,Z,Y,XPD6,XPDTRACK
 ;Get data needed
 I '$D(^XPD(9.7,$G(D0),0)) D BMES^XPDUTL(" INSTALL file entry missing") Q ""
 ;p350 -add node 6 for the Test# and Seq#. -REM
 S XPD0=^XPD(9.7,D0,0),XPD1=$G(^(1)),XPD2=$G(^(2)),XPD6=$G(^(6))
 I '$P(XPD0,U,2) D BMES^XPDUTL(" No link to PACKAGE file") Q ""
 S XPD=$P($G(^DIC(9.4,+$P(XPD0,U,2),0)),U),XPDV=$$VER^XPDUTL($P(XPD0,U))
 I XPD="" D BMES^XPDUTL(" PACKAGE file entry missing") Q ""
 ;XPZ(1)=start, XPZ(2)=completion date/time, XPZ(3)=run time
 S XPZ(1)=$P(XPD1,U),XPZ(2)=$P(XPD1,U,3),XPZ(3)=$$FMDIFF^XLFDT(XPZ(2),XPZ(1),3),XPZ(1)=$$FMTE^XLFDT(XPZ(1)),XPZ(2)=$$FMTE^XLFDT(XPZ(2))
 D LOCAL
 S XPDTRACK=$$TRACK
 D REMEDY ;p350 -REM
 Q $$FORUM()
LOCAL ;Send a message to local mail group
 N XMY,XPDTEXT,XMTEXT,XMDUZ,XMSUB,XMZ
 K ^TMP($J)
 S X=$$MAILGRP^XPDUTL(XPD) Q:X=""
 S XMY(X)="" D GETENV^%ZOSV
 ;Message for users
 S XPDTEXT(1,0)="PACKAGE INSTALL"
 S XPDTEXT(2,0)="SITE: "_$G(^XMB("NETNAME"))
 S XPDTEXT(3,0)="PACKAGE: "_XPD
 S XPDTEXT(4,0)="VERSION: "_XPDV
 S XPDTEXT(5,0)="Start time: "_XPZ(1)
 S XPDTEXT(6,0)="Completion time: "_XPZ(2)
 S XPDTEXT(7,0)="Environment: "_Y
 S XPDTEXT(8,0)="Installed by: "_$P($G(^VA(200,+$P(XPD0,U,11),0)),U)
 S XPDTEXT(9,0)="Install Name: "_$P(XPD0,U)
 S XPDTEXT(10,0)="Distribution Date: "_$$FMTE^XLFDT($P(XPD1,U,4))
 S XMDUZ=$S($P(XPD0,U,11):+$P(XPD0,U,11),1:.5),XMTEXT="XPDTEXT(",XMSUB=$P(XPD0,U)_" INSTALLATION"
 D ^XMD
 Q
TRACK() ;EF. Should VA track the installation of this patch at a national level?
 Q:$G(XPY)="" 0  ; No - National site tracking was not requested
 ;Quit if not VA production primary domain
 I $G(^XMB("NETNAME"))'[".domain.ext" D BMES^XPDUTL(" Not a VA primary domain") Q 0
 ;X ^%ZOSF("UCI") S %=^%ZOSF("PROD")
 ;S:%'["," Y=$P(Y,",")
 ;I Y'=% D BMES^XPDUTL(" Not a production UCI") Q ""
 ; 486/GMB Replaced the above 3 lines with the following line:
 I '$$PROD^XUPROD D BMES^XPDUTL(" Not a production UCI") Q 0
 Q 1
REMEDY ;Send to Remedy Server - ESSRESOURCE@DOMAIN.EXT *p350 -REM
 Q:'XPDTRACK
 N XMY,XPDTEXT,XMTEXT,XMDUZ,XMSUB,XMZ
 K ^TMP($J)
 S:XPY XMY("ESSRESOURCE@DOMAIN.EXT")=""
 S:$L($P(XPY,U,2)) XMY($P(XPY,U,2))=""
 ;Message for server (all in one string)
 ;XMTEXT=Type(1),Domain(2-65),Pkg(66-95),Version(96-125),
 ;       StartTime(126-147),CompleteTime(148-169),RunTime(170-177),
 ;       Date(178-199),InstalledBy(200-229),InstallName(230-259),
 ;       DistributionDate(260-281),Seq#(282-286),
 ;       PatchTestVersion(287-317)
 ;
 S X1=1_$G(^XMB("NETNAME")) ;Type is always "1"(1=patch,0=pkg).
 S $E(X1,66,95)=XPD,$E(X1,96,125)=XPDV,$E(X1,126,147)=XPZ(1),$E(X1,148,169)=XPZ(2),$E(X1,170,177)=XPZ(3),$E(X1,178,199)=DT
 S $E(X1,200,229)=$P($G(^VA(200,+$P(XPD0,U,11),0)),U),$E(X1,230,259)=$P(XPD0,U),$E(X1,260,281)=$P(XPD1,U,4),$E(X1,282,286)=$P(XPD6,U,2),$E(X1,287,317)=$P(XPD6,U)
 S XPDTEXT(1,0)=X1
 S XMDUZ=$S($P(XPD0,U,11):+$P(XPD0,U,11),1:.5),XMTEXT="XPDTEXT(",XMSUB="KIDS-"_$P(XPD0,U)_" INSTALLATION"
 D ^XMD
 Q
FORUM() ;EF. send to Server on FORUM
 Q:'XPDTRACK ""
 N XMY,XPDTEXT,XMTEXT,XMDUZ,XMSUB,XMZ
 K ^TMP($J)
 S:XPY XMY("S.A5CSTS@FORUM.domain.ext")=""
 S:$L($P(XPY,U,2)) XMY($P(XPY,U,2))=""
 ;Message for server
 S XPDTEXT(1,0)="PACKAGE INSTALL"
 S XPDTEXT(2,0)="SITE: "_$G(^XMB("NETNAME"))
 S XPDTEXT(3,0)="PACKAGE: "_XPD
 S XPDTEXT(4,0)="VERSION: "_XPDV
 S XPDTEXT(5,0)="Start time: "_XPZ(1)
 S XPDTEXT(6,0)="Completion time: "_XPZ(2)
 S XPDTEXT(7,0)="Run time: "_XPZ(3)
 S XPDTEXT(8,0)="DATE: "_DT
 S XPDTEXT(9,0)="Installed by: "_$P($G(^VA(200,+$P(XPD0,U,11),0)),U)
 S XPDTEXT(10,0)="Install Name: "_$P(XPD0,U)
 S XPDTEXT(11,0)="Distribution Date: "_$P(XPD1,U,4)
 S XPDTEXT(12,0)=XPD2
 S XPDTEXT(13,0)=+XPD6
 S XMDUZ=$S($P(XPD0,U,11):+$P(XPD0,U,11),1:.5),XMTEXT="XPDTEXT(",XMSUB=$P(XPD0,U)_" INSTALLATION"
 D ^XMD
 Q "#"_$G(XMZ)
 ;
CHKS(XPDPH,XPDTEXT) ;Get Checksum from Forum for patch XPDPH, XPDTEXT is passed by reference
 ;returns XPDTEXT(routine name)= before checksum
 ;need to create parameter to store url - future
 Q
 K ^TMP($J,"XPDTHC")
 Q:$G(XPDPH)=""
 N XPDCHK,XPDHDR,XPDURL,I,X,Y
 S XPDURL="http://127.0.0.1:6100/cgi/PCHCSUM?PCH="_XPDPH,XPDCHK=0
 S X=$$GETURL^XTHC10(XPDURL,,$NA(^TMP($J,"XPDTHC")),.XPDHDR)
 I X>0 D
 . S I=""
 . F  S I=$O(^TMP($J,"XPDTHC",I)) Q:I=""  S X=$G(^(I)) D:$E(X,1,4)="<li>"
 .. S Y=$P($P(X,"</li>"),U,4),X=$P($P(X,"<li>",2),U),XPDTEXT(X)=Y,XPDCHK=XPDCHK+1
 . Q
 S XPDTEXT=XPDCHK
 K ^TMP($J,"XPDTHC")
 Q
