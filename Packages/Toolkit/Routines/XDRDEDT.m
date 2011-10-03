XDRDEDT ;SF-IRMFO/REM - EDIT STATUS FIELD IN FILE 15 ;10/10/08  13:38
 ;;7.3;TOOLKIT;**23,43,113**;Apr 25, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
EN ;;
 N XDRFIL,X,X1,X2,N1,N2,XDRDELET,XDROSTAT
EN2 K DIE,DIC
 S XDRFIL=$$FILE^XDRDPICK() Q:XDRFIL'>0  S XDRGLB=$G(^DIC(XDRFIL,0,"GL")) Q:XDRGLB=""
 F  D  Q:DA'>0
 . S DIC="^VA(15,",DIC(0)="AEQZ",DIC("S")="I $$SCRN^XDRDEDT(+Y,XDRGLB)"
 . S DIC("A")="Select an Entry to "_$S($D(XDRDELET):"DELETE: ",1:"RESET TO POTENTIAL DUPLICATES: ")
 . D ^DIC S DA=+Y Q:DA<0
 . I $P(^VA(15,DA,0),U,4)<2 S X1=+^VA(15,DA,0),X2=+$P(^(0),U,2)
 . E  S X1=+$P(^VA(15,DA,0),U,2),X2=+^(0)
 . S N1=$P(@(XDRGLB_X1_",0)"),U),N2=$P(@(XDRGLB_X2_",0)"),U)
 . S N1=$$PEELNAM(N1),N2=$$PEELNAM(N2)
 . W !!!,"  Duplicate Record File Entry ",DA," for the ",$P(^DIC(XDRFIL,0),U)," FILE"
 . ; XT*7.3*113 changed to call $$GET1^DIQ instead of EN^DIQ
 . S XDROSTAT=$$GET1^DIQ(15,DA_",",.03)
 . W !?10,X1,?20,N1,!?10,X2,?20,N2,!!?10,"Currently listed as ",XDROSTAT,!!
 . S DIR(0)="Y",DIR("A")="Do you really want to "_$S($D(XDRDELET):"DELETE THIS DUPLICATE RECORD ENTRY",1:"RESET to POTENTIAL DUPLICATE"),DIR("B")="NO"
 . D ^DIR Q:Y'>0
 . D NAME(DA)
 . I $D(XDRDELET) D
 . . N DIK
 . . S DIK="^VA(15," D ^DIK
 . I '$D(XDRDELET) D
 . . K DIE S DIE="^VA(15,",DR=".03///P;.04///@;.05///@;.07///@;.08///@;.1///@;.13///@;.14///@;" D ^DIE K DIE
 . . S:$D(DUZ) $P(^VA(15,DA,0),U,12)=DUZ
 . . K ^VA(15,DA,2)
 . . K ^VA(15,DA,3)
 . W !!,"   ",$S($D(XDRDELET):"Entry DELETED!",1:"Status RESET to POTENTIAL DUPLICATE RECORD."),!!,*7
 . ; If PATIENT and previous status was VERIFIED, NOT A DUPLICATE, inactivate entry
 . ; on the MPI DO NOT LINK file 985.28. - (new with XT*7.3*113)
 . I XDROSTAT'="VERIFIED, NOT A DUPLICATE" Q
 . Q:XDRFIL'=2
 . ; Quit if routine ^MPIFDNL is not loaded
 . S X="MPIFDNL" X ^%ZOSF("TEST") Q:'$T
 . S X=^VA(15,DA,0)
 . D CALLRPC^MPIFDNL(DUZ,DUZ(2),+X,+$P(X,U,2),1)
 . Q
 K DA,DR,DIC,DIE
 Q
SCRN(DA,GLOBAL) ;Screen for verified dup. or verified not dup.
 I $P(^(0),U,5)>1 Q 0 ; But don't take merged or merge in progress!
 I '$D(XDRDELET),$P(^(0),U,3)="P"!($P(^(0),U,3)="O") Q 0 ; DON'T NEED TO SET BACK
 I (U_$P($P(^(0),U),";",2))'=GLOBAL Q 0 ; Take only the specified file
 ;I $P(^(0),U,3)="V" Q 1
 ;I $P(^(0),U,3)="N" Q 1
 Q 1
 ;
NAME(DA) ;
 N X,X1,X2,N,N1,N2
 S X=^VA(15,DA,0),X1=+X,X2=+$P(X,U,2),X=$P($P(X,U),";",2)
 S N1=$P($G(@(U_X_X1_",0)")),U)
 S N2=$P($G(@(U_X_X2_",0)")),U)
 S N=$$PEELNAM(N1)
 I N'=N1 S $P(@(U_X_X1_",0)"),U)=N
 S N=$$PEELNAM(N2)
 I N'=N2 S $P(@(U_X_X2_",0)"),U)=N
 Q
PEELNAM(NAME) ;
 F  Q:NAME'["MERGING INTO"  S NAME=$P($P(NAME,"(",2,10),")",1,$L(NAME,")")-1)
 Q NAME
 ;
DELETE ;
 N XDRFIL,X,X1,X2,N1,N2,XDRDELET
 S XDRDELET=1
 D EN2
 Q
 ;
LOOKUP(FILE) ; FIND PAIRS IN DUPLICATE RECORD FILE
 N FILENAM,NAME,NAME1,NAME2,NAMEA,XDRDIC,DIR,Y,I,J,XDR1,IEN,N,X,FILID,IEN1
 S FILENAM=$P(^DIC(FILE,0),U) I FILENAM="" G NOFILE
 S XDRDIC=$G(^DIC(FILE,0,"GL")) I XDRDIC="" G NOFILE
 S XDRDIC=";"_$E(XDRDIC,2,99)
 ;
LOOK1 K DIR S DIR("A")="Select "_FILENAM,DIR(0)="FO^2" D ^DIR K DIR ; GET PART OF A NAME
 I X="" Q -1
 I $D(DIRUT)!(Y="^") Q -1
 ;
 ; GET A LIST OF NAMES IN THE FILE STARTING WITH THE USERS INPUT AND WHICH HAVE AN IEN THAT IS
 ; IN THE DUPLICATE RECORD FILE
 ;
 S NAME=$NA(^TMP($J,"XDRLIST")) K @NAME
 D FIND^DIC(FILE,"","","",X,"","B^BS5^SSN","I $D(^VA(15,""B"",(Y_XDRDIC)))","",NAME)
 ;
 S NAME1=$NA(@NAME@("DILIST"))
 ;
 ; NOW GO THROUGH THE LIST OF MATCHING NAMES AND CHECK FOR THOSE WHICH HAVE THE DESIRED STATUS
 ;    USE THE DATA UNDER THE 2 NODE WHICH IS THE IEN
 ;
 F I=0:0 S I=$O(@NAME1@(2,I)) Q:I'>0  S IEN=^(I) D
 . S XDR1=IEN_XDRDIC
 . F J=0:0 S J=$O(^VA(15,"B",XDR1,J)) Q:J'>0  I $P(^VA(15,J,0),U,3)="P" Q
 . ; IF NOT AT LEAST ONE WITH THE DESIRED STATUS, THEN REMOVE IT FROM THE ARRAY
 . I J'>0 F J=1,2,"ID" K @NAME1@(J,I)
 . Q
 ;
 S J=$O(@NAME1@(2,0)) I J'>0 G NONAME
 ;
 S NAME2=$NA(^TMP($J,"XDRLI1")) K @NAME2
 S N=0 F I=0:0 S I=$O(@NAME1@(1,I)) Q:I'>0  D
 . S N=N+1
 . S X=@NAME1@(1,I)_" [ien="_@NAME1@(2,I)_"]" F J=0:0 S J=$O(@NAME1@("ID",I,J)) Q:J'>0  S FILID(J)="" S X=X_"  "_@NAME1@("ID",I,J)
 . S @NAME2@(N)=X,@NAME2@(N,"IEN")=@NAME1@(2,I)
 S X=$$ASK(NAME2) I X'>0 G NONAME
 I N>1 W @NAME2@(X)
 S IEN1=@NAME2@(X,"IEN")_XDRDIC K @NAME2,@NAME
 S X=$$PAIR(IEN1,"FILID") I X'>0 G NONAME
 Q X
 ;
PAIR(IENDIC,IDARR) ;
 N FILE,IEN,NAME,XDRN,IEN2,XDRX1,XDRJ,XDRX
 S NAME=$NA(^TMP($J,"XDRPAIR")) K @NAME
 S FILE=+$P(@(U_$P(IENDIC,";",2)_"0)"),U,2),XDRN=0
 F IEN=0:0 S IEN=$O(^VA(15,"B",IENDIC,IEN)) Q:IEN'>0  I $P(^VA(15,IEN,0),U,3)="P" D
 . S XDRN=XDRN+1
 . S XDRX=^VA(15,IEN,0)
 . S IEN2=$P(XDRX,U) I IEN2=IENDIC S IEN2=$P(XDRX,U,2)
 . S IEN2=+IEN2,IENS=IEN2_","
 . S XDRX1=$$GET1^DIQ(FILE,IENS,.01)_" [iens="_IEN2_"]"
 . F XDRJ=0:0 S XDRJ=$O(@IDARR@(XDRJ)) Q:XDRJ'>0  S XDRX1=XDRX1_"  "_$$GET1^DIQ(FILE,IENS,XDRJ)
 . S @NAME@(XDRN)=XDRX1,@NAME@(XDRN,"IEN")=IEN
 I XDRN>1 W !!,"This entry is paired with more than one other record.",!,"Select which pair from the following list:",!
 S XDRX=$$ASK(NAME) I XDRX>0 S XDRX=@NAME@(XDRX,"IEN")
 K @NAME
 Q XDRX
 ;
ASK(ARRAY) ;
 N N,I,N1,NCHOICE
 W !
 S N=0 F I=0:0 S I=$O(@ARRAY@(I)) Q:I'>0  S N=N+1
 I N'>1 S I=+$O(@ARRAY@(0)) W:I>0 @ARRAY@(I) Q I
 I N>5 W "There are "_N_" choices.",!!
 S N1=0,NCHOICE=0
 F I=0:0 S I=$O(@ARRAY@(I)) Q:I'>0  S N1=N1+1 W !,N1,".  ",@ARRAY@(I) I '(N1#5) S NCHOICE=$$ASKEM(N1,N) Q:NCHOICE  Q:$D(DIRUT)
 I 'NCHOICE,'$D(DIRUT) S NCHOICE=$$ASKEM(N1,N1)
 Q NCHOICE
 ;
ASKEM(NCUR,NMAX) ;
 N DIR,Y
 W !! I NCUR<NMAX W !,"Choose from 1 to "_NCUR S DIR("A")="Or return to continue: ",DIR(0)="NO^1:"_NCUR
 E  S DIR("A")="Choose from 1 to "_NCUR,DIR(0)="N^1:"_NCUR
 D ^DIR W ! I $D(DIRUT),'$D(DTOUT),'$D(DUOUT) K DIRUT
 Q $S(Y>0:Y,1:0)
 ;
NOFILE ;
 W !,"FILE ",FILE," NOT FOUND",$C(7),!!
 Q -1
 ;
NONAME ;
 W $C(7),"??"
 G LOOK1
 ;
