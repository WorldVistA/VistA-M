SCAPMCU3 ;MJK/ALB - AUTOLINK API ; 8/10/99 4:09pm
 ;;5.3;Scheduling;**41,45,177,204**;AUG 13, 1993
 ;
GETREC(SCDATA,SCTEAM) ; -- get team record with autolink data
 ; input  :    SCTEAM := ien of team
 ; output : SCDATA is the return array
 ;          SCDATA(0) := 0th node of Team
 ;             (1..n) := autolink name ^ autolink type ^ ien of entity
 ;
 N SC,X
 ; -- get 0th node of team
 S X=$$GETEAM(SCTEAM)
 ; -- add to return array
 D SET(X,0,.SCDATA)
 ; -- find all autolinks for team
 D SCAN(SCTEAM,.SC)
 ; -- build autolink string and add to return array
 D BUILD(.SC,.SCDATA)
 Q
 ;
BUILD(SC,SCDATA) ; -- build string to send and add to return array
 N SCLINK,SCINC,X,SCGLB,SCTYPE
 S SCINC=1
 S SCLINK=""
 F  S SCLINK=$O(SC(SCLINK)) Q:SCLINK=""  D
 . S X=SCLINK
 . IF X["DIC(42," S SCGLB="^DIC(42)",SCTYPE="WARD"
 . IF X["DIC(45.7," S SCGLB="^DIC(45.7)",SCTYPE="SPECIALTY"
 . IF X["VA(200," S SCGLB="^VA(200)",SCTYPE="PRACTITIONER"
 . IF X["DG(405.4," S SCGLB="^DG(405.4)",SCTYPE="ROOM"
 . IF X["SC(" S SCGLB="^SC",SCTYPE="CLINIC"
 . ; - add data to return array
 . IF $D(@SCGLB@(+SCLINK,0)) D SET($P(^(0),U)_U_SCTYPE_U_+SCLINK,.SCINC,.SCDATA)
 Q
 ;
SET(X,INC,SCDATA) ; -- set value in return array
 S INC=$G(INC)+1,SCDATA(INC)=X
 Q
 ;
SETREC(SCOK,SCTEAM,SC) ; -- add/edit autolink data to Team record
 ; input  :    SCTEAM := ien of team
 ; output : SC is the input array
 ;           SC(1..n) := autolink name ^ autolink type ^ ien of entity
 ;
 N SCTYPE,SCROOT,SCGLB,SCLINK,SCLINKI,SCI,SCOLD,SCNEW
 ; -- build array of current autolink assignments
 D SCAN(SCTEAM,.SCOLD)
 ;
 ; -- compare current with input  and add autolinks if in
 ;    input array but not in current array
 S SCI=0 F  S SCI=$O(SC(SCI)) Q:'SCI  S SCX=SC(SCI) D
 . S SCTYPE=$P(SCX,U,2)
 . D ROOT(SCTYPE,.SCROOT,.SCGLB)
 . S SCLINK=+$P(SCX,U,3)_";"_SCROOT
 . S SCNEW(SCLINK)=""
 . IF '$D(SCOLD(SCLINK)),SCGLB]"",$D(@SCGLB@(+SCLINK,0)) D ADD(SCTEAM,SCLINK)
 ;
 ; -- compare current with input and delete autolinks if not
 ;    in input array but in current array
 S SCLINK=""
 F  S SCLINK=$O(SCOLD(SCLINK)) Q:'SCLINK  IF '$D(SCNEW(SCLINK)) D
 . S SCLINKI=+SCOLD(SCLINK)
 . IF SCLINKI D DELETE(SCLINKI)
 S SCOK=1
 Q
 ;
ADD(SCTEAM,SCLINK) ; -- add an autolink to a Team
 N DIC,DD,DO,DLAYGO
 S DIC="^SCTM(404.56,",DLAYGO=404.56,DIC(0)="L",X=SCTEAM,DIC("DR")=".02////^S X=SCLINK"
 D FILE^DICN
 Q
 ;
DELETE(SCLINKI) ; -- delete an autolink from a Team
 N DIK,DA
 IF $D(^SCTM(404.56,SCLINKI,0)) D
 . S DIK="^SCTM(404.56,",DA=SCLINKI D ^DIK
 Q
 ;
GETEAM(SCTEAM) ; -- retrieve Team demographics
 Q $G(^SCTM(404.51,+$G(SCTEAM),0))
 ;
SCAN(SCTEAM,SC) ; -- build an array of current autolink assignments
 N SCLINK
 S SCLINK=""
 F  S SCLINK=$O(^SCTM(404.56,"APRIMARY",+$G(SCTEAM),SCLINK)) Q:SCLINK=""  S SC(SCLINK)=+$O(^(SCLINK,0))
 Q
 ;
ROOT(SCTYPE,SCROOT,SCGLB) ; -- determine global root of autolink type
 S (SCROOT,SCGLB)=""
 IF SCTYPE="WARD" S SCROOT="DIC(42,",SCGLB="^DIC(42)"
 IF SCTYPE="SPECIALTY" S SCROOT="DIC(45.7,",SCGLB="^DIC(45.7)"
 IF SCTYPE="PRACTITIONER" S SCROOT="VA(200,",SCGLB="^VA(200)"
 IF SCTYPE="ROOM" S SCROOT="DG(405.4,",SCGLB="^DG(405.4)"
 IF SCTYPE="CLINIC" S SCROOT="SC(",SCGLB="^SC"
 Q
 ;
GETLINK(SC,SCTYPE,SCIEN) ; -- get autolink entity data
 ;  input:  SCTYPE   := type of autolink (WARD, SPECIALTY, ectc.)
 ;          SCIEN    := ien of entity
 ; output:  SC(1..n) := list of Team names autolinked to entity
 ;                    
 ;
 N SCTEAM,SCROOT,SCGLB,SCINC,SCLINK
 ; -- deterine global root for autolink entity
 D ROOT(SCTYPE,.SCROOT,.SCGLB)
 ; -- set variable pointer value for autolink entity
 S SCLINK=+SCIEN_";"_$G(SCROOT)
 ; -- find Teams with autolinks to this entity
 S (SCINC,SCTEAM)=0
 IF $O(^SCTM(404.56,"AC",SCLINK,SCTEAM)) D
 . F  S SCTEAM=$O(^SCTM(404.56,"AC",SCLINK,SCTEAM)) Q:'SCTEAM  D
 . . S SCINC=SCINC+1
 . . S SC(SCINC)=$P($G(^SCTM(404.51,SCTEAM,0)),U)
 ELSE  D
 . S SCINC=SCINC+1
 . S SC(SCINC)="No links found."
 Q
 ;
PCPROV(SCTP,DATE,PCAP) ;returns ien & name of practitioner filling position
 ;Input: SCTP=team position ifn of primary care position assignment
 ;Input: DATE=relevant date
 ;Input: PCAP= '1' for pc provider
 ;             '2' for attending provider
 ;             '3' for pc associate provider
 ;
 ;   Returned [Error or None Found:"", Else: sc200^practname]
 ;
 N X,SCPRDTS,SCPR,SCPP,ERR,SCI,SCII,SCPRX,SCSUB,SCX,SCY
 S SCPP=0,DATE=$G(DATE,DT),SCPRDTS("INCL")=0
 S (SCPRDTS("BEGIN"),SCPRDTS("END"))=DATE
 ;bp/cmf 204 original code next line [SCALLHIS param not needed]
 ;S X=$$PRTPC^SCAPMC(SCTP,"SCPRDTS","SCPR","ERR",1,0)
 ;bp/cmf 204 change code next line
 S X=$$PRTPC^SCAPMC(SCTP,"SCPRDTS","SCPR","ERR",0,0)
 ;regroup providers
 S SCI=0 F  S SCI=$O(SCPR(SCI)) Q:'SCI  D
 .S SCSUB="" F  S SCSUB=$O(SCPR(SCI,SCSUB)) Q:SCSUB=""  D
 ..I SCSUB="PREC" S SCPP=1 Q:PCAP=3  ;precepted position flag
 ..S SCII="" F  S SCII=$O(SCPR(SCI,SCSUB,SCII)) Q:SCII=""  D
 ...S SCX=$P(SCPR(SCI,SCSUB,SCII),U,1,2) Q:'SCX
 ...S SCY=$S(PCAP=2:$P(SCSUB,"-"),1:SCSUB)
 ...S SCPRX(SCY)=$G(SCPRX(SCY))+1,SCPRX(SCY,SCPRX(SCY))=SCX
 ...Q
 ..Q
 .Q
 ;return preceptor pc provider
 I PCAP=1,SCPP,$G(SCPRX("PREC"))=1 Q SCPRX("PREC",1)
 ;return non-preceptor pc provider
 I PCAP=1,'SCPP,$G(SCPRX("PROV-U"))=1 Q SCPRX("PROV-U",1)
 ;return attending provider
 I PCAP=2,$G(SCPRX("PROV"))=1 Q SCPRX("PROV",1)
 ;return associate provider
 I PCAP=3,SCPP,$G(SCPRX("PROV-P"))=1 Q SCPRX("PROV-P",1)
 ;bp/cmf 204 original code next line [-1 busts documented output]
 ;Q -1
 ;bp/cmf 204 change code next line ["" is documented output]
 Q ""
