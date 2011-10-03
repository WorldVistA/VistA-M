XPDIK ;SFISC/RSD - Install Kernel Files & FM Files ;04/26/2004  11:20
 ;;8.0;KERNEL;**15,58,108,124,146,346**;Jul 10, 1995
 Q
KRN ;
 ;XPDA=package ien in INSTALL FILE, XPDNM=package name, XPDCP= check points
 N DA,DIC,DIOVRD,EPOS,EPRE,FDEL,FPOS,FPRE,OLDA,ORD,X,XGCEDITR,XPDFIL,XPDFILNM,XPDFL,XPDNEW,XREF,Y,%
 ;DIOVRD is used to override write protection on a file
 ;XGCEDITR is check in file 8995, at 'SCR' node of DD
 S ORD=0,XPDCP="KRN",(DIOVRD,XGCEDITR)=1
 F  S ORD=$O(^XTMP("XPDI",XPDA,"ORD",ORD)) Q:'ORD  S XPDFIL=+$O(^(ORD,0)),XREF=$G(^(XPDFIL)),XPDFILNM=$G(^(XPDFIL,0)) D:XPDFIL
 .;sets up EPOS,EPRE,FDEL,FPOS,FPRE variables
 .F DA=1:1:5 S @$P("FPRE^EPRE^FPOS^EPOS^FDEL",U,DA)=$P(XREF,";",DA+5)
 .K DIC,^TMP($J,"XPDEL")
 .S DIC=$G(^DIC(XPDFIL,0,"GL")),XREF=+$P(XREF,";",3)
 .;check if file, XPDFIL, exist at this site
 .I $P($G(^DIC(XPDFIL,0)),U)'=XPDFILNM D BMES^XPDUTL(" File "_XPDFIL_" is not "_XPDFILNM_", nothing installed.") Q
 .;check if XPDFIL has already been installed
 .I $P(^XPD(9.7,XPDA,"KRN",XPDFIL,0),U,2) D BMES^XPDUTL(" "_XPDFILNM_" already installed.") Q
 .D BMES^XPDUTL(" Installing "_XPDFILNM),SETTOT^XPDID(XPDFIL)
 .;do File Pre-install action, continue if ok
 .;XPDFL= 0-send,1-delete,2-link,3-merge,4-attach,5-disable
 .;loops thru the entries for this file
 .I '$$ACT(FPRE) S OLDA=0 F  S OLDA=$O(^XTMP("XPDI",XPDA,"KRN",XPDFIL,OLDA)) Q:'OLDA  S XPDFL=+$G(^(OLDA,-1)),OLDA(0)=^(0) D
 ..;if we are doing VT graphic display, set counter
 ..I $D(XPDIDVT) S XPDIDCNT=XPDIDCNT+1 D:'(XPDIDCNT#XPDIDMOD) UPDATE^XPDID(XPDIDCNT)
 ..;quit if disable or attach (4 or 5).  Attach will be processed under the parent menu.
 ..Q:XPDFL>3
 ..;if FM file, need to set screening logic
 ..I XPDFIL<.44 S %=$S(XPDFIL'=.403:4,1:8),DIC("S")="I $P(^(0),U,"_%_")="_$P(OLDA(0),U,%)
 ..;if deleting at site and a template, reset the lookup value and DIC("S")
 ..I XPDFL=1,XPDFIL<.44 S %=$P(OLDA(0),U),$P(OLDA(0),U)=$P(%,"    FILE #"),DIC("S")="I $P(^(0),U,"_$S(XPDFIL'=.403:4,1:8)_")="_+$P(%,"    FILE #",2)
 ..;XPDNEW=1 if entry is new, laygo
 ..S X=$P(OLDA(0),U),Y=$$DIC(XPDFIL,X,$G(DIC("S")),XPDFL) Q:'Y  S DA=+Y,XPDNEW=$P(Y,U,3)
 ..;if deleting then save and process after FPOS
 ..I XPDFL=1 S ^TMP($J,"XPDEL",DA)="" Q
 ..;do Entries Pre-install action
 ..Q:$$ACT(EPRE)
 ..;merges the data, if you want the data deleted before the merge, you must
 ..;do it in the Entry Pre-install node, EPRE.
 ..M @(DIC_DA_")")=^XTMP("XPDI",XPDA,"KRN",XPDFIL,OLDA)
 ..;kill the flag node from the live data node
 ..K @(DIC_DA_",-1)") Q:$$ACT(EPOS)
 ..;XREF is flag to x-ref file after each entry, it is set in file 9.6
 ..I XREF N DIK S DIK=DIC D IX1^DIK
 .;do File Post Install Action
 .S %=$$ACT(FPOS)
 .;process the deleting of entries, FDEL should allow the passing of all entries
 .;to delete in array ^TMP($J,"XPDEL",DA)=""
 .I $L(FDEL),$D(^TMP($J,"XPDEL")) S %="^TMP($J,""XPDEL"")" D @FDEL
 .;complete check point
 .S %=$$XPCOM(XPDFIL)
 .K ^TMP($J,"XPDEL")
 .I $D(XPDIDVT) D UPDATE^XPDID(XPDIDCNT)
 Q
FIA ;
 ;XPFIL2=file is new^DD screen failed^data already exists^change file name^don't add data; 1=yes, 0=no
 N XPGR,XPFIL,XPFILO,XPFIL2,Z
 S XPFIL=0,XPGR=$NA(^XTMP("XPDI",XPDA))
 F  S XPFIL=$O(^XTMP("XPDI",XPDA,"FIA",XPFIL)) Q:'XPFIL  S XPFILO=^(XPFIL,0,1),XPFIL2=^(2) D
 .;if we are doing VT graphic display, set counter
 .I $D(XPDIDVT) S XPDIDCNT=XPDIDCNT+1 D:'(XPDIDCNT#XPDIDMOD) UPDATE^XPDID(XPDIDCNT)
 .;file is new, alway install DD
 .S:XPFIL2 $P(XPFILO,U)="y",$P(^XTMP("XPDI",XPDA,"FIA",XPFIL,0,1),U)="y"
 .;DD failed screen
 .I $P(XPFIL2,U,2) D  Q
 ..N XPD
 ..S XPD(1)=" ",XPD(2)="Data Dictionary for File #"_XPFIL_" not installed, failed DD screen."
 ..D MES^XPDUTL(.XPD) S %=$$XPCOM(XPFIL)
 .;if udate DD question = no & file is not new update checkpoint
 .I $P(XPFILO,U)'="y"&'XPFIL2 S %=$$XPCOM(XPFIL)
 .;check if XPFIL has already been installed
 .Q:$P(^XPD(9.7,XPDA,4,XPFIL,0),U,2)
 .;update file name
 .I $P(XPFIL2,U,4) D
 ..N DIE,DR,DA
 ..S DR=".01////"_^XTMP("XPDI",XPDA,"FIA",XPFIL),DA=XPFIL,DIE=1
 ..D ^DIE
 .;move DD and check for errors
 .D DDIN^DIFROMS(XPFIL,"","",XPGR),DIERR("** ERROR IN DATA DICTIONARY FOR FILE # "_XPFIL_" **"):$D(DIERR)
 .S %=$$XPCOM(XPFIL)
 I $D(XPDIDVT) D UPDATE^XPDID(XPDIDTOT)
 Q
DAT ;
 N XPGR,XPFIL,XPFILO,XPFIL2,Z
 S XPFIL=0,XPGR=$NA(^XTMP("XPDI",XPDA))
 ;DO if they are sending data
 F  S XPFIL=$O(^XTMP("XPDI",XPDA,"FIA",XPFIL)) Q:'XPFIL  S XPFILO=^(XPFIL,0,1),XPFIL2=^(2) D:$P(XPFILO,U,7)="y"
 .;DD failed screen or answer no to adding data or 'Add if new' & data already exists or file doesn't exist
 .I $P(XPFIL2,U,2)!$P(XPFIL2,U,5)!($P(XPFILO,U,8)="a"&$P(XPFIL2,U,3))!'$D(^DIC(XPFIL,0)) S %=$$XPCOM(XPFIL,1) Q
 .;check if XPFIL has already been installed or no data to input
 .Q:$P(^XPD(9.7,XPDA,4,XPFIL,0),U,3)!('$D(^XTMP("XPDI",XPDA,"DATA",XPFIL)))
 .;bring in Data and check for error
 .D DATAIN^DIFROMS(XPFIL,"","",XPGR),DIERR("** ERROR IN DATA FOR FILE # "_XPFIL_" **"):$D(DIERR)
 .S %=$$XPCOM(XPFIL,1)
 D RP^DIFROMSR("","",XPGR),DIERR("** ERROR IN POINTER RESOLUTION OF DATA **"):$D(DIERR)
 Q
 ;record error
DIERR(XPDI) N XPD
 D MSG^DIALOG("AE",.XPD) Q:'$D(XPD)
 D BMES^XPDUTL(XPDI),MES^XPDUTL(.XPD)
 Q
 ;
 ;XPDF=file #,X=input,XPDS=screen logic, XPDACT=action
DIC(XPDF,XPDX,XPDS,XPDACT) ;
 N DIC,DIERR,XPD,XPDN
 S DIC=$G(^DIC(XPDF,0,"GL"))
 D FIND^DIC(XPDF,"","","XQf",XPDX,5,"",$G(XPDS),"","XPD")
 ;one or more matches, just return first one
 I $G(XPD(0)) D:XPD(0)>1  Q XPD(1)
 .N %
 .S %(1)=$P($G(^DIC(XPDF,0)),U)_"  "_XPDX_"  is Duplicated,",%(2)=" only ien #"_XPD(1)_" was updated."
 .D MES^XPDUTL(.%)
 ;no match and action=(delete,link, or attach), don't write message if deleting
 I $G(XPDACT),XPDACT'=3 D:XPDACT'=1 BMES^XPDUTL(" "_$P($G(^DIC(XPDF,0)),U)_" "_XPDX_" Lookup failed, NO Action Taken.") Q 0
 ;add a new entry
 N DLAYGO,X,Y
 S X=XPDX,DIC(0)="LX",DLAYGO=XPDF,DIC("S")=$G(XPDS) D ^DIC
 I Y<0 D BMES^XPDUTL(" "_$P($G(^DIC(XPDF,0)),U)_" "_XPDX_" **Couldn't Add to file**") Q 0
 Q Y
 ;code can't be used until UPDATE^DIE allows the creation of a record
 ;without required identifiers
 ;K XPD,DIERR
 ;S XPD(XPDF,"+1,",.01)=XPDX
 ;D UPDATE^DIE("","XPD","XPDN")
 ;couldn't add as new
 ;I $D(DIERR) D DIERR(" "_$P($G(^DIC(XPDF,0)),U)_" "_XPDX_" **Couldn't Add to file**") Q 0
 ;I '$G(XPDN(1)) D BMES^XPDUTL(" "_$P($G(^DIC(XPDF,0)),U)_" "_XPDX_" **Couldn't Add to file**") Q 0
 ;Q XPDN(1)
 ;
ACT(%) ;execute action, returns 0 to continue, 1 to quit
 ;user can count on DIC,DA,XPDFIL,OLDA,XPDNM,XPDFL,X,Y being around
 ;XPDNEW is set only for Entry Pre-install action
 Q:%="" 0
 N %1,%2,%3 S %1=$G(DIC),%2=$G(DA),%3=$G(OLDA)
 N DA,DIC,DIOVRD,OLDA,EPOS,EPRE,FPOS,FPRE,ORD,XREF,XPDQUIT
 S DIC=%1,DA=%2,OLDA=%3
 S:%'["^" %="^"_%
 ;XPDQUIT=quit this level of processing
 D @% Q $D(XPDQUIT)
 Q
 ;
XPCOM(XPDF,XPDJ) ;complete checkpoint for file XPDF
 ;XPDJ=1 only for data of fm files, it set the field to edit = 2
 N XPD,%,Z
 S %=$$NOW^XLFDT,Z=$S(XPDCP="KRN":9.715,1:9.714),XPD(Z,XPDF_","_XPDA_",",$G(XPDJ)+1)=%
 ;if Build Components, save the ORDer number
 S:Z=9.715 XPD(Z,XPDF_","_XPDA_",",2)=ORD
 D FILE^DIE("","XPD")
 Q 1
 ;
XPCK(XPDI) ;setup check points for file type XPDI
 ;XPDI="KRN"-components, ="FIA"-files
 N %,XPD,XPDF,XPDJ,XPDK
 ;XPDK=sub DD
 S XPDK=$S(XPDI="KRN":9.715,1:9.714),XPDF=0
 F %=1:1 S XPDF=$O(^XTMP("XPDI",XPDA,XPDI,XPDF)) Q:'XPDF  S (XPDJ(%),XPD(XPDK,"+"_%_","_XPDA_",",.01))=XPDF
 D:$D(XPD)>9 UPDATE^DIE("","XPD","XPDJ")
 Q
