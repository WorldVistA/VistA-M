XUTMTZ2 ;SEA/RDS - TaskMan: Toolkit, troubleshooting, part 3 ;5/20/91  15:40 ;
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
REPORT ;entry--report all errors in Error file by count
 K ^TMP($J)
 S ZTRANSLT="" F ZTA=0:1:31,127 S ZTRANSLT=ZTRANSLT_$C(ZTA)
 D %ZTER G QUIT:$D(DIRUT) D COUNT G QUIT:$D(DIRUT)
 D DAY G QUIT:$D(DIRUT) I ZTDAY D NUMBER G QUIT:$D(DIRUT)
 I 'ZTDAY,'ZTCOUNT W !!,$C(7),"No report selected!" G QUIT
 D PRINT G QUIT:$D(DIRUT) D MAIL G QUIT:$D(DIRUT)
 I 'ZTPRINT,'ZTMAIL W !!,"No method of reporting selected." G QUIT
 I ZTMAIL D EN^XM,DES^XMA21 G QUIT:$D(DIRUT)
 W !!,"Generating the report."
 D HERE^XUTMTZ3,OTHERS^XUTMTZ3:ZTOTHERS
 D DAILIES^XUTMTZ3:ZTDAY,TOTALS^XUTMTZ3:ZTCOUNT
 D OUT^XUTMTZ3:ZTPRINT,SEND^XUTMTZ3:ZTMAIL
QUIT K ^TMP($J),X,Y,ZT,ZT1,ZT2,ZT3,ZTA,ZTE,ZTMAIL,ZTOTHERS,ZTPRINT,ZTRANSLT,ZTX
 Q
 ;
%ZTER ;REPORT--prompt user as to whether %ZTER is replicated/translated
 S DIR(0)="YO",DIR("A")="Is %ZTER translated/replicated",DIR("B")="YES"
 S DIR("?",1)="Answer YES to restrict the search to this volume set."
 S DIR("?")="If not, I will search the %ZTER on each volume set."
 D ^DIR K DIR
 I $D(DTOUT) W $C(7),"**TIMEOUT**"
 I $D(DIRUT) W !!,"Report canceled!" Q
 S ZTOTHERS='Y
 Q
 ;
COUNT ;REPORT--prompt user as to whether to count unresolved errors
 S DIR(0)="YO",DIR("A")="Count unresolved errors since install"
 S DIR("B")="YES"
 S DIR("?",1)="Answer NO to suppress count of unresolved errors."
 S DIR("?")="Otherwise a list of errors by count will be generated."
 W ! D ^DIR K DIR
 I $D(DTOUT) W $C(7),"**TIMEOUT**"
 I $D(DIRUT) W !!,"Report canceled!" Q
 S ZTCOUNT=Y
 Q
 ;
DAY ;REPORT--prompt user as to whether to report errors by day
 S DIR(0)="YO",DIR("A")="Report errors by day of occurrence"
 S DIR("B")="YES"
 S DIR("?",1)="Answer NO to suppress display of errors by day."
 S DIR("?")="Otherwise list will show error that occurred each day."
 D ^DIR K DIR
 I $D(DTOUT) W $C(7),"**TIMEOUT**"
 I $D(DIRUT) W !!,"Report canceled!" Q
 S ZTDAY=Y
 Q
 ;
NUMBER ;REPORT--prompt user as to how many days' errors to show
 S DIR(0)="NO^1:9999",DIR("A")="Number of days to show"
 S DIR("B")=9999
 S DIR("?",1)="Answer with the number of days to display."
 S DIR("?")="Answer must be a number between 1 and 9999."
 D ^DIR K DIR
 I $D(DTOUT) W $C(7),"**TIMEOUT**"
 I $D(DIRUT) W !!,"Report canceled!" Q
 S ZTNUMBER=Y
 Q
 ;
PRINT ;REPORT--prompt user as to whether to display the report
 S DIR(0)="YO",DIR("A")="Display the report"
 S DIR("B")="YES"
 S DIR("?",1)="Answer NO to suppress display of the report."
 S DIR("?")="Otherwise it will be displayed on the terminal."
 W ! D ^DIR K DIR
 I $D(DTOUT) W $C(7),"**TIMEOUT**"
 I $D(DIRUT) W !!,"Report canceled!" Q
 S ZTPRINT=Y
 Q
 ;
MAIL ;REPORT--prompt user as to whether to mail the report
 S DIR(0)="YO",DIR("A")="Mail the report"
 S DIR("B")="NO"
 S DIR("?",1)="Answer YES to mail the report."
 S DIR("?")="Otherwise the report will not be bundled into a mail message."
 D ^DIR K DIR
 I $D(DTOUT) W $C(7),"**TIMEOUT**"
 I $D(DIRUT) W !!,"Report canceled!" Q
 S ZTMAIL=Y
 Q
 ;
