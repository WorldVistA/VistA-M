PRCSP131 ;WISC/SAW-CPA PRINTS CON'T-TRANSACTION STATUS REPORT ;4/21/93  08:56
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D:IO=IO(0) S^PRCSP13 Q:PRCSEX[U  S PRCS7=$S($D(^PRCS(410,DA,7)):^(7),1:"")
 N XNAME S XNAME=$P($G(^PRCS(410,DA,14)),"^")
 I +XNAME'=0 W !,"Originator of Request: " I $P($G(^VA(200,XNAME,0)),"^")'="" W $P(^(0),"^") E  W "*NO NEW PERSON ENTRY*"
 W !,"Requestor: " S X=$P(^DD(410,40,0),"^",2) I X[200 W $S($D(^VA(200,+PRCS7,0)):$P(^(0),U),1:"")
 W ?41,"Form Type: ",$S($D(^PRCS(410.5,+$P(PRCS0,U,4),0)):$P(^(0),U),1:"")
 W !,"Requestor's Title: ",$P(PRCS7,U,2) W ?41,"Requesting Service: " S X=$S($D(^PRCS(410,DA,3)):$P(^(3),U,5),1:"") I $D(^DIC(49,+X,0)) W $P(^(0),U) W:$P(^(0),U,8)]"" " ("_$P(^(0),U,8)_")"
 W !,"Approving Official: " S X=$P(^DD(410,42,0),"^",2) I X[200 W $S($D(^VA(200,+$P(PRCS7,U,3),0)):$P(^(0),U),1:"")
 W ?41,"Inventory Dist. Point: " I $D(^PRCS(410,DA,0)),$P(^(0),U,6)'="" W $S($D(^PRCP(445,$P(^(0),U,6),0)):$P($P(^(0),U,1),"-",2),1:"")
 W !,"Appr. Official's Title: ",$P(PRCS7,U,4) W ?41,"Cost Center: ",$S($D(^PRCS(410,DA,3)):$E($P(^(3),U,3),1,25),1:"")
 W !,"Date Signed (Approved): " S Y=$P(PRCS7,U,5) X:Y ^DD("DD") W Y K PRCS7
 K ^UTILITY($J,"W") S DIWL=1,DIWR=62,DIWF="",PRCSDY=8,PRCSI=0
 F PRCSJ=1:1 S PRCSI=$O(^PRCS(410,DA,8,PRCSI)) Q:'PRCSI  S X=^(PRCSI,0) D DIWP^PRCUTL($G(DA))
 S I=$S($D(^UTILITY($J,"W",DIWL)):+^(DIWL),1:0)
 I I F J=1:1:I D:PRCSDY>PRCSS S^PRCSP13 Q:PRCSEX[U  W ! W:J=1 "Justification:" W ?15,^UTILITY($J,"W",DIWL,J,0) S PRCSDY=PRCSDY+1
 Q:PRCSEX[U  K PRCSX S PRCS9=$S($D(^PRCS(410,DA,9)):^(9),1:"")
 D:PRCSDY>(PRCSS-4) S^PRCSP13 Q:PRCSEX[U  W !,"Deliver To/Location: ",$P(PRCS9,U)
 S PRCS1=$S($D(^PRCS(410,DA,1)):^(1),1:"") W !,"Classification of Request: " S X=$S($D(^PRCS(410.2,+$P(PRCS1,U,5),0)):$E($P(^(0),U),1,22),1:"") W X K PRCS1
 S X=$S($D(^PRCS(410,DA,11)):$P(^(11),U),1:"") S:$P(X,";") X=$P(X,";",2)_$P(X,";"),X="^"_X_",0)",X=$S($D(@X):$P(^(0),U),1:"") W !,"Sort Group: ",X
 D SUBC^PRCSP132
 S PRCSDY=PRCSDY+4 D RTS^PRCSP132,COM
 I PRCSTC="O",$P(PRCS0,"^",4)>1,$O(^PRCS(410,DA,"IT",0)) G ^PRCSP132
 Q
COM D:PRCSDY>PRCSS S^PRCSP13 Q:PRCSEX[U  K ^UTILITY($J,"W") S DIWL=1,DIWR=68,DIWF="",PRCSDY=PRCSDY+1,PRCSI=0
 F PRCSJ=1:1 S PRCSI=$O(^PRCS(410,DA,"CO",PRCSI)) Q:'PRCSI  S X=^(PRCSI,0) D DIWP^PRCUTL($G(DA))
 S I=$S($D(^UTILITY($J,"W",DIWL)):+^(DIWL),1:0)
 I I F J=1:1:I D:PRCSDY>PRCSS S^PRCSP13 Q:PRCSEX[U  W ! W:J=1 "Comments:" W ?10,^UTILITY($J,"W",DIWL,J,0) S PRCSDY=PRCSDY+1
 Q
