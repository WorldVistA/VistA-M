DIKCP3 ;SFISC/MKO-PRINT INDEX(ES) ;9:21 PM  7 Dec 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
PRFILE(FIL,FLD,FLAG,PAGE,FHDR) ;Print Traditional cross-references on a file
 Q:'$G(FIL)
 N HDR,NAM,NO,XR
 I $G(FLAG)'["i" N LM,TS,TYP,WID D INIT^DIKCP
 ;
 ;If field is not specified, print all xrefs on field
 I $G(FLD)="" D
 . ;Build list of xrefs sorted by name
 . K ^TMP("DIKCP3",$J)
 . S FLD=0 F  S FLD=$O(^DD(FIL,"IX",FLD)) Q:'FLD  D
 .. S XR=0 F  S XR=$O(^DD(FIL,FLD,1,XR)) Q:'XR  D
 ... Q:$D(^DD(FIL,FLD,1,XR))<9  S NAM=$P($G(^(XR,0)),U,2)
 ... S:NAM="" NAM="~~"_$G(NO),NO=$G(NO)+1
 ... S ^TMP("DIKCP3",$J,NAM,FLD,XR)=""
 . ;
 . ;Loop through sorted list and print
 . S NAM="" F  S NAM=$O(^TMP("DIKCP3",$J,NAM)) Q:NAM=""  D  Q:PAGE(U)
 .. S FLD=0 F  S FLD=$O(^TMP("DIKCP3",$J,NAM,FLD)) Q:'FLD  D  Q:PAGE(U)
 ... S XR=0 F  S XR=$O(^TMP("DIKCP3",$J,NAM,FLD,XR)) Q:'XR  D  Q:PAGE(U)
 .... I '$G(FHDR) D FHDR^DIKCP(FIL,FLAG,.PAGE,.FHDR) Q:PAGE(U)
 .... I '$G(HDR) D HDR(FIL,FLAG,LM,.PAGE,.HDR) Q:PAGE(U)
 .... D PRINDEX(FIL,FLD,XR,FLAG,.PAGE) Q:PAGE(U)
 .... D WRLN("",0,.PAGE) Q:PAGE(U)
 .... I FLAG'["S" D WRLN("",0,.PAGE)
 . K ^TMP("DIKCP3",$J)
 ;
 ;Else print cross-references on specific field
 E  S XR=0 F  S XR=$O(^DD(FIL,FLD,1,XR)) Q:'XR  D  Q:PAGE(U)
 . I '$G(FHDR) D FHDR^DIKCP(FIL,FLAG,.PAGE,.FHDR) Q:PAGE(U)
 . I '$G(HDR) D HDR(FIL,FLAG,LM,.PAGE,.HDR) Q:PAGE(U)
 . D PRINDEX(FIL,FLD,XR,FLAG,.PAGE) Q:PAGE(U)
 . D WRLN("",0,.PAGE) Q:PAGE(U)
 . I FLAG'["S" D WRLN("",0,.PAGE)
 Q
 ;
PRINDEX(FIL,FLD,XR,FLAG,PAGE) ;Print a specific index
 Q:'$G(FIL)!'$G(FLD)!'$G(XR)
 N ND,WFLAG
 I $G(FLAG)'["i" N LM,TYP,TS,WID D INIT^DIKCP
 ;
 ;Print first line of information
 D FL(FIL,FLD,XR,WID,LM,TS,TYP,.PAGE) Q:PAGE(U)
 ;
 ;Print Field
 D WLP^DIKCP1("Field:  ",$P($G(^DD(FIL,FLD,0)),U)_"  ("_FIL_","_FLD_")",WID,LM+TS,0,.PAGE)
 Q:PAGE(U)
 ;
 ;For Triggers, print triggered field
 I $P($G(^DD(FIL,FLD,1,XR,0)),U,3)["TRIG" D  Q:PAGE(U)
 . N LAB,TFIL,TFLD
 . S TFIL=$P(^DD(FIL,FLD,1,XR,0),U,4),TFLD=$P(^(0),U,5)
 . S LAB="Triggered Field:  "
 . D WLP^DIKCP1(LAB,$P($G(^DD(TFIL,TFLD,0)),U)_"  ("_TFIL_","_TFLD_")",WID-$L(LAB),LM+TS+$L(LAB),"",.PAGE)
 ;
 ;Print Description
 I $O(^DD(FIL,FLD,1,XR,"%D",0)) D  Q:PAGE(U)
 . D WRWP^DIKCP1($NA(^DD(FIL,FLD,1,XR,"%D")),LM,WID,"Description:  ",TS,.PAGE)
 I FLAG'["S" D WRLN("",0,.PAGE) Q:PAGE(U)
 ;
 ;Print xref nodes
 K WFLAG
 S ND=0 F  S ND=$O(^DD(FIL,FLD,1,XR,ND)) Q:ND=""  D  Q:PAGE(U)
 . Q:ND="%D"!(ND="DT")
 . N TXT
 . S TXT(0)=ND_")= "
 . S TXT(1)=^DD(FIL,FLD,1,XR,ND)
 . I FLAG'["S",ND,$G(WFLAG) D WRLN("",0,.PAGE) Q:PAGE(U)
 . D WLP^DIKCP1("",.TXT,WID,LM+TS,1,.PAGE,.WFLAG)
 Q
 ;
FL(FIL,FLD,XR,WID,LM,TS,TYP,PAGE) ;Print first line
 N NAME,SP,TYPE,TXT,WF,XR0
 ;
 S SP=$J("",4)
 S XR0=$G(^DD(FIL,FLD,1,XR,0)) Q:XR0?."^"
 S NAME=$P(XR0,U,2)
 S TYPE=$P(XR0,U,3) S:TYPE="" TYPE="REGULAR"
 S TXT=NAME_SP_TYPE
 ;
 I $P(XR0,U),$P(XR0,U)'=FIL D
 . S TXT=TXT_SP_"WHOLE"_$C(0)_"FILE"_$C(0)_"(#"_$P(XR0,U)_")"
 ;
 ;Print first line
 D WRPHI^DIKCP1(TXT,WID,LM,TS,0,.PAGE)
 Q
 ;
HDR(FIL,FLAG,LM,PAGE,HDR) ;Print header
 I FLAG'["M",FLAG'["R",FLAG'["F" Q
 D WRLN("Traditional Cross-References:",LM,.PAGE,2) Q:PAGE(U)
 D WRLN("",0,.PAGE)
 S HDR=1
 Q
 ;
 ;
WRLN(TXT,TAB,PAGE,KWN) ;Write a line of text
 ;See ^DIKCP for documentation
 N X
 S PAGE(U)=""
 ;
 ;Do paging, if necessary
 I $D(PAGE("H"))#2,$G(IOSL,24)-2-$G(PAGE("B"))-$G(KWN)'>$Y D  Q:PAGE(U)
 . I PAGE("H")?1"W ".E X PAGE("H") Q
 . I $E($G(IOST,"C"))="C" D  Q:PAGE(U)
 .. W $C(7) R X:$G(DTIME,300) I X=U!'$T S PAGE(U)=1
 . W @$G(IOF,"#"),PAGE("H")
 ;
 ;Write text
 W !?$G(TAB),$TR($G(TXT),$C(0)," ")
 Q
