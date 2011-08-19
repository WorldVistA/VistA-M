PRCSUT1 ;SF-ISC/LJP/KSS/KMB/DGL-CONTROL POINT UTILITY ROUTINE ;8/25/00  16:45
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;find #requests to approve/process, ACTION FOR 'PRCSCP OFFICIAL' OPTION.
 N PRC,PRCSAMT,PRCSCT,PRCSDA,PRCSI,PRCSJ,PRCSK,PRCSKS,PRCSVAR
 ; APPREQ=1 if user entered from approve requests procedure [PRCSAPP]
 Q:'$D(DUZ)  S (PRC("CP"),PRC("SITE"))=0,U="^"
 ;
 F PRCSI=0:0 D  Q:PRC("SITE")'>0  ; for each station the user accesses
 . S PRC("SITE")=$O(^PRC(420,"A",DUZ,PRC("SITE")))
 . Q:PRC("SITE")'>0
 . ;
 . F PRCSJ=0:0 D  Q:PRC("CP")'>0  ; and for each CP at that station
 . . S PRC("CP")=$O(^PRC(420,"A",DUZ,PRC("SITE"),+PRC("CP")))
 . . Q:PRC("CP")'>0
 . . I $D(^PRC(420,"A",DUZ,PRC("SITE"),+PRC("CP"),1)) D
 . . . ;  
 . . . ; if the user is an official for that station and CP
 . . . S (PRCSAMT,PRCSCT)=0 ; $value,counter
 . . . S PRCSVAR=PRC("SITE")_"-"_+PRC("CP")
 . . . S PRCSKS=PRCSVAR_"-"_0 ; station-CP-counter
 . . . ;
 . . . F PRCSK=0:0 D  Q:PRCSK=1  ; find all txns to be approved
 . . . . S PRCSKS=$O(^PRCS(410,"F",PRCSVAR_"-"_$P(PRCSKS,"-",3)))
 . . . . I $P(PRCSVAR,"-",1,2)'=$P(PRCSKS,"-",1,2)!(PRCSKS="") S PRCSK=1 Q
 . . . . S PRCSDA=$O(^PRCS(410,"F",PRCSKS,0)) ; get ien
 . . . . Q:PRCSDA'>0
 . . . . I $$MAINT(PRCSKS,PRCSDA)=1 Q  ; pointer values are wrong
 . . . . S PRCSCT=PRCSCT+1
 . . . . I $D(^PRCS(410,PRCSDA,4))
 . . . . I  S PRCSAMT=PRCSAMT+$S($P(^PRCS(410,PRCSDA,4),U):$P(^PRCS(410,PRCSDA,4),U),$P(^PRCS(410,PRCSDA,0),U,2)="A"&($P(^PRCS(410,PRCSDA,0),U,4)=1):$P(^PRCS(410,PRCSDA,4),U,6),1:0)
 . . . ;
 . . . Q:'PRCSCT  ; no txns awaiting approval
 . . . I $D(APPREQ) S CPCK(PRC("CP"))="" Q
 . . . W !,"You have "_PRCSCT_" request(s) to approve in station "_PRC("SITE")_", CP ",PRC("CP"),?60,"$: "_$J(PRCSAMT,9,2)
 . . . Q
 . . . ;
 . . Q:$D(APPREQ)
 . . ; if user is a clerk for this site and CP check processing queue
 . . I $D(^PRC(420,"A",DUZ,PRC("SITE"),+PRC("CP"),2)) D CHECK^PRCSRDIS
 ;
 Q
MAINT(TN,DA) ; returns 1 if 'F' subscripts inconsistent with master file data
 ; TN = Transaction name, DA = ien
 ; kills x-refs that are not correct
 N X,Y,U
 S Y=0 ; flag=0 if maintenance not required
 S U="^"
 I '$D(^PRCS(410,DA,0)) S Y=1 G MAINTQ ; shouldn't the xrefs be killed?
 ; if document is signed by an aproving official, kill xrefs
 I $D(^PRCS(410,DA,7)),$P(^PRCS(410,DA,7),U,6)]"" S Y=1 D KXREF G MAINTQ
 ; if document is not ready for approval, kill x-refs
 I $S('$D(^PRCS(410,DA,11)):1,'$P(^PRCS(410,DA,11),U,3):1,1:0)
 I  S Y=1 D KXREF G MAINTQ
 S X=$P($P(^PRCS(410,DA,0),U),"-",4,5)
 ; if the CP or counter in 'F' differs from txn name at ien in 410 file
 I +$P(X,"-")'=$P(TN,"-",2)!($P(X,"-",2)'=$P(TN,"-",3))
 I  S Y=1
 I  K ^PRCS(410,"F",TN,DA)
 I  K ^PRCS(410,"F1",$P(TN,"-",3)_"-"_$P(TN,"-",1,2),DA)
MAINTQ Q Y
KXREF ;KILL F,F1 AND AQ CROSS REFERENCES
 K ^PRCS(410,"F",PRC("SITE")_"-"_+PRC("CP")_"-"_$P($P(^PRCS(410,DA,0),U),"-",5),DA)
 K ^PRCS(410,"F1",$P($P(^PRCS(410,DA,0),U),"-",5)_"-"_PRC("SITE")_"-"_+PRC("CP"),DA)
 K ^PRCS(410,"AQ",1,DA)
 Q
 ;
K ;
 S X=+T2_"-"_+$P(T2,"-",4)_"-"_$P(T2,"-",5)
 K ^PRCS(410,"F",X,DA)
 S X=$P(X,"-",3)_"-"_$P(X,"-",1,2)
 K ^PRCS(410,"F1",X,DA)
 Q
 ;
CPF(PRCIPFLG) ; Entry point for Inv. Pt. selection
CP ;CONTROL POINT SCREEN FROM MENU
 I '$G(PRCIPFLG) N:'$D(PRCIPFLG) PRCIPFLG S PRCIPFLG=0
 K PRCSIP ; inventory distribution point variable
 S DIC="^PRC(420,"_PRC("SITE")_",1,"
 S DIC(0)="AEMNQZ"
 S DIC("A")="Select CONTROL POINT: "
 I $D(PRC("CP")) S DIC("B")=$S($D(^PRC(420,"A",DUZ,PRC("SITE"),+PRC("CP"),PRCSC)):PRC("CP"),1:"")
 S DIC("S")="I '$P(^(0),U,19),$S($D(^PRC(420,""A"",DUZ,PRC(""SITE""),+Y,PRCSC)):1,"
 I PRCSC=1 S DIC("S")=DIC("S")_"$O(^PRC(420,""A"",DUZ,PRC(""SITE""),+Y,0))=(PRCSC+1):1,1:0)"
 I PRCSC=2 S DIC("S")=DIC("S")_"$D(^PRC(420,""A"",DUZ,PRC(""SITE""),+Y,PRCSC)):1,1:0)"
 I PRCSC=3 S DIC("S")=DIC("S")_"$P(^PRC(420,PRC(""SITE""),1,+Y,0),U,9)=""Y""!($O(^PRC(420,""A"",DUZ,PRC(""SITE""),+Y,0))>0):1,1:0)"
 I PRCSC=4 K DIC("S")
 S D="B^C" D MIX^DIC1 K DIC("A"),DIC("B"),DIC("S")
 Q:Y<0
 S PRC("CP")=$P(Y(0),U)
 I PRCIPFLG=1 D IP^PRCSUT
 Q
PRT ;REQUESTS TO BE APPROVED LIST
 D EN3^PRCSUT
 G W2^PRCSEB:'$D(PRC("SITE"))
 G END:Y<0
 S L=0,DIC="^PRCS(410,"
 S FLDS="[PRCS REQUESTS FOR APPROVAL]"
 S BY="'55"
 S (FR,TO)=""
 S DIS(0)="I $D(^PRCS(410,D0,0)),$P($G(^PRCS(410,D0,0)),""-"")=PRC(""SITE""),$P(^(0),""-"",4)=$P(PRC(""CP""),"" ""),$P($G(^PRCS(410,D0,1)),U,2)="""""
 D EN1^DIP
 R !,"Press return to continue or uparrow to exit: ",X:DTIME,!
 Q:('$T)!(X'="")
 G PRT
END Q
RL ;RENUMBER LINE ITEMS
 K I
 I $D(^PRCS(410,DA,"IT",0)) K ^("AB"),^("B") S Z=0 F I=1:1 S Z=$O(^PRCS(410,DA,"IT",Z)) Q:Z'>0  S L=^(Z,0) S ^(0)=I_U_$P(^(0),U,2,99) S ^PRCS(410,DA,"IT","B",I,Z)="",^PRCS(410,DA,"IT","AB",I,Z)=""
 S I=$S($D(I):I-1,1:0)
 S ^PRCS(410,DA,10)=$S($D(^PRCS(410,DA,10)):I_U_$P(^(10),U,2,99),1:I)
 K I,L,Z
 Q
RLR ;RENUMBER LINE ITEMS IN REP ITEM LIST FILE
 K I,L
 Q:'$D(^PRCS(410.3,D0,1,0))
 K ^("AC"),^("B")
 S (PRCSCS,Z)=0
 F I=1:1 S Z=$O(^PRCS(410.3,D0,1,Z)) Q:Z'>0  S L(I)=^(Z,0) K ^PRCS(410.3,D0,1,Z,0)
 K Z
 S I=0
 F J=1:1 S I=$O(L(I)) Q:I'>0  S Z=L(I),^PRCS(410.3,D0,1,J,0)=+Z_U_$P(Z,U,2,99) S PRCSCS=PRCSCS+($P(Z,U,2)*$P(Z,U,4)),^PRCS(410.3,D0,1,"AC",$P(Z,U,3),I)="",^PRCS(410.3,D0,1,"B",+Z,I)=""
 S $P(^PRCS(410.3,D0,1,0),U,3,4)=(J-1)_U_(J-1),$P(^PRCS(410.3,D0,0),U,2)=PRCSCS
 K I,L,PRCSCS,Z
 Q
