LRVER4 ;DALOI/CJS/DALOI/FHS - LAB ROUTINE DATA VERIFICATION ;8/11/97
 ;;5.2;LAB SERVICE;**14,42,112,121,140,171,153,188,279,283,286**;Sep 27, 1994
 ;
 N LRAMEND,LRRFLAG
 ;
LOOP ;
 S LRLCT=0
 I '$D(LRGVP) D
 . S:$D(LRWRDS) LRWRD=LRWRDS
 . W !!,PNM,"  SSN: ",SSN,"   " S LRLCT=LRLCT+1
 . I LRDPF=2 W "   LOC: ",$S(LRWRD'="":LRWRD,1:$S($L($P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,7)):$P(^(0),U,7),1:"??"))
 ;
 W !,"Pat Info: ",$P($G(^LR(LRDFN,.091)),U)
 W ?34," Sex: ",$S(SEX="M":"MALE",SEX="F":"FEMALE",1:SEX)
 W ?48," Age: ",$$CALCAGE^LRRPU(DOB,LRCDT)," as of ",$$FMTE^XLFDT(LRCDT,"1D")
 S LRPRAC=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,8)
 I LRPRAC>0,LRPRAC=+LRPRAC D GETS^DIQ(200,LRPRAC_",",".01;.132;.137;.138","E","LRPRAC(LRPRAC)","LRERR")
 W !,"Provider: "
 S LRLCT=LRLCT+2
 I LRPRAC'="",'$D(LRPRAC(LRPRAC,200)) W LRPRAC
 I LRPRAC,$D(LRPRAC(LRPRAC,200)) D
 . W LRPRAC(LRPRAC,200,LRPRAC_",",.01,"E"),?40," Voice pager: ",LRPRAC(LRPRAC,200,LRPRAC_",",.137,"E")
 . W !,"   Phone: ",LRPRAC(LRPRAC,200,LRPRAC_",",.132,"E"),?38," Digital pager: ",LRPRAC(LRPRAC,200,LRPRAC_",",.138,"E")
 . S LRLCT=LRLCT+1
 ;
 N PRAC,PR
 D PRAC^LR7OMERG(LRAA,LRAD,LRAN,.PRAC)
 I $O(PRAC(0)) D
 . S PR=0
 . F  S PR=$O(PRAC(PR)) Q:PR<1  I $D(^VA(200,PR,0)) W !?14,$P(^(0),"^") S LRLCT=LRLCT+1
 W ! S LRLCT=LRLCT+1
 S LRNX=0,LRVRM=2,T=""
 I $P(^LR(LRDFN,LRSS,LRIDT,0),U,7)'="" D
 . W !,"VOLUME: ",$P(^(0),U,7)
 . S LRLCT=LRLCT+1
 S LRACC=$P(Z1,U,6)
 W !,"ACCESSION:",?30,$P(Z2,U,6),?44," ",LRACC
 W !,?30,LRDAT(2) W ?44," ",LRDAT
 S LRLCT=LRLCT+2
 I $D(LRALERT),LRALERT<($P(LRPARAM,U,20)+1) D
 . W !?15 W:$E(IOST,1,2)="C-" @LRVIDO
 . W "Test ordered "_$P($G(^LAB(62.05,+LRALERT,0)),U)
 . W:$E(IOST,1,2)="C-" @LRVIDOF,$C(7)
 . S LRLCT=LRLCT+1
 ;
 I '$O(LRORD(0)) W !!?7,$C(7),"This is not a verifiable test/accession ",! Q
V I $D(LRGVP) D V20 Q
 G EDIT:($O(^LR(LRDFN,LRSS,LRIDT,1))=""!('LRVF&$D(LRPER)))&'$D(LRNUF)
 K LRNUF
 D V20,ND G V37:LRVF&'$D(X)#2,EDIT:LREDIT
 S LRTEC=$S($D(^LRO(68,LRAA,1,LRAD,2)):$P(^(2),U),1:$S($D(LRUSI):LRUSI,1:"")),LREDIT=0
V36 ;
 Q:$D(LRGVP)
 K DIR
 S DIR(0)="SAO^E:Edit;C:Comments;W:Workload"
 S DIR("A")="SELECT ('E' to Edit, 'C' for Comments, 'W' Workload): "
 D ^DIR
 I $D(DIRUT) S X="^" G V37
 S X=Y
 S:$E(X)="E" LREDIT=1,X=""
 K LRNC
 I $E(X)="C" S LRNC=1 D COM K LRNC G V36
 I $E(X)="W" D  G LOOP
 . I $P(LRPARAM,U,14),$P($G(^LRO(68,LRAA,0)),U,16) D STD^LRCAPV,EN^LRCAPV S LREND=0 Q
 . W !?10," Workload is not activated."
 S X=$S(X="@":"",X="":LRTEC,1:X),LRTEC=X
 S:'$D(^LRO(68,LRAA,1,LRAD,2)) ^(2)="" S ^(2)=X_U_$P(^(2),U,2,99)
 G EDIT:LREDIT
V37 Q  ;LEAVE LRVER4, BACK TO LRVER3
 ;
 ;
V20 ;
 I $G(LRCHG) D V21,DCOM^LRVERA Q
 S LRNX=$O(LRORD(LRNX)) G V35:LRNX<1 D SUBS
 G:'$G(LRTS) V20
 I '$D(LRSB(LRSB)),'$D(^LR(LRDFN,LRSS,LRIDT,LRSB)) G V20
 D V25^LRVER5
 ;
 D:$D(LRGVP) PG Q:$D(LRGVP)&($D(DTOUT)!$D(DUOUT))
 ;
 W !,$P(^LAB(60,+LRTS,0),U)
 S X1=""
 I $D(^LR(LRDFN,LRSS,+LRLDT,LRSB)) D
 . S X1=$P(^(LRSB),U),X=X1
 . I $$GET1^DID(63.04,LRSB,"","TYPE","","LRERR")="SET" D
 . . S X=$$EXTERNAL^DILFD(63.04,LRSB,"",X1)
 . . I X="" S X=X1
 . W:X'="" ?30,@LRFP
 S (X,LRFLG)=""
 I $D(LRSB(LRSB)) D
 . N LRX
 . K LRNOVER(LRSB)
 . S (LRDL,LRX,X)=$P(LRSB(LRSB),U)
 . S LREDIT=0,LRFLG=$P(LRSB(LRSB),U,2)
 . I $$GET1^DID(63.04,LRSB,"","TYPE","","LRERR")="SET" D
 . . S X=$$EXTERNAL^DILFD(63.04,LRSB,"",LRX)
 . . I X="" S X=LRX
 . W ?44," ",@LRFP," ",LRFLG,?56," ",$P($P(LRSB(LRSB),U,5),"!",7) ;$P(LRNG,U,7)
 . S X=LRX
 . I X=""!(X="canc")!(X="comment")!(X="pending") Q
 . S Y=0
 . I LRDEL'="" S LRQ=1 X LRDEL K LRQ
 . W "  "
 . I '$D(LRQ),$E(LRFLG,2)="*" D DISPFLG^LRVER4
 ;
 S:$P(X,U)="" $P(LRSB(LRSB),U)=""
 I $P(X,U)'="" D
 . N I,LRX,LRY
 . S $P(LRSB(LRSB),U)=X,$P(LRSB(LRSB),U,2)=LRFLG
 . S LRX=$$TMPSB^LRVER1(LRSB),LRY=$P(LRSB(LRSB),U,3)
 . F I=1:1:$L(LRX,"!") I $P(LRY,"!",I)="" S $P(LRY,"!",I)=$P(LRX,"!",I)
 . S $P(LRSB(LRSB),U,3)=LRY
 . I $P($P(LRSB(LRSB),U,3),"!")="" D RONLT^LRVER3
 . D
 . . I $P(LRSB(LRSB),U,4)!($P(LRSB(LRSB),U)="pending") Q
 . . I '$D(LRSA(LRSB))#2 S $P(LRSB(LRSB),U,4)=$S($G(LRDUZ):LRDUZ,1:$G(DUZ)),$P(LRSB(LRSB),U,9)=$S($G(LRDUZ(2)):LRDUZ(2),$G(DUZ(2)):DUZ(2),1:"") Q
 . . I $P(LRSB(LRSB),U)=$P(LRSA(LRSB),U) S:$P(LRSA(LRSB),U,4) $P(LRSB(LRSB),U,4)=$P(LRSA(LRSB),U,4) S $P(LRSA(LRSB),U,3)=$P(LRSB(LRSB),U,3) Q
 . . S:'$P(LRSB(LRSB),U,4) $P(LRSB(LRSB),U,4)=$S($G(LRDUZ):LRDUZ,1:$G(DUZ)),$P(LRSB(LRSB),U,9)=$S($G(LRDUZ(2)):LRDUZ(2),$G(DUZ(2)):DUZ(2),1:"")
 . S $P(LRSB(LRSB),U,5)=$TR(LRNGS,U,"!")
 I '$D(LRNUF) S LRLCT=LRLCT+1 S:$X>80 LRLCT=LRLCT+1 D:LRLCT>22 WT G:$G(Y)'="^" V20
 ;
V35 ;
 D LRCFL:LRCFL]""
 D DCOM^LRVERA K LRNUF
 Q
 ;
 ;
LRCFL ;
 S LREXEC=LRCFL D ^LREXEC:LRCFL[""
 D:LRLCT>22 WT
 Q
 ;
 ;
EDIT ;
 K LROUT
 D ^LRVER5 S LRVRM=2 G:$G(LRCHG) LOOP G LRCFL:$D(LROUT)!$D(LRPER)
 G LOOP
 ;
 ;
RANGE ;
 N LRI,LRFIND
 S Y=X
 I X=""!(X="canc")!(X="comment")!(X="pending") Q
 W "  "
 F LRI=1:1:$L(X) S LRFIND=$E(X,LRI) Q:LRFIND?1(1N,1A,1".",1"-",1"<",1">")
 S X=$E(X,LRI,999)
 ;
 ; User has indicated specific normality to set - used when entering
 ; reference lab results and all the info to calculate is not available.
 I $G(LRRFLAG(LRSB)) S LRFLG=$P("L^L*^H^H*","^",LRRFLAG(LRSB))
 ;
 E  D RANGECHK
 I '$D(LRQ),$E(LRFLG,2)="*" D DISPFLG^LRVER4
RQ S X=Y
 Q
 ;
 ;
RANGECHK ; Check result against reference ranges and set flag
 ;
 ;
 ; Check for numeric abnormal results
 I X?.1"-".N.1".".N D  Q
 . I LRNG4'="",LRNG4?.1"-".N.1".".N,X<LRNG4 S LRFLG="L*" Q
 . I LRNG5'="",LRNG5?.1"-".N.1".".N,X>LRNG5 S LRFLG="H*" Q
 . I LRNG2'="",LRNG2?.1"-".N.1".".N,X<LRNG2 S LRFLG="L" Q
 . I LRNG3'="",LRNG3?.1"-".N.1".".N,X>LRNG3 S LRFLG="H" Q
 ;
 ; Check for <> abnormal results
 ; "<" results checked against low values
 ; ">" results checked against high values
 I X?1(1"<",1">").N.1".".N D  Q
 . N LRX
 . S LRX=$E(X,2,$L(X))
 . I $E(X)="<" D  Q
 . . I LRNG4'="",LRNG4?.N.1".".N,LRX<LRNG4 S LRFLG="L*" Q
 . . I LRNG4'="",LRNG4?.N.1".".N,LRX=LRNG4 S LRFLG="L*" Q
 . . I LRNG2'="",LRNG2?.N.1".".N,LRX<LRNG2 S LRFLG="L" Q
 . . I LRNG2'="",LRNG2?.N.1".".N,LRX=LRNG2 S LRFLG="L" Q
 . I $E(X)=">" D  Q
 . . I LRNG5'="",LRNG5?.N.1".".N,LRX>LRNG5 S LRFLG="H*" Q
 . . I LRNG5'="",LRNG5?.N.1".".N,LRX=LRNG5 S LRFLG="H*" Q
 . . I LRNG3'="",LRNG3?.N.1".".N,LRX>LRNG3 S LRFLG="H" Q
 . . I LRNG3'="",LRNG3?.N.1".".N,LRX=LRNG3 S LRFLG="H" Q
 ;
 ; Check for ranges, i.e. 0-5, 6-10.
 ; Compare first value to abnormal value
 I X?1.N1"-"1.N D  Q
 . I LRNG4'="",LRNG4?.N.1".".N,+X<LRNG4 S LRFLG="L*" Q
 . I LRNG5'="",LRNG5?.N.1".".N,+X>LRNG5 S LRFLG="H*" Q
 . I LRNG2'="",LRNG2?.N.1".".N,+X<LRNG2 S LRFLG="L" Q
 . I LRNG3'="",LRNG3?.N.1".".N,+X>LRNG3 S LRFLG="H" Q
 ;
 Q
 ;
 ;
DISPFLG ; Display critical flags
 ;
 I $E(IOST,1,2)="C-" W $C(7),@LRVIDO
 W "CRITICAL ",$S($E(LRFLG,1)="L":"LOW",$E(LRFLG,1)="H":"HIGH",1:""),"!!"
 I $E(IOST,1,2)="C-" W @LRVIDOF,$C(7),$C(7)
 Q
 ;
 ;
SUBS ;
 S LRSB=LRORD(LRNX),LRTS=$S($D(^TMP("LR",$J,"TMP",LRSB)):^(LRSB),1:0)
 Q
 ;
 ;
ND ;
 K X,DIR
 Q:'LRVF
 I '$P($G(LRLABKY),U) D  Q
 . W !,"You're not authorized to edit verified data."
 . S LREDIT=0
 S DIR(0)="FO"
 S DIR("A")="If you need to change something, enter your initials"
 S DIR("?")="To change verified results, enter your initials."
 D ^DIR
 S X=Y K DIR
 I $$UP^XLFSTR(X)'=$$UP^XLFSTR(LRUSI) S LREDIT=0 K X QUIT
 I $D(X)#2,'$G(LRCHG) W ! D  S LRCHG=1
 . K LRSA S LRSA=1
 . F  S LRSA=$O(^LR(LRDFN,"CH",LRIDT,LRSA)) Q:'LRSA  S LRSA(LRSA)=^(LRSA)
 Q
 ;
 ;
WT S LRLCT=0 Q:$D(LRGVP)
 W !,"PRESS ANY KEY TO CONTINUE, '^' TO STOP " R Y:DTIME S:'$T Y="^"
 Q
 ;
 ;
COM ;from LRVER5
 Q:$D(LRGVP)
 K DR
 S DIE="^LR("_LRDFN_",""CH"",",DA=LRIDT,DA(1)=LRDFN,DR=.99
 D ^DIE,COM1:$D(LRNC)
 L +^LR(LRDFN,LRSS,LRIDT):5
 I $O(^LR(LRDFN,"CH",LRIDT,1,0))="" K ^LR(LRDFN,"CH",LRIDT,1)
 L -^LR(LRDFN,LRSS,LRIDT)
 Q
 ;
 ;
VOL ;
 W !,"VOLUME: ",$P(^LR(LRDFN,LRSS,LRIDT,0),U,7),"//" R X:DTIME
 G VOL:X["?" S:X'=""&(X'[U) ^(0)=$P(^(0),U,1,6)_U_X_U_$P(^(0),U,8,10)
 G COM
 ;
 ;
COM1 ;
 N LRX Q:'$P(^LR(LRDFN,LRSS,LRIDT,0),U,3)
 D XREF^LRVER3A
 S LRX=0 F  S LRX=$O(^TMP("LR",$J,"TMP",LRX)) Q:LRX<1  S ^LRO(68,"AC",LRDFN,LRIDT,LRX)=""
 I $L($P(^LR(LRDFN,LRSS,LRIDT,0),U,9)),$E($P(^(0),U,9))'="-" S $P(^(0),U,9)="-"_$P(^(0),U,9)
 Q
 ;
 ;
PG Q:$Y<(IOSL+5)
 I $E(IOST,1,2)'="C-" W @IOF Q
 D PG^LRGVP
 Q
 ;
V21 ;
 N Y,LREND
 S LRSB=1,LRLCT=1
 F  S LRSB=+$O(LRSB(LRSB)) Q:'LRSB!($G(LREND))  D
 . N LRX
 . S LRTS=$O(^LAB(60,"C","CH;"_LRSB_";1",0)) Q:'LRTS
 . D V25^LRVER5
 . W !,$P(^LAB(60,LRTS,0),U) S X1=""
 . I $D(^LR(LRDFN,LRSS,+LRLDT,LRSB)) D
 . . S X1=$P(^(LRSB),U),(LRDL,X)=X1
 . . I $$GET1^DID(63.04,LRSB,"","TYPE","","LRERR")="SET" D
 . . . S X=$$EXTERNAL^DILFD(63.04,LRSB,"",X1)
 . . . I X="" S X=X1
 . . W:X'="" ?30,@LRFP
 . S (LRDL,LRX,X)=$P(LRSB(LRSB),U)
 . S LREDIT=0,LRFLG=$P(LRSB(LRSB),U,2)
 . I $$GET1^DID(63.04,LRSB,"","TYPE","","LRERR")="SET" D
 . . S X=$$EXTERNAL^DILFD(63.04,LRSB,"",LRX)
 . . I X="" S X=LRX
 . W ?44," ",@LRFP," ",LRFLG,?56," ",$P(LRNG,U,7)
 . S X=LRX
 . I X=""!(X="canc")!(X="comment")!(X="pending") Q
 . S Y=0
 . I LRDEL'="" S LRQ=1 X LRDEL K LRQ
 . W "  "
 . I '$D(LRQ),$E(LRFLG,2)="*" D DISPFLG^LRVER4
 . I '$D(LRNUF) S LRLCT=LRLCT+1 S:$X>80 LRLCT=LRLCT+1 D:LRLCT>15 WT S:$E($G(Y))="^" LREND=1
 Q
