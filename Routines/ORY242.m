ORY242 ;SLC/MKB -- Support for patch OR*3*242 ;11/21/05  11:16
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**242**;Dec 17, 1997;Build 6
 ;
PRE ; -- preinit
 D NATURE
 ;D REASON
 Q
 ;
POST ; -- postinit
 D VUID
 Q
 ;
NATURE ; -- create new Nature of Order, verify standard values
 N ORI,X,CODE,DA,X0,OR0,DR,DIE
 ; enforce standard values
 F ORI=1:1 S X=$T(ITEMS+ORI),CODE=$P(X,";",3) Q:CODE="ZZZZZ"  D
 . S DA=+$O(^ORD(100.02,"C",CODE,0)) Q:DA<1
 . I +$G(^ORD(100.02,DA,1))'=+$P(X,";",5) S $P(^(1),U)=+$P(X,";",5)
 . I $P(^ORD(100.02,DA,1),U,4)'=$P(X,";",6) S $P(^(1),U,4)=$P(X,";",6)
 . S X0=$P(X,";",4),OR0=$G(^ORD(100.02,DA,0))
 . I OR0'=X0 S DR="" D  ;lock std values
 .. F I=1:1:6 I $P(X0,U,I)'=$P(OR0,U,I) S DR=DR_".0"_I_"///"_$P(X0,U,I)_";"
 .. I $L(DR) S DIE="^ORD(100.02," D ^DIE
 ; add new SERVICE REJECT nature
 S DA=+$O(^ORD(100.02,"B","SERVICE REJECT",0)) Q:DA  ;done
 S DA=+$O(^ORD(100.02,"B","PHARMACY REJECT",0)) I 'DA D  ;use if exists,
 . L +^ORD(100.02,0)                                     ;else get new DA
 . S DA=11 F  S DA=DA+1 Q:'$D(^ORD(100.02,DA))
 . S $P(^ORD(100.02,0),U,3,4)=DA_U_DA
 . L -^ORD(100.02,0)
 ; Kill old xrefs, if updating PHARMACY REJECT
 S OR0=$G(^ORD(100.02,DA,0))
 S X=$P(OR0,U) K:$L(X) ^ORD(100.02,"B",X,DA)
 S X=$P(OR0,U,2) K:$L(X) ^ORD(100.02,"C",X,DA)
 S X=$P(OR0,U,3) K:$L(X) ^ORD(100.02,"AC",X,DA)
 ; Set new data
 S ^ORD(100.02,DA,0)="SERVICE REJECT^R^0^^B^1",^(1)="1^1^0^2^^1"
 S ^ORD(100.02,"AC",0,DA)=""
 S ^ORD(100.02,"B","SERVICE REJECT",DA)=""
 S ^ORD(100.02,"C","R",DA)=""
 Q
 ;
ITEMS ;;CODE;0-node;CREATE ACTION;DEFAULT SIG STS
 ;;W;WRITTEN^W^0^^X^0;1;0;
 ;;V;VERBAL^V^0^^X^0;1;2;
 ;;P;TELEPHONED^P^0^^X^0;1;2;
 ;;S;SERVICE CORRECTION^S^0^^B^0;0;6;
 ;;I;POLICY^I^0^^X^0;1;3;
 ;;D;DUPLICATE^D^0^^X^1;0;;
 ;;X;REJECTED^X^1^^B^1;0;;
 ;;E;ELECTRONICALLY ENTERED^E^1^^F^0;1;2;
 ;;A;AUTO^A^1^^X^0;0;;
 ;;C;CHANGED^C^1^^X^1;0;;
 ;;M;MAINTENANCE^M^1^^X^1;0;;
 ;;R;SERVICE REJECT^R^0^^B^1;1;2;
 ;;ZZZZZ;;;;
 ;
REASON ; -- restructure Reason file for standardization
 ;   [save for later use]
 N ORI,X,CODE,DA,DR,DIE,DIK,LRI,LRX
 ; update reason NAMEs
 F ORI=1:1 S X=$T(NAMES+ORI),CODE=$P(X,";",3) Q:CODE="ZZZZZ"  D
 . S DA=+$O(^ORD(100.03,"C",CODE,0)) Q:DA<1
 . Q:$P($G(^ORD(100.03,DA,0)),U)=$P(X,";",4)  ;done
 . S DR=".01///"_$P(X,";",4),DIE="^ORD(100.03," D ^DIE
 ; move PACKAGE and CODE fields of #100.03 into multiple
 S LRI=+$O(^ORD(100.03,"C","LRPCAN",0)),LRX=$G(^ORD(100.03,LRI,0))
 S ORI=0 F  S ORI=$O(^ORD(100.03,ORI)) Q:ORI<1  S X=$G(^(ORI,0)) D
 . Q:$D(^ORD(100.03,ORI,1,0))  Q:'$P(X,U,5)  ;done, or no data
 . I ORI=LRI S $P(^ORD(100.03,ORI,0),U,4)=1 Q  ;add to ORREQ instead
 . S ^ORD(100.03,ORI,1,0)="^100.031P^1^1",^(1,0)=$P(X,U,5,6)
 . S ^ORD(100.03,ORI,1,"B",+$P(X,U,5),1)=""
 . S ^ORD(100.03,"APKG",+$P(X,U,5),ORI,1)=""
 . S $P(^ORD(100.03,ORI,0),U,5,6)="^"
 . I $L($P(X,U,6)) D  ;reset C xref
 .. K ^ORD(100.03,"C",$P(X,U,6),ORI)
 .. S ^ORD(100.03,"C",$P(X,U,6),ORI,1)=""
 . I $P(X,U,6)="ORREQ",$P(LRX,U,5) D  ;add LRPCAN here
 .. S ^ORD(100.03,ORI,1,0)="^100.031P^2^2",^(2,0)=$P(LRX,U,5,6)
 .. S ^ORD(100.03,ORI,1,"B",+$P(LRX,U,5),2)=""
 .. S ^ORD(100.03,"APKG",+$P(LRX,U,5),ORI,2)=""
 .. S ^ORD(100.03,"C",$P(LRX,U,6),ORI,2)=""
 .. K ^ORD(100.03,"C",$P(LRX,U,6),LRI)
 .. S $P(^ORD(100.03,LRI,0),U,5,6)="^"
 ; remove old PACKAGE and CODE fields, D xref
 S DIK="^DD(100.03,",DA(1)=100.03 F DA=.05,.06 D ^DIK
 K ^ORD(100.03,"D")
 Q
 ;
NAMES ;;CODE;NAME of Reasons
 ;;ORDUP;DUPLICATE ORDER
 ;;ORDIS;DISCHARGE
 ;;ORTRANS;TRANSFER
 ;;ORSPEC;TREATING SPECIALTY CHANGE
 ;;ORADMIT;ADMISSION
 ;;ORREQ;PROVIDER CANCELLED
 ;;OROBS;OBSOLETE ORDER
 ;;ORERR;ENTERED IN ERROR
 ;;ORDEATH;DEATH
 ;;OROR;SURGERY
 ;;ORPASS;PATIENT AWAY ON PASS
 ;;ORASIH;ABSENT SICK IN HOSPITAL
 ;;ZZZZZ;
 ;
VUID ; -- seed new VUID fields
 N ORDOMPTR,TMP
 S TMP=$$GETIEN^HDISVF09("ORDERS",.ORDOMPTR) ;IA#4651
 I TMP D EN^HDISVCMR(ORDOMPTR,"") ;IA #4639
 Q
