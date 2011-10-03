QACEDIT ;HISC/RS,CEW,DAD - Edit routine for the Patient representative package ;3/21/95  10:18
 ;;2.0;Patient Representative;**3,5,10,17**;07/25/1995
 S (DIC,DIE)="^QA(745.1,",DIC(0)="AEMQZ",DIC("A")="Select CONTACT NUMBER: "
 S DIC("S")="I ($P($G(^QA(745.1,+Y,7)),""^"",2)=""O""),(($D(^XUSEC(""QAC EDIT"",DUZ))#2)!(DUZ=$P(^QA(745.1,+Y,0),U,7)))"
 D ^DIC I Y<0 K DIC,DIE Q
 ;DISPLAY CONTACT DATA NOT EDITABLE
EDT ;Entry point for editing open ROCs on same patient from option 'Enter
 ;New Contact'
 N QACPSRV,QACGWV
 S RECNR=+Y L +^QA(745.1,RECNR):0 I '$T W !!,"Record being edited by another user." G END
 N QACPN S QACPN=$P(^QA(745.1,RECNR,0),U,3)
 K DA,DR,DIC,DIQ,TMP
 S DA=+Y,DIC=745.1,DIQ="TMP",DR=".01;1;2;3;4;5;6;7" D EN^DIQ1
 I '$G(QACFLG) W @IOF
 W !!,?15,"Edit Patient Representative Contact",!
 S N1="" F  S N1=$O(TMP(745.1,N1)) Q:N1=""  S N2="" F  S N2=$O(TMP(745.1,N1,N2)) Q:N2=""  S QACDATA=TMP(745.1,N1,N2) D
 .Q:QACDATA=""
 .S FLD=N2*100\1,TEXT=$P($T(@FLD),";;",2),TAB=$P(TEXT,"^"),LINE=$P(TEXT,"^",2),CODE=$P(TEXT,"^",3,99)
 .W:TAB=0 !
 .W ?TAB,LINE
 .X CODE
 .Q
 I QACPN'="" S QACPSRV=$P($G(^DPT(QACPN,.32)),U,3),QACGWV=$P($G(^DPT(QACPN,.322)),U,10)
 S DIE="^QA(745.1,",DA=RECNR,DR="31////"_$G(QACPSRV)_";32////"_$G(QACGWV) D ^DIE
 I $G(QACPSRV)]"" W !,"Period of Service: ",?20,$P(^DIC(21,$G(QACPSRV),0),U)
 W ?47,"Persian Gulf War?:",?66,$S($G(QACGWV)="Y":"YES",$G(QACGWV)="N":"NO",$G(QACGWV)="U":"UNKNOWN",1:"Not Entered")
 ;I $P($G(^QA(745.1,RECNR,0)),U,16)]"" W !,"Division: ",?20,$P(^DIC(4,$P(^QA(745.1,RECNR,0),U,16),0),U)
 I $P($G(^QA(745.1,RECNR,0)),U,16)]"" D
 . S QAC1DIV=$P($G(^QA(745.1,RECNR,0)),U,16)
 . S QACDVNAM="" D INST^QACUTL0(QAC1DIV,.QACDVNAM)
 . W !,"Division: ",?20,QACDVNAM
 S DFN=$P(^QA(745.1,RECNR,0),U,3) I DFN'="" D DIS^DGRPDB
 K TMP,DIQ,N1,N2,QACDATA,FLD,TAB,TEXT,LINE,CODE
 ;Enter edit rest of the data
EDIT ;
 N QACEE,QACLIST,QACNT S QACNT=0
 I QACPN'="" W ! S QACPN=$P($G(^QA(745.1,DA,0)),"^",3),QACALERT=1
 I $G(QACPN)]"" S DR=16.5 D ^DIE
 S DR="[QAC CONTACT ENTER/EDIT]"
 D ^DIE K DIE
END L -^QA(745.1,RECNR)
 Q:$G(QACFLG)
 K DIC,DR,DIE,DA,D0,DO,QACPN,X,Y,RECNR,BY,DFN,DHD,DLAYGO,FLDS,FR,IOP,L
 K QACD1,QACDFLT,QACOUT,TO,QACALERT,QACDVNAM
 W !! G ^QACEDIT
TEXT ;This is for the display of data, tab, description, data info. 
1 ;;0^Contact Number:^W ?20,QACDATA
100 ;;47^Date of Contact:^W ?66,QACDATA
200 ;;0^Patient Name:^W ?20,QACDATA
300 ;;47^Patient SSN (c):^W ?66,QACDATA
400 ;;0^Patient DOB (c):^S Y=QACDATA D DD^%DT S QACDATA=Y W ?20,QACDATA
500 ;;47^Patient sex (c):^W ?66,QACDATA
600 ;;0^Eligibility Status:^W ?20,QACDATA
700 ;;47^Patient Category:^W ?66,QACDATA
3100 ;;0^Period of Service:^W ?20,$P(^DIC(21,$G(QACDATA),0),U)
 Q
IDSPLAY ;If the site wants to display the Issue Codes and Services
 ;IDSPLAY is used. See Site Parameters.
 W !!,?10,"Previously Entered Issue Codes:",!!
 I $O(^QA(745.1,DA,3,0)) S QACNUM=DA D CODES^QACNEW
 I '$O(^QA(745.1,DA,3,0)) W ?3,"None!",!
 ;. S DIC="^QA(745.1,",L=0,DHD="@@"
 ;. S FLDS="21,.01;C3;L60,"" (*"",:745.2:7,"")""1,.01;C10,",BY="@NUMBER",(FR,TO)=DA
 ;. S IOP="HOME" D EN1^DIP
 ;E  W ?3,"None!",!
 Q
