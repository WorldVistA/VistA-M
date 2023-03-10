LRTSTOUT ;DALOI/STAFF - JAM TESTS OFF ACCESSIONS ;July 29, 2019@10:00
 ;;5.2;LAB SERVICE;**100,121,153,202,221,337,350,445,527,541**;Sep 27, 1994;Build 7
 ;
 ; Cancel tests - Test are no longer deleted, instead the status is changed to Not Performed.
 ;
EN ;
 N LREND
 D EN^LRPARAM Q:$G(LREND)
 I '$D(LRLABKY) W !?5,"You are not authorized to change test status.",!,$C(7) S LREND=1 Q
 N LRXX W @IOF
 F  D  Q:$G(LREND)
 . D END
 . S (LREND,LRNOP)=0
 . D FIX
 . I $G(LREND) D UNLOCK Q
 . I '$G(LRNOP) D CHG
 . D UNLOCK
 D EXIT
 Q
 ;
 ;
FIX ;
 N LRACC,LRNATURE
 S (LREND,LRNOP)=0,LRNOW=$$NOW^XLFDT
 W ! S LRACC=1 D LRACC Q:$G(LRNOP)
 I $G(LRAN)<1 S LREND=1 Q
 I '$P($G(^LRO(68,+$G(LRAA),1,+$G(LRAD),1,+$G(LRAN),0)),U,2) W !?5,"Accession has no Test ",! S LRNOP=1 Q
 D LOCK^DILF("^LRO(68,LRAA,1,LRAD,1,LRAN)")
 I '$T W !,"Someone else is working on this accession",! S LRNOP=1 Q
 ;
 S LRX=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRACN=$P(^(.2),U),LRUID=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),U)
 S LRDFN=+LRX,LRSN=+$P(LRX,U,5),LRODT=+$P(LRX,U,4)
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 D PT^LRX
 W !,PNM,?30,SSN
 S LRIDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U,5)
 D LOCK^DILF("^LR(LRDFN,LRSS,LRIDT)")
 I '$T W !,"Someone else is working on this data." S LRNOP=1 Q
 ;
 I '$G(^LR(LRDFN,LRSS,LRIDT,0)) W !?5," Can't find Lab Data for this accession",! D UNLOCK S LRNOP=1 Q
 ;
 I LRODT,LRSN,$D(^LRO(69,LRODT,1,LRSN,0))#2 D
 . N LRACN,LRAA,LRAD
 . D SHOW^LROS
 ;
 K DIR
 S DIR(0)="E" D ^DIR
 I $D(DIRUT) S LRNOP=1 Q
 ;
FX1 ;
 D SHOWTST
 Q
 ;
 ;
CHG ;
 N DIC,I,LRCOMM,LRCTST,LROTA,LRXX
 W !
 S:'$D(DIC("A")) DIC("A")="Change which LABORATORY TEST: "
 S DIC="^LRO(68,"_LRAA_",1,"_LRAD_",1,"_LRAN_",4,",DIC("S")="I '$L($P(^(0),U,5))",DIC(0)="AEMOQ"
 F  D ^DIC Q:Y<1  S LRCTST(+Y)=$P(^LAB(60,+Y,0),U),DIC("A")="Select another test: "
 I '$O(LRCTST(0)) D  Q
 . D UNLOCK
 . W !?5,"No Test Selected",!
 I LRODT=""!(LRSN="") W !,"NO CHANGE" D UNLOCK,END Q
 S LRCCOM="",LREND=0
 I '($D(^LRO(69,LRODT,1,LRSN,0))#2) W !?5,"There is no Order for this Accession",! D UNLOCK,END Q
 W @IOF,!!?5,"Change Accession : ",LRACN,?40,"UID: ",LRUID
 ;
 ; Check if tests selected have results stored in file #63.
 S I=0
 F  S I=$O(LRCTST(I)) Q:I<1  D
 . N LRX
 . W !?10,LRCTST(I)
 . S LRX=$$CHK63(I,LRDFN,LRSS,LRIDT)
 . I LRX>0 S LRNOP=1
 . I LRX=1 W ?40," Results entered for this test, cannot NP until removed."
 . I LRX=2 W ?40," Results entered for this test, cannot NP this test."
 . I LRX=3 W ?40," Results verified for this test, cannot NP this test."
 I LRNOP Q
 ;
 D FX2 Q:$G(LREND)
 ;
 S LRTSTS=0
 F  S LRTSTS=$O(LRCTST(LRTSTS)) Q:LRTSTS<1  D
 . Q:'($D(^LAB(60,LRTSTS,0))#2)  S LRTNM=$P(^(0),U)
 . ;The test being canceled might be a component of a panel which was ordered.
 . ;If not a panel (i.e. "atomic test"), LRORDTST=LRTSTS
 . S LRORDTST=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTSTS,0),U,9) D SET,CLNPENDG
 . D LEDICHK  ; ccr_6164n
 . W:'$G(LREND) !?5,"[ "_LRTNM_" ] ",$S('$D(LRLABKY):" Marked Canceled by Floor",1:" Marked Not Performed"),!
 ;
 I $D(LROTA) D LEDISET(.LROTA) ; ccr_6164n
 ;
 S LREND=0
 ;
 Q
 ;
 ;
SHOWTST ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LRI,LRN,LRY,LRIC,X
 S DIR(0)="E"
 D DEMO
 S (LRN,LRI)=0
 F  S LRI=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI)) Q:LRI<1!($G(LRY))  D
 . S LRIC=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI,0)),U,4,6) Q:'($D(^LAB(60,+LRI,0))#2)
 . W !,?5,$P(^(0),U) S LRN=LRN+1
 . I LRIC W ?35,"  "_$S($L($P(LRIC,U,3)):$P(LRIC,U,3),1:"Completed")_"  "_$$FMTE^XLFDT($P(LRIC,U,2),"1FMZ")_" by "_$P(LRIC,U)
 . I LRN>18 D ^DIR S:$D(DIRUT) LRY=1 Q:$G(LRY)  D DEMO S LRN=0
 ;
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRODT=$P(X,U,4),LRSN=$P(X,U,5)
 ;
 Q
 ;
 ;
DEMO W !,PNM,?50,SSN
 W !,"TESTS ON ACCESSION: ",LRACN,?40,"UID: ",LRUID
 Q
 ;
 ;
SET ;
 S LRNOW=$$NOW^XLFDT
 S LRLLOC=$P(^LRO(69,LRODT,1,LRSN,0),U,7)
 ;
 N II,X,LRI,LRSTATUS,OCXTRACE,ORIFN,ORSTS,LRMERGSO,LRORSTAT,LR7DONE
 S:$G(LRDBUG) OCXTRACE=1
 ;LR*5.2*527: SET^LRTSTOUT might be called from other routines
 ;            adding lines below:
 I '$G(LRORDTST),$G(LRAA)]"",$G(LRAD)]"",$G(LRAN)]"" D
 . Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))
 . ;make sure this is the same patient if called from another routine
 . Q:+^LRO(68,LRAA,1,LRAD,1,LRAN,0)'=+^LRO(69,LRODT,1,LRSN,0)
 . ;LRORDTST=ordered test
 . S LRORDTST=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTSTS,0)),U,9)
 ;LR*5.2*527 end of added lines
 S LRI=0
 F  S LRI=$O(^LRO(69,LRODT,1,LRSN,2,LRI)) Q:LRI<1  I $D(^(LRI,0))#2 D
 . ;LR*5.2*527: if don't have ordered test for some reason, make sure
 . ;            current test being evaluated is broken out in file 69.
 . I '$G(LRORDTST),LRTSTS'=+^LRO(69,LRODT,1,LRSN,2,LRI,0) Q
 . ;checking for ordered test or possibly component of ordered test (i.e. panel)
 . I $G(LRORDTST),LRTSTS'=+^LRO(69,LRODT,1,LRSN,2,LRI,0),LRORDTST'=+^LRO(69,LRODT,1,LRSN,2,LRI,0) Q
 . ;Already canceled = if 11th piece is not null
 . Q:$P(^LRO(69,LRODT,1,LRSN,2,LRI,0),U,11)  S ORIFN=$P(^(0),U,7),(LRORSTAT,LR7DONE)=0
 . S (LRSTATUS,II(LRTSTS))=""
 . S X=1+$O(^LRO(69,LRODT,1,LRSN,2,LRI,1.1,"A"),-1),X(1)=$P($G(^(0)),U,4)
 . ;LR*5.2*527 note: If a panel component is being canceled, the cancel comments
 . ;                 will be filed at both the panel and component levels so that
 . ;                 the comments will display as expected in various reports.
 . S ^LRO(69,LRODT,1,LRSN,2,LRI,1.1,X,0)=$P($G(LRNATURE),U,5)_": "_LRCCOM,X=X+1,X(1)=X(1)+1
 . S ^LRO(69,LRODT,1,LRSN,2,LRI,1.1,X,0)=$S($G(LRMERG):"*Merged:",'$D(LRLABKY):"*Cancel by Floor: ",1:"*NP Action: ")_$$FMTE^XLFDT(LRNOW,"1FMZ")
 . S ^LRO(69,LRODT,1,LRSN,2,LRI,1.1,0)="^^"_X_"^"_X(1)_"^"_DT
 . I $G(LRMERG),$P(^LRO(69,LRODT,1,LRSN,2,LRI,0),"^",3,5)'=(LRAD_"^"_LRAA_"^"_LRAN) D  ;Don't cancel test on order if accession merged to same order.
 . . Q:'$G(LRSOF)  ;same order flag has not been set
 . . S X=X+1,X(1)=X(1)+1
 . . S ^LRO(69,LRODT,1,LRSN,2,LRI,1.1,X,0)="*Merge from: "_$G(^LRO(68,+$G(LR1AA),1,+$G(LR1AD),1,+$G(LR1AN),.2),"Unknown")
 . . S ^LRO(69,LRODT,1,LRSN,2,LRI,1.1,0)="^^"_X_"^"_X(1)_"^"_DT
 . . S LRMERGSO=1,LRMSTATI=6 ;indicate that a same order merge occurred & we want to keep #100 order
 . ;LR*5.2*527: Check order status if deleting panel component
 . ;LR*5.2*541: ... if patient is in the PATIENT (#2) file
 . ;                (variable LRDPF).
 . I '$G(LRMERG),$G(LRORDTST),LRTSTS'=LRORDTST,$G(LRDPF)=2 D
 . . S LR7DONE=1
 . . S LRORSTAT=$$OR(LRORDTST,LRTSTS,ORIFN)
 . . ;don't update status if any pending tests
 . . Q:'LRORSTAT
 . . I '$G(ORIFN),'$D(II) Q
 . . D NEW^LR7OB1(LRODT,LRSN,$S(LRORSTAT=1:"SC",1:"OC"),$G(LRNATURE),.II,LRSTATUS)
 . . K ^TMP("LR",$J,"PANEL")
 . . ;LR*5.2*527 end of added lines
 . I 'LR7DONE,$G(ORIFN),$D(II) D NEW^LR7OB1(LRODT,LRSN,$S($G(LRMSTATI)=""!($G(LRMSTATI)=1):"OC",1:"SC"),$G(LRNATURE),.II,LRSTATUS)
 . ;Keep ^LR7OB1 call before ^^ update to status/DUZ in File #69 (below); see warning in 69^LR7OB69:
 . ;LR*5.2*527 added lines below:
 . I LR7DONE D
 . . ;only set canceled status in file 69 if everything on ordered test is canceled
 . . I LRORSTAT=2 D  Q
 . . . S $P(^LRO(69,LRODT,1,LRSN,2,LRI,0),"^",9)="CA",$P(^(0),U,10)="L",$P(^(0),U,11)=DUZ
 . . ;if a panel and components broken out, set canceled status for each canceled component
 . . I +^LRO(69,LRODT,1,LRSN,2,LRI,0)=LRTSTS D
 . . . S $P(^LRO(69,LRODT,1,LRSN,2,LRI,0),"^",9)="CA",$P(^(0),U,10)="L",$P(^(0),U,11)=DUZ
 . ;LR*5.2*527 end of added lines
 . I 'LR7DONE,'$D(LRMERGSO) S $P(^LRO(69,LRODT,1,LRSN,2,LRI,0),"^",9)="CA",$P(^(0),U,10)="L",$P(^(0),U,11)=DUZ
 . S:$D(^LRO(69,LRODT,1,LRSN,"PCE")) ^LRO(69,"AE",DUZ,LRODT,LRSN,LRI)=""
 . K II,LRMERGSO,LRSOF
 ;
 K ORIFN,ORSTS
 ;
 I $D(^LRO(68,+$G(LRAA),1,+$G(LRAD),1,+$G(LRAN),0))#2,$D(^(4,$G(LRTSTS),0))#2 S $P(^(0),U,4,6)=DUZ_U_LRNOW_U_$S($G(LRMERG):"*Merged",1:"*Not Performed") D
 . S LROWDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),U,3) I LROWDT,LROWDT'=LRAD D ROL Q
 . S LROWDT=+$G(^LRO(68,LRAA,1,LRAD,1,LRAN,9)) I LROWDT D ROL
 ;
 I $G(LRIDT),$G(LRSS)'="",LRCCOM'="",$G(^LR(LRDFN,LRSS,LRIDT,0)) D
 . D UPD63(LRDFN,LRSS,LRIDT,LRTNM,LRCCOM)
 . I '$D(^LRO(68,LRAA,1,LRAD,1,"AD",DT,LRAN)) D XREF^LRVER3A
 ;
 ; Update status of test in file #63 ORUT node.
 ; Set reporting site in file #63.
 I $G(LRIDT),$G(LRSS)'="" D
 . D ORUT
 . D SETRL^LRVERA(LRDFN,LRSS,LRIDT,DUZ(2))
 ;
 ; Put in list to check for auto download.
 ; Check if LEDI specimen and notify collecting facility
 I $G(LRAA),$G(LRAD),$G(LRAN),$D(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)) D
 . D EN^LA7ADL($P(^LRO(68,LRAA,1,LRAD,1,LRAN,.3),"^"))
 . ;I $P(^LRO(68,LRAA,1,LRAD,1,LRAN,.3),"^",3) D LEDI ;ccr_6164n
 ;
 Q
 ;
OR(LRORDTST,LRTSTS,ORIFN) ;evaluate overall status of order
 ;LR*5.2*527 added this section
 N LRXSN,LRXSTR,LRXPEND,LRXRESULT,LRXSTATUS
 ;AX8^LR7OB3 is called downstream from NEW^LR7OB1 and
 ;refers to ^TMP("LR",$J,"PANEL" to determine whether a panel
 ;is canceled.
 ;The kill below is not necessary, but adding as a safeguard.
 K ^TMP("LR",$J,"PANEL")
 ;Check all tests for this CPRS order number
 S (LRXSN,LRXPEND,LRXRESULT,LRXSTATUS)=0
 ;if any pending components within panel, stop evaluating
 F  S LRXSN=$O(^LRO(69,LRODT,1,LRSN,2,LRXSN)) Q:'LRXSN  Q:LRXPEND  D
 . S LRXSTR=$G(^LRO(69,LRODT,1,LRSN,2,LRXSN,0))
 . ;This test has a different CPRS order number.
 . Q:$P(LRXSTR,U,7)'=ORIFN
 . ;don't evaluate test currently being deleted
 . ;The file 68 status will be updated later.
 . Q:+LRXSTR=LRTSTS
 . N LRXAA,LRXAD,LRXAN
 . S LRXAA=$P(LRXSTR,U,4),LRXAD=$P(LRXSTR,U,3),LRXAN=$P(LRXSTR,U,5)
 . ;This test has not been accessioned, possibly because 
 . ;the components have been.
 . Q:LRXAA=""
 . ;Panels which "explode" into other panels might not be subscripted
 . ;in file 68.
 . Q:'$D(^LRO(68,LRXAA,1,LRXAD,1,LRXAN,4,+LRXSTR,0))
 . I $P($G(^LRO(68,LRXAA,1,LRXAD,1,LRXAN,4,+LRXSTR,0)),U,5)="" S LRXPEND=1 Q
 . ;Continue to check for pending panel components
 . ;Due to site requests, panel is marked as complete if any components are verified
 . ;so that the panel will not display on the "Incomplete Test Status Report".
 . N LRX68TST
 . S LRX68TST=0
 . F  S LRX68TST=$O(^LRO(68,LRXAA,1,LRXAD,1,LRXAN,4,LRX68TST)) Q:'LRX68TST  Q:LRXPEND  D
 . . S LRXSTR=$G(^LRO(68,LRXAA,1,LRXAD,1,LRXAN,4,LRX68TST,0))
 . . Q:$P(LRXSTR,U,9)'=LRORDTST
 . . Q:LRX68TST=LRTSTS
 . . I $P(LRXSTR,U,5)="" S LRXPEND=1 Q
 . . ;This test contains a result.
 . . I $P(LRXSTR,U,6)="" S LRXRESULT=1
 ;If there are any pending tests left on the order, do not call LR7OB1
 ;If no pending tests and any results, update to complete
 ;If no pending tests and no results, update to discontinued.
 S LRXSTATUS=$S(LRXPEND:0,LRXRESULT:1,1:2)
 S ^TMP("LR",$J,"PANEL",ORIFN)=LRXSTATUS
 Q LRXSTATUS
 ;
ROL ;
 Q:+$G(^LRO(68,LRAA,1,LROWDT,1,LRAN,0))'=LRDFN  Q:'($D(^(4,LRTSTS,0))#2)
 S $P(^LRO(68,LRAA,1,LROWDT,1,LRAN,4,LRTSTS,0),U,4,6)=DUZ_U_LRNOW_U_$S($G(LRMERG):"*Merged",1:"*Not Performed")
 Q
 ;
 ;
LRACC ;
 K LRAN
 S LREND=0,LREXMPT=1 D ^LRWU4 K LREXMPT
 Q:'$G(LRAA)!('$G(LRAN))!('($D(^LRO(68,LRAA,0))#2))
 S DA(2)=LRAA,DA(1)=LRAD,LRSS=$P(^LRO(68,LRAA,0),U,2)
 I LRSS="" S LRAN=0,LRNOP=1 W !?5,"No Subscript for this Accession Area ",!!
 Q
 ;
 ;
LREND ;
 S LREND=1
 Q
 ;
 ;
UNLOCK ;
 I +$G(LRDFN),$G(LRSS)'="",+$G(LRIDT) L -^LR(LRDFN,LRSS,LRIDT)
 I +$G(LRAA),+$G(LRAD),+$G(LRAN) L -^LRO(68,LRAA,1,LRAD,1,LRAN)
 ;
 Q
 ;
 ;
EXIT ;
 K LRSCNX,LREND,LRNOECHO,LRACN,LRLABRV,LRNOW
 ;
END ;
 K LRCCOM0,LRCCOM1,LRCCOMX,LRI,LRL,LRNATURE,LRNOP,LRSCN,LRMSTATI,LRORDTST,LROWDT,LRPRAC,LRTSTS,LRUID
 K Q9,LRXX,DIR,LRCOM,LRAGE,DI,LRCTST,LRACN,LRACN0,LRDOC,LRLL,LRNOW
 K LROD0,LROD1,LROD3,LROOS,LROS,LROSD,LROT,LRROD,LRTT,X4
 D KVA^VADPT,END^LRTSTJAM,V^LRU
 Q
 ;
 ;
FX2 ;
 S LREND=0,(LRCOM,LRCCOM1)=""
 I LRDPF=2,$G(LRNATURE)="" D DC^LROR6() I $G(LRNATURE)="-1" W !!,$C(7),"Nothing Changed",! S LREND=1 Q
 I '$D(LRLABKY) D FX3 Q
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="62.5,5",DIR("A")="Select NP comment Lab Description screen"
 S DIR("?",1)="The default expansion screens are GENERAL, ORDER and LAB"
 S DIR("?",2)="You may select an additional lab description expansion screen"
 S DIR("?",3)="which will be used to expand your NP reason."
 S DIR("?")="Press return to only use these default screens"
 ;
 K LRNOECHO
 S:$G(LRSCN)="" LRSCN="AKL"
 W !
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S LREND=1 Q
 I Y'="" S LRSCN=LRSCN_Y
 K X,Y
 ;
 F  D FX3 Q:LREND!($G(LRCCOM)'="")
 Q
 ;
 ;
FX3 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LRL,LRY
 S LRL=52,LREND=0
 S DIR("A")=$S('$D(LRLABKY):"Reason for Cancel",1:"Not Perform Reason")
 I $G(LRXX)'="" S DIR("B")=$G(LRXX)
 S DIR(0)="F^1:"_LRL_"^"
 W !
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S LREND=1 Q
 S LRY=Y
 ;
 I LREND Q
 I $D(LRLABKY) D
 . N LRSAV S LRSAV=LRSCN
 . S (LRXX,X)=LRY,Q9="1,"_LRL_","_LRSCN D COM^LRNUM S LRSCN=LRSAV
 . I $G(X)="" Q
 . I $E(X,$L(X))=" " S X=$E(X,1,($L(X)-1))
 . S LRY=X
 S (LRCCOM,LRCCOMX)=LRY
 I '$D(LRLABKY) W !,"("_LRCCOM_")"
 K DIR
 S DIR(0)="Y",DIR("A")="Satisfactory Comment",DIR("B")="Yes"
 D ^DIR
 I $D(DIRUT) S LREND=1 Q
 I Y=1 S LRCCOM=$E($S('$D(LRLABKY):"*Floor Cancel Reason: ",1:"*NP Reason: ")_LRCCOM,1,68)
 E  S (LRCCOM,LRCCOMX)=""
 Q
 ;
 ;
UPD63(LRDFN,LRSS,LRIDT,LRTNM,LRCCOM) ; Update file #63 with comment reflecting dispostion.
 ;
 N FDA,LRCCOMO,LRDIE,LRFN,LRNOECHO,LRY
 ;
 S:'$G(LRNOW) LRNOW=$$NOW^XLFDT
 S LRNOECHO=1
 S LRCCOMO=$E("*"_LRTNM_$S($G(LRMERG):" Merged: ",'$D(LRLABKY):" Floor Canceled: ",1:" Not Performed: ")_$$FMTE^XLFDT(LRNOW,"1FMZ")_" by "_DUZ,1,68)
  ;
 S LRFN=$S(LRSS="CH":63.041,LRSS="MI":63.05,LRSS="SP":63.98,LRSS="CY":63.908,LRSS="EM":63.208,LRSS="BB":63.199,1:"")
 I LRSS="MI" D  Q
 . S FDA(1,LRFN,LRIDT_","_LRDFN_",",.99)=LRCCOMO
 . D FILE^DIE("","FDA(1)","LRDIE(1)")
 . K FDA(1),LRDIE(1)
 ;
 F LRY=LRCCOMO,LRCCOM D
 . S FDA(1,LRFN,"+1,"_LRIDT_","_LRDFN_",",.01)=LRY
 . I $D(FDA(1)) D UPDATE^DIE("","FDA(1)","","LRDIE(1)")
 . K FDA(1),LRDIE(1)
 D CLEAN^DILF
 Q
 ;
 ;
CLNPENDG ; Remove pending and other info from Lab test when set to not performed
 N LRIFN
 S LRIFN=$P($G(^LAB(60,LRTSTS,.2)),U)
 I LRIFN'="",LRSS="CH" D
 . I $P($G(^LR(LRDFN,LRSS,LRIDT,LRIFN)),U)="pending" K ^LR(LRDFN,LRSS,LRIDT,LRIFN) Q
 . I $D(^LR(LRDFN,LRSS,LRIDT,LRIFN)),$P(^LR(LRDFN,LRSS,LRIDT,LRIFN),U)="" K ^LR(LRDFN,LRSS,LRIDT,LRIFN) Q
 Q
 ;
 ;
ORUT ; Update ORUT node in file #63 with this disposition
 N DIERR,LRDIE,LRFDA,LR60,LR60P,LR64,LR64P,LRDISPO,LRFN,LRIEN
 ;
 S LRDISPO="",LR60=LRTSTS,(LR64,LR64P,LRIEN)=0
 S LR64=$P($G(^LAB(60,LR60,64)),"^")
 ;
 S LR60P=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LR60,0)),"^",9)
 I LR60P S LR64P=$P($G(^LAB(60,LR60P,64)),"^")
 I LR64<1,LR64P<1 Q
 ;
 ; Check to see if NLT in ordered test multiple, check test or parent
 S LR64(0)=$$GET1^DIQ(64,LR64_",",1),LRIEN=0
 I LR64(0) S LRIEN=$O(^LR(LRDFN,LRSS,LRIDT,"ORUT","B",LR64(0),0))
 I LRIEN S LRDISPO=$$FIND1^DIC(64.061,"","OQX","X","D","I $P(^(0),U,5)=""0123""")
 I 'LRIEN,LR64P D
 . S LR64P(0)=$$GET1^DIQ(64,LR64P_",",1)
 . I LR64P(0) S LRIEN=$O(^LR(LRDFN,LRSS,LRIDT,"ORUT","B",LR64P(0),0))
 . I LRIEN S LRDISPO=$$FIND1^DIC(64.061,"","OQX","A","D","I $P(^(0),U,5)=""0123""")
 I LRDISPO<1 Q
 ;
 S LRFN=$S(LRSS="CH":63.07,LRSS="MI":63.5,LRSS="SP":63.53,LRSS="CY":63.51,LRSS="EM":63.52,1:"")
 I LRFN<1 Q
 S LRIEN=LRIEN_","_LRIDT_","_LRDFN_","
 S LRFDA(63,LRFN,LRIEN,10)=LRDISPO
 S LRFDA(63,LRFN,LRIEN,11)=LRNOW
 S LRFDA(63,LRFN,LRIEN,12)=DUZ
 D FILE^DIE("","LRFDA(63)","LRDIE(63)")
 D CLEAN^DILF
 Q
 ;
 ;
LEDICHK ; Add test to LROTA array if it is a LEDI accesison - added with ccr_6164n
 ;
 ; - When tests from an exploded panel are NP'ed, only send back one OBR with the ordered test,
 ;   instead of one OBR for each individual test on a panel that was NP'ed.
 ; - When tests from an exploded panel are NP'ed, send back an OBX for each individual test
 ;   that were NP'ed so the receiving system can determine which tests from the panel were NP'ed.
 ;
 ; Process flow:
 ;  - After NP'ing a test (via SET^LRTSTOUT), calling routine should call LEDICHK^LRTSTOUT.
 ;  - If it is a LEDI test, LEDICHK will add the NP'ed test to the LROTA array.
 ;  - After all tests are finished being NP'ed, calling process will then call LEDISET^LRTSTOUT.
 ;  - LEDISET will process LROTA array to send the LEDI messages.
 ;
 ;
 N LRORDTST,LRUID
 ;
 I '$P($G(^LRO(68,+$G(LRAA),1,+$G(LRAD),1,+$G(LRAN),.3)),"^",3) Q  ;Not a LEDI accession
 ;
 S LRUID=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,.3),"^")
 I LRUID="" Q
 S LRORDTST=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTSTS,0),U,9)
 I 'LRORDTST S LRORDTST=LRTSTS
 S LROTA(LRUID,LRORDTST)=LRAA_U_LRAD_U_LRAN_U_LRDFN_U_LRSS_U_LRIDT_U_LRODT
 I LRORDTST'=LRTSTS D  ;Send back OBX for this test, as it is part of panel
 . S LROTA(LRUID,LRORDTST,LRTSTS)=""
 ;
 ;
 Q
 ;
 ;
LEDISET(LROTA) ; added with ccr_6164n
 ;
 ; Called with: LROTA = array with LEDI tests (passed by reference)
 ;                 LROTA(UID,ORDERED TEST IEN)=LRAA_U_LRAD_U_LRAN_U_LRDFN_U_LRSS_U_LRIDT_U_LRODT
 ;                 LROTA(LRUID,ORDERED TEST IEN,TEST BEING NP'ED)=""
 ;
 N LRORDTST,LRUID,LRX
 ;
 Q:'$D(LROTA)
 ;
 S LRUID=""
 F  S LRUID=$O(LROTA(LRUID)) Q:LRUID=""  D
 . S LRORDTST=0
 . F  S LRORDTST=$O(LROTA(LRUID,LRORDTST)) Q:'LRORDTST  D
 . . N LA7VDB,LRTSTS,LRX
 . . S LRX=$G(LROTA(LRUID,LRORDTST))
 . . S LA7VDB=""
 . . S LRTSTS=0
 . . F  S LRTSTS=$O(LROTA(LRUID,LRORDTST,LRTSTS)) Q:'LRTSTS  D
 . . . N LA7TREE,LRSB,LRY
 . . . D UNWIND^LA7ADL1(LRTSTS,9,LRTSTS)
 . . . S LRY=0
 . . . F  S LRY=$O(LA7TREE(LRY)) Q:'LRY  D
 . . . . S LRSB=$P($G(^LAB(60,LRY,.2)),U)
 . . . . I LRSB="" Q
 . . . . I $P(LRX,U,5)="CH" S LA7VDB(LRSB)=LRSB
 . . D LEDI($P(LRX,U,1),$P(LRX,U,2),$P(LRX,U,3),$P(LRX,U,4),$P(LRX,U,5),$P(LRX,U,6),$P(LRX,U,7),LRORDTST,.LA7VDB)
 ;
 Q
 ;
 ;
LEDI(LRAA,LRAD,LRAN,LRDFN,LRSS,LRIDT,LRODT,LRORDTST,LA7VDB) ; Put accession in queue to send message back to collecting site.
 ;
 ; Made the following changes - ccr_6164n:
 ;  - Added formal paramater list
 ;  - Use parent test instead of individual NP'ed test (LRORDTST instead of LRTSTS)
 ;  - Pass in LA7VDB array to SET^LA7VMSG call (so that an OBX can be generated when individual tests from a panel are NP'ed).
 ;
 ; Handle CH subscript tests
 I LRSS="CH" D  Q
 . N LR64,LRORU3,LRTPN,LRTPNN
 . S LRORU3=^LRO(68,LRAA,1,LRAD,1,LRAN,.3),LR64=$P($G(^LAB(60,LRORDTST,64)),"^") Q:'LR64
 . S LRTPN=$$GET1^DIQ(64,LR64_",",.01),LRTPNN=$$GET1^DIQ(64,LR64_",",1)
 . D SET^LA7VMSG($P(LRORU3,U,4),$P(LRORU3,U,2),$P(LRORU3,U,5),$P(LRORU3,U,3),LRTPN,LRTPNN,LRIDT,LRSS,LRDFN,LRODT,.LA7VDB,"ORU")
 ;
 ; Handle the other subscripts - MI, SP, CY , EM.
 I LRSS?1(1"MI",1"SP",1"CY",1"EM") D MIAP^LA7VMSG(LRAA,LRAD,LRAN,LRORDTST,LRDFN,LRSS,LRIDT,LRODT)
 Q
 ;
 ;
CHK63(LR60,LRDFN,LRSS,LRIDT) ;  Check if tests being NP already have resuls in file #63.
 ; Call with LR60 = ien of entry in file #60
 ;          LRDFN = ien of entry in file #63
 ;           LRSS = file #63 subscript
 ;          LRIDT = file #63 inverse date/time of specimen
 ;
 ; Returns LRFLAG = flag indicating if results exist in file #63 for this test either verified or unverified.
 ;                  0 = no existing result in file #63
 ;                  1 = existing node, no result value
 ;                  2 = existing node, result value exists
 ;                  3 = result exists and accession verified
 ;
 N LA7TREE,LRFLAG,LRSB,LRX
 ;
 D UNWIND^LA7ADL1(LR60,9,LR60)
 S (LRFLAG,LRX)=0
 F  S LRX=$O(LA7TREE(LRX)) Q:'LRX  D
 . S LRSB=$P($P(^LAB(60,LRX,0),"^",5),";",2)
 . I LRSB="" Q
 . I '$D(^LR(LRDFN,LRSS,LRIDT,LRSB)) Q
 . I $P(^LR(LRDFN,LRSS,LRIDT,LRSB),"^")'="" D  Q
 . . I $P(^LR(LRDFN,LRSS,LRIDT,LRSB),"^")="pending" Q
 . . I $P(^LR(LRDFN,LRSS,LRIDT,0),"^",3) S LRFLAG=3
 . . E  S LRFLAG=2
 . S LRFLAG=1
 ;
 Q LRFLAG
