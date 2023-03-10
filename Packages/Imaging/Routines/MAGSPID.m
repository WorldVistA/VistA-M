MAGSPID ;WOIFO/SF,DAC,JSL - PATIENT DATA UTILITIES ; 22 Jul 2021 12:00 PM
 ;;3.0;IMAGING;**122,123,301**;Mar 19, 2002;Build 2;Oct 10, 2020
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
 ; This routine is used on both VistA and the DICOM Gateway
PIDLABEL() ;
 Q $S($$ISIHS():"HRN",1:"SSN")
 ;
DEM(LOC) ;For IHS, call DEM^VADPT but reset DUZ(2) to the instrument division
 ;this is because in IHS, patients have different chart numbers in each division
 ;this procedure can only be called on VistA or RPMs.  It cannot be called on a DICOM GW
 I $G(LOC)="" S LOC=DUZ(2)
 S TMPDUZ2=DUZ(2),DUZ(2)=LOC
 D DEM^VADPT ; Supported IA (#10061)
 S DUZ(2)=TMPDUZ2 K TMPDUZ2
 Q
 ;
ISIHS() ;Is this IHS site? (P123)
 ; This function is used on both VistA and the DICOM gateway
 ; In VistA DUZ("AG") will be used to determine if a site is an IHS site
 ; On the DICOM gateway the DICOM GATEWAY PARAMETER (#2006.563) file will be checked
 Q $S($G(DUZ("AG"))="I":1,$G(^MAGDICOM(2006.563,1,"AGENCY"))="I":1,1:0)
 ;
PROD(FORCE) ;;Check if it is the PRODUCTION TYPE - MAG WORK ITEM (field#4, Input Transform)
 N VERSION,LC,SID,SITE,Y,X
 ;
 I $$ISIHS=0 Q 0  ;VA site follows VA screen rule
 ; 
 I $$PROD^XUPROD($G(FORCE)) Q 1  ; IA #4440 
 ;
 S SITE=$S($G(DUZ(2)):DUZ(2),1:+$$SITE^VASITE)
 D BMES^XPDUTL("Imaging SITE is not the production, must run PROD^MAGSPID(1) for TEST account: "_SITE)
 ;
CHKNMSPC ;check IHS test/production account setting
 N MAGPL,NWNAME,NAME,MAGDA,FN,DIR
 S MAGPL=$$PLACE^MAGBAPI(SITE)  ;PLACE#2006.1
 I 'MAGPL D LNOIS^MAGUSIT Q 0   ;Need set the MAG site #2006.1 for SITE
 S NWNAME=$P(^MAG(2006.1,+MAGPL,0),U,2)  ;current namespace
 S NAME=$$KSP^XUPARAM("WHERE"),MAGDA=$O(^MAG(2006.19,"B",NAME,""))
 S FN=$S('MAGDA:$$UNDEF^MAGUSIT(NAME),1:$P($G(^MAG(2006.19,MAGDA,0)),U,4))
 I FN="ZZT" D                   ;user specified TEST account, add namespace over real one
 . S DIR(0)="Y",DIR("B")="YES",DIR("A")="Accept the defaults Namespace: "_FN D ^DIR
 . I 'Y K DIR S DIR(0)="F:1:3",DIR("A")="Enter your Test namespace " D ^DIR
 . I ($L(Y)=3),(FN'=NWNAME) S FN=Y  ;new namespace
 . Q
 I (FN="")!($G(Y)="^") D LNOIS^MAGUSIT Q 0  ;; Error issue
 D:NWNAME'=FN PNMSP^MAGUSIT(MAGPL,FN)       ;; add new namespace
 S $P(^XTV(8989.3,1,"SID"),U,1)=1 Q 1       ;; Allow IHS site for MAG WORK ITEM (TEST/PRO) 
 Q 0
