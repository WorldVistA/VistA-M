XPDIP ;SFISC/RSD - Install Package & Routine file ;03/08/2006
 ;;8.0;KERNEL;**15,21,28,30,41,44,51,58,83,92,100,108,137,229,350,393,517**;Jul 10, 1995;Build 6
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
PKG ;
 N %,OLDA,DA,DIK,XPD,XPDFIL,XPDPKG,XPDBLDA,Y
 ;update variable for graphic display
 I $D(XPDIDVT) S XPDIDTOT=10,XPDIDMOD=1,XPDIDCNT=0 D:XPDIDVT UPDATE^XPDID(0)
 ;XPDPKG=ien of Package file, OLDA=old Package ien
 S Y=$$PKGADD,XPDPKG=$P(Y,U),OLDA=$P(Y,U,2)
 ;Package file entry not sent, XPDPKG=0
 G:'XPDPKG PKGEND
 ;update version multiple
 S DA=XPDPKG D PKGV
PKGH I $D(XPDIDVT) S XPDIDCNT=XPDIDCNT+2 D UPDATE^XPDID(XPDIDCNT)
 S %=$P(^DIC(9.4,XPDPKG,0),U,4)
 ;repoint Help Frame (0;4)
 I $L(%),'% S $P(^DIC(9.4,XPDPKG,0),U,4)=$$LK^XPDIA("^DIC(9.2)",%),DIK="^DIC(9.4," D IX1^DIK
 ;update node 20 for Patient Merge
 N REC,IEN
 S REC=0
 F  S REC=$O(^XTMP("XPDI",XPDA,"PKG",OLDA,20,REC)) Q:'REC  D
 . ;;Only install if have a routine defined
 . K IEN I '$L($P($G(^XTMP("XPDI",XPDA,"PKG",OLDA,20,REC,0)),U,3)) Q
 . S IEN(9.402,"?+1,"_XPDPKG_",",.01)=$P($G(^XTMP("XPDI",XPDA,"PKG",OLDA,20,REC,0)),U,1)
 . S IEN(9.402,"?+1,"_XPDPKG_",",3)=$P($G(^XTMP("XPDI",XPDA,"PKG",OLDA,20,REC,0)),U,3)
 . S IEN(9.402,"?+1,"_XPDPKG_",",4)=$G(^XTMP("XPDI",XPDA,"PKG",OLDA,20,REC,1))
 . D UPDATE^DIE("","IEN")
 . Q
 ;
PKGEND S XPDBLDA=$$BLD(XPDBLD) Q:'XPDBLDA
 ;Move the Test/SEQ number from build to Install file.
 S ^XPD(9.7,XPDA,6)=$G(^XPD(9.6,XPDBLDA,6))
 ;move Alpha/Beta testing info to Kernel site para file
 I XPDPKG S %=$G(^XPD(9.6,XPDBLDA,"ABPKG")) D
 .;Install message and they have an address, set flag in XPDIST
 .I $P(%,U)="y",$P(%,U,2)="y",$L($P(%,U,3)) S $P(XPDIST,U,2)=$P(%,U,3)
 .D EN^XQABLOAD(XPDBLDA)
 Q
PKGADD() ;check Package file, add if not there
 ;return new Package file ien^old ien
 N DA,DIK,XPD,XPDFIL,XPDO,X,Y
 S DA=+$P(^XPD(9.7,XPDA,0),U,2),XPDO=+$O(^XTMP("XPDI",XPDA,"PKG",0)),X=$P($G(^(XPDO,0)),U)
 I DA,$D(^DIC(9.4,DA,0)) Q DA_U_XPDO
 ;quit if there was no package entry sent
 Q:'XPDO "0^0"
 S XPDFIL=9.4,Y=$$DIC^XPDIK(9.4,X) Q:'Y "0^0"
 S DA=+Y
 ;if new entry in package file, bring in everything
 I $P(Y,U,3) D
 .M ^DIC(9.4,DA)=^XTMP("XPDI",XPDA,"PKG",XPDO)
 .;kill the -1 flag node first
 .K ^DIC(9.4,DA,-1)
 .;re-cross ref after adding a new package
 .S DIK="^DIC(9.4," D IX1^DIK
 ;add package to file 9.7
 S XPD(9.7,XPDA_",",1)=DA D FILE^DIE("","XPD")
 Q DA_U_XPDO
 ;
BLD(XPDBLD) ;add Build entry, XPDBLD=Build ien in ^XTMP("XPDI",XPDA,"BLD",
 N %,DA,DIK,XPDFIL,Y
 I $D(XPDIDVT) S XPDIDCNT=XPDIDCNT+4 D UPDATE^XPDID(XPDIDCNT)
 ;XPDBLD=Build ien in ^XTMP, set in XPDIJ
 S XPDFIL=9.6,Y=$$DIC^XPDIK(9.6,XPDNM) Q:'Y ""
 S DA=+Y
 ;Build entry not new, remove old data
 I '$P(Y,U,3) S %=$P(^XPD(9.6,DA,0),U,2) K ^XPD(9.6,DA) K:% ^XPD(9.6,"C",%,DA)
 M ^XPD(9.6,DA)=^XTMP("XPDI",XPDA,"BLD",XPDBLD)
 ;reset Package File Link (0;2)
 ;XPDIST = national site tracking^A/B install message address
 S $P(^XPD(9.6,DA,0),U,2)=$S(XPDPKG:XPDPKG,1:"") S:$P(^(0),U,5)="y" XPDIST=1
 ;re-index cross-ref. on fields .01 and 1
 S DIK="^XPD(9.6," F Y=.01,1 S DIK(1)=Y D EN1^DIK
 I $D(XPDIDVT) D UPDATE^XPDID(XPDIDTOT)
 Q DA
 ;
 ;update the version multiple in the package file
PKGV N %
 I $D(XPDIDVT) S XPDIDCNT=XPDIDCNT+2 D UPDATE^XPDID(XPDIDCNT)
 ;%=ien in the Version multiple_U_ien in Patch multiple in ^XTMP
 S %=$G(^XTMP("XPDI",XPDA,"PKG",OLDA,-1))
 I XPDNM'["*" D  Q
 .S %=+% Q:'$D(^XTMP("XPDI",XPDA,"PKG",OLDA,22,%,0))  S %=^(0) S:$D(^(1)) %(1)=$NA(^(1))
 .S $P(%,U,3,4)=DT_U_DUZ,%=$$PKGVER(DA,.%)
 ;update patch history multiple
 Q:'$D(^XTMP("XPDI",XPDA,"PKG",OLDA,22,+%,"PAH",+$P(%,U,2),0))  S %=$P(^(0),U) S:$D(^(1)) %(1)=$NA(^(1))
 ;check File Comment, %=patch number
 S:^XPD(9.7,XPDA,2)[" SEQ #" %=$P(^(2),"*",3)
 S $P(%,U,2,3)=$$NOW^XLFDT()_U_DUZ,%=$$PKGPAT(DA,$$VER^XPDUTL(XPDNM),.%)
 Q
 ;
PKGVER(XPDPDA,XPDI) ;update version in package file, XPDPDA=Package file ien, return ien
 ;XPDI=version^date distr.^date installed^install by
 ;XPDI(1)=root of description field
 N I,X,XPD,XPDIEN,XPDJ,XPDV
 S XPDIEN=","_XPDPDA_",",XPDV=$$MDIC(9.49,XPDIEN,$P(XPDI,U)) Q:'XPDV 0
 S XPD(9.4,XPDPDA_",",13)=$P(XPDI,U),X="XPD(9.49,"""_XPDV_XPDIEN_""")"
 F I=1:1:3 S:$P(XPDI,U,I+1)]"" @X@(I)=$P(XPDI,U,I+1)
 S:$D(XPDI(1)) @X@(41)=XPDI(1)
 D FILE^DIE("","XPD")
 Q XPDV
 ;
PKGPAT(XPDPDA,XPDV,XPDI) ;update patch history
 ;INPUT: XPDPDA=Package file ien, XPDV=version
 ;XPDI=patch^date installed^install by
 ;RETURNS: version ien^patch ien^[CURRENT VERSION, if it was set]
 N I,X,XPD,XPDP,XPDIEN,CURVER
 ;quit if we can't find the version multiple, resets XPDV=ien of version
 S XPDIEN=","_XPDPDA_",",XPDV=$$MDIC(9.49,XPDIEN,XPDV) Q:'XPDV 0
 S XPDIEN=","_XPDV_XPDIEN,XPDP=$$MDIC(9.4901,XPDIEN,$P(XPDI,U)) Q:'XPDP 0
 S X="XPD(9.4901,"""_XPDP_XPDIEN_""")"
 F I=.02,.03 S:$P(XPDI,U,I*100)]"" @X@(I)=$P(XPDI,U,I*100)
 S:$D(XPDI(1)) @X@(1)=XPDI(1)
 ;if no CURRENT VERSION, set it
 I $G(^DIC(9.4,XPDPDA,"VERSION"))="" S XPD(9.4,XPDPDA_",",13)=XPDV,CURVER=XPDV
 D FILE^DIE("","XPD")
 Q XPDV_U_XPDP_U_$G(CURVER)
 ;
 ;XPDF=subfile #,XPDIEN=ien string, X=input
MDIC(XPDF,XPDIEN,XPDX) ;
 N DIERR,XPD,XPDN
 D FIND^DIC(XPDF,XPDIEN,"","XQf",XPDX,5,"","","","XPD")
 ;one or more matches, just return first one
 I $G(XPD(0)) D:XPD(0)>1  Q XPD(1)
 .N %
 .S %(1)=$P(^DD(XPDF,.01,0),U)_"  "_XPDX_"  is Duplicated,",%(2)=" only ien #"_XPD(1)_" was updated."
 .D MES^XPDUTL(.%)
 ;add a new entry
 S XPDN(XPDF,"+1"_XPDIEN,.01)=XPDX K XPD
 D UPDATE^DIE("","XPDN","XPD")
 I '$G(XPD(1)) D BMES^XPDUTL(" "_$P(^DD(XPDF,.01,0),U)_" "_XPDX_" **Couldn't Add to file**") Q 0
 Q XPD(1)
 ;
RTN ;move rtns to install file
 N XPD,XPDC,XPDCR,XPDI,XPDJ,XPDK,XPDL,XPDM,XPDR,XPDRH,X,NOW
 K ^XPD(9.7,XPDA,"RTN"),^TMP($J)
 S (XPDC,XPDCR,XPDRH)=0,XPDJ="",NOW=$$NOW^XLFDT()
 ;get all routines that were loaded, XPDM=action
 ;actions are 0=load, 1=delete, 2=skip
 F  S XPDJ=$O(^XTMP("XPDI",XPDA,"RTN",XPDJ)) Q:XPDJ=""  S XPDM=^(XPDJ) D:'XPDM
 .;XPD, build array to update ROUTINE multiple in INSTALL file
 .S XPDC=XPDC+1,^TMP($J,"XPDL",XPDC)=XPDC,^TMP($J,"XPD",9.704,"+"_XPDC_","_XPDA_",",.01)=XPDJ
 .;XPDR, build array to update ROUTINE file, Set install date
 .;S:'$D(^DIC(9.8,"B",XPDJ)) XPDCR=XPDCR+1,^TMP($J,"XPDR",9.8,"?+"_XPDCR_",",.01)=XPDJ,^(1)="R"
 .S XPDCR=XPDCR+1,^TMP($J,"XPDR",9.8,"?+"_XPDCR_",",.01)=XPDJ,^(1)="R",^(7.4)=NOW ;**229
 ;if we are doing VT graphic display, update only 40%
 I $D(XPDIDVT) S XPDIDCNT=XPDIDTOT*.4 D UPDATE^XPDID(XPDIDCNT)
 F XPDK="DIKZ","DIEZ","DIPZ" D
 .S XPDI=0
 .;loop thru list of compile template routines
 .;XTMP("XPDI",XPDA,"DIKZ",ien,routine name)
 .F  S XPDI=$O(^XTMP("XPDI",XPDA,XPDK,XPDI)),XPDJ="" Q:'XPDI  D
 ..I 'XPDRH D BMES^XPDUTL(" The following Routines were created during this install:") S XPDRH=1
 ..F  S XPDJ=$O(^XTMP("XPDI",XPDA,XPDK,XPDI,XPDJ)) Q:XPDJ=""  D:'$D(^XTMP("XPDI",XPDA,"RTN",XPDJ))
 ...S XPDC=XPDC+1,^TMP($J,"XPDL",XPDC)=XPDC,^TMP($J,"XPD",9.704,"+"_XPDC_","_XPDA_",",.01)=XPDJ
 ...D MES^XPDUTL("     "_XPDJ)
 ;update routine multiple in Install file with routines and
 ;compile template routines
 I $D(^TMP($J,"XPD"))>9 D
 .D UPDATE^DIE("","^TMP($J,""XPD"")","^TMP($J,""XPDL"")")
 .;if we are doing VT graphic display, update only 40%
 .I $D(XPDIDVT) S XPDIDCNT=XPDIDCNT+(XPDIDTOT*.40) D UPDATE^XPDID(XPDIDCNT)
 ;update Routine file
 D:$D(^TMP($J,"XPDR"))>9 UPDATE^DIE("","^TMP($J,""XPDR"")")
 ;if we are doing VT graphic display, update 100%
 I $D(XPDIDVT) D UPDATE^XPDID(XPDIDTOT)
 Q
