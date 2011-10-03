PXRRPECS ;ISL/PKR - Build a list of Person Class entries. ;12/11/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**12,147**;Aug 12, 1996
 ;
 ;=======================================================================
PCLASS ;Build a list of person classes.
 N BELL,IC,INDENT,JC,NOCC,NS,NSPEC,NSUB,OCC,OCCIEN,PCLASS
 N SELECT,SOCC,SOCCW,SPEC,SPECIEN,SSPEC,SSPECW,SUB,SSUB,TEMP,WC,X,Y
 ;We will need a DBIA for reading the Person Class file.
 ;Build a list of the OCCUPATION entries in the Person Class file.
 S IC=0
 F  S IC=$O(^USC(8932.1,IC)) Q:+IC=0  D
 . S TEMP=$P(^USC(8932.1,IC,0),U,1)
 . I $L(TEMP)>0 S OCC($$UPPRCASE^PXRRPECU(TEMP))=TEMP
 ;
 ;Count the number of Occupation entries.
 S NOCC=0
 S IC=""
 F  S IC=$O(OCC(IC)) Q:IC=""  D
 . S NOCC=NOCC+1
 ;
 S BELL=$C(7)
 ;Set the wildcard to be *.
 S WC="*"
 ;NS is NOT SPECIFIED.
 S NS="NOT SPECIFIED"
 S INDENT=3
 S NCL=0
 K PXRRPECL
MPROMPT W !,"Select PERSON CLASS (OCCUPATION, SPECIALTY, SUBSPECIALTY)"
 K DTOUT,DUOUT
 W !
NPCLASS ;
 I NCL'<1 W !!,"Select another PERSON CLASS OCCUPATION"
 ;Select an occupation.
NOCC S DIR(0)="FAOU^1:60"
 S DIR("?")="^D OCCHLP^PXRRPECS"
 S DIR("??")="^D LISTA^PXRRPECU(.OCC)"
 S DIR("A")=" Select OCCUPATION (enter "_WC_" for all, return to end selection): "
 W !
 D ^DIR
 K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!$D(DUOUT) Q
 S SOCC=$$FDME^PXRRPECU(Y,.OCC)
 I SOCC=-1 W " ??",BELL G NOCC
 I ($P(SOCC,U,1)="")&(NCL=0) D  G MPROMPT
 . W !,"You must select a person class!"
 I $P(SOCC,U,1)="" Q
 I $P(SOCC,U,1)=WC S SOCCW=1
 E  S SOCCW=0
 ;
 ;Build a list of iens for SOCC (Selected OCCupation).
 K OCCIEN
 K SPEC
 I ('SOCCW) D
 . S TEMP=$E($P(SOCC,U,2),1,62)
 . S IC=0
 . F  S IC=$O(^USC(8932.1,"B",TEMP,IC)) Q:+IC=0  D
 .. S OCCIEN(IC)=""
 ;
 ;Build a list of specialties valid for SOCC.
 S IC=0
 F  S IC=$O(OCCIEN(IC)) Q:+IC=0  D
 . S TEMP=$P(^USC(8932.1,IC,0),U,2)
 . I TEMP="" S TEMP=NS
 . S SPEC($$UPPRCASE^PXRRPECU(TEMP))=TEMP
 ;
 ;Special case for Occupation selected as wildcard.
 I SOCCW D
 . S IC=0
 . F  S IC=$O(^USC(8932.1,IC)) Q:+IC=0  D
 .. S TEMP=$P(^USC(8932.1,IC,0),U,2)
 .. I TEMP="" S TEMP=NS
 .. S SPEC($$UPPRCASE^PXRRPECU(TEMP))=TEMP
 ;
 ;Count the number of Specialty entries compatible with the selected
 ;Occupation.
 S NSPEC=0
 S IC=0
 F  S IC=$O(SPEC(IC)) Q:IC=""  D
 . S NSPEC=NSPEC+1
 ;
 I NSPEC=0 D  G NPCLASS
 . W !,"There are no specialties for:"
 . W !,?INDENT,"OCCUPATION: ",$P(SOCC,U,1)
 . S NCL=NCL+1
 . S PXRRPECL(NCL)=$P(SOCC,U,2)_U_NS_U_NS
 ;
 ;Select a specialty.
 S SSPEC=""
NSPEC I (NCL>0)&($L(SSPEC)>0) D VERIFY^PXRRPECU
 S DIR(0)="FAOU^1:50"
 S DIR("?")="^D SPECHLP^PXRRPECS"
 S DIR("??")="^D LISTA^PXRRPECU(.SPEC)"
 S DIR("A")=" Select SPECIALTY (enter "_WC_" for all, return to change OCCUPATION): "
 W !!,"The currently selected OCCUPATION is:"
 W !," ",$P(SOCC,U,2)
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT) Q
 I $D(DUOUT) G NOCC
 I $L(Y)=0 G NPCLASS
 S SSPEC=$$FDME^PXRRPECU(Y,.SPEC)
 I $P(SSPEC,U,1)="" G NPCLASS
 I SSPEC=-1 W " ??",BELL G NSPEC
 I $P(SSPEC,U,1)=WC S SSPECW=1
 E  S SSPECW=0
 ;
 ;Build a list of iens for SSPEC (Selected SPECialty).  Trim the OCCIEN
 ;list so it only contains entries valid for SOCC and SSPEC.
 K SPECIEN
 K SUB
 S IC=0
 F  S IC=$O(OCCIEN(IC)) Q:+IC=0  D
 . S SPECIEN(IC)=OCCIEN(IC)
 ;
 ;If SSPEC was selected as the wildcard then we don't need to do
 ;anything.
 I ('SSPECW)&('SOCCW) D
 . S TEMP=$P(SSPEC,U,2)
 . S IC=0
 . F  S IC=$O(SPECIEN(IC)) Q:+IC=0  D
 .. I $P(^USC(8932.1,IC,0),U,2)'=TEMP K SPECIEN(IC)
 ;
 ;Special case with SOCC=WC and SSPEC'=WC
 I ('SSPECW)&(SOCCW) D
 . S TEMP=$P(SSPEC,U,2)
 . S IC=0
 . F  S IC=$O(^USC(8932.1,IC)) Q:+IC=0  D
 .. I $P(^USC(8932.1,IC,0),U,2)=TEMP S SPECIEN(IC)=""
 ;
 ;Build a list of subspecialties valid for SOCC and SSPEC.
  S IC=0
  F  S IC=$O(SPECIEN(IC)) Q:+IC=0  D
 . S TEMP=$P(^USC(8932.1,IC,0),U,3)
 . I TEMP="" S TEMP=NS
 . S SUB($$UPPRCASE^PXRRPECU(TEMP))=TEMP
 ;
 ;Special case SOCC and SSPEC are wild.
 I (SSPECW)&(SOCCW) D
 . S IC=0
 . F  S IC=$O(^USC(8932.1,IC)) Q:+IC=0  D
 .. S TEMP=$P(^USC(8932.1,IC,0),U,3)
 .. I TEMP="" S TEMP=NS
 .. S SUB($$UPPRCASE^PXRRPECU(TEMP))=TEMP
 ;
 ;Count the number of entries.
 S NSUB=0
 S IC=""
 F  S IC=$O(SUB(IC)) Q:IC=""  D
 . S NSUB=NSUB+1
 ;
 I (NSUB=0)!((NSUB=1)&($D(SUB(NS)))) D  G NSPEC
 . W !,"There are no subspecialties for:"
 . W !,?INDENT,"OCCUPATION: ",$P(SOCC,U,1)
 . W !,?INDENT,"SPECIALTY:  ",$P(SSPEC,U,1)
 . S NCL=NCL+1
 . S PXRRPECL(NCL)=$P(SOCC,U,2)_U_$P(SSPEC,U,2)_U_NS
 ;
 ;Select a subspecialty.
NSUB S DIR(0)="FAOU^1:50"
 S DIR("?")="^D SUBHLP^PXRRPECS"
 S DIR("??")="^D LISTA^PXRRPECU(.SUB)"
 S DIR("A")=" Select SUBSPECIALTY (enter "_WC_" for all): "
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT) Q
 I $D(DUOUT) G NSPEC
 I $L(Y)=0 S SSUB=NS_U_NS
 E  S SSUB=$$FDME^PXRRPECU(Y,.SUB)
 I SSUB=-1 W " ??",BELL G NSUB
 ;
 ;Save the selections.
 S TEMP=$L($P(SOCC,U,1))+$L($P(SSPEC,U,1))+$L($P(SSUB,U,1))
 I TEMP=0 Q
 I TEMP>0 D
 . S NCL=NCL+1
 . S PXRRPECL(NCL)=$P(SOCC,U,2)_U_$P(SSPEC,U,2)_U_$P(SSUB,U,2)
 I $D(DUOUT) G PCLASS
 I (NCL=0)&($D(DIRUT)!$D(DUOUT)) Q
 I (NCL=0) W !,"You must select a PERSON CLASS!" G PCLASS
 G NSPEC
 ;
 ;=======================================================================
OCCHLP ;Help for occupation input.
 N PROMPT
 W !!,"Answer with an OCCUPATION, note ",WC," matches all OCCUPATIONS"
 S PROMPT="Do you want the entire "_NOCC_"-entry occupation list? "
 I $$GETYORN^PXRRPECU(PROMPT) D LISTA^PXRRPECU(.OCC)
 Q
 ;
 ;=======================================================================
SPECHLP ;Help for specialty input.
 N PROMPT
 W !!,"Answer with a SPECIALTY, note ",WC," matches all SPECIALTIES"
 S PROMPT="Do you want the entire "_NSPEC_"-entry specialty list? "
 I $$GETYORN^PXRRPECU(PROMPT) D LISTA^PXRRPECU(.SPEC)
 Q
 ;
 ;=======================================================================
SUBHLP ;Help for subspecialty input.
 N PROMPT
 W !!,"Answer with a SUBSPECIALTY, note ",WC," matches all SUBSPECIALTIES"
 S PROMPT="Do you want the entire "_NSUB_"-entry subspecialty list? "
 I $$GETYORN^PXRRPECU(PROMPT) D LISTA^PXRRPECU(.SUB)
 Q
 ;
