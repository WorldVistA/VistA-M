FBUCEX ;ALBISC/TET - EXPIRATION UPDATE &/OR OUTPUT ;7/23/01
 ;;3.5;FEE BASIS;**32**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ABAND ;background update to abandoned if expiration date is met
 ;on claims with status order of 10 or 55
 N FBDT,FBACT S FBACT="EDT"
 S FBO=0 F  S FBO=$O(^FB583("AES",FBO)) Q:'FBO  I "^10^55^"[FBO  S FBDT=-(DT) F  S FBDT=$O(^FB583("AES",FBO,FBDT)) Q:FBDT']""  S FBDA=0 F  S FBDA=$O(^FB583("AES",FBO,FBDT,FBDA)) Q:'FBDA  S FBZ=$G(^FB583(FBDA,0)) I FBZ]"" D
 .N FBUCA,FBUCAA,FBUCP,FBUCPA
 .D PRIOR^FBUCEVT(FBDA,"EDT") S DIE="^FB583(",DA=FBDA,DR="26///^S X=""@"";10////^S X=5"
 .D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE L -^FB583(DA) K DIE,DR,DA
 .D AFTER^FBUCEVT(FBDA,"EDT"),^FBUCUPD(FBUCP,FBUCPA,FBUCA,FBUCAA,FBDA,"EDT")
 .S ^TMP("FBEX",$J,$$VET^FBUCUTL($P(FBZ,U,4))_";"_$P(FBZ,U,4),FBDA)=$E($$VEN^FBUCUTL($P(FBZ,U,3)),1,20)_U_$E($P($$PTR^FBUCUTL("^FB(162.92,",$$STATUS^FBUCUTL(FBO)),U),1,16)_U_$$DATX^FBAAUTL($P(FBZ,U,5))_U_$$DATX^FBAAUTL($P(FBZ,U,6))
 .K FBLOCK
 G:'$D(^TMP("FBEX")) END S FBHDR="Unauthorized Claims Dispositioned to 'ABANDONED'"
PRINT ;print claims which have been dispositioned to abandoned or fall within date range to expire
 U IO S FBPG=0,FBCRT=$S($E(IOST,1,2)="C-":1,1:0),FBOUT=0,$P(FBDASH,"=",80)="" D PAGE
 S FBVET="" F  S FBVET=$O(^TMP("FBEX",$J,FBVET)) Q:FBVET']""!(FBOUT)  S FBDA=0 F  S FBDA=$O(^TMP("FBEX",$J,FBVET,FBDA)) Q:'FBDA!(FBOUT)  S FBNODE=$G(^TMP("FBEX",$J,FBVET,FBDA)) D  Q:FBOUT
 .I IOSL<($Y+5) D PAGE Q:FBOUT
 .W !,$E($P(FBVET,";"),1,20),?24,$P(FBNODE,U),?48,$P(FBNODE,U,3),?60,$P(FBNODE,U,4),?72,$E($P(FBNODE,U,2),1,8)
END ;kill variables,tmp global and quit
 K FBCRT,FBDA,FBDASH,FBDT,FBFR,FBHDR,FBLOCK,FBNODE,FBO,FBOUT,FBPG,FBPOP,FBTO,FBVET,FBZ,BEGDATE,DIR,DIRUT,DTOUT,DUOUT,ENDDATE,PGM,POP,VAL,VAR,^TMP("FBEX",$J),FB1725R
 D CLOSE^FBAAUTL
 Q
PAGE ;write new page
 D:FBCRT&(FBPG>0) CR Q:FBOUT
HDR W:FBCRT!(FBPG>0) @IOF S FBPG=FBPG+1
 W !,FBHDR,!!,?48,"Treatment",?60,"Treatment",!,"Veteran",?24,"Vendor",?51,"FROM",?64,"TO",?72,"Status",!,FBDASH
 Q
CR ;ask end of page prompt
 ;OUTPUT: FBOUT is set if time out or up arrow out
 W ! S DIR(0)="E" D ^DIR S:$D(DTOUT)!($D(DUOUT)) FBOUT=1
 Q
EXPIRE ;called from print option to display/print claims due to expire within date range
 ;claim will print if expiration date falls within date range user selected,
 ;status order is 10 <incomplete> or 55 <appeal/stmt of case issued>,
 ;and has not been abandoned (ck needed?)
 ; ask if report for just mill-bill (1725) or just non-mill bill claims
 S FB1725R=$$ASKMB^FBUCUTL9 I FB1725R="" G END
 W !?3,"Select the date range within which an unauthorized claim will expire." S %DT="AEX" D DATE^FBAAUTL K %DT G:FBPOP END
 S VAR="BEGDATE^ENDDATE^FB1725R",VAL=VAR,PGM="DQ^FBUCEX" D ZIS^FBAAUTL G:FBPOP END
DQ S FBFR=BEGDATE,FBTO=ENDDATE ;scratch
 S FBHDR="Unauthorized"_$S(FB1725R="M":" Mill Bill (1725)",FB1725R="N":" NON-Mill Bill",1:"")_" Claims Due to Expire between "_$$DATX^FBAAUTL(FBFR)_" and "_$$DATX^FBAAUTL(FBTO)
 S FBO=0 F  S FBO=$O(^FB583("AES",FBO)) Q:'FBO  I "^10^55^"[FBO S FBDT=-(FBTO-.1) F  S FBDT=$O(^FB583("AES",FBO,FBDT)) Q:FBDT']""!(FBDT>-FBFR)  S FBDA=0 F  S FBDA=$O(^FB583("AES",FBO,FBDT,FBDA)) Q:'FBDA  S FBZ=$G(^FB583(FBDA,0)) I FBZ]"" D
 .; if user requested just mill-bill (1725) or non-mill bill claims then
 .; check claim and skip when appropriate
 .Q:$S(FB1725R="M"&'+$P(FBZ,U,28):1,FB1725R="N"&+$P(FBZ,U,28):1,1:0)
 .S ^TMP("FBEX",$J,$$VET^FBUCUTL($P(FBZ,U,4))_";"_$P(FBZ,U,4),FBDA)=$E($$VEN^FBUCUTL($P(FBZ,U,3)),1,20)_U_$E($P($$PTR^FBUCUTL("^FB(162.92,",$$STATUS^FBUCUTL(FBO)),U),1,16)_U_$$DATX^FBAAUTL($P(FBZ,U,5))_U_$$DATX^FBAAUTL($P(FBZ,U,6))
 I '$D(^TMP("FBEX")) D  G END
 .S FBPG=0,$P(FBDASH,"=",80)="",FBCRT=$S($E(IOST,1,2)="C-":1,1:0)
 .S FBOUT=0
 .U IO
 .D PAGE W !,"No claims will expire within selected date range."
 G PRINT
 Q
