IBBAADD ;OAK/ELZ - PFSS FILE INDEXING ;15-MAR-2005
 ;;2.0;INTEGRATED BILLING;**286**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SAC(DA) ;set AC xref on file #375
 N X1,X2,X3
 S X2=+$P($G(^IBBAA(375,DA,"PV1")),U,3)
 Q:'X2
 S X1=$P(^IBBAA(375,DA,0),U,3)
 S X3=$P(^IBBAA(375,DA,"PV1"),U,44)
 I X3'="" S ^IBBAA(375,"AC",X1,X3,X2,DA)=""
 Q
 ;
KAC144(DA) ;kill AC xref on file #375
 N X1,X2,X3
 S X2=+$P($G(^IBBAA(375,DA,"PV1")),U,3)
 Q:'X2
 S X1=$P(^IBBAA(375,DA,0),U,3)
 S X3=$P(^IBBAA(375,DA,"PV1"),U,44)
 I X3'="" K ^IBBAA(375,"AC",X1,X3,X2,DA)
 Q
 ;
SAF(DA) ;set AF xref on file #375
 N X1,X2,X3
 S X2=$G(^IBBAA(375,DA,16))
 Q:X2=""
 S X1=$P(^IBBAA(375,DA,0),U,3)
 S X3=$P($G(^IBBAA(375,DA,"PV1")),U,44)
 I X3'="" S ^IBBAA(375,"AF",X1,X3,X2,DA)=""
 Q
 ;
KAF(DA) ;kill AF xref on file #375
 N X1,X2,X3
 S X2=$G(^IBBAA(375,DA,16))
 Q:X2=""
 S X1=$P(^IBBAA(375,DA,0),U,3)
 S X3=$P($G(^IBBAA(375,DA,"PV1")),U,44)
 I X3'="" K ^IBBAA(375,"AC",X1,X3,X2,DA)
 Q
 ;
SAOX(DA,DFN,IBBTEST) ;set AX or OX xref on file #373
 N X,X1,X2,X3,X4
 ;do not set if test patient
 I $$TESTPAT^VADPT($G(DFN)) S IBBTEST=1 Q
 S X=$G(^IBBAD(373,DA,0))
 S X1=$P(X,U,3),X2=$P(X,U,4),X3=$P(X,U,6),X4=$P(X,U,11)
 I X4="" D
 .I X3=419 S ^IBBAD(373,"AX",X1,X2,DA)=""
 .E  S ^IBBAD(373,"OX",X1,X2,DA)=""
 Q
 ;
KAOX(DA) ;kill AX or OX xref on file #373
 N X,X1,X2,X3,X4
 S X=$G(^IBBAD(373,DA,0))
 S X1=$P(X,U,3),X2=$P(X,U,4),X3=$P(X,U,6),X4=$P(X,U,11)
 I X4 D
 .I X3=419 K ^IBBAD(373,"AX",X1,X2,DA)
 .E  K ^IBBAD(373,"OX",X1,X2,DA)
 Q
 ;
SAA(DA) ;set AA xref on file #374
 N XX,X1,X2,X3
 S XX=^IBBAS(374,DA(1),1,DA,0),X1=$P(XX,U,1),X2=$P(XX,U,2),X3=$P(XX,U,3)
 I X3=1 S ^IBBAS(374,"AA",X1,X2,DA(1),DA)=""
 Q
