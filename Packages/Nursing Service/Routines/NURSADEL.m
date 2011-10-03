NURSADEL ;CISC/MD/MH-PURGE ROUTINE FOR FILES 214.6 - 214.7 ;12/07/89
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
EN1 ; ENTRY POINT TO PURGE DATA FROM FILES 214.6 AND 214.7
 W !!,$C(7),"Has Nursing been contacted before purging data from files 214.6 and 214.7" S %=1 D YN^DICN
 I %=0 W !!,$C(7),"ANSWER 'YES' or 'NO'" G EN1
 I %=2 W !!!,$C(7),"Contact Nursing before proceeding!",! G Q
 G:%'>0 Q
EN1A W !!,$C(7),"Has journaling of ^NURSA global been stopped" S %=1 D YN^DICN
 I %=0 W !!,$C(7),"ANSWER 'YES' OR 'NO'" G EN1A
 I %=2 W !!!,$C(7),"Stop journaling of ^NURSA global before proceeding!",! G Q
 G:%'>0 Q
ASK W ! S NUROUT=0,U="^",X="T-6M",%DT="" D ^%DT S NURSDATE=+Y D D^DIQ S %DT("A")="Start With: ",%DT("B")=Y,%DT(0)=-NURSDATE,%DT="AEPT" D ^%DT G Q:+Y'>0 S NURSDATE=+Y
 W !!,"Are you sure you want to delete data older than " D DT^DIQ S NURSDATE(1)=Y,%=1 D YN^DICN I '% W $C(7),!,?4,"ANSWER 'YES' OR 'NO':" G ASK
 G ASK:%=2 Q:%'>0
 D PURGE G:NUROUT Q D EN2,EN3
 W !!,$C(7),"Purge is completed, journaling for the ^NURSA global should be restarted!"
 S XQA("G.NURS-ADP")="",XQAMSG="Classification data older than "_NURSDATE(1)_" has been purged from the system." D SETUP^XQALERT
Q D ^NURSKILL
 Q
PURGE ; ENTRY POINT TO PURGE DATA FROM THE NURSP(214.6 AND NURSP(214.7 GLOBALS
 G:'$O(^NURSA(214.6,0)) AROUND W !!,"Purging 214.6 data.."
 I '$D(^NURSA(214.6,"B")) W !,$C(7),"INCOMPLETE DATA FILE" S NUROUT=1 Q
 F DA=0:0 S DA=$O(^NURSA(214.6,"B",DA)) Q:+DA>NURSDATE!(DA'>0)  F IEN=0:0 S IEN=$O(^NURSA(214.6,"B",DA,IEN)) Q:IEN'>0  K ^NURSA(214.6,IEN) W "."
 K ^NURSA(214.6,"B"),^NURSA(214.6,"C"),^NURSA(214.6,"AA"),^NURSA(214.6,"E"),^NURSA(214.6,"ACNT")
AROUND Q:'$O(^NURSA(214.7,0))  W !!,"Purging 214.7 data .."
 I '$D(^NURSA(214.7,"B")),$O(^NURSA(214.7,0)) W !,$C(7),"INCOMPLETE DATA FILE" S NUROUT=1 Q
 F DA=0:0 S DA=$O(^NURSA(214.7,"B",DA)) Q:+DA>NURSDATE!(DA'>0)  F IEN=0:0 S IEN=$O(^NURSA(214.7,"B",DA,IEN)) Q:IEN'>0  K ^NURSA(214.7,IEN) W "."
 K ^NURSA(214.7,"B"),^NURSA(214.7,"C"),^NURSA(214.7,"AA"),^NURSA(214.7,"ACNT"),^NURSA(214.7,"E")
 Q
EN2 ;REINDEX FILES
 Q:'$O(^NURSA(214.6,0))  W !,"Reindexing File 214.6 .."
 S (NCT,NCT(1))=0 I $D(^NURSA(214.6,0)) F DA=0:0 S DA=$O(^NURSA(214.6,DA)) Q:DA'>0  S NCT=NCT+1,NCT(1)=DA_U_NCT W "." D INDX1
 S $P(^NURSA(214.6,0),U,3,4)=$P(NCT(1),U,1,2)
 Q
EN3 Q:'$O(^NURSA(214.7,0))  W !,"Reindexing File 214.7 .."
 S (NCT,NCT(1))=0 I $D(^NURSA(214.7,0)) F DA=0:0 S DA=$O(^NURSA(214.7,DA)) Q:DA'>0  S NCT=NCT+1,NCT(1)=DA_U_NCT W "." D INDX2
 S $P(^NURSA(214.7,0),U,3,4)=$P(NCT(1),1,2)
 Q
INDX1 ;
 S X=^NURSA(214.6,DA,0) I +$P(X,U) S ^NURSA(214.6,"B",+$P(X,U),DA)=""
 I +$P(X,U,2) S ^NURSA(214.6,"C",+$P(X,U,2),DA)=""
 I +$P(X,U),+$P(X,U,2) S ^NURSA(214.6,"AA",$P(X,U,2),9999999-$P(X,U),DA)=""
 I +$P(X,U,8) S ^NURSA(214.6,"E",+$P(X,U,8),DA)=""
 I $P(X,U,10)'="",+$P(X,U),+$P(X,U,8) S ZX=$S($P(X,U,10)="H":$P(X,U,10),$P(X,U,10)="R":$P(X,U,10),1:"") I ZX'="" S ^NURSA(214.6,"ACNT",$P(X,U)\1,+$P(X,U,8),ZX,DA)="" K X
 Q
INDX2 ;
 S X=^NURSA(214.7,DA,0) I +$P(X,U) S ^NURSA(214.7,"B",+$P(X,U),DA)=""
 I +$P(X,U,2) S ^NURSA(214.7,"C",+$P(X,U,2),DA)=""
 I +$P(X,U),+$P(X,U,2) S ^NURSA(214.7,"AA",$P(X,U,2),9999999-$P(X,U),DA)=""
 I +$P(X,U,8) S ^NURSA(214.7,"E",+$P(X,U,8),DA)=""
 I $P(X,U,10)'="",+$P(X,U),+$P(X,U,8) S ZX=$S($P(X,U,10)="H":$P(X,U,10),$P(X,U,10)="R":$P(X,U,10),1:"") I ZX'="" S ^NURSA(214.7,"ACNT",$P(X,U)\1,+$P(X,U,8),ZX,DA)="" K ZX
 Q
