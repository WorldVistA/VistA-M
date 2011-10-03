PXRMDISC ; SLC/PKR - Return the reminder disclaimer in ^TMP. ;06/14/2005
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
FORMAT ;Format and store the formatted disclaimer.
 N IND,LC,NIN,NOUT,TEXTIN,TEXTOUT
 ;If the Site Reminder Disclaimer is empty then use the default
 ;disclaimer.
 S IND=$S($D(^PXRM(800,1,"DISC2")):"DISC2",1:"DISC1")
 S (LC,NIN)=0
 F  S LC=$O(^PXRM(800,1,IND,LC)) Q:LC=""  D
 . S NIN=NIN+1,TEXTIN(NIN)=$G(^PXRM(800,1,IND,LC,0))
 D FORMAT^PXRMTEXT(1,70,NIN,.TEXTIN,.NOUT,.TEXTOUT)
 K ^PXRM(800,1,"DISCF")
 F LC=1:1:NOUT S ^PXRM(800,1,"DISCF",LC,0)=TEXTOUT(LC)
 Q
 ;
 ;========================================================
LOAD ;Load the formatted disclaimer.
 I $D(^TMP("PXRM",$J,"DISC")) Q
 N LC
 S LC=0
 F  S LC=$O(^PXRM(800,1,"DISCF",LC)) Q:LC=""  D
 . S ^TMP("PXRM",$J,"DISC",LC)=^PXRM(800,1,"DISCF",LC,0)
 Q
 ;
