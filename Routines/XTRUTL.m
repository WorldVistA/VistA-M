XTRUTL ;ISCSF/RWF - Developer Routine Utilities ;3/21/2006 2:50PM
 ;;7.3;TOOLKIT;**20,39,59,66,76,100**;Apr 25, 1995;Build 4
 ;
 Q  ;No entry from the top.
BUILD ;
 K ^UTILITY($J),^TMP($J) D HOME^%ZIS
 N BLDA,DIC,IX,X,PATCH,RTN,RN,L2,OLDSUM,OON
 W !!,"This generates the Checksum/2nd line list for the routines from a BUILD file."
 I '$D(^XPD(9.6,0)) W !,"No BUILD file to work from." Q
 S Y=$$BUILD^XTRUTL1 G EXIT:Y'>0 S BLDA=+Y,PATCH=+$P(Y,"*",3)
 D RTN^XTRUTL1(BLDA)
 I '$D(^UTILITY($J)) W !,"No routines in this build." G EXIT
 ;Ask about old/new checksums
 S OON=$$ASKOON Q:OON<1  ;Return 1 or 2
 ;S X=$P(^DIC(9.4,+$P(Y(0),U,2),0),U,2)
 S RN="" F  S RN=$O(^UTILITY($J,RN)) Q:RN=""  D  Q:$D(L2)
 . S X=RN X ^%ZOSF("TEST") I '$T D  Q
 . . W !,RN,?13,"Routine not in this UCI."
 . . K ^UTILITY($J,RN)
 . S L2=$T(+2^@RN)
 I '$D(L2) W !,"No other routines in this build." G EXIT
 S L2=$P(L2,";",1,4)_";**[Patch List]**;"_$P(L2,";",6,99)
 W !!,"Routine Summary"
 W !,"Checksums shown are "_$S(OON=1:"OLD",1:"NEW")_" Checksums"
 W !,"The following routines are included in this patch.  The second line of each",!,"of these routines now looks like:"
 W !,L2
 W !!,?17,"Checksums",!,"Routine",?16,"Old",?28,"New",?39,"Patch List"
 S RN=""
 F  S RN=$O(^UTILITY($J,RN)) Q:RN=""  D
 . S RSUM=$P($$NEWSUM(RN),"/",OON) ;rwf
 . S OLDSUM=$$OLDSUM(RN),OLDSUM=$P(OLDSUM,"/",OON) ;rwf
 . S X=$G(RTN(2,0)) ;X has second line of routine
 . S:(+OLDSUM=0) OLDSUM="n/a  " S:(+RSUM=0) RSUM="n/a  "
 . W !,RN,?13,$J(OLDSUM,8),?25,$J(RSUM,8) D WRAP(37,$P(X,";",5))
 . D PTLBLD($P(X,";",5))
 . S Y=$P(X,"**",2),Z=$P(Y,",",$L(Y,","))
 . I PATCH,Z'=PATCH W " <<<No "_PATCH
 . Q
 W ! D PTLDSP
 W !,"Sites should use CHECK"_$S(OON=2:"1",1:"")_"^XTSUMBLD to verify checksums.",!
EXIT K %
 Q
 ;
ASKOON() ;Ask if user wants old/new checksum
 ;Return 1 or 2.
 N DIR,DIOUT
 S DIR(0)="S^1:Old;2:New",DIR("A")="New or Old Checksums",DIR("B")="New"
 D ^DIR
 I $D(DIRUT) S Y=-1
 Q Y
 ;
WRAP(C,S) ;Wrap S starting at col C.
 I $L(S)+C<80 W ?C,S Q
 N I,T
 S I=$F(S,",",70-C) W ?C,$E(S,1,I-1) S S=$E(S,I,999)
 F  S I=$F(S,",",70-C),I=$S(I>0:I,1:$L(S)+2) W !,?C+2,$E(S,1,I-1) S S=$E(S,I,999) Q:'$L(S)
 Q
 ;
RSUM() N Y,Y2,%,%1,%2,%3 S (Y,Y2)=0
 F %=1,3:1:LC S %1=RTN(%,0),%3=$F(%1," "),%3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y,Y2=$A(%1,%2)*(%2+%)+Y2
 ;S RSUM=Y,RSUM2=Y2
 Q Y_"/"_Y2
 ;
NEWSUM(X) ;Get the NEW Checksum
 N XCNP,DIF K RTN I '$L($T(^@X)) Q 0
 S XCNP=0,DIF="RTN(" K RTN X ^%ZOSF("LOAD") S LC=XCNP-1
 Q $$RSUM
 ;
OLDSUM(X) ;Get the OLD Checksum
 N Y S Y=$O(^DIC(9.8,"B",X,0)) Q:Y'>0 ""
 S X=$G(^DIC(9.8,Y,4))
 Q $P(X,"^",2)
 ;
PTLBLD(Z) ;Build in ^TMP the patches used
 N I,J,K,P S Z=$P(Z,"**",2),K=""
 F I=1:1 S J=$P(Z,",",I) Q:(J="")  I (J'=PATCH) S P=$G(^TMP($J,J)),^TMP($J,J)=P_K S K=K_J_","
 Q
PTLSRT ;Sort the list
 N I,J,K,L S I=0
 F I=0:0 S I=$O(^TMP($J,I)) Q:I'>0  S K=^(I) D
 . F J=1:1 S L=$P(K,",",J) Q:L=""  K ^TMP($J,L)
 . Q
 Q
 ;
PTLDSP ;Display list of patches.
 D PTLSRT
 N I,J K ^TMP($J,PATCH)
 Q:$O(^TMP($J,0))=""
 W !,"List of preceding patches: "
 S (I,J)="" F  S I=$O(^TMP($J,I)) Q:I=""  D
 . I $X>70 W ! S J=""
 . W J,I S J=", "
 S:$L(J)>2 J=$E(J,1,$L(J)-2)
 Q
 ;
UPDATE ;Update the ROUTINE file with current checksums
 K ^UTILITY($J)
 N BLDA,DIC,IX,X,NOW,DIR
 W !!,"This will update the ROUTINE file for the routines from a BUILD file."
 I '$D(^XPD(9.6,0)) W !,"No BUILD file to work from." Q
 S Y=$$BUILD^XTRUTL1 G EXIT:Y'>0 S BLDA=+Y
 S DIR(0)="Y",DIR("A")="Is "_$P(Y,U,2)_" the one you want" D ^DIR
 I $D(DIRUT)!(Y'=1) Q
 D RTN^XTRUTL1(BLDA)
 S NOW=$$NOW^XLFDT()
 G EXIT:$O(^UTILITY($J,""))=""
 S RN=""
 F  S RN=$O(^UTILITY($J,RN)) Q:RN=""  D UD1(RN)
 W !,"Done"
 Q
 ;
UD1(RN) ;
 N X,XCNP,DIF,LC,RSUM,Y S:'$D(NOW) NOW=$$NOW^XLFDT
 S U="^",RSUM=$$NEWSUM(RN) Q:RSUM=0
 S X=RTN(2,0)
 S Y=$$GETDA(RN) I Y'>0 W !,"  Routine ",RN," not found in the database." Q
 I '$$LOCAL(Y) W !,"This is a national routine and will not be updated" Q 
 S ^DIC(9.8,+Y,4)=NOW_U_RSUM_U_$P(X,";",5)
 Q
 ;
SHOW(RN) ;Show current data
 N Y,%0,%4,RTN,RSUM S %4="^n/a^n/a",U="^"
 S Y=$$GETDA(RN) I Y>0  S %0=^DIC(9.8,Y,0),%4=$G(^(4))
 S RSUM=$$NEWSUM(RN)
 W !,"RTN",?10,"New ChkSum",?28,"Old ChkSum",?46,"Old Date"
 W !,RN,?10,RSUM,?28,$P(%4,U,2),?46,$P(%4,U)
 W !,$S($$LOCAL(Y):"Local",1:"National")_" Routine"
 Q
 ;
GETDA(X) ;Find a DA in file
 Q $O(^DIC(9.8,"B",X,0))
 ;
M ;Manual Update of the Routine file
 N DIC,DIE,DA,DR
 S DIC="^DIC(9.8,",DIC(0)="AEMQ" D ^DIC Q:Y'>0
 I '$$LOCAL(+Y) W !,"This routine Checksum only updated from FORUM." Q
 S DA=+Y,DIE=DIC,DR=7.2 D ^DIE
 Q
 ;
LIST ;List all routines that don't match the old checksum
 N Y,X,RN,RSUM,DA
 S RN="",U="^"
 F  S RN=$O(^DIC(9.8,"B",RN)) Q:RN=""  D
 . S DA=$O(^DIC(9.8,"B",RN,0)) Q:DA'>0
 . S %4=$G(^DIC(9.8,DA,4)) Q:$P(%4,U,2)=""  S RSUM=$$NEWSUM(RN)
 . I RSUM'=$P(%4,U,2) W !,RN,?10,"Checksum mismatch ",$P($T(+2^@RN),";",5)
 . Q
 Q
 ;
LOCAL(DA) ;Return if this is a local routine in the ROUTINE file.
 Q $P($G(^DIC(9.8,DA,6)),"^")<2
 ;
