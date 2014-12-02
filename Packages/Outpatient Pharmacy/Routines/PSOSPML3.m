PSOSPML3 ;BIRM/MFR - ASAP Definitions Listman Driver ;09/01/12
 ;;7.0;OUTPATIENT PHARMACY;**408**;DEC 1997;Build 100
 ;
 N ASAPVER,DIR,DIRUT,DTOUT,X,Y,DIC
 ;
VER ; ASAP Version Prompt
 S ASAPVER=0
 K DIR S DIR("A")="ASAP Version",DIR(0)="SO^1995:Version 1995;3.0:Version 3.0;4.0:Version 4.0;4.1:Version 4.1;4.2:Version 4.2"
 S DIR("?")="American Society for Automation in Pharmacy (ASAP) Version"
 D ^DIR I (X="")!$D(DIRUT)!$D(DTOUT) G EXIT
 S ASAPVER=Y
 ;
 D EN(ASAPVER,0)
 ;
 G VER
 ;
EN(PSOASVER,PSOSHOW) ; Entry point
 N ASAP
 S PSOSHOW=+$G(PSOSHOW)
 D EN^VALM("PSO SPMP VIEW ASAP DEFINITION")
 D FULL^VALM1
 Q
 ;
HDR ; - Builds the Header section
 S VALM("TITLE")=" ASAP Standard Version "_PSOASVER
 Q
 ;
INIT ; Builds the Body section
 N ASAP,LINE,I
 ;
 K ^TMP("PSOSPML3",$J) S VALMCNT=0,LINE=0
 F I=1:1:1000 D RESTORE^VALM10(I)
 I PSOASVER="1995" D
 . D SETSEG95^PSOSPML4("PSOSPML3","") S VALMCNT=LINE
 I PSOASVER'="1995" D
 . D LOADASAP^PSOSPMUT(PSOASVER,.ASAP)
 . D SETSEG("ASAP") S VALMCNT=LINE
 Q
 ;
 ; Note: Recursivity used because of the 'Tree' nature of the ASAP definition
SETSEG(ARRNAM) ; 
 N ARRAY,COLUMN,TYPE,DETLN,SEGID,JUST,I,J,LSTELM
 ;
 S ARRAY=$Q(@ARRNAM) I '+$P(ARRAY,"(",2) Q
 S SEGID=@ARRAY,COLUMN=(($L(ARRAY,",")-1)*4)
 S JUST="" S:'$G(PSOSHOW) JUST=$J("",COLUMN)
 D SETLN^PSOSPMU1("PSOSPML3",JUST_$P(ASAP(SEGID),"^")_" "_$P(ASAP(SEGID),"^",2),0,1,0)
 S LSTELM=+$O(ASAP(SEGID,""),-1)
 F I=1:1:LSTELM D
 . S:'$G(PSOSHOW) JUST=$J("",COLUMN+$L(SEGID)+1)
 . I '$D(ASAP(SEGID,I)) D SETLN^PSOSPMU1("PSOSPML3",JUST_SEGID_$E(100+I,2,3)_" - NOT USED") Q
 . D SETLN^PSOSPMU1("PSOSPML3",JUST_$P(ASAP(SEGID,I),"^")_" - "_$P(ASAP(SEGID,I),"^",2),0,0,1)
 . I '$G(PSOSHOW) Q
 . S DETLN=JUST_"Required: "_$S($P(ASAP(SEGID,I),"^",6)="R":"YES",1:"NO")
 . S TYPE=$P(ASAP(SEGID,I),"^",3)
 . S $E(DETLN,18)="Format: "_$S(TYPE="AN":"Alphanumeric",TYPE="N":"Numeric",TYPE="D":"Decimal",TYPE="DT":"Date (CCYYMMDD)",TYPE="TM":"Time (HHMMSS or HHMM)",1:"")
 . S $E(DETLN,50)="Length: "_$P(ASAP(SEGID,I),"^",4)
 . D SETLN^PSOSPMU1("PSOSPML3",DETLN)
 . F J=1:1 Q:'$D(ASAP(SEGID,I,"DES",J))  D
 . . D SETLN^PSOSPMU1("PSOSPML3",JUST_ASAP(SEGID,I,"DES",J))
 . D SETLN^PSOSPMU1("PSOSPML3"," ")
 D SETSEG(ARRAY)
 Q
 ;
SHOWHID ; Show/Hide Details
 I PSOASVER="1995" D  Q
 . S VALMSG="Details not available for ASAP 1995 version.",VALMBCK="R" W $C(7)
 W ?52,"Please wait..." S PSOSHOW=$S($G(PSOSHOW):0,1:1)
 D INIT,HDR S VALMBCK="R",VALMBG=1
 Q
 ;
EXIT ;
 K ^TMP("PSOSPML3",$J)
 Q
 ;
HELP ; Listman HELP entry-point
 Q
