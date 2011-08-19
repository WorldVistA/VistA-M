FBUCOUT1 ;ALBISC/TET - OUTPUTS cont'd ;6/27/2001
 ;;3.5;FEE BASIS;**32**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ONE ;display/print all claims for one vendor/veteran/other party
 ;sort by treatment from/to dates, group by master claim
 ;sort by vendor if vet or other selected, otherwise veteran
 ;'*' denotes secondary claim
 N FBI,FBIEN,FBIX,FBMC,FBOIEN,FBPTR,FBSORT,FBZ S (FBVEN,FBVET,FBOTH)=""
 D IEN^FBUCUTL3 G END:'FBIEN
 ; ask if report for just mill-bill (1725) or just non-mill bill claims
 S FB1725R=$$ASKMB^FBUCUTL9 I FB1725R="" G END
 I FBIX="AOMS" S FBOIEN=FBIEN,FBOTH=$P($G(^VA(200,FBOIEN,0)),U),FBIEN=+$P($$FBZ^FBUCUTL(+$O(^FB583(FBIX,FBOIEN,0))),U,4)
 S:FBIX'="AVMS" FBVET=$P($G(^DPT(FBIEN,0)),U) S:FBIX="AVMS" FBVEN=$P($G(^FBAAV(FBIEN,0)),U)
Q ;que to print
 S:FBIX="AOMS" FBIEN=FBOIEN S VAR="FBIX^FBIEN^FBVEN^FBVET^FBOTH^FB1725R",VAL=VAR,PGM="SORT^FBUCOUT1" D ZIS^FBAAUTL G:FBPOP END
SORT ;sort all claims output
 U IO K ^TMP("FB",$J) N FBI,FBMC,FBZ
 S FBMC="" F  S FBMC=$O(^FB583(FBIX,FBIEN,FBMC)) Q:FBMC']""  S FBI=0 F  S FBI=$O(^FB583("AMC",+FBMC,FBI)) Q:'FBI  S FBZ=$G(^FB583(FBI,0)) I FBZ]"" D
 .; if user requested just mill-bill (1725) or non-mill bill claims then
 .; check claim and skip when appropriate
 .Q:$S(FB1725R="M"&'+$P(FBZ,U,28):1,FB1725R="N"&+$P(FBZ,U,28):1,1:0)
 .N FBPTR,FBSORT,NODE S FBPTR=$S(FBIX="AVMS":$P(FBZ,U,4),1:$P(FBZ,U,3))
 .S FBSORT=$P($$PTR^FBUCUTL($S(FBIX="AVMS":"^DPT(",1:"^FBAAV("),FBPTR),U) I FBIX="AVMS" S FBSORT=$E(FBSORT,1,30)
 .S NODE=$E($P($$PROG^FBUCUTL(+$P(FBZ,U,2)),U),1,15)_U_$E($P($$PTR^FBUCUTL("^FB(162.92,",$P(FBZ,U,24)),U),1,20) I "^40^70^90^"[$$ORDER^FBUCUTL($P(FBZ,U,24)) S NODE=NODE_U_$$CODE^FBUCOUT($P(FBZ,U,11))
 .S ^TMP("FB",$J,+$P(FBZ,U,5)_";"_+$P(FBZ,U,6),+FBMC_$S(+FBMC=FBI:"P",1:"S")_";"_FBI,$S(+FBMC=FBI:"",1:" *")_FBSORT_";"_FBPTR)=NODE
 .S FBMC=+FBMC_"z"
PRINT ;print all claims output
 N DIRUT,DTOUT,DUTOUT,FBCRT,FBDASH,FBDT,FBHDR,FBMC,FBN,FBNODE,FBOMC,FBOUT,FBPG
 S FBHDR=$S(FBIX="AVMS":"VENDOR: "_FBVEN,FBIX="APMS":"VETERAN: "_FBVET,1:"OTHER PARTY: "_FBOTH),FBPG=0,FBCRT=$S($E(IOST,1,2)="C-":1,1:0),FBOUT=0,$P(FBDASH,"=",80)="" D PAGE
 S FBOMC=0,FBDT=""
 F  S FBDT=$O(^TMP("FB",$J,FBDT)) Q:FBDT']""!(FBOUT)  S FBMC="" F  S FBMC=$O(^TMP("FB",$J,FBDT,FBMC)) Q:FBMC']""  W:+FBOMC'=+FBMC !! S FBOMC=FBMC D  Q:FBOUT
 .S FBN="" F  S FBN=$O(^TMP("FB",$J,FBDT,FBMC,FBN)) Q:FBN']""  S FBNODE=$G(^TMP("FB",$J,FBDT,FBMC,FBN)) D  Q:FBOUT
 ..I IOSL<($Y+5) D PAGE Q:FBOUT
 ..W !,$P(FBN,";"),?34,$P(FBNODE,U),?53,$P(FBNODE,U,2),?75,$P(FBNODE,U,3)
 ..W !?3,"Treatment From: ",$$DATX^FBAAUTL($P(FBDT,";")),?29,"Treatment To: ",$$DATX^FBAAUTL($P(FBDT,";",2))
 ..I FBIX="AOMS" W ?54,"VETERAN: ",$E($$VET^FBUCUTL(+$P($$FBZ^FBUCUTL(+$P(FBMC,";",2)),U,4)),1,16)
END ;kill variables,tmp global and quit
 K FBIEN,FBIX,FBOTH,FBPOP,FBVEN,FBVET,PGM,POP,VAL,VAR,^TMP("FB",$J),FB1725R
 D CLOSE^FBAAUTL
 Q
PAGE ;write new page
 D:FBCRT&(FBPG>0) CR Q:FBOUT
HDR W:FBCRT!(FBPG>0) @IOF S FBPG=FBPG+1
 W !,FBHDR,!?70,"Page: ",FBPG,!,$S(FBIX="AVMS":"Veteran",1:"Vendor"),?34,"Fee Program",?53,"Status",?75,"Code",!,FBDASH
 Q
CR ;ask end of page prompt
 ;OUTPUT: FBOUT is set if time out or up arrow out
 W ! S DIR(0)="E" D ^DIR K DIR S:$D(DTOUT)!($D(DUOUT)) FBOUT=1
 Q
