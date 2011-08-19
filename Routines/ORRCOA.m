ORRCOA ;SLC/JMH - ORDER ACKNOWLEDGMENT QUERY UTILITY ;  ; Compiled January 31, 2006 09:47:02
 ;;1.0;CARE MANAGEMENT;**5**;Jul 15, 2003;Build 4
 ;
 ;
INQBYORD ;
 N NUM,DIR,X,Y,LIST
 S NUM=1,LIST=""
 W !!
 W "This option searches the ORDER ACKNOWLEDGMENT file for entries related to a"
 W !,"    specific order.  This can be used to help determine if a provider"
 W !,"    has already acknowledged an order or not."
 W !!
 S DIR(0)="NO",DIR("A")="Enter an Order Number: "
 S X="" F  D ^DIR Q:'X!(X="^")  D
 .N IEN
 .S IEN=$O(^ORA(102.4,"B",X,0))
 .I 'IEN W !!,"There are no records in the ORDER ACKNOWLEDGMENT file that point to this ",!,"order number." Q
 .S LIST(IEN)=""
 Q:X="^"
 I $D(LIST)'=11 W !!,"No records have been chosen for inclusion in the report." Q
 D PRINTLST(.LIST,NUM)
 Q
 ;
INQBYPRO ;
 N I,J,NUM,LIST,DIC,X,Y,DIR,PROV,START,END
 S NUM=2,LIST="",START=0,END=9999999
 W !!
 W "This option searches the ORDER ACKNOWLEDGMENT file for un-acknowledged orders"
 W !,"    only by provider.  This can be used to help a provider identify those"
 W !,"    orders that s/he still needs to take care of."
 W !,"    Orders that have already been acknowledged will NOT show up here."
 W !!
 S DIC="^VA(200,",DIC(0)="AEQZ" D ^DIC
 I 'Y Q
 S PROV=Y
 S I=0 F  S I=$O(^ORA(102.4,"ACK",+PROV,I)) Q:'I  D
 .S J=0 F  S J=$O(^ORA(102.4,"ACK",+PROV,I,J)) Q:'J  D
 ..S LIST(J)=""
 I $D(LIST)'=11 W !!,"No records have been chosen for inclusion in the report." Q
 D PRINTLST(.LIST,NUM)
 Q
 ;
PRINTREC(IEN) ;
 N ORDER,PROV,ACKDT
 S ORDER=+$G(^ORA(102.4,IEN,0))
 S PROV=$P($G(^ORA(102.4,IEN,0)),U,2)
 S PROV=$P($G(^VA(200,PROV,0)),U)
 S ACKDT=$$FMTE^XLFDT($P($G(^ORA(102.4,IEN,0)),U,3))
 I $G(ORDER) W !!,"ORDER: ",ORDER,?35,"PROVIDER: ",PROV
 I $L($G(ACKDT)) W !,?10,"ACKNOWLEDGEMENT DATE/TIME: ",ACKDT
 Q
 ;
PRINTLST(LIST,NUM) ;
 N %ZIS
 S %ZIS="M" D ^%ZIS U IO
 N I,ORRCQ
 S ORRCQ=0
 Q:'$D(LIST)
 W @IOF
 D HDR(NUM)
 S I=0 F  S I=$O(LIST(I)) Q:'I!(ORRCQ)  D
 .D PRINTREC(I)
 .I $Y>(IOSL-3)&(IOST["C-") S ORRCQ='$$PAUSE() D
 ..Q:ORRCQ
 ..W @IOF
 ..D HDR(NUM)
 W !,"_________________________________________________",!!
 I ORRCQ W !,"Exiting report before complete..."
 I 'ORRCQ W !,"End of report."
 D ^%ZISC
 Q
HDR(NUM) ;
 I NUM=1 D
 . W !,"Listing of ORDER ACKNOWLEDGEMENTS by order number"
 . W !,"================================================="
 I NUM=2 D
 . W !,"Listing of ORDER ACKNOWLEDGMENTES by Provider"
 . W !,"============================================="
 Q 0
PAUSE() ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT
 S DIR(0)="E"
 D ^DIR
 Q $S(Y'=1:0,1:1)
