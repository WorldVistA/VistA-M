ORY7 ;SLB/MKB-postinit for OR*3.0*7 ;3/20/98  14:45
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7**;Dec 17, 1997
 ;
POST ; -- Set ^ORD(100.03,"D"), value for Lab parameter
 ;
 N DIK,ORX
 I '$D(^ORD(100.03,"D")) S DIK="^ORD(100.03,",DIK(1)=".01^D" D ENALL^DIK
 S ORX=$P($G(^ORD(100.99,1,0)),U,18)
 D:$L(ORX) EN^XPAR("SYS","ORPF SHOW LAB #",1,ORX)
 Q
 ;
PRE ; -- preinit cleanup of Order Reason file #100.03
 N DA,DIK,ORSYN,ORNM,ORI,ORACTV,ORINACT,ORX
 S DA=.001,DA(1)=100.03,DIK="^DD(100.03," D ^DIK ;remove NUMBER field
 F ORSYN="DUP","ER" D  ;cleanup duplicates
 . K ORACTV,ORINACT S ORI=0
 . F  S ORI=$O(^ORD(100.03,"S",ORSYN,ORI)) Q:ORI'>0  D
 .. S ORX=$G(^ORD(100.03,+ORI,0))
 .. I $P(ORX,U,4) S ORINACT=+$G(ORINACT)+1,ORINACT(+ORI)=ORX
 .. E  S ORACTV=+$G(ORACTV)+1,ORACTV(+ORI)=ORX
 . S ORNM=$S(ORSYN="DUP":"Duplicate Order",1:"Entered in error")
 . I $G(ORINACT) S ORI=0 F  S ORI=$O(ORINACT(ORI)) Q:ORI'>0  S ORX=ORINACT(ORI) D INACT
 . S ORI=$O(ORACTV(0)) Q:ORI'>0  S ORX=ORACTV(ORI)
 . I ORSYN="DUP",ORNM'=$P(ORX,U) D SETNM(ORI,ORNM)
 . I ORSYN="ER",'$P(ORX,U,7) S $P(^ORD(100.03,ORI,0),U,7)=+$O(^ORD(100.02,"C","M",0)) ;set nature="maintenance"
 . I $G(ORACTV)>1 F  S ORI=$O(ORACTV(ORI)) Q:ORI'>0  S ORX=ORACTV(ORI) D INACT ;inactivate extra entries
 Q
 ;
INACT ; -- inactivate reason
 N DA,DR,DIE,X,Y
 S DA=ORI,DIE="^ORD(100.03,",DR=".03///@;.04////1;.06///@"
 S:ORNM=$P(ORX,U) DR=".01///Z"_ORNM_";"_DR D ^DIE
 Q
 ;
SETNM(DA,X) ; -- set .01 Name
 N DR,DIE,Y Q:'DA
 S DIE="^ORD(100.03,",DR=".01///"_X D ^DIE
 Q
