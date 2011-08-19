LR7OU5 ;DALOI/DCM/FHS-NLT LINKING UTILITY SEMI-MANUAL ; 2/23/07 6:53am
 ;;5.2;LAB SERVICE;**127,201,272,334**;Sep 27, 1994;Build 12
 ; Reference to ^%ZIS supported by IA #10086
 ; Reference to ^%ZISC supported by IA #10089
 ; Reference to ^%ZTLOAD supported by IA #10063
 ; Reference to ^DIC supported by IA #10007
 ; Reference to ^DIR supported by IA #10026
 ; Reference to $$HTE^XLFDT supported by IA #10103
 ; Reference to $$CJ^XLFDT supported by IA #10104
 ; Reference to $$LJ^XLFDT supported by IA #10104
EN ;
64 ;User assigns links between 60 and 64 (NLT)
 D LLIST G:$G(LREND) END
 I '$O(^LAB(60,"AD",0)) D  H 5
 . W !?5,"You have not yet ran the 'Semi-automatic Linking of file 60 to 64' option",!
 . W !?20,"[LR70 60-64 AUTO]",!
 . W !,"IT IS STRONGLY RECOMMENDED YOU RUN THE AUTOMATIC OPTION FIRST",!!
 W !,$$CJ^XLFSTR("This option will allow you to make links between file 64 (NLT) and file 60.",80)
 W !,$$CJ^XLFSTR("You may select ANY NLT code to create ",80)
 W !,$$CJ^XLFSTR("a linkage of entries between these two files. ",80)
 W !,$$CJ^XLFSTR("Tests with the type of NEITHER or null will be skipped in the Auto Mode.",80)
 W !,$$CJ^XLFSTR("ONLY ORDERABLE LAB TEST NEED TO BE LINKED TO WKLD CODES.",80),!
 K DIR S DIR("A")="Would you like a list of WKLD CODES from LABORATORY TEST file",DIR(0)="Y",DIR("B")="No"
 D ^DIR G:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) END I Y=1 D   G:$D(DIRUT)!($D(DTOUT))!($D(DUOUT))!(Y=0) END G START
 . D ^LRCAPD K DIR S DIR("A")="Ready to start linkage procedure ",DIR(0)="Y"
 . D ^DIR
MSG ;
 W ! K DIR S DIR("A")="Ready to proceed",DIR(0)="Y"
 D ^DIR G:$D(DIRUT)!($D(DTOUT))!($D(DUOUT))!(Y'=1) END
START W ! K DIR S DIR("A")="Select Linking Method ",DIR(0)="S^M:Manual;S:Semi-Auto",DIR("?")="Linking method description"
 W !!,$$CJ^XLFSTR(DIR("A"),80)
 F I=1:1 S LN=$P($T(TXT+I),";;",2) Q:LN="END"  S DIR("?",I)=LN W !,$$LJ^XLFSTR(LN,80)
 W !! K LN D ^DIR K DIR G:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) END G:Y="M" SEL
LIST ;Print LOINC Code Status
 K DIR W !!?5,"Select a starting TEST NAME " R LRN:DTIME G:'$T!($E(LRN)=U) END
LK ;
 W ! S AUTO=0 S:$L(LRN)>1 LRN=$E(LRN,1,($L(LRN)-1))
LAB ;
 S END="" F  S LRN=$O(^LAB(60,"B",LRN)) Q:LRN=""!($G(END))  D
 . S LRIEN="" F  S LRIEN=+$O(^LAB(60,"B",LRN,LRIEN)) Q:LRIEN<1!($G(END))  I '$G(^(LRIEN)) D CHECK
 W:'$G(END) !!,$$CJ^XLFSTR("End of loop",80),!
 G END
 Q
CHECK ;
 K DIC Q:'($D(^LAB(60,LRIEN,0))#2)!($G(^LAB(60,LRIEN,64)))!($G(END))
 S LRDATA=$P(^LAB(60,LRIEN,0),U),LRTY=$P(^(0),U,3) Q:LRTY=""!(LRTY="N")
 D  I $G(LRMIEN) S:($D(^LAM(LRMIEN,0))#2) Y=LRMIEN,Y(0)=^(0),LRCODE=$P(Y(0),U,2),LRMNAME=$P(Y(0),U) G OK
 . K LRMIEN D 91^LR7OU4
 . Q:'$G(LRMIEN)!'($D(^LAM(+$G(LRMIEN),0))#2)  S LRCODE=$P($P(^(0),U,2),".",1)_".0000 " I 'LRCODE W !,"Database is corrupted for WKLD CODE ",LRCODE S LRMIEN="" Q
 . S LRMIEN=$O(^LAM("C",LRCODE,0)) Q:('LRMIEN)!'($D(^LAM(LRMIEN,0))#2)
 K DIC S DIC="^LAM(",DIC(0)="AQEZNM"
 W !,$$CJ^XLFSTR("Select NLT code to be linked with LAB TEST",80),!,$$CJ^XLFSTR(LRDATA,80),!
 D ^DIC S:$E(X)=U END=1 Q:$G(END)!(Y<1)
 S LRMIEN=+Y,LRMNAME=$P(Y(0),U),LRCODE=$P(Y(0),U,2)
OK I '($D(^LAM(LRMIEN,0))#2) W !!,"Database is corrupted for IEN ",LRMIEN Q
 W !!,"60 = ",LRDATA,!,"64 = ",LRMNAME_"   "_LRCODE
 D LINK^LR7OU4(LRIEN,LRMIEN,AUTO)
 Q
END ;
 K LREND,LRANS,LRN,LRTY,ZTSAVE D END^LR7OU4
 K LINKED,LRMNAME,LRNLT,POP,ZTRTN,ZTDESC,ZTQUEUED
 K DIROUT,DIRUT,DTOUT,DUOUT,ZTDESC,X1,X60,X64,Y64 Q
SEL ;
 S AUTO=0
 K DIC,DIR S DIC("A")="You may select any test in LABORATORY TEST FILE: "
 S DIC="^LAB(60,",DIC(0)="AEQZMN" D ^DIC G:Y<1 END
 S LRDATA=$P(Y(0),U),(LRIEN,X60)=+Y
 I $G(^LAB(60,X60,64)),$D(^LAM(+^(64),0)) S Y64=^(0) D
 . W !!?5,"Currently linked to [ ",$P(Y64,U)_" ]   "_$P(Y64,U,2),!!
 W !!,"Now select ANY WKLD CODE for "_LRDATA,!!
 K DIC S DIC="^LAM(",DIC(0)="AEQZNM",DIC("A")="WKLD CODE: "
 D ^DIC G:Y<1 SEL S (LRMIEN,X64)=+Y,LRMNAME=$P(Y(0),U),LRCODE=$P(Y(0),U,2)
 D OK G SEL
TXT ;;
 ;;              Linking options description
 ;;ONLY ORDERABLE LAB TEST NEED TO BE LINKED TO WKLD CODES.
 ;;
 ;;(S) You can use the semi automated method, which will provide a
 ;;alphabetical listing of LABORATORY TEST names. The system will prompt
 ;;you for those tests not already assigned a WKLD CODE.
 ;;Tests with null TYPE or with the type of NEITHER are excluded.
 ;; 
 ;;(M) Using the Manual method, you are able to select ANY test
 ;;regardless of the type field in the LABORATORY TEST file,
 ;;and assign it a WKLD CODE. If the test is already linked 
 ;;the system will display the code and allow you to change
 ;;the WKLD CODE assigned. This method will allow you to
 ;;change linked LABORATORY TEST to another WKLD CODE.
 ;;END
 Q
LLIST ;
 W !?5,"Would you like a list of Laboratory Tests"
 K DIR S DIR(0)="S^0:No;1:ALL;2:Linked;3:Unlinked" D ^DIR
 Q:$D(DIRUT)!($D(DTOUT))!($D(DUOUT))!(Y=0)
 S LRANS=Y
 K %ZIS S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) K ZTSAVE S ZTRTN="DQ^LR7OU5",ZTSAVE("LRANS")="",ZTDESC="LAB TEST LIST" D ^%ZTLOAD,^%ZISC Q
DQ U IO I $D(ZTQUEUED) S ZTREQ="@"
 W !!?5,"Listing of ",$S(LRANS=1:"ALL",LRANS=2:"LINKED",1:"UNLINKED")," Laboratory Test   [ ",$$HTE^XLFDT($H)," ] ",!!
 S LRN=""  F  S LRN=$O(^LAB(60,"B",LRN)) Q:LRN=""!($G(LREND))  S LRIEN="" D
 . F  S LRIEN=+$O(^LAB(60,"B",LRN,LRIEN)) Q:LRIEN<0!($G(^(LRIEN)))!($G(LREND))  Q:'$D(^LAB(60,LRIEN,0))  S LRTY=$P(^(0),U,3) Q:LRTY=""  D
 . . I LRANS=1 D PRT Q
 . . I LRANS=2,$G(^LAB(60,LRIEN,64)) D PRT Q
 . . I LRANS=3,'$G(^LAB(60,LRIEN,64)) D PRT Q
 W:$E(IOST,1,2)="P-" @IOF D ^%ZISC Q
PRT ;
 W !?5,LRN,?45,$S(LRTY="B":"BOTH",LRTY="N":"NEITHER",LRTY="O":"OUTPUT",1:"INPUT"),!
 S LRNLT=$G(^LAB(60,LRIEN,64)) I LRNLT,$D(^LAM(LRNLT,0)) W $P(^(0),U,2),?15,$P(^(0),U)
 W ! Q
