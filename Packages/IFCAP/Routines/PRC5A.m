PRC5A ;WISC/PLT-IFCAP pre-install routine defined in package file ;9/13/00  17:46
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;invoke by the pre-initial installation field of package file.
EN ;called from routine prcinit[1]
 D EN^DDIOL("IFCAP PRE-INIT STARTS at "_$$NOW)
 D DESCRIP^PRC5INS1(410,443.99) ;remove ifcap dd field descriptions
 ;remove erroneous computed field nodes of Free-Text field
 K ^DD(420.01,2,9.01),^(9.1),^(9.2)
 K ^DD(420.01,3,9.01),^(9.1),^(9.2)
 ;Delete discontinued fields
 S DIK="^DD(443.6,",DA(1)=443.6 F DA=.4,8.4 D:$D(^DD(443.6,DA)) ^DIK
 K DA,DIK
 ;kill erroneous index nodes
 K ^DD(442.8,0,"IX","AE",442.8,.01)
 ;kill old "NM" nodes where name change
 K ^DD(420.11,0,"NM","SUBACCOUNT")
 F X="PRCO EDI RE-TRAN^PRCHPC PO","PRCHPM CS RETRANSMIT BATCH^PRCHPM CS TRANSMISSION MENU" D UNLINK($P(X,"^"),$P(X,"^",2))
 D ^PRCIPR1A ;delete option/routine/template(s)
 D EN3^PRC5C1 ;reindex special fcp in file 420
 ;add entry in file 420.92 if not defined
 I '$O(^PRCU(420.92,"B",PRCFIXV,"")) D
 . N PRCRI,A
 . S A="",PRCRI(9.4)=$O(^DIC(9.4,"B","IFCAP",0)) I PRCRI(9.4) S A=$P(^DIC(9.4,PRCRI(9.4),"VERSION"),"^",1)
 . S A=A_"/"_$P($T(+2^PRCINIT),";",3)
 . S X=PRCFIXV,X("DR")="1////"_A_";2.6///^S X=""N"""
 . D ADD^PRC0B1(.X,.Y,"420.92;^PRCU(420.92,")
 . I Y=-1 K Y I Y W !,"ERROR TRAP! CALL IRM/ISC SUPPORT."
 . QUIT
 D EN^DDIOL("IFCAP PRE-INIT ENDS at"_$$NOW)
 QUIT
 ;
 ;
NOW() ;ev value date@time of now
 N %H,Y,X,%
 S %H=$H D YX^%DTC
 QUIT Y
 ;
UNLINK(A,B) ;Remove Option from Menu
 ;A: Option to remove; B: Menu
 N X,DA
 S X=$O(^DIC(19,"B",A,0)) Q:X'?1.N
 S DA(1)=$O(^DIC(19,"B",B,0)) Q:DA(1)'?1.N
 S DA=$O(^DIC(19,DA(1),10,"B",X,0)) Q:DA'?1.N
 S DIK="^DIC(19,"_DA(1)_",10," D ^DIK K DIK
 Q
