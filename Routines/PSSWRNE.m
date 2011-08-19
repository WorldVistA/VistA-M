PSSWRNE ;BIR/EJW-NEW WARNING SOURCE NEW WARNING LABEL LIST EDITOR ;05/24/04
 ;;1.0;PHARMACY DATA MANAGEMENT;**87**;9/30/97
 ;
 ;Reference to ^PS(50.625 supported by DBIA 4445
EDIT ;
 N STAR,QUIT,PSSOUT
 S QUIT=0,STAR="",PSSOUT=0
 S DRUG="" F  S DRUG=$O(^TMP("PSSWRNB",$J,DRUG)) Q:DRUG=""  D  I QUIT Q
 .S DRUGN=$O(^PSDRUG("B",DRUG,0)) Q:'DRUGN  D DEA,PRINT
 Q
 ;
PRINT ;
 N NEWLIST,STAR
 I '$G(PSSLOOK) D
 .W @IOF
 .W "Current Warning labels for ",DRUG
 .I $G(NEWLIST)="",PSSWRN'["N" W !,"No warnings from the new data source exist for this drug." D
 ..W !,"Verify that the drug is matched to the National Drug File."
 I PSSWRN'="" D
 .I '$G(PSSLOOK) W !,"Labels will print in the order in which they appear for local and CMOP fills:"
 .I '$G(ENDWARN) S ENDWARN=5
 .S STAR=""
 .F WWW=1:1:ENDWARN S PSOWARN=$P(PSSWRN,",",WWW) Q:PSOWARN=""  D
 ..I WWW>5 S STAR="*"
 ..I PSOWARN["N" D NEWWARN Q
 ..D WARN54
 .D FULL Q:$G(PSSOUT)  W !!,"Pharmacy fill card display: DRUG WARNING ",PSSWRN
 .I $G(PSSLOOK) Q
 .I $G(SEL)=6 D
 ..S WARN54=$G(^TMP("PSSWRNB",$J,DRUG))
 ..D FULL W !,"  RX CONSULT file Drug Warning="_WARN54
 ..N I,WARN F I=1:1:$L(WARN54,",") S WARN=$P(WARN54,",",I) I WARN'="",$G(^PS(54,WARN,2))="" D FULL W !,"  ",WARN_" "_$G(^PS(54,WARN,0))_" is not mapped to the new data source"
 .I $G(SEL)=8 D
 ..W !
 ..S DIE="^PSDRUG(",DA=DRUGN,DR=8.2 D ^DIE K DIE,DA,DR
 .S NEWLIST=$P($G(^PSDRUG(DRUGN,"WARN")),"^") I NEWLIST="" D
 ..I PSSWRN'["N" Q
 ..D FULL Q:$G(PSSOUT)  W !,"NOTE: Because the NEW WARNING LABEL LIST field is empty, the warnings above"
 ..D FULL Q:$G(PSSOUT)  W !,"are the warnings that our national data source distributes for this drug."
 I $G(PSSLOOK) Q
 I $G(NEWLIST)'="" D FULL Q:$G(PSSOUT)  W !,"NEW WARNING LABEL LIST: ",NEWLIST
 D FULL Q:$G(PSSOUT)  W ! K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Would you like to edit this list of warnings" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S QUIT=1
 I 'Y D  Q
 .I $G(DRUGENT) S WARNEDIT=0 K ^TMP("PSSWRNB",$J)
 I $G(DRUGENT) S WARNEDIT=1 K ^TMP("PSSWRNB",$J) Q
 S OLDWARN=PSSWRN
 S DIE="^PSDRUG(",DA=DRUGN,DR=8.1 D ^DIE K DIE,DA,DR
 S PSSWRN=$P($G(^PSDRUG(DRUGN,"WARN")),"^") I PSSWRN'="" D CHECK20^PSSWRNA G PRINT
 I $G(OLDWARN)'="",PSSWRN="" D DEA G PRINT
 Q
FULL ;
 I ($Y+3)>IOSL&('$G(PSSOUT)) D HDR
 Q
NEWWARN ;
 N PSOWRNN,JJJ,STR
 S TEXT=""
 S PSOWRNN=+PSOWARN I $D(^PS(50.625,PSOWRNN)) D
 .I '$G(PSSLOOK) W !
 .S TEXT=STAR_PSOWARN_" "
 .S JJJ=0 F  S JJJ=$O(^PS(50.625,PSOWRNN,1,JJJ)) Q:'JJJ  S STR=$G(^PS(50.625,PSOWRNN,1,JJJ,0)) S TEXT=TEXT_" "_STR
 I TEXT'="" D FORMAT I $G(PSSLOOK) D FULL^PSSLOOK
 Q
WARN54 ;
 S TEXT=""
 I $D(^PS(54,PSOWARN,1)) D
 .I '$G(PSSLOOK) W !
 .S TEXT=STAR_PSOWARN_" "
 .S JJJ=0 F  S JJJ=$O(^PS(54,PSOWARN,1,JJJ)) Q:'JJJ  S TEXT=TEXT_" "_$G(^PS(54,PSOWARN,1,JJJ,0))
 I TEXT'="" D FORMAT I $G(PSSLOOK) D FULL^PSSLOOK
 Q
VALID ; VALIDATE NEW WARNING LABEL LIST
 N BAD
 S BAD=0
 I $G(X)="" W !,"TOO MANY WARNINGS. LIMIT ANSWER STRING TO 30 CHARACTERS OR LESS" K Y Q
 F I=1:1:$L(X,",") S PSOWARN=$P(X,",",I) I PSOWARN'="" D
 .I PSOWARN["N" S PSOWRNN=+PSOWARN D  Q
 ..I '$D(^PS(50.625,PSOWRNN)) W !,PSOWARN," does not exist in the WARNING LABEL-ENGLISH file" S BAD=1
 .I '$D(^PS(54,PSOWARN)) W !,PSOWARN," does not exist in the RX CONSULT file" S BAD=1
 I BAD K X
 Q
FORMAT ;
 N I,LEN,PTEXT
 S LEN=0,PTEXT=""
 F I=1:1:$L(TEXT," ") S STR=$P(TEXT," ",I)_" " D
 .I LEN+$L(STR)<80 S PTEXT=PTEXT_STR,LEN=LEN+$L(STR) Q
 .S LEN=0,I=I-1 D FULL Q:$G(PSSOUT)  W !,PTEXT S PTEXT=""
 I PTEXT'="" D FULL Q:$G(PSSOUT)  W !,PTEXT S PTEXT=""
 Q
 ;
NOTE ;
 N PSSWSITE
 S PSSWSITE=+$O(^PS(59.7,0)) I $P($G(^PS(59.7,PSSWSITE,10)),"^",9)'="N" D
 .W !,?2,"NOTE: You must edit the WARNING LABEL SOURCE field using the option"
 .W !,?2,"Pharmacy System Parameters Edit to enable national warning labels."
 Q
 ;
DEA ;
 S DEA=$P($G(^PSDRUG(DRUGN,0)),"^",3)
 S XX=DRUGN D WARNLST^PSSWRNA S:PSSWRN="" PSSWRN=$P($G(^PSDRUG(DRUGN,0)),"^",8)
 D CHECK20^PSSWRNA,CHECKLST^PSSWRNA
 Q
 ;
HDR ;
 K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSSOUT=1,QUIT=1 Q
 W @IOF
 W "Current Warning labels for ",DRUG,"  (continued)"
 Q
 ;
NOTE2 W !!,?5,"The RX CONSULT File (#54) contains local label expansions."
 W !,?5,"The WARNING LABEL-ENGLISH file (#50.625) contains national label"
 W !,?5,"expansions in English."
 W !,?5,"The WARNING LABEL-SPANISH file (#50.626) contains national label"
 W !,?5,"expansions in Spanish."
 W !,?5,"It is important to note that RX Consult entry numbers do not"
 W !,?5,"correlate with the other files (i.e. Number 7 in file 54 is not"
 W !,?5,"included in file 50.625)."
 W !!,?5,"You should print a list of the current RX CONSULT file entries"
 W !,?5,"and the current WARNING LABEL-ENGLISH file entries."
 W !
 Q
