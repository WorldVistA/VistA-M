DDMPU ;SFISC/DPC-IMPORT USER INTERFACE, TEMPLATE CREATE ;9/12/96  17:07
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN ;Entry point for Import Data option.
 D CLEAN^DIEFU
 N DIQUIET,DIFM S (DIQUIET,DIFM)=1
 N DA
 N DDMPHOST,DDMPSELF,DDMPFLAG,DDMPDR,DDSSAVE,DDMPSMFF,DDMPHOST,DDMPIORE,DDMPFDSL,DDMPTMPL
 D  Q:'$G(DDSSAVE)
 . N DDSPARM,DDSFILE,DR
 . N DDMPF,DDMPCF,DDMPCPNM,DDMPCPTH,DDMPFCAP,DDMPFDCT,DDMPFDNM,DDMPFLNM,DDMPOSET,DDMPX,DDMPFRP4,DDMPOLDF
 . S DDSFILE=.46,DR="[DDMP SPECIFY IMPORT]",DDSPARM="S" D ^DDS
 W @IOF
 I '$D(DDMPSELF) S DDMPFLAG="F"
 I $G(DDMPIORE)="E" S DDMPFLAG=$G(DDMPFLAG)_"E"
 I '($G(DDMPTMPL)]""),$D(DDMPSELF) D
 . N DIR,DIRUT,Y
 . S DIR(0)="Y"
 . S DIR("A")="Do you want to store the selected fields in an Import Template"
 . D ^DIR
 . I Y D MKTMPL(DDMPSELF,.DDMPFDSL,.DDMPDR)
 N DIR,DIRUT,Y S DIR(0)="Y"
 S DIR("A")="Do you want to proceed with the import"
 S DIR("?",1)="If you answer 'YES', the import will occur now."
 S DIR("?")="If you answer 'NO', you will need to respecify the import criteria."
 W ! D ^DIR
 I 'Y!$G(DIRUT) W !!,"Okay, you can do the import later." Q
 D FILE^DDMP($G(DDMPSELF),.DDMPDR,$G(DDMPFLAG),.DDMPHOST,.DDMPSMFF)
 W !!
 I $G(DIERR) D
 . W "Following error messages were generated when import failed."
 . D MSG^DIALOG("","","",3)
 E  I '$G(ZTSK) W "Done."
 Q
 ;
MKTMPL(DDMPF,DDMPFLDS,DDMPDR) ; Create Import Template.
 N DDMPTPNM,DDMPTPNO,DDMPRCNO,DDMPOUT,DDMPSQ,DIR,DIRUT,Y
 F  D  Q:$G(DDMPOUT)!($G(DDMPTPNM)]"")
 . S DIR(0)="FA^3:30^K:(X?1P.E) X"
 . S DIR("?")="Enter name for your import template.  It should be 3-30 characters and it should not start with a punctuation character"
 . S DIR("A")="Name of Import Template:  "
 . W ! D ^DIR
 . I Y']""!$G(DIRUT) S DDMPOUT=1 Q
 . S DDMPTPNM=Y
 . S DDMPTPNO=$O(^DIST(.46,"F"_DDMPF,DDMPTPNM,""))
 . I DDMPTPNO D DUPNAME(DDMPF,.DDMPTPNM,DDMPTPNO) Q:DDMPTPNM=""
 . S DIR("A")="  Are you adding '"_DDMPTPNM_"' as a new Import Template"
 . S DIR(0)="Y"
 . D ^DIR
 . I 'Y S DDMPTPNM="" Q
 . K ^TMP($J,"DDMPFDA")
 . S ^TMP($J,"DDMPFDA",.46,"+1,",.01)=DDMPTPNM
 . S ^TMP($J,"DDMPFDA",.46,"+1,",4)=DDMPF
 . S ^TMP($J,"DDMPFDA",.46,"+1,",5)=DUZ
 . S ^TMP($J,"DDMPFDA",.46,"+1,",2)=DT
 . S:DUZ(0)'="@" (^TMP($J,"DDMPFDA",.46,"+1,",3),^TMP($J,"DDMPFDA",.46,"+1,",6))=DUZ(0)
 . F DDMPSQ=1:1  Q:'$D(DDMPFLDS(DDMPSQ))  D
 . . N DDMPIENS,DDMPLVLS
 . . S DDMPIENS="+"_(DDMPSQ+1)_",+1,"
 . . S DDMPLVLS=$L(DDMPFLDS(DDMPSQ),":")
 . . S ^TMP($J,"DDMPFDA",.463,DDMPIENS,.01)=DDMPSQ
 . . S ^TMP($J,"DDMPFDA",.463,DDMPIENS,1)=$P($P(DDMPFLDS(DDMPSQ),":",DDMPLVLS),U,2)
 . . S ^TMP($J,"DDMPFDA",.463,DDMPIENS,2)=+$P(DDMPFLDS(DDMPSQ),":",DDMPLVLS)
 . . S:$D(DDMPFLDS("LN",DDMPSQ)) ^TMP($J,"DDMPFDA",.463,DDMPIENS,3)=DDMPFLDS("LN",DDMPSQ)
 . . S:DDMPLVLS>1 ^TMP($J,"DDMPFDA",.463,DDMPIENS,10)=$P(DDMPFLDS(DDMPSQ),":",1,DDMPLVLS-1)
 . . S ^TMP($J,"DDMPFDA",.463,DDMPIENS,20)=DDMPFLDS("CAP",DDMPSQ)
 . N DDMPERR S DDMPERR=$G(DIERR)
 . D UPDATE^DIE("","^TMP($J,""DDMPFDA"")","DDMPRCNO")
 . I DDMPERR'=$G(DIERR) W !,"An error occurred during the filing of the import template." S DDMPOUT=1 Q
 . D RECALL^DILFD(.46,DDMPRCNO(1)_",",DUZ)
 . I DUZ(0)="@" S $P(^DIST(.46,DDMPRCNO(1),0),U,3)="@",$P(^(0),U,6)="@"
 I $G(DDMPOUT) W !,"No import template will be created."
 Q
 ;
DUPNAME(DDMPF,DDMPTPNM,DDMPTPNO) ;selected template exists.
 ;If Import template name remains in DDMPTPNM after subroutine,
 ;user has chosen to delete existing template.
 W !!,"Import Template "_DDMPTPNM_" already exists."
 N DDMPDLOK S DDMPDLOK=0
 I DUZ(0)="@" D
 . S DDMPDLOK=$$CKDLT
 E  D
 . N DDMPWRAC,I
 . S DDMPWRAC=$$GET1^DIQ(.46,DDMPTPNO_",",6)
 . F I=1:1:$L(DDMPWRAC) I DUZ(0)[$E(DDMPWRAC,I) S DDMPDLOK=$$CKDLT Q
 I DDMPDLOK D
 . N DIK,DA S DIK="^DIST(.46,",DA=DDMPTPNO D ^DIK
 . W !,"Existing Import Template "_DDMPTPNM_" has been deleted."
 E  S DDMPTPNM="" W !!,"Choose another template name."
 Q
 ;
CKDLT() ;
 ;user has write access to the template.  Do they want to delete it?
 N DIR,DIRUT
 S DIR(0)="Y"
 S DIR("A")="Do you want to replace the existing template with a new one"
 S DIR("?",1)="If you answer 'YES', the existing template will be deleted."
 S DIR("?")="Answer YES or NO."
 D ^DIR
 I 'Y!$G(DIRUT) Q 0
 Q 1
