FSCLIMIT ;SLC/STAFF-NOIS Limit Restrictions ;1/13/98  12:31
 ;;1.1;NOIS;;Sep 06, 1998
 ;
RESTRICT(RESTRICT) ; from FSCULOOK
 N OK
 S OK=0 F  D  Q:OK
 .N DIR,X,Y K DIR S RESTRICT=""
 .S DIR(0)="SAMO^DATE RANGE:DATE RANGE;LAST N CALLS:LAST N CALLS;NO RESTRICTION:NO RESTRICTION"
 .S DIR("A",1)="-- restrictions that can be applied to this list --"
 .S DIR("A")="(D)ate range, (L)ast n calls, (N)o restriction: "
 .S DIR("B")="NO RESTRICTION"
 .S DIR("?",1)="Enter DATE RANGE to restrict calls to a date range (date openend)."
 .S DIR("?",2)="Enter LAST N CALLS to restrict to the last number of calls received."
 .S DIR("?",3)="Enter NO RESTRICTIONS or '^' to get the entire list."
 .S DIR("?",4)="Enter '??' for further help."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .D ^DIR K DIR
 .S OK=1
 .D
 ..I Y="NO RESTRICTION" S RESTRICT=0 Q
 ..I Y="DATE RANGE" D  Q
 ...N FROM,TO
 ...D DATES(.FROM,.TO)
 ...I FROM,TO S RESTRICT="1^^"_FROM_U_TO Q
 ...S OK=0 W $C(7)
 ..I Y="LAST N CALLS" D  Q
 ...N LASTN
 ...D LASTN(.LASTN)
 ...I LASTN S RESTRICT="1^"_LASTN Q
 ...S OK=0 W $C(7)
 Q
 ;
DATES(FROM,TO) ;
 N DIR,X,Y K DIR S (FROM,TO)=0
 S DIR(0)="DAO^2900101:DT:EX"
 S DIR("A")="From: "
 S DIR("?",1)="Enter the beginning date of a date range."
 S DIR("?")="^D HELP^%DTC,HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S FROM=Y
 ;
 N DIR,X,Y K DIR
 S DIR(0)="DAO^2900101:DT:EX"
 S DIR("A")="To: "
 S DIR("?",1)="Enter the ending date of a date range."
 S DIR("?")="^D HELP^%DTC,HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) S FROM=0 Q
 S TO=Y I FROM>TO S X=FROM,FROM=TO,TO=X
 Q
 ;
LASTN(LASTN) ;
 N DIR,X,Y K DIR S LASTN=0
 S DIR(0)="NAO^1:100000:0"
 S DIR("A")="Enter the maximum number of the last calls received: "
 S DIR("?",1)="Enter the maximum number of calls you want from this list."
 S DIR("?",2)="The calls will be restricted to this number of calls, starting with"
 S DIR("?",3)="the most recently entered call, up to but not exceeding the number."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S LASTN=+Y
 Q
 ;
ASK(LIST) ; $$(list#) -> 1 or 0, on whether to ask for restrictions
 N APPROX,LIMIT
 S LIMIT=$P($G(^FSC("LIST",+LIST,0)),U,8),APPROX=$P($G(^(0)),U,9)
 I 'LIMIT Q 0
 I LIMIT=-1 Q 1
 I APPROX,APPROX>LIMIT Q 1
 Q 0
