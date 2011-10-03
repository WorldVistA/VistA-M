FBUCUTL ;ALBISC/TET - UNAUTHORIZED CLAIMS UTILITY ;12/7/2001
 ;;3.5;FEE BASIS;**38**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
CDTC(X1,X2) ;date comparison
 ;INPUT:  X1 = date
 ;        X2 = days to subtract or add
 ;OUTPUT: date less/plus x days
 N X D C^%DTC K %H Q $G(X)
 ;
DTC(X1,X2) ;days between two days
 ;INPUT:  X1 = date one
 ;        X2 = date two
 ;OUTPUT: difference between two days
 N X,%Y D ^%DTC K %Y Q $G(X)
 ;
VET(X) ;veteran name
 ;INPUT:  internal entry number of veteran
 ;OUTPUT: veteran name or unknown
 S X=$G(^DPT(+X,0)) Q $S($P(X,U)]"":$P(X,U),1:"UNKNOWN")
 ;
VEN(X) ;vendor name
 ;INPUT:  internal entry number of vendor
 ;OUTPUT: vendor name or unknown
 S X=$G(^FBAAV(+X,0)) Q $S($P(X,U)]"":$P(X,U),1:"UNKNOWN")
 ;
PROG(X) ;fee program name
 ;INPUT:  internal entry number of fee program
 ;OUTPUT: fee program name or unknown
 S X=$G(^FBAA(161.8,+X,0)) Q $S($P(X,U)]"":$P(X,U),1:"UNKNOWN")
 ;
PTR(FBGL,FBIEN) ;get .01 value of pointer
 ;INPUT:  FBGL = global root
 ;        FBIEN = internal entry number (DA) of pointed to file
 ;OUTPUT: zero node, or 'UNKNOWN'
 N FBVAL,NODE S NODE=FBGL_+FBIEN_",0)"
 S FBVAL=$G(@(NODE))
 Q $S(FBVAL]"":FBVAL,1:"UNKNOWN")
 ;
LOCK(FBGL,FBDA,GO) ;lock entry before editing
 ;INPUT:  FBGL = global root
 ;        FBDA = interal entry number of file
 ;        GO   = 1 to continue to try (enter/updates),
 ;               0 to notify user and quit on failure (edits)
 ;         (optional, if not set will be set to 0)
 ;OUTPUT: FBLOCK = 1 if successful; 0 if failed
 ;        incremental lock may be issued
 S FBLOCK=0,GO=$S('$D(GO):0,1:+GO) I $S('$D(FBGL):1,FBGL']"":1,'$D(FBDA):1,'+FBDA:1,1:0) Q
 S FBGL=FBGL_FBDA_")"
L L +@FBGL:2 S FBLOCK=$T I 'FBLOCK G:GO L W:'GO&('$D(ZTQUEUED)) !,"Another user is editing this entry."
 Q
DAYS(X,FB1725) ;number of days associated with a status
 ;INPUT:  X=ien of status in file 162.92
 ;        FB1725=true if days for 38 U.S.C. 1725 claim should be returned
 ;OUTPUT: 0 or number of days
 N FBY
 S FBY=$G(^FB(162.92,X,0))
 Q $S($G(FB1725):+$P(FBY,U,7),1:+$P(FBY,U,3))
 ;
DISAP(DA1,X) ;disapproval reason for disapproved dispositions
 ;INPUT:  DA1 = DA of top level of record (DA(1))
 ;        X   = ien of disapproval reason, 162.94
 ;OUTPUT: none - entry to disapproval multiple if not already there, disapproval reason is active and disposition reason is other than approved.
 N Y,DA,DIC
 S DIC(0)="Z",DIC="^FB583("_DA1_",""D"","
 I $P(^FB583(DA1,0),U,11)>1,$P(^FB(162.94,+X,0),U,2),'$D(^FB583(DA1,"D","B",+X)) S:'$D(^FB583(DA1,"D")) ^FB583(DA1,"D",0)="^162.715PA^^"  S DA(1)=DA1 K DD,DO D FILE^DICN
 Q
STATUS(X) ;get status internal entry number
 ;INPUT:  X = order number of status in file 162.92
 ;OUTPUT: ien of status in file 162.92 (status file)
 Q +$O(^FB(162.92,"AO",X,0))
 ;
ORDER(X) ;get order number of status
 ;INPUT:  X = ien of status in file 162.92, status file
 ;OUTPUT: order number of status
 S X=$G(^FB(162.92,+X,0)) Q +$P(X,U,4)
 ;
PAY(X,FBGL) ;determine if any payments have been made
 ;INPUT:  X= ien in file
 ;        FBGL= global root
 ;OUTPUT: 0 if no payments, 1 if payments
 S:$E(FBGL,1)="^" FBGL=$P(FBGL,"^",2) S FBGL=X_";"_FBGL
 Q $S(+$O(^FBAA(162.1,"AO",FBGL,0)):1,+$O(^FBAAC("AM",FBGL,0)):1,+$O(^FBAAI("E",FBGL,0)):1,1:0)
 ;
OVER(KEY) ;determine if ability to override
 ;INPUT:  KEY=security key
 ;OUTPUT: 0 if not holder of key, 1 if holder of key
 Q $S($D(^XUSEC(KEY,DUZ)):1,1:0)
 ;
UPOK(X) ;ok to update
 ;INPUT:  X= ien of 162.7
 ;OUTPUT: 0 if NOT OK to update, 1 if OK to update
 Q $S('$$PAY(X,"^FB583("):1,$$OVER("FBAASUPERVISOR"):1,1:0)
 ;
TIME(ED) ;determine if expiration date passed
 ;INPUT:  ED= expiration date
 ;OUTPUT: 0 if late, 1 if within timeframe
 Q $S('ED:1,DT>ED:0,1:1)
UNTIME(FBX) ;write untimely message - called from input templates
 ;INPUT:  FBX = disapproval reason
 W !?5,"Claim has been dispositioned to DISAPPROVED" W:+FBX !?8,"with disapproval reason of '",$P($$PTR("^FB(162.94,",FBX),U),"'.",!,*7
 Q
 ;
FBZ(X) ;get zero node on 162.7
 ;INPUT:  X = ien of 162.7, unauthorized claim file
 ;OUTPUT: zero node of 162.7
 I '+X Q 0
 S X=+X Q $G(^FB583(X,0))
 ;
FILE(FBGL,X,FBDI,FBDA1) ;add entry to file or subfile
 ;INPUT:  FBGL = global root
 ;        X    = value for .01 field
 ;        FBDI = 1 for dinum entry, 0 or null if not (optional)
 ;        FBDA1 = DA(1) value (optional), if doesn't exist will not set
 ;OUTPUT: entry is added to designated file
 ;        Y is returned  ien^value of .01 field^1
 N DA,DIC,DINUM,Y I $S(X']"":1,'$D(FBDI):1,+FBDI&(X'=+X):1,'$D(FBDA):1,1:0) Q ""
 I $D(FBDA1) S DA(1)=FBDA1
ADD S:+FBDI DINUM=X S DIC(0)="MZ",DIC=FBGL K DD,DO D FILE^DICN G:+Y'>0 ADD K DIC,DINUM
 Q $G(Y)
 ;
PEND(FBDA) ;check if any info pending for claim
 ;INPUT:  FBDA = ien of unauthorized claim in 162.7
 ;OUTPUT: 1 if info pending, otherwise 0
 Q $S(+$O(^FBAA(162.8,"ACD",FBDA,0)):1,1:0)
PAYST(FBDA,FBUCP) ; unauthorized claim payment status (released+)
 ;INPUT: FBDA = ien of unauthorized claim in 162.7
 ;       FBUCP = name of array (optional)
 ;RESULT: 1 (true) if at least one payment and all have been released
 ;        0 (false) if no payments or if some have not been released
 ;OUTPUT: if FBCUP contains the name of an array then that array will
 ;        be populated with payment information in the following format
 ;        array (claim ien) = result ^ number of payments
 ;        array (claim ien, payment file #, payment iens) = batch status
 N FBGL,FBRET,FBPDA,FBPDA1,FBPDA2,FBPDA3,FBBS,FBC
 S FBRET=1
 S FBC=0
 I $G(FBUCP)]"" K FBCUP(FBDA)
 S FBGL=FBDA_";FB583("
 ; pharmacy payments
 S FBPDA=0
 F  S FBPDA=$O(^FBAA(162.1,"AO",FBGL,FBPDA)) Q:'FBPDA  D
 .S FBPDA1=0
 .F  S FBPDA1=$O(^FBAA(162.1,"AO",FBGL,FBPDA,FBPDA1)) Q:'FBPDA1  D
 ..S FBIENS=FBPDA1_","_FBPDA_","
 ..S FBBS=$$GET1^DIQ(162.11,FBIENS,"13:11","I")
 ..I $G(FBUCP)]"" S @FBUCP@(FBDA,162.11,FBIENS)=FBBS
 ..I "^S^T^V^R^"'[(U_FBBS_U) S FBRET=0
 ..S FBC=FBC+1
 ; outpatient and ancillary payments
 S FBPDA=0
 F  S FBPDA=$O(^FBAAC("AM",FBGL,FBPDA)) Q:'FBPDA  D
 .S FBPDA1=0
 .F  S FBPDA1=$O(^FBAAC("AM",FBGL,FBPDA,FBPDA1)) Q:'FBPDA1  D
 ..S FBPDA2=0
 ..F  S FBPDA2=$O(^FBAAC("AM",FBGL,FBPDA,FBPDA1,FBPDA2)) Q:'FBPDA2  D
 ...S FBPDA3=0
 ...F  S FBPDA3=$O(^FBAAC("AM",FBGL,FBPDA,FBPDA1,FBPDA2,FBPDA3)) Q:'FBPDA3  D
 ....S FBIENS=FBPDA3_","_FBPDA2_","_FBPDA1_","_FBPDA_","
 ....S FBBS=$$GET1^DIQ(162.03,FBIENS,"7:11","I")
 ....I $G(FBUCP)]"" S @FBUCP@(FBDA,162.03,FBIENS)=FBBS
 ....I "^S^T^V^R^"'[(U_FBBS_U) S FBRET=0
 ....S FBC=FBC+1
 ; civil hospital payments
 S FBPDA=0
 F  S FBPDA=$O(^FBAAI("E",FBGL,FBPDA)) Q:'FBPDA  D
 .S FBIENS=FBPDA_","
 .S FBBS=$$GET1^DIQ(162.5,FBIENS,"20:11","I")
 .I $G(FBUCP)]"" S @FBUCP@(FBDA,162.5,FBIENS)=FBBS
 .I "^S^T^V^R^"'[(U_FBBS_U) S FBRET=0
 .S FBC=FBC+1
 I FBC=0 S FBRET=0
 I $G(FBUCP)]"" S @FBUCP@(FBDA)=FBRET_U_FBC
 Q FBRET
