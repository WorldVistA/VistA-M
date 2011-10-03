LRAPR1 ;AVAMC/KLL- ANAT RELEASE REPORTS CONT'D;07/26/04
 ;;5.2;LAB SERVICE;**317**;Sep 27, 1994
 ;
RELCHK ;Check to make sure all supp reports are released
 N LRFILE,LRIENS,LRIENS1,LRX,LRRLS,LRFDA,LRLKFL,LRDA,LRNOSP
 N LRMSG,LRSRFL,LRSRMD
 S DIC("B")=""
 I LRSS'="AU" D
 .S LRFILE=+$$GET1^DID(LRSF,1.2,"","SPECIFIER")
 .S LRIENS1=LRI_","_LRDFN_","
 .S LRX=0 F  S LRX=$O(^LR(LRDFN,LRSS,LRI,1.2,LRX)) Q:'LRX  D
 ..S LRIENS=LRX_","_LRIENS1
 ..S LRSRFL=$$GET1^DIQ(LRFILE,LRIENS,.02,"I")
 ..;LRSRMD- if flag is true, supp rpt has been modified, needs release
 ..S LRSRMD=$$GET1^DIQ(LRFILE,LRIENS,.03,"I")
 ..Q:LRSRFL&('LRSRMD)
 ..S DIC("B")=$$GET1^DIQ(LRFILE,LRIENS,.01,"I")
 I LRSS="AU" D
 .S LRFILE=63.324
 .S LRX=0 F  S LRX=$O(^LR(LRDFN,84,LRX)) Q:'LRX  D
 ..S LRIENS=LRX_","_LRDFN_","
 ..S LRSRFL=$$GET1^DIQ(LRFILE,LRIENS,.02,"I")
 ..;LRSRMD- if flag is true, supp rpt has been modified, needs release
 ..S LRSRMD=$$GET1^DIQ(LRFILE,LRIENS,.03,"I")
 ..Q:LRSRFL&('LRSRMD)
 ..S DIC("B")=$$GET1^DIQ(LRFILE,LRIENS,.01,"I")
 I $G(DIC("B")) S LRQT=1
 Q
CHKSUP ;Check for unreleased supp reports for E-sign switch OFF
 N LRQT,LRZ11,LRZ15,LRIENS3
 S (LRQT,LRZ11,LRZ15)=0
 D RELCHK
 I LRQT D  Q
 .W !!,"All supp repts must be released before main report can be released."
 I 'LRQT D
 .K LRFDA
 .D NOW^%DTC S LRNTIME=%
 .I 'LRAU D
 ..S LRZ15=$P($G(^LR(LRDFN,LRSS,LRI,0)),"^",15)
 ..S LRZ11=$P($G(^LR(LRDFN,LRSS,LRI,0)),"^",11)
 ..S LRIENS3=LRI_","_LRDFN_","
 ..S LRFDA(LRSF,LRIENS3,.11)=LRNTIME
 ..S LRFDA(LRSF,LRIENS3,.13)=DUZ
 ..I 'LRZ15 S LRFDA(LRSF,LRIENS3,.15)=LRZ11
 .I LRAU D
 ..S LRIENS3=LRDFN_","
 ..S LRFDA(63,LRIENS3,14.7)=LRNTIME
 ..S LRFDA(63,LRIENS3,14.8)=DUZ
 .;S LRSRMD=$$GET1^DIQ(LRFILE,LRIENS,.03,"I")
 .;If MODIFY SUPP REPORT flag is set, remove it at this point
 .;I LRSRMD S LRFDA(LRSF,LRIENS,.03)="@"
 .D FILE^DIE("","LRFDA")
 .W !!,"*** Main Report Has Been Released ***",!
 Q
UNRLSE ;Must unrelease at this point in order to successfully release
 ;  below
 K LRFDA
 N LRREL,LRIENS3
 D RELEASE^LRAPUTL(.LRREL,LRDFN,LRSS,$G(LRI))
 I 'LRAU D
 .S LRIENS3=LRI_","_LRDFN_","
 .I '$G(LRREL(3)) S LRFDA(LRSF,LRIENS3,.15)=LRREL(1)
 .S LRFDA(LRSF,LRIENS3,.11)="@"
 .S LRFDA(LRSF,LRIENS3,.13)="@"
 I LRAU D
 .S LRZ(2)="" ;Must null this in order to prevent unrelease
 .S LRFDA(63,LRDFN,14.7)="@"
 .S LRFDA(63,LRDFN,14.8)="@"
 D FILE^DIE("","LRFDA")
 Q
SUPCHK  ;Check Supplementary Reports
 N LRSR,LRSR1,LRSR2,LRFILE,LRIENS,LRIENS1
 S LRSR=0,LRSR1=1
 I LRSS'="AU" D
 .Q:'+$P($G(^LR(LRDFN,LRSS,LRI,1.2,0)),U,4)
 .S LRFILE=+$$GET1^DID(LRSF,1.2,"","SPECIFIER")
 .S LRIENS1=LRI_","_LRDFN_","
 .F  S LRSR=$O(^LR(LRDFN,LRSS,LRI,1.2,LRSR)) Q:LRSR'>0!('LRSR1)  D
 ..S LRIENS=LRSR_","_LRIENS1
 ..S LRSR1=+$$GET1^DIQ(LRFILE,LRIENS,.02,"I")
 ..I 'LRSR1 S LRSR2=$$GET1^DIQ(LRFILE,LRIENS,.01)
 I LRSS="AU" D
 .Q:'+$P($G(^LR(LRDFN,84,0)),U,4)
 .S LRFILE=63.324,LRIENS1=LRDFN_","
 .F  S LRSR=$O(^LR(LRDFN,84,LRSR)) Q:LRSR'>0!('LRSR1)  D
 ..S LRIENS=LRSR_","_LRIENS1
 ..S LRSR1=+$$GET1^DIQ(LRFILE,LRIENS,.02,"I")
 ..I 'LRSR1 S LRSR2=$$GET1^DIQ(LRFILE,LRIENS,.01)
 I 'LRSR1 D
 .S LRMSG="Supplementary report "_LRSR2_" has not been released.  "
 .S LRMSG=LRMSG_"Cannot release."
 .D EN^DDIOL(LRMSG,"","!!") K LRMSG
 .S LRQUIT=1
 Q
CKSIGNR ;Update supp report with Releaser ID and Date/time
 N LRIEN2,LRFLE,LRFL3
 S LRQT2=0
 I LRSS'="AU" D
 .S (A,B)=0 F  S A=$O(^LR(LRDFN,LRSS,LRI,1.2,LRDA,2,A)) Q:'A  D
 ..S B=A
 .I '$D(^LR(LRDFN,LRSS,LRI,1.2,LRDA,2,B,0)) S LRQT2=1 Q
 .S LRIEN2=B_","_LRDA_","_LRI_","_LRDFN_","
 .S LRFLE=$S(LRSS="SP":63.8172,LRSS="CY":63.9072,LRSS="EM":63.2072,1:"")
 .S LRFL3=$S(LRSS="SP":63.817,LRSS="CY":63.907,LRSS="EM":63.207,1:"")
 I LRSS="AU" D
 .S (A,B)=0 F  S A=$O(^LR(LRDFN,84,LRDA,2,A)) Q:'A  D
 ..S B=A
 .I '$D(^LR(LRDFN,84,LRDA,2,B,0)) S LRQT2=1 Q
 .S LRIEN2=B_","_LRDA_","_LRDFN_","
 .S LRFLE=$S(LRSS="AU":63.3242,1:"")
 .S LRFL3=$S(LRSS="AU":63.324,1:"")
 Q:LRQT2
 S LRFDA(LRFLE,LRIEN2,.03)=DUZ
 D NOW^%DTC
 S LRFDA(LRFLE,LRIEN2,.04)=%
 ;Must remove supp report modified flag once supp rpt is released
 S LRFDA(LRFL3,LRIENS,.03)="@"
 ;Set, but don't file unless unrelease required
 S LRFDA2(LRFLE,LRIEN2,.03)="@"
 S LRFDA2(LRFLE,LRIEN2,.04)="@"
 Q
