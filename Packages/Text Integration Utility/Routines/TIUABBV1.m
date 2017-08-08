TIUABBV1 ;BPOIFO/JLTP/EL - Entries for UNAUTHORIZED ABBREVIATIONS ;9/23/2015
 ;;1.0;TEXT INTEGRATION UTILITIES;**297**;JUN 20, 1997;Build 40
 ;
 ; External Reference DBIA#:
 ; -------------------------
 ; #10009 - DICN call (Supported)
 ; #2052 - DID call (Supported)
 ; #2053 - DIE call (Supported)
 ; #2055 - DILFD call (Supported)
 ; #2056 - DIQ call (Supported)
 ; #10026 - DIR call (Supported)
 ; #510 - DISV reference (Controlled Subscription)
 ; #10104 - XLFSTR call (Supported)
 ;
 Q
 ;
EN ;Manage Unauthorized Abbreviations
 N ABBV,ABBVU,ACT,ASK,C,CLS,DA,DESC,DR,EXACT,FLD,FILE,FILENAME
 N H1,H2,HLP,I,J,L,L1,L2,L3,L4,L5,MCH,NEW,RESP,RESP1,SEQ,STOP
 N TIUINP,TP,TPUN,TRET,TSEQ,TWAIT,X,X1,X2,X3,X4,X5,XX,Y,ZZ
 N DIC,DIE,DIR,DIRUT,DUOUT
 S TPUN="!@#$%^&*()_-+={}[]|\/:;""'<>?,.~`"
 S (FILE,FILENAME,TWAIT)="",STOP=0
 S FILE="8927.9",FILENAME=$P(^DIC(FILE,0),U)
 S (DIC,DIE)="^TIU("_FILE_","
 S TWAIT=300
 I $G(DTIME)'="" S TWAIT=DTIME
 ;
ENTER ;
 I $G(STOP)=1 Q
 D HD
 K DIC,DIE,TP,ZZ
 S (ABBV,ACT,CLS,DA,DESC,DR,MCH,NEW,X,XX,Y)=""
 S DIC("A")="Enter Unauthorized Abbreviation: "
 D TIUDIC
 I $G(Y)<0!($G(Y)="") S STOP=1 G ENTER
 I $G(Y)=0 W ! D STOP G ENTER
 S DA=$P(Y,U),ABBV=$P(Y,U,2),NEW=$P(Y,U,3),DIE="^TIU("_FILE_","
 D RECALL^DILFD(FILE,DA_",",+($G(DUZ)))
 I '$G(NEW) D  D STOP G ENTER
 . S X=Y(0),CLS=$P(X,U,2),MCH=$P(X,U,3),ACT=$P(X,U,4),DESC=$P(X,U,5)
 . I $E(CLS)="N" W !!,"The Abbreviation '"_ABBV_"' has a NATIONAL class. Therefore, it cannot be modified.",!  Q
 . W !!,"Unauthorized Abbreviation: ",ABBV
 . S DR=".03;.04;.05" W !
 . L +^TIU(FILE,DA):1 I '$T W *7,!!,"Other user is editing this abbreviation '",ABBV,"'. Try later.",!! Q
 . D ^DIE
 . L -^TIU(FILE,DA)
 . S XX="",XX="STATUS for this Unauthorized Abbreviation '"_ABBV_"' is "
 . S XX=XX_$$GETFLD(FILE,SEQ,".04")_" now."
 . W !!,XX,!!
 S DR=".02///L;.03///1;.04///A"
 D ^DIE
 W !!,"** New Local '",ABBV,"' has been added. **"
 W !,"Abbreviation Exact Match: "_$$GETFLD(FILE,SEQ,".03")
 W !,"Status: "_$$GETFLD(FILE,SEQ,".04")
 W !!,"Unauthorized Abbreviation: ",ABBV
 S DR=".02///^S X=""LOCAL"";.03//^S X=""YES"";.04//^S X=""ACTIVE"";.05"
 D ^DIE
 S XX="",XX="STATUS for this Unauthorized Abbreviation '"_ABBV_"' is "
 S XX=XX_$$GETFLD(FILE,SEQ,".04")_" now."
 W !!,XX,!!
 D STOP
 G ENTER
 ;
STOP ; 
 S J="",STOP=0
 R !,"Enter <RETURN> to continue or '^' to exit: ",J:TWAIT S:'$T J=U
 I $G(J)=U S STOP=1
 Q
 ;
 ;
HD ; Header for Enter/Edit Unauthorized Abbreviation
 S (H1,H2,I,X)=""
 S H1="Enter/Edit Unauthorized Abbreviation(s)"
 F I=1:1:$L(H1) S H2=H2_"="
 I $G(IOM)="" S IOM=80
 S X=(IOM-$L(H1))/2
 W @IOF,!! F I=1:1:X W " "
 W H1,! F I=1:1:X W " "
 W H2
 Q
 ;
TIUDIC ;
 S (ASK,C,I,RESP,SEQ,TP,X,XX,Y)=""
 W !!,DIC("A") R X:TWAIT S:'$T X=U I U[X S Y=-1 Q
 I X=" ",$D(^DISV(DUZ,"^TIU("_FILE_",")) D  I $G(Y)="" S Y=-1 Q
 . S Y=$G(^DISV(DUZ,"^TIU("_FILE_","))
 . I $G(Y)="" Q
 . S X=$P($G(^TIU(FILE,Y,0)),U) W X
 W !
 I X="?"!(X="??") D DICHLP S Y=0 Q
 S TIUINP=$$GET1^DID(FILE,.01,"","INPUT TRANSFORM")
 I $G(TIUINP)]"" X TIUINP
 I '$D(X)#2 S Y=0 Q
 K TP S RESP=X,C=0,TP(C)=0
 D SEARCH(RESP,.TP)
 W !
 I $G(C)'>0 S ASK=$$ASK(RESP) D  Q
 .  W !
 .  I '$G(ASK) S Y=0
 .  E  S Y=ASK,SEQ=$P(ASK,U),Y(0)=$G(^TIU(FILE,SEQ,0))
 K DIR S DIR("T")=TWAIT
 S DIR(0)="NO^1:"_C
 I $P(TP(0),U)=1 S DIR("A")="For EDIT Unauthorized Abbreviation, Select number"
 E  S DIR("A")="For EDIT or CREATE Unauthorized Abbreviation, Select number"
 F I=1:1:C S DIR("A",I)=I_") "_$E($P(TP(I),U,3),1,75)
 S DIR("A",C+1)=""
 D ^DIR
 I $D(DUOUT) W !!,"No action has been taken !!",! S Y=0 Q
 I TP(0)=1,X="" W !!,"Nothing is selected !!",! S Y=0 Q
 I Y="" W !!,"Nothing is selected !!",! S Y=0 Q
 I $G(Y(0))="NO" W !!,"No action has been taken !!",! S Y=0 Q
 I $G(Y(0))="YES"!($E($P(TP(X),U,3),1,3)="** ") D  Q
 . I $P(TP(0),U,2)'="" D  I $G(STOP)=1 Q
 . . S XX="",XX=$P(TP(0),U,2)
 . . W !!,"The EXACT-MATCH for the following active abbreviation is set to """_"NO"_""""_": "
 . . W !,"    "_XX
 . . W !,"As a result, this abbreviation '"_RESP_"' will be flagged as unauthorized.",!
 . . K DIR S DIR("T")=TWAIT
 . . S DIR(0)="Y"
 . . S DIR("A")="Do you still want to add '"_RESP_"'"
 . . S DIR("B")="NO"
 . . D ^DIR
 . . I $D(DIRUT)!('Y) W !!,"No action has been taken !!",! S Y=0,STOP=1 Q
 . S DIC="^TIU(FILE,",DIC(0)="",X=RESP D FILE^DICN
 . S SEQ=$P(Y,U),Y(0)=$G(^TIU(FILE,SEQ,0))
 I $G(Y)'="" S SEQ=$P(TP(Y),U,1),Y=$P(TP(Y),U,1,2),Y(0)=$G(^TIU(FILE,SEQ,0)) Q
 Q
 ;
SEARCH(RESP,TP) ; Search for matching ABBREVIATION
 S (ABBV,ABBVU,C,EXACT,L1,L2,L3,L4,L5,RESP1)=""
 S (SEQ,X1,X2,X3,X4,X5,XX)=""
 S (C,EXACT,L1,L2,L3,L4,L5)=0 S TP(0)=EXACT
 S RESP1=$$UP^XLFSTR(RESP)
 S ABBV=""
S10 S ABBV=$O(^TIU(FILE,"B",ABBV)) G:$G(ABBV)="" SOUT
 S ABBVU=$$UP^XLFSTR(ABBV)
 I $TR(ABBVU,TPUN)'=$TR(RESP1,TPUN) G S10
 I ABBV=RESP S EXACT=1,$P(TP(0),U)=EXACT
 S SEQ=""
S20 S SEQ=$O(^TIU(FILE,"B",ABBV,SEQ)) G:$G(SEQ)="" S10
 S XX="",XX=$G(^TIU(FILE,SEQ,0))
 I $G(XX)="" G S20
 S C=C+1
 S (X1,X2,X3,X4,X5)=""
 S X1=$P(XX,U),X2=$P(XX,U,2),X3=$P(XX,U,3),X4=$P(XX,U,4),X5=$P(XX,U,5)
 I $G(X3)=0,($G(X4)="A") D
 . I $P(TP(0),U,2)'="" S $P(TP(0),U,2)=$P(TP(0),U,2)_", "_X1
 . E  S $P(TP(0),U,2)=X1
 I $L(X1)>L1 S L1=$L(X1)
 S X2=$$GETFLD(FILE,SEQ,".02"),X2="CLASS="_X2
 I $L(X2)>L2 S L2=$L(X2)
 S X3=$$GETFLD(FILE,SEQ,".03"),X3="EXACT-MATCH="_X3
 I $L(X3)>L3 S L3=$L(X3)
 S X4=$$GETFLD(FILE,SEQ,".04"),X4="STATUS="_X4
 I $L(X4)>L4 S L4=$L(X4)
 I $G(X5)'="" S X5="NOTE: "_X5
 S TP(C)=SEQ_U_ABBV_U_X1_","_X2_","_X3_","_X4_","_X5
 G S20
 ;
SOUT ; OUT from SEARCH
 I C'>0 Q
 S (I,J,L,X1,X2,X3,X4,X5,XX)=""
 S I=0
S30 S I=$O(TP(I)) G:$G(I)="" S40
 S (J,L,X1,X2,X3,X4,X5,XX)=""
 S XX=$P(TP(I),U,3)
 S X1=$P(XX,",",1),L=L1-$L(X1) I L>0 F J=1:1:L S X1=X1_" "
 S X2=$P(XX,",",2),L=L2-$L(X2) I L>0 F J=1:1:L S X2=X2_" "
 S X3=$P(XX,",",3),L=L3-$L(X3) I L>0 F J=1:1:L S X3=X3_" "
 S X4=$P(XX,",",4),L=L4-$L(X4) I L>0 F J=1:1:L S X4=X4_" "
 S X5=$P(XX,",",5)
 S $P(TP(I),U,3)=X1_" :   "_X3_"   "_X4_"   "_X2
 G S30
 ;
S40 I '$D(^TIU(8927.9,"B",RESP)) D  Q
 .  S SEQ=$P(^TIU(FILE,0),U,3),SEQ=$G(SEQ)+1,C=C+1
 .  S TP(C)=SEQ_U_RESP_U_"** Create a new entry '"_RESP_"' as new Unauthorized Abbreviation."
 Q
 ;
ASK(RESP) ; Ask if adding a new entry
 K DIC,DIR
 S DIR("T")=TWAIT
 S DIR(0)="Y",DIR("A")="Are you adding '"_RESP_"' as a new "_FILENAME
 S DIR("B")="No" D ^DIR Q:$D(DIRUT)!('Y) 0
 S DIC="^TIU(FILE,",DIC(0)="",X=RESP D FILE^DICN
 Q Y
 ;
GETFLD(FILE,SEQ,FLD) ; Get field value
 S (TRET,TSEQ)=""
 S TSEQ=SEQ_","
 D GETS^DIQ(FILE,TSEQ,FLD,"E","ZZ")
 S TRET=$G(ZZ(FILE,TSEQ,FLD,"E"))
 Q $G(TRET)
 ;
DICHLP ; Help for lookup
 K DIR S (HLP,C,J,X1,X2,X3,X4,X5,ABBV,SEQ)=""
 S DIR("T")=TWAIT
 W !! D HELP^DIE(8927.9,"",.01,"??","HLP")
 S HLP=HLP("DIHELP") F HLP=3:1:HLP("DIHELP") W !,HLP("DIHELP",HLP)
 S DIR(0)="Y"
 s DIR("A")="Do you want the list of Unauthorized Abbreviation(s)"
 S DIR("B")="Yes" W !! D ^DIR Q:$D(DIRUT)!('Y)
 S ABBV="",C=0 W !
H10 S ABBV=$O(^TIU(FILE,"B",ABBV)) Q:$G(ABBV)=""
 S SEQ=0
H20 S SEQ=$O(^TIU(FILE,"B",ABBV,SEQ)) G:$G(SEQ)="" H10
 S XX="",XX=$G(^TIU(FILE,SEQ,0))
 I $G(XX)="" G H20
 S C=C+1
 I C#20'>0 R !!,"Enter <RETURN> to continue or '^' to exit: ",J:DIR("T") S:'$T J=U Q:$G(J)=U
 S (X1,X2,X3,X4,X5)=""
 S X1=$P(XX,U),X2=$P(XX,U,2),X3=$P(XX,U,3)
 S X4=$P(XX,U,4),X5=$P(XX,U,5)
 S X1=X1_" :   "
 S X2=$$GETFLD(FILE,SEQ,".02"),X2="CLASS="_X2
 S X3=$$GETFLD(FILE,SEQ,".03"),X3="EXACT-MATCH="_X3_"   "
 S X4=$$GETFLD(FILE,SEQ,".04"),X4="STATUS="_X4_"   "
 S XX=X1_X3_X4_X2
 W !,C,")",?6,$E(XX,1,74)
 G H20
 ;
