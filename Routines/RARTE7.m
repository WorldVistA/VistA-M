RARTE7 ;HISC/SM continuation - Delete a Report, Outside Rpt misc;10/10/08 16:05
 ;;5.0;Radiology/Nuclear Medicine;**56,95,97,103**;Mar 16, 1998;Build 2
 ;Supported IA #2053 NOW^XLFDT, FILE^DIE, UPDATE^DIE
 ;Supported IA #2052 GET1^DID
 ;Supported IA #2055 ROOT^DILFD
 ;
 ;04/06/2010 BP/KAM RA*5*103 Remedy Ticket 324541 Outside Reports does
 ;                           not generate Imaging Results CPRS Alert
 Q
MARKDEL ; set field 5 to "X" to mark rpt as deleted
 ; also update activity log, send report deletion bulletin, store then delete
 ; associated DX, Staff, Resident data
 N DA,DIK,RA1,RA2,RAA,RAFDA,RAIEN2,RAIENDX,RAIENL,RACLOAK
 N RAMEMARR,RAMSG,RAOUT,RAPRTSET,RASAVE,RAX,RA7003
 N RAF1,RAF2,RAF3,RAIENS
 ;
 ;PART 1 - mark report as deleted
 ;
 S RASAVE=$P(^RARPT(RAIEN,0),U,5) ;save current rpt status
 S RAFDA(74,RAIEN_",",5)="X" ;change rpt status
 D FILE^DIE("","RAFDA")
 K RAFDA
 ;
 ;PART 2 - add new entry to ACTIVITY LOG and store primary data
 ;
 S RA7003=^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)
 S RAIENL="+1,"_RAIEN_","
 S RAFDA(74.01,RAIENL,.01)=+$E($$NOW^XLFDT(),1,12)
 S RAFDA(74.01,RAIENL,2)="X"
 S RAFDA(74.01,RAIENL,3)=$G(DUZ)
 S RAFDA(74.01,RAIENL,4)=RASAVE ;store before-delete rpt status
 S RAFDA(74.01,RAIENL,5)=$P(RA7003,U,13) ; store Prim DX code
 S RAFDA(74.01,RAIENL,7)=$P(RA7003,U,15) ; store Prim Staff
 S RAFDA(74.01,RAIENL,9)=$P(RA7003,U,12) ; store Prim Resident
 D UPDATE^DIE(,"RAFDA","RAOUT","RAMSG")
 W:$D(RAMSG("DIERR")) !!,"Could not update deleted Report's Activity Log."
 K RAFDA
 ;
 ; store Secondary DXs/Staff/Residents under this ACTIVITY LOG
 ; if printset, no need to store each case's sec DX, they should be same
 Q:'RAOUT(1)  ;no record set in 74.01
 S RAIEN2=RAOUT(1)
 ;
 ;PART 3 - send report deletion bulletin
 ;
 D CLOAK^RABUL3 ; requires RAIEN and RAIEN2
 ;
 ;PART 4 - store secondary DX, Staff, Resident data
 ;
 ;don't need separate logic for printset for storing identical data
 F RAFLD=5,7,9 D SET7401(RAFLD)
 ;
 ;PART 5 - remove Prim. and Sec.  DX, Staff, Resident from case record
 ;
 D EN2^RAUTL20(.RAMEMARR) ; is case part of a printset?
 G:RAPRTSET PSET
 ;
 ; single case
 ;
 ; delete primaries
 S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",13)="@" ;Prim. DX
 S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",15)="@" ;Prim. Staff
 S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",12)="@" ;Prim. Resident
 D FILE^DIE("","RAFDA")
 K RAFDA
 ;
 ; delete secondaries
 F RASUB=70.14,70.11,70.09 D KILSEC(RASUB,RACNI)
 Q
 ;
 ; cases from printset
 ;
PSET ;delete primary and secondary data
 S RA1=0
 F  S RA1=$O(RAMEMARR(RA1)) Q:RA1=""  D
 .; delete primary from 70.03
 .S RAFDA(70.03,RA1_","_RADTI_","_RADFN_",",13)="@" ;Prim. DX
 .S RAFDA(70.03,RA1_","_RADTI_","_RADFN_",",15)="@" ;Prim. Staff
 .S RAFDA(70.03,RA1_","_RADTI_","_RADFN_",",12)="@" ;Prim. Resident
 .D FILE^DIE("","RAFDA")
 .K RAFDA
 .F RASUB=70.14,70.11,70.09 D KILSEC(RASUB,RA1)
 Q
KILSEC(RAF2,RAC1) ;kill secondary data
 ;RAF2 subfile number from file 70's secondaries
 ;RAC1 ien for subfile 70.03
 N RAA,RAROOT
 K DA,DIK
 S RAIENS=1_","_RAC1_","_RADTI_","_RADFN_","
 S RAROOT=$$ROOT^DILFD(RAF2,RAIENS,1) ; closed root
 M RAA=@RAROOT
 Q:$O(RAA(0))'>0  ;no secondaries
 D DA^DILF(RAIENS,.DA) ;get the DA array
 S DIK=$$ROOT^DILFD(RAF2,RAIENS)
 S RA2=0
 F  S RA2=$O(RAA(RA2)) Q:'RA2  S DA=RA2 D ^DIK
 K DIK
 Q
SET7401(X) ; use this for DX, Staff, Resident secondaries 
 ; set activity log's subfiles to store any secondaries
 K RAFDA,RAMSG,RAA
 ; X is the Field number from subfile 74.01:
 ; 5 = BEFORE DELETION PRIM. DX CODE
 ; 7 = BEFORE DELETION PRIM. STAFF
 ; 9 = BEFORE DELETION PRIM. RESIDENT
 ;
 ; RAF1 = subfile number from file 74's activity log
 ; RAF2 = subfile number from file 70's secondaries
 ; RAF3 = subfile number pointed to from file 70's secondaries
 ;
 S RAF1=$S(X=5:74.16,X=7:74.18,X=9:74.19,1:"") Q:RAF1=""
 S RAF2=$S(X=5:70.14,X=7:70.11,X=9:70.09,1:"") Q:RAF2=""
 S RAIENS=1_","_RACNI_","_RADTI_","_RADFN_","
 S RAROOT=$$ROOT^DILFD(RAF2,RAIENS,1) ; closed root, file 70's secondaries
 M RAA=@RAROOT
 Q:$O(RAA(0))'>0  ; no secondaries
 ;
 S RAF3=$$GET1^DID(RAF2,.01,"","POINTER")
 ; extract file number from RAF3
 S RAF3=$TR(RAF3,$TR(RAF3,"0123456789."))
 ;
 ; store Secondary DXs
 S RA1=0
 S RAIENDX="+2,"_RAIEN2_","_RAIEN_","
 F  S RA1=$O(RAA(RA1)) Q:'RA1  S RAX=$G(RAA(RA1,0)) D:RAX
 .S RAFDA(RAF1,RAIENDX,.01)=RAX
 .D UPDATE^DIE(,"RAFDA",,"RAMSG")
 .W:$D(RAMSG("DIERR")) !!,"Could not store ",$$GET1^DID(RAF2,.01,"","LABEL"),"'s value: ",$$GET1^DIQ(RAF3,RAX,.01)
 .K RAFDA,RAMSG
 .Q
 Q
ANYDX(ARRAY) ; called from RARTE5
 ; input ARRAY name to store all DXs for this case
 ; output:
 ;  =1 if one or more diag codes
 ;  =0 if no diag code
 ;  ARRAY() stores diag codes as merged from case
 Q:'$D(RADFN)!('$D(RADTI))!('$D(RACNI))
 K ARRAY
 M ARRAY=^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX") ;Sec Diags
 S ARRAY(9999,0)=$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,13) ;Prim Diag
 I $O(ARRAY(0)) Q 1
 Q 0
 ;
ALERT ; for Outside Report, ck if new/changed diags require alert
 ; this is called from RARTE5 each time an outside report is edited
 Q:'$D(RADFN)!('$D(RADTI))!('$D(RACNI))
 N RASAVE,RAY3,X
 ; set RASAVE() for OENOTE^RAUTL00
 S RASAVE("RADFN")=RADFN,RASAVE("RADTI")=RADTI,RASAVE("RACNI")=RACNI
 ;
 N I
 Q:(RANY1=0)&(RANY2=0)  ;no diags before and after edit
 S I=0
 ; loop RAA2 
 F  S I=$O(RAA2(I)) Q:'I  K:RAA2(I,0)=$G(RAA1(I,0)) RAA2(I,0)
 ;04/06/2010 BP/KAM RA*5*103 Rem Tkt 324541 Commented out next line
 ;Q:'$O(RAA2(0))
 K RAAB
 S I=0 F  S I=$O(RAA2(I)) Q:'I  D
 .I $D(^RA(78.3,+RAA2(I,0),0)),($P(^(0),U,4)="y") S RAAB=1
 .Q
 ; invoke notification for either condition:
 ; (1) new EF report is made --> non-critical imaging alert
 ; (2) old/new EF report w abnormal DX --> abnormal alert
 ; either of the above alert may be from an amended report or not
 I $G(RAAB)!RAFIRST D
 .S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 .S X=RAY3 ; X is input to OENOTE
 .D OENOTE^RAUTL00
 Q
