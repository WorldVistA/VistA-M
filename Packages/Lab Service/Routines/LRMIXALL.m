LRMIXALL ;DALISC/FHS - RE INDEX "AI" "AJ" "AS" FOR ^LAB(62.06
 ;;5.2;LAB SERVICE;;Sep 27, 1994
EN ;Also called from the ^DD(62.06,1 X-ref indexes by FM
 N X
 Q:'$G(DA)!('$D(^LAB(62.06,+$G(DA),0))#2)  S X=^(0)
 Q:+$P(X,U,2)<2
 W:$G(LRMAN) !,$P(X,U,2),?10,$P(X,U) S X=+$P(X,U,2)
 W:$G(LRMAN) !?5," X-REF THE 'AJ' Entries " D BUGNODE^LRMIXR1
 W:$G(LRMAN) !?5," X-REF THE 'AS' Entries " D BUGNODE^LRMIXR2
 W:$G(LRMAN) !?5," X-REF THE 'AI' Entries " D BUGNODE^LRMIXR3
 W:$G(LRMAN) !,"Done",!
 Q
MAN F I=0:1 S L=$P($T(TAG+I),";;",2) Q:L="END"  W !,L
 G ASK
TAG ;; This routine will re-cross reference a drug with a single call
 ;;for "AI", "AJ" and "AS" in ANTIMICROBIAL SUSECPTIBILITY file (#62.06).
 ;; This process can be done via FileMan re-index function.
 ;;Not all LIMs have access to the re-index options. This routine
 ;;can be used for these specific cross references only.
 ;;  It removes the entire X-Ref to clean up any errors and the
 ;;performs the set logic. It does not harm anything to do it more than once.
 ;;
 ;;END
 Q
ASK ;
 K DIC,DA
 W ! S LRMAN=1 S DIC=62.06,DIC(0)="AQEZM",DIC("S")="I $P(^(0),U,2)>2" D ^DIC G:Y<1 END
 S DA=+Y S XX=+$P(Y(0),U,2) K ^LAB(62.06,"AJ",XX),^LAB(62.06,"AS",XX),^LAB(62.06,"AI",XX)
 D EN G ASK
END ;
 K DA,X,XX,DIC,I,L,LRMAN D ^%ZISC Q
