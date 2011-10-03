MAGBRTE5 ;WOIFO/PMK - Background Routing - Load Balance ; 06/08/2007 10:28
 ;;3.0;IMAGING;**11,30,51,85,54**;03-July-2009;;Build 1424
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
BALANCE(IMAGE,RULE) N %,D,DEST,PARENT,PRI,X
 S PARENT=$P(^MAG(2005,IMAGE,0),"^",10) ; ~~~
 D:'$D(^MAGRT(2006.5906,RULE,1,PARENT))
 . N CP,M1,M2,MAX,B,E,L,RD,T
 . ;
 . L +^MAGRT(2006.5906,0):1E9 ; Background task must wait for lock
 . ;
 . ; Clean up old info
 . ; Allow for a study to cross one day boundary,
 . ; and remove everything that is older than a day.
 . ;
 . S RD=RDT-1 F  S RD=$O(^MAGRT(2006.5906,"D",RD),-1) Q:'RD  D
 . . N DE,RU,PA
 . . S DE="" F  S DE=$O(^MAGRT(2006.5906,"D",RD,DE)) Q:DE=""  D
 . . . S RU="" F  S RU=$O(^MAGRT(2006.5906,"D",RD,DE,RU)) Q:RU=""  D
 . . . . S PA="" F  S PA=$O(^MAGRT(2006.5906,"D",RD,DE,RU,PA)) Q:PA=""  D
 . . . . . K ^MAGRT(2006.5906,"D",RD,DE,RU,PA)
 . . . . . K ^MAGRT(2006.5906,RU,1,PA)
 . . . . . S X=^MAGRT(2006.5906,RU,1,0)
 . . . . . S $P(X,"^",4)=$P(X,"^",4)-1
 . . . . . S ^MAGRT(2006.5906,RU,1,0)=X
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . ;
 . D:'$D(^MAGRT(2006.5906,RULE))
 . . S X=$G(^MAGRT(2006.5906,0))
 . . S $P(X,"^",1,2)="ROUTE LOAD BALANCE^2006.5906"
 . . S:RULE>$P(X,"^",3) $P(X,"^",3)=RULE
 . . S $P(X,"^",4)=$P(X,"^",4)+1
 . . S:RULE>$P(X,"^",3) $P(X,"^",3)=RULE
 . . S ^MAGRT(2006.5906,0)=X
 . . S ^MAGRT(2006.5906,RULE,0)=RULE
 . . Q
 . ;
 . M CP=^MAGRT(2006.5906,"D",RDT)
 . S (B,DEST,L,M1,M2,MAX)=0
 . F  S DEST=$O(RULE(RULE,"ACTION",DEST)) Q:'DEST  D
 . . N I,T
 . . S B=B+1,B(B)=DEST
 . . S X=RULE(RULE,"ACTION",DEST)
 . . S M(B)=$P(X,"^",2),MAX=MAX+M(B)
 . . ; Don't exceed maximum number of studies per day days
 . . S T=0,I="" F  S I=$O(CP(DEST,I)) Q:I=""  S T=T+1
 . . I $P(X,"^",3),T'<$P(X,"^",3) S M2=M2+M(B),M(B)=-1,M1=M1+1
 . . Q
 . ; If one destination has reached its cap, redistribute...
 . D:M1
 . . N I,L,R
 . . S R=M2#M1,L=0
 . . F I=1:1:B S:M(I)>0 M(I)=M2\M1+M(I),L=I
 . . S M(L)=M(L)+R
 . . Q
 . ;
 . S X=$G(^MAGRT(2006.5906,RULE,2))
 . ; X = LAST ^ TOTAL ^ COUNT(DEST) ^ COUNT(DEST) ^ ...
 . F L=1:1:B S E(L)=+$P(X,"^",L+2)
 . S L=$P(X,"^",1) F  S L=L+1 S:L>B L=1 Q:E(L)<M(L)
 . S T=$P(X,"^",2)+1,E(L)=E(L)+1,DEST=B(L)
 . I T'<MAX S T=0 F L=1:1:B S E(L)=0
 . S X=L_"^"_T F L=1:1:B S X=X_"^"_E(L)
 . S ^MAGRT(2006.5906,RULE,2)=X
 . ;
 . ; Note: on consolidated sites 'origins' and 'destinations'
 . ; matter even more than on non-consolidated ones.
 . ; In the case of load-balancing, however, the 'destinations'
 . ; part is taken care of by the balancing parameters, and the
 . ; origin is moot, because each study has one (and only one)
 . ; origin.
 . ;
 . D:'$D(^MAGRT(2006.5906,RULE,1,PARENT))
 . . S X=$G(^MAGRT(2006.5906,RULE,1,0))
 . . S $P(X,"^",1,2)="^2006.59061"
 . . S:PARENT>$P(X,"^",3) $P(X,"^",3)=PARENT
 . . S $P(X,"^",4)=$P(X,"^",4)+1
 . . S ^MAGRT(2006.5906,RULE,1,0)=X
 . . S ^MAGRT(2006.5906,RULE,1,PARENT,0)=PARENT_"^"_RDT_"^"_DEST
 . . Q
 . L -^MAGRT(2006.5906,0)
 . Q
 S DEST=$P(^MAGRT(2006.5906,RULE,1,PARENT,0),"^",3)
 S X=$G(RULE(RULE,"ACTION",DEST))
 I X="" S METMSG(0,"No location for rule "_RULE_", alternative "_DEST)="" Q
 S X=$P(X,"^",1) Q:X="<LOCAL>"
 S DEST=0
 S D=0 F  S D=$O(RULE(RULE,"ACTION",D)) Q:'D  D  Q:DEST
 . Q:$P($G(RULE(RULE,"ACTION",D)),"^",1)'=X
 . S DEST=D
 . Q
 I 'DEST S METMSG(0,"Cannot find location """_X_""".")="" Q
 S ^MAGRT(2006.5906,"D",RDT,DEST,RULE,PARENT)=""
 ;
 ; Current version assumes that BALANCE means DOS-Copy, not DICOM...
 D VALDEST^MAGDRPC1(.DEST,X)
 D LOG("Load-Balance Destination is "_X)
 S PRI=$$PRI^MAGBRTE4($G(RULE(RULE,"PRIORITY")),IMAGE)
 S VRS=$$VRS(VRS,$$SEND(IMAGE,DEST,PRI,1,LOCATION))
 Q
 ;
VARNAME(F) ;
 S F=$TR(F," !""#$%&'()*+,-./:;<=>?@[\]^_`{|}~","_________________________________")
 F  Q:F'["__"  S F=$P(F,"__",1)_"_"_$P(F,"__",2,$L(F)+2)
 F  Q:$E(F,1)'="_"  S F=$E(F,2,$L(F))
 F  Q:$E(F,$L(F))'="_"  S F=$E(F,1,$L(F)-1)
 S F=$TR(F,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q F
 ;
SEND(IMAGE,DEST,PRI,MECH,LOCATION) N D1,D2,IM,IMG,O,OUT,PRE,RADFN,RADTI,RACNI,RARPT,VRS,X
 S VRS=$$VRS("",$$SEND^MAGBRTUT(IMAGE,DEST,PRI,MECH,LOCATION))
 Q:$G(RULE(RULE,"PRIORSTUDY"))'="YES" VRS
 Q:'$G(IMAGE) VRS
 S X=$G(^MAG(2005,IMAGE,2))
 I $P(X,"^",6)'=74 Q VRS
 S RARPT=$P(X,"^",7) I 'RARPT Q VRS
 S X=$G(^RARPT(RARPT,0)) ; IA # 1171
 S RADFN=$P(X,"^",2),RADTI=9999999.9999-$P(X,"^",3),RACNI=$P(X,"^",4)
 S:RACNI RACNI=$O(^RADPT(+RADFN,"DT",+RADTI,"P","B",RACNI,"")) ; IA # 1172
 S PRE="A^"_RADFN_"^"_RADTI_"^"_RACNI_"^"_RARPT
 D PRIOR1^MAGJEX2(.OUT,PRE)
 S O=0 F  S O=$O(OUT(O))  Q:O=""  D
 . S X=$G(OUT(O)) Q:'$P(X,"^",2)
 . S X=$P(X,"|",2) Q:'X
 . S RARPT=$P(X,"^",4) Q:'RARPT
 . S D1=0 F  S D1=$O(^RARPT(RARPT,2005,D1)) Q:'D1  D  ; IA # 1171
 . . S IM=+$G(^RARPT(RARPT,2005,D1,0)) Q:'IM  ; IA # 1171
 . . S D2=0 F  S D2=$O(^MAG(2005,IM,1,D2)) Q:'D2  D
 . . . S IMG=+$G(^MAG(2005,IM,1,D2,0)) Q:'IMG
 . . . S VRS=$$VRS(VRS,$$SEND^MAGBRTUT(IMG,DEST,PRI,MECH,LOCATION))
 . . . S METMSG(1,"SEND also image #"_IMG_" from prior study")=""
 . . . Q
 . . Q
 . Q
 Q VRS
 ;
VRS(OLD,NEW) N OUT
 S OUT=""
 S:OLD OUT=OLD_"^"
 S:NEW OUT=OUT_NEW
 F  Q:OUT'["^^"  S OUT=$P(OUT,"^^",1)_"^"_$P(OUT,"^^",2,$L(OUT)+2)
 Q:$L(OUT)<100 OUT
 Q $P(OUT,"^",1)_"^...^"_$P(OUT,"^",$L(OUT,"^"))
 ;
LOG(X) N D,H,I,M,T
 S I=$O(^XTMP("MAGEVAL",ZTSK," "),-1)+1
 S XMSG=$G(XMSG)+1 S:I>XMSG XMSG=I
 S D=$P("Thu Fri Sat Sun Mon Tue Wed"," ",$H#7+1)
 S T=$P($H,",",2),H=T\3600,M=T\60#60 S:H<10 H=0_H S:M<10 M=0_M
 S ^XTMP("MAGEVAL",ZTSK,XMSG)=D_" "_H_":"_M_" "_X
 Q
 ;
WLDMATCH(VAL,WILD) ;
 ;
 ; Returns true if VAL=WILD (Val=Actual value, Wild=Wildcard)
 ;
 ; Wild characters are:
 ;   ?   matches any single character
 ;   *   matches any string of characters
 ;
 N I,M
 F  Q:VAL=""  Q:WILD=""  D
 . I $E(VAL,1)=$E(WILD,1) S VAL=$E(VAL,2,$L(VAL)),WILD=$E(WILD,2,$L(WILD)) Q
 . I $E(WILD,1)="?" S VAL=$E(VAL,2,$L(VAL)),WILD=$E(WILD,2,$L(WILD)) Q
 . I $E(WILD,1)="*" D  Q:M
 . . I WILD="*" S (VAL,WILD)="",M=1 Q
 . . S WILD=$E(WILD,2,$L(WILD)),M=0
 . . F I=1:1:$L(VAL) I $$WLDMATCH($E(VAL,I,$L(VAL)),WILD) S M=1,VAL=$E(VAL,I,$L(VAL)) Q
 . . Q
 . S VAL="!",WILD=""
 . Q
 Q:VAL'="" 0 Q:WILD'="" 0 Q 1
 ;
