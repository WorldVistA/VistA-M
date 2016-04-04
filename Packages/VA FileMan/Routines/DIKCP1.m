DIKCP1 ;SFISC/MKO-PRINT INDEX(ES) ;2015-01-02  2:55 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**20,167,1051**
 ;
PRINDEX ;Come here from PRINDEX^DIKCP
 Q:'$G(XR)
 N XR0
 I $G(FLAG)'["i" N LM,TYP,TS,WID D INIT^DIKCP
 S XR0=$G(^DD("IX",XR,0)) Q:XR0?."^"
 ;
 ;Print first line of information
 D FL(XR0,WID,LM,TS,TYP,.PAGE) Q:PAGE(U)
 I FLAG'["S" D WRLN("",0,.PAGE) Q:PAGE(U)
 ;
 ;Print Keys with this Uniqueness Index
 D KEY(XR,WID,LM,TS,.PAGE) Q:PAGE(U)
 ;
 ;Print short description
 I $P(XR0,U,3)]"" D  Q:PAGE(U)
 . D WLP("Short Descr:  ",$P(XR0,U,3),WID,LM+TS,0,.PAGE)
 ;
 ;Print description
 I $O(^DD("IX",XR,.1,0)) D  Q:PAGE(U)
 . D WRWP($NA(^DD("IX",XR,.1)),LM,WID,"Description:  ",TS,.PAGE)
 I FLAG'["S" D WRLN("",0,.PAGE) Q:PAGE(U)
 ;
 ;Print logic
 I FLAG'["N" D  Q:PAGE(U)
 . D LOGIC(XR,WID,LM,TS,FLAG,.PAGE) Q:PAGE(U)
 . I FLAG'["S" D WRLN("",0,.PAGE)
 ;
 ;Print Cross Reference Values
 D CRV(XR,WID,LM,TS,FLAG,.PAGE)
NOREIN I $G(^DD("IX",XR,"NOREINDEX")) W !?9,"NO RE-INDEXING ALLOWED!"
 Q
 ;
FL(XR0,WID,LM,TS,TYP,PAGE) ;Print first line
 N ACT,EXEC,NAME,RTYP,SP,TYPE,TXT,USE
 ;
 S SP=$J("",4)
 S EXEC=$$EXTERNAL^DILFD(.11,.4,"",$P(XR0,U,6))
 S NAME=$P(XR0,U,2)_" (#"_XR_")"
 S TYPE=$$EXTERNAL^DILFD(.11,.2,"",$P(XR0,U,4))
 S ACT=$P(XR0,U,7)
 S USE=$TR($$EXTERNAL^DILFD(.11,.42,"",$P(XR0,U,14))," ",$C(0))
 S RTYP=$P(XR0,U,8) S:"I"[RTYP RTYP=""
 S:RTYP]"" RTYP=$TR($$EXTERNAL^DILFD(.11,.5,"",RTYP)," ",$C(0))
 S:RTYP]"" RTYP=SP_RTYP_$C(0)_"(#"_$P(XR0,U)_")"
 ;
 ;Print first line
 I TYP=1 D
 . S TXT=EXEC_" INDEX: ",TXT=TXT_$J("",TS-$L(TXT))
 . S TXT=TXT_NAME_SP_TYPE_SP_ACT_SP_USE_RTYP
 E  S TXT=NAME_SP_EXEC_SP_TYPE_SP_ACT_SP_USE_RTYP
 ;
 D WRPHI(TXT,WID,LM,TS,0,.PAGE)
 Q
 ;
KEY(XR,WID,LM,TS,PAGE) ;Print keys that have XR as Uniqueness Index
 Q:'$D(^DD("KEY","AU",XR))
 N KEY,KEY0,KEYLN,TXT
 ;
 S TXT=0,TXT(0)=""
 S KEY=0 F  S KEY=$O(^DD("KEY","AU",XR,KEY)) Q:'KEY  D
 . S KEY0=$G(^DD("KEY",KEY,0)) Q:KEY0?."^"
 . S KEYLN="Key "_$P(KEY0,U,2)_" (#"_KEY_"), File #"_$P(KEY0,U)
 . S:$G(TXT(TXT))]"" TXT(TXT)=TXT(TXT)_"; "
 . D ADDSTR($TR(KEYLN," ",$C(0)),.TXT)
 Q:$G(TXT(0))=""
 D WLP("Unique for:  ",.TXT,WID,LM+TS,0,.PAGE)
 Q
 ;
LOGIC(XR,WID,LM,TS,FLAG,PAGE) ;Print set and kill logic
 N CD,LN
 S CD=$G(^DD("IX",XR,1))
 I CD'?."^" D  Q:PAGE(U)
 . D WLP("Set Logic:  ",CD,WID,LM+TS,1,.PAGE) Q:PAGE(U)
 . S LN=0 F  S LN=$O(^DD("IX",XR,1.2,LN)) Q:LN'=+LN  D  Q:PAGE(U)
 .. S CD=$G(^DD("IX",XR,1.2,LN,1))
 .. I CD'?."^" D WLP(LN_") ",CD,WID,LM+TS,1,.PAGE)
 S CD=$G(^DD("IX",XR,1.4))
 I CD'?."^" D WLP("Set Cond:  ",CD,WID,LM+TS,1,.PAGE) Q:PAGE(U)
 ;
 S CD=$G(^DD("IX",XR,2))
 I CD'?."^" D  Q:PAGE(U)
 . D WLP("Kill Logic:  ",CD,WID,LM+TS,1,.PAGE) Q:PAGE(U)
 . S LN=0 F  S LN=$O(^DD("IX",XR,2.2,LN)) Q:LN'=+LN  D  Q:PAGE(U)
 .. S CD=$G(^DD("IX",XR,2.2,LN,2))
 .. I CD'?."^" D WLP(LN_") ",CD,WID,LM+TS,1,.PAGE)
 S CD=$G(^DD("IX",XR,2.4))
 I CD'?."^" D WLP("Kill Cond:  ",CD,WID,LM+TS,1,.PAGE) Q:PAGE(U)
 S CD=$G(^DD("IX",XR,2.5))
 I CD'?."^" D WLP("Whole Kill:  ",CD,WID,LM+TS,1,.PAGE) Q:PAGE(U)
 Q
 ;
CRV(XR,WID,LM,TS,FLAG,PAGE) ;Print cross reference values
 N CD,CV,CV0,FL,FD,LAB,ORD,TXT
 S ORD="" F  S ORD=$O(^DD("IX",XR,11.1,"B",ORD)) Q:ORD=""  D  Q:PAGE(U)
 . S CV=$O(^DD("IX",XR,11.1,"B",ORD,0)) Q:'CV
 . Q:$G(^DD("IX",XR,11.1,CV,0))?."^"  S CV0=^(0)
 . S LAB=$S(FLAG'["N":"X("_ORD_"):  ",1:ORD_":  ")
 . ;
 . ;Field-type values
 . I $P(CV0,U,2)="F" D  Q:PAGE(U)
 .. S FL=$P(CV0,U,3),FD=$P(CV0,U,4)
 .. I FL,FD S TXT=$P($G(^DD(FL,FD,0)),U)_"  ("_FL_","_FD_")"
 .. E  S TXT="<undefined file/field>"
 .. D CRVOTH(CV0,.TXT)
 .. D WLP(LAB,TXT,WID,LM+TS,"",.PAGE)
 . ;
 . ;Computed-type values
 . E  D  Q:PAGE(U)
 .. S CD=$G(^DD("IX",XR,11.1,CV,1.5))
 .. I CD'?."^" D
 ... S TXT=$S(FLAG["N":"<computed>",1:"Computed Code: "_CD)
 .. E  S TXT="<undefined computed code>"
 .. D WLP(LAB,TXT,WID,LM+TS,1,.PAGE) Q:PAGE(U)
 .. S TXT=""
 .. D CRVOTH(CV0,.TXT)
 .. D WLP("",TXT,WID,LM+TS,"",.PAGE)
 . ;
 . ;Lookup prompt
 . I $P(CV0,U,8)]"" D  Q:PAGE(U)
 .. D WLP("Lookup Prompt:  ",$P(CV0,U,8),WID-18,LM+TS+18,"",.PAGE)
 . ;
 . ;Transform
 . I FLAG'["N" D
 .. S CD=$G(^DD("IX",XR,11.1,CV,2))
 .. I CD'?."^" D WLP("Transform (Storage):  ",CD,WID-24,LM+TS+24,1,.PAGE)
 .. S CD=$G(^DD("IX",XR,11.1,CV,4))
 .. I CD'?."^" D WLP(" Transform (Lookup):  ",CD,WID-24,LM+TS+24,1,.PAGE)
 .. S CD=$G(^DD("IX",XR,11.1,CV,3))
 .. I CD'?."^" D WLP("Transform (Display):  ",CD,WID-24,LM+TS+24,1,.PAGE)
 Q
 ;
CRVOTH(CV0,TXT) ;Get other attributes of Cross Reference Value
 S:$P(CV0,U,6) TXT=TXT_"  (Subscr"_$C(0)_$P(CV0,U,6)_")"
 S:$P(CV0,U,5) TXT=TXT_"  (Len"_$C(0)_$P(CV0,U,5)_")"
 I $P(CV0,U,7)]"" D
 . S TXT=TXT_"  ("_$$EXTERNAL^DILFD(.114,7,"",$P(CV0,U,7))_")"
 Q
 ;
ADDSTR(X,TXT) ;Add string X to the TXT array
 I $L(TXT(TXT))+$L(X)>200 S TXT=TXT+1,TXT(TXT)=""
 S TXT(TXT)=TXT(TXT)_X
 Q
 ;
WRPHI(TXT,WID,LM,TS,COD,PAGE) ;Write a paragraph with a hanging indent
 N LAB,LN,TAB
 S:$D(TXT(0))[0 TXT(0)=$G(TXT)
 S LAB=$E(TXT(0),1,$G(TS)),TXT(0)=$E(TXT(0),$G(TS)+1,999)
 D WRAP^DIKCU2(.TXT,WID,"",$G(COD))
 D WRLN($G(LAB)_TXT(0),$G(LM),.PAGE) Q:PAGE(U)
 F LN=1:1 Q:'$D(TXT(LN))  D WRLN(TXT(LN),$G(LM)+$G(TS),.PAGE) Q:PAGE(U)
 Q
 ;
WLP(LAB,TXT,WID,TAB,COD,PAGE,WFLAG) ;Write a labeled paragraph
 N LN
 S:$D(TXT(0))[0 TXT(0)=$G(TXT)
 D WRAP^DIKCU2(.TXT,WID,"",$G(COD))
 D WRLN($G(LAB)_TXT(0),TAB-$L(LAB),.PAGE) Q:PAGE(U)
 F LN=1:1 Q:'$D(TXT(LN))  D WRLN(TXT(LN),TAB,.PAGE) Q:PAGE(U)
 S WFLAG=LN>1
 Q
 ;
WRLN(TXT,TAB,PAGE,KWN) ;Write a line of text
 ;See ^DIKCP for documentation
 N X
 S PAGE(U)=""
 ;
 ;Do paging, if necessary
 I $D(PAGE("H"))#2,$G(IOSL,24)-2-$G(PAGE("B"))-$G(KWN)'>$Y S $Y=0 D  Q:PAGE(U)
 . I PAGE("H")?1"W ".E X PAGE("H") Q
 . I $E($G(IOST,"C"))="C" D  Q:PAGE(U)
 .. W $C(7) R X:$G(DTIME,300) I X=U!'$T S PAGE(U)=1
 . W @$G(IOF,"#"),PAGE("H")
 ;
 ;Write text
 W !?$G(TAB),$TR($G(TXT),$C(0)," ")
 Q
 ;
WRWP(ROOT,LM,WID,LAB,TS,PAGE) ;Call DIWP/DIWW to format a wp field.
 ;Then write the formatted lines.
 Q:$G(ROOT)=""  Q:'$D(@ROOT)
 N DIWF,DIWL,DIWR,LN,X
 N DIW,DIWI,DIWT,DIWTC,DIWX,DN,I,Z
 K ^UTILITY($J,"W")
 ;
 S LM=$G(LM)\1,WID=$G(WID)\1,TS=$G(TS)\1,LAB=$G(LAB)
 I 'WID S WID=$G(IOM,80)-1-LM-TS S:WID<1 WID=1
 S DIWL=0,DIWR=WID,DIWF="|"
 S LN=0 F  S LN=$O(@ROOT@(LN)) Q:'LN  S X=$G(@ROOT@(LN,0)) D ^DIWP
 ;
 D WRLN($G(LAB)_$G(^UTILITY($J,"W",DIWL,1,0)),LM+TS-$L(LAB),.PAGE)
 G:$G(PAGE(U)) WRWPQ
 ;
 S LN=1 F  S LN=$O(^UTILITY($J,"W",DIWL,LN)) Q:'LN  D  Q:$G(PAGE(U))
 . D WRLN(^UTILITY($J,"W",DIWL,LN,0),LM+TS,.PAGE)
 ;
WRWPQ ;Cleanup and quit
 K ^UTILITY($J,"W")
 Q
