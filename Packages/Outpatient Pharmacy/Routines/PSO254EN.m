PSO254EN ;BHAM-ISC/MFR - ENVIRONMENT CHECK ROUTINE FOR PATCH PSO*7*254 ;10/03/06
 ;;7.0;OUTPATIENT PHARMACY;**254**;DEC 1997;Build 19
 ;Reference to $$PROD^XPROD supported by IA 4440
 ;Reference to NEW PERSON file (#200) supported by IA 224
 ;Reference to BMES^XPDUTL supported by IA 10141
 ;
 Q:'$G(XPDENV)  S XPDABORT=0
 ;
 I $$PROD^XUPROD(),'$$FIND1^DIC(4,,"B","LEAVENWORTH PHARMACY") D  Q
 . S XPDQUIT=1 D BMES^XPDUTL("THE POST-INSTALL FOR XU*8*416 HAS NOT COMPLETED AND/OR RUN. TRY AGAIN LATER!")
 ;
 W !
 W !,"     The post-install routine included with this patch will send out a"
 W !,"     Mailman message with the list of Pharmacy Divisions in your site"
 W !,"     along with their related National Provider Identifier (NPI)"
 W !,"     Institution, which is being automatically assigned by this patch."
 W !,"     "
 W !,"     It will also indicate if there were problems in the automatic"
 W !,"     assignment, which will have to be followed-up by an Outpatient"
 W !,"     Pharmacy user as outlined in the patch description."
 W !,"     "
 W !,"     So, please enter the Outpatient Pharmacy user(s) (e.g., Pharmacy"
 W !,"     ADPAC or designee) who should receive this message (at least 1 user"
 W !,"     is required). The user entered should be the person responsible for"
 W !,"     the maintenance of the PSO Site Parameters. The message will also"
 W !,"     be sent to the user installing the patch."
 W !
 ;
 N ARRAY,DIC,DTOUT,DUOUT,QT,Y,X,I,USR
 S DIC=200,DIC(0)="QEZAM",DIC("A")="PHARMACY USER: "
 F  D ^DIC Q:X=""  D  Q:$G(QT)
 . I $D(DTOUT)!$D(DUOUT) K ARRAY S QT=1 Q
 . W "   ",$P(Y,"^",2),$S($D(ARRAY(+Y)):"       (already selected)",1:"")
 . W ! S ARRAY(+Y)="",DIC("A")="ANOTHER ONE: "
 ;
 I '$D(ARRAY) D  S XPDABORT=2 Q
 . D BMES^XPDUTL("AT LEAST ONE PHARMACY USER MUST BE ENTERED FOR THIS PATCH TO BE INSTALLED!")
 ;
 S @XPDGREF@("PSO254USR0")=DUZ
 S USR="" F I=1:1 S USR=$O(ARRAY(USR)) Q:USR=""  S @XPDGREF@("PSO254USR"_I)=USR
 ;
 Q
