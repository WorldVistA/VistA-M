MAGQBUT ;WOIFO/RMP,JSL - Imaging Background Processor Utilities ; 24 May 2016 11:16 AM
 ;;3.0;IMAGING;**7,8,48,20,39,168**;Mar 19, 2002;Build 18;May 24, 2016
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
CHGSERV(RESULT,NOTIFY,WSOS,BPWS) ;
 ; RPC[MAGQ FS CHNGE]
 ; RESULT VALUES:-1=NO RG MEMBERS,0=BELOW RESERVE,1=ABOVE RESERVE*PURGE FACTOR,2=BETWEEN RESERVE AND RESERVE*PURGE FACTOR
 ; ^CWL-PHYSICAL REFERENCE^CWL-TOTAL SPACE^PURGE^%FREE SPACE^PURGE_GROUP_IEN^VERIFY^RGADVANCE
 N SPACE,IEN,SIZE,CWL,MIN,CNT,TNODE,TINT,NOW,TLTIME,TOD,PLACE,TSPACE,TSIZE,AUTON,GROUP
 N APP,PFACTOR,NG,WSIEN,X,OG
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S U="^",(SPACE,SIZE,CNT,TSPACE,TSIZE)=0,(RESULT,IEN,NG)="" ; T23
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S APP="MAGQ FS CHNGE: "_BPWS
 S WSIEN=$O(^MAG(2006.8,"C",PLACE,BPWS,""))
 S MIN=$$SPARM
 S CWL=$$CWL^MAGBAPI(PLACE)
 S (GROUP,OG)=$$GRP(PLACE)
 D:SPACE>0 REPCWL(CWL,GROUP,.RESULT) ; Update Result with Current Write Group properties
 S PFACTOR=$$GET1^DIQ(2006.1,PLACE,"60.5","E")
 S PFACTOR=$S(+PFACTOR:+PFACTOR,1:2) ; If only one group default to 1
 D SPRGE(WSIEN,PLACE,.RESULT) ; Check for Scheduled Purge
 D SVERI(WSIEN,PLACE,.RESULT) ; Check for Scheduled Verifier
 D RGADV(PLACE,.GROUP,.RESULT)  ;Check for RG Advance (Scheduled RAID group advance)
 I $P($G(^MAG(2006.1,PLACE,1)),U,10) D NAUTOW(PLACE,CWL,.SPACE,.SIZE,.RESULT,NOTIFY,GROUP) Q  ;Cache balancing off
 ; Evaluate space for auto-write location update/should find group with space
 F  D FSP(MIN,.SPACE,.SIZE,.IEN,.TSPACE,.TSIZE,PLACE,GROUP,"") Q:IEN  D  Q:$P(RESULT,U,1)="-1"  Q:GROUP=$$GRP(PLACE)  Q:OG=GROUP
 . S NG=$$NXTGP(PLACE,GROUP)
 . I NG=GROUP D  Q
 . . D NGF(PLACE) ; Mail "Get_Next_RAID_Group_failure" message
 . . I '$P($G(^MAG(2005.2,NG,7,0)),U,4)  S $P(RESULT,U,1)="-1" ; ZERO MEMBER COUNT - T23
 . . Q
 . S GROUP=NG
 . Q
 I OG'=GROUP,$P(RESULT,U,8)'="" S $P(RESULT,U,8)="Automatic RGADVANCE"
 Q:$P(RESULT,U,1)="-1"
 I TSIZE D REPCWL(IEN,GROUP,.RESULT,TSPACE,TSIZE) ; %FREE SPACE
 E  S $P(RESULT,U,5)="0.00"
 I +IEN'=CWL,IEN>0 D  ; on Change event 
 . D SCWL(IEN,PLACE,GROUP,APP,DUZ)  ; UPDATES SITE PARAMETER FILE WITH CURRENT WRITE AND GROUP LOCATIONS
 . Q
 ; Evaluate space for auto purge contingencies for current RAID group
 I TSIZE>0,(((TSPACE/TSIZE)*100)>(PFACTOR*MIN)) S $P(RESULT,U)=1 Q
 S $P(RESULT,U)=$S('TSIZE:0,(((TSPACE/TSIZE)*100)>MIN):1,SPACE>0:2,1:0)
 S $P(RESULT,U,2,3)=$P($G(^MAG(2005.2,+$P(^MAG(2006.1,PLACE,0),U,3),0)),U,1,2)
 I ($P($G(^MAG(2006.1,PLACE,"BPPURGE")),U)&(SPACE>0)&($$GET1^DIQ(2006.8,WSIEN,"3","I")="1")) D  Q  ;AUTOPURGE IS ENABLED
 . S NG=$$NXTGP(PLACE,GROUP,"1") ;NEXT PURGE CAPABLE GROUP
 . I 'NG D NGF(PLACE) Q
 . Q:($P(^MAG(2006.1,PLACE,"BPPURGE"),U,7))+4>$$DT^XLFDT  ; Allow only 1 auto-purge per 4 days
 . I ($$UPPER^MAGQE4(WSOS)'["SERVER") Q:(WSOS'[".6.2.")  ;;Q:$$UPPER^MAGQE4(WSOS)'["SERVER"
 . S $P(RESULT,U,4)="AUTO_PURGE"
 . S $P(RESULT,U,6)=NG ;GROUP TO BE PURGED
 . D DFNIQ^MAGQBPG1("","An automatic RAID Group purge has been initiated for the following",0,PLACE,"AUTO_RAID_GROUP_PURGE")
 . D DFNIQ^MAGQBPG1("","VistA Imaging RAID group: "_$P($G(^MAG(2005.2,NG,0)),U,1),0,PLACE,"AUTO_RAID_GROUP_PURGE")
 . D DFNIQ^MAGQBPG1("","Auto_RAID_group_purge",1,PLACE,"AUTO_RAID_GROUP_PURGE")
 . Q
 I TSIZE>0,(((TSPACE/TSIZE)*100)>MIN) Q
 D:(NOTIFY!(SPACE>0)) TMESS(SPACE,"VistA Imaging RAID storage is Critically Low",PLACE)
 Q 
TMESS(SPACE,TS,PLACE) ;Trigger a message
 N TN,PC,SER S TN=$$GETMI^MAGQBUT5(TS,PLACE)
 S PC=$P($G(^MAG(2006.1,PLACE,"BPPURGE")),U)
 S SER=$$PURGES(PLACE)
 Q:$$FMADD^XLFDT(+$P(TN,"^",2),"",+$P(TN,U,1),"","")>$$NOW^XLFDT
 D ICCL^MAGQBUT1(CNT_U_TS_U_SPACE_U_PC_SER,$P(TN,"^",1)_" hours.",PLACE)
 Q
PURGES(PLACE) ; BP Server Assigned to Auto-purge
 N IEN,NAME,SER S (NAME,SER)=""
 F  S NAME=$O(^MAG(2006.8,"C",PLACE,NAME)) Q:NAME=""  D  Q:SER]""
 . S IEN=$O(^MAG(2006.8,"C",PLACE,NAME,"")) Q:'IEN
 . I $P($G(^MAG(2006.8,IEN,0)),U,4)=1 S SER=$P($G(^MAG(2006.8,IEN,1)),U,1)
 . Q 
 Q SER
NXTGP(PL,GRP,FP) ; return sure the NEXT able group (Canonically sorted by name)
 N INDX,TMP,GNAME
 S INDX="",GNAME=$P($G(^MAG(2005.2,GRP,0)),U)
 F  S INDX=$O(^MAG(2005.2,"F",PL,"GRP",INDX)) Q:'INDX  D
 . Q:'$P($G(^MAG(2005.2,INDX,7,0)),U,4)  ; ZERO MEMBER COUNT
 . ; CHECK MEMBERS FOR ONLINE, READABLE, HASHED, AND SPACE
 . Q:'$$GABLE(INDX,$G(FP))
 . S TMP($P($G(^MAG(2005.2,INDX,0)),U),INDX)=""
 . Q
 Q:'$D(TMP) GRP
 S INDX=$O(TMP(GNAME)) ;TRY NEXT GROUP NAME CANONICALLY CH
 I INDX="" S INDX=$O(TMP("")) ; ELSE LOOP TO FIRST
 S INDX=$S(INDX'="":$O(TMP(INDX,"")),1:"") ; IF ANY GROUPS QUALIFY
 K TMP
 Q $S(INDX'="":INDX,1:GRP)
GABLE(GR,FP) ; next group able (has online, readable, hashed)
 N IEN,RESULT,MIN,SPACE,SIZE
 S (IEN,RESULT,SPACE,SIZE)=0
 S MIN=$$SPARM
 F  S IEN=$O(^MAG(2005.2,GR,7,"B",IEN)) Q:'IEN  D
 . Q:$P($G(^MAG(2005.2,IEN,0)),U,6,7)'="1^MAG"  ; Not online/MAG
 . Q:$P($G(^MAG(2005.2,IEN,1)),U,6)="1"  ; Read-only
 . Q:$P($G(^MAG(2005.2,IEN,0)),U,3)'>0  ; No total space reported
 . Q:$P($G(^MAG(2005.2,IEN,0)),U,8)'="Y"  ; Not hashed
 . Q:$P($G(^MAG(2005.2,IEN,0)),U,2)[":"  ;skip if it appears to be a local drive
 . Q:$E($P($G(^MAG(2005.2,IEN,0)),U,2),1,2)'="\\"  ; skip if not a normal share path address
 . Q:('$G(FP)&'$$MAXSP(IEN,.SPACE,.SIZE,$G(^MAG(2005.2,IEN,0)),MIN))
 . S RESULT="1"
 . Q
 Q RESULT
MAXSP(IEN,FS,SZ,NODE,MIN) ; Called from FSP (RPC[MAGQ FS CHNGE]CHGSERV:FSP) 
 N SPACE,SIZE
 S SPACE=+$P(NODE,U,5),SIZE=+$P(NODE,U,3)
 I SIZE>0,(((SPACE/SIZE)*100)>MIN),SPACE>FS D  Q 1
 . S FS=SPACE,SZ=SIZE
 Q 0
SPARM() ;Site Parameter for PERCENT server space to be held in reserve
 N VALUE
 S VALUE=$P($G(^MAG(2006.1,$$PLACE^MAGBAPI(+$G(DUZ(2))),1)),U,8)
 Q $S(VALUE>0:VALUE,1:5)
SCWL(IEN,PLACE,GROUP,APP,DUZ) ; Sets updates the Current Write Location
 N X,X2,CNT
 Q:'$$VALRD(IEN,PLACE,GROUP)
 S X=$$DT^XLFDT,X2=$$FMADD^XLFDT(X,30,"","","")
 I '$D(^XTMP("MAGSCWL "_X,0)) D 
 . S ^XTMP("MAGSCWL "_X,0)=X2_"^"_X_"^"_"Recording current write location updates"
 S ^XTMP("MAGSCWL "_X,$$NOW^XLFDT)="CWL: "_IEN_" ( "_$P($G(^MAG(2005.2,IEN,0)),U,1,2)_")^PLACE: "_PLACE_"^GROUP: "_GROUP_"^Application: "_$G(APP)_"^DUZ: "_DUZ
 S $P(^MAG(2006.1,PLACE,0),U,10)=GROUP
 S $P(^MAG(2006.1,PLACE,0),U,3)=IEN
 S $P(^MAG(2006.1,PLACE,"PACS"),U,3)=IEN
 Q
EGR(PL,GRP,ACTION) ; Edit Group Read Only 
 N INDX,ZNODE,NODE1
 S INDX=0
 F  S INDX=$O(^MAG(2005.2,INDX)) Q:INDX'?1N.N  D
 . S ZNODE=$G(^MAG(2005.2,INDX,0))
 . Q:$P(ZNODE,U,10)'=PLACE
 . Q:$P(ZNODE,U,6,7)'["1^MAG"
 . Q:$P(ZNODE,U,9)="1"  ;ROUTING SHARE
 . S NODE1=$G(^MAG(2005.2,INDX,1))
 . Q:$P(NODE1,U,8)'=GRP
 . I ACTION="E" S $P(^MAG(2005.2,INDX,1),U,6)="0"
 . E  S $P(^MAG(2005.2,INDX,1),U,6)="1"
 . Q
 Q
GRP(PLACE) ;
 Q $S(+$P($G(^MAG(2006.1,PLACE,0)),U,10):+$P($G(^MAG(2006.1,PLACE,0)),U,10),1:$$NXTGP(PLACE,0))
FSP(MIN,SPACE,SIZE,IEN,TSPACE,TSIZE,PLACE,GROUP,FILTER) ; Find Space called from (RPC[MAGQ FS CHNGE]CHGSERV)
 N INDX,ZNODE,NODE1
 S (INDX,TSPACE,TSIZE)=0
 F  S INDX=$O(^MAG(2005.2,INDX)) Q:INDX'?1N.N  D
 . Q:'$$VALRD(INDX,PLACE,GROUP)
 . S ZNODE=$G(^MAG(2005.2,INDX,0))
 . S TSPACE=TSPACE+(+$P(ZNODE,U,5))
 . S TSIZE=TSIZE+(+$P(ZNODE,U,3))
 . S CNT=CNT+1
 . Q:(+FILTER=INDX)  ; Find a share within the group other than this one
 . I $$MAXSP(INDX,.SPACE,.SIZE,ZNODE,MIN) S IEN=INDX
 . Q
 Q
VALRD(IEN,PLACE,GROUP) ;Validate Active RAID
 N ZNODE,NODE1
 S ZNODE=$G(^MAG(2005.2,IEN,0))
 S NODE1=$G(^MAG(2005.2,IEN,1))
 Q:$P(ZNODE,U,10)'=PLACE 0
 I $D(GROUP),$P(NODE1,U,8)'=GROUP Q 0
 Q:+$P(NODE1,U,6) 0 ;READ ONLY
 Q:$P(ZNODE,U,6,7)'["1^MAG" 0
 Q:$P(ZNODE,U,9)="1" 0 ;ROUTING SHARE
 Q:$P(ZNODE,U,8)'="Y" 0 ;skip not hashed
 Q:$P(ZNODE,U,2)[":" 0 ;skip if it appears to be a local drive - from testing
 Q:$E($P(ZNODE,U,2),1,2)'="\\" 0 ; skip if not a normal share path address
 Q 1
NGF(PLACE) ;
 D DFNIQ^MAGQBPG1("","The get next raid group function failed!",0,PLACE,"GET_NEXT_RAID_GROUP_FAILURE")
 D DFNIQ^MAGQBPG1("","Use your BP Network Location Manager to re-configure your RAID",0,PLACE,"GET_NEXT_RAID_GROUP_FAILURE")
 D DFNIQ^MAGQBPG1("","Get_Next_RAID_Group_failure",1,PLACE,"GET_NEXT_RAID_GROUP_FAILURE")
 Q
SPRGE(WSIEN,PLACE,RESULT) ; Scheduled Purge
 N NG
 ;Check for scheduled purge
 Q:'$$GET1^DIQ(2006.1,PLACE,"61","I")  ; Check if Scheduled purge is enabled
 Q:($$GET1^DIQ(2006.1,PLACE,"61.1","I")+1)>$$DT^XLFDT  ;Check if activated today
 I ($$UPPER^MAGQE4(WSOS)'["SERVER") Q:(WSOS'[".6.2.")  ;;Q:$$UPPER^MAGQE4(WSOS)'["SERVER"  ; workaround  Win 2012
 Q:'$$GET1^DIQ(2006.8,WSIEN,"3","I")  ;Check if task is assigned to this BP WS
 N T1,T2
 ;Adjust 24 hour time for Fileman format for Scheduled time (#61.4)
 S T1="0000",T2=$$GET1^DIQ(2006.1,PLACE,"61.4","I"),T1=$E(T1,1,($L(T1)-$L(T2)))_T2
 I $$FMADD^XLFDT($$NOW^XLFDT,"","",20,"")>($$GET1^DIQ(2006.1,PLACE,"61.3","I")_"."_T1) D
 . S NG=$$NXTGP(PLACE,GROUP,"1") ; Next purge capable Group
 . I 'NG D NGF(PLACE)  Q  ; Quit if next Raid Group not found
 . S $P(RESULT,U,4)="SCHEDULED_PURGE"_"~"_$$GET1^DIQ(2006.1,PLACE,"61.3","I")
 . S $P(RESULT,U,6)=NG
 . D DFNIQ^MAGQBPG1("","A scheduled RAID group purge has been initiated for the following",0,PLACE,"SCHEDULED_RAID_GROUP_PURGE")
 . D DFNIQ^MAGQBPG1("","VistA Imaging RAID group: "_$P($G(^MAG(2005.2,NG,0)),U,1),0,PLACE,"SCHEDULED_RAID_GROUP_PURGE")
 . D DFNIQ^MAGQBPG1("","Scheduled_RAID_group_purge",1,PLACE,"SCHEDULED_RAID_GROUP_PURGE")
 . Q
 Q
SVERI(WSIEN,PLACE,RESULT) ; Scheduled Verify
 Q:'$$GET1^DIQ(2006.1,PLACE,"62","I")  ; Check if Scheduled Verify is enabled
 Q:($$GET1^DIQ(2006.1,PLACE,"62.1","I")+1)>$$DT^XLFDT  ;Check if activated today
 I ($$UPPER^MAGQE4(WSOS)'["SERVER") Q:(WSOS'[".6.2.")  ;;Q:$$UPPER^MAGQE4(WSOS)'["SERVER"
 Q:'$$GET1^DIQ(2006.8,WSIEN,"4","I")  ;Check if task is assigned to this BP WS
 N T1,T2
 S T1="0000",T2=$$GET1^DIQ(2006.1,PLACE,"62.4","I"),T1=$E(T1,1,($L(T1)-$L(T2)))_T2
 I $$FMADD^XLFDT($$NOW^XLFDT,"","",20,"")>($$GET1^DIQ(2006.1,PLACE,"62.3","I")_"."_T1) D
 . S $P(RESULT,U,7)="VERIFY"_"~"_$$GET1^DIQ(2006.1,PLACE,"62.3","I")
 . Q
 Q
NAUTOW(PLACE,CWL,SPACE,SIZE,RESULT,NOTIFY,GROUP) ; CACHE BALANCING OFF
 ; No Auto RG Advance if Auto write is off
 S SPACE=+$P($G(^MAG(2005.2,CWL,0)),U,5),SIZE=+$P($G(^MAG(2005.2,CWL,0)),U,3)
 I (SIZE>0),((SPACE/SIZE)*100)>MIN D  Q  ;Here is where % Reserve is returned ...need to add by group and by RAID set also GB
 . S $P(RESULT,U)=1
 . I SIZE S $P(RESULT,U,5)=$P(((SPACE/SIZE)*100),".")_"."_$E($P(((SPACE/SIZE)*100),".",2),1,2)
 . E  S $P(RESULT,U,5)="0.00"
 . Q
 I SIZE>0 S $P(RESULT,U,5)=$P(((SPACE/SIZE)*100),".")_"."_$E($P(((SPACE/SIZE)*100),".",2),1,2)
 E  S $P(RESULT,U,5)="0.00"
 S $P(RESULT,U)=$S(SPACE>0:2,1:0)
 S $P(RESULT,U,2,3)=$P(^MAG(2005.2,$P(^MAG(2006.1,PLACE,0),U,3),0),U,1,2)
 I (($$GET1^DIQ(2006.1,PLACE,"61.1","I")+4)<$$DT^XLFDT) D  ;Check if activated within 4 days
 . I ($P($G(^MAG(2006.1,PLACE,"BPPURGE")),U)&(SPACE>0)&($$GET1^DIQ(2006.8,WSIEN,"3","I")="1")) D
 . . I ($$UPPER^MAGQE4(WSOS)'["SERVER") Q:(WSOS'[".6.2.")  ;;Q:$$UPPER^MAGQE4(WSOS)'["SERVER"
 . . S $P(RESULT,U,4)="AUTO_PURGE",$P(RESULT,U,6)=GROUP
 . . D DFNIQ^MAGQBPG1("","An automatic RAID Group purge has been initiated for the following",0,PLACE,"AUTO_RAID_GROUP_PURGE")
 . . D DFNIQ^MAGQBPG1("","VistA Imaging RAID group: "_$P($G(^MAG(2005.2,GROUP,0)),U,1),0,PLACE,"AUTO_RAID_GROUP_PURGE")
 . . D DFNIQ^MAGQBPG1("","Auto_RAID_group_purge",1,PLACE,"AUTO_RAID_GROUP_PURGE")
 . . Q
 . Q
 D:(NOTIFY!(SPACE>0)) TMESS(SPACE,"VistA Imaging RAID storage is Critically Low ",PLACE)
 Q
RGADV(PLACE,GROUP,RESULT) ; Scheduled Raid Group Advance
 N NODERG,NG,IEN,APP,SCH,T1,T2
 S NODERG=$G(^MAG(2006.1,PLACE,"RGADVANCE"))
 I $P(NODERG,U,1) D
 . Q:'(+$P(NODERG,U,4))
 . S T1="0000",T2=$P(NODERG,U,5),T1=$E(T1,1,($L(T1)-$L(T2)))_T2
 . I $$FMADD^XLFDT($$NOW^XLFDT,"","",20,"")>($P(NODERG,U,4)_"."_T1) D
 . . S NG=$$NXTGP(PLACE,GROUP) ;$$NXTGP returns null when no group with suitable space is found
 . . I ((NG)&(NG'=GROUP)) D  Q
 . . . S GROUP=NG,IEN=""
 . . . D FSP(MIN,.SPACE,.SIZE,.IEN,.TSPACE,.TSIZE,PLACE,GROUP,"")
 . . . S APP="Scheduled RAID Group Advance"
 . . . D SCWL(IEN,PLACE,GROUP,APP,DUZ)
 . . . S $P(RESULT,U,8)="Scheduled RGADVANCE"
 . . . D DFNIQ^MAGQBPG1("","A Scheduled RGADVANCE has completed",0,PLACE,APP)
 . . . D DFNIQ^MAGQBPG1("","The Active RAID Group is now set to: "_$P(^MAG(2005.2,GROUP,0),U,1),0,PLACE,APP)
 . . . D DFNIQ^MAGQBPG1("","Scheduled_RAID_Group_Advance",1,PLACE,APP)
 . . . S $P(^MAG(2006.1,PLACE,"RGADVANCE"),U,3)=$$DT^XLFDT ; DATE OF LAST RG ADVANCE #63.2
 . . . ;Allow singly scheduled RGAdvance,unschedule next if Frequency not set
 . . . S $P(^MAG(2006.1,PLACE,"RGADVANCE"),U,4)=$S(+$P(NODERG,U,2)>0:$$FMADD^XLFDT($$DT^XLFDT,$P(NODERG,U,2),"","",""),1:"")
 . . . Q
 . . ; Else NOTIFY & QUIT
 . . N MSG S MSG="The scheduled RAID Group Advance failed!"
 . . D DFNIQ^MAGQBPG1("",MSG,0,PLACE,"MAGQ FS CHNGE")
 . . S MSG="Scheduled_RAID_Group_Advance_failure!"
 . . D DFNIQ^MAGQBPG1("",MSG,1,PLACE,"MAGQ FS CHNGE") ; Send
 . . Q
 . Q
 Q
REPCWL(IEN,RG,RES,TSPACE,TSIZE) ;  Update Result with Current Write Group properties
 S $P(RES,U,2)="CWL: "_IEN_" RG: "_RG
 S $P(RES,U,3)=TSPACE
 S $P(RES,U,5)=$P(((TSPACE/TSIZE)*100),".")_"."_$E($P(((TSPACE/TSIZE)*100),".",2),1,2) ; %FREE SPACE
 Q
