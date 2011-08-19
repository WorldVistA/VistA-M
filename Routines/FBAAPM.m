FBAAPM ;AISC/DMK,GRR-CREATE PATIENT MRA TRANSACTION ;7/7/1998
 ;;3.5;FEE BASIS;**13**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
1 Q:'$D(FBMTYPE)
 D GETVET^FBAAUTL1 G END:'DFN
 D GETAUTH^FBAAUTL1 G 1:FTP']""
 S FBD1=+FTP
3 W ! S DIR("A")="Are you sure you want to create a '"_$S(FBMTYPE="A":"Add",FBMTYPE="D":"Delete",FBMTYPE="C":"Change",FBMTYPE="R":"Reinstate",1:"")_"' type MRA for this patient",DIR("B")="Yes",DIR(0)="Y"
 D ^DIR K DIR G 1:$D(DIRUT)!('Y)
 S FBMST=$S($P(^FBAAA(DFN,1,FBD1,0),"^",13)=1:"Y",1:"")
 S DIC="^FBAA(161.26,",DIC(0)="L",DLAYGO=161.26,X=DFN
 S DR="1////^S X=""P"";2////^S X=FBD1;S Y=$S(FBMST="""":3,1:6);6////^S X=FBMST;3////^S X=FBMTYPE"
 ; for Change MRA (expect State Home) ask if From Date was changed
 I FBMTYPE="C",$P($G(^FBAAA(DFN,1,FBD1,0)),U,13)'=4 S DR=DR_";5"
 S DIE=DIC K DD,DO D FILE^DICN K DLAYGO G:Y<0 END S DA=+Y
 D ^DIE I $D(Y)>0 S DIK=DIE D ^DIK W !,*7,"MRA deleted.",! G 1
 W !!,"Transaction Created!"
 I FBMTYPE="D" S $P(^FBAAA(DFN,1,FBD1,"ADEL"),"^",1,2)="Y^"_DT
 I FBMTYPE="R"!(FBMTYPE="A") S:$D(^FBAAA(DFN,1,FBD1,"ADEL")) ^("ADEL")=""
 G 1
END K DIC,CNT,Y,X,I,DIC,D0,DFN,F,C,FBD1,DA,DAT,DI,DIE,DQ,DR,PE,FBMST,FBMTYPE,FBVEN,FTP,FBPSA,FBLOC,FBASSOC,FB7078,FBAABDT,FBAAEDT,FBAAOUT,FBAUT,FBPOV,FBPROG,FBPT,FBTT,FBTYPE,PI,TA,Z,FBDMRA
 Q
