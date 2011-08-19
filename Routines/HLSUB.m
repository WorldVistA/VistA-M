HLSUB ;IRMFO-SF/JC - Subscription Registry ;03/24/2004  14:43
 ;;1.6;HEALTH LEVEL SEVEN;**14,57,58,59,66,83,108**;Oct 13, 1995
 ; DBIA #2270 Supported APIs:
 ; $$ACT - Function to return new subscription control number
 ; GET   - Get information about a subscriber.
 ; UPD   - Add a new subscription or update an existing one
ACT() ;Activate a new subscription
 ;Returns new file 774 ien (Subscription Control number)
 ;Returns -1 if error
 N X,DLAYGO,DIC,DA,DR
 Q:'$$LOCK774(0) -1
 S DLAYGO=774,X=$O(^HLS(774,"B"),-1),X=X+1,DIC=774,DIC(0)="L" D ^DIC
 L -^HLS(774,0)
 Q +Y
LOCK774(IEN) ;
 N I
 S I=0
TRY L +^HLS(774,IEN):1 I '$T S I=I+1 Q:I>600 0  G TRY
 Q 1
UPD(HLSCN,HLNN,HLTP,HLAD,HLTD,HLRAP,HLER,HLAPP,HLDESC) ;Subscription update
 ;HLSCN  - Subscription Control number (IEN in file 774), required
 ;HLNN   - Network node (Logical Link IEN or name in file 870), required
 ;HLTP   - Subscription type 
 ;         0 descriptive updates only (default)
 ;         1 activates clinical updates
 ;         2 other (locally defined)
 ;HLTD   - Termination date/time (external format), optional.
 ;         If date is supplied, but time isn't, default time is 1 minute
 ;         past midnight.
 ;         For a new subscription,
 ;         - if HLTD is null or not supplied, it means it's open-ended.
 ;           (default)
 ;         For an existing subscription,
 ;         - if HLTD is null or not supplied, no change is made to
 ;           existing TD. (default)
 ;         - the existing TD is deleted if
 ;           1. HLTD="@" or
 ;           2. HLTD='""' This is NOT the null string!  It is 2 double
 ;              quotes.  The variable HL("Q")="""""" is 2 double quotes.
 ;HLAD   - Activation date AND time (external format), optional,
 ;         default 'now'
 ;HLRAP  - Receiving Application (IEN or name in file 771), optional
 ;HLER   - (output) Error message array passed by reference
 ;HLAPP  - Optional, application that created the subscription record.
 ;         1-40 characters.  Excess is truncated.
 ;HLDESC - Optional, description/documentation, ie, file and record that
 ;         points to this subscription.  1-75 characters.  Excess is
 ;         truncated.
 ;Modification of existing entry triggers archive of previous record.
 D CHKPARM Q:$D(HLER)
 Q:'$$LOCK774(HLSCN)
 D ADDUP
 L -^HLS(774,HLSCN)
 Q
ADDUP ;Lookup and add subscriber (logical link)
 N HLCD,DIC,DIE,DA,DR,X,Y,HLINKIEN,HLINK0
 I $G(HLAPP)]"" S $P(^HLS(774,HLSCN,0),U,2)=$E(HLAPP,1,40)
 I $G(HLDESC)]"" S ^HLS(774,HLSCN,1)=$E(HLDESC,1,75)
 S HLCD=$$FMTE^XLFDT($$NOW^XLFDT) ;Creation date
 I $G(HLAD)="" S HLAD=HLCD ;Activation date
 S DLAYGO=774
 S DA(1)=HLSCN,DIC="^HLS(774,DA(1),""TO"",",DIC("P")=$P(^DD(774,1,0),U,2)
 S X=$G(HLRAP)_"@"_HLNN
 S DIC(0)="LMZ" D ^DIC Q:Y<1
 S HLINKIEN=+Y,HLINK0=Y(0)
 K DIC,DIE,DA,DR,X,Y
 ;If Updating existing record-archive old record
 I $P(HLINK0,U,2)]"" D ARCHIVE(HLSCN,HLINKIEN,HLINK0)
 ;bring in update
 S DA(1)=HLSCN,DA=HLINKIEN,DIE="^HLS(774,DA(1),"_"""TO"""_","
 S DR="3///^S X=HLNN;4///^S X=HLTP;5///^S X=HLCD;6///^S X=HLAD"
 I $G(HLRAP)]"" S DR=DR_";1///^S X=HLRAP"
 I $G(HLTD)=$G(HL("Q"),"""""")!($G(HLTD)="@") D
 . I $P(HLINK0,U,8)]"" S DR=DR_";7///@" ; remove termination date
 E  I $G(HLTD)]"" D
 . S DR=DR_";7///"_HLTD_$S(HLTD["@":"",1:"@0001") ; change it
 D ^DIE
 Q
CHKPARM ;
 K HLER
 I $G(HLSCN)="" S HLER(1)="Missing subscription control number."
 I $G(HLNN)="" S HLER(2)="Missing logical link."
 Q:$D(HLER)
 S HLTP=+$G(HLTP)
 I '$D(^HLS(774,HLSCN)) S HLER(4)="Invalid Subscription Control number"
 I HLNN?1N.N S HLNN=$P($G(^HLCS(870,HLNN,0)),U) I HLNN="" S HLER(5)="Invalid Logical Link" Q
 I '$O(^HLCS(870,"B",HLNN,0)) S HLER(5)="Invalid logical link" Q
 I $G(HLRAP)?1N.N S HLRAP=$P($G(^HL(771,HLRAP,0)),U) I $G(HLRAP)="" S HLER(6)="Invalid receiving application." Q
 ;
 ; patch HL*1.6*108 start
 ;I $G(HLRAP)]"",'$O(^HL(771,"B",HLRAP,0)) S HLER(6)="Invalid receiving application."
 I $G(HLRAP)]"",'$O(^HL(771,"B",$E(HLRAP,1,30),0)) S HLER(6)="Invalid receiving application."
 ; patch HL*1.6*108 end
 ;
 Q
ARCHIVE(HLSCN,HLINKIEN,HLINK0) ;
 N DLAYGO,DIC,DIE,DA,DR,X,Y,CD,AD,TD
 S CD=$P(HLINK0,U,6),AD=$P(HLINK0,U,7),TD=$P(HLINK0,U,8)
 S CD=$$FMTE^XLFDT(CD),AD=$$FMTE^XLFDT(AD) I TD]"" S TD=$$FMTE^XLFDT(TD)
 S DA(2)=HLSCN,DA(1)=HLINKIEN,X=$$FMTE^XLFDT($$NOW^XLFDT)
 S DIC="^HLS(774,DA(2),""TO"",DA(1),""HX"","
 S DIC("DR")="1///^S X=CD;2///^S X=AD;4///^S X=$P(HLINK0,U,5)"
 I TD]"" S DIC("DR")=DIC("DR")_";3///^S X=TD"
 S DLAYGO=774,DIC(0)="L",DIC("P")=$P(^DD(774.01,8,0),U,2)
 D ^DIC
 Q
GET(HLSCN,HLTP,HLCL,HLL) ;Return active subscribers
 ;Called by a HL7 ROUTING protocol to return array of subscribers
 ;Make separate call for each 'type' specified EXCEPT TYPE 0
 ;type 0 returns both '0' and '1' subscribers 
 ;HLSCN=SUBSCRIPTION CONTROL NUMBER
 ;HLTP=SUBSCRIBER TYPE (0,1,2)/Null=all
 ;HLCL=HL7 CLIENT PROTOCOL
 ;HLL=HLL("LINKS",x)=CLIENT PROTOCOL^LOGICAL LINK (passed by reference)
 ;If the client protocol is not passed in, piece three will be checked
 ;for a complete destination reference. The destination is of the format
 ;RECEIVING APPLICATION@LOGICAL LINK. When a valid destination is present
 ;it will be used for populating the message header and routing.
 ;The HLL("LINKS") array is required by the HL7 package for routing.
 N I,J,HLINK,HLND,HLDT,HLINKP,HLINKX,DIC,X,Y
 Q:'$G(HLSCN)
 Q:'$G(^HLS(774,HLSCN,0))
 S HLCL=$G(HLCL)
 I HLCL]"" S DIC=101,DIC(0)="X",X=HLCL D ^DIC Q:+Y<1
 S X="",HLTP=$G(HLTP)
 I $D(HLL("LINKS")) S X=$O(HLL("LINKS",X),-1)
 S HLDT=$$NOW^XLFDT
 S I=0
 F  S I=$O(^HLS(774,HLSCN,"TO",I)) Q:'I  S J=$G(^(I,0)) D
 . I HLTP'="",HLTP'=0 Q:$P(J,U,5)'=HLTP  ;type specified
 . I HLTP=0 Q:$P(J,U,5)>1  ;return clinical and descriptive
 . Q:$P(J,U,7)>HLDT  ;Activation date is later
 . I $P(J,U,8)]"" Q:$P(J,U,8)<HLDT  ;Subscription terminated
 . S (HLINKX,HLINKP)=$P(J,U,4)
 . I HLINKP S HLINKX=$P(^HLCS(870,HLINKP,0),U)
 . S X=X+1,HLL("LINKS",X)=HLCL_U_HLINKX_U_J
 Q
