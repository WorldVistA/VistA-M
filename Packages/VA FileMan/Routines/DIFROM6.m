DIFROM6 ;SFISC/XAK-CREATES RTN ENDING IN 'INIT' ;03:06 PM  28 Nov 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 S DH=" ;",Q=" K DIF,DIFQ,DIFQR,DIFQN,DIK,DDF,DDT,DTO,D0,DLAYGO,DIC,DIDUZ,DIR,DA,DIFROM,DFR,DTN,DIX,DZ,DIRUT,DTOUT,DUOUT"
 S ^UTILITY($J,.3,0)=" S DIOVRD=1,U=""^"",DIFQ=0,DIFROM="""_$S($D(DPK(1)):DPK(1),1:0)_""" W !,""This version"_$S($D(DPK(1)):" (#"_DPK(1)_")",1:"")_" of '"_DTL_"INIT' was created on "_DIFROM(1)_""""
 S ^UTILITY($J,1,0)=" I $D(^DD(""VERSION"")),^(""VERSION"")'<"_+DRN_" G GO"
 S ^UTILITY($J,2,0)=" ;W !,""FIRST, I'LL FRESHEN UP YOUR VA FILEMAN...."" D N^DINIT"
 S ^UTILITY($J,2.9,0)=" I ^DD(""VERSION"")<"_+DRN_" W !,""but I need version "_+DRN_" of the VA FileMan!"" G Q"
 S ^UTILITY($J,3,0)="GO ;"
 S ^UTILITY($J,3.5,0)="EN ; ENTER HERE TO BYPASS THE PRE-INIT PROGRAM"
 S ^UTILITY($J,3.6,0)=" S DIFQ=0 K DIRUT,DTOUT,DUOUT"
 S ^UTILITY($J,3.7,0)=" F DIFRIR=1:1:"_DIFRIR_" S DIFRRTN="_""""_U_DIFRRN_""""_"_$E("_""""_$E(DIFRRXT,1,DIFRIR)_""""_",DIFRIR) D @DIFRRTN"
 S ^UTILITY($J,3.8,0)=" W:"_(DIFRTX>0)_" !,""I AM GOING TO SET UP THE FOLLOWING FILE"_$E("S",X>1)_":"" F I=1:2:"_DIFRTX_" S DIF(I)=^UTILITY(""DIF"",$J,I) D 1 G Q:DIFQ!$D(DIRUT) K DIF(I)"
 S X=$E(DTL_"INIT",1,7)
 S ^UTILITY($J,4,0)=" S DIFROM="""_$S($D(DPK(1)):DPK(1),1:0)_""" D PKG:'$D(DIFROM(0)),^"_X_"1 G Q:'$D(DIFQ) S DIK(0)=""AB"""
 S ^UTILITY($J,6,0)=" K DIFQR D ^"_X_"2,^"_X_3,X=0
 D VERSION^DI
 S ^UTILITY($J,.6,0)=" W !?9,""("_$S($D(^DD("SITE")):"at "_^("SITE")_",",1:"")_" by "_X_")"",!"
 I DPK>0,$D(^DIC(9.4,DPK,"PRE")),$P(^("PRE"),U)]"" S ^UTILITY($J,3.1,0)=" W !,""I HAVE TO RUN AN ENVIRONMENT CHECK ROUTINE."" D PKG,^"_$P(^("PRE"),U)_" Q:'$D(DIFQ)  D NOW^%DTC S DIFROM(""PRE"")=%"
 K ^UTILITY(U,$J),E S D=-9999,DNAME=DTL_"INIT",DL=0 D 2^DIFROM3
 I $G(DPK)>0,$D(^%ZOSF),$D(^%ZTSK) N DIFRINIS D SETUP^DIFROM7(DTL_"INIT",.DIFRINIS) W:$G(DIFRINIS)["INIS" !,DTL,"INIS HAS BEEN FILED..."
 Q
 ;
INTEG W !,"..." S X=0,%X="F %Y=1:1:DD S D=$A(DNAME,%Y)*%Y+D"
 F XCNP=XCNP:0 S X=$O(^UTILITY($J,X)) Q:X=""  W "." X "ZL @X S D=0 F Y=1:1 S DNAME=$T(+Y),DD=$L(DNAME) X %X I 'DD S ^UTILITY(""DINTEG"",$J,X)=D ZL DIFROM6 Q"
 Q
