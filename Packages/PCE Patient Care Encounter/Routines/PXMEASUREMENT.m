PXMEASUREMENT ;SLC/PKR - Routines for measurements. ;04/28/2022
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**217**;Aug 12, 1996;Build 134
 ;
 ;==========
FIXCMEAS ;Fix V EXAM,V HEALTH FACTORS, and V PATIENT ED entries that have a MAGNITUDE
 ;of 0 and no UCUM CODE.
 N IEN,MAG,NEDU,NEXAM,NHF,NODE,SUBJECT,TEMP220,UCUM
 S (NEDU,NEXAM,NHF)=0
 S IEN=0
 F  S IEN=+$O(^AUPNVHF(IEN)) Q:IEN=0  D
 . S TEMP220=$G(^AUPNVHF(IEN,220))
 . S MAG=$P(TEMP220,U,1),UCUM=$P(TEMP220,U,2)
 . I ((MAG=0)&(UCUM=""))!((MAG="")&(UCUM'="")) D
 .. S NHF=NHF+1
 .. S ^AUPNVHF(IEN,220)=""
 ;
 S IEN=0
 F  S IEN=+$O(^AUPNVPED(IEN)) Q:IEN=0  D
 . S TEMP220=$G(^AUPNVPED(IEN,220))
 . S MAG=$P(TEMP220,U,1),UCUM=$P(TEMP220,U,2)
 . I ((MAG=0)&(UCUM=""))!((MAG="")&(UCUM'="")) D
 .. S NEDU=NEDU+1
 .. S ^AUPNVPED(IEN,220)=""
 ;
 S IEN=0
 F  S IEN=+$O(^AUPNVXAM(IEN)) Q:IEN=0  D
 . S TEMP220=$G(^AUPNVXAM(IEN,220))
 . S MAG=$P(TEMP220,U,1),UCUM=$P(TEMP220,U,2)
 . I ((MAG=0)&(UCUM=""))!((MAG="")&(UCUM'="")) D
 .. S NEXAM=NEXAM+1
 .. S ^AUPNVXAM(IEN,220)=""
 ;
 S NODE="PXXMZ"
 S SUBJECT="Corrupted Measurement Repair"
 K ^TMP(NODE,$J)
 S ^TMP(NODE,$J,1,0)=NHF_" V HEALTH FACTOR entries were repaired."
 S ^TMP(NODE,$J,2,0)=NEDU_" V PATIENT ED entries were repaired."
 S ^TMP(NODE,$J,3,0)=NEXAM_" V EXAM entries were repaired."
 S ^TMP(NODE,$J,4,0)="No further action is needed."
 D SEND^PXMSG(NODE,SUBJECT)
 K ^TMP(NODE,$J)
 Q
 ;
 ;==========
MAGFORMAT(MAG) ;Format magnitude.
 ;Remove unneeded starting +.
 I $E(MAG,1)="+" S MAG=$E(MAG,2,25)
 ;If the magnitude is a fraction, make sure it is preceded by 0.
 I (MAG*MAG)<1 D
 . I $E(MAG,1)="." S MAG=0_MAG Q
 . I $E(MAG,1,2)="-." S MAG="-0"_$E(MAG,2,25) Q
 . I $E(MAG,1,2)="+." S MAG=0_$E(MAG,2,25) Q
 . I MAG="-0" S MAG=0
 Q MAG
 ;
 ;==========
MAXDECEX(MAG,MAXDEC) ;^DIR does not recognize trailing 0s when checking the
 ;number of decimals. Use this as a screen to recognize
 ;trailing 0s when checking the number of decimals.
 N FRAC,LENFRAC
 S FRAC=$P(MAG,".",2)
 S LENFRAC=$L(FRAC)
 Q $S(LENFRAC>MAXDEC:1,1:0)
 ;
 ;==========
TFIXCMEAS(START) ;Run FIXCMEAS^PXMEASUREMENT as a TaskMan job.
 S ZTRTN="FIXCMEAS^PXMEASUREMENT"
 S ZTDESC="Corrupted V-File measurement repair."
 S ZTIO=""
 S ZTDTH=$G(START)
 D ^%ZTLOAD
 D BMES^XPDUTL("TaskMan job: ZTSK="_ZTSK)
 Q
 ;
 ;==========
UCDHTEXT ;UCUM DISPLAY executable help text.
 ;;This field specifies how the units are presented when a measurement is 
 ;;displayed in CPRS, Clinical Reminders, and Health Summary. When the value
 ;;is C, the UCUM Code is displayed when the value is D, the Description is
 ;;displayed. When the value is N, no units are displayed.
 ;;**End Text**
 Q
 ;
 ;==========
UCDXHELP(FILENUM,DA) ;UCUM DISPLAY executable help.
 N DONE,DIR0,IND,TEXT,UCUMDATA,UCUMIEN
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT(IND)=$P($T(UCDHTEXT+IND),";",3)
 . I TEXT(IND)="**End Text**" S TEXT(IND)=" ",DONE=1 Q
 S IND=IND-1
 ;
 ;Get the Description and UCUM Code.
 S UCUMIEN=$$GET^DDSVAL(FILENUM,DA,223)
 I UCUMIEN="" D
 . S IND=IND+1,TEXT(IND)="No units have been choosen yet, once they have, the Description and UCUM Code"
 . S IND=IND+1,TEXT(IND)="can be displayed to help you decide which to use."
 E  D
 . D UCUMDATA^LEXMUCUM(UCUMIEN,.UCUMDATA)
 . S IND=IND+1,TEXT(IND)="The UCUM CODE is: "_UCUMDATA(UCUMIEN,"UCUM CODE")
 . S IND=IND+1,TEXT(IND)="The description is: "_UCUMDATA(UCUMIEN,"DESCRIPTION")
 ;
 D BROWSE^DDBR("TEXT","NR","UCUM DISPLAY field Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
