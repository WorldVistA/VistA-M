XPDIA2 ;SFISC/RSD - Delete Options and cleanup pointers ;11/03/99  12:58
 ;;8.0;KERNEL;**68,131**;Jul 10, 1995
 Q
OPT ;options
 N XPDI,XPDJ,XPDK,XPDM,XPDX,X
 ;XPDM=ien of the XMUSER option
 S X=$O(^DIC(19,"B","XMUSER",0)),XPDM=$S(X:X,1:"@"),XPDX=0
 ;loop thru all the options that are to be deleted
 F  S XPDX=$O(^TMP($J,"XPDEL",XPDX)) Q:'XPDX  D
 .;check that the following might reference this option, XPDX
 .;file 19, menu item, 10
 .S XPDI=0 F  S XPDI=$O(^DIC(19,"AD",XPDX,XPDI)) Q:'XPDI  D
 ..S XPDJ=0 F  S XPDJ=$O(^DIC(19,"AD",XPDX,XPDI,XPDJ)) Q:'XPDJ  D
 ...N XPDA S XPDA=XPDJ,XPDA(1)=XPDI
 ...D DIK("^DIC(19,"_XPDI_",10,",.XPDA,DUZ)
 .;file 19.081, field .01
 .S XPDI=0 F  S XPDI=$O(^XUSEC(19,"B",XPDX,XPDI)) Q:'XPDI  D DIK("^XUSEC(19,",XPDI,DUZ)
 .;file 19.2, field .01
 .S XPDI=0 F  S XPDI=$O(^DIC(19.2,"B",XPDX,XPDI)) Q:'XPDI  D DIK("^DIC(19.2,",XPDI,DUZ)
 .;file 200, secondary menu item, 203
 .S XPDI=0 F  S XPDI=$O(^VA(200,"AD",XPDX,XPDI)) Q:'XPDI  D
 ..S XPDJ=0 F  S XPDJ=$O(^VA(200,"AD",XPDX,XPDI,XPDJ)) Q:'XPDJ  D
 ...N XPDA S XPDA=XPDJ,XPDA(1)=XPDI
 ...D DIK("^VA(200,"_XPDI_",203,",.XPDA,DUZ)
 .Q
 ;
 ;loop thru New Person file
 S XPDI=0 F  S XPDI=$O(^VA(200,XPDI)) Q:'XPDI  D
 .K XPDK S X="XPDK(200,"""_XPDI_","")"
 .I $D(^VA(200,XPDI,201)) S XPDX=^(201) D
 ..;check primary option field 201
 ..S:$D(^TMP($J,"XPDEL",+XPDX)) @X@(201)=XPDM
 ..;check primary window field 201.1
 ..S:$D(^TMP($J,"XPDEL",+$P(XPDX,U,2))) @X@(201.1)="@"
 .;check last option accessed field 202.1
 .I $D(^VA(200,XPDI,202.1)),$D(^TMP($J,"XPDEL",+^(202.1))) S @X@(202.1)="@"
 .D:$D(XPDK) DIE(.XPDK,DUZ)
 .;loop thru delegated options field 19.5, this multiple is dinumed
 .S XPDJ=0 F  S XPDJ=$O(^VA(200,XPDI,19.5,XPDJ)) Q:'XPDJ  D:$D(^TMP($J,"XPDEL",XPDJ))
 ..N XPDA S XPDA=XPDJ,XPDA(1)=XPDI
 ..D DIK("^VA(200,"_XPDI_",19.5,",.XPDA,DUZ)
 .Q
 ;
 ;loop thru Kernel Site Parameter file
 S XPDI=0 F  S XPDI=$O(^XTV(8989.3,XPDI)) Q:'XPDI  D
 .;loop thru alpha/beta test options field 33, node ABOPT, multiple is dinumed
 .S XPDJ=0 F  S XPDJ=$O(^XTV(8989.3,XPDI,"ABOPT",XPDJ)) Q:'XPDJ  D:$D(^TMP($J,"XPDEL",XPDJ))
 ..N XPDA S XPDA=XPDJ,XPDA(1)=XPDI
 ..D DIK("^XTV(8989.3,"_XPDI_",""ABOPT"",",.XPDA,DUZ)
 .;loop thru option to audit field 19.1, node 19.1
 .S XPDJ=0 F  S XPDJ=$O(^XTV(8989.3,XPDI,19.1,"B",XPDJ)) Q:'XPDJ  D:$D(^TMP($J,"XPDEL",XPDJ))
 ..N XPDA S XPDK=$O(^XTV(8989.3,XPDI,19.1,"B",XPDJ,0)),XPDA=XPDK,XPDA(1)=XPDI
 ..D DIK("^XTV(8989.3,"_XPDI_",19.1,",.XPDA,DUZ)
 .Q
 ;
 ;loop thru Device File and check primary option field 201
 S XPDI=0 F  S XPDI=$O(^%ZIS(1,XPDI)) Q:'XPDI  D:$D(^TMP($J,"XPDEL",+$G(^(XPDI,201))))
 .K XPDK S XPDK(3.5,XPDI_",",201)="@" D DIE(.XPDK,DUZ)
 Q
 ;
PRO ;protocols
 N XPDI,XPDJ,XPDK,XPDX,X
 S XPDX=0
 ;loop thru all the protocols that are to be deleted
 F  S XPDX=$O(^TMP($J,"XPDEL",XPDX)) Q:'XPDX  D
 .;check that the following might reference this protocol, XPDX
 .;file 101, menu item, 10
 .S XPDI=0 F  S XPDI=$O(^ORD(101,"AD",XPDX,XPDI)) Q:'XPDI  D
 ..S XPDJ=0 F  S XPDJ=$O(^ORD(101,"AD",XPDX,XPDI,XPDJ)) Q:'XPDJ  D
 ...N XPDA S XPDA=XPDJ,XPDA(1)=XPDI
 ...D DIK("^ORD(101,"_XPDI_",10,",.XPDA,DUZ)
 .;file 101, subscriber, 775
 .S XPDI=0 F  S XPDI=$O(^ORD(101,"AB",XPDX,XPDI)) Q:'XPDI  D
 ..S XPDJ=0 F  S XPDJ=$O(^ORD(101,"AB",XPDX,XPDI,XPDJ)) Q:'XPDJ  D
 ...N XPDA S XPDA=XPDJ,XPDA(1)=XPDI
 ...D DIK("^ORD(101,"_XPDI_",775,",.XPDA,DUZ)
 .;file 123.1, REQUEST ACTION TYPE, field 2
 .S XPDI=0 F  S XPDI=$O(^GMR(123.1,"C",XPDX,XPDI)) Q:'XPDI  D
 ..S X=$G(^GMR(123.1,XPDI,0)) Q:X=""
 ..K XPDK S XPDK(123.1,XPDI_",",2)="@"
 ..D DIE(.XPDK,DUZ)
 .Q
 ;
 ;loop thru New Person file
 S XPDI=0 F  S XPDI=$O(^VA(200,XPDI)) Q:'XPDI  D
 .K XPDK S X="XPDK(200,"""_XPDI_","")"
 .I $D(^VA(200,XPDI,100.1)) S XPDX=^(100.1) D
 ..;check  PRIMARY OE/RR MENU, field 100.11
 ..S:$D(^TMP($J,"XPDEL",+XPDX)) @X@(100.11)="@"
 ..;check PRIMARY ORDER MENU, field 100.12
 ..S:$D(^TMP($J,"XPDEL",+$P(XPDX,U,2))) @X@(100.12)="@"
 .I $D(^VA(200,XPDI,100.2)) S XPDX=^(100.2) D
 ..;check  DEFAULT RESULT REPORTING MENU, field 100.23
 ..S:$D(^TMP($J,"XPDEL",+$P(XPDX,U,3))) @X@(100.23)="@"
 ..;check  PRIMARY PROFILE MENU, field 100.24
 ..S:$D(^TMP($J,"XPDEL",+$P(XPDX,U,4))) @X@(100.24)="@"
 .D:$D(XPDK) DIE(.XPDK,DUZ)
 Q
 ;
DIK(DIK,DA,DUZ) ;delete
 S DUZ(0)="@" D ^DIK
 Q
DIE(XPD,DUZ) ;
 ;XPD(file,DA_",",field)=XMUSER option or '@' to delete
 S DUZ(0)="@"
 D FILE^DIE("","XPD")
 Q
