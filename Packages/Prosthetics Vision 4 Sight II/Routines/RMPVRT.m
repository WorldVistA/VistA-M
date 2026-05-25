RMPVRT ; OIT/JDA - SCAMP runtime and compiletime support; Nov 17, 2024@23:35:37
 ;;1.0;PROSTHETICS VISION 4 SIGHT II;**2**;Jan 31, 2025;Build 38
 ;
 Q
NEWNAME(ROUT) ; Given a routine name, return the generated routine name
 Q "RMPV0"_ROUT
WRITEARG(ARG) ; Compiletime process to output WRITE command call
 I "!?#/*"[$E(ARG) Q "WRITECTL^RMPVIO("_$$QUOTE^XLFSTR(ARG)_")"
 I $E(ARG)="@" Q "WRITEIND^RMPVIO("_$$QUOTE^XLFSTR(ARG)_")"
 Q "WRITE^RMPVIO("_ARG_")"
READARG(ARG) ; Compiletime process to output READ command call
 I "!?#/"[$E(ARG) Q "READCTL^RMPVIO("_$$QUOTE^XLFSTR(ARG)_")"
 I $E(ARG)="@" Q "READIND^RMPVIO("_$$QUOTE^XLFSTR(ARG)_")"
 I $E(ARG)="""" Q "READPMT^RMPVIO("_ARG_")"
 I $E(ARG)="*" Q "READCHAR^RMPVIO(."_$E(ARG,2,*)_")"
 Q "READ^RMPVIO(."_ARG_")"
HOMEZIS ; Compiletime process
 I $G(^TMP($J,"RMPV","SILENT")) S IOP="NULL" D ^%ZIS U IO ; TODO: Should check POP in case NULL isn't set up
 Q
