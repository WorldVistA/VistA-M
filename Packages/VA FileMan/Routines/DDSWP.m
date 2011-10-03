DDSWP ;SFISC/MKO-WP ;1:05 PM  23 Aug 1999
 ;;22.0;VA FileMan;**8**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EDIT ;Edit the word processing field
 N I
 S DDSUE=$D(DDSTP)#2!$S($P($G(DDSU("A")),U,4)="":$P($G(DDSO(4)),U,4),1:$P(DDSU("A"),U,4))
 I DDSUE D  I $D(DIRUT) K DIRUT,DUOUT,DIROUT G EDITQ
 . D:DDM CLRMSG^DDS
 . K DIR S DIR(0)="E"
 . S DIR("A",1)="WARNING: This field is uneditable."
 . S DIR("A",2)="         Any changes made in the editor will not be saved."
 . S DIR("A",3)=""
 . S DIR("A")="Press RETURN to enter editor:"
 . S DIR0=IOSL-1_U_($L(DIR("A"))+1)_"^1^"_(IOSL-4)_"^0"
 . D ^DIR K DIR
 ;
 S DDSUTL=$NA(@DDSREFT@("F"_DDP,DDSDA,DDSFLD))
 ;
 I $D(@DDSUTL@("F"))[0,$D(@(DDSGL_"0)"))#2 D
 . K @DDSUTL@("D")
 . M @DDSUTL@("D")=@($E(DDSGL,1,$L(DDSGL)-1)_")")
 ;
 S (DY,DX)=0 X IOXY W $P(DDGLCLR,DDGLDEL,2)
 S DIC=$E(DDSUTL,1,$L(DDSUTL)-1)_",""D"",",DWPK=1
 S DIWESUB=$P($G(DDSU("DD")),U) K:DIWESUB="" DIWESUB
 D EN^DIWE
 K DIC,DIWESUB,DWPK
 I 'DDSUE S DDSCHG=1,@DDSUTL@("F")=1
 E  K @DDSUTL@("D")
EDITQ K DDSUE,DDSUTL
 Q
 ;
WP ;At the wp field
 S DIR(0)="FO^0:0"
 S DIR("?")="^W ""Press 'RETURN' to edit this word processing field."""
 S DIR("??")="^D HELP^DDSWP"
 D ^DIR K DIR,DUOUT,DIRUT,DIROUT
 Q
HELP ;?? help at the WP field
 S DDSFN=+$P(DDSU("M"),U,3)
 D:$G(^DD(DDSFN,.01,3))]"" MSG^DDSMSG(^(3))
 X:$G(^DD(DDSFN,.01,4))]"" ^(4)
 D:$D(^DD(DDSFN,.01,21)) WP^DDSMSG("^DD("_DDSFN_",.01,21)")
 K DDSFN
 Q
