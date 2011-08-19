DGRUDYN ;ALB/SCK - RAI/MDS COTS DYNAMIC ADDRESSING ROUTINE; 9-2-99 ; 6/23/03 3:25pm
 ;;5.3;Registration;**190,328,354,357,473,501**;Aug 13, 1993
 ;
EN(EVENT) ;
 ;
 ; Input  CLIENT - HL7 Client protocol 
 ;        DGWARD - Ward location [Optional]
 ;
 N DGENTRY,DGDIV,DGSCN,DGSITE,HLNODE,DGSTN,DGWARD,DGIEN,DGFAC,CLIENT
 ;
 Q:$G(EVENT)']""
 ;
 ; Extract HL7 message to local array for processing
 N I,J,X
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S X(I)=HLNODE,J=0
 . F  S J=$O(HLNODE(J)) Q:'J  S X(I,J)=HLNODE(J)
 ;
 ; Look for PV1 segment.  If A03 or A21, get previous ward, otherwise get current ward location.
 S I=0
 F  S I=$O(X(I)) Q:'I  D
 . I $P(X(I),"^",1)="PV1" D
 . . I "A03"[EVENT S DGWARD=$$WARD(X(I),7)
 . . I "A11"[EVENT S DGWARD=$$WARD(X(I),7) ; Retrieve ward prior toadmission cancellation
 . . I "A21"[EVENT S DGWARD=$$WARD(X(I),7)
 . . I '$G(DGWARD) S DGWARD=$$WARD(X(I),4)
 ;
 ; Get division for ward
 S DGDIV=+$$GET1^DIQ(42,DGWARD,.015,"I")
 ;
 ; Retrieve subscription control number for division
 S DGSCN=+$$GET1^DIQ(40.8,DGDIV,900.01)
 ;
 ;set HLL("LINKS") array
 K HLL ;added p-357
 D GET^HLSUB(DGSCN,2,"",.HLL) ;added p-357
 ;
 ; Set client protocol for destination
 S DGSTN=$$SITE^VASITE($$NOW^XLFDT,DGDIV)
 ; S DGAPIEN=$P(HLL("LINKS",1),"^",4) ;changed p-357, disabled p-501
 S DGAPIEN=$$GET1^DIQ(771,$P(HLL("LINKS",1),"^",4),.01) ; added p-501
 S DGFAC=$$GET1^DIQ(771,$P(HLL("LINKS",1),"^",4),3) ; added p-501
 ; S CLIENT="DGRU-RAI-"_EVENT_"-"_DGAPIEN ;changed p-357,disabled p501
 S CLIENT="DGRU-RAI-"_EVENT ; added p-501
 S $P(HLL("LINKS",1),"^",1)=CLIENT ;changed p-357
 S HLP("SUBSCRIBER")="^^^"_DGAPIEN_"^"_DGFAC ; added p-501
 Q
 ;
WARD(DGPV1,DGP) ; Retrieve Ward IEN for Division lookup.  If the ward has been
 ; "translated", then return the original Ward IEN.
 ; Input
 ;   DGPV1 - Copy of the PV1 segment
 ;   DGP   - Piece containing the ward to be checked
 ;
 N DGW,DGN,Y,DIC,DGIEN,DGX
 ;
 S DGW=$P(DGPV1,"^",DGP),DGN=$P(DGW,"~",1)
 S DGIEN=$$FIND1^DIC(42,"","BX",DGN,"","","DGERR")
 ;
 ; If the Lookup is unable to find a valid ward location, then check to see if this 
 ; is a translated ward name.  If it is, then return original ward ien
 I DGIEN<1 D
 . S DGX=$$FIND1^DIC(46.12,"","",DGN,"AC")
 . I DGX>0 S DGIEN=+$G(^DGRU(46.12,DGX,0)) ;p-473
 . E  D  ;p-473
 .. S DGX=$O(^DGRU(46.12,"AC",DGN,0)) ;p-473
 .. I DGX>0 S DGIEN=+$G(^DGRU(46.12,DGX,0)) ;p-473
 Q DGIEN
 ;
ENMFU(DGEVENT,DGDIV) ;ENTRY POINT FOR MASTER FILE UPDATE ROUTING
 ;
 N DGAPIEN,DGFAC,CLIENT
 S DGSCN=$$GET1^DIQ(40.8,DGDIV,900.01) ;Retrieve the Subscription Control Number for the division
 Q:DGSCN']""  ;Quit if division does not have a Subscription Control Number
 S DGSTN=$$SITE^VASITE($$NOW^XLFDT,DGDIV) ;Retrieve station info for division
 K HLL ;changed p-357
 D GET^HLSUB(DGSCN,2,"",.HLL) ;changed p-357
 ; S DGAPIEN=$P(HLL("LINKS",1),"^",4) ;ADDED P-357, disabled p-501
 S DGAPIEN=$$GET1^DIQ(771,$P(HLL("LINKS",1),"^",4),.01) ; added p-501
 S DGFAC=$$GET1^DIQ(771,$P(HLL("LINKS",1),"^",4),3) ; added p-501
 ; S CLIENT="DGRU-RAI-"_DGEVENT_"-"_DGAPIEN ;changed p-357 Set client variable using event type and receiving app,disabled p-501
 S CLIENT="DGRU-RAI-"_DGEVENT ; added p-501
 S $P(HLL("LINKS",1),"^",1)=CLIENT ;added p-357
 S HLP("SUBSCRIBER")="^^^"_DGAPIEN_"^"_DGFAC ; added p-501
 Q
 ;
