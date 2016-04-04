DIKCUTL2 ;SFISC/MKO-UTILITY OPTION TO MODIFY INDEX ;17DEC2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**68,167**
 ;
 ;========
 ; $$TYPE
 ;========
 ;Prompt for type xref (to reindex or modify)
 ;Returns:
 ; '1' for Traditional; or
 ; '2' for New
 ;
TYPE() ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SAM^1:TRADITIONAL;2:NEW"
 S DIR("A")="What type of cross-reference (Traditional or New)? "
 S DIR("B")="Traditional"
 S DIR("?",1)="Enter 'T' to select a Traditional cross-reference."
 S DIR("?",2)="  Traditional cross references are stored in the data"
 S DIR("?",3)="  dictionary under ^DD(file#,field#,1)."
 S DIR("?",4)=" "
 S DIR("?",5)="Enter 'N' to select a New-Style cross-reference."
 S DIR("?",6)="  New-Style cross references are stored in the Index file."
 S DIR("?",7)="  Compound indexes (indexes based on more than one field)"
 S DIR("?")="  are examples of New-Style cross-references."
 D ^DIR
 Q $S($D(DIRUT):"",1:Y)
 ;
 ;==========================
 ; GETXR(file#,.count,flag)
 ;==========================
 ;Loop through the "AC" index to get the list of Index file
 ;xrefs with root file FIL.
 ;In:
 ; FIL = Root file #
 ; FLG [ "M" : also get xrefs on subfiles of FIL
 ;Out:
 ; CNT = # xrefs^rootFile# (or null if FLG [ "M")
 ; CNT(xref#) = rootFile#^File#^xrefName^rootType^UI[if uniq index]
 ;
GETXR(FIL,CNT,FLG) ;
 N F,SB,XR
 K CNT
 D:$G(FLG)["M" SUBFILES^DIKCU(FIL,.SB)
 S SB(FIL)=""
 ;
 S (CNT,F)=0 F  S F=$O(SB(F)) Q:'F  D
 . S XR=0 F  S XR=$O(^DD("IX","AC",F,XR)) Q:'XR  D
 .. I $G(^DD("IX",XR,0))?."^" K ^DD("IX","AC",F,XR) Q
 ..I $G(FLG)["x",$G(^("NOREINDEX")) Q  ;167
 .. S CNT=CNT+1
 .. S CNT(XR)=F_U_$P($G(^DD("IX",XR,0)),U,1,2)_U_$P(^(0),U,8)
 .. S:$D(^DD("KEY","AU",XR)) $P(CNT(XR),U,5)="UI"
 ;
 S:$G(FLG)'["M" $P(CNT,U,2)=FIL
 Q
 ;
 ;============================
 ; LIST(.count,header,screen)
 ;============================
 ;List the xrefs in the CNT array
 ;In:
 ; CNT = Array of xrefs to print (obtained by GETXR call above)
 ; HDR = Text to print before listing
 ;        (default is 'Current Indexes[ on [sub]file #xxx]:')
 ; SCR = Sets $T to screen out indexes (Y = index#)
 ;
LIST(CNT,HDR,SCR) ;
 I '$G(CNT) W:$P(CNT,U,2) !,"There are no INDEX file cross-references defined on "_$$FSTR($P(CNT,U,2))_"." Q
 N FIL,I,ONEFIL,RFIL,TYP,TXT,UI,XR,Y
 ;
 S ONEFIL=$P(CNT,U,2)
 S:$G(HDR)="" HDR="Current Indexes"_$S(ONEFIL:" on "_$$FSTR(ONEFIL),1:"")_":"
 W !,HDR
 ;
 S XR=0 F  S XR=$O(CNT(XR)) Q:'XR  D
 . I $G(SCR)]"" K Y S Y=XR,Y(0)=CNT(XR) X SCR K Y E  Q
 . S FIL=$P(CNT(XR),U,2),RFIL=$P(CNT(XR),U),TYP=$P(CNT(XR),U,4)
 . S UI=$S($P(CNT(XR),U,5)="UI":"uniqueness ",1:"")
 . S RFIL=$S('ONEFIL:" on "_$$FSTR(RFIL),1:"")
 . ;
 . S TXT=XR_"  "_$J("",5-$L(XR))_"'"_$P(CNT(XR),U,3)_"' "_UI
 . I TYP'="W" S TXT=TXT_"index"_RFIL
 . E  S TXT=TXT_"whole file index"_RFIL_" (resides on "_$$FSTR(FIL)_")"
 . ;
 . D WRAP^DIKCU2(.TXT,-11,-2)
 . W !,"  "_TXT F I=1:1 Q:$D(TXT(I))[0  W !?10,TXT(I)
 . K TXT
 Q
 ;
 ;================================
 ; $$CHOOSE(.count,prompt,screen)
 ;================================
 ;Prompt for a xref from the DIKCCNT array
 ;In:
 ; DIKCCNT = Array contain xref data (obtained by GETXR call above)
 ; DIKCPR  = Action to include with the prompt
 ; DIKCSCR = Sets $T to screen out entries (Y=index#)
 ;Returns:
 ; Index ien (or 0, if none selected)
 ;
CHOOSE(DIKCCNT,DIKCPR,DIKCSCR) ;
 Q:'$G(DIKCCNT) 0
 N I,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="SAO^"
 S I=0 F  S I=$O(DIKCCNT(I)) Q:'I  S DIR("C",I)=I_":"_$P(DIKCCNT(I),U,3)
 S DIR("A")="Which Index do you wish to "_DIKCPR_"? "
 S:+DIKCCNT=1 DIR("B")=$O(DIKCCNT(0))
 S DIR("?")="",DIR("??")="^D LIST^DIKCUTL2(.DIKCCNT)"
 W ! D ^DIR I 'Y!$D(DIRUT) Q 0
 Q Y
 ;
 ;====================
 ; $$FSTR(file#,flag)
 ;====================
 ;Return string 'file #xxx' or 'subfile #xxx'
 ;In:
 ; FIL = File #
 ; FLG [ U : Capitalize 'File' or 'Subfile'
 ;
FSTR(FIL,FLG) ;
 ;Q $P($P("f;F^subf;Subf",U,$G(^DD(FIL,0,"UP"))>0+1),";",$G(FLG)["U"+1)_"ile #"_FIL
 Q $P($$EZBLD^DIALOG(8098),U,$G(^DD(FIL,0,"UP"))>0*2+1+($G(FLG)["U"))_" #"_FIL
 ;
 ;================
 ; PRTMSG(index#)
 ;================
 ;Print message that DIXR can't be deleted because it's the
 ;Uniqueness Index for a key.
 ;In:
 ; DIXR = index #
 ;
PRTMSG(DIXR) ;
 N KEYID,I,INDID,MSG
 ;
 S KEYID=$O(^DD("KEY","AU",DIXR,0)) Q:'KEYID
 S KEYID=$G(^DD("KEY",KEYID,0)) Q:KEYID?."^"
 S KEYID="Key '"_$P(KEYID,U,2)_"' on File #"_$P(KEYID,U)
 ;
 S INDID="Index '"_$P($G(^DD("IX",DIXR,0)),U,2)_"'"
 S MSG(0)=INDID_" cannot be deleted. It is the uniqueness index for "_KEYID_"."
 D WRAP^DIKCU2(.MSG)
 ;
 W $C(7) F I=0:1 Q:'$D(MSG(I))  W !,MSG(I)
 Q
 ;
 ;================
 ; BLDLOG(index#)
 ;================
 ;Build and file the logic of the cross reference.
 ;In:
 ; DIXR = index #
 ;
 ;Called from EDIT^DIKCUTL after an Index is edited.
 ;The reason for this call is if the user deletes some Cross-Reference
 ;Values, and then Quits the form, the Set/Kill logic may not reflect
 ;the deleted Values.
 ;
BLDLOG(DIXR) ;
 N CNT,CRV,CRV0,DIERR,FCNT,FDA,FILE,IX0,KILL,L,LDIF,MAXL,MSG
 N NAME,ORD,ROOT,RTYPE,RFILE,SBSC,SET,VAL,WKILL
 ;
 ;Get index data
 S IX0=$G(^DD("IX",DIXR,0)) Q:IX0?."^"
 I $P(IX0,U,4)="MU" D UPDEXEC(DIXR) Q
 S FILE=$P(IX0,U),NAME=$P(IX0,U,2),RTYPE=$P(IX0,U,8),RFILE=$P(IX0,U,9)
 ;
 ;Build root of index and the 'Kill Entire Index Code'
 I FILE'=RFILE Q:RTYPE'="W"  S LDIF=$$FLEVDIFF^DIKCU(FILE,RFILE)
 E  S LDIF=0
 S ROOT=$$FROOTDA^DIKCU(FILE,LDIF_"O")_""""_NAME_""""
 S WKILL="K "_ROOT_")"
 ;
 ;Loop through Cross-Reference Values multiple
 ;Build SBSC(subscript#)=order#^maxLength array
 S CRV=0 F  S CRV=$O(^DD("IX",DIXR,11.1,CRV)) Q:'CRV  D
 . S CRV0=$G(^DD("IX",DIXR,11.1,CRV,0)) Q:CRV0?."^"
 . S ORD=$P(CRV0,U) Q:'ORD
 . S:$P(CRV0,U,2)="F" FCNT=$G(FCNT)+1
 . S CNT=$G(CNT)+1
 . S SBSC=$P(CRV0,U,6) Q:'SBSC
 . S MAXL=$P(CRV0,U,5)
 . S SBSC(SBSC)=ORD_U_MAXL
 ;
 ;Loop through SBSC array and build the root w/ X(n) array
 S SBSC=0 F  S SBSC=$O(SBSC(SBSC)) Q:'SBSC  D
 . S ORD=$P(SBSC(SBSC),U),MAXL=$P(SBSC(SBSC),U,2)
 . I $G(CNT)=1 S VAL=$S(MAXL:"$E(X,1,"_MAXL_")",1:"X")
 . E  S VAL=$S(MAXL:"$E(X("_ORD_"),1,"_MAXL_")",1:"X("_ORD_")")
 . S ROOT=ROOT_","_VAL
 ;
 ;Append DA(n) to root
 F L=LDIF:-1:1 S ROOT=ROOT_",DA("_L_")"
 S ROOT=ROOT_",DA)"
 ;
 ;Build and file the Set and Kill Logic and the Execution
 I '$O(SBSC(0)) S (SET,KILL)="Q",WKILL=""
 E  S SET="S "_ROOT_"=""""",KILL="K "_ROOT
 K FDA
 S FDA(.11,DIXR_",",1.1)=SET
 S FDA(.11,DIXR_",",2.1)=KILL
 S FDA(.11,DIXR_",",2.5)=WKILL
 S FDA(.11,DIXR_",",.4)=$S($G(FCNT)>1:"R",1:"F")
 D FILE^DIE("","FDA","MSG")
 Q
 ;
UPDEXEC(DIXR) ;Update Execution based on number of field-type xref values
 N CRV,CRV0,DIERR,FCNT,FDA,MSG
 S CRV(1)=DIXR,CRV=0
 F  S CRV=$O(^DD("IX",DIXR,11.1,CRV)) Q:'CRV  D
 . S CRV0=$G(^DD("IX",DIXR,11.1,CRV,0)) Q:'CRV0
 . S:$P(CRV0,U,2)="F" FCNT=$G(FCNT)+1
 S FDA(.11,DIXR_",",.4)=$S($G(FCNT)>1:"R",1:"F")
 D FILE^DIE("","FDA","MSG")
 Q
