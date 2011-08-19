PRCPEITG ;WOIFO/CC-enter/edit inventory items (On-Demand) ; 11/6/06 9:56am
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
ODI(PRCPINPT,PRCPITEM) ; ask On-Demand and reason if appropriate, save data
 ;
 ; PRCPINPT   inventory point ien
 ; PRCPITEM   ien of the selected item
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,PRCPARRY,PRCPEDIT,PRCPIEN,PRCPONN,PRCPONO,PRCPREAS,Y
 S PRCPONO=$P(^PRCP(445,+PRCPINPT,1,+PRCPITEM,0),"^",30) ; O-D Flag
 I PRCPONO'="Y" S PRCPONO="N" ; if no value is defined, O-D Flag is No
 ; Can user edit this On-Demand setting?
 S PRCPEDIT=0
 I $D(^PRCP(445,+PRCPINPT,9,"B",DUZ)) S PRCPEDIT=1 ; authorized user
 ;
 ; Display On-Demand value. If user is not authorized,
 ; display << not editable >> , pause and exit
 I 'PRCPEDIT D EN^DDIOL("ON-DEMAND: "_$S(PRCPONO="N":"NO",1:"YES")_"//   <<may not edit>>") D R^PRCPUREP Q
 ; if user can edit value, proceed with prompting
YN S DIR(0)="Y",DIR("A")="ON-DEMAND",DIR("B")=PRCPONO
 S DIR("?",1)="Enter 'Y'es for low usage items qualifying to be On-Demand"
 S DIR("?")="      'N'o  for routinely used (standard) items"
 D ^DIR K DIR
 ; prompt user, default to value on file
 ; if user up-arrows or times out, exit
 I $D(DUOUT)!$D(DTOUT) G NOCHANGE
 I Y'=0,Y'=1 W "??" G YN
 I Y=1 S PRCPONN="Y"
 I Y=0 S PRCPONN="N"
 ; if new value agrees with current setting, exit
 I PRCPONN=PRCPONO Q  ; no additional processing required
 ;
 ; prompt user for reason
RS S DIR(0)="F^3:30",DIR("A")="REASON FOR CHANGE"
 S DIR("?")="Enter 3 - 30 characters with no embedded '^' and no leading spaces"
 ; if user enters '^', all spaces or just hits return, tell user setting will not be changed - no reason entered, prompt On-Demand again.
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G NOCHANGE
 F  Q:$E(Y,1)'=" "  S Y=$E(Y,2,$L(Y))
 I Y']"" W "??" G RS
 S PRCPREAS=Y
 ;
 ; save new setting, date/time, DUZ, reason in audit file
 S PRCPIEN="+1,"_+PRCPITEM_","_+PRCPINPT_","
 S PRCPARRY(445.13,PRCPIEN,.01)=$$NOW^XLFDT
 S PRCPARRY(445.13,PRCPIEN,1)=DUZ
 S PRCPARRY(445.13,PRCPIEN,2)=PRCPREAS
 S PRCPARRY(445.13,PRCPIEN,3)=PRCPONN
 D UPDATE^DIE("","PRCPARRY")
 I $D(^TMP("DIERR",$J)) W "NOTHING SAVED" ; likely system or space err
 ;
 ; Save new setting into field .8
 S PRCPIEN=+PRCPITEM_","_+PRCPINPT_","
 K PRCPARRY S PRCPARRY(445.01,PRCPIEN,.8)=PRCPONN
 D UPDATE^DIE("","PRCPARRY")
 I $D(^TMP("DIERR",$J)) W "NOTHING SAVED" ; likely system or space err
OD Q
 ;
NOCHANGE D EN^DDIOL("NO DATA UPDATED.  VALID RESPONSE AND/OR REASON NOT ENTERED.")
 D R^PRCPUREP
 Q
