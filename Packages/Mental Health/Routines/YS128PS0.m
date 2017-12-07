YS128PS0 ;SLC/JLC - Patch 128 post-init - utilities; 9/15/2015 ;05/30/17  07:55
 ;;5.01;MENTAL HEALTH;**128**;Dec 30, 1994;Build 26
 ;
 ;
 Q
 ;
UPDVER(WHICH,VER) ; update MHA version number in broker option
 ; WHICH: 1=server, 2="A" DLL, 3=MHA exe
 ; VER: version string for WHICH component
 N OPT,TXT,VERPART,FDA,DIERR
 S OPT=$$FIND1^DIC(19,"","X","YS BROKER1","B")
 I 'OPT D BMES^XPDUTL("ERROR: YS BROKER1 not found on this system.") QUIT
 I $D(DIERR) D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1))) QUIT
 S TXT=$$GET1^DIQ(19,OPT_",",1),VERPART=$P(TXT,"version ",2)
 S $P(VERPART,"~",WHICH)=VER,$P(TXT,"version ",2)=VERPART
 S FDA(19,OPT_",",1)=TXT
 D FILE^DIE("","FDA")
 I $D(DIERR) D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
POST ;update DLL version number
 D UPDVER(2,"1.0.5.4")
 Q
