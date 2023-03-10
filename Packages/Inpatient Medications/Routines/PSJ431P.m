PSJ431P ;HPS/DSK - PSJ*5.0*431 PATCH POST INSTALL ROUTINE ;Apr 20, 2022@17:40
 ;;5.0;INPATIENT MEDICATIONS;**431**;16 DEC 97;Build 5
 ;
 Q
 ;
 ;This routine checks for any unit dose or IV "zero level" subscripts
 ;which do not have the sub-file indicator field populated.
 ;
EN ;
 N PSJDUZ
 S ZTRTN="START^PSJ431P"
 S ZTDESC="PSJ*5.0*431 Post-Install Routine"
 S ZTIO="",ZTDTH=$H
 S PSJDUZ=DUZ
 S ZTSAVE("PSJDUZ")=""
 D ^%ZTLOAD
 W !!,"PSJ*5.0*431 Post-Install Routine has been tasked."
 W !,"TASK NUMBER: ",$G(ZTSK)
 W !!,"The installer will receive a MailMan message"
 W !,"when the search completes.",!
 Q
 ;
START ;
 N PSJPT,PSJCOUNT,PSJUDCT,PSJIVCT
 ;Kill in case install re-started for some reason.
 K ^XTMP("PSJ431 POST")
 S ^XTMP("PSJ431 POST",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^PSJ*5.0*431 Post-Install Routine"
 S ^XTMP("PSJ431 POST",1)="Any internal entry number (IEN) in the PHARMACY PATIENT (#55) file which was"
 S ^XTMP("PSJ431 POST",2)="missing a sub-file entry for Unit Dose (subscript 5) or IV (subscript ""IV"")"
 S ^XTMP("PSJ431 POST",3)="is listed as a subscript under ""UD"" or ""IV""."
 S (PSJPT,PSJCOUNT,PSJUDCT,PSJIVCT)=0
 F  S PSJPT=$O(^PS(55,PSJPT)) Q:'PSJPT  D
 . S PSJCOUNT=PSJCOUNT+1
 . ;It might not be necessary to pause so as to not consume
 . ;system resources. But pausing anyway to be on the safe side.
 . I PSJCOUNT#50000=0 H 15
 . I $D(^PS(55,PSJPT,5,0)),$P(^(0),"^",2)="" D
 . . S $P(^PS(55,PSJPT,5,0),"^",2)="55.06IA"
 . . S PSJUDCT=PSJUDCT+1
 . . S ^XTMP("PSJ431 POST","UD",PSJPT)=""
 . I $D(^PS(55,PSJPT,"IV",0)),$P(^(0),"^",2)="" D
 . . S $P(^PS(55,PSJPT,"IV",0),"^",2)=55.01
 . . S PSJIVCT=PSJIVCT+1
 . . S ^XTMP("PSJ431 POST","IV",PSJPT)=""
 ;Set total counts for Unit Dose (5) and IV entries which were corrected.
 S ^XTMP("PSJ431 POST","UD")=$S(PSJUDCT=0:"None",1:PSJUDCT)
 S ^XTMP("PSJ431 POST","IV")=$S(PSJIVCT=0:"None",1:PSJIVCT)
 D XTMP,MAIL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
XTMP ;Generate MailMan message and keep in ^XTMP for 60 days
 N PSJSUB
 S PSJSUB="PSJ431 MAILMAN MESSAGE"
 ;Kill in case install re-started for some reason.
 K ^XTMP(PSJSUB)
 S ^XTMP(PSJSUB,0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^PSJ*5.0*431 POST INSTALL"
 S ^XTMP(PSJSUB,1)=" "
 S ^XTMP(PSJSUB,2)="The post-install routine for PSJ*5.0*431 has completed."
 S ^XTMP(PSJSUB,3)=" "
 S ^XTMP(PSJSUB,4)="The number of instances in the PHARMACY PATIENT (#55) file which"
 S ^XTMP(PSJSUB,5)="were missing sub-file entries in the second piece of the zero"
 S ^XTMP(PSJSUB,6)="node for Unit Dose (subscript 5) and IV (subscript ""IV"") are:"
 S ^XTMP(PSJSUB,7)=" "
 S ^XTMP(PSJSUB,8)="Unit Dose: "_^XTMP("PSJ431 POST","UD")
 S ^XTMP(PSJSUB,9)="       IV: "_^XTMP("PSJ431 POST","IV")
 S ^XTMP(PSJSUB,10)=" "
 I PSJUDCT>0!(PSJIVCT>0) D
 . S ^XTMP(PSJSUB,11)="The appropriate sub-file entries have been filed if they were missing."
 . S ^XTMP(PSJSUB,12)="Details as to which instances were missing sub-file entries can be"
 . S ^XTMP(PSJSUB,13)="found in ^XTMP(""PSJ431 POST"" for the next 60 days."
 Q
 ;
MAIL ;
 N PSJMY,PSJMIN,PSJMSUB,PSJTEXT
 S PSJMY(PSJDUZ)=""
 S PSJMIN("FROM")="PSJ*5.0*431 Post-Install Routine PSJ431P"
 S PSJMSUB="PSJ*5.0*431 Post-Install Findings"
 S PSJTEXT="^XTMP(""PSJ431 MAILMAN MESSAGE"")"
 D SENDMSG^XMXAPI(PSJDUZ,PSJMSUB,PSJTEXT,.PSJMY,.PSJMIN,"","")
 Q
