PRCPCUDI ;WISC/RFJ-fileman input transforms for case carts          ;01 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CHECK(FILE,FIELD) ;  check input transform for files 445.7 and 445.8
 ;  x = item master number
 ;  if it fails goto kill and kill x and dinum
 N MESSAGE
 S MESSAGE="UNAUTHORIZED ACCESS"
 I '$G(PRCPPRIV) D KILL Q MESSAGE
 S MESSAGE=""
 I FILE=445.7,FIELD=.01 D  Q MESSAGE
 .   I $$PURCHASE^PRCPU441(X) S MESSAGE="*** Item cannot be defined as 'purchasable' in item master file ***" D KILL Q
 .   I $D(^PRCP(445.8,X,0)) S MESSAGE="*** Item is already defined as an Instrument Kit ***" D KILL Q
 .   I $D(^PRCP(445.8,"AI",X)) S MESSAGE="*** Item is included in an Instrument Kit ***" D KILL Q
 ;
 I FILE=445.7,FIELD=1 D  Q MESSAGE
 .   I $D(^PRCP(445.7,"B",X)) S MESSAGE="*** A Case Cart cannot be an item in a Case Cart ***" D KILL Q
 ;
 I FILE=445.8,FIELD=.01 D  Q MESSAGE
 .   I $$PURCHASE^PRCPU441(X) S MESSAGE="*** Item cannot be defined as 'purchasable' in item master file ***" D KILL Q
 .   I $D(^PRCP(445.7,X,0)) S MESSAGE="*** Item is already defined as a Case Cart ***" D KILL Q
 ;
 I FILE=445.8,FIELD=1 D  Q MESSAGE
 .   I $D(^PRCP(445.8,X,0)) S MESSAGE="*** Item is already defined as an Instrument Kit ***" D KILL Q
 .   I $D(^PRCP(445.7,X,0)) S MESSAGE="*** Item is already defined as a Case Cart ***" D KILL Q
 Q
 ;
 ;
KILL ;  kill x and dinum
 K X,DINUM
 Q
