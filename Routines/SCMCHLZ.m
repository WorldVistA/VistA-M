SCMCHLZ ;BP/DJB - PCMM HL7 Bld ZPC Segment ; 3/7/00 1:08pm
 ;;5.3;Scheduling;**177,210,212,245,286,515**;AUG 13, 1993;Build 14
 ;
ZPC(SCSTR,SCID,SCDATA,SCSEQ) ;Main entry point for building ZPC segment
 ;
 ;Input:
 ;   SCSTR...: String of fields requested separated by commas
 ;   SCID....: Provider Assignment ID. Unique ID string that
 ;             Austin uses for the key field.
 ;   SCDATA..: "^" Delimited string that contains all data needed
 ;             to build a ZPC segment. If all pieces are "", Austin
 ;             does a deletion.
 ;               Format:
 ;                 ProviderIEN^DateAssign^DateUnassign^Type
 ;               Examples:
 ;                 3^2980605^2990203^PCP
 ;                 6^2980605^2990203^AP
 ;                 ""^""^""^"" (deletion)
 ;   SCSEQ...: Sequentially number multiple ZPC segments.
 ;             djb/bp Patch 210.
 ;Output:
 ;   ZPC segment string.
 ;
 NEW CS,FS,QT,SCZPC,SS
 ;
 ;Initialize variables
 D INIT
 I $G(SCID)="" Q SCZPC
 ;
 I SCSTR[",1," D ID ;........Provider Assignment ID
 I SCSTR[",2," D PROV ;......Provider
 I SCSTR[",3," D PROVDA ;....Date provider assigned
 I SCSTR[",4," D PROVDU ;....Date provider unassigned
 I SCSTR[",5," D PROVT ;.....Provider Type code
 I SCSTR[",6," D PROVPC ;....Provider Person Class  PATCH 515
 I SCSTR[",8," D PROVSSN ;...Provider SSN;bp/ar and alb/rpm Patch 212
 I SCSTR[",9," D STATION ;....5 or 6 digit station number Patch 286
 I SCSTR[",10," D TEAM ;....Team Name - Patch 515
 I SCSTR[",11," D TMIEN ;....Team IEN - Patch 515
 I SCSTR[",16," D TMPUR ;...Team Purpose  Patch 515
 I $L(SCZPC)>245 D ADJUST ;..If length>245 add continuation node
 Q SCZPC
 ;
ID ;Provider Assignment ID
 ;Convert ID to IEN of file 404.49 since it's alot shorter.
 ;ID format:
 ;  IEN404.43 - IEN404.52 - IEN404.53 - AP/PCP
 ;  Examples: "2290-405-34-PCP"
 ;            "2290-406-0-AP"
 ;
 NEW FAC,ID,OLDID,SCERR,SCFDA,SCIEN
 ;
 ;Find ID in PCMM HL7 ID file (404.49), and use IEN.
 S ID=$O(^SCPT(404.49,"B",SCID,""))
 ;
 ;If ID not found, add it to 404.49 now.
 I 'ID D  ;
 . S SCFDA(404.49,"+1,",.01)=SCID
 . D UPDATE^DIE("E","SCFDA","SCIEN","SCERR")
 . S ID=$G(SCIEN(1))
 ;
 ;bp/djb Patch 210
 ;New code begins
 ;If this is a site integration entry, use old ID.
 S FAC=SCFAC ;..Facility
 S OLDID=$P($G(^SCPT(404.49,ID,0)),U,2)
 I OLDID]"" D  ;
 . S FAC=$P(OLDID,"-",1)
 . S ID=$P(OLDID,"-",2)
 ;New code ends
 ;
 ;Add ID to ZPC segment
 S $P(SCZPC,FS,2)=FAC_"-"_ID
 Q
 ;
STATION ; Add station # suffix patch SD*5.3*286
 NEW STAT,SNUM,SCTP,TEAM,TEAMP
 S $P(SCZPC,FS,10)=""
 S SCTP=+$P(SCZPC,"-",2),SCTP=+$P($G(^SCPT(404.49,SCTP,0)),"-",1) D
 .IF SCTP S TEAMP=$$GET1^DIQ(404.43,SCTP_",",.02,"I") D
 ..IF TEAMP S SNUM=$$GET1^DIQ(404.57,TEAMP_",",.02,"I") D
 ...IF SNUM S TEAM=$$GET1^DIQ(404.51,SNUM_",",.07,"I") D
 ....IF TEAM S STAT=$$GET1^DIQ(4,TEAM_",",99) D
 .....IF STAT S $P(SCZPC,FS,10)=STAT
 Q
 ;
TEAM ;Add Team Name patch SD*5.3*515
 NEW SNUM,SCTP,TEAM,TEAMP
 S $P(SCZPC,FS,11)=QT
 Q:'$L(($P(SCDATA,U,2)))
 S SCTP=+$P(SCZPC,"-",2),SCTP=+$P($G(^SCPT(404.49,SCTP,0)),"-",1) D
 .IF SCTP S TEAMP=$$GET1^DIQ(404.43,SCTP_",",.02,"I") D
 ..IF TEAMP S SNUM=$$GET1^DIQ(404.57,TEAMP_",",.02,"I") D
 ...IF SNUM S TEAM=$$GET1^DIQ(404.51,SNUM_",",.01,"I") D
 ....IF $L(TEAM)>0 S $P(SCZPC,FS,11)=TEAM
 Q
 ;
TMIEN ;Add Team IEN patch SD*5.3*515
 NEW SNUM,SCTP,TEAMP
 S $P(SCZPC,FS,12)=QT
 Q:'$L(($P(SCDATA,U,2)))
 S SCTP=+$P(SCZPC,"-",2),SCTP=+$P($G(^SCPT(404.49,SCTP,0)),"-",1) D
 .IF SCTP S TEAMP=$$GET1^DIQ(404.43,SCTP_",",.02,"I") D
 ..IF TEAMP S SNUM=$$GET1^DIQ(404.57,TEAMP_",",.02,"I") D
 ...IF SNUM S $P(SCZPC,FS,12)=SNUM
 Q
 ;
PROV ;Provider
 NEW PROV,PTR200,SCNAM,SCNAME,SCTMP,X
 ;
 S $P(SCZPC,FS,3)=QT
 S PTR200=+SCDATA
 Q:'PTR200
 ;
 ;Get External Provider ID
 D PERSON^VAFHLRO3(PTR200,"SCTMP",QT)
 Q:'$D(SCTMP)
 S PROV=SCTMP(1,1,1)_SS_SCTMP(1,1,2)
 S $P(PROV,CS,8)=SCTMP(1,8)
 ;rpm/alb patch 210-Stuff facility in Assigning Facility(component 14)
 S $P(PROV,CS,14)=SCTMP(1,1,2)
 ;rpm/alb patch 210
 ;Get Standardized Name using Kernel API
 ;Standardized Name retrieval allowed by IA #3065
 S SCNAM("FILE")=200
 S SCNAM("IENS")=PTR200_","
 S SCNAM("FIELD")=.01
 S SCNAME=$$HLNAME^XLFNAME(.SCNAM,"",FS)
 F X=2:1:7 S $P(PROV,CS,X)=$P(SCNAME,FS,X-1)
 F X=9:1:13 S $P(PROV,CS,X)=""
 ;
 ;Add provider to ZPC segment
 S $P(SCZPC,FS,3)=PROV
 Q
 ;
PROVDA ;Provider - Date Assigned
 NEW DATE
 S $P(SCZPC,FS,4)=QT
 S DATE=$P(SCDATA,U,2)
 Q:'DATE
 S $P(SCZPC,FS,4)=$$HLDATE^HLFNC(DATE,"DT")
 Q
 ;
PROVDU ;Provider - Date Unassigned
 NEW DATE
 S $P(SCZPC,FS,5)=QT
 S DATE=$P(SCDATA,U,3)
 Q:'DATE
 S $P(SCZPC,FS,5)=$$HLDATE^HLFNC(DATE,"DT")
 Q
 ;
PROVT ;Provider - Type code
 NEW PT
 S $P(SCZPC,FS,6)=QT
 S PT=$P(SCDATA,U,4)
 Q:PT']""
 S $P(SCZPC,FS,6)=PT
 Q
 ;
PROVPC ;Provider - Person Class
 NEW CODE,PTR200
 S $P(SCZPC,FS,7)=QT
 S PTR200=+SCDATA
 Q:'PTR200
 S CODE=$$GET^XUA4A72(PTR200)
 ; PATCH 515  OLD CODE
 ; I CODE=-1!'CODE Q
 ; S $P(SCZPC,FS,7)=$P(CODE,"^",7)_CS_CS_"VA8932.1"
 I CODE=-1!'CODE S CODE=""
 S CODE=$P(CODE,"^",7)
 S $P(SCZPC,FS,7)=CODE_CS_CS_"VA8932.1"
 Q
 ;
PROVSSN ;Provider - Social Security Number
 ;bp/ar and alb/rpm Patch 212
 NEW SCSNN,PTR200,SC200,SCARRY
 S $P(SCZPC,FS,9)=QT
 S PTR200=+SCDATA
 Q:'PTR200
 S SC200=$$NEWPERSN^SCMCGU(PTR200,"SCARRY")
 I SC200'=1 Q
 S SCSNN=$P($G(SCARRY(PTR200)),U,6)
 Q:SCSNN'?9N
 S $P(SCZPC,FS,9)=SCSNN
 Q
 ;
TMPUR ; TEAM PURPOSE ADDED PATCH 515 send in BOTH DELETE & ADD
 S $P(SCZPC,FS,17)=QT
 ; Q:SCDATA="^^^"   COMMENT OUT SO SEND W DELETE TOO
 NEW SCTMPI,SCTMP,SCTPD,SCTM,TMD,ND,SCTP
 ; Read PATIENT TEAM ASS FILE 
 S ND=$G(^SCPT(404.43,$P(SCID,"-",1),0))
 Q:ND=""
 S SCTP=$P(ND,U,2)   ; TP
 ; READ TP REC (57)
 S SCTPD=$G(^SCTM(404.57,SCTP,0))
 Q:SCTPD=""
 S SCTM=$P(SCTPD,U,2)
 ; READ TEAM FILE (404.51
 S TMD=^SCTM(404.51,SCTM,0)
 S SCTMP=$P(TMD,U,3)
 Q:SCTMP=""
 S SCTMPI=SCTMP
 S SCTMP=$G(^SD(403.47,SCTMP,0))
 Q:SCTMP=""
 S SCTMP=$P(SCTMP,U,1)
 Q:SCTMP=""
 S $P(SCZPC,FS,17)=SCTMPI_CS_SCTMP
 Q
 ;
INIT ;Initialize variables
 ;
 ;Set delimeter values
 S FS=HL("FS") ;.........^
 S CS=$E(HL("ECH"),1) ;..~
 S SS=$E(HL("ECH"),4) ;..&
 S QT=HL("Q") ;..........""
 ;
 ;Default SCSEQ to 1. djb/bp Patch 210
 S:'$G(SCSEQ) SCSEQ=1
 ;
 ;Initialize ZPC segment to all nulls.
 ;bp/ar and alb/rpm Patch 212
 ;S $P(SCZPC,FS,5)="^" ;Initialize as empty; not null.
 ;S SCZPC="ZPC"_FS_SCZPC_FS_SCSEQ ;djb/bp Patch 210
 S $P(SCZPC,FS,9)=""
 S $P(SCZPC,FS,10)="" ; PATCH 286
 S $P(SCZPC,FS,11)="" ; PATCH 515
 S $P(SCZPC,FS,12)="" ; PATCH 515
 ; DEBBIE LEVY TPA CHGS 20070518 PATCH 515
 S $P(SCZPC,FS,17)=""
 S $P(SCZPC,FS,1)="ZPC"
 S $P(SCZPC,FS,8)=SCSEQ
 ;
 ;Initialize SCSTR to fields user requested.
 S SCSTR=$G(SCSTR)
 ;bp/ar and alb/rpm Added "8" to default fields Patch 212
 ; Added "9" to default fields Patch 286
 ; DEBBIE LEVY TPA CHGS 20070518 PATCH 515
 ;     added team (10), team IEN (11) and team purpose (16)
 ;I SCSTR']"" S SCSTR="1,2,3,4,5,6,8,9" ;Default fields
 I SCSTR']"" S SCSTR="1,2,3,4,5,6,8,9,10,11,16" ;Default fields
 ;Add starting and ending comma.
 I $E(SCSTR)'="," S SCSTR=","_SCSTR
 I $E(SCSTR,$L(SCSTR))'="," S SCSTR=SCSTR_","
 Q
 ;
ADJUST ;Add a continuation node if length is greater than 245.
 Q:$L(SCZPC)'>245
 S SCZPC(1)=$E(SCZPC,246,999) ;
 S SCZPC=$E(SCZPC,1,245)
 Q
