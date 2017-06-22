DIAXF ;SFISC/DCM-FILE EXTRACTED DATA ;5/13/96  14:01
 ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN ;
 Q:'$D(^TMP("DIAX",$J))
 N DIAXDAZ
 S DIAXDAZ="^TMP(""DIAXDAZ"",$J)" K @DIAXDAZ
 D UPDATE^DIE("E","^TMP(""DIAX"",$J)",DIAXDAZ,DIAXERR)
 I $G(DIERR) D  Q
 . K ^TMP("DIAX",$J) I $D(@DIAXDAZ) D  Q
 . . N NODE,DA,DIK S NODE=$Q(@(DIAXDAZ))
 . . S DA=@NODE,DIK=DIAXDFRT
 . . D ^DIK K @DIAXDAZ Q
 S DIAXDA=@($Q(@DIAXDAZ)) K @DIAXDAZ
 Q
