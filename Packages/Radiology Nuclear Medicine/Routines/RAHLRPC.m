RAHLRPC ;HIRMFO/BNT-Rad/NM HL7 Protocol calls ;05/21/99   14:50
 ;;5.0;Radiology/Nuclear Medicine;**12,25,54,71,82,81,84**;Mar 16, 1998;Build 13
 ; 03/16/2006 *71 Rem Call 124379 allow exam updates to create HL7 msg
 ;
 ;Integration Agreements
 ;----------------------
 ;$$FIND1^DIC(2051); GETS^DIQ(2056)
 ;all access to ^ORD(101 to maintain application specific protocols(872)
 ;read w/FileMan HL7 APPLICATION PARAMETER(10136)
 ; 
REG ; register exam
 N X,RA101Z,RAEID
 S RA101Z="RA REF" ; get all protocols beginning RA REG
 F  S RA101Z=$O(^ORD(101,"B",RA101Z)) Q:RA101Z'["RA REG"  D
 .S RAEID=$O(^ORD(101,"B",RA101Z,0))
 .I RAEID,'$L($P(^ORD(101,RAEID,0),"^",3)) D EN^RAHLR
 Q
CANCEL ; cancel exam
 N X,RA101Z,RAEID
 S RA101Z="RA CANCEK" ; get all protocols beginning RA CANCEL
 F  S RA101Z=$O(^ORD(101,"B",RA101Z)) Q:RA101Z'["RA CANCEL"  D
 .S RAEID=$O(^ORD(101,"B",RA101Z,0))
 .I RAEID,'$L($P(^ORD(101,RAEID,0),"^",3)) D EN^RAHLR
 Q
 ;
RPT ; report verified or released/not verified
 N X,RA101Z,RAEID,RASSS ; RASSS subcriber array to be passed to HLL for GENERATE^HLMA
 ;S X="^%ET",@^%ZOSF("TRAP")
 S RA101Z="RA RPS" ; get all protocols beginning RA RPT
 F  S RA101Z=$O(^ORD(101,"B",RA101Z)) Q:RA101Z'["RA RPT"  D
 .S RAEID=$O(^ORD(101,"B",RA101Z,0)) K RASSS  ; RA*5*81
 .S:$L($G(RANOSEND)) RAEID=$$GETEID(RAEID,RANOSEND,.RASSS) ;RA*5*81
 .I RAEID,'$L($P(^ORD(101,RAEID,0),"^",3)) D EN^RAHLRPT
 K RANOSEND
 Q
 ;
EXM ;Examined case; called from RAUTL1 and RASTED after a case has been edited.
 ;
 ;Called from RAUTL1 and RASTED after a case's status is upgraded
 ; and case's 30th piece is null
 ;
 ;If this new status is :
 ; at a status (or higher than a status) where
 ; GENERATE EXAMINED HL7 MSG = Y,
 ; then :
 ; 1. send an HL7 msg re this case having reached EXAMINED status
 ; 2. set subfile 70.03's HL7 EXAMINED MSG SENT  to  Y
 ;
 ; RALOWER = next lower status
 ; RANEWST = new status ien
 ; RAEXEDT = Indication of editing of: proc, proc mod, req phys, CPT mod, Tech comm...
 ; RAGENHL7 = Indication that sending ORU is due...
 ; RASSSX1(IENs) = Array of subscribers from 771, the message will be sent (SCIMGE)
 ; 
 N RAIMGTYI,RAIMGTYJ,RALOWER,RANEWST,RAEXMDUN,RAGENHL7,RASSSX1
 S RAIMGTYI=$P($G(^RADPT(RADFN,"DT",RADTI,0)),U,2),RAIMGTYJ=$P(^RA(79.2,RAIMGTYI,0),U),RANEWST=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),U,3)
 S:$P(^RA(72,RANEWST,0),U,8)="Y" RAGENHL7=1 ;this status has GEN HL7 marked Y
 ; look thru lower statuses for GEN HL7 marked Y
DOWN S RALOWER=$P($G(^RA(72,+RANEWST,0)),U,3)
 I '$G(RAGENHL7) F  S RALOWER=$O(^RA(72,"AA",RAIMGTYJ,RALOWER),-1) Q:RALOWER<1  S:$P(^RA(72,+$O(^RA(72,"AA",RAIMGTYJ,RALOWER,0)),0),U,8)="Y" RAGENHL7=1
 ;?? none of the lower status levels have GEN HL7 marked Y
 K:$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,30)="Y" RAGENHL7 ;already sent
 ;Q:'$G(RAEXEDT)&'$G(RAGENHL7)
 ; Business Rule: RA*5*84 sends an examined message to ScImage unconditionally
 I '$G(RAEXEDT),'$G(RAGENHL7) Q:'$O(^RA(79.7,0))  D  Q:'$O(RASSSX1(0))
 .N X,RASSS,RASSSL S X=0 F  S X=$O(^RA(79.7,X)) Q:'X  S:$P(^(X,0),U,2) RASSS(X)=""
 .D:$D(RASSS) GETSUB^RAHLRS1(.RASSS,.RASSSX1,.RASSSL)
1 N RAEXMDUN
 S RAEXMDUN=1
A1 N X,RA101Z,RAEID
 S RA101Z="RA EXAMINEC" ; get all protocols beginning RA EXAMINED
 F  S RA101Z=$O(^ORD(101,"B",RA101Z)) Q:RA101Z'["RA EXAMINED"  D
 .N RAGENHL7 S RAEID=$O(^ORD(101,"B",RA101Z,0))
 .I RAEID,'$L($P(^ORD(101,RAEID,0),"^",3)) D EN^RAHLR
 S:$G(RAGENHL7) $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,30)="Y"
 Q
 ;
GETEID(RAEID,RANOSEND,RASSS) ; RA*5*81   Return RAEID or 0 (zero)  = for future use.
 ; RAEID = IEN of regular Event driver
 ; RANOSEND Application name or IEN from 771 file..  don't send message to Subcr. with this application.
 ; RASSS Array of subcribers (IENs) associated with RANOSEND application
 ; 0 (zero) returned if No subscriber exist or all subscribers associated with RANOSEND application.
 S RAEID=$G(RAEID) Q:'RAEID!'$L($G(RANOSEND))!'$D(^ORD(101,+RAEID,0)) RAEID
 N RAXX,ERR,X1,Y1,YY,RAPL,RANEW,RAPIDS,RAIEDS,DIERR,RAERR
 S RAPL=$S(+RANOSEND:+RANOSEND,1:$$FIND1^DIC(771,"","X",RANOSEND,"","","RAERR"))
 Q:'RAPL!($D(RAERR)#2) RAEID
 D GETS^DIQ(101,RAEID_",","**","I","RAXX","ERR")
 Q:$D(ERR) RAEID ; Was not able get Event driver info... so just pass event driver...
 Q:'$D(RAXX(101.0775)) 0  ;No subcribers exist for Event driver
 S X1="",RANEW=0,Y1=0 F  S X1=$O(RAXX(101.0775,X1)) Q:'$L(X1)  D
 .S YY=$G(RAXX(101.0775,X1,.01,"I"))
 .I $P($G(^ORD(101,+YY,770)),U,2)=RAPL D  Q
 ..S Y1=Y1+1,RASSS("EXCLUDE SUBSCRIBER",Y1)=YY ;Y1= 1,2,3...
 .S RANEW=1
 Q:'RANEW 0  ;All subscribers are associated with application RANOSEND..  Don't send the message.
 Q RAEID
