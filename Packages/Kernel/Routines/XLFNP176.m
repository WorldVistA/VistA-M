XLFNP176 ;SFISC/MKO-FIX NEW PERSON NAMES ;3:16 PM  27 Oct 2000
 ;;8.0;KERNEL;**176**;Jul 10, 1995
LIST ;; M D^ D D S^ PH D^ R N^ D P M^ D O^ P A^ N P^ C R N A^ L P N
 Q
 ;
FIX N XUFIX,DIRUT
 D INTRO Q:$D(DIRUT)
 S XUFIX=$$ASKFIX Q:$D(DIRUT)
 D DEVSEL Q:$D(DIRUT)
 U IO
 ;
MAIN ;Loop through the New person file; entry point for queued jobs
 N XUHLIN,XUIEN,XULIST,XUNAM,XUNEW,XUPAGE,XUPC,XUPROB,XUSUF
 D INIT
 S XULIST=$P($T(LIST),";;",2,999)
 ;
 S XUIEN=0 F  S XUIEN=$O(^VA(200,XUIEN)) Q:'XUIEN  D  Q:$D(DIRUT)
 . S XUNAM=$P($G(^VA(200,XUIEN,0)),U) Q:XUNAM=""
 . F XUPC=1:1 S XUSUF=$P(XULIST,U,XUPC) Q:XUSUF=""  D  Q:$D(DIRUT)
 .. Q:XUNAM'?@(".E1"""_XUSUF_"""")
 .. S XUPROB=1
 .. D BLDCOMP(XUNAM,XUSUF,.XUNEW)
 .. D WRITE(XUIEN,XUNAM,.XUNEW) Q:$D(DIRUT)
 .. D:XUFIX FILE(XUIEN,.XUNEW) Q:$D(DIRUT)
 ;
 W:'$G(XUPROB) !,"NO PROBLEMS FOUND",!
 D END
 Q
 ;
BLDCOMP(XUNAM,XUSUF,XUNEW) ;Build new name components
 K XUNEW
 S XUNEW=$E(XUNAM,1,$L(XUNAM)-$L(XUSUF))
 S XUSUF=$TR(XUSUF," ")
 D NAMECOMP^XLFNAME(.XUNEW)
 S XUNEW=XUNEW_" "_XUSUF
 S XUNEW("SUFFIX")=$G(XUNEW("SUFFIX"))_$E(" ",$G(XUNEW("SUFFIX"))]"")_XUSUF
 Q
 ;
WRITE(XUIEN,XUNAM,XUNEW) ;Write info
 D W() Q:$D(DIRUT)
 D W("Entry #"_XUIEN) Q:$D(DIRUT)
 D W("Old Name: "_XUNAM) Q:$D(DIRUT)
 D W("New Name: "_XUNEW) Q:$D(DIRUT)
 I $G(XUNEW("GIVEN"))]"" D W(" Given: "_XUNEW("GIVEN"),10) Q:$D(DIRUT)
 I $G(XUNEW("MIDDLE"))]"" D W("Middle: "_XUNEW("MIDDLE"),10) Q:$D(DIRUT)
 I $G(XUNEW("FAMILY"))]"" D W("Family: "_XUNEW("FAMILY"),10) Q:$D(DIRUT)
 I $G(XUNEW("SUFFIX"))]"" D W("Suffix: "_XUNEW("SUFFIX"),10) Q:$D(DIRUT)
 Q
 ;
FILE(XUIEN,XUNEW) ;Correct Name
 N DIERR,XUFDA,XUMSG,XUNC
 ;
 S XUNC=$P($G(^VA(200,XUIEN,3.1)),U)
 I XUNC,$D(^VA(20,XUNC,0))#2,$P(^(0),U,1,3)="200^.01^"_XUIEN_"," D
 . S XUFDA(20,XUNC_",",1)=$G(XUNEW("FAMILY"))
 . S XUFDA(20,XUNC_",",2)=$G(XUNEW("GIVEN"))
 . S XUFDA(20,XUNC_",",3)=$G(XUNEW("MIDDLE"))
 . S XUFDA(20,XUNC_",",5)=$G(XUNEW("SUFFIX"))
 . D FILE^DIE("","XUFDA","XUMSG")
 ;
 E  D
 . D W("** Unable to file new name **")
 . D W("     There is no corresponding entry in the Name Components file.")
 ;
 I $G(DIERR) D
 . N XUI,XUOUT
 . D MSG^DIALOG("AE","XUOUT","",5,"XUMSG")
 . D W("** Unable to file new name **") Q:$D(DIRUT)
 . F XUI=1:1:XUOUT D W(XUOUT(XUI)) Q:$D(DIRUT)
 Q
 ;
W(XUSTR,XUTAB) ;Write XUSTR
 I $Y+4>IOSL D EOP Q:$D(DIRUT)
 W !?+$G(XUTAB),$G(XUSTR)
 Q
 ;
EOP ;End-of-page prompt/check
 I $E(IOST,1,2)="C-" D  Q:$D(DIRUT)
 . N DIR,DIROUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="E" W ! D ^DIR
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DIRUT)=1 Q
 W @IOF
 D HDR
 Q
 ;
HDR ;Print header
 S ($X,$Y)=0
 S XUPAGE=$G(XUPAGE)+1
 I XUFIX W "NEW PERSON NAMES FIXED BY FIX^XLFNP176"
 E  W "HOW FIX^XLFNP176 WOULD FIX NEW PERSON NAMES"
 W ?(IOM-$L(XUHLIN)-$L(XUPAGE)-1),XUHLIN_XUPAGE
 W !,$TR($J("",IOM-1)," ","-")
 Q
 ;
ASKFIX() ;Ask whether to file corrected New Person name
 N DIR,DIROUT,DTOUT,DUOUT,X,Y K DIRUT
 S DIR(0)="SBA^R:Report Only;F:Fix Names"
 S DIR("A")="Fix names or just print a Report (F/R)? "
 S DIR("?",1)="Answer 'R' to print a report of names with a potential problems."
 S DIR("?")="Answer 'F' to fix the names."
 W ! D ^DIR
 Q Y="F"
 ;
DEVSEL ;Select device
 N %ZIS,POP K DIRUT
 S %ZIS=$S($D(^%ZTSK):"Q",1:"")
 W ! D ^%ZIS
 I $G(POP) S DIRUT=1 Q
 ;
 ;Queue report
 I $D(IO("Q")),$D(^%ZTSK) D  S DIRUT=1 Q
 . N ZTSK
 . S ZTRTN="MAIN^XLFNP176"
 . S ZTDESC="Names in New Person file with spaces within a suffix."
 . S ZTSAVE("XUFIX")=""
 . D ^%ZTLOAD
 . I $D(ZTSK)#2 W !,"Report queued!",!,"Task number: "_$G(ZTSK),!
 . E  W !,"Report canceled!",!
 . S IOP="HOME" D ^%ZIS
 Q
 ;
INIT ;Setup
 N %,%H,X,Y
 S %H=$H D YX^%DTC
 S XUHLIN=$P(Y,"@")_"  "_$P($P(Y,"@",2),":",1,2)_"    PAGE "
 W:$E(IOST,1,2)="C-" @IOF
 D HDR
 Q
 ;
END ;Finish up
 I $D(ZTQUEUED) S ZTREQ="@"
 E  N POP D ^%ZISC
 Q
 ;
INTRO ;
 N DIR,DIROUT,DUOUT,DTOUT,I,L,S,X,Y
 W !,"Routine XLFNP176 was released with patch XU*8*176."
 ;
 W !!,"This entry point (FIX^XLFNP176) loops through all the entries in the New"
 W !,"Person file (#200) and looks for names that may have been standardized and"
 W !,"parsed incorrectly by the Name Standardization Patch XU*8*134. If a name"
 W !,"in the New Person file prior to the installation of Patch XU*8*134"
 W !,"contained periods within its suffix, the Post-Install Conversion of that"
 W !,"patch converted those periods to spaces, and didn't recognize the name"
 W !,"component as a suffix. This entry point prints a report of names that may"
 W !,"have the problem, and optionally corrects them."
 ;
 W !!,"NOTE: This routine should be run only after Patches XU*8*134 and XU*8*152"
 W !,"have been installed."
 ;
 I '$$PATCH^XPDUTL("XU*8.0*134")!'$$PATCH^XPDUTL("XU*8.0*152") D  Q
 . W !!,$C(7),"  It appears that the above two patches have NOT been installed on"
 . W !,"  your system. Exiting ...",!
 . S DIRUT=1
 ;
 W !!,"  It appears that those two patches HAVE been installed in this acccount"
 W ! S DIR(0)="E" D ^DIR K DIR Q:$D(DIRUT)
 ;
 W !!,"Each New Person file Name will be checked to determine whether any"
 W !,"following strings occur at the end of the Name:",!
 S L=$P($T(LIST),";;",2,99)
 F I=1:1:$L(L,U) S S=$P(L,U,I) W:S]"" !,"  '"_S_"'"
 ;
 S DIR(0)="Y"
 S DIR("A")="Do you wish to use a different list"
 S DIR("B")="NO"
 S DIR("?",1)="  Enter 'YES' to exit and modify line tag LIST^XLFNP162."
 S DIR("?")="  Enter 'NO' to accept the above list and continue."
 W ! D ^DIR K DIR Q:$D(DIRUT)
 I Y D  Q
 . W !!,"  Edit the list at line tag LIST^XLFNP176.",!
 . S DIRUT=1
 Q
