HMPMONM ;ASMR/BL, monitor server selection ;Sep 19, 2016 20:02:20
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526, DE6644 - routine refactored, 7 September 2016
 ;
M ; interactive, monitor a different server
 ; called after ^DIR call in OPTION^HMPMON
 ; places into symbol table:
 ;   HMPMNTR("server") = ien of server to monitor
 ;   HMPMNTR("zero node") - zero node of selected entry
 ;
 W ! N DIC,DIROUT,DUOUT,X,Y
 S DIC="^HMP(800000,",DIC(0)="AEMQZ",DIC("A")="Select eHMP Server to Monitor: ",DIC("B")=HMPMNTR("server") ; default to current selection
 D ^DIC  ;interactive lookup
 Q:$D(DTOUT)  ; time-out, leave in symbol table
 Q:$D(DUOUT)!$D(DIROUT)!'(Y>0)  ; nothing selected
 S HMPMNTR("server")=+Y ; update server IEN
 S HMPMNTR("zero node")=Y(0)  ;save node zero
 Q
 ;
GETSRVR() ;extrinsic variable, returns IEN of default server to monitor
 ;
 N F,J,RSLT S RSLT=+$O(^HMP(800000,0))
 Q:'$O(^HMP(800000,RSLT)) RSLT  ; nothing else to check, return first IEN found
 ;
 ;^DD(800000,.07,0)="DEFAULT?^S^1:YES;0:NO;^0;7^Q"
 Q:$P(^HMP(800000,RSLT,0),U,7) RSLT  ; 1st entry is default
 ; if nothing marked as default, 1st entry will be returned
 S F=0,J=RSLT  ; F is flag, default IEN found
 ;start with RSLT, check other entries for DEFAULT flag, stop if one found
 F  S J=$O(^HMP(800000,J)) Q:'J!F  S:$P(^HMP(800000,J,0),U,7) (F,RSLT)=J
 Q RSLT
 ;
NOSRVR ; interactive help display if no server selected
 W !!,"There must be a SERVER entry in the HMP SUBSCRIPTION file (#800000)."
 W !,"You can set the field DEFAULT? (#.07) to 'YES'"
 W !,"and that entry will become the default server to monitor.",!
 D RTRN2CON^HMPMONL ; Enter RETURN to continue
 Q
 ;
