FBUCDUP ;ALBISC/TET - Duplicate check of claims ;4/28/93  11:14
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
BUILD ;build display array of potential duplicates
 ;INPUT:  FBVET - ien of veteran
 ;        FBVEN - ien of vendor
 ;        FBTFROM - from treatment date of claim
 ;        FBTTO - to treatment date of claim
 ;OUTPUT: FBDISP( - array of claims within same date range
 N DTOUT,DUOUT
 G:'$D(^FB583("APF",FBVET)) END N FBFROM,FBDA,NODE S FBFROM=FBTFROM-.1 ;S FBFROM=$$CDTC^FBUCUTL(FBTFROM,-730),FBFROM=FBFROM-.1
 F  S FBFROM=$O(^FB583("APF",FBVET,FBFROM)) Q:'FBFROM!(FBFROM>FBTFROM)  D
 .S FBDA=0 F  S FBDA=$O(^FB583("APF",FBVET,FBFROM,FBDA)) Q:'FBDA  S NODE=$G(^FB583(FBDA,0)) I $P(NODE,U,6)=FBTTO,$P(NODE,U,3)=FBVEN S FBDISP(FBDA)=NODE
 .;S FBDA=0 F  S FBDA=$O(^FB583("APF",FBVET,FBFROM,FBDA)) Q:'FBDA  S:'$O(FBDISP(FBDA)) FBDISP(FBDA)=$G(^FB583(FBDA,0))
 ;Q
LIST ;display array of potential duplicates
 ;INPUT:  FBDISP( - array of claims within same date range of submitted
 ;OUTPUT: formatted display of list; FBOUT for uparrow or timeout
 G:'$D(FBDISP) END N FBPG,FBCRT,FBTITLE,FBDASH,FBDA,FBZ,FBOUT
 S FBPG=0,FBCRT=$S($E(IOST,1,2)="C-":1,1:0),FBTITLE="POTENTIAL DUPLICATES",$P(FBDASH,"=",80)="",FBOUT=0
 D HDR S FBDA=0 F  S FBDA=$O(FBDISP(FBDA)) G:'FBDA END D
 .D:($Y+3)>IOSL PAGE Q:FBOUT  S FBZ=FBDISP(FBDA)
 .W !,FBDA,?10,$E($$VET^FBUCUTL($P(FBZ,U,4)),1,25),?40,$E($$VEN^FBUCUTL($P(FBZ,U,3)),1,25),?70,$E($$PROG^FBUCUTL($P(FBZ,U,2)),1,10)
 .W !?5,"TREATMENT FROM: ",$$DATX^FBAAUTL($P(FBZ,U,5)),?40,"TREATMENT TO: ",$$DATX^FBAAUTL($P(FBZ,U,6))
 ;
END Q
HDR ;header of list display
 I FBPG>0!FBCRT W @IOF
 S FBPG=FBPG+1
 W !?(IOM-$L(FBTITLE)/2),FBTITLE
 W !,"No.",?10,"VETERAN",?40,"VENDOR",?70,"PROGRAM",!
 Q
CR ;carriage return
 S DIR(0)="E" W ! D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1
 Q
PAGE ;new page
 I FBCRT D CR I 'FBOUT D HDR
 Q
