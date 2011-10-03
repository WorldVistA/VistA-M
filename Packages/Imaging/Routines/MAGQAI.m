MAGQAI ;WOIFO/RMP Imaging Utilities to support Assigning Initials [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;;Mar 01, 2002
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;ASSIGN INITIALS FOR TELNETED IMAGING FILES
 Q
ONE(DOMAIN) ;ADD A SINGLE DOMAIN
 N INIT
 S INIT=$$ASSN(DOMAIN)
 S:INIT="" INIT=$$REASS(DOMAIN)
 D:INIT'="" FINIT(DOMAIN,INIT)
 Q INIT
FINIT(DOMAIN,INIT) ;File Initials
 N DIC
 S DIC="^MAG(2006.19,"
 S X=DOMAIN,DIC("DR")=".02///^S X=INIT"
 S DIC(0)="LQ" K DD,DO D FILE^DICN
 Q
ASSN(VALUE) ;ASSIGN INITIALS WHILE UNIQUE
 N INIT,NAME
 S NAME=$P(VALUE,".")
 I NAME["-" S INIT=$E(NAME,1,1)_$E($P(NAME,"-",2),1,1)
 I NAME'["-" S INIT=$E(NAME,1,2)
 Q $S($D(^MAG(2006.19,"C",INIT)):"",1:INIT)
REASS(REP) ;ASSIGN WITH ALTERNATE
 N INIT,NAME,LEN,SEC,I,TEMP
 S NAME=$P(REP,"."),INIT=""
 S:NAME["-" SEC=$P(REP,"-",2)
 S LEN=$S(NAME["-":$L(SEC),1:$L(NAME))
 F I=1:1:LEN D  Q:INIT'=""
 . S TEMP=$E(NAME)_$E($S(NAME["-":SEC,1:NAME),I)
 . Q:$E(TEMP,2)'?1A
 . S:'$D(^MAG(2006.19,"C",TEMP)) INIT=TEMP
 Q INIT
DEL ;
 N INDX
 S INDX=0
 F  S INDX=$O(^MAG(2006.19,INDX)) Q:INDX'?1N.N  D
 . Q:"^40^41^42^43^44^45^46^53^78^81^94^132^"[("^"_INDX_"^")
 . Q:"^136^137^151^152^157^171^180^203^208^328^329^330^"[("^"_INDX_"^")
 . S DA=INDX,DR=".01///@",DIE="^MAG(2006.19,"
 . D ^DIE
 Q
MMGRP ;CREATES REMOTE MAIL GROUP TO HANDLE IMAGE ERROR MESSAGES
 N DA,DIE,DR,MAGA,MAGB,MAGC,MAGD,MAGE,MAGF,MAGG,IEN,MAGY,MAGM
 ;
 S MAGA="MAG SERVER" ; Mail group name
 S IEN=$$FIND1^DIC(3.8,"","MX",MAGA,"","","ERR")
 I +IEN=0 D
 . S MAGDATA(1)=""
 . S MAGDATA(2)="Creating the MAG SERVER mail group."
 . D MES^XPDUTL(.MAGDATA) K MAGDATA
 . S MAGB=0 ; Public
 . S MAGC=.5 ; Organizer is Postmaster
 . S MAGD=1 ; Self enrollment
 . S MAGF(1)="Mail group to manage Image activity messages." ;Description
 . S MAGG=1 ; Silent flag
 . S MAGDATA=$$MG^XMBGRP(MAGA,MAGB,MAGC,MAGD,.MAGE,.MAGF,MAGG)
 S MAGDATA=$S(+IEN>0:IEN,MAGDATA>0:MAGDATA,1:0)
 I MAGDATA>0 D
 . S MAGY(DUZ)=""
 . S MAGG=1
 . ;ADD installer as local mail recipient
 . S IEN=$$MG^XMBGRP(MAGDATA,"","","",.MAGY,"",MAGG)
 . ;Add G.MAG SERVER @ development site as remote recipient
 . S MAGM="G.IMAGING DEVELOPMENT TEAM@FORUM.DOMAIN.EXT"
 . I '$$FIND1^DIC(3.812,","_MAGDATA_",","MX",MAGM,"","","ERR") D
 . . S MAGE(3.812,"+1,"_MAGDATA_",",.01)=MAGM
 . . D UPDATE^DIE("E","MAGE")
 . ;Remove development domain mailgroup reference
 . S MAGX=$E("G.MAG SERVER@LAVC.ISC-WASH.DOMAIN.EXT",1,30)
 . S IEN=$$FIND1^DIC(3.812,","_MAGDATA_",","MX",MAGX,"","","ERR")
 . I +IEN>0 D
 . . K MAGE
 . . S MAGE(3.812,IEN_","_MAGDATA_",",.01)="@"
 . . D UPDATE^DIE("E","MAGE")
 Q
JBPTR() ;
 N JBPTR,X
 S U="^"
 S JBPTR=$S($P(^MAG(2006.1,1,1),U,6)>1:$P(^(1),U,6),+$P($G(^MAGQUEUE(2006.032,0)),U,4):$P(^(0),U,4),1:1)
 S X=$G(^MAGQUEUE(2006.032,JBPTR,0))
 Q $S(X="":0,1:JBPTR)
