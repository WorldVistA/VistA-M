FBPST35B ;ACAMPUS/DMK-CONVERT FILE 163.99
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This post-init routine goes through file 163.99 and converts the .01
 ;field from a pointer to the CPT file(#81) to the external value.
 ;The .01 field is converted to free text with this install to allow
 ;for the incorperation of CPT Modifiers to the Fee Schedule.
 ;
 Q:+$G(^DD(163.99,0,"VR"))>3
 W !!,"Beginning FBPST35B ....",!!?18,"CONVERSION OF FEE BASIS FEE SCHEDULE FILE (#163.99)"
 N FBI,FBX,DA,DIE,DR,X
 S FBI=0
 F  S FBI=$O(^FBAA(163.99,FBI)) Q:'FBI  I $D(^(FBI,0)) D
 . S DA=FBI Q:'$D(^ICPT(FBI,0))  S FBX=$P(^(0),U)
 . S DIE="^FBAA(163.99,",DR=".01////^S X=FBX" D ^DIE
 ;clean up old PT node in file 81
 K ^DD(81,0,"PT",163.99,.01)
 W !!,"Completed FBPST35B   " D NOW^%DTC W $$DATX^FBAAUTL(%)
 Q
VENDOR ;clean up invalid ID entries still in 161.25
 S FBI=0 F  S FBI=$O(^FBAA(161.25,FBI)) Q:'FBI  S FBL=+$P($G(^FBAA(161.25,FBI,0)),U,6) D
 .I FBL,(FBI'=FBL) Q
 .S FBJ=0 F  S FBJ=$O(^FBAA(161.25,"AF",FBI,FBJ)) Q:'FBJ  I (FBI'=FBJ) S FBOUT=1 Q
 .I $G(FBOUT) K FBOUT Q
 .S FBID=$P($G(^FBAAV(FBI,0)),U,2) I FBID']""!($A(FBID)=45)!($L(FBID)>11)!($L(FBID)<9)!(+FBID=0)!(FBID'?9N.2AN) D
 ..S FB(FBI)=""
 ..S DIK="^FBAA(161.25,",DA=FBI D ^DIK K DIK,DA
 ..S DIE="^FBAAV(",DA=FBI,DR="9////^S X=""Y"";13///^S X=""T""" D ^DIE K DIE,DA,DR
 I '$D(FB) G END
 S PAD=" ",$P(PAD," ",40)="",FBCTR=2,FBTEXT(1,0)="The following vendors with invalid ID's have been placed in delete status:",FBTEXT(2,0)=" "
 S FBI=0 F  S FBI=$O(FB(FBI)) Q:'FBI  S FBCTR=FBCTR+1,FBTEXT((FBCTR),0)="   "_$E($$VNAME^FBNHEXP(FBI),1,30)_$E(PAD,$L($$VNAME^FBNHEXP(FBI))+1,40)_$$VID^FBNHEXP(FBI)
 S XMSUB="FEE BASIS VENDOR CORRECTIONS CLEANUP",XMDUZ=.5,XMY("G.FEE")="",XMTEXT="FBTEXT(" D ^XMD K FBTEXT,XMDUZ,XMSUB,XMY,XMTEXT,XMZ,PAD,FBCTR
END K FBI,FBJ,FBL,FBID,FB,X,Y,DIC
 Q
XREF ;fix cross-references in 162 and 162.1 on date finalized & cert fields
 S ZTRTN="FIX^FBPST35B",ZTIO="",ZTDTH=$H D ^%ZTLOAD
 K ZTSK
 Q
FIX ;outpatient x-ref fix on field date finalized
 S FBV=0 F  S FBV=$O(^FBAAC("AP",FBV)) Q:'FBV  D
 .S FBI=0 F  S FBI=$O(^FBAAC("AP",FBV,FBI)) Q:'FBI  D
 ..S DFN=0 F  S DFN=$O(^FBAAC("AP",FBV,FBI,DFN)) Q:'DFN  D
 ...S FBSDT=0 F  S FBSDT=$O(^FBAAC("AP",FBV,FBI,DFN,FBSDT)) Q:'FBSDT  D
 ....S FBCPT=0 F  S FBCPT=$O(^FBAAC("AP",FBV,FBI,DFN,FBSDT,FBCPT)) Q:'FBCPT  D
 .....I $P($G(^FBAAC(DFN,1,FBV,1,FBSDT,1,FBCPT,0)),"^",6)'=FBI D
 ......K ^FBAAC("AK",FBI,DFN,FBV,FBSDT,FBCPT),^FBAAC("AP",FBV,FBI,DFN,FBSDT,FBCPT)
 ......S FBPSA=$P($G(^FBAAC(DFN,1,FBV,1,FBSDT,1,FBCPT,0)),"^",12) I FBPSA K ^FBAAC("AQ",FBPSA,9999999-FBI,DFN,FBV,FBSDT,FBCPT)
FIXRX ;fix Pharmacy Invoice x-ref on field date certified for payment
 S FBI=0 F  S FBI=$O(^FBAA(162.1,"AA",FBI)) Q:'FBI  D
 .S DFN=0 F  S DFN=$O(^FBAA(162.1,"AA",FBI,DFN)) Q:'DFN  D
 ..S FBIN=0 F  S FBIN=$O(^FBAA(162.1,"AA",FBI,DFN,FBIN)) Q:'FBIN  D
 ...S FBRX=0 F  S FBRX=$O(^FBAA(162.1,"AA",FBI,DFN,FBIN,FBRX)) Q:'FBRX  D
 ....S FBDT=$P($G(^FBAA(162.1,FBIN,"RX",FBRX,0)),"^",19) D  K FBDT
 .....Q:FBDT=FBI
 .....I FBDT,(FBDT'=FBI) S $P(^FBAA(162.1,FBIN,"RX",FBRX,0),"^",19)=FBI Q
 .....K ^FBAA(162.1,"AA",FBI,DFN,FBIN,FBRX)
 .....S FBPSA=$P($G(^FBAA(162.1,FBIN,"RX",FBRX,2)),"^",5) I FBPSA K ^FBAA(162.1,"AI",FBPSA,9999999-FBI,FBIN,FBRX)
 K FBI,DFN,FBV,FBSDT,FBCPT,FBPSA,FBIN,FBRX,FBDT S ZTREQ="@"
 Q
