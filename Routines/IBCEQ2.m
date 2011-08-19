IBCEQ2 ;ALB/TMK - PROVIDER/BILLING ID WORKSHEET ;18-AUG-04
 ;;2.0;INTEGRATED BILLING;**282**;21-MAR-94
 ;
 ; WORKSHEET TO IDENTIFY BC/BS AND TRICARE PLANS THAT MAY NEED SPECIAL
 ; SET UP FOR PERFORMING PROVIDER OR BILLING PROVIDER IDS
 ;
EN ;
 N POP,ZTSAVE,%ZIS,ZTSK,ZTRTN,ZTDESC,DIR,X,Y,DUOUT,DTOUT,Z,IBPG,IBSTOP,IBBL
 ;
 S DIR("A")="PRINT (P)RE-PRINTED, (B)LANK FORM, (S)OLUTIONS?: ",DIR(0)="SA^P:PRE-PRINTED;B:BLANK FORM;S:SOLUTIONS"
 S DIR("B")="PRE-PRINTED" W ! D ^DIR K DIR
 Q:$D(DTOUT)!$D(DUOUT)
 S IBBL=$P(Y,U)
 I $P(Y,U)="B" D  Q:$D(DTOUT)!$D(DUOUT)
 . S DIR(0)="NA^1:100",DIR("A")="NUMBER OF BLANK FORMS TO PRINT: ",DIR("B")=1 W ! D ^DIR K DIR
 . S $P(IBBL,U,2)=+Y
 I $P(IBBL,U)'["S" D  Q:$D(DTOUT)!$D(DUOUT)
 . S DIR(0)="YA",DIR("B")="NO",DIR("A")="DO YOU WANT TO PRINT THE SOLUTIONS TOO?: " D ^DIR K DIR
 . I Y=1 S $P(IBBL,U)=$P(IBBL,U)_"S"
 S %ZIS="QM" D ^%ZIS G:POP EN1Q
 I $D(IO("Q")) D  G EN1Q
 . S ZTRTN="ENQ^IBCEQ2",ZTDESC="IB - HIPAA ENHANCEMENTS PERF/BILLING PROV ID WORKSHEET",ZTSAVE("IBBL")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Task # "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 D ENQ
EN1Q Q
 ;
ENQ ; Queued job enters here
 ;
 N X,Z,Z0,Z00,IBI0,IBPAYR,IBPG,IBSTOP,IBCT,TYPCOV,IBCTI,IBLOOP,IBCOPY,IBTYPE
 K ^TMP($J)
 I $P(IBBL,U)["P" D
 . S Z=0 F  S Z=$O(^DIC(36,Z)) Q:'Z  D
 .. S IBI0=$G(^DIC(36,Z,0)),IBPAYR=$P(IBI0,U)
 .. Q:$P(IBI0,U,5)  ; ins co inactive
 .. S TYPCOV=$P(IBI0,U,13) ; type of cov ien;file 355.2
 .. S Z0=$P($G(^IBE(355.2,+TYPCOV,0)),U,2)
 .. I $S(Z0="TRI":0,Z0="CHS":0,Z0="BC":0,1:Z0'="BS") Q  ; Not Tricare or BC/BS
 .. S X=$S(Z0="TRI"!(Z0="CHS"):"TRICARE",Z0="BC":"BLUE CROSS",1:"BLUE SHIELD")
 .. S ^TMP($J,"IB",0_U_X,$E(IBPAYR,1,25)_U_Z)=IBPAYR,^TMP($J,"IB",0_U_X,$E(IBPAYR,1,25)_U_Z,0)=$G(^DIC(36,Z,.11))
 . ;
 . S ^TMP($J,"IB","1^"," ")=""
 ;
 I $P(IBBL,U,2) S ^TMP($J,"IB",1_U," ")=$P(IBBL,U,2)
 S (IBPG,IBSTOP,IBCTI)=0
 S Z="" F  S Z=$O(^TMP($J,"IB",Z)) Q:Z=""  D  Q:IBSTOP
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (IBSTOP,ZTSTOP)=1 K ZTREQ W:IBPG !,"***TASK STOPPED BY USER***" Q
 . S IBCOPY=$S($P(Z,U,2)'="":1,1:+$G(^TMP($J,"IB",Z," "))) S:'IBCOPY IBCOPY=1
 . F IBLOOP=1:1:IBCOPY D  Q:IBSTOP
 .. D HDR(Z,.IBPG,.IBSTOP)
 .. Q:IBSTOP
 .. ;
 .. S Z0="",IBCT=0 F  S Z0=$O(^TMP($J,"IB",Z,Z0)) Q:Z0=""  S Z00=$G(^(Z0,0)) D
 ... I IBCT'<5 S IBCT=0 D HDR(Z,.IBPG,.IBSTOP) Q:IBSTOP
 ... S IBCT=IBCT+1
 ... D BOX($G(^TMP($J,"IB",Z,Z0)),Z00,.IBCTI)
 .. ;
 .. I IBCT'>4 F IBCT=IBCT+1:1:5 D BOX("","")
 ;
 I 'IBSTOP,$P(IBBL,U)["S" D
 . N IBZ,IBTEXT,IBLINE,IBDONE,X,Q,Z
 . S IBPG=0
 . I $P(IBBL,U)'="S" D ASK(.IBSTOP) Q:IBSTOP  W @IOF
 . D HDR1^IBCEQ2A(.IBPG)
 . ;
 . S IBDONE=0,(IBLINE,IBTYPE,IBOTYPE)=""
 . F Z=1:1 D  Q:IBDONE
 .. S IBZ=$P($T(SOLUTION+Z),";;",2)
 .. I IBZ="" S IBDONE=1 Q
 .. S IBLINE(+$O(IBLINE(" "),-1)+1,$P(IBZ,U,2))=$P(IBZ,U,3)
 . ;
 . S Z=0 F  S Z=$O(IBLINE(Z)) Q:'Z  D
 .. S IBTYPE=$O(IBLINE(Z,"")) Q:IBTYPE=""
 .. S IBTEXT=$G(IBLINE(Z,IBTYPE))
 .. ;
 .. I $E(IBTYPE)="S" D  S IBOTYPE="S" Q
 ... I IBOTYPE'="S" D WRTS^IBCEQ2A("S",IBOTYPE,.IBTEXT,.IBSTOP) I IBSTOP S IBDONE=1 Q
 ... I $P(IBTYPE,"S",2) F Q=1:1:$P(IBTYPE,"S",2) W !
 ... W IBTEXT
 .. ;
 .. D WRTS^IBCEQ2A(IBTYPE,IBOTYPE,.IBTEXT,.IBSTOP) I IBSTOP S IBDONE=1 Q
 .. S IBOTYPE=IBTYPE
 . I 'IBSTOP,$O(IBTEXT("")) S IBTEXT="" D WRTS^IBCEQ2A("",IBOTYPE,.IBTEXT,.IBSTOP)
 I '$D(ZTQUEUED) D ^%ZISC I 'IBSTOP,IBPG D ASK()
 I $D(ZTQUEUED),'IBSTOP S ZTREQ="@"
 K ^TMP($J)
 Q
 ;
BOX(IBINM,Z00,IBCTI) ;
 N Q,X
 S:$TR(Z00," ")="" IBINM=""
 S:IBINM'="" IBCTI=IBCTI+1
 W !,"!",$E($S($TR(IBINM," ")'="":"("_IBCTI_")"_IBINM,1:"")_$J("",30),1,30),"!",$J("",$S(IOM<132:23,1:49)),"!",$J("",$S(IOM<132:23,1:49)),"!"
 W !,"!",$E($P(Z00,U)_$J("",30),1,30),"!",$J("",$S(IOM<132:23,1:49)),"!",$J("",$S(IOM<132:23,1:49)),"!"
 W !,"!",$E($P(Z00,U,2)_$J("",30),1,30),"!",$J("",$S(IOM<132:23,1:49)),"!",$J("",$S(IOM<132:23,1:49)),"!"
 W !,"!",$E($P(Z00,U,3)_$J("",30),1,30),"!",$J("",$S(IOM<132:23,1:49)),"!",$J("",$S(IOM<132:23,1:49)),"!"
 W !,"!",$E($P(Z00,U,4)_" "_$P($G(^DIC(5,+$P(Z00,U,5),0)),U,2)_" "_$P(Z00,U,6)_$J("",30),1,30),"!",$J("",$S(IOM<132:23,1:49)),"!",$J("",$S(IOM<132:23,1:49)),"!"
 F Q=1:1:2 W !,"!",$J("",30),"!",$J("",$S(IOM<132:23,1:49)),"!",$J("",$S(IOM<132:23,1:49)),"!"
 S X="",$P(X,"-",IOM+1)="" W !,X
 Q
 ;
HDR(IBINM,IBPG,IBSTOP) ; Ins Co info
 N X,IBINMX
 I IBPG D ASK(.IBSTOP) Q:IBSTOP  W @IOF
 S IBPG=IBPG+1
 S IBINMX=+IBINM,IBINM=$P(IBINM,U,2)
 W !,$S(IBINM="":"",1:$$FMTE^XLFDT(DT,"2D")),?(IOM-39\2),"INSURANCE COMPANY PROVIDER ID WORKSHEET" W:IBINM'="" ?(70+$S(IOM<132:0,1:52)),"PAGE: ",IBPG
 I IBINM'="" S X="INSURANCE COMPANY TYPE: "_IBINM W !,?(IOM-$L(X)\2),X
 W !
 I 'IBINMX D
 . W !,"**** ENTER THE SPECIAL PERFORMING AND BILLING PROVIDER ID REQUIREMENTS",!,"     FOR THE LISTED INSURANCE COMPANIES IN THE BOXES PROVIDED"
 I IBINMX D
 . W !,"**** ENTER THE NAMES OF ANY INSURANCE COMPANIES THAT HAVE SPECIAL ID",!,"     REQUIREMENTS FOR YOUR SITE AND THEN ENTER THE SPECIFIC REQUIREMENTS IN",!,"     THE BOXES PROVIDED."
 S X="",$P(X,"-",IOM+1)=""
 W !,X,!,"!                              !"_$J("",$S(IOM<132:1,1:14))_"SECONDARY PERFORMING"_$J("",$S(IOM<132:2,1:15))_"!"_$J("",$S(IOM<132:8,1:21))_"BILLING"_$J("",$S(IOM<132:8,1:21)),"!"
 W !,"!                              !"_$J("",$S(IOM<132:3,1:16))_"PROV. ID SPECIFIC"_$J("",$S(IOM<132:3,1:16))_"!"_$J("",$S(IOM<132:3,1:16))_"PROV. ID SPECIFIC"_$J("",$S(IOM<132:3,1:16))_"!"
 W !,"!  INSURANCE COMPANY           !"_$J("",$S(IOM<132:0,1:13))_"REQUIREMENTS (SCREEN 8)"_$J("",$S(IOM<132:0,1:13))_"!"_$J("",$S(IOM<132:0,1:13))_"REQUIREMENTS (SCREEN 3)"_$J("",$S(IOM<132:0,1:13))_"!"
 W !,X
 W !,"!"_$J("",30)_"!"_$J("",$S(IOM<132:23,1:49))_"!"_$J("",$S(IOM<132:23,1:49))_"!"
 W !,"!*** example:                  !"_$J("",$S(IOM<132:1,1:14))_"requires specific IDs"_$J("",$S(IOM<132:1,1:14))_"!"_$J("",$S(IOM<132:1,1:14))_"requires specific ids"_$J("",$S(IOM<132:1,1:14))_"!"
 W !,"! insurance co name            !"_$J("",$S(IOM<132:2,1:15))_"for each specialty"_$J("",$S(IOM<132:3,1:16))_"!"_$J("",$S(IOM<132:3,1:16))_"for each division"_$J("",$S(IOM<132:3,1:16))_"!"
 W !,X
 Q
 ;
ASK(IBSTOP) ; Ask continue
 ; If passed by ref, IBSTOP returned = 1 if print aborted
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S IBSTOP=1 Q
 Q
 ;
SOLUTION ; Solution text
 ;;^S0^    *********************** SCREEN 8 IDs ***********************"
 ;;^S1^
 ;;^Q^****FOR ALL OF THE FOLLOWING SCENARIOS, YOU MUST FIRST SET UP THE PERFORMING PROVIDER SECONDARY ID PARAMETERS FOR THE PAYER****
 ;;^A^Use the INSURANCE COMPANY ENTRY/EDIT (EI) option to set up the payer's id parameters.  Select the insurance company, and the PROVIDER ID PARAMS (ID) action to set up the PERFORMING PROVIDER SECONDARY ID TYPE for each form type
 ;;^A^ and the flag for whether the ids are required or not.  Reference page 38 in the EDI USER'S GUIDE for help on setting up the id parameters.
 ;;^S1^
 ;;^Q^1.  PAYER REQUIRES ONE PERFORMING PROVIDER SECONDARY ID FOR THE SITE:
 ;;^A^Use Provider ID Maintenance option 2 (INSURANCE CO IDS) and set up an id for the PROVIDER ID TYPE specified by the payer.  Do not choose a provider when prompted.
 ;;^A^  Enter the form types/care types this id will be used for and the appropriate id.  Reference pages 39-42 in the EDI USER'S GUIDE for more help on setting up the id.
 ;;^S1^
 ;;^Q^2.  PAYER REQUIRES ONE PERFORMING PROVIDER SECONDARY ID AS ASSIGNED TO EACH PROVIDER AT THE SITE:
 ;;^A^Follow the same set up for the payer's secondary id parameters as noted in 1 above.  Use Provider ID Maintenance option 2 (INSURANCE CO IDS) and set up an id for the PROVIDER ID TYPE specified by the payer.
 ;;^A^  Choose a provider when prompted.  Enter the form types/care types this id will be used for and the appropriate id.
 ;;^A^  Repeat these steps for each provider whose services can be billed to this payer.  Reference pages 42-44 in the EDI USER'S GUIDE for more help on setting up the id.
 ;;^S1^
 ;;^Q^3.  PAYER REQUIRES ONE PERFORMING PROVIDER SECONDARY ID AS ASSIGNED TO EACH SPECIALTY AT THE SITE:
 ;;^A^Use the Provider ID Maintenance option 4 (CARE UNIT MAINTENANCE) and set up an entry for each specialty that has a specific id.
 ;;^A^  Follow the same steps in either 1 or 2 above to set up the ids.  There will be one extra prompt for care unit.  Enter the name of the SPECIALTY for the id.
 ;;^A^  Reference pages 50-55 in the EDI USER'S GUIDE for more help.
 ;;^S1^
 ;;^Q^4.  PAYER REQUIRES ONE PERFORMING PROVIDER SECONDARY ID AS ASSIGNED TO EACH DIVISION AT THE SITE:
 ;;^A^Follow the same steps as for specialty (#3 above) except the care units will be DIVISIONS instead of SPECIALTIES.
 ;;^S3^    *********************** SCREEN 3 IDs ***********************
 ;;^S1^
 ;;^Q^1.  PAYER REQUIRES ONE BILLING FACILITY PRIMARY ID FOR THE SITE:
 ;;^A^Use the INSURANCE COMPANY ENTRY/EDIT option (EI) and make sure there is an id number set up for each form type.  If not, add the ids using the facility's main billing division as the division.
 ;;^A^  Reference pages 25-27 in the EDI USERS GUIDE for more help.
 ;;^S1^
 ;;^Q^2.  PAYER REQUIRES ONE BILLING FACILITY PRIMARY ID AS ASSIGNED TO EACH DIVISION AT THE SITE:
 ;;^A^Use the INSURANCE COMPANY ENTRY/EDIT option (EI) and choose the insurance company.  Choose action Billing Parameters (BP), respond YES TO EDIT BILLING FACILITY PRIMARY IDs.
 ;;^A^  Choose the ADD action and define the ids for each division that requires a special id.  Reference pages 25-27 in the EDI USERS GUIDE for more help.
 ;
