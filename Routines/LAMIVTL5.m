LAMIVTL5 ;DAL/HOAK Verify for Vitek literal isolate 0  ;7/8/96  07:30 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**12,36**;Sep 27,1994
INIT ;
 S OK=1
 K ^TMP("LRISO1",$J)
ZEROCHK ;
 S LRX1=0
 ;
 Q:'$D(^LAH(LRLL,"ISO",LRAN))
 Q:'$D(^LAH(LRLL,"ISO",LRAN,0))
 ;---WE got `em 0s
 S LRTIC=0 ;--Looking for all the isolates for this accn
 ;
 F  S LRTIC=$O(^LAH(LRLL,"ISO",LRAN,LRTIC)) Q:+LRTIC'>0  D
 .  I LRTIC>0 S ^TMP("LRISO1",$J,LRTIC)=""
 ;
 ;
 I $D(^LAB(61.38,1,3)) S LRX1=$G(^LAB(61.38,1,3))
 I $G(LRX1)'>0 S LRX1=99
CHANGE ;
 S FIXED=""
 I '$D(^LAH(LRLL,"ISO",LRAN,LRX1)) D
 .  ;
 .  S FIXED=1
 .  S ^LAH(LRLL,"ISO",LRAN,LRX1)=^LAH(LRLL,"ISO",LRAN,0)
 .  ;
 .  ;--Change all the zeros to LRX1
 .  S LRPIC=0
 .  F  S LRPIC=$O(^LAH(LRLL,1,LRPIC)) Q:+LRPIC'>0  D
 ..  S LRTAC=-1
 ..  S LRTAC=$O(^LAH(LRLL,1,LRPIC,3,LRTAC)) Q:LRTAC'=0
 ..  S %Y="^LAH(LRLL,1,LRPIC,3,LRX1,",%X="^LAH(LRLL,1,LRPIC,3,LRTAC,"
 ..  D %XY^%RCR
 ..  K ^LAH(LRLL,1,LRPIC,3,0)
 ..  ;
 ..  K ^LAH(LRLL,"ISO",LRAN,0)
 ;
 I 'FIXED D NOTONE
 Q
 ;
NOTONE ;
 ;--cant use one
 Q:FIXED
 S LRNUM5=0
 F  S LRNUM5=$O(^TMP("LRISO1",$J,LRNUM5)) Q:+LRNUM5'>0  S LRX1=LRNUM5
 ;S LRX1=LRX1+1
 I LRX1'=99 S LRX1=99
 I 'FIXED D CHANGE
 ;
 Q
