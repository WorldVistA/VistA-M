LRBLD ;AVAMC/REG - CK BLOOD DONOR ENTRY ; 10/19/88  18:28 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 K Z S T=$P(Y(0),U,3),S=$P(Y(0),U,2),X=$F(LRP,","),Y=$A($E(LRP,X))+1,Y=$C(Y),Y=$P(LRP,",")_","_Y,X=$E(LRP,1,X)
 S F=0,A=X F B=0:0 S A=$O(^LRE("B",A)) Q:A=""!(A]Y)  F C=0:0 S C=$O(^LRE("B",A,C)) Q:'C  S W=^LRE(C,0) I C'=DA,S=$P(W,"^",2) S F=F+1 D W
 I $D(Z) W !,"Your entry: ",LRP,?43,"DOB: ",$E(T,4,5)_"/"_$E(T,6,7)_"/"_$E(T,2,3),!!,"Want to delete your entry " S %=2 D YN^LRU I %=1 S DIK="^LRE(" D ^DIK K DIK,DA W !!,"Ok, ",LRP," deleted.",!
 K A,B,C,E,F,X,Y,Z Q
W W:F=1 !!,"Donors with same last name, first name initial and sex as your entry:",! D:F#20=0 M S Z=$P(^LRE(C,0),"^",3) W ?12,A,?43,"DOB: ",$E(Z,4,5)_"/"_$E(Z,6,7)_"/"_$E(Z,2,3),! Q
 ;
M R "Press <CR>, 'ENTER' or 'RETURN' key: ",X(1):DTIME W $C(13),$J("",80),$C(13) Q
