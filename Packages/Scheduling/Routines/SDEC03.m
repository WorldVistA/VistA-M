SDEC03 ;ALB/SAT,LAB - VISTA SCHEDULING RPCS ;JAN 27,2022
 ;;5.3;Scheduling;**627,642,658,807**;Aug 13, 1993;Build 5
 ;
 Q
 ;
XR2S(SDECDA) ;build the ARSRC xref for the RESOURCE field of the SDEC APPOINTMENT file
 ;Format is ^SDEC(409.84,"ARSRC",RESOURCEID,STARTTIME,APPTID)
 Q:'$D(^SDEC(409.84,SDECDA,0))
 N SDECNOD,SDECAPPID,SDECRSID,SDECS
 S SDECNOD=^SDEC(409.84,SDECDA,0)
 S SDECAPPID=SDECDA
 S SDECRSID=$P(SDECNOD,U,7)
 Q:'+SDECAPPID>0
 Q:'+SDECRSID>0
 S SDECS=$P(SDECNOD,U)
 Q:'+SDECS
 S ^SDEC(409.84,"ARSRC",SDECRSID,SDECS,SDECAPPID)=""
 Q
 ;
XR2K(SDECA) ;kill the ARSRC xref for the RESOURCE field of the SDEC APPOINTMENT file
 Q:'$D(^SDEC(409.84,SDECA,0))
 N SDECNOD,SDECAPPID,SDECRSID,SDECS
 S SDECNOD=^SDEC(409.84,SDECA,0)
 S SDECAPPID=SDECA
 S SDECRSID=$P(SDECNOD,U,7)
 S SDECS=$P(SDECNOD,U)
 Q:'+SDECAPPID>0
 Q:'+SDECRSID>0
 Q:'+SDECS>0
 K ^SDEC(409.84,"ARSRC",SDECRSID,SDECS,SDECAPPID)
 Q
XR4S(SDECDA) ;build ARSCT xref for the STARTTIME field of the SDEC ACCESS BLOCK file
 ;Format is ^SDEC(409.821,"ARSCT",RESOURCEID,STARTTIME,DA)
 Q:'$D(^SDEC(409.821,SDECDA,0))
 N SDECNOD,SDECR,SDECS
 S SDECNOD=^SDEC(409.821,SDECDA,0)
 S SDECR=$P(SDECNOD,U)
 S SDECS=$P(SDECNOD,U,2)
 Q:'+SDECR>0
 Q:'+SDECS>0
 S ^SDEC(409.821,"ARSCT",SDECR,SDECS,SDECDA)=""
 Q
 ;
XR4K(SDECDA) ;kill ARSCT xref for the STARTTIME field of the SDEC ACCESS BLOCK file
 Q:'$D(^SDEC(409.821,SDECDA,0))
 N SDECNOD,SDECR,SDECS
 S SDECNOD=^SDEC(409.821,SDECDA,0)
 S SDECR=$P(SDECNOD,U)
 S SDECS=$P(SDECNOD,U,2)
 Q:'+SDECR>0
 Q:'+SDECS>0
 K ^SDEC(409.821,"ARSCT",SDECR,SDECS,SDECDA)
 Q
 ;
 ;support for single HOSPITAL LOCATION in SDEC RESOURCE
XRC1(SDDA) ;computed routine for INACTIVE field in SDEC RESOURCE
 ;NO = active; YES = inactive
 N SDNOD,SDTYPR,N21,N25,X,SDCHKDT
 S X=""
 S SDNOD=^SDEC(409.831,SDDA,0)
 S N21=$P(SDNOD,U,7)   ;inactive date/time
 S N25=$P(SDNOD,U,9)   ;reactive date/time
 S SDTYPR=$P(SDNOD,U,11)
 S SDCHKDT=$$NOW^XLFDT
 I $P(SDTYPR,";",2)="VA(200," I $$PC^SDEC45($P(SDTYPR,";",1)) S X="YES" D RESDG^SDEC01B(SDDA) Q X   ;do not include provider resource if NEW PERSON is not active
 I (N21="") S X="NO" Q X ;if no inactive date, then resource is not inactive
 I N21>SDCHKDT S X="NO" Q X  ;if inactive > today, then send NO inactive date is in the future
 ;we now now that inactive date is present and is less than or equal to today.
 I N25="" S X="YES" D RESDG^SDEC01B(SDDA) Q X  ;if there is no reactivation date, resource is inactive
 I N25>SDCHKDT S X="YES" D RESDG^SDEC01B(SDDA) Q X  ;the reactive date is in the future, resource is inactive
 I N25<N21 S X="YES" D RESDG^SDEC01B(SDDA) Q X  ;bad data, reactive date should always be cleared when inactivated
 ;We now know that reactive date is less than or equal to today and greater than or equal to the inactive date.
 S X="NO"
 Q X
 ;
XRC1M(SDDA,SDDA1) ;computed routine for INACTIVE field in SDEC RESOURCE; supports multiple HOSPITAL LOCATION in SDEC RESOURCE
 N SDNOD,N21,N22,N25,N26,X
 S X=""
 S SDNOD=^SDEC(409.831,SDDA,2,SDDA1,0)
 S N21=$P(SDNOD,U,7)
 S N22=$P(SDNOD,U,8)
 S N25=$P(SDNOD,U,9)
 S N26=$P(SDNOD,U,10)
 I (N21="")&(N22="") S X="NO" Q X
 I (N25="")!(N26="") S X="YES" Q X
 S X="NO"
 Q X
 ;
OT1(SDTYPE) ;output transform for RESOURCE TYPE in SDEC RESOURCE file 409.831
 ;INPUT:
 ; SDTYPE - internal format of RESOURCE TYPE
 ;RETURN:
 ;  SDRET - external text description of RESOURCE TYPE
 N SDRET
 I $P(SDTYPE,";",2)="SC(" S SDRET="CLINIC" Q SDRET
 I $P(SDTYPE,";",2)="VA(200," S SDRET="PROVIDER" Q SDRET
 I $P(SDTYPE,";",2)="SDEC(409.834," S SDRET="ADD'L RESOURCE" Q SDRET
 Q ""
 ;
N44S(SDCL,SDCLN) ;MUMPS xref for NAME of file 44 to update SDEC RESOURCE name if changed in 44
 N SDFDA,SDI,SDTYP
 ;find clinic resource in SDEC RESOURCE
 S SDI="" F  S SDI=$O(^SDEC(409.831,"ALOC",SDCL,SDI)) Q:SDI'>0  D
 .S SDTYP=$$GET1^DIQ(409.831,SDI_",",.012,"I")
 .Q:$P(SDTYP,";",2)'="SC("
 .S SDFDA(409.831,SDI_",",.01)=SDCLN
 .D UPDATE^DIE("","SDFDA")
 Q
 ;
 ;alb/sat 658
A44S(SDCL,SDCLA) ;MUMPS xref for ABBREVIATION of file 44 to update SDEC RESOURCE abbreviation if changed in 44
 N SDFDA,SDI,SDTYP
 ;find clinic resource in SDEC RESOURCE
 S SDI="" F  S SDI=$O(^SDEC(409.831,"ALOC",SDCL,SDI)) Q:SDI'>0  D
 .S SDTYP=$$GET1^DIQ(409.831,SDI_",",.012,"I")
 .Q:$P(SDTYP,";",2)'="SC("
 .S SDFDA(409.831,SDI_",",.011)=SDCLA
 .D UPDATE^DIE("","SDFDA")
 Q
