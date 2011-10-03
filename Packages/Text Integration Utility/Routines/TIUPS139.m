TIUPS139 ; SLC/AJB - Cleanup for TIU*1*138 ; August 2, 2002
 ;;1.0;TEXT INTEGRATION UTILITIES;**139**;Jun 20, 1997
 ;
 Q
CLEAN ; control segment
 ;
 N ANS,HDR,RPT,RECS,TMP
 ;
 W @IOF
 ;
 D MKWSDEV Q:$G(ANS("EXIT"))="YES"
 ;
 D ASKUSER(.ANS) Q:$G(ANS("EXIT"))="YES"
 ;
 I ANS("PRINT")="YES" D  Q
 . K POP N POP,ZTDESC,ZTRTN
 . S ZTDESC="TIUPS139 Cleanup Routine",ZTRTN="REPORT^TIUPS139",ZTSAVE("*")=""
 . D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
 ;
 W !,"Searching..."
 D REPORT
 W !!
 D OUTPUT
EXIT ;
 Q
REPORT ;
 ; 
 N DA,DR,DIE,ELAPSED,ENTRYDT,POP,SPACER,START,STOP,TIUDA,TIUDT
 ;
 S (RECS("CHK"),RECS("FOUND"),RECS("SEARCHED"),RECS("TOTAL"))=0
 ;
 S START=$$NOW^XLFDT,TIUDA="",TIUDT=ANS("BEGDT")
 F  S TIUDT=$O(^TIU(8925,"F",TIUDT)) Q:TIUDT=""!(TIUDT>ANS("ENDDT"))  F  S TIUDA=$O(^TIU(8925,"F",TIUDT,TIUDA)) Q:TIUDA=""  S RECS("SEARCHED")=RECS("SEARCHED")+1 I $P($G(^TIU(8925,TIUDA,0)),U,5)=6,$P($G(^TIU(8925,TIUDA,12)),U,8)="" D
 . S ENTRYDT=TIUDT
 . I +$$REQCOSIG($P($G(^TIU(8925,TIUDA,0)),U),TIUDA,$P($G(^TIU(8925,TIUDA,12)),U,2))=1 D  Q
 .. S RECS("CHK")=RECS("CHK")+1 S:RECS("CHK")<10 RECS("CHK")="0"_RECS("CHK") S:RECS("CHK")<100 RECS("CHK")="0"_RECS("CHK")
 .. S TMP(RECS("CHK")_"C",TIUDA)="",RECS("CHK")=+RECS("CHK")
 . S RECS("FOUND")=RECS("FOUND")+1,TMP(RECS("FOUND"),TIUDA)=""
 . S DA=TIUDA,DIE="^TIU(8925,",DR=".05////7;1506////0"
 . I ANS("UPDATE")="YES" D ^DIE
 S RECS("TOTAL")=RECS("FOUND")+RECS("CHK")
 S STOP=$$NOW^XLFDT,ELAPSED=$FN($$FMDIFF^XLFDT(START,STOP,2)/60,"-")
 ;
 S HDR(1)="Elapsed Time:   "_(ELAPSED\1)_" minute(s) "_($FN((ELAPSED#1)*60,"-",0))_" second(s)"
 S HDR(2)="# of Records:   "_"Searched    "_RECS("SEARCHED")
 S SPACER="",$P(SPACER," ",(8-$L(RECS("TOTAL"))))=" "
 S HDR(3)="                Found       "_RECS("TOTAL")_SPACER_"(STATUS=UNCOSIGNED, EXPECTED COSIGNER="""")"
 S SPACER="",$P(SPACER," ",(8-$L(RECS("FOUND"))))=" "
 S:ANS("UPDATE")="YES" HDR(4)="                Corrected   "_RECS("FOUND")_SPACER_"(COSIGNATURE REQUIRED=NO)"
 S:ANS("UPDATE")="NO" HDR(4)="                Unchanged   "_RECS("FOUND")_SPACER_"(COSIGNATURE REQUIRED=NO)"
 S SPACER="",$P(SPACER," ",(8-$L(RECS("CHK"))))=" "
 S:RECS("CHK")>0 HDR(5)="                Unchanged*  "_RECS("CHK")_SPACER_"(COSIGNATURE REQUIRED=YES)"
 S:RECS("CHK")>0 HDR(6)="",HDR(7)="                * co-signer requirement should be verified"
 S HDR(8)=""
 S HDR(9)="                Host File Path:  "_ANS("PATH")_"TIUPS139.TXT"
 S HDR(10)=""
 S RPT(1)="Current User:         "_($$GET1^DIQ(200,+DUZ,.01))
 S RPT(2)="Current Date:         "_($$HTE^XLFDT($H))
 S RPT(3)="Date range searched:  "_($$FMTE^XLFDT(ANS("BEGDT"),"D"))_" - "_($$FMTE^XLFDT(ANS("ENDDT"),"D"))
 S RPT(4)=""
 S RPT(5)="Count       Entry Date/Time"
 S RPT(6)="Doc #       Title                                 Author/Dictator"
 S RPT(7)="-----       -----                                 ---------------"
 ;
 I RECS("TOTAL")=0 S RPT(8)="<NO RECORDS FOUND>",RPT(9)=""
 ;
 N AUTHOR,CNT,NUM,TITLE
 ;
 S CNT=7,RECS=0,(NUM,TIUDA)=""
 F  S NUM=$O(TMP(NUM)) Q:NUM=""  F  S TIUDA=$O(TMP(NUM,TIUDA)) Q:TIUDA=""  D
 . I RECS("FOUND")=0,NUM="001C" S CNT=CNT+1,RPT(CNT)="<NO RECORDS FOUND>",CNT=CNT+1,RPT(CNT)=""
 . I NUM="001C" S CNT=CNT+1,RPT(CNT)="** The following records are STATUS=UNCOSIGNED  COSIGNATURE REQUIRED=YES **",CNT=CNT+1,RPT(CNT)=""
 . S CNT=CNT+1,RECS=RECS+1
 . S SPACER="",$P(SPACER," ",(11-$L(RECS)))=" "
 . S RPT(CNT)="#"_RECS_SPACER_$$FMTE^XLFDT($P(^TIU(8925,TIUDA,12),U))
 . S CNT=CNT+1,TITLE=$E($$GET1^DIQ(8925,TIUDA_",",.01),1,36),AUTHOR=$E($$GET1^DIQ(8925,TIUDA_",",1202),1,28)
 . S SPACER="",$P(SPACER," ",(11-$L(TIUDA)))=" "
 . S:NUM["C" RPT(CNT)=TIUDA_"*"_SPACER_TITLE
 . S:NUM'["C" RPT(CNT)=TIUDA_" "_SPACER_TITLE
 . S SPACER="",$P(SPACER," ",(50-$L(RPT(CNT))))=" "
 . S RPT(CNT)=RPT(CNT)_SPACER_AUTHOR,CNT=CNT+1,RPT(CNT)=""
 ;
 D:ANS("PRINT")="YES" OUTPUT,^%ZISC
 ;
 D OPEN^%ZISH("TIUPS139",ANS("PATH"),"TIUPS139.TXT","A") Q:POP>0
 U IO D OUTPUT
 D CLOSE^%ZISH("TIUPS139")
 ;
 S XQA(DUZ)="",XQAMSG="TIUPS139 has finished."
 D SETUP^XQALERT
 Q
OUTPUT ;
 N NUM
 S NUM=""
 F  S NUM=$O(HDR(NUM)) Q:NUM=""  W HDR(NUM),!
 F  S NUM=$O(RPT(NUM)) Q:NUM=""  W RPT(NUM),!
 S $P(NUM,"-",80)="-" W NUM
 Q
 ;
ASKUSER(ANS) ;
 ;
 N DIR,POP,X,Y
 ;
 ; delete the host file and quit?
 ;
 N DELHFS
 S DIR(0)="Y"
 S DIR("A")="Delete the host file TIUPS139.TXT and QUIT"
 S DIR("B")="NO"
 S DIR("?")="Entering 'NO' will not delete the host file TIUPS139.TXT and continue."
 S DIR("?",1)="Entering 'YES' will delete the host file TIUPS139.TXT and QUIT."
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S ANS("EXIT")="YES" Q
 S ANS("DELHFS")=Y(0) W !
 I ANS("DELHFS")="YES" D  Q
 . S DELHFS("TIUPS139.TXT")=""
 . S Y=$$DEL^%ZISH(ANS("PATH"),$NA(DELHFS))
 . W !,"TIUPS139.TXT has been deleted.",!
 . S ANS("EXIT")="YES" ;
 ;
 ; date range?
 ;
 N %DT,CNT
 S %DT="AE"
 F CNT=1:1:2 D
 . S %DT("A")=$S(CNT=1:"START WITH REFERENCE DATE:  ",CNT=2:"     GO TO REFERENCE DATE:  ")
 . S %DT("B")=$S(CNT=1:"Jan 01, 2001",CNT=2:$P($$HTE^XLFDT($H),"@"))
 . D ^%DT
 . I Y=-1 S CNT=2,ANS("EXIT")="YES" Q
 . I CNT=1 S ANS("BEGDT")=Y
 . I CNT=2 S ANS("ENDDT")=Y_".24"
 W !
 Q:$G(ANS("EXIT"))="YES"
 ;
 ; update the documents?
 ;
 S DIR(0)="Y"
 S DIR("A")="Update the records at this time"
 S DIR("B")="NO"
 S DIR("?",1)="Entering 'YES' will find and update the records."
 S DIR("?",2)="STATUS will be changed from 'UNCOSIGNED' to 'COMPLETED' and"
 S DIR("?",3)="COSIGNATURE NEEDED will be changed to 'NO'."
 S DIR("?",4)=""
 S DIR("?")="Entering 'NO' will find and report the records without making any changes."
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S ANS("EXIT")="YES" Q
 S ANS("UPDATE")=Y(0) W !
 ;
 ; print the results?
 ;
 S DIR(0)="Y"
 S DIR("A")="Would you like to print or queue the search"
 S DIR("B")="YES"
 S DIR("?",1)="Entering 'YES' will send the search results to the selected device."
 S DIR("?",2)="It will also allow the search to be queued and run at a later time if desired."
 S DIR("?",3)=""
 S DIR("?",4)="Entering 'NO' will not allow printing or queuing of the search results."
 S DIR("?")="The search results will be displayed on the current device."
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S ANS("EXIT")="YES" Q
 S ANS("PRINT")=Y(0) W !
 ;
 Q
 ;
REQCOSIG(TIUTYP,TIUDA,USER) ; Evaluate whether user requires cosignature
 N TIUI,TIUY,TIUDPRM S USER=$S(+$G(USER):+$G(USER),1:+$G(DUZ))
 D DOCPRM^TIULC1(TIUTYP,.TIUDPRM,+$G(TIUDA))
 I $G(TIUDPRM(5))="" G REQCOSX
 F TIUI=1:1:$L(TIUDPRM(5),U) D  Q:+TIUY>0
 . S TIUY=+$$ISA(+USER,+$P(TIUDPRM(5),U,TIUI))
REQCOSX Q +$G(TIUY)
 ;
ISA(USER,CLASS,ERR) ; Boolean - Is USER a Member of CLASS?
 N USRY,USRI
 I $S(CLASS="USER":1,CLASS=+$O(^USR(8930,"B","USER",0)):1,1:0) S USRY=1 G ISAX
 I '+USER S USER=+$O(^VA(200,"B",USER,0))
 I +USER'>0 S ERR="INVALID USER" Q 0
 I '+CLASS S CLASS=+$O(^USR(8930,"B",CLASS,0))
 I +CLASS'>0 S ERR="INVALID USER CLASS" Q 0
 ; If USER is a member of CLASS return true
 S USRY=0
 I +$D(^USR(8930.3,"AUC",USER,CLASS)) D
 . N USRMDA
 . S USRMDA=0
 . F  S USRMDA=+$O(^USR(8930.3,"AUC",USER,CLASS,USRMDA)) Q:((+USRMDA'>0)!(USRY))  D
 .. S USRY=+$$CURRENT(USRMDA)
 I USRY Q USRY
 ; Otherwise, check to see if user is a member of any subclass of CLASS
 S USRI=0
 F  S USRI=$O(^USR(8930,+CLASS,1,USRI)) Q:+USRI'>0!+$G(USRY)  D
 . N USRSUB S USRSUB=+$G(^USR(8930,+CLASS,1,USRI,0)) Q:+USRSUB'>0
 . S USRY=$$ISA(USER,USRSUB) ; Recurs to find members of subclass
ISAX Q +$G(USRY)
 ;
CURRENT(MEMBER) ; Boolean - Is Membership current?
 N USRIN,USROUT,USRY
 S USRIN=+$P($G(^USR(8930.3,+MEMBER,0)),U,3)
 S USROUT=+$P($G(^USR(8930.3,+MEMBER,0)),U,4)
 I USRIN'>ENTRYDT,$S(USROUT>0&(USROUT'<ENTRYDT):1,USROUT=0:1,1:0) S USRY=1
 E  S USRY=0
 Q USRY
 ;
MKWSDEV ;
 ;
 I +$$FIND1^DIC(3.5,"","MX","TIUPS139 WORKSTATION")>0 S ANS("PATH")=$$PWD^%ZISH Q
 ;
 N FDA,FDAIEN,MSG
 S FDA(3.5,"+1,",.01)="TIUPS139 WORKSTATION"
 S FDA(3.5,"+1,",.02)="TIUPS139 Workstation HFS Device" ; location
 S FDA(3.5,"+1,",1)="TIUPS139.DAT" ;$I
 S FDA(3.5,"+1,",1.95)=0 ; sign-on/system device
 S FDA(3.5,"+1,",2)="HFS" ; type
 S FDA(3.5,"+1,",3)=$$FIND1^DIC(3.2,"","MX","P-OTHER") ; subtype
 S FDA(3.5,"+1,",4)=0 ; ask device
 S FDA(3.5,"+1,",5)=0 ; ask parameters
 S FDA(3.5,"+1,",5.1)=0 ; ask host file
 S FDA(3.5,"+1,",5.2)=0 ; ask hfs i/o operation
 D UPDATE^DIE("","FDA","FDAIEN","MSG")
 I $D(MSG) D  Q
 . W !,"Workstation device creation failed."
 . S ANS("EXIT")="YES"
 S ANS("PATH")=$$PWD^%ZISH
 Q
