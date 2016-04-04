DIKCBLD ;SFISC/MKO-AUTOBUILD A ROUTINE THAT CALLS CREIXN^DDMOD ; 15NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**95**
 ;
MAIN ;Main process
 N DIKCRTN,DIKCNMSP,DIKCITL,DIKCXR,%
 ;
 ;Check save code
 D:'$D(DISYS) OS^DII
 I '$D(^DD("OS",DISYS,"ZS")) W $C(7),$$EZBLD^DIALOG(820) Q
 ;
 ;Gather information from user
Q1 S DIKCRTN=$$ASKRTN Q:U[DIKCRTN
Q2 S DIKCITL=$$ASKITL Q:DIKCITL[U  I DIKCITL="" W ! G Q1
Q3 S DIKCNMSP=$$ASKNMSP Q:DIKCNMSP[U  I DIKCNMSP="" W ! G Q2
Q4 S DIKCXR=$$ASKXR() I 'DIKCXR W ! G Q3
 ;
 ;Build and save routine
 D BUILD(DIKCRTN,DIKCITL,DIKCNMSP,DIKCXR)
 D SAVE(DIKCRTN)
 ;
 ;Final message and clean up
 W !!,"  Done!"
 W !!,"  Be sure to edit the routine to fill in the missing details,"
 W !,"  and to customize the call to CREIXN^DDMOD."
 W !
 K ^UTILITY($J)
 Q
 ;
BUILD(DIKCRTN,DIKCITL,NS,XR) ;Build routine DIKCRTN
 N CV
 K ^UTILITY($J)
 D AD(DIKCRTN_" ;xxxx/"_DIKCITL_"-CREATE NEW-STYLE XREF ;")
 D AD(" ;;1.0")
 D AD(" ;")
 D AD(" N "_NS_"XR,"_NS_"RES,"_NS_"OUT")
 D BC(NS,XR,"FILE",0,1)
 D:$P($G(^DD("IX",XR,0)),U,8)="W" BC(NS,XR,"ROOT FILE",0,9)
 D BC(NS,XR,"NAME",0,2)
 D BC(NS,XR,"TYPE",0,4)
 D BC(NS,XR,"USE",0,14)
 D BC(NS,XR,"EXECUTION",0,6)
 D BC(NS,XR,"ACTIVITY",0,7)
 D BC(NS,XR,"SHORT DESCR",0,3)
 D BCW(NS,XR,"DESCR",.1)
 D:$P($G(^DD("IX",XR,0)),U,4)="MU"
 . D BC(NS,XR,"SET",1)
 . D BC(NS,XR,"KILL",2)
 . D BC(NS,XR,"WHOLE KILL",2.5)
 D BC(NS,XR,"SET CONDITION",1.4)
 D BC(NS,XR,"KILL CONDITION",2.4)
 ;
 S CV=0 F  S CV=$O(^DD("IX",XR,11.1,CV)) Q:'CV  D
 . N ON,TP,VAL
 . S ON=$P($G(^DD("IX",XR,11.1,CV,0)),U) Q:'ON
 . S TP=$P($G(^DD("IX",XR,11.1,CV,0)),U,2)
 . I TP="F" D
 .. S VAL=$P($G(^DD("IX",XR,11.1,CV,0)),U,4) Q:'VAL
 .. D AD(" S "_NS_"XR(""VAL"","_ON_")="_VAL)
 . E  D
 .. S VAL=$G(^DD("IX",XR,11.1,CV,1.5)) Q:VAL=""
 .. D AD(" S "_NS_"XR(""VAL"","_ON_")="_$$QT(VAL))
 . D BCC(NS,XR,CV,ON,"SUBSCRIPT",0,6)
 . D BCC(NS,XR,CV,ON,"LENGTH",0,5)
 . D BCC(NS,XR,CV,ON,"COLLATION",0,7)
 . D BCC(NS,XR,CV,ON,"LOOKUP PROMPT",0,8)
 . D:TP="F"
 .. D BCC(NS,XR,CV,ON,"XFORM FOR STORAGE",2)
 .. D BCC(NS,XR,CV,ON,"XFORM FOR LOOKUP",4)
 .. D BCC(NS,XR,CV,ON,"XFORM FOR DISPLAY",3)
 ;
 D AD(" D CREIXN^DDMOD(."_NS_"XR,""SW"",."_NS_"RES,"""_NS_"OUT"")")
 D AD(" Q")
 ;
 Q
BC(NS,XR,SUB,ND,PC) ;Build code that sets an array element
 N VAL
 I $G(PC)="" S VAL=$G(^DD("IX",XR,ND))
 E  S VAL=$P($G(^DD("IX",XR,ND)),U,PC)
 Q:VAL=""
 D AD(" S "_NS_"XR("""_SUB_""")="_$$QT(VAL))
 Q
 ;
BCW(NS,XR,SUB,ND) ;Build code that sets array for wp field
 N I,VAL
 S I=0 F  S I=$O(^DD("IX",XR,ND,I)) Q:'I  D
 . S VAL=$G(^DD("IX",XR,ND,I,0)) S:VAL="" VAL=" "
 . D AD(" S "_NS_"XR("""_SUB_""","_I_")="_$$QT(VAL))
 Q
 ;
BCC(NS,XR,CV,ON,SUB,ND,PC) ;Build code that sets an array element
 N VAL
 I $G(PC)="" S VAL=$G(^DD("IX",XR,11.1,CV,ND))
 E  S VAL=$P($G(^DD("IX",XR,11.1,CV,ND)),U,PC)
 Q:VAL=""
 D AD(" S "_NS_"XR(""VAL"","_ON_","""_SUB_""")="_$$QT(VAL))
 Q
 ;
QT(X) ;Return string X quoted, if noncanonic
 Q:$G(X)="" """"""
 Q:X=+$E($P(X,"E"),1,15) X
 S X(X)="",X=$Q(X(""))
 Q $E(X,3,$L(X)-1)
 ;
AD(X) ;Add a routine line to ^UTILITY
 N LN
 S LN=$O(^UTILITY($J,0," "),-1)+1
 S ^UTILITY($J,0,LN)=X
 Q
 ;
SAVE(DIKCRTN) ;Save routine DIKCRTN
 N X,%Y
 S ^UTILITY($J,0,1)=^UTILITY($J,0,1)_$$NOW
 S X=DIKCRTN X ^DD("OS",DISYS,"ZS")
 W !!,$$EZBLD^DIALOG(8025,DIKCRTN)
 Q
 ;
ASKRTN() ;Prompt for routine name; return ^ if timeout, null, or ^
 N DIR,X,Y,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="FO^1:8^K:X?.E1.C.E!'(X?1""%""1.7AN!(X?1A1.7AN)) X"
 S DIR("A")="Routine name"
 S DIR("?",1)="  Enter the name of the routine, without the leading up-arrow, that"
 S DIR("?",2)="  should be built."
 S DIR("?",3)=""
 S DIR("?",4)="  Answer must be 1-8 characters in length. It must begin with % or a"
 S DIR("?")="  letter, followed by a combination of letters and numbers."
 F  D  Q:$G(DIKCRTN)]""
 . D ^DIR I $D(DIRUT) S DIKCRTN=U Q
 . S DIKCRTN=X
 . Q:$T(^@X)=""  ; routine doesn't exist; overwrite okay. VEN/SMH
 . Q:$$ASKREPL(DIKCRTN)
 . S DIKCRTN=""
 Q $G(DIKCRTN)
 ;
ASKREPL(DIKCRTN) ;Ask whether to replace the existing routine
 N DIR,X,Y,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YO"
 S DIR("A")="  Do you wish to replace routine "_DIKCRTN
 S DIR("B")="NO"
 S DIR("?")="    Answer yes if you wish to replace routine "_DIKCRTN_" with a new version."
 W !!,"  Routine "_DIKCRTN_" already exists."
 D ^DIR W !
 Q Y
 ;
ASKITL() ;Ask for programmer initials
 N DIR,X,Y,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="FO^1:15"
 S DIR("A")="Programmer initials"
 S DIR("?",1)="  Enter your initials, which will appear on the first line of the"
 S DIR("?")="  routine."
 D ^DIR
 Q Y
 ;
ASKNMSP() ;Prompt for a namespace
 N DIR,X,Y,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="FO^1:4^K:X?.E1.C.E!'(X?1""%""1.3AN!(X?1A1.3AN)) X"
 S DIR("A")="Namespace to use for local variables"
 S DIR("?",1)="  All variables used in the generated routine will start with the namespace"
 S DIR("?",2)="  you choose."
 S DIR("?",3)=""
 S DIR("?",4)="  Answer must be 1-4 characters in length. It must begin with % or a"
 S DIR("?")="  letter, followed by a combination of letters and numbers."
 D ^DIR
 Q Y
 ;
ASKXR() ;Prompt for file/xref
 N DIKCCNT,DIKCROOT,DIKCTOP,DIKCFILE,DDS1,D,DIC,X,Y
 S DDS1="CROSS-REFERENCE FROM: " D W^DICRW Q:Y<0 ""
 S DIKCTOP=+$P($G(@(DIC_"0)")),U,2) Q:'DIKCTOP ""
 S DIKCFILE=$$SUB^DIKCU(DIKCTOP)
 ;
 D GETXR^DIKCUTL2(DIKCFILE,.DIKCCNT)
 W ! D LIST^DIKCUTL2(.DIKCCNT)
 Q $$CHOOSE^DIKCUTL2(.DIKCCNT,"to build a routine for")
 ;
NOW() ;Return current time in external form
 N %,%I,%H,AP,HR,MIN,MON,TIM,X
 D NOW^%DTC
 S TIM=$P(%,".",2)
 S HR=$E(TIM,1,2)
 S AP=$S(HR<12:"AM",1:"PM")
 S HR=$S(HR<13:+HR,1:HR#12)
 S MIN=$E(TIM_"0000",3,4)
 ;
 S MON=$P("Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec",U,%I(1))
 Q HR_":"_MIN_" "_AP_"  "_%I(2)_" "_MON_" "_(%I(3)+1700)
