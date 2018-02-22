XVSE ; VEN/SMH - VPE Editor Init Code;2017-08-16  12:17 PM; 3/1/17 3:28pm
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; (c) 2010-2016 Sam Habiel
 ;
 ;
E ; Edit Entry Point
 S $EC="" ; Clear error code b/c save part aborts if there is one.
 D E3 ; Get DUZ
 Q:$G(DUZ)=""
 NEW FLAGSAVE,FLAGVPE,XVVS
 NEW:$G(XVV("OS"))="" XVV
 D E4 ; Open routine for editing
 Q:'$D(^TMP("XVV","VRR",$J))  ; Nothing to save; quit
 D E1
 K ^UTILITY($J)
 N VRRS S VRRS=1
 KILL ^TMP("XVV","VRR",$J,VRRS)
 KILL ^TMP("XVV","IR"_VRRS,$J)
 QUIT
 ;
 ;
 ;
 ;
E1 ; Move Routine in Editor Window to ^UTILITY to Save it
 NEW %Y,VRRPGM,X
 D SAVE^XVEMRC(1)
 Q:$G(VRRPGM)=""
 D E2 ; Save
 QUIT
 ;
 ;
 ;
 ;
E2 ; Save Routine
 NEW X S X=VRRPGM
 X XVVS("ZS")
 D E5 ; GT.M ZLINK
 QUIT
 ;
 ;
 ;
 ;
E3 ; Get DUZ (NB: Old code saved and restored %1 and %2; We are more grown up now!)
 Q:$G(DUZ)>0
 D
 . N %1,%2
 . D ID^XVEMKU
 QUIT
 ;
 ;
 ;
 ;
E4 ; Open for editing at Routine %1 tag %2
 S $P(FLAGVPE,"^",4)="EDIT"
 D PARAM^XVEMR($G(%1),$G(%2))
 QUIT
 ;
 ;
 ;
 ;
E5 ; GT.M ZLINK Routine
 I XVV("OS")'=19!(XVV("OS")'=17) QUIT  ; GTM/UNIX,VAX only
 ;
 NEW PGM SET PGM=VRRPGM,PGM=$TR(PGM,"%","_")
 ZLINK PGM
 QUIT
