VBECDCM ;hoifo/gjc-data mapping utilities.;Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to $$NEWERR^%ZTER supported by IA: 1621
 ;Call to ^DIC supported by IA: 10006
 ;Call to MIX^DIC1 supported by IA: 10007
 ;Call to FILE^DIE supported by IA: 2053
 ;Execution of ^%ZOSF("TEST") supported by IA: 10096
 ;
EN613 ; entry point for mapping utilities on antibodies & antigens
 D EN613^VBECDCM0 ;check for adds, edits, or deletes on the VistA side
 S VBECFN=61.3 D GO Q
 ;
EN654 ; entry point for mapping utilities on transfusion reactions
 D EN654^VBECDCM2 ;check for adds, edits, or deletes on the VistA side
 S VBECFN=65.4 D GO Q
 ;
GO ; main entry point for mapping...
 ; VBECXIT is used to denote when the application is to be exited
 ; VBECFNM is the attribute name within the VistA file (blood product,
 ; antigen/antibody, transfusion reaction, & blood supplier)
 ;
 ; initialize error trap
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 ;
 S VBECXIT=0
 S VBECFNM=$S(VBECFN=61.3:"Antigen/Antibody",VBECFN=65.4:"Transfusion Reaction",VBECFN=66:"Blood Product",66.01:"Blood Supplier",1:"")
 ;
 ; Lock the file that is being mapped to disallow another user the
 ; ability to add/edit/delete records in the file.  If we cannot lock,
 ; we need to try again at a later date.
 L +^VBEC(6005):5
 I '$T D  D XIT Q
 .W !!,"The "_VBECFNM_" file is being edited by another user.",!,"Try again later."
 .Q
 ;
 ; select the VistA element to map & the standardized value to map to
 F  D  Q:VBECXIT
 .S VBECVSTA=$$VSTLOOK(VBECFNM,VBECFN)
 .I +VBECVSTA=-1 S VBECXIT=1 Q
 .S VBECSQL=$$SQLLOOK(VBECFNM,VBECFN,VBECVSTA)
 .I +VBECSQL=-1 S VBECXIT=1 Q
 .; file pointer to standardized data (fld: .05)
 .K VBECFDA
 .S VBECFDA(8,6005,+VBECVSTA_",",.05)=+VBECSQL
 .D FILE^DIE("","VBECFDA(8)","")
 .; end of data filing
 .Q
 ;*********************************************************************
 ;
XIT ; kill and quit
 L -^VBEC(6005) K VBECFDA,VBECFN,VBECFNM,VBECSQL,VBECVSTA,VBECXIT,X,Y
 Q
 ;
SQLLOOK(VBECFNM,VBECFN,VBECVSTA) ; Lookup on standardized blood products,
 ; transfusion reactions, blood suppliers, and antigens/antibodies.
 ;
 ; Input: VBECFNM=attribute to be mapped, i.e., transfusion reactions
 ;        & antigens/antibodies.
 ;        VBECFN=VistA file #; VistA file where the attribute resides
 ;        VBECVSTA=ien^file#-ien^name attribute^identifier^
 ;                 antibody/antigen flag
 ;
 ; return: ien^attribute name^attribute key, -1 if lookup fails
 ;
 N VBECSQL,VBECID,VBECVK,VBECVN
 ; VBECVK=antibody/antigen flag or null
 ; VBECVN=VistA name (.01)
 ; VBECID=for antibodies only, SNOMED code
 S VBECVN=$P(VBECVSTA,U,3),VBECID=$P(VBECVSTA,U,4)
 S VBECVK=$P(VBECVSTA,U,5)
 ;
 F  D  Q:+VBECSQL
 .S DIC="^VBEC(6007,",DIC("A")="Select a standardized "_VBECFNM_": "
 .S DIC(0)="QEAMZ"
 .S DIC("S")="I $D(^VBEC(6007,""FNUM"",VBECFN,+Y))#2" ; common to all
 .;
 .;additional logic for antibody/antigen screen
 .S:VBECFN=61.3 DIC("S")=DIC("S")_" N VBECQ S VBECQ=$G(^VBEC(6007,+Y,0)) I $P(VBECQ,U,4)=VBECVK"
 .;
 .;display identifier when looking up antibody/antigen
 .S:VBECFN=61.3 DIC("W")="N VBEC67 S VBEC67=$G(^VBEC(6007,+Y,0)) W $P(VBEC67,U,2)_$S($P(VBEC67,U,4)=""AB"":"" (Antibody)"",$P(VBEC67,U,2)=""AN"":"" (Antigen)"",1:"""")"
 .;
 .D ^DIC K DIC,VBECSCR
 .I $D(DUOUT)!($D(DTOUT))!(+Y=-1) S VBECSQL=-1 Q
 .; VBECSQL format: internal entry # ^ attribute name ^ attribute key
 .S VBECSQL=+Y_U_$P(Y(0),U,1,2)
 .Q
 Q VBECSQL
 ;
VSTLOOK(VBECFNM,VBECFN) ; Lookup on standardized VistA blood products,
 ; transfusion reactions, blood suppliers, and antigens/antibodies.
 ;
 ; Input: VBECFNM=attribute to be mapped, i.e., blood products,
 ;        transfusion reactions, blood suppliers, and
 ;        antigens/antibodies.
 ;        VBECFN=VistA file #; VistA file where the attribute resides
 ;
 ; return if antibody/antigen: ien ^ file#-ien ^ name attribute ^
 ;                             ^ identifier ^ antibody/antigen flag
 ;       transfusion reaction: ien ^ file#-ien ^ name attribute ^
 ;                             null (no identifier) ^ (no flag)
 ;
 ;                             -1 if lookup fails
 ;
 N VBECVSTA
 F  D  Q:+VBECVSTA
 .K D,DIC,DO S DIC(0)="QEFASZ" S:VBECFN=61.3 DIC(0)=DIC(0)_"X"
 .S D="N^VA",DIC="^VBEC(6005,",DIC("A")="Select VistA "_VBECFNM_": "
 .S:VBECFN=61.3 DIC("W")="N VBEC24 S VBEC24=$P($G(^VBEC(6005,+Y,0)),U,2,4) W $P(VBEC24,U,2)_$S($P(VBEC24,U,3)=""AB"":"" (Antibody)"",$P(VBEC24,U,3)=""AN"":"" (Antigen)"",1:"""")"
 .;S:VBECFN=61.3 DIC("W")="N VBEC04 S VBEC04=$P($G(^VBEC(6005,+Y,0)),U,4) W $S(VBEC04=""AB"":""(Antibody)"",VBEC04=""AN"":""(Antigen)"",1:"""")"
 .S DIC("S")="N VBEC05 S VBEC05=$G(^VBEC(6005,+Y,0)) I +VBEC05=VBECFN,$P(VBEC05,U,5)="""""
 .D MIX^DIC1 K D,DIC,DO
 .I $D(DUOUT)!($D(DTOUT))!(+Y=-1) S VBECVSTA=-1 Q
 .S VBECVSTA=+Y_U_$P(Y(0),U,1,4)
 .Q
 Q VBECVSTA
 ;
