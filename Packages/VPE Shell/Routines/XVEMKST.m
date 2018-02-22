XVEMKST ;DJB/KRN**Save Symbol Table [07/22/94];2017-09-20  10:24 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
SYMTAB(ACTION,MODULE,SESSION) ; Symbol Table
 ;ACTION ....: C=Clear  R=Restore  S=Save
 ;MODULE ....: VEDD  VGL  VRR
 ;SESSION ...: Number (VGL=Session number  VRR=Rtn Number)
 Q:",C,R,S,"'[(","_$G(ACTION)_",")
 Q:",VEDD,VEDDL,VGL,VRR,"'[(","_$G(MODULE)_",")
 S:$G(SESSION)'>0 SESSION=1
 I ACTION="C" D SAVE,CLEAR Q  ;Clear symbol table
 I ACTION="R" D RESTORE Q  ;Restore symbol table
 I ACTION="S" D SAVE Q  ;Save symbol table
 Q
SAVE ;Save symbol table.
 KILL ^TMP("XVV","SYMTAB",$J,MODULE,SESSION)
 Q:'$$EXIST^XVEMKU("%ZOSV")
 NEW %,%X,%Y,%ZISOS,X,Y
 S X="^TMP(""XVV"",""SYMTAB"","_$J_","""_MODULE_""","_SESSION_","
 D DOLRO^%ZOSV
 Q
CLEAR ;Clear symbol table (Save certain variables)
 Q:'$D(^TMP("XVV","SYMTAB",$J,MODULE,SESSION))
 NEW %HLD,%PC,%REF,%VAR,%ut
 S %REF="^TMP(""XVV"",""SYMTAB"","_$J_","""_MODULE_""","_SESSION_")"
 S %HLD="""XVV"",""SYMTAB"","_$J_","""_MODULE_""","_SESSION_","
 F  S %REF=$Q(@%REF) Q:%REF=""!(%REF'[%HLD)  D
 . F %PC=1:1:10 Q:$P(%REF,",",%PC)["SYMTAB"  ;%PC varies with translation
 . S %VAR=$P(%REF,",",(%PC+4)),%VAR=$P(%VAR,"""",2) ;Strip quotes
 . I $P(%REF,",",(%PC+5))]""  S %VAR=%VAR_"("_$P(%REF,",",(%PC+5),99)
 . I $E(%VAR,1,3)="DUZ"!($E(%VAR,1,2)="IO") Q
 . I $E(%VAR,1,3)="XVV" Q
 . I ",FLAGVPE,GLS,U,VEDDS,VRRS,"[(","_%VAR_",") Q  ;Module counters
 . I ",%HLD,%PC,%REF,%VAR,"[(","_%VAR_",") Q  ;Used by RESTORE
 . KILL @%VAR
 . Q
 Q
RESTORE ;Restore symbol table.
 Q:'$D(^TMP("XVV","SYMTAB",$J,MODULE,SESSION))
 NEW %HLD,%PC,%REF,%VAR
 S %REF="^TMP(""XVV"",""SYMTAB"","_$J_","""_MODULE_""","_SESSION_")"
 S %HLD="""XVV"",""SYMTAB"","_$J_","""_MODULE_""","_SESSION_","
 F  S %REF=$Q(@%REF) Q:%REF=""!(%REF'[%HLD)  D
 . F %PC=1:1:10 Q:$P(%REF,",",%PC)["SYMTAB"  ;PC varies with translation
 . S %VAR=$P(%REF,",",(%PC+4)),%VAR=$P(%VAR,"""",2) ;Strip quotes
 . I $P(%REF,",",(%PC+5))]""  S %VAR=%VAR_"("_$P(%REF,",",(%PC+5),99)
 . I ",%HLD,%PC,%REF,%VAR,,X,Y,"[(","_%VAR_",") Q  ;Used by RESTORE
 . S @%VAR=@%REF
 . Q
 KILL ^TMP("XVV","SYMTAB",$J,MODULE,SESSION)
 Q
