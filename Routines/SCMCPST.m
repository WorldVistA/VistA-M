SCMCPST ;ALB/REW - PCMM Post-init ; 4 Feb 1996
 ;;5.3;Scheduling;**41**;AUG 13, 1993
EN ;
 D MESS("PCMM Post-init Actions:","!")
 N SCUSR,SCVAR
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 IF '$$EXTCHK D  G QTEN
 .D MESS("...Problem with Package Environment")
 .D ABORT
 D MESS("...Environment Ok")
 IF '$$DEFAULT D  G QTEN
 .D MESS("...Problem with Setting up default variables")
 .D ABORT
 D MESS("...Default setup Ok")
 IF '$$OKCLEAN D  G QTEN
 .D MESS("...Problem with Cleanup")
 .D ABORT
 D MESS("... Cleanup Ok")
 D MESS(">>>PCMM Post-init Routine is complete","!!")
QTEN Q
 ;
EXTCHK() ;environment check
 D MESS(">>> Checking Package Environment","!!")
 N SCOK
 S (SCOK,SCUSR)=1
 S:'$$GLOBCHK SCOK=0
QTEXT D:'SCOK MESS("Problem with Environment Checker.  Post-init aborted")
 Q SCOK
 ;
DEFAULT() ;setup system defaults
 N DR,DA,DIE,X,Y,SCOK
 S SCOK=1
 D MESS(">>> Setting Default System Settings","!!")
 D MESS(">>> SCHEDULING PARAMETER FILE (#404.91)","!?4")
 IF '$D(^SD(404.91,1,0))#2 D
 .K ^SD(404.91,1)
 .K DO,DD
 .S DIC="^SD(404.91,"
 .S DIC(0)="L"
 .S X=1
 .D FILE^DICN
 D MESS("'USE USR CLASS FUNCTIONALITY?' Field(#801)","!?8")
 IF $G(SCUSR) D
 .IF $P($G(^SD(404.91,1,"PCMM")),U,1)="" D
 ..S DR="801////1;802////1",DA=1,DIE="^SD(404.91," D ^DIE
 ..D MESS("...Set to 'YES'","?50")
 .ELSE  D
 ..D MESS("...Already set - No change","?50")
 ELSE  D
 .D MESS("...Needs TIU to be set","?50")
 .S DR="802////1",DA=1,DIE="^SD(404.91," D ^DIE
 Q SCOK
GLOBCHK() ;
 N SCOK
 S SCOK=1
 D MESS(">>> Checking Globals:","!?4")
 F SCX=1:1 S SCGLOB=$P($T(GLOB+SCX),";;",2) Q:'$L(SCGLOB)  D
 .S SCARR=$P(SCGLOB,"(",1)
 .S SCSUB=$P($P(SCGLOB,"(",2),U,1)
 .S SCVAR=$P(SCGLOB,U,3)
 .D MESS($P(SCARR_"("_SCSUB,U,2),"!?8")
 .IF '$D(@SCARR@(SCSUB)) D
 ..D MESS(" ...Missing","?50")
 ..S @SCVAR=0
 .ELSE  D
 ..D MESS(" ...Present","?50")
QTGLOB D:'SCOK MESS("Problem with Globals checking")
 Q SCOK
 ;
OKCLEAN() ;
 D MESS(">>> Cleaning up ^TMP(""SCMC,$J,"" global","!!")
 N SCOK
 S SCOK=1
 K ^TMP("SCMC",$J)
 Q SCOK
 ;
ABORT ;
 D MESS("After correcting the above mentioned problem(s), you should")
 D MESS("re-run the PCMM post-init routine by entering the following")
 D MESS("command at the programmer's prompt:")
 D MESS("     D EN^SCMCPST")
 D MESS("")
 D MESS("Prior to users making team, position, or staff assignments,")
 D MESS("the post-init may be re-run without any harm.")
 Q
 ;
MESS(TEXT,FORMAT) ;
 S TEXT=$G(TEXT,"")
 S FORMAT=$G(FORMAT,"!")
 D EN^DDIOL(TEXT,"",FORMAT)
 Q
 ;
GLOB ;
 ;;^USR(8930.3^SCUSR
 ;;^USR(8930^SCUSR
 ;
LTRRT ; - to be used later if a/s isn't distributed with pcmm
 ;;USRPROV^1.0T7^Authorization/Subscription^^Feb 15, 1996^SCUSR
LTRGLB ;
