XPDIA0 ;SFISC/RSD - Cont. of XPDIA ;03/09/2000  06:50
 ;;8.0;KERNEL;**131,144,672**;Jul 10, 1995;Build 28
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
PROE1 ;protocols entry pre
 N %,I
 S ^TMP($J,"XPD",DA)=XPDFL
 ;if Event Driver, subscriber multiple is on node 775
 I $P(^XTMP("XPDI",XPDA,"KRN",101,OLDA,0),U,4)="E" D
 . Q:$D(^XTMP("XPDI",XPDA,"KRN",101,OLDA,775))
 . ;pre patch HL*1.6*57, convert menu multiple to subscriber
 . M ^XTMP("XPDI",XPDA,"KRN",101,OLDA,775)=^XTMP("XPDI",XPDA,"KRN",101,OLDA,10)
 . K ^XTMP("XPDI",XPDA,"KRN",101,OLDA,10)
 ;if Menu linking or merge save menu and subscriber mult. and process in FPOS code
 I XPDFL>1 D
 . M ^TMP($J,"XPD",DA,775)=^XTMP("XPDI",XPDA,"KRN",101,OLDA,775),^TMP($J,"XPD",DA,10)=^XTMP("XPDI",XPDA,"KRN",101,OLDA,10)
 . K ^XTMP("XPDI",XPDA,"KRN",101,OLDA,775),^(10)
 ;if Menu link, XPDQUIT prevents data merge
 I XPDFL=2 S XPDQUIT=1 Q
 ;if this is new to the site then disable and quit
 I $G(XPDNEW) D:XPDSET  Q
 .;quit if option already has out of order msg.
 .Q:$P(^XTMP("XPDI",XPDA,"KRN",101,OLDA,0),U,3)]""
 .S $P(^XTMP("XPDI",XPDA,"KRN",101,OLDA,0),U,3)=$P(XPDSET,U,3)
 .D ADD^XQOO1($P(XPDSET,U,2),101,DA)
 S I=^XTMP("XPDI",XPDA,"KRN",101,OLDA,0),%=^ORD(101,DA,0)
 ;$P(%,U,3)=disable message,
 S:$P(I,U,3)]"" $P(I,U,3)=$P(%,U,3)
 ;if there is no new Security Key, save the old Key
 S:$P(I,U,6)="" $P(I,U,6)=$P(%,U,6)
 S ^XTMP("XPDI",XPDA,"KRN",101,OLDA,0)=I
 ;if there is a new Description, kill the old Description
 K:$O(^XTMP("XPDI",XPDA,"KRN",101,OLDA,1,0)) ^ORD(101,DA,1)
 ;kill old ACCESS multiple
 K ^ORD(101,DA,3) S I=0
 ;XPDFL=3-merge menu items, Quit
 ;the new menu items have already been saved into ^TMP, will restore in
 ;the file post action as a relink
 Q:XPDFL=3
 ;we are replacing menu items, kill the old.
 ;loop thru and kill "AD" and "AB" x-ref., it will be reset with new options
 F  S I=$O(^ORD(101,DA,10,I)) Q:'I  S %=+$G(^(I,0)) K:% ^ORD(101,"AD",%,DA,I)
 F  S I=$O(^ORD(101,DA,775,I)) Q:'I  S %=+$G(^(I,0)) K:% ^ORD(101,"AB",%,DA,I)
 K ^ORD(101,DA,10),^ORD(101,DA,775)
 Q
 ;
ENTF1 ;ENTITY #1.5 file pre
 K ^TMP($J,"XPD")
 Q
 ;
ENTE1 ;ENTITY #1.5 entry pre
 N %,%1,%2,%6
 S ^TMP($J,"XPD",DA)=XPDFL
 ;save ITEM multiple and process in file post ENTF2
 M ^TMP($J,"XPD",DA,1)=^XTMP("XPDI",XPDA,"KRN",1.5,OLDA,1) K ^XTMP("XPDI",XPDA,"KRN",1.5,OLDA,1)
 ;%1=DISPLAY NAME(#.1), %2=DEFAULT FILE NUMBER(#.02), %6=DATA MODEL(#.06)
 S %=$G(^DDE(DA,0)),%1=$G(^DDE(DA,.1)),%2=$P(%,U,2),%6=$P(%,U,6)
 ;kill the DEFAULT FILE NUMBER cross ref.
 I %2 K ^DDE("F",%2,DA)
 ;kill the DATA MODEL(%6) & DISPLAY NAME(%1) & DEFAULT FILE(%2) cross ref. ^DDE("FHIR" and ^DDE("SDA"
 I %6]"",%1]"",%2 D
 . I %6="F" K ^DDE("FHIR",$E(%1,1,30),%2,DA)
 . I %6="S" K ^DDE("SDA",$E(%1,1,30),%2,DA)
 ;just save the .01 field
 S ^DDE(DA,0)=$P(%,U),%1=0
 ;loop thru ITEM multiple #1, check ENTITY #.08
 F  S %1=$O(^DDE(DA,1,%1)) Q:'%1  S %2=$G(^(%1,0)) D:$P(%2,U,8)]""
 . ;kill the file level cross ref. ^DDE("AD",entity,ien,multiple)
 . K ^DDE("AD",$P(%2,U,8),DA,%1)
 ; kill rest of file
 S %=0 F  S %=$O(^DDE(DA,%)) Q:%=""  K ^(%)
 Q
 ;
ENTF2 ;ENTITY #1.5 file post
 ;Loop ^TMP($J,"XPD",DA) and save ITEM multiple
 N DA,DIK,%,%1,%8
 S DIK="^DDE(",DA=0
 F  S DA=$O(^TMP($J,"XPD",DA)) Q:'DA  S %1=0 D
 . F  S %1=$O(^TMP($J,"XPD",DA,1,%1)) Q:'%1  S %8=$P($G(^(%1,0)),U,8) D:%8]""
 .. ;resolve ENTITY(#.08) and put ien back
 .. S %=$$LK^XPDIA("^DDE",%8) S:%]"" $P(^TMP($J,"XPD",DA,1,%1,0),U,8)=%
 . ;save ITEM multiple into DDE
 . M ^DDE(DA,1)=^TMP($J,"XPD",DA,1)
 .;re-index this record
 .D IX1^DIK
 K ^TMP($J,"XPD")
 Q
 ;
ENTDEL(RT) ;ENTITY #1.5 delete
 D DELIEN^XPDUTL1(1.5,RT)
 Q
 ;
POLF1 ;POLICY #1.6 file pre
 K ^TMP($J,"XPD")
 ;add TYPE during a new record, XPDDR is for identifiers
 S XPDDR(.02)="$P(OLDA(0),U,2)"
 Q
 ;
POLE1 ;POLICY entry pre
 N %,I
 ;XPDFL= 0-send,1-delete,2-link,3-merge,4-attach,5-disable
 ;attach & disable never get here
 S ^TMP($J,"XPD",DA)=XPDFL
 ;if Member linking or merge save Member mult. and process in FPOS code
 I XPDFL>1 M ^TMP($J,"XPD",DA,10)=^XTMP("XPDI",XPDA,"KRN",1.6,OLDA,10) K ^XTMP("XPDI",XPDA,"KRN",1.6,OLDA,10)
 ;if Menu link, XPDQUIT prevents data merge
 I XPDFL=2 S XPDQUIT=1 Q
 ;if this is new to the site quit
 I $G(XPDNEW) Q
 ;if there is a new Description, kill the old Description
 K:$O(^XTMP("XPDI",XPDA,"KRN",1.6,OLDA,1,0)) ^DIAC(1.6,DA,1)
 Q
 ;
POLE2 ;POLICY #1.6 entry post
 N %,%1,%2
 ;repoint  ATTRIBUTE FUNCTION (0;4) and RESULT FUNCTION (0;7)
 S %=^DIAC(1.6,DA,0) D  S ^DIAC(1.6,DA,0)=%
 .F %1=4,7 S %2=$P(%,U,%1),$P(%,U,%1)=$$LK^XPDIA("^DIAC(1.62)",%2)
 .Q
 ;repoint DENY OBLIGATION (7) and PERMIT OBLIGATION (8)
 F %1=7,8 S %=$G(^DIAC(1.6,DA,%1)) D:$L(%)
 .S %2=$P(%,U),$P(%,U)=$$LK^XPDIA("^DIAC(1.62)",%2)
 .S ^DIAC(1.6,DA,%1)=%
 .Q
 ;loop thru CONDITIONS (3) and repoint FUNCTION (0;2)
 S %1=0 F  S %1=$O(^DIAC(1.6,DA,3,%1)) Q:'%1  S %=$G(^(%1,0)) D
 .S %2=$P(%,U,2) Q:%2=""
 .S $P(%,U,2)=$$LK^XPDIA("^DIAC(1.62)",%2)
 .S ^DIAC(1.6,DA,3,%1,0)=%
 .Q
 Q
 ;
POLF2 ;POLICY #1.6 file post
 N ACT,DA,DIK,I,X,Y,Y0
 ;loop thru all the new incomming policies
 S DA=0,DIK=DIC F  S DA=$O(^TMP($J,"XPD",DA)) Q:'DA  S ACT=^(DA) D
 .;need to loop through ^TMP($J,"XPD",DA,10,I) these are MEMBERS that need to be
 .;merged, they are also linked memeber, but treat like merge
 .S I=0 F  S I=$O(^TMP($J,"XPD",DA,10,I)) Q:'I  S Y0=$G(^(I,0)),X=$G(^(U)) D:X]"" MEM(DA,X,Y0)
 .;loop thru Menu and repoint Option (0;1), text is on ^(U) node
 .;also need to recount all menus and reset zeroth node, use X
 .S (I,X)=0 F  S I=$O(^DIAC(1.6,DA,10,I)) Q:'I  S Y0=$G(^(I,U)) D
 ..I $L(Y0) D  Q:'Y
 ...S Y=$$LK^XPDIA("^DIAC(1.6)",Y0)
 ...K ^DIAC(1.6,DA,10,I,U)
 ...I 'Y K ^DIAC(1.6,DA,10,I) D BMES^XPDUTL(" Policy "_Y0_" in Policy Members "_$P(^DIAC(1.6,DA,0),U)_" **NOT FOUND**") Q
 ...S $P(^DIAC(1.6,DA,10,I,0),U)=Y
 ...Q
 ..S X=I_U_(X+1)
 ..Q
 .S:X $P(^DIAC(1.6,DA,10,0),U,3,4)=X
 .;re-index this option
 .D IX1^DIK
 .Q
 K ^TMP($J,"XPD")
 Q
 ;
POLDEL(RT) ;POLICY delete
 D DELPTR^XPDUTL1(1.6,RT) ;Delete any pointer entries
 D DELIEN^XPDUTL1(1.6,RT) ;Delete the entries
 Q
 ;
POLEE1 ;EVENT #1.61 entry pre
 N %
 S %=^XTMP("XPDI",XPDA,"KRN",1.61,OLDA,0)
 ;repoint POLICY (0;5)
 I $P(%,U,5)]"" S $P(%,U,5)=$$LK^XPDIA("^DIAC(1.6)",$P(%,U,5)),^XTMP("XPDI",XPDA,"KRN",1.61,OLDA,0)=%
 Q
 ;
POLEDEL(RT) ;EVENT delete
 D DELIEN^XPDUTL1(1.61,RT)
 Q
 ;
POLFE1 ;FUNCTION #1.62 entry pre
 ;if there is a new Description, kill the old Description
 K:$O(^XTMP("XPDI",XPDA,"KRN",1.62,OLDA,2,0)) ^DIAC(1.62,DA,2)
 Q
 ;
POLFDEL(RT) ;FUNCTION delete
 D DELPTR^XPDUTL1(1.62,RT) ;Delete any pointer entries
 D DELIEN^XPDUTL1(1.62,RT) ;Delete the entries
 Q
 ;
 ;this is used to add member to a policy
MEM(DA,X,X0) ;DA=ien of option/protocol, X=Member, X0=0 node of member
 N DIC,DLAYGO,DIK,D0,D1,I,Y,Y0
 S DIC="^DIAC(1.6,"_DA_",10,",DIC(0)="L",DLAYGO=XPDFIL,(D0,DA(1))=DA
 S:'$D(@(DIC_"0)")) @(DIC_"0)")=U_$P(^DD(XPDFIL,10,0),U,2)
 S:$L($G(X0)) DIC("DR")=".02///"_$P(X0,U,2)
 D ^DIC
 Q
