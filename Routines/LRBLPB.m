LRBLPB ;AVAMC/REG - PATIENT ANTIBODIES ;2/18/93  09:40 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W !!?20,"Patient antibody list"
 S ZTRTN="QUE^LRBLPB" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU
 S A=0 F LRDFN=0:0 S LRDFN=$O(^LR(LRDFN)) Q:'LRDFN  I $D(^LR(LRDFN,"BB")) S X=^LR(LRDFN,0) D A
 S ^TMP($J,0)=A
 D END^LRUTL,END Q
A S A=A+1 Q:'$D(^LR(LRDFN,1.7))  S Y=$P(X,"^",3),Z=^DIC($P(X,"^",2),0,"GL"),Z=@(Z_Y_",0)"),Z(1)=$P(Z,"^")_" "_$P(Z,"^",9)
 F B=0:0 S B=$O(^LR(LRDFN,1.7,B)) Q:'B  S ^TMP($J,B,Z(1))="",^TMP($J,Z(1),B)=""
 Q
END D V^LRU Q
