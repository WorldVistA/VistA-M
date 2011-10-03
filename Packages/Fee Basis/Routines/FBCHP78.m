FBCHP78 ;AISC/DMK-GENERATE 7078 ; 8/28/09 12:01pm
 ;;3.5;FEE BASIS;**12,23,52,101,103,111**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 I '$D(^FBAA(161.4,1,0)) W !,"Site Parameters must be entered prior",!," to using this option." Q
GET78 S DIC="^FB7078(",DIC(0)="AEQMZ",DIC("A")="Select Veteran: ",D="D",DIC("S")="I $P(^(0),U,9)'=""DC""" D IX^DIC G END:X="^"!(X=""),GET78:Y<0 S FB7078=+Y,FB(0)=Y(0) K DIC,D
 S DA=FB7078,DIC="^FB7078(",DR=0 D EN^DIQ
ASK S DIR(0)="Y",DIR("A")="Is this the correct 7078",DIR("B")="YES" D ^DIR K DIR G END:$D(DIRUT),GET78:'Y
 D SITEP^FBAAUTL S FBO=$S($D(FBSITE(1)):$P(FBSITE(1),"^",7),1:""),FBNUM=$S($D(FBSITE(1)):$P(FBSITE(1),"^",5),1:"")
 S FBT=$S($D(FBSITE(1)):$P(FBSITE(1),"^",8),1:"")
 D FBO G END:$D(DIRUT)
 S PRCF("X")="S" D ^PRCFSITE S PRC("SITE")=$S($D(PRC("SITE")):PRC("SITE"),1:"") I PRC("SITE")="" W ! G GET78
 S FB("SITE")=PRC("SITE")
QUE S VAR="FB7078^FBNUM^FBO^FBT^FB(""SITE"")",VAL=FB7078_"^"_FBNUM_"^"_FBO_"^"_FBT_"^"_FB("SITE"),PGM="START^FBCHP78" D ZIS^FBAAUTL G:FBPOP END
 ;
START S FB(0)=^FB7078(FB7078,0) S:$E(IOST,1,2)'["C-" FBPG=1 F FBM=1:1:FBNUM D 7078
END K DA,DFN,DIC,DINAME,DIRUT,DIWF,DIWL,DR,FB,FB7078,FBFD,FBID,FBNM,FBNUM,FBO,FBRR,FBSITE,FBTD,FBV,FBVEN,FBT,I,L,FBM,PGM,S,UL,VA,VADM,VAEL,VAERR,VAL,VAPA,VAR,X,Y,Z,PRC,PRCS,^UTILITY($J),PRCSCPAN
 D CLOSE^FBAAUTL Q
 ;
7078 U IO S UL="",$P(UL,"-",120)="-",L="|" D HED^FBCH78A
 S DFN=$P(^FB7078(FB7078,0),"^",3) G END:'$D(DFN)#2!('$D(^DPT(+DFN,0)))
 N FBNAME
 S FBNAME("FILE")=2,FBNAME("IENS")=DFN_",",FBNAME("FIELD")=.01
 S FBNAME=$$NAMEFMT^XLFNAME(.FBNAME,"F","C")
 S VAPA("P")="" D SITEP^FBAAUTL,6^VADPT
 N FBCONFAD S FBCONFAD=$$ACTIVECC^FBAACO0() I FBCONFAD,$L($G(VAPA(16))) D
 . N FBLEN S FBLEN=$L(VAPA(16))+$L($P($G(VAPA(17)),U,2))+$L($P($G(VAPA(18)),U,2))+3 S:FBLEN>52 FBLEN=$L(VAPA(16))-(FBLEN-52),VAPA(16)=$E(VAPA(16),1,FBLEN)
 F FBNM=1:1:7 S FBNM(FBNM)=$P(FBSITE(0),"^",FBNM)
 S FBNM(5)=$S($D(^DIC(5,FBNM(5))):$P(^(FBNM(5),0),"^",2),1:"")
 S Y=$P(FB(0),"^",10) D DATE S FBID=Y,FBVEN=$P(FB(0),"^",2),(FBVEN,FBV(0))=$P(FBVEN,";",1),FBVEN=$S($D(^FBAAV(FBVEN,0)):$P(^(0),"^",1),1:"Unknown"),FBVEN(1)=$S($D(^FBAAV(FBV(0),0)):$P(^(0),"^",2),1:"")
 F I=3:1:6,14 S FBV(I)=$S($D(^FBAAV(FBV(0),0)):$P(^(0),"^",I),1:"")
 I FBV(5)]"" S FBV(5)=$S($D(^DIC(5,FBV(5),0)):$P(^(0),"^",2),1:"")
 S Y=$P(FB(0),"^",4) D DATE S FBFD=Y,Y=$S($P(FB(0),"^",5)]"":$P(FB(0),"^",5),1:"Disposition") D DATE:Y>0 S FBTD=Y
 S FB(6)=$P(FB(0),"^",6) I FB(6)]"" S FB(6)=$S($D(^DIC(43.4,FB(6),0)):$P(^(0),"^",3),1:"")
 W "Issuing Office",?66,L,"1. Date of Issue",!,?5,FBNM(1),?66,L,?70,FBID,!,?5,FBNM(2),?66,L,$E(UL,1,52),!,?5,$S(FBNM(3)]"":FBNM(3),1:FBNM(4)_", "_FBNM(5)_" "_FBNM(6)),?66,L,"2. Veteran's Name",!
 I FBNM(3)]"" W ?5,FBNM(4)_", "_FBNM(5)_" "_FBNM(6)
 W ?66,L,?70,FBNAME,!,UL,!,"Name of Physician or Station",?66,L,"3. Address",!,?5,FBVEN,?66,L,?68,$S(FBCONFAD:VAPA(13),1:VAPA(1)),!,?5,FBV(3),?66,L,?68,$S(FBCONFAD:VAPA(14),1:VAPA(2)),!,?5,FBV(14)
 W ?66,L,?68,$S(FBCONFAD:VAPA(15),1:VAPA(3)),!?5,FBV(4)_", "_FBV(5)_" "_FBV(6)
 W ?66,L,?68,$S(FBCONFAD:$G(VAPA(16)),1:VAPA(4))_", "_$S(FBCONFAD:$P($G(VAPA(17)),U,2),1:$P(VAPA(5),"^",2))_" "_$S(FBCONFAD:$P($G(VAPA(18)),U,2),'+$G(VAPA(11)):VAPA(6),$P(VAPA(11),U,2)]"":$P(VAPA(11),U,2),1:VAPA(6)),!?5,"ID#: ",FBVEN(1)
 W ?66,L,$E(UL,1,53),!,?66,L,?68,"4. Veteran's Claim No.",?93,L,?95,"4A. SSN",!,?66,L,?68,$S($G(VAEL(7))=$P($G(VADM(2)),U,1):$$SSNL4^FBAAUTL($G(VAEL(7))),1:$G(VAEL(7))) ;87 - fix display if claim number = ssn number.
 W ?93,L,?95,$$SSNL4^FBAAUTL($P(VADM(2),"^",2)),!,?66,L,$E(UL,1,53),!,?66,L,?75,"5. Authorization Valid",!,?66,L,$E(UL,1,53),!
 ; next few lines contain changes that display/print the referring provider data  FB*3.5*103
 W "Name of VA Referring Provider",?66,L,"From",?93,L,"To",!
 W ?5,$$GET1^DIQ(162.4,FB7078_",",15),?50,"NPI: ",$$REFNPI^FBCH78("",FB7078,1)
 W ?66,L,?68,FBFD,?93,L,?95,FBTD,!,UL,!,?45,"PART 1. - SERVICES AUTHORIZED",!,UL,!,"6. Services shown below are authorized for the period indicated in Item 5 above.",?104,L,?107,"7. Fee",!
 W ?12,"(See Special Provisions below.)",?104,L,"$",!
 S DIWL=1,DIWF="WC103" K ^UTILITY($J,"W")
 I $D(^FB7078(FB7078,1,0)) F FBRR=0:0 S FBRR=$O(^FB7078(FB7078,1,FBRR)) Q:FBRR'>0  S FBXX=^(FBRR,0),X=FBXX D ^DIWP
 D ^DIWW:$D(FBXX) K FBXX
 D FISCAL^FBCH78A
 W UL,!,"8. Fee Schedule or Contract",?33,L,"9. Authority",?66,L,"9A.",?93,L,"10. Estimated Amount",!?5,$$CONT^FBCH78A(+$P(FB(0),U,2),$P(FB(0),U,4)),?33,L,?35,FB(6),?66,L,?93,L,?95,"$"
 K X2 S X=$P(FB(0),"^",7),X3=$L(+X)+2 D COMMA^%DTC K X3 W X,!,UL,!
 W "11. Fiscal Symbols",?66,L,"12. Authorized by (Name and Title)",!,?5,FB("SYM"),?66,L,?68,FBO,"  ",FBT,!,UL
 D BOT^FBCH78A
 Q
DATE S Y=$$FMTE^XLFDT(Y) Q
 ;
FBO S DIR(0)="F^3:45",DIR("A")="Approving Official for 7078",DIR("B")=FBO,DIR("?")="Enter <return> to accept the default or enter a name from 3 to 45 characters in length" D ^DIR K DIR Q:$D(DIRUT)  S FBO=X
FBT S DIR(0)="F^3:45",DIR("A")="Title of Approving Official",DIR("B")=FBT,DIR("?")="Enter <return> to accept the default title or enter a title from 3 to 45 characters in length" D ^DIR K DIR Q:$D(DIRUT)  S FBT=X
ASKN S DIR(0)="N^1:5",DIR("A")="# of copies of 7078",DIR("B")=FBNUM,DIR("?")="Select a number between 1 and 5.  This number represents the number of copies of the 7078 you would like printed" D ^DIR K DIR Q:$D(DIRUT)  S FBNUM=X
