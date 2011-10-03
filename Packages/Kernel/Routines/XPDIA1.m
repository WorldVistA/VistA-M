XPDIA1 ;SFISC/RSD - Install Pre/Post Actions for Kernel files cont. ;06/24/2008
 ;;8.0;KERNEL;**2,44,51,58,68,85,131,146,182,229,302,399,507,539**;Jul 10, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
HLPF1 ;help frames file pre
 K ^TMP($J,"XPD")
 Q
HLPE1 ;entry pre
 S ^TMP($J,"XPD",DA)="" K ^DIC(9.2,DA,1),^(2),^(3),^(10)
 Q
HLPF2 ;file post
 N DA,DIK,I,X,Y,Y0
 ;need to send error message, need to setup message
 S DA=0,DIK=DIC F  S DA=$O(^TMP($J,"XPD",DA)) Q:'DA  D
 .;repoint Related Frame (2;0)
 .S I=0 F  S I=$O(^DIC(9.2,DA,2,I)) Q:'I  S Y0=$G(^(I,0)),Y=$$LK^XPDIA("^DIC(9.2)",$P(Y0,U,2)),$P(^DIC(9.2,DA,2,I,0),U,2)=Y
 .;repoint OBJECT (10;0)
 .S (I,X)=0 F  S I=$O(^DIC(9.2,DA,10,I)) Q:'I  S Y0=$G(^(I,0)) D
 ..S Y=$$LK^XPDIA("^MAG",$P(Y0,U)) S:Y $P(^DIC(9.2,DA,10,I,0),U)=Y,X=X+1_U_I
 ..K:'Y ^DIC(9.2,DA,10,I)
 .I X S $P(^DIC(9.2,DA,10,0),U,3,4)=$P(X,U,2)_U_+X
 .D IX1^DIK
 K ^TMP($J,"XPD")
 Q
HLPDEL ;help frame delete
 N DA,DIK,XPDI,XPDJ
 S XPDI=0
 F  S XPDI=$O(^TMP($J,"XPDEL",XPDI)),XPDJ=0 Q:'XPDI  D
 .S DIK="^DIC(9.2,XPDJ,2,"
 .;check other frames that point to this one
 .F  S XPDJ=$O(^DIC(9.2,"AE",XPDI,XPDJ)) Q:'XPDJ  S Z=$O(^(XPDJ,0)) D:Z
 ..K DA S DA=Z,DA(1)=XPDJ D ^DIK
 .;delete this frame
 .K DA S DA=XPDI,DIK="^DIC(9.2," D ^DIK
 Q
BULE1 ;bulletin entry pre
 N X,I S I=0
 ;save current Mail Groups (2)
 I $G(^XMB(3.6,DA,2,0))]"" S X(0)=^(0) F  S I=$O(^XMB(3.6,DA,2,I)) Q:'I  S X(I)=$G(^(I,0))
 K ^XMB(3.6,DA)
 ;after killing data, put back Mail Groups before data merge
 I $D(X) S ^XMB(3.6,DA,2,0)=X(0),I=0 F  S I=$O(X(I)) Q:'I  S ^XMB(3.6,DA,2,I,0)=X(I)
 Q
BULDEL ;del bulletins
 D DELIEN^XPDUTL1(3.6,$G(%))
 Q
MAILGF1 ;mail groups file pre
 K ^TMP($J,"XPD")
 Q
MAILGE1 ;mail group entry pre
 N I,J
 S ^TMP($J,"XPD",DA)=""
 ;save MEMBER GROUPS (5;0)
 I $O(^XTMP("XPDI",XPDA,"KRN",3.8,OLDA,5,0)) M ^TMP($J,"XPD",DA,5)=^XTMP("XPDI",XPDA,"KRN",3.8,OLDA,5) K ^XTMP("XPDI",XPDA,"KRN",3.8,OLDA,5)
 ;save MEMBER - REMOTE (6;0)
 I $O(^XTMP("XPDI",XPDA,"KRN",3.8,OLDA,6,0)) M ^TMP($J,"XPD",DA,6)=^XTMP("XPDI",XPDA,"KRN",3.8,OLDA,6) K ^XTMP("XPDI",XPDA,"KRN",3.8,OLDA,6)
 ;if there is a new Description, kill the old Description
 K:$O(^XTMP("XPDI",XPDA,"KRN",3.8,OLDA,2,0)) ^XMB(3.8,DA,2)
 ;I=current mail group, J=incoming mail group
 S I=^XMB(3.8,DA,0),J=^XTMP("XPDI",XPDA,"KRN",3.8,OLDA,0)
 ;save REFERENCE COUNT (0;4) & LAST REFERENCED (0;5)
 S:$P(I,U,4) $P(J,U,4)=$P(I,U,4) S:$P(I,U,5) $P(J,U,5)=$P(I,U,5)
 ;check COORDINATOR (0;7), bring in one that was asked during install question
 D
 .;get the existing coordinator, and set it
 .I $P(I,U,7) S $P(J,U,7)=$P(I,U,7)
 .;check if there is a pre-question
 .S %=$O(^XPD(9.7,XPDA,"QUES","B","XPM"_OLDA_"#1",0)) Q:'%
 .;if they entered a coordinator, then set it
 .I $G(^XPD(9.7,XPDA,"QUES",%,1)) S $P(J,U,7)=^(1)
 S ^XTMP("XPDI",XPDA,"KRN",3.8,OLDA,0)=J,I=$G(^XMB(3.8,DA,3))
 ;save ORGANIZER (3;1)
 I $P(I,U) S $P(^XTMP("XPDI",XPDA,"KRN",3.8,OLDA,3),U)=$P(I,U)
 Q
MAILGF2 ;mail group file post
 N DA,DIK,XPDMDA,XPDI,Y
 S XPDMDA=0,DIK="^XMB(3.8,"
 F  S XPDMDA=$O(^TMP($J,"XPD",XPDMDA)) Q:'XPDMDA  D
 .;merge & repoint MEMBER GROUP (5;0)
 .S XPDI=0
 .F  S XPDI=$O(^TMP($J,"XPD",XPDMDA,5,XPDI)) Q:'XPDI  S Y=$P($G(^(XPDI,0)),U) D:Y]"" ADD^XPDIA(3.811,XPDMDA,Y)
 .;merge & repoint MEMBER - REMOTE (6;0)
 .S XPDI=0
 .F  S XPDI=$O(^TMP($J,"XPD",XPDMDA,6,XPDI)) Q:'XPDI  S Y=$P($G(^(XPDI,0)),U) D:Y]"" ADD^XPDIA(3.812,XPDMDA,Y)
 .S DA=XPDMDA D IX1^DIK
 K ^TMP($J,"XPD")
 Q
MAILGDEL(RT) ;Mail Group delete
 D DELPTR^XPDUTL1(3.8,RT) ;Delete any pointer entries
 D DELIEN^XPDUTL1(3.8,RT) ;Delete the entries
 Q
HLAPF1 ;HL7 application parameter #771 file pre
 K ^TMP($J,"XPD")
 Q
HLAPE1 ;HL7 application parameter #771 entry pre
 N I,J
 S ^TMP($J,"XPD",DA)=""
 S I=^HL(771,DA,0),J=^XTMP("XPDI",XPDA,"KRN",771,OLDA,0)
 ;save FACILITY NAME (0;3)
 S:$P(I,U,3)]"" $P(J,U,3)=$P(I,U,3)
 ;repoint MAIL GROUP (0;4)
 S:$P(J,U,4)]"" $P(J,U,4)=$$LK^XPDIA("^XMB(3.8)",$P(J,U,4))
 ;repoint COUNTRY CODE (0;7)
 S:$P(J,U,7)]"" $P(J,U,7)=$$LK^XPDIA("^HL(779.004)",$P(J,U,7))
 S ^XTMP("XPDI",XPDA,"KRN",771,OLDA,0)=J
 ;remove HL7 SEGMENT (SEG;0), HL7 MESSAGE (MSG;0)
 K ^HL(771,DA,"SEG"),^("MSG")
 Q
HLAPF2 ;HL7 application parameter #771 file post
 N DA,DIK,XPDI,X,Y
 S DA=0,DIK="^HL(771,"
 F  S DA=$O(^TMP($J,"XPD",DA)) Q:'DA  D
 .;repoint HL7 SEGMENT (SEG;0)
 .S XPDI=0
 .F  S XPDI=$O(^HL(771,DA,"SEG",XPDI)) Q:'XPDI  S Y=$P($G(^(XPDI,0)),U) D
 ..S X=$$LK^XPDIA("^HL(771.3)",$P(Y,U))
 ..I X]"" S $P(^HL(771,DA,"SEG",XPDI,0),U)=X Q
 ..K ^HL(771,DA,"SEG",XPDI)
 .;repoint HL7 MESSAGE (MSG;0)
 .S XPDI=0
 .F  S XPDI=$O(^HL(771,DA,"MSG",XPDI)) Q:'XPDI  S Y=$P($G(^(XPDI,0)),U) D
 ..S X=$$LK^XPDIA("^HL(771.3)",$P(Y,U))
 ..I X]"" S $P(^HL(771,DA,"MSG",XPDI,0),U)=X Q
 ..K ^HL(771,DA,"MSG",XPDI)
 .D IX1^DIK
 K ^TMP($J,"XPD")
 Q
HLLLPE ;HL7 lower level protocol #869.2 entry pre
 N I,J,L,TMP,Y
 S L=$P(^XTMP("XPDI",XPDA,"KRN",869.2,OLDA,0),U),I=0
 ;loop thru logical links and find those pointing to this llp
 F  S I=$O(^XTMP("XPDI",XPDA,"KRN",870,I)) Q:'I  S J=$G(^(I,0)) D
 . Q:$P(J,U,3)'=L
 . ;save llp into tmp, get the llp type field
 . M TMP=^XTMP("XPDI",XPDA,"KRN",869.2,OLDA) S Y=$P(TMP(0),U,2)
 . K TMP(-1),TMP(0)
 . M ^XTMP("XPDI",XPDA,"KRN",870,I)=TMP S $P(^(I,0),U,3)=Y
 S I=$P(^XTMP("XPDI",XPDA,"KRN",869.2,OLDA,0),U,2)
 ;repoint LLP TYPE (0;2)
 S:I]"" $P(^XTMP("XPDI",XPDA,"KRN",869.2,OLDA,0),U,2)=$$LK^XPDIA("^HLCS(869.1)",I)
 S I=$P($G(^XTMP("XPDI",XPDA,"KRN",869.2,OLDA,100)),U)
 ;repoint MAIL GROUP (100;1)
 S:I]"" $P(^XTMP("XPDI",XPDA,"KRN",869.2,OLDA,100),U)=$$LK^XPDIA("^XMB(3.8)",I)
 ;save HLLP DEVICE (200;1)
 S I=$G(^HLCS(869.2,DA,200))
 S:I $P(^XTMP("XPDI",XPDA,"KRN",869.2,OLDA,200),U)=$P(I,U)
 ;save X3.28 DEVICE (300;1)
 S I=$G(^HLCS(869.2,DA,300))
 S:I $P(^XTMP("XPDI",XPDA,"KRN",869.2,OLDA,300),U)=$P(I,U)
 ;save TCP/IP Start-up Node (400;6)
 S I=$G(^HLCS(869.2,DA,400))
 S:I $P(^XTMP("XPDI",XPDA,"KRN",869.2,OLDA,400),U,6)=$P(I,U,6)
 Q
HLLLE ;HL7 logical link #870 entry pre
 N I,J,K,L,Y
 S I=^HLCS(870,DA,0),J=^XTMP("XPDI",XPDA,"KRN",870,OLDA,0)
 ;repoint INSTITUTION (0;2)
 I $P(J,U,2)]"" S Y=$$LK^XPDIA("^DIC(4)",$P(J,U,2)) D:Y=""  S $P(J,U,2)=Y
 .D BMES^XPDUTL(" Couldn't resolve Institution "_$P(J,U,2)_" for Logical Link "_$P(^HLCS(870,DA,0),U))
 ;repoint LLP TYPE (0;3)
 S:$P(J,U,3)]"" $P(J,U,3)=$$LK^XPDIA("^HLCS(869.1)",$P(J,U,3))
 ;repoint MAILMAN DOMAIN (0;7)
 I $P(J,U,7)]"" S Y=$$LK^XPDIA("^DIC(4.2)",$P(J,U,7)) D:Y=""  S $P(J,U,7)=Y
 .D BMES^XPDUTL(" Couldn't resolve Domain "_$P(J,U,7)_" for Logical Link "_$P(^HLCS(870,DA,0),U))
 ;save node 0; pieces 4,5,6,7,9,10,11,12,16,19,21
 F L=4:1:7,9:1:12,16,19,21 S:$P(I,U,L)]"" $P(J,U,L)=$P(I,U,L)
 ;set SHUTDOWN LLP (0;15) no for multi-listener and yes for all else
 S Y=$P($G(^HLCS(870,DA,400)),U,3) S:Y]"" $P(J,U,15)=$S(Y="M":0,1:1)
 S ^XTMP("XPDI",XPDA,"KRN",870,OLDA,0)=J
 S I=$P($G(^XTMP("XPDI",XPDA,"KRN",870,OLDA,100)),U)
 ;repoint MAIL GROUP (100;1)
 S:I]"" $P(^XTMP("XPDI",XPDA,"KRN",870,OLDA,100),U)=$$LK^XPDIA("^XMB(3.8)",I)
 ;save data from site on nodes 200,300,400,500
 F L=200,300,400,500 S I=$G(^HLCS(870,DA,L)) D:I]""
 . S J=$G(^XTMP("XPDI",XPDA,"KRN",870,OLDA,L)) Q:J=""
 . ;check local data (I) and if exist set incomming data (J)
 . F K=1:1:10 S Y=$P(I,U,K) S:Y]"" $P(J,U,K)=Y
 . S ^XTMP("XPDI",XPDA,"KRN",870,OLDA,L)=J
 ;remove following values when a Test site (not a Production site)
 D:$P($$PARAM^HLCS2,U,3)'="P"
 . ;MAILMAN DOMAIN (0;7), DNS DOMAIN (0;8)
 . S $P(^XTMP("XPDI",XPDA,"KRN",870,OLDA,0),U,7,8)="^"
 . ;TCP/IP ADDRESS (400,1), IPV6 ADDRESS (500,1)
 . S J=$G(^XTMP("XPDI",XPDA,"KRN",870,OLDA,400))
 . S:J]"" $P(^XTMP("XPDI",XPDA,"KRN",870,OLDA,400),U)=""
 . S J=$G(^XTMP("XPDI",XPDA,"KRN",870,OLDA,500))
 . S:J]"" $P(^XTMP("XPDI",XPDA,"KRN",870,OLDA,500),U)=""
 Q
KEYF1 ;SECURITY KEY file pre
 K ^TMP($J,"XPD")
 Q
KEYE1 ;SECURITY KEY file entry pre
 S ^TMP($J,"XPD",DA)=""
 Q
KEYF2 ;SECURITY KEY file post
 N DA,DIK,I,X,Y,Y0
 ;Repoint fields
 S DA=0,DIK=DIC
 F  S DA=$O(^TMP($J,"XPD",DA)) Q:'DA  D
 . ;Repoint SUBORDINATE (3)
 . S I=0 F  S I=$O(^DIC(19.1,DA,3,I)) Q:'I  S Y0=$G(^(I,0)) D
 . . S Y=$$LK^XPDIA("^DIC(19.1)",$P(Y0,U)) S:Y $P(^DIC(19.1,DA,3,I,0),U)=Y
 . ;MUTUALLY EXCLUSIVE KEYS (5)
 . S (I,X)=0 F  S I=$O(^DIC(19.1,DA,5,I)) Q:'I  S Y0=$G(^(I,0)) D
 . . S Y=$$LK^XPDIA("^DIC(19.1)",$P(Y0,U)) S:Y $P(^DIC(19.1,DA,5,I,0),U)=Y
 . D IX1^DIK
 K ^TMP($J,"XPD")
 Q
KEYDEL ;del security keys
 N XPDI S XPDI=0
 F  S XPDI=$O(^TMP($J,"XPDEL",XPDI)) Q:'XPDI  D DEL^XPDKEY(XPDI)
 Q
LME1 ;List Templates entry pre
 ;kill old entry before data merge
 K ^SD(409.61,DA)
 Q
LMDEL ;del list manager templates
 D DELIEN^XPDUTL1(409.61,$NA(^TMP($J,"XPDEL")))
 Q
RPCDEL ;del Kernel RPCs
 D DELIEN^XPDUTL1(8994,$G(%))
 Q
CRC32PE ;pre entry for Kernel RPCs CRC32
 ;if there is a new Description, kill the old Description
 K:$O(^XTMP("XPDI",XPDA,"KRN",8994.2,OLDA,1,0)) ^XWB(8994.2,DA,1)
 Q
CRC32DEL ;del Kernel RPCs CRC32
 D DELIEN^XPDUTL1(8994.2,$G(%))
 Q
HLAPDEL(RT) ;del HL7 application parameter #771
 D DELIEN^XPDUTL1(771,RT)
 Q
HLLLDEL(RT) ;del HL7 logical link #870
 N DA,DIK,XPDI,XPDJ,Y
 S XPDI=0
 ;loop thru protocols, #101, get LL field, 770.7 (700;7)
 F  S XPDI=$O(^ORD(101,XPDI)) Q:'XPDI  S Y=$P($G(^(XPDI,700)),U,7) D:Y
 . Q:'$D(^TMP($J,"XPDEL",Y))
 . K XPDJ S XPDJ(101,XPDI_",",770.7)="@"
 . D FILE^DIE("","XPDJ")
 ;subscription, #774
 F  S XPDI=$O(TMP($J,"XPDEL",XPDI)) Q:'XPDI  D:$D(^HLS(774,"C",XPDI))
 . S XPDJ=0 F  S XPDJ=$O(^HLS(774,"C",XPDI,XPDJ))
 D DELIEN^XPDUTL1(870,RT)
 Q
HLOE ;HLO application registry #779.2
 N I,J,K,L,Y
 S I=^HLD(779.2,DA,0),J=^XTMP("XPDI",XPDA,"KRN",779.2,OLDA,0)
 ;repoint APPLICATION SPECIFIC LISTENER (0;9)
 I $P(J,U,9)]"" S Y=$$LK^XPDIA("^HLCS(870)",$P(J,U,9)) D:Y=""  S $P(J,U,9)=Y
 .D BMES^XPDUTL(" Couldn't resolve APPLICATION SPECIFIC LISTENER "_$P(J,U,2)_" HLO APPLICATION "_$P(I,U))
 S ^XTMP("XPDI",XPDA,"KRN",779.2,OLDA,0)=J
 ;repoint Package File Link (2;1)
 S J=$P($G(^XTMP("XPDI",XPDA,"KRN",779.2,OLDA,2)),U)
 S:J]"" $P(^XTMP("XPDI",XPDA,"KRN",779.2,OLDA,2),U)=$$LK^XPDIA("^DIC(9.4)",J)
 ;save data from site on nodes 200,300,400
 Q
