RGHLLOG ;CAIRO/DKM-LOG MESSAGE PROCESSING INFO ;09/04/98
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**1,3,11,13,18,19,25,45,52,57,59,62**;30 Apr 99;Build 3
 ;
 ;Reference to ^HLMA("C" supported by IA #3244
 ;=================================================================
 ; Log information about message processing and exceptions
 ; in CIRN HL7 Exception Log file.
 ;=================================================================
 ; Start time for run log
START(RGMSG,RGDC,RGPARAM) ;
 ;This entry point starts the log process in the CIRN HL7 EXCEPTION LOG
 ;file (#991.1), if the (#6) MINIMAL EXCEPTION LOGGING? field in
 ;File #990.8 is set to 0.
 ; Input: Required
 ;   RGMSG - IEN of message entry in File #773, usually HLMTIEN
 ;        Optional
 ;   RGDC - Event Class, associated with an entry in File #
 ;   RGPARAM - reprocessing routine
 S U="^"
 K RGLOG
 S RGLOG(3)=$G(RGMSG),RGLOG(5)=$G(RGDC),RGLOG(4)=$G(RGPARAM),RGLOG(1)=$$NOW^XLFDT
 I '$P(^RGSITE("COR",1,0),U,8) S RGLOG=$$CREATE
 Q
 ; Create a log entry
CREATE() Q:$G(RGLOG) RGLOG
 L +^RGHL7(991.1,0):10
 S RGLOG=$O(^RGHL7(991.1,$C(32)),-1)+1
 S:$G(RGLOG(1))="" RGLOG(1)=$$NOW^XLFDT
 S RGLOG(3)=$S($G(RGLOG(3))=0:0,$G(HL("MID"))="":"",1:$$IEN773($G(HL("MID"))))
 S (DA,X)=RGLOG,DIC="^RGHL7(991.1,",DIC(0)="L",DLAYGO=991.1,DIC("DR")="1///"_$G(RGLOG(1))_";3////"_$G(RGLOG(3))_";5///"_$G(RGLOG(5))_";4////"_$G(RGLOG(4)) K DD,DO D FILE^DICN K DIC,DA,X,DLAYGO
 L -^RGHL7(991.1,0)
 Q RGLOG
 ; Log time run completed
STOP(RGQUIT) ;
 ;This entry point completes the logging process
 ; Input: required
 ;    RGQUIT - 0 for success and 1 for failure
 ;
 Q:'$G(RGLOG)
 L +^RGHL7(991.1,RGLOG):10
 S DIE="^RGHL7(991.1,",DR="1.5///NOW;1.6///^S X=$G(RGQUIT)",DA=RGLOG D ^DIE K DIE,DA,DR
 L -^RGHL7(991.1,RGLOG)
 K RGLOG,RGQUIT,X,Y,DIC,DIE
 Q
 ; Log unclassified exception (old entry point)
ERR(RGERR,RGSEV) ;
 D EXC(18,RGERR)
 S RGQUIT=$G(RGQUIT)!$G(RGSEV)
 Q
 ; Log an exception
EXC(RGEXC,RGERR,RGDFN,MSGID,STATNUM) ;
 ;This entry point logs exceptions in the CIRN HL7 EXCEPTION LOG
 ;file (#991.1)
 ; Input: Required
 ;   RGEXC - Exception type in File #991.11
 ;   RGERR - Supplemental text
 ;        Optional
 ;   RGDFN - IEN in the PATIENT file (#2)
 ;   MSGID - message id of the HL7 message where the exception was encountered (optional)
 ;   STATNUM - station # of site that encountered the error (optional) - if not defined then the local site is assumed, using $$SITE^VASITE
 ;
 I (RGEXC=215)!(RGEXC=216)!(RGEXC=217) Q  ;**52 until MPIFBT3 call eliminates these exception types
 ;I (RGEXC=215)!(RGEXC=216)!(RGEXC=217) Q  ;**52 until MPIFBT3 call eliminates these exception types;**57 done in MPIF*1*52
 ; **62 (elz) MVI_4551, don't log 234 anymore
 I RGEXC=234 Q
 ;I RGEXC=234 N ACTPVR S ACTPVR=1 D  I ACTPVR=0 Q  ;**59 MVI_778 Do not log duplicate PVR (234) exception for patient if active one in CIRN HL7 EXCEPTION LOG (#991.1) file.
 ;.N PVRIEN,PVRIEN2 S PVRIEN=0
 ;.;Examine PVR (234) exception type, for patient - RGDFN
 ;.F  S PVRIEN=$O(^RGHL7(991.1,"ADFN",234,RGDFN,PVRIEN)) Q:'PVRIEN  Q:ACTPVR=0  D
 ;..S PVRIEN2=0
 ;..F  S PVRIEN2=$O(^RGHL7(991.1,"ADFN",234,RGDFN,PVRIEN,PVRIEN2)) Q:'PVRIEN2  Q:ACTPVR=0  D
 ;...;Is there an active exception in CIRN HL7 EXCEPTION LOG (#991.1) file?
 ;...S ACTPVR=$P($G(^RGHL7(991.1,PVRIEN,1,PVRIEN2,0)),"^",5) I ACTPVR=0 Q
 ;
 I $L($G(HL("MID"))) Q:$$INVEXC(HL("MID"))  ; is the exception valid?
 N RGI,RGZ
 S U="^"
 S:RGEXC[U RGERR=$P(RGEXC,U,2,999),RGEXC=+RGEXC
 S:RGEXC'=+RGEXC RGERR=RGEXC,RGEXC=18
 S:'$D(^RGHL7(991.11,RGEXC)) RGEXC=18
 L +^RGHL7(991.11,RGEXC):10
 S RGZ=$G(^RGHL7(991.11,RGEXC,0))
 S:$L(RGZ) $P(^RGHL7(991.11,RGEXC,0),U,5)=$P(RGZ,U,5)+1
 S:$P(RGZ,U,2)>1 RGQUIT=1
 L -^RGHL7(991.11,RGEXC)
 S RGLOG=$$CREATE
 L +^RGHL7(991.1,RGLOG):10
 S RGI=$O(^RGHL7(991.1,RGLOG,1,$C(32)),-1)+1
 S RGERR=$E($G(RGERR),1,250)
 S DIC="^RGHL7(991.1,"_RGLOG_",1,"
 S X=RGI,DA(1)=RGLOG,DIC(0)="FL",DLAYGO=991.12,DIC("P")=$P(^DD(991.1,2,0),"^",2)
 D ^DIC
 S DIE=DIC
 K DIC,DA,DR,DLAYGO
 S STAT=0
 S DIC="3.8",DIC(0)="Z",X="MPIF EXCEPTIONS" D ^DIC K DIC
 S RGMG=$P($G(Y),"^",1)
 I $P(^RGHL7(991.11,RGEXC,0),U,4)=RGMG S STAT=1
 S DA(1)=RGLOG,DA=RGI,DR="2///"_$G(RGEXC)_";3///"_$S($G(RGDFN):"`"_RGDFN,1:"")_";6///"_$G(STAT)_";10///"_$G(RGERR)
 D ^DIE K DIE,DA,DR
 L -^RGHL7(991.1,RGLOG)
 S RGI=$P(RGZ,U,3),RGZ=$P(RGZ,U,4)
 ;
 ;If the action type is for the MPI Exception Handler, send exception to the handler and quit
 I (RGI=3) D SENDMPI^RGHLLOG1($G(RGEXC),$G(RGERR),$G(RGDFN),$G(MSGID),$G(STATNUM)) Q
 ;
 Q:'RGI!'RGZ
 ;quit and don't send messages for exception types that are now being
 ;handled through the MPI/PD Exception Handling option.
 Q:RGEXC=234  ;**52 MPIC_772 remove 215, 216 & 217;**57 MPIC_1893 remove 218
 S DIC="^XMB(3.8,",DIC(0)="NZ",X="`"_RGZ D ^DIC K DIC Q:+Y<1  S RGZ=$P(Y,U,2) K Y
 Q:RGZ=""!$P($G(^RGSITE("COR",1,0)),U,7)
 S RGERR=$$SHORT(RGEXC,RGERR),RGZ="G."_RGZ
 I RGI=2 D ALERT^RGRSUTL2(RGERR,RGZ) Q
 D MAIL^RGRSUTL2(RGERR,RGZ,"MPI/PD Exception: "_$$SHORT(RGEXC),"MPI/PD exception notification")
 Q
 ;
INVEXC(RGMID) ; determine if this exception needs to be sent to MPI/PD
 ; personnel via FORUM. Return 1 to avoid messaging to FORUM, else 0.
 ; IA#:3244 is applied in this functionality
 N RGFLG,RGIEN S RGFLG=1
 S RGIEN=$$IEN773(RGMID) Q:'RGIEN RGFLG
 S RGIEN("SND")=$$GET1^DIQ(773,RGIEN_",",13)
 S RGIEN("REC")=$$GET1^DIQ(773,RGIEN_",",14)
 ; check the sending application (fld:13, 0;11) & the receiving
 ; application (fld:14, 0;12) to see if they are related to the MPI/PD
 ; project.
 I RGIEN("SND")]""!(RGIEN("REC")]"") D  Q RGFLG
 .S RGFLG=$$APP(RGIEN("SND")) Q:'RGFLG
 .S RGFLG=$$APP(RGIEN("REC"))
 .Q
 ; Only if the sending/receiving applications cannot be determined from
 ; the data in their respective fields, do I check the MSH multiple for
 ; the MSH segment. I identify the sending/receiving application from
 ; this segment. 
 E  D
 .N RG,RG1,RGMSH,RGFS
 .D GETS^DIQ(773,RGIEN_",",200,,"RGMSH") ;check MSH mult for snd/rec app
 .Q:'($D(RGMSH)\10)  ; no data in "MSH" multiple for file 773
 .S RGIEN=RGIEN_",",RG="RGMSH(773,"""_RGIEN_""","_200_")"
 .S RG1=0 F  S RG1=$O(@RG@(RG1)) Q:RG1'>0  D  Q:$E($G(@RG@(RG1)),1,3)="MSH"
 ..I $E($G(@RG@(RG1)),1,3)="MSH" D
 ...S RG(0)=$G(@RG@(RG1)),RGFS=$E(RG(0),4)
 ...S:$P(RG(0),RGFS,3)]"" RGFLG=$$APP($P(RG(0),RGFS,3)) Q:'RGFLG
 ...S:$P(RG(0),RGFS,5)]"" RGFLG=$$APP($P(RG(0),RGFS,5))
 ...Q
 ..Q
 .Q
 Q RGFLG
APP(X) ; check if the sending/receiving application is relevant to the
 ; MPI/PD team.  Returns 1 if a non-relevant namespace, else 0
 I $E(X,1,2)="RG"!($E(X,1,2)="VA")!($E(X,1,3)="MPI") Q 0
 Q 1
 ;
IEN773(RGMID) ; find the ien of the record in the HL7 MESSAGE ADMINISTRATION
 ; (#773) file based on the Message ID.  Input: Message ID
 ; Output: null, no record in 773, else 773 record ien.  IA#: 3244
 Q:$G(RGMID)="" ""
 Q $O(^HLMA("C",RGMID,0))
 ;
SHORT(RGEXC,RGTXT) ;
 ; Retrieve short text description of exception
 Q $G(^RGHL7(991.11,+RGEXC,10))_$S($G(RGTXT)="":"",1:": "_RGTXT)
 ;
