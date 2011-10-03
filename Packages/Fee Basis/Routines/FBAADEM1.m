FBAADEM1 ;AISC/DMK-DISPLAY PATIENT DEMOGRAPHICS ;14MAY92
 ;;3.5;FEE BASIS;**13,51,103**;JAN 30, 1995;Build 19
 ;;Per VHA Directive 2004-038, this routine should not be modified.
EN N FBDX,FBFDT,FBI,FBRR,FBT,FBTYPE,FBV,FBZ,PSA
 S:'$D(FBPROG) FBPROG="I 1"
 ;
 S Y=$G(^FBAAA(DFN,4)) W:$P(Y,"^")]"" !,"Fee ID Card #: ",$P(Y,"^"),?40,"Fee Card Issue Date: " S Y=$P(Y,"^",2) D PDF W Y,!
 ;
 I $O(^FBAAA(DFN,1,0)) D  Q:FBAAOUT
 . D HANG:$Y+5>IOSL Q:FBAAOUT
 . W !,"Patient Name: ",VADM(1),?55,"Pt.ID: ",$P(VADM(2),"^",2)
 . W !!,"AUTHORIZATIONS:",!
 . K FBAUT
 . S FBZ=0,FBFDT="9999999"
 . F  S FBFDT=$O(^FBAAA(DFN,1,"B",FBFDT),-1) Q:'FBFDT  D  Q:FBAAOUT
 . . S FBI=0 F  S FBI=$O(^FBAAA(DFN,1,"B",FBFDT,FBI)) Q:'FBI  I $D(^FBAAA(DFN,1,FBI,0)) X FBPROG I  S FBZ=FBZ+1,X=^(0) D  Q:FBAAOUT
 . . . S Y=+X,PSA=$P(X,"^",5),FBT=$P(X,"^",13),FBV=+$P(X,"^",4) D PDF
 . . . W ?3,"(",FBZ,")",?7,"FR: ",Y,?25,"VENDOR: ",$S($D(^FBAAV(FBV,0)):$P(^(0),"^")_" - "_$P(^(0),"^",2),1:"Not Specified")
 . . . S FBDX=$G(^FBAAA(DFN,1,FBI,3)) W !?7,"TO: " S Y=$P(X,"^",2) D PDF W Y,!?25,"Authorization Type: " D
 . . . . S FBTYPE=$P(X,"^",3),FBTYPE=$S(FBTYPE=2:"Outpatient - "_$S(FBT=1:"Short Term",FBT=2:"Home Health",FBT=3:"ID Card",1:""),$D(^FBAA(161.8,+FBTYPE,0)):$P(^(0),"^"),1:"Unknown")
 . . . W FBTYPE W:$P(X,"^",7) !,?11,"Purpose of Visit: ",$P($G(^FBAA(161.82,$P(X,"^",7),0)),"^") I $P(X,"^",9)["FB583(" W !?25,">> Unauthorized Claim <<"
 . . . ; PRXM/KJH - Patch 103. Add Referring Provider and NPI to the display.
 . . . W !?11,"DX: ",$P(X,"^",8) W ?40,"REF: "
 . . . I $P(X,"^",21)'="" W $$GET1^DIQ(200,$P(X,"^",21),.01)
 . . . W !?11,"REF NPI: ",$$REFNPI^FBCH78($P(X,"^",21)),!
 . . . W:$P(FBDX,"^")]"" !?15,$P(FBDX,"^") W:$P(FBDX,"^",2)]"" !?15,$P(FBDX,"^",2)
 . . . S FBAUT($P(X,"^"))=$P(X,"^",2)
 . . . W !?7,"County: ",FBCOUNTY,?40,"PSA: ",$S($D(^DIC(4,+PSA,0)):$P(^(0),"^"),1:"Unknown"),!
 . . . S FBDEL=$G(^FBAAA(DFN,1,FBI,"ADEL")) I FBDEL]"" S Y=$P(FBDEL,"^",2) D PDF W ?12,">> DELETE MRA SENT TO AUSTIN ON - ",Y," >>",!
 . . . I $D(^FBAAA(DFN,1,FBI,2,0)) K ^UTILITY($J,"W") S DIWL=15,DIWR=70,DIWF="W" D HANG:$Y+6>IOSL Q:FBAAOUT  W !?11,"REMARKS:" D
 . . . . S FBRR=0 F  S FBRR=$O(^FBAAA(DFN,1,FBI,2,FBRR)) Q:'FBRR  S (FBXX,X)=^(FBRR,0) D ^DIWP
 . . . D ^DIWW:$D(FBXX) K FBXX W !
 . . . K X,FBDX,FBT,FBTYPE,FBV,PSA D HANG:$Y+5>IOSL
 ;
 D HANG:$Y+5>IOSL Q:FBAAOUT
 ;
 I $O(^FBAAA(DFN,2,0))>0 D  Q:FBAAOUT
 . W !,"VENDOR CONTACTS:"
 . S (FBZ,FBI)=0
 . F  S FBI=$O(^FBAAA(DFN,2,FBI)) Q:'FBI!(FBAAOUT)  S FBZ=FBZ+1,X=$G(^(FBI,0)),Y=+X D PDF D
 . . W !?3,"(",FBZ,")",?7,"DATE: ",Y,?25,"VENDOR: ",$P(X,"^",2),?55,"PHONE: ",$S($P(X,"^",3)]"":$P(X,"^",3),1:"Not Found")
 . . I $D(^FBAAA(DFN,2,FBI,1,0)) K ^UTILITY($J,"W") S DIWL=20,DIWR=70,DIWF="W" D HANG:$Y+5>IOSL Q:FBAAOUT  W !?11,"NARRATIVE:",! D
 . . . S FBRR=0 F  S FBRR=$O(^FBAAA(DFN,2,FBI,1,FBRR)) Q:'FBRR  S FBXX=^(FBRR,0) D HANG:$Y+5>IOSL Q:FBAAOUT  S X=FBXX D ^DIWP
 . . D ^DIWW:$D(FBXX) K FBXX W !
 Q
 ;
HANG I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1
 W @IOF I 'FBAAOUT W !,"Patient Name: ",VADM(1),?55,"Pt.ID: ",$P(VADM(2),"^",2),!
 Q
 ;
PDF S:Y Y=$$FMTE^XLFDT(Y,5)  ; TRANSLATE TO DISPLAY DATE
 Q
